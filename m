From: Len Brown <lenb@kernel.org>
Subject: [PATCH 38/44] tools/power turbostat: move --Package and --processor into the --cpu option
Date: Wed,  1 Mar 2017 00:27:42 -0500
Message-ID: <4e4e1e7c6eaf387f8ec803f37f154fdd60e303c0.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32775 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdCAFbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:31:20 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

--Package is now "--cpu package",
which will display just the 1st CPU in each package

--processor is not "--cpu core"
which will display just the 1st CPU in each core

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  6 +-----
 tools/power/x86/turbostat/turbostat.c | 31 ++++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index b1b1ab80102c..5189d9d982fe 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -52,7 +52,7 @@ name as necessary to disambiguate it from others is necessary.  Note that option
 		as the column header.
 .fi
 .PP
-\fB--cpu cpu-set\fP limit output to system summary plus the specified cpu-set.  cpu-set is a comma delimited list of cpu ranges. cpu ranges can be individual cpu numbers or start and end numbers, separated by ".." or '-'.  eg. 1,2,8,14..17,21-44
+\fB--cpu cpu-set\fP limit output to system summary plus the specified cpu-set.  If cpu-set is the string "core", then the system summary plus the first CPU in each core are printed -- eg. subsequent HT siblings are not printed.  Or if cpu-set is the string "package", then the system summary plus the first CPU in each package is printed.  Otherwise, the system summary plus the specified set of CPUs are printed.  The cpu-set is ordered from low to high, comma delimited with ".." and "-" permitted to denote a range. eg. 1,2,8,14..17,21-44
 .PP
 \fB--hide column\fP do not show the specified columns.  May be invoked multiple times, or with a comma-separated list of column names.  Use "--hide sysfs" to hide the sysfs statistics columns as a group.
 .PP
@@ -71,12 +71,8 @@ The file is truncated if it already exists, and it is created if it does not exi
 .PP
 \fB--Joules\fP displays energy in Joules, rather than dividing Joules by time to print power in Watts.
 .PP
-\fB--Package\fP limits output to the system summary plus the 1st thread in each Package.
-.PP
 \fB--list\fP display column header names available for use by --show and --hide, then exit.
 .PP
-\fB--processor\fP limits output to the system summary plus the 1st thread in each processor of each package.  Ie. it skips hyper-threaded siblings.
-.PP
 \fB--Summary\fP limits output to a 1-line System Summary for each interval.
 .PP
 \fB--TCC temperature\fP sets the Thermal Control Circuit temperature for systems which do not export that value.  This is used for making sense of the Digital Thermal Sensor outputs, as they return degrees Celsius below the TCC activation temperature.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 851eaf06f358..c005d9052679 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4153,7 +4153,8 @@ void help()
 	"to print statistics, until interrupted.\n"
 	"--add		add a counter\n"
 	"		eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
-	"--cpu	cpu-set	limit output to summary plus cpu-set cpu-set\n"
+	"--cpu	cpu-set	limit output to summary plus cpu-set:\n"
+	"		{core | package | j,k,l..m,n-p }\n"
 	"--quiet	skip decoding system configuration header\n"
 	"--interval sec	Override default 5-second measurement interval\n"
 	"--help		print this help message\n"
@@ -4756,6 +4757,21 @@ void parse_cpu_command(char *optarg)
 	unsigned int start, end;
 	char *next;
 
+	if (!strcmp(optarg, "core")) {
+		if (cpu_subset)
+			goto error;
+		show_core_only++;
+		return;
+	}
+	if (!strcmp(optarg, "package")) {
+		if (cpu_subset)
+			goto error;
+		show_pkg_only++;
+		return;
+	}
+	if (show_core_only || show_pkg_only)
+		goto error;
+
 	cpu_subset = CPU_ALLOC(CPU_SUBSET_MAXCPUS);
 	if (cpu_subset == NULL)
 		err(3, "CPU_ALLOC");
@@ -4813,7 +4829,8 @@ void parse_cpu_command(char *optarg)
 	return;
 
 error:
-	fprintf(stderr, "'--cpu %s' malformed\n", optarg);
+	fprintf(stderr, "\"--cpu %s\" malformed\n", optarg);
+	help();
 	exit(-1);
 }
 
@@ -4867,8 +4884,6 @@ void cmdline(int argc, char **argv)
 		{"Joules",	no_argument,		0, 'J'},
 		{"list",	no_argument,		0, 'l'},
 		{"out",		required_argument,	0, 'o'},
-		{"Package",	no_argument,		0, 'p'},
-		{"processor",	no_argument,		0, 'p'},
 		{"quiet",	no_argument,		0, 'q'},
 		{"show",	required_argument,	0, 's'},
 		{"Summary",	no_argument,		0, 'S'},
@@ -4879,7 +4894,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:PpqST:v",
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:o:qST:v",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
@@ -4925,12 +4940,6 @@ void cmdline(int argc, char **argv)
 		case 'o':
 			outf = fopen_or_die(optarg, "w");
 			break;
-		case 'P':
-			show_pkg_only++;
-			break;
-		case 'p':
-			show_core_only++;
-			break;
 		case 'q':
 			quiet = 1;
 			break;
-- 
2.11.0.161.g6610af872
