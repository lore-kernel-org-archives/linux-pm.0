From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 5/5] scripts: AnalyzeSuspend v4.2 part5
Date: Thu, 14 Jul 2016 14:09:29 -0700
Message-ID: <9c23473ec65780b3d190b9f4db9da36971a930b7.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65217 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcGNVJh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 17:09:37 -0400
In-Reply-To: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 scripts/analyze_suspend.py | 356 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 274 insertions(+), 82 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index b93bb07..a0ba48f 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -4370,6 +4370,25 @@ def getArgInt(name, args, min, max, main=True):
 		doError(name+': value should be between %d and %d' % (min, max), True)
 	return val
 
+# Function: getArgFloat
+# Description:
+#	 pull out a float argument from the command line with checks
+def getArgFloat(name, args, min, max, main=True):
+	if main:
+		try:
+			arg = args.next()
+		except:
+			doError(name+': no argument supplied', True)
+	else:
+		arg = args
+	try:
+		val = float(arg)
+	except:
+		doError(name+': non-numerical value given', True)
+	if(val < min or val > max):
+		doError(name+': value should be between %f and %f' % (min, max), True)
+	return val
+
 # Function: rerunTest
 # Description:
 #	 generate an output from an existing set of ftrace/dmesg logs
@@ -4397,15 +4416,12 @@ def rerunTest():
 # Function: runTest
 # Description:
 #	 execute a suspend/resume, gather the logs, and generate the output
-def runTest(subdir):
+def runTest(subdir, testpath=''):
 	global sysvals
 
 	# prepare for the test
-	if(not sysvals.android):
-		initFtrace()
-	else:
-		initFtraceAndroid()
-	sysvals.initTestOutput(subdir)
+	sysvals.initFtrace()
+	sysvals.initTestOutput(subdir, testpath)
 
 	vprint('Output files:\n    %s' % sysvals.dmesgfile)
 	if(sysvals.usecallgraph or
@@ -4415,10 +4431,8 @@ def runTest(subdir):
 	vprint('    %s' % sysvals.htmlfile)
 
 	# execute the test
-	if(not sysvals.android):
-		executeSuspend()
-	else:
-		executeAndroidSuspend()
+	executeSuspend()
+	sysvals.cleanupFtrace()
 
 	# analyze the data and create the html output
 	print('PROCESSING DATA')
@@ -4482,6 +4496,153 @@ def runSummary(subdir, output):
 
 	createHTMLSummarySimple(testruns, subdir+'/summary.html')
 
+# Function: checkArgBool
+# Description:
+#	 check if a boolean string value is true or false
+def checkArgBool(value):
+	yes = ['1', 'true', 'yes', 'on']
+	if value.lower() in yes:
+		return True
+	return False
+
+# Function: configFromFile
+# Description:
+#	 Configure the script via the info in a config file
+def configFromFile(file):
+	global sysvals
+	Config = ConfigParser.ConfigParser()
+
+	ignorekprobes = False
+	Config.read(file)
+	sections = Config.sections()
+	if 'Settings' in sections:
+		for opt in Config.options('Settings'):
+			value = Config.get('Settings', opt).lower()
+			if(opt.lower() == 'verbose'):
+				sysvals.verbose = checkArgBool(value)
+			elif(opt.lower() == 'addlogs'):
+				sysvals.addlogs = checkArgBool(value)
+			elif(opt.lower() == 'dev'):
+				sysvals.usedevsrc = checkArgBool(value)
+			elif(opt.lower() == 'ignorekprobes'):
+				ignorekprobes = checkArgBool(value)
+			elif(opt.lower() == 'x2'):
+				if checkArgBool(value):
+					sysvals.execcount = 2
+			elif(opt.lower() == 'callgraph'):
+				sysvals.usecallgraph = checkArgBool(value)
+			elif(opt.lower() == 'callgraphfunc'):
+				sysvals.debugfuncs = []
+				if value:
+					value = value.split(',')
+				for i in value:
+					sysvals.debugfuncs.append(i.strip())
+			elif(opt.lower() == 'expandcg'):
+				sysvals.cgexp = checkArgBool(value)
+			elif(opt.lower() == 'srgap'):
+				if checkArgBool(value):
+					sysvals.srgap = 5
+			elif(opt.lower() == 'mode'):
+				sysvals.suspendmode = value
+			elif(opt.lower() == 'command'):
+				sysvals.testcommand = value
+			elif(opt.lower() == 'x2delay'):
+				sysvals.x2delay = getArgInt('-x2delay', value, 0, 60000, False)
+			elif(opt.lower() == 'postres'):
+				sysvals.postresumetime = getArgInt('-postres', value, 0, 3600, False)
+			elif(opt.lower() == 'rtcwake'):
+				sysvals.rtcwake = True
+				sysvals.rtcwaketime = getArgInt('-rtcwake', value, 0, 3600, False)
+			elif(opt.lower() == 'timeprec'):
+				sysvals.setPrecision(getArgInt('-timeprec', value, 0, 6, False))
+			elif(opt.lower() == 'mindev'):
+				sysvals.mindevlen = getArgFloat('-mindev', value, 0.0, 10000.0, False)
+			elif(opt.lower() == 'mincg'):
+				sysvals.mincglen = getArgFloat('-mincg', value, 0.0, 10000.0, False)
+			elif(opt.lower() == 'kprobecolor'):
+				try:
+					val = int(value, 16)
+					sysvals.kprobecolor = '#'+value
+				except:
+					sysvals.kprobecolor = value
+			elif(opt.lower() == 'synccolor'):
+				try:
+					val = int(value, 16)
+					sysvals.synccolor = '#'+value
+				except:
+					sysvals.synccolor = value
+			elif(opt.lower() == 'output-dir'):
+				args = dict()
+				n = datetime.now()
+				args['date'] = n.strftime('%y%m%d')
+				args['time'] = n.strftime('%H%M%S')
+				args['hostname'] = sysvals.hostname
+				sysvals.outdir = value.format(**args)
+
+	if sysvals.suspendmode == 'command' and not sysvals.testcommand:
+		doError('No command supplied for mode "command"', False)
+	if sysvals.usedevsrc and sysvals.usecallgraph:
+		doError('dev and callgraph cannot both be true', False)
+	if sysvals.usecallgraph and sysvals.execcount > 1:
+		doError('-x2 is not compatible with -f', False)
+
+	if ignorekprobes:
+		return
+
+	kprobes = dict()
+	archkprobe = 'Kprobe_'+platform.machine()
+	if archkprobe in sections:
+		for name in Config.options(archkprobe):
+			kprobes[name] = Config.get(archkprobe, name)
+	if 'Kprobe' in sections:
+		for name in Config.options('Kprobe'):
+			kprobes[name] = Config.get('Kprobe', name)
+
+	for name in kprobes:
+		function = name
+		format = name
+		color = ''
+		args = dict()
+		data = kprobes[name].split()
+		i = 0
+		for val in data:
+			# bracketted strings are special formatting, read them separately
+			if val[0] == '[' and val[-1] == ']':
+				for prop in val[1:-1].split(','):
+					p = prop.split('=')
+					if p[0] == 'color':
+						try:
+							color = int(p[1], 16)
+							color = '#'+p[1]
+						except:
+							color = p[1]
+				continue
+			# first real arg should be the format string
+			if i == 0:
+				format = val
+			# all other args are actual function args
+			else:
+				d = val.split('=')
+				args[d[0]] = d[1]
+			i += 1
+		if not function or not format:
+			doError('Invalid kprobe: %s' % name, False)
+		for arg in re.findall('{(?P<n>[a-z,A-Z,0-9]*)}', format):
+			if arg not in args:
+				doError('Kprobe "%s" is missing argument "%s"' % (name, arg), False)
+		if name in sysvals.kprobes:
+			doError('Duplicate kprobe found "%s"' % (name), False)
+		vprint('Adding KPROBE: %s %s %s %s' % (name, function, format, args))
+		sysvals.kprobes[name] = {
+			'name': name,
+			'func': function,
+			'format': format,
+			'args': args,
+			'mask': re.sub('{(?P<n>[a-z,A-Z,0-9]*)}', '.*', format)
+		}
+		if color:
+			sysvals.kprobes[name]['color'] = color
+
 # Function: printHelp
 # Description:
 #	 print out the help text
@@ -4490,7 +4651,7 @@ def printHelp():
 	modes = getModes()
 
 	print('')
-	print('AnalyzeSuspend v%.1f' % sysvals.version)
+	print('AnalyzeSuspend v%s' % sysvals.version)
 	print('Usage: sudo analyze_suspend.py <options>')
 	print('')
 	print('Description:')
@@ -4511,27 +4672,38 @@ def printHelp():
 	print('  [general]')
 	print('    -h          Print this help text')
 	print('    -v          Print the current tool version')
+	print('    -config file Pull arguments and config options from a file')
 	print('    -verbose    Print extra information during execution and analysis')
 	print('    -status     Test to see if the system is enabled to run this tool')
 	print('    -modes      List available suspend modes')
 	print('    -m mode     Mode to initiate for suspend %s (default: %s)') % (modes, sysvals.suspendmode)
-	print('    -rtcwake t  Use rtcwake to autoresume after <t> seconds (default: disabled)')
+	print('    -o subdir   Override the output subdirectory')
 	print('  [advanced]')
+	print('    -rtcwake t  Use rtcwake to autoresume after <t> seconds (default: disabled)')
+	print('    -addlogs    Add the dmesg and ftrace logs to the html output')
+	print('    -multi n d  Execute <n> consecutive tests at <d> seconds intervals. The outputs will')
+	print('                be created in a new subdirectory with a summary page.')
+	print('    -srgap      Add a visible gap in the timeline between sus/res (default: disabled)')
+	print('    -cmd {s}    Instead of suspend/resume, run a command, e.g. "sync -d"')
+	print('    -mindev ms  Discard all device blocks shorter than ms milliseconds (e.g. 0.001 for us)')
+	print('    -mincg  ms  Discard all callgraphs shorter than ms milliseconds (e.g. 0.001 for us)')
+	print('    -timeprec N Number of significant digits in timestamps (0:S, [3:ms], 6:us)')
+	print('  [debug]')
 	print('    -f          Use ftrace to create device callgraphs (default: disabled)')
-	print('    -filter "d1 d2 ..." Filter out all but this list of dev names')
+	print('    -expandcg   pre-expand the callgraph data in the html output (default: disabled)')
+	print('    -flist      Print the list of functions currently being captured in ftrace')
+	print('    -flistall   Print all functions capable of being captured in ftrace')
+	print('    -fadd file  Add functions to be graphed in the timeline from a list in a text file')
+	print('    -filter "d1 d2 ..." Filter out all but this list of device names')
+	print('    -dev        Display common low level functions in the timeline')
+	print('  [post-resume task analysis]')
 	print('    -x2         Run two suspend/resumes back to back (default: disabled)')
 	print('    -x2delay t  Minimum millisecond delay <t> between the two test runs (default: 0 ms)')
 	print('    -postres t  Time after resume completion to wait for post-resume events (default: 0 S)')
-	print('    -multi n d  Execute <n> consecutive tests at <d> seconds intervals. The outputs will')
-	print('                be created in a new subdirectory with a summary page.')
 	print('  [utilities]')
 	print('    -fpdt       Print out the contents of the ACPI Firmware Performance Data Table')
 	print('    -usbtopo    Print out the current USB topology with power info')
 	print('    -usbauto    Enable autosuspend for all connected USB devices')
-	print('  [android testing]')
-	print('    -adb binary Use the given adb binary to run the test on an android device.')
-	print('                The device should already be connected and with root access.')
-	print('                Commands will be executed on the device using "adb shell"')
 	print('  [re-analyze data from previous runs]')
 	print('    -ftrace ftracefile  Create HTML output using ftrace input')
 	print('    -dmesg dmesgfile    Create HTML output using dmesg (not needed for kernel >= 3.15)')
@@ -4545,6 +4717,7 @@ if __name__ == '__main__':
 	cmd = ''
 	cmdarg = ''
 	multitest = {'run': False, 'count': 0, 'delay': 0}
+	simplecmds = ['-modes', '-fpdt', '-flist', '-flistall', '-usbtopo', '-usbauto', '-status']
 	# loop through the command line arguments
 	args = iter(sys.argv[1:])
 	for arg in args:
@@ -4553,58 +4726,85 @@ if __name__ == '__main__':
 				val = args.next()
 			except:
 				doError('No mode supplied', True)
+			if val == 'command' and not sysvals.testcommand:
+				doError('No command supplied for mode "command"', True)
 			sysvals.suspendmode = val
-		elif(arg == '-adb'):
-			try:
-				val = args.next()
-			except:
-				doError('No adb binary supplied', True)
-			if(not os.path.exists(val)):
-				doError('file doesnt exist: %s' % val, False)
-			if(not os.access(val, os.X_OK)):
-				doError('file isnt executable: %s' % val, False)
-			try:
-				check = os.popen(val+' version').read().strip()
-			except:
-				doError('adb version failed to execute', False)
-			if(not re.match('Android Debug Bridge .*', check)):
-				doError('adb version failed to execute', False)
-			sysvals.adb = val
-			sysvals.android = True
+		elif(arg in simplecmds):
+			cmd = arg[1:]
+		elif(arg == '-h'):
+			printHelp()
+			sys.exit()
+		elif(arg == '-v'):
+			print("Version %s" % sysvals.version)
+			sys.exit()
 		elif(arg == '-x2'):
-			if(sysvals.postresumetime > 0):
-				doError('-x2 is not compatible with -postres', False)
 			sysvals.execcount = 2
+			if(sysvals.usecallgraph):
+				doError('-x2 is not compatible with -f', False)
 		elif(arg == '-x2delay'):
 			sysvals.x2delay = getArgInt('-x2delay', args, 0, 60000)
 		elif(arg == '-postres'):
-			if(sysvals.execcount != 1):
-				doError('-x2 is not compatible with -postres', False)
 			sysvals.postresumetime = getArgInt('-postres', args, 0, 3600)
 		elif(arg == '-f'):
 			sysvals.usecallgraph = True
-		elif(arg == '-modes'):
-			cmd = 'modes'
-		elif(arg == '-fpdt'):
-			cmd = 'fpdt'
-		elif(arg == '-usbtopo'):
-			cmd = 'usbtopo'
-		elif(arg == '-usbauto'):
-			cmd = 'usbauto'
-		elif(arg == '-status'):
-			cmd = 'status'
+			if(sysvals.execcount > 1):
+				doError('-x2 is not compatible with -f', False)
+			if(sysvals.usedevsrc):
+				doError('-dev is not compatible with -f', False)
+		elif(arg == '-addlogs'):
+			sysvals.addlogs = True
 		elif(arg == '-verbose'):
 			sysvals.verbose = True
-		elif(arg == '-v'):
-			print("Version %.1f" % sysvals.version)
-			sys.exit()
+		elif(arg == '-dev'):
+			sysvals.usedevsrc = True
+			if(sysvals.usecallgraph):
+				doError('-dev is not compatible with -f', False)
 		elif(arg == '-rtcwake'):
 			sysvals.rtcwake = True
 			sysvals.rtcwaketime = getArgInt('-rtcwake', args, 0, 3600)
+		elif(arg == '-timeprec'):
+			sysvals.setPrecision(getArgInt('-timeprec', args, 0, 6))
+		elif(arg == '-mindev'):
+			sysvals.mindevlen = getArgFloat('-mindev', args, 0.0, 10000.0)
+		elif(arg == '-mincg'):
+			sysvals.mincglen = getArgFloat('-mincg', args, 0.0, 10000.0)
+		elif(arg == '-cmd'):
+			try:
+				val = args.next()
+			except:
+				doError('No command string supplied', True)
+			sysvals.testcommand = val
+			sysvals.suspendmode = 'command'
+		elif(arg == '-expandcg'):
+			sysvals.cgexp = True
+		elif(arg == '-srgap'):
+			sysvals.srgap = 5
 		elif(arg == '-multi'):
 			multitest['run'] = True
 			multitest['count'] = getArgInt('-multi n (exec count)', args, 2, 1000000)
 			multitest['delay'] = getArgInt('-multi d (delay between tests)', args, 0, 3600)
+		elif(arg == '-o'):
+			try:
+				val = args.next()
+			except:
+				doError('No subdirectory name supplied', True)
+			sysvals.outdir = val
+		elif(arg == '-config'):
+			try:
+				val = args.next()
+			except:
+				doError('No text file supplied', True)
+			if(os.path.exists(val) == False):
+				doError('%s does not exist' % val, False)
+			configFromFile(val)
+		elif(arg == '-fadd'):
+			try:
+				val = args.next()
+			except:
+				doError('No text file supplied', True)
+			if(os.path.exists(val) == False):
+				doError('%s does not exist' % val, False)
+			sysvals.addFtraceFilterFunctions(val)
 		elif(arg == '-dmesg'):
 			try:
 				val = args.next()
@@ -4613,17 +4813,16 @@ if __name__ == '__main__':
 			sysvals.notestrun = True
 			sysvals.dmesgfile = val
 			if(os.path.exists(sysvals.dmesgfile) == False):
-				doError('%s doesnt exist' % sysvals.dmesgfile, False)
+				doError('%s does not exist' % sysvals.dmesgfile, False)
 		elif(arg == '-ftrace'):
 			try:
 				val = args.next()
 			except:
 				doError('No ftrace file supplied', True)
 			sysvals.notestrun = True
-			sysvals.usecallgraph = True
 			sysvals.ftracefile = val
 			if(os.path.exists(sysvals.ftracefile) == False):
-				doError('%s doesnt exist' % sysvals.ftracefile, False)
+				doError('%s does not exist' % sysvals.ftracefile, False)
 		elif(arg == '-summary'):
 			try:
 				val = args.next()
@@ -4633,35 +4832,35 @@ if __name__ == '__main__':
 			cmdarg = val
 			sysvals.notestrun = True
 			if(os.path.isdir(val) == False):
-				doError('%s isnt accesible' % val, False)
+				doError('%s is not accesible' % val, False)
 		elif(arg == '-filter'):
 			try:
 				val = args.next()
 			except:
 				doError('No devnames supplied', True)
 			sysvals.setDeviceFilter(val)
-		elif(arg == '-h'):
-			printHelp()
-			sys.exit()
 		else:
 			doError('Invalid argument: '+arg, True)
 
+	# callgraph size cannot exceed device size
+	if sysvals.mincglen < sysvals.mindevlen:
+		sysvals.mincglen = sysvals.mindevlen
+
 	# just run a utility command and exit
 	if(cmd != ''):
 		if(cmd == 'status'):
-			statusCheck()
+			statusCheck(True)
 		elif(cmd == 'fpdt'):
-			if(sysvals.android):
-				doError('cannot read FPDT on android device', False)
 			getFPDT(True)
 		elif(cmd == 'usbtopo'):
-			if(sysvals.android):
-				doError('cannot read USB topology '+\
-					'on an android device', False)
-			detectUSB(True)
+			detectUSB()
 		elif(cmd == 'modes'):
 			modes = getModes()
 			print modes
+		elif(cmd == 'flist'):
+			sysvals.getFtraceFilterFunctions(True)
+		elif(cmd == 'flistall'):
+			sysvals.getFtraceFilterFunctions(False)
 		elif(cmd == 'usbauto'):
 			setUSBDevicesAuto()
 		elif(cmd == 'summary'):
@@ -4669,15 +4868,6 @@ if __name__ == '__main__':
 			runSummary(cmdarg, True)
 		sys.exit()
 
-	# run test on android device
-	if(sysvals.android):
-		if(sysvals.usecallgraph):
-			doError('ftrace (-f) is not yet supported '+\
-				'in the android kernel', False)
-		if(sysvals.notestrun):
-			doError('cannot analyze test files on the '+\
-				'android device', False)
-
 	# if instructed, re-analyze existing data files
 	if(sysvals.notestrun):
 		rerunTest()
@@ -4689,18 +4879,20 @@ if __name__ == '__main__':
 		sys.exit()
 
 	if multitest['run']:
-		# run multiple tests in a separte subdirectory
+		# run multiple tests in a separate subdirectory
 		s = 'x%d' % multitest['count']
-		subdir = datetime.now().strftime('suspend-'+s+'-%m%d%y-%H%M%S')
-		os.mkdir(subdir)
+		if not sysvals.outdir:
+			sysvals.outdir = datetime.now().strftime('suspend-'+s+'-%m%d%y-%H%M%S')
+		if not os.path.isdir(sysvals.outdir):
+			os.mkdir(sysvals.outdir)
 		for i in range(multitest['count']):
 			if(i != 0):
 				print('Waiting %d seconds...' % (multitest['delay']))
 				time.sleep(multitest['delay'])
 			print('TEST (%d/%d) START' % (i+1, multitest['count']))
-			runTest(subdir)
+			runTest(sysvals.outdir)
 			print('TEST (%d/%d) COMPLETE' % (i+1, multitest['count']))
-		runSummary(subdir, False)
+		runSummary(sysvals.outdir, False)
 	else:
 		# run the test in the current directory
-		runTest(".")
+		runTest('.', sysvals.outdir)
-- 
2.1.4

