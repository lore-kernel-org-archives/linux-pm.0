From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 3/3] pm-graph: package makefile and man pages
Date: Fri,  7 Apr 2017 11:05:37 -0700
Message-ID: <1bdac35722e86a8cb8dc7a71e52d5c1f35bebddd.1491587995.git.todd.e.brandt@linux.intel.com>
References: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41937 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932863AbdDGSFn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 14:05:43 -0400
In-Reply-To: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
References: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: arjan@linux.intel.com, len.brown@intel.com, todd.e.brandt@intel.com, todd.e.brandt@linux.intel.com

BootGraph and SleepGraph man pages
- includes full descriptions of tool arguments and commands
- includes examples of common use cases
Makefile
- no build required, used only for install
- installs man pages and tools as libraries with links
- includes an uninstall

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/Makefile     |  28 +++++
 tools/power/pm-graph/bootgraph.8  | 132 +++++++++++++++++++++
 tools/power/pm-graph/sleepgraph.8 | 243 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 403 insertions(+)
 create mode 100644 tools/power/pm-graph/Makefile
 create mode 100644 tools/power/pm-graph/bootgraph.8
 create mode 100644 tools/power/pm-graph/sleepgraph.8

diff --git a/tools/power/pm-graph/Makefile b/tools/power/pm-graph/Makefile
new file mode 100644
index 0000000..4d0ccc8
--- /dev/null
+++ b/tools/power/pm-graph/Makefile
@@ -0,0 +1,28 @@
+PREFIX		?= /usr
+DESTDIR		?=
+
+all:
+	@echo "Nothing to build"
+
+install :
+	install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph
+	install analyze_suspend.py $(DESTDIR)$(PREFIX)/lib/pm-graph
+	install analyze_boot.py $(DESTDIR)$(PREFIX)/lib/pm-graph
+
+	ln -s $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_boot.py $(DESTDIR)$(PREFIX)/bin/bootgraph
+	ln -s $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_suspend.py $(DESTDIR)$(PREFIX)/bin/sleepgraph
+
+	install -d  $(DESTDIR)$(PREFIX)/share/man/man8
+	install bootgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
+	install sleepgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
+
+uninstall :
+	rm $(DESTDIR)$(PREFIX)/share/man/man8/bootgraph.8
+	rm $(DESTDIR)$(PREFIX)/share/man/man8/sleepgraph.8
+
+	rm $(DESTDIR)$(PREFIX)/bin/bootgraph
+	rm $(DESTDIR)$(PREFIX)/bin/sleepgraph
+
+	rm $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_boot.py
+	rm $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_suspend.py
+	rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph
diff --git a/tools/power/pm-graph/bootgraph.8 b/tools/power/pm-graph/bootgraph.8
new file mode 100644
index 0000000..55272a6
--- /dev/null
+++ b/tools/power/pm-graph/bootgraph.8
@@ -0,0 +1,132 @@
+.TH BOOTGRAPH 8
+.SH NAME
+bootgraph \- Kernel boot timing analysis
+.SH SYNOPSIS
+.ft B
+.B bootgraph
+.RB [ OPTIONS ]
+.RB [ COMMAND ]
+.SH DESCRIPTION
+\fBbootgraph \fP reads the dmesg log from kernel boot and
+creates an html representation of the initcall timeline up to the start
+of the init process.
+.PP
+If no specific command is given, the tool reads the current dmesg log and
+outputs bootgraph.html.
+.PP
+The tool can also augment the timeline with ftrace data on custom target
+functions as well as full trace callgraphs.
+.SH OPTIONS
+.TP
+\fB-h\fR
+Print this help text
+.TP
+\fB-v\fR
+Print the current tool version
+.TP
+\fB-addlogs\fR
+Add the dmesg log to the html output. It will be viewable by
+clicking a button in the timeline.
+.TP
+\fB-o \fIfile\fR
+Override the HTML output filename (default: bootgraph.html)
+.SS "Ftrace Debug"
+.TP
+\fB-f\fR
+Use ftrace to add function detail (default: disabled)
+.TP
+\fB-callgraph\fR
+Use ftrace to create initcall callgraphs (default: disabled). If -filter
+is not used there will be one callgraph per initcall. This can produce
+very large outputs, i.e. 10MB - 100MB.
+.TP
+\fB-maxdepth \fIlevel\fR
+limit the callgraph trace depth to \fIlevel\fR (default: 2). This is
+the best way to limit the output size when using -callgraph.
+.TP
+\fB-mincg \fIt\fR
+Discard all callgraphs shorter than \fIt\fR milliseconds (default: 0=all).
+This reduces the html file size as there can be many tiny callgraphs
+which are barely visible in the timeline.
+The value is a float: e.g. 0.001 represents 1 us.
+.TP
+\fB-timeprec \fIn\fR
+Number of significant digits in timestamps (0:S, 3:ms, [6:us])
+.TP
+\fB-expandcg\fR
+pre-expand the callgraph data in the html output (default: disabled)
+.TP
+\fB-filter \fI"func1,func2,..."\fR
+Instead of tracing each initcall, trace a custom list of functions (default: do_one_initcall)
+
+.SH COMMANDS
+.TP
+\fB-reboot\fR
+Reboot the machine and generate a new timeline automatically. Works in 4 steps.
+  1. updates grub with the required kernel parameters
+  2. installs a cron job which re-runs the tool after reboot
+  3. reboots the system
+  4. after startup, extracts the data and generates the timeline
+.TP
+\fB-manual\fR
+Show the requirements to generate a new timeline manually. Requires 3 steps.
+  1. append the string to the kernel command line via your native boot manager.
+  2. reboot the system
+  3. after startup, re-run the tool with the same arguments and no command
+.TP
+\fB-dmesg \fIfile\fR
+Create HTML output from an existing dmesg file.
+.TP
+\fB-ftrace \fIfile\fR
+Create HTML output from an existing ftrace file (used with -dmesg).
+.TP
+\fB-flistall\fR
+Print all ftrace functions capable of being captured. These are all the
+possible values you can add to trace via the -filter argument.
+
+.SH EXAMPLES
+Create a timeline using the current dmesg log.
+.IP
+\f(CW$ bootgraph\fR
+.PP
+Create a timeline using the current dmesg and ftrace log.
+.IP
+\f(CW$ bootgraph -callgraph\fR
+.PP
+Create a timeline using the current dmesg, add the log to the html and change the name.
+.IP
+\f(CW$ bootgraph -addlogs -o myboot.html\fR
+.PP
+Capture a new boot timeline by automatically rebooting the machine.
+.IP
+\f(CW$ sudo bootgraph -reboot -addlogs -o latestboot.html\fR
+.PP
+Capture a new boot timeline with function trace data.
+.IP
+\f(CW$ sudo bootgraph -reboot -f\fR
+.PP
+Capture a new boot timeline with trace & callgraph data. Skip callgraphs smaller than 5ms.
+.IP
+\f(CW$ sudo bootgraph -reboot -callgraph -mincg 5\fR
+.PP
+Capture a new boot timeline with callgraph data over custom functions.
+.IP
+\f(CW$ sudo bootgraph -reboot -callgraph -filter "acpi_ps_parse_aml,msleep"\fR
+.PP
+Capture a brand new boot timeline with manual reboot.
+.IP
+\f(CW$ sudo bootgraph -callgraph -manual\fR
+.IP
+\f(CW$ vi /etc/default/grub      # add the CMDLINE string to your kernel params\fR
+.IP
+\f(CW$ sudo reboot               # reboot the machine\fR
+.IP
+\f(CW$ sudo bootgraph -callgraph # re-run the tool after restart\fR
+.PP
+
+.SH "SEE ALSO"
+dmesg(1), update-grub(8), crontab(1), reboot(8)
+.PP
+.SH AUTHOR
+.nf
+Written by Todd Brandt <todd.e.brandt@linux.intel.com>
diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
new file mode 100644
index 0000000..610e72e
--- /dev/null
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -0,0 +1,243 @@
+.TH SLEEPGRAPH 8
+.SH NAME
+sleepgraph \- Suspend/Resume timing analysis
+.SH SYNOPSIS
+.ft B
+.B sleepgraph
+.RB [ OPTIONS ]
+.RB [ COMMAND ]
+.SH DESCRIPTION
+\fBsleepgraph \fP is designed to assist kernel and OS developers
+in optimizing their linux stack's suspend/resume time. Using a kernel
+image built with a few extra options enabled, the tool will execute a
+suspend and capture dmesg and ftrace data until resume is complete.
+This data is transformed into a device timeline and an optional
+callgraph to give a detailed view of which devices/subsystems are
+taking the most time in suspend/resume.
+.PP
+If no specific command is given, the default behavior is to initiate
+a suspend/resume.
+.PP
+Generates output files in subdirectory: suspend-yymmdd-HHMMSS
+   html timeline   :     <hostname>_<mode>.html
+   raw dmesg file  :     <hostname>_<mode>_dmesg.txt
+   raw ftrace file :     <hostname>_<mode>_ftrace.txt
+.SH OPTIONS
+.TP
+\fB-h\fR
+Print the help text.
+.TP
+\fB-v\fR
+Print the current tool version.
+.TP
+\fB-verbose\fR
+Print extra information during execution and analysis.
+.TP
+\fB-config \fIfile\fR
+Pull arguments and config options from a file.
+.TP
+\fB-m \fImode\fR
+Mode to initiate for suspend e.g. standby, freeze, mem (default: mem).
+.TP
+\fB-o \fIsubdir\fR
+Override the output subdirectory. Use {date}, {time}, {hostname} for current values.
+.sp
+e.g. suspend-{hostname}-{date}-{time}
+.TP
+\fB-rtcwake \fIt\fR | off
+Use rtcwake to autoresume after \fIt\fR seconds (default: 15). Set t to "off" to
+disable rtcwake and require a user keypress to resume.
+.TP
+\fB-addlogs\fR
+Add the dmesg and ftrace logs to the html output. They will be viewable by
+clicking buttons in the timeline.
+
+.SS "Advanced"
+.TP
+\fB-cmd \fIstr\fR
+Run the timeline over a custom suspend command, e.g. pm-suspend. By default
+the tool forces suspend via /sys/power/state so this allows testing over
+an OS's official suspend method. The output file will change to
+hostname_command.html and will autodetect which suspend mode was triggered.
+.TP
+\fB-filter \fI"d1,d2,..."\fR
+Filter out all but these device callbacks. These strings can be device names
+or module names. e.g. 0000:00:02.0, ata5, i915, usb, etc.
+.TP
+\fB-mindev \fIt\fR
+Discard all device callbacks shorter than \fIt\fR milliseconds (default: 0.0).
+This reduces the html file size as there can be many tiny callbacks which are barely
+visible. The value is a float: e.g. 0.001 represents 1 us.
+.TP
+\fB-proc\fR
+Add usermode process info into the timeline (default: disabled).
+.TP
+\fB-dev\fR
+Add kernel source calls and threads to the timeline (default: disabled).
+.TP
+\fB-x2\fR
+Run two suspend/resumes back to back (default: disabled).
+.TP
+\fB-x2delay \fIt\fR
+Include \fIt\fR ms delay between multiple test runs (default: 0 ms).
+.TP
+\fB-predelay \fIt\fR
+Include \fIt\fR ms delay before 1st suspend (default: 0 ms).
+.TP
+\fB-postdelay \fIt\fR
+Include \fIt\fR ms delay after last resume (default: 0 ms).
+.TP
+\fB-multi \fIn d\fR
+Execute \fIn\fR consecutive tests at \fId\fR seconds intervals. The outputs will
+be created in a new subdirectory with a summary page: suspend-xN-{date}-{time}.
+
+.SS "Ftrace Debug"
+.TP
+\fB-f\fR
+Use ftrace to create device callgraphs (default: disabled). This can produce
+very large outputs, i.e. 10MB - 100MB.
+.TP
+\fB-maxdepth \fIlevel\fR
+limit the callgraph trace depth to \fIlevel\fR (default: 0=all). This is
+the best way to limit the output size when using callgraphs via -f.
+.TP
+\fB-expandcg\fR
+pre-expand the callgraph data in the html output (default: disabled)
+.TP
+\fB-fadd \fIfile\fR
+Add functions to be graphed in the timeline from a list in a text file
+.TP
+\fB-mincg \fIt\fR
+Discard all callgraphs shorter than \fIt\fR milliseconds (default: 0.0).
+This reduces the html file size as there can be many tiny callgraphs
+which are barely visible in the timeline.
+The value is a float: e.g. 0.001 represents 1 us.
+.TP
+\fB-cgphase \fIp\fR
+Only show callgraph data for phase \fIp\fR (e.g. suspend_late).
+.TP
+\fB-cgtest \fIn\fR
+In an x2 run, only show callgraph data for test \fIn\fR (e.g. 0 or 1).
+.TP
+\fB-timeprec \fIn\fR
+Number of significant digits in timestamps (0:S, [3:ms], 6:us).
+
+.SH COMMANDS
+.TP
+\fB-ftrace \fIfile\fR
+Create HTML output from an existing ftrace file.
+.TP
+\fB-dmesg \fIfile\fR
+Create HTML output from an existing dmesg file.
+.TP
+\fB-summary \fIindir\fR
+Create a summary page of all tests in \fIindir\fR. Creates summary.html
+in the current folder. The output page is a table of tests with
+suspend and resume values sorted by suspend mode, host, and kernel.
+Includes test averages by mode and links to the test html files.
+.TP
+\fB-modes\fR
+List available suspend modes.
+.TP
+\fB-status\fR
+Test to see if the system is able to run this tool. Use this along
+with any options you intend to use to see if they will work.
+.TP
+\fB-fpdt\fR
+Print out the contents of the ACPI Firmware Performance Data Table.
+.TP
+\fB-usbtopo\fR
+Print out the current USB topology with power info.
+.TP
+\fB-usbauto\fR
+Enable autosuspend for all connected USB devices.
+.TP
+\fB-flist\fR
+Print the list of ftrace functions currently being captured. Functions
+that are not available as symbols in the current kernel are shown in red.
+By default, the tool traces a list of important suspend/resume functions
+in order to better fill out the timeline. If the user has added their own
+with -fadd they will also be checked.
+.TP
+\fB-flistall\fR
+Print all ftrace functions capable of being captured. These are all the
+possible values you can add to trace via the -fadd argument.
+
+.SH EXAMPLES
+.SS "Simple Commands"
+Check which suspend modes are currently supported.
+.IP
+\f(CW$ sleepgraph -modes\fR
+.PP
+Read the Firmware Performance Data Table (FPDT)
+.IP
+\f(CW$ sudo sleepgraph -fpdt\fR
+.PP
+Print out the current USB power topology
+.IP
+\f(CW$ sleepgraph -usbtopo
+.PP
+Verify that you can run a command with a set of arguments
+.IP
+\f(CW$ sudo sleepgraph -f -rtcwake 30 -status
+.PP
+Generate a summary of all timelines in a particular folder.
+.IP
+\f(CW$ sleepgraph -summary ~/workspace/myresults/\fR
+.PP
+Re-generate the html output from a previous run's dmesg and ftrace log.
+.IP
+\f(CW$ sleepgraph -dmesg myhost_mem_dmesg.txt -ftrace myhost_mem_ftrace.txt\fR
+.PP
+
+.SS "Capturing Simple Timelines"
+Execute a mem suspend with a 15 second wakeup. Include the logs in the html.
+.IP
+\f(CW$ sudo sleepgraph -rtcwake 15 -addlogs\fR
+.PP
+Execute a standby with a 15 second wakeup. Change the output folder name.
+.IP
+\f(CW$ sudo sleepgraph -m standby -rtcwake 15 -o "standby-{hostname}-{date}-{time}"\fR
+.PP
+Execute a freeze with no wakeup (require keypress). Change output folder name.
+.IP
+\f(CW$ sudo sleepgraph -m freeze -rtcwake off -o "freeze-{hostname}-{date}-{time}"\fR
+.PP
+
+.SS "Capturing Advanced Timelines"
+Execute a suspend & include dev mode source calls, limit callbacks to 5ms or larger.
+.IP
+\f(CW$ sudo sleepgraph -m mem -rtcwake 15 -dev -mindev 5\fR
+.PP
+Run two suspends back to back, include a 500ms delay before, after, and in between runs.
+.IP
+\f(CW$ sudo sleepgraph -m mem -rtcwake 15 -x2 -predelay 500 -x2delay 500 -postdelay 500\fR
+.PP
+Do a batch run of 10 freezes with 30 seconds delay between runs.
+.IP
+\f(CW$ sudo sleepgraph -m freeze -rtcwake 15 -multi 10 30\fR
+.PP
+Execute a suspend using a custom command.
+.IP
+\f(CW$ sudo sleepgraph -cmd "echo mem > /sys/power/state" -rtcwake 15\fR
+.PP
+
+
+.SS "Capturing Timelines with Callgraph Data"
+Add device callgraphs. Limit the trace depth and only show callgraphs 10ms or larger.
+.IP
+\f(CW$ sudo sleepgraph -m mem -rtcwake 15 -f -maxdepth 5 -mincg 10\fR
+.PP
+Capture a full callgraph across all suspend, then filter the html by a single phase.
+.IP
+\f(CW$ sudo sleepgraph -m mem -rtcwake 15 -f\fR
+.IP
+\f(CW$ sleepgraph -dmesg host_mem_dmesg.txt -ftrace host_mem_ftrace.txt -f -cgphase resume
+.PP
+
+.SH "SEE ALSO"
+dmesg(1)
+.PP
+.SH AUTHOR
+.nf
+Written by Todd Brandt <todd.e.brandt@linux.intel.com>
-- 
2.7.4
