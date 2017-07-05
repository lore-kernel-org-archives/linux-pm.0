From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 1/3] pm-graph: AnalyzeSuspend v4.7
Date: Wed,  5 Jul 2017 14:42:55 -0700
Message-ID: <7267bdd45b88058e46331f4f63a03d349f57be2b.1499290431.git.todd.e.brandt@linux.intel.com>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58554 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751896AbdGEVnC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jul 2017 17:43:02 -0400
In-Reply-To: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

- changed -rtcwake parameter to be on & 15 sec by default,
  to disable rtcwake use: "-rtcwake off"
- changed behavior of -o: renames html file on rerun, subdir on new run
- changed execution_misalignment error to missing_function_name
- add sysinfo to logs and timeline via a custom dmidecode call
  it supplants dmidecode tool when used as a library call
- add -sysinfo command, displays dmidecode values and cpu/mem info
- set trace buffer size to lesser of memtotal/2 or 2GB when using callgraph
- add support for /sys/power/mem_sleep. if mem_sleep found:
  mem-shallow=standby, mem-s2idle=freeze, mem-deep=mem
- remove redundant javascript
- cosmetic changes to html layout

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/analyze_suspend.py | 534 +++++++++++++++++++++++---------
 1 file changed, 379 insertions(+), 155 deletions(-)

diff --git a/tools/power/pm-graph/analyze_suspend.py b/tools/power/pm-graph/analyze_suspend.py
index a9206e67fc1f..1b60fe203741 100755
--- a/tools/power/pm-graph/analyze_suspend.py
+++ b/tools/power/pm-graph/analyze_suspend.py
@@ -68,10 +68,12 @@ from subprocess import call, Popen, PIPE
 #	 store system values and test parameters
 class SystemValues:
 	title = 'SleepGraph'
-	version = '4.6'
+	version = '4.7'
 	ansi = False
 	verbose = False
-	addlogs = False
+	testlog = True
+	dmesglog = False
+	ftracelog = False
 	mindevlen = 0.0
 	mincglen = 0.0
 	cgphase = ''
@@ -79,10 +81,11 @@ class SystemValues:
 	max_graph_depth = 0
 	callloopmaxgap = 0.0001
 	callloopmaxlen = 0.005
+	cpucount = 0
+	memtotal = 204800
 	srgap = 0
 	cgexp = False
-	outdir = ''
-	testdir = '.'
+	testdir = ''
 	tpath = '/sys/kernel/debug/tracing/'
 	fpdtpath = '/sys/firmware/acpi/tables/FPDT'
 	epath = '/sys/kernel/debug/tracing/events/power/'
@@ -95,14 +98,17 @@ class SystemValues:
 	testcommand = ''
 	mempath = '/dev/mem'
 	powerfile = '/sys/power/state'
+	mempowerfile = '/sys/power/mem_sleep'
 	suspendmode = 'mem'
+	memmode = ''
 	hostname = 'localhost'
 	prefix = 'test'
 	teststamp = ''
+	sysstamp = ''
 	dmesgstart = 0.0
 	dmesgfile = ''
 	ftracefile = ''
-	htmlfile = ''
+	htmlfile = 'output.html'
 	embedded = False
 	rtcwake = True
 	rtcwaketime = 15
@@ -127,9 +133,6 @@ class SystemValues:
 	devpropfmt = '# Device Properties: .*'
 	tracertypefmt = '# tracer: (?P<t>.*)'
 	firmwarefmt = '# fwsuspend (?P<s>[0-9]*) fwresume (?P<r>[0-9]*)$'
-	stampfmt = '# suspend-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
-				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
-				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
 	tracefuncs = {
 		'sys_sync': dict(),
 		'pm_prepare_console': dict(),
@@ -218,7 +221,7 @@ class SystemValues:
 		# if this is a phoronix test run, set some default options
 		if('LOG_FILE' in os.environ and 'TEST_RESULTS_IDENTIFIER' in os.environ):
 			self.embedded = True
-			self.addlogs = True
+			self.dmesglog = self.ftracelog = True
 			self.htmlfile = os.environ['LOG_FILE']
 		self.archargs = 'args_'+platform.machine()
 		self.hostname = platform.node()
@@ -233,6 +236,13 @@ class SystemValues:
 			self.rtcpath = rtc
 		if (hasattr(sys.stdout, 'isatty') and sys.stdout.isatty()):
 			self.ansi = True
+		self.testdir = datetime.now().strftime('suspend-%y%m%d-%H%M%S')
+	def rootCheck(self, fatal=True):
+		if(os.access(self.powerfile, os.W_OK)):
+			return True
+		if fatal:
+			doError('This command requires sysfs mount and root access')
+		return False
 	def rootUser(self, fatal=False):
 		if 'USER' in os.environ and os.environ['USER'] == 'root':
 			return True
@@ -249,30 +259,60 @@ class SystemValues:
 		args['date'] = n.strftime('%y%m%d')
 		args['time'] = n.strftime('%H%M%S')
 		args['hostname'] = self.hostname
-		self.outdir = value.format(**args)
+		return value.format(**args)
 	def setOutputFile(self):
-		if((self.htmlfile == '') and (self.dmesgfile != '')):
+		if self.dmesgfile != '':
 			m = re.match('(?P<name>.*)_dmesg\.txt$', self.dmesgfile)
 			if(m):
 				self.htmlfile = m.group('name')+'.html'
-		if((self.htmlfile == '') and (self.ftracefile != '')):
+		if self.ftracefile != '':
 			m = re.match('(?P<name>.*)_ftrace\.txt$', self.ftracefile)
 			if(m):
 				self.htmlfile = m.group('name')+'.html'
-		if(self.htmlfile == ''):
-			self.htmlfile = 'output.html'
-	def initTestOutput(self, subdir, testpath=''):
+	def systemInfo(self, info):
+		p = c = m = b = ''
+		if 'baseboard-manufacturer' in info:
+			m = info['baseboard-manufacturer']
+		elif 'system-manufacturer' in info:
+			m = info['system-manufacturer']
+		if 'baseboard-product-name' in info:
+			p = info['baseboard-product-name']
+		elif 'system-product-name' in info:
+			p = info['system-product-name']
+		if 'processor-version' in info:
+			c = info['processor-version']
+		if 'bios-version' in info:
+			b = info['bios-version']
+		self.sysstamp = '# sysinfo | man:%s | plat:%s | cpu:%s | bios:%s | numcpu:%d | memsz:%d' % \
+			(m, p, c, b, self.cpucount, self.memtotal)
+	def printSystemInfo(self):
+		self.rootCheck(True)
+		out = dmidecode(self.mempath, True)
+		fmt = '%-24s: %s'
+		for name in sorted(out):
+			print fmt % (name, out[name])
+		print fmt % ('cpucount', ('%d' % self.cpucount))
+		print fmt % ('memtotal', ('%d kB' % self.memtotal))
+	def cpuInfo(self):
+		self.cpucount = 0
+		fp = open('/proc/cpuinfo', 'r')
+		for line in fp:
+			if re.match('^processor[ \t]*:[ \t]*[0-9]*', line):
+				self.cpucount += 1
+		fp.close()
+		fp = open('/proc/meminfo', 'r')
+		for line in fp:
+			m = re.match('^MemTotal:[ \t]*(?P<sz>[0-9]*) *kB', line)
+			if m:
+				self.memtotal = int(m.group('sz'))
+				break
+		fp.close()
+	def initTestOutput(self, name):
 		self.prefix = self.hostname
 		v = open('/proc/version', 'r').read().strip()
 		kver = string.split(v)[2]
-		n = datetime.now()
-		testtime = n.strftime('suspend-%m%d%y-%H%M%S')
-		if not testpath:
-			testpath = n.strftime('suspend-%y%m%d-%H%M%S')
-		if(subdir != "."):
-			self.testdir = subdir+"/"+testpath
-		else:
-			self.testdir = testpath
+		fmt = name+'-%m%d%y-%H%M%S'
+		testtime = datetime.now().strftime(fmt)
 		self.teststamp = \
 			'# '+testtime+' '+self.prefix+' '+self.suspendmode+' '+kver
 		if(self.embedded):
@@ -355,7 +395,7 @@ class SystemValues:
 				continue
 			self.tracefuncs[i] = dict()
 	def getFtraceFilterFunctions(self, current):
-		rootCheck(True)
+		self.rootCheck(True)
 		if not current:
 			call('cat '+self.tpath+'available_filter_functions', shell=True)
 			return
@@ -453,7 +493,7 @@ class SystemValues:
 		val += '\nr:%s_ret %s $retval\n' % (name, func)
 		return val
 	def addKprobes(self, output=False):
-		if len(sysvals.kprobes) < 1:
+		if len(self.kprobes) < 1:
 			return
 		if output:
 			print('    kprobe functions in this kernel:')
@@ -525,7 +565,7 @@ class SystemValues:
 			fp.flush()
 			fp.close()
 		except:
-			pass
+			return False
 		return True
 	def fgetVal(self, path):
 		file = self.tpath+path
@@ -566,9 +606,15 @@ class SystemValues:
 		self.cleanupFtrace()
 		# set the trace clock to global
 		self.fsetVal('global', 'trace_clock')
-		# set trace buffer to a huge value
 		self.fsetVal('nop', 'current_tracer')
-		self.fsetVal('131073', 'buffer_size_kb')
+		# set trace buffer to a huge value
+		if self.usecallgraph or self.usedevsrc:
+			tgtsize = min(self.memtotal / 2, 2*1024*1024)
+			maxbuf = '%d' % (tgtsize / max(1, self.cpucount))
+			if self.cpucount < 1 or not self.fsetVal(maxbuf, 'buffer_size_kb'):
+				self.fsetVal('131072', 'buffer_size_kb')
+		else:
+			self.fsetVal('16384', 'buffer_size_kb')
 		# go no further if this is just a status check
 		if testing:
 			return
@@ -641,6 +687,15 @@ class SystemValues:
 		if not self.ansi:
 			return str
 		return '\x1B[%d;40m%s\x1B[m' % (color, str)
+	def writeDatafileHeader(self, filename, fwdata=[]):
+		fp = open(filename, 'w')
+		fp.write(self.teststamp+'\n')
+		fp.write(self.sysstamp+'\n')
+		if(self.suspendmode == 'mem' or self.suspendmode == 'command'):
+			for fw in fwdata:
+				if(fw):
+					fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
+		fp.close()
 
 sysvals = SystemValues()
 suspendmodename = {
@@ -1008,6 +1063,12 @@ class Data:
 			else:
 				self.trimTime(self.tSuspended, \
 					self.tResumed-self.tSuspended, False)
+	def getTimeValues(self):
+		sktime = (self.dmesg['suspend_machine']['end'] - \
+			self.tKernSus) * 1000
+		rktime = (self.dmesg['resume_complete']['end'] - \
+			self.dmesg['resume_machine']['start']) * 1000
+		return (sktime, rktime)
 	def setPhase(self, phase, ktime, isbegin):
 		if(isbegin):
 			self.dmesg[phase]['start'] = ktime
@@ -1517,7 +1578,7 @@ class FTraceCallGraph:
 			prelinedep += 1
 		last = 0
 		lasttime = line.time
-		virtualfname = 'execution_misalignment'
+		virtualfname = 'missing_function_name'
 		if len(self.list) > 0:
 			last = self.list[-1]
 			lasttime = last.time
@@ -1773,24 +1834,30 @@ class Timeline:
 	html_device = '<div id="{0}" title="{1}" class="thread{7}" style="left:{2}%;top:{3}px;height:{4}px;width:{5}%;{8}">{6}</div>\n'
 	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}px;height:{3}px;background:{4}">{5}</div>\n'
 	html_phaselet = '<div id="{0}" class="phaselet" style="left:{1}%;width:{2}%;background:{3}"></div>\n'
+	html_legend = '<div id="p{3}" class="square" style="left:{0}%;background:{1}">&nbsp;{2}</div>\n'
 	def __init__(self, rowheight, scaleheight):
 		self.rowH = rowheight
 		self.scaleH = scaleheight
 		self.html = ''
-	def createHeader(self, sv, suppress=''):
+	def createHeader(self, sv):
 		if(not sv.stamp['time']):
 			return
 		self.html += '<div class="version"><a href="https://01.org/suspendresume">%s v%s</a></div>' \
 			% (sv.title, sv.version)
-		if sv.logmsg and 'log' not in suppress:
-			self.html += '<button id="showtest" class="logbtn">log</button>'
-		if sv.addlogs and 'dmesg' not in suppress:
-			self.html += '<button id="showdmesg" class="logbtn">dmesg</button>'
-		if sv.addlogs and sv.ftracefile and 'ftrace' not in suppress:
-			self.html += '<button id="showftrace" class="logbtn">ftrace</button>'
+		if sv.logmsg and sv.testlog:
+			self.html += '<button id="showtest" class="logbtn btnfmt">log</button>'
+		if sv.dmesglog:
+			self.html += '<button id="showdmesg" class="logbtn btnfmt">dmesg</button>'
+		if sv.ftracelog:
+			self.html += '<button id="showftrace" class="logbtn btnfmt">ftrace</button>'
 		headline_stamp = '<div class="stamp">{0} {1} {2} {3}</div>\n'
 		self.html += headline_stamp.format(sv.stamp['host'], sv.stamp['kernel'],
 			sv.stamp['mode'], sv.stamp['time'])
+		if 'man' in sv.stamp and 'plat' in sv.stamp and 'cpu' in sv.stamp:
+			headline_sysinfo = '<div class="stamp sysinfo">{0} {1} <i>with</i> {2}</div>\n'
+			self.html += headline_sysinfo.format(sv.stamp['man'],
+				sv.stamp['plat'], sv.stamp['cpu'])
+
 	# Function: getDeviceRows
 	# Description:
 	#    determine how may rows the device funcs will take
@@ -1839,7 +1906,7 @@ class Timeline:
 	#	 devlist: the list of devices/actions in a group of contiguous phases
 	# Output:
 	#	 The total number of rows needed to display this phase of the timeline
-	def getPhaseRows(self, devlist, row=0):
+	def getPhaseRows(self, devlist, row=0, sortby='length'):
 		# clear all rows and set them to undefined
 		remaining = len(devlist)
 		rowdata = dict()
@@ -1852,8 +1919,12 @@ class Timeline:
 			if tp not in myphases:
 				myphases.append(tp)
 			dev['row'] = -1
-			# sort by length 1st, then name 2nd
-			sortdict[item] = (float(dev['end']) - float(dev['start']), item.dev['name'])
+			if sortby == 'start':
+				# sort by start 1st, then length 2nd
+				sortdict[item] = (-1*float(dev['start']), float(dev['end']) - float(dev['start']))
+			else:
+				# sort by length 1st, then name 2nd
+				sortdict[item] = (float(dev['end']) - float(dev['start']), item.dev['name'])
 			if 'src' in dev:
 				dev['devrows'] = self.getDeviceRows(dev['src'])
 		# sort the devlist by length so that large items graph on top
@@ -1995,8 +2066,13 @@ class Timeline:
 #	 A list of values describing the properties of these test runs
 class TestProps:
 	stamp = ''
+	sysinfo = ''
 	S0i3 = False
 	fwdata = []
+	stampfmt = '# [a-z]*-(?P<m>[0-9]{2})(?P<d>[0-9]{2})(?P<y>[0-9]{2})-'+\
+				'(?P<H>[0-9]{2})(?P<M>[0-9]{2})(?P<S>[0-9]{2})'+\
+				' (?P<host>.*) (?P<mode>.*) (?P<kernel>.*)$'
+	sysinfofmt = '^# sysinfo .*'
 	ftrace_line_fmt_fg = \
 		'^ *(?P<time>[0-9\.]*) *\| *(?P<cpu>[0-9]*)\)'+\
 		' *(?P<proc>.*)-(?P<pid>[0-9]*) *\|'+\
@@ -2019,6 +2095,36 @@ class TestProps:
 			self.ftrace_line_fmt = self.ftrace_line_fmt_nop
 		else:
 			doError('Invalid tracer format: [%s]' % tracer)
+	def parseStamp(self, data, sv):
+		m = re.match(self.stampfmt, self.stamp)
+		data.stamp = {'time': '', 'host': '', 'mode': ''}
+		dt = datetime(int(m.group('y'))+2000, int(m.group('m')),
+			int(m.group('d')), int(m.group('H')), int(m.group('M')),
+			int(m.group('S')))
+		data.stamp['time'] = dt.strftime('%B %d %Y, %I:%M:%S %p')
+		data.stamp['host'] = m.group('host')
+		data.stamp['mode'] = m.group('mode')
+		data.stamp['kernel'] = m.group('kernel')
+		if re.match(self.sysinfofmt, self.sysinfo):
+			for f in self.sysinfo.split('|'):
+				if '#' in f:
+					continue
+				tmp = f.strip().split(':', 1)
+				key = tmp[0]
+				val = tmp[1]
+				data.stamp[key] = val
+		sv.hostname = data.stamp['host']
+		sv.suspendmode = data.stamp['mode']
+		if sv.suspendmode == 'command' and sv.ftracefile != '':
+			modes = ['on', 'freeze', 'standby', 'mem']
+			out = Popen(['grep', 'suspend_enter', sv.ftracefile],
+				stderr=PIPE, stdout=PIPE).stdout.read()
+			m = re.match('.* suspend_enter\[(?P<mode>.*)\]', out)
+			if m and m.group('mode') in ['1', '2', '3']:
+				sv.suspendmode = modes[int(m.group('mode'))]
+				data.stamp['mode'] = sv.suspendmode
+		if not sv.stamp:
+			sv.stamp = data.stamp
 
 # Class: TestRun
 # Description:
@@ -2090,35 +2196,6 @@ def vprint(msg):
 	if(sysvals.verbose):
 		print(msg)
 
-# Function: parseStamp
-# Description:
-#	 Pull in the stamp comment line from the data file(s),
-#	 create the stamp, and add it to the global sysvals object
-# Arguments:
-#	 m: the valid re.match output for the stamp line
-def parseStamp(line, data):
-	m = re.match(sysvals.stampfmt, line)
-	data.stamp = {'time': '', 'host': '', 'mode': ''}
-	dt = datetime(int(m.group('y'))+2000, int(m.group('m')),
-		int(m.group('d')), int(m.group('H')), int(m.group('M')),
-		int(m.group('S')))
-	data.stamp['time'] = dt.strftime('%B %d %Y, %I:%M:%S %p')
-	data.stamp['host'] = m.group('host')
-	data.stamp['mode'] = m.group('mode')
-	data.stamp['kernel'] = m.group('kernel')
-	sysvals.hostname = data.stamp['host']
-	sysvals.suspendmode = data.stamp['mode']
-	if sysvals.suspendmode == 'command' and sysvals.ftracefile != '':
-		modes = ['on', 'freeze', 'standby', 'mem']
-		out = Popen(['grep', 'suspend_enter', sysvals.ftracefile],
-			stderr=PIPE, stdout=PIPE).stdout.read()
-		m = re.match('.* suspend_enter\[(?P<mode>.*)\]', out)
-		if m and m.group('mode') in ['1', '2', '3']:
-			sysvals.suspendmode = modes[int(m.group('mode'))]
-			data.stamp['mode'] = sysvals.suspendmode
-	if not sysvals.stamp:
-		sysvals.stamp = data.stamp
-
 # Function: doesTraceLogHaveTraceEvents
 # Description:
 #	 Quickly determine if the ftrace log has some or all of the trace events
@@ -2136,11 +2213,6 @@ def doesTraceLogHaveTraceEvents():
 		sysvals.usekprobes = True
 	out = Popen(['head', '-1', sysvals.ftracefile],
 		stderr=PIPE, stdout=PIPE).stdout.read().replace('\n', '')
-	m = re.match(sysvals.stampfmt, out)
-	if m and m.group('mode') == 'command':
-		sysvals.usetraceeventsonly = True
-		sysvals.usetraceevents = True
-		return
 	# figure out what level of trace events are supported
 	sysvals.usetraceeventsonly = True
 	sysvals.usetraceevents = False
@@ -2182,11 +2254,13 @@ def appendIncompleteTraceLog(testruns):
 	for line in tf:
 		# remove any latent carriage returns
 		line = line.replace('\r\n', '')
-		# grab the time stamp
-		m = re.match(sysvals.stampfmt, line)
-		if(m):
+		# grab the stamp and sysinfo
+		if re.match(tp.stampfmt, line):
 			tp.stamp = line
 			continue
+		elif re.match(tp.sysinfofmt, line):
+			tp.sysinfo = line
+			continue
 		# determine the trace data type (required for further parsing)
 		m = re.match(sysvals.tracertypefmt, line)
 		if(m):
@@ -2219,7 +2293,7 @@ def appendIncompleteTraceLog(testruns):
 		# look for the suspend start marker
 		if(t.startMarker()):
 			data = testrun[testidx].data
-			parseStamp(tp.stamp, data)
+			tp.parseStamp(data, sysvals)
 			data.setStart(t.time)
 			continue
 		if(not data):
@@ -2389,11 +2463,13 @@ def parseTraceLog():
 	for line in tf:
 		# remove any latent carriage returns
 		line = line.replace('\r\n', '')
-		# stamp line: each stamp means a new test run
-		m = re.match(sysvals.stampfmt, line)
-		if(m):
+		# stamp and sysinfo lines
+		if re.match(tp.stampfmt, line):
 			tp.stamp = line
 			continue
+		elif re.match(tp.sysinfofmt, line):
+			tp.sysinfo = line
+			continue
 		# firmware line: pull out any firmware data
 		m = re.match(sysvals.firmwarefmt, line)
 		if(m):
@@ -2439,7 +2515,7 @@ def parseTraceLog():
 			testdata.append(data)
 			testrun = TestRun(data)
 			testruns.append(testrun)
-			parseStamp(tp.stamp, data)
+			tp.parseStamp(data, sysvals)
 			data.setStart(t.time)
 			data.tKernSus = t.time
 			continue
@@ -2820,10 +2896,13 @@ def loadKernelLog(justtext=False):
 		idx = line.find('[')
 		if idx > 1:
 			line = line[idx:]
-		m = re.match(sysvals.stampfmt, line)
-		if(m):
+		# grab the stamp and sysinfo
+		if re.match(tp.stampfmt, line):
 			tp.stamp = line
 			continue
+		elif re.match(tp.sysinfofmt, line):
+			tp.sysinfo = line
+			continue
 		m = re.match(sysvals.firmwarefmt, line)
 		if(m):
 			tp.fwdata.append((int(m.group('s')), int(m.group('r'))))
@@ -2839,7 +2918,7 @@ def loadKernelLog(justtext=False):
 			if(data):
 				testruns.append(data)
 			data = Data(len(testruns))
-			parseStamp(tp.stamp, data)
+			tp.parseStamp(data, sysvals)
 			if len(tp.fwdata) > data.testnumber:
 				data.fwSuspend, data.fwResume = tp.fwdata[data.testnumber]
 				if(data.fwSuspend > 0 or data.fwResume > 0):
@@ -3170,6 +3249,8 @@ def addCallgraphs(sv, hf, data):
 			continue
 		list = data.dmesg[p]['list']
 		for devname in data.sortedDevices(p):
+			if len(sv.devicefilter) > 0 and devname not in sv.devicefilter:
+				continue
 			dev = list[devname]
 			color = 'white'
 			if 'color' in data.dmesg[p]:
@@ -3309,7 +3390,6 @@ def createHTML(testruns):
 	html_error = '<div id="{1}" title="kernel error/warning" class="err" style="right:{0}%">ERROR&rarr;</div>\n'
 	html_traceevent = '<div title="{0}" class="traceevent{6}" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;{7}">{5}</div>\n'
 	html_cpuexec = '<div class="jiffie" style="left:{0}%;top:{1}px;height:{2}px;width:{3}%;background:{4};"></div>\n'
-	html_legend = '<div id="p{3}" class="square" style="left:{0}%;background:{1}">&nbsp;{2}</div>\n'
 	html_timetotal = '<table class="time1">\n<tr>'\
 		'<td class="green" title="{3}">{2} Suspend Time: <b>{0} ms</b></td>'\
 		'<td class="yellow" title="{4}">{2} Resume Time: <b>{1} ms</b></td>'\
@@ -3346,10 +3426,7 @@ def createHTML(testruns):
 	# Generate the header for this timeline
 	for data in testruns:
 		tTotal = data.end - data.start
-		sktime = (data.dmesg['suspend_machine']['end'] - \
-			data.tKernSus) * 1000
-		rktime = (data.dmesg['resume_complete']['end'] - \
-			data.dmesg['resume_machine']['start']) * 1000
+		sktime, rktime = data.getTimeValues()
 		if(tTotal == 0):
 			print('ERROR: No timeline data')
 			sys.exit()
@@ -3581,7 +3658,7 @@ def createHTML(testruns):
 				id += tmp[1][0]
 			order = '%.2f' % ((data.dmesg[phase]['order'] * pdelta) + pmargin)
 			name = string.replace(phase, '_', ' &nbsp;')
-			devtl.html += html_legend.format(order, \
+			devtl.html += devtl.html_legend.format(order, \
 				data.dmesg[phase]['color'], name, id)
 		devtl.html += '</div>\n'
 
@@ -3628,10 +3705,10 @@ def createHTML(testruns):
 		addCallgraphs(sysvals, hf, data)
 
 	# add the test log as a hidden div
-	if sysvals.logmsg:
+	if sysvals.testlog and sysvals.logmsg:
 		hf.write('<div id="testlog" style="display:none;">\n'+sysvals.logmsg+'</div>\n')
 	# add the dmesg log as a hidden div
-	if sysvals.addlogs and sysvals.dmesgfile:
+	if sysvals.dmesglog and sysvals.dmesgfile:
 		hf.write('<div id="dmesglog" style="display:none;">\n')
 		lf = open(sysvals.dmesgfile, 'r')
 		for line in lf:
@@ -3640,7 +3717,7 @@ def createHTML(testruns):
 		lf.close()
 		hf.write('</div>\n')
 	# add the ftrace log as a hidden div
-	if sysvals.addlogs and sysvals.ftracefile:
+	if sysvals.ftracelog and sysvals.ftracefile:
 		hf.write('<div id="ftracelog" style="display:none;">\n')
 		lf = open(sysvals.ftracefile, 'r')
 		for line in lf:
@@ -3701,6 +3778,7 @@ def addCSS(hf, sv, testcount=1, kerror=False, extra=''):
 	<style type=\'text/css\'>\n\
 		body {overflow-y:scroll;}\n\
 		.stamp {width:100%;text-align:center;background:gray;line-height:30px;color:white;font:25px Arial;}\n\
+		.stamp.sysinfo {font:10px Arial;}\n\
 		.callgraph {margin-top:30px;box-shadow:5px 5px 20px black;}\n\
 		.callgraph article * {padding-left:28px;}\n\
 		h1 {color:black;font:bold 30px Times;}\n\
@@ -3746,7 +3824,7 @@ def addCSS(hf, sv, testcount=1, kerror=False, extra=''):
 		.legend {position:relative; width:100%; height:40px; text-align:center;margin-bottom:20px}\n\
 		.legend .square {position:absolute;cursor:pointer;top:10px; width:0px;height:20px;border:1px solid;padding-left:20px;}\n\
 		button {height:40px;width:200px;margin-bottom:20px;margin-top:20px;font-size:24px;}\n\
-		.logbtn {position:relative;float:right;height:25px;width:50px;margin-top:3px;margin-bottom:0;font-size:10px;text-align:center;}\n\
+		.btnfmt {position:relative;float:right;height:25px;width:auto;margin-top:3px;margin-bottom:0;font-size:10px;text-align:center;}\n\
 		.devlist {position:'+devlistpos+';width:190px;}\n\
 		a:link {color:white;text-decoration:none;}\n\
 		a:visited {color:white;}\n\
@@ -4084,8 +4162,6 @@ def addScriptCode(hf, testruns):
 	'		win.document.write(title+"<pre>"+log.innerHTML+"</pre>");\n'\
 	'		win.document.close();\n'\
 	'	}\n'\
-	'	function onClickPhase(e) {\n'\
-	'	}\n'\
 	'	function onMouseDown(e) {\n'\
 	'		dragval[0] = e.clientX;\n'\
 	'		dragval[1] = document.getElementById("dmesgzoombox").scrollLeft;\n'\
@@ -4120,9 +4196,6 @@ def addScriptCode(hf, testruns):
 	'		document.getElementById("zoomin").onclick = zoomTimeline;\n'\
 	'		document.getElementById("zoomout").onclick = zoomTimeline;\n'\
 	'		document.getElementById("zoomdef").onclick = zoomTimeline;\n'\
-	'		var list = document.getElementsByClassName("square");\n'\
-	'		for (var i = 0; i < list.length; i++)\n'\
-	'			list[i].onclick = onClickPhase;\n'\
 	'		var list = document.getElementsByClassName("err");\n'\
 	'		for (var i = 0; i < list.length; i++)\n'\
 	'			list[i].onclick = errWindow;\n'\
@@ -4193,8 +4266,14 @@ def executeSuspend():
 		if sysvals.testcommand != '':
 			call(sysvals.testcommand+' 2>&1', shell=True);
 		else:
+			mode = sysvals.suspendmode
+			if sysvals.memmode and os.path.exists(sysvals.mempowerfile):
+				mode = 'mem'
+				pf = open(sysvals.mempowerfile, 'w')
+				pf.write(sysvals.memmode)
+				pf.close()
 			pf = open(sysvals.powerfile, 'w')
-			pf.write(sysvals.suspendmode)
+			pf.write(mode)
 			# execution will pause here
 			try:
 				pf.close()
@@ -4219,24 +4298,15 @@ def executeSuspend():
 			pm.stop()
 		sysvals.fsetVal('0', 'tracing_on')
 		print('CAPTURING TRACE')
-		writeDatafileHeader(sysvals.ftracefile, fwdata)
+		sysvals.writeDatafileHeader(sysvals.ftracefile, fwdata)
 		call('cat '+tp+'trace >> '+sysvals.ftracefile, shell=True)
 		sysvals.fsetVal('', 'trace')
 		devProps()
 	# grab a copy of the dmesg output
 	print('CAPTURING DMESG')
-	writeDatafileHeader(sysvals.dmesgfile, fwdata)
+	sysvals.writeDatafileHeader(sysvals.dmesgfile, fwdata)
 	sysvals.getdmesg()
 
-def writeDatafileHeader(filename, fwdata):
-	fp = open(filename, 'a')
-	fp.write(sysvals.teststamp+'\n')
-	if(sysvals.suspendmode == 'mem' or sysvals.suspendmode == 'command'):
-		for fw in fwdata:
-			if(fw):
-				fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
-	fp.close()
-
 # Function: setUSBDevicesAuto
 # Description:
 #	 Set the autosuspend control parameter of all USB devices to auto
@@ -4244,7 +4314,7 @@ def writeDatafileHeader(filename, fwdata):
 #	 to always-on since the kernel cant determine if the device can
 #	 properly autosuspend
 def setUSBDevicesAuto():
-	rootCheck(True)
+	sysvals.rootCheck(True)
 	for dirname, dirnames, filenames in os.walk('/sys/devices'):
 		if(re.match('.*/usb[0-9]*.*', dirname) and
 			'idVendor' in filenames and 'idProduct' in filenames):
@@ -4467,13 +4537,146 @@ def devProps(data=0):
 # Output:
 #	 A string list of the available modes
 def getModes():
-	modes = ''
+	modes = []
 	if(os.path.exists(sysvals.powerfile)):
 		fp = open(sysvals.powerfile, 'r')
 		modes = string.split(fp.read())
 		fp.close()
+	if(os.path.exists(sysvals.mempowerfile)):
+		deep = False
+		fp = open(sysvals.mempowerfile, 'r')
+		for m in string.split(fp.read()):
+			memmode = m.strip('[]')
+			if memmode == 'deep':
+				deep = True
+			else:
+				modes.append('mem-%s' % memmode)
+		fp.close()
+		if 'mem' in modes and not deep:
+			modes.remove('mem')
 	return modes
 
+# Function: dmidecode
+# Description:
+#	 Read the bios tables and pull out system info
+# Arguments:
+#	 mempath: /dev/mem or custom mem path
+#	 fatal: True to exit on error, False to return empty dict
+# Output:
+#	 A dict object with all available key/values
+def dmidecode(mempath, fatal=False):
+	out = dict()
+
+	# the list of values to retrieve, with hardcoded (type, idx)
+	info = {
+		'bios-vendor': (0, 4),
+		'bios-version': (0, 5),
+		'bios-release-date': (0, 8),
+		'system-manufacturer': (1, 4),
+		'system-product-name': (1, 5),
+		'system-version': (1, 6),
+		'system-serial-number': (1, 7),
+		'baseboard-manufacturer': (2, 4),
+		'baseboard-product-name': (2, 5),
+		'baseboard-version': (2, 6),
+		'baseboard-serial-number': (2, 7),
+		'chassis-manufacturer': (3, 4),
+		'chassis-type': (3, 5),
+		'chassis-version': (3, 6),
+		'chassis-serial-number': (3, 7),
+		'processor-manufacturer': (4, 7),
+		'processor-version': (4, 16),
+	}
+	if(not os.path.exists(mempath)):
+		if(fatal):
+			doError('file does not exist: %s' % mempath)
+		return out
+	if(not os.access(mempath, os.R_OK)):
+		if(fatal):
+			doError('file is not readable: %s' % mempath)
+		return out
+
+	# by default use legacy scan, but try to use EFI first
+	memaddr = 0xf0000
+	memsize = 0x10000
+	for ep in ['/sys/firmware/efi/systab', '/proc/efi/systab']:
+		if not os.path.exists(ep) or not os.access(ep, os.R_OK):
+			continue
+		fp = open(ep, 'r')
+		buf = fp.read()
+		fp.close()
+		i = buf.find('SMBIOS=')
+		if i >= 0:
+			try:
+				memaddr = int(buf[i+7:], 16)
+				memsize = 0x20
+			except:
+				continue
+
+	# read in the memory for scanning
+	fp = open(mempath, 'rb')
+	try:
+		fp.seek(memaddr)
+		buf = fp.read(memsize)
+	except:
+		if(fatal):
+			doError('DMI table is unreachable, sorry')
+		else:
+			return out
+	fp.close()
+
+	# search for either an SM table or DMI table
+	i = base = length = num = 0
+	while(i < memsize):
+		if buf[i:i+4] == '_SM_' and i < memsize - 16:
+			length = struct.unpack('H', buf[i+22:i+24])[0]
+			base, num = struct.unpack('IH', buf[i+24:i+30])
+			break
+		elif buf[i:i+5] == '_DMI_':
+			length = struct.unpack('H', buf[i+6:i+8])[0]
+			base, num = struct.unpack('IH', buf[i+8:i+14])
+			break
+		i += 16
+	if base == 0 and length == 0 and num == 0:
+		if(fatal):
+			doError('Neither SMBIOS nor DMI were found')
+		else:
+			return out
+
+	# read in the SM or DMI table
+	fp = open(mempath, 'rb')
+	try:
+		fp.seek(base)
+		buf = fp.read(length)
+	except:
+		if(fatal):
+			doError('DMI table is unreachable, sorry')
+		else:
+			return out
+	fp.close()
+
+	# scan the table for the values we want
+	count = i = 0
+	while(count < num and i <= len(buf) - 4):
+		type, size, handle = struct.unpack('BBH', buf[i:i+4])
+		n = i + size
+		while n < len(buf) - 1:
+			if 0 == struct.unpack('H', buf[n:n+2])[0]:
+				break
+			n += 1
+		data = buf[i+size:n+2].split('\0')
+		for name in info:
+			itype, idxadr = info[name]
+			if itype == type:
+				idx = struct.unpack('B', buf[i+idxadr])[0]
+				if idx > 0 and idx < len(data) - 1:
+					s = data[idx-1].strip()
+					if s and s.lower() != 'to be filled by o.e.m.':
+						out[name] = data[idx-1]
+		i = n + 2
+		count += 1
+	return out
+
 # Function: getFPDT
 # Description:
 #	 Read the acpi bios tables and pull out FPDT, the firmware data
@@ -4487,7 +4690,7 @@ def getFPDT(output):
 	prectype[0] = 'Basic S3 Resume Performance Record'
 	prectype[1] = 'Basic S3 Suspend Performance Record'
 
-	rootCheck(True)
+	sysvals.rootCheck(True)
 	if(not os.path.exists(sysvals.fpdtpath)):
 		if(output):
 			doError('file does not exist: %s' % sysvals.fpdtpath)
@@ -4617,7 +4820,7 @@ def statusCheck(probecheck=False):
 
 	# check we have root access
 	res = sysvals.colorText('NO (No features of this tool will work!)')
-	if(rootCheck(False)):
+	if(sysvals.rootCheck(False)):
 		res = 'YES'
 	print('    have root access: %s' % res)
 	if(res != 'YES'):
@@ -4716,16 +4919,6 @@ def doError(msg, help=False):
 	print('ERROR: %s\n') % msg
 	sys.exit()
 
-# Function: rootCheck
-# Description:
-#	 quick check to see if we have root access
-def rootCheck(fatal):
-	if(os.access(sysvals.powerfile, os.W_OK)):
-		return True
-	if fatal:
-		doError('This command requires sysfs mount and root access')
-	return False
-
 # Function: getArgInt
 # Description:
 #	 pull out an integer argument from the command line with checks
@@ -4779,6 +4972,7 @@ def processData():
 		if(sysvals.ftracefile and (sysvals.usecallgraph or sysvals.usetraceevents)):
 			appendIncompleteTraceLog(testruns)
 	createHTML(testruns)
+	return testruns
 
 # Function: rerunTest
 # Description:
@@ -4790,17 +4984,20 @@ def rerunTest():
 		doError('recreating this html output requires a dmesg file')
 	sysvals.setOutputFile()
 	vprint('Output file: %s' % sysvals.htmlfile)
-	if(os.path.exists(sysvals.htmlfile) and not os.access(sysvals.htmlfile, os.W_OK)):
-		doError('missing permission to write to %s' % sysvals.htmlfile)
-	processData()
+	if os.path.exists(sysvals.htmlfile):
+		if not os.path.isfile(sysvals.htmlfile):
+			doError('a directory already exists with this name: %s' % sysvals.htmlfile)
+		elif not os.access(sysvals.htmlfile, os.W_OK):
+			doError('missing permission to write to %s' % sysvals.htmlfile)
+	return processData()
 
 # Function: runTest
 # Description:
 #	 execute a suspend/resume, gather the logs, and generate the output
-def runTest(subdir, testpath=''):
+def runTest():
 	# prepare for the test
 	sysvals.initFtrace()
-	sysvals.initTestOutput(subdir, testpath)
+	sysvals.initTestOutput('suspend')
 	vprint('Output files:\n\t%s\n\t%s\n\t%s' % \
 		(sysvals.dmesgfile, sysvals.ftracefile, sysvals.htmlfile))
 
@@ -4897,7 +5094,7 @@ def configFromFile(file):
 			if(opt.lower() == 'verbose'):
 				sysvals.verbose = checkArgBool(value)
 			elif(opt.lower() == 'addlogs'):
-				sysvals.addlogs = checkArgBool(value)
+				sysvals.dmesglog = sysvals.ftracelog = checkArgBool(value)
 			elif(opt.lower() == 'dev'):
 				sysvals.usedevsrc = checkArgBool(value)
 			elif(opt.lower() == 'proc'):
@@ -4947,7 +5144,7 @@ def configFromFile(file):
 			elif(opt.lower() == 'mincg'):
 				sysvals.mincglen = getArgFloat('-mincg', value, 0.0, 10000.0, False)
 			elif(opt.lower() == 'output-dir'):
-				sysvals.setOutputFolder(value)
+				sysvals.testdir = sysvals.setOutputFolder(value)
 
 	if sysvals.suspendmode == 'command' and not sysvals.testcommand:
 		doError('No command supplied for mode "command"')
@@ -5030,8 +5227,6 @@ def configFromFile(file):
 # Description:
 #	 print out the help text
 def printHelp():
-	modes = getModes()
-
 	print('')
 	print('%s v%s' % (sysvals.title, sysvals.version))
 	print('Usage: sudo sleepgraph <options> <commands>')
@@ -5048,7 +5243,7 @@ def printHelp():
 	print('  If no specific command is given, the default behavior is to initiate')
 	print('  a suspend/resume and capture the dmesg/ftrace output as an html timeline.')
 	print('')
-	print('  Generates output files in subdirectory: suspend-mmddyy-HHMMSS')
+	print('  Generates output files in subdirectory: suspend-yymmdd-HHMMSS')
 	print('   HTML output:                    <hostname>_<mode>.html')
 	print('   raw dmesg output:               <hostname>_<mode>_dmesg.txt')
 	print('   raw ftrace output:              <hostname>_<mode>_ftrace.txt')
@@ -5058,8 +5253,9 @@ def printHelp():
 	print('   -v           Print the current tool version')
 	print('   -config fn   Pull arguments and config options from file fn')
 	print('   -verbose     Print extra information during execution and analysis')
-	print('   -m mode      Mode to initiate for suspend %s (default: %s)') % (modes, sysvals.suspendmode)
-	print('   -o subdir    Override the output subdirectory')
+	print('   -m mode      Mode to initiate for suspend (default: %s)') % (sysvals.suspendmode)
+	print('   -o name      Overrides the output subdirectory name when running a new test')
+	print('                default: suspend-{date}-{time}')
 	print('   -rtcwake t   Wakeup t seconds after suspend, set t to "off" to disable (default: 15)')
 	print('   -addlogs     Add the dmesg and ftrace logs to the html output')
 	print('   -srgap       Add a visible gap in the timeline between sus/res (default: disabled)')
@@ -5084,17 +5280,20 @@ def printHelp():
 	print('   -cgphase P   Only show callgraph data for phase P (e.g. suspend_late)')
 	print('   -cgtest N    Only show callgraph data for test N (e.g. 0 or 1 in an x2 run)')
 	print('   -timeprec N  Number of significant digits in timestamps (0:S, [3:ms], 6:us)')
-	print('  [commands]')
-	print('   -ftrace ftracefile  Create HTML output using ftrace input (used with -dmesg)')
-	print('   -dmesg dmesgfile    Create HTML output using dmesg (used with -ftrace)')
-	print('   -summary directory  Create a summary of all test in this dir')
+	print('')
+	print('Other commands:')
 	print('   -modes       List available suspend modes')
 	print('   -status      Test to see if the system is enabled to run this tool')
 	print('   -fpdt        Print out the contents of the ACPI Firmware Performance Data Table')
+	print('   -sysinfo     Print out system info extracted from BIOS')
 	print('   -usbtopo     Print out the current USB topology with power info')
 	print('   -usbauto     Enable autosuspend for all connected USB devices')
 	print('   -flist       Print the list of functions currently being captured in ftrace')
 	print('   -flistall    Print all functions capable of being captured in ftrace')
+	print('   -summary directory  Create a summary of all test in this dir')
+	print('  [redo]')
+	print('   -ftrace ftracefile  Create HTML output using ftrace input (used with -dmesg)')
+	print('   -dmesg dmesgfile    Create HTML output using dmesg (used with -ftrace)')
 	print('')
 	return True
 
@@ -5102,9 +5301,9 @@ def printHelp():
 # exec start (skipped if script is loaded as library)
 if __name__ == '__main__':
 	cmd = ''
-	cmdarg = ''
+	outdir = ''
 	multitest = {'run': False, 'count': 0, 'delay': 0}
-	simplecmds = ['-modes', '-fpdt', '-flist', '-flistall', '-usbtopo', '-usbauto', '-status']
+	simplecmds = ['-sysinfo', '-modes', '-fpdt', '-flist', '-flistall', '-usbtopo', '-usbauto', '-status']
 	# loop through the command line arguments
 	args = iter(sys.argv[1:])
 	for arg in args:
@@ -5135,7 +5334,7 @@ if __name__ == '__main__':
 		elif(arg == '-f'):
 			sysvals.usecallgraph = True
 		elif(arg == '-addlogs'):
-			sysvals.addlogs = True
+			sysvals.dmesglog = sysvals.ftracelog = True
 		elif(arg == '-verbose'):
 			sysvals.verbose = True
 		elif(arg == '-proc'):
@@ -5195,7 +5394,7 @@ if __name__ == '__main__':
 				val = args.next()
 			except:
 				doError('No subdirectory name supplied', True)
-			sysvals.setOutputFolder(val)
+			outdir = sysvals.setOutputFolder(val)
 		elif(arg == '-config'):
 			try:
 				val = args.next()
@@ -5236,7 +5435,7 @@ if __name__ == '__main__':
 			except:
 				doError('No directory supplied', True)
 			cmd = 'summary'
-			cmdarg = val
+			outdir = val
 			sysvals.notestrun = True
 			if(os.path.isdir(val) == False):
 				doError('%s is not accesible' % val)
@@ -5260,11 +5459,14 @@ if __name__ == '__main__':
 		sysvals.mincglen = sysvals.mindevlen
 
 	# just run a utility command and exit
+	sysvals.cpuInfo()
 	if(cmd != ''):
 		if(cmd == 'status'):
 			statusCheck(True)
 		elif(cmd == 'fpdt'):
 			getFPDT(True)
+		elif(cmd == 'sysinfo'):
+			sysvals.printSystemInfo()
 		elif(cmd == 'usbtopo'):
 			detectUSB()
 		elif(cmd == 'modes'):
@@ -5276,7 +5478,7 @@ if __name__ == '__main__':
 		elif(cmd == 'usbauto'):
 			setUSBDevicesAuto()
 		elif(cmd == 'summary'):
-			runSummary(cmdarg, True)
+			runSummary(outdir, True)
 		sys.exit()
 
 	# if instructed, re-analyze existing data files
@@ -5289,21 +5491,43 @@ if __name__ == '__main__':
 		print('Check FAILED, aborting the test run!')
 		sys.exit()
 
+	# extract mem modes and convert
+	mode = sysvals.suspendmode
+	if 'mem' == mode[:3]:
+		if '-' in mode:
+			memmode = mode.split('-')[-1]
+		else:
+			memmode = 'deep'
+		if memmode == 'shallow':
+			mode = 'standby'
+		elif memmode ==  's2idle':
+			mode = 'freeze'
+		else:
+			mode = 'mem'
+		sysvals.memmode = memmode
+		sysvals.suspendmode = mode
+
+	sysvals.systemInfo(dmidecode(sysvals.mempath))
+
 	if multitest['run']:
 		# run multiple tests in a separate subdirectory
-		s = 'x%d' % multitest['count']
-		if not sysvals.outdir:
-			sysvals.outdir = datetime.now().strftime('suspend-'+s+'-%m%d%y-%H%M%S')
-		if not os.path.isdir(sysvals.outdir):
-			os.mkdir(sysvals.outdir)
+		if not outdir:
+			s = 'suspend-x%d' % multitest['count']
+			outdir = datetime.now().strftime(s+'-%y%m%d-%H%M%S')
+		if not os.path.isdir(outdir):
+			os.mkdir(outdir)
 		for i in range(multitest['count']):
 			if(i != 0):
 				print('Waiting %d seconds...' % (multitest['delay']))
 				time.sleep(multitest['delay'])
 			print('TEST (%d/%d) START' % (i+1, multitest['count']))
-			runTest(sysvals.outdir)
+			fmt = 'suspend-%y%m%d-%H%M%S'
+			sysvals.testdir = os.path.join(outdir, datetime.now().strftime(fmt))
+			runTest()
 			print('TEST (%d/%d) COMPLETE' % (i+1, multitest['count']))
-		runSummary(sysvals.outdir, False)
+		runSummary(outdir, False)
 	else:
+		if outdir:
+			sysvals.testdir = outdir
 		# run the test in the current directory
-		runTest('.', sysvals.outdir)
+		runTest()
-- 
2.11.0
