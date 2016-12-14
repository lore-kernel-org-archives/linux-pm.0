From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 2/3] AnalyzeSuspend v4.4
Date: Wed, 14 Dec 2016 10:37:06 -0800
Message-ID: <3788acc08987153aae4f413dc3912818b9bc8919.1481740176.git.todd.e.brandt@linux.intel.com>
References: <cover.1481740176.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26466 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754327AbcLNShQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 14 Dec 2016 13:37:16 -0500
In-Reply-To: <cover.1481740176.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1481740176.git.todd.e.brandt@linux.intel.com>
References: <cover.1481740176.git.todd.e.brandt@linux.intel.com>
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
 scripts/analyze_suspend.py | 565 ++++++++++++++++++++++++---------------------
 1 file changed, 300 insertions(+), 265 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index baf5a08..0126859 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -67,7 +67,7 @@ from datetime import datetime
 import struct
 import ConfigParser
 from threading import Thread
-import subprocess
+from subprocess import call, Popen, PIPE
 
 # ----------------- CLASSES --------------------
 
@@ -77,11 +77,13 @@ import subprocess
 #	 store system values and test parameters
 class SystemValues:
 	ansi = False
-	version = '4.3'
+	version = '4.4'
 	verbose = False
 	addlogs = False
 	mindevlen = 0.001
 	mincglen = 1.0
+	callloopmaxgap = 0.0001
+	callloopmaxlen = 0.005
 	srgap = 0
 	cgexp = False
 	outdir = ''
@@ -132,9 +134,6 @@ class SystemValues:
 	stampfmt = '# suspend-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
 				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
 				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
-	kprobecolor = 'rgba(204,204,204,0.5)'
-	synccolor = 'rgba(204,204,204,0.5)'
-	debugfuncs = []
 	tracefuncs = {
 		'sys_sync': dict(),
 		'pm_prepare_console': dict(),
@@ -213,6 +212,7 @@ class SystemValues:
 			self.embedded = True
 			self.addlogs = True
 			self.htmlfile = os.environ['LOG_FILE']
+		self.archargs = 'args_'+platform.machine()
 		self.hostname = platform.node()
 		if(self.hostname == ''):
 			self.hostname = 'localhost'
@@ -282,7 +282,7 @@ class SystemValues:
 		for i in value:
 			self.devicefilter.append(i.strip())
 	def rtcWakeAlarmOn(self):
-		os.system('echo 0 > '+self.rtcpath+'/wakealarm')
+		call('echo 0 > '+self.rtcpath+'/wakealarm', shell=True)
 		outD = open(self.rtcpath+'/date', 'r').read().strip()
 		outT = open(self.rtcpath+'/time', 'r').read().strip()
 		mD = re.match('^(?P<y>[0-9]*)-(?P<m>[0-9]*)-(?P<d>[0-9]*)', outD)
@@ -298,12 +298,12 @@ class SystemValues:
 			# if hardware time fails, use the software time
 			nowtime = int(datetime.now().strftime('%s'))
 		alarm = nowtime + self.rtcwaketime
-		os.system('echo %d > %s/wakealarm' % (alarm, self.rtcpath))
+		call('echo %d > %s/wakealarm' % (alarm, self.rtcpath), shell=True)
 	def rtcWakeAlarmOff(self):
-		os.system('echo 0 > %s/wakealarm' % self.rtcpath)
+		call('echo 0 > %s/wakealarm' % self.rtcpath, shell=True)
 	def initdmesg(self):
 		# get the latest time stamp from the dmesg log
-		fp = os.popen('dmesg')
+		fp = Popen('dmesg', stdout=PIPE).stdout
 		ktime = '0'
 		for line in fp:
 			line = line.replace('\r\n', '')
@@ -317,7 +317,7 @@ class SystemValues:
 		self.dmesgstart = float(ktime)
 	def getdmesg(self):
 		# store all new dmesg lines since initdmesg was called
-		fp = os.popen('dmesg')
+		fp = Popen('dmesg', stdout=PIPE).stdout
 		op = open(self.dmesgfile, 'a')
 		for line in fp:
 			line = line.replace('\r\n', '')
@@ -343,25 +343,18 @@ class SystemValues:
 	def getFtraceFilterFunctions(self, current):
 		rootCheck(True)
 		if not current:
-			os.system('cat '+self.tpath+'available_filter_functions')
+			call('cat '+self.tpath+'available_filter_functions', shell=True)
 			return
 		fp = open(self.tpath+'available_filter_functions')
 		master = fp.read().split('\n')
 		fp.close()
-		if len(self.debugfuncs) > 0:
-			for i in self.debugfuncs:
-				if i in master:
-					print i
-				else:
-					print self.colorText(i)
-		else:
-			for i in self.tracefuncs:
-				if 'func' in self.tracefuncs[i]:
-					i = self.tracefuncs[i]['func']
-				if i in master:
-					print i
-				else:
-					print self.colorText(i)
+		for i in self.tracefuncs:
+			if 'func' in self.tracefuncs[i]:
+				i = self.tracefuncs[i]['func']
+			if i in master:
+				print i
+			else:
+				print self.colorText(i)
 	def setFtraceFilterFunctions(self, list):
 		fp = open(self.tpath+'available_filter_functions')
 		master = fp.read().split('\n')
@@ -384,9 +377,8 @@ class SystemValues:
 		for field in ['name', 'format', 'func']:
 			if field not in k:
 				k[field] = name
-		archargs = 'args_'+platform.machine()
-		if archargs in k:
-			k['args'] = k[archargs]
+		if self.archargs in k:
+			k['args'] = k[self.archargs]
 		else:
 			k['args'] = dict()
 			k['format'] = name
@@ -423,8 +415,19 @@ class SystemValues:
 		out = fmt.format(**arglist)
 		out = out.replace(' ', '_').replace('"', '')
 		return out
-	def kprobeText(self, kprobe):
-		name, fmt, func, args = kprobe['name'], kprobe['format'], kprobe['func'], kprobe['args']
+	def kprobeText(self, kname, kprobe):
+		name = fmt = func = kname
+		args = dict()
+		if 'name' in kprobe:
+			name = kprobe['name']
+		if 'format' in kprobe:
+			fmt = kprobe['format']
+		if 'func' in kprobe:
+			func = kprobe['func']
+		if self.archargs in kprobe:
+			args = kprobe[self.archargs]
+		if 'args' in kprobe:
+			args = kprobe['args']
 		if re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', func):
 			doError('Kprobe "%s" has format info in the function name "%s"' % (name, func), False)
 		for arg in re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', fmt):
@@ -440,7 +443,7 @@ class SystemValues:
 		print('INITIALIZING KPROBES...')
 		rejects = []
 		for name in sorted(self.kprobes):
-			if not self.testKprobe(self.kprobes[name]):
+			if not self.testKprobe(name, self.kprobes[name]):
 				rejects.append(name)
 		# remove all failed ones from the list
 		for name in rejects:
@@ -450,9 +453,9 @@ class SystemValues:
 		kprobeevents = ''
 		# set the kprobes all at once
 		for kp in self.kprobes:
-			val = self.kprobeText(self.kprobes[kp])
+			val = self.kprobeText(kp, self.kprobes[kp])
 			vprint('Adding KPROBE: %s\n%s' % (kp, val.strip()))
-			kprobeevents += self.kprobeText(self.kprobes[kp])
+			kprobeevents += self.kprobeText(kp, self.kprobes[kp])
 		self.fsetVal(kprobeevents, 'kprobe_events')
 		# verify that the kprobes were set as ordered
 		check = self.fgetVal('kprobe_events')
@@ -461,11 +464,11 @@ class SystemValues:
 		if linesack < linesout:
 			# if not, try appending the kprobes 1 by 1
 			for kp in self.kprobes:
-				kprobeevents = self.kprobeText(self.kprobes[kp])
+				kprobeevents = self.kprobeText(kp, self.kprobes[kp])
 				self.fsetVal(kprobeevents, 'kprobe_events', 'a')
 		self.fsetVal('1', 'events/kprobes/enable')
-	def testKprobe(self, kprobe):
-		kprobeevents = self.kprobeText(kprobe)
+	def testKprobe(self, kname, kprobe):
+		kprobeevents = self.kprobeText(kname, kprobe)
 		if not kprobeevents:
 			return False
 		try:
@@ -511,18 +514,15 @@ class SystemValues:
 		for name in self.dev_tracefuncs:
 			self.defaultKprobe(name, self.dev_tracefuncs[name])
 	def isCallgraphFunc(self, name):
-		if len(self.debugfuncs) < 1 and self.suspendmode == 'command':
-			return True
-		if name in self.debugfuncs:
+		if len(self.tracefuncs) < 1 and self.suspendmode == 'command':
 			return True
-		funclist = []
 		for i in self.tracefuncs:
 			if 'func' in self.tracefuncs[i]:
-				funclist.append(self.tracefuncs[i]['func'])
+				f = self.tracefuncs[i]['func']
 			else:
-				funclist.append(i)
-		if name in funclist:
-			return True
+				f = i
+			if name == f:
+				return True
 		return False
 	def initFtrace(self, testing=False):
 		tp = self.tpath
@@ -538,18 +538,7 @@ class SystemValues:
 		# go no further if this is just a status check
 		if testing:
 			return
-		if self.usekprobes:
-			# add tracefunc kprobes so long as were not using full callgraph
-			if(not self.usecallgraph or len(self.debugfuncs) > 0):
-				for name in self.tracefuncs:
-					self.defaultKprobe(name, self.tracefuncs[name])
-				if self.usedevsrc:
-					for name in self.dev_tracefuncs:
-						self.defaultKprobe(name, self.dev_tracefuncs[name])
-			else:
-				self.usedevsrc = False
-			self.addKprobes()
-		# initialize the callgraph trace, unless this is an x2 run
+		# initialize the callgraph trace
 		if(self.usecallgraph):
 			# set trace type
 			self.fsetVal('function_graph', 'current_tracer')
@@ -565,20 +554,23 @@ class SystemValues:
 			self.fsetVal('context-info', 'trace_options')
 			self.fsetVal('graph-time', 'trace_options')
 			self.fsetVal('0', 'max_graph_depth')
-			if len(self.debugfuncs) > 0:
-				self.setFtraceFilterFunctions(self.debugfuncs)
-			elif self.suspendmode == 'command':
-				self.fsetVal('', 'set_graph_function')
-			else:
-				cf = ['dpm_run_callback']
-				if(self.usetraceeventsonly):
-					cf += ['dpm_prepare', 'dpm_complete']
-				for fn in self.tracefuncs:
-					if 'func' in self.tracefuncs[fn]:
-						cf.append(self.tracefuncs[fn]['func'])
-					else:
-						cf.append(fn)
-				self.setFtraceFilterFunctions(cf)
+			cf = ['dpm_run_callback']
+			if(self.usetraceeventsonly):
+				cf += ['dpm_prepare', 'dpm_complete']
+			for fn in self.tracefuncs:
+				if 'func' in self.tracefuncs[fn]:
+					cf.append(self.tracefuncs[fn]['func'])
+				else:
+					cf.append(fn)
+			self.setFtraceFilterFunctions(cf)
+		# initialize the kprobe trace
+		elif self.usekprobes:
+			for name in self.tracefuncs:
+				self.defaultKprobe(name, self.tracefuncs[name])
+			if self.usedevsrc:
+				for name in self.dev_tracefuncs:
+					self.defaultKprobe(name, self.dev_tracefuncs[name])
+			self.addKprobes()
 		if(self.usetraceevents):
 			# turn trace events on
 			events = iter(self.traceevents)
@@ -791,25 +783,22 @@ class Data:
 				break
 		return tgtdev
 	def addDeviceFunctionCall(self, displayname, kprobename, proc, pid, start, end, cdata, rdata):
-		tgtphase = self.sourcePhase(start, end)
 		# try to place the call in a device
 		tgtdev = self.sourceDevice(self.phases, start, end, pid, 'device')
-		# calls with device pids that occur outside dev bounds are dropped
+		# calls with device pids that occur outside device bounds are dropped
+		# TODO: include these somehow
 		if not tgtdev and pid in self.devpids:
 			return False
 		# try to place the call in a thread
 		if not tgtdev:
-			tgtdev = self.sourceDevice([tgtphase], start, end, pid, 'thread')
+			tgtdev = self.sourceDevice(self.phases, start, end, pid, 'thread')
 		# create new thread blocks, expand as new calls are found
 		if not tgtdev:
 			if proc == '<...>':
 				threadname = 'kthread-%d' % (pid)
 			else:
 				threadname = '%s-%d' % (proc, pid)
-			if(start < self.start):
-				self.setStart(start)
-			if(end > self.end):
-				self.setEnd(end)
+			tgtphase = self.sourcePhase(start, end)
 			self.newAction(tgtphase, threadname, pid, '', start, end, '', ' kth', '')
 			return self.addDeviceFunctionCall(displayname, kprobename, proc, pid, start, end, cdata, rdata)
 		# this should not happen
@@ -836,7 +825,8 @@ class Data:
 				r = 'ret=%s ' % r
 			if ubiquitous and c in self.dev_ubiquitous:
 				return False
-		e = DevFunction(displayname, a, c, r, start, end, ubiquitous, proc, pid)
+		color = sysvals.kprobeColor(kprobename)
+		e = DevFunction(displayname, a, c, r, start, end, ubiquitous, proc, pid, color)
 		tgtdev['src'].append(e)
 		return True
 	def overflowDevices(self):
@@ -866,6 +856,30 @@ class Data:
 					continue
 				dev['src'] += tdev['src']
 				del list[devname]
+	def usurpTouchingThread(self, name, dev):
+		# the caller test has priority of this thread, give it to him
+		for phase in self.phases:
+			list = self.dmesg[phase]['list']
+			if name in list:
+				tdev = list[name]
+				if tdev['start'] - dev['end'] < 0.1:
+					dev['end'] = tdev['end']
+					if 'src' not in dev:
+						dev['src'] = []
+					if 'src' in tdev:
+						dev['src'] += tdev['src']
+					del list[name]
+				break
+	def stitchTouchingThreads(self, testlist):
+		# merge any threads between tests that touch
+		for phase in self.phases:
+			list = self.dmesg[phase]['list']
+			for devname in list:
+				dev = list[devname]
+				if 'htmlclass' not in dev or 'kth' not in dev['htmlclass']:
+					continue
+				for data in testlist:
+					data.usurpTouchingThread(devname, dev)
 	def optimizeDevSrc(self):
 		# merge any src call loops to reduce timeline size
 		for phase in self.phases:
@@ -962,29 +976,18 @@ class Data:
 						break
 				vprint('%s (%s): callback didnt return' % (devname, phase))
 	def deviceFilter(self, devicefilter):
-		# get a list of all devices related to the filter devices
-		filter = []
-		for phase in self.phases:
-			list = self.dmesg[phase]['list']
-			for name in devicefilter:
-				dev = name
-				# loop up to the top level parent of this dev
-				while(dev in list):
-					if(dev not in filter):
-						filter.append(dev)
-					dev = list[dev]['par']
-				# now get the full tree of related devices
-				children = self.deviceDescendants(name, phase)
-				for dev in children:
-					if(dev not in filter):
-						filter.append(dev)
-		# remove all devices not in the filter list
+		# check each device name & driver name
+		# remove it if it does not include one of the filter strings
 		for phase in self.phases:
 			list = self.dmesg[phase]['list']
 			rmlist = []
 			for name in list:
-				pid = list[name]['pid']
-				if(name not in filter):
+				keep = False
+				for filter in devicefilter:
+					if filter in name or \
+						('drv' in list[name] and filter in list[name]['drv']):
+						keep = True
+				if not keep:
 					rmlist.append(name)
 			for name in rmlist:
 				del list[name]
@@ -992,10 +995,6 @@ class Data:
 		# if any calls never returned, clip them at system resume end
 		for phase in self.phases:
 			self.fixupInitcalls(phase, self.end)
-	def isInsideTimeline(self, start, end):
-		if(self.start <= start and self.end > start):
-			return True
-		return False
 	def phaseOverlap(self, phases):
 		rmgroups = []
 		newgroup = []
@@ -1012,12 +1011,6 @@ class Data:
 			self.devicegroups.remove(group)
 		self.devicegroups.append(newgroup)
 	def newActionGlobal(self, name, start, end, pid=-1, color=''):
-		# if event starts before timeline start, expand timeline
-		if(start < self.start):
-			self.setStart(start)
-		# if event ends after timeline end, expand the timeline
-		if(end > self.end):
-			self.setEnd(end)
 		# which phase is this device callback or action in
 		targetphase = 'none'
 		htmlclass = ''
@@ -1036,13 +1029,12 @@ class Data:
 					continue
 				targetphase = phase
 				overlap = o
-		# if no target phase was found, check for pre/post resume
+		# if no target phase was found, pin it to the edge
 		if targetphase == 'none':
-			o = max(0, min(end, self.tKernSus) - max(start, self.start))
-			if o > 0:
+			p0start = self.dmesg[self.phases[0]]['start']
+			if start <= p0start:
 				targetphase = self.phases[0]
-			o = max(0, min(end, self.end) - max(start, self.tKernRes))
-			if o > 0:
+			else:
 				targetphase = self.phases[-1]
 		if pid == -2:
 			htmlclass = ' bg'
@@ -1195,6 +1187,15 @@ class Data:
 				if width != '0.000000' and length >= mindevlen:
 					devlist.append(dev)
 			self.tdevlist[phase] = devlist
+	def addHorizontalDivider(self, devname, devend):
+		phase = 'suspend_prepare'
+		self.newAction(phase, devname, -2, '', \
+			self.start, devend, '', ' sec', '')
+		if phase not in self.tdevlist:
+			self.tdevlist[phase] = []
+		self.tdevlist[phase].append(devname)
+		d = DevItem(0, phase, self.dmesg[phase]['list'][devname])
+		return d
 	def addProcessUsageEvent(self, name, times):
 		# get the start and end times for this process
 		maxC = 0
@@ -1273,7 +1274,7 @@ class Data:
 class DevFunction:
 	row = 0
 	count = 1
-	def __init__(self, name, args, caller, ret, start, end, u, proc, pid):
+	def __init__(self, name, args, caller, ret, start, end, u, proc, pid, color):
 		self.name = name
 		self.args = args
 		self.caller = caller
@@ -1284,17 +1285,18 @@ class DevFunction:
 		self.ubiquitous = u
 		self.proc = proc
 		self.pid = pid
+		self.color = color
 	def title(self):
 		cnt = ''
 		if self.count > 1:
 			cnt = '(x%d)' % self.count
 		l = '%0.3fms' % (self.length * 1000)
 		if self.ubiquitous:
-			title = '%s(%s) <- %s, %s%s(%s)' % \
-				(self.name, self.args, self.caller, self.ret, cnt, l)
+			title = '%s(%s)%s <- %s, %s(%s)' % \
+				(self.name, self.args, cnt, self.caller, self.ret, l)
 		else:
 			title = '%s(%s) %s%s(%s)' % (self.name, self.args, self.ret, cnt, l)
-		return title
+		return title.replace('"', '')
 	def text(self):
 		if self.count > 1:
 			text = '%s(x%d)' % (self.name, self.count)
@@ -1302,12 +1304,15 @@ class DevFunction:
 			text = self.name
 		return text
 	def repeat(self, tgt):
+		# is the tgt call just a repeat of this call (e.g. are we in a loop)
 		dt = self.time - tgt.end
+		# only combine calls if -all- attributes are identical
 		if tgt.caller == self.caller and \
 			tgt.name == self.name and tgt.args == self.args and \
 			tgt.proc == self.proc and tgt.pid == self.pid and \
-			tgt.ret == self.ret and dt >= 0 and dt <= 0.000100 and \
-			self.length < 0.001:
+			tgt.ret == self.ret and dt >= 0 and \
+			dt <= sysvals.callloopmaxgap and \
+			self.length < sysvals.callloopmaxlen:
 			return True
 		return False
 
@@ -1698,6 +1703,10 @@ class DevItem:
 		self.test = test
 		self.phase = phase
 		self.dev = dev
+	def isa(self, cls):
+		if 'htmlclass' in self.dev and cls in self.dev['htmlclass']:
+			return True
+		return False
 
 # Class: Timeline
 # Description:
@@ -1767,11 +1776,10 @@ class Timeline:
 	#	 devlist: the list of devices/actions in a group of contiguous phases
 	# Output:
 	#	 The total number of rows needed to display this phase of the timeline
-	def getPhaseRows(self, devlist):
+	def getPhaseRows(self, devlist, row=0):
 		# clear all rows and set them to undefined
 		remaining = len(devlist)
 		rowdata = dict()
-		row = 0
 		sortdict = dict()
 		myphases = []
 		# initialize all device rows to -1 and calculate devrows
@@ -1825,8 +1833,14 @@ class Timeline:
 				if p not in self.rowlines[t] or p not in self.rowheight[t]:
 					self.rowlines[t][p] = dict()
 					self.rowheight[t][p] = dict()
+				rh = self.rowH
+				# section headers should use a different row height
+				if len(rowdata[row]) == 1 and \
+					'htmlclass' in rowdata[row][0].dev and \
+					'sec' in rowdata[row][0].dev['htmlclass']:
+					rh = 15
 				self.rowlines[t][p][row] = rowheight
-				self.rowheight[t][p][row] = rowheight * self.rowH
+				self.rowheight[t][p][row] = rowheight * rh
 			row += 1
 		if(row > self.rows):
 			self.rows = int(row)
@@ -1952,7 +1966,7 @@ class ProcessMonitor:
 	running = False
 	def procstat(self):
 		c = ['cat /proc/[1-9]*/stat 2>/dev/null']
-		process = subprocess.Popen(c, shell=True, stdout=subprocess.PIPE)
+		process = Popen(c, shell=True, stdout=PIPE)
 		running = dict()
 		for line in process.stdout:
 			data = line.split()
@@ -2027,7 +2041,8 @@ def parseStamp(line, data):
 	sysvals.suspendmode = data.stamp['mode']
 	if sysvals.suspendmode == 'command' and sysvals.ftracefile != '':
 		modes = ['on', 'freeze', 'standby', 'mem']
-		out = os.popen('grep suspend_enter '+sysvals.ftracefile).read()
+		out = Popen(['grep', 'suspend_enter', sysvals.ftracefile],
+			stderr=PIPE, stdout=PIPE).stdout.read()
 		m = re.match('.* suspend_enter\[(?P<mode>.*)\]', out)
 		if m and m.group('mode') in ['1', '2', '3']:
 			sysvals.suspendmode = modes[int(m.group('mode'))]
@@ -2065,14 +2080,15 @@ def doesTraceLogHaveTraceEvents():
 
 	# check for kprobes
 	sysvals.usekprobes = False
-	out = os.system('grep -q "_cal: (" '+sysvals.ftracefile)
+	out = call('grep -q "_cal: (" '+sysvals.ftracefile, shell=True)
 	if(out == 0):
 		sysvals.usekprobes = True
 	# check for callgraph data on trace event blocks
-	out = os.system('grep -q "_cpu_down()" '+sysvals.ftracefile)
+	out = call('grep -q "_cpu_down()" '+sysvals.ftracefile, shell=True)
 	if(out == 0):
 		sysvals.usekprobes = True
-	out = os.popen('head -1 '+sysvals.ftracefile).read().replace('\n', '')
+	out = Popen(['head', '-1', sysvals.ftracefile],
+		stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
 	m = re.match(sysvals.stampfmt, out)
 	if m and m.group('mode') == 'command':
 		sysvals.usetraceeventsonly = True
@@ -2082,14 +2098,14 @@ def doesTraceLogHaveTraceEvents():
 	sysvals.usetraceeventsonly = True
 	sysvals.usetraceevents = False
 	for e in sysvals.traceevents:
-		out = os.system('grep -q "'+e+': " '+sysvals.ftracefile)
+		out = call('grep -q "'+e+': " '+sysvals.ftracefile, shell=True)
 		if(out != 0):
 			sysvals.usetraceeventsonly = False
 		if(e == 'suspend_resume' and out == 0):
 			sysvals.usetraceevents = True
 	# determine is this log is properly formatted
 	for e in ['SUSPEND START', 'RESUME COMPLETE']:
-		out = os.system('grep -q "'+e+'" '+sysvals.ftracefile)
+		out = call('grep -q "'+e+'" '+sysvals.ftracefile, shell=True)
 		if(out != 0):
 			sysvals.usetracemarkers = False
 
@@ -2617,14 +2633,14 @@ def parseTraceLog():
 	if sysvals.suspendmode == 'command':
 		for test in testruns:
 			for p in test.data.phases:
-				if p == 'resume_complete':
+				if p == 'suspend_prepare':
 					test.data.dmesg[p]['start'] = test.data.start
 					test.data.dmesg[p]['end'] = test.data.end
 				else:
-					test.data.dmesg[p]['start'] = test.data.start
-					test.data.dmesg[p]['end'] = test.data.start
-			test.data.tSuspended = test.data.start
-			test.data.tResumed = test.data.start
+					test.data.dmesg[p]['start'] = test.data.end
+					test.data.dmesg[p]['end'] = test.data.end
+			test.data.tSuspended = test.data.end
+			test.data.tResumed = test.data.end
 			test.data.tLow = 0
 			test.data.fwValid = False
 
@@ -2632,16 +2648,22 @@ def parseTraceLog():
 	if sysvals.usedevsrc or sysvals.useprocmon:
 		sysvals.mixedphaseheight = False
 
-	for test in testruns:
+	for i in range(len(testruns)):
+		test = testruns[i]
+		data = test.data
+		# find the total time range for this test (begin, end)
+		tlb, tle = data.start, data.end
+		if i < len(testruns) - 1:
+			tle = testruns[i+1].data.start
 		# add the process usage data to the timeline
 		if sysvals.useprocmon:
-			test.data.createProcessUsageEvents()
+			data.createProcessUsageEvents()
 		# add the traceevent data to the device hierarchy
 		if(sysvals.usetraceevents):
 			# add actual trace funcs
 			for name in test.ttemp:
 				for event in test.ttemp[name]:
-					test.data.newActionGlobal(name, event['begin'], event['end'], event['pid'])
+					data.newActionGlobal(name, event['begin'], event['end'], event['pid'])
 			# add the kprobe based virtual tracefuncs as actual devices
 			for key in tp.ktemp:
 				name, pid = key
@@ -2649,25 +2671,21 @@ def parseTraceLog():
 					continue
 				for e in tp.ktemp[key]:
 					kb, ke = e['begin'], e['end']
-					if kb == ke or not test.data.isInsideTimeline(kb, ke):
+					if kb == ke or tlb > kb or tle <= kb:
 						continue
-					test.data.newActionGlobal(e['name'], kb, ke, pid)
+					color = sysvals.kprobeColor(name)
+					data.newActionGlobal(e['name'], kb, ke, pid, color)
 			# add config base kprobes and dev kprobes
-			for key in tp.ktemp:
-				name, pid = key
-				if name in sysvals.tracefuncs:
-					continue
-				for e in tp.ktemp[key]:
-					kb, ke = e['begin'], e['end']
-					if kb == ke or not test.data.isInsideTimeline(kb, ke):
+			if sysvals.usedevsrc:
+				for key in tp.ktemp:
+					name, pid = key
+					if name in sysvals.tracefuncs or name not in sysvals.dev_tracefuncs:
 						continue
-					color = sysvals.kprobeColor(e['name'])
-					if name not in sysvals.dev_tracefuncs:
-						# custom user kprobe from the config
-						test.data.newActionGlobal(e['name'], kb, ke, -2, color)
-					elif sysvals.usedevsrc:
-						# dev kprobe
-						test.data.addDeviceFunctionCall(e['name'], name, e['proc'], pid, kb,
+					for e in tp.ktemp[key]:
+						kb, ke = e['begin'], e['end']
+						if kb == ke or tlb > kb or tle <= kb:
+							continue
+						data.addDeviceFunctionCall(e['name'], name, e['proc'], pid, kb,
 							ke, e['cdata'], e['rdata'])
 		if sysvals.usecallgraph:
 			# add the callgraph data to the device hierarchy
@@ -2683,7 +2701,7 @@ def parseTraceLog():
 							id+', ignoring this callback')
 						continue
 					# match cg data to devices
-					if sysvals.suspendmode == 'command' or not cg.deviceMatch(pid, test.data):
+					if sysvals.suspendmode == 'command' or not cg.deviceMatch(pid, data):
 						sortkey = '%f%f%d' % (cg.start, cg.end, pid)
 						sortlist[sortkey] = cg
 			# create blocks for orphan cg data
@@ -2692,7 +2710,7 @@ def parseTraceLog():
 				name = cg.list[0].name
 				if sysvals.isCallgraphFunc(name):
 					vprint('Callgraph found for task %d: %.3fms, %s' % (cg.pid, (cg.end - cg.start)*1000, name))
-					cg.newActionFromFunction(test.data)
+					cg.newActionFromFunction(data)
 
 	if sysvals.suspendmode == 'command':
 		if(sysvals.verbose):
@@ -2724,14 +2742,14 @@ def parseTraceLog():
 		if sysvals.verbose:
 			data.printDetails()
 
-	# merge any overlapping devices between test runs
+	# x2: merge any overlapping devices between test runs
 	if sysvals.usedevsrc and len(testdata) > 1:
 		tc = len(testdata)
 		for i in range(tc - 1):
 			devlist = testdata[i].overflowDevices()
 			for j in range(i + 1, tc):
 				testdata[j].mergeOverlapDevices(devlist)
-
+		testdata[0].stitchTouchingThreads(testdata[1:])
 	return testdata
 
 # Function: loadRawKernelLog
@@ -3300,29 +3318,29 @@ def createHTML(testruns):
 	html_timeline = '<div id="dmesgzoombox" class="zoombox">\n<div id="{0}" class="timeline" style="height:{1}px">\n'
 	html_tblock = '<div id="block{0}" class="tblock" style="left:{1}%;width:{2}%;"><div class="tback" style="height:{3}px"></div>\n'
 	html_device = '<div id="{0}" title="{1}" class="thread{7}" style="left:{2}%;top:{3}px;height:{4}px;width:{5}%;{8}">{6}</div>\n'
-	html_traceevent = '<div title="{0}" class="traceevent{6}" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;">{5}</div>\n'
+	html_traceevent = '<div title="{0}" class="traceevent{6}" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;{7}">{5}</div>\n'
 	html_cpuexec = '<div class="jiffie" style="left:{0}%;top:{1}px;height:{2}px;width:{3}%;background:{4};"></div>\n'
 	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}px;height:{3}px;background-color:{4}">{5}</div>\n'
 	html_phaselet = '<div id="{0}" class="phaselet" style="left:{1}%;width:{2}%;background:{3}"></div>\n'
 	html_legend = '<div id="p{3}" class="square" style="left:{0}%;background-color:{1}">&nbsp;{2}</div>\n'
 	html_timetotal = '<table class="time1">\n<tr>'\
-		'<td class="green">{2} Suspend Time: <b>{0} ms</b></td>'\
-		'<td class="yellow">{2} Resume Time: <b>{1} ms</b></td>'\
+		'<td class="green" title="{3}">{2} Suspend Time: <b>{0} ms</b></td>'\
+		'<td class="yellow" title="{4}">{2} Resume Time: <b>{1} ms</b></td>'\
 		'</tr>\n</table>\n'
 	html_timetotal2 = '<table class="time1">\n<tr>'\
-		'<td class="green">{3} Suspend Time: <b>{0} ms</b></td>'\
-		'<td class="gray">'+sysvals.suspendmode+' time: <b>{1} ms</b></td>'\
-		'<td class="yellow">{3} Resume Time: <b>{2} ms</b></td>'\
+		'<td class="green" title="{4}">{3} Suspend Time: <b>{0} ms</b></td>'\
+		'<td class="gray" title="time spent in low-power mode with clock running">'+sysvals.suspendmode+' time: <b>{1} ms</b></td>'\
+		'<td class="yellow" title="{5}">{3} Resume Time: <b>{2} ms</b></td>'\
 		'</tr>\n</table>\n'
 	html_timetotal3 = '<table class="time1">\n<tr>'\
 		'<td class="green">Execution Time: <b>{0} ms</b></td>'\
 		'<td class="yellow">Command: <b>{1}</b></td>'\
 		'</tr>\n</table>\n'
 	html_timegroups = '<table class="time2">\n<tr>'\
-		'<td class="green">{4}Kernel Suspend: {0} ms</td>'\
+		'<td class="green" title="time from kernel enter_state({5}) to firmware mode [kernel time only]">{4}Kernel Suspend: {0} ms</td>'\
 		'<td class="purple">{4}Firmware Suspend: {1} ms</td>'\
 		'<td class="purple">{4}Firmware Resume: {2} ms</td>'\
-		'<td class="yellow">{4}Kernel Resume: {3} ms</td>'\
+		'<td class="yellow" title="time from firmware mode to return from kernel enter_state({5}) [kernel time only]">{4}Kernel Resume: {3} ms</td>'\
 		'</tr>\n</table>\n'
 
 	# html format variables
@@ -3338,6 +3356,10 @@ def createHTML(testruns):
 	# Generate the header for this timeline
 	for data in testruns:
 		tTotal = data.end - data.start
+		sktime = (data.dmesg['suspend_machine']['end'] - \
+			data.tKernSus) * 1000
+		rktime = (data.dmesg['resume_complete']['end'] - \
+			data.dmesg['resume_machine']['start']) * 1000
 		if(tTotal == 0):
 			print('ERROR: No timeline data')
 			sys.exit()
@@ -3354,42 +3376,40 @@ def createHTML(testruns):
 			thtml = html_timetotal3.format(run_time, testdesc)
 			devtl.html['header'] += thtml
 		elif data.fwValid:
-			suspend_time = '%.0f'%((data.tSuspended-data.start)*1000 + \
-				(data.fwSuspend/1000000.0))
-			resume_time = '%.0f'%((data.end-data.tSuspended)*1000 + \
-				(data.fwResume/1000000.0))
+			suspend_time = '%.0f'%(sktime + (data.fwSuspend/1000000.0))
+			resume_time = '%.0f'%(rktime + (data.fwResume/1000000.0))
 			testdesc1 = 'Total'
 			testdesc2 = ''
+			stitle = 'time from kernel enter_state(%s) to low-power mode [kernel & firmware time]' % sysvals.suspendmode
+			rtitle = 'time from low-power mode to return from kernel enter_state(%s) [firmware & kernel time]' % sysvals.suspendmode
 			if(len(testruns) > 1):
 				testdesc1 = testdesc2 = ordinal(data.testnumber+1)
 				testdesc2 += ' '
 			if(data.tLow == 0):
 				thtml = html_timetotal.format(suspend_time, \
-					resume_time, testdesc1)
+					resume_time, testdesc1, stitle, rtitle)
 			else:
 				thtml = html_timetotal2.format(suspend_time, low_time, \
-					resume_time, testdesc1)
+					resume_time, testdesc1, stitle, rtitle)
 			devtl.html['header'] += thtml
-			sktime = '%.3f'%((data.dmesg['suspend_machine']['end'] - \
-				data.tKernSus)*1000)
 			sftime = '%.3f'%(data.fwSuspend / 1000000.0)
 			rftime = '%.3f'%(data.fwResume / 1000000.0)
-			rktime = '%.3f'%((data.dmesg['resume_complete']['end'] - \
-				data.dmesg['resume_machine']['start'])*1000)
-			devtl.html['header'] += html_timegroups.format(sktime, \
-				sftime, rftime, rktime, testdesc2)
+			devtl.html['header'] += html_timegroups.format('%.3f'%sktime, \
+				sftime, rftime, '%.3f'%rktime, testdesc2, sysvals.suspendmode)
 		else:
-			suspend_time = '%.0f'%((data.tSuspended-data.start)*1000)
-			resume_time = '%.0f'%((data.end-data.tSuspended)*1000)
+			suspend_time = '%.3f' % sktime
+			resume_time = '%.3f' % rktime
 			testdesc = 'Kernel'
+			stitle = 'time from kernel enter_state(%s) to firmware mode [kernel time only]' % sysvals.suspendmode
+			rtitle = 'time from firmware mode to return from kernel enter_state(%s) [kernel time only]' % sysvals.suspendmode
 			if(len(testruns) > 1):
 				testdesc = ordinal(data.testnumber+1)+' '+testdesc
 			if(data.tLow == 0):
 				thtml = html_timetotal.format(suspend_time, \
-					resume_time, testdesc)
+					resume_time, testdesc, stitle, rtitle)
 			else:
 				thtml = html_timetotal2.format(suspend_time, low_time, \
-					resume_time, testdesc)
+					resume_time, testdesc, stitle, rtitle)
 			devtl.html['header'] += thtml
 
 	# time scale for potentially multiple datasets
@@ -3400,6 +3420,9 @@ def createHTML(testruns):
 
 	# determine the maximum number of rows we need to draw
 	fulllist = []
+	threadlist = []
+	pscnt = 0
+	devcnt = 0
 	for data in testruns:
 		data.selectTimelineDevices('%f', tTotal, sysvals.mindevlen)
 		for group in data.devicegroups:
@@ -3408,11 +3431,31 @@ def createHTML(testruns):
 				for devname in data.tdevlist[phase]:
 					d = DevItem(data.testnumber, phase, data.dmesg[phase]['list'][devname])
 					devlist.append(d)
-					fulllist.append(d)
+					if d.isa('kth'):
+						threadlist.append(d)
+					else:
+						if d.isa('ps'):
+							pscnt += 1
+						else:
+							devcnt += 1
+						fulllist.append(d)
 			if sysvals.mixedphaseheight:
 				devtl.getPhaseRows(devlist)
 	if not sysvals.mixedphaseheight:
+		if len(threadlist) > 0 and len(fulllist) > 0:
+			if pscnt > 0 and devcnt > 0:
+				msg = 'user processes & device pm callbacks'
+			elif pscnt > 0:
+				msg = 'user processes'
+			else:
+				msg = 'device pm callbacks'
+			d = testruns[0].addHorizontalDivider(msg, testruns[-1].end)
+			fulllist.insert(0, d)
 		devtl.getPhaseRows(fulllist)
+		if len(threadlist) > 0:
+			d = testruns[0].addHorizontalDivider('asynchronous kernel threads', testruns[-1].end)
+			threadlist.insert(0, d)
+			devtl.getPhaseRows(threadlist, devtl.rows)
 	devtl.calcTotalRows()
 
 	# create bounding box, add buttons
@@ -3494,7 +3537,7 @@ def createHTML(testruns):
 					length = ' (%0.3f ms) ' % ((dev['end']-dev['start'])*1000)
 					title = name+drv+xtrainfo+length
 					if sysvals.suspendmode == 'command':
-						title += 'cmdexec'
+						title += sysvals.testcommand
 					elif xtraclass == ' ps':
 						if 'suspend' in b:
 							title += 'pre_suspend_process'
@@ -3526,12 +3569,12 @@ def createHTML(testruns):
 						top = '%.3f' % (rowtop + devtl.scaleH + (e.row*devtl.rowH))
 						left = '%f' % (((e.time-m0)*100)/mTotal)
 						width = '%f' % (e.length*100/mTotal)
-						sleepclass = ''
-						if e.ubiquitous:
-							sleepclass = ' sleep'
+						xtrastyle = ''
+						if e.color:
+							xtrastyle = 'background:%s;' % e.color
 						devtl.html['timeline'] += \
 							html_traceevent.format(e.title(), \
-								left, top, height, width, e.text(), sleepclass)
+								left, top, height, width, e.text(), '', xtrastyle)
 			# draw the time scale, try to make the number of labels readable
 			devtl.html['timeline'] += devtl.createTimeScale(m0, mMax, tTotal, dir)
 			devtl.html['timeline'] += '</div>\n'
@@ -3601,17 +3644,15 @@ def createHTML(testruns):
 		.zoombox {position:relative;width:100%;overflow-x:scroll;-webkit-user-select:none;-moz-user-select:none;user-select:none;}\n\
 		.timeline {position:relative;font-size:14px;cursor:pointer;width:100%; overflow:hidden;background:linear-gradient(#cccccc, white);}\n\
 		.thread {position:absolute;height:0%;overflow:hidden;z-index:7;line-height:30px;font-size:14px;border:1px solid;text-align:center;white-space:nowrap;}\n\
-		.thread.sync {background-color:'+sysvals.synccolor+';}\n\
-		.thread.bg {background-color:'+sysvals.kprobecolor+';}\n\
 		.thread.ps {border-radius:3px;background:linear-gradient(to top, #ccc, #eee);}\n\
 		.thread:hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
+		.thread.sec,.thread.sec:hover {background-color:black;border:0;color:white;line-height:15px;font-size:10px;}\n\
 		.hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
 		.hover.sync {background-color:white;}\n\
 		.hover.bg,.hover.kth,.hover.sync,.hover.ps {background-color:white;}\n\
 		.jiffie {position:absolute;pointer-events: none;z-index:8;}\n\
-		.traceevent {position:absolute;font-size:10px;z-index:7;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,rgb(204,204,204),rgb(150,150,150));}\n\
-		.traceevent.sleep {font-style:normal;}\n\
-		.traceevent:hover {background:white;}\n\
+		.traceevent {position:absolute;font-size:10px;z-index:7;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,#CCC,#969696);}\n\
+		.traceevent:hover {color:white;font-weight:bold;border:1px solid white;}\n\
 		.phase {position:absolute;overflow:hidden;border:0px;text-align:center;}\n\
 		.phaselet {position:absolute;overflow:hidden;border:0px;text-align:center;height:100px;font-size:24px;}\n\
 		.t {position:absolute;pointer-events:none;top:0%;height:100%;border-right:1px solid black;z-index:6;}\n\
@@ -4108,7 +4149,7 @@ def executeSuspend():
 			time.sleep(sysvals.predelay/1000.0)
 		# initiate suspend or command
 		if sysvals.testcommand != '':
-			os.system(sysvals.testcommand+' 2>&1');
+			call(sysvals.testcommand+' 2>&1', shell=True);
 		else:
 			pf = open(sysvals.powerfile, 'w')
 			pf.write(sysvals.suspendmode)
@@ -4135,7 +4176,7 @@ def executeSuspend():
 		sysvals.fsetVal('0', 'tracing_on')
 		print('CAPTURING TRACE')
 		writeDatafileHeader(sysvals.ftracefile, fwdata)
-		os.system('cat '+tp+'trace >> '+sysvals.ftracefile)
+		call('cat '+tp+'trace >> '+sysvals.ftracefile, shell=True)
 		sysvals.fsetVal('', 'trace')
 		devProps()
 	# grab a copy of the dmesg output
@@ -4167,12 +4208,12 @@ def setUSBDevicesAuto():
 	for dirname, dirnames, filenames in os.walk('/sys/devices'):
 		if(re.match('.*/usb[0-9]*.*', dirname) and
 			'idVendor' in filenames and 'idProduct' in filenames):
-			os.system('echo auto > %s/power/control' % dirname)
+			call('echo auto > %s/power/control' % dirname, shell=True)
 			name = dirname.split('/')[-1]
-			desc = os.popen('cat %s/product 2>/dev/null' % \
-				dirname).read().replace('\n', '')
-			ctrl = os.popen('cat %s/power/control 2>/dev/null' % \
-				dirname).read().replace('\n', '')
+			desc = Popen(['cat', '%s/product' % dirname],
+				stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
+			ctrl = Popen(['cat', '%s/power/control' % dirname],
+				stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
 			print('control is %s for %6s: %s' % (ctrl, name, desc))
 
 # Function: yesno
@@ -4236,12 +4277,12 @@ def detectUSB():
 		if(re.match('.*/usb[0-9]*.*', dirname) and
 			'idVendor' in filenames and 'idProduct' in filenames):
 			for i in field:
-				field[i] = os.popen('cat %s/%s 2>/dev/null' % \
-					(dirname, i)).read().replace('\n', '')
+				field[i] = Popen(['cat', '%s/%s' % (dirname, i)],
+					stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
 			name = dirname.split('/')[-1]
 			for i in power:
-				power[i] = os.popen('cat %s/power/%s 2>/dev/null' % \
-					(dirname, i)).read().replace('\n', '')
+				power[i] = Popen(['cat', '%s/power/%s' % (dirname, i)],
+					stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
 			if(re.match('usb[0-9]*', name)):
 				first = '%-8s' % name
 			else:
@@ -4619,35 +4660,19 @@ def statusCheck(probecheck=False):
 	if not probecheck:
 		return status
 
-	if (sysvals.usecallgraph and len(sysvals.debugfuncs) > 0) or len(sysvals.kprobes) > 0:
-		sysvals.initFtrace(True)
-
-	# verify callgraph debugfuncs
-	if sysvals.usecallgraph and len(sysvals.debugfuncs) > 0:
-		print('    verifying these ftrace callgraph functions work:')
-		sysvals.setFtraceFilterFunctions(sysvals.debugfuncs)
-		fp = open(sysvals.tpath+'set_graph_function', 'r')
-		flist = fp.read().split('\n')
-		fp.close()
-		for func in sysvals.debugfuncs:
+	# verify kprobes
+	if sysvals.usekprobes and len(sysvals.tracefuncs) > 0:
+		print('    verifying timeline kprobes work:')
+		for name in sorted(sysvals.tracefuncs):
 			res = sysvals.colorText('NO')
-			if func in flist:
+			if sysvals.testKprobe(name, sysvals.tracefuncs[name]):
 				res = 'YES'
-			else:
-				for i in flist:
-					if ' [' in i and func == i.split(' ')[0]:
-						res = 'YES'
-						break
-			print('         %s: %s' % (func, res))
-
-	# verify kprobes
-	if len(sysvals.kprobes) > 0:
-		print('    verifying these kprobes work:')
-		for name in sorted(sysvals.kprobes):
-			if name in sysvals.tracefuncs:
-				continue
+			print('         %s: %s' % (name, res))
+	if sysvals.usedevsrc and sysvals.usekprobes and len(sysvals.dev_tracefuncs) > 0:
+		print('    verifying dev kprobes work:')
+		for name in sorted(sysvals.dev_tracefuncs):
 			res = sysvals.colorText('NO')
-			if sysvals.testKprobe(sysvals.kprobes[name]):
+			if sysvals.testKprobe(name, sysvals.dev_tracefuncs[name]):
 				res = 'YES'
 			print('         %s: %s' % (name, res))
 
@@ -4786,6 +4811,11 @@ def runTest(subdir, testpath=''):
 		if(sysvals.usecallgraph or sysvals.usetraceevents):
 			appendIncompleteTraceLog(testruns)
 	createHTML(testruns)
+	# if running as root, change output dir owner to sudo_user
+	if os.path.isdir(sysvals.testdir) and os.getuid() == 0 and \
+		'SUDO_USER' in os.environ:
+		cmd = 'chown -R {0}:{0} {1} > /dev/null 2>&1'
+		call(cmd.format(os.environ['SUDO_USER'], sysvals.testdir), shell=True)
 
 # Function: runSummary
 # Description:
@@ -4851,9 +4881,10 @@ def configFromFile(file):
 	global sysvals
 	Config = ConfigParser.ConfigParser()
 
-	ignorekprobes = False
 	Config.read(file)
 	sections = Config.sections()
+	overridekprobes = False
+	overridedevkprobes = False
 	if 'Settings' in sections:
 		for opt in Config.options('Settings'):
 			value = Config.get('Settings', opt).lower()
@@ -4865,19 +4896,15 @@ def configFromFile(file):
 				sysvals.usedevsrc = checkArgBool(value)
 			elif(opt.lower() == 'proc'):
 				sysvals.useprocmon = checkArgBool(value)
-			elif(opt.lower() == 'ignorekprobes'):
-				ignorekprobes = checkArgBool(value)
 			elif(opt.lower() == 'x2'):
 				if checkArgBool(value):
 					sysvals.execcount = 2
 			elif(opt.lower() == 'callgraph'):
 				sysvals.usecallgraph = checkArgBool(value)
-			elif(opt.lower() == 'callgraphfunc'):
-				sysvals.debugfuncs = []
-				if value:
-					value = value.split(',')
-				for i in value:
-					sysvals.debugfuncs.append(i.strip())
+			elif(opt.lower() == 'override-timeline-functions'):
+				overridekprobes = checkArgBool(value)
+			elif(opt.lower() == 'override-dev-timeline-functions'):
+				overridedevkprobes = checkArgBool(value)
 			elif(opt.lower() == 'devicefilter'):
 				sysvals.setDeviceFilter(value)
 			elif(opt.lower() == 'expandcg'):
@@ -4902,20 +4929,12 @@ def configFromFile(file):
 				sysvals.setPrecision(getArgInt('-timeprec', value, 0, 6, False))
 			elif(opt.lower() == 'mindev'):
 				sysvals.mindevlen = getArgFloat('-mindev', value, 0.0, 10000.0, False)
+			elif(opt.lower() == 'callloop-maxgap'):
+				sysvals.callloopmaxgap = getArgFloat('-callloop-maxgap', value, 0.0, 1.0, False)
+			elif(opt.lower() == 'callloop-maxlen'):
+				sysvals.callloopmaxgap = getArgFloat('-callloop-maxlen', value, 0.0, 1.0, False)
 			elif(opt.lower() == 'mincg'):
 				sysvals.mincglen = getArgFloat('-mincg', value, 0.0, 10000.0, False)
-			elif(opt.lower() == 'kprobecolor'):
-				try:
-					val = int(value, 16)
-					sysvals.kprobecolor = '#'+value
-				except:
-					sysvals.kprobecolor = value
-			elif(opt.lower() == 'synccolor'):
-				try:
-					val = int(value, 16)
-					sysvals.synccolor = '#'+value
-				except:
-					sysvals.synccolor = value
 			elif(opt.lower() == 'output-dir'):
 				sysvals.setOutputFolder(value)
 
@@ -4930,24 +4949,32 @@ def configFromFile(file):
 	if sysvals.usecallgraph and sysvals.useprocmon:
 		doError('-proc is not compatible with -f', False)
 
-	if ignorekprobes:
-		return
+	if overridekprobes:
+		sysvals.tracefuncs = dict()
+	if overridedevkprobes:
+		sysvals.dev_tracefuncs = dict()
 
 	kprobes = dict()
-	archkprobe = 'Kprobe_'+platform.machine()
-	if archkprobe in sections:
-		for name in Config.options(archkprobe):
-			kprobes[name] = Config.get(archkprobe, name)
-	if 'Kprobe' in sections:
-		for name in Config.options('Kprobe'):
-			kprobes[name] = Config.get('Kprobe', name)
+	kprobesec = 'dev_timeline_functions_'+platform.machine()
+	if kprobesec in sections:
+		for name in Config.options(kprobesec):
+			text = Config.get(kprobesec, name)
+			kprobes[name] = (text, True)
+	kprobesec = 'timeline_functions_'+platform.machine()
+	if kprobesec in sections:
+		for name in Config.options(kprobesec):
+			if name in kprobes:
+				doError('Duplicate timeline function found "%s"' % (name), False)
+			text = Config.get(kprobesec, name)
+			kprobes[name] = (text, False)
 
 	for name in kprobes:
 		function = name
 		format = name
 		color = ''
 		args = dict()
-		data = kprobes[name].split()
+		text, dev = kprobes[name]
+		data = text.split()
 		i = 0
 		for val in data:
 			# bracketted strings are special formatting, read them separately
@@ -4974,17 +5001,21 @@ def configFromFile(file):
 		for arg in re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', format):
 			if arg not in args:
 				doError('Kprobe "%s" is missing argument "%s"' % (name, arg), False)
-		if name in sysvals.kprobes:
-			doError('Duplicate kprobe found "%s"' % (name), False)
-		vprint('Adding KPROBE: %s %s %s %s' % (name, function, format, args))
-		sysvals.kprobes[name] = {
+		if (dev and name in sysvals.dev_tracefuncs) or (not dev and name in sysvals.tracefuncs):
+			doError('Duplicate timeline function found "%s"' % (name), False)
+
+		kp = {
 			'name': name,
 			'func': function,
 			'format': format,
-			'args': args
+			sysvals.archargs: args
 		}
 		if color:
-			sysvals.kprobes[name]['color'] = color
+			kp['color'] = color
+		if dev:
+			sysvals.dev_tracefuncs[name] = kp
+		else:
+			sysvals.tracefuncs[name] = kp
 
 # Function: printHelp
 # Description:
@@ -5108,6 +5139,10 @@ if __name__ == '__main__':
 			sysvals.mindevlen = getArgFloat('-mindev', args, 0.0, 10000.0)
 		elif(arg == '-mincg'):
 			sysvals.mincglen = getArgFloat('-mincg', args, 0.0, 10000.0)
+		elif(arg == '-callloop-maxgap'):
+			sysvals.callloopmaxgap = getArgFloat('-callloop-maxgap', args, 0.0, 1.0)
+		elif(arg == '-callloop-maxlen'):
+			sysvals.callloopmaxlen = getArgFloat('-callloop-maxlen', args, 0.0, 1.0)
 		elif(arg == '-cmd'):
 			try:
 				val = args.next()
-- 
2.1.4

