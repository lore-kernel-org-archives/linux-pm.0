From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v2 3/4] AnalyzeSuspend v4.4
Date: Thu,  9 Feb 2017 13:06:59 -0800
Message-ID: <80fd82001b2a4c39bc4d79f5c3ba1e4ebf6ad44a.1486674261.git.todd.e.brandt@linux.intel.com>
References: <cover.1486674261.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20895 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752551AbdBIVIp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Feb 2017 16:08:45 -0500
In-Reply-To: <cover.1486674261.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1486674261.git.todd.e.brandt@linux.intel.com>
References: <cover.1486674261.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: todd.e.brandt@intel.com, rjw@rjwysocki.net, rafael.j.wysocki@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

- when running with sudo, change output dir back to SUDO_USER ownership
- replace all os.system/popen instances with subprocess.call/Popen
- graph pm device callbacks and async threads in separate sections
- remove kprobe config section and replaced it with timeline_functions
- added new kprobe config section for dev mode: dev_timeline_functions
- merge call loops in dev mode to create a single event with a count
- added hover text to all header entries to explain what they mean
- changed the -filter option to grep device driver/name for a string
- added new options for tuning the dev mode timeline/custom kprobes

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 scripts/analyze_suspend.py | 591 +++++++++++++++++++++------------------------
 1 file changed, 272 insertions(+), 319 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index 0126859..383df79 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -24,11 +24,6 @@
 #	   https://01.org/suspendresume
 #	 Source repo
 #	   https://github.com/01org/suspendresume
-#	 Documentation
-#	   Getting Started
-#	     https://01.org/suspendresume/documentation/getting-started
-#	   Command List:
-#	     https://01.org/suspendresume/documentation/command-list
 #
 # Description:
 #	 This tool is designed to assist kernel and OS developers in optimizing
@@ -77,11 +72,13 @@ from subprocess import call, Popen, PIPE
 #	 store system values and test parameters
 class SystemValues:
 	ansi = False
-	version = '4.4'
+	version = '4.5'
 	verbose = False
 	addlogs = False
-	mindevlen = 0.001
-	mincglen = 1.0
+	mindevlen = 0.0
+	mincglen = 0.0
+	cgphase = ''
+	cgtest = -1
 	callloopmaxgap = 0.0001
 	callloopmaxlen = 0.005
 	srgap = 0
@@ -96,6 +93,7 @@ class SystemValues:
 		'device_pm_callback_end',
 		'device_pm_callback_start'
 	]
+	logmsg = ''
 	testcommand = ''
 	mempath = '/dev/mem'
 	powerfile = '/sys/power/state'
@@ -166,18 +164,38 @@ class SystemValues:
 	}
 	dev_tracefuncs = {
 		# general wait/delay/sleep
-		'msleep': { 'args_x86_64': {'time':'%di:s32'} },
-		'schedule_timeout_uninterruptible': { 'args_x86_64': {'timeout':'%di:s32'} },
-		'schedule_timeout': { 'args_x86_64': {'timeout':'%di:s32'} },
-		'udelay': { 'func':'__const_udelay', 'args_x86_64': {'loops':'%di:s32'} },
-		'usleep_range': { 'args_x86_64': {'min':'%di:s32', 'max':'%si:s32'} },
-		'mutex_lock_slowpath': { 'func':'__mutex_lock_slowpath' },
-		'acpi_os_stall': dict(),
+		'msleep': { 'args_x86_64': {'time':'%di:s32'}, 'ub': 1 },
+		'schedule_timeout_uninterruptible': { 'args_x86_64': {'timeout':'%di:s32'}, 'ub': 1 },
+		'schedule_timeout': { 'args_x86_64': {'timeout':'%di:s32'}, 'ub': 1 },
+		'udelay': { 'func':'__const_udelay', 'args_x86_64': {'loops':'%di:s32'}, 'ub': 1 },
+		'usleep_range': { 'args_x86_64': {'min':'%di:s32', 'max':'%si:s32'}, 'ub': 1 },
+		'mutex_lock_slowpath': { 'func':'__mutex_lock_slowpath', 'ub': 1 },
+		'acpi_os_stall': {'ub': 1},
 		# ACPI
 		'acpi_resume_power_resources': dict(),
 		'acpi_ps_parse_aml': dict(),
 		# filesystem
 		'ext4_sync_fs': dict(),
+		# 80211
+		'iwlagn_mac_start': dict(),
+		'iwlagn_alloc_bcast_station': dict(),
+		'iwl_trans_pcie_start_hw': dict(),
+		'iwl_trans_pcie_start_fw': dict(),
+		'iwl_run_init_ucode': dict(),
+		'iwl_load_ucode_wait_alive': dict(),
+		'iwl_alive_start': dict(),
+		'iwlagn_mac_stop': dict(),
+		'iwlagn_mac_suspend': dict(),
+		'iwlagn_mac_resume': dict(),
+		'iwlagn_mac_add_interface': dict(),
+		'iwlagn_mac_remove_interface': dict(),
+		'iwlagn_mac_change_interface': dict(),
+		'iwlagn_mac_config': dict(),
+		'iwlagn_configure_filter': dict(),
+		'iwlagn_mac_hw_scan': dict(),
+		'iwlagn_bss_info_changed': dict(),
+		'iwlagn_mac_channel_switch': dict(),
+		'iwlagn_mac_flush': dict(),
 		# ATA
 		'ata_eh_recover': { 'args_x86_64': {'port':'+36(%di):s32'} },
 		# i915
@@ -196,14 +214,6 @@ class SystemValues:
 		'intel_opregion_init': dict(),
 		'intel_fbdev_set_suspend': dict(),
 	}
-	kprobes_postresume = [
-		{
-			'name': 'ataportrst',
-			'func': 'ata_eh_recover',
-			'args': {'port':'+36(%di):s32'},
-			'format': 'ata{port}_port_reset'
-		}
-	]
 	kprobes = dict()
 	timeformat = '%.3f'
 	def __init__(self):
@@ -429,45 +439,65 @@ class SystemValues:
 		if 'args' in kprobe:
 			args = kprobe['args']
 		if re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', func):
-			doError('Kprobe "%s" has format info in the function name "%s"' % (name, func), False)
+			doError('Kprobe "%s" has format info in the function name "%s"' % (name, func))
 		for arg in re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', fmt):
 			if arg not in args:
-				doError('Kprobe "%s" is missing argument "%s"' % (name, arg), False)
+				doError('Kprobe "%s" is missing argument "%s"' % (name, arg))
 		val = 'p:%s_cal %s' % (name, func)
 		for i in sorted(args):
 			val += ' %s=%s' % (i, args[i])
 		val += '\nr:%s_ret %s $retval\n' % (name, func)
 		return val
-	def addKprobes(self):
+	def addKprobes(self, output=False):
+		if len(sysvals.kprobes) < 1:
+			return
+		if output:
+			print('    kprobe functions in this kernel:')
 		# first test each kprobe
-		print('INITIALIZING KPROBES...')
 		rejects = []
+		# sort kprobes: trace, ub-dev, custom, dev
+		kpl = [[], [], [], []]
 		for name in sorted(self.kprobes):
+			res = self.colorText('YES', 32)
 			if not self.testKprobe(name, self.kprobes[name]):
+				res = self.colorText('NO')
 				rejects.append(name)
+			else:
+				if name in self.tracefuncs:
+					kpl[0].append(name)
+				elif name in self.dev_tracefuncs:
+					if 'ub' in self.dev_tracefuncs[name]:
+						kpl[1].append(name)
+					else:
+						kpl[3].append(name)
+				else:
+					kpl[2].append(name)
+			if output:
+				print('         %s: %s' % (name, res))
+		kplist = kpl[0] + kpl[1] + kpl[2] + kpl[3]
 		# remove all failed ones from the list
 		for name in rejects:
-			vprint('Skipping KPROBE: %s' % name)
 			self.kprobes.pop(name)
+		# set the kprobes all at once
 		self.fsetVal('', 'kprobe_events')
 		kprobeevents = ''
-		# set the kprobes all at once
-		for kp in self.kprobes:
-			val = self.kprobeText(kp, self.kprobes[kp])
-			vprint('Adding KPROBE: %s\n%s' % (kp, val.strip()))
+		for kp in kplist:
 			kprobeevents += self.kprobeText(kp, self.kprobes[kp])
 		self.fsetVal(kprobeevents, 'kprobe_events')
 		# verify that the kprobes were set as ordered
 		check = self.fgetVal('kprobe_events')
-		linesout = len(kprobeevents.split('\n'))
-		linesack = len(check.split('\n'))
-		if linesack < linesout:
-			# if not, try appending the kprobes 1 by 1
-			for kp in self.kprobes:
-				kprobeevents = self.kprobeText(kp, self.kprobes[kp])
-				self.fsetVal(kprobeevents, 'kprobe_events', 'a')
+		linesout = len(kprobeevents.split('\n')) - 1
+		linesack = len(check.split('\n')) - 1
+		if output:
+			res = '%d/%d' % (linesack, linesout)
+			if linesack < linesout:
+				res = self.colorText(res, 31)
+			else:
+				res = self.colorText(res, 32)
+			print('    working kprobe functions enabled: %s' % res)
 		self.fsetVal('1', 'events/kprobes/enable')
 	def testKprobe(self, kname, kprobe):
+		self.fsetVal('0', 'events/kprobes/enable')
 		kprobeevents = self.kprobeText(kname, kprobe)
 		if not kprobeevents:
 			return False
@@ -486,8 +516,9 @@ class SystemValues:
 		if not os.path.exists(file):
 			return False
 		try:
-			fp = open(file, mode)
+			fp = open(file, mode, 0)
 			fp.write(val)
+			fp.flush()
 			fp.close()
 		except:
 			pass
@@ -525,7 +556,6 @@ class SystemValues:
 				return True
 		return False
 	def initFtrace(self, testing=False):
-		tp = self.tpath
 		print('INITIALIZING FTRACE...')
 		# turn trace off
 		self.fsetVal('0', 'tracing_on')
@@ -570,7 +600,8 @@ class SystemValues:
 			if self.usedevsrc:
 				for name in self.dev_tracefuncs:
 					self.defaultKprobe(name, self.dev_tracefuncs[name])
-			self.addKprobes()
+			print('INITIALIZING KPROBES...')
+			self.addKprobes(self.verbose)
 		if(self.usetraceevents):
 			# turn trace events on
 			events = iter(self.traceevents)
@@ -602,10 +633,10 @@ class SystemValues:
 			if(os.path.exists(tp+f) == False):
 				return False
 		return True
-	def colorText(self, str):
+	def colorText(self, str, color=31):
 		if not self.ansi:
 			return str
-		return '\x1B[31;40m'+str+'\x1B[m'
+		return '\x1B[%d;40m%s\x1B[m' % (color, str)
 
 sysvals = SystemValues()
 
@@ -658,8 +689,6 @@ class DeviceNode:
 #	 The primary container for suspend/resume test data. There is one for
 #	 each test run. The data is organized into a cronological hierarchy:
 #	 Data.dmesg {
-#		root structure, started as dmesg & ftrace, but now only ftrace
-#		contents: times for suspend start/end, resume start/end, fwdata
 #		phases {
 #			10 sequential, non-overlapping phases of S/R
 #			contents: times for phase start/end, order/color data for html
@@ -670,7 +699,7 @@ class DeviceNode:
 #					contents: start/stop times, pid/cpu/driver info
 #						parents/children, html id for timeline/callgraph
 #						optionally includes an ftrace callgraph
-#						optionally includes intradev trace events
+#						optionally includes dev/ps data
 #				}
 #			}
 #		}
@@ -697,16 +726,9 @@ class Data:
 	stamp = 0
 	outfile = ''
 	devpids = []
-	dev_ubiquitous = [
-		'msleep',
-		'schedule_timeout_uninterruptible',
-		'schedule_timeout',
-		'udelay',
-		'usleep_range',
-		'mutex_lock_slowpath'
-	]
+	kerror = False
 	def __init__(self, num):
-		idchar = 'abcdefghijklmnopqrstuvwxyz'
+		idchar = 'abcdefghij'
 		self.pstl = dict()
 		self.testnumber = num
 		self.idstr = idchar[num]
@@ -738,6 +760,35 @@ class Data:
 		self.devicegroups = []
 		for phase in self.phases:
 			self.devicegroups.append([phase])
+		self.errorinfo = {'suspend':[],'resume':[]}
+	def extractErrorInfo(self, dmesg):
+		error = ''
+		tm = 0.0
+		for i in range(len(dmesg)):
+			if 'Call Trace:' in dmesg[i]:
+				m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) .*', dmesg[i])
+				if not m:
+					continue
+				tm = float(m.group('ktime'))
+				if tm < self.start or tm > self.end:
+					continue
+				for j in range(i-10, i+1):
+					error += dmesg[j]
+				continue
+			if error:
+				m = re.match('[ \t]*\[ *[0-9\.]*\]  \[\<[0-9a-fA-F]*\>\] .*', dmesg[i])
+				if m:
+					error += dmesg[i]
+				else:
+					if tm < self.tSuspended:
+						dir = 'suspend'
+					else:
+						dir = 'resume'
+					error = error.replace('<', '&lt').replace('>', '&gt')
+					vprint('kernel error found in %s at %f' % (dir, tm))
+					self.errorinfo[dir].append((tm, error))
+					self.kerror = True
+					error = ''
 	def setStart(self, time):
 		self.start = time
 	def setEnd(self, time):
@@ -751,9 +802,8 @@ class Data:
 					time < d['end']):
 					return False
 		return True
-	def sourcePhase(self, start, end):
+	def sourcePhase(self, start):
 		for phase in self.phases:
-			pstart = self.dmesg[phase]['start']
 			pend = self.dmesg[phase]['end']
 			if start <= pend:
 				return phase
@@ -798,7 +848,7 @@ class Data:
 				threadname = 'kthread-%d' % (pid)
 			else:
 				threadname = '%s-%d' % (proc, pid)
-			tgtphase = self.sourcePhase(start, end)
+			tgtphase = self.sourcePhase(start)
 			self.newAction(tgtphase, threadname, pid, '', start, end, '', ' kth', '')
 			return self.addDeviceFunctionCall(displayname, kprobename, proc, pid, start, end, cdata, rdata)
 		# this should not happen
@@ -809,8 +859,9 @@ class Data:
 		# place the call data inside the src element of the tgtdev
 		if('src' not in tgtdev):
 			tgtdev['src'] = []
+		dtf = sysvals.dev_tracefuncs
 		ubiquitous = False
-		if kprobename in self.dev_ubiquitous:
+		if kprobename in dtf and 'ub' in dtf[kprobename]:
 			ubiquitous = True
 		title = cdata+' '+rdata
 		mstr = '\(.*\) *(?P<args>.*) *\((?P<caller>.*)\+.* arg1=(?P<ret>.*)'
@@ -823,7 +874,7 @@ class Data:
 				r = ''
 			else:
 				r = 'ret=%s ' % r
-			if ubiquitous and c in self.dev_ubiquitous:
+			if ubiquitous and c in dtf and 'ub' in dtf[c]:
 				return False
 		color = sysvals.kprobeColor(kprobename)
 		e = DevFunction(displayname, a, c, r, start, end, ubiquitous, proc, pid, color)
@@ -917,6 +968,8 @@ class Data:
 		self.tSuspended = self.trimTimeVal(self.tSuspended, t0, dT, left)
 		self.tResumed = self.trimTimeVal(self.tResumed, t0, dT, left)
 		self.start = self.trimTimeVal(self.start, t0, dT, left)
+		self.tKernSus = self.trimTimeVal(self.tKernSus, t0, dT, left)
+		self.tKernRes = self.trimTimeVal(self.tKernRes, t0, dT, left)
 		self.end = self.trimTimeVal(self.end, t0, dT, left)
 		for phase in self.phases:
 			p = self.dmesg[phase]
@@ -964,7 +1017,7 @@ class Data:
 		for t in sorted(tmp):
 			slist.append(tmp[t])
 		return slist
-	def fixupInitcalls(self, phase, end):
+	def fixupInitcalls(self, phase):
 		# if any calls never returned, clip them at system resume end
 		phaselist = self.dmesg[phase]['list']
 		for devname in phaselist:
@@ -976,8 +1029,6 @@ class Data:
 						break
 				vprint('%s (%s): callback didnt return' % (devname, phase))
 	def deviceFilter(self, devicefilter):
-		# check each device name & driver name
-		# remove it if it does not include one of the filter strings
 		for phase in self.phases:
 			list = self.dmesg[phase]['list']
 			rmlist = []
@@ -994,7 +1045,7 @@ class Data:
 	def fixupInitcallsThatDidntReturn(self):
 		# if any calls never returned, clip them at system resume end
 		for phase in self.phases:
-			self.fixupInitcalls(phase, self.end)
+			self.fixupInitcalls(phase)
 	def phaseOverlap(self, phases):
 		rmgroups = []
 		newgroup = []
@@ -1068,22 +1119,6 @@ class Data:
 		if color:
 			list[name]['color'] = color
 		return name
-	def deviceIDs(self, devlist, phase):
-		idlist = []
-		list = self.dmesg[phase]['list']
-		for devname in list:
-			if devname in devlist:
-				idlist.append(list[devname]['id'])
-		return idlist
-	def deviceParentID(self, devname, phase):
-		pdev = ''
-		pdevid = ''
-		list = self.dmesg[phase]['list']
-		if devname in list:
-			pdev = list[devname]['par']
-		if pdev in list:
-			return list[pdev]['id']
-		return pdev
 	def deviceChildren(self, devname, phase):
 		devlist = []
 		list = self.dmesg[phase]['list']
@@ -1091,15 +1126,6 @@ class Data:
 			if(list[child]['par'] == devname):
 				devlist.append(child)
 		return devlist
-	def deviceDescendants(self, devname, phase):
-		children = self.deviceChildren(devname, phase)
-		family = children
-		for child in children:
-			family += self.deviceDescendants(child, phase)
-		return family
-	def deviceChildrenIDs(self, devname, phase):
-		devlist = self.deviceChildren(devname, phase)
-		return self.deviceIDs(devlist, phase)
 	def printDetails(self):
 		vprint('Timeline Details:')
 		vprint('          test start: %f' % self.start)
@@ -1418,7 +1444,6 @@ class FTraceLine:
 			print('%s -- %f (%02d): %s() { (%.3f us)' % (dev, self.time, \
 				self.depth, self.name, self.length*1000000))
 	def startMarker(self):
-		global sysvals
 		# Is this the starting line of a suspend?
 		if not self.fevent:
 			return False
@@ -1721,8 +1746,9 @@ class Timeline:
 	rows = 0	# total timeline rows
 	rowlines = dict()
 	rowheight = dict()
-	def __init__(self, rowheight):
+	def __init__(self, rowheight, scaleheight):
 		self.rowH = rowheight
+		self.scaleH = scaleheight
 		self.html = {
 			'header': '',
 			'timeline': '',
@@ -1921,7 +1947,6 @@ class Timeline:
 #	 A list of values describing the properties of these test runs
 class TestProps:
 	stamp = ''
-	tracertype = ''
 	S0i3 = False
 	fwdata = []
 	ftrace_line_fmt_fg = \
@@ -1939,14 +1964,13 @@ class TestProps:
 	def __init__(self):
 		self.ktemp = dict()
 	def setTracerType(self, tracer):
-		self.tracertype = tracer
 		if(tracer == 'function_graph'):
 			self.cgformat = True
 			self.ftrace_line_fmt = self.ftrace_line_fmt_fg
 		elif(tracer == 'nop'):
 			self.ftrace_line_fmt = self.ftrace_line_fmt_nop
 		else:
-			doError('Invalid tracer format: [%s]' % tracer, False)
+			doError('Invalid tracer format: [%s]' % tracer)
 
 # Class: TestRun
 # Description:
@@ -1995,7 +2019,6 @@ class ProcessMonitor:
 			out += '%s-%s %d' % (val['name'], pid, jiffies)
 		return 'ps - '+out
 	def processMonitor(self, tid):
-		global sysvals
 		while self.running:
 			out = self.procstat()
 			if out:
@@ -2015,7 +2038,7 @@ class ProcessMonitor:
 # Arguments:
 #	 msg: the debug/log message to print
 def vprint(msg):
-	global sysvals
+	sysvals.logmsg += msg+'\n'
 	if(sysvals.verbose):
 		print(msg)
 
@@ -2026,8 +2049,6 @@ def vprint(msg):
 # Arguments:
 #	 m: the valid re.match output for the stamp line
 def parseStamp(line, data):
-	global sysvals
-
 	m = re.match(sysvals.stampfmt, line)
 	data.stamp = {'time': '', 'host': '', 'mode': ''}
 	dt = datetime(int(m.group('y'))+2000, int(m.group('m')),
@@ -2076,8 +2097,6 @@ def diffStamp(stamp1, stamp2):
 #	 required for primary parsing. Set the usetraceevents and/or
 #	 usetraceeventsonly flags in the global sysvals object
 def doesTraceLogHaveTraceEvents():
-	global sysvals
-
 	# check for kprobes
 	sysvals.usekprobes = False
 	out = call('grep -q "_cal: (" '+sysvals.ftracefile, shell=True)
@@ -2120,8 +2139,6 @@ def doesTraceLogHaveTraceEvents():
 # Arguments:
 #	 testruns: the array of Data objects obtained from parseKernelLog
 def appendIncompleteTraceLog(testruns):
-	global sysvals
-
 	# create TestRun vessels for ftrace parsing
 	testcnt = len(testruns)
 	testidx = 0
@@ -2312,8 +2329,7 @@ def appendIncompleteTraceLog(testruns):
 								dev['ftrace'] = cg
 						break
 
-		if(sysvals.verbose):
-			test.data.printDetails()
+		test.data.printDetails()
 
 # Function: parseTraceLog
 # Description:
@@ -2324,11 +2340,9 @@ def appendIncompleteTraceLog(testruns):
 # Output:
 #	 An array of Data objects
 def parseTraceLog():
-	global sysvals
-
 	vprint('Analyzing the ftrace data...')
 	if(os.path.exists(sysvals.ftracefile) == False):
-		doError('%s does not exist' % sysvals.ftracefile, False)
+		doError('%s does not exist' % sysvals.ftracefile)
 
 	sysvals.setupAllKprobes()
 	tracewatch = []
@@ -2398,10 +2412,6 @@ def parseTraceLog():
 			testrun = TestRun(data)
 			testruns.append(testrun)
 			parseStamp(tp.stamp, data)
-			if sysvals.suspendmode == 'mem' and len(tp.fwdata) > data.testnumber:
-				data.fwSuspend, data.fwResume = tp.fwdata[data.testnumber]
-				if(data.fwSuspend > 0 or data.fwResume > 0):
-					data.fwValid = True
 			data.setStart(t.time)
 			data.tKernSus = t.time
 			continue
@@ -2427,6 +2437,11 @@ def parseTraceLog():
 				data.tKernRes = t.time
 			if data.dmesg['resume_complete']['end'] < 0:
 				data.dmesg['resume_complete']['end'] = t.time
+			if sysvals.suspendmode == 'mem' and len(tp.fwdata) > data.testnumber:
+				data.fwSuspend, data.fwResume = tp.fwdata[data.testnumber]
+				if(data.tSuspended != 0 and data.tResumed != 0 and \
+					(data.fwSuspend > 0 or data.fwResume > 0)):
+					data.fwValid = True
 			if(not sysvals.usetracemarkers):
 				# no trace markers? then quit and be sure to finish recording
 				# the event we used to trigger resume end
@@ -2713,9 +2728,8 @@ def parseTraceLog():
 					cg.newActionFromFunction(data)
 
 	if sysvals.suspendmode == 'command':
-		if(sysvals.verbose):
-			for data in testdata:
-				data.printDetails()
+		for data in testdata:
+			data.printDetails()
 		return testdata
 
 	# fill in any missing phases
@@ -2723,7 +2737,7 @@ def parseTraceLog():
 		lp = data.phases[0]
 		for p in data.phases:
 			if(data.dmesg[p]['start'] < 0 and data.dmesg[p]['end'] < 0):
-				print('WARNING: phase "%s" is missing!' % p)
+				vprint('WARNING: phase "%s" is missing!' % p)
 			if(data.dmesg[p]['start'] < 0):
 				data.dmesg[p]['start'] = data.dmesg[lp]['end']
 				if(p == 'resume_machine'):
@@ -2732,6 +2746,8 @@ def parseTraceLog():
 					data.tLow = 0
 			if(data.dmesg[p]['end'] < 0):
 				data.dmesg[p]['end'] = data.dmesg[p]['start']
+			if(p != lp and not ('machine' in p and 'machine' in lp)):
+				data.dmesg[lp]['end'] = data.dmesg[p]['start']
 			lp = p
 
 		if(len(sysvals.devicefilter) > 0):
@@ -2739,8 +2755,7 @@ def parseTraceLog():
 		data.fixupInitcallsThatDidntReturn()
 		if sysvals.usedevsrc:
 			data.optimizeDevSrc()
-		if sysvals.verbose:
-			data.printDetails()
+		data.printDetails()
 
 	# x2: merge any overlapping devices between test runs
 	if sysvals.usedevsrc and len(testdata) > 1:
@@ -2752,50 +2767,6 @@ def parseTraceLog():
 		testdata[0].stitchTouchingThreads(testdata[1:])
 	return testdata
 
-# Function: loadRawKernelLog
-# Description:
-#	 Load a raw kernel log that wasn't created by this tool, it might be
-#	 possible to extract a valid suspend/resume log
-def loadRawKernelLog(dmesgfile):
-	global sysvals
-
-	stamp = {'time': '', 'host': '', 'mode': 'mem', 'kernel': ''}
-	stamp['time'] = datetime.now().strftime('%B %d %Y, %I:%M:%S %p')
-	stamp['host'] = sysvals.hostname
-
-	testruns = []
-	data = 0
-	lf = open(dmesgfile, 'r')
-	for line in lf:
-		line = line.replace('\r\n', '')
-		idx = line.find('[')
-		if idx > 1:
-			line = line[idx:]
-		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
-		if(not m):
-			continue
-		msg = m.group("msg")
-		m = re.match('PM: Syncing filesystems.*', msg)
-		if(m):
-			if(data):
-				testruns.append(data)
-			data = Data(len(testruns))
-			data.stamp = stamp
-		if(data):
-			m = re.match('.* *(?P<k>[0-9]\.[0-9]{2}\.[0-9]-.*) .*', msg)
-			if(m):
-				stamp['kernel'] = m.group('k')
-			m = re.match('PM: Preparing system for (?P<m>.*) sleep', msg)
-			if(m):
-				stamp['mode'] = m.group('m')
-			data.dmesgtext.append(line)
-	if(data):
-		testruns.append(data)
-		sysvals.stamp = stamp
-		sysvals.suspendmode = stamp['mode']
-	lf.close()
-	return testruns
-
 # Function: loadKernelLog
 # Description:
 #	 [deprecated for kernel 3.15.0 or newer]
@@ -2803,15 +2774,16 @@ def loadRawKernelLog(dmesgfile):
 #	 The dmesg filename is taken from sysvals
 # Output:
 #	 An array of empty Data objects with only their dmesgtext attributes set
-def loadKernelLog():
-	global sysvals
-
+def loadKernelLog(justtext=False):
 	vprint('Analyzing the dmesg data...')
 	if(os.path.exists(sysvals.dmesgfile) == False):
-		doError('%s does not exist' % sysvals.dmesgfile, False)
+		doError('%s does not exist' % sysvals.dmesgfile)
 
+	if justtext:
+		dmesgtext = []
 	# there can be multiple test runs in a single file
 	tp = TestProps()
+	tp.stamp = datetime.now().strftime('# suspend-%m%d%y-%H%M%S localhost mem unknown')
 	testruns = []
 	data = 0
 	lf = open(sysvals.dmesgfile, 'r')
@@ -2832,6 +2804,9 @@ def loadKernelLog():
 		if(not m):
 			continue
 		msg = m.group("msg")
+		if justtext:
+			dmesgtext.append(line)
+			continue
 		if(re.match('PM: Syncing filesystems.*', msg)):
 			if(data):
 				testruns.append(data)
@@ -2841,24 +2816,24 @@ def loadKernelLog():
 				data.fwSuspend, data.fwResume = tp.fwdata[data.testnumber]
 				if(data.fwSuspend > 0 or data.fwResume > 0):
 					data.fwValid = True
-		if(re.match('ACPI: resume from mwait', msg)):
-			print('NOTE: This suspend appears to be freeze rather than'+\
-				' %s, it will be treated as such' % sysvals.suspendmode)
-			sysvals.suspendmode = 'freeze'
 		if(not data):
 			continue
+		m = re.match('.* *(?P<k>[0-9]\.[0-9]{2}\.[0-9]-.*) .*', msg)
+		if(m):
+			sysvals.stamp['kernel'] = m.group('k')
+		m = re.match('PM: Preparing system for (?P<m>.*) sleep', msg)
+		if(m):
+			sysvals.stamp['mode'] = sysvals.suspendmode = m.group('m')
 		data.dmesgtext.append(line)
-	if(data):
-		testruns.append(data)
 	lf.close()
 
-	if(len(testruns) < 1):
-		# bad log, but see if you can extract something meaningful anyway
-		testruns = loadRawKernelLog(sysvals.dmesgfile)
-
-	if(len(testruns) < 1):
-		doError(' dmesg log is completely unreadable: %s' \
-			% sysvals.dmesgfile, False)
+	if justtext:
+		return dmesgtext
+	if data:
+		testruns.append(data)
+	if len(testruns) < 1:
+		doError(' dmesg log has no suspend/resume data: %s' \
+			% sysvals.dmesgfile)
 
 	# fix lines with same timestamp/function with the call and return swapped
 	for data in testruns:
@@ -2890,8 +2865,6 @@ def loadKernelLog():
 # Output:
 #	 The filled Data object
 def parseKernelLog(data):
-	global sysvals
-
 	phase = 'suspend_runtime'
 
 	if(data.fwValid):
@@ -2949,7 +2922,6 @@ def parseKernelLog(data):
 	prevktime = -1.0
 	actions = dict()
 	for line in data.dmesgtext:
-		# -- preprocessing --
 		# parse each dmesg line into the time and message
 		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 		if(m):
@@ -2957,8 +2929,6 @@ def parseKernelLog(data):
 			try:
 				ktime = float(val)
 			except:
-				doWarning('INVALID DMESG LINE: '+\
-					line.replace('\n', ''), 'dmesg')
 				continue
 			msg = m.group('msg')
 			# initialize data start to first line time
@@ -2976,12 +2946,12 @@ def parseKernelLog(data):
 			phase = 'resume_noirq'
 			data.dmesg[phase]['start'] = ktime
 
-		# -- phase changes --
 		# suspend start
 		if(re.match(dm['suspend_prepare'], msg)):
 			phase = 'suspend_prepare'
 			data.dmesg[phase]['start'] = ktime
 			data.setStart(ktime)
+			data.tKernSus = ktime
 		# suspend start
 		elif(re.match(dm['suspend'], msg)):
 			data.dmesg['suspend_prepare']['end'] = ktime
@@ -3038,7 +3008,7 @@ def parseKernelLog(data):
 		elif(re.match(dm['post_resume'], msg)):
 			data.dmesg['resume_complete']['end'] = ktime
 			data.setEnd(ktime)
-			phase = 'post_resume'
+			data.tKernRes = ktime
 			break
 
 		# -- device callbacks --
@@ -3065,7 +3035,6 @@ def parseKernelLog(data):
 					dev['length'] = int(t)
 					dev['end'] = ktime
 
-		# -- non-devicecallback actions --
 		# if trace events are not available, these are better than nothing
 		if(not sysvals.usetraceevents):
 			# look for known actions
@@ -3125,8 +3094,7 @@ def parseKernelLog(data):
 		for event in actions[name]:
 			data.newActionGlobal(name, event['begin'], event['end'])
 
-	if(sysvals.verbose):
-		data.printDetails()
+	data.printDetails()
 	if(len(sysvals.devicefilter) > 0):
 		data.deviceFilter(sysvals.devicefilter)
 	data.fixupInitcallsThatDidntReturn()
@@ -3138,8 +3106,6 @@ def parseKernelLog(data):
 # Arguments:
 #	 testruns: array of Data objects from parseTraceLog
 def createHTMLSummarySimple(testruns, htmlfile):
-	global sysvals
-
 	# print out the basic summary of all the tests
 	hf = open(htmlfile, 'w')
 
@@ -3264,7 +3230,6 @@ def createHTMLSummarySimple(testruns, htmlfile):
 	hf.close()
 
 def htmlTitle():
-	global sysvals
 	modename = {
 		'freeze': 'Freeze (S0)',
 		'standby': 'Standby (S1)',
@@ -3297,13 +3262,14 @@ def ordinal(value):
 # Output:
 #	 True if the html file was created, false if it failed
 def createHTML(testruns):
-	global sysvals
-
 	if len(testruns) < 1:
 		print('ERROR: Not enough test data to build a timeline')
 		return
 
+	kerror = False
 	for data in testruns:
+		if data.kerror:
+			kerror = True
 		data.normalizeTime(testruns[-1].tSuspended)
 
 	x2changes = ['', 'absolute']
@@ -3318,6 +3284,7 @@ def createHTML(testruns):
 	html_timeline = '<div id="dmesgzoombox" class="zoombox">\n<div id="{0}" class="timeline" style="height:{1}px">\n'
 	html_tblock = '<div id="block{0}" class="tblock" style="left:{1}%;width:{2}%;"><div class="tback" style="height:{3}px"></div>\n'
 	html_device = '<div id="{0}" title="{1}" class="thread{7}" style="left:{2}%;top:{3}px;height:{4}px;width:{5}%;{8}">{6}</div>\n'
+	html_error = '<div id="{1}" title="kernel error/warning" class="err" style="right:{0}%">ERROR&rarr;</div>\n'
 	html_traceevent = '<div title="{0}" class="traceevent{6}" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;{7}">{5}</div>\n'
 	html_cpuexec = '<div class="jiffie" style="left:{0}%;top:{1}px;height:{2}px;width:{3}%;background:{4};"></div>\n'
 	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}px;height:{3}px;background-color:{4}">{5}</div>\n'
@@ -3347,11 +3314,16 @@ def createHTML(testruns):
 	hoverZ = 'z-index:8;'
 	if sysvals.usedevsrc:
 		hoverZ = ''
+	scaleH = 20
+	scaleTH = 20
+	if kerror:
+		scaleH = 40
+		scaleTH = 60
 
 	# device timeline
 	vprint('Creating Device Timeline...')
 
-	devtl = Timeline(30)
+	devtl = Timeline(30, scaleH)
 
 	# Generate the header for this timeline
 	for data in testruns:
@@ -3415,7 +3387,6 @@ def createHTML(testruns):
 	# time scale for potentially multiple datasets
 	t0 = testruns[0].start
 	tMax = testruns[-1].end
-	tSuspended = testruns[-1].tSuspended
 	tTotal = tMax - t0
 
 	# determine the maximum number of rows we need to draw
@@ -3507,6 +3478,11 @@ def createHTML(testruns):
 				devtl.html['timeline'] += html_phase.format(left, width, \
 					'%.3f'%devtl.scaleH, '%.3f'%devtl.bodyH, \
 					data.dmesg[b]['color'], '')
+			for e in data.errorinfo[dir]:
+				# draw red lines for any kernel errors found
+				t, err = e
+				right = '%f' % (((mMax-t)*100.0)/mTotal)
+				devtl.html['timeline'] += html_error.format(right, err)
 			for b in sorted(phases[dir]):
 				# draw the devices for this phase
 				phaselist = data.dmesg[b]['list']
@@ -3623,8 +3599,7 @@ def createHTML(testruns):
 		t2 {color:black;font:25px Times;}\n\
 		t3 {color:black;font:20px Times;white-space:nowrap;}\n\
 		t4 {color:black;font:bold 30px Times;line-height:60px;white-space:nowrap;}\n\
-		cS {color:blue;font:bold 11px Times;}\n\
-		cR {color:red;font:bold 11px Times;}\n\
+		cS {font:bold 13px Times;}\n\
 		table {width:100%;}\n\
 		.gray {background-color:rgba(80,80,80,0.1);}\n\
 		.green {background-color:rgba(204,255,204,0.4);}\n\
@@ -3655,7 +3630,8 @@ def createHTML(testruns):
 		.traceevent:hover {color:white;font-weight:bold;border:1px solid white;}\n\
 		.phase {position:absolute;overflow:hidden;border:0px;text-align:center;}\n\
 		.phaselet {position:absolute;overflow:hidden;border:0px;text-align:center;height:100px;font-size:24px;}\n\
-		.t {position:absolute;pointer-events:none;top:0%;height:100%;border-right:1px solid black;z-index:6;}\n\
+		.t {position:absolute;line-height:'+('%d'%scaleTH)+'px;pointer-events:none;top:0;height:100%;border-right:1px solid black;z-index:6;}\n\
+		.err {position:absolute;top:0%;height:100%;border-right:3px solid red;color:red;font:bold 14px Times;line-height:18px;}\n\
 		.legend {position:relative; width:100%; height:40px; text-align:center;margin-bottom:20px}\n\
 		.legend .square {position:absolute;cursor:pointer;top:10px; width:0px;height:20px;border:1px solid;padding-left:20px;}\n\
 		button {height:40px;width:200px;margin-bottom:20px;margin-top:20px;font-size:24px;}\n\
@@ -3683,6 +3659,8 @@ def createHTML(testruns):
 	# write the test title and general info header
 	if(sysvals.stamp['time'] != ""):
 		hf.write(headline_version)
+		if sysvals.logmsg:
+			hf.write('<button id="showtest" class="logbtn">log</button>')
 		if sysvals.addlogs and sysvals.dmesgfile:
 			hf.write('<button id="showdmesg" class="logbtn">dmesg</button>')
 		if sysvals.addlogs and sysvals.ftracefile:
@@ -3718,7 +3696,10 @@ def createHTML(testruns):
 	hf.write('</div>\n')
 
 	# write the ftrace data (callgraph)
-	data = testruns[-1]
+	if sysvals.cgtest >= 0 and len(testruns) > sysvals.cgtest:
+		data = testruns[sysvals.cgtest]
+	else:
+		data = testruns[-1]
 	if(sysvals.usecallgraph and not sysvals.embedded):
 		hf.write('<section id="callgraphs" class="callgraph">\n')
 		# write out the ftrace data converted to html
@@ -3728,6 +3709,8 @@ def createHTML(testruns):
 		html_func_leaf = '<article>{0} {1}</article>\n'
 		num = 0
 		for p in data.phases:
+			if sysvals.cgphase and p != sysvals.cgphase:
+				continue
 			list = data.dmesg[p]['list']
 			for devname in data.sortedDevices(p):
 				if('ftrace' not in list[devname]):
@@ -3765,11 +3748,15 @@ def createHTML(testruns):
 				hf.write(html_func_end)
 		hf.write('\n\n    </section>\n')
 
+	# add the test log as a hidden div
+	if sysvals.logmsg:
+		hf.write('<div id="testlog" style="display:none;">\n'+sysvals.logmsg+'</div>\n')
 	# add the dmesg log as a hidden div
 	if sysvals.addlogs and sysvals.dmesgfile:
 		hf.write('<div id="dmesglog" style="display:none;">\n')
 		lf = open(sysvals.dmesgfile, 'r')
 		for line in lf:
+			line = line.replace('<', '&lt').replace('>', '&gt')
 			hf.write(line)
 		lf.close()
 		hf.write('</div>\n')
@@ -3822,7 +3809,7 @@ def addScriptCode(hf, testruns):
 	'	var resolution = -1;\n'\
 	'	var dragval = [0, 0];\n'\
 	'	function redrawTimescale(t0, tMax, tS) {\n'\
-	'		var rline = \'<div class="t" style="left:0;border-left:1px solid black;border-right:0;"><cR><-R</cR></div>\';\n'\
+	'		var rline = \'<div class="t" style="left:0;border-left:1px solid black;border-right:0;"><cS>&larr;R</cS></div>\';\n'\
 	'		var tTotal = tMax - t0;\n'\
 	'		var list = document.getElementsByClassName("tblock");\n'\
 	'		for (var i = 0; i < list.length; i++) {\n'\
@@ -3847,7 +3834,7 @@ def addScriptCode(hf, testruns):
 	'					pos = 100 - (((j)*tS*100)/mTotal) - divEdge;\n'\
 	'					val = (j-divTotal+1)*tS;\n'\
 	'					if(j == divTotal - 1)\n'\
-	'						htmlline = \'<div class="t" style="right:\'+pos+\'%"><cS>S-></cS></div>\';\n'\
+	'						htmlline = \'<div class="t" style="right:\'+pos+\'%"><cS>S&rarr;</cS></div>\';\n'\
 	'					else\n'\
 	'						htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
 	'				}\n'\
@@ -4027,12 +4014,7 @@ def addScriptCode(hf, testruns):
 	'		}\n'\
 	'	}\n'\
 	'	function devListWindow(e) {\n'\
-	'		var sx = e.clientX;\n'\
-	'		if(sx > window.innerWidth - 440)\n'\
-	'			sx = window.innerWidth - 440;\n'\
-	'		var cfg="top="+e.screenY+", left="+sx+", width=440, height=720, scrollbars=yes";\n'\
-	'		var win = window.open("", "_blank", cfg);\n'\
-	'		if(window.chrome) win.moveBy(sx, 0);\n'\
+	'		var win = window.open();\n'\
 	'		var html = "<title>"+e.target.innerHTML+"</title>"+\n'\
 	'			"<style type=\\"text/css\\">"+\n'\
 	'			"   ul {list-style-type:circle;padding-left:10px;margin-left:10px;}"+\n'\
@@ -4042,6 +4024,12 @@ def addScriptCode(hf, testruns):
 	'			dt = devtable[1];\n'\
 	'		win.document.write(html+dt);\n'\
 	'	}\n'\
+	'	function errWindow() {\n'\
+	'		var text = this.id;\n'\
+	'		var win = window.open();\n'\
+	'		win.document.write("<pre>"+text+"</pre>");\n'\
+	'		win.document.close();\n'\
+	'	}\n'\
 	'	function logWindow(e) {\n'\
 	'		var name = e.target.id.slice(4);\n'\
 	'		var win = window.open();\n'\
@@ -4089,6 +4077,9 @@ def addScriptCode(hf, testruns):
 	'		var list = document.getElementsByClassName("square");\n'\
 	'		for (var i = 0; i < list.length; i++)\n'\
 	'			list[i].onclick = onClickPhase;\n'\
+	'		var list = document.getElementsByClassName("err");\n'\
+	'		for (var i = 0; i < list.length; i++)\n'\
+	'			list[i].onclick = errWindow;\n'\
 	'		var list = document.getElementsByClassName("logbtn");\n'\
 	'		for (var i = 0; i < list.length; i++)\n'\
 	'			list[i].onclick = logWindow;\n'\
@@ -4111,8 +4102,6 @@ def addScriptCode(hf, testruns):
 #	 Execute system suspend through the sysfs interface, then copy the output
 #	 dmesg and ftrace files to the test output directory.
 def executeSuspend():
-	global sysvals
-
 	pm = ProcessMonitor()
 	tp = sysvals.tpath
 	fwdata = []
@@ -4128,7 +4117,9 @@ def executeSuspend():
 	for count in range(1,sysvals.execcount+1):
 		# x2delay in between test runs
 		if(count > 1 and sysvals.x2delay > 0):
+			sysvals.fsetVal('WAIT %d' % sysvals.x2delay, 'trace_marker')
 			time.sleep(sysvals.x2delay/1000.0)
+			sysvals.fsetVal('WAIT END', 'trace_marker')
 		# start message
 		if sysvals.testcommand != '':
 			print('COMMAND START')
@@ -4146,7 +4137,9 @@ def executeSuspend():
 			sysvals.fsetVal('SUSPEND START', 'trace_marker')
 		# predelay delay
 		if(count == 1 and sysvals.predelay > 0):
+			sysvals.fsetVal('WAIT %d' % sysvals.predelay, 'trace_marker')
 			time.sleep(sysvals.predelay/1000.0)
+			sysvals.fsetVal('WAIT END', 'trace_marker')
 		# initiate suspend or command
 		if sysvals.testcommand != '':
 			call(sysvals.testcommand+' 2>&1', shell=True);
@@ -4162,7 +4155,9 @@ def executeSuspend():
 			sysvals.rtcWakeAlarmOff()
 		# postdelay delay
 		if(count == sysvals.execcount and sysvals.postdelay > 0):
+			sysvals.fsetVal('WAIT %d' % sysvals.postdelay, 'trace_marker')
 			time.sleep(sysvals.postdelay/1000.0)
+			sysvals.fsetVal('WAIT END', 'trace_marker')
 		# return from suspend
 		print('RESUME COMPLETE')
 		if(sysvals.usecallgraph or sysvals.usetraceevents):
@@ -4185,8 +4180,6 @@ def executeSuspend():
 	sysvals.getdmesg()
 
 def writeDatafileHeader(filename, fwdata):
-	global sysvals
-
 	fp = open(filename, 'a')
 	fp.write(sysvals.teststamp+'\n')
 	if(sysvals.suspendmode == 'mem' or sysvals.suspendmode == 'command'):
@@ -4202,8 +4195,6 @@ def writeDatafileHeader(filename, fwdata):
 #	 to always-on since the kernel cant determine if the device can
 #	 properly autosuspend
 def setUSBDevicesAuto():
-	global sysvals
-
 	rootCheck(True)
 	for dirname, dirnames, filenames in os.walk('/sys/devices'):
 		if(re.match('.*/usb[0-9]*.*', dirname) and
@@ -4250,8 +4241,6 @@ def ms2nice(val):
 #	 Detect all the USB hosts and devices currently connected and add
 #	 a list of USB device names to sysvals for better timeline readability
 def detectUSB():
-	global sysvals
-
 	field = {'idVendor':'', 'idProduct':'', 'product':'', 'speed':''}
 	power = {'async':'', 'autosuspend':'', 'autosuspend_delay_ms':'',
 			 'control':'', 'persist':'', 'runtime_enabled':'',
@@ -4306,7 +4295,6 @@ def detectUSB():
 # Description:
 #	 Retrieve a list of properties for all devices in the trace log
 def devProps(data=0):
-	global sysvals
 	props = dict()
 
 	if data:
@@ -4331,7 +4319,7 @@ def devProps(data=0):
 		return
 
 	if(os.path.exists(sysvals.ftracefile) == False):
-		doError('%s does not exist' % sysvals.ftracefile, False)
+		doError('%s does not exist' % sysvals.ftracefile)
 
 	# first get the list of devices we need properties for
 	msghead = 'Additional data added by AnalyzeSuspend'
@@ -4354,7 +4342,7 @@ def devProps(data=0):
 		m = re.match('.*: (?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*', m.group('msg'));
 		if(not m):
 			continue
-		drv, dev, par = m.group('drv'), m.group('d'), m.group('p')
+		dev = m.group('d')
 		if dev not in props:
 			props[dev] = DevProps()
 	tf.close()
@@ -4430,7 +4418,6 @@ def devProps(data=0):
 # Output:
 #	 A string list of the available modes
 def getModes():
-	global sysvals
 	modes = ''
 	if(os.path.exists(sysvals.powerfile)):
 		fp = open(sysvals.powerfile, 'r')
@@ -4444,8 +4431,6 @@ def getModes():
 # Arguments:
 #	 output: True to output the info to stdout, False otherwise
 def getFPDT(output):
-	global sysvals
-
 	rectype = {}
 	rectype[0] = 'Firmware Basic Boot Performance Record'
 	rectype[1] = 'S3 Performance Table Record'
@@ -4456,19 +4441,19 @@ def getFPDT(output):
 	rootCheck(True)
 	if(not os.path.exists(sysvals.fpdtpath)):
 		if(output):
-			doError('file does not exist: %s' % sysvals.fpdtpath, False)
+			doError('file does not exist: %s' % sysvals.fpdtpath)
 		return False
 	if(not os.access(sysvals.fpdtpath, os.R_OK)):
 		if(output):
-			doError('file is not readable: %s' % sysvals.fpdtpath, False)
+			doError('file is not readable: %s' % sysvals.fpdtpath)
 		return False
 	if(not os.path.exists(sysvals.mempath)):
 		if(output):
-			doError('file does not exist: %s' % sysvals.mempath, False)
+			doError('file does not exist: %s' % sysvals.mempath)
 		return False
 	if(not os.access(sysvals.mempath, os.R_OK)):
 		if(output):
-			doError('file is not readable: %s' % sysvals.mempath, False)
+			doError('file is not readable: %s' % sysvals.mempath)
 		return False
 
 	fp = open(sysvals.fpdtpath, 'rb')
@@ -4478,7 +4463,7 @@ def getFPDT(output):
 	if(len(buf) < 36):
 		if(output):
 			doError('Invalid FPDT table data, should '+\
-				'be at least 36 bytes', False)
+				'be at least 36 bytes')
 		return False
 
 	table = struct.unpack('4sIBB6s8sI4sI', buf[0:36])
@@ -4577,7 +4562,6 @@ def getFPDT(output):
 # Output:
 #	 True if the test will work, False if not
 def statusCheck(probecheck=False):
-	global sysvals
 	status = True
 
 	print('Checking this system (%s)...' % platform.node())
@@ -4661,20 +4645,13 @@ def statusCheck(probecheck=False):
 		return status
 
 	# verify kprobes
-	if sysvals.usekprobes and len(sysvals.tracefuncs) > 0:
-		print('    verifying timeline kprobes work:')
-		for name in sorted(sysvals.tracefuncs):
-			res = sysvals.colorText('NO')
-			if sysvals.testKprobe(name, sysvals.tracefuncs[name]):
-				res = 'YES'
-			print('         %s: %s' % (name, res))
-	if sysvals.usedevsrc and sysvals.usekprobes and len(sysvals.dev_tracefuncs) > 0:
-		print('    verifying dev kprobes work:')
-		for name in sorted(sysvals.dev_tracefuncs):
-			res = sysvals.colorText('NO')
-			if sysvals.testKprobe(name, sysvals.dev_tracefuncs[name]):
-				res = 'YES'
-			print('         %s: %s' % (name, res))
+	if sysvals.usekprobes:
+		for name in sysvals.tracefuncs:
+			sysvals.defaultKprobe(name, sysvals.tracefuncs[name])
+		if sysvals.usedevsrc:
+			for name in sysvals.dev_tracefuncs:
+				sysvals.defaultKprobe(name, sysvals.dev_tracefuncs[name])
+		sysvals.addKprobes(True)
 
 	return status
 
@@ -4684,33 +4661,20 @@ def statusCheck(probecheck=False):
 # Arguments:
 #	 msg: the error message to print
 #	 help: True if printHelp should be called after, False otherwise
-def doError(msg, help):
+def doError(msg, help=False):
 	if(help == True):
 		printHelp()
 	print('ERROR: %s\n') % msg
 	sys.exit()
 
-# Function: doWarning
-# Description:
-#	 generic warning function for non-catastrophic anomalies
-# Arguments:
-#	 msg: the warning message to print
-#	 file: If not empty, a filename to request be sent to the owner for debug
-def doWarning(msg, file=''):
-	print('/* %s */') % msg
-	if(file):
-		print('/* For a fix, please send this'+\
-			' %s file to <todd.e.brandt@intel.com> */' % file)
-
 # Function: rootCheck
 # Description:
 #	 quick check to see if we have root access
 def rootCheck(fatal):
-	global sysvals
 	if(os.access(sysvals.powerfile, os.W_OK)):
 		return True
 	if fatal:
-		doError('This command must be run as root', False)
+		doError('This command must be run as root')
 	return False
 
 # Function: getArgInt
@@ -4751,66 +4715,51 @@ def getArgFloat(name, args, min, max, main=True):
 		doError(name+': value should be between %f and %f' % (min, max), True)
 	return val
 
-# Function: rerunTest
-# Description:
-#	 generate an output from an existing set of ftrace/dmesg logs
-def rerunTest():
-	global sysvals
-
-	if(sysvals.ftracefile != ''):
-		doesTraceLogHaveTraceEvents()
-	if(sysvals.dmesgfile == '' and not sysvals.usetraceeventsonly):
-		doError('recreating this html output '+\
-			'requires a dmesg file', False)
-	sysvals.setOutputFile()
-	vprint('Output file: %s' % sysvals.htmlfile)
-	if(os.path.exists(sysvals.htmlfile) and not os.access(sysvals.htmlfile, os.W_OK)):
-		doError('missing permission to write to %s' % sysvals.htmlfile, False)
+def processData():
 	print('PROCESSING DATA')
 	if(sysvals.usetraceeventsonly):
 		testruns = parseTraceLog()
+		if sysvals.dmesgfile:
+			dmesgtext = loadKernelLog(True)
+			for data in testruns:
+				data.extractErrorInfo(dmesgtext)
 	else:
 		testruns = loadKernelLog()
 		for data in testruns:
 			parseKernelLog(data)
-		if(sysvals.ftracefile != ''):
+		if(sysvals.ftracefile and (sysvals.usecallgraph or sysvals.usetraceevents)):
 			appendIncompleteTraceLog(testruns)
 	createHTML(testruns)
 
+# Function: rerunTest
+# Description:
+#	 generate an output from an existing set of ftrace/dmesg logs
+def rerunTest():
+	if sysvals.ftracefile:
+		doesTraceLogHaveTraceEvents()
+	if not sysvals.dmesgfile and not sysvals.usetraceeventsonly:
+		doError('recreating this html output requires a dmesg file')
+	sysvals.setOutputFile()
+	vprint('Output file: %s' % sysvals.htmlfile)
+	if(os.path.exists(sysvals.htmlfile) and not os.access(sysvals.htmlfile, os.W_OK)):
+		doError('missing permission to write to %s' % sysvals.htmlfile)
+	processData()
+
 # Function: runTest
 # Description:
 #	 execute a suspend/resume, gather the logs, and generate the output
 def runTest(subdir, testpath=''):
-	global sysvals
-
 	# prepare for the test
 	sysvals.initFtrace()
 	sysvals.initTestOutput(subdir, testpath)
-
-	vprint('Output files:\n    %s' % sysvals.dmesgfile)
-	if(sysvals.usecallgraph or
-		sysvals.usetraceevents or
-		sysvals.usetraceeventsonly):
-		vprint('    %s' % sysvals.ftracefile)
-	vprint('    %s' % sysvals.htmlfile)
+	vprint('Output files:\n\t%s\n\t%s\n\t%s' % \
+		(sysvals.dmesgfile, sysvals.ftracefile, sysvals.htmlfile))
 
 	# execute the test
 	executeSuspend()
 	sysvals.cleanupFtrace()
+	processData()
 
-	# analyze the data and create the html output
-	print('PROCESSING DATA')
-	if(sysvals.usetraceeventsonly):
-		# data for kernels 3.15 or newer is entirely in ftrace
-		testruns = parseTraceLog()
-	else:
-		# data for kernels older than 3.15 is primarily in dmesg
-		testruns = loadKernelLog()
-		for data in testruns:
-			parseKernelLog(data)
-		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			appendIncompleteTraceLog(testruns)
-	createHTML(testruns)
 	# if running as root, change output dir owner to sudo_user
 	if os.path.isdir(sysvals.testdir) and os.getuid() == 0 and \
 		'SUDO_USER' in os.environ:
@@ -4821,8 +4770,6 @@ def runTest(subdir, testpath=''):
 # Description:
 #	 create a summary of tests in a sub-directory
 def runSummary(subdir, output):
-	global sysvals
-
 	# get a list of ftrace output files
 	files = []
 	for dirname, dirnames, filenames in os.walk(subdir):
@@ -4878,7 +4825,6 @@ def checkArgBool(value):
 # Description:
 #	 Configure the script via the info in a config file
 def configFromFile(file):
-	global sysvals
 	Config = ConfigParser.ConfigParser()
 
 	Config.read(file)
@@ -4939,15 +4885,13 @@ def configFromFile(file):
 				sysvals.setOutputFolder(value)
 
 	if sysvals.suspendmode == 'command' and not sysvals.testcommand:
-		doError('No command supplied for mode "command"', False)
+		doError('No command supplied for mode "command"')
 
 	# compatibility errors
 	if sysvals.usedevsrc and sysvals.usecallgraph:
-		doError('-dev is not compatible with -f', False)
-	if sysvals.usecallgraph and sysvals.execcount > 1:
-		doError('-x2 is not compatible with -f', False)
+		doError('-dev is not compatible with -f')
 	if sysvals.usecallgraph and sysvals.useprocmon:
-		doError('-proc is not compatible with -f', False)
+		doError('-proc is not compatible with -f')
 
 	if overridekprobes:
 		sysvals.tracefuncs = dict()
@@ -4964,7 +4908,7 @@ def configFromFile(file):
 	if kprobesec in sections:
 		for name in Config.options(kprobesec):
 			if name in kprobes:
-				doError('Duplicate timeline function found "%s"' % (name), False)
+				doError('Duplicate timeline function found "%s"' % (name))
 			text = Config.get(kprobesec, name)
 			kprobes[name] = (text, False)
 
@@ -4997,12 +4941,12 @@ def configFromFile(file):
 				args[d[0]] = d[1]
 			i += 1
 		if not function or not format:
-			doError('Invalid kprobe: %s' % name, False)
+			doError('Invalid kprobe: %s' % name)
 		for arg in re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', format):
 			if arg not in args:
-				doError('Kprobe "%s" is missing argument "%s"' % (name, arg), False)
+				doError('Kprobe "%s" is missing argument "%s"' % (name, arg))
 		if (dev and name in sysvals.dev_tracefuncs) or (not dev and name in sysvals.tracefuncs):
-			doError('Duplicate timeline function found "%s"' % (name), False)
+			doError('Duplicate timeline function found "%s"' % (name))
 
 		kp = {
 			'name': name,
@@ -5021,7 +4965,6 @@ def configFromFile(file):
 # Description:
 #	 print out the help text
 def printHelp():
-	global sysvals
 	modes = getModes()
 
 	print('')
@@ -5074,6 +5017,8 @@ def printHelp():
 	print('   -fadd file   Add functions to be graphed in the timeline from a list in a text file')
 	print('   -filter "d1,d2,..." Filter out all but this comma-delimited list of device names')
 	print('   -mincg  ms   Discard all callgraphs shorter than ms milliseconds (e.g. 0.001 for us)')
+	print('   -cgphase P   Only show callgraph data for phase P (e.g. suspend_late)')
+	print('   -cgtest N    Only show callgraph data for test N (e.g. 0 or 1 in an x2 run)')
 	print('   -timeprec N  Number of significant digits in timestamps (0:S, [3:ms], 6:us)')
 	print('  [utilities]')
 	print('   -fpdt        Print out the contents of the ACPI Firmware Performance Data Table')
@@ -5139,6 +5084,17 @@ if __name__ == '__main__':
 			sysvals.mindevlen = getArgFloat('-mindev', args, 0.0, 10000.0)
 		elif(arg == '-mincg'):
 			sysvals.mincglen = getArgFloat('-mincg', args, 0.0, 10000.0)
+		elif(arg == '-cgtest'):
+			sysvals.cgtest = getArgInt('-cgtest', args, 0, 1)
+		elif(arg == '-cgphase'):
+			try:
+				val = args.next()
+			except:
+				doError('No phase name supplied', True)
+			d = Data(0)
+			if val not in d.phases:
+				doError('Invalid phase, valid phaess are %s' % d.phases, True)
+			sysvals.cgphase = val
 		elif(arg == '-callloop-maxgap'):
 			sysvals.callloopmaxgap = getArgFloat('-callloop-maxgap', args, 0.0, 1.0)
 		elif(arg == '-callloop-maxlen'):
@@ -5170,7 +5126,7 @@ if __name__ == '__main__':
 			except:
 				doError('No text file supplied', True)
 			if(os.path.exists(val) == False):
-				doError('%s does not exist' % val, False)
+				doError('%s does not exist' % val)
 			configFromFile(val)
 		elif(arg == '-fadd'):
 			try:
@@ -5178,7 +5134,7 @@ if __name__ == '__main__':
 			except:
 				doError('No text file supplied', True)
 			if(os.path.exists(val) == False):
-				doError('%s does not exist' % val, False)
+				doError('%s does not exist' % val)
 			sysvals.addFtraceFilterFunctions(val)
 		elif(arg == '-dmesg'):
 			try:
@@ -5188,7 +5144,7 @@ if __name__ == '__main__':
 			sysvals.notestrun = True
 			sysvals.dmesgfile = val
 			if(os.path.exists(sysvals.dmesgfile) == False):
-				doError('%s does not exist' % sysvals.dmesgfile, False)
+				doError('%s does not exist' % sysvals.dmesgfile)
 		elif(arg == '-ftrace'):
 			try:
 				val = args.next()
@@ -5197,7 +5153,7 @@ if __name__ == '__main__':
 			sysvals.notestrun = True
 			sysvals.ftracefile = val
 			if(os.path.exists(sysvals.ftracefile) == False):
-				doError('%s does not exist' % sysvals.ftracefile, False)
+				doError('%s does not exist' % sysvals.ftracefile)
 		elif(arg == '-summary'):
 			try:
 				val = args.next()
@@ -5207,7 +5163,7 @@ if __name__ == '__main__':
 			cmdarg = val
 			sysvals.notestrun = True
 			if(os.path.isdir(val) == False):
-				doError('%s is not accesible' % val, False)
+				doError('%s is not accesible' % val)
 		elif(arg == '-filter'):
 			try:
 				val = args.next()
@@ -5218,12 +5174,10 @@ if __name__ == '__main__':
 			doError('Invalid argument: '+arg, True)
 
 	# compatibility errors
-	if(sysvals.usecallgraph and sysvals.execcount > 1):
-		doError('-x2 is not compatible with -f', False)
 	if(sysvals.usecallgraph and sysvals.usedevsrc):
-		doError('-dev is not compatible with -f', False)
+		doError('-dev is not compatible with -f')
 	if(sysvals.usecallgraph and sysvals.useprocmon):
-		doError('-proc is not compatible with -f', False)
+		doError('-proc is not compatible with -f')
 
 	# callgraph size cannot exceed device size
 	if sysvals.mincglen < sysvals.mindevlen:
@@ -5238,8 +5192,7 @@ if __name__ == '__main__':
 		elif(cmd == 'usbtopo'):
 			detectUSB()
 		elif(cmd == 'modes'):
-			modes = getModes()
-			print modes
+			print getModes()
 		elif(cmd == 'flist'):
 			sysvals.getFtraceFilterFunctions(True)
 		elif(cmd == 'flistall'):
-- 
2.1.4

