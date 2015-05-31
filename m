From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] intel_pstate: change some inconsistent debug information.
Date: Sun, 31 May 2015 07:46:47 -0700
Message-ID: <1433083607-4150-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33372 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756380AbbEaOq6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 May 2015 10:46:58 -0400
Received: by padj3 with SMTP id j3so25804042pad.0
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2015 07:46:58 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen@linux.intel.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: dsmythies@telus.net

In a previous revision,
commit ce717613f3fb531dea3e11c8c24d80585331f137
turned per cpu printk into pr_debug.
However, only half of the change was done,
introducing an inconsistency between
entry and exit from driver pstate control.
This patch changes the exit message to
pr_debug also.

The various messages are inconsistent with respect
to any identifier text that can be used to help
isolate the desired information from a huge log.
This patch makes a consistent identifier portion
of the string.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 77b6edf..cbf1890 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -399,7 +399,7 @@ static ssize_t store_no_turbo(struct kobject *a, struct attribute *b,
 
 	update_turbo_state();
 	if (limits.turbo_disabled) {
-		pr_warn("Turbo disabled by BIOS or unavailable on processor\n");
+		pr_warn("intel_pstate: Turbo disabled by BIOS or unavailable on processor\n");
 		return -EPERM;
 	}
 
@@ -487,7 +487,7 @@ static void __init intel_pstate_sysfs_expose_params(void)
 static void intel_pstate_hwp_enable(void)
 {
 	hwp_active++;
-	pr_info("intel_pstate HWP enabled\n");
+	pr_info("intel_pstate: HWP enabled\n");
 
 	wrmsrl( MSR_PM_ENABLE, 0x1);
 }
@@ -940,7 +940,7 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
 
 	add_timer_on(&cpu->timer, cpunum);
 
-	pr_debug("Intel pstate controlling: cpu %d\n", cpunum);
+	pr_debug("intel_pstate: controlling: cpu %d\n", cpunum);
 
 	return 0;
 }
@@ -1006,7 +1006,7 @@ static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 	int cpu_num = policy->cpu;
 	struct cpudata *cpu = all_cpu_data[cpu_num];
 
-	pr_info("intel_pstate CPU %d exiting\n", cpu_num);
+	pr_debug("intel_pstate: CPU %d exiting\n", cpu_num);
 
 	del_timer_sync(&all_cpu_data[cpu_num]->timer);
 	if (hwp_active)
-- 
1.9.1

