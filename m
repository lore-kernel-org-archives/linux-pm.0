From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH] Fix header-name to read full state name and adjust column width
Date: Thu,  6 Jul 2017 12:44:24 +0530
Message-ID: <1499325264-15521-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51133 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752610AbdGFHOf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 03:14:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v667DcMc066460
        for <linux-pm@vger.kernel.org>; Thu, 6 Jul 2017 03:14:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bh38m5jnn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 06 Jul 2017 03:14:34 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <s1seetee@linux.vnet.ibm.com>;
        Thu, 6 Jul 2017 17:14:32 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, trenn@suse.com
Cc: s1seetee@linux.vnet.ibm.com

---Steps to Reproduce---

1.Execute the cpupower monitor command to fetch all the Idle_Stats values.

root:~# cpupower monitor
              |Idle_Stats
PKG |CORE|CPU | snoo | stop | stop
   0|   8|   0|  0.00|  0.00|  2.79
   0|   8|   1|  0.00|  0.00| 70.68

User interpret it as 2 columns for stop Idle_stats.

root:/sys/devices/system/cpu/cpu8/cpuidle# cat */name
snooze
stop0_lite
stop1_lite

cpupower monitor now shows full state name and adjust colomn width.

root:~/linux/tools/power/cpupower# cpupower monitor
              |Idle_Stats
PKG |CORE|CPU |snooze|stop0_lite|stop1_lite
   0|   8|   0|  0.00|      0.00|     99.83
   0|   8|   1|  0.00|      0.00|     43.82
   0|   8|   2|  0.00|      0.00|     102.1
   0|   8|   3|  0.00|      0.00|     96.56

tested on x86 as well.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 .../cpupower/utils/idle_monitor/cpupower-monitor.c | 25 ++++++++++++++--------
 .../cpupower/utils/idle_monitor/cpupower-monitor.h |  2 +-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 05f953f..5e708d5 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -88,7 +88,7 @@ void print_header(int topology_depth)
 	int state, need_len;
 	cstate_t s;
 	char buf[128] = "";
-	int percent_width = 4;
+	unsigned int percent_width = 6;
 
 	fill_string_with_spaces(buf, topology_depth * 5 - 1);
 	printf("%s|", buf);
@@ -116,17 +116,18 @@ void print_header(int topology_depth)
 	for (mon = 0; mon < avail_monitors; mon++) {
 		if (mon != 0)
 			printf("|| ");
-		else
-			printf(" ");
 		for (state = 0; state < monitors[mon]->hw_states_num; state++) {
 			if (state != 0)
-				printf(" | ");
+				printf("|");
 			s = monitors[mon]->hw_states[state];
 			sprintf(buf, "%s", s.name);
-			fill_string_with_spaces(buf, percent_width);
+			if (strlen(s.name) > percent_width)
+				fill_string_with_spaces(buf, strlen(s.name));
+			else
+				fill_string_with_spaces(buf, percent_width);
+
 			printf("%s", buf);
-		}
-		printf(" ");
+			}
 	}
 	printf("\n");
 }
@@ -139,7 +140,9 @@ void print_results(int topology_depth, int cpu)
 	double percent;
 	unsigned long long result;
 	cstate_t s;
-
+	char buf[128] = "";
+	unsigned int percent_width = 6;
+	unsigned int width;
 	/* Be careful CPUs may got resorted for pkg value do not just use cpu */
 	if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
 		return;
@@ -163,7 +166,11 @@ void print_results(int topology_depth, int cpu)
 				printf("|");
 
 			s = monitors[mon]->hw_states[state];
-
+			if (strlen(s.name) > percent_width) {
+				width = strlen(s.name) - percent_width;
+				fill_string_with_spaces(buf, width);
+				printf("%s", buf);
+			}
 			if (s.get_count_percent) {
 				ret = s.get_count_percent(s.id, &percent,
 						  cpu_top.core_info[cpu].cpu);
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index 9e43f33..c9179c6 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -15,7 +15,7 @@
 
 #define MONITORS_MAX 20
 #define MONITOR_NAME_LEN 20
-#define CSTATE_NAME_LEN 5
+#define CSTATE_NAME_LEN 16
 #define CSTATE_DESC_LEN 60
 
 int cpu_count;
-- 
1.8.3.1
