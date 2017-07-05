From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 3/3] pm-graph: package makefile and man pages
Date: Wed,  5 Jul 2017 14:42:57 -0700
Message-ID: <6854af352268d1d3ab3ad60e2ca7fc5d01bcc74e.1499290431.git.todd.e.brandt@linux.intel.com>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58554 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752086AbdGEVnE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jul 2017 17:43:04 -0400
In-Reply-To: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

update help text and man pages for both tools
- added more examples and separated them by category
Makefile upgrades
- uninstall: remove errors from uninstall if tool not found
- install: perform uninstall before install

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/Makefile     | 19 +++++++-----
 tools/power/pm-graph/bootgraph.8  | 61 +++++++++++++++++++++++++++++----------
 tools/power/pm-graph/sleepgraph.8 | 48 ++++++++++++++++++------------
 3 files changed, 86 insertions(+), 42 deletions(-)

diff --git a/tools/power/pm-graph/Makefile b/tools/power/pm-graph/Makefile
index 4d0ccc89e6c6..32f40eacdafe 100644
--- a/tools/power/pm-graph/Makefile
+++ b/tools/power/pm-graph/Makefile
@@ -4,7 +4,7 @@ DESTDIR		?=
 all:
 	@echo "Nothing to build"
 
-install :
+install : uninstall
 	install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph
 	install analyze_suspend.py $(DESTDIR)$(PREFIX)/lib/pm-graph
 	install analyze_boot.py $(DESTDIR)$(PREFIX)/lib/pm-graph
@@ -17,12 +17,15 @@ install :
 	install sleepgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
 
 uninstall :
-	rm $(DESTDIR)$(PREFIX)/share/man/man8/bootgraph.8
-	rm $(DESTDIR)$(PREFIX)/share/man/man8/sleepgraph.8
+	rm -f $(DESTDIR)$(PREFIX)/share/man/man8/bootgraph.8
+	rm -f $(DESTDIR)$(PREFIX)/share/man/man8/sleepgraph.8
 
-	rm $(DESTDIR)$(PREFIX)/bin/bootgraph
-	rm $(DESTDIR)$(PREFIX)/bin/sleepgraph
+	rm -f $(DESTDIR)$(PREFIX)/bin/bootgraph
+	rm -f $(DESTDIR)$(PREFIX)/bin/sleepgraph
 
-	rm $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_boot.py
-	rm $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_suspend.py
-	rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph
+	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_boot.py
+	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_suspend.py
+	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/*.pyc
+	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph ] ; then \
+		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph; \
+	fi;
diff --git a/tools/power/pm-graph/bootgraph.8 b/tools/power/pm-graph/bootgraph.8
index 55272a67b0e7..dbdafcf546df 100644
--- a/tools/power/pm-graph/bootgraph.8
+++ b/tools/power/pm-graph/bootgraph.8
@@ -8,14 +8,23 @@ bootgraph \- Kernel boot timing analysis
 .RB [ COMMAND ]
 .SH DESCRIPTION
 \fBbootgraph \fP reads the dmesg log from kernel boot and
-creates an html representation of the initcall timeline up to the start
-of the init process.
+creates an html representation of the initcall timeline. It graphs
+every module init call found, through both kernel and user modes. The
+timeline is split into two phases: kernel mode & user mode. kernel mode
+represents a single process run on a single cpu with serial init calls.
+Once user mode begins, the init process is called, and the init calls
+start working in parallel.
 .PP
 If no specific command is given, the tool reads the current dmesg log and
-outputs bootgraph.html.
+outputs a new timeline.
 .PP
 The tool can also augment the timeline with ftrace data on custom target
 functions as well as full trace callgraphs.
+.PP
+Generates output files in subdirectory: boot-yymmdd-HHMMSS
+   html timeline   :     <hostname>_boot.html
+   raw dmesg file  :     <hostname>_boot_dmesg.txt
+   raw ftrace file :     <hostname>_boot_ftrace.txt
 .SH OPTIONS
 .TP
 \fB-h\fR
@@ -28,15 +37,18 @@ Print the current tool version
 Add the dmesg log to the html output. It will be viewable by
 clicking a button in the timeline.
 .TP
-\fB-o \fIfile\fR
-Override the HTML output filename (default: bootgraph.html)
-.SS "Ftrace Debug"
+\fB-o \fIname\fR
+Overrides the output subdirectory name when running a new test.
+Use {date}, {time}, {hostname} for current values.
+.sp
+e.g. boot-{hostname}-{date}-{time}
+.SS "advanced"
 .TP
 \fB-f\fR
 Use ftrace to add function detail (default: disabled)
 .TP
 \fB-callgraph\fR
-Use ftrace to create initcall callgraphs (default: disabled). If -filter
+Use ftrace to create initcall callgraphs (default: disabled). If -func
 is not used there will be one callgraph per initcall. This can produce
 very large outputs, i.e. 10MB - 100MB.
 .TP
@@ -50,16 +62,19 @@ This reduces the html file size as there can be many tiny callgraphs
 which are barely visible in the timeline.
 The value is a float: e.g. 0.001 represents 1 us.
 .TP
+\fB-cgfilter \fI"func1,func2,..."\fR
+Reduce callgraph output in the timeline by limiting it to a list of calls. The
+argument can be a single function name or a comma delimited list.
+(default: none)
+.TP
 \fB-timeprec \fIn\fR
 Number of significant digits in timestamps (0:S, 3:ms, [6:us])
 .TP
 \fB-expandcg\fR
 pre-expand the callgraph data in the html output (default: disabled)
 .TP
-\fB-filter \fI"func1,func2,..."\fR
+\fB-func \fI"func1,func2,..."\fR
 Instead of tracing each initcall, trace a custom list of functions (default: do_one_initcall)
-
-.SH COMMANDS
 .TP
 \fB-reboot\fR
 Reboot the machine and generate a new timeline automatically. Works in 4 steps.
@@ -73,16 +88,23 @@ Show the requirements to generate a new timeline manually. Requires 3 steps.
   1. append the string to the kernel command line via your native boot manager.
   2. reboot the system
   3. after startup, re-run the tool with the same arguments and no command
+
+.SH COMMANDS
+.SS "rebuild"
 .TP
 \fB-dmesg \fIfile\fR
 Create HTML output from an existing dmesg file.
 .TP
 \fB-ftrace \fIfile\fR
 Create HTML output from an existing ftrace file (used with -dmesg).
+.SS "other"
 .TP
 \fB-flistall\fR
 Print all ftrace functions capable of being captured. These are all the
-possible values you can add to trace via the -filter argument.
+possible values you can add to trace via the -func argument.
+.TP
+\fB-sysinfo\fR
+Print out system info extracted from BIOS. Reads /dev/mem directly instead of going through dmidecode.
 
 .SH EXAMPLES
 Create a timeline using the current dmesg log.
@@ -93,13 +115,13 @@ Create a timeline using the current dmesg and ftrace log.
 .IP
 \f(CW$ bootgraph -callgraph\fR
 .PP
-Create a timeline using the current dmesg, add the log to the html and change the name.
+Create a timeline using the current dmesg, add the log to the html and change the folder.
 .IP
-\f(CW$ bootgraph -addlogs -o myboot.html\fR
+\f(CW$ bootgraph -addlogs -o "myboot-{date}-{time}"\fR
 .PP
 Capture a new boot timeline by automatically rebooting the machine.
 .IP
-\f(CW$ sudo bootgraph -reboot -addlogs -o latestboot.html\fR
+\f(CW$ sudo bootgraph -reboot -addlogs -o "latest-{hostname)"\fR
 .PP
 Capture a new boot timeline with function trace data.
 .IP
@@ -111,7 +133,7 @@ Capture a new boot timeline with trace & callgraph data. Skip callgraphs smaller
 .PP
 Capture a new boot timeline with callgraph data over custom functions.
 .IP
-\f(CW$ sudo bootgraph -reboot -callgraph -filter "acpi_ps_parse_aml,msleep"\fR
+\f(CW$ sudo bootgraph -reboot -callgraph -func "acpi_ps_parse_aml,msleep"\fR
 .PP
 Capture a brand new boot timeline with manual reboot.
 .IP
@@ -123,6 +145,15 @@ Capture a brand new boot timeline with manual reboot.
 .IP
 \f(CW$ sudo bootgraph -callgraph # re-run the tool after restart\fR
 .PP
+.SS "rebuild timeline from logs"
+.PP
+Rebuild the html from a previous run's logs, using the same options.
+.IP
+\f(CW$ bootgraph -dmesg dmesg.txt -ftrace ftrace.txt -callgraph\fR
+.PP
+Rebuild the html with different options.
+.IP
+\f(CW$ bootgraph -dmesg dmesg.txt -ftrace ftrace.txt -addlogs\fR
 
 .SH "SEE ALSO"
 dmesg(1), update-grub(8), crontab(1), reboot(8)
diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index 610e72ebbc06..fbe7bd3eae8e 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -39,8 +39,9 @@ Pull arguments and config options from a file.
 \fB-m \fImode\fR
 Mode to initiate for suspend e.g. standby, freeze, mem (default: mem).
 .TP
-\fB-o \fIsubdir\fR
-Override the output subdirectory. Use {date}, {time}, {hostname} for current values.
+\fB-o \fIname\fR
+Overrides the output subdirectory name when running a new test.
+Use {date}, {time}, {hostname} for current values.
 .sp
 e.g. suspend-{hostname}-{date}-{time}
 .TP
@@ -52,7 +53,7 @@ disable rtcwake and require a user keypress to resume.
 Add the dmesg and ftrace logs to the html output. They will be viewable by
 clicking buttons in the timeline.
 
-.SS "Advanced"
+.SS "advanced"
 .TP
 \fB-cmd \fIstr\fR
 Run the timeline over a custom suspend command, e.g. pm-suspend. By default
@@ -91,7 +92,7 @@ Include \fIt\fR ms delay after last resume (default: 0 ms).
 Execute \fIn\fR consecutive tests at \fId\fR seconds intervals. The outputs will
 be created in a new subdirectory with a summary page: suspend-xN-{date}-{time}.
 
-.SS "Ftrace Debug"
+.SS "ftrace debug"
 .TP
 \fB-f\fR
 Use ftrace to create device callgraphs (default: disabled). This can produce
@@ -124,12 +125,6 @@ Number of significant digits in timestamps (0:S, [3:ms], 6:us).
 
 .SH COMMANDS
 .TP
-\fB-ftrace \fIfile\fR
-Create HTML output from an existing ftrace file.
-.TP
-\fB-dmesg \fIfile\fR
-Create HTML output from an existing dmesg file.
-.TP
 \fB-summary \fIindir\fR
 Create a summary page of all tests in \fIindir\fR. Creates summary.html
 in the current folder. The output page is a table of tests with
@@ -146,6 +141,9 @@ with any options you intend to use to see if they will work.
 \fB-fpdt\fR
 Print out the contents of the ACPI Firmware Performance Data Table.
 .TP
+\fB-sysinfo\fR
+Print out system info extracted from BIOS. Reads /dev/mem directly instead of going through dmidecode.
+.TP
 \fB-usbtopo\fR
 Print out the current USB topology with power info.
 .TP
@@ -162,9 +160,16 @@ with -fadd they will also be checked.
 \fB-flistall\fR
 Print all ftrace functions capable of being captured. These are all the
 possible values you can add to trace via the -fadd argument.
+.SS "rebuild"
+.TP
+\fB-ftrace \fIfile\fR
+Create HTML output from an existing ftrace file.
+.TP
+\fB-dmesg \fIfile\fR
+Create HTML output from an existing dmesg file.
 
 .SH EXAMPLES
-.SS "Simple Commands"
+.SS "simple commands"
 Check which suspend modes are currently supported.
 .IP
 \f(CW$ sleepgraph -modes\fR
@@ -185,12 +190,8 @@ Generate a summary of all timelines in a particular folder.
 .IP
 \f(CW$ sleepgraph -summary ~/workspace/myresults/\fR
 .PP
-Re-generate the html output from a previous run's dmesg and ftrace log.
-.IP
-\f(CW$ sleepgraph -dmesg myhost_mem_dmesg.txt -ftrace myhost_mem_ftrace.txt\fR
-.PP
 
-.SS "Capturing Simple Timelines"
+.SS "capturing basic timelines"
 Execute a mem suspend with a 15 second wakeup. Include the logs in the html.
 .IP
 \f(CW$ sudo sleepgraph -rtcwake 15 -addlogs\fR
@@ -204,7 +205,7 @@ Execute a freeze with no wakeup (require keypress). Change output folder name.
 \f(CW$ sudo sleepgraph -m freeze -rtcwake off -o "freeze-{hostname}-{date}-{time}"\fR
 .PP
 
-.SS "Capturing Advanced Timelines"
+.SS "capturing advanced timelines"
 Execute a suspend & include dev mode source calls, limit callbacks to 5ms or larger.
 .IP
 \f(CW$ sudo sleepgraph -m mem -rtcwake 15 -dev -mindev 5\fR
@@ -222,8 +223,7 @@ Execute a suspend using a custom command.
 \f(CW$ sudo sleepgraph -cmd "echo mem > /sys/power/state" -rtcwake 15\fR
 .PP
 
-
-.SS "Capturing Timelines with Callgraph Data"
+.SS "adding callgraph data"
 Add device callgraphs. Limit the trace depth and only show callgraphs 10ms or larger.
 .IP
 \f(CW$ sudo sleepgraph -m mem -rtcwake 15 -f -maxdepth 5 -mincg 10\fR
@@ -235,6 +235,16 @@ Capture a full callgraph across all suspend, then filter the html by a single ph
 \f(CW$ sleepgraph -dmesg host_mem_dmesg.txt -ftrace host_mem_ftrace.txt -f -cgphase resume
 .PP
 
+.SS "rebuild timeline from logs"
+.PP
+Rebuild the html from a previous run's logs, using the same options.
+.IP
+\f(CW$ sleepgraph -dmesg dmesg.txt -ftrace ftrace.txt -callgraph\fR
+.PP
+Rebuild the html with different options.
+.IP
+\f(CW$ sleepgraph -dmesg dmesg.txt -ftrace ftrace.txt -addlogs -srgap\fR
+
 .SH "SEE ALSO"
 dmesg(1)
 .PP
-- 
2.11.0
