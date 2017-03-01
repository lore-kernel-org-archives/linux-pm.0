From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/44] tools/power turbostat: dump p-state software config
Date: Wed,  1 Mar 2017 00:27:45 -0500
Message-ID: <7293fccdffdec0ab0c36c4e4cffacb3ff114928e.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

cpu1: cpufreq driver: acpi-cpufreq
cpu1: cpufreq governor: ondemand
cpufreq boost: 1

or

cpu0: cpufreq driver: intel_pstate
cpu0: cpufreq governor: powersave
cpufreq intel_pstate no_turbo: 0

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 50 +++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2c674ad5ab80..7af5f42a9792 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2979,6 +2979,54 @@ dump_sysfs_cstate_config(void)
 		fclose(input);
 	}
 }
+static void
+dump_sysfs_pstate_config(void)
+{
+	char path[64];
+	char driver_buf[64];
+	char governor_buf[64];
+	FILE *input;
+	int turbo;
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_driver",
+			base_cpu);
+	input = fopen(path, "r");
+	if (input == NULL) {
+		fprintf(stderr, "NSFOD %s\n", path);
+		return;
+	}
+	fgets(driver_buf, sizeof(driver_buf), input);
+	fclose(input);
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_governor",
+			base_cpu);
+	input = fopen(path, "r");
+	if (input == NULL) {
+		fprintf(stderr, "NSFOD %s\n", path);
+		return;
+	}
+	fgets(governor_buf, sizeof(governor_buf), input);
+	fclose(input);
+
+	fprintf(outf, "cpu%d: cpufreq driver: %s", base_cpu, driver_buf);
+	fprintf(outf, "cpu%d: cpufreq governor: %s", base_cpu, governor_buf);
+
+	sprintf(path, "/sys/devices/system/cpu/cpufreq/boost");
+	input = fopen(path, "r");
+	if (input != NULL) {
+		fscanf(input, "%d", &turbo);
+		fprintf(outf, "cpufreq boost: %d\n", turbo);
+		fclose(input);
+	}
+
+	sprintf(path, "/sys/devices/system/cpu/intel_pstate/no_turbo");
+	input = fopen(path, "r");
+	if (input != NULL) {
+		fscanf(input, "%d", &turbo);
+		fprintf(outf, "cpufreq intel_pstate no_turbo: %d\n", turbo);
+		fclose(input);
+	}
+}
 
 
 /*
@@ -4168,6 +4216,8 @@ void process_cpuid()
 
 	if (!quiet)
 		dump_sysfs_cstate_config();
+	if (!quiet)
+		dump_sysfs_pstate_config();
 
 	if (has_skl_msrs(family, model))
 		calculate_tsc_tweak();
-- 
2.11.0.161.g6610af872
