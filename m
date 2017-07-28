From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 1/7] turbostat: set max_num_cpus equal to the cpumask length
Date: Fri, 28 Jul 2017 08:06:15 -0400
Message-ID: <1501243581-31491-3-git-send-email-prarit@redhat.com>
References: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdG1MGa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jul 2017 08:06:30 -0400
In-Reply-To: <1501243581-31491-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: lenb@kernel.org, Prarit Bhargava <prarit@redhat.com>, Len Brown <len.brown@intel.com>

Future fixes will use sysfs files that contain cpumask output.  The code
needs to know the length of the cpumask in order to determine which cpus
are set in a cpumask.  Currently topo.max_cpu_num is the maximum cpu
number.  It can be increased the the maximum value of cpus represented in
cpumasks.

Set max_num_cpus to the length of a cpumask.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0dafba2c1e7d..6d368e744d27 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2413,6 +2413,20 @@ void re_initialize(void)
 	printf("turbostat: re-initialized with num_cpus %d\n", topo.num_cpus);
 }
 
+void set_max_cpu_num(void)
+{
+	FILE *filep;
+	unsigned long dummy;
+
+	topo.max_cpu_num = 0;
+	filep = fopen_or_die(
+			"/sys/devices/system/cpu/cpu0/topology/thread_siblings",
+			"r");
+	while (fscanf(filep, "%lx,", &dummy) == 1)
+		topo.max_cpu_num+=32;
+	fclose(filep);
+	topo.max_cpu_num--; /* 0 based */
+}
 
 /*
  * count_cpus()
@@ -2420,10 +2434,7 @@ void re_initialize(void)
  */
 int count_cpus(int cpu)
 {
-	if (topo.max_cpu_num < cpu)
-		topo.max_cpu_num = cpu;
-
-	topo.num_cpus += 1;
+	topo.num_cpus++;
 	return 0;
 }
 int mark_cpu_present(int cpu)
@@ -4320,8 +4331,8 @@ void topology_probe()
 	} *cpus;
 
 	/* Initialize num_cpus, max_cpu_num */
+	set_max_cpu_num();
 	topo.num_cpus = 0;
-	topo.max_cpu_num = 0;
 	for_all_proc_cpus(count_cpus);
 	if (!summary_only && topo.num_cpus > 1)
 		BIC_PRESENT(BIC_CPU);
-- 
1.8.5.5
