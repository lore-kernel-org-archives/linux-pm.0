From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] intel_pstate, decrease number of "HWP enabled" messages
Date: Thu, 22 Oct 2015 09:43:31 -0400
Message-ID: <1445521411-28850-1-git-send-email-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When booting an HWP enabled system the kernel displays one "HWP enabled"
message for each cpu.  The messages are superfluous since HWP is globally
enabled across all CPUs. This patch also adds an informational message
when HWP is disabled via intel_pstate=no_hwp.

Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/cpufreq/intel_pstate.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index aa33b92..dec6275 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -497,8 +497,6 @@ static void __init intel_pstate_sysfs_expose_params(void)
 
 static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
-	pr_info("intel_pstate: HWP enabled\n");
-
 	wrmsrl_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 }
 
@@ -1276,8 +1274,10 @@ static int __init intel_pstate_init(void)
 	if (!all_cpu_data)
 		return -ENOMEM;
 
-	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp)
+	if (static_cpu_has_safe(X86_FEATURE_HWP) && !no_hwp) {
+		pr_info("intel_pstate: HWP enabled\n");
 		hwp_active++;
+	}
 
 	if (!hwp_active && hwp_only)
 		goto out;
@@ -1312,8 +1312,10 @@ static int __init intel_pstate_setup(char *str)
 
 	if (!strcmp(str, "disable"))
 		no_load = 1;
-	if (!strcmp(str, "no_hwp"))
+	if (!strcmp(str, "no_hwp")) {
+		pr_info("intel_pstate: HWP disabled\n");
 		no_hwp = 1;
+	}
 	if (!strcmp(str, "force"))
 		force_load = 1;
 	if (!strcmp(str, "hwp_only"))
-- 
1.7.9.3
