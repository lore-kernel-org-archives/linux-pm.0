From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] Creating a common structure initialization pattern for struct option
Date: Fri, 23 Oct 2015 09:52:45 +0200
Message-ID: <1445586765-20292-1-git-send-email-trenn@suse.de>
References: <1445527027-2764-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49668 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbbJWHxG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Oct 2015 03:53:06 -0400
In-Reply-To: <1445527027-2764-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Sriram Raghunathan <sriram@marirs.net.in>, Thomas Renninger <trenn@suse.de>

From: Sriram Raghunathan <sriram@marirs.net.in>

This patch tries to creates a common structure initialization
within the cpupower tool.

Previously the ``struct option`` was initialized
using `designated initializer` technique which was
not needed. There were conflicting initialization methods seen with

bench/main.c & others.

Signed-off-by: Sriram Raghunathan <sriram@marirs.net.in>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/debug/i386/dump_psb.c |  2 +-
 tools/power/cpupower/utils/cpufreq-info.c  | 30 +++++++++++++++---------------
 tools/power/cpupower/utils/cpufreq-set.c   | 10 +++++-----
 tools/power/cpupower/utils/cpuidle-info.c  |  4 ++--
 tools/power/cpupower/utils/cpuidle-set.c   | 14 +++++---------
 tools/power/cpupower/utils/cpupower-info.c |  4 ++--
 tools/power/cpupower/utils/cpupower-set.c  |  2 +-
 7 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/tools/power/cpupower/debug/i386/dump_psb.c b/tools/power/cpupower/debug/i386/dump_psb.c
index 8d6a475..2c768cf 100644
--- a/tools/power/cpupower/debug/i386/dump_psb.c
+++ b/tools/power/cpupower/debug/i386/dump_psb.c
@@ -134,7 +134,7 @@ next_one:
 }
 
 static struct option info_opts[] = {
-	{.name = "numpst",	.has_arg=no_argument,	.flag=NULL, .val='n'},
+     {"numpst", no_argument, NULL, 'n'},
 };
 
 void print_help(void)
diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index b4b90a9..0e67643 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -536,21 +536,21 @@ static int get_latency(unsigned int cpu, unsigned int human)
 }
 
 static struct option info_opts[] = {
-	{ .name = "debug",	.has_arg = no_argument,		.flag = NULL,	.val = 'e'},
-	{ .name = "boost",	.has_arg = no_argument,		.flag = NULL,	.val = 'b'},
-	{ .name = "freq",	.has_arg = no_argument,		.flag = NULL,	.val = 'f'},
-	{ .name = "hwfreq",	.has_arg = no_argument,		.flag = NULL,	.val = 'w'},
-	{ .name = "hwlimits",	.has_arg = no_argument,		.flag = NULL,	.val = 'l'},
-	{ .name = "driver",	.has_arg = no_argument,		.flag = NULL,	.val = 'd'},
-	{ .name = "policy",	.has_arg = no_argument,		.flag = NULL,	.val = 'p'},
-	{ .name = "governors",	.has_arg = no_argument,		.flag = NULL,	.val = 'g'},
-	{ .name = "related-cpus", .has_arg = no_argument,	.flag = NULL,	.val = 'r'},
-	{ .name = "affected-cpus",.has_arg = no_argument,	.flag = NULL,	.val = 'a'},
-	{ .name = "stats",	.has_arg = no_argument,		.flag = NULL,	.val = 's'},
-	{ .name = "latency",	.has_arg = no_argument,		.flag = NULL,	.val = 'y'},
-	{ .name = "proc",	.has_arg = no_argument,		.flag = NULL,	.val = 'o'},
-	{ .name = "human",	.has_arg = no_argument,		.flag = NULL,	.val = 'm'},
-	{ .name = "no-rounding", .has_arg = no_argument,	.flag = NULL,	.val = 'n'},
+	{"debug",	 no_argument,		 NULL,	 'e'},
+	{"boost",	 no_argument,		 NULL,	 'b'},
+	{"freq",	 no_argument,		 NULL,	 'f'},
+	{"hwfreq",	 no_argument,		 NULL,	 'w'},
+	{"hwlimits",	 no_argument,		 NULL,	 'l'},
+	{"driver",	 no_argument,		 NULL,	 'd'},
+	{"policy",	 no_argument,		 NULL,	 'p'},
+	{"governors",	 no_argument,		 NULL,	 'g'},
+	{"related-cpus",  no_argument,	 NULL,	 'r'},
+	{"affected-cpus", no_argument,	 NULL,	 'a'},
+	{"stats",	 no_argument,		 NULL,	 's'},
+	{"latency",	 no_argument,		 NULL,	 'y'},
+	{"proc",	 no_argument,		 NULL,	 'o'},
+	{"human",	 no_argument,		 NULL,	 'm'},
+	{"no-rounding", no_argument,	 NULL,	 'n'},
 	{ },
 };
 
diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index 4e21357..0fbd1a2 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -22,11 +22,11 @@
 #define NORM_FREQ_LEN 32
 
 static struct option set_opts[] = {
-	{ .name = "min",	.has_arg = required_argument,	.flag = NULL,	.val = 'd'},
-	{ .name = "max",	.has_arg = required_argument,	.flag = NULL,	.val = 'u'},
-	{ .name = "governor",	.has_arg = required_argument,	.flag = NULL,	.val = 'g'},
-	{ .name = "freq",	.has_arg = required_argument,	.flag = NULL,	.val = 'f'},
-	{ .name = "related",	.has_arg = no_argument,		.flag = NULL,	.val='r'},
+	{"min",		required_argument,	NULL, 'd'},
+	{"max",		required_argument,	NULL, 'u'},
+	{"governor",	required_argument,	NULL, 'g'},
+	{"freq",	required_argument,	NULL, 'f'},
+	{"related",	no_argument,		NULL, 'r'},
 	{ },
 };
 
diff --git a/tools/power/cpupower/utils/cpuidle-info.c b/tools/power/cpupower/utils/cpuidle-info.c
index 75e66de..750c1d8 100644
--- a/tools/power/cpupower/utils/cpuidle-info.c
+++ b/tools/power/cpupower/utils/cpuidle-info.c
@@ -126,8 +126,8 @@ static void proc_cpuidle_cpu_output(unsigned int cpu)
 }
 
 static struct option info_opts[] = {
-	{ .name = "silent",	.has_arg = no_argument,	.flag = NULL,	.val = 's'},
-	{ .name = "proc",	.has_arg = no_argument,	.flag = NULL,	.val = 'o'},
+	{"silent", no_argument, NULL, 's'},
+	{"proc", no_argument, NULL, 'o'},
 	{ },
 };
 
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index eaea130..d6b6ae4 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -13,15 +13,11 @@
 #include "helpers/sysfs.h"
 
 static struct option info_opts[] = {
-	{ .name = "disable",
-	  .has_arg = required_argument,	.flag = NULL,	.val = 'd'},
-	{ .name = "enable",
-	  .has_arg = required_argument,	.flag = NULL,	.val = 'e'},
-	{ .name = "disable-by-latency",
-	  .has_arg = required_argument,	.flag = NULL,	.val = 'D'},
-	{ .name = "enable-all",
-	  .has_arg = no_argument,	.flag = NULL,	.val = 'E'},
-	{ },
+     {"disable",	required_argument,		NULL, 'd'},
+     {"enable",		required_argument,		NULL, 'e'},
+     {"disable-by-latency", required_argument,		NULL, 'D'},
+     {"enable-all",	no_argument,			NULL, 'E'},
+     { },
 };
 
 
diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 136d979..10299f2 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -17,8 +17,8 @@
 #include "helpers/sysfs.h"
 
 static struct option set_opts[] = {
-	{ .name = "perf-bias",	.has_arg = optional_argument,	.flag = NULL,	.val = 'b'},
-	{ },
+     {"perf-bias", optional_argument, NULL, 'b'},
+     { },
 };
 
 static void print_wrong_arg_exit(void)
diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
index 573c75f..3e6f374 100644
--- a/tools/power/cpupower/utils/cpupower-set.c
+++ b/tools/power/cpupower/utils/cpupower-set.c
@@ -18,7 +18,7 @@
 #include "helpers/bitmask.h"
 
 static struct option set_opts[] = {
-	{ .name = "perf-bias",	.has_arg = required_argument,	.flag = NULL,	.val = 'b'},
+	{"perf-bias", required_argument, NULL, 'b'},
 	{ },
 };
 
-- 
2.1.4

