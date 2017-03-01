From: Len Brown <lenb@kernel.org>
Subject: [PATCH 33/44] tools/power turbostat: fix zero IRQ count shown in one-shot command mode
Date: Wed,  1 Mar 2017 00:27:37 -0500
Message-ID: <218f0e8d5c388767be9c78fd2c5bc0a6f416d6d0.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36126 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdCAHOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 02:14:35 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

The IRQ column has been working for periodic mode,
but not in one-shot command mode, it shows only 0.

until now.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8c965bb2f461..48b540a2fe81 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -619,9 +619,9 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "c1: %016llX\n", t->c1);
 
 		if (DO_BIC(BIC_IRQ))
-			outp += sprintf(outp, "IRQ: %08X\n", t->irq_count);
+			outp += sprintf(outp, "IRQ: %d\n", t->irq_count);
 		if (DO_BIC(BIC_SMI))
-			outp += sprintf(outp, "SMI: %08X\n", t->smi_count);
+			outp += sprintf(outp, "SMI: %d\n", t->smi_count);
 
 		for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 			outp += sprintf(outp, "tADDED [%d] msr0x%x: %08llX\n",
@@ -2410,8 +2410,9 @@ int snapshot_gfx_mhz(void)
  */
 int snapshot_proc_sysfs_files(void)
 {
-	if (snapshot_proc_interrupts())
-		return 1;
+	if (DO_BIC(BIC_IRQ))
+		if (snapshot_proc_interrupts())
+			return 1;
 
 	if (DO_BIC(BIC_GFX_rc6))
 		snapshot_gfx_rc6_ms();
@@ -4391,6 +4392,7 @@ int fork_it(char **argv)
 	pid_t child_pid;
 	int status;
 
+	snapshot_proc_sysfs_files();
 	status = for_all_cpus(get_counters, EVEN_COUNTERS);
 	if (status)
 		exit(status);
@@ -4417,6 +4419,7 @@ int fork_it(char **argv)
 	 * n.b. fork_it() does not check for errors from for_all_cpus()
 	 * because re-starting is problematic when forking
 	 */
+	snapshot_proc_sysfs_files();
 	for_all_cpus(get_counters, ODD_COUNTERS);
 	gettimeofday(&tv_odd, (struct timezone *)NULL);
 	timersub(&tv_odd, &tv_even, &tv_delta);
@@ -4438,6 +4441,7 @@ int get_and_dump_counters(void)
 {
 	int status;
 
+	snapshot_proc_sysfs_files();
 	status = for_all_cpus(get_counters, ODD_COUNTERS);
 	if (status)
 		return status;
-- 
2.11.0.161.g6610af872
