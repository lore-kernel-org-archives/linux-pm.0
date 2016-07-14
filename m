From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 3/5] scripts: AnalyzeSuspend v4.2 part3
Date: Thu, 14 Jul 2016 14:09:27 -0700
Message-ID: <8b237dcb25c2b6aabe1367c1ee5d9c5f00d5cce3.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:43378 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbcGNVJh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
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
 scripts/analyze_suspend.py | 906 ++++++++++++++++++++++++++-------------------
 1 file changed, 530 insertions(+), 376 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index bc782f7..c9c477e 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -2026,20 +2026,14 @@ def appendIncompleteTraceLog(testruns):
 		if(sysvals.usetraceevents):
 			for name in test.ttemp:
 				for event in test.ttemp[name]:
-					begin = event['begin']
-					end = event['end']
-					# if event starts before timeline start, expand timeline
-					if(begin < test.data.start):
-						test.data.setStart(begin)
-					# if event ends after timeline end, expand the timeline
-					if(end > test.data.end):
-						test.data.setEnd(end)
-					test.data.newActionGlobal(name, begin, end)
+					test.data.newActionGlobal(name, event['begin'], event['end'])
 
 		# add the callgraph data to the device hierarchy
 		for pid in test.ftemp:
 			for cg in test.ftemp[pid]:
-				if(not cg.sanityCheck()):
+				if len(cg.list) < 1 or cg.invalid:
+					continue
+				if(not cg.postProcess()):
 					id = 'task %s cpu %s' % (pid, m.group('cpu'))
 					vprint('Sanity check failed for '+\
 						id+', ignoring this callback')
@@ -2061,14 +2055,6 @@ def appendIncompleteTraceLog(testruns):
 		if(sysvals.verbose):
 			test.data.printDetails()
 
-
-	# add the time in between the tests as a new phase so we can see it
-	if(len(testruns) > 1):
-		t1e = testruns[0].getEnd()
-		t2s = testruns[-1].getStart()
-		testruns[-1].newPhaseWithSingleAction('user mode', \
-			'user mode', t1e, t2s, '#FF9966')
-
 # Function: parseTraceLog
 # Description:
 #	 Analyze an ftrace log output file generated from this app during
@@ -2082,9 +2068,16 @@ def parseTraceLog():
 
 	vprint('Analyzing the ftrace data...')
 	if(os.path.exists(sysvals.ftracefile) == False):
-		doError('%s doesnt exist' % sysvals.ftracefile, False)
+		doError('%s does not exist' % sysvals.ftracefile, False)
+
+	sysvals.setupAllKprobes()
+	tracewatch = ['suspend_enter']
+	if sysvals.usekprobes:
+		tracewatch += ['sync_filesystems', 'freeze_processes', 'syscore_suspend',
+			'syscore_resume', 'resume_console', 'thaw_processes', 'CPU_ON', 'CPU_OFF']
 
 	# extract the callgraph and traceevent data
+	tp = TestProps()
 	testruns = []
 	testdata = []
 	testrun = 0
@@ -2097,27 +2090,17 @@ def parseTraceLog():
 		# stamp line: each stamp means a new test run
 		m = re.match(sysvals.stampfmt, line)
 		if(m):
-			data = Data(len(testdata))
-			testdata.append(data)
-			testrun = TestRun(data)
-			testruns.append(testrun)
-			parseStamp(m, data)
-			continue
-		if(not data):
+			tp.stamp = line
 			continue
 		# firmware line: pull out any firmware data
 		m = re.match(sysvals.firmwarefmt, line)
 		if(m):
-			data.fwSuspend = int(m.group('s'))
-			data.fwResume = int(m.group('r'))
-			if(data.fwSuspend > 0 or data.fwResume > 0):
-				data.fwValid = True
+			tp.fwdata.append((int(m.group('s')), int(m.group('r'))))
 			continue
 		# tracer type line: determine the trace data type
 		m = re.match(sysvals.tracertypefmt, line)
 		if(m):
-			tracer = m.group('t')
-			testrun.setTracerType(tracer)
+			tp.setTracerType(m.group('t'))
 			continue
 		# post resume time line: did this test run include post-resume data
 		m = re.match(sysvals.postresumefmt, line)
@@ -2126,15 +2109,20 @@ def parseTraceLog():
 			if(t > 0):
 				sysvals.postresumetime = t
 			continue
+		# device properties line
+		if(re.match(sysvals.devpropfmt, line)):
+			devProps(line)
+			continue
 		# ftrace line: parse only valid lines
-		m = re.match(testrun.ftrace_line_fmt, line)
+		m = re.match(tp.ftrace_line_fmt, line)
 		if(not m):
 			continue
 		# gather the basic message data from the line
 		m_time = m.group('time')
+		m_proc = m.group('proc')
 		m_pid = m.group('pid')
 		m_msg = m.group('msg')
-		if(testrun.cgformat):
+		if(tp.cgformat):
 			m_param3 = m.group('dur')
 		else:
 			m_param3 = 'traceevent'
@@ -2146,24 +2134,38 @@ def parseTraceLog():
 		# the line should be a call, return, or event
 		if(not t.fcall and not t.freturn and not t.fevent):
 			continue
-		# only parse the ftrace data during suspend/resume
-		if(not testrun.inthepipe):
-			# look for the suspend start marker
-			if(t.fevent):
-				if(t.name == 'SUSPEND START'):
-					testrun.inthepipe = True
-					data.setStart(t.time)
+		# find the start of suspend
+		if(t.startMarker()):
+			phase = 'suspend_prepare'
+			data = Data(len(testdata))
+			testdata.append(data)
+			testrun = TestRun(data)
+			testruns.append(testrun)
+			parseStamp(tp.stamp, data)
+			if len(tp.fwdata) > data.testnumber:
+				data.fwSuspend, data.fwResume = tp.fwdata[data.testnumber]
+				if(data.fwSuspend > 0 or data.fwResume > 0):
+					data.fwValid = True
+			data.setStart(t.time)
+			continue
+		if(not data):
+			continue
+		# find the end of resume
+		if(t.endMarker()):
+			if(sysvals.usetracemarkers and sysvals.postresumetime > 0):
+				phase = 'post_resume'
+				data.newPhase(phase, t.time, t.time, '#F0F0F0', -1)
+			data.setEnd(t.time)
+			if(not sysvals.usetracemarkers):
+				# no trace markers? then quit and be sure to finish recording
+				# the event we used to trigger resume end
+				if(len(testrun.ttemp['thaw_processes']) > 0):
+					# if an entry exists, assume this is its end
+					testrun.ttemp['thaw_processes'][-1]['end'] = t.time
+				break
 			continue
 		# trace event processing
 		if(t.fevent):
-			if(t.name == 'RESUME COMPLETE'):
-				if(sysvals.postresumetime > 0):
-					phase = 'post_resume'
-					data.newPhase(phase, t.time, t.time, '#FF9966', -1)
-				else:
-					testrun.inthepipe = False
-				data.setEnd(t.time)
-				continue
 			if(phase == 'post_resume'):
 				data.setEnd(t.time)
 			if(t.type == 'suspend_resume'):
@@ -2185,8 +2187,7 @@ def parseTraceLog():
 					m = re.match('(?P<name>.*) .*', t.name)
 					name = m.group('name')
 				# ignore these events
-				if(re.match('acpi_suspend\[.*', t.name) or
-					re.match('suspend_enter\[.*', name)):
+				if(name.split('[')[0] in tracewatch):
 					continue
 				# -- phase changes --
 				# suspend_prepare start
@@ -2220,7 +2221,7 @@ def parseTraceLog():
 						data.dmesg[phase]['end'] = t.time
 						data.tSuspended = t.time
 					else:
-						if(sysvals.suspendmode in ['mem', 'disk']):
+						if(sysvals.suspendmode in ['mem', 'disk'] and not tp.S0i3):
 							data.dmesg['suspend_machine']['end'] = t.time
 							data.tSuspended = t.time
 						phase = 'resume_machine'
@@ -2228,6 +2229,15 @@ def parseTraceLog():
 						data.tResumed = t.time
 						data.tLow = data.tResumed - data.tSuspended
 					continue
+				# acpi_suspend
+				elif(re.match('acpi_suspend\[.*', t.name)):
+					# acpi_suspend[0] S0i3
+					if(re.match('acpi_suspend\[0\] begin', t.name)):
+						if(sysvals.suspendmode == 'mem'):
+							tp.S0i3 = True
+							data.dmesg['suspend_machine']['end'] = t.time
+							data.tSuspended = t.time
+					continue
 				# resume_noirq start
 				elif(re.match('dpm_resume_noirq\[.*', t.name)):
 					phase = 'resume_noirq'
@@ -2251,30 +2261,25 @@ def parseTraceLog():
 					if(isbegin):
 						data.dmesg[phase]['start'] = t.time
 					continue
-
-				# is this trace event outside of the devices calls
-				if(data.isTraceEventOutsideDeviceCalls(pid, t.time)):
-					# global events (outside device calls) are simply graphed
-					if(name not in testrun.ttemp):
-						testrun.ttemp[name] = []
-					if(isbegin):
-						# create a new list entry
-						testrun.ttemp[name].append(\
-							{'begin': t.time, 'end': t.time})
-					else:
-						if(len(testrun.ttemp[name]) > 0):
-							# if an antry exists, assume this is its end
-							testrun.ttemp[name][-1]['end'] = t.time
-						elif(phase == 'post_resume'):
-							# post resume events can just have ends
-							testrun.ttemp[name].append({
-								'begin': data.dmesg[phase]['start'],
-								'end': t.time})
+				# skip trace events inside devices calls
+				if(not data.isTraceEventOutsideDeviceCalls(pid, t.time)):
+					continue
+				# global events (outside device calls) are graphed
+				if(name not in testrun.ttemp):
+					testrun.ttemp[name] = []
+				if(isbegin):
+					# create a new list entry
+					testrun.ttemp[name].append(\
+						{'begin': t.time, 'end': t.time, 'pid': pid})
 				else:
-					if(isbegin):
-						data.addIntraDevTraceEvent('', name, pid, t.time)
-					else:
-						data.capIntraDevTraceEvent('', name, pid, t.time)
+					if(len(testrun.ttemp[name]) > 0):
+						# if an entry exists, assume this is its end
+						testrun.ttemp[name][-1]['end'] = t.time
+					elif(phase == 'post_resume'):
+						# post resume events can just have ends
+						testrun.ttemp[name].append({
+							'begin': data.dmesg[phase]['start'],
+							'end': t.time})
 			# device callback start
 			elif(t.type == 'device_pm_callback_start'):
 				m = re.match('(?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*',\
@@ -2297,75 +2302,127 @@ def parseTraceLog():
 					dev = list[n]
 					dev['length'] = t.time - dev['start']
 					dev['end'] = t.time
+		# kprobe event processing
+		elif(t.fkprobe):
+			kprobename = t.type
+			kprobedata = t.name
+			key = (kprobename, pid)
+			# displayname is generated from kprobe data
+			displayname = ''
+			if(t.fcall):
+				displayname = sysvals.kprobeDisplayName(kprobename, kprobedata)
+				if not displayname:
+					continue
+				if(key not in tp.ktemp):
+					tp.ktemp[key] = []
+				tp.ktemp[key].append({
+					'pid': pid,
+					'begin': t.time,
+					'end': t.time,
+					'name': displayname,
+					'cdata': kprobedata,
+					'proc': m_proc,
+				})
+			elif(t.freturn):
+				if(key not in tp.ktemp) or len(tp.ktemp[key]) < 1:
+					continue
+				e = tp.ktemp[key][-1]
+				if e['begin'] < 0.0 or t.time - e['begin'] < 0.000001:
+					tp.ktemp[key].pop()
+				else:
+					e['end'] = t.time
+					e['rdata'] = kprobedata
 		# callgraph processing
 		elif sysvals.usecallgraph:
-			# this shouldn't happen, but JIC, ignore callgraph data post-res
-			if(phase == 'post_resume'):
-				continue
 			# create a callgraph object for the data
-			if(pid not in testrun.ftemp):
-				testrun.ftemp[pid] = []
-				testrun.ftemp[pid].append(FTraceCallGraph())
+			key = (m_proc, pid)
+			if(key not in testrun.ftemp):
+				testrun.ftemp[key] = []
+				testrun.ftemp[key].append(FTraceCallGraph(pid))
 			# when the call is finished, see which device matches it
-			cg = testrun.ftemp[pid][-1]
-			if(cg.addLine(t, m)):
-				testrun.ftemp[pid].append(FTraceCallGraph())
+			cg = testrun.ftemp[key][-1]
+			if(cg.addLine(t)):
+				testrun.ftemp[key].append(FTraceCallGraph(pid))
 	tf.close()
 
+	if sysvals.suspendmode == 'command':
+		for test in testruns:
+			for p in test.data.phases:
+				if p == 'resume_complete':
+					test.data.dmesg[p]['start'] = test.data.start
+					test.data.dmesg[p]['end'] = test.data.end
+				else:
+					test.data.dmesg[p]['start'] = test.data.start
+					test.data.dmesg[p]['end'] = test.data.start
+			test.data.tSuspended = test.data.start
+			test.data.tResumed = test.data.start
+			test.data.tLow = 0
+			test.data.fwValid = False
+
 	for test in testruns:
 		# add the traceevent data to the device hierarchy
 		if(sysvals.usetraceevents):
+			# add actual trace funcs
 			for name in test.ttemp:
 				for event in test.ttemp[name]:
-					begin = event['begin']
-					end = event['end']
-					# if event starts before timeline start, expand timeline
-					if(begin < test.data.start):
-						test.data.setStart(begin)
-					# if event ends after timeline end, expand the timeline
-					if(end > test.data.end):
-						test.data.setEnd(end)
-					test.data.newActionGlobal(name, begin, end)
-
-		# add the callgraph data to the device hierarchy
-		borderphase = {
-			'dpm_prepare': 'suspend_prepare',
-			'dpm_complete': 'resume_complete'
-		}
-		for pid in test.ftemp:
-			for cg in test.ftemp[pid]:
-				if len(cg.list) < 2:
-					continue
-				if(not cg.sanityCheck()):
-					id = 'task %s cpu %s' % (pid, m.group('cpu'))
-					vprint('Sanity check failed for '+\
-						id+', ignoring this callback')
-					continue
-				callstart = cg.start
-				callend = cg.end
-				if(cg.list[0].name in borderphase):
-					p = borderphase[cg.list[0].name]
-					list = test.data.dmesg[p]['list']
-					for devname in list:
-						dev = list[devname]
-						if(pid == dev['pid'] and
-							callstart <= dev['start'] and
-							callend >= dev['end']):
-							dev['ftrace'] = cg.slice(dev['start'], dev['end'])
+					test.data.newActionGlobal(name, event['begin'], event['end'], event['pid'])
+			# add the kprobe based virtual tracefuncs as actual devices
+			for key in tp.ktemp:
+				name, pid = key
+				if name not in sysvals.tracefuncs:
 					continue
-				if(cg.list[0].name != 'dpm_run_callback'):
+				for e in tp.ktemp[key]:
+					kb, ke = e['begin'], e['end']
+					if kb == ke or not test.data.isInsideTimeline(kb, ke):
+						continue
+					test.data.newActionGlobal(e['name'], kb, ke, pid)
+			# add config base kprobes and dev kprobes
+			for key in tp.ktemp:
+				name, pid = key
+				if name in sysvals.tracefuncs:
 					continue
-				for p in test.data.phases:
-					if(test.data.dmesg[p]['start'] <= callstart and
-						callstart <= test.data.dmesg[p]['end']):
-						list = test.data.dmesg[p]['list']
-						for devname in list:
-							dev = list[devname]
-							if(pid == dev['pid'] and
-								callstart <= dev['start'] and
-								callend >= dev['end']):
-								dev['ftrace'] = cg
-						break
+				for e in tp.ktemp[key]:
+					kb, ke = e['begin'], e['end']
+					if kb == ke or not test.data.isInsideTimeline(kb, ke):
+						continue
+					color = sysvals.kprobeColor(e['name'])
+					if name not in sysvals.dev_tracefuncs:
+						# config base kprobe
+						test.data.newActionGlobal(e['name'], kb, ke, -2, color)
+					elif sysvals.usedevsrc:
+						# dev kprobe
+						data.addDeviceFunctionCall(e['name'], name, e['proc'], pid, kb,
+							ke, e['cdata'], e['rdata'])
+		if sysvals.usecallgraph:
+			# add the callgraph data to the device hierarchy
+			sortlist = dict()
+			for key in test.ftemp:
+				proc, pid = key
+				for cg in test.ftemp[key]:
+					if len(cg.list) < 1 or cg.invalid:
+						continue
+					if(not cg.postProcess()):
+						id = 'task %s' % (pid)
+						vprint('Sanity check failed for '+\
+							id+', ignoring this callback')
+						continue
+					# match cg data to devices
+					if sysvals.suspendmode == 'command' or not cg.deviceMatch(pid, test.data):
+						sortkey = '%f%f%d' % (cg.start, cg.end, pid)
+						sortlist[sortkey] = cg
+			# create blocks for orphan cg data
+			for sortkey in sorted(sortlist):
+				cg = sortlist[sortkey]
+				name = cg.list[0].name
+				if sysvals.isCallgraphFunc(name):
+					vprint('Callgraph found for task %d: %.3fms, %s' % (cg.pid, (cg.end - cg.start)*1000, name))
+					cg.newActionFromFunction(test.data)
+
+	if sysvals.suspendmode == 'command':
+		if(sysvals.verbose):
+			for data in testdata:
+				data.printDetails()
+		return testdata
 
 	# fill in any missing phases
 	for data in testdata:
@@ -2389,14 +2446,52 @@ def parseTraceLog():
 		if(sysvals.verbose):
 			data.printDetails()
 
-	# add the time in between the tests as a new phase so we can see it
-	if(len(testdata) > 1):
-		t1e = testdata[0].getEnd()
-		t2s = testdata[-1].getStart()
-		testdata[-1].newPhaseWithSingleAction('user mode', \
-			'user mode', t1e, t2s, '#FF9966')
 	return testdata
 
+# Function: loadRawKernelLog
+# Description:
+#	 Load a raw kernel log that wasn't created by this tool, it might be
+#	 possible to extract a valid suspend/resume log
+def loadRawKernelLog(dmesgfile):
+	global sysvals
+
+	stamp = {'time': '', 'host': '', 'mode': 'mem', 'kernel': ''}
+	stamp['time'] = datetime.now().strftime('%B %d %Y, %I:%M:%S %p')
+	stamp['host'] = sysvals.hostname
+
+	testruns = []
+	data = 0
+	lf = open(dmesgfile, 'r')
+	for line in lf:
+		line = line.replace('\r\n', '')
+		idx = line.find('[')
+		if idx > 1:
+			line = line[idx:]
+		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+		if(not m):
+			continue
+		msg = m.group("msg")
+		m = re.match('PM: Syncing filesystems.*', msg)
+		if(m):
+			if(data):
+				testruns.append(data)
+			data = Data(len(testruns))
+			data.stamp = stamp
+		if(data):
+			m = re.match('.* *(?P<k>[0-9]\.[0-9]{2}\.[0-9]-.*) .*', msg)
+			if(m):
+				stamp['kernel'] = m.group('k')
+			m = re.match('PM: Preparing system for (?P<m>.*) sleep', msg)
+			if(m):
+				stamp['mode'] = m.group('m')
+			data.dmesgtext.append(line)
+	if(data):
+		testruns.append(data)
+		sysvals.stamp = stamp
+		sysvals.suspendmode = stamp['mode']
+	lf.close()
+	return testruns
+
 # Function: loadKernelLog
 # Description:
 #	 [deprecated for kernel 3.15.0 or newer]
@@ -2409,9 +2504,10 @@ def loadKernelLog():
 
 	vprint('Analyzing the dmesg data...')
 	if(os.path.exists(sysvals.dmesgfile) == False):
-		doError('%s doesnt exist' % sysvals.dmesgfile, False)
+		doError('%s does not exist' % sysvals.dmesgfile, False)
 
-	# there can be multiple test runs in a single file delineated by stamps
+	# there can be multiple test runs in a single file
+	tp = TestProps()
 	testruns = []
 	data = 0
 	lf = open(sysvals.dmesgfile, 'r')
@@ -2422,35 +2518,43 @@ def loadKernelLog():
 			line = line[idx:]
 		m = re.match(sysvals.stampfmt, line)
 		if(m):
-			if(data):
-				testruns.append(data)
-			data = Data(len(testruns))
-			parseStamp(m, data)
-			continue
-		if(not data):
+			tp.stamp = line
 			continue
 		m = re.match(sysvals.firmwarefmt, line)
 		if(m):
-			data.fwSuspend = int(m.group('s'))
-			data.fwResume = int(m.group('r'))
-			if(data.fwSuspend > 0 or data.fwResume > 0):
-				data.fwValid = True
+			tp.fwdata.append((int(m.group('s')), int(m.group('r'))))
 			continue
 		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
-		if(m):
-			data.dmesgtext.append(line)
-			if(re.match('ACPI: resume from mwait', m.group('msg'))):
-				print('NOTE: This suspend appears to be freeze rather than'+\
-					' %s, it will be treated as such' % sysvals.suspendmode)
-				sysvals.suspendmode = 'freeze'
-		else:
-			vprint('ignoring dmesg line: %s' % line.replace('\n', ''))
-	testruns.append(data)
+		if(not m):
+			continue
+		msg = m.group("msg")
+		if(re.match('PM: Syncing filesystems.*', msg)):
+			if(data):
+				testruns.append(data)
+			data = Data(len(testruns))
+			parseStamp(tp.stamp, data)
+			if len(tp.fwdata) > data.testnumber:
+				data.fwSuspend, data.fwResume = tp.fwdata[data.testnumber]
+				if(data.fwSuspend > 0 or data.fwResume > 0):
+					data.fwValid = True
+		if(re.match('ACPI: resume from mwait', msg)):
+			print('NOTE: This suspend appears to be freeze rather than'+\
+				' %s, it will be treated as such' % sysvals.suspendmode)
+			sysvals.suspendmode = 'freeze'
+		if(not data):
+			continue
+		data.dmesgtext.append(line)
+	if(data):
+		testruns.append(data)
 	lf.close()
 
-	if(not data):
-		print('ERROR: analyze_suspend header missing from dmesg log')
-		sys.exit()
+	if(len(testruns) < 1):
+		# bad log, but see if you can extract something meaningful anyway
+		testruns = loadRawKernelLog(sysvals.dmesgfile)
+
+	if(len(testruns) < 1):
+		doError(' dmesg log is completely unreadable: %s' \
+			% sysvals.dmesgfile, False)
 
 	# fix lines with same timestamp/function with the call and return swapped
 	for data in testruns:
@@ -2667,7 +2771,8 @@ def parseKernelLog(data):
 						actions[a] = []
 					actions[a].append({'begin': ktime, 'end': ktime})
 				if(re.match(at[a]['emsg'], msg)):
-					actions[a][-1]['end'] = ktime
+					if(a in actions):
+						actions[a][-1]['end'] = ktime
 			# now look for CPU on/off events
 			if(re.match('Disabling non-boot CPUs .*', msg)):
 				# start of first cpu suspend
@@ -2714,15 +2819,7 @@ def parseKernelLog(data):
 	# fill in any actions we've found
 	for name in actions:
 		for event in actions[name]:
-			begin = event['begin']
-			end = event['end']
-			# if event starts before timeline start, expand timeline
-			if(begin < data.start):
-				data.setStart(begin)
-			# if event ends after timeline end, expand the timeline
-			if(end > data.end):
-				data.setEnd(end)
-			data.newActionGlobal(name, begin, end)
+			data.newActionGlobal(name, event['begin'], event['end'])
 
 	if(sysvals.verbose):
 		data.printDetails()
@@ -2731,92 +2828,6 @@ def parseKernelLog(data):
 	data.fixupInitcallsThatDidntReturn()
 	return True
 
-# Function: setTimelineRows
-# Description:
-#	 Organize the timeline entries into the smallest
-#	 number of rows possible, with no entry overlapping
-# Arguments:
-#	 list: the list of devices/actions for a single phase
-#	 sortedkeys: cronologically sorted key list to use
-# Output:
-#	 The total number of rows needed to display this phase of the timeline
-def setTimelineRows(list, sortedkeys):
-
-	# clear all rows and set them to undefined
-	remaining = len(list)
-	rowdata = dict()
-	row = 0
-	for item in list:
-		list[item]['row'] = -1
-
-	# try to pack each row with as many ranges as possible
-	while(remaining > 0):
-		if(row not in rowdata):
-			rowdata[row] = []
-		for item in sortedkeys:
-			if(list[item]['row'] < 0):
-				s = list[item]['start']
-				e = list[item]['end']
-				valid = True
-				for ritem in rowdata[row]:
-					rs = ritem['start']
-					re = ritem['end']
-					if(not (((s <= rs) and (e <= rs)) or
-						((s >= re) and (e >= re)))):
-						valid = False
-						break
-				if(valid):
-					rowdata[row].append(list[item])
-					list[item]['row'] = row
-					remaining -= 1
-		row += 1
-	return row
-
-# Function: createTimeScale
-# Description:
-#	 Create the timescale header for the html timeline
-# Arguments:
-#	 t0: start time (suspend begin)
-#	 tMax: end time (resume end)
-#	 tSuspend: time when suspend occurs, i.e. the zero time
-# Output:
-#	 The html code needed to display the time scale
-def createTimeScale(t0, tMax, tSuspended):
-	timescale = '<div class="t" style="right:{0}%">{1}</div>\n'
-	output = '<div id="timescale">\n'
-
-	# set scale for timeline
-	tTotal = tMax - t0
-	tS = 0.1
-	if(tTotal <= 0):
-		return output
-	if(tTotal > 4):
-		tS = 1
-	if(tSuspended < 0):
-		for i in range(int(tTotal/tS)+1):
-			pos = '%0.3f' % (100 - ((float(i)*tS*100)/tTotal))
-			if(i > 0):
-				val = '%0.fms' % (float(i)*tS*1000)
-			else:
-				val = ''
-			output += timescale.format(pos, val)
-	else:
-		tSuspend = tSuspended - t0
-		divTotal = int(tTotal/tS) + 1
-		divSuspend = int(tSuspend/tS)
-		s0 = (tSuspend - tS*divSuspend)*100/tTotal
-		for i in range(divTotal):
-			pos = '%0.3f' % (100 - ((float(i)*tS*100)/tTotal) - s0)
-			if((i == 0) and (s0 < 3)):
-				val = ''
-			elif(i == divSuspend):
-				val = 'S/R'
-			else:
-				val = '%0.fms' % (float(i-divSuspend)*tS*1000)
-			output += timescale.format(pos, val)
-	output += '</div>\n'
-	return output
-
 # Function: createHTMLSummarySimple
 # Description:
 #	 Create summary html file for a series of tests
@@ -2948,6 +2959,32 @@ def createHTMLSummarySimple(testruns, htmlfile):
 	hf.write('</body>\n</html>\n')
 	hf.close()
 
+def htmlTitle():
+	global sysvals
+	modename = {
+		'freeze': 'Freeze (S0)',
+		'standby': 'Standby (S1)',
+		'mem': 'Suspend (S3)',
+		'disk': 'Hibernate (S4)'
+	}
+	kernel = sysvals.stamp['kernel']
+	host = sysvals.hostname[0].upper()+sysvals.hostname[1:]
+	mode = sysvals.suspendmode
+	if sysvals.suspendmode in modename:
+		mode = modename[sysvals.suspendmode]
+	return host+' '+mode+' '+kernel
+
+def ordinal(value):
+	suffix = 'th'
+	if value < 10 or value > 19:
+		if value % 10 == 1:
+			suffix = 'st'
+		elif value % 10 == 2:
+			suffix = 'nd'
+		elif value % 10 == 3:
+			suffix = 'rd'
+	return '%d%s' % (value, suffix)
+
 # Function: createHTML
 # Description:
 #	 Create the output html file from the resident test data
@@ -2958,6 +2995,10 @@ def createHTMLSummarySimple(testruns, htmlfile):
 def createHTML(testruns):
 	global sysvals
 
+	if len(testruns) < 1:
+		print('ERROR: Not enough test data to build a timeline')
+		return
+
 	for data in testruns:
 		data.normalizeTime(testruns[-1].tSuspended)
 
@@ -2965,16 +3006,18 @@ def createHTML(testruns):
 	if len(testruns) > 1:
 		x2changes = ['1', 'relative']
 	# html function templates
+	headline_version = '<div class="version"><a href="https://01.org/suspendresume">AnalyzeSuspend v%s</a></div>' % sysvals.version
 	headline_stamp = '<div class="stamp">{0} {1} {2} {3}</div>\n'
 	html_devlist1 = '<button id="devlist1" class="devlist" style="float:left;">Device Detail%s</button>' % x2changes[0]
 	html_zoombox = '<center><button id="zoomin">ZOOM IN</button><button id="zoomout">ZOOM OUT</button><button id="zoomdef">ZOOM 1:1</button></center>\n'
 	html_devlist2 = '<button id="devlist2" class="devlist" style="float:right;">Device Detail2</button>\n'
 	html_timeline = '<div id="dmesgzoombox" class="zoombox">\n<div id="{0}" class="timeline" style="height:{1}px">\n'
-	html_device = '<div id="{0}" title="{1}" class="thread" style="left:{2}%;top:{3}%;height:{4}%;width:{5}%;">{6}</div>\n'
-	html_traceevent = '<div title="{0}" class="traceevent" style="left:{1}%;top:{2}%;height:{3}%;width:{4}%;border:1px solid {5};background-color:{5}">{6}</div>\n'
-	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}%;height:{3}%;background-color:{4}">{5}</div>\n'
+	html_tblock = '<div id="block{0}" class="tblock" style="left:{1}%;width:{2}%;">\n'
+	html_device = '<div id="{0}" title="{1}" class="thread{7}" style="left:{2}%;top:{3}px;height:{4}px;width:{5}%;{8}">{6}</div>\n'
+	html_traceevent = '<div title="{0}" class="traceevent" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;">{5}</div>\n'
+	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}px;height:{3}px;background-color:{4}">{5}</div>\n'
 	html_phaselet = '<div id="{0}" class="phaselet" style="left:{1}%;width:{2}%;background-color:{3}"></div>\n'
-	html_legend = '<div class="square" style="left:{0}%;background-color:{1}">&nbsp;{2}</div>\n'
+	html_legend = '<div id="p{3}" class="square" style="left:{0}%;background-color:{1}">&nbsp;{2}</div>\n'
 	html_timetotal = '<table class="time1">\n<tr>'\
 		'<td class="green">{2} Suspend Time: <b>{0} ms</b></td>'\
 		'<td class="yellow">{2} Resume Time: <b>{1} ms</b></td>'\
@@ -2984,6 +3027,10 @@ def createHTML(testruns):
 		'<td class="gray">'+sysvals.suspendmode+' time: <b>{1} ms</b></td>'\
 		'<td class="yellow">{3} Resume Time: <b>{2} ms</b></td>'\
 		'</tr>\n</table>\n'
+	html_timetotal3 = '<table class="time1">\n<tr>'\
+		'<td class="green">Execution Time: <b>{0} ms</b></td>'\
+		'<td class="yellow">Command: <b>{1}</b></td>'\
+		'</tr>\n</table>\n'
 	html_timegroups = '<table class="time2">\n<tr>'\
 		'<td class="green">{4}Kernel Suspend: {0} ms</td>'\
 		'<td class="purple">{4}Firmware Suspend: {1} ms</td>'\
@@ -2991,12 +3038,21 @@ def createHTML(testruns):
 		'<td class="yellow">{4}Kernel Resume: {3} ms</td>'\
 		'</tr>\n</table>\n'
 
+	# html format variables
+	rowheight = 30
+	devtextS = '14px'
+	devtextH = '30px'
+	hoverZ = 'z-index:10;'
+
+	if sysvals.usedevsrc:
+		hoverZ = ''
+
 	# device timeline
 	vprint('Creating Device Timeline...')
-	devtl = Timeline()
+
+	devtl = Timeline(rowheight)
 
 	# Generate the header for this timeline
-	textnum = ['First', 'Second']
 	for data in testruns:
 		tTotal = data.end - data.start
 		tEnd = data.dmesg['resume_complete']['end']
@@ -3005,7 +3061,17 @@ def createHTML(testruns):
 			sys.exit()
 		if(data.tLow > 0):
 			low_time = '%.0f'%(data.tLow*1000)
-		if data.fwValid:
+		if sysvals.suspendmode == 'command':
+			run_time = '%.0f'%((data.end-data.start)*1000)
+			if sysvals.testcommand:
+				testdesc = sysvals.testcommand
+			else:
+				testdesc = 'unknown'
+			if(len(testruns) > 1):
+				testdesc = ordinal(data.testnumber+1)+' '+testdesc
+			thtml = html_timetotal3.format(run_time, testdesc)
+			devtl.html['header'] += thtml
+		elif data.fwValid:
 			suspend_time = '%.0f'%((data.tSuspended-data.start)*1000 + \
 				(data.fwSuspend/1000000.0))
 			resume_time = '%.0f'%((tEnd-data.tSuspended)*1000 + \
@@ -3013,7 +3079,7 @@ def createHTML(testruns):
 			testdesc1 = 'Total'
 			testdesc2 = ''
 			if(len(testruns) > 1):
-				testdesc1 = testdesc2 = textnum[data.testnumber]
+				testdesc1 = testdesc2 = ordinal(data.testnumber+1)
 				testdesc2 += ' '
 			if(data.tLow == 0):
 				thtml = html_timetotal.format(suspend_time, \
@@ -3021,28 +3087,28 @@ def createHTML(testruns):
 			else:
 				thtml = html_timetotal2.format(suspend_time, low_time, \
 					resume_time, testdesc1)
-			devtl.html['timeline'] += thtml
+			devtl.html['header'] += thtml
 			sktime = '%.3f'%((data.dmesg['suspend_machine']['end'] - \
 				data.getStart())*1000)
 			sftime = '%.3f'%(data.fwSuspend / 1000000.0)
 			rftime = '%.3f'%(data.fwResume / 1000000.0)
-			rktime = '%.3f'%((data.getEnd() - \
+			rktime = '%.3f'%((data.dmesg['resume_complete']['end'] - \
 				data.dmesg['resume_machine']['start'])*1000)
-			devtl.html['timeline'] += html_timegroups.format(sktime, \
+			devtl.html['header'] += html_timegroups.format(sktime, \
 				sftime, rftime, rktime, testdesc2)
 		else:
 			suspend_time = '%.0f'%((data.tSuspended-data.start)*1000)
 			resume_time = '%.0f'%((tEnd-data.tSuspended)*1000)
 			testdesc = 'Kernel'
 			if(len(testruns) > 1):
-				testdesc = textnum[data.testnumber]+' '+testdesc
+				testdesc = ordinal(data.testnumber+1)+' '+testdesc
 			if(data.tLow == 0):
 				thtml = html_timetotal.format(suspend_time, \
 					resume_time, testdesc)
 			else:
 				thtml = html_timetotal2.format(suspend_time, low_time, \
 					resume_time, testdesc)
-			devtl.html['timeline'] += thtml
+			devtl.html['header'] += thtml
 
 	# time scale for potentially multiple datasets
 	t0 = testruns[0].start
@@ -3051,153 +3117,241 @@ def createHTML(testruns):
 	tTotal = tMax - t0
 
 	# determine the maximum number of rows we need to draw
-	timelinerows = 0
 	for data in testruns:
-		for phase in data.dmesg:
-			list = data.dmesg[phase]['list']
-			rows = setTimelineRows(list, list)
-			data.dmesg[phase]['row'] = rows
-			if(rows > timelinerows):
-				timelinerows = rows
-
-	# calculate the timeline height and create bounding box, add buttons
-	devtl.setRows(timelinerows + 1)
-	devtl.html['timeline'] += html_devlist1
-	if len(testruns) > 1:
-		devtl.html['timeline'] += html_devlist2
+		data.selectTimelineDevices('%f', tTotal, sysvals.mindevlen)
+		for group in data.devicegroups:
+			devlist = []
+			for phase in group:
+				for devname in data.tdevlist[phase]:
+					devlist.append((phase,devname))
+			devtl.getPhaseRows(data.dmesg, devlist)
+	devtl.calcTotalRows()
+
+	# create bounding box, add buttons
+	if sysvals.suspendmode != 'command':
+		devtl.html['timeline'] += html_devlist1
+		if len(testruns) > 1:
+			devtl.html['timeline'] += html_devlist2
 	devtl.html['timeline'] += html_zoombox
 	devtl.html['timeline'] += html_timeline.format('dmesg', devtl.height)
 
-	# draw the colored boxes for each of the phases
-	for data in testruns:
-		for b in data.dmesg:
-			phase = data.dmesg[b]
-			length = phase['end']-phase['start']
-			left = '%.3f' % (((phase['start']-t0)*100.0)/tTotal)
-			width = '%.3f' % ((length*100.0)/tTotal)
-			devtl.html['timeline'] += html_phase.format(left, width, \
-				'%.3f'%devtl.scaleH, '%.3f'%(100-devtl.scaleH), \
-				data.dmesg[b]['color'], '')
+	# draw the full timeline
+	phases = {'suspend':[],'resume':[]}
+	for phase in data.dmesg:
+		if 'resume' in phase:
+			phases['resume'].append(phase)
+		else:
+			phases['suspend'].append(phase)
 
-	# draw the time scale, try to make the number of labels readable
-	devtl.html['scale'] = createTimeScale(t0, tMax, tSuspended)
-	devtl.html['timeline'] += devtl.html['scale']
+	# draw each test run chronologically
 	for data in testruns:
-		for b in data.dmesg:
-			phaselist = data.dmesg[b]['list']
-			for d in phaselist:
-				name = d
-				drv = ''
-				dev = phaselist[d]
-				if(d in sysvals.altdevname):
-					name = sysvals.altdevname[d]
-				if('drv' in dev and dev['drv']):
-					drv = ' {%s}' % dev['drv']
-				height = (100.0 - devtl.scaleH)/data.dmesg[b]['row']
-				top = '%.3f' % ((dev['row']*height) + devtl.scaleH)
-				left = '%.3f' % (((dev['start']-t0)*100)/tTotal)
-				width = '%.3f' % (((dev['end']-dev['start'])*100)/tTotal)
-				length = ' (%0.3f ms) ' % ((dev['end']-dev['start'])*1000)
-				color = 'rgba(204,204,204,0.5)'
-				devtl.html['timeline'] += html_device.format(dev['id'], \
-					d+drv+length+b, left, top, '%.3f'%height, width, name+drv)
-
-	# draw any trace events found
-	for data in testruns:
-		for b in data.dmesg:
-			phaselist = data.dmesg[b]['list']
-			for name in phaselist:
-				dev = phaselist[name]
-				if('traceevents' in dev):
-					vprint('Debug trace events found for device %s' % name)
-					vprint('%20s %20s %10s %8s' % ('action', \
+		# if nore than one test, draw a block to represent user mode
+		if(data.testnumber > 0):
+			m0 = testruns[data.testnumber-1].end
+			mMax = testruns[data.testnumber].start
+			mTotal = mMax - m0
+			name = 'usermode%d' % data.testnumber
+			top = '%d' % devtl.scaleH
+			left = '%f' % (((m0-t0)*100.0)/tTotal)
+			width = '%f' % ((mTotal*100.0)/tTotal)
+			title = 'user mode (%0.3f ms) ' % (mTotal*1000)
+			devtl.html['timeline'] += html_device.format(name, \
+				title, left, top, '%d'%devtl.bodyH, width, '', '', '')
+		# now draw the actual timeline blocks
+		for dir in phases:
+			# draw suspend and resume blocks separately
+			bname = '%s%d' % (dir[0], data.testnumber)
+			if dir == 'suspend':
+				m0 = testruns[data.testnumber].start
+				mMax = testruns[data.testnumber].tSuspended
+				mTotal = mMax - m0
+				left = '%f' % (((m0-t0)*100.0)/tTotal)
+			else:
+				m0 = testruns[data.testnumber].tSuspended
+				mMax = testruns[data.testnumber].end
+				mTotal = mMax - m0
+				left = '%f' % ((((m0-t0)*100.0)+sysvals.srgap/2)/tTotal)
+			# if a timeline block is 0 length, skip altogether
+			if mTotal == 0:
+				continue
+			width = '%f' % (((mTotal*100.0)-sysvals.srgap/2)/tTotal)
+			devtl.html['timeline'] += html_tblock.format(bname, left, width)
+			for b in sorted(phases[dir]):
+				# draw the phase color background
+				phase = data.dmesg[b]
+				length = phase['end']-phase['start']
+				left = '%f' % (((phase['start']-m0)*100.0)/mTotal)
+				width = '%f' % ((length*100.0)/mTotal)
+				devtl.html['timeline'] += html_phase.format(left, width, \
+					'%.3f'%devtl.scaleH, '%.3f'%devtl.bodyH, \
+					data.dmesg[b]['color'], '')
+				# draw the devices for this phase
+				phaselist = data.dmesg[b]['list']
+				for d in data.tdevlist[b]:
+					name = d
+					drv = ''
+					dev = phaselist[d]
+					xtraclass = ''
+					xtrainfo = ''
+					xtrastyle = ''
+					if 'htmlclass' in dev:
+						xtraclass = dev['htmlclass']
+						xtrainfo = dev['htmlclass']
+					if 'color' in dev:
+						xtrastyle = 'background-color:%s;' % dev['color']
+					if(d in sysvals.devprops):
+						name = sysvals.devprops[d].altName(d)
+						xtraclass = sysvals.devprops[d].xtraClass()
+						xtrainfo = sysvals.devprops[d].xtraInfo()
+					if('drv' in dev and dev['drv']):
+						drv = ' {%s}' % dev['drv']
+					rowheight = devtl.phaseRowHeight(b, dev['row'])
+					rowtop = devtl.phaseRowTop(b, dev['row'])
+					top = '%.3f' % (rowtop + devtl.scaleH)
+					left = '%f' % (((dev['start']-m0)*100)/mTotal)
+					width = '%f' % (((dev['end']-dev['start'])*100)/mTotal)
+					length = ' (%0.3f ms) ' % ((dev['end']-dev['start'])*1000)
+					if sysvals.suspendmode == 'command':
+						title = name+drv+xtrainfo+length+'cmdexec'
+					else:
+						title = name+drv+xtrainfo+length+b
+					devtl.html['timeline'] += html_device.format(dev['id'], \
+						title, left, top, '%.3f'%rowheight, width, \
+						d+drv, xtraclass, xtrastyle)
+					if('src' not in dev):
+						continue
+					# draw any trace events for this device
+					vprint('Debug trace events found for device %s' % d)
+					vprint('%20s %20s %10s %8s' % ('title', \
 						'name', 'time(ms)', 'length(ms)'))
-					for e in dev['traceevents']:
-						vprint('%20s %20s %10.3f %8.3f' % (e.action, \
-							e.name, e.time*1000, e.length*1000))
-						height = (100.0 - devtl.scaleH)/data.dmesg[b]['row']
-						top = '%.3f' % ((dev['row']*height) + devtl.scaleH)
-						left = '%.3f' % (((e.time-t0)*100)/tTotal)
-						width = '%.3f' % (e.length*100/tTotal)
+					for e in dev['src']:
+						vprint('%20s %20s %10.3f %8.3f' % (e.title, \
+							e.text, e.time*1000, e.length*1000))
+						height = devtl.rowH
+						top = '%.3f' % (rowtop + devtl.scaleH + (e.row*devtl.rowH))
+						left = '%f' % (((e.time-m0)*100)/mTotal)
+						width = '%f' % (e.length*100/mTotal)
 						color = 'rgba(204,204,204,0.5)'
 						devtl.html['timeline'] += \
-							html_traceevent.format(e.action+' '+e.name, \
+							html_traceevent.format(e.title, \
 								left, top, '%.3f'%height, \
-								width, e.color, '')
+								width, e.text)
+			# draw the time scale, try to make the number of labels readable
+			devtl.html['timeline'] += devtl.createTimeScale(m0, mMax, tTotal, dir)
+			devtl.html['timeline'] += '</div>\n'
 
 	# timeline is finished
 	devtl.html['timeline'] += '</div>\n</div>\n'
 
 	# draw a legend which describes the phases by color
-	data = testruns[-1]
-	devtl.html['legend'] = '<div class="legend">\n'
-	pdelta = 100.0/len(data.phases)
-	pmargin = pdelta / 4.0
-	for phase in data.phases:
-		order = '%.2f' % ((data.dmesg[phase]['order'] * pdelta) + pmargin)
-		name = string.replace(phase, '_', ' &nbsp;')
-		devtl.html['legend'] += html_legend.format(order, \
-			data.dmesg[phase]['color'], name)
-	devtl.html['legend'] += '</div>\n'
+	if sysvals.suspendmode != 'command':
+		data = testruns[-1]
+		devtl.html['legend'] = '<div class="legend">\n'
+		pdelta = 100.0/len(data.phases)
+		pmargin = pdelta / 4.0
+		for phase in data.phases:
+			tmp = phase.split('_')
+			id = tmp[0][0]
+			if(len(tmp) > 1):
+				id += tmp[1][0]
+			order = '%.2f' % ((data.dmesg[phase]['order'] * pdelta) + pmargin)
+			name = string.replace(phase, '_', ' &nbsp;')
+			devtl.html['legend'] += html_legend.format(order, \
+				data.dmesg[phase]['color'], name, id)
+		devtl.html['legend'] += '</div>\n'
 
 	hf = open(sysvals.htmlfile, 'w')
-	thread_height = 0
+
+	if not sysvals.cgexp:
+		cgchk = 'checked'
+		cgnchk = 'not(:checked)'
+	else:
+		cgchk = 'not(:checked)'
+		cgnchk = 'checked'
 
 	# write the html header first (html head, css code, up to body start)
 	html_header = '<!DOCTYPE html>\n<html>\n<head>\n\
 	<meta http-equiv="content-type" content="text/html; charset=UTF-8">\n\
-	<title>AnalyzeSuspend</title>\n\
+	<title>'+htmlTitle()+'</title>\n\
 	<style type=\'text/css\'>\n\
-		body {overflow-y: scroll;}\n\
-		.stamp {width: 100%;text-align:center;background-color:gray;line-height:30px;color:white;font: 25px Arial;}\n\
-		.callgraph {margin-top: 30px;box-shadow: 5px 5px 20px black;}\n\
-		.callgraph article * {padding-left: 28px;}\n\
-		h1 {color:black;font: bold 30px Times;}\n\
-		t0 {color:black;font: bold 30px Times;}\n\
-		t1 {color:black;font: 30px Times;}\n\
-		t2 {color:black;font: 25px Times;}\n\
-		t3 {color:black;font: 20px Times;white-space:nowrap;}\n\
-		t4 {color:black;font: bold 30px Times;line-height:60px;white-space:nowrap;}\n\
+		body {overflow-y:scroll;}\n\
+		.stamp {width:100%;text-align:center;background-color:gray;line-height:30px;color:white;font:25px Arial;}\n\
+		.callgraph {margin-top:30px;box-shadow:5px 5px 20px black;}\n\
+		.callgraph article * {padding-left:28px;}\n\
+		h1 {color:black;font:bold 30px Times;}\n\
+		t0 {color:black;font:bold 30px Times;}\n\
+		t1 {color:black;font:30px Times;}\n\
+		t2 {color:black;font:25px Times;}\n\
+		t3 {color:black;font:20px Times;white-space:nowrap;}\n\
+		t4 {color:black;font:bold 30px Times;line-height:60px;white-space:nowrap;}\n\
+		cS {color:blue;font:bold 11px Times;}\n\
+		cR {color:red;font:bold 11px Times;}\n\
 		table {width:100%;}\n\
 		.gray {background-color:rgba(80,80,80,0.1);}\n\
 		.green {background-color:rgba(204,255,204,0.4);}\n\
 		.purple {background-color:rgba(128,0,128,0.2);}\n\
 		.yellow {background-color:rgba(255,255,204,0.4);}\n\
-		.time1 {font: 22px Arial;border:1px solid;}\n\
-		.time2 {font: 15px Arial;border-bottom:1px solid;border-left:1px solid;border-right:1px solid;}\n\
-		td {text-align: center;}\n\
+		.time1 {font:22px Arial;border:1px solid;}\n\
+		.time2 {font:15px Arial;border-bottom:1px solid;border-left:1px solid;border-right:1px solid;}\n\
+		td {text-align:center;}\n\
 		r {color:#500000;font:15px Tahoma;}\n\
 		n {color:#505050;font:15px Tahoma;}\n\
-		.tdhl {color: red;}\n\
-		.hide {display: none;}\n\
-		.pf {display: none;}\n\
-		.pf:checked + label {background: url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/><rect x="8" y="4" width="2" height="10" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
-		.pf:not(:checked) ~ label {background: url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
-		.pf:checked ~ *:not(:nth-child(2)) {display: none;}\n\
-		.zoombox {position: relative; width: 100%; overflow-x: scroll;}\n\
-		.timeline {position: relative; font-size: 14px;cursor: pointer;width: 100%; overflow: hidden; background-color:#dddddd;}\n\
-		.thread {position: absolute; height: '+'%.3f'%thread_height+'%; overflow: hidden; line-height: 30px; border:1px solid;text-align:center;white-space:nowrap;background-color:rgba(204,204,204,0.5);}\n\
-		.thread:hover {background-color:white;border:1px solid red;z-index:10;}\n\
-		.hover {background-color:white;border:1px solid red;z-index:10;}\n\
-		.traceevent {position: absolute;opacity: 0.3;height: '+'%.3f'%thread_height+'%;width:0;overflow:hidden;line-height:30px;text-align:center;white-space:nowrap;}\n\
-		.phase {position: absolute;overflow: hidden;border:0px;text-align:center;}\n\
+		.tdhl {color:red;}\n\
+		.hide {display:none;}\n\
+		.pf {display:none;}\n\
+		.pf:'+cgchk+' + label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/><rect x="8" y="4" width="2" height="10" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
+		.pf:'+cgnchk+' ~ label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
+		.pf:'+cgchk+' ~ *:not(:nth-child(2)) {display:none;}\n\
+		.zoombox {position:relative;width:100%;overflow-x:scroll;}\n\
+		.timeline {position:relative;font-size:14px;cursor:pointer;width:100%; overflow:hidden;background:linear-gradient(#cccccc, white);}\n\
+		.thread {position:absolute;height:0%;overflow:hidden;line-height:'+devtextH+';font-size:'+devtextS+';border:1px solid;text-align:center;white-space:nowrap;background-color:rgba(204,204,204,0.5);}\n\
+		.thread.sync {background-color:'+sysvals.synccolor+';}\n\
+		.thread.bg {background-color:'+sysvals.kprobecolor+';}\n\
+		.thread:hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
+		.hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
+		.hover.sync {background-color:white;}\n\
+		.hover.bg {background-color:white;}\n\
+		.traceevent {position:absolute;font-size:10px;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,rgba(204,204,204,1),rgba(150,150,150,1));}\n\
+		.traceevent:hover {background:white;}\n\
+		.phase {position:absolute;overflow:hidden;border:0px;text-align:center;}\n\
 		.phaselet {position:absolute;overflow:hidden;border:0px;text-align:center;height:100px;font-size:24px;}\n\
-		.t {position:absolute;top:0%;height:100%;border-right:1px solid black;}\n\
-		.legend {position: relative; width: 100%; height: 40px; text-align: center;margin-bottom:20px}\n\
-		.legend .square {position:absolute;top:10px; width: 0px;height: 20px;border:1px solid;padding-left:20px;}\n\
+		.t {z-index:2;position:absolute;pointer-events:none;top:0%;height:100%;border-right:1px solid black;}\n\
+		.legend {position:relative; width:100%; height:40px; text-align:center;margin-bottom:20px}\n\
+		.legend .square {position:absolute;cursor:pointer;top:10px; width:0px;height:20px;border:1px solid;padding-left:20px;}\n\
 		button {height:40px;width:200px;margin-bottom:20px;margin-top:20px;font-size:24px;}\n\
+		.logbtn {position:relative;float:right;height:25px;width:50px;margin-top:3px;margin-bottom:0;font-size:10px;text-align:center;}\n\
 		.devlist {position:'+x2changes[1]+';width:190px;}\n\
-		#devicedetail {height:100px;box-shadow: 5px 5px 20px black;}\n\
+		a:link {color:white;text-decoration:none;}\n\
+		a:visited {color:white;}\n\
+		a:hover {color:white;}\n\
+		a:active {color:white;}\n\
+		.version {position:relative;float:left;color:white;font-size:10px;line-height:30px;margin-left:10px;}\n\
+		#devicedetail {height:100px;box-shadow:5px 5px 20px black;}\n\
+		.tblock {position:absolute;height:100%;}\n\
+		.bg {z-index:1;}\n\
 	</style>\n</head>\n<body>\n'
-	hf.write(html_header)
+
+	# no header or css if its embedded
+	if(sysvals.embedded):
+		hf.write('pass True tSus %.3f tRes %.3f tLow %.3f fwvalid %s tSus %.3f tRes %.3f\n' %
+			(data.tSuspended-data.start, data.end-data.tSuspended, data.tLow, data.fwValid, \
+				data.fwSuspend/1000000, data.fwResume/1000000))
+	else:
+		hf.write(html_header)
 
 	# write the test title and general info header
 	if(sysvals.stamp['time'] != ""):
+		hf.write(headline_version)
+		if sysvals.addlogs and sysvals.dmesgfile:
+			hf.write('<button id="showdmesg" class="logbtn">dmesg</button>')
+		if sysvals.addlogs and sysvals.ftracefile:
+			hf.write('<button id="showftrace" class="logbtn">ftrace</button>')
 		hf.write(headline_stamp.format(sysvals.stamp['host'],
 			sysvals.stamp['kernel'], sysvals.stamp['mode'], \
 				sysvals.stamp['time']))
 
 	# write the device timeline
+	hf.write(devtl.html['header'])
 	hf.write(devtl.html['timeline'])
 	hf.write(devtl.html['legend'])
 	hf.write('<div id="devicedetailtitle"></div>\n')
-- 
2.1.4

