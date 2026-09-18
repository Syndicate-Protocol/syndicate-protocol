/**
 * Single Source of Truth (SSOT) & Anti-Drift Integrity Validator for Syndicate Protocol.
 *
 * Verifies:
 * 1. Existence of all living root documents and docs/ hub documents declared in config.
 * 2. That every file referenced (in backticks) by a completed ("[x]") task in TASK.md
 *    actually exists on disk — the automated check for Rule 6 (no fake complete status).
 * 3. Registration/synchronization of test suites (optional, config-gated).
 * 4. Absence of disallowed shadow-tracker files.
 */

import * as fs from "fs";
import * as path from "path";

const ROOT_DIR = process.cwd();
const CONFIG_PATH = path.join(ROOT_DIR, "ssot.config.json");

if (!fs.existsSync(CONFIG_PATH)) {
	console.error(
		`❌ Missing ssot.config.json at repo root. Copy docs/syndicate-protocol-kit/ssot.config.example.json to ${CONFIG_PATH} and fill it in.`,
	);
	process.exit(1);
}

const config = JSON.parse(fs.readFileSync(CONFIG_PATH, "utf8"));
const projectName = config.projectName || "Syndicate Protocol";

console.log(
	`🔍 Running ${projectName} Single Source of Truth (SSOT) Integrity Check...\n`,
);

let errorCount = 0;

function checkFileExists(relPath, description) {
	const fullPath = path.join(ROOT_DIR, relPath);
	if (fs.existsSync(fullPath)) {
		console.log(`  ✅ [FOUND] ${description}: ${relPath}`);
		return true;
	}
	// Fallback check between canonical AGENTS.md and legacy AGENT.md
	if (relPath === "AGENTS.md" && fs.existsSync(path.join(ROOT_DIR, "AGENT.md"))) {
		console.log(`  ✅ [FOUND] ${description}: AGENT.md (legacy alias)`);
		return true;
	}
	if (relPath === "AGENT.md" && fs.existsSync(path.join(ROOT_DIR, "AGENTS.md"))) {
		console.log(`  ✅ [FOUND] ${description}: AGENTS.md (canonical)`);
		return true;
	}
	console.error(`  ❌ [MISSING] ${description}: ${relPath}`);
	errorCount++;
	return false;
}

// 1. Verify Living Root Documents
console.log("1. Checking Living Root Documents:");
for (const [file, desc] of config.rootDocs || []) {
	checkFileExists(file, desc);
}

// 2. Verify Centralized Documentation in docs/
console.log("\n2. Checking Centralized docs/ Hub:");
for (const [file, desc] of config.docsHub || []) {
	checkFileExists(file, desc);
}

// 3. Verify every file referenced by a COMPLETED task in TASK.md actually exists.
console.log(
	"\n3. Checking File References in Completed (\"[x]\") Tasks:",
);
if (config.verifyTaskFileReferences && config.taskFile) {
	const taskFilePath = path.join(ROOT_DIR, config.taskFile);
	if (!fs.existsSync(taskFilePath)) {
		console.error(`  ❌ [MISSING] Task file declared in config not found: ${config.taskFile}`);
		errorCount++;
	} else {
		const lines = fs.readFileSync(taskFilePath, "utf8").split("\n");
		const completedTaskLine = /^\s*-\s*\[x\]/i;
		const backtickSpan = /`([^`]+)`/g;

		function looksLikeFilePath(candidate) {
			if (/\s/.test(candidate)) return false; // shell commands / prose, not paths
			const hasExtension = /\.[A-Za-z0-9]{1,8}$/.test(candidate);
			const hasSlash = /^[\w.\-]+\/[\w./\-]+$/.test(candidate);
			return hasExtension || hasSlash;
		}

		let referencesChecked = 0;
		let referencesMissing = 0;
		for (const line of lines) {
			if (!completedTaskLine.test(line)) continue;
			let match;
			while ((match = backtickSpan.exec(line)) !== null) {
				const candidate = match[1];
				if (!looksLikeFilePath(candidate)) continue;
				referencesChecked++;
				const fullPath = path.join(ROOT_DIR, candidate);
				if (!fs.existsSync(fullPath)) {
					referencesMissing++;
					console.error(
						`  ❌ [DRIFT] Completed task references missing file: ${candidate}`,
					);
					errorCount++;
				}
			}
		}
		if (referencesChecked === 0) {
			console.log(
				`  ℹ️  No backtick-quoted file paths found in completed tasks yet (nothing to check).`,
			);
		} else if (referencesMissing === 0) {
			console.log(
				`  ✅ [SYNCED] All ${referencesChecked} file reference(s) in completed tasks exist on disk.`,
			);
		}
	}
} else {
	console.log("  ⏭️  Skipped (verifyTaskFileReferences is false or taskFile unset in config).");
}

// 4. Verify Test Suite Registration (optional, config-gated)
console.log("\n4. Checking Test Suite Synchronization:");
if (config.testDir && config.testFileSuffix) {
	const testDirPath = path.join(ROOT_DIR, config.testDir);
	if (!fs.existsSync(testDirPath)) {
		console.error(`  ❌ [MISSING] Configured test directory not found: ${config.testDir}`);
		errorCount++;
	} else {
		const testFiles = fs
			.readdirSync(testDirPath)
			.filter((f) => f.endsWith(config.testFileSuffix));

		const buildConfigContent = config.buildConfigFile
			? fs.readFileSync(path.join(ROOT_DIR, config.buildConfigFile), "utf8")
			: null;

		let packageJson = null;
		const packageJsonPath = path.join(ROOT_DIR, "package.json");
		if (fs.existsSync(packageJsonPath)) {
			packageJson = JSON.parse(fs.readFileSync(packageJsonPath, "utf8"));
		}

		for (const tf of testFiles) {
			const testPath = `${config.testDir}/${tf}`;
			const inBuildConfig = buildConfigContent
				? buildConfigContent.includes(testPath)
				: true;
			const testScript =
				packageJson?.scripts?.[config.packageJsonTestScript] || "";
			const inPackageJson = config.packageJsonTestScript
				? testScript.includes(tf.replace(/\.\w+$/, ".js")) ||
				  testScript.includes(tf)
				: true;

			if (inBuildConfig && inPackageJson) {
				console.log(`  ✅ [SYNCED] Test suite '${tf}' is registered.`);
			} else {
				console.error(
					`  ❌ [DESYNC] Test suite '${tf}' missing from build config (${inBuildConfig}) or package.json test script (${inPackageJson}).`,
				);
				errorCount++;
			}
		}
	}
} else {
	console.log("  ⏭️  Skipped (testDir/testFileSuffix not configured).");
}

// 5. Anti-Drift: Check for Disallowed Shadow Tracker Files
console.log("\n5. Checking for Disallowed Shadow Trackers:");
let foundShadowTracker = false;
for (const badFile of config.shadowTrackers || []) {
	if (fs.existsSync(path.join(ROOT_DIR, badFile))) {
		console.error(
			`  ❌ [FORBIDDEN] Found unauthorized shadow tracker '${badFile}'. All tasks must live in ${config.taskFile || "TASK.md"}!`,
		);
		errorCount++;
		foundShadowTracker = true;
	}
}
if (!foundShadowTracker) {
	console.log("  ✅ No unauthorized shadow task trackers detected.");
}

// Final Assessment
console.log("\n------------------------------------------------------------");
if (errorCount === 0) {
	console.log(
		"🎉 Single Source of Truth (SSOT) Verification PASSED! Zero drift detected.",
	);
	console.log("------------------------------------------------------------\n");
	process.exit(0);
} else {
	console.error(
		`💥 SSOT Verification FAILED with ${errorCount} error(s). Please fix drift before hand-off!`,
	);
	console.log("------------------------------------------------------------\n");
	process.exit(1);
}
