From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 3/3] pm-graph: AnalyzeSuspend v5.0
Date: Tue, 30 Jan 2018 00:17:20 -0800
Message-ID: <b4d73d194be1439e5b4f69c35bddb0fa8133f45b.1517297999.git.todd.e.brandt@linux.intel.com>
References: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31326 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751756AbeA3IRY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 30 Jan 2018 03:17:24 -0500
In-Reply-To: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
References: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

- add -cgskip option to reduce callgraph output size
- add -cgfilter option to focus on a list of devices
- add -result option for exporting batch test results
- removed all phoronix hooks, use -result to enable batch testing
- change -usbtopo to -devinfo, now prints all devices
- add -gzip option to read/write logs in gz format
- add -bufsize option to manually control ftrace buffer size
- add -sync option to run filesystem sync prior to test
- add -display option to enable/disable the display prior to test
- add -rs option to enable/disable runtime suspend on all devices for test
- add installed config files to search path
- add kernel error/warning links into the timeline
- fix callgraph trace to better handle interrupts
- include command string and kernel params in timeline output header

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/sleepgraph.8  |   47 +-
 tools/power/pm-graph/sleepgraph.py | 1625 ++++++++++++++++++++++--------------
 2 files changed, 1053 insertions(+), 619 deletions(-)

diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index fbe7bd3eae8e..18baaf6300c9 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -52,9 +52,32 @@ disable rtcwake and require a user keypress to resume.
 \fB-addlogs\fR
 Add the dmesg and ftrace logs to the html output. They will be viewable by
 clicking buttons in the timeline.
+.TP
+\fB-result \fIfile\fR
+Export a results table to a text file for parsing.
+.TP
+\fB-sync\fR
+Sync the filesystems before starting the test. This reduces the size of
+the sys_sync call which happens in the suspend_prepare phase.
+.TP
+\fB-rs \fIenable/disable\fR
+During test, enable/disable runtime suspend for all devices. The test is delayed
+by 5 seconds to allow runtime suspend changes to occur. The settings are restored
+after the test is complete.
+.TP
+\fB-display \fIon/off\fR
+Turn the display on or off for the test using the xset command. This helps
+maintain the consistecy of test data for better comparison.
+.TP
+\fB-skiphtml\fR
+Run the test and capture the trace logs, but skip the timeline generation.
 
 .SS "advanced"
 .TP
+\fB-gzip\fR
+Gzip the trace and dmesg logs to save space. The tool can also read in gzipped
+logs for processing.
+.TP
 \fB-cmd \fIstr\fR
 Run the timeline over a custom suspend command, e.g. pm-suspend. By default
 the tool forces suspend via /sys/power/state so this allows testing over
@@ -114,6 +137,18 @@ This reduces the html file size as there can be many tiny callgraphs
 which are barely visible in the timeline.
 The value is a float: e.g. 0.001 represents 1 us.
 .TP
+\fB-cgfilter \fI"func1,func2,..."\fR
+Reduce callgraph output in the timeline by limiting it to a list of calls. The
+argument can be a single function name or a comma delimited list.
+(default: none)
+.TP
+\fB-cgskip \fIfile\fR
+Reduce callgraph timeline size by skipping over uninteresting functions
+in the trace, e.g. printk or console_unlock. The functions listed
+in this file will show up as empty leaves in the callgraph with only the start/end
+times displayed. cgskip.txt is used automatically if found in the path, so
+use "off" to disable completely (default: cgskip.txt)
+.TP
 \fB-cgphase \fIp\fR
 Only show callgraph data for phase \fIp\fR (e.g. suspend_late).
 .TP
@@ -122,6 +157,9 @@ In an x2 run, only show callgraph data for test \fIn\fR (e.g. 0 or 1).
 .TP
 \fB-timeprec \fIn\fR
 Number of significant digits in timestamps (0:S, [3:ms], 6:us).
+.TP
+\fB-bufsize \fIN\fR
+Set trace buffer size to N kilo-bytes (default: all of free memory up to 3GB)
 
 .SH COMMANDS
 .TP
@@ -144,11 +182,8 @@ Print out the contents of the ACPI Firmware Performance Data Table.
 \fB-sysinfo\fR
 Print out system info extracted from BIOS. Reads /dev/mem directly instead of going through dmidecode.
 .TP
-\fB-usbtopo\fR
-Print out the current USB topology with power info.
-.TP
-\fB-usbauto\fR
-Enable autosuspend for all connected USB devices.
+\fB-devinfo\fR
+Print out the pm settings of all devices which support runtime suspend.
 .TP
 \fB-flist\fR
 Print the list of ftrace functions currently being captured. Functions
@@ -198,7 +233,7 @@ Execute a mem suspend with a 15 second wakeup. Include the logs in the html.
 .PP
 Execute a standby with a 15 second wakeup. Change the output folder name.
 .IP
-\f(CW$ sudo sleepgraph -m standby -rtcwake 15 -o "standby-{hostname}-{date}-{time}"\fR
+\f(CW$ sudo sleepgraph -m standby -rtcwake 15 -o "standby-{host}-{date}-{time}"\fR
 .PP
 Execute a freeze with no wakeup (require keypress). Change output folder name.
 .IP
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 1b60fe203741..266409fb27ae 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -19,7 +19,7 @@
 #	 Home Page
 #	   https://01.org/suspendresume
 #	 Source repo
-#	   https://github.com/01org/pm-graph
+#	   git@github.com:01org/pm-graph
 #
 # Description:
 #	 This tool is designed to assist kernel and OS developers in optimizing
@@ -57,6 +57,7 @@ import platform
 from datetime import datetime
 import struct
 import ConfigParser
+import gzip
 from threading import Thread
 from subprocess import call, Popen, PIPE
 
@@ -68,8 +69,12 @@ from subprocess import call, Popen, PIPE
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '4.7'
+	version = '5.0'
 	ansi = False
+	rs = 0
+	display = 0
+	gzip = False
+	sync = False
 	verbose = False
 	testlog = True
 	dmesglog = False
@@ -78,14 +83,19 @@ class SystemValues:
 	mincglen = 0.0
 	cgphase = ''
 	cgtest = -1
+	cgskip = ''
+	multitest = {'run': False, 'count': 0, 'delay': 0}
 	max_graph_depth = 0
 	callloopmaxgap = 0.0001
 	callloopmaxlen = 0.005
+	bufsize = 0
 	cpucount = 0
 	memtotal = 204800
+	memfree = 204800
 	srgap = 0
 	cgexp = False
 	testdir = ''
+	outdir = ''
 	tpath = '/sys/kernel/debug/tracing/'
 	fpdtpath = '/sys/firmware/acpi/tables/FPDT'
 	epath = '/sys/kernel/debug/tracing/events/power/'
@@ -109,22 +119,24 @@ class SystemValues:
 	dmesgfile = ''
 	ftracefile = ''
 	htmlfile = 'output.html'
-	embedded = False
+	result = ''
 	rtcwake = True
 	rtcwaketime = 15
 	rtcpath = ''
 	devicefilter = []
+	cgfilter = []
 	stamp = 0
 	execcount = 1
 	x2delay = 0
+	skiphtml = False
 	usecallgraph = False
 	usetraceevents = False
-	usetraceeventsonly = False
 	usetracemarkers = True
 	usekprobes = True
 	usedevsrc = False
 	useprocmon = False
 	notestrun = False
+	cgdump = False
 	mixedphaseheight = True
 	devprops = dict()
 	predelay = 0
@@ -134,24 +146,33 @@ class SystemValues:
 	tracertypefmt = '# tracer: (?P<t>.*)'
 	firmwarefmt = '# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
 	tracefuncs = {
-		'sys_sync': dict(),
-		'pm_prepare_console': dict(),
-		'pm_notifier_call_chain': dict(),
-		'freeze_processes': dict(),
-		'freeze_kernel_threads': dict(),
-		'pm_restrict_gfp_mask': dict(),
-		'acpi_suspend_begin': dict(),
-		'suspend_console': dict(),
-		'acpi_pm_prepare': dict(),
-		'syscore_suspend': dict(),
-		'arch_enable_nonboot_cpus_end': dict(),
-		'syscore_resume': dict(),
-		'acpi_pm_finish': dict(),
-		'resume_console': dict(),
-		'acpi_pm_end': dict(),
-		'pm_restore_gfp_mask': dict(),
-		'thaw_processes': dict(),
-		'pm_restore_console': dict(),
+		'sys_sync': {},
+		'__pm_notifier_call_chain': {},
+		'pm_prepare_console': {},
+		'pm_notifier_call_chain': {},
+		'freeze_processes': {},
+		'freeze_kernel_threads': {},
+		'pm_restrict_gfp_mask': {},
+		'acpi_suspend_begin': {},
+		'acpi_hibernation_begin': {},
+		'acpi_hibernation_enter': {},
+		'acpi_hibernation_leave': {},
+		'acpi_pm_freeze': {},
+		'acpi_pm_thaw': {},
+		'hibernate_preallocate_memory': {},
+		'create_basic_memory_bitmaps': {},
+		'swsusp_write': {},
+		'suspend_console': {},
+		'acpi_pm_prepare': {},
+		'syscore_suspend': {},
+		'arch_enable_nonboot_cpus_end': {},
+		'syscore_resume': {},
+		'acpi_pm_finish': {},
+		'resume_console': {},
+		'acpi_pm_end': {},
+		'pm_restore_gfp_mask': {},
+		'thaw_processes': {},
+		'pm_restore_console': {},
 		'CPU_OFF': {
 			'func':'_cpu_down',
 			'args_x86_64': {'cpu':'%di:s32'},
@@ -173,56 +194,54 @@ class SystemValues:
 		'mutex_lock_slowpath': { 'func':'__mutex_lock_slowpath', 'ub': 1 },
 		'acpi_os_stall': {'ub': 1},
 		# ACPI
-		'acpi_resume_power_resources': dict(),
-		'acpi_ps_parse_aml': dict(),
+		'acpi_resume_power_resources': {},
+		'acpi_ps_parse_aml': {},
 		# filesystem
-		'ext4_sync_fs': dict(),
+		'ext4_sync_fs': {},
 		# 80211
-		'iwlagn_mac_start': dict(),
-		'iwlagn_alloc_bcast_station': dict(),
-		'iwl_trans_pcie_start_hw': dict(),
-		'iwl_trans_pcie_start_fw': dict(),
-		'iwl_run_init_ucode': dict(),
-		'iwl_load_ucode_wait_alive': dict(),
-		'iwl_alive_start': dict(),
-		'iwlagn_mac_stop': dict(),
-		'iwlagn_mac_suspend': dict(),
-		'iwlagn_mac_resume': dict(),
-		'iwlagn_mac_add_interface': dict(),
-		'iwlagn_mac_remove_interface': dict(),
-		'iwlagn_mac_change_interface': dict(),
-		'iwlagn_mac_config': dict(),
-		'iwlagn_configure_filter': dict(),
-		'iwlagn_mac_hw_scan': dict(),
-		'iwlagn_bss_info_changed': dict(),
-		'iwlagn_mac_channel_switch': dict(),
-		'iwlagn_mac_flush': dict(),
+		'iwlagn_mac_start': {},
+		'iwlagn_alloc_bcast_station': {},
+		'iwl_trans_pcie_start_hw': {},
+		'iwl_trans_pcie_start_fw': {},
+		'iwl_run_init_ucode': {},
+		'iwl_load_ucode_wait_alive': {},
+		'iwl_alive_start': {},
+		'iwlagn_mac_stop': {},
+		'iwlagn_mac_suspend': {},
+		'iwlagn_mac_resume': {},
+		'iwlagn_mac_add_interface': {},
+		'iwlagn_mac_remove_interface': {},
+		'iwlagn_mac_change_interface': {},
+		'iwlagn_mac_config': {},
+		'iwlagn_configure_filter': {},
+		'iwlagn_mac_hw_scan': {},
+		'iwlagn_bss_info_changed': {},
+		'iwlagn_mac_channel_switch': {},
+		'iwlagn_mac_flush': {},
 		# ATA
 		'ata_eh_recover': { 'args_x86_64': {'port':'+36(%di):s32'} },
 		# i915
-		'i915_gem_resume': dict(),
-		'i915_restore_state': dict(),
-		'intel_opregion_setup': dict(),
-		'g4x_pre_enable_dp': dict(),
-		'vlv_pre_enable_dp': dict(),
-		'chv_pre_enable_dp': dict(),
-		'g4x_enable_dp': dict(),
-		'vlv_enable_dp': dict(),
-		'intel_hpd_init': dict(),
-		'intel_opregion_register': dict(),
-		'intel_dp_detect': dict(),
-		'intel_hdmi_detect': dict(),
-		'intel_opregion_init': dict(),
-		'intel_fbdev_set_suspend': dict(),
+		'i915_gem_resume': {},
+		'i915_restore_state': {},
+		'intel_opregion_setup': {},
+		'g4x_pre_enable_dp': {},
+		'vlv_pre_enable_dp': {},
+		'chv_pre_enable_dp': {},
+		'g4x_enable_dp': {},
+		'vlv_enable_dp': {},
+		'intel_hpd_init': {},
+		'intel_opregion_register': {},
+		'intel_dp_detect': {},
+		'intel_hdmi_detect': {},
+		'intel_opregion_init': {},
+		'intel_fbdev_set_suspend': {},
 	}
+	cgblacklist = []
 	kprobes = dict()
 	timeformat = '%.3f'
+	cmdline = '%s %s' % \
+			(os.path.basename(sys.argv[0]), string.join(sys.argv[1:], ' '))
 	def __init__(self):
-		# if this is a phoronix test run, set some default options
-		if('LOG_FILE' in os.environ and 'TEST_RESULTS_IDENTIFIER' in os.environ):
-			self.embedded = True
-			self.dmesglog = self.ftracelog = True
-			self.htmlfile = os.environ['LOG_FILE']
 		self.archargs = 'args_'+platform.machine()
 		self.hostname = platform.node()
 		if(self.hostname == ''):
@@ -237,18 +256,36 @@ class SystemValues:
 		if (hasattr(sys.stdout, 'isatty') and sys.stdout.isatty()):
 			self.ansi = True
 		self.testdir = datetime.now().strftime('suspend-%y%m%d-%H%M%S')
+	def vprint(self, msg):
+		self.logmsg += msg+'\n'
+		if(self.verbose):
+			print(msg)
 	def rootCheck(self, fatal=True):
 		if(os.access(self.powerfile, os.W_OK)):
 			return True
 		if fatal:
-			doError('This command requires sysfs mount and root access')
+			msg = 'This command requires sysfs mount and root access'
+			print('ERROR: %s\n') % msg
+			self.outputResult({'error':msg})
+			sys.exit()
 		return False
 	def rootUser(self, fatal=False):
 		if 'USER' in os.environ and os.environ['USER'] == 'root':
 			return True
 		if fatal:
-			doError('This command must be run as root')
+			msg = 'This command must be run as root'
+			print('ERROR: %s\n') % msg
+			self.outputResult({'error':msg})
+			sys.exit()
 		return False
+	def getExec(self, cmd):
+		dirlist = ['/sbin', '/bin', '/usr/sbin', '/usr/bin',
+			'/usr/local/sbin', '/usr/local/bin']
+		for path in dirlist:
+			cmdfull = os.path.join(path, cmd)
+			if os.path.exists(cmdfull):
+				return cmdfull
+		return ''
 	def setPrecision(self, num):
 		if num < 0 or num > 6:
 			return
@@ -258,15 +295,15 @@ class SystemValues:
 		n = datetime.now()
 		args['date'] = n.strftime('%y%m%d')
 		args['time'] = n.strftime('%H%M%S')
-		args['hostname'] = self.hostname
+		args['hostname'] = args['host'] = self.hostname
 		return value.format(**args)
 	def setOutputFile(self):
 		if self.dmesgfile != '':
-			m = re.match('(?P<name>.*)_dmesg\.txt$', self.dmesgfile)
+			m = re.match('(?P<name>.*)_dmesg\.txt.*', self.dmesgfile)
 			if(m):
 				self.htmlfile = m.group('name')+'.html'
 		if self.ftracefile != '':
-			m = re.match('(?P<name>.*)_ftrace\.txt$', self.ftracefile)
+			m = re.match('(?P<name>.*)_ftrace\.txt.*', self.ftracefile)
 			if(m):
 				self.htmlfile = m.group('name')+'.html'
 	def systemInfo(self, info):
@@ -283,16 +320,19 @@ class SystemValues:
 			c = info['processor-version']
 		if 'bios-version' in info:
 			b = info['bios-version']
-		self.sysstamp = '# sysinfo | man:%s | plat:%s | cpu:%s | bios:%s | numcpu:%d | memsz:%d' % \
-			(m, p, c, b, self.cpucount, self.memtotal)
-	def printSystemInfo(self):
+		self.sysstamp = '# sysinfo | man:%s | plat:%s | cpu:%s | bios:%s | numcpu:%d | memsz:%d | memfr:%d' % \
+			(m, p, c, b, self.cpucount, self.memtotal, self.memfree)
+	def printSystemInfo(self, fatal=False):
 		self.rootCheck(True)
-		out = dmidecode(self.mempath, True)
+		out = dmidecode(self.mempath, fatal)
+		if len(out) < 1:
+			return
 		fmt = '%-24s: %s'
 		for name in sorted(out):
 			print fmt % (name, out[name])
 		print fmt % ('cpucount', ('%d' % self.cpucount))
 		print fmt % ('memtotal', ('%d kB' % self.memtotal))
+		print fmt % ('memfree', ('%d kB' % self.memfree))
 	def cpuInfo(self):
 		self.cpucount = 0
 		fp = open('/proc/cpuinfo', 'r')
@@ -305,7 +345,9 @@ class SystemValues:
 			m = re.match('^MemTotal:[ \t]*(?P<sz>[0-9]*) *kB', line)
 			if m:
 				self.memtotal = int(m.group('sz'))
-				break
+			m = re.match('^MemFree:[ \t]*(?P<sz>[0-9]*) *kB', line)
+			if m:
+				self.memfree = int(m.group('sz'))
 		fp.close()
 	def initTestOutput(self, name):
 		self.prefix = self.hostname
@@ -315,39 +357,34 @@ class SystemValues:
 		testtime = datetime.now().strftime(fmt)
 		self.teststamp = \
 			'# '+testtime+' '+self.prefix+' '+self.suspendmode+' '+kver
-		if(self.embedded):
-			self.dmesgfile = \
-				'/tmp/'+testtime+'_'+self.suspendmode+'_dmesg.txt'
-			self.ftracefile = \
-				'/tmp/'+testtime+'_'+self.suspendmode+'_ftrace.txt'
-			return
+		ext = ''
+		if self.gzip:
+			ext = '.gz'
 		self.dmesgfile = \
-			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'_dmesg.txt'
+			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'_dmesg.txt'+ext
 		self.ftracefile = \
-			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'_ftrace.txt'
+			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'_ftrace.txt'+ext
 		self.htmlfile = \
 			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'.html'
 		if not os.path.isdir(self.testdir):
 			os.mkdir(self.testdir)
+	def getValueList(self, value):
+		out = []
+		for i in value.split(','):
+			if i.strip():
+				out.append(i.strip())
+		return out
 	def setDeviceFilter(self, value):
-		self.devicefilter = []
-		if value:
-			value = value.split(',')
-		for i in value:
-			self.devicefilter.append(i.strip())
+		self.devicefilter = self.getValueList(value)
+	def setCallgraphFilter(self, value):
+		self.cgfilter = self.getValueList(value)
+	def setCallgraphBlacklist(self, file):
+		self.cgblacklist = self.listFromFile(file)
 	def rtcWakeAlarmOn(self):
 		call('echo 0 > '+self.rtcpath+'/wakealarm', shell=True)
-		outD = open(self.rtcpath+'/date', 'r').read().strip()
-		outT = open(self.rtcpath+'/time', 'r').read().strip()
-		mD = re.match('^(?P<y>[0-9]*)-(?P<m>[0-9]*)-(?P<d>[0-9]*)', outD)
-		mT = re.match('^(?P<h>[0-9]*):(?P<m>[0-9]*):(?P<s>[0-9]*)', outT)
-		if(mD and mT):
-			# get the current time from hardware
-			utcoffset = int((datetime.now() - datetime.utcnow()).total_seconds())
-			dt = datetime(\
-				int(mD.group('y')), int(mD.group('m')), int(mD.group('d')),
-				int(mT.group('h')), int(mT.group('m')), int(mT.group('s')))
-			nowtime = int(dt.strftime('%s')) + utcoffset
+		nowtime = open(self.rtcpath+'/since_epoch', 'r').read().strip()
+		if nowtime:
+			nowtime = int(nowtime)
 		else:
 			# if hardware time fails, use the software time
 			nowtime = int(datetime.now().strftime('%s'))
@@ -369,10 +406,10 @@ class SystemValues:
 				ktime = m.group('ktime')
 		fp.close()
 		self.dmesgstart = float(ktime)
-	def getdmesg(self):
+	def getdmesg(self, fwdata=[]):
+		op = self.writeDatafileHeader(sysvals.dmesgfile, fwdata)
 		# store all new dmesg lines since initdmesg was called
 		fp = Popen('dmesg', stdout=PIPE).stdout
-		op = open(self.dmesgfile, 'a')
 		for line in fp:
 			line = line.replace('\r\n', '')
 			idx = line.find('[')
@@ -386,11 +423,17 @@ class SystemValues:
 				op.write(line)
 		fp.close()
 		op.close()
-	def addFtraceFilterFunctions(self, file):
+	def listFromFile(self, file):
+		list = []
 		fp = open(file)
-		list = fp.read().split('\n')
+		for i in fp.read().split('\n'):
+			i = i.strip()
+			if i and i[0] != '#':
+				list.append(i)
 		fp.close()
-		for i in list:
+		return list
+	def addFtraceFilterFunctions(self, file):
+		for i in self.listFromFile(file):
 			if len(i) < 2:
 				continue
 			self.tracefuncs[i] = dict()
@@ -399,9 +442,7 @@ class SystemValues:
 		if not current:
 			call('cat '+self.tpath+'available_filter_functions', shell=True)
 			return
-		fp = open(self.tpath+'available_filter_functions')
-		master = fp.read().split('\n')
-		fp.close()
+		master = self.listFromFile(self.tpath+'available_filter_functions')
 		for i in self.tracefuncs:
 			if 'func' in self.tracefuncs[i]:
 				i = self.tracefuncs[i]['func']
@@ -410,9 +451,7 @@ class SystemValues:
 			else:
 				print self.colorText(i)
 	def setFtraceFilterFunctions(self, list):
-		fp = open(self.tpath+'available_filter_functions')
-		master = fp.read().split('\n')
-		fp.close()
+		master = self.listFromFile(self.tpath+'available_filter_functions')
 		flist = ''
 		for i in list:
 			if i not in master:
@@ -501,6 +540,7 @@ class SystemValues:
 		rejects = []
 		# sort kprobes: trace, ub-dev, custom, dev
 		kpl = [[], [], [], []]
+		linesout = len(self.kprobes)
 		for name in sorted(self.kprobes):
 			res = self.colorText('YES', 32)
 			if not self.testKprobe(name, self.kprobes[name]):
@@ -528,17 +568,10 @@ class SystemValues:
 		for kp in kplist:
 			kprobeevents += self.kprobeText(kp, self.kprobes[kp])
 		self.fsetVal(kprobeevents, 'kprobe_events')
-		# verify that the kprobes were set as ordered
-		check = self.fgetVal('kprobe_events')
-		linesout = len(kprobeevents.split('\n')) - 1
-		linesack = len(check.split('\n')) - 1
 		if output:
-			res = '%d/%d' % (linesack, linesout)
-			if linesack < linesout:
-				res = self.colorText(res, 31)
-			else:
-				res = self.colorText(res, 32)
-			print('    working kprobe functions enabled: %s' % res)
+			check = self.fgetVal('kprobe_events')
+			linesack = (len(check.split('\n')) - 1) / 2
+			print('    kprobe functions enabled: %d/%d' % (linesack, linesout))
 		self.fsetVal('1', 'events/kprobes/enable')
 	def testKprobe(self, kname, kprobe):
 		self.fsetVal('0', 'events/kprobes/enable')
@@ -555,8 +588,7 @@ class SystemValues:
 		if linesack < linesout:
 			return False
 		return True
-	def fsetVal(self, val, path, mode='w'):
-		file = self.tpath+path
+	def setVal(self, val, file, mode='w'):
 		if not os.path.exists(file):
 			return False
 		try:
@@ -567,8 +599,9 @@ class SystemValues:
 		except:
 			return False
 		return True
-	def fgetVal(self, path):
-		file = self.tpath+path
+	def fsetVal(self, val, path, mode='w'):
+		return self.setVal(val, self.tpath+path, mode)
+	def getVal(self, file):
 		res = ''
 		if not os.path.exists(file):
 			return res
@@ -579,10 +612,13 @@ class SystemValues:
 		except:
 			pass
 		return res
+	def fgetVal(self, path):
+		return self.getVal(self.tpath+path)
 	def cleanupFtrace(self):
-		if(self.usecallgraph or self.usetraceevents):
+		if(self.usecallgraph or self.usetraceevents or self.usedevsrc):
 			self.fsetVal('0', 'events/kprobes/enable')
 			self.fsetVal('', 'kprobe_events')
+			self.fsetVal('1024', 'buffer_size_kb')
 	def setupAllKprobes(self):
 		for name in self.tracefuncs:
 			self.defaultKprobe(name, self.tracefuncs[name])
@@ -599,7 +635,8 @@ class SystemValues:
 			if name == f:
 				return True
 		return False
-	def initFtrace(self, testing=False):
+	def initFtrace(self):
+		self.printSystemInfo(False)
 		print('INITIALIZING FTRACE...')
 		# turn trace off
 		self.fsetVal('0', 'tracing_on')
@@ -607,17 +644,21 @@ class SystemValues:
 		# set the trace clock to global
 		self.fsetVal('global', 'trace_clock')
 		self.fsetVal('nop', 'current_tracer')
-		# set trace buffer to a huge value
-		if self.usecallgraph or self.usedevsrc:
-			tgtsize = min(self.memtotal / 2, 2*1024*1024)
-			maxbuf = '%d' % (tgtsize / max(1, self.cpucount))
-			if self.cpucount < 1 or not self.fsetVal(maxbuf, 'buffer_size_kb'):
-				self.fsetVal('131072', 'buffer_size_kb')
+		# set trace buffer to an appropriate value
+		cpus = max(1, self.cpucount)
+		if self.bufsize > 0:
+			tgtsize = self.bufsize
+		elif self.usecallgraph or self.usedevsrc:
+			tgtsize = min(self.memfree, 3*1024*1024)
 		else:
-			self.fsetVal('16384', 'buffer_size_kb')
-		# go no further if this is just a status check
-		if testing:
-			return
+			tgtsize = 65536
+		while not self.fsetVal('%d' % (tgtsize / cpus), 'buffer_size_kb'):
+			# if the size failed to set, lower it and keep trying
+			tgtsize -= 65536
+			if tgtsize < 65536:
+				tgtsize = int(self.fgetVal('buffer_size_kb')) * cpus
+				break
+		print 'Setting trace buffers to %d kB (%d kB per cpu)' % (tgtsize, tgtsize/cpus)
 		# initialize the callgraph trace
 		if(self.usecallgraph):
 			# set trace type
@@ -635,7 +676,7 @@ class SystemValues:
 			self.fsetVal('graph-time', 'trace_options')
 			self.fsetVal('%d' % self.max_graph_depth, 'max_graph_depth')
 			cf = ['dpm_run_callback']
-			if(self.usetraceeventsonly):
+			if(self.usetraceevents):
 				cf += ['dpm_prepare', 'dpm_complete']
 			for fn in self.tracefuncs:
 				if 'func' in self.tracefuncs[fn]:
@@ -688,16 +729,65 @@ class SystemValues:
 			return str
 		return '\x1B[%d;40m%s\x1B[m' % (color, str)
 	def writeDatafileHeader(self, filename, fwdata=[]):
-		fp = open(filename, 'w')
-		fp.write(self.teststamp+'\n')
-		fp.write(self.sysstamp+'\n')
+		fp = self.openlog(filename, 'w')
+		fp.write('%s\n%s\n# command | %s\n' % (self.teststamp, self.sysstamp, self.cmdline))
 		if(self.suspendmode == 'mem' or self.suspendmode == 'command'):
 			for fw in fwdata:
 				if(fw):
 					fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
+		return fp
+	def sudouser(self, dir):
+		if os.path.exists(dir) and os.getuid() == 0 and \
+			'SUDO_USER' in os.environ:
+			cmd = 'chown -R {0}:{0} {1} > /dev/null 2>&1'
+			call(cmd.format(os.environ['SUDO_USER'], dir), shell=True)
+	def outputResult(self, testdata, num=0):
+		if not self.result:
+			return
+		n = ''
+		if num > 0:
+			n = '%d' % num
+		fp = open(self.result, 'a')
+		if 'error' in testdata:
+			fp.write('result%s: fail\n' % n)
+			fp.write('error%s: %s\n' % (n, testdata['error']))
+		else:
+			fp.write('result%s: pass\n' % n)
+		for v in ['suspend', 'resume', 'boot', 'lastinit']:
+			if v in testdata:
+				fp.write('%s%s: %.3f\n' % (v, n, testdata[v]))
+		for v in ['fwsuspend', 'fwresume']:
+			if v in testdata:
+				fp.write('%s%s: %.3f\n' % (v, n, testdata[v] / 1000000.0))
+		if 'bugurl' in testdata:
+			fp.write('url%s: %s\n' % (n, testdata['bugurl']))
 		fp.close()
+		self.sudouser(self.result)
+	def configFile(self, file):
+		dir = os.path.dirname(os.path.realpath(__file__))
+		if os.path.exists(file):
+			return file
+		elif os.path.exists(dir+'/'+file):
+			return dir+'/'+file
+		elif os.path.exists(dir+'/config/'+file):
+			return dir+'/config/'+file
+		return ''
+	def openlog(self, filename, mode):
+		isgz = self.gzip
+		if mode == 'r':
+			try:
+				with gzip.open(filename, mode+'b') as fp:
+					test = fp.read(64)
+				isgz = True
+			except:
+				isgz = False
+		if isgz:
+			return gzip.open(filename, mode+'b')
+		return open(filename, mode)
 
 sysvals = SystemValues()
+switchvalues = ['enable', 'disable', 'on', 'off', 'true', 'false', '1', '0']
+switchoff = ['disable', 'off', 'false', '0']
 suspendmodename = {
 	'freeze': 'Freeze (S0)',
 	'standby': 'Standby (S1)',
@@ -826,34 +916,65 @@ class Data:
 		for phase in self.phases:
 			self.devicegroups.append([phase])
 		self.errorinfo = {'suspend':[],'resume':[]}
-	def extractErrorInfo(self, dmesg):
-		error = ''
-		tm = 0.0
-		for i in range(len(dmesg)):
-			if 'Call Trace:' in dmesg[i]:
-				m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) .*', dmesg[i])
-				if not m:
-					continue
-				tm = float(m.group('ktime'))
-				if tm < self.start or tm > self.end:
-					continue
-				for j in range(i-10, i+1):
-					error += dmesg[j]
+	def extractErrorInfo(self):
+		lf = sysvals.openlog(sysvals.dmesgfile, 'r')
+		i = 0
+		list = []
+		# sl = start line, et = error time, el = error line
+		type = 'ERROR'
+		sl = et = el = -1
+		for line in lf:
+			i += 1
+			m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+			if not m:
 				continue
-			if error:
-				m = re.match('[ \t]*\[ *[0-9\.]*\]  \[\<[0-9a-fA-F]*\>\] .*', dmesg[i])
-				if m:
-					error += dmesg[i]
-				else:
-					if tm < self.tSuspended:
-						dir = 'suspend'
-					else:
-						dir = 'resume'
-					error = error.replace('<', '&lt').replace('>', '&gt')
-					vprint('kernel error found in %s at %f' % (dir, tm))
-					self.errorinfo[dir].append((tm, error))
+			t = float(m.group('ktime'))
+			if t < self.start or t > self.end:
+				continue
+			if t < self.tSuspended:
+				dir = 'suspend'
+			else:
+				dir = 'resume'
+			msg = m.group('msg')
+			if re.match('-*\[ *cut here *\]-*', msg):
+				type = 'WARNING'
+				sl = i
+			elif re.match('genirq: .*', msg):
+				type = 'IRQ'
+				sl = i
+			elif re.match('BUG: .*', msg) or re.match('kernel BUG .*', msg):
+				type = 'BUG'
+				sl = i
+			elif re.match('-*\[ *end trace .*\]-*', msg) or \
+				re.match('R13: .*', msg):
+				if et >= 0 and sl >= 0:
+					list.append((type, dir, et, sl, i))
 					self.kerror = True
-					error = ''
+					sl = et = el = -1
+					type = 'ERROR'
+			elif 'Call Trace:' in msg:
+				if el >= 0 and et >= 0:
+					list.append((type, dir, et, el, el))
+					self.kerror = True
+				et, el = t, i
+				if sl < 0 or type == 'BUG':
+					slval = i
+					if sl >= 0:
+						slval = sl
+					list.append((type, dir, et, slval, i))
+					self.kerror = True
+					sl = et = el = -1
+					type = 'ERROR'
+		if el >= 0 and et >= 0:
+			list.append((type, dir, et, el, el))
+			self.kerror = True
+		for e in list:
+			type, dir, t, idx1, idx2 = e
+			sysvals.vprint('kernel %s found in %s at %f' % (type, dir, t))
+			self.errorinfo[dir].append((type, t, idx1, idx2))
+		if self.kerror:
+			sysvals.dmesglog = True
+		lf.close()
 	def setStart(self, time):
 		self.start = time
 	def setEnd(self, time):
@@ -867,6 +988,14 @@ class Data:
 					time < d['end']):
 					return False
 		return True
+	def phaseCollision(self, phase, isbegin, line):
+		key = 'end'
+		if isbegin:
+			key = 'start'
+		if self.dmesg[phase][key] >= 0:
+			sysvals.vprint('IGNORE: %s' % line.strip())
+			return True
+		return False
 	def sourcePhase(self, start):
 		for phase in self.phases:
 			pend = self.dmesg[phase]['end']
@@ -918,7 +1047,7 @@ class Data:
 			return self.addDeviceFunctionCall(displayname, kprobename, proc, pid, start, end, cdata, rdata)
 		# this should not happen
 		if not tgtdev:
-			vprint('[%f - %f] %s-%d %s %s %s' % \
+			sysvals.vprint('[%f - %f] %s-%d %s %s %s' % \
 				(start, end, proc, pid, kprobename, cdata, rdata))
 			return False
 		# place the call data inside the src element of the tgtdev
@@ -1054,6 +1183,13 @@ class Data:
 				if('src' in d):
 					for e in d['src']:
 						e.time = self.trimTimeVal(e.time, t0, dT, left)
+		for dir in ['suspend', 'resume']:
+			list = []
+			for e in self.errorinfo[dir]:
+				type, tm, idx1, idx2 = e
+				tm = self.trimTimeVal(tm, t0, dT, left)
+				list.append((type, tm, idx1, idx2))
+			self.errorinfo[dir] = list
 	def normalizeTime(self, tZero):
 		# trim out any standby or freeze clock time
 		if(self.tSuspended != self.tResumed):
@@ -1100,7 +1236,7 @@ class Data:
 					if self.dmesg[p]['end'] > dev['start']:
 						dev['end'] = self.dmesg[p]['end']
 						break
-				vprint('%s (%s): callback didnt return' % (devname, phase))
+				sysvals.vprint('%s (%s): callback didnt return' % (devname, phase))
 	def deviceFilter(self, devicefilter):
 		for phase in self.phases:
 			list = self.dmesg[phase]['list']
@@ -1200,15 +1336,15 @@ class Data:
 				devlist.append(child)
 		return devlist
 	def printDetails(self):
-		vprint('Timeline Details:')
-		vprint('          test start: %f' % self.start)
-		vprint('kernel suspend start: %f' % self.tKernSus)
+		sysvals.vprint('Timeline Details:')
+		sysvals.vprint('          test start: %f' % self.start)
+		sysvals.vprint('kernel suspend start: %f' % self.tKernSus)
 		for phase in self.phases:
 			dc = len(self.dmesg[phase]['list'])
-			vprint('    %16s: %f - %f (%d devices)' % (phase, \
+			sysvals.vprint('    %16s: %f - %f (%d devices)' % (phase, \
 				self.dmesg[phase]['start'], self.dmesg[phase]['end'], dc))
-		vprint('   kernel resume end: %f' % self.tKernRes)
-		vprint('            test end: %f' % self.end)
+		sysvals.vprint('   kernel resume end: %f' % self.tKernRes)
+		sysvals.vprint('            test end: %f' % self.end)
 	def deviceChildrenAllPhases(self, devname):
 		devlist = []
 		for phase in self.phases:
@@ -1358,14 +1494,21 @@ class Data:
 				tres.append(t)
 		# process the events for suspend and resume
 		if len(proclist) > 0:
-			vprint('Process Execution:')
+			sysvals.vprint('Process Execution:')
 		for ps in proclist:
 			c = self.addProcessUsageEvent(ps, tsus)
 			if c > 0:
-				vprint('%25s (sus): %d' % (ps, c))
+				sysvals.vprint('%25s (sus): %d' % (ps, c))
 			c = self.addProcessUsageEvent(ps, tres)
 			if c > 0:
-				vprint('%25s (res): %d' % (ps, c))
+				sysvals.vprint('%25s (res): %d' % (ps, c))
+	def debugPrint(self):
+		for p in self.phases:
+			list = self.dmesg[p]['list']
+			for devname in list:
+				dev = list[devname]
+				if 'ftrace' in dev:
+					dev['ftrace'].debugPrint(' [%s]' % devname)
 
 # Class: DevFunction
 # Description:
@@ -1504,18 +1647,24 @@ class FTraceLine:
 			# something else (possibly a trace marker)
 			else:
 				self.name = m
+	def isCall(self):
+		return self.fcall and not self.freturn
+	def isReturn(self):
+		return self.freturn and not self.fcall
+	def isLeaf(self):
+		return self.fcall and self.freturn
 	def getDepth(self, str):
 		return len(str)/2
-	def debugPrint(self, dev=''):
-		if(self.freturn and self.fcall):
-			print('%s -- %f (%02d): %s(); (%.3f us)' % (dev, self.time, \
-				self.depth, self.name, self.length*1000000))
-		elif(self.freturn):
-			print('%s -- %f (%02d): %s} (%.3f us)' % (dev, self.time, \
-				self.depth, self.name, self.length*1000000))
+	def debugPrint(self, info=''):
+		if self.isLeaf():
+			print(' -- %12.6f (depth=%02d): %s(); (%.3f us) %s' % (self.time, \
+				self.depth, self.name, self.length*1000000, info))
+		elif self.freturn:
+			print(' -- %12.6f (depth=%02d): %s} (%.3f us) %s' % (self.time, \
+				self.depth, self.name, self.length*1000000, info))
 		else:
-			print('%s -- %f (%02d): %s() { (%.3f us)' % (dev, self.time, \
-				self.depth, self.name, self.length*1000000))
+			print(' -- %12.6f (depth=%02d): %s() { (%.3f us) %s' % (self.time, \
+				self.depth, self.name, self.length*1000000, info))
 	def startMarker(self):
 		# Is this the starting line of a suspend?
 		if not self.fevent:
@@ -1558,107 +1707,160 @@ class FTraceCallGraph:
 	depth = 0
 	pid = 0
 	name = ''
-	def __init__(self, pid):
+	partial = False
+	vfname = 'missing_function_name'
+	ignore = False
+	sv = 0
+	def __init__(self, pid, sv):
 		self.start = -1.0
 		self.end = -1.0
 		self.list = []
 		self.depth = 0
 		self.pid = pid
-	def addLine(self, line, debug=False):
+		self.sv = sv
+	def addLine(self, line):
 		# if this is already invalid, just leave
 		if(self.invalid):
-			return False
-		# invalidate on too much data or bad depth
-		if(len(self.list) >= 1000000 or self.depth < 0):
+			if(line.depth == 0 and line.freturn):
+				return 1
+			return 0
+		# invalidate on bad depth
+		if(self.depth < 0):
 			self.invalidate(line)
-			return False
+			return 0
+		# ignore data til we return to the current depth
+		if self.ignore:
+			if line.depth > self.depth:
+				return 0
+			else:
+				self.list[-1].freturn = True
+				self.list[-1].length = line.time - self.list[-1].time
+				self.ignore = False
+				# if this is a return at self.depth, no more work is needed
+				if line.depth == self.depth and line.isReturn():
+					if line.depth == 0:
+						self.end = line.time
+						return 1
+					return 0
 		# compare current depth with this lines pre-call depth
 		prelinedep = line.depth
-		if(line.freturn and not line.fcall):
+		if line.isReturn():
 			prelinedep += 1
 		last = 0
 		lasttime = line.time
-		virtualfname = 'missing_function_name'
 		if len(self.list) > 0:
 			last = self.list[-1]
 			lasttime = last.time
+			if last.isLeaf():
+				lasttime += last.length
 		# handle low misalignments by inserting returns
-		if prelinedep < self.depth:
-			if debug and last:
-				print '-------- task %d --------' % self.pid
-				last.debugPrint()
+		mismatch = prelinedep - self.depth
+		warning = self.sv.verbose and abs(mismatch) > 1
+		info = []
+		if mismatch < 0:
 			idx = 0
 			# add return calls to get the depth down
 			while prelinedep < self.depth:
-				if debug:
-					print 'MISALIGN LOW (add returns): C%d - eC%d' % (self.depth, prelinedep)
 				self.depth -= 1
-				if idx == 0 and last and last.fcall and not last.freturn:
+				if idx == 0 and last and last.isCall():
 					# special case, turn last call into a leaf
 					last.depth = self.depth
 					last.freturn = True
 					last.length = line.time - last.time
-					if debug:
-						last.debugPrint()
+					if warning:
+						info.append(('[make leaf]', last))
 				else:
 					vline = FTraceLine(lasttime)
 					vline.depth = self.depth
-					vline.name = virtualfname
+					vline.name = self.vfname
 					vline.freturn = True
 					self.list.append(vline)
-					if debug:
-						vline.debugPrint()
+					if warning:
+						if idx == 0:
+							info.append(('', last))
+						info.append(('[add return]', vline))
 				idx += 1
-			if debug:
-				line.debugPrint()
-				print ''
+			if warning:
+				info.append(('', line))
 		# handle high misalignments by inserting calls
-		elif prelinedep > self.depth:
-			if debug and last:
-				print '-------- task %d --------' % self.pid
-				last.debugPrint()
+		elif mismatch > 0:
 			idx = 0
+			if warning:
+				info.append(('', last))
 			# add calls to get the depth up
 			while prelinedep > self.depth:
-				if debug:
-					print 'MISALIGN HIGH (add calls): C%d - eC%d' % (self.depth, prelinedep)
-				if idx == 0 and line.freturn and not line.fcall:
+				if idx == 0 and line.isReturn():
 					# special case, turn this return into a leaf
 					line.fcall = True
 					prelinedep -= 1
+					if warning:
+						info.append(('[make leaf]', line))
 				else:
 					vline = FTraceLine(lasttime)
 					vline.depth = self.depth
-					vline.name = virtualfname
+					vline.name = self.vfname
 					vline.fcall = True
-					if debug:
-						vline.debugPrint()
 					self.list.append(vline)
 					self.depth += 1
 					if not last:
 						self.start = vline.time
+					if warning:
+						info.append(('[add call]', vline))
 				idx += 1
-			if debug:
-				line.debugPrint()
-				print ''
+			if warning and ('[make leaf]', line) not in info:
+				info.append(('', line))
+		if warning:
+			print 'WARNING: ftrace data missing, corrections made:'
+			for i in info:
+				t, obj = i
+				if obj:
+					obj.debugPrint(t)
 		# process the call and set the new depth
-		if(line.fcall and not line.freturn):
-			self.depth += 1
-		elif(line.freturn and not line.fcall):
+		skipadd = False
+		md = self.sv.max_graph_depth
+		if line.isCall():
+			# ignore blacklisted/overdepth funcs
+			if (md and self.depth >= md - 1) or (line.name in self.sv.cgblacklist):
+				self.ignore = True
+			else:
+				self.depth += 1
+		elif line.isReturn():
 			self.depth -= 1
+			# remove blacklisted/overdepth/empty funcs that slipped through
+			if (last and last.isCall() and last.depth == line.depth) or \
+				(md and last and last.depth >= md) or \
+				(line.name in self.sv.cgblacklist):
+				while len(self.list) > 0 and self.list[-1].depth > line.depth:
+					self.list.pop(-1)
+				if len(self.list) == 0:
+					self.invalid = True
+					return 1
+				self.list[-1].freturn = True
+				self.list[-1].length = line.time - self.list[-1].time
+				self.list[-1].name = line.name
+				skipadd = True
 		if len(self.list) < 1:
 			self.start = line.time
-		self.list.append(line)
+		# check for a mismatch that returned all the way to callgraph end
+		res = 1
+		if mismatch < 0 and self.list[-1].depth == 0 and self.list[-1].freturn:
+			line = self.list[-1]
+			skipadd = True
+			res = -1
+		if not skipadd:
+			self.list.append(line)
 		if(line.depth == 0 and line.freturn):
 			if(self.start < 0):
 				self.start = line.time
 			self.end = line.time
 			if line.fcall:
 				self.end += line.length
-			if self.list[0].name == virtualfname:
+			if self.list[0].name == self.vfname:
 				self.invalid = True
-			return True
-		return False
+			if res == -1:
+				self.partial = True
+			return res
+		return 0
 	def invalidate(self, line):
 		if(len(self.list) > 0):
 			first = self.list[0]
@@ -1668,29 +1870,30 @@ class FTraceCallGraph:
 		id = 'task %s' % (self.pid)
 		window = '(%f - %f)' % (self.start, line.time)
 		if(self.depth < 0):
-			vprint('Too much data for '+id+\
+			print('Data misalignment for '+id+\
 				' (buffer overflow), ignoring this callback')
 		else:
-			vprint('Too much data for '+id+\
+			print('Too much data for '+id+\
 				' '+window+', ignoring this callback')
-	def slice(self, t0, tN):
-		minicg = FTraceCallGraph(0)
-		count = -1
-		firstdepth = 0
+	def slice(self, dev):
+		minicg = FTraceCallGraph(dev['pid'], self.sv)
+		minicg.name = self.name
+		mydepth = -1
+		good = False
 		for l in self.list:
-			if(l.time < t0 or l.time > tN):
+			if(l.time < dev['start'] or l.time > dev['end']):
 				continue
-			if(count < 0):
-				if(not l.fcall or l.name == 'dev_driver_string'):
-					continue
-				firstdepth = l.depth
-				count = 0
-			l.depth -= firstdepth
-			minicg.addLine(l)
-			if((count == 0 and l.freturn and l.fcall) or
-				(count > 0 and l.depth <= 0)):
+			if mydepth < 0:
+				if l.name == 'mutex_lock' and l.freturn:
+					mydepth = l.depth
+				continue
+			elif l.depth == mydepth and l.name == 'mutex_unlock' and l.fcall:
+				good = True
 				break
-			count += 1
+			l.depth -= mydepth
+			minicg.addLine(l)
+		if not good or len(minicg.list) < 1:
+			return 0
 		return minicg
 	def repair(self, enddepth):
 		# bring the depth back to 0 with additional returns
@@ -1701,11 +1904,11 @@ class FTraceCallGraph:
 			t.depth = i
 			t.freturn = True
 			fixed = self.addLine(t)
-			if fixed:
+			if fixed != 0:
 				self.end = last.time
 				return True
 		return False
-	def postProcess(self, debug=False):
+	def postProcess(self):
 		if len(self.list) > 0:
 			self.name = self.list[0].name
 		stack = dict()
@@ -1714,20 +1917,23 @@ class FTraceCallGraph:
 		for l in self.list:
 			# ftrace bug: reported duration is not reliable
 			# check each leaf and clip it at max possible length
-			if(last and last.freturn and last.fcall):
+			if last and last.isLeaf():
 				if last.length > l.time - last.time:
 					last.length = l.time - last.time
-			if(l.fcall and not l.freturn):
+			if l.isCall():
 				stack[l.depth] = l
 				cnt += 1
-			elif(l.freturn and not l.fcall):
+			elif l.isReturn():
 				if(l.depth not in stack):
-					if debug:
+					if self.sv.verbose:
 						print 'Post Process Error: Depth missing'
 						l.debugPrint()
 					return False
 				# calculate call length from call/return lines
-				stack[l.depth].length = l.time - stack[l.depth].time
+				cl = stack[l.depth]
+				cl.length = l.time - cl.time
+				if cl.name == self.vfname:
+					cl.name = l.name
 				stack.pop(l.depth)
 				l.length = 0
 				cnt -= 1
@@ -1736,13 +1942,13 @@ class FTraceCallGraph:
 			# trace caught the whole call tree
 			return True
 		elif(cnt < 0):
-			if debug:
+			if self.sv.verbose:
 				print 'Post Process Error: Depth is less than 0'
 			return False
 		# trace ended before call tree finished
 		return self.repair(cnt)
 	def deviceMatch(self, pid, data):
-		found = False
+		found = ''
 		# add the callgraph data to the device hierarchy
 		borderphase = {
 			'dpm_prepare': 'suspend_prepare',
@@ -1756,8 +1962,10 @@ class FTraceCallGraph:
 				if(pid == dev['pid'] and
 					self.start <= dev['start'] and
 					self.end >= dev['end']):
-					dev['ftrace'] = self.slice(dev['start'], dev['end'])
-					found = True
+					cg = self.slice(dev)
+					if cg:
+						dev['ftrace'] = cg
+					found = devname
 			return found
 		for p in data.phases:
 			if(data.dmesg[p]['start'] <= self.start and
@@ -1769,7 +1977,7 @@ class FTraceCallGraph:
 						self.start <= dev['start'] and
 						self.end >= dev['end']):
 						dev['ftrace'] = self
-						found = True
+						found = devname
 						break
 				break
 		return found
@@ -1793,18 +2001,20 @@ class FTraceCallGraph:
 		if out:
 			phase, myname = out
 			data.dmesg[phase]['list'][myname]['ftrace'] = self
-	def debugPrint(self):
-		print('[%f - %f] %s (%d)') % (self.start, self.end, self.name, self.pid)
+	def debugPrint(self, info=''):
+		print('%s pid=%d [%f - %f] %.3f us') % \
+			(self.name, self.pid, self.start, self.end,
+			(self.end - self.start)*1000000)
 		for l in self.list:
-			if(l.freturn and l.fcall):
-				print('%f (%02d): %s(); (%.3f us)' % (l.time, \
-					l.depth, l.name, l.length*1000000))
-			elif(l.freturn):
-				print('%f (%02d): %s} (%.3f us)' % (l.time, \
-					l.depth, l.name, l.length*1000000))
+			if l.isLeaf():
+				print('%f (%02d): %s(); (%.3f us)%s' % (l.time, \
+					l.depth, l.name, l.length*1000000, info))
+			elif l.freturn:
+				print('%f (%02d): %s} (%.3f us)%s' % (l.time, \
+					l.depth, l.name, l.length*1000000, info))
 			else:
-				print('%f (%02d): %s() { (%.3f us)' % (l.time, \
-					l.depth, l.name, l.length*1000000))
+				print('%f (%02d): %s() { (%.3f us)%s' % (l.time, \
+					l.depth, l.name, l.length*1000000, info))
 		print(' ')
 
 class DevItem:
@@ -1839,8 +2049,8 @@ class Timeline:
 		self.rowH = rowheight
 		self.scaleH = scaleheight
 		self.html = ''
-	def createHeader(self, sv):
-		if(not sv.stamp['time']):
+	def createHeader(self, sv, stamp):
+		if(not stamp['time']):
 			return
 		self.html += '<div class="version"><a href="https://01.org/suspendresume">%s v%s</a></div>' \
 			% (sv.title, sv.version)
@@ -1851,12 +2061,12 @@ class Timeline:
 		if sv.ftracelog:
 			self.html += '<button id="showftrace" class="logbtn btnfmt">ftrace</button>'
 		headline_stamp = '<div class="stamp">{0} {1} {2} {3}</div>\n'
-		self.html += headline_stamp.format(sv.stamp['host'], sv.stamp['kernel'],
-			sv.stamp['mode'], sv.stamp['time'])
-		if 'man' in sv.stamp and 'plat' in sv.stamp and 'cpu' in sv.stamp:
+		self.html += headline_stamp.format(stamp['host'], stamp['kernel'],
+			stamp['mode'], stamp['time'])
+		if 'man' in stamp and 'plat' in stamp and 'cpu' in stamp and \
+			stamp['man'] and stamp['plat'] and stamp['cpu']:
 			headline_sysinfo = '<div class="stamp sysinfo">{0} {1} <i>with</i> {2}</div>\n'
-			self.html += headline_sysinfo.format(sv.stamp['man'],
-				sv.stamp['plat'], sv.stamp['cpu'])
+			self.html += headline_sysinfo.format(stamp['man'], stamp['plat'], stamp['cpu'])
 
 	# Function: getDeviceRows
 	# Description:
@@ -2067,12 +2277,16 @@ class Timeline:
 class TestProps:
 	stamp = ''
 	sysinfo = ''
+	cmdline = ''
+	kparams = ''
 	S0i3 = False
 	fwdata = []
 	stampfmt = '# [a-z]*-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
 				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
 				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
 	sysinfofmt = '^# sysinfo .*'
+	cmdlinefmt = '^# command \| (?P<cmd>.*)'
+	kparamsfmt = '^# kparams \| (?P<kp>.*)'
 	ftrace_line_fmt_fg = \
 		'^ *(?P<time>[0-9\.]*) *\| *(?P<cpu>[0-9]*)\)'+\
 		' *(?P<proc>.*)-(?P<pid>[0-9]*) *\|'+\
@@ -2116,13 +2330,20 @@ class TestProps:
 		sv.hostname = data.stamp['host']
 		sv.suspendmode = data.stamp['mode']
 		if sv.suspendmode == 'command' and sv.ftracefile != '':
-			modes = ['on', 'freeze', 'standby', 'mem']
-			out = Popen(['grep', 'suspend_enter', sv.ftracefile],
+			modes = ['on', 'freeze', 'standby', 'mem', 'disk']
+			out = Popen(['grep', 'machine_suspend', sv.ftracefile],
 				stderr=PIPE, stdout=PIPE).stdout.read()
-			m = re.match('.* suspend_enter\[(?P<mode>.*)\]', out)
-			if m and m.group('mode') in ['1', '2', '3']:
+			m = re.match('.* machine_suspend\[(?P<mode>.*)\]', out)
+			if m and m.group('mode') in ['1', '2', '3', '4']:
 				sv.suspendmode = modes[int(m.group('mode'))]
 				data.stamp['mode'] = sv.suspendmode
+		m = re.match(self.cmdlinefmt, self.cmdline)
+		if m:
+			sv.cmdline = m.group('cmd')
+		if self.kparams:
+			m = re.match(self.kparamsfmt, self.kparams)
+			if m:
+				sv.kparams = m.group('kp')
 		if not sv.stamp:
 			sv.stamp = data.stamp
 
@@ -2186,47 +2407,43 @@ class ProcessMonitor:
 
 # ----------------- FUNCTIONS --------------------
 
-# Function: vprint
-# Description:
-#	 verbose print (prints only with -verbose option)
-# Arguments:
-#	 msg: the debug/log message to print
-def vprint(msg):
-	sysvals.logmsg += msg+'\n'
-	if(sysvals.verbose):
-		print(msg)
-
 # Function: doesTraceLogHaveTraceEvents
 # Description:
-#	 Quickly determine if the ftrace log has some or all of the trace events
-#	 required for primary parsing. Set the usetraceevents and/or
-#	 usetraceeventsonly flags in the global sysvals object
+#	 Quickly determine if the ftrace log has all of the trace events,
+#	 markers, and/or kprobes required for primary parsing.
 def doesTraceLogHaveTraceEvents():
-	# check for kprobes
+	kpcheck = ['_cal: (', '_cpu_down()']
+	techeck = sysvals.traceevents[:]
+	tmcheck = ['SUSPEND START', 'RESUME COMPLETE']
 	sysvals.usekprobes = False
-	out = call('grep -q "_cal: (" '+sysvals.ftracefile, shell=True)
-	if(out == 0):
-		sysvals.usekprobes = True
-	# check for callgraph data on trace event blocks
-	out = call('grep -q "_cpu_down()" '+sysvals.ftracefile, shell=True)
-	if(out == 0):
-		sysvals.usekprobes = True
-	out = Popen(['head', '-1', sysvals.ftracefile],
-		stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
-	# figure out what level of trace events are supported
-	sysvals.usetraceeventsonly = True
-	sysvals.usetraceevents = False
-	for e in sysvals.traceevents:
-		out = call('grep -q "'+e+': " '+sysvals.ftracefile, shell=True)
-		if(out != 0):
-			sysvals.usetraceeventsonly = False
-		if(e == 'suspend_resume' and out == 0):
-			sysvals.usetraceevents = True
-	# determine is this log is properly formatted
-	for e in ['SUSPEND START', 'RESUME COMPLETE']:
-		out = call('grep -q "'+e+'" '+sysvals.ftracefile, shell=True)
-		if(out != 0):
-			sysvals.usetracemarkers = False
+	fp = sysvals.openlog(sysvals.ftracefile, 'r')
+	for line in fp:
+		# check for kprobes
+		if not sysvals.usekprobes:
+			for i in kpcheck:
+				if i in line:
+					sysvals.usekprobes = True
+		# check for all necessary trace events
+		check = techeck[:]
+		for i in techeck:
+			if i in line:
+				check.remove(i)
+		techeck = check
+		# check for all necessary trace markers
+		check = tmcheck[:]
+		for i in tmcheck:
+			if i in line:
+				check.remove(i)
+		tmcheck = check
+	fp.close()
+	if len(techeck) == 0:
+		sysvals.usetraceevents = True
+	else:
+		sysvals.usetraceevents = False
+	if len(tmcheck) == 0:
+		sysvals.usetracemarkers = True
+	else:
+		sysvals.usetracemarkers = False
 
 # Function: appendIncompleteTraceLog
 # Description:
@@ -2247,9 +2464,10 @@ def appendIncompleteTraceLog(testruns):
 		testrun.append(TestRun(data))
 
 	# extract the callgraph and traceevent data
-	vprint('Analyzing the ftrace data...')
+	sysvals.vprint('Analyzing the ftrace data (%s)...' % \
+		os.path.basename(sysvals.ftracefile))
 	tp = TestProps()
-	tf = open(sysvals.ftracefile, 'r')
+	tf = sysvals.openlog(sysvals.ftracefile, 'r')
 	data = 0
 	for line in tf:
 		# remove any latent carriage returns
@@ -2261,6 +2479,9 @@ def appendIncompleteTraceLog(testruns):
 		elif re.match(tp.sysinfofmt, line):
 			tp.sysinfo = line
 			continue
+		elif re.match(tp.cmdlinefmt, line):
+			tp.cmdline = line
+			continue
 		# determine the trace data type (required for further parsing)
 		m = re.match(sysvals.tracertypefmt, line)
 		if(m):
@@ -2393,11 +2614,14 @@ def appendIncompleteTraceLog(testruns):
 			# create a callgraph object for the data
 			if(pid not in testrun[testidx].ftemp):
 				testrun[testidx].ftemp[pid] = []
-				testrun[testidx].ftemp[pid].append(FTraceCallGraph(pid))
+				testrun[testidx].ftemp[pid].append(FTraceCallGraph(pid, sysvals))
 			# when the call is finished, see which device matches it
 			cg = testrun[testidx].ftemp[pid][-1]
-			if(cg.addLine(t)):
-				testrun[testidx].ftemp[pid].append(FTraceCallGraph(pid))
+			res = cg.addLine(t)
+			if(res != 0):
+				testrun[testidx].ftemp[pid].append(FTraceCallGraph(pid, sysvals))
+			if(res == -1):
+				testrun[testidx].ftemp[pid][-1].addLine(t)
 	tf.close()
 
 	for test in testrun:
@@ -2410,11 +2634,11 @@ def appendIncompleteTraceLog(testruns):
 		# add the callgraph data to the device hierarchy
 		for pid in test.ftemp:
 			for cg in test.ftemp[pid]:
-				if len(cg.list) < 1 or cg.invalid:
+				if len(cg.list) < 1 or cg.invalid or (cg.end - cg.start == 0):
 					continue
 				if(not cg.postProcess()):
 					id = 'task %s cpu %s' % (pid, m.group('cpu'))
-					vprint('Sanity check failed for '+\
+					sysvals.vprint('Sanity check failed for '+\
 						id+', ignoring this callback')
 					continue
 				callstart = cg.start
@@ -2431,8 +2655,6 @@ def appendIncompleteTraceLog(testruns):
 								dev['ftrace'] = cg
 						break
 
-		test.data.printDetails()
-
 # Function: parseTraceLog
 # Description:
 #	 Analyze an ftrace log output file generated from this app during
@@ -2441,12 +2663,13 @@ def appendIncompleteTraceLog(testruns):
 #	 The ftrace filename is taken from sysvals
 # Output:
 #	 An array of Data objects
-def parseTraceLog():
-	vprint('Analyzing the ftrace data...')
+def parseTraceLog(live=False):
+	sysvals.vprint('Analyzing the ftrace data (%s)...' % \
+		os.path.basename(sysvals.ftracefile))
 	if(os.path.exists(sysvals.ftracefile) == False):
 		doError('%s does not exist' % sysvals.ftracefile)
-
-	sysvals.setupAllKprobes()
+	if not live:
+		sysvals.setupAllKprobes()
 	tracewatch = []
 	if sysvals.usekprobes:
 		tracewatch += ['sync_filesystems', 'freeze_processes', 'syscore_suspend',
@@ -2458,7 +2681,7 @@ def parseTraceLog():
 	testdata = []
 	testrun = 0
 	data = 0
-	tf = open(sysvals.ftracefile, 'r')
+	tf = sysvals.openlog(sysvals.ftracefile, 'r')
 	phase = 'suspend_prepare'
 	for line in tf:
 		# remove any latent carriage returns
@@ -2470,6 +2693,9 @@ def parseTraceLog():
 		elif re.match(tp.sysinfofmt, line):
 			tp.sysinfo = line
 			continue
+		elif re.match(tp.cmdlinefmt, line):
+			tp.cmdline = line
+			continue
 		# firmware line: pull out any firmware data
 		m = re.match(sysvals.firmwarefmt, line)
 		if(m):
@@ -2591,6 +2817,8 @@ def parseTraceLog():
 					phase = 'suspend_prepare'
 					if(not isbegin):
 						data.dmesg[phase]['end'] = t.time
+						if data.dmesg[phase]['start'] < 0:
+							data.dmesg[phase]['start'] = data.start
 					continue
 				# suspend start
 				elif(re.match('dpm_suspend\[.*', t.name)):
@@ -2604,6 +2832,8 @@ def parseTraceLog():
 					continue
 				# suspend_noirq start
 				elif(re.match('dpm_suspend_noirq\[.*', t.name)):
+					if data.phaseCollision('suspend_noirq', isbegin, line):
+						continue
 					phase = 'suspend_noirq'
 					data.setPhase(phase, t.time, isbegin)
 					if(not isbegin):
@@ -2636,6 +2866,8 @@ def parseTraceLog():
 					continue
 				# resume_noirq start
 				elif(re.match('dpm_resume_noirq\[.*', t.name)):
+					if data.phaseCollision('resume_noirq', isbegin, line):
+						continue
 					phase = 'resume_noirq'
 					data.setPhase(phase, t.time, isbegin)
 					if(isbegin):
@@ -2742,11 +2974,14 @@ def parseTraceLog():
 			key = (m_proc, pid)
 			if(key not in testrun.ftemp):
 				testrun.ftemp[key] = []
-				testrun.ftemp[key].append(FTraceCallGraph(pid))
+				testrun.ftemp[key].append(FTraceCallGraph(pid, sysvals))
 			# when the call is finished, see which device matches it
 			cg = testrun.ftemp[key][-1]
-			if(cg.addLine(t)):
-				testrun.ftemp[key].append(FTraceCallGraph(pid))
+			res = cg.addLine(t)
+			if(res != 0):
+				testrun.ftemp[key].append(FTraceCallGraph(pid, sysvals))
+			if(res == -1):
+				testrun.ftemp[key][-1].addLine(t)
 	tf.close()
 
 	if sysvals.suspendmode == 'command':
@@ -2812,28 +3047,31 @@ def parseTraceLog():
 			for key in test.ftemp:
 				proc, pid = key
 				for cg in test.ftemp[key]:
-					if len(cg.list) < 1 or cg.invalid:
+					if len(cg.list) < 1 or cg.invalid or (cg.end - cg.start == 0):
 						continue
 					if(not cg.postProcess()):
 						id = 'task %s' % (pid)
-						vprint('Sanity check failed for '+\
+						sysvals.vprint('Sanity check failed for '+\
 							id+', ignoring this callback')
 						continue
 					# match cg data to devices
-					if sysvals.suspendmode == 'command' or not cg.deviceMatch(pid, data):
+					devname = ''
+					if sysvals.suspendmode != 'command':
+						devname = cg.deviceMatch(pid, data)
+					if not devname:
 						sortkey = '%f%f%d' % (cg.start, cg.end, pid)
 						sortlist[sortkey] = cg
+					elif len(cg.list) > 1000000:
+						print 'WARNING: the callgraph for %s is massive (%d lines)' %\
+							(devname, len(cg.list))
 			# create blocks for orphan cg data
 			for sortkey in sorted(sortlist):
 				cg = sortlist[sortkey]
 				name = cg.name
 				if sysvals.isCallgraphFunc(name):
-					vprint('Callgraph found for task %d: %.3fms, %s' % (cg.pid, (cg.end - cg.start)*1000, name))
+					sysvals.vprint('Callgraph found for task %d: %.3fms, %s' % (cg.pid, (cg.end - cg.start)*1000, name))
 					cg.newActionFromFunction(data)
-
 	if sysvals.suspendmode == 'command':
-		for data in testdata:
-			data.printDetails()
 		return testdata
 
 	# fill in any missing phases
@@ -2841,7 +3079,7 @@ def parseTraceLog():
 		lp = data.phases[0]
 		for p in data.phases:
 			if(data.dmesg[p]['start'] < 0 and data.dmesg[p]['end'] < 0):
-				vprint('WARNING: phase "%s" is missing!' % p)
+				sysvals.vprint('WARNING: phase "%s" is missing!' % p)
 			if(data.dmesg[p]['start'] < 0):
 				data.dmesg[p]['start'] = data.dmesg[lp]['end']
 				if(p == 'resume_machine'):
@@ -2859,7 +3097,6 @@ def parseTraceLog():
 		data.fixupInitcallsThatDidntReturn()
 		if sysvals.usedevsrc:
 			data.optimizeDevSrc()
-		data.printDetails()
 
 	# x2: merge any overlapping devices between test runs
 	if sysvals.usedevsrc and len(testdata) > 1:
@@ -2878,19 +3115,18 @@ def parseTraceLog():
 #	 The dmesg filename is taken from sysvals
 # Output:
 #	 An array of empty Data objects with only their dmesgtext attributes set
-def loadKernelLog(justtext=False):
-	vprint('Analyzing the dmesg data...')
+def loadKernelLog():
+	sysvals.vprint('Analyzing the dmesg data (%s)...' % \
+		os.path.basename(sysvals.dmesgfile))
 	if(os.path.exists(sysvals.dmesgfile) == False):
 		doError('%s does not exist' % sysvals.dmesgfile)
 
-	if justtext:
-		dmesgtext = []
 	# there can be multiple test runs in a single file
 	tp = TestProps()
 	tp.stamp = datetime.now().strftime('# suspend-%m%d%y-%H%M%S localhost mem unknown')
 	testruns = []
 	data = 0
-	lf = open(sysvals.dmesgfile, 'r')
+	lf = sysvals.openlog(sysvals.dmesgfile, 'r')
 	for line in lf:
 		line = line.replace('\r\n', '')
 		idx = line.find('[')
@@ -2903,6 +3139,9 @@ def loadKernelLog(justtext=False):
 		elif re.match(tp.sysinfofmt, line):
 			tp.sysinfo = line
 			continue
+		elif re.match(tp.cmdlinefmt, line):
+			tp.cmdline = line
+			continue
 		m = re.match(sysvals.firmwarefmt, line)
 		if(m):
 			tp.fwdata.append((int(m.group('s')), int(m.group('r'))))
@@ -2911,9 +3150,6 @@ def loadKernelLog(justtext=False):
 		if(not m):
 			continue
 		msg = m.group("msg")
-		if justtext:
-			dmesgtext.append(line)
-			continue
 		if(re.match('PM: Syncing filesystems.*', msg)):
 			if(data):
 				testruns.append(data)
@@ -2934,8 +3170,6 @@ def loadKernelLog(justtext=False):
 		data.dmesgtext.append(line)
 	lf.close()
 
-	if justtext:
-		return dmesgtext
 	if data:
 		testruns.append(data)
 	if len(testruns) < 1:
@@ -2975,7 +3209,7 @@ def parseKernelLog(data):
 	phase = 'suspend_runtime'
 
 	if(data.fwValid):
-		vprint('Firmware Suspend = %u ns, Firmware Resume = %u ns' % \
+		sysvals.vprint('Firmware Suspend = %u ns, Firmware Resume = %u ns' % \
 			(data.fwSuspend, data.fwResume))
 
 	# dmesg phase match table
@@ -3201,7 +3435,6 @@ def parseKernelLog(data):
 		for event in actions[name]:
 			data.newActionGlobal(name, event['begin'], event['end'])
 
-	data.printDetails()
 	if(len(sysvals.devicefilter) > 0):
 		data.deviceFilter(sysvals.devicefilter)
 	data.fixupInitcallsThatDidntReturn()
@@ -3230,9 +3463,9 @@ def callgraphHTML(sv, hf, num, cg, title, color, devid):
 		else:
 			fmt = '<n>(%.3f ms @ '+sv.timeformat+')</n>'
 			flen = fmt % (line.length*1000, line.time)
-		if(line.freturn and line.fcall):
+		if line.isLeaf():
 			hf.write(html_func_leaf.format(line.name, flen))
-		elif(line.freturn):
+		elif line.freturn:
 			hf.write(html_func_end)
 		else:
 			hf.write(html_func_start.format(num, line.name, flen))
@@ -3249,7 +3482,7 @@ def addCallgraphs(sv, hf, data):
 			continue
 		list = data.dmesg[p]['list']
 		for devname in data.sortedDevices(p):
-			if len(sv.devicefilter) > 0 and devname not in sv.devicefilter:
+			if len(sv.cgfilter) > 0 and devname not in sv.cgfilter:
 				continue
 			dev = list[devname]
 			color = 'white'
@@ -3270,7 +3503,6 @@ def addCallgraphs(sv, hf, data):
 				for cg in dev['ftraces']:
 					num = callgraphHTML(sv, hf, num, cg,
 						name+' &rarr; '+cg.name, color, dev['id'])
-
 	hf.write('\n\n    </section>\n')
 
 # Function: createHTMLSummarySimple
@@ -3311,7 +3543,7 @@ def createHTMLSummarySimple(testruns, htmlfile, folder):
 	sTimeAvg = rTimeAvg = 0.0
 	mode = ''
 	num = 0
-	for data in sorted(testruns, key=lambda v:(v['mode'], v['host'], v['kernel'])):
+	for data in sorted(testruns, key=lambda v:(v['mode'], v['host'], v['kernel'], v['time'])):
 		if mode != data['mode']:
 			# test average line
 			if(num > 0):
@@ -3387,7 +3619,7 @@ def createHTML(testruns):
 		data.normalizeTime(testruns[-1].tSuspended)
 
 	# html function templates
-	html_error = '<div id="{1}" title="kernel error/warning" class="err" style="right:{0}%">ERROR&rarr;</div>\n'
+	html_error = '<div id="{1}" title="kernel error/warning" class="err" style="right:{0}%">{2}&rarr;</div>\n'
 	html_traceevent = '<div title="{0}" class="traceevent{6}" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;{7}">{5}</div>\n'
 	html_cpuexec = '<div class="jiffie" style="left:{0}%;top:{1}px;height:{2}px;width:{3}%;background:{4};"></div>\n'
 	html_timetotal = '<table class="time1">\n<tr>'\
@@ -3416,20 +3648,17 @@ def createHTML(testruns):
 		scaleH = 40
 
 	# device timeline
-	vprint('Creating Device Timeline...')
-
 	devtl = Timeline(30, scaleH)
 
 	# write the test title and general info header
-	devtl.createHeader(sysvals)
+	devtl.createHeader(sysvals, testruns[0].stamp)
 
 	# Generate the header for this timeline
 	for data in testruns:
 		tTotal = data.end - data.start
 		sktime, rktime = data.getTimeValues()
 		if(tTotal == 0):
-			print('ERROR: No timeline data')
-			sys.exit()
+			doError('No timeline data')
 		if(data.tLow > 0):
 			low_time = '%.0f'%(data.tLow*1000)
 		if sysvals.suspendmode == 'command':
@@ -3567,9 +3796,10 @@ def createHTML(testruns):
 					data.dmesg[b]['color'], '')
 			for e in data.errorinfo[dir]:
 				# draw red lines for any kernel errors found
-				t, err = e
+				type, t, idx1, idx2 = e
+				id = '%d_%d' % (idx1, idx2)
 				right = '%f' % (((mMax-t)*100.0)/mTotal)
-				devtl.html += html_error.format(right, err)
+				devtl.html += html_error.format(right, id, type)
 			for b in sorted(phases[dir]):
 				# draw the devices for this phase
 				phaselist = data.dmesg[b]['list']
@@ -3663,14 +3893,7 @@ def createHTML(testruns):
 		devtl.html += '</div>\n'
 
 	hf = open(sysvals.htmlfile, 'w')
-
-	# no header or css if its embedded
-	if(sysvals.embedded):
-		hf.write('pass True tSus %.3f tRes %.3f tLow %.3f fwvalid %s tSus %.3f tRes %.3f\n' %
-			(data.tSuspended-data.start, data.end-data.tSuspended, data.tLow, data.fwValid, \
-				data.fwSuspend/1000000, data.fwResume/1000000))
-	else:
-		addCSS(hf, sysvals, len(testruns), kerror)
+	addCSS(hf, sysvals, len(testruns), kerror)
 
 	# write the device timeline
 	hf.write(devtl.html)
@@ -3701,7 +3924,7 @@ def createHTML(testruns):
 		data = testruns[sysvals.cgtest]
 	else:
 		data = testruns[-1]
-	if(sysvals.usecallgraph and not sysvals.embedded):
+	if sysvals.usecallgraph:
 		addCallgraphs(sysvals, hf, data)
 
 	# add the test log as a hidden div
@@ -3710,7 +3933,7 @@ def createHTML(testruns):
 	# add the dmesg log as a hidden div
 	if sysvals.dmesglog and sysvals.dmesgfile:
 		hf.write('<div id="dmesglog" style="display:none;">\n')
-		lf = open(sysvals.dmesgfile, 'r')
+		lf = sysvals.openlog(sysvals.dmesgfile, 'r')
 		for line in lf:
 			line = line.replace('<', '&lt').replace('>', '&gt')
 			hf.write(line)
@@ -3719,28 +3942,15 @@ def createHTML(testruns):
 	# add the ftrace log as a hidden div
 	if sysvals.ftracelog and sysvals.ftracefile:
 		hf.write('<div id="ftracelog" style="display:none;">\n')
-		lf = open(sysvals.ftracefile, 'r')
+		lf = sysvals.openlog(sysvals.ftracefile, 'r')
 		for line in lf:
 			hf.write(line)
 		lf.close()
 		hf.write('</div>\n')
 
-	if(not sysvals.embedded):
-		# write the footer and close
-		addScriptCode(hf, testruns)
-		hf.write('</body>\n</html>\n')
-	else:
-		# embedded out will be loaded in a page, skip the js
-		t0 = (testruns[0].start - testruns[-1].tSuspended) * 1000
-		tMax = (testruns[-1].end - testruns[-1].tSuspended) * 1000
-		# add js code in a div entry for later evaluation
-		detail = 'var bounds = [%f,%f];\n' % (t0, tMax)
-		detail += 'var devtable = [\n'
-		for data in testruns:
-			topo = data.deviceTopology()
-			detail += '\t"%s",\n' % (topo)
-		detail += '];\n'
-		hf.write('<div id=customcode style=display:none>\n'+detail+'</div>\n')
+	# write the footer and close
+	addScriptCode(hf, testruns)
+	hf.write('</body>\n</html>\n')
 	hf.close()
 	return True
 
@@ -4149,9 +4359,25 @@ def addScriptCode(hf, testruns):
 	'		win.document.write(html+dt);\n'\
 	'	}\n'\
 	'	function errWindow() {\n'\
-	'		var text = this.id;\n'\
+	'		var range = this.id.split("_");\n'\
+	'		var idx1 = parseInt(range[0]);\n'\
+	'		var idx2 = parseInt(range[1]);\n'\
 	'		var win = window.open();\n'\
-	'		win.document.write("<pre>"+text+"</pre>");\n'\
+	'		var log = document.getElementById("dmesglog");\n'\
+	'		var title = "<title>dmesg log</title>";\n'\
+	'		var text = log.innerHTML.split("\\n");\n'\
+	'		var html = "";\n'\
+	'		for(var i = 0; i < text.length; i++) {\n'\
+	'			if(i == idx1) {\n'\
+	'				html += "<e id=target>"+text[i]+"</e>\\n";\n'\
+	'			} else if(i > idx1 && i <= idx2) {\n'\
+	'				html += "<e>"+text[i]+"</e>\\n";\n'\
+	'			} else {\n'\
+	'				html += text[i]+"\\n";\n'\
+	'			}\n'\
+	'		}\n'\
+	'		win.document.write("<style>e{color:red}</style>"+title+"<pre>"+html+"</pre>");\n'\
+	'		win.location.hash = "#target";\n'\
 	'		win.document.close();\n'\
 	'	}\n'\
 	'	function logWindow(e) {\n'\
@@ -4219,6 +4445,30 @@ def addScriptCode(hf, testruns):
 	'</script>\n'
 	hf.write(script_code);
 
+def setRuntimeSuspend(before=True):
+	global sysvals
+	sv = sysvals
+	if sv.rs == 0:
+		return
+	if before:
+		# runtime suspend disable or enable
+		if sv.rs > 0:
+			sv.rstgt, sv.rsval, sv.rsdir = 'on', 'auto', 'enabled'
+		else:
+			sv.rstgt, sv.rsval, sv.rsdir = 'auto', 'on', 'disabled'
+		print('CONFIGURING RUNTIME SUSPEND...')
+		sv.rslist = deviceInfo(sv.rstgt)
+		for i in sv.rslist:
+			sv.setVal(sv.rsval, i)
+		print('runtime suspend %s on all devices (%d changed)' % (sv.rsdir, len(sv.rslist)))
+		print('waiting 5 seconds...')
+		time.sleep(5)
+	else:
+		# runtime suspend re-enable or re-disable
+		for i in sv.rslist:
+			sv.setVal(sv.rstgt, i)
+		print('runtime suspend settings restored on %d devices' % len(sv.rslist))
+
 # Function: executeSuspend
 # Description:
 #	 Execute system suspend through the sysfs interface, then copy the output
@@ -4227,6 +4477,19 @@ def executeSuspend():
 	pm = ProcessMonitor()
 	tp = sysvals.tpath
 	fwdata = []
+	# run these commands to prepare the system for suspend
+	if sysvals.display:
+		if sysvals.display > 0:
+			print('TURN DISPLAY ON')
+			call('xset -d :0.0 dpms force suspend', shell=True)
+			call('xset -d :0.0 dpms force on', shell=True)
+		else:
+			print('TURN DISPLAY OFF')
+			call('xset -d :0.0 dpms force suspend', shell=True)
+		time.sleep(1)
+	if sysvals.sync:
+		print('SYNCING FILESYSTEMS')
+		call('sync', shell=True)
 	# mark the start point in the kernel ring buffer just as we start
 	sysvals.initdmesg()
 	# start ftrace
@@ -4298,47 +4561,22 @@ def executeSuspend():
 			pm.stop()
 		sysvals.fsetVal('0', 'tracing_on')
 		print('CAPTURING TRACE')
-		sysvals.writeDatafileHeader(sysvals.ftracefile, fwdata)
-		call('cat '+tp+'trace >> '+sysvals.ftracefile, shell=True)
+		op = sysvals.writeDatafileHeader(sysvals.ftracefile, fwdata)
+		fp = open(tp+'trace', 'r')
+		for line in fp:
+			op.write(line)
+		op.close()
 		sysvals.fsetVal('', 'trace')
 		devProps()
 	# grab a copy of the dmesg output
 	print('CAPTURING DMESG')
-	sysvals.writeDatafileHeader(sysvals.dmesgfile, fwdata)
-	sysvals.getdmesg()
+	sysvals.getdmesg(fwdata)
 
-# Function: setUSBDevicesAuto
-# Description:
-#	 Set the autosuspend control parameter of all USB devices to auto
-#	 This can be dangerous, so use at your own risk, most devices are set
-#	 to always-on since the kernel cant determine if the device can
-#	 properly autosuspend
-def setUSBDevicesAuto():
-	sysvals.rootCheck(True)
-	for dirname, dirnames, filenames in os.walk('/sys/devices'):
-		if(re.match('.*/usb[0-9]*.*', dirname) and
-			'idVendor' in filenames and 'idProduct' in filenames):
-			call('echo auto > %s/power/control' % dirname, shell=True)
-			name = dirname.split('/')[-1]
-			desc = Popen(['cat', '%s/product' % dirname],
-				stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
-			ctrl = Popen(['cat', '%s/power/control' % dirname],
-				stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
-			print('control is %s for %6s: %s' % (ctrl, name, desc))
-
-# Function: yesno
-# Description:
-#	 Print out an equivalent Y or N for a set of known parameter values
-# Output:
-#	 'Y', 'N', or ' ' if the value is unknown
-def yesno(val):
-	yesvals = ['auto', 'enabled', 'active', '1']
-	novals = ['on', 'disabled', 'suspended', 'forbidden', 'unsupported']
-	if val in yesvals:
-		return 'Y'
-	elif val in novals:
-		return 'N'
-	return ' '
+def readFile(file):
+	if os.path.islink(file):
+		return os.readlink(file).split('/')[-1]
+	else:
+		return sysvals.getVal(file).strip()
 
 # Function: ms2nice
 # Description:
@@ -4346,69 +4584,81 @@ def yesno(val):
 # Output:
 #	 The time string, e.g. "1901m16s"
 def ms2nice(val):
-	ms = 0
-	try:
-		ms = int(val)
-	except:
-		return 0.0
-	m = ms / 60000
-	s = (ms / 1000) - (m * 60)
-	return '%3dm%2ds' % (m, s)
+	val = int(val)
+	h = val / 3600000
+	m = (val / 60000) % 60
+	s = (val / 1000) % 60
+	if h > 0:
+		return '%d:%02d:%02d' % (h, m, s)
+	if m > 0:
+		return '%02d:%02d' % (m, s)
+	return '%ds' % s
 
-# Function: detectUSB
+def yesno(val):
+	list = {'enabled':'A', 'disabled':'S', 'auto':'E', 'on':'D',
+		'active':'A', 'suspended':'S', 'suspending':'S'}
+	if val not in list:
+		return ' '
+	return list[val]
+
+# Function: deviceInfo
 # Description:
 #	 Detect all the USB hosts and devices currently connected and add
 #	 a list of USB device names to sysvals for better timeline readability
-def detectUSB():
-	field = {'idVendor':'', 'idProduct':'', 'product':'', 'speed':''}
-	power = {'async':'', 'autosuspend':'', 'autosuspend_delay_ms':'',
-			 'control':'', 'persist':'', 'runtime_enabled':'',
-			 'runtime_status':'', 'runtime_usage':'',
-			'runtime_active_time':'',
-			'runtime_suspended_time':'',
-			'active_duration':'',
-			'connected_duration':''}
-
-	print('LEGEND')
-	print('---------------------------------------------------------------------------------------------')
-	print('  A = async/sync PM queue Y/N                       D = autosuspend delay (seconds)')
-	print('  S = autosuspend Y/N                         rACTIVE = runtime active (min/sec)')
-	print('  P = persist across suspend Y/N              rSUSPEN = runtime suspend (min/sec)')
-	print('  E = runtime suspend enabled/forbidden Y/N    ACTIVE = active duration (min/sec)')
-	print('  R = runtime status active/suspended Y/N     CONNECT = connected duration (min/sec)')
-	print('  U = runtime usage count')
-	print('---------------------------------------------------------------------------------------------')
-	print('  NAME       ID      DESCRIPTION         SPEED A S P E R U D rACTIVE rSUSPEN  ACTIVE CONNECT')
-	print('---------------------------------------------------------------------------------------------')
-
+def deviceInfo(output=''):
+	if not output:
+		print('LEGEND')
+		print('---------------------------------------------------------------------------------------------')
+		print('  A = async/sync PM queue (A/S)               C = runtime active children')
+		print('  R = runtime suspend enabled/disabled (E/D)  rACTIVE = runtime active (min/sec)')
+		print('  S = runtime status active/suspended (A/S)   rSUSPEND = runtime suspend (min/sec)')
+		print('  U = runtime usage count')
+		print('---------------------------------------------------------------------------------------------')
+		print('DEVICE                     NAME                       A R S U C    rACTIVE   rSUSPEND')
+		print('---------------------------------------------------------------------------------------------')
+
+	res = []
+	tgtval = 'runtime_status'
+	lines = dict()
 	for dirname, dirnames, filenames in os.walk('/sys/devices'):
-		if(re.match('.*/usb[0-9]*.*', dirname) and
-			'idVendor' in filenames and 'idProduct' in filenames):
-			for i in field:
-				field[i] = Popen(['cat', '%s/%s' % (dirname, i)],
-					stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
-			name = dirname.split('/')[-1]
-			for i in power:
-				power[i] = Popen(['cat', '%s/power/%s' % (dirname, i)],
-					stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
-			if(re.match('usb[0-9]*', name)):
-				first = '%-8s' % name
-			else:
-				first = '%8s' % name
-			print('%s [%s:%s] %-20s %-4s %1s %1s %1s %1s %1s %1s %1s %s %s %s %s' % \
-				(first, field['idVendor'], field['idProduct'], \
-				field['product'][0:20], field['speed'], \
-				yesno(power['async']), \
-				yesno(power['control']), \
-				yesno(power['persist']), \
-				yesno(power['runtime_enabled']), \
-				yesno(power['runtime_status']), \
-				power['runtime_usage'], \
-				power['autosuspend'], \
-				ms2nice(power['runtime_active_time']), \
-				ms2nice(power['runtime_suspended_time']), \
-				ms2nice(power['active_duration']), \
-				ms2nice(power['connected_duration'])))
+		if(not re.match('.*/power', dirname) or
+			'control' not in filenames or
+			tgtval not in filenames):
+			continue
+		name = ''
+		dirname = dirname[:-6]
+		device = dirname.split('/')[-1]
+		power = dict()
+		power[tgtval] = readFile('%s/power/%s' % (dirname, tgtval))
+		# only list devices which support runtime suspend
+		if power[tgtval] not in ['active', 'suspended', 'suspending']:
+			continue
+		for i in ['product', 'driver', 'subsystem']:
+			file = '%s/%s' % (dirname, i)
+			if os.path.exists(file):
+				name = readFile(file)
+				break
+		for i in ['async', 'control', 'runtime_status', 'runtime_usage',
+			'runtime_active_kids', 'runtime_active_time',
+			'runtime_suspended_time']:
+			if i in filenames:
+				power[i] = readFile('%s/power/%s' % (dirname, i))
+		if output:
+			if power['control'] == output:
+				res.append('%s/power/control' % dirname)
+			continue
+		lines[dirname] = '%-26s %-26s %1s %1s %1s %1s %1s %10s %10s' % \
+			(device[:26], name[:26],
+			yesno(power['async']), \
+			yesno(power['control']), \
+			yesno(power['runtime_status']), \
+			power['runtime_usage'], \
+			power['runtime_active_kids'], \
+			ms2nice(power['runtime_active_time']), \
+			ms2nice(power['runtime_suspended_time']))
+	for i in sorted(lines):
+		print lines[i]
+	return res
 
 # Function: devProps
 # Description:
@@ -4444,7 +4694,7 @@ def devProps(data=0):
 	msghead = 'Additional data added by AnalyzeSuspend'
 	alreadystamped = False
 	tp = TestProps()
-	tf = open(sysvals.ftracefile, 'r')
+	tf = sysvals.openlog(sysvals.ftracefile, 'r')
 	for line in tf:
 		if msghead in line:
 			alreadystamped = True
@@ -4469,7 +4719,7 @@ def devProps(data=0):
 	if not alreadystamped and sysvals.suspendmode == 'command':
 		out = '#\n# '+msghead+'\n# Device Properties: '
 		out += 'testcommandstring,%s,0;' % (sysvals.testcommand)
-		with open(sysvals.ftracefile, 'a') as fp:
+		with sysvals.openlog(sysvals.ftracefile, 'a') as fp:
 			fp.write(out+'\n')
 		sysvals.devprops = props
 		return
@@ -4526,7 +4776,7 @@ def devProps(data=0):
 		out = '#\n# '+msghead+'\n# Device Properties: '
 		for dev in sorted(props):
 			out += props[dev].out(dev)
-		with open(sysvals.ftracefile, 'a') as fp:
+		with sysvals.openlog(sysvals.ftracefile, 'a') as fp:
 			fp.write(out+'\n')
 
 	sysvals.devprops = props
@@ -4869,20 +5119,12 @@ def statusCheck(probecheck=False):
 	# what data source are we using
 	res = 'DMESG'
 	if(ftgood):
-		sysvals.usetraceeventsonly = True
-		sysvals.usetraceevents = False
+		sysvals.usetraceevents = True
 		for e in sysvals.traceevents:
-			check = False
-			if(os.path.exists(sysvals.epath+e)):
-				check = True
-			if(not check):
-				sysvals.usetraceeventsonly = False
-			if(e == 'suspend_resume' and check):
-				sysvals.usetraceevents = True
-		if(sysvals.usetraceevents and sysvals.usetraceeventsonly):
+			if not os.path.exists(sysvals.epath+e):
+				sysvals.usetraceevents = False
+		if(sysvals.usetraceevents):
 			res = 'FTRACE (all trace events found)'
-		elif(sysvals.usetraceevents):
-			res = 'DMESG and FTRACE (suspend_resume trace event found)'
 	print('    timeline data source: %s' % res)
 
 	# check if rtcwake
@@ -4917,6 +5159,7 @@ def doError(msg, help=False):
 	if(help == True):
 		printHelp()
 	print('ERROR: %s\n') % msg
+	sysvals.outputResult({'error':msg})
 	sys.exit()
 
 # Function: getArgInt
@@ -4957,22 +5200,36 @@ def getArgFloat(name, args, min, max, main=True):
 		doError(name+': value should be between %f and %f' % (min, max), True)
 	return val
 
-def processData():
+def processData(live=False):
 	print('PROCESSING DATA')
-	if(sysvals.usetraceeventsonly):
-		testruns = parseTraceLog()
+	if(sysvals.usetraceevents):
+		testruns = parseTraceLog(live)
 		if sysvals.dmesgfile:
-			dmesgtext = loadKernelLog(True)
 			for data in testruns:
-				data.extractErrorInfo(dmesgtext)
+				data.extractErrorInfo()
 	else:
 		testruns = loadKernelLog()
 		for data in testruns:
 			parseKernelLog(data)
 		if(sysvals.ftracefile and (sysvals.usecallgraph or sysvals.usetraceevents)):
 			appendIncompleteTraceLog(testruns)
+	sysvals.vprint('Command:\n    %s' % sysvals.cmdline)
+	for data in testruns:
+		data.printDetails()
+	if sysvals.cgdump:
+		for data in testruns:
+			data.debugPrint()
+		sys.exit()
+
+	sysvals.vprint('Creating the html timeline (%s)...' % sysvals.htmlfile)
 	createHTML(testruns)
-	return testruns
+	print('DONE')
+	data = testruns[0]
+	stamp = data.stamp
+	stamp['suspend'], stamp['resume'] = data.getTimeValues()
+	if data.fwValid:
+		stamp['fwsuspend'], stamp['fwresume'] = data.fwSuspend, data.fwResume
+	return (testruns, stamp)
 
 # Function: rerunTest
 # Description:
@@ -4980,37 +5237,36 @@ def processData():
 def rerunTest():
 	if sysvals.ftracefile:
 		doesTraceLogHaveTraceEvents()
-	if not sysvals.dmesgfile and not sysvals.usetraceeventsonly:
+	if not sysvals.dmesgfile and not sysvals.usetraceevents:
 		doError('recreating this html output requires a dmesg file')
 	sysvals.setOutputFile()
-	vprint('Output file: %s' % sysvals.htmlfile)
 	if os.path.exists(sysvals.htmlfile):
 		if not os.path.isfile(sysvals.htmlfile):
 			doError('a directory already exists with this name: %s' % sysvals.htmlfile)
 		elif not os.access(sysvals.htmlfile, os.W_OK):
 			doError('missing permission to write to %s' % sysvals.htmlfile)
-	return processData()
+	testruns, stamp = processData(False)
+	return stamp
 
 # Function: runTest
 # Description:
 #	 execute a suspend/resume, gather the logs, and generate the output
-def runTest():
+def runTest(n=0):
 	# prepare for the test
 	sysvals.initFtrace()
 	sysvals.initTestOutput('suspend')
-	vprint('Output files:\n\t%s\n\t%s\n\t%s' % \
-		(sysvals.dmesgfile, sysvals.ftracefile, sysvals.htmlfile))
 
 	# execute the test
 	executeSuspend()
 	sysvals.cleanupFtrace()
-	processData()
-
-	# if running as root, change output dir owner to sudo_user
-	if os.path.isdir(sysvals.testdir) and os.getuid() == 0 and \
-		'SUDO_USER' in os.environ:
-		cmd = 'chown -R {0}:{0} {1} > /dev/null 2>&1'
-		call(cmd.format(os.environ['SUDO_USER'], sysvals.testdir), shell=True)
+	if sysvals.skiphtml:
+		sysvals.sudouser(sysvals.testdir)
+		return
+	testruns, stamp = processData(True)
+	for data in testruns:
+		del data
+	sysvals.sudouser(sysvals.testdir)
+	sysvals.outputResult(stamp, n)
 
 def find_in_html(html, strs, div=False):
 	for str in strs:
@@ -5072,10 +5328,12 @@ def runSummary(subdir, local=True):
 # Function: checkArgBool
 # Description:
 #	 check if a boolean string value is true or false
-def checkArgBool(value):
-	yes = ['1', 'true', 'yes', 'on']
-	if value.lower() in yes:
+def checkArgBool(name, value):
+	if value in switchvalues:
+		if value in switchoff:
+			return False
 		return True
+	doError('invalid boolean --> (%s: %s), use "true/false" or "1/0"' % (name, value), True)
 	return False
 
 # Function: configFromFile
@@ -5091,60 +5349,116 @@ def configFromFile(file):
 	if 'Settings' in sections:
 		for opt in Config.options('Settings'):
 			value = Config.get('Settings', opt).lower()
-			if(opt.lower() == 'verbose'):
-				sysvals.verbose = checkArgBool(value)
-			elif(opt.lower() == 'addlogs'):
-				sysvals.dmesglog = sysvals.ftracelog = checkArgBool(value)
-			elif(opt.lower() == 'dev'):
-				sysvals.usedevsrc = checkArgBool(value)
-			elif(opt.lower() == 'proc'):
-				sysvals.useprocmon = checkArgBool(value)
-			elif(opt.lower() == 'x2'):
-				if checkArgBool(value):
+			option = opt.lower()
+			if(option == 'verbose'):
+				sysvals.verbose = checkArgBool(option, value)
+			elif(option == 'addlogs'):
+				sysvals.dmesglog = sysvals.ftracelog = checkArgBool(option, value)
+			elif(option == 'dev'):
+				sysvals.usedevsrc = checkArgBool(option, value)
+			elif(option == 'proc'):
+				sysvals.useprocmon = checkArgBool(option, value)
+			elif(option == 'x2'):
+				if checkArgBool(option, value):
 					sysvals.execcount = 2
-			elif(opt.lower() == 'callgraph'):
-				sysvals.usecallgraph = checkArgBool(value)
-			elif(opt.lower() == 'override-timeline-functions'):
-				overridekprobes = checkArgBool(value)
-			elif(opt.lower() == 'override-dev-timeline-functions'):
-				overridedevkprobes = checkArgBool(value)
-			elif(opt.lower() == 'devicefilter'):
+			elif(option == 'callgraph'):
+				sysvals.usecallgraph = checkArgBool(option, value)
+			elif(option == 'override-timeline-functions'):
+				overridekprobes = checkArgBool(option, value)
+			elif(option == 'override-dev-timeline-functions'):
+				overridedevkprobes = checkArgBool(option, value)
+			elif(option == 'skiphtml'):
+				sysvals.skiphtml = checkArgBool(option, value)
+			elif(option == 'sync'):
+				sysvals.sync = checkArgBool(option, value)
+			elif(option == 'rs' or option == 'runtimesuspend'):
+				if value in switchvalues:
+					if value in switchoff:
+						sysvals.rs = -1
+					else:
+						sysvals.rs = 1
+				else:
+					doError('invalid value --> (%s: %s), use "enable/disable"' % (option, value), True)
+			elif(option == 'display'):
+				if value in switchvalues:
+					if value in switchoff:
+						sysvals.display = -1
+					else:
+						sysvals.display = 1
+				else:
+					doError('invalid value --> (%s: %s), use "on/off"' % (option, value), True)
+			elif(option == 'gzip'):
+				sysvals.gzip = checkArgBool(option, value)
+			elif(option == 'cgfilter'):
+				sysvals.setCallgraphFilter(value)
+			elif(option == 'cgskip'):
+				if value in switchoff:
+					sysvals.cgskip = ''
+				else:
+					sysvals.cgskip = sysvals.configFile(val)
+					if(not sysvals.cgskip):
+						doError('%s does not exist' % sysvals.cgskip)
+			elif(option == 'cgtest'):
+				sysvals.cgtest = getArgInt('cgtest', value, 0, 1, False)
+			elif(option == 'cgphase'):
+				d = Data(0)
+				if value not in d.phases:
+					doError('invalid phase --> (%s: %s), valid phases are %s'\
+						% (option, value, d.phases), True)
+				sysvals.cgphase = value
+			elif(option == 'fadd'):
+				file = sysvals.configFile(value)
+				if(not file):
+					doError('%s does not exist' % value)
+				sysvals.addFtraceFilterFunctions(file)
+			elif(option == 'result'):
+				sysvals.result = value
+			elif(option == 'multi'):
+				nums = value.split()
+				if len(nums) != 2:
+					doError('multi requires 2 integers (exec_count and delay)', True)
+				sysvals.multitest['run'] = True
+				sysvals.multitest['count'] = getArgInt('multi: n d (exec count)', nums[0], 2, 1000000, False)
+				sysvals.multitest['delay'] = getArgInt('multi: n d (delay between tests)', nums[1], 0, 3600, False)
+			elif(option == 'devicefilter'):
 				sysvals.setDeviceFilter(value)
-			elif(opt.lower() == 'expandcg'):
-				sysvals.cgexp = checkArgBool(value)
-			elif(opt.lower() == 'srgap'):
-				if checkArgBool(value):
+			elif(option == 'expandcg'):
+				sysvals.cgexp = checkArgBool(option, value)
+			elif(option == 'srgap'):
+				if checkArgBool(option, value):
 					sysvals.srgap = 5
-			elif(opt.lower() == 'mode'):
+			elif(option == 'mode'):
 				sysvals.suspendmode = value
-			elif(opt.lower() == 'command'):
+			elif(option == 'command' or option == 'cmd'):
 				sysvals.testcommand = value
-			elif(opt.lower() == 'x2delay'):
-				sysvals.x2delay = getArgInt('-x2delay', value, 0, 60000, False)
-			elif(opt.lower() == 'predelay'):
-				sysvals.predelay = getArgInt('-predelay', value, 0, 60000, False)
-			elif(opt.lower() == 'postdelay'):
-				sysvals.postdelay = getArgInt('-postdelay', value, 0, 60000, False)
-			elif(opt.lower() == 'maxdepth'):
-				sysvals.max_graph_depth = getArgInt('-maxdepth', value, 0, 1000, False)
-			elif(opt.lower() == 'rtcwake'):
-				if value.lower() == 'off':
+			elif(option == 'x2delay'):
+				sysvals.x2delay = getArgInt('x2delay', value, 0, 60000, False)
+			elif(option == 'predelay'):
+				sysvals.predelay = getArgInt('predelay', value, 0, 60000, False)
+			elif(option == 'postdelay'):
+				sysvals.postdelay = getArgInt('postdelay', value, 0, 60000, False)
+			elif(option == 'maxdepth'):
+				sysvals.max_graph_depth = getArgInt('maxdepth', value, 0, 1000, False)
+			elif(option == 'rtcwake'):
+				if value in switchoff:
 					sysvals.rtcwake = False
 				else:
 					sysvals.rtcwake = True
-					sysvals.rtcwaketime = getArgInt('-rtcwake', value, 0, 3600, False)
-			elif(opt.lower() == 'timeprec'):
-				sysvals.setPrecision(getArgInt('-timeprec', value, 0, 6, False))
-			elif(opt.lower() == 'mindev'):
-				sysvals.mindevlen = getArgFloat('-mindev', value, 0.0, 10000.0, False)
-			elif(opt.lower() == 'callloop-maxgap'):
-				sysvals.callloopmaxgap = getArgFloat('-callloop-maxgap', value, 0.0, 1.0, False)
-			elif(opt.lower() == 'callloop-maxlen'):
-				sysvals.callloopmaxgap = getArgFloat('-callloop-maxlen', value, 0.0, 1.0, False)
-			elif(opt.lower() == 'mincg'):
-				sysvals.mincglen = getArgFloat('-mincg', value, 0.0, 10000.0, False)
-			elif(opt.lower() == 'output-dir'):
-				sysvals.testdir = sysvals.setOutputFolder(value)
+					sysvals.rtcwaketime = getArgInt('rtcwake', value, 0, 3600, False)
+			elif(option == 'timeprec'):
+				sysvals.setPrecision(getArgInt('timeprec', value, 0, 6, False))
+			elif(option == 'mindev'):
+				sysvals.mindevlen = getArgFloat('mindev', value, 0.0, 10000.0, False)
+			elif(option == 'callloop-maxgap'):
+				sysvals.callloopmaxgap = getArgFloat('callloop-maxgap', value, 0.0, 1.0, False)
+			elif(option == 'callloop-maxlen'):
+				sysvals.callloopmaxgap = getArgFloat('callloop-maxlen', value, 0.0, 1.0, False)
+			elif(option == 'mincg'):
+				sysvals.mincglen = getArgFloat('mincg', value, 0.0, 10000.0, False)
+			elif(option == 'bufsize'):
+				sysvals.bufsize = getArgInt('bufsize', value, 1, 1024*1024*8, False)
+			elif(option == 'output-dir'):
+				sysvals.outdir = sysvals.setOutputFolder(value)
 
 	if sysvals.suspendmode == 'command' and not sysvals.testcommand:
 		doError('No command supplied for mode "command"')
@@ -5259,7 +5573,14 @@ def printHelp():
 	print('   -rtcwake t   Wakeup t seconds after suspend, set t to "off" to disable (default: 15)')
 	print('   -addlogs     Add the dmesg and ftrace logs to the html output')
 	print('   -srgap       Add a visible gap in the timeline between sus/res (default: disabled)')
+	print('   -skiphtml    Run the test and capture the trace logs, but skip the timeline (default: disabled)')
+	print('   -result fn   Export a results table to a text file for parsing.')
+	print('  [testprep]')
+	print('   -sync        Sync the filesystems before starting the test')
+	print('   -rs on/off   Enable/disable runtime suspend for all devices, restore all after test')
+	print('   -display on/off  Turn the display on or off for the test')
 	print('  [advanced]')
+	print('   -gzip        Gzip the trace and dmesg logs to save space')
 	print('   -cmd {s}     Run the timeline over a custom command, e.g. "sync -d"')
 	print('   -proc        Add usermode process info into the timeline (default: disabled)')
 	print('   -dev         Add kernel function calls and threads to the timeline (default: disabled)')
@@ -5280,14 +5601,16 @@ def printHelp():
 	print('   -cgphase P   Only show callgraph data for phase P (e.g. suspend_late)')
 	print('   -cgtest N    Only show callgraph data for test N (e.g. 0 or 1 in an x2 run)')
 	print('   -timeprec N  Number of significant digits in timestamps (0:S, [3:ms], 6:us)')
+	print('   -cgfilter S  Filter the callgraph output in the timeline')
+	print('   -cgskip file Callgraph functions to skip, off to disable (default: cgskip.txt)')
+	print('   -bufsize N   Set trace buffer size to N kilo-bytes (default: all of free memory)')
 	print('')
 	print('Other commands:')
 	print('   -modes       List available suspend modes')
 	print('   -status      Test to see if the system is enabled to run this tool')
 	print('   -fpdt        Print out the contents of the ACPI Firmware Performance Data Table')
 	print('   -sysinfo     Print out system info extracted from BIOS')
-	print('   -usbtopo     Print out the current USB topology with power info')
-	print('   -usbauto     Enable autosuspend for all connected USB devices')
+	print('   -devinfo     Print out the pm settings of all devices which support runtime suspend')
 	print('   -flist       Print the list of functions currently being captured in ftrace')
 	print('   -flistall    Print all functions capable of being captured in ftrace')
 	print('   -summary directory  Create a summary of all test in this dir')
@@ -5301,9 +5624,9 @@ def printHelp():
 # exec start (skipped if script is loaded as library)
 if __name__ == '__main__':
 	cmd = ''
-	outdir = ''
-	multitest = {'run': False, 'count': 0, 'delay': 0}
-	simplecmds = ['-sysinfo', '-modes', '-fpdt', '-flist', '-flistall', '-usbtopo', '-usbauto', '-status']
+	simplecmds = ['-sysinfo', '-modes', '-fpdt', '-flist', '-flistall', '-devinfo', '-status']
+	if '-f' in sys.argv:
+		sysvals.cgskip = sysvals.configFile('cgskip.txt')
 	# loop through the command line arguments
 	args = iter(sys.argv[1:])
 	for arg in args:
@@ -5333,6 +5656,10 @@ if __name__ == '__main__':
 			sysvals.postdelay = getArgInt('-postdelay', args, 0, 60000)
 		elif(arg == '-f'):
 			sysvals.usecallgraph = True
+		elif(arg == '-skiphtml'):
+			sysvals.skiphtml = True
+		elif(arg == '-cgdump'):
+			sysvals.cgdump = True
 		elif(arg == '-addlogs'):
 			sysvals.dmesglog = sysvals.ftracelog = True
 		elif(arg == '-verbose'):
@@ -5341,6 +5668,34 @@ if __name__ == '__main__':
 			sysvals.useprocmon = True
 		elif(arg == '-dev'):
 			sysvals.usedevsrc = True
+		elif(arg == '-sync'):
+			sysvals.sync = True
+		elif(arg == '-gzip'):
+			sysvals.gzip = True
+		elif(arg == '-rs'):
+			try:
+				val = args.next()
+			except:
+				doError('-rs requires "enable" or "disable"', True)
+			if val.lower() in switchvalues:
+				if val.lower() in switchoff:
+					sysvals.rs = -1
+				else:
+					sysvals.rs = 1
+			else:
+				doError('invalid option: %s, use "enable/disable" or "on/off"' % val, True)
+		elif(arg == '-display'):
+			try:
+				val = args.next()
+			except:
+				doError('-display requires "on" or "off"', True)
+			if val.lower() in switchvalues:
+				if val.lower() in switchoff:
+					sysvals.display = -1
+				else:
+					sysvals.display = 1
+			else:
+				doError('invalid option: %s, use "on/off"' % val, True)
 		elif(arg == '-maxdepth'):
 			sysvals.max_graph_depth = getArgInt('-maxdepth', args, 0, 1000)
 		elif(arg == '-rtcwake'):
@@ -5348,7 +5703,7 @@ if __name__ == '__main__':
 				val = args.next()
 			except:
 				doError('No rtcwake time supplied', True)
-			if val.lower() == 'off':
+			if val.lower() in switchoff:
 				sysvals.rtcwake = False
 			else:
 				sysvals.rtcwake = True
@@ -5359,6 +5714,8 @@ if __name__ == '__main__':
 			sysvals.mindevlen = getArgFloat('-mindev', args, 0.0, 10000.0)
 		elif(arg == '-mincg'):
 			sysvals.mincglen = getArgFloat('-mincg', args, 0.0, 10000.0)
+		elif(arg == '-bufsize'):
+			sysvals.bufsize = getArgInt('-bufsize', args, 1, 1024*1024*8)
 		elif(arg == '-cgtest'):
 			sysvals.cgtest = getArgInt('-cgtest', args, 0, 1)
 		elif(arg == '-cgphase'):
@@ -5368,8 +5725,26 @@ if __name__ == '__main__':
 				doError('No phase name supplied', True)
 			d = Data(0)
 			if val not in d.phases:
-				doError('Invalid phase, valid phaess are %s' % d.phases, True)
+				doError('invalid phase --> (%s: %s), valid phases are %s'\
+					% (arg, val, d.phases), True)
 			sysvals.cgphase = val
+		elif(arg == '-cgfilter'):
+			try:
+				val = args.next()
+			except:
+				doError('No callgraph functions supplied', True)
+			sysvals.setCallgraphFilter(val)
+		elif(arg == '-cgskip'):
+			try:
+				val = args.next()
+			except:
+				doError('No file supplied', True)
+			if val.lower() in switchoff:
+				sysvals.cgskip = ''
+			else:
+				sysvals.cgskip = sysvals.configFile(val)
+				if(not sysvals.cgskip):
+					doError('%s does not exist' % sysvals.cgskip)
 		elif(arg == '-callloop-maxgap'):
 			sysvals.callloopmaxgap = getArgFloat('-callloop-maxgap', args, 0.0, 1.0)
 		elif(arg == '-callloop-maxlen'):
@@ -5386,31 +5761,33 @@ if __name__ == '__main__':
 		elif(arg == '-srgap'):
 			sysvals.srgap = 5
 		elif(arg == '-multi'):
-			multitest['run'] = True
-			multitest['count'] = getArgInt('-multi n (exec count)', args, 2, 1000000)
-			multitest['delay'] = getArgInt('-multi d (delay between tests)', args, 0, 3600)
+			sysvals.multitest['run'] = True
+			sysvals.multitest['count'] = getArgInt('-multi n d (exec count)', args, 2, 1000000)
+			sysvals.multitest['delay'] = getArgInt('-multi n d (delay between tests)', args, 0, 3600)
 		elif(arg == '-o'):
 			try:
 				val = args.next()
 			except:
 				doError('No subdirectory name supplied', True)
-			outdir = sysvals.setOutputFolder(val)
+			sysvals.outdir = sysvals.setOutputFolder(val)
 		elif(arg == '-config'):
 			try:
 				val = args.next()
 			except:
 				doError('No text file supplied', True)
-			if(os.path.exists(val) == False):
+			file = sysvals.configFile(val)
+			if(not file):
 				doError('%s does not exist' % val)
-			configFromFile(val)
+			configFromFile(file)
 		elif(arg == '-fadd'):
 			try:
 				val = args.next()
 			except:
 				doError('No text file supplied', True)
-			if(os.path.exists(val) == False):
+			file = sysvals.configFile(val)
+			if(not file):
 				doError('%s does not exist' % val)
-			sysvals.addFtraceFilterFunctions(val)
+			sysvals.addFtraceFilterFunctions(file)
 		elif(arg == '-dmesg'):
 			try:
 				val = args.next()
@@ -5435,7 +5812,7 @@ if __name__ == '__main__':
 			except:
 				doError('No directory supplied', True)
 			cmd = 'summary'
-			outdir = val
+			sysvals.outdir = val
 			sysvals.notestrun = True
 			if(os.path.isdir(val) == False):
 				doError('%s is not accesible' % val)
@@ -5445,6 +5822,12 @@ if __name__ == '__main__':
 			except:
 				doError('No devnames supplied', True)
 			sysvals.setDeviceFilter(val)
+		elif(arg == '-result'):
+			try:
+				val = args.next()
+			except:
+				doError('No result file supplied', True)
+			sysvals.result = val
 		else:
 			doError('Invalid argument: '+arg, True)
 
@@ -5454,42 +5837,48 @@ if __name__ == '__main__':
 	if(sysvals.usecallgraph and sysvals.useprocmon):
 		doError('-proc is not compatible with -f')
 
+	if sysvals.usecallgraph and sysvals.cgskip:
+		sysvals.vprint('Using cgskip file: %s' % sysvals.cgskip)
+		sysvals.setCallgraphBlacklist(sysvals.cgskip)
+
 	# callgraph size cannot exceed device size
 	if sysvals.mincglen < sysvals.mindevlen:
 		sysvals.mincglen = sysvals.mindevlen
 
-	# just run a utility command and exit
+	# remove existing buffers before calculating memory
+	if(sysvals.usecallgraph or sysvals.usedevsrc):
+		sysvals.fsetVal('16', 'buffer_size_kb')
 	sysvals.cpuInfo()
+
+	# just run a utility command and exit
 	if(cmd != ''):
 		if(cmd == 'status'):
 			statusCheck(True)
 		elif(cmd == 'fpdt'):
 			getFPDT(True)
 		elif(cmd == 'sysinfo'):
-			sysvals.printSystemInfo()
-		elif(cmd == 'usbtopo'):
-			detectUSB()
+			sysvals.printSystemInfo(True)
+		elif(cmd == 'devinfo'):
+			deviceInfo()
 		elif(cmd == 'modes'):
 			print getModes()
 		elif(cmd == 'flist'):
 			sysvals.getFtraceFilterFunctions(True)
 		elif(cmd == 'flistall'):
 			sysvals.getFtraceFilterFunctions(False)
-		elif(cmd == 'usbauto'):
-			setUSBDevicesAuto()
 		elif(cmd == 'summary'):
-			runSummary(outdir, True)
+			runSummary(sysvals.outdir, True)
 		sys.exit()
 
 	# if instructed, re-analyze existing data files
 	if(sysvals.notestrun):
-		rerunTest()
+		stamp = rerunTest()
+		sysvals.outputResult(stamp)
 		sys.exit()
 
 	# verify that we can run a test
 	if(not statusCheck()):
-		print('Check FAILED, aborting the test run!')
-		sys.exit()
+		doError('Check FAILED, aborting the test run!')
 
 	# extract mem modes and convert
 	mode = sysvals.suspendmode
@@ -5509,25 +5898,35 @@ if __name__ == '__main__':
 
 	sysvals.systemInfo(dmidecode(sysvals.mempath))
 
-	if multitest['run']:
+	setRuntimeSuspend(True)
+	if sysvals.display:
+		call('xset -d :0.0 dpms 0 0 0', shell=True)
+		call('xset -d :0.0 s off', shell=True)
+	if sysvals.multitest['run']:
 		# run multiple tests in a separate subdirectory
-		if not outdir:
-			s = 'suspend-x%d' % multitest['count']
-			outdir = datetime.now().strftime(s+'-%y%m%d-%H%M%S')
-		if not os.path.isdir(outdir):
-			os.mkdir(outdir)
-		for i in range(multitest['count']):
+		if not sysvals.outdir:
+			s = 'suspend-x%d' % sysvals.multitest['count']
+			sysvals.outdir = datetime.now().strftime(s+'-%y%m%d-%H%M%S')
+		if not os.path.isdir(sysvals.outdir):
+			os.mkdir(sysvals.outdir)
+		for i in range(sysvals.multitest['count']):
 			if(i != 0):
-				print('Waiting %d seconds...' % (multitest['delay']))
-				time.sleep(multitest['delay'])
-			print('TEST (%d/%d) START' % (i+1, multitest['count']))
+				print('Waiting %d seconds...' % (sysvals.multitest['delay']))
+				time.sleep(sysvals.multitest['delay'])
+			print('TEST (%d/%d) START' % (i+1, sysvals.multitest['count']))
 			fmt = 'suspend-%y%m%d-%H%M%S'
-			sysvals.testdir = os.path.join(outdir, datetime.now().strftime(fmt))
-			runTest()
-			print('TEST (%d/%d) COMPLETE' % (i+1, multitest['count']))
-		runSummary(outdir, False)
+			sysvals.testdir = os.path.join(sysvals.outdir, datetime.now().strftime(fmt))
+			runTest(i+1)
+			print('TEST (%d/%d) COMPLETE' % (i+1, sysvals.multitest['count']))
+			sysvals.logmsg = ''
+		if not sysvals.skiphtml:
+			runSummary(sysvals.outdir, False)
+		sysvals.sudouser(sysvals.outdir)
 	else:
-		if outdir:
-			sysvals.testdir = outdir
+		if sysvals.outdir:
+			sysvals.testdir = sysvals.outdir
 		# run the test in the current directory
 		runTest()
+	if sysvals.display:
+		call('xset -d :0.0 s reset', shell=True)
+	setRuntimeSuspend(False)
-- 
2.14.1
