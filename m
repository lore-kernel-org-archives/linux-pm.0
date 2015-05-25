From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 2/2] turbostat, add set_base_cpu()
Date: Mon, 25 May 2015 08:34:29 -0400
Message-ID: <1432557269-10994-3-git-send-email-prarit@redhat.com>
References: <1432557269-10994-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56244 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbbEYMeg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 May 2015 08:34:36 -0400
In-Reply-To: <1432557269-10994-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, andrey.semin@intel.com, linux-pm@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>

turbostat does not function properly on systems that support CPU0 hotplug.
When running turbostat on these systems the following error is seen.

[root@intel-chiefriver-04 ~]# turbostat ls
turbostat: no /dev/cpu/0/msr
Try "# modprobe msr": No such file or directory

This happens because base_cpu is set to 0 in the turbostat code and calls
to check_dev_msr() will fail if CPU0 has been removed.

This patchset adds functionality to set the value of base_cpu to the lowest
found cpu on the system.  This patch moves setup_all_buffers() to the
beginning of the turbostat_init() so that set_base_cpu() can take advantage
of topo.max_cpu_num which is set in setup_all_buffers().

After this change, on a system that has CPU0 removed,

[root@prarit ~]# ./turbostat -d -d ls
turbostat version 4.5 2 Apr, 2015 - Len Brown <lenb@kernel.org>
num_cpus 7 max_cpu_num 7
cpu0 NOT PRESENT
cpu 1 pkg 0 core 0
cpu 2 pkg 0 core 1
cpu 3 pkg 0 core 1
cpu 4 pkg 0 core 2
cpu 5 pkg 0 core 2
cpu 6 pkg 0 core 3
cpu 7 pkg 0 core 3
<snip>
anaconda-ks.cfg  README  turbostat
    Core     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz     SMI  CPU%c1  CPU%c3  CPU%c6  CPU%c7 CoreTmp  PkgTmp Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 PkgWatt CorWatt GFXWatt
       -       -     492   14.20    3462    2634       0   18.90    0.00    0.00   68.63      27      27    0.00    0.00    0.00    0.00   17.65   12.69    0.00
       0       1     353    9.95    3552    2645       0    9.68    0.00    0.00   80.37      27      27    0.00    0.00    0.00    0.00   17.65   12.69    0.00
       1       2     217    7.70    2814    2614       0   64.63    0.00    0.00   27.68      26
       1       3    2006   57.20    3507    2660       0   15.61
       2       4     120    3.37    3570    2649       0   10.95    0.00    0.00   85.69      25
       2       5     155    4.22    3679    2631       0    9.48
       3       6     296    8.38    3530    2620       0   11.07    0.00    0.00   80.55      17
       3       7     296    8.15    3630    2617       0   11.22
0.001160 sec

I have additionally tested various other hotplug configurations to make sure
that turbostat behaves correctly in those situations as well.

[v2]: use sched_getcpu() to get current cpu

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 tools/power/x86/turbostat/turbostat.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8c2e761..8e4ce9f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -91,7 +91,7 @@ unsigned int do_gfx_perf_limit_reasons;
 unsigned int do_ring_perf_limit_reasons;
 unsigned int crystal_hz;
 unsigned long long tsc_hz;
-int base_cpu = 0;
+int base_cpu = -1;
 
 #define RAPL_PKG		(1 << 0)
 					/* 0x610 MSR_PKG_POWER_LIMIT */
@@ -2790,13 +2790,24 @@ void setup_all_buffers(void)
 	for_all_proc_cpus(initialize_counters);
 }
 
+void set_base_cpu(void)
+{
+	base_cpu = sched_getcpu();
+	if (base_cpu < 0)
+		err(-ENODEV, "No valid cpus found");
+
+	if (debug > 1)
+		fprintf(stderr, "base_cpu = %d\n", base_cpu);
+}
+
 void turbostat_init()
 {
+	setup_all_buffers();
+	set_base_cpu();
 	check_dev_msr();
 	check_permissions();
 	process_cpuid();
 
-	setup_all_buffers();
 
 	if (debug)
 		for_all_cpus(print_epb, ODD_COUNTERS);
-- 
1.7.9.3

