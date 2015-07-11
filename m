From: Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH] tools/power turbostat: fix parameter passing for forked command
Date: Sat, 11 Jul 2015 10:02:21 +0800
Message-ID: <1436580141-26507-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:42221 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751809AbbGKGZH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 11 Jul 2015 02:25:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: len.brown@intel.com, rafael.j.wysocki@intel.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

turbostat supports forked command when sampling cpu state. However,
the forked command is not allowed to be executed with options, otherwise
turbostat might regard these options as invalid turbostat options.
For example:

./turbostat stress -c 4 -t 10
./turbostat: unrecognized option '-t'

This patch adds -e option for turbostat, followed by a command
string quoted by " or ':
./turbostat -e "stress -c 4 -t 10"
stress: info: [26429] dispatching hogs: 4 cpu, 0 io, 0 vm, 0 hdd
stress: info: [26429] successful run completed in 10s
     CPU Avg_MHz   %Busy Bzy_MHz TSC_MHz
       -    1688   50.06    3372    3392
       0       9    0.28    3370    3392
       4    3369   99.92    3372    3392
       1    2853   84.10    3392    3392
       5       1    0.03    2818    3392
       2     516   15.77    3270    3392
       6    3370   99.95    3371    3392
       3      19    0.56    3382    3392
       7    3369   99.89    3372    3392
10.002188 sec

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 57 +++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 323b65e..6eb5f65 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -71,6 +71,7 @@ unsigned int extra_msr_offset32;
 unsigned int extra_msr_offset64;
 unsigned int extra_delta_offset32;
 unsigned int extra_delta_offset64;
+unsigned int command_need_fork;
 int do_smi;
 double bclk;
 unsigned int show_pkg;
@@ -124,10 +125,51 @@ int base_cpu;
 
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
 
+#define MAX_COMMAND_PARAM_NUM		20
+#define MAX_COMMAND_LEN			50
 int aperf_mperf_unstable;
 int backwards_count;
 char *progname;
 
+char command_to_fork_string[MAX_COMMAND_LEN];
+char *command_to_fork_argv[MAX_COMMAND_PARAM_NUM];
+
+int convert_string_to_argv(void)
+{
+	int i = 0;
+	char *cur_pointer = command_to_fork_string;
+	char *copy_string = NULL;
+	/*trim space ahead*/
+	while (isspace(*cur_pointer))
+		*cur_pointer++ = '\0';
+	/*start parsing*/
+	copy_string = cur_pointer;
+	/*no available command*/
+	if (*cur_pointer == '\0')
+		return -EINVAL;
+	while (*cur_pointer != '\0') {
+		if (isspace(*cur_pointer)) {
+			/*
+			 * save to argv[i]. The last argv[i] for
+			 * execvp must be NULL, so the max valid
+			 * index is MAX_COMMAND_PARAM_NUM-2.
+			 */
+			*cur_pointer++ = '\0';
+			if (i > (MAX_COMMAND_PARAM_NUM-2))
+				return -EINVAL;
+			command_to_fork_argv[i++] = copy_string;
+			while (isspace(*cur_pointer))
+				cur_pointer++;
+			copy_string = cur_pointer;
+		} else
+			cur_pointer++;
+	}
+	command_to_fork_argv[i++] = copy_string;
+	/*the last parameter for execvp must be NULL*/
+	command_to_fork_argv[i] = NULL;
+	return 0;
+}
+
 cpu_set_t *cpu_present_set, *cpu_affinity_set;
 size_t cpu_present_setsize, cpu_affinity_setsize;
 
@@ -2699,6 +2741,7 @@ void help()
 	"If no COMMAND is specified, turbostat wakes every 5-seconds\n"
 	"to print statistics, until interrupted.\n"
 	"--debug	run in \"debug\" mode\n"
+	"--execute	forks COMMAND for executing, COMMAND must be quoted by \" or \'\n"
 	"--interval sec	Override default 5-second measurement interval\n"
 	"--help		print this help message\n"
 	"--counter msr	print 32-bit counter at address \"msr\"\n"
@@ -3022,6 +3065,7 @@ void cmdline(int argc, char **argv)
 {
 	int opt;
 	int option_index = 0;
+	command_need_fork = 0;
 	static struct option long_options[] = {
 		{"Counter",	required_argument,	0, 'C'},
 		{"counter",	required_argument,	0, 'c'},
@@ -3036,6 +3080,7 @@ void cmdline(int argc, char **argv)
 		{"processor",	no_argument,		0, 'p'},
 		{"Summary",	no_argument,		0, 'S'},
 		{"TCC",		required_argument,	0, 'T'},
+		{"execute",	required_argument,	0, 'e'},
 		{"version",	no_argument,		0, 'v' },
 		{0,		0,			0,  0 }
 	};
@@ -3057,6 +3102,14 @@ void cmdline(int argc, char **argv)
 		case 'd':
 			debug++;
 			break;
+		case 'e':
+			if (strlen(optarg) < MAX_COMMAND_LEN) {
+				strcpy(command_to_fork_string, optarg);
+				if (!convert_string_to_argv()) {
+					command_need_fork = 1;
+					break;
+				}
+			};
 		case 'h':
 		default:
 			help();
@@ -3109,8 +3162,8 @@ int main(int argc, char **argv)
 	/*
 	 * if any params left, it must be a command to fork
 	 */
-	if (argc - optind)
-		return fork_it(argv + optind);
+	if (command_need_fork)
+		return fork_it((char **)command_to_fork_argv);
 	else
 		turbostat_loop();
 
-- 
1.9.1

