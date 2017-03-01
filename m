From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/44] tools/power turbostat: support "--hide C1" etc.
Date: Wed,  1 Mar 2017 00:27:43 -0500
Message-ID: <dd778a5e6bbd0f52f34c61ae9b42b725c5f22398.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33354 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdCAFfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Mar 2017 00:35:21 -0500
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Originally, the only way to hide the sysfs C-state statistics columns
was with "--hide sysfs".  This was because we process "--hide" before
we probe for those columns.

hack --hide to remember deferred hide requests, and apply
them when sysfs is probed.

"--hide sysfs" is still available as short-hand to refer to
the entire group of counters.

The down-side of this change is that we no longer error check for
bogus --hide column names.  But the user will quickly figure that
out if a column they mean to hide is still there...

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |   2 +-
 tools/power/x86/turbostat/turbostat.c | 115 +++++++++++++++++++++-------------
 2 files changed, 73 insertions(+), 44 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 5189d9d982fe..fedca3285326 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -114,7 +114,7 @@ This is ideal for remote debugging, use the "--out" option to save everything to
 .PP
 When you are not interested in all that information, and there are several ways to see only what you want.  First the "--quiet" option will skip the configuration information, and turbostat will show only the counter columns.  Second, you can reduce the columns with the "--hide" and "--show" options.  If you use the "--show" option, then turbostat will show only the columns you list.  If you use the "--hide" option, turbostat will show all columns, except the ones you list.
 .PP
-To find out what columns are available for --show and --hide, the "--list" option is available.  Note, however, there is an exception.  The C-state columns collected from sysfs "C1,C2,C3,C1%,C2%,C3%" are not built-in counters, but are discovered after --show and --hide are processed.  You can use the special counter name "sysfs" to refer to all of them at the same time.
+To find out what columns are available for --show and --hide, the "--list" option is available.  For convenience, the special strings "sysfs" can be used to refer to all of the sysfs C-state counters at once:
 .nf
 sudo ./turbostat --show sysfs --quiet sleep 10
 10.003837 sec
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index c005d9052679..596259f48f50 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -434,12 +434,45 @@ unsigned long long bic_present = BIC_sysfs;
 #define BIC_PRESENT(COUNTER_BIT) (bic_present |= COUNTER_BIT)
 #define BIC_NOT_PRESENT(COUNTER_BIT) (bic_present &= ~COUNTER_BIT)
 
+#define MAX_DEFERRED 16
+char *deferred_skip_names[MAX_DEFERRED];
+int deferred_skip_index;
+
+/*
+ * HIDE_LIST - hide this list of counters, show the rest [default]
+ * SHOW_LIST - show this list of counters, hide the rest
+ */
+enum show_hide_mode { SHOW_LIST, HIDE_LIST } global_show_hide_mode = HIDE_LIST;
+
+void help(void)
+{
+	fprintf(outf,
+	"Usage: turbostat [OPTIONS][(--interval seconds) | COMMAND ...]\n"
+	"\n"
+	"Turbostat forks the specified COMMAND and prints statistics\n"
+	"when COMMAND completes.\n"
+	"If no COMMAND is specified, turbostat wakes every 5-seconds\n"
+	"to print statistics, until interrupted.\n"
+	"--add		add a counter\n"
+	"		eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
+	"--cpu	cpu-set	limit output to summary plus cpu-set:\n"
+	"		{core | package | j,k,l..m,n-p }\n"
+	"--quiet	skip decoding system configuration header\n"
+	"--interval sec	Override default 5-second measurement interval\n"
+	"--help		print this help message\n"
+	"--list		list column headers only\n"
+	"--out file	create or truncate \"file\" for all output\n"
+	"--version	print version information\n"
+	"\n"
+	"For more help, run \"man turbostat\"\n");
+}
+
 /*
  * bic_lookup
  * for all the strings in comma separate name_list,
  * set the approprate bit in return value.
  */
-unsigned long long bic_lookup(char *name_list)
+unsigned long long bic_lookup(char *name_list, enum show_hide_mode mode)
 {
 	int i;
 	unsigned long long retval = 0;
@@ -459,8 +492,19 @@ unsigned long long bic_lookup(char *name_list)
 			}
 		}
 		if (i == MAX_BIC) {
-			fprintf(stderr, "Invalid counter name: %s\n", name_list);
-			exit(-1);
+			if (mode == SHOW_LIST) {
+				fprintf(stderr, "Invalid counter name: %s\n", name_list);
+				exit(-1);
+			}
+			deferred_skip_names[deferred_skip_index++] = name_list;
+			if (debug)
+				fprintf(stderr, "deferred \"%s\"\n", name_list);
+			if (deferred_skip_index >= MAX_DEFERRED) {
+				fprintf(stderr, "More than max %d un-recognized --skip options '%s'\n",
+					MAX_DEFERRED, name_list);
+				help();
+				exit(1);
+			}
 		}
 
 		name_list = comma;
@@ -471,6 +515,7 @@ unsigned long long bic_lookup(char *name_list)
 	return retval;
 }
 
+
 void print_header(char *delim)
 {
 	struct msr_counter *mp;
@@ -502,20 +547,17 @@ void print_header(char *delim)
 		outp += sprintf(outp, "%sSMI", (printed++ ? delim : ""));
 
 	for (mp = sys.tp; mp; mp = mp->next) {
-		if (*delim == ',') {
-			outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), "sysfs");
-			break;
-		}
+
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
-				outp += sprintf(outp, "%s%18.18s", delim, mp->name);
+				outp += sprintf(outp, "%s%18.18s", (printed++ ? delim : ""), mp->name);
 			else
-				outp += sprintf(outp, "%s%10.10s", delim, mp->name);
+				outp += sprintf(outp, "%s%10.10s", (printed++ ? delim : ""), mp->name);
 		} else {
 			if ((mp->type == COUNTER_ITEMS) && sums_need_wide_columns)
-				outp += sprintf(outp, "%s%8s", delim, mp->name);
+				outp += sprintf(outp, "%s%8s", (printed++ ? delim : ""), mp->name);
 			else
-				outp += sprintf(outp, "%s%s", delim, mp->name);
+				outp += sprintf(outp, "%s%s", (printed++ ? delim : ""), mp->name);
 		}
 	}
 
@@ -4142,29 +4184,6 @@ void process_cpuid()
 	return;
 }
 
-void help()
-{
-	fprintf(outf,
-	"Usage: turbostat [OPTIONS][(--interval seconds) | COMMAND ...]\n"
-	"\n"
-	"Turbostat forks the specified COMMAND and prints statistics\n"
-	"when COMMAND completes.\n"
-	"If no COMMAND is specified, turbostat wakes every 5-seconds\n"
-	"to print statistics, until interrupted.\n"
-	"--add		add a counter\n"
-	"		eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
-	"--cpu	cpu-set	limit output to summary plus cpu-set:\n"
-	"		{core | package | j,k,l..m,n-p }\n"
-	"--quiet	skip decoding system configuration header\n"
-	"--interval sec	Override default 5-second measurement interval\n"
-	"--help		print this help message\n"
-	"--list		list column headers only\n"
-	"--out file	create or truncate \"file\" for all output\n"
-	"--version	print version information\n"
-	"\n"
-	"For more help, run \"man turbostat\"\n");
-}
-
 
 /*
  * in /dev/cpu/ return success for names that are numbers
@@ -4689,6 +4708,16 @@ void parse_add_command(char *add_command)
 	}
 }
 
+int is_deferred_skip(char *name)
+{
+	int i;
+
+	for (i = 0; i < deferred_skip_index; ++i)
+		if (!strcmp(name, deferred_skip_names[i]))
+			return 1;
+	return 0;
+}
+
 void probe_sysfs(void)
 {
 	char path[64];
@@ -4720,6 +4749,9 @@ void probe_sysfs(void)
 
 		sprintf(path, "cpuidle/state%d/time", state);
 
+		if (is_deferred_skip(name_buf))
+			continue;
+
 		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_USEC,
 				FORMAT_PERCENT, SYSFS_PERCPU);
 	}
@@ -4741,6 +4773,9 @@ void probe_sysfs(void)
 
 		sprintf(path, "cpuidle/state%d/usage", state);
 
+		if (is_deferred_skip(name_buf))
+			continue;
+
 		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS,
 				FORMAT_DELTA, SYSFS_PERCPU);
 	}
@@ -4834,12 +4869,6 @@ void parse_cpu_command(char *optarg)
 	exit(-1);
 }
 
-/*
- * HIDE_LIST - hide this list of counters, show the rest [default]
- * SHOW_LIST - show this list of counters, hide the rest
- */
-enum show_hide_mode { SHOW_LIST, HIDE_LIST } global_show_hide_mode = HIDE_LIST;
-
 int shown;
 /*
  * parse_show_hide() - process cmdline to set default counter action
@@ -4853,9 +4882,9 @@ void parse_show_hide(char *optarg, enum show_hide_mode new_mode)
 	 */
 	if (new_mode == SHOW_LIST) {
 		if (shown == 0)
-			bic_enabled = bic_lookup(optarg);
+			bic_enabled = bic_lookup(optarg, new_mode);
 		else
-			bic_enabled |= bic_lookup(optarg);
+			bic_enabled |= bic_lookup(optarg, new_mode);
 		shown = 1;
 
 		return;
@@ -4865,7 +4894,7 @@ void parse_show_hide(char *optarg, enum show_hide_mode new_mode)
 	 * --hide: do not show those specified
 	 *  multiple invocations simply clear more bits in enabled mask
 	 */
-	bic_enabled &= ~bic_lookup(optarg);
+	bic_enabled &= ~bic_lookup(optarg, new_mode);
 
 }
 
-- 
2.11.0.161.g6610af872
