From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 4/9] cpupower: Introduce idle state disable-by-latency and enable-all
Date: Tue, 13 May 2014 12:41:41 +0200
Message-ID: <1399977706-50854-5-git-send-email-trenn@suse.de>
References: <1399977706-50854-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51387 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760526AbaEMKlw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 May 2014 06:41:52 -0400
In-Reply-To: <1399977706-50854-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/man/cpupower-idle-set.1 |   10 +++-
 tools/power/cpupower/utils/cpuidle-set.c     |   75 +++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 6b16072..3e6799d 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -13,11 +13,17 @@ sleep states. This can be handy for power vs performance tuning.
 .SH "OPTIONS"
 .LP
 .TP
-\fB\-d\fR \fB\-\-disable\fR
+\fB\-d\fR \fB\-\-disable\fR <STATE_NO>
 Disable a specific processor sleep state.
 .TP
-\fB\-e\fR \fB\-\-enable\fR
+\fB\-e\fR \fB\-\-enable\fR <STATE_NO>
 Enable a specific processor sleep state.
+.TP
+\fB\-D\fR \fB\-\-disable-by-latency\fR <LATENCY>
+Disable all idle states with a equal or higher latency than <LATENCY>
+.TP
+\fB\-E\fR \fB\-\-enable-all\fR
+Enable all idle states if not enabled already.
 
 .SH "REMARKS"
 .LP
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index c78141c..d45d8d7 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -13,8 +13,14 @@
 #include "helpers/sysfs.h"
 
 static struct option info_opts[] = {
-	{ .name = "disable",	.has_arg = required_argument,	.flag = NULL,	.val = 'd'},
-	{ .name = "enable",	.has_arg = required_argument,	.flag = NULL,	.val = 'e'},
+	{ .name = "disable",
+	  .has_arg = required_argument,	.flag = NULL,	.val = 'd'},
+	{ .name = "enable",
+	  .has_arg = required_argument,	.flag = NULL,	.val = 'e'},
+	{ .name = "disable-by-latency",
+	  .has_arg = required_argument,	.flag = NULL,	.val = 'D'},
+	{ .name = "enable-all",
+	  .has_arg = no_argument,	.flag = NULL,	.val = 'E'},
 	{ },
 };
 
@@ -23,11 +29,13 @@ int cmd_idle_set(int argc, char **argv)
 {
 	extern char *optarg;
 	extern int optind, opterr, optopt;
-	int ret = 0, cont = 1, param = 0, idlestate = 0;
-	unsigned int cpu = 0;
+	int ret = 0, cont = 1, param = 0, disabled;
+	unsigned long long latency = 0, state_latency;
+	unsigned int cpu = 0, idlestate = 0, idlestates = 0;
+	char *endptr;
 
 	do {
-		ret = getopt_long(argc, argv, "d:e:", info_opts, NULL);
+		ret = getopt_long(argc, argv, "d:e:ED:", info_opts, NULL);
 		if (ret == -1)
 			break;
 		switch (ret) {
@@ -53,6 +61,27 @@ int cmd_idle_set(int argc, char **argv)
 			param = ret;
 			idlestate = atoi(optarg);
 			break;
+		case 'D':
+			if (param) {
+				param = -1;
+				cont = 0;
+				break;
+			}
+			param = ret;
+			latency = strtoull(optarg, &endptr, 10);
+			if (*endptr != '\0') {
+				printf(_("Bad latency value: %s\n"), optarg);
+				exit(EXIT_FAILURE);
+			}
+			break;
+		case 'E':
+			if (param) {
+				param = -1;
+				cont = 0;
+				break;
+			}
+			param = ret;
+			break;
 		case -1:
 			cont = 0;
 			break;
@@ -79,8 +108,14 @@ int cmd_idle_set(int argc, char **argv)
 		if (!bitmask_isbitset(cpus_chosen, cpu))
 			continue;
 
-		switch (param) {
+		if (sysfs_is_cpu_online(cpu) != 1)
+			continue;
+
+		idlestates = sysfs_get_idlestate_count(cpu);
+		if (idlestates <= 0)
+			continue;
 
+		switch (param) {
 		case 'd':
 			ret = sysfs_idlestate_disable(cpu, idlestate, 1);
 			if (ret == 0)
@@ -107,6 +142,34 @@ int cmd_idle_set(int argc, char **argv)
 		printf(_("Idlestate %u not enabled on CPU %u\n"),
 		       idlestate, cpu);
 			break;
+		case 'D':
+			for (idlestate = 0; idlestate < idlestates; idlestate++) {
+				disabled = sysfs_is_idlestate_disabled
+					(cpu, idlestate);
+				state_latency = sysfs_get_idlestate_latency
+					(cpu, idlestate);
+				printf("CPU: %u - idlestate %u - state_latency: %llu - latency: %llu\n",
+				       cpu, idlestate, state_latency, latency);
+				if (disabled == 1 || latency > state_latency)
+					continue;
+				ret = sysfs_idlestate_disable
+					(cpu, idlestate, 1);
+				if (ret == 0)
+		printf(_("Idlestate %u disabled on CPU %u\n"), idlestate, cpu);
+			}
+			break;
+		case 'E':
+			for (idlestate = 0; idlestate < idlestates; idlestate++) {
+				disabled = sysfs_is_idlestate_disabled
+					(cpu, idlestate);
+				if (disabled == 1) {
+					ret = sysfs_idlestate_disable
+						(cpu, idlestate, 0);
+					if (ret == 0)
+		printf(_("Idlestate %u enabled on CPU %u\n"), idlestate, cpu);
+				}
+			}
+			break;
 		default:
 			/* Not reachable with proper args checking */
 			printf(_("Invalid or unknown argument\n"));
-- 
1.7.6.1

