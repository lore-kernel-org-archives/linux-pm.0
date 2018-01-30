From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 1/3] pm-graph: config files and installer
Date: Tue, 30 Jan 2018 00:17:18 -0800
Message-ID: <ea05efd43283c731a17df599705253032f9616e9.1517297999.git.todd.e.brandt@linux.intel.com>
References: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31326 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751576AbeA3IRX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jan 2018 03:17:23 -0500
In-Reply-To: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
References: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

- name change: analyze_boot.py to bootgraph.py
- name change: analyze_suspend.py to sleepgraph.py
- added config files for easier sleepgraph usage
- added example.cfg which describes all config options
- added cgskip.txt definition for slimmer callgraphs

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/Makefile                      |  29 ++-
 .../pm-graph/{analyze_boot.py => bootgraph.py}     |   0
 tools/power/pm-graph/config/cgskip.txt             |  65 +++++++
 .../pm-graph/config/custom-timeline-functions.cfg  | 205 +++++++++++++++++++++
 tools/power/pm-graph/config/example.cfg            | 133 +++++++++++++
 tools/power/pm-graph/config/freeze-callgraph.cfg   |  94 ++++++++++
 tools/power/pm-graph/config/freeze-dev.cfg         |  93 ++++++++++
 tools/power/pm-graph/config/freeze.cfg             |  93 ++++++++++
 tools/power/pm-graph/config/standby-callgraph.cfg  |  94 ++++++++++
 tools/power/pm-graph/config/standby-dev.cfg        |  93 ++++++++++
 tools/power/pm-graph/config/standby.cfg            |  93 ++++++++++
 tools/power/pm-graph/config/suspend-callgraph.cfg  |  98 ++++++++++
 tools/power/pm-graph/config/suspend-dev.cfg        |  93 ++++++++++
 tools/power/pm-graph/config/suspend-x2-proc.cfg    |  93 ++++++++++
 tools/power/pm-graph/config/suspend.cfg            |  93 ++++++++++
 .../pm-graph/{analyze_suspend.py => sleepgraph.py} |   0
 16 files changed, 1362 insertions(+), 7 deletions(-)
 rename tools/power/pm-graph/{analyze_boot.py => bootgraph.py} (100%)
 create mode 100644 tools/power/pm-graph/config/cgskip.txt
 create mode 100644 tools/power/pm-graph/config/custom-timeline-functions.cfg
 create mode 100644 tools/power/pm-graph/config/example.cfg
 create mode 100644 tools/power/pm-graph/config/freeze-callgraph.cfg
 create mode 100644 tools/power/pm-graph/config/freeze-dev.cfg
 create mode 100644 tools/power/pm-graph/config/freeze.cfg
 create mode 100644 tools/power/pm-graph/config/standby-callgraph.cfg
 create mode 100644 tools/power/pm-graph/config/standby-dev.cfg
 create mode 100644 tools/power/pm-graph/config/standby.cfg
 create mode 100644 tools/power/pm-graph/config/suspend-callgraph.cfg
 create mode 100644 tools/power/pm-graph/config/suspend-dev.cfg
 create mode 100644 tools/power/pm-graph/config/suspend-x2-proc.cfg
 create mode 100644 tools/power/pm-graph/config/suspend.cfg
 rename tools/power/pm-graph/{analyze_suspend.py => sleepgraph.py} (100%)

diff --git a/tools/power/pm-graph/Makefile b/tools/power/pm-graph/Makefile
index 4e1e999e7b05..c1899cd72c80 100644
--- a/tools/power/pm-graph/Makefile
+++ b/tools/power/pm-graph/Makefile
@@ -7,11 +7,24 @@ all:
 
 install : uninstall
 	install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph
-	install analyze_suspend.py $(DESTDIR)$(PREFIX)/lib/pm-graph
-	install analyze_boot.py $(DESTDIR)$(PREFIX)/lib/pm-graph
+	install sleepgraph.py $(DESTDIR)$(PREFIX)/lib/pm-graph
+	install bootgraph.py $(DESTDIR)$(PREFIX)/lib/pm-graph
+	install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/cgskip.txt $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/freeze-callgraph.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/freeze.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/freeze-dev.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/standby-callgraph.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/standby.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/standby-dev.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/suspend-callgraph.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/suspend.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/suspend-dev.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
+	install -m 644 config/suspend-x2-proc.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
 
-	ln -s $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_boot.py $(DESTDIR)$(PREFIX)/bin/bootgraph
-	ln -s $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_suspend.py $(DESTDIR)$(PREFIX)/bin/sleepgraph
+	install -d  $(DESTDIR)$(PREFIX)/bin
+	ln -s $(DESTDIR)$(PREFIX)/lib/pm-graph/bootgraph.py $(DESTDIR)$(PREFIX)/bin/bootgraph
+	ln -s $(DESTDIR)$(PREFIX)/lib/pm-graph/sleepgraph.py $(DESTDIR)$(PREFIX)/bin/sleepgraph
 
 	install -d  $(DESTDIR)$(PREFIX)/share/man/man8
 	install bootgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
@@ -24,9 +37,11 @@ uninstall :
 	rm -f $(DESTDIR)$(PREFIX)/bin/bootgraph
 	rm -f $(DESTDIR)$(PREFIX)/bin/sleepgraph
 
-	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_boot.py
-	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/analyze_suspend.py
-	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/*.pyc
+	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/config/*
+	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph/config ] ; then \
+		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/config; \
+	fi;
+	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/*
 	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph ] ; then \
 		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph; \
 	fi;
diff --git a/tools/power/pm-graph/analyze_boot.py b/tools/power/pm-graph/bootgraph.py
similarity index 100%
rename from tools/power/pm-graph/analyze_boot.py
rename to tools/power/pm-graph/bootgraph.py
diff --git a/tools/power/pm-graph/config/cgskip.txt b/tools/power/pm-graph/config/cgskip.txt
new file mode 100644
index 000000000000..e48d588fbfb4
--- /dev/null
+++ b/tools/power/pm-graph/config/cgskip.txt
@@ -0,0 +1,65 @@
+# -----------------------------------------------
+# CallGraph function skip list
+#
+# This file contains a list of functions which are
+# meant to be skipped in the callgraph trace. It reduces
+# the callgraph html file size by treating these functions
+# as leaves with no child calls. It can be editted by
+# adding or removing function symbol names.
+#
+# The sleepgraph tool automatically pulls this file in when
+# it is found in the config folder. It can be ignored if
+# the tool is called with "-cgskip off".
+# -----------------------------------------------
+
+# low level scheduling and timing
+up
+down_timeout
+mutex_lock
+down_read
+complete_all
+schedule_timeout
+wake_up_process
+msleep
+__udelay
+ktime_get
+
+# console calls
+printk
+dev_printk
+console_unlock
+
+# memory handling
+__kmalloc
+__kmalloc_track_caller
+kmem_cache_alloc
+kmem_cache_alloc_trace
+kmem_cache_free
+kstrdup
+kstrdup_const
+kmalloc_slab
+new_slab
+__slab_alloc
+__slab_free
+raw_pci_read
+pci_read
+alloc_pages_current
+
+# debugfs and sysfs setup
+debugfs_remove_recursive
+debugfs_create_dir
+debugfs_create_files
+debugfs_create_dir
+debugfs_get_inode
+sysfs_add_file_mode_ns
+sysfs_add_file
+sysfs_create_dir_ns
+sysfs_create_link
+sysfs_create_group
+sysfs_create_groups
+sysfs_create_bin_file
+dpm_sysfs_add
+sysfs_create_file_ns
+sysfs_merge_group
+sysfs_add_link_to_group
+sysfs_create_link_sd
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
new file mode 100644
index 000000000000..4f80ad7d7275
--- /dev/null
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -0,0 +1,205 @@
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config thisfile.txt
+#
+
+[Settings]
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: mem
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: true
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 1
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: suspend-{hostname}-{date}-{time}-custom
+
+# Override default timeline entries
+# Do not use the internal default functions for timeline entries (default: false)
+# Set this to true if you intend to only use the ones defined in this config
+override-timeline-functions: true
+
+# Override default dev timeline entries
+# Do not use the internal default functions for dev timeline entries (default: false)
+# Set this to true if you intend to only use the ones defined in this config
+override-dev-timeline-functions: true
+
+[timeline_functions_x86_64]
+#
+# Function calls to display in the timeline alongside device callbacks.
+# The tool has an internal set of these functions which should cover the
+# whole of kernel execution, but you can append or override here.
+#
+# This is a list of kprobes which use both symbol data and function arg data.
+# The function calls are displayed on the timeline alongside the device blocks.
+# The args are pulled directly from the stack using this architecture's registers
+# and stack formatting. Three pieces of info are required. The function name,
+# a format string, and an argument list
+#
+# Entry format:
+#
+#   function: format{fn_arg1}_{fn_arg2} fn_arg1 fn_arg2 ... [color=purple]
+#
+# Required Arguments:
+#
+#   function: The symbol name for the function you want probed, this is the
+#             minimum required for an entry, it will show up as the function
+#             name with no arguments.
+#
+#       example: _cpu_up:
+#
+# Optional Arguments:
+#
+#   format: The format to display the data on the timeline in. Use braces to
+#           enclose the arg names.
+#
+#       example: CPU_ON[{cpu}]
+#
+#   color: The color of the entry block in the timeline. The default color is
+#          transparent, so the entry shares the phase color. The color is an
+#          html color string, either a word, or an RGB.
+#
+#       example: [color=#CC00CC]
+#
+#   arglist: A list of arguments from registers/stack addresses. See URL:
+#            https://www.kernel.org/doc/Documentation/trace/kprobetrace.txt
+#
+#       example: cpu=%di:s32
+#
+# Example: Display cpu resume in the timeline
+#
+#       _cpu_up: CPU_ON[{cpu}] cpu=%di:s32 [color=orange]
+#
+_cpu_down: CPU_OFF[{cpu}] cpu=%di:s32
+_cpu_up: CPU_ON[{cpu}] cpu=%di:s32
+sys_sync:
+pm_prepare_console:
+pm_notifier_call_chain:
+freeze_processes:
+freeze_kernel_threads:
+pm_restrict_gfp_mask:
+acpi_suspend_begin:
+suspend_console:
+acpi_pm_prepare:
+syscore_suspend:
+arch_enable_nonboot_cpus_end:
+syscore_resume:
+acpi_pm_finish:
+resume_console:
+acpi_pm_end:
+pm_restore_gfp_mask:
+thaw_processes:
+pm_restore_console:
+
+[dev_timeline_functions_x86_64]
+#
+# Dev mode function calls to display inside timeline entries
+#
+# This is a list of kprobes which use both symbol data and function arg data.
+# The function calls are displayed on the timeline alongside the device blocks.
+# The args are pulled directly from the stack using this architecture's registers
+# and stack formatting. Three pieces of info are required. The function name,
+# a format string, and an argument list
+#
+# Entry format:
+#
+#   function: format{fn_arg1}_{fn_arg2} fn_arg1 fn_arg2 ... [color=purple]
+#
+# Required Arguments:
+#
+#   function: The symbol name for the function you want probed, this is the
+#             minimum required for an entry, it will show up as the function
+#             name with no arguments.
+#
+#       example: ata_eh_recover:
+#
+# Optional Arguments:
+#
+#   format: The format to display the data on the timeline in. Use braces to
+#           enclose the arg names.
+#
+#       example: ata{port}_port_reset
+# 
+#   color: The color of the entry block in the timeline. The default color is
+#          transparent, so the entry shares the phase color. The color is an
+#          html color string, either a word, or an RGB.
+#
+#       example: [color=#CC00CC]
+#
+#   arglist: A list of arguments from registers/stack addresses. See URL:
+#            https://www.kernel.org/doc/Documentation/trace/kprobetrace.txt
+#
+#       example: port=+36(%di):s32
+#
+# Example: Display ATA port reset as ataN_port_reset in the timeline
+#
+#       ata_eh_recover: ata{port}_port_reset port=+36(%di):s32
+#
+msleep: msleep time=%di:s32
+schedule_timeout_uninterruptible: schedule_timeout_uninterruptible timeout=%di:s32
+schedule_timeout: schedule_timeout timeout=%di:s32
+usleep_range: usleep_range min=%di:s32 max=%si:s32
+__const_udelay: udelay loops=%di:s32
+__mutex_lock_slowpath: mutex_lock_slowpath
+ata_eh_recover: ata_eh_recover port=+36(%di):s32
+acpi_os_stall:
+acpi_resume_power_resources:
+acpi_ps_parse_aml:
+ext4_sync_fs:
+i915_gem_resume:
+i915_restore_state:
+intel_opregion_setup:
+g4x_pre_enable_dp:
+vlv_pre_enable_dp:
+chv_pre_enable_dp:
+g4x_enable_dp:
+vlv_enable_dp:
+intel_hpd_init:
+intel_opregion_register:
+intel_dp_detect:
+intel_hdmi_detect:
+intel_opregion_init:
+intel_fbdev_set_suspend:
diff --git a/tools/power/pm-graph/config/example.cfg b/tools/power/pm-graph/config/example.cfg
new file mode 100644
index 000000000000..05b2efb9bb54
--- /dev/null
+++ b/tools/power/pm-graph/config/example.cfg
@@ -0,0 +1,133 @@
+#
+# Generic S3 (Suspend to Mem) test
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/example.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: mem
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: suspend-{hostname}-{date}-{time}
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: true
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# Skip HTML generation
+# Only capture the logs, don't generate the html timeline (default: false)
+skiphtml: false
+
+# Sync filesystem before suspend
+# run sync before the test, minimizes sys_sync call time (default: false)
+sync: true
+
+# Runtime suspend enable/disable
+# Enable/disable runtime suspend for all devices, restore all after test (default: no-action)
+# rs: disable
+
+# Turn display on/off for test
+# Switch the display on/off for the test using xset (default: no-action)
+# display: on
+
+# Print results to text file
+# Print the status of the test run in the given file (default: no-action)
+result: result.txt
+
+# Gzip the log files to save space
+# Gzip the generated log files, and read gzipped log files (default: false)
+gzip: true
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of suspend (default: "")
+# command: echo mem > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Multiple test runs
+# Run N tests D seconds apart, generates separate outputs with a summary (default: false)
+# multi: 3 5
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back and display in the same timeline (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 0.001
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Callgraph phase filter
+# Only enable callgraphs for one phase, i.e. resume_noirq (default: all)
+cgphase: suspend
+
+# Callgraph x2 test filter
+# Only enable callgraphs test 0 or 1 when using -x2 (default: 1)
+cgtest: 0
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 6
+
+# Device Filter
+# show only devices whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
+
+# Add kprobe functions to the timeline
+# Add functions to the timeline from a text file (default: no-action)
+# fadd: file.txt
diff --git a/tools/power/pm-graph/config/freeze-callgraph.cfg b/tools/power/pm-graph/config/freeze-callgraph.cfg
new file mode 100644
index 000000000000..f692821c4828
--- /dev/null
+++ b/tools/power/pm-graph/config/freeze-callgraph.cfg
@@ -0,0 +1,94 @@
+#
+# Full Callgraph for S2 (Freeze) test
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/freeze-callgraph.cfg
+#
+# NOTE: the output of this test is very large (> 30MB)
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: freeze
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: freeze-{hostname}-{date}-{time}-cg
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of freeze (default: "")
+# command: echo freeze > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 1
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: true
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 6
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/freeze-dev.cfg b/tools/power/pm-graph/config/freeze-dev.cfg
new file mode 100644
index 000000000000..c4ad5cea3cbf
--- /dev/null
+++ b/tools/power/pm-graph/config/freeze-dev.cfg
@@ -0,0 +1,93 @@
+#
+# Dev S2 (Freeze) test - includes src calls / kernel threads
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/freeze-dev.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: freeze
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: freeze-{hostname}-{date}-{time}-dev
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of freeze (default: "")
+# command: echo freeze > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: true
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 1
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 3
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/freeze.cfg b/tools/power/pm-graph/config/freeze.cfg
new file mode 100644
index 000000000000..0b70e0b74527
--- /dev/null
+++ b/tools/power/pm-graph/config/freeze.cfg
@@ -0,0 +1,93 @@
+#
+# Generic S2 (Freeze) test
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/freeze.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: freeze
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: freeze-{hostname}-{date}-{time}
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of freeze (default: "")
+# command: echo freeze > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 0.001
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 3
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/standby-callgraph.cfg b/tools/power/pm-graph/config/standby-callgraph.cfg
new file mode 100644
index 000000000000..f52a6b9d5c32
--- /dev/null
+++ b/tools/power/pm-graph/config/standby-callgraph.cfg
@@ -0,0 +1,94 @@
+#
+# Full Callgraph for S1 (Standby) test
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/standby-callgraph.cfg
+#
+# NOTE: the output of this test is very large (> 30MB)
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: standby
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: standby-{hostname}-{date}-{time}-cg
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of standby (default: "")
+# command: echo standby > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 1
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: true
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 6
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/standby-dev.cfg b/tools/power/pm-graph/config/standby-dev.cfg
new file mode 100644
index 000000000000..a5498ece3def
--- /dev/null
+++ b/tools/power/pm-graph/config/standby-dev.cfg
@@ -0,0 +1,93 @@
+#
+# Dev S1 (Standby) test - includes src calls / kernel threads
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/standby-dev.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: standby
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: standby-{hostname}-{date}-{time}-dev
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of standby (default: "")
+# command: echo standby > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: true
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 1
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 3
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/standby.cfg b/tools/power/pm-graph/config/standby.cfg
new file mode 100644
index 000000000000..f0dd264dfeff
--- /dev/null
+++ b/tools/power/pm-graph/config/standby.cfg
@@ -0,0 +1,93 @@
+#
+# Generic S1 (Standby) test
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/standby.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: standby
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: standby-{hostname}-{date}-{time}
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of standby (default: "")
+# command: echo standby > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 0.001
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 3
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/suspend-callgraph.cfg b/tools/power/pm-graph/config/suspend-callgraph.cfg
new file mode 100644
index 000000000000..11b8cbc12d34
--- /dev/null
+++ b/tools/power/pm-graph/config/suspend-callgraph.cfg
@@ -0,0 +1,98 @@
+#
+# Full Callgraph for S3 (Suspend to Mem) test
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/suspend.cfg
+#
+# NOTE: the output of this test is very large (> 30MB)
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: mem
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: suspend-{hostname}-{date}-{time}-cg
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of suspend (default: "")
+# command: echo mem > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 0.001
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: true
+
+# Max graph depth
+# limit the callgraph trace to this depth (default: 0 = all)
+maxdepth: 5
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 6
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/suspend-dev.cfg b/tools/power/pm-graph/config/suspend-dev.cfg
new file mode 100644
index 000000000000..56f1d21cc79b
--- /dev/null
+++ b/tools/power/pm-graph/config/suspend-dev.cfg
@@ -0,0 +1,93 @@
+#
+# Dev S3 (Suspend to Mem) test - includes src calls / kernel threads
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/suspend-dev.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: mem
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: suspend-{hostname}-{date}-{time}-dev
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of suspend (default: "")
+# command: echo mem > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: true
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 1
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 3
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/suspend-x2-proc.cfg b/tools/power/pm-graph/config/suspend-x2-proc.cfg
new file mode 100644
index 000000000000..0ecca0ede138
--- /dev/null
+++ b/tools/power/pm-graph/config/suspend-x2-proc.cfg
@@ -0,0 +1,93 @@
+#
+# Proc S3 (Suspend to Mem) x2 test - includes user processes
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/suspend-proc.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: mem
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: suspend-{hostname}-{date}-{time}-x2-proc
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of suspend (default: "")
+# command: echo mem > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: true
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: true
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 1000
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 1000
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 1000
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 1
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 3
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/config/suspend.cfg b/tools/power/pm-graph/config/suspend.cfg
new file mode 100644
index 000000000000..70d293231b06
--- /dev/null
+++ b/tools/power/pm-graph/config/suspend.cfg
@@ -0,0 +1,93 @@
+#
+# Generic S3 (Suspend to Mem) test
+#
+# This is the configuration file for sleepgraph. It contains
+# all the tool arguments so that they don't have to be given on the
+# command line. It also includes advanced settings for functions
+# and kprobes. It is run like this
+#
+#    sudo ./sleepgraph.py -config config/suspend.cfg
+#
+
+[Settings]
+
+# ---- General Options ----
+
+# Verbosity
+# print verbose messages (default: false)
+verbose: false
+
+# Suspend Mode
+# e.g. standby, mem, freeze, disk (default: mem)
+mode: mem
+
+# Output Directory Format
+# output folder for html, ftrace, and dmesg. Use {date} and {time} for current values
+output-dir: suspend-{hostname}-{date}-{time}
+
+# Automatic Wakeup
+# Use rtcwake to autoresume after X seconds, or off to disable (default: 15)
+rtcwake: 15
+
+# Add Logs
+# add the dmesg and ftrace log to the html output (default: false)
+addlogs: false
+
+# Suspend/Resume Gap
+# insert a small visible gap between suspend and resume on the timeline (default: false)
+srgap: false
+
+# ---- Advanced Options ----
+
+# Command to execute in lieu of suspend (default: "")
+# command: echo mem > /sys/power/state
+
+# Display user processes
+# graph user processes and cpu usage in the timeline (default: false)
+proc: false
+
+# Display function calls
+# graph source functions in the timeline (default: false)
+dev: false
+
+# Back to Back Suspend/Resume
+# Run two suspend/resumes back to back (default: false)
+x2: false
+
+# Back to Back Suspend Delay
+# Time delay between the two test runs in ms (default: 0 ms)
+x2delay: 0
+
+# Pre Suspend Delay
+# Include an N ms delay before (1st) suspend (default: 0 ms)
+predelay: 0
+
+# Post Resume Delay
+# Include an N ms delay after (last) resume (default: 0 ms)
+postdelay: 0
+
+# Minimum Device Length
+# graph only devices longer than min in the timeline (default: 0.001 ms)
+mindev: 0.001
+
+# ---- Debug Options ----
+
+# Callgraph
+# gather detailed ftrace callgraph data on all timeline events (default: false)
+callgraph: false
+
+# Expand Callgraph
+# pre-expand the callgraph data in the html output (default: disabled)
+expandcg: false
+
+# Minimum Callgraph Length
+# provide callgraph data for blocks longer than min (default: 0.001 ms)
+mincg: 1
+
+# Timestamp Precision
+# Number of significant digits in timestamps (0:S, [3:ms], 6:us)
+timeprec: 3
+
+# Device Filter
+# show only devs whose name/driver includes one of these strings
+# devicefilter: _cpu_up,_cpu_down,i915,usb
diff --git a/tools/power/pm-graph/analyze_suspend.py b/tools/power/pm-graph/sleepgraph.py
similarity index 100%
rename from tools/power/pm-graph/analyze_suspend.py
rename to tools/power/pm-graph/sleepgraph.py
-- 
2.14.1
