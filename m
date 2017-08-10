From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH v3] Fix header-name to read state name and adjust column width
Date: Thu, 10 Aug 2017 18:24:54 +0530
Message-ID: <1502369694-9720-1-git-send-email-s1seetee@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Cc: s1seetee@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

root:~# cpupower monitor
               |Idle_Stats
 PKG |CORE|CPU | snoo | stop | stop
    0|   8|   0|  0.00|  0.00|  2.79
    0|   8|   1|  0.00|  0.00| 70.68

In this patch, we modify the output to print the state name
and adjust the column width, that results in a legible output.

root:~#cpupower monitor
              |Idle_Stats
PKG |CORE|CPU |snooze|stop0_li|stop1_li
   0|   8|   0|  0.00|    0.00|   60.04
   0|   8|   1|  0.00|    0.00|   38.97
   0|   8|   2|  0.00|    0.00|    0.00
   0|   8|   3|  0.00|    0.00|    0.00
   0|  12|   4|  0.00|    0.00|   99.25
   0|  12|   5|  0.00|    0.00|    0.00
   0|  12|   6|  0.00|    0.00|   99.71
   0|  12|   7|  0.00|    0.00|   99.85
   8|2048|   8|  0.00|    0.00|   54.66
   8|2048|   9|  0.00|    0.00|    0.00
   8|2048|  10|  0.00|    0.00|    0.00
   8|2048|  11|  0.00|    0.00|   97.83
   8|2052|  12|  0.00|    0.00|    0.00
   8|2052|  13|  0.00|    0.00|    0.00
   8|2052|  14|  0.00|    0.00|    1.99
   8|2052|  15|  0.00|    0.00|   99.87

Tested on POWER8, POWER9 and x86.

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
---
 .../cpupower/utils/idle_monitor/cpupower-monitor.c | 62 +++++++++++++++-------
 .../cpupower/utils/idle_monitor/cpupower-monitor.h |  6 ++-
 2 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 05f953f..949b3bc 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -21,6 +21,10 @@
 #include "idle_monitor/cpupower-monitor.h"
 #include "idle_monitor/idle_monitors.h"
 #include "helpers/helpers.h"
+#define xstr(s) str(s)
+#define str(s) #s
+#define COL_WIDTH_MIN   6
+#define COL_WIDTH_MAX   8
 
 /* Define pointers to all monitors.  */
 #define DEF(x) & x ## _monitor ,
@@ -85,7 +89,7 @@ int fill_string_with_spaces(char *s, int n)
 void print_header(int topology_depth)
 {
 	int unsigned mon;
-	int state, need_len;
+	int state, need_len, name_len;
 	cstate_t s;
 	char buf[128] = "";
 	int percent_width = 4;
@@ -116,17 +120,19 @@ void print_header(int topology_depth)
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
-			sprintf(buf, "%s", s.name);
+			name_len = strlen(s.name);
+			if (name_len <= COL_WIDTH_MIN)
+				percent_width = COL_WIDTH_MIN;
+			else
+				percent_width = COL_WIDTH_MAX;
+			sprintf(buf, "%.*s", percent_width, s.name);
 			fill_string_with_spaces(buf, percent_width);
 			printf("%s", buf);
 		}
-		printf(" ");
 	}
 	printf("\n");
 }
@@ -134,12 +140,12 @@ void print_header(int topology_depth)
 
 void print_results(int topology_depth, int cpu)
 {
-	unsigned int mon;
-	int state, ret;
+	unsigned int mon, percent_width, name_len, width;
+	int state, ret, i;
 	double percent;
 	unsigned long long result;
 	cstate_t s;
-
+	char buf[128] = "";
 	/* Be careful CPUs may got resorted for pkg value do not just use cpu */
 	if (!bitmask_isbitset(cpus_chosen, cpu_top.core_info[cpu].cpu))
 		return;
@@ -163,23 +160,37 @@ void print_results(int topology_depth, int cpu)
 				printf("|");
 
 			s = monitors[mon]->hw_states[state];
-
+			name_len = strlen(s.name);
+			if (name_len > COL_WIDTH_MIN) {
+				percent_width = COL_WIDTH_MAX;
+				width = percent_width - COL_WIDTH_MIN;
+				fill_string_with_spaces(buf, width);
+				printf("%s", buf);
+			}
 			if (s.get_count_percent) {
 				ret = s.get_count_percent(s.id, &percent,
 						  cpu_top.core_info[cpu].cpu);
-				if (ret)
-					printf("******");
-				else if (percent >= 100.0)
-					printf("%6.1f", percent);
-				else
-					printf("%6.2f", percent);
+				if (ret) {
+					for (i = 0; i < COL_WIDTH_MIN; i++)
+						printf("*");
+				} else if (percent >= 100.0) {
+					printf("%"xstr(COL_WIDTH_MIN)".1f",
+						  percent);
+					}
+				else {
+					printf("%"xstr(COL_WIDTH_MIN)".2f",
+						  percent);
+				}
 			} else if (s.get_count) {
 				ret = s.get_count(s.id, &result,
 						  cpu_top.core_info[cpu].cpu);
-				if (ret)
-					printf("******");
-				else
-					printf("%6llu", result);
+				if (ret) {
+					for (i = 0; i < COL_WIDTH_MIN; i++)
+						printf("*");
+				} else {
+					printf("%"xstr(COL_WIDTH_MIN)"llu",
+						  result);
+				}
 			} else {
 				printf(_("Monitor %s, Counter %s has no count "
 					 "function. Implementation error\n"),
diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
index 9e43f33..f6dcb9f 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.h
@@ -15,7 +15,11 @@
 
 #define MONITORS_MAX 20
 #define MONITOR_NAME_LEN 20
-#define CSTATE_NAME_LEN 5
+/*
+ *  CSTATE_NAME_LEN is limited by the CPUIDLE_NAME_LEN defined
+ *  in include/linux/cpuidle.h.
+ */
+#define CSTATE_NAME_LEN 16
 #define CSTATE_DESC_LEN 60
 
 int cpu_count;
-- 
1.8.3.1
