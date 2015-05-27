From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/5] tools/power turbostat: correctly display more than 2 threads/core
Date: Wed, 27 May 2015 18:08:02 -0400
Message-ID: <e275b3885dffd31095984ed2476ed0447fa7309a.1432764245.git.len.brown@intel.com>
References: <1432764486-3517-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33639 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbE0WIS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 18:08:18 -0400
Received: by qkhg32 with SMTP id g32so14433073qkh.0
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 15:08:17 -0700 (PDT)
In-Reply-To: <1432764486-3517-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Len Brown <len.brown@intel.com>

From: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>

Without this update, turbostat displays only 2 threads per core.
Some processors, such as Xeon Phi, have more.

Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 71 +++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index bac98ca..d85adba 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1381,12 +1381,41 @@ int parse_int_file(const char *fmt, ...)
 }
 
 /*
- * cpu_is_first_sibling_in_core(cpu)
- * return 1 if given CPU is 1st HT sibling in the core
+ * get_cpu_position_in_core(cpu)
+ * return the position of the CPU among its HT siblings in the core
+ * return -1 if the sibling is not in list
  */
-int cpu_is_first_sibling_in_core(int cpu)
+int get_cpu_position_in_core(int cpu)
 {
-	return cpu == parse_int_file("/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list", cpu);
+	char path[64];
+	FILE *filep;
+	int this_cpu;
+	char character;
+	int i;
+
+	sprintf(path,
+		"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list",
+		cpu);
+	filep = fopen(path, "r");
+	if (filep == NULL) {
+		perror(path);
+		exit(1);
+	}
+
+	for (i = 0; i < topo.num_threads_per_core; i++) {
+		fscanf(filep, "%d", &this_cpu);
+		if (this_cpu == cpu) {
+			fclose(filep);
+			return i;
+		}
+
+		/* Account for no separator after last thread*/
+		if (i != (topo.num_threads_per_core - 1))
+			fscanf(filep, "%c", &character);
+	}
+
+	fclose(filep);
+	return -1;
 }
 
 /*
@@ -1412,25 +1441,31 @@ int get_num_ht_siblings(int cpu)
 {
 	char path[80];
 	FILE *filep;
-	int sib1, sib2;
-	int matches;
+	int sib1;
+	int matches = 0;
 	char character;
+	char str[100];
+	char *ch;
 
 	sprintf(path, "/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list", cpu);
 	filep = fopen_or_die(path, "r");
+
 	/*
 	 * file format:
-	 * if a pair of number with a character between: 2 siblings (eg. 1-2, or 1,4)
-	 * otherwinse 1 sibling (self).
+	 * A ',' separated or '-' separated set of numbers
+	 * (eg 1-2 or 1,3,4,5)
 	 */
-	matches = fscanf(filep, "%d%c%d\n", &sib1, &character, &sib2);
+	fscanf(filep, "%d%c\n", &sib1, &character);
+	fseek(filep, 0, SEEK_SET);
+	fgets(str, 100, filep);
+	ch = strchr(str, character);
+	while (ch != NULL) {
+		matches++;
+		ch = strchr(ch+1, character);
+	}
 
 	fclose(filep);
-
-	if (matches == 3)
-		return 2;
-	else
-		return 1;
+	return matches+1;
 }
 
 /*
@@ -2755,13 +2790,9 @@ int initialize_counters(int cpu_id)
 
 	my_package_id = get_physical_package_id(cpu_id);
 	my_core_id = get_core_id(cpu_id);
-
-	if (cpu_is_first_sibling_in_core(cpu_id)) {
-		my_thread_id = 0;
+	my_thread_id = get_cpu_position_in_core(cpu_id);
+	if (!my_thread_id)
 		topo.num_cores++;
-	} else {
-		my_thread_id = 1;
-	}
 
 	init_counter(EVEN_COUNTERS, my_thread_id, my_core_id, my_package_id, cpu_id);
 	init_counter(ODD_COUNTERS, my_thread_id, my_core_id, my_package_id, cpu_id);
-- 
2.4.1.314.g9532ead

