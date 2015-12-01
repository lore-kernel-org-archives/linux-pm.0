From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 3/5] cpupower: Do not analyse offlined cpus
Date: Tue,  1 Dec 2015 17:14:15 +0100
Message-ID: <1448986457-12844-4-git-send-email-trenn@suse.com>
References: <1448986457-12844-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49847 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546AbbLAQOV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Dec 2015 11:14:21 -0500
In-Reply-To: <1448986457-12844-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.com>

Use sysfs_is_cpu_online(cpu) instead of cpufreq_cpu_exists(cpu) to detect offlined cpus.

Re-arrange printfs slightly to have a consistent output even if you have multiple CPUs
as output and even if offlined cores are in between.

Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/utils/cpufreq-info.c  | 11 ++++++++---
 tools/power/cpupower/utils/cpuidle-info.c  | 16 ++++++++++------
 tools/power/cpupower/utils/cpupower-info.c |  9 ++++++---
 tools/power/cpupower/utils/cpupower-set.c  | 10 +++++++---
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 0e67643..522b357 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -14,6 +14,7 @@
 #include <getopt.h>
 
 #include "cpufreq.h"
+#include "helpers/sysfs.h"
 #include "helpers/helpers.h"
 #include "helpers/bitmask.h"
 
@@ -647,11 +648,14 @@ int cmd_freq_info(int argc, char **argv)
 
 		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
-		if (cpufreq_cpu_exists(cpu)) {
-			printf(_("couldn't analyze CPU %d as it doesn't seem to be present\n"), cpu);
+
+		printf(_("analyzing CPU %d:\n"), cpu);
+
+		if (sysfs_is_cpu_online(cpu) != 1) {
+			printf(_(" *is offline\n"));
+			printf("\n");
 			continue;
 		}
-		printf(_("analyzing CPU %d:\n"), cpu);
 
 		switch (output_param) {
 		case 'b':
@@ -693,6 +697,7 @@ int cmd_freq_info(int argc, char **argv)
 		}
 		if (ret)
 			return ret;
+		printf("\n");
 	}
 	return ret;
 }
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index 750c1d8..8bf8ab5 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -12,7 +12,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <getopt.h>
-#include <cpufreq.h>
 
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
@@ -25,8 +24,6 @@ static void cpuidle_cpu_output(unsigned int cpu, int verbose)
 	unsigned int idlestates, idlestate;
 	char *tmp;
 
-	printf(_ ("Analyzing CPU %d:\n"), cpu);
-
 	idlestates = sysfs_get_idlestate_count(cpu);
 	if (idlestates == 0) {
 		printf(_("CPU %u: No idle states\n"), cpu);
@@ -71,7 +68,6 @@ static void cpuidle_cpu_output(unsigned int cpu, int verbose)
 		printf(_("Duration: %llu\n"),
 		       sysfs_get_idlestate_time(cpu, idlestate));
 	}
-	printf("\n");
 }
 
 static void cpuidle_general_output(void)
@@ -189,10 +185,17 @@ int cmd_idle_info(int argc, char **argv)
 	for (cpu = bitmask_first(cpus_chosen);
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
-		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpufreq_cpu_exists(cpu))
+		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
 
+		printf(_("analyzing CPU %d:\n"), cpu);
+
+		if (sysfs_is_cpu_online(cpu) != 1) {
+			printf(_(" *is offline\n"));
+			printf("\n");
+			continue;
+		}
+
 		switch (output_param) {
 
 		case 'o':
@@ -203,6 +206,7 @@ int cmd_idle_info(int argc, char **argv)
 			cpuidle_cpu_output(cpu, verbose);
 			break;
 		}
+		printf("\n");
 	}
 	return EXIT_SUCCESS;
 }
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 10299f2..c7caa8e 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -12,7 +12,6 @@
 #include <string.h>
 #include <getopt.h>
 
-#include <cpufreq.h>
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
 
@@ -83,12 +82,16 @@ int cmd_info(int argc, char **argv)
 	for (cpu = bitmask_first(cpus_chosen);
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
-		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpufreq_cpu_exists(cpu))
+		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
 
 		printf(_("analyzing CPU %d:\n"), cpu);
 
+		if (sysfs_is_cpu_online(cpu) != 1){
+			printf(_(" *is offline\n"));
+			continue;
+		}
+
 		if (params.perf_bias) {
 			ret = msr_intel_get_perf_bias(cpu);
 			if (ret < 0) {
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 3e6f374..532f46b 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -12,7 +12,6 @@
 #include <string.h>
 #include <getopt.h>
 
-#include <cpufreq.h>
 #include "helpers/helpers.h"
 #include "helpers/sysfs.h"
 #include "helpers/bitmask.h"
@@ -78,10 +77,15 @@ int cmd_set(int argc, char **argv)
 	for (cpu = bitmask_first(cpus_chosen);
 	     cpu <= bitmask_last(cpus_chosen); cpu++) {
 
-		if (!bitmask_isbitset(cpus_chosen, cpu) ||
-		    cpufreq_cpu_exists(cpu))
+		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
 
+		if (sysfs_is_cpu_online(cpu) != 1){
+			fprintf(stderr, _("Cannot set values on CPU %d:"), cpu);
+			fprintf(stderr, _(" *is offline\n"));
+			continue;
+		}
+
 		if (params.perf_bias) {
 			ret = msr_intel_set_perf_bias(cpu, perf_bias);
 			if (ret) {
-- 
2.1.4

