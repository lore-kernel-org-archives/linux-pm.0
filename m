From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 2/3] pm-graph: AnalyzeBoot v2.1
Date: Wed,  5 Jul 2017 14:42:56 -0700
Message-ID: <a99bb6a8f243a6b072454f7363a7902368601c1a.1499290431.git.todd.e.brandt@linux.intel.com>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12688 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751929AbdGEVnC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jul 2017 17:43:02 -0400
In-Reply-To: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
References: <cover.1499290431.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: todd.e.brandt@linux.intel.com, todd.e.brandt@intel.com

- changed output from single html file to dir with html/dmesg/ftrace
- add sysinfo to logs and timeline
- add -sysinfo command, displays dmidecode values and cpu/mem info
- set trace buffer size to lesser of memtotal/2 or 2GB when using callgraph
- extended timeline to the last init call in user space
  separated timeline into two phases, kernel mode & user mode
- add kernel version check for ftrace usage, 4.10 minimum
- change -filter argument to -func
- add strict protections on -func usage with full symbol checks
  now only works for statically linked functions
  cmd -flistall now ignores all loadable module functions
- add -cgfilter argument for reducing timeline size by removing callgraphs
- crontab usage: preserve existing @reboot lines in user crontab
- fedora support added: uses grub2 loader, handles fedora crontab
- stop using "which" to find binaries, search pre-defined path list
- moved most output processing to analyze_suspend library

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/analyze_boot.py | 586 +++++++++++++++++++++++------------
 1 file changed, 387 insertions(+), 199 deletions(-)

diff --git a/tools/power/pm-graph/analyze_boot.py b/tools/power/pm-graph/analyze_boot.py
index 3e1dcbbf1adc..e83df141a597 100755
--- a/tools/power/pm-graph/analyze_boot.py
+++ b/tools/power/pm-graph/analyze_boot.py
@@ -42,7 +42,7 @@ import analyze_suspend as aslib
 #	 store system values and test parameters
 class SystemValues(aslib.SystemValues):
 	title = 'BootGraph'
-	version = 2.0
+	version = '2.1'
 	hostname = 'localhost'
 	testtime = ''
 	kernel = ''
@@ -50,9 +50,14 @@ class SystemValues(aslib.SystemValues):
 	ftracefile = ''
 	htmlfile = 'bootgraph.html'
 	outfile = ''
-	phoronix = False
-	addlogs = False
+	testdir = ''
+	testdirprefix = 'boot'
+	embedded = False
+	testlog = False
+	dmesglog = False
+	ftracelog = False
 	useftrace = False
+	usecallgraph = False
 	usedevsrc = True
 	suspendmode = 'boot'
 	max_graph_depth = 2
@@ -61,10 +66,12 @@ class SystemValues(aslib.SystemValues):
 	manual = False
 	iscronjob = False
 	timeformat = '%.6f'
+	bootloader = 'grub'
+	blexec = []
 	def __init__(self):
 		if('LOG_FILE' in os.environ and 'TEST_RESULTS_IDENTIFIER' in os.environ):
-			self.phoronix = True
-			self.addlogs = True
+			self.embedded = True
+			self.dmesglog = True
 			self.outfile = os.environ['LOG_FILE']
 			self.htmlfile = os.environ['LOG_FILE']
 		self.hostname = platform.node()
@@ -76,42 +83,80 @@ class SystemValues(aslib.SystemValues):
 			self.kernel = self.kernelVersion(val)
 		else:
 			self.kernel = 'unknown'
+		self.testdir = datetime.now().strftime('boot-%y%m%d-%H%M%S')
 	def kernelVersion(self, msg):
 		return msg.split()[2]
+	def checkFtraceKernelVersion(self):
+		val = tuple(map(int, self.kernel.split('-')[0].split('.')))
+		if val >= (4, 10, 0):
+			return True
+		return False
 	def kernelParams(self):
 		cmdline = 'initcall_debug log_buf_len=32M'
 		if self.useftrace:
-			cmdline += ' trace_buf_size=128M trace_clock=global '\
+			if self.cpucount > 0:
+				bs = min(self.memtotal / 2, 2*1024*1024) / self.cpucount
+			else:
+				bs = 131072
+			cmdline += ' trace_buf_size=%dK trace_clock=global '\
 			'trace_options=nooverwrite,funcgraph-abstime,funcgraph-cpu,'\
 			'funcgraph-duration,funcgraph-proc,funcgraph-tail,'\
 			'nofuncgraph-overhead,context-info,graph-time '\
 			'ftrace=function_graph '\
 			'ftrace_graph_max_depth=%d '\
 			'ftrace_graph_filter=%s' % \
-				(self.max_graph_depth, self.graph_filter)
+				(bs, self.max_graph_depth, self.graph_filter)
 		return cmdline
 	def setGraphFilter(self, val):
-		fp = open(self.tpath+'available_filter_functions')
-		master = fp.read().split('\n')
-		fp.close()
+		master = self.getBootFtraceFilterFunctions()
+		fs = ''
 		for i in val.split(','):
 			func = i.strip()
+			if func == '':
+				doError('badly formatted filter function string')
+			if '[' in func or ']' in func:
+				doError('loadable module functions not allowed - "%s"' % func)
+			if ' ' in func:
+				doError('spaces found in filter functions - "%s"' % func)
 			if func not in master:
 				doError('function "%s" not available for ftrace' % func)
-		self.graph_filter = val
+			if not fs:
+				fs = func
+			else:
+				fs += ','+func
+		if not fs:
+			doError('badly formatted filter function string')
+		self.graph_filter = fs
+	def getBootFtraceFilterFunctions(self):
+		self.rootCheck(True)
+		fp = open(self.tpath+'available_filter_functions')
+		fulllist = fp.read().split('\n')
+		fp.close()
+		list = []
+		for i in fulllist:
+			if not i or ' ' in i or '[' in i or ']' in i:
+				continue
+			list.append(i)
+		return list
+	def myCronJob(self, line):
+		if '@reboot' not in line:
+			return False
+		if 'bootgraph' in line or 'analyze_boot.py' in line or '-cronjob' in line:
+			return True
+		return False
 	def cronjobCmdString(self):
 		cmdline = '%s -cronjob' % os.path.abspath(sys.argv[0])
 		args = iter(sys.argv[1:])
 		for arg in args:
 			if arg in ['-h', '-v', '-cronjob', '-reboot']:
 				continue
-			elif arg in ['-o', '-dmesg', '-ftrace', '-filter']:
+			elif arg in ['-o', '-dmesg', '-ftrace', '-func']:
 				args.next()
 				continue
 			cmdline += ' '+arg
 		if self.graph_filter != 'do_one_initcall':
-			cmdline += ' -filter "%s"' % self.graph_filter
-		cmdline += ' -o "%s"' % os.path.abspath(self.htmlfile)
+			cmdline += ' -func "%s"' % self.graph_filter
+		cmdline += ' -o "%s"' % os.path.abspath(self.testdir)
 		return cmdline
 	def manualRebootRequired(self):
 		cmdline = self.kernelParams()
@@ -121,6 +166,39 @@ class SystemValues(aslib.SystemValues):
 		print '3. After reboot, re-run this tool with the same arguments but no command (w/o -reboot or -manual).\n'
 		print 'CMDLINE="%s"' % cmdline
 		sys.exit()
+	def getExec(self, cmd):
+		dirlist = ['/sbin', '/bin', '/usr/sbin', '/usr/bin',
+			'/usr/local/sbin', '/usr/local/bin']
+		for path in dirlist:
+			cmdfull = os.path.join(path, cmd)
+			if os.path.exists(cmdfull):
+				return cmdfull
+		return ''
+	def blGrub(self):
+		blcmd = ''
+		for cmd in ['update-grub', 'grub-mkconfig', 'grub2-mkconfig']:
+			if blcmd:
+				break
+			blcmd = self.getExec(cmd)
+		if not blcmd:
+			doError('[GRUB] missing update command')
+		if not os.path.exists('/etc/default/grub'):
+			doError('[GRUB] missing /etc/default/grub')
+		if 'grub2' in blcmd:
+			cfg = '/boot/grub2/grub.cfg'
+		else:
+			cfg = '/boot/grub/grub.cfg'
+		if not os.path.exists(cfg):
+			doError('[GRUB] missing %s' % cfg)
+		if 'update-grub' in blcmd:
+			self.blexec = [blcmd]
+		else:
+			self.blexec = [blcmd, '-o', cfg]
+	def getBootLoader(self):
+		if self.bootloader == 'grub':
+			self.blGrub()
+		else:
+			doError('unknown boot loader: %s' % self.bootloader)
 
 sysvals = SystemValues()
 
@@ -136,20 +214,23 @@ class Data(aslib.Data):
 	idstr = ''
 	html_device_id = 0
 	valid = False
-	initstart = 0.0
+	tUserMode = 0.0
 	boottime = ''
-	phases = ['boot']
+	phases = ['kernel', 'user']
 	do_one_initcall = False
 	def __init__(self, num):
 		self.testnumber = num
 		self.idstr = 'a'
 		self.dmesgtext = []
 		self.dmesg = {
-			'boot': {'list': dict(), 'start': -1.0, 'end': -1.0, 'row': 0, 'color': '#dddddd'}
+			'kernel': {'list': dict(), 'start': -1.0, 'end': -1.0, 'row': 0,
+				'order': 0, 'color': 'linear-gradient(to bottom, #fff, #bcf)'},
+			'user': {'list': dict(), 'start': -1.0, 'end': -1.0, 'row': 0,
+				'order': 1, 'color': '#fff'}
 		}
 	def deviceTopology(self):
 		return ''
-	def newAction(self, phase, name, start, end, ret, ulen):
+	def newAction(self, phase, name, pid, start, end, ret, ulen):
 		# new device callback for a specific phase
 		self.html_device_id += 1
 		devid = '%s%d' % (self.idstr, self.html_device_id)
@@ -163,41 +244,46 @@ class Data(aslib.Data):
 			name = '%s[%d]' % (origname, i)
 			i += 1
 		list[name] = {'name': name, 'start': start, 'end': end,
-			'pid': 0, 'length': length, 'row': 0, 'id': devid,
+			'pid': pid, 'length': length, 'row': 0, 'id': devid,
 			'ret': ret, 'ulen': ulen }
 		return name
-	def deviceMatch(self, cg):
+	def deviceMatch(self, pid, cg):
 		if cg.end - cg.start == 0:
 			return True
-		list = self.dmesg['boot']['list']
-		for devname in list:
-			dev = list[devname]
-			if cg.name == 'do_one_initcall':
-				if(cg.start <= dev['start'] and cg.end >= dev['end'] and dev['length'] > 0):
-					dev['ftrace'] = cg
-					self.do_one_initcall = True
-					return True
-			else:
-				if(cg.start > dev['start'] and cg.end < dev['end']):
-					if 'ftraces' not in dev:
-						dev['ftraces'] = []
-					dev['ftraces'].append(cg)
-					return True
+		for p in data.phases:
+			list = self.dmesg[p]['list']
+			for devname in list:
+				dev = list[devname]
+				if pid != dev['pid']:
+					continue
+				if cg.name == 'do_one_initcall':
+					if(cg.start <= dev['start'] and cg.end >= dev['end'] and dev['length'] > 0):
+						dev['ftrace'] = cg
+						self.do_one_initcall = True
+						return True
+				else:
+					if(cg.start > dev['start'] and cg.end < dev['end']):
+						if 'ftraces' not in dev:
+							dev['ftraces'] = []
+						dev['ftraces'].append(cg)
+						return True
 		return False
 
 # ----------------- FUNCTIONS --------------------
 
-# Function: loadKernelLog
+# Function: parseKernelLog
 # Description:
-#	 Load a raw kernel log from dmesg
-def loadKernelLog():
+#	 parse a kernel log for boot data
+def parseKernelLog():
+	phase = 'kernel'
 	data = Data(0)
-	data.dmesg['boot']['start'] = data.start = ktime = 0.0
+	data.dmesg['kernel']['start'] = data.start = ktime = 0.0
 	sysvals.stamp = {
 		'time': datetime.now().strftime('%B %d %Y, %I:%M:%S %p'),
 		'host': sysvals.hostname,
 		'mode': 'boot', 'kernel': ''}
 
+	tp = aslib.TestProps()
 	devtemp = dict()
 	if(sysvals.dmesgfile):
 		lf = open(sysvals.dmesgfile, 'r')
@@ -205,6 +291,13 @@ def loadKernelLog():
 		lf = Popen('dmesg', stdout=PIPE).stdout
 	for line in lf:
 		line = line.replace('\r\n', '')
+		# grab the stamp and sysinfo
+		if re.match(tp.stampfmt, line):
+			tp.stamp = line
+			continue
+		elif re.match(tp.sysinfofmt, line):
+			tp.sysinfo = line
+			continue
 		idx = line.find('[')
 		if idx > 1:
 			line = line[idx:]
@@ -215,7 +308,6 @@ def loadKernelLog():
 		if(ktime > 120):
 			break
 		msg = m.group('msg')
-		data.end = data.initstart = ktime
 		data.dmesgtext.append(line)
 		if(ktime == 0.0 and re.match('^Linux version .*', msg)):
 			if(not sysvals.stamp['kernel']):
@@ -228,43 +320,39 @@ def loadKernelLog():
 			data.boottime = bt.strftime('%Y-%m-%d_%H:%M:%S')
 			sysvals.stamp['time'] = bt.strftime('%B %d %Y, %I:%M:%S %p')
 			continue
-		m = re.match('^calling *(?P<f>.*)\+.*', msg)
+		m = re.match('^calling *(?P<f>.*)\+.* @ (?P<p>[0-9]*)', msg)
 		if(m):
-			devtemp[m.group('f')] = ktime
+			func = m.group('f')
+			pid = int(m.group('p'))
+			devtemp[func] = (ktime, pid)
 			continue
 		m = re.match('^initcall *(?P<f>.*)\+.* returned (?P<r>.*) after (?P<t>.*) usecs', msg)
 		if(m):
 			data.valid = True
+			data.end = ktime
 			f, r, t = m.group('f', 'r', 't')
 			if(f in devtemp):
-				data.newAction('boot', f, devtemp[f], ktime, int(r), int(t))
-				data.end = ktime
+				start, pid = devtemp[f]
+				data.newAction(phase, f, pid, start, ktime, int(r), int(t))
 				del devtemp[f]
 			continue
 		if(re.match('^Freeing unused kernel memory.*', msg)):
-			break
-
-	data.dmesg['boot']['end'] = data.end
+			data.tUserMode = ktime
+			data.dmesg['kernel']['end'] = ktime
+			data.dmesg['user']['start'] = ktime
+			phase = 'user'
+
+	if tp.stamp:
+		sysvals.stamp = 0
+		tp.parseStamp(data, sysvals)
+	data.dmesg['user']['end'] = data.end
 	lf.close()
 	return data
 
-# Function: loadTraceLog
+# Function: parseTraceLog
 # Description:
 #	 Check if trace is available and copy to a temp file
-def loadTraceLog(data):
-	# load the data to a temp file if none given
-	if not sysvals.ftracefile:
-		lib = aslib.sysvals
-		aslib.rootCheck(True)
-		if not lib.verifyFtrace():
-			doError('ftrace not available')
-		if lib.fgetVal('current_tracer').strip() != 'function_graph':
-			doError('ftrace not configured for a boot callgraph')
-		sysvals.ftracefile = '/tmp/boot_ftrace.%s.txt' % os.getpid()
-		call('cat '+lib.tpath+'trace > '+sysvals.ftracefile, shell=True)
-	if not sysvals.ftracefile:
-		doError('No trace data available')
-
+def parseTraceLog(data):
 	# parse the trace log
 	ftemp = dict()
 	tp = aslib.TestProps()
@@ -306,9 +394,29 @@ def loadTraceLog(data):
 				print('Sanity check failed for %s-%d' % (proc, pid))
 				continue
 			# match cg data to devices
-			if not data.deviceMatch(cg):
+			if not data.deviceMatch(pid, cg):
 				print ' BAD: %s %s-%d [%f - %f]' % (cg.name, proc, pid, cg.start, cg.end)
 
+# Function: retrieveLogs
+# Description:
+#	 Create copies of dmesg and/or ftrace for later processing
+def retrieveLogs():
+	# check ftrace is configured first
+	if sysvals.useftrace:
+		tracer = sysvals.fgetVal('current_tracer').strip()
+		if tracer != 'function_graph':
+			doError('ftrace not configured for a boot callgraph')
+	# create the folder and get dmesg
+	sysvals.systemInfo(aslib.dmidecode(sysvals.mempath))
+	sysvals.initTestOutput('boot')
+	sysvals.writeDatafileHeader(sysvals.dmesgfile)
+	call('dmesg >> '+sysvals.dmesgfile, shell=True)
+	if not sysvals.useftrace:
+		return
+	# get ftrace
+	sysvals.writeDatafileHeader(sysvals.ftracefile)
+	call('cat '+sysvals.tpath+'trace >> '+sysvals.ftracefile, shell=True)
+
 # Function: colorForName
 # Description:
 #	 Generate a repeatable color from a list for a given name
@@ -353,18 +461,19 @@ def cgOverview(cg, minlen):
 #	 testruns: array of Data objects from parseKernelLog or parseTraceLog
 # Output:
 #	 True if the html file was created, false if it failed
-def createBootGraph(data, embedded):
+def createBootGraph(data):
 	# html function templates
 	html_srccall = '<div id={6} title="{5}" class="srccall" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;">{0}</div>\n'
 	html_timetotal = '<table class="time1">\n<tr>'\
-		'<td class="blue">Time from Kernel Boot to start of User Mode: <b>{0} ms</b></td>'\
+		'<td class="blue">Init process starts @ <b>{0} ms</b></td>'\
+		'<td class="blue">Last initcall ends @ <b>{1} ms</b></td>'\
 		'</tr>\n</table>\n'
 
 	# device timeline
 	devtl = aslib.Timeline(100, 20)
 
 	# write the test title and general info header
-	devtl.createHeader(sysvals, 'noftrace')
+	devtl.createHeader(sysvals)
 
 	# Generate the header for this timeline
 	t0 = data.start
@@ -373,84 +482,98 @@ def createBootGraph(data, embedded):
 	if(tTotal == 0):
 		print('ERROR: No timeline data')
 		return False
-	boot_time = '%.0f'%(tTotal*1000)
-	devtl.html += html_timetotal.format(boot_time)
+	user_mode = '%.0f'%(data.tUserMode*1000)
+	last_init = '%.0f'%(tTotal*1000)
+	devtl.html += html_timetotal.format(user_mode, last_init)
 
 	# determine the maximum number of rows we need to draw
-	phase = 'boot'
-	list = data.dmesg[phase]['list']
 	devlist = []
-	for devname in list:
-		d = aslib.DevItem(0, phase, list[devname])
-		devlist.append(d)
-	devtl.getPhaseRows(devlist)
+	for p in data.phases:
+		list = data.dmesg[p]['list']
+		for devname in list:
+			d = aslib.DevItem(0, p, list[devname])
+			devlist.append(d)
+		devtl.getPhaseRows(devlist, 0, 'start')
 	devtl.calcTotalRows()
 
 	# draw the timeline background
 	devtl.createZoomBox()
-	boot = data.dmesg[phase]
-	length = boot['end']-boot['start']
-	left = '%.3f' % (((boot['start']-t0)*100.0)/tTotal)
-	width = '%.3f' % ((length*100.0)/tTotal)
-	devtl.html += devtl.html_tblock.format(phase, left, width, devtl.scaleH)
-	devtl.html += devtl.html_phase.format('0', '100', \
-		'%.3f'%devtl.scaleH, '%.3f'%devtl.bodyH, \
-		'white', '')
+	devtl.html += devtl.html_tblock.format('boot', '0', '100', devtl.scaleH)
+	for p in data.phases:
+		phase = data.dmesg[p]
+		length = phase['end']-phase['start']
+		left = '%.3f' % (((phase['start']-t0)*100.0)/tTotal)
+		width = '%.3f' % ((length*100.0)/tTotal)
+		devtl.html += devtl.html_phase.format(left, width, \
+			'%.3f'%devtl.scaleH, '%.3f'%devtl.bodyH, \
+			phase['color'], '')
 
 	# draw the device timeline
 	num = 0
 	devstats = dict()
-	for devname in sorted(list):
-		cls, color = colorForName(devname)
-		dev = list[devname]
-		info = '@|%.3f|%.3f|%.3f|%d' % (dev['start']*1000.0, dev['end']*1000.0,
-			dev['ulen']/1000.0, dev['ret'])
-		devstats[dev['id']] = {'info':info}
-		dev['color'] = color
-		height = devtl.phaseRowHeight(0, phase, dev['row'])
-		top = '%.6f' % ((dev['row']*height) + devtl.scaleH)
-		left = '%.6f' % (((dev['start']-t0)*100)/tTotal)
-		width = '%.6f' % (((dev['end']-dev['start'])*100)/tTotal)
-		length = ' (%0.3f ms) ' % ((dev['end']-dev['start'])*1000)
-		devtl.html += devtl.html_device.format(dev['id'],
-			devname+length+'kernel_mode', left, top, '%.3f'%height,
-			width, devname, ' '+cls, '')
-		rowtop = devtl.phaseRowTop(0, phase, dev['row'])
-		height = '%.6f' % (devtl.rowH / 2)
-		top = '%.6f' % (rowtop + devtl.scaleH + (devtl.rowH / 2))
-		if data.do_one_initcall:
-			if('ftrace' not in dev):
+	for phase in data.phases:
+		list = data.dmesg[phase]['list']
+		for devname in sorted(list):
+			cls, color = colorForName(devname)
+			dev = list[devname]
+			info = '@|%.3f|%.3f|%.3f|%d' % (dev['start']*1000.0, dev['end']*1000.0,
+				dev['ulen']/1000.0, dev['ret'])
+			devstats[dev['id']] = {'info':info}
+			dev['color'] = color
+			height = devtl.phaseRowHeight(0, phase, dev['row'])
+			top = '%.6f' % ((dev['row']*height) + devtl.scaleH)
+			left = '%.6f' % (((dev['start']-t0)*100)/tTotal)
+			width = '%.6f' % (((dev['end']-dev['start'])*100)/tTotal)
+			length = ' (%0.3f ms) ' % ((dev['end']-dev['start'])*1000)
+			devtl.html += devtl.html_device.format(dev['id'],
+				devname+length+phase+'_mode', left, top, '%.3f'%height,
+				width, devname, ' '+cls, '')
+			rowtop = devtl.phaseRowTop(0, phase, dev['row'])
+			height = '%.6f' % (devtl.rowH / 2)
+			top = '%.6f' % (rowtop + devtl.scaleH + (devtl.rowH / 2))
+			if data.do_one_initcall:
+				if('ftrace' not in dev):
+					continue
+				cg = dev['ftrace']
+				large, stats = cgOverview(cg, 0.001)
+				devstats[dev['id']]['fstat'] = stats
+				for l in large:
+					left = '%f' % (((l.time-t0)*100)/tTotal)
+					width = '%f' % (l.length*100/tTotal)
+					title = '%s (%0.3fms)' % (l.name, l.length * 1000.0)
+					devtl.html += html_srccall.format(l.name, left,
+						top, height, width, title, 'x%d'%num)
+					num += 1
+				continue
+			if('ftraces' not in dev):
 				continue
-			cg = dev['ftrace']
-			large, stats = cgOverview(cg, 0.001)
-			devstats[dev['id']]['fstat'] = stats
-			for l in large:
-				left = '%f' % (((l.time-t0)*100)/tTotal)
-				width = '%f' % (l.length*100/tTotal)
-				title = '%s (%0.3fms)' % (l.name, l.length * 1000.0)
-				devtl.html += html_srccall.format(l.name, left,
-					top, height, width, title, 'x%d'%num)
+			for cg in dev['ftraces']:
+				left = '%f' % (((cg.start-t0)*100)/tTotal)
+				width = '%f' % ((cg.end-cg.start)*100/tTotal)
+				cglen = (cg.end - cg.start) * 1000.0
+				title = '%s (%0.3fms)' % (cg.name, cglen)
+				cg.id = 'x%d' % num
+				devtl.html += html_srccall.format(cg.name, left,
+					top, height, width, title, dev['id']+cg.id)
 				num += 1
-			continue
-		if('ftraces' not in dev):
-			continue
-		for cg in dev['ftraces']:
-			left = '%f' % (((cg.start-t0)*100)/tTotal)
-			width = '%f' % ((cg.end-cg.start)*100/tTotal)
-			cglen = (cg.end - cg.start) * 1000.0
-			title = '%s (%0.3fms)' % (cg.name, cglen)
-			cg.id = 'x%d' % num
-			devtl.html += html_srccall.format(cg.name, left,
-				top, height, width, title, dev['id']+cg.id)
-			num += 1
 
 	# draw the time scale, try to make the number of labels readable
-	devtl.createTimeScale(t0, tMax, tTotal, phase)
+	devtl.createTimeScale(t0, tMax, tTotal, 'boot')
 	devtl.html += '</div>\n'
 
 	# timeline is finished
 	devtl.html += '</div>\n</div>\n'
 
+	# draw a legend which describes the phases by color
+	devtl.html += '<div class="legend">\n'
+	pdelta = 20.0
+	pmargin = 36.0
+	for phase in data.phases:
+		order = '%.2f' % ((data.dmesg[phase]['order'] * pdelta) + pmargin)
+		devtl.html += devtl.html_legend.format(order, \
+			data.dmesg[phase]['color'], phase+'_mode', phase[0])
+	devtl.html += '</div>\n'
+
 	if(sysvals.outfile == sysvals.htmlfile):
 		hf = open(sysvals.htmlfile, 'a')
 	else:
@@ -474,7 +597,7 @@ def createBootGraph(data, embedded):
 		.fstat td {text-align:left;width:35px;}\n\
 		.srccall {position:absolute;font-size:10px;z-index:7;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,#CCC,#969696);}\n\
 		.srccall:hover {color:white;font-weight:bold;border:1px solid white;}\n'
-	if(not embedded):
+	if(not sysvals.embedded):
 		aslib.addCSS(hf, sysvals, 1, False, extra)
 
 	# write the device timeline
@@ -495,9 +618,11 @@ def createBootGraph(data, embedded):
 	html = \
 		'<div id="devicedetailtitle"></div>\n'\
 		'<div id="devicedetail" style="display:none;">\n'\
-		'<div id="devicedetail0">\n'\
-		'<div id="kernel_mode" class="phaselet" style="left:0%;width:100%;background:#DDDDDD"></div>\n'\
-		'</div>\n</div>\n'\
+		'<div id="devicedetail0">\n'
+	for p in data.phases:
+		phase = data.dmesg[p]
+		html += devtl.html_phaselet.format(p+'_mode', '0', '100', phase['color'])
+	html += '</div>\n</div>\n'\
 		'<script type="text/javascript">\n'+statinfo+\
 		'</script>\n'
 	hf.write(html)
@@ -507,21 +632,21 @@ def createBootGraph(data, embedded):
 		aslib.addCallgraphs(sysvals, hf, data)
 
 	# add the dmesg log as a hidden div
-	if sysvals.addlogs:
+	if sysvals.dmesglog:
 		hf.write('<div id="dmesglog" style="display:none;">\n')
 		for line in data.dmesgtext:
 			line = line.replace('<', '&lt').replace('>', '&gt')
 			hf.write(line)
 		hf.write('</div>\n')
 
-	if(not embedded):
+	if(not sysvals.embedded):
 		# write the footer and close
 		aslib.addScriptCode(hf, [data])
 		hf.write('</body>\n</html>\n')
 	else:
 		# embedded out will be loaded in a page, skip the js
 		hf.write('<div id=bounds style=display:none>%f,%f</div>' % \
-			(data.start*1000, data.initstart*1000))
+			(data.start*1000, data.end*1000))
 	hf.close()
 	return True
 
@@ -533,17 +658,20 @@ def updateCron(restore=False):
 	if not restore:
 		sysvals.rootUser(True)
 	crondir = '/var/spool/cron/crontabs/'
-	cronfile = crondir+'root'
-	backfile = crondir+'root-analyze_boot-backup'
+	if not os.path.exists(crondir):
+		crondir = '/var/spool/cron/'
 	if not os.path.exists(crondir):
 		doError('%s not found' % crondir)
-	out = Popen(['which', 'crontab'], stdout=PIPE).stdout.read()
-	if not out:
+	cronfile = crondir+'root'
+	backfile = crondir+'root-analyze_boot-backup'
+	cmd = sysvals.getExec('crontab')
+	if not cmd:
 		doError('crontab not found')
 	# on restore: move the backup cron back into place
 	if restore:
 		if os.path.exists(backfile):
 			shutil.move(backfile, cronfile)
+			call([cmd, cronfile])
 		return
 	# backup current cron and install new one with reboot
 	if os.path.exists(cronfile):
@@ -556,13 +684,13 @@ def updateCron(restore=False):
 		fp = open(backfile, 'r')
 		op = open(cronfile, 'w')
 		for line in fp:
-			if '@reboot' not in line:
+			if not sysvals.myCronJob(line):
 				op.write(line)
 				continue
 		fp.close()
 		op.write('@reboot python %s\n' % sysvals.cronjobCmdString())
 		op.close()
-		res = call('crontab %s' % cronfile, shell=True)
+		res = call([cmd, cronfile])
 	except Exception, e:
 		print 'Exception: %s' % str(e)
 		shutil.move(backfile, cronfile)
@@ -577,25 +705,16 @@ def updateGrub(restore=False):
 	# call update-grub on restore
 	if restore:
 		try:
-			call(['update-grub'], stderr=PIPE, stdout=PIPE,
+			call(sysvals.blexec, stderr=PIPE, stdout=PIPE,
 				env={'PATH': '.:/sbin:/usr/sbin:/usr/bin:/sbin:/bin'})
 		except Exception, e:
 			print 'Exception: %s\n' % str(e)
 		return
-	# verify we can do this
-	sysvals.rootUser(True)
-	grubfile = '/etc/default/grub'
-	if not os.path.exists(grubfile):
-		print 'ERROR: Unable to set the kernel parameters via grub.\n'
-		sysvals.manualRebootRequired()
-	out = Popen(['which', 'update-grub'], stdout=PIPE).stdout.read()
-	if not out:
-		print 'ERROR: Unable to set the kernel parameters via grub.\n'
-		sysvals.manualRebootRequired()
-
 	# extract the option and create a grub config without it
+	sysvals.rootUser(True)
 	tgtopt = 'GRUB_CMDLINE_LINUX_DEFAULT'
 	cmdline = ''
+	grubfile = '/etc/default/grub'
 	tempfile = '/etc/default/grub.analyze_boot'
 	shutil.move(grubfile, tempfile)
 	res = -1
@@ -622,7 +741,7 @@ def updateGrub(restore=False):
 		# if the target option value is in quotes, strip them
 		sp = '"'
 		val = cmdline.strip()
-		if val[0] == '\'' or val[0] == '"':
+		if val and (val[0] == '\'' or val[0] == '"'):
 			sp = val[0]
 			val = val.strip(sp)
 		cmdline = val
@@ -633,7 +752,7 @@ def updateGrub(restore=False):
 		# write out the updated target option
 		op.write('\n%s=%s%s%s\n' % (tgtopt, sp, cmdline, sp))
 		op.close()
-		res = call('update-grub')
+		res = call(sysvals.blexec)
 		os.remove(grubfile)
 	except Exception, e:
 		print 'Exception: %s' % str(e)
@@ -641,10 +760,18 @@ def updateGrub(restore=False):
 	# cleanup
 	shutil.move(tempfile, grubfile)
 	if res != 0:
-		doError('update-grub failed')
+		doError('update grub failed')
 
-# Function: doError
+# Function: updateKernelParams
 # Description:
+#	 update boot conf for all kernels with our parameters
+def updateKernelParams(restore=False):
+	# find the boot loader
+	sysvals.getBootLoader()
+	if sysvals.bootloader == 'grub':
+		updateGrub(restore)
+
+# Function: doError Description:
 #	 generic error function for catastrphic failures
 # Arguments:
 #	 msg: the error message to print
@@ -660,7 +787,7 @@ def doError(msg, help=False):
 #	 print out the help text
 def printHelp():
 	print('')
-	print('%s v%.1f' % (sysvals.title, sysvals.version))
+	print('%s v%s' % (sysvals.title, sysvals.version))
 	print('Usage: bootgraph <options> <command>')
 	print('')
 	print('Description:')
@@ -669,13 +796,19 @@ def printHelp():
 	print('  the start of the init process.')
 	print('')
 	print('  If no specific command is given the tool reads the current dmesg')
-	print('  and/or ftrace log and outputs bootgraph.html')
+	print('  and/or ftrace log and creates a timeline')
+	print('')
+	print('  Generates output files in subdirectory: boot-yymmdd-HHMMSS')
+	print('   HTML output:                    <hostname>_boot.html')
+	print('   raw dmesg output:               <hostname>_boot_dmesg.txt')
+	print('   raw ftrace output:              <hostname>_boot_ftrace.txt')
 	print('')
 	print('Options:')
 	print('  -h            Print this help text')
 	print('  -v            Print the current tool version')
 	print('  -addlogs      Add the dmesg log to the html output')
-	print('  -o file       Html timeline name (default: bootgraph.html)')
+	print('  -o name       Overrides the output subdirectory name when running a new test')
+	print('                default: boot-{date}-{time}')
 	print(' [advanced]')
 	print('  -f            Use ftrace to add function detail (default: disabled)')
 	print('  -callgraph    Add callgraph detail, can be very large (default: disabled)')
@@ -683,13 +816,18 @@ def printHelp():
 	print('  -mincg ms     Discard all callgraphs shorter than ms milliseconds (e.g. 0.001 for us)')
 	print('  -timeprec N   Number of significant digits in timestamps (0:S, 3:ms, [6:us])')
 	print('  -expandcg     pre-expand the callgraph data in the html output (default: disabled)')
-	print('  -filter list  Limit ftrace to comma-delimited list of functions (default: do_one_initcall)')
-	print(' [commands]')
+	print('  -func list    Limit ftrace to comma-delimited list of functions (default: do_one_initcall)')
+	print('  -cgfilter S   Filter the callgraph output in the timeline')
+	print('  -bl name      Use the following boot loader for kernel params (default: grub)')
 	print('  -reboot       Reboot the machine automatically and generate a new timeline')
-	print('  -manual       Show the requirements to generate a new timeline manually')
-	print('  -dmesg file   Load a stored dmesg file (used with -ftrace)')
-	print('  -ftrace file  Load a stored ftrace file (used with -dmesg)')
+	print('  -manual       Show the steps to generate a new timeline manually (used with -reboot)')
+	print('')
+	print('Other commands:')
 	print('  -flistall     Print all functions capable of being captured in ftrace')
+	print('  -sysinfo      Print out system info extracted from BIOS')
+	print(' [redo]')
+	print('  -dmesg file   Create HTML output using dmesg input (used with -ftrace)')
+	print('  -ftrace file  Create HTML output using ftrace input (used with -dmesg)')
 	print('')
 	return True
 
@@ -698,14 +836,15 @@ def printHelp():
 if __name__ == '__main__':
 	# loop through the command line arguments
 	cmd = ''
-	simplecmds = ['-updategrub', '-flistall']
+	testrun = True
+	simplecmds = ['-sysinfo', '-kpupdate', '-flistall', '-checkbl']
 	args = iter(sys.argv[1:])
 	for arg in args:
 		if(arg == '-h'):
 			printHelp()
 			sys.exit()
 		elif(arg == '-v'):
-			print("Version %.1f" % sysvals.version)
+			print("Version %s" % sysvals.version)
 			sys.exit()
 		elif(arg in simplecmds):
 			cmd = arg[1:]
@@ -716,16 +855,32 @@ if __name__ == '__main__':
 			sysvals.usecallgraph = True
 		elif(arg == '-mincg'):
 			sysvals.mincglen = aslib.getArgFloat('-mincg', args, 0.0, 10000.0)
+		elif(arg == '-cgfilter'):
+			try:
+				val = args.next()
+			except:
+				doError('No callgraph functions supplied', True)
+			sysvals.setDeviceFilter(val)
+		elif(arg == '-bl'):
+			try:
+				val = args.next()
+			except:
+				doError('No boot loader name supplied', True)
+			if val.lower() not in ['grub']:
+				doError('Unknown boot loader: %s' % val, True)
+			sysvals.bootloader = val.lower()
 		elif(arg == '-timeprec'):
 			sysvals.setPrecision(aslib.getArgInt('-timeprec', args, 0, 6))
 		elif(arg == '-maxdepth'):
 			sysvals.max_graph_depth = aslib.getArgInt('-maxdepth', args, 0, 1000)
-		elif(arg == '-filter'):
+		elif(arg == '-func'):
 			try:
 				val = args.next()
 			except:
 				doError('No filter functions supplied', True)
-			aslib.rootCheck(True)
+			sysvals.useftrace = True
+			sysvals.usecallgraph = True
+			sysvals.rootCheck(True)
 			sysvals.setGraphFilter(val)
 		elif(arg == '-ftrace'):
 			try:
@@ -734,9 +889,10 @@ if __name__ == '__main__':
 				doError('No ftrace file supplied', True)
 			if(os.path.exists(val) == False):
 				doError('%s does not exist' % val)
+			testrun = False
 			sysvals.ftracefile = val
 		elif(arg == '-addlogs'):
-			sysvals.addlogs = True
+			sysvals.dmesglog = True
 		elif(arg == '-expandcg'):
 			sysvals.cgexp = True
 		elif(arg == '-dmesg'):
@@ -748,18 +904,15 @@ if __name__ == '__main__':
 				doError('%s does not exist' % val)
 			if(sysvals.htmlfile == val or sysvals.outfile == val):
 				doError('Output filename collision')
+			testrun = False
 			sysvals.dmesgfile = val
 		elif(arg == '-o'):
 			try:
 				val = args.next()
 			except:
-				doError('No HTML filename supplied', True)
-			if(sysvals.dmesgfile == val or sysvals.ftracefile == val):
-				doError('Output filename collision')
-			sysvals.htmlfile = val
+				doError('No subdirectory name supplied', True)
+			sysvals.testdir = sysvals.setOutputFolder(val)
 		elif(arg == '-reboot'):
-			if sysvals.iscronjob:
-				doError('-reboot and -cronjob are incompatible')
 			sysvals.reboot = True
 		elif(arg == '-manual'):
 			sysvals.reboot = True
@@ -767,58 +920,93 @@ if __name__ == '__main__':
 		# remaining options are only for cron job use
 		elif(arg == '-cronjob'):
 			sysvals.iscronjob = True
-			if sysvals.reboot:
-				doError('-reboot and -cronjob are incompatible')
 		else:
 			doError('Invalid argument: '+arg, True)
 
+	# compatibility errors and access checks
+	if(sysvals.iscronjob and (sysvals.reboot or \
+		sysvals.dmesgfile or sysvals.ftracefile or cmd)):
+		doError('-cronjob is meant for batch purposes only')
+	if(sysvals.reboot and (sysvals.dmesgfile or sysvals.ftracefile)):
+		doError('-reboot and -dmesg/-ftrace are incompatible')
+	if cmd or sysvals.reboot or sysvals.iscronjob or testrun:
+		sysvals.rootCheck(True)
+	if (testrun and sysvals.useftrace) or cmd == 'flistall':
+		if not sysvals.verifyFtrace():
+			doError('Ftrace is not properly enabled')
+
+	# run utility commands
+	sysvals.cpuInfo()
 	if cmd != '':
-		if cmd == 'updategrub':
-			updateGrub()
+		if cmd == 'kpupdate':
+			updateKernelParams()
 		elif cmd == 'flistall':
-			sysvals.getFtraceFilterFunctions(False)
+			for f in sysvals.getBootFtraceFilterFunctions():
+				print f
+		elif cmd == 'checkbl':
+			sysvals.getBootLoader()
+			print 'Boot Loader: %s\n%s' % (sysvals.bootloader, sysvals.blexec)
+		elif(cmd == 'sysinfo'):
+			sysvals.printSystemInfo()
 		sys.exit()
 
-	# update grub, setup a cronjob, and reboot
+	# reboot: update grub, setup a cronjob, and reboot
 	if sysvals.reboot:
+		if (sysvals.useftrace or sysvals.usecallgraph) and \
+			not sysvals.checkFtraceKernelVersion():
+			doError('Ftrace functionality requires kernel v4.10 or newer')
 		if not sysvals.manual:
-			updateGrub()
+			updateKernelParams()
 			updateCron()
 			call('reboot')
 		else:
 			sysvals.manualRebootRequired()
 		sys.exit()
 
-	# disable the cronjob
+	# cronjob: remove the cronjob, grub changes, and disable ftrace
 	if sysvals.iscronjob:
 		updateCron(True)
-		updateGrub(True)
+		updateKernelParams(True)
+		try:
+			sysvals.fsetVal('0', 'tracing_on')
+		except:
+			pass
 
-	data = loadKernelLog()
-	if sysvals.useftrace:
-		loadTraceLog(data)
-		if sysvals.iscronjob:
-			try:
-				sysvals.fsetVal('0', 'tracing_on')
-			except:
-				pass
+	# testrun: generate copies of the logs
+	if testrun:
+		retrieveLogs()
+	else:
+		sysvals.setOutputFile()
 
-	if(sysvals.outfile and sysvals.phoronix):
-		fp = open(sysvals.outfile, 'w')
-		fp.write('pass %s initstart %.3f end %.3f boot %s\n' %
-			(data.valid, data.initstart*1000, data.end*1000, data.boottime))
-		fp.close()
-	if(not data.valid):
-		if sysvals.dmesgfile:
+	# process the log data
+	if sysvals.dmesgfile:
+		data = parseKernelLog()
+		if(not data.valid):
 			doError('No initcall data found in %s' % sysvals.dmesgfile)
-		else:
-			doError('No initcall data found, is initcall_debug enabled?')
+		if sysvals.useftrace and sysvals.ftracefile:
+			parseTraceLog(data)
+	else:
+		doError('dmesg file required')
 
 	print('          Host: %s' % sysvals.hostname)
 	print('     Test time: %s' % sysvals.testtime)
 	print('     Boot time: %s' % data.boottime)
 	print('Kernel Version: %s' % sysvals.kernel)
 	print('  Kernel start: %.3f' % (data.start * 1000))
-	print('    init start: %.3f' % (data.initstart * 1000))
+	print('Usermode start: %.3f' % (data.tUserMode * 1000))
+	print('Last Init Call: %.3f' % (data.end * 1000))
+
+	# handle embedded output logs
+	if(sysvals.outfile and sysvals.embedded):
+		fp = open(sysvals.outfile, 'w')
+		fp.write('pass %s initstart %.3f end %.3f boot %s\n' %
+			(data.valid, data.tUserMode*1000, data.end*1000, data.boottime))
+		fp.close()
+
+	createBootGraph(data)
 
-	createBootGraph(data, sysvals.phoronix)
+	# if running as root, change output dir owner to sudo_user
+	if testrun and os.path.isdir(sysvals.testdir) and \
+		os.getuid() == 0 and 'SUDO_USER' in os.environ:
+		cmd = 'chown -R {0}:{0} {1} > /dev/null 2>&1'
+		call(cmd.format(os.environ['SUDO_USER'], sysvals.testdir), shell=True)
-- 
2.11.0
