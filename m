From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 1/5] scripts: AnalyzeSuspend v4.2 part1
Date: Thu, 14 Jul 2016 14:09:25 -0700
Message-ID: <3f03da9ae764990476a0eccc2c9ec2f4b7f6837c.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43378 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcGNVJf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 17:09:35 -0400
In-Reply-To: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 scripts/analyze_suspend.py | 753 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 643 insertions(+), 110 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index 93e1fd4..813681f 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -19,6 +19,17 @@
 # Authors:
 #	 Todd Brandt <todd.e.brandt@linux.intel.com>
 #
+# Links:
+#	 Home Page
+#	   https://01.org/suspendresume
+#	 Source repo
+#	   https://github.com/01org/suspendresume
+#	 Documentation
+#	   Getting Started
+#	     https://01.org/suspendresume/documentation/getting-started
+#	   Command List:
+#	     https://01.org/suspendresume/documentation/command-list
+#
 # Description:
 #	 This tool is designed to assist kernel and OS developers in optimizing
 #	 their linux stack's suspend/resume time. Using a kernel image built
@@ -35,6 +46,8 @@
 #		 CONFIG_FTRACE=y
 #		 CONFIG_FUNCTION_TRACER=y
 #		 CONFIG_FUNCTION_GRAPH_TRACER=y
+#		 CONFIG_KPROBES=y
+#		 CONFIG_KPROBES_ON_FTRACE=y
 #
 #	 For kernel versions older than 3.15:
 #	 The following additional kernel parameters are required:
@@ -52,6 +65,7 @@ import re
 import platform
 from datetime import datetime
 import struct
+import ConfigParser
 
 # ----------------- CLASSES --------------------
 
@@ -60,8 +74,15 @@ import struct
 #	 A global, single-instance container used to
 #	 store system values and test parameters
 class SystemValues:
-	version = 3.0
+	ansi = False
+	version = '4.2'
 	verbose = False
+	addlogs = False
+	mindevlen = 0.001
+	mincglen = 1.0
+	srgap = 0
+	cgexp = False
+	outdir = ''
 	testdir = '.'
 	tpath = '/sys/kernel/debug/tracing/'
 	fpdtpath = '/sys/firmware/acpi/tables/FPDT'
@@ -71,26 +92,21 @@ class SystemValues:
 		'device_pm_callback_end',
 		'device_pm_callback_start'
 	]
-	modename = {
-		'freeze': 'Suspend-To-Idle (S0)',
-		'standby': 'Power-On Suspend (S1)',
-		'mem': 'Suspend-to-RAM (S3)',
-		'disk': 'Suspend-to-disk (S4)'
-	}
+	testcommand = ''
 	mempath = '/dev/mem'
 	powerfile = '/sys/power/state'
 	suspendmode = 'mem'
 	hostname = 'localhost'
 	prefix = 'test'
 	teststamp = ''
+	dmesgstart = 0.0
 	dmesgfile = ''
 	ftracefile = ''
 	htmlfile = ''
+	embedded = False
 	rtcwake = False
 	rtcwaketime = 10
 	rtcpath = ''
-	android = False
-	adb = 'adb'
 	devicefilter = []
 	stamp = 0
 	execcount = 1
@@ -98,16 +114,90 @@ class SystemValues:
 	usecallgraph = False
 	usetraceevents = False
 	usetraceeventsonly = False
+	usetracemarkers = True
+	usekprobes = True
+	usedevsrc = False
 	notestrun = False
-	altdevname = dict()
+	devprops = dict()
 	postresumetime = 0
+	devpropfmt = '# Device Properties: .*'
 	tracertypefmt = '# tracer: (?P<t>.*)'
 	firmwarefmt = '# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
 	postresumefmt = '# post resume time (?P<t>[0-9]*)$'
 	stampfmt = '# suspend-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
 				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
 				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
+	kprobecolor = 'rgba(204,204,204,0.5)'
+	synccolor = 'rgba(204,204,204,0.5)'
+	debugfuncs = []
+	tracefuncs = {
+		'sys_sync': dict(),
+		'pm_prepare_console': dict(),
+		'pm_notifier_call_chain': dict(),
+		'freeze_processes': dict(),
+		'freeze_kernel_threads': dict(),
+		'pm_restrict_gfp_mask': dict(),
+		'acpi_suspend_begin': dict(),
+		'suspend_console': dict(),
+		'acpi_pm_prepare': dict(),
+		'syscore_suspend': dict(),
+		'arch_enable_nonboot_cpus_end': dict(),
+		'syscore_resume': dict(),
+		'acpi_pm_finish': dict(),
+		'resume_console': dict(),
+		'acpi_pm_end': dict(),
+		'pm_restore_gfp_mask': dict(),
+		'thaw_processes': dict(),
+		'pm_restore_console': dict(),
+		'CPU_OFF': {
+			'func':'_cpu_down',
+			'args_x86_64': {'cpu':'%di:s32'},
+			'format': 'CPU_OFF[{cpu}]',
+			'mask': 'CPU_.*_DOWN'
+		},
+		'CPU_ON': {
+			'func':'_cpu_up',
+			'args_x86_64': {'cpu':'%di:s32'},
+			'format': 'CPU_ON[{cpu}]',
+			'mask': 'CPU_.*_UP'
+		},
+	}
+	dev_tracefuncs = {
+		# general wait/delay/sleep
+		'msleep': { 'args_x86_64': {'time':'%di:s32'} },
+		'udelay': { 'func':'__const_udelay', 'args_x86_64': {'loops':'%di:s32'} },
+		'acpi_os_stall': dict(),
+		# ACPI
+		'acpi_resume_power_resources': dict(),
+		'acpi_ps_parse_aml': dict(),
+		# filesystem
+		'ext4_sync_fs': dict(),
+		# ATA
+		'ata_eh_recover': { 'args_x86_64': {'port':'+36(%di):s32'} },
+		# i915
+		'i915_gem_restore_gtt_mappings': dict(),
+		'intel_opregion_setup': dict(),
+		'intel_dp_detect': dict(),
+		'intel_hdmi_detect': dict(),
+		'intel_opregion_init': dict(),
+	}
+	kprobes_postresume = [
+		{
+			'name': 'ataportrst',
+			'func': 'ata_eh_recover',
+			'args': {'port':'+36(%di):s32'},
+			'format': 'ata{port}_port_reset',
+			'mask': 'ata.*_port_reset'
+		}
+	]
+	kprobes = dict()
+	timeformat = '%.3f'
 	def __init__(self):
+		# if this is a phoronix test run, set some default options
+		if('LOG_FILE' in os.environ and 'TEST_RESULTS_IDENTIFIER' in os.environ):
+			self.embedded = True
+			self.addlogs = True
+			self.htmlfile = os.environ['LOG_FILE']
 		self.hostname = platform.node()
 		if(self.hostname == ''):
 			self.hostname = 'localhost'
@@ -118,6 +208,12 @@ class SystemValues:
 		if os.path.exists(rtc) and os.path.exists(rtc+'/date') and \
 			os.path.exists(rtc+'/time') and os.path.exists(rtc+'/wakealarm'):
 			self.rtcpath = rtc
+		if (hasattr(sys.stdout, 'isatty') and sys.stdout.isatty()):
+			self.ansi = True
+	def setPrecision(self, num):
+		if num < 0 or num > 6:
+			return
+		self.timeformat = '%.{0}f'.format(num)
 	def setOutputFile(self):
 		if((self.htmlfile == '') and (self.dmesgfile != '')):
 			m = re.match('(?P<name>.*)_dmesg\.txt$', self.dmesgfile)
@@ -129,32 +225,37 @@ class SystemValues:
 				self.htmlfile = m.group('name')+'.html'
 		if(self.htmlfile == ''):
 			self.htmlfile = 'output.html'
-	def initTestOutput(self, subdir):
-		if(not self.android):
-			self.prefix = self.hostname
-			v = open('/proc/version', 'r').read().strip()
-			kver = string.split(v)[2]
-		else:
-			self.prefix = 'android'
-			v = os.popen(self.adb+' shell cat /proc/version').read().strip()
-			kver = string.split(v)[2]
-		testtime = datetime.now().strftime('suspend-%m%d%y-%H%M%S')
+	def initTestOutput(self, subdir, testpath=''):
+		self.prefix = self.hostname
+		v = open('/proc/version', 'r').read().strip()
+		kver = string.split(v)[2]
+		n = datetime.now()
+		testtime = n.strftime('suspend-%m%d%y-%H%M%S')
+		if not testpath:
+			testpath = n.strftime('suspend-%y%m%d-%H%M%S')
 		if(subdir != "."):
-			self.testdir = subdir+"/"+testtime
+			self.testdir = subdir+"/"+testpath
 		else:
-			self.testdir = testtime
+			self.testdir = testpath
 		self.teststamp = \
 			'# '+testtime+' '+self.prefix+' '+self.suspendmode+' '+kver
+		if(self.embedded):
+			self.dmesgfile = \
+				'/tmp/'+testtime+'_'+self.suspendmode+'_dmesg.txt'
+			self.ftracefile = \
+				'/tmp/'+testtime+'_'+self.suspendmode+'_ftrace.txt'
+			return
 		self.dmesgfile = \
 			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'_dmesg.txt'
 		self.ftracefile = \
 			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'_ftrace.txt'
 		self.htmlfile = \
 			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'.html'
-		os.mkdir(self.testdir)
+		if not os.path.isdir(self.testdir):
+			os.mkdir(self.testdir)
 	def setDeviceFilter(self, devnames):
 		self.devicefilter = string.split(devnames)
-	def rtcWakeAlarm(self):
+	def rtcWakeAlarmOn(self):
 		os.system('echo 0 > '+self.rtcpath+'/wakealarm')
 		outD = open(self.rtcpath+'/date', 'r').read().strip()
 		outT = open(self.rtcpath+'/time', 'r').read().strip()
@@ -172,9 +273,361 @@ class SystemValues:
 			nowtime = int(datetime.now().strftime('%s'))
 		alarm = nowtime + self.rtcwaketime
 		os.system('echo %d > %s/wakealarm' % (alarm, self.rtcpath))
+	def rtcWakeAlarmOff(self):
+		os.system('echo 0 > %s/wakealarm' % self.rtcpath)
+	def initdmesg(self):
+		# get the latest time stamp from the dmesg log
+		fp = os.popen('dmesg')
+		ktime = '0'
+		for line in fp:
+			line = line.replace('\r\n', '')
+			idx = line.find('[')
+			if idx > 1:
+				line = line[idx:]
+			m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+			if(m):
+				ktime = m.group('ktime')
+		fp.close()
+		self.dmesgstart = float(ktime)
+	def getdmesg(self):
+		# store all new dmesg lines since initdmesg was called
+		fp = os.popen('dmesg')
+		op = open(self.dmesgfile, 'a')
+		for line in fp:
+			line = line.replace('\r\n', '')
+			idx = line.find('[')
+			if idx > 1:
+				line = line[idx:]
+			m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+			if(not m):
+				continue
+			ktime = float(m.group('ktime'))
+			if ktime > self.dmesgstart:
+				op.write(line)
+		fp.close()
+		op.close()
+	def addFtraceFilterFunctions(self, file):
+		fp = open(file)
+		list = fp.read().split('\n')
+		fp.close()
+		for i in list:
+			if len(i) < 2:
+				continue
+			self.tracefuncs[i] = dict()
+	def getFtraceFilterFunctions(self, current):
+		rootCheck(True)
+		if not current:
+			os.system('cat '+self.tpath+'available_filter_functions')
+			return
+		fp = open(self.tpath+'available_filter_functions')
+		master = fp.read().split('\n')
+		fp.close()
+		if len(self.debugfuncs) > 0:
+			for i in self.debugfuncs:
+				if i in master:
+					print i
+				else:
+					print self.colorText(i)
+		else:
+			for i in self.tracefuncs:
+				if 'func' in self.tracefuncs[i]:
+					i = self.tracefuncs[i]['func']
+				if i in master:
+					print i
+				else:
+					print self.colorText(i)
+	def setFtraceFilterFunctions(self, list):
+		fp = open(self.tpath+'available_filter_functions')
+		master = fp.read().split('\n')
+		fp.close()
+		flist = ''
+		for i in list:
+			if i not in master:
+				continue
+			if ' [' in i:
+				flist += i.split(' ')[0]+'\n'
+			else:
+				flist += i+'\n'
+		fp = open(self.tpath+'set_graph_function', 'w')
+		fp.write(flist)
+		fp.close()
+	def kprobeMatch(self, name, target):
+		if name not in self.kprobes:
+			return False
+		if re.match(self.kprobes[name]['mask'], target):
+			return True
+		return False
+	def basicKprobe(self, name):
+		self.kprobes[name] = {'name': name,'func': name,'args': dict(),'format': name,'mask': name}
+	def defaultKprobe(self, name, kdata):
+		k = kdata
+		for field in ['name', 'format', 'mask', 'func']:
+			if field not in k:
+				k[field] = name
+		archargs = 'args_'+platform.machine()
+		if archargs in k:
+			k['args'] = k[archargs]
+		else:
+			k['args'] = dict()
+			k['format'] = name
+		self.kprobes[name] = k
+	def kprobeColor(self, name):
+		if name not in self.kprobes or 'color' not in self.kprobes[name]:
+			return ''
+		return self.kprobes[name]['color']
+	def kprobeDisplayName(self, name, dataraw):
+		if name not in self.kprobes:
+			self.basicKprobe(name)
+		data = ''
+		quote=0
+		# first remvoe any spaces inside quotes, and the quotes
+		for c in dataraw:
+			if c == '"':
+				quote = (quote + 1) % 2
+			if quote and c == ' ':
+				data += '_'
+			elif c != '"':
+				data += c
+		fmt, args = self.kprobes[name]['format'], self.kprobes[name]['args']
+		arglist = dict()
+		# now process the args
+		for arg in sorted(args):
+			arglist[arg] = ''
+			m = re.match('.* '+arg+'=(?P<arg>.*) ', data);
+			if m:
+				arglist[arg] = m.group('arg')
+			else:
+				m = re.match('.* '+arg+'=(?P<arg>.*)', data);
+				if m:
+					arglist[arg] = m.group('arg')
+		out = fmt.format(**arglist)
+		out = out.replace(' ', '_').replace('"', '')
+		return out
+	def kprobeText(self, kprobe):
+		name, fmt, func, args = kprobe['name'], kprobe['format'], kprobe['func'], kprobe['args']
+		if re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', func):
+			doError('Kprobe "%s" has format info in the function name "%s"' % (name, func), False)
+		for arg in re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', fmt):
+			if arg not in args:
+				doError('Kprobe "%s" is missing argument "%s"' % (name, arg), False)
+		val = 'p:%s_cal %s' % (name, func)
+		for i in sorted(args):
+			val += ' %s=%s' % (i, args[i])
+		val += '\nr:%s_ret %s $retval\n' % (name, func)
+		return val
+	def addKprobes(self):
+		# first test each kprobe
+		print('INITIALIZING KPROBES...')
+		rejects = []
+		for name in sorted(self.kprobes):
+			if not self.testKprobe(self.kprobes[name]):
+				rejects.append(name)
+		# remove all failed ones from the list
+		for name in rejects:
+			vprint('Skipping KPROBE: %s' % name)
+			self.kprobes.pop(name)
+		self.fsetVal('', 'kprobe_events')
+		kprobeevents = ''
+		# set the kprobes all at once
+		for kp in self.kprobes:
+			val = self.kprobeText(self.kprobes[kp])
+			vprint('Adding KPROBE: %s\n%s' % (kp, val.strip()))
+			kprobeevents += self.kprobeText(self.kprobes[kp])
+		self.fsetVal(kprobeevents, 'kprobe_events')
+		# verify that the kprobes were set as ordered
+		check = self.fgetVal('kprobe_events')
+		linesout = len(kprobeevents.split('\n'))
+		linesack = len(check.split('\n'))
+		if linesack < linesout:
+			# if not, try appending the kprobes 1 by 1
+			for kp in self.kprobes:
+				kprobeevents = self.kprobeText(self.kprobes[kp])
+				self.fsetVal(kprobeevents, 'kprobe_events', 'a')
+		self.fsetVal('1', 'events/kprobes/enable')
+	def testKprobe(self, kprobe):
+		kprobeevents = self.kprobeText(kprobe)
+		if not kprobeevents:
+			return False
+		try:
+			self.fsetVal(kprobeevents, 'kprobe_events')
+			check = self.fgetVal('kprobe_events')
+		except:
+			return False
+		linesout = len(kprobeevents.split('\n'))
+		linesack = len(check.split('\n'))
+		if linesack < linesout:
+			return False
+		return True
+	def fsetVal(self, val, path, mode='w'):
+		file = self.tpath+path
+		if not os.path.exists(file):
+			return False
+		try:
+			fp = open(file, mode)
+			fp.write(val)
+			fp.close()
+		except:
+			pass
+		return True
+	def fgetVal(self, path):
+		file = self.tpath+path
+		res = ''
+		if not os.path.exists(file):
+			return res
+		try:
+			fp = open(file, 'r')
+			res = fp.read()
+			fp.close()
+		except:
+			pass
+		return res
+	def cleanupFtrace(self):
+		if(self.usecallgraph or self.usetraceevents):
+			self.fsetVal('0', 'events/kprobes/enable')
+			self.fsetVal('', 'kprobe_events')
+	def setupAllKprobes(self):
+		for name in self.tracefuncs:
+			self.defaultKprobe(name, self.tracefuncs[name])
+		for name in self.dev_tracefuncs:
+			self.defaultKprobe(name, self.dev_tracefuncs[name])
+	def isCallgraphFunc(self, name):
+		if len(self.debugfuncs) < 1 and self.suspendmode == 'command':
+			return True
+		if name in self.debugfuncs:
+			return True
+		funclist = []
+		for i in self.tracefuncs:
+			if 'func' in self.tracefuncs[i]:
+				funclist.append(self.tracefuncs[i]['func'])
+			else:
+				funclist.append(i)
+		if name in funclist:
+			return True
+		return False
+	def initFtrace(self, testing=False):
+		tp = self.tpath
+		print('INITIALIZING FTRACE...')
+		# turn trace off
+		self.fsetVal('0', 'tracing_on')
+		self.cleanupFtrace()
+		# set the trace clock to global
+		self.fsetVal('global', 'trace_clock')
+		# set trace buffer to a huge value
+		self.fsetVal('nop', 'current_tracer')
+		self.fsetVal('100000', 'buffer_size_kb')
+		# go no further if this is just a status check
+		if testing:
+			return
+		if self.usekprobes:
+			# add tracefunc kprobes so long as were not using full callgraph
+			if(not self.usecallgraph or len(self.debugfuncs) > 0):
+				for name in self.tracefuncs:
+					self.defaultKprobe(name, self.tracefuncs[name])
+				if self.usedevsrc:
+					for name in self.dev_tracefuncs:
+						self.defaultKprobe(name, self.dev_tracefuncs[name])
+			else:
+				self.usedevsrc = False
+			self.addKprobes()
+		# initialize the callgraph trace, unless this is an x2 run
+		if(self.usecallgraph):
+			# set trace type
+			self.fsetVal('function_graph', 'current_tracer')
+			self.fsetVal('', 'set_ftrace_filter')
+			# set trace format options
+			self.fsetVal('print-parent', 'trace_options')
+			self.fsetVal('funcgraph-abstime', 'trace_options')
+			self.fsetVal('funcgraph-cpu', 'trace_options')
+			self.fsetVal('funcgraph-duration', 'trace_options')
+			self.fsetVal('funcgraph-proc', 'trace_options')
+			self.fsetVal('funcgraph-tail', 'trace_options')
+			self.fsetVal('nofuncgraph-overhead', 'trace_options')
+			self.fsetVal('context-info', 'trace_options')
+			self.fsetVal('graph-time', 'trace_options')
+			self.fsetVal('0', 'max_graph_depth')
+			if len(self.debugfuncs) > 0:
+				self.setFtraceFilterFunctions(self.debugfuncs)
+			elif self.suspendmode == 'command':
+				self.fsetVal('', 'set_graph_function')
+			else:
+				cf = ['dpm_run_callback']
+				if(self.usetraceeventsonly):
+					cf += ['dpm_prepare', 'dpm_complete']
+				for fn in self.tracefuncs:
+					if 'func' in self.tracefuncs[fn]:
+						cf.append(self.tracefuncs[fn]['func'])
+					else:
+						cf.append(fn)
+				self.setFtraceFilterFunctions(cf)
+		if(self.usetraceevents):
+			# turn trace events on
+			events = iter(self.traceevents)
+			for e in events:
+				self.fsetVal('1', 'events/power/'+e+'/enable')
+		# clear the trace buffer
+		self.fsetVal('', 'trace')
+	def verifyFtrace(self):
+		# files needed for any trace data
+		files = ['buffer_size_kb', 'current_tracer', 'trace', 'trace_clock',
+				 'trace_marker', 'trace_options', 'tracing_on']
+		# files needed for callgraph trace data
+		tp = self.tpath
+		if(self.usecallgraph):
+			files += [
+				'available_filter_functions',
+				'set_ftrace_filter',
+				'set_graph_function'
+			]
+		for f in files:
+			if(os.path.exists(tp+f) == False):
+				return False
+		return True
+	def verifyKprobes(self):
+		# files needed for kprobes to work
+		files = ['kprobe_events', 'events']
+		tp = self.tpath
+		for f in files:
+			if(os.path.exists(tp+f) == False):
+				return False
+		return True
+	def colorText(self, str):
+		if not self.ansi:
+			return str
+		return '\x1B[31;40m'+str+'\x1B[m'
 
 sysvals = SystemValues()
 
+# Class: DevProps
+# Description:
+#	 Simple class which holds property values collected
+#	 for all the devices used in the timeline.
+class DevProps:
+	syspath = ''
+	altname = ''
+	async = True
+	xtraclass = ''
+	xtrainfo = ''
+	def out(self, dev):
+		return '%s,%s,%d;' % (dev, self.altname, self.async)
+	def debug(self, dev):
+		print '%s:\n\taltname = %s\n\t  async = %s' % (dev, self.altname, self.async)
+	def altName(self, dev):
+		if not self.altname or self.altname == dev:
+			return dev
+		return '%s [%s]' % (self.altname, dev)
+	def xtraClass(self):
+		if self.xtraclass:
+			return ' '+self.xtraclass
+		if not self.async:
+			return ' sync'
+		return ''
+	def xtraInfo(self):
+		if self.xtraclass:
+			return ' '+self.xtraclass
+		if self.async:
+			return ' async'
+		return ' sync'
+
 # Class: DeviceNode
 # Description:
 #	 A container used to create a device hierachy, with a single root node
@@ -228,6 +681,7 @@ class Data:
 	html_device_id = 0
 	stamp = 0
 	outfile = ''
+	dev_ubiquitous = ['msleep', 'udelay']
 	def __init__(self, num):
 		idchar = 'abcdefghijklmnopqrstuvwxyz'
 		self.testnumber = num
@@ -257,6 +711,9 @@ class Data:
 								'row': 0, 'color': '#FFFFCC', 'order': 9}
 		}
 		self.phases = self.sortedPhases()
+		self.devicegroups = []
+		for phase in self.phases:
+			self.devicegroups.append([phase])
 	def getStart(self):
 		return self.dmesg[self.phases[0]]['start']
 	def setStart(self, time):
@@ -273,51 +730,61 @@ class Data:
 			for dev in list:
 				d = list[dev]
 				if(d['pid'] == pid and time >= d['start'] and
-					time <= d['end']):
+					time < d['end']):
 					return False
 		return True
-	def addIntraDevTraceEvent(self, action, name, pid, time):
-		if(action == 'mutex_lock_try'):
-			color = 'red'
-		elif(action == 'mutex_lock_pass'):
-			color = 'green'
-		elif(action == 'mutex_unlock'):
-			color = 'blue'
-		else:
-			# create separate colors based on the name
-			v1 = len(name)*10 % 256
-			v2 = string.count(name, 'e')*100 % 256
-			v3 = ord(name[0])*20 % 256
-			color = '#%06X' % ((v1*0x10000) + (v2*0x100) + v3)
-		for phase in self.phases:
-			list = self.dmesg[phase]['list']
-			for dev in list:
-				d = list[dev]
-				if(d['pid'] == pid and time >= d['start'] and
-					time <= d['end']):
-					e = TraceEvent(action, name, color, time)
-					if('traceevents' not in d):
-						d['traceevents'] = []
-					d['traceevents'].append(e)
-					return d
-					break
-		return 0
-	def capIntraDevTraceEvent(self, action, name, pid, time):
-		for phase in self.phases:
+	def targetDevice(self, phaselist, start, end, pid=-1):
+		tgtdev = ''
+		for phase in phaselist:
 			list = self.dmesg[phase]['list']
-			for dev in list:
-				d = list[dev]
-				if(d['pid'] == pid and time >= d['start'] and
-					time <= d['end']):
-					if('traceevents' not in d):
-						return
-					for e in d['traceevents']:
-						if(e.action == action and
-							e.name == name and not e.ready):
-							e.length = time - e.time
-							e.ready = True
-							break
-					return
+			for devname in list:
+				dev = list[devname]
+				if(pid >= 0 and dev['pid'] != pid):
+					continue
+				devS = dev['start']
+				devE = dev['end']
+				if(start < devS or start >= devE or end <= devS or end > devE):
+					continue
+				tgtdev = dev
+				break
+		return tgtdev
+	def addDeviceFunctionCall(self, displayname, kprobename, proc, pid, start, end, cdata, rdata):
+		machstart = self.dmesg['suspend_machine']['start']
+		machend = self.dmesg['resume_machine']['end']
+		tgtdev = self.targetDevice(self.phases, start, end, pid)
+		if not tgtdev and start >= machstart and end < machend:
+			# device calls in machine phases should be serial
+			tgtdev = self.targetDevice(['suspend_machine', 'resume_machine'], start, end)
+		if not tgtdev:
+			if 'scsi_eh' in proc:
+				self.newActionGlobal(proc, start, end, pid)
+				self.addDeviceFunctionCall(displayname, kprobename, proc, pid, start, end, cdata, rdata)
+			else:
+				vprint('IGNORE: %s[%s](%d) [%f - %f] | %s | %s | %s' % (displayname, kprobename,
+					pid, start, end, cdata, rdata, proc))
+			return False
+		# detail block fits within tgtdev
+		if('src' not in tgtdev):
+			tgtdev['src'] = []
+		title = cdata+' '+rdata
+		mstr = '\(.*\) *(?P<args>.*) *\((?P<caller>.*)\+.* arg1=(?P<ret>.*)'
+		m = re.match(mstr, title)
+		if m:
+			c = m.group('caller')
+			a = m.group('args').strip()
+			r = m.group('ret')
+			if len(r) > 6:
+				r = ''
+			else:
+				r = 'ret=%s ' % r
+			l = '%0.3fms' % ((end - start) * 1000)
+			if kprobename in self.dev_ubiquitous:
+				title = '%s(%s) <- %s, %s(%s)' % (displayname, a, c, r, l)
+			else:
+				title = '%s(%s) %s(%s)' % (displayname, a, r, l)
+		e = TraceEvent(title, kprobename, start, end - start)
+		tgtdev['src'].append(e)
+		return True
 	def trimTimeVal(self, t, t0, dT, left):
 		if left:
 			if(t > t0):
@@ -353,11 +820,11 @@ class Data:
 					cg.end = self.trimTimeVal(cg.end, t0, dT, left)
 					for line in cg.list:
 						line.time = self.trimTimeVal(line.time, t0, dT, left)
-				if('traceevents' in d):
-					for e in d['traceevents']:
+				if('src' in d):
+					for e in d['src']:
 						e.time = self.trimTimeVal(e.time, t0, dT, left)
 	def normalizeTime(self, tZero):
-		# first trim out any standby or freeze clock time
+		# trim out any standby or freeze clock time
 		if(self.tSuspended != self.tResumed):
 			if(self.tResumed > tZero):
 				self.trimTime(self.tSuspended, \
@@ -365,29 +832,6 @@ class Data:
 			else:
 				self.trimTime(self.tSuspended, \
 					self.tResumed-self.tSuspended, False)
-		# shift the timeline so that tZero is the new 0
-		self.tSuspended -= tZero
-		self.tResumed -= tZero
-		self.start -= tZero
-		self.end -= tZero
-		for phase in self.phases:
-			p = self.dmesg[phase]
-			p['start'] -= tZero
-			p['end'] -= tZero
-			list = p['list']
-			for name in list:
-				d = list[name]
-				d['start'] -= tZero
-				d['end'] -= tZero
-				if('ftrace' in d):
-					cg = d['ftrace']
-					cg.start -= tZero
-					cg.end -= tZero
-					for line in cg.list:
-						line.time -= tZero
-				if('traceevents' in d):
-					for e in d['traceevents']:
-						e.time -= tZero
 	def newPhaseWithSingleAction(self, phasename, devname, start, end, color):
 		for phase in self.phases:
 			self.dmesg[phase]['order'] += 1
@@ -417,6 +861,7 @@ class Data:
 			{'list': list, 'start': start, 'end': end,
 			'row': 0, 'color': color, 'order': order}
 		self.phases = self.sortedPhases()
+		self.devicegroups.append([phasename])
 	def setPhase(self, phase, ktime, isbegin):
 		if(isbegin):
 			self.dmesg[phase]['start'] = ktime
@@ -442,7 +887,10 @@ class Data:
 		for devname in phaselist:
 			dev = phaselist[devname]
 			if(dev['end'] < 0):
-				dev['end'] = end
+				for p in self.phases:
+					if self.dmesg[p]['end'] > dev['start']:
+						dev['end'] = self.dmesg[p]['end']
+						break
 				vprint('%s (%s): callback didnt return' % (devname, phase))
 	def deviceFilter(self, devicefilter):
 		# remove all by the relatives of the filter devnames
@@ -472,22 +920,58 @@ class Data:
 		# if any calls never returned, clip them at system resume end
 		for phase in self.phases:
 			self.fixupInitcalls(phase, self.getEnd())
-	def newActionGlobal(self, name, start, end):
+	def isInsideTimeline(self, start, end):
+		if(self.start <= start and self.end > start):
+			return True
+		return False
+	def phaseOverlap(self, phases):
+		rmgroups = []
+		newgroup = []
+		for group in self.devicegroups:
+			for phase in phases:
+				if phase not in group:
+					continue
+				for p in group:
+					if p not in newgroup:
+						newgroup.append(p)
+				if group not in rmgroups:
+					rmgroups.append(group)
+		for group in rmgroups:
+			self.devicegroups.remove(group)
+		self.devicegroups.append(newgroup)
+	def newActionGlobal(self, name, start, end, pid=-1, color=''):
+		# if event starts before timeline start, expand timeline
+		if(start < self.start):
+			self.setStart(start)
+		# if event ends after timeline end, expand the timeline
+		if(end > self.end):
+			self.setEnd(end)
 		# which phase is this device callback or action "in"
 		targetphase = "none"
+		htmlclass = ''
 		overlap = 0.0
+		phases = []
 		for phase in self.phases:
 			pstart = self.dmesg[phase]['start']
 			pend = self.dmesg[phase]['end']
 			o = max(0, min(end, pend) - max(start, pstart))
-			if(o > overlap):
+			if o > 0:
+				phases.append(phase)
+			if o > overlap:
+				if overlap > 0 and phase == 'post_resume':
+					continue
 				targetphase = phase
 				overlap = o
+		if pid == -2:
+			htmlclass = ' bg'
+		if len(phases) > 1:
+			htmlclass = ' bg'
+			self.phaseOverlap(phases)
 		if targetphase in self.phases:
-			self.newAction(targetphase, name, -1, '', start, end, '')
-			return True
+			newname = self.newAction(targetphase, name, pid, '', start, end, '', htmlclass, color)
+			return (targetphase, newname)
 		return False
-	def newAction(self, phase, name, pid, parent, start, end, drv):
+	def newAction(self, phase, name, pid, parent, start, end, drv, htmlclass='', color=''):
 		# new device callback for a specific phase
 		self.html_device_id += 1
 		devid = '%s%d' % (self.idstr, self.html_device_id)
@@ -495,8 +979,19 @@ class Data:
 		length = -1.0
 		if(start >= 0 and end >= 0):
 			length = end - start
+		if pid == -2:
+			i = 2
+			origname = name
+			while(name in list):
+				name = '%s[%d]' % (origname, i)
+				i += 1
 		list[name] = {'start': start, 'end': end, 'pid': pid, 'par': parent,
 					  'length': length, 'row': 0, 'id': devid, 'drv': drv }
+		if htmlclass:
+			list[name]['htmlclass'] = htmlclass
+		if color:
+			list[name]['color'] = color
+		return name
 	def deviceIDs(self, devlist, phase):
 		idlist = []
 		list = self.dmesg[phase]['list']
@@ -536,10 +1031,21 @@ class Data:
 			vprint('    %16s: %f - %f (%d devices)' % (phase, \
 				self.dmesg[phase]['start'], self.dmesg[phase]['end'], dc))
 		vprint('            test end: %f' % self.end)
+	def deviceChildrenAllPhases(self, devname):
+		devlist = []
+		for phase in self.phases:
+			list = self.deviceChildren(devname, phase)
+			for dev in list:
+				if dev not in devlist:
+					devlist.append(dev)
+		return devlist
 	def masterTopology(self, name, list, depth):
 		node = DeviceNode(name, depth)
 		for cname in list:
-			clist = self.deviceChildren(cname, 'resume')
+			# avoid recursions
+			if name == cname:
+				continue
+			clist = self.deviceChildrenAllPhases(cname)
 			cnode = self.masterTopology(cname, clist, depth+1)
 			node.children.append(cnode)
 		return node
@@ -580,7 +1086,8 @@ class Data:
 			list = self.dmesg[phase]['list']
 			for dev in list:
 				pdev = list[dev]['par']
-				if(re.match('[0-9]*-[0-9]*\.[0-9]*[\.0-9]*\:[\.0-9]*$', pdev)):
+				pid = list[dev]['pid']
+				if(pid < 0 or re.match('[0-9]*-[0-9]*\.[0-9]*[\.0-9]*\:[\.0-9]*$', pdev)):
 					continue
 				if pdev and pdev not in real and pdev not in rootlist:
 					rootlist.append(pdev)
@@ -589,22 +1096,33 @@ class Data:
 		rootlist = self.rootDeviceList()
 		master = self.masterTopology('', rootlist, 0)
 		return self.printTopology(master)
+	def selectTimelineDevices(self, widfmt, tTotal, mindevlen):
+		# only select devices that will actually show up in html
+		self.tdevlist = dict()
+		for phase in self.dmesg:
+			devlist = []
+			list = self.dmesg[phase]['list']
+			for dev in list:
+				length = (list[dev]['end'] - list[dev]['start']) * 1000
+				width = widfmt % (((list[dev]['end']-list[dev]['start'])*100)/tTotal)
+				if width != '0.000000' and length >= mindevlen:
+					devlist.append(dev)
+			self.tdevlist[phase] = devlist
 
 # Class: TraceEvent
 # Description:
 #	 A container for trace event data found in the ftrace file
 class TraceEvent:
-	ready = False
-	name = ''
+	text = ''
 	time = 0.0
-	color = '#FFFFFF'
 	length = 0.0
-	action = ''
-	def __init__(self, a, n, c, t):
-		self.action = a
-		self.name = n
-		self.color = c
+	title = ''
+	row = 0
+	def __init__(self, a, n, t, l):
+		self.title = a
+		self.text = n
 		self.time = t
+		self.length = l
 
 # Class: FTraceLine
 # Description:
@@ -623,11 +1141,14 @@ class FTraceLine:
 	fcall = False
 	freturn = False
 	fevent = False
+	fkprobe = False
 	depth = 0
 	name = ''
 	type = ''
-	def __init__(self, t, m, d):
+	def __init__(self, t, m='', d=''):
 		self.time = float(t)
+		if not m and not d:
+			return
 		# is this a trace event
 		if(d == 'traceevent' or re.match('^ *\/\* *(?P<msg>.*) \*\/ *$', m)):
 			if(d == 'traceevent'):
@@ -644,6 +1165,18 @@ class FTraceLine:
 				self.type = emm.group('call')
 			else:
 				self.name = msg
+			km = re.match('^(?P<n>.*)_cal$', self.type)
+			if km:
+				self.fcall = True
+				self.fkprobe = True
+				self.type = km.group('n')
+				return
+			km = re.match('^(?P<n>.*)_ret$', self.type)
+			if km:
+				self.freturn = True
+				self.fkprobe = True
+				self.type = km.group('n')
+				return
 			self.fevent = True
 			return
 		# convert the duration to seconds
@@ -662,7 +1195,7 @@ class FTraceLine:
 				# includes comment with function name
 				match = re.match('^} *\/\* *(?P<n>.*) *\*\/$', m)
 				if(match):
-					self.name = match.group('n')
+					self.name = match.group('n').strip()
 		# function call
 		else:
 			self.fcall = True
-- 
2.1.4

