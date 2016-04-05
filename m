From: Joe Perches <joe@perches.com>
Subject: [PATCH 1/3] intel_pstate: Use pr_fmt
Date: Tue,  5 Apr 2016 13:28:23 -0700
Message-ID: <710e23a9e0846d1aaa660849321e433b5f5dd4e7.1459887986.git.joe@perches.com>
References: <cover.1459887986.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1459887986.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Prefix the output using the more common kernel style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/cpufreq/intel_pstate.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index a382195..e674db8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -10,6 +10,8 @@
  * of the License.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
@@ -436,7 +438,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 
 	update_turbo_state();
 	if (limits->turbo_disabled) {
-		pr_warn("intel_pstate: Turbo disabled by BIOS or unavailable on processor\n");
+		pr_warn("Turbo disabled by BIOS or unavailable on processor\n");
 		return -EPERM;
 	}
 
@@ -1107,7 +1109,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 	intel_pstate_busy_pid_reset(cpu);
 
-	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
+	pr_debug("controlling: cpu %d\n", cpunum);
 
 	return 0;
 }
@@ -1149,12 +1151,12 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 
 	if (policy->policy == CPUFREQ_POLICY_PERFORMANCE &&
 	    policy->max >= policy->cpuinfo.max_freq) {
-		pr_debug("intel_pstate: set performance\n");
+		pr_debug("set performance\n");
 		limits = &performance_limits;
 		goto out;
 	}
 
-	pr_debug("intel_pstate: set powersave\n");
+	pr_debug("set powersave\n");
 	limits = &powersave_limits;
 	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
 	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
@@ -1206,7 +1208,7 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 	int cpu_num = policy->cpu;
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
-	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
+	pr_debug("CPU %d exiting\n", cpu_num);
 
 	intel_pstate_clear_update_util_hook(cpu_num);
 
@@ -1451,7 +1453,7 @@ hwp_cpu_matched:
 	if (intel_pstate_platform_pwr_mgmt_exists())
 		return -ENODEV;
 
-	pr_info("Intel P-state driver initializing.\n");
+	pr_info("Intel P-state driver initializing\n");
 
 	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
 	if (!all_cpu_data)
@@ -1468,7 +1470,7 @@ hwp_cpu_matched:
 	intel_pstate_sysfs_expose_params();
 
 	if (hwp_active)
-		pr_info("intel_pstate: HWP enabled\n");
+		pr_info("HWP enabled\n");
 
 	return rc;
 out:
@@ -1494,7 +1496,7 @@ static int __init intel_pstate_setup(char *str)
 	if (!strcmp(str, "disable"))
 		no_load = 1;
 	if (!strcmp(str, "no_hwp")) {
-		pr_info("intel_pstate: HWP disabled\n");
+		pr_info("HWP disabled\n");
 		no_hwp = 1;
 	}
 	if (!strcmp(str, "force"))
-- 
2.8.0.rc4.16.g56331f8
