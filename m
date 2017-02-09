From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v3 1/4] AnalyzeSuspend v4.3
Date: Thu,  9 Feb 2017 13:27:40 -0800
Message-ID: <4f1c6dd9d2fe05c66e3213d35cbc648576c81b4f.1486675333.git.todd.e.brandt@linux.intel.com>
References: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17732 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754101AbdBIVcR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Feb 2017 16:32:17 -0500
In-Reply-To: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
References: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: todd.e.brandt@intel.com, rjw@rjwysocki.net, rafael.j.wysocki@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

- config file support added
- dev mode for monitoring kernel source calls and async kernel threads
- custom command support for executing a user cmd instead of suspend
- proc mode support for monitoring user processes with cpu exec data
- kprobe support for custom function tracing
- advanced callgraph support for function debug
- many bug fixes and formatting upgrades

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 scripts/analyze_suspend.py | 972 ++++++++++++++++++++++++++++++---------------
 1 file changed, 660 insertions(+), 312 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index a0ba48f..baf5a08 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -66,6 +66,8 @@ import platform
 from datetime import datetime
 import struct
 import ConfigParser
+from threading import Thread
+import subprocess
 
 # ----------------- CLASSES --------------------
 
@@ -75,7 +77,7 @@ import ConfigParser
 #	 store system values and test parameters
 class SystemValues:
 	ansi = False
-	version = '4.2'
+	version = '4.3'
 	verbose = False
 	addlogs = False
 	mindevlen = 0.001
@@ -117,13 +119,16 @@ class SystemValues:
 	usetracemarkers = True
 	usekprobes = True
 	usedevsrc = False
+	useprocmon = False
 	notestrun = False
+	mixedphaseheight = True
 	devprops = dict()
-	postresumetime = 0
+	predelay = 0
+	postdelay = 0
+	procexecfmt = 'ps - (?P<ps>.*)$'
 	devpropfmt = '# Device Properties: .*'
 	tracertypefmt = '# tracer: (?P<t>.*)'
 	firmwarefmt = '# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
-	postresumefmt = '# post resume time (?P<t>[0-9]*)$'
 	stampfmt = '# suspend-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
 				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
 				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
@@ -152,20 +157,22 @@ class SystemValues:
 		'CPU_OFF': {
 			'func':'_cpu_down',
 			'args_x86_64': {'cpu':'%di:s32'},
-			'format': 'CPU_OFF[{cpu}]',
-			'mask': 'CPU_.*_DOWN'
+			'format': 'CPU_OFF[{cpu}]'
 		},
 		'CPU_ON': {
 			'func':'_cpu_up',
 			'args_x86_64': {'cpu':'%di:s32'},
-			'format': 'CPU_ON[{cpu}]',
-			'mask': 'CPU_.*_UP'
+			'format': 'CPU_ON[{cpu}]'
 		},
 	}
 	dev_tracefuncs = {
 		# general wait/delay/sleep
 		'msleep': { 'args_x86_64': {'time':'%di:s32'} },
+		'schedule_timeout_uninterruptible': { 'args_x86_64': {'timeout':'%di:s32'} },
+		'schedule_timeout': { 'args_x86_64': {'timeout':'%di:s32'} },
 		'udelay': { 'func':'__const_udelay', 'args_x86_64': {'loops':'%di:s32'} },
+		'usleep_range': { 'args_x86_64': {'min':'%di:s32', 'max':'%si:s32'} },
+		'mutex_lock_slowpath': { 'func':'__mutex_lock_slowpath' },
 		'acpi_os_stall': dict(),
 		# ACPI
 		'acpi_resume_power_resources': dict(),
@@ -175,19 +182,27 @@ class SystemValues:
 		# ATA
 		'ata_eh_recover': { 'args_x86_64': {'port':'+36(%di):s32'} },
 		# i915
-		'i915_gem_restore_gtt_mappings': dict(),
+		'i915_gem_resume': dict(),
+		'i915_restore_state': dict(),
 		'intel_opregion_setup': dict(),
+		'g4x_pre_enable_dp': dict(),
+		'vlv_pre_enable_dp': dict(),
+		'chv_pre_enable_dp': dict(),
+		'g4x_enable_dp': dict(),
+		'vlv_enable_dp': dict(),
+		'intel_hpd_init': dict(),
+		'intel_opregion_register': dict(),
 		'intel_dp_detect': dict(),
 		'intel_hdmi_detect': dict(),
 		'intel_opregion_init': dict(),
+		'intel_fbdev_set_suspend': dict(),
 	}
 	kprobes_postresume = [
 		{
 			'name': 'ataportrst',
 			'func': 'ata_eh_recover',
 			'args': {'port':'+36(%di):s32'},
-			'format': 'ata{port}_port_reset',
-			'mask': 'ata.*_port_reset'
+			'format': 'ata{port}_port_reset'
 		}
 	]
 	kprobes = dict()
@@ -214,6 +229,13 @@ class SystemValues:
 		if num < 0 or num > 6:
 			return
 		self.timeformat = '%.{0}f'.format(num)
+	def setOutputFolder(self, value):
+		args = dict()
+		n = datetime.now()
+		args['date'] = n.strftime('%y%m%d')
+		args['time'] = n.strftime('%H%M%S')
+		args['hostname'] = self.hostname
+		self.outdir = value.format(**args)
 	def setOutputFile(self):
 		if((self.htmlfile == '') and (self.dmesgfile != '')):
 			m = re.match('(?P<name>.*)_dmesg\.txt$', self.dmesgfile)
@@ -253,8 +275,12 @@ class SystemValues:
 			self.testdir+'/'+self.prefix+'_'+self.suspendmode+'.html'
 		if not os.path.isdir(self.testdir):
 			os.mkdir(self.testdir)
-	def setDeviceFilter(self, devnames):
-		self.devicefilter = string.split(devnames)
+	def setDeviceFilter(self, value):
+		self.devicefilter = []
+		if value:
+			value = value.split(',')
+		for i in value:
+			self.devicefilter.append(i.strip())
 	def rtcWakeAlarmOn(self):
 		os.system('echo 0 > '+self.rtcpath+'/wakealarm')
 		outD = open(self.rtcpath+'/date', 'r').read().strip()
@@ -351,17 +377,11 @@ class SystemValues:
 		fp = open(self.tpath+'set_graph_function', 'w')
 		fp.write(flist)
 		fp.close()
-	def kprobeMatch(self, name, target):
-		if name not in self.kprobes:
-			return False
-		if re.match(self.kprobes[name]['mask'], target):
-			return True
-		return False
 	def basicKprobe(self, name):
-		self.kprobes[name] = {'name': name,'func': name,'args': dict(),'format': name,'mask': name}
+		self.kprobes[name] = {'name': name,'func': name,'args': dict(),'format': name}
 	def defaultKprobe(self, name, kdata):
 		k = kdata
-		for field in ['name', 'format', 'mask', 'func']:
+		for field in ['name', 'format', 'func']:
 			if field not in k:
 				k[field] = name
 		archargs = 'args_'+platform.machine()
@@ -625,8 +645,8 @@ class DevProps:
 		if self.xtraclass:
 			return ' '+self.xtraclass
 		if self.async:
-			return ' async'
-		return ' sync'
+			return ' async_device'
+		return ' sync_device'
 
 # Class: DeviceNode
 # Description:
@@ -671,19 +691,31 @@ class Data:
 	end = 0.0   # test end
 	tSuspended = 0.0 # low-level suspend start
 	tResumed = 0.0   # low-level resume start
+	tKernSus = 0.0   # kernel level suspend start
+	tKernRes = 0.0   # kernel level resume end
 	tLow = 0.0       # time spent in low-level suspend (standby/freeze)
 	fwValid = False  # is firmware data available
 	fwSuspend = 0    # time spent in firmware suspend
 	fwResume = 0     # time spent in firmware resume
 	dmesgtext = []   # dmesg text file in memory
+	pstl = 0         # process timeline
 	testnumber = 0
 	idstr = ''
 	html_device_id = 0
 	stamp = 0
 	outfile = ''
-	dev_ubiquitous = ['msleep', 'udelay']
+	devpids = []
+	dev_ubiquitous = [
+		'msleep',
+		'schedule_timeout_uninterruptible',
+		'schedule_timeout',
+		'udelay',
+		'usleep_range',
+		'mutex_lock_slowpath'
+	]
 	def __init__(self, num):
 		idchar = 'abcdefghijklmnopqrstuvwxyz'
+		self.pstl = dict()
 		self.testnumber = num
 		self.idstr = idchar[num]
 		self.dmesgtext = []
@@ -714,16 +746,10 @@ class Data:
 		self.devicegroups = []
 		for phase in self.phases:
 			self.devicegroups.append([phase])
-	def getStart(self):
-		return self.dmesg[self.phases[0]]['start']
 	def setStart(self, time):
 		self.start = time
-		self.dmesg[self.phases[0]]['start'] = time
-	def getEnd(self):
-		return self.dmesg[self.phases[-1]]['end']
 	def setEnd(self, time):
 		self.end = time
-		self.dmesg[self.phases[-1]]['end'] = time
 	def isTraceEventOutsideDeviceCalls(self, pid, time):
 		for phase in self.phases:
 			list = self.dmesg[phase]['list']
@@ -733,39 +759,70 @@ class Data:
 					time < d['end']):
 					return False
 		return True
-	def targetDevice(self, phaselist, start, end, pid=-1):
+	def sourcePhase(self, start, end):
+		for phase in self.phases:
+			pstart = self.dmesg[phase]['start']
+			pend = self.dmesg[phase]['end']
+			if start <= pend:
+				return phase
+		return 'resume_complete'
+	def sourceDevice(self, phaselist, start, end, pid, type):
 		tgtdev = ''
 		for phase in phaselist:
 			list = self.dmesg[phase]['list']
 			for devname in list:
 				dev = list[devname]
-				if(pid >= 0 and dev['pid'] != pid):
+				# pid must match
+				if dev['pid'] != pid:
 					continue
 				devS = dev['start']
 				devE = dev['end']
-				if(start < devS or start >= devE or end <= devS or end > devE):
-					continue
+				if type == 'device':
+					# device target event is entirely inside the source boundary
+					if(start < devS or start >= devE or end <= devS or end > devE):
+						continue
+				elif type == 'thread':
+					# thread target event will expand the source boundary
+					if start < devS:
+						dev['start'] = start
+					if end > devE:
+						dev['end'] = end
 				tgtdev = dev
 				break
 		return tgtdev
 	def addDeviceFunctionCall(self, displayname, kprobename, proc, pid, start, end, cdata, rdata):
-		machstart = self.dmesg['suspend_machine']['start']
-		machend = self.dmesg['resume_machine']['end']
-		tgtdev = self.targetDevice(self.phases, start, end, pid)
-		if not tgtdev and start >= machstart and end < machend:
-			# device calls in machine phases should be serial
-			tgtdev = self.targetDevice(['suspend_machine', 'resume_machine'], start, end)
+		tgtphase = self.sourcePhase(start, end)
+		# try to place the call in a device
+		tgtdev = self.sourceDevice(self.phases, start, end, pid, 'device')
+		# calls with device pids that occur outside dev bounds are dropped
+		if not tgtdev and pid in self.devpids:
+			return False
+		# try to place the call in a thread
+		if not tgtdev:
+			tgtdev = self.sourceDevice([tgtphase], start, end, pid, 'thread')
+		# create new thread blocks, expand as new calls are found
 		if not tgtdev:
-			if 'scsi_eh' in proc:
-				self.newActionGlobal(proc, start, end, pid)
-				self.addDeviceFunctionCall(displayname, kprobename, proc, pid, start, end, cdata, rdata)
+			if proc == '<...>':
+				threadname = 'kthread-%d' % (pid)
 			else:
-				vprint('IGNORE: %s[%s](%d) [%f - %f] | %s | %s | %s' % (displayname, kprobename,
-					pid, start, end, cdata, rdata, proc))
+				threadname = '%s-%d' % (proc, pid)
+			if(start < self.start):
+				self.setStart(start)
+			if(end > self.end):
+				self.setEnd(end)
+			self.newAction(tgtphase, threadname, pid, '', start, end, '', ' kth', '')
+			return self.addDeviceFunctionCall(displayname, kprobename, proc, pid, start, end, cdata, rdata)
+		# this should not happen
+		if not tgtdev:
+			vprint('[%f - %f] %s-%d %s %s %s' % \
+				(start, end, proc, pid, kprobename, cdata, rdata))
 			return False
-		# detail block fits within tgtdev
+		# place the call data inside the src element of the tgtdev
 		if('src' not in tgtdev):
 			tgtdev['src'] = []
+		ubiquitous = False
+		if kprobename in self.dev_ubiquitous:
+			ubiquitous = True
 		title = cdata+' '+rdata
 		mstr = '\(.*\) *(?P<args>.*) *\((?P<caller>.*)\+.* arg1=(?P<ret>.*)'
 		m = re.match(mstr, title)
@@ -777,14 +834,56 @@ class Data:
 				r = ''
 			else:
 				r = 'ret=%s ' % r
-			l = '%0.3fms' % ((end - start) * 1000)
-			if kprobename in self.dev_ubiquitous:
-				title = '%s(%s) <- %s, %s(%s)' % (displayname, a, c, r, l)
-			else:
-				title = '%s(%s) %s(%s)' % (displayname, a, r, l)
-		e = TraceEvent(title, kprobename, start, end - start)
+			if ubiquitous and c in self.dev_ubiquitous:
+				return False
+		e = DevFunction(displayname, a, c, r, start, end, ubiquitous, proc, pid)
 		tgtdev['src'].append(e)
 		return True
+	def overflowDevices(self):
+		# get a list of devices that extend beyond the end of this test run
+		devlist = []
+		for phase in self.phases:
+			list = self.dmesg[phase]['list']
+			for devname in list:
+				dev = list[devname]
+				if dev['end'] > self.end:
+					devlist.append(dev)
+		return devlist
+	def mergeOverlapDevices(self, devlist):
+		# merge any devices that overlap devlist
+		for dev in devlist:
+			devname = dev['name']
+			for phase in self.phases:
+				list = self.dmesg[phase]['list']
+				if devname not in list:
+					continue
+				tdev = list[devname]
+				o = min(dev['end'], tdev['end']) - max(dev['start'], tdev['start'])
+				if o <= 0:
+					continue
+				dev['end'] = tdev['end']
+				if 'src' not in dev or 'src' not in tdev:
+					continue
+				dev['src'] += tdev['src']
+				del list[devname]
+	def optimizeDevSrc(self):
+		# merge any src call loops to reduce timeline size
+		for phase in self.phases:
+			list = self.dmesg[phase]['list']
+			for dev in list:
+				if 'src' not in list[dev]:
+					continue
+				src = list[dev]['src']
+				p = 0
+				for e in sorted(src, key=lambda event: event.time):
+					if not p or not e.repeat(p):
+						p = e
+						continue
+					# e is another iteration of p, move it into p
+					p.end = e.end
+					p.length = p.end - p.time
+					p.count += 1
+					src.remove(e)
 	def trimTimeVal(self, t, t0, dT, left):
 		if left:
 			if(t > t0):
@@ -832,36 +931,6 @@ class Data:
 			else:
 				self.trimTime(self.tSuspended, \
 					self.tResumed-self.tSuspended, False)
-	def newPhaseWithSingleAction(self, phasename, devname, start, end, color):
-		for phase in self.phases:
-			self.dmesg[phase]['order'] += 1
-		self.html_device_id += 1
-		devid = '%s%d' % (self.idstr, self.html_device_id)
-		list = dict()
-		list[devname] = \
-			{'start': start, 'end': end, 'pid': 0, 'par': '',
-			'length': (end-start), 'row': 0, 'id': devid, 'drv': '' };
-		self.dmesg[phasename] = \
-			{'list': list, 'start': start, 'end': end,
-			'row': 0, 'color': color, 'order': 0}
-		self.phases = self.sortedPhases()
-	def newPhase(self, phasename, start, end, color, order):
-		if(order < 0):
-			order = len(self.phases)
-		for phase in self.phases[order:]:
-			self.dmesg[phase]['order'] += 1
-		if(order > 0):
-			p = self.phases[order-1]
-			self.dmesg[p]['end'] = start
-		if(order < len(self.phases)):
-			p = self.phases[order]
-			self.dmesg[p]['start'] = end
-		list = dict()
-		self.dmesg[phasename] = \
-			{'list': list, 'start': start, 'end': end,
-			'row': 0, 'color': color, 'order': order}
-		self.phases = self.sortedPhases()
-		self.devicegroups.append([phasename])
 	def setPhase(self, phase, ktime, isbegin):
 		if(isbegin):
 			self.dmesg[phase]['start'] = ktime
@@ -893,33 +962,36 @@ class Data:
 						break
 				vprint('%s (%s): callback didnt return' % (devname, phase))
 	def deviceFilter(self, devicefilter):
-		# remove all by the relatives of the filter devnames
+		# get a list of all devices related to the filter devices
 		filter = []
 		for phase in self.phases:
 			list = self.dmesg[phase]['list']
 			for name in devicefilter:
 				dev = name
+				# loop up to the top level parent of this dev
 				while(dev in list):
 					if(dev not in filter):
 						filter.append(dev)
 					dev = list[dev]['par']
+				# now get the full tree of related devices
 				children = self.deviceDescendants(name, phase)
 				for dev in children:
 					if(dev not in filter):
 						filter.append(dev)
+		# remove all devices not in the filter list
 		for phase in self.phases:
 			list = self.dmesg[phase]['list']
 			rmlist = []
 			for name in list:
 				pid = list[name]['pid']
-				if(name not in filter and pid >= 0):
+				if(name not in filter):
 					rmlist.append(name)
 			for name in rmlist:
 				del list[name]
 	def fixupInitcallsThatDidntReturn(self):
 		# if any calls never returned, clip them at system resume end
 		for phase in self.phases:
-			self.fixupInitcalls(phase, self.getEnd())
+			self.fixupInitcalls(phase, self.end)
 	def isInsideTimeline(self, start, end):
 		if(self.start <= start and self.end > start):
 			return True
@@ -946,24 +1018,36 @@ class Data:
 		# if event ends after timeline end, expand the timeline
 		if(end > self.end):
 			self.setEnd(end)
-		# which phase is this device callback or action "in"
-		targetphase = "none"
+		# which phase is this device callback or action in
+		targetphase = 'none'
 		htmlclass = ''
 		overlap = 0.0
 		phases = []
 		for phase in self.phases:
 			pstart = self.dmesg[phase]['start']
 			pend = self.dmesg[phase]['end']
+			# see if the action overlaps this phase
 			o = max(0, min(end, pend) - max(start, pstart))
 			if o > 0:
 				phases.append(phase)
+			# set the target phase to the one that overlaps most
 			if o > overlap:
 				if overlap > 0 and phase == 'post_resume':
 					continue
 				targetphase = phase
 				overlap = o
+		# if no target phase was found, check for pre/post resume
+		if targetphase == 'none':
+			o = max(0, min(end, self.tKernSus) - max(start, self.start))
+			if o > 0:
+				targetphase = self.phases[0]
+			o = max(0, min(end, self.end) - max(start, self.tKernRes))
+			if o > 0:
+				targetphase = self.phases[-1]
 		if pid == -2:
 			htmlclass = ' bg'
+		elif pid == -3:
+			htmlclass = ' ps'
 		if len(phases) > 1:
 			htmlclass = ' bg'
 			self.phaseOverlap(phases)
@@ -985,8 +1069,8 @@ class Data:
 			while(name in list):
 				name = '%s[%d]' % (origname, i)
 				i += 1
-		list[name] = {'start': start, 'end': end, 'pid': pid, 'par': parent,
-					  'length': length, 'row': 0, 'id': devid, 'drv': drv }
+		list[name] = {'name': name, 'start': start, 'end': end, 'pid': pid,
+			'par': parent, 'length': length, 'row': 0, 'id': devid, 'drv': drv }
 		if htmlclass:
 			list[name]['htmlclass'] = htmlclass
 		if color:
@@ -1025,11 +1109,14 @@ class Data:
 		devlist = self.deviceChildren(devname, phase)
 		return self.deviceIDs(devlist, phase)
 	def printDetails(self):
+		vprint('Timeline Details:')
 		vprint('          test start: %f' % self.start)
+		vprint('kernel suspend start: %f' % self.tKernSus)
 		for phase in self.phases:
 			dc = len(self.dmesg[phase]['list'])
 			vprint('    %16s: %f - %f (%d devices)' % (phase, \
 				self.dmesg[phase]['start'], self.dmesg[phase]['end'], dc))
+		vprint('   kernel resume end: %f' % self.tKernRes)
 		vprint('            test end: %f' % self.end)
 	def deviceChildrenAllPhases(self, devname):
 		devlist = []
@@ -1108,21 +1195,121 @@ class Data:
 				if width != '0.000000' and length >= mindevlen:
 					devlist.append(dev)
 			self.tdevlist[phase] = devlist
-
-# Class: TraceEvent
+	def addProcessUsageEvent(self, name, times):
+		# get the start and end times for this process
+		maxC = 0
+		tlast = 0
+		start = -1
+		end = -1
+		for t in sorted(times):
+			if tlast == 0:
+				tlast = t
+				continue
+			if name in self.pstl[t]:
+				if start == -1 or tlast < start:
+					start = tlast
+				if end == -1 or t > end:
+					end = t
+			tlast = t
+		if start == -1 or end == -1:
+			return 0
+		# add a new action for this process and get the object
+		out = self.newActionGlobal(name, start, end, -3)
+		if not out:
+			return 0
+		phase, devname = out
+		dev = self.dmesg[phase]['list'][devname]
+		# get the cpu exec data
+		tlast = 0
+		clast = 0
+		cpuexec = dict()
+		for t in sorted(times):
+			if tlast == 0 or t <= start or t > end:
+				tlast = t
+				continue
+			list = self.pstl[t]
+			c = 0
+			if name in list:
+				c = list[name]
+			if c > maxC:
+				maxC = c
+			if c != clast:
+				key = (tlast, t)
+				cpuexec[key] = c
+				tlast = t
+				clast = c
+		dev['cpuexec'] = cpuexec
+		return maxC
+	def createProcessUsageEvents(self):
+		# get an array of process names
+		proclist = []
+		for t in self.pstl:
+			pslist = self.pstl[t]
+			for ps in pslist:
+				if ps not in proclist:
+					proclist.append(ps)
+		# get a list of data points for suspend and resume
+		tsus = []
+		tres = []
+		for t in sorted(self.pstl):
+			if t < self.tSuspended:
+				tsus.append(t)
+			else:
+				tres.append(t)
+		# process the events for suspend and resume
+		if len(proclist) > 0:
+			vprint('Process Execution:')
+		for ps in proclist:
+			c = self.addProcessUsageEvent(ps, tsus)
+			if c > 0:
+				vprint('%25s (sus): %d' % (ps, c))
+			c = self.addProcessUsageEvent(ps, tres)
+			if c > 0:
+				vprint('%25s (res): %d' % (ps, c))
+
+# Class: DevFunction
 # Description:
-#	 A container for trace event data found in the ftrace file
-class TraceEvent:
-	text = ''
-	time = 0.0
-	length = 0.0
-	title = ''
+#	 A container for kprobe function data we want in the dev timeline
+class DevFunction:
 	row = 0
-	def __init__(self, a, n, t, l):
-		self.title = a
-		self.text = n
-		self.time = t
-		self.length = l
+	count = 1
+	def __init__(self, name, args, caller, ret, start, end, u, proc, pid):
+		self.name = name
+		self.args = args
+		self.caller = caller
+		self.ret = ret
+		self.time = start
+		self.length = end - start
+		self.end = end
+		self.ubiquitous = u
+		self.proc = proc
+		self.pid = pid
+	def title(self):
+		cnt = ''
+		if self.count > 1:
+			cnt = '(x%d)' % self.count
+		l = '%0.3fms' % (self.length * 1000)
+		if self.ubiquitous:
+			title = '%s(%s) <- %s, %s%s(%s)' % \
+				(self.name, self.args, self.caller, self.ret, cnt, l)
+		else:
+			title = '%s(%s) %s%s(%s)' % (self.name, self.args, self.ret, cnt, l)
+		return title
+	def text(self):
+		if self.count > 1:
+			text = '%s(x%d)' % (self.name, self.count)
+		else:
+			text = self.name
+		return text
+	def repeat(self, tgt):
+		dt = self.time - tgt.end
+		if tgt.caller == self.caller and \
+			tgt.name == self.name and tgt.args == self.args and \
+			tgt.proc == self.proc and tgt.pid == self.pid and \
+			tgt.ret == self.ret and dt >= 0 and dt <= 0.000100 and \
+			self.length < 0.001:
+			return True
+		return False
 
 # Class: FTraceLine
 # Description:
@@ -1506,6 +1693,12 @@ class FTraceCallGraph:
 					l.depth, l.name, l.length*1000000))
 		print(' ')
 
+class DevItem:
+	def __init__(self, test, phase, dev):
+		self.test = test
+		self.phase = phase
+		self.dev = dev
+
 # Class: Timeline
 # Description:
 #	 A container for a device timeline which calculates
@@ -1517,9 +1710,7 @@ class Timeline:
 	rowH = 30	# device row height
 	bodyH = 0	# body height
 	rows = 0	# total timeline rows
-	phases = []
-	rowmaxlines = dict()
-	rowcount = dict()
+	rowlines = dict()
 	rowheight = dict()
 	def __init__(self, rowheight):
 		self.rowH = rowheight
@@ -1537,21 +1728,19 @@ class Timeline:
 	#	 The total number of rows needed to display this phase of the timeline
 	def getDeviceRows(self, rawlist):
 		# clear all rows and set them to undefined
-		lendict = dict()
+		sortdict = dict()
 		for item in rawlist:
 			item.row = -1
-			lendict[item] = item.length
-		list = []
-		for i in sorted(lendict, key=lendict.get, reverse=True):
-			list.append(i)
-		remaining = len(list)
+			sortdict[item] = item.length
+		sortlist = sorted(sortdict, key=sortdict.get, reverse=True)
+		remaining = len(sortlist)
 		rowdata = dict()
 		row = 1
 		# try to pack each row with as many ranges as possible
 		while(remaining > 0):
 			if(row not in rowdata):
 				rowdata[row] = []
-			for i in list:
+			for i in sortlist:
 				if(i.row >= 0):
 					continue
 				s = i.time
@@ -1575,81 +1764,81 @@ class Timeline:
 	#	 Organize the timeline entries into the smallest
 	#	 number of rows possible, with no entry overlapping
 	# Arguments:
-	#	 list: the list of devices/actions for a single phase
-	#	 devlist: string list of device names to use
+	#	 devlist: the list of devices/actions in a group of contiguous phases
 	# Output:
 	#	 The total number of rows needed to display this phase of the timeline
-	def getPhaseRows(self, dmesg, devlist):
+	def getPhaseRows(self, devlist):
 		# clear all rows and set them to undefined
 		remaining = len(devlist)
 		rowdata = dict()
 		row = 0
-		lendict = dict()
+		sortdict = dict()
 		myphases = []
+		# initialize all device rows to -1 and calculate devrows
 		for item in devlist:
-			if item[0] not in self.phases:
-				self.phases.append(item[0])
-			if item[0] not in myphases:
-				myphases.append(item[0])
-				self.rowmaxlines[item[0]] = dict()
-				self.rowheight[item[0]] = dict()
-			dev = dmesg[item[0]]['list'][item[1]]
+			dev = item.dev
+			tp = (item.test, item.phase)
+			if tp not in myphases:
+				myphases.append(tp)
 			dev['row'] = -1
-			lendict[item] = float(dev['end']) - float(dev['start'])
+			# sort by length 1st, then name 2nd
+			sortdict[item] = (float(dev['end']) - float(dev['start']), item.dev['name'])
 			if 'src' in dev:
 				dev['devrows'] = self.getDeviceRows(dev['src'])
-		lenlist = []
-		for i in sorted(lendict, key=lendict.get, reverse=True):
-			lenlist.append(i)
+		# sort the devlist by length so that large items graph on top
+		sortlist = sorted(sortdict, key=sortdict.get, reverse=True)
 		orderedlist = []
-		for item in lenlist:
-			dev = dmesg[item[0]]['list'][item[1]]
-			if dev['pid'] == -2:
+		for item in sortlist:
+			if item.dev['pid'] == -2:
 				orderedlist.append(item)
-		for item in lenlist:
+		for item in sortlist:
 			if item not in orderedlist:
 				orderedlist.append(item)
-		# try to pack each row with as many ranges as possible
+		# try to pack each row with as many devices as possible
 		while(remaining > 0):
 			rowheight = 1
 			if(row not in rowdata):
 				rowdata[row] = []
 			for item in orderedlist:
-				dev = dmesg[item[0]]['list'][item[1]]
+				dev = item.dev
 				if(dev['row'] < 0):
 					s = dev['start']
 					e = dev['end']
 					valid = True
 					for ritem in rowdata[row]:
-						rs = ritem['start']
-						re = ritem['end']
+						rs = ritem.dev['start']
+						re = ritem.dev['end']
 						if(not (((s <= rs) and (e <= rs)) or
 							((s >= re) and (e >= re)))):
 							valid = False
 							break
 					if(valid):
-						rowdata[row].append(dev)
+						rowdata[row].append(item)
 						dev['row'] = row
 						remaining -= 1
 						if 'devrows' in dev and dev['devrows'] > rowheight:
 							rowheight = dev['devrows']
-			for phase in myphases:
-				self.rowmaxlines[phase][row] = rowheight
-				self.rowheight[phase][row] = rowheight * self.rowH
+			for t, p in myphases:
+				if t not in self.rowlines or t not in self.rowheight:
+					self.rowlines[t] = dict()
+					self.rowheight[t] = dict()
+				if p not in self.rowlines[t] or p not in self.rowheight[t]:
+					self.rowlines[t][p] = dict()
+					self.rowheight[t][p] = dict()
+				self.rowlines[t][p][row] = rowheight
+				self.rowheight[t][p][row] = rowheight * self.rowH
 			row += 1
 		if(row > self.rows):
 			self.rows = int(row)
-		for phase in myphases:
-			self.rowcount[phase] = row
 		return row
-	def phaseRowHeight(self, phase, row):
-		return self.rowheight[phase][row]
-	def phaseRowTop(self, phase, row):
+	def phaseRowHeight(self, test, phase, row):
+		return self.rowheight[test][phase][row]
+	def phaseRowTop(self, test, phase, row):
 		top = 0
-		for i in sorted(self.rowheight[phase]):
+		for i in sorted(self.rowheight[test][phase]):
 			if i >= row:
 				break
-			top += self.rowheight[phase][i]
+			top += self.rowheight[test][phase][i]
 		return top
 	# Function: calcTotalRows
 	# Description:
@@ -1657,19 +1846,21 @@ class Timeline:
 	def calcTotalRows(self):
 		maxrows = 0
 		standardphases = []
-		for phase in self.phases:
-			total = 0
-			for i in sorted(self.rowmaxlines[phase]):
-				total += self.rowmaxlines[phase][i]
-			if total > maxrows:
-				maxrows = total
-			if total == self.rowcount[phase]:
-				standardphases.append(phase)
+		for t in self.rowlines:
+			for p in self.rowlines[t]:
+				total = 0
+				for i in sorted(self.rowlines[t][p]):
+					total += self.rowlines[t][p][i]
+				if total > maxrows:
+					maxrows = total
+				if total == len(self.rowlines[t][p]):
+					standardphases.append((t, p))
 		self.height = self.scaleH + (maxrows*self.rowH)
 		self.bodyH = self.height - self.scaleH
-		for phase in standardphases:
-			for i in sorted(self.rowheight[phase]):
-				self.rowheight[phase][i] = self.bodyH/self.rowcount[phase]
+		# if there is 1 line per row, draw them the standard way
+		for t, p in standardphases:
+			for i in sorted(self.rowheight[t][p]):
+				self.rowheight[t][p][i] = self.bodyH/len(self.rowlines[t][p])
 	# Function: createTimeScale
 	# Description:
 	#	 Create the timescale for a timeline block
@@ -1756,6 +1947,52 @@ class TestRun:
 		self.ftemp = dict()
 		self.ttemp = dict()
 
+class ProcessMonitor:
+	proclist = dict()
+	running = False
+	def procstat(self):
+		c = ['cat /proc/[1-9]*/stat 2>/dev/null']
+		process = subprocess.Popen(c, shell=True, stdout=subprocess.PIPE)
+		running = dict()
+		for line in process.stdout:
+			data = line.split()
+			pid = data[0]
+			name = re.sub('[()]', '', data[1])
+			user = int(data[13])
+			kern = int(data[14])
+			kjiff = ujiff = 0
+			if pid not in self.proclist:
+				self.proclist[pid] = {'name' : name, 'user' : user, 'kern' : kern}
+			else:
+				val = self.proclist[pid]
+				ujiff = user - val['user']
+				kjiff = kern - val['kern']
+				val['user'] = user
+				val['kern'] = kern
+			if ujiff > 0 or kjiff > 0:
+				running[pid] = ujiff + kjiff
+		result = process.wait()
+		out = ''
+		for pid in running:
+			jiffies = running[pid]
+			val = self.proclist[pid]
+			if out:
+				out += ','
+			out += '%s-%s %d' % (val['name'], pid, jiffies)
+		return 'ps - '+out
+	def processMonitor(self, tid):
+		global sysvals
+		while self.running:
+			out = self.procstat()
+			if out:
+				sysvals.fsetVal(out, 'trace_marker')
+	def start(self):
+		self.thread = Thread(target=self.processMonitor, args=(0,))
+		self.running = True
+		self.thread.start()
+	def stop(self):
+		self.running = False
+
 # ----------------- FUNCTIONS --------------------
 
 # Function: vprint
@@ -1788,6 +2025,13 @@ def parseStamp(line, data):
 	data.stamp['kernel'] = m.group('kernel')
 	sysvals.hostname = data.stamp['host']
 	sysvals.suspendmode = data.stamp['mode']
+	if sysvals.suspendmode == 'command' and sysvals.ftracefile != '':
+		modes = ['on', 'freeze', 'standby', 'mem']
+		out = os.popen('grep suspend_enter '+sysvals.ftracefile).read()
+		m = re.match('.* suspend_enter\[(?P<mode>.*)\]', out)
+		if m and m.group('mode') in ['1', '2', '3']:
+			sysvals.suspendmode = modes[int(m.group('mode'))]
+			data.stamp['mode'] = sysvals.suspendmode
 	if not sysvals.stamp:
 		sysvals.stamp = data.stamp
 
@@ -2071,7 +2315,7 @@ def parseTraceLog():
 		doError('%s does not exist' % sysvals.ftracefile, False)
 
 	sysvals.setupAllKprobes()
-	tracewatch = ['suspend_enter']
+	tracewatch = []
 	if sysvals.usekprobes:
 		tracewatch += ['sync_filesystems', 'freeze_processes', 'syscore_suspend',
 			'syscore_resume', 'resume_console', 'thaw_processes', 'CPU_ON', 'CPU_OFF']
@@ -2102,17 +2346,13 @@ def parseTraceLog():
 		if(m):
 			tp.setTracerType(m.group('t'))
 			continue
-		# post resume time line: did this test run include post-resume data
-		m = re.match(sysvals.postresumefmt, line)
-		if(m):
-			t = int(m.group('t'))
-			if(t > 0):
-				sysvals.postresumetime = t
-			continue
 		# device properties line
 		if(re.match(sysvals.devpropfmt, line)):
 			devProps(line)
 			continue
+		# ignore all other commented lines
+		if line[0] == '#':
+			continue
 		# ftrace line: parse only valid lines
 		m = re.match(tp.ftrace_line_fmt, line)
 		if(not m):
@@ -2142,20 +2382,35 @@ def parseTraceLog():
 			testrun = TestRun(data)
 			testruns.append(testrun)
 			parseStamp(tp.stamp, data)
-			if len(tp.fwdata) > data.testnumber:
+			if sysvals.suspendmode == 'mem' and len(tp.fwdata) > data.testnumber:
 				data.fwSuspend, data.fwResume = tp.fwdata[data.testnumber]
 				if(data.fwSuspend > 0 or data.fwResume > 0):
 					data.fwValid = True
 			data.setStart(t.time)
+			data.tKernSus = t.time
 			continue
 		if(not data):
 			continue
+		# process cpu exec line
+		if t.type == 'tracing_mark_write':
+			m = re.match(sysvals.procexecfmt, t.name)
+			if(m):
+				proclist = dict()
+				for ps in m.group('ps').split(','):
+					val = ps.split()
+					if not val:
+						continue
+					name = val[0].replace('--', '-')
+					proclist[name] = int(val[1])
+				data.pstl[t.time] = proclist
+				continue
 		# find the end of resume
 		if(t.endMarker()):
-			if(sysvals.usetracemarkers and sysvals.postresumetime > 0):
-				phase = 'post_resume'
-				data.newPhase(phase, t.time, t.time, '#F0F0F0', -1)
 			data.setEnd(t.time)
+			if data.tKernRes == 0.0:
+				data.tKernRes = t.time
+			if data.dmesg['resume_complete']['end'] < 0:
+				data.dmesg['resume_complete']['end'] = t.time
 			if(not sysvals.usetracemarkers):
 				# no trace markers? then quit and be sure to finish recording
 				# the event we used to trigger resume end
@@ -2190,8 +2445,14 @@ def parseTraceLog():
 				if(name.split('[')[0] in tracewatch):
 					continue
 				# -- phase changes --
+				# start of kernel suspend
+				if(re.match('suspend_enter\[.*', t.name)):
+					if(isbegin):
+						data.dmesg[phase]['start'] = t.time
+						data.tKernSus = t.time
+					continue
 				# suspend_prepare start
-				if(re.match('dpm_prepare\[.*', t.name)):
+				elif(re.match('dpm_prepare\[.*', t.name)):
 					phase = 'suspend_prepare'
 					if(not isbegin):
 						data.dmesg[phase]['end'] = t.time
@@ -2291,6 +2552,8 @@ def parseTraceLog():
 				p = m.group('p')
 				if(n and p):
 					data.newAction(phase, n, pid, p, t.time, -1, drv)
+					if pid not in data.devpids:
+						data.devpids.append(pid)
 			# device callback finish
 			elif(t.type == 'device_pm_callback_end'):
 				m = re.match('(?P<drv>.*) (?P<d>.*), err.*', t.name);
@@ -2332,6 +2595,12 @@ def parseTraceLog():
 				else:
 					e['end'] = t.time
 					e['rdata'] = kprobedata
+				# end of kernel resume
+				if(kprobename == 'pm_notifier_call_chain' or \
+					kprobename == 'pm_restore_console'):
+					data.dmesg[phase]['end'] = t.time
+					data.tKernRes = t.time
+
 		# callgraph processing
 		elif sysvals.usecallgraph:
 			# create a callgraph object for the data
@@ -2359,7 +2628,14 @@ def parseTraceLog():
 			test.data.tLow = 0
 			test.data.fwValid = False
 
+	# dev source and procmon events can be unreadable with mixed phase height
+	if sysvals.usedevsrc or sysvals.useprocmon:
+		sysvals.mixedphaseheight = False
+
 	for test in testruns:
+		# add the process usage data to the timeline
+		if sysvals.useprocmon:
+			test.data.createProcessUsageEvents()
 		# add the traceevent data to the device hierarchy
 		if(sysvals.usetraceevents):
 			# add actual trace funcs
@@ -2387,11 +2663,11 @@ def parseTraceLog():
 						continue
 					color = sysvals.kprobeColor(e['name'])
 					if name not in sysvals.dev_tracefuncs:
-						# config base kprobe
+						# custom user kprobe from the config
 						test.data.newActionGlobal(e['name'], kb, ke, -2, color)
 					elif sysvals.usedevsrc:
 						# dev kprobe
-						data.addDeviceFunctionCall(e['name'], name, e['proc'], pid, kb,
+						test.data.addDeviceFunctionCall(e['name'], name, e['proc'], pid, kb,
 							ke, e['cdata'], e['rdata'])
 		if sysvals.usecallgraph:
 			# add the callgraph data to the device hierarchy
@@ -2443,9 +2719,19 @@ def parseTraceLog():
 		if(len(sysvals.devicefilter) > 0):
 			data.deviceFilter(sysvals.devicefilter)
 		data.fixupInitcallsThatDidntReturn()
-		if(sysvals.verbose):
+		if sysvals.usedevsrc:
+			data.optimizeDevSrc()
+		if sysvals.verbose:
 			data.printDetails()
 
+	# merge any overlapping devices between test runs
+	if sysvals.usedevsrc and len(testdata) > 1:
+		tc = len(testdata)
+		for i in range(tc - 1):
+			devlist = testdata[i].overflowDevices()
+			for j in range(i + 1, tc):
+				testdata[j].mergeOverlapDevices(devlist)
+
 	return testdata
 
 # Function: loadRawKernelLog
@@ -3009,14 +3295,15 @@ def createHTML(testruns):
 	headline_version = '<div class="version"><a href="https://01.org/suspendresume">AnalyzeSuspend v%s</a></div>' % sysvals.version
 	headline_stamp = '<div class="stamp">{0} {1} {2} {3}</div>\n'
 	html_devlist1 = '<button id="devlist1" class="devlist" style="float:left;">Device Detail%s</button>' % x2changes[0]
-	html_zoombox = '<center><button id="zoomin">ZOOM IN</button><button id="zoomout">ZOOM OUT</button><button id="zoomdef">ZOOM 1:1</button></center>\n'
+	html_zoombox = '<center><button id="zoomin">ZOOM IN +</button><button id="zoomout">ZOOM OUT -</button><button id="zoomdef">ZOOM 1:1</button></center>\n'
 	html_devlist2 = '<button id="devlist2" class="devlist" style="float:right;">Device Detail2</button>\n'
 	html_timeline = '<div id="dmesgzoombox" class="zoombox">\n<div id="{0}" class="timeline" style="height:{1}px">\n'
-	html_tblock = '<div id="block{0}" class="tblock" style="left:{1}%;width:{2}%;">\n'
+	html_tblock = '<div id="block{0}" class="tblock" style="left:{1}%;width:{2}%;"><div class="tback" style="height:{3}px"></div>\n'
 	html_device = '<div id="{0}" title="{1}" class="thread{7}" style="left:{2}%;top:{3}px;height:{4}px;width:{5}%;{8}">{6}</div>\n'
-	html_traceevent = '<div title="{0}" class="traceevent" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;">{5}</div>\n'
+	html_traceevent = '<div title="{0}" class="traceevent{6}" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;">{5}</div>\n'
+	html_cpuexec = '<div class="jiffie" style="left:{0}%;top:{1}px;height:{2}px;width:{3}%;background:{4};"></div>\n'
 	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}px;height:{3}px;background-color:{4}">{5}</div>\n'
-	html_phaselet = '<div id="{0}" class="phaselet" style="left:{1}%;width:{2}%;background-color:{3}"></div>\n'
+	html_phaselet = '<div id="{0}" class="phaselet" style="left:{1}%;width:{2}%;background:{3}"></div>\n'
 	html_legend = '<div id="p{3}" class="square" style="left:{0}%;background-color:{1}">&nbsp;{2}</div>\n'
 	html_timetotal = '<table class="time1">\n<tr>'\
 		'<td class="green">{2} Suspend Time: <b>{0} ms</b></td>'\
@@ -3039,23 +3326,18 @@ def createHTML(testruns):
 		'</tr>\n</table>\n'
 
 	# html format variables
-	rowheight = 30
-	devtextS = '14px'
-	devtextH = '30px'
-	hoverZ = 'z-index:10;'
-
+	hoverZ = 'z-index:8;'
 	if sysvals.usedevsrc:
 		hoverZ = ''
 
 	# device timeline
 	vprint('Creating Device Timeline...')
 
-	devtl = Timeline(rowheight)
+	devtl = Timeline(30)
 
 	# Generate the header for this timeline
 	for data in testruns:
 		tTotal = data.end - data.start
-		tEnd = data.dmesg['resume_complete']['end']
 		if(tTotal == 0):
 			print('ERROR: No timeline data')
 			sys.exit()
@@ -3074,7 +3356,7 @@ def createHTML(testruns):
 		elif data.fwValid:
 			suspend_time = '%.0f'%((data.tSuspended-data.start)*1000 + \
 				(data.fwSuspend/1000000.0))
-			resume_time = '%.0f'%((tEnd-data.tSuspended)*1000 + \
+			resume_time = '%.0f'%((data.end-data.tSuspended)*1000 + \
 				(data.fwResume/1000000.0))
 			testdesc1 = 'Total'
 			testdesc2 = ''
@@ -3089,7 +3371,7 @@ def createHTML(testruns):
 					resume_time, testdesc1)
 			devtl.html['header'] += thtml
 			sktime = '%.3f'%((data.dmesg['suspend_machine']['end'] - \
-				data.getStart())*1000)
+				data.tKernSus)*1000)
 			sftime = '%.3f'%(data.fwSuspend / 1000000.0)
 			rftime = '%.3f'%(data.fwResume / 1000000.0)
 			rktime = '%.3f'%((data.dmesg['resume_complete']['end'] - \
@@ -3098,7 +3380,7 @@ def createHTML(testruns):
 				sftime, rftime, rktime, testdesc2)
 		else:
 			suspend_time = '%.0f'%((data.tSuspended-data.start)*1000)
-			resume_time = '%.0f'%((tEnd-data.tSuspended)*1000)
+			resume_time = '%.0f'%((data.end-data.tSuspended)*1000)
 			testdesc = 'Kernel'
 			if(len(testruns) > 1):
 				testdesc = ordinal(data.testnumber+1)+' '+testdesc
@@ -3117,14 +3399,20 @@ def createHTML(testruns):
 	tTotal = tMax - t0
 
 	# determine the maximum number of rows we need to draw
+	fulllist = []
 	for data in testruns:
 		data.selectTimelineDevices('%f', tTotal, sysvals.mindevlen)
 		for group in data.devicegroups:
 			devlist = []
 			for phase in group:
 				for devname in data.tdevlist[phase]:
-					devlist.append((phase,devname))
-			devtl.getPhaseRows(data.dmesg, devlist)
+					d = DevItem(data.testnumber, phase, data.dmesg[phase]['list'][devname])
+					devlist.append(d)
+					fulllist.append(d)
+			if sysvals.mixedphaseheight:
+				devtl.getPhaseRows(devlist)
+	if not sysvals.mixedphaseheight:
+		devtl.getPhaseRows(fulllist)
 	devtl.calcTotalRows()
 
 	# create bounding box, add buttons
@@ -3145,18 +3433,6 @@ def createHTML(testruns):
 
 	# draw each test run chronologically
 	for data in testruns:
-		# if nore than one test, draw a block to represent user mode
-		if(data.testnumber > 0):
-			m0 = testruns[data.testnumber-1].end
-			mMax = testruns[data.testnumber].start
-			mTotal = mMax - m0
-			name = 'usermode%d' % data.testnumber
-			top = '%d' % devtl.scaleH
-			left = '%f' % (((m0-t0)*100.0)/tTotal)
-			width = '%f' % ((mTotal*100.0)/tTotal)
-			title = 'user mode (%0.3f ms) ' % (mTotal*1000)
-			devtl.html['timeline'] += html_device.format(name, \
-				title, left, top, '%d'%devtl.bodyH, width, '', '', '')
 		# now draw the actual timeline blocks
 		for dir in phases:
 			# draw suspend and resume blocks separately
@@ -3169,13 +3445,16 @@ def createHTML(testruns):
 			else:
 				m0 = testruns[data.testnumber].tSuspended
 				mMax = testruns[data.testnumber].end
+				# in an x2 run, remove any gap between blocks
+				if len(testruns) > 1 and data.testnumber == 0:
+					mMax = testruns[1].start
 				mTotal = mMax - m0
 				left = '%f' % ((((m0-t0)*100.0)+sysvals.srgap/2)/tTotal)
 			# if a timeline block is 0 length, skip altogether
 			if mTotal == 0:
 				continue
 			width = '%f' % (((mTotal*100.0)-sysvals.srgap/2)/tTotal)
-			devtl.html['timeline'] += html_tblock.format(bname, left, width)
+			devtl.html['timeline'] += html_tblock.format(bname, left, width, devtl.scaleH)
 			for b in sorted(phases[dir]):
 				# draw the phase color background
 				phase = data.dmesg[b]
@@ -3185,6 +3464,7 @@ def createHTML(testruns):
 				devtl.html['timeline'] += html_phase.format(left, width, \
 					'%.3f'%devtl.scaleH, '%.3f'%devtl.bodyH, \
 					data.dmesg[b]['color'], '')
+			for b in sorted(phases[dir]):
 				# draw the devices for this phase
 				phaselist = data.dmesg[b]['list']
 				for d in data.tdevlist[b]:
@@ -3196,46 +3476,62 @@ def createHTML(testruns):
 					xtrastyle = ''
 					if 'htmlclass' in dev:
 						xtraclass = dev['htmlclass']
-						xtrainfo = dev['htmlclass']
 					if 'color' in dev:
 						xtrastyle = 'background-color:%s;' % dev['color']
 					if(d in sysvals.devprops):
 						name = sysvals.devprops[d].altName(d)
 						xtraclass = sysvals.devprops[d].xtraClass()
 						xtrainfo = sysvals.devprops[d].xtraInfo()
+					elif xtraclass == ' kth':
+						xtrainfo = ' kernel_thread'
 					if('drv' in dev and dev['drv']):
 						drv = ' {%s}' % dev['drv']
-					rowheight = devtl.phaseRowHeight(b, dev['row'])
-					rowtop = devtl.phaseRowTop(b, dev['row'])
+					rowheight = devtl.phaseRowHeight(data.testnumber, b, dev['row'])
+					rowtop = devtl.phaseRowTop(data.testnumber, b, dev['row'])
 					top = '%.3f' % (rowtop + devtl.scaleH)
 					left = '%f' % (((dev['start']-m0)*100)/mTotal)
 					width = '%f' % (((dev['end']-dev['start'])*100)/mTotal)
 					length = ' (%0.3f ms) ' % ((dev['end']-dev['start'])*1000)
+					title = name+drv+xtrainfo+length
 					if sysvals.suspendmode == 'command':
-						title = name+drv+xtrainfo+length+'cmdexec'
+						title += 'cmdexec'
+					elif xtraclass == ' ps':
+						if 'suspend' in b:
+							title += 'pre_suspend_process'
+						else:
+							title += 'post_resume_process'
 					else:
-						title = name+drv+xtrainfo+length+b
+						title += b
 					devtl.html['timeline'] += html_device.format(dev['id'], \
 						title, left, top, '%.3f'%rowheight, width, \
 						d+drv, xtraclass, xtrastyle)
+					if('cpuexec' in dev):
+						for t in sorted(dev['cpuexec']):
+							start, end = t
+							j = float(dev['cpuexec'][t]) / 5
+							if j > 1.0:
+								j = 1.0
+							height = '%.3f' % (rowheight/3)
+							top = '%.3f' % (rowtop + devtl.scaleH + 2*rowheight/3)
+							left = '%f' % (((start-m0)*100)/mTotal)
+							width = '%f' % ((end-start)*100/mTotal)
+							color = 'rgba(255, 0, 0, %f)' % j
+							devtl.html['timeline'] += \
+								html_cpuexec.format(left, top, height, width, color)
 					if('src' not in dev):
 						continue
 					# draw any trace events for this device
-					vprint('Debug trace events found for device %s' % d)
-					vprint('%20s %20s %10s %8s' % ('title', \
-						'name', 'time(ms)', 'length(ms)'))
 					for e in dev['src']:
-						vprint('%20s %20s %10.3f %8.3f' % (e.title, \
-							e.text, e.time*1000, e.length*1000))
-						height = devtl.rowH
+						height = '%.3f' % devtl.rowH
 						top = '%.3f' % (rowtop + devtl.scaleH + (e.row*devtl.rowH))
 						left = '%f' % (((e.time-m0)*100)/mTotal)
 						width = '%f' % (e.length*100/mTotal)
-						color = 'rgba(204,204,204,0.5)'
+						sleepclass = ''
+						if e.ubiquitous:
+							sleepclass = ' sleep'
 						devtl.html['timeline'] += \
-							html_traceevent.format(e.title, \
-								left, top, '%.3f'%height, \
-								width, e.text)
+							html_traceevent.format(e.title(), \
+								left, top, height, width, e.text(), sleepclass)
 			# draw the time scale, try to make the number of labels readable
 			devtl.html['timeline'] += devtl.createTimeScale(m0, mMax, tTotal, dir)
 			devtl.html['timeline'] += '</div>\n'
@@ -3302,20 +3598,23 @@ def createHTML(testruns):
 		.pf:'+cgchk+' + label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/><rect x="8" y="4" width="2" height="10" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
 		.pf:'+cgnchk+' ~ label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
 		.pf:'+cgchk+' ~ *:not(:nth-child(2)) {display:none;}\n\
-		.zoombox {position:relative;width:100%;overflow-x:scroll;}\n\
+		.zoombox {position:relative;width:100%;overflow-x:scroll;-webkit-user-select:none;-moz-user-select:none;user-select:none;}\n\
 		.timeline {position:relative;font-size:14px;cursor:pointer;width:100%; overflow:hidden;background:linear-gradient(#cccccc, white);}\n\
-		.thread {position:absolute;height:0%;overflow:hidden;line-height:'+devtextH+';font-size:'+devtextS+';border:1px solid;text-align:center;white-space:nowrap;background-color:rgba(204,204,204,0.5);}\n\
+		.thread {position:absolute;height:0%;overflow:hidden;z-index:7;line-height:30px;font-size:14px;border:1px solid;text-align:center;white-space:nowrap;}\n\
 		.thread.sync {background-color:'+sysvals.synccolor+';}\n\
 		.thread.bg {background-color:'+sysvals.kprobecolor+';}\n\
+		.thread.ps {border-radius:3px;background:linear-gradient(to top, #ccc, #eee);}\n\
 		.thread:hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
 		.hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
 		.hover.sync {background-color:white;}\n\
-		.hover.bg {background-color:white;}\n\
-		.traceevent {position:absolute;font-size:10px;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,rgba(204,204,204,1),rgba(150,150,150,1));}\n\
+		.hover.bg,.hover.kth,.hover.sync,.hover.ps {background-color:white;}\n\
+		.jiffie {position:absolute;pointer-events: none;z-index:8;}\n\
+		.traceevent {position:absolute;font-size:10px;z-index:7;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,rgb(204,204,204),rgb(150,150,150));}\n\
+		.traceevent.sleep {font-style:normal;}\n\
 		.traceevent:hover {background:white;}\n\
 		.phase {position:absolute;overflow:hidden;border:0px;text-align:center;}\n\
 		.phaselet {position:absolute;overflow:hidden;border:0px;text-align:center;height:100px;font-size:24px;}\n\
-		.t {z-index:2;position:absolute;pointer-events:none;top:0%;height:100%;border-right:1px solid black;}\n\
+		.t {position:absolute;pointer-events:none;top:0%;height:100%;border-right:1px solid black;z-index:6;}\n\
 		.legend {position:relative; width:100%; height:40px; text-align:center;margin-bottom:20px}\n\
 		.legend .square {position:absolute;cursor:pointer;top:10px; width:0px;height:20px;border:1px solid;padding-left:20px;}\n\
 		button {height:40px;width:200px;margin-bottom:20px;margin-top:20px;font-size:24px;}\n\
@@ -3327,7 +3626,8 @@ def createHTML(testruns):
 		a:active {color:white;}\n\
 		.version {position:relative;float:left;color:white;font-size:10px;line-height:30px;margin-left:10px;}\n\
 		#devicedetail {height:100px;box-shadow:5px 5px 20px black;}\n\
-		.tblock {position:absolute;height:100%;}\n\
+		.tblock {position:absolute;height:100%;background-color:#ddd;}\n\
+		.tback {position:absolute;width:100%;background:linear-gradient(#ccc, #ddd);}\n\
 		.bg {z-index:1;}\n\
 	</style>\n</head>\n<body>\n'
 
@@ -3359,6 +3659,9 @@ def createHTML(testruns):
 	# draw the colored boxes for the device detail section
 	for data in testruns:
 		hf.write('<div id="devicedetail%d">\n' % data.testnumber)
+		pscolor = 'linear-gradient(to top left, #ccc, #eee)'
+		hf.write(html_phaselet.format('pre_suspend_process', \
+			'0', '0', pscolor))
 		for b in data.phases:
 			phase = data.dmesg[b]
 			length = phase['end']-phase['start']
@@ -3366,9 +3669,10 @@ def createHTML(testruns):
 			width = '%.3f' % ((length*100.0)/tTotal)
 			hf.write(html_phaselet.format(b, left, width, \
 				data.dmesg[b]['color']))
+		hf.write(html_phaselet.format('post_resume_process', \
+			'0', '0', pscolor))
 		if sysvals.suspendmode == 'command':
-			hf.write(html_phaselet.format('cmdexec', '0', '0', \
-				data.dmesg['resume_complete']['color']))
+			hf.write(html_phaselet.format('cmdexec', '0', '0', pscolor))
 		hf.write('</div>\n')
 	hf.write('</div>\n')
 
@@ -3475,6 +3779,7 @@ def addScriptCode(hf, testruns):
 	script_code = \
 	'<script type="text/javascript">\n'+detail+\
 	'	var resolution = -1;\n'\
+	'	var dragval = [0, 0];\n'\
 	'	function redrawTimescale(t0, tMax, tS) {\n'\
 	'		var rline = \'<div class="t" style="left:0;border-left:1px solid black;border-right:0;"><cR><-R</cR></div>\';\n'\
 	'		var tTotal = tMax - t0;\n'\
@@ -3542,8 +3847,12 @@ def addScriptCode(hf, testruns):
 	'		resolution = tS[i];\n'\
 	'		redrawTimescale(t0, tMax, tS[i]);\n'\
 	'	}\n'\
+	'	function deviceName(title) {\n'\
+	'		var name = title.slice(0, title.indexOf(" ("));\n'\
+	'		return name;\n'\
+	'	}\n'\
 	'	function deviceHover() {\n'\
-	'		var name = this.title.slice(0, this.title.indexOf(" ("));\n'\
+	'		var name = deviceName(this.title);\n'\
 	'		var dmesg = document.getElementById("dmesg");\n'\
 	'		var dev = dmesg.getElementsByClassName("thread");\n'\
 	'		var cpu = -1;\n'\
@@ -3552,7 +3861,7 @@ def addScriptCode(hf, testruns):
 	'		else if(name.match("CPU_OFF\[[0-9]*\]"))\n'\
 	'			cpu = parseInt(name.slice(8));\n'\
 	'		for (var i = 0; i < dev.length; i++) {\n'\
-	'			dname = dev[i].title.slice(0, dev[i].title.indexOf(" ("));\n'\
+	'			dname = deviceName(dev[i].title);\n'\
 	'			var cname = dev[i].className.slice(dev[i].className.indexOf("thread"));\n'\
 	'			if((cpu >= 0 && dname.match("CPU_O[NF]*\\\[*"+cpu+"\\\]")) ||\n'\
 	'				(name == dname))\n'\
@@ -3578,7 +3887,7 @@ def addScriptCode(hf, testruns):
 	'			total[2] = (total[2]+total[4])/2;\n'\
 	'		}\n'\
 	'		var devtitle = document.getElementById("devicedetailtitle");\n'\
-	'		var name = title.slice(0, title.indexOf(" ("));\n'\
+	'		var name = deviceName(title);\n'\
 	'		if(cpu >= 0) name = "CPU"+cpu;\n'\
 	'		var driver = "";\n'\
 	'		var tS = "<t2>(</t2>";\n'\
@@ -3600,7 +3909,7 @@ def addScriptCode(hf, testruns):
 	'	function deviceDetail() {\n'\
 	'		var devinfo = document.getElementById("devicedetail");\n'\
 	'		devinfo.style.display = "block";\n'\
-	'		var name = this.title.slice(0, this.title.indexOf(" ("));\n'\
+	'		var name = deviceName(this.title);\n'\
 	'		var cpu = -1;\n'\
 	'		if(name.match("CPU_ON\[[0-9]*\]"))\n'\
 	'			cpu = parseInt(name.slice(7));\n'\
@@ -3615,7 +3924,7 @@ def addScriptCode(hf, testruns):
 	'		var pd = pdata[0];\n'\
 	'		var total = [0.0, 0.0, 0.0];\n'\
 	'		for (var i = 0; i < dev.length; i++) {\n'\
-	'			dname = dev[i].title.slice(0, dev[i].title.indexOf(" ("));\n'\
+	'			dname = deviceName(dev[i].title);\n'\
 	'			if((cpu >= 0 && dname.match("CPU_O[NF]*\\\[*"+cpu+"\\\]")) ||\n'\
 	'				(name == dname))\n'\
 	'			{\n'\
@@ -3656,7 +3965,7 @@ def addScriptCode(hf, testruns):
 	'					phases[i].title = phases[i].id+" "+pd[phases[i].id]+" ms";\n'\
 	'					left += w;\n'\
 	'					var time = "<t4 style=\\"font-size:"+fs+"px\\">"+pd[phases[i].id]+" ms<br></t4>";\n'\
-	'					var pname = "<t3 style=\\"font-size:"+fs2+"px\\">"+phases[i].id.replace("_", " ")+"</t3>";\n'\
+	'					var pname = "<t3 style=\\"font-size:"+fs2+"px\\">"+phases[i].id.replace(new RegExp("_", "g"), " ")+"</t3>";\n'\
 	'					phases[i].innerHTML = time+pname;\n'\
 	'				} else {\n'\
 	'					phases[i].style.width = "0%";\n'\
@@ -3702,10 +4011,37 @@ def addScriptCode(hf, testruns):
 	'	}\n'\
 	'	function onClickPhase(e) {\n'\
 	'	}\n'\
+	'	function onMouseDown(e) {\n'\
+	'		dragval[0] = e.clientX;\n'\
+	'		dragval[1] = document.getElementById("dmesgzoombox").scrollLeft;\n'\
+	'		document.onmousemove = onMouseMove;\n'\
+	'	}\n'\
+	'	function onMouseMove(e) {\n'\
+	'		var zoombox = document.getElementById("dmesgzoombox");\n'\
+	'		zoombox.scrollLeft = dragval[1] + dragval[0] - e.clientX;\n'\
+	'	}\n'\
+	'	function onMouseUp(e) {\n'\
+	'		document.onmousemove = null;\n'\
+	'	}\n'\
+	'	function onKeyPress(e) {\n'\
+	'		var c = e.charCode;\n'\
+	'		if(c != 42 && c != 43 && c != 45) return;\n'\
+	'		var click = document.createEvent("Events");\n'\
+	'		click.initEvent("click", true, false);\n'\
+	'		if(c == 43)  \n'\
+	'			document.getElementById("zoomin").dispatchEvent(click);\n'\
+	'		else if(c == 45)\n'\
+	'			document.getElementById("zoomout").dispatchEvent(click);\n'\
+	'		else if(c == 42)\n'\
+	'			document.getElementById("zoomdef").dispatchEvent(click);\n'\
+	'	}\n'\
 	'	window.addEventListener("resize", function () {zoomTimeline();});\n'\
 	'	window.addEventListener("load", function () {\n'\
 	'		var dmesg = document.getElementById("dmesg");\n'\
 	'		dmesg.style.width = "100%"\n'\
+	'		document.onmousedown = onMouseDown;\n'\
+	'		document.onmouseup = onMouseUp;\n'\
+	'		document.onkeypress = onKeyPress;\n'\
 	'		document.getElementById("zoomin").onclick = zoomTimeline;\n'\
 	'		document.getElementById("zoomout").onclick = zoomTimeline;\n'\
 	'		document.getElementById("zoomdef").onclick = zoomTimeline;\n'\
@@ -3736,7 +4072,7 @@ def addScriptCode(hf, testruns):
 def executeSuspend():
 	global sysvals
 
-	t0 = time.time()*1000
+	pm = ProcessMonitor()
 	tp = sysvals.tpath
 	fwdata = []
 	# mark the start point in the kernel ring buffer just as we start
@@ -3745,30 +4081,35 @@ def executeSuspend():
 	if(sysvals.usecallgraph or sysvals.usetraceevents):
 		print('START TRACING')
 		sysvals.fsetVal('1', 'tracing_on')
+		if sysvals.useprocmon:
+			pm.start()
 	# execute however many s/r runs requested
 	for count in range(1,sysvals.execcount+1):
-		# if this is test2 and there's a delay, start here
+		# x2delay in between test runs
 		if(count > 1 and sysvals.x2delay > 0):
-			tN = time.time()*1000
-			while (tN - t0) < sysvals.x2delay:
-				tN = time.time()*1000
-				time.sleep(0.001)
-		# initiate suspend
-		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			sysvals.fsetVal('SUSPEND START', 'trace_marker')
-		if sysvals.suspendmode == 'command':
+			time.sleep(sysvals.x2delay/1000.0)
+		# start message
+		if sysvals.testcommand != '':
 			print('COMMAND START')
-			if(sysvals.rtcwake):
-				print('will issue an rtcwake in %d seconds' % sysvals.rtcwaketime)
-				sysvals.rtcWakeAlarmOn()
-			os.system(sysvals.testcommand)
 		else:
 			if(sysvals.rtcwake):
 				print('SUSPEND START')
-				print('will autoresume in %d seconds' % sysvals.rtcwaketime)
-				sysvals.rtcWakeAlarmOn()
 			else:
 				print('SUSPEND START (press a key to resume)')
+		# set rtcwake
+		if(sysvals.rtcwake):
+			print('will issue an rtcwake in %d seconds' % sysvals.rtcwaketime)
+			sysvals.rtcWakeAlarmOn()
+		# start of suspend trace marker
+		if(sysvals.usecallgraph or sysvals.usetraceevents):
+			sysvals.fsetVal('SUSPEND START', 'trace_marker')
+		# predelay delay
+		if(count == 1 and sysvals.predelay > 0):
+			time.sleep(sysvals.predelay/1000.0)
+		# initiate suspend or command
+		if sysvals.testcommand != '':
+			os.system(sysvals.testcommand+' 2>&1');
+		else:
 			pf = open(sysvals.powerfile, 'w')
 			pf.write(sysvals.suspendmode)
 			# execution will pause here
@@ -3776,22 +4117,21 @@ def executeSuspend():
 				pf.close()
 			except:
 				pass
-		t0 = time.time()*1000
 		if(sysvals.rtcwake):
 			sysvals.rtcWakeAlarmOff()
+		# postdelay delay
+		if(count == sysvals.execcount and sysvals.postdelay > 0):
+			time.sleep(sysvals.postdelay/1000.0)
 		# return from suspend
 		print('RESUME COMPLETE')
 		if(sysvals.usecallgraph or sysvals.usetraceevents):
 			sysvals.fsetVal('RESUME COMPLETE', 'trace_marker')
-		if(sysvals.suspendmode == 'mem'):
+		if(sysvals.suspendmode == 'mem' or sysvals.suspendmode == 'command'):
 			fwdata.append(getFPDT(False))
-	# look for post resume events after the last test run
-	t = sysvals.postresumetime
-	if(t > 0):
-		print('Waiting %d seconds for POST-RESUME trace events...' % t)
-		time.sleep(t)
 	# stop ftrace
 	if(sysvals.usecallgraph or sysvals.usetraceevents):
+		if sysvals.useprocmon:
+			pm.stop()
 		sysvals.fsetVal('0', 'tracing_on')
 		print('CAPTURING TRACE')
 		writeDatafileHeader(sysvals.ftracefile, fwdata)
@@ -3806,15 +4146,12 @@ def executeSuspend():
 def writeDatafileHeader(filename, fwdata):
 	global sysvals
 
-	prt = sysvals.postresumetime
 	fp = open(filename, 'a')
 	fp.write(sysvals.teststamp+'\n')
-	if(sysvals.suspendmode == 'mem'):
+	if(sysvals.suspendmode == 'mem' or sysvals.suspendmode == 'command'):
 		for fw in fwdata:
 			if(fw):
 				fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
-	if(prt > 0):
-		fp.write('# post resume time %u\n' % prt)
 	fp.close()
 
 # Function: setUSBDevicesAuto
@@ -4402,6 +4739,8 @@ def rerunTest():
 			'requires a dmesg file', False)
 	sysvals.setOutputFile()
 	vprint('Output file: %s' % sysvals.htmlfile)
+	if(os.path.exists(sysvals.htmlfile) and not os.access(sysvals.htmlfile, os.W_OK)):
+		doError('missing permission to write to %s' % sysvals.htmlfile, False)
 	print('PROCESSING DATA')
 	if(sysvals.usetraceeventsonly):
 		testruns = parseTraceLog()
@@ -4524,6 +4863,8 @@ def configFromFile(file):
 				sysvals.addlogs = checkArgBool(value)
 			elif(opt.lower() == 'dev'):
 				sysvals.usedevsrc = checkArgBool(value)
+			elif(opt.lower() == 'proc'):
+				sysvals.useprocmon = checkArgBool(value)
 			elif(opt.lower() == 'ignorekprobes'):
 				ignorekprobes = checkArgBool(value)
 			elif(opt.lower() == 'x2'):
@@ -4537,6 +4878,8 @@ def configFromFile(file):
 					value = value.split(',')
 				for i in value:
 					sysvals.debugfuncs.append(i.strip())
+			elif(opt.lower() == 'devicefilter'):
+				sysvals.setDeviceFilter(value)
 			elif(opt.lower() == 'expandcg'):
 				sysvals.cgexp = checkArgBool(value)
 			elif(opt.lower() == 'srgap'):
@@ -4548,8 +4891,10 @@ def configFromFile(file):
 				sysvals.testcommand = value
 			elif(opt.lower() == 'x2delay'):
 				sysvals.x2delay = getArgInt('-x2delay', value, 0, 60000, False)
-			elif(opt.lower() == 'postres'):
-				sysvals.postresumetime = getArgInt('-postres', value, 0, 3600, False)
+			elif(opt.lower() == 'predelay'):
+				sysvals.predelay = getArgInt('-predelay', value, 0, 60000, False)
+			elif(opt.lower() == 'postdelay'):
+				sysvals.postdelay = getArgInt('-postdelay', value, 0, 60000, False)
 			elif(opt.lower() == 'rtcwake'):
 				sysvals.rtcwake = True
 				sysvals.rtcwaketime = getArgInt('-rtcwake', value, 0, 3600, False)
@@ -4572,19 +4917,18 @@ def configFromFile(file):
 				except:
 					sysvals.synccolor = value
 			elif(opt.lower() == 'output-dir'):
-				args = dict()
-				n = datetime.now()
-				args['date'] = n.strftime('%y%m%d')
-				args['time'] = n.strftime('%H%M%S')
-				args['hostname'] = sysvals.hostname
-				sysvals.outdir = value.format(**args)
+				sysvals.setOutputFolder(value)
 
 	if sysvals.suspendmode == 'command' and not sysvals.testcommand:
 		doError('No command supplied for mode "command"', False)
+
+	# compatibility errors
 	if sysvals.usedevsrc and sysvals.usecallgraph:
-		doError('dev and callgraph cannot both be true', False)
+		doError('-dev is not compatible with -f', False)
 	if sysvals.usecallgraph and sysvals.execcount > 1:
 		doError('-x2 is not compatible with -f', False)
+	if sysvals.usecallgraph and sysvals.useprocmon:
+		doError('-proc is not compatible with -f', False)
 
 	if ignorekprobes:
 		return
@@ -4637,8 +4981,7 @@ def configFromFile(file):
 			'name': name,
 			'func': function,
 			'format': format,
-			'args': args,
-			'mask': re.sub('{(?P<n>[a-z,A-Z,0-9]*)}', '.*', format)
+			'args': args
 		}
 		if color:
 			sysvals.kprobes[name]['color'] = color
@@ -4670,44 +5013,45 @@ def printHelp():
 	print('')
 	print('Options:')
 	print('  [general]')
-	print('    -h          Print this help text')
-	print('    -v          Print the current tool version')
-	print('    -config file Pull arguments and config options from a file')
-	print('    -verbose    Print extra information during execution and analysis')
-	print('    -status     Test to see if the system is enabled to run this tool')
-	print('    -modes      List available suspend modes')
-	print('    -m mode     Mode to initiate for suspend %s (default: %s)') % (modes, sysvals.suspendmode)
-	print('    -o subdir   Override the output subdirectory')
+	print('   -h           Print this help text')
+	print('   -v           Print the current tool version')
+	print('   -config fn   Pull arguments and config options from file fn')
+	print('   -verbose     Print extra information during execution and analysis')
+	print('   -status      Test to see if the system is enabled to run this tool')
+	print('   -modes       List available suspend modes')
+	print('   -m mode      Mode to initiate for suspend %s (default: %s)') % (modes, sysvals.suspendmode)
+	print('   -o subdir    Override the output subdirectory')
+	print('   -rtcwake t   Use rtcwake to autoresume after <t> seconds (default: disabled)')
+	print('   -addlogs     Add the dmesg and ftrace logs to the html output')
+	print('   -srgap       Add a visible gap in the timeline between sus/res (default: disabled)')
 	print('  [advanced]')
-	print('    -rtcwake t  Use rtcwake to autoresume after <t> seconds (default: disabled)')
-	print('    -addlogs    Add the dmesg and ftrace logs to the html output')
-	print('    -multi n d  Execute <n> consecutive tests at <d> seconds intervals. The outputs will')
+	print('   -cmd {s}     Run the timeline over a custom command, e.g. "sync -d"')
+	print('   -proc        Add usermode process info into the timeline (default: disabled)')
+	print('   -dev         Add kernel function calls and threads to the timeline (default: disabled)')
+	print('   -x2          Run two suspend/resumes back to back (default: disabled)')
+	print('   -x2delay t   Include t ms delay between multiple test runs (default: 0 ms)')
+	print('   -predelay t  Include t ms delay before 1st suspend (default: 0 ms)')
+	print('   -postdelay t Include t ms delay after last resume (default: 0 ms)')
+	print('   -mindev ms   Discard all device blocks shorter than ms milliseconds (e.g. 0.001 for us)')
+	print('   -multi n d   Execute <n> consecutive tests at <d> seconds intervals. The outputs will')
 	print('                be created in a new subdirectory with a summary page.')
-	print('    -srgap      Add a visible gap in the timeline between sus/res (default: disabled)')
-	print('    -cmd {s}    Instead of suspend/resume, run a command, e.g. "sync -d"')
-	print('    -mindev ms  Discard all device blocks shorter than ms milliseconds (e.g. 0.001 for us)')
-	print('    -mincg  ms  Discard all callgraphs shorter than ms milliseconds (e.g. 0.001 for us)')
-	print('    -timeprec N Number of significant digits in timestamps (0:S, [3:ms], 6:us)')
 	print('  [debug]')
-	print('    -f          Use ftrace to create device callgraphs (default: disabled)')
-	print('    -expandcg   pre-expand the callgraph data in the html output (default: disabled)')
-	print('    -flist      Print the list of functions currently being captured in ftrace')
-	print('    -flistall   Print all functions capable of being captured in ftrace')
-	print('    -fadd file  Add functions to be graphed in the timeline from a list in a text file')
-	print('    -filter "d1 d2 ..." Filter out all but this list of device names')
-	print('    -dev        Display common low level functions in the timeline')
-	print('  [post-resume task analysis]')
-	print('    -x2         Run two suspend/resumes back to back (default: disabled)')
-	print('    -x2delay t  Minimum millisecond delay <t> between the two test runs (default: 0 ms)')
-	print('    -postres t  Time after resume completion to wait for post-resume events (default: 0 S)')
+	print('   -f           Use ftrace to create device callgraphs (default: disabled)')
+	print('   -expandcg    pre-expand the callgraph data in the html output (default: disabled)')
+	print('   -flist       Print the list of functions currently being captured in ftrace')
+	print('   -flistall    Print all functions capable of being captured in ftrace')
+	print('   -fadd file   Add functions to be graphed in the timeline from a list in a text file')
+	print('   -filter "d1,d2,..." Filter out all but this comma-delimited list of device names')
+	print('   -mincg  ms   Discard all callgraphs shorter than ms milliseconds (e.g. 0.001 for us)')
+	print('   -timeprec N  Number of significant digits in timestamps (0:S, [3:ms], 6:us)')
 	print('  [utilities]')
-	print('    -fpdt       Print out the contents of the ACPI Firmware Performance Data Table')
-	print('    -usbtopo    Print out the current USB topology with power info')
-	print('    -usbauto    Enable autosuspend for all connected USB devices')
+	print('   -fpdt        Print out the contents of the ACPI Firmware Performance Data Table')
+	print('   -usbtopo     Print out the current USB topology with power info')
+	print('   -usbauto     Enable autosuspend for all connected USB devices')
 	print('  [re-analyze data from previous runs]')
-	print('    -ftrace ftracefile  Create HTML output using ftrace input')
-	print('    -dmesg dmesgfile    Create HTML output using dmesg (not needed for kernel >= 3.15)')
-	print('    -summary directory  Create a summary of all test in this dir')
+	print('   -ftrace ftracefile  Create HTML output using ftrace input')
+	print('   -dmesg dmesgfile    Create HTML output using dmesg (not needed for kernel >= 3.15)')
+	print('   -summary directory  Create a summary of all test in this dir')
 	print('')
 	return True
 
@@ -4739,26 +5083,22 @@ if __name__ == '__main__':
 			sys.exit()
 		elif(arg == '-x2'):
 			sysvals.execcount = 2
-			if(sysvals.usecallgraph):
-				doError('-x2 is not compatible with -f', False)
 		elif(arg == '-x2delay'):
 			sysvals.x2delay = getArgInt('-x2delay', args, 0, 60000)
-		elif(arg == '-postres'):
-			sysvals.postresumetime = getArgInt('-postres', args, 0, 3600)
+		elif(arg == '-predelay'):
+			sysvals.predelay = getArgInt('-predelay', args, 0, 60000)
+		elif(arg == '-postdelay'):
+			sysvals.postdelay = getArgInt('-postdelay', args, 0, 60000)
 		elif(arg == '-f'):
 			sysvals.usecallgraph = True
-			if(sysvals.execcount > 1):
-				doError('-x2 is not compatible with -f', False)
-			if(sysvals.usedevsrc):
-				doError('-dev is not compatible with -f', False)
 		elif(arg == '-addlogs'):
 			sysvals.addlogs = True
 		elif(arg == '-verbose'):
 			sysvals.verbose = True
+		elif(arg == '-proc'):
+			sysvals.useprocmon = True
 		elif(arg == '-dev'):
 			sysvals.usedevsrc = True
-			if(sysvals.usecallgraph):
-				doError('-dev is not compatible with -f', False)
 		elif(arg == '-rtcwake'):
 			sysvals.rtcwake = True
 			sysvals.rtcwaketime = getArgInt('-rtcwake', args, 0, 3600)
@@ -4788,7 +5128,7 @@ if __name__ == '__main__':
 				val = args.next()
 			except:
 				doError('No subdirectory name supplied', True)
-			sysvals.outdir = val
+			sysvals.setOutputFolder(val)
 		elif(arg == '-config'):
 			try:
 				val = args.next()
@@ -4842,6 +5182,14 @@ if __name__ == '__main__':
 		else:
 			doError('Invalid argument: '+arg, True)
 
+	# compatibility errors
+	if(sysvals.usecallgraph and sysvals.execcount > 1):
+		doError('-x2 is not compatible with -f', False)
+	if(sysvals.usecallgraph and sysvals.usedevsrc):
+		doError('-dev is not compatible with -f', False)
+	if(sysvals.usecallgraph and sysvals.useprocmon):
+		doError('-proc is not compatible with -f', False)
+
 	# callgraph size cannot exceed device size
 	if sysvals.mincglen < sysvals.mindevlen:
 		sysvals.mincglen = sysvals.mindevlen
-- 
2.1.4

