From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 2/3] pm-graph: AnalyzeBoot v2.2
Date: Tue, 30 Jan 2018 00:17:19 -0800
Message-ID: <3a35d8f11200b2739106c01df458f15406fb262c.1517297999.git.todd.e.brandt@linux.intel.com>
References: <cover.1517297999.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31330 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751712AbeA3IRY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
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
- changed argument -f to match sleegraph, -f = -callgraph
- use -fstat for function status instead of -f
- add -verbose option to print out timeline stats and kernel options
- include command string and kernel params in timeline output header

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 tools/power/pm-graph/bootgraph.8  |  18 +++-
 tools/power/pm-graph/bootgraph.py | 219 +++++++++++++++++++++++++-------------
 2 files changed, 160 insertions(+), 77 deletions(-)

diff --git a/tools/power/pm-graph/bootgraph.8 b/tools/power/pm-graph/bootgraph.8
index dbdafcf546df..64d513f80a2a 100644
--- a/tools/power/pm-graph/bootgraph.8
+++ b/tools/power/pm-graph/bootgraph.8
@@ -37,6 +37,9 @@ Print the current tool version
 Add the dmesg log to the html output. It will be viewable by
 clicking a button in the timeline.
 .TP
+\fB-result \fIfile\fR
+Export a results table to a text file for parsing.
+.TP
 \fB-o \fIname\fR
 Overrides the output subdirectory name when running a new test.
 Use {date}, {time}, {hostname} for current values.
@@ -44,14 +47,14 @@ Use {date}, {time}, {hostname} for current values.
 e.g. boot-{hostname}-{date}-{time}
 .SS "advanced"
 .TP
-\fB-f\fR
-Use ftrace to add function detail (default: disabled)
-.TP
-\fB-callgraph\fR
+\fB-f or -callgraph\fR
 Use ftrace to create initcall callgraphs (default: disabled). If -func
 is not used there will be one callgraph per initcall. This can produce
 very large outputs, i.e. 10MB - 100MB.
 .TP
+\fB-fstat\fR
+Use ftrace to add function detail (default: disabled)
+.TP
 \fB-maxdepth \fIlevel\fR
 limit the callgraph trace depth to \fIlevel\fR (default: 2). This is
 the best way to limit the output size when using -callgraph.
@@ -67,6 +70,13 @@ Reduce callgraph output in the timeline by limiting it to a list of calls. The
 argument can be a single function name or a comma delimited list.
 (default: none)
 .TP
+\fB-cgskip \fIfile\fR
+Reduce callgraph output in the timeline by skipping over uninteresting
+functions in the trace, e.g. printk or console_unlock. The functions listed
+in this file will show up as empty leaves in the callgraph with only the start/end
+times displayed.
+(default: none)
+.TP
 \fB-timeprec \fIn\fR
 Number of significant digits in timestamps (0:S, 3:ms, [6:us])
 .TP
diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index e83df141a597..abb4c38f029b 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -32,7 +32,7 @@ import platform
 import shutil
 from datetime import datetime, timedelta
 from subprocess import call, Popen, PIPE
-import analyze_suspend as aslib
+import sleepgraph as aslib
 
 # ----------------- CLASSES --------------------
 
@@ -42,23 +42,18 @@ import analyze_suspend as aslib
 #	 store system values and test parameters
 class SystemValues(aslib.SystemValues):
 	title = 'BootGraph'
-	version = '2.1'
+	version = '2.2'
 	hostname = 'localhost'
 	testtime = ''
 	kernel = ''
 	dmesgfile = ''
 	ftracefile = ''
 	htmlfile = 'bootgraph.html'
-	outfile = ''
 	testdir = ''
-	testdirprefix = 'boot'
-	embedded = False
-	testlog = False
-	dmesglog = False
-	ftracelog = False
+	kparams = ''
+	result = ''
 	useftrace = False
 	usecallgraph = False
-	usedevsrc = True
 	suspendmode = 'boot'
 	max_graph_depth = 2
 	graph_filter = 'do_one_initcall'
@@ -69,11 +64,6 @@ class SystemValues(aslib.SystemValues):
 	bootloader = 'grub'
 	blexec = []
 	def __init__(self):
-		if('LOG_FILE' in os.environ and 'TEST_RESULTS_IDENTIFIER' in os.environ):
-			self.embedded = True
-			self.dmesglog = True
-			self.outfile = os.environ['LOG_FILE']
-			self.htmlfile = os.environ['LOG_FILE']
 		self.hostname = platform.node()
 		self.testtime = datetime.now().strftime('%Y-%m-%d_%H:%M:%S')
 		if os.path.exists('/proc/version'):
@@ -148,11 +138,18 @@ class SystemValues(aslib.SystemValues):
 		cmdline = '%s -cronjob' % os.path.abspath(sys.argv[0])
 		args = iter(sys.argv[1:])
 		for arg in args:
-			if arg in ['-h', '-v', '-cronjob', '-reboot']:
+			if arg in ['-h', '-v', '-cronjob', '-reboot', '-verbose']:
 				continue
 			elif arg in ['-o', '-dmesg', '-ftrace', '-func']:
 				args.next()
 				continue
+			elif arg == '-result':
+				cmdline += ' %s "%s"' % (arg, os.path.abspath(args.next()))
+				continue
+			elif arg == '-cgskip':
+				file = self.configFile(args.next())
+				cmdline += ' %s "%s"' % (arg, os.path.abspath(file))
+				continue
 			cmdline += ' '+arg
 		if self.graph_filter != 'do_one_initcall':
 			cmdline += ' -func "%s"' % self.graph_filter
@@ -166,14 +163,6 @@ class SystemValues(aslib.SystemValues):
 		print '3. After reboot, re-run this tool with the same arguments but no command (w/o -reboot or -manual).\n'
 		print 'CMDLINE="%s"' % cmdline
 		sys.exit()
-	def getExec(self, cmd):
-		dirlist = ['/sbin', '/bin', '/usr/sbin', '/usr/bin',
-			'/usr/local/sbin', '/usr/local/bin']
-		for path in dirlist:
-			cmdfull = os.path.join(path, cmd)
-			if os.path.exists(cmdfull):
-				return cmdfull
-		return ''
 	def blGrub(self):
 		blcmd = ''
 		for cmd in ['update-grub', 'grub-mkconfig', 'grub2-mkconfig']:
@@ -199,6 +188,14 @@ class SystemValues(aslib.SystemValues):
 			self.blGrub()
 		else:
 			doError('unknown boot loader: %s' % self.bootloader)
+	def writeDatafileHeader(self, filename):
+		self.kparams = open('/proc/cmdline', 'r').read().strip()
+		fp = open(filename, 'w')
+		fp.write(self.teststamp+'\n')
+		fp.write(self.sysstamp+'\n')
+		fp.write('# command | %s\n' % self.cmdline)
+		fp.write('# kparams | %s\n' % self.kparams)
+		fp.close()
 
 sysvals = SystemValues()
 
@@ -249,7 +246,7 @@ class Data(aslib.Data):
 		return name
 	def deviceMatch(self, pid, cg):
 		if cg.end - cg.start == 0:
-			return True
+			return ''
 		for p in data.phases:
 			list = self.dmesg[p]['list']
 			for devname in list:
@@ -260,14 +257,25 @@ class Data(aslib.Data):
 					if(cg.start <= dev['start'] and cg.end >= dev['end'] and dev['length'] > 0):
 						dev['ftrace'] = cg
 						self.do_one_initcall = True
-						return True
+						return devname
 				else:
 					if(cg.start > dev['start'] and cg.end < dev['end']):
 						if 'ftraces' not in dev:
 							dev['ftraces'] = []
 						dev['ftraces'].append(cg)
-						return True
-		return False
+						return devname
+		return ''
+	def printDetails(self):
+		sysvals.vprint('Timeline Details:')
+		sysvals.vprint('          Host: %s' % sysvals.hostname)
+		sysvals.vprint('        Kernel: %s' % sysvals.kernel)
+		sysvals.vprint('     Test time: %s' % sysvals.testtime)
+		sysvals.vprint('     Boot time: %s' % self.boottime)
+		for phase in self.phases:
+			dc = len(self.dmesg[phase]['list'])
+			sysvals.vprint('%9s mode: %.3f - %.3f (%d initcalls)' % (phase,
+				self.dmesg[phase]['start']*1000,
+				self.dmesg[phase]['end']*1000, dc))
 
 # ----------------- FUNCTIONS --------------------
 
@@ -275,6 +283,8 @@ class Data(aslib.Data):
 # Description:
 #	 parse a kernel log for boot data
 def parseKernelLog():
+	sysvals.vprint('Analyzing the dmesg data (%s)...' % \
+		os.path.basename(sysvals.dmesgfile))
 	phase = 'kernel'
 	data = Data(0)
 	data.dmesg['kernel']['start'] = data.start = ktime = 0.0
@@ -298,6 +308,12 @@ def parseKernelLog():
 		elif re.match(tp.sysinfofmt, line):
 			tp.sysinfo = line
 			continue
+		elif re.match(tp.cmdlinefmt, line):
+			tp.cmdline = line
+			continue
+		elif re.match(tp.kparamsfmt, line):
+			tp.kparams = line
+			continue
 		idx = line.find('[')
 		if idx > 1:
 			line = line[idx:]
@@ -353,6 +369,17 @@ def parseKernelLog():
 # Description:
 #	 Check if trace is available and copy to a temp file
 def parseTraceLog(data):
+	sysvals.vprint('Analyzing the ftrace data (%s)...' % \
+		os.path.basename(sysvals.ftracefile))
+	# if available, calculate cgfilter allowable ranges
+	cgfilter = []
+	if len(sysvals.cgfilter) > 0:
+		for p in data.phases:
+			list = data.dmesg[p]['list']
+			for i in sysvals.cgfilter:
+				if i in list:
+					cgfilter.append([list[i]['start']-0.0001,
+						list[i]['end']+0.0001])
 	# parse the trace log
 	ftemp = dict()
 	tp = aslib.TestProps()
@@ -366,7 +393,16 @@ def parseTraceLog(data):
 			continue
 		m_time, m_proc, m_pid, m_msg, m_dur = \
 			m.group('time', 'proc', 'pid', 'msg', 'dur')
-		if float(m_time) > data.end:
+		t = float(m_time)
+		if len(cgfilter) > 0:
+			allow = False
+			for r in cgfilter:
+				if t >= r[0] and t < r[1]:
+					allow = True
+					break
+			if not allow:
+				continue
+		if t > data.end:
 			break
 		if(m_time and m_pid and m_msg):
 			t = aslib.FTraceLine(m_time, m_msg, m_dur)
@@ -378,24 +414,36 @@ def parseTraceLog(data):
 		key = (m_proc, pid)
 		if(key not in ftemp):
 			ftemp[key] = []
-			ftemp[key].append(aslib.FTraceCallGraph(pid))
+			ftemp[key].append(aslib.FTraceCallGraph(pid, sysvals))
 		cg = ftemp[key][-1]
-		if(cg.addLine(t)):
-			ftemp[key].append(aslib.FTraceCallGraph(pid))
+		res = cg.addLine(t)
+		if(res != 0):
+			ftemp[key].append(aslib.FTraceCallGraph(pid, sysvals))
+		if(res == -1):
+			ftemp[key][-1].addLine(t)
+
 	tf.close()
 
 	# add the callgraph data to the device hierarchy
 	for key in ftemp:
 		proc, pid = key
 		for cg in ftemp[key]:
-			if len(cg.list) < 1 or cg.invalid:
+			if len(cg.list) < 1 or cg.invalid or (cg.end - cg.start == 0):
 				continue
 			if(not cg.postProcess()):
 				print('Sanity check failed for %s-%d' % (proc, pid))
 				continue
 			# match cg data to devices
-			if not data.deviceMatch(pid, cg):
-				print ' BAD: %s %s-%d [%f - %f]' % (cg.name, proc, pid, cg.start, cg.end)
+			devname = data.deviceMatch(pid, cg)
+			if not devname:
+				kind = 'Orphan'
+				if cg.partial:
+					kind = 'Partial'
+				sysvals.vprint('%s callgraph found for %s %s-%d [%f - %f]' %\
+					(kind, cg.name, proc, pid, cg.start, cg.end))
+			elif len(cg.list) > 1000000:
+				print 'WARNING: the callgraph found for %s is massive! (%d lines)' %\
+					(devname, len(cg.list))
 
 # Function: retrieveLogs
 # Description:
@@ -473,7 +521,7 @@ def createBootGraph(data):
 	devtl = aslib.Timeline(100, 20)
 
 	# write the test title and general info header
-	devtl.createHeader(sysvals)
+	devtl.createHeader(sysvals, sysvals.stamp)
 
 	# Generate the header for this timeline
 	t0 = data.start
@@ -574,12 +622,9 @@ def createBootGraph(data):
 			data.dmesg[phase]['color'], phase+'_mode', phase[0])
 	devtl.html += '</div>\n'
 
-	if(sysvals.outfile == sysvals.htmlfile):
-		hf = open(sysvals.htmlfile, 'a')
-	else:
-		hf = open(sysvals.htmlfile, 'w')
+	hf = open(sysvals.htmlfile, 'w')
 
-	# add the css if this is not an embedded run
+	# add the css
 	extra = '\
 		.c1 {background:rgba(209,0,0,0.4);}\n\
 		.c2 {background:rgba(255,102,34,0.4);}\n\
@@ -597,8 +642,7 @@ def createBootGraph(data):
 		.fstat td {text-align:left;width:35px;}\n\
 		.srccall {position:absolute;font-size:10px;z-index:7;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,#CCC,#969696);}\n\
 		.srccall:hover {color:white;font-weight:bold;border:1px solid white;}\n'
-	if(not sysvals.embedded):
-		aslib.addCSS(hf, sysvals, 1, False, extra)
+	aslib.addCSS(hf, sysvals, 1, False, extra)
 
 	# write the device timeline
 	hf.write(devtl.html)
@@ -631,6 +675,9 @@ def createBootGraph(data):
 	if(sysvals.usecallgraph):
 		aslib.addCallgraphs(sysvals, hf, data)
 
+	# add the test log as a hidden div
+	if sysvals.testlog and sysvals.logmsg:
+		hf.write('<div id="testlog" style="display:none;">\n'+sysvals.logmsg+'</div>\n')
 	# add the dmesg log as a hidden div
 	if sysvals.dmesglog:
 		hf.write('<div id="dmesglog" style="display:none;">\n')
@@ -639,14 +686,9 @@ def createBootGraph(data):
 			hf.write(line)
 		hf.write('</div>\n')
 
-	if(not sysvals.embedded):
-		# write the footer and close
-		aslib.addScriptCode(hf, [data])
-		hf.write('</body>\n</html>\n')
-	else:
-		# embedded out will be loaded in a page, skip the js
-		hf.write('<div id=bounds style=display:none>%f,%f</div>' % \
-			(data.start*1000, data.end*1000))
+	# write the footer and close
+	aslib.addScriptCode(hf, [data])
+	hf.write('</body>\n</html>\n')
 	hf.close()
 	return True
 
@@ -780,6 +822,7 @@ def doError(msg, help=False):
 	if help == True:
 		printHelp()
 	print 'ERROR: %s\n' % msg
+	sysvals.outputResult({'error':msg})
 	sys.exit()
 
 # Function: printHelp
@@ -806,18 +849,21 @@ def printHelp():
 	print('Options:')
 	print('  -h            Print this help text')
 	print('  -v            Print the current tool version')
+	print('  -verbose      Print extra information during execution and analysis')
 	print('  -addlogs      Add the dmesg log to the html output')
+	print('  -result fn    Export a results table to a text file for parsing.')
 	print('  -o name       Overrides the output subdirectory name when running a new test')
 	print('                default: boot-{date}-{time}')
 	print(' [advanced]')
-	print('  -f            Use ftrace to add function detail (default: disabled)')
-	print('  -callgraph    Add callgraph detail, can be very large (default: disabled)')
+	print('  -fstat        Use ftrace to add function detail and statistics (default: disabled)')
+	print('  -f/-callgraph Add callgraph detail, can be very large (default: disabled)')
 	print('  -maxdepth N   limit the callgraph data to N call levels (default: 2)')
 	print('  -mincg ms     Discard all callgraphs shorter than ms milliseconds (e.g. 0.001 for us)')
 	print('  -timeprec N   Number of significant digits in timestamps (0:S, 3:ms, [6:us])')
 	print('  -expandcg     pre-expand the callgraph data in the html output (default: disabled)')
 	print('  -func list    Limit ftrace to comma-delimited list of functions (default: do_one_initcall)')
 	print('  -cgfilter S   Filter the callgraph output in the timeline')
+	print('  -cgskip file  Callgraph functions to skip, off to disable (default: cgskip.txt)')
 	print('  -bl name      Use the following boot loader for kernel params (default: grub)')
 	print('  -reboot       Reboot the machine automatically and generate a new timeline')
 	print('  -manual       Show the steps to generate a new timeline manually (used with -reboot)')
@@ -837,8 +883,13 @@ if __name__ == '__main__':
 	# loop through the command line arguments
 	cmd = ''
 	testrun = True
+	switchoff = ['disable', 'off', 'false', '0']
 	simplecmds = ['-sysinfo', '-kpupdate', '-flistall', '-checkbl']
+	cgskip = ''
+	if '-f' in sys.argv:
+		cgskip = sysvals.configFile('cgskip.txt')
 	args = iter(sys.argv[1:])
+	mdset = False
 	for arg in args:
 		if(arg == '-h'):
 			printHelp()
@@ -846,13 +897,17 @@ if __name__ == '__main__':
 		elif(arg == '-v'):
 			print("Version %s" % sysvals.version)
 			sys.exit()
+		elif(arg == '-verbose'):
+			sysvals.verbose = True
 		elif(arg in simplecmds):
 			cmd = arg[1:]
-		elif(arg == '-f'):
+		elif(arg == '-fstat'):
 			sysvals.useftrace = True
-		elif(arg == '-callgraph'):
+		elif(arg == '-callgraph' or arg == '-f'):
 			sysvals.useftrace = True
 			sysvals.usecallgraph = True
+		elif(arg == '-cgdump'):
+			sysvals.cgdump = True
 		elif(arg == '-mincg'):
 			sysvals.mincglen = aslib.getArgFloat('-mincg', args, 0.0, 10000.0)
 		elif(arg == '-cgfilter'):
@@ -860,7 +915,18 @@ if __name__ == '__main__':
 				val = args.next()
 			except:
 				doError('No callgraph functions supplied', True)
-			sysvals.setDeviceFilter(val)
+			sysvals.setCallgraphFilter(val)
+		elif(arg == '-cgskip'):
+			try:
+				val = args.next()
+			except:
+				doError('No file supplied', True)
+			if val.lower() in switchoff:
+				cgskip = ''
+			else:
+				cgskip = sysvals.configFile(val)
+				if(not cgskip):
+					doError('%s does not exist' % cgskip)
 		elif(arg == '-bl'):
 			try:
 				val = args.next()
@@ -872,6 +938,7 @@ if __name__ == '__main__':
 		elif(arg == '-timeprec'):
 			sysvals.setPrecision(aslib.getArgInt('-timeprec', args, 0, 6))
 		elif(arg == '-maxdepth'):
+			mdset = True
 			sysvals.max_graph_depth = aslib.getArgInt('-maxdepth', args, 0, 1000)
 		elif(arg == '-func'):
 			try:
@@ -902,8 +969,6 @@ if __name__ == '__main__':
 				doError('No dmesg file supplied', True)
 			if(os.path.exists(val) == False):
 				doError('%s does not exist' % val)
-			if(sysvals.htmlfile == val or sysvals.outfile == val):
-				doError('Output filename collision')
 			testrun = False
 			sysvals.dmesgfile = val
 		elif(arg == '-o'):
@@ -912,6 +977,12 @@ if __name__ == '__main__':
 			except:
 				doError('No subdirectory name supplied', True)
 			sysvals.testdir = sysvals.setOutputFolder(val)
+		elif(arg == '-result'):
+			try:
+				val = args.next()
+			except:
+				doError('No result file supplied', True)
+			sysvals.result = val
 		elif(arg == '-reboot'):
 			sysvals.reboot = True
 		elif(arg == '-manual'):
@@ -947,7 +1018,7 @@ if __name__ == '__main__':
 			sysvals.getBootLoader()
 			print 'Boot Loader: %s\n%s' % (sysvals.bootloader, sysvals.blexec)
 		elif(cmd == 'sysinfo'):
-			sysvals.printSystemInfo()
+			sysvals.printSystemInfo(True)
 		sys.exit()
 
 	# reboot: update grub, setup a cronjob, and reboot
@@ -963,6 +1034,10 @@ if __name__ == '__main__':
 			sysvals.manualRebootRequired()
 		sys.exit()
 
+	if sysvals.usecallgraph and cgskip:
+		sysvals.vprint('Using cgskip file: %s' % cgskip)
+		sysvals.setCallgraphBlacklist(cgskip)
+
 	# cronjob: remove the cronjob, grub changes, and disable ftrace
 	if sysvals.iscronjob:
 		updateCron(True)
@@ -980,29 +1055,23 @@ if __name__ == '__main__':
 
 	# process the log data
 	if sysvals.dmesgfile:
+		if not mdset:
+			sysvals.max_graph_depth = 0
 		data = parseKernelLog()
 		if(not data.valid):
 			doError('No initcall data found in %s' % sysvals.dmesgfile)
 		if sysvals.useftrace and sysvals.ftracefile:
 			parseTraceLog(data)
+		if sysvals.cgdump:
+			data.debugPrint()
+			sys.exit()
 	else:
 		doError('dmesg file required')
 
-	print('          Host: %s' % sysvals.hostname)
-	print('     Test time: %s' % sysvals.testtime)
-	print('     Boot time: %s' % data.boottime)
-	print('Kernel Version: %s' % sysvals.kernel)
-	print('  Kernel start: %.3f' % (data.start * 1000))
-	print('Usermode start: %.3f' % (data.tUserMode * 1000))
-	print('Last Init Call: %.3f' % (data.end * 1000))
-
-	# handle embedded output logs
-	if(sysvals.outfile and sysvals.embedded):
-		fp = open(sysvals.outfile, 'w')
-		fp.write('pass %s initstart %.3f end %.3f boot %s\n' %
-			(data.valid, data.tUserMode*1000, data.end*1000, data.boottime))
-		fp.close()
-
+	sysvals.vprint('Creating the html timeline (%s)...' % sysvals.htmlfile)
+	sysvals.vprint('Command:\n    %s' % sysvals.cmdline)
+	sysvals.vprint('Kernel parameters:\n    %s' % sysvals.kparams)
+	data.printDetails()
 	createBootGraph(data)
 
 	# if running as root, change output dir owner to sudo_user
@@ -1010,3 +1079,7 @@ if __name__ == '__main__':
 		os.getuid() == 0 and 'SUDO_USER' in os.environ:
 		cmd = 'chown -R {0}:{0} {1} > /dev/null 2>&1'
 		call(cmd.format(os.environ['SUDO_USER'], sysvals.testdir), shell=True)
+
+	sysvals.stamp['boot'] = (data.tUserMode - data.start) * 1000
+	sysvals.stamp['lastinit'] = data.end * 1000
+	sysvals.outputResult(sysvals.stamp)
-- 
2.14.1
