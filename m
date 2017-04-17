From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Subject: [PATCH] cpupower:Read available CPU frequency
Date: Mon, 17 Apr 2017 14:55:07 +0530
Message-ID: <149242094296.13908.11081644341712841929.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49159 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751738AbdDQJZO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 05:25:14 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v3H9ORZD139196
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 05:25:14 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
        by mx0a-001b2d01.pphosted.com with ESMTP id 29ucdjgmym-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 05:25:13 -0400
Received: from localhost
        by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <mamatha4@linux.vnet.ibm.com>;
        Mon, 17 Apr 2017 14:55:10 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
        by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v3H9P7tM20578456
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 14:55:07 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
        by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v3H9P7wq006383
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 14:55:07 +0530
Received: from localhost.localdomain ([9.124.158.109])
        by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id v3H9P71r006380
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 14:55:07 +0530
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Problem:On power systems "cpupower frequency-info" and
"cpupower idle-info" commands were always reading CPU0
frequencies. If CPU0 is guarded or offline then it used
to display frequency as NULL.

Solution: This patch will check for the available/online CPUs
and read the frequency and idle state info of that CPU

Test Results:

Before Patch:
********************************
#cpupower frequency-info
analyzing CPU 0:
 *is offline

# cpupower idle-info
    CPUidle driver: powernv_idle
    CPUidle governor: menu
    analyzing CPU 0:
     *is offline

With Patch:
*************************************
#./cpupower frequency-info
analyzing CPU 8:
  driver: powernv-cpufreq
  CPUs which run at the same hardware frequency: 8 9 10 11 12 13 14 15
  CPUs which need to have their frequency coordinated by software: 8 9 10 11 12 13 14 15
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 2.06 GHz - 4.32 GHz
  available frequency steps:  4.32 GHz, 4.29 GHz, 4.26 GHz, 4.22 GHz, 4.19 GHz, 4.16 GHz, 4.12 GHz, 4.09 GHz, 4.06 GHz, 4.02 GHz, 3.99 GHz, 3.96 GHz, 3.92 GHz, 3.89 GHz, 3.86 GHz, 3.82 GHz, 3.79 GHz, 3.76 GHz, 3.72 GHz, 3.69 GHz, 3.66 GHz, 3.62 GHz, 3.59 GHz, 3.56 GHz, 3.52 GHz, 3.49 GHz, 3.46 GHz, 3.42 GHz, 3.39 GHz, 3.36 GHz, 3.33 GHz, 3.29 GHz, 3.26 GHz, 3.23 GHz, 3.19 GHz, 3.16 GHz, 3.13 GHz, 3.09 GHz, 3.06 GHz, 3.03 GHz, 2.99 GHz, 2.96 GHz, 2.93 GHz, 2.89 GHz, 2.86 GHz, 2.83 GHz, 2.79 GHz, 2.76 GHz, 2.73 GHz, 2.69 GHz, 2.66 GHz, 2.63 GHz, 2.59 GHz, 2.56 GHz, 2.53 GHz, 2.49 GHz, 2.46 GHz, 2.43 GHz, 2.39 GHz, 2.36 GHz, 2.33 GHz, 2.29 GHz, 2.26 GHz, 2.23 GHz, 2.19 GHz, 2.16 GHz, 2.13 GHz, 2.09 GHz, 2.06 GHz
  available cpufreq governors: conservative ondemand userspace powersave performance
  current policy: frequency should be within 2.06 GHz and 4.32 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: 4.32 GHz (asserted by call to hardware)
#

# ./cpupower idle-info
    CPUidle driver: powernv_idle
    CPUidle governor: menu
    analyzing CPU 8:

    Number of idle states: 3
    Available idle states: snooze Nap FastSleep
    snooze:
    Flags/Description: snooze
    Latency: 0
    Usage: 8650
    Duration: 780105
    Nap:
    Flags/Description: Nap
    Latency: 4
    Usage: 7065
    Duration: 82588288
    FastSleep:
    Flags/Description: FastSleep
    Latency: 40
    Usage: 503
    Duration: 709565392

Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
---
 tools/power/cpupower/man/cpupower-frequency-info.1 |    2 +-
 tools/power/cpupower/man/cpupower-idle-info.1      |    2 +-
 tools/power/cpupower/utils/cpufreq-info.c          |   11 +++++++++--
 tools/power/cpupower/utils/cpuidle-info.c          |   11 +++++++++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 6aa8d23..2dcaedb 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -55,7 +55,7 @@ Output frequencies and latencies without rounding off values.
 .TP  
 .SH "REMARKS"
 .LP 
-By default only values of core zero are displayed. How to display settings of
+By default only online core values are displayed. How to display settings of
 other cores is described in the cpupower(1) manpage in the \-\-cpu option section.
 .LP 
 You can't specify more than one of the output specific options \-o \-e \-a \-g \-p \-d \-l \-w \-f \-y.
diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 80a1311..65c3e36 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -71,7 +71,7 @@ ignores ACPI BIOS exported processor sleep states tables.
 
 .SH "REMARKS"
 .LP
-By default only values of core zero are displayed. How to display settings of
+By default only online core values are displayed. How to display settings of
 other cores is described in the cpupower(1) manpage in the \-\-cpu option
 section.
 .SH REFERENCES
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 3e701f0..3085b42 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -20,6 +20,7 @@
 #include "helpers/bitmask.h"
 
 #define LINE_LEN 10
+static struct cpupower_topology cpu_top;
 
 static unsigned int count_cpus(void)
 {
@@ -509,6 +510,7 @@ int cmd_freq_info(int argc, char **argv)
 	unsigned int cpu = 0;
 	unsigned int human = 0;
 	int output_param = 0;
+	unsigned int nr_cpus = 0;
 
 	do {
 		ret = getopt_long(argc, argv, "oefwldpgrasmybn", info_opts,
@@ -572,9 +574,14 @@ int cmd_freq_info(int argc, char **argv)
 
 	ret = 0;
 
-	/* Default is: show output of CPU 0 only */
+	/* Show output of available online CPU */
+	nr_cpus = get_cpu_topology(&cpu_top);
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (sysfs_is_cpu_online(cpu) == 1)
+			break;
+	}
 	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+		bitmask_setbit(cpus_chosen, cpu);
 
 	switch (output_param) {
 	case -1:
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index b59c85d..b23b382 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -20,6 +20,7 @@
 #include "helpers/bitmask.h"
 
 #define LINE_LEN 10
+static struct cpupower_topology cpu_top;
 
 static void cpuidle_cpu_output(unsigned int cpu, int verbose)
 {
@@ -140,6 +141,7 @@ int cmd_idle_info(int argc, char **argv)
 	extern int optind, opterr, optopt;
 	int ret = 0, cont = 1, output_param = 0, verbose = 1;
 	unsigned int cpu = 0;
+	unsigned int nr_cpus = 0;
 
 	do {
 		ret = getopt_long(argc, argv, "os", info_opts, NULL);
@@ -177,9 +179,14 @@ int cmd_idle_info(int argc, char **argv)
 		cpuidle_exit(EXIT_FAILURE);
 	}
 
-	/* Default is: show output of CPU 0 only */
+	/* Show output of available online CPU */
+	nr_cpus = get_cpu_topology(&cpu_top);
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		if (sysfs_is_cpu_online(cpu) == 1)
+			break;
+	}
 	if (bitmask_isallclear(cpus_chosen))
-		bitmask_setbit(cpus_chosen, 0);
+		bitmask_setbit(cpus_chosen, cpu);
 
 	if (output_param == 0)
 		cpuidle_general_output();
