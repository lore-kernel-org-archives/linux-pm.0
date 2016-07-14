From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 2/5] scripts: AnalyzeSuspend v4.2 part2
Date: Thu, 14 Jul 2016 14:09:26 -0700
Message-ID: <ae63c90db460e73e887fb2fd6a79dafd27cb10cf.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:65217 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbcGNVJg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 17:09:36 -0400
In-Reply-To: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, rafael.j.wysocki@intel.com, todd.e.brandt@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 scripts/analyze_suspend.py | 911 +++++++++++++++++++++++++++++----------------
 1 file changed, 590 insertions(+), 321 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index 813681f..bc782f7 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -1203,19 +1203,19 @@ class FTraceLine:
 			if(m[-1] == '{'):
 				match = re.match('^(?P<n>.*) *\(.*', m)
 				if(match):
-					self.name = match.group('n')
+					self.name = match.group('n').strip()
 			# function call with no children (leaf)
 			elif(m[-1] == ';'):
 				self.freturn = True
 				match = re.match('^(?P<n>.*) *\(.*', m)
 				if(match):
-					self.name = match.group('n')
+					self.name = match.group('n').strip()
 			# something else (possibly a trace marker)
 			else:
 				self.name = m
 	def getDepth(self, str):
 		return len(str)/2
-	def debugPrint(self, dev):
+	def debugPrint(self, dev=''):
 		if(self.freturn and self.fcall):
 			print('%s -- %f (%02d): %s(); (%.3f us)' % (dev, self.time, \
 				self.depth, self.name, self.length*1000000))
@@ -1225,6 +1225,33 @@ class FTraceLine:
 		else:
 			print('%s -- %f (%02d): %s() { (%.3f us)' % (dev, self.time, \
 				self.depth, self.name, self.length*1000000))
+	def startMarker(self):
+		global sysvals
+		# Is this the starting line of a suspend?
+		if not self.fevent:
+			return False
+		if sysvals.usetracemarkers:
+			if(self.name == 'SUSPEND START'):
+				return True
+			return False
+		else:
+			if(self.type == 'suspend_resume' and
+				re.match('suspend_enter\[.*\] begin', self.name)):
+				return True
+			return False
+	def endMarker(self):
+		# Is this the ending line of a resume?
+		if not self.fevent:
+			return False
+		if sysvals.usetracemarkers:
+			if(self.name == 'RESUME COMPLETE'):
+				return True
+			return False
+		else:
+			if(self.type == 'suspend_resume' and
+				re.match('thaw_processes\[.*\] end', self.name)):
+				return True
+			return False
 
 # Class: FTraceCallGraph
 # Description:
@@ -1238,54 +1265,124 @@ class FTraceCallGraph:
 	list = []
 	invalid = False
 	depth = 0
-	def __init__(self):
+	pid = 0
+	def __init__(self, pid):
 		self.start = -1.0
 		self.end = -1.0
 		self.list = []
 		self.depth = 0
-	def setDepth(self, line):
+		self.pid = pid
+	def addLine(self, line, debug=False):
+		# if this is already invalid, just leave
+		if(self.invalid):
+			return False
+		# invalidate on too much data or bad depth
+		if(len(self.list) >= 1000000 or self.depth < 0):
+			self.invalidate(line)
+			return False
+		# compare current depth with this lines pre-call depth
+		prelinedep = line.depth
+		if(line.freturn and not line.fcall):
+			prelinedep += 1
+		last = 0
+		lasttime = line.time
+		virtualfname = 'execution_misalignment'
+		if len(self.list) > 0:
+			last = self.list[-1]
+			lasttime = last.time
+		# handle low misalignments by inserting returns
+		if prelinedep < self.depth:
+			if debug and last:
+				print '-------- task %d --------' % self.pid
+				last.debugPrint()
+			idx = 0
+			# add return calls to get the depth down
+			while prelinedep < self.depth:
+				if debug:
+					print 'MISALIGN LOW (add returns): C%d - eC%d' % (self.depth, prelinedep)
+				self.depth -= 1
+				if idx == 0 and last and last.fcall and not last.freturn:
+					# special case, turn last call into a leaf
+					last.depth = self.depth
+					last.freturn = True
+					last.length = line.time - last.time
+					if debug:
+						last.debugPrint()
+				else:
+					vline = FTraceLine(lasttime)
+					vline.depth = self.depth
+					vline.name = virtualfname
+					vline.freturn = True
+					self.list.append(vline)
+					if debug:
+						vline.debugPrint()
+				idx += 1
+			if debug:
+				line.debugPrint()
+				print ''
+		# handle high misalignments by inserting calls
+		elif prelinedep > self.depth:
+			if debug and last:
+				print '-------- task %d --------' % self.pid
+				last.debugPrint()
+			idx = 0
+			# add calls to get the depth up
+			while prelinedep > self.depth:
+				if debug:
+					print 'MISALIGN HIGH (add calls): C%d - eC%d' % (self.depth, prelinedep)
+				if idx == 0 and line.freturn and not line.fcall:
+					# special case, turn this return into a leaf
+					line.fcall = True
+					prelinedep -= 1
+				else:
+					vline = FTraceLine(lasttime)
+					vline.depth = self.depth
+					vline.name = virtualfname
+					vline.fcall = True
+					if debug:
+						vline.debugPrint()
+					self.list.append(vline)
+					self.depth += 1
+					if not last:
+						self.start = vline.time
+				idx += 1
+			if debug:
+				line.debugPrint()
+				print ''
+		# process the call and set the new depth
 		if(line.fcall and not line.freturn):
-			line.depth = self.depth
 			self.depth += 1
 		elif(line.freturn and not line.fcall):
 			self.depth -= 1
-			line.depth = self.depth
-		else:
-			line.depth = self.depth
-	def addLine(self, line, match):
-		if(not self.invalid):
-			self.setDepth(line)
+		if len(self.list) < 1:
+			self.start = line.time
+		self.list.append(line)
 		if(line.depth == 0 and line.freturn):
 			if(self.start < 0):
 				self.start = line.time
 			self.end = line.time
-			self.list.append(line)
+			if line.fcall:
+				self.end += line.length
+			if self.list[0].name == virtualfname:
+				self.invalid = True
 			return True
-		if(self.invalid):
-			return False
-		if(len(self.list) >= 1000000 or self.depth < 0):
-			if(len(self.list) > 0):
-				first = self.list[0]
-				self.list = []
-				self.list.append(first)
-			self.invalid = True
-			if(not match):
-				return False
-			id = 'task %s cpu %s' % (match.group('pid'), match.group('cpu'))
-			window = '(%f - %f)' % (self.start, line.time)
-			if(self.depth < 0):
-				print('Too much data for '+id+\
-					' (buffer overflow), ignoring this callback')
-			else:
-				print('Too much data for '+id+\
-					' '+window+', ignoring this callback')
-			return False
-		self.list.append(line)
-		if(self.start < 0):
-			self.start = line.time
 		return False
+	def invalidate(self, line):
+		if(len(self.list) > 0):
+			first = self.list[0]
+			self.list = []
+			self.list.append(first)
+		self.invalid = True
+		id = 'task %s' % (self.pid)
+		window = '(%f - %f)' % (self.start, line.time)
+		if(self.depth < 0):
+			vprint('Too much data for '+id+\
+				' (buffer overflow), ignoring this callback')
+		else:
+			vprint('Too much data for '+id+\
+				' '+window+', ignoring this callback')
 	def slice(self, t0, tN):
-		minicg = FTraceCallGraph()
+		minicg = FTraceCallGraph(0)
 		count = -1
 		firstdepth = 0
 		for l in self.list:
@@ -1297,13 +1394,26 @@ class FTraceCallGraph:
 				firstdepth = l.depth
 				count = 0
 			l.depth -= firstdepth
-			minicg.addLine(l, 0)
+			minicg.addLine(l)
 			if((count == 0 and l.freturn and l.fcall) or
 				(count > 0 and l.depth <= 0)):
 				break
 			count += 1
 		return minicg
-	def sanityCheck(self):
+	def repair(self, enddepth):
+		# bring the depth back to 0 with additional returns
+		fixed = False
+		last = self.list[-1]
+		for i in reversed(range(enddepth)):
+			t = FTraceLine(last.time)
+			t.depth = i
+			t.freturn = True
+			fixed = self.addLine(t)
+			if fixed:
+				self.end = last.time
+				return True
+		return False
+	def postProcess(self, debug=False):
 		stack = dict()
 		cnt = 0
 		for l in self.list:
@@ -1312,98 +1422,317 @@ class FTraceCallGraph:
 				cnt += 1
 			elif(l.freturn and not l.fcall):
 				if(l.depth not in stack):
+					if debug:
+						print 'Post Process Error: Depth missing'
+						l.debugPrint()
 					return False
+				# transfer total time from return line to call line
 				stack[l.depth].length = l.length
-				stack[l.depth] = 0
+				stack.pop(l.depth)
 				l.length = 0
 				cnt -= 1
 		if(cnt == 0):
+			# trace caught the whole call tree
 			return True
-		return False
-	def debugPrint(self, filename):
-		if(filename == 'stdout'):
-			print('[%f - %f]') % (self.start, self.end)
-			for l in self.list:
-				if(l.freturn and l.fcall):
-					print('%f (%02d): %s(); (%.3f us)' % (l.time, \
-						l.depth, l.name, l.length*1000000))
-				elif(l.freturn):
-					print('%f (%02d): %s} (%.3f us)' % (l.time, \
-						l.depth, l.name, l.length*1000000))
-				else:
-					print('%f (%02d): %s() { (%.3f us)' % (l.time, \
-						l.depth, l.name, l.length*1000000))
-			print(' ')
-		else:
-			fp = open(filename, 'w')
-			print(filename)
-			for l in self.list:
-				if(l.freturn and l.fcall):
-					fp.write('%f (%02d): %s(); (%.3f us)\n' % (l.time, \
-						l.depth, l.name, l.length*1000000))
-				elif(l.freturn):
-					fp.write('%f (%02d): %s} (%.3f us)\n' % (l.time, \
-						l.depth, l.name, l.length*1000000))
-				else:
-					fp.write('%f (%02d): %s() { (%.3f us)\n' % (l.time, \
-						l.depth, l.name, l.length*1000000))
-			fp.close()
+		elif(cnt < 0):
+			if debug:
+				print 'Post Process Error: Depth is less than 0'
+			return False
+		# trace ended before call tree finished
+		return self.repair(cnt)
+	def deviceMatch(self, pid, data):
+		found = False
+		# add the callgraph data to the device hierarchy
+		borderphase = {
+			'dpm_prepare': 'suspend_prepare',
+			'dpm_complete': 'resume_complete'
+		}
+		if(self.list[0].name in borderphase):
+			p = borderphase[self.list[0].name]
+			list = data.dmesg[p]['list']
+			for devname in list:
+				dev = list[devname]
+				if(pid == dev['pid'] and
+					self.start <= dev['start'] and
+					self.end >= dev['end']):
+					dev['ftrace'] = self.slice(dev['start'], dev['end'])
+					found = True
+			return found
+		for p in data.phases:
+			if(data.dmesg[p]['start'] <= self.start and
+				self.start <= data.dmesg[p]['end']):
+				list = data.dmesg[p]['list']
+				for devname in list:
+					dev = list[devname]
+					if(pid == dev['pid'] and
+						self.start <= dev['start'] and
+						self.end >= dev['end']):
+						dev['ftrace'] = self
+						found = True
+						break
+				break
+		return found
+	def newActionFromFunction(self, data):
+		name = self.list[0].name
+		if name in ['dpm_run_callback', 'dpm_prepare', 'dpm_complete']:
+			return
+		fs = self.start
+		fe = self.end
+		if fs < data.start or fe > data.end:
+			return
+		phase = ''
+		for p in data.phases:
+			if(data.dmesg[p]['start'] <= self.start and
+				self.start < data.dmesg[p]['end']):
+				phase = p
+				break
+		if not phase:
+			return
+		out = data.newActionGlobal(name, fs, fe, -2)
+		if out:
+			phase, myname = out
+			data.dmesg[phase]['list'][myname]['ftrace'] = self
+	def debugPrint(self):
+		print('[%f - %f] %s (%d)') % (self.start, self.end, self.list[0].name, self.pid)
+		for l in self.list:
+			if(l.freturn and l.fcall):
+				print('%f (%02d): %s(); (%.3f us)' % (l.time, \
+					l.depth, l.name, l.length*1000000))
+			elif(l.freturn):
+				print('%f (%02d): %s} (%.3f us)' % (l.time, \
+					l.depth, l.name, l.length*1000000))
+			else:
+				print('%f (%02d): %s() { (%.3f us)' % (l.time, \
+					l.depth, l.name, l.length*1000000))
+		print(' ')
 
 # Class: Timeline
 # Description:
-#	 A container for a suspend/resume html timeline. In older versions
-#	 of the script there were multiple timelines, but in the latest
-#	 there is only one.
+#	 A container for a device timeline which calculates
+#	 all the html properties to display it correctly
 class Timeline:
 	html = {}
-	scaleH = 0.0 # height of the row as a percent of the timeline height
-	rowH = 0.0 # height of each row in percent of the timeline height
-	row_height_pixels = 30
-	maxrows = 0
-	height = 0
-	def __init__(self):
+	height = 0	# total timeline height
+	scaleH = 20	# timescale (top) row height
+	rowH = 30	# device row height
+	bodyH = 0	# body height
+	rows = 0	# total timeline rows
+	phases = []
+	rowmaxlines = dict()
+	rowcount = dict()
+	rowheight = dict()
+	def __init__(self, rowheight):
+		self.rowH = rowheight
 		self.html = {
+			'header': '',
 			'timeline': '',
 			'legend': '',
-			'scale': ''
 		}
-	def setRows(self, rows):
-		self.maxrows = int(rows)
-		self.scaleH = 100.0/float(self.maxrows)
-		self.height = self.maxrows*self.row_height_pixels
-		r = float(self.maxrows - 1)
-		if(r < 1.0):
-			r = 1.0
-		self.rowH = (100.0 - self.scaleH)/r
+	# Function: getDeviceRows
+	# Description:
+	#    determine how may rows the device funcs will take
+	# Arguments:
+	#	 rawlist: the list of devices/actions for a single phase
+	# Output:
+	#	 The total number of rows needed to display this phase of the timeline
+	def getDeviceRows(self, rawlist):
+		# clear all rows and set them to undefined
+		lendict = dict()
+		for item in rawlist:
+			item.row = -1
+			lendict[item] = item.length
+		list = []
+		for i in sorted(lendict, key=lendict.get, reverse=True):
+			list.append(i)
+		remaining = len(list)
+		rowdata = dict()
+		row = 1
+		# try to pack each row with as many ranges as possible
+		while(remaining > 0):
+			if(row not in rowdata):
+				rowdata[row] = []
+			for i in list:
+				if(i.row >= 0):
+					continue
+				s = i.time
+				e = i.time + i.length
+				valid = True
+				for ritem in rowdata[row]:
+					rs = ritem.time
+					re = ritem.time + ritem.length
+					if(not (((s <= rs) and (e <= rs)) or
+						((s >= re) and (e >= re)))):
+						valid = False
+						break
+				if(valid):
+					rowdata[row].append(i)
+					i.row = row
+					remaining -= 1
+			row += 1
+		return row
+	# Function: getPhaseRows
+	# Description:
+	#	 Organize the timeline entries into the smallest
+	#	 number of rows possible, with no entry overlapping
+	# Arguments:
+	#	 list: the list of devices/actions for a single phase
+	#	 devlist: string list of device names to use
+	# Output:
+	#	 The total number of rows needed to display this phase of the timeline
+	def getPhaseRows(self, dmesg, devlist):
+		# clear all rows and set them to undefined
+		remaining = len(devlist)
+		rowdata = dict()
+		row = 0
+		lendict = dict()
+		myphases = []
+		for item in devlist:
+			if item[0] not in self.phases:
+				self.phases.append(item[0])
+			if item[0] not in myphases:
+				myphases.append(item[0])
+				self.rowmaxlines[item[0]] = dict()
+				self.rowheight[item[0]] = dict()
+			dev = dmesg[item[0]]['list'][item[1]]
+			dev['row'] = -1
+			lendict[item] = float(dev['end']) - float(dev['start'])
+			if 'src' in dev:
+				dev['devrows'] = self.getDeviceRows(dev['src'])
+		lenlist = []
+		for i in sorted(lendict, key=lendict.get, reverse=True):
+			lenlist.append(i)
+		orderedlist = []
+		for item in lenlist:
+			dev = dmesg[item[0]]['list'][item[1]]
+			if dev['pid'] == -2:
+				orderedlist.append(item)
+		for item in lenlist:
+			if item not in orderedlist:
+				orderedlist.append(item)
+		# try to pack each row with as many ranges as possible
+		while(remaining > 0):
+			rowheight = 1
+			if(row not in rowdata):
+				rowdata[row] = []
+			for item in orderedlist:
+				dev = dmesg[item[0]]['list'][item[1]]
+				if(dev['row'] < 0):
+					s = dev['start']
+					e = dev['end']
+					valid = True
+					for ritem in rowdata[row]:
+						rs = ritem['start']
+						re = ritem['end']
+						if(not (((s <= rs) and (e <= rs)) or
+							((s >= re) and (e >= re)))):
+							valid = False
+							break
+					if(valid):
+						rowdata[row].append(dev)
+						dev['row'] = row
+						remaining -= 1
+						if 'devrows' in dev and dev['devrows'] > rowheight:
+							rowheight = dev['devrows']
+			for phase in myphases:
+				self.rowmaxlines[phase][row] = rowheight
+				self.rowheight[phase][row] = rowheight * self.rowH
+			row += 1
+		if(row > self.rows):
+			self.rows = int(row)
+		for phase in myphases:
+			self.rowcount[phase] = row
+		return row
+	def phaseRowHeight(self, phase, row):
+		return self.rowheight[phase][row]
+	def phaseRowTop(self, phase, row):
+		top = 0
+		for i in sorted(self.rowheight[phase]):
+			if i >= row:
+				break
+			top += self.rowheight[phase][i]
+		return top
+	# Function: calcTotalRows
+	# Description:
+	#	 Calculate the heights and offsets for the header and rows
+	def calcTotalRows(self):
+		maxrows = 0
+		standardphases = []
+		for phase in self.phases:
+			total = 0
+			for i in sorted(self.rowmaxlines[phase]):
+				total += self.rowmaxlines[phase][i]
+			if total > maxrows:
+				maxrows = total
+			if total == self.rowcount[phase]:
+				standardphases.append(phase)
+		self.height = self.scaleH + (maxrows*self.rowH)
+		self.bodyH = self.height - self.scaleH
+		for phase in standardphases:
+			for i in sorted(self.rowheight[phase]):
+				self.rowheight[phase][i] = self.bodyH/self.rowcount[phase]
+	# Function: createTimeScale
+	# Description:
+	#	 Create the timescale for a timeline block
+	# Arguments:
+	#	 m0: start time (mode begin)
+	#	 mMax: end time (mode end)
+	#	 tTotal: total timeline time
+	#	 mode: suspend or resume
+	# Output:
+	#	 The html code needed to display the time scale
+	def createTimeScale(self, m0, mMax, tTotal, mode):
+		timescale = '<div class="t" style="right:{0}%">{1}</div>\n'
+		rline = '<div class="t" style="left:0;border-left:1px solid black;border-right:0;">Resume</div>\n'
+		output = '<div class="timescale">\n'
+		# set scale for timeline
+		mTotal = mMax - m0
+		tS = 0.1
+		if(tTotal <= 0):
+			return output+'</div>\n'
+		if(tTotal > 4):
+			tS = 1
+		divTotal = int(mTotal/tS) + 1
+		divEdge = (mTotal - tS*(divTotal-1))*100/mTotal
+		for i in range(divTotal):
+			htmlline = ''
+			if(mode == 'resume'):
+				pos = '%0.3f' % (100 - ((float(i)*tS*100)/mTotal))
+				val = '%0.fms' % (float(i)*tS*1000)
+				htmlline = timescale.format(pos, val)
+				if(i == 0):
+					htmlline = rline
+			else:
+				pos = '%0.3f' % (100 - ((float(i)*tS*100)/mTotal) - divEdge)
+				val = '%0.fms' % (float(i-divTotal+1)*tS*1000)
+				if(i == divTotal - 1):
+					val = 'Suspend'
+				htmlline = timescale.format(pos, val)
+			output += htmlline
+		output += '</div>\n'
+		return output
 
-# Class: TestRun
+# Class: TestProps
 # Description:
-#	 A container for a suspend/resume test run. This is necessary as
-#	 there could be more than one, and they need to be separate.
-class TestRun:
+#	 A list of values describing the properties of these test runs
+class TestProps:
+	stamp = ''
+	tracertype = ''
+	S0i3 = False
+	fwdata = []
 	ftrace_line_fmt_fg = \
 		'^ *(?P<time>[0-9\.]*) *\| *(?P<cpu>[0-9]*)\)'+\
 		' *(?P<proc>.*)-(?P<pid>[0-9]*) *\|'+\
-		'[ +!]*(?P<dur>[0-9\.]*) .*\|  (?P<msg>.*)'
+		'[ +!#\*@$]*(?P<dur>[0-9\.]*) .*\|  (?P<msg>.*)'
 	ftrace_line_fmt_nop = \
 		' *(?P<proc>.*)-(?P<pid>[0-9]*) *\[(?P<cpu>[0-9]*)\] *'+\
 		'(?P<flags>.{4}) *(?P<time>[0-9\.]*): *'+\
 		'(?P<msg>.*)'
 	ftrace_line_fmt = ftrace_line_fmt_nop
 	cgformat = False
-	ftemp = dict()
-	ttemp = dict()
-	inthepipe = False
-	tracertype = ''
 	data = 0
-	def __init__(self, dataobj):
-		self.data = dataobj
-		self.ftemp = dict()
-		self.ttemp = dict()
-	def isReady(self):
-		if(tracertype == '' or not data):
-			return False
-		return True
+	ktemp = dict()
+	def __init__(self):
+		self.ktemp = dict()
 	def setTracerType(self, tracer):
 		self.tracertype = tracer
 		if(tracer == 'function_graph'):
@@ -1414,6 +1743,19 @@ class TestRun:
 		else:
 			doError('Invalid tracer format: [%s]' % tracer, False)
 
+# Class: TestRun
+# Description:
+#	 A container for a suspend/resume test run. This is necessary as
+#	 there could be more than one, and they need to be separate.
+class TestRun:
+	ftemp = dict()
+	ttemp = dict()
+	data = 0
+	def __init__(self, dataobj):
+		self.data = dataobj
+		self.ftemp = dict()
+		self.ttemp = dict()
+
 # ----------------- FUNCTIONS --------------------
 
 # Function: vprint
@@ -1426,104 +1768,16 @@ def vprint(msg):
 	if(sysvals.verbose):
 		print(msg)
 
-# Function: initFtrace
-# Description:
-#	 Configure ftrace to use trace events and/or a callgraph
-def initFtrace():
-	global sysvals
-
-	tp = sysvals.tpath
-	cf = 'dpm_run_callback'
-	if(sysvals.usetraceeventsonly):
-		cf = '-e dpm_prepare -e dpm_complete -e dpm_run_callback'
-	if(sysvals.usecallgraph or sysvals.usetraceevents):
-		print('INITIALIZING FTRACE...')
-		# turn trace off
-		os.system('echo 0 > '+tp+'tracing_on')
-		# set the trace clock to global
-		os.system('echo global > '+tp+'trace_clock')
-		# set trace buffer to a huge value
-		os.system('echo nop > '+tp+'current_tracer')
-		os.system('echo 100000 > '+tp+'buffer_size_kb')
-		# initialize the callgraph trace, unless this is an x2 run
-		if(sysvals.usecallgraph and sysvals.execcount == 1):
-			# set trace type
-			os.system('echo function_graph > '+tp+'current_tracer')
-			os.system('echo "" > '+tp+'set_ftrace_filter')
-			# set trace format options
-			os.system('echo funcgraph-abstime > '+tp+'trace_options')
-			os.system('echo funcgraph-proc > '+tp+'trace_options')
-			# focus only on device suspend and resume
-			os.system('cat '+tp+'available_filter_functions | grep '+\
-				cf+' > '+tp+'set_graph_function')
-		if(sysvals.usetraceevents):
-			# turn trace events on
-			events = iter(sysvals.traceevents)
-			for e in events:
-				os.system('echo 1 > '+sysvals.epath+e+'/enable')
-		# clear the trace buffer
-		os.system('echo "" > '+tp+'trace')
-
-# Function: initFtraceAndroid
-# Description:
-#	 Configure ftrace to capture trace events
-def initFtraceAndroid():
-	global sysvals
-
-	tp = sysvals.tpath
-	if(sysvals.usetraceevents):
-		print('INITIALIZING FTRACE...')
-		# turn trace off
-		os.system(sysvals.adb+" shell 'echo 0 > "+tp+"tracing_on'")
-		# set the trace clock to global
-		os.system(sysvals.adb+" shell 'echo global > "+tp+"trace_clock'")
-		# set trace buffer to a huge value
-		os.system(sysvals.adb+" shell 'echo nop > "+tp+"current_tracer'")
-		os.system(sysvals.adb+" shell 'echo 10000 > "+tp+"buffer_size_kb'")
-		# turn trace events on
-		events = iter(sysvals.traceevents)
-		for e in events:
-			os.system(sysvals.adb+" shell 'echo 1 > "+\
-				sysvals.epath+e+"/enable'")
-		# clear the trace buffer
-		os.system(sysvals.adb+" shell 'echo \"\" > "+tp+"trace'")
-
-# Function: verifyFtrace
-# Description:
-#	 Check that ftrace is working on the system
-# Output:
-#	 True or False
-def verifyFtrace():
-	global sysvals
-	# files needed for any trace data
-	files = ['buffer_size_kb', 'current_tracer', 'trace', 'trace_clock',
-			 'trace_marker', 'trace_options', 'tracing_on']
-	# files needed for callgraph trace data
-	tp = sysvals.tpath
-	if(sysvals.usecallgraph):
-		files += [
-			'available_filter_functions',
-			'set_ftrace_filter',
-			'set_graph_function'
-		]
-	for f in files:
-		if(sysvals.android):
-			out = os.popen(sysvals.adb+' shell ls '+tp+f).read().strip()
-			if(out != tp+f):
-				return False
-		else:
-			if(os.path.exists(tp+f) == False):
-				return False
-	return True
-
 # Function: parseStamp
 # Description:
 #	 Pull in the stamp comment line from the data file(s),
 #	 create the stamp, and add it to the global sysvals object
 # Arguments:
 #	 m: the valid re.match output for the stamp line
-def parseStamp(m, data):
+def parseStamp(line, data):
 	global sysvals
+
+	m = re.match(sysvals.stampfmt, line)
 	data.stamp = {'time': '', 'host': '', 'mode': ''}
 	dt = datetime(int(m.group('y'))+2000, int(m.group('m')),
 		int(m.group('d')), int(m.group('H')), int(m.group('M')),
@@ -1532,6 +1786,7 @@ def parseStamp(m, data):
 	data.stamp['host'] = m.group('host')
 	data.stamp['mode'] = m.group('mode')
 	data.stamp['kernel'] = m.group('kernel')
+	sysvals.hostname = data.stamp['host']
 	sysvals.suspendmode = data.stamp['mode']
 	if not sysvals.stamp:
 		sysvals.stamp = data.stamp
@@ -1564,14 +1819,35 @@ def diffStamp(stamp1, stamp2):
 def doesTraceLogHaveTraceEvents():
 	global sysvals
 
+	# check for kprobes
+	sysvals.usekprobes = False
+	out = os.system('grep -q "_cal: (" '+sysvals.ftracefile)
+	if(out == 0):
+		sysvals.usekprobes = True
+	# check for callgraph data on trace event blocks
+	out = os.system('grep -q "_cpu_down()" '+sysvals.ftracefile)
+	if(out == 0):
+		sysvals.usekprobes = True
+	out = os.popen('head -1 '+sysvals.ftracefile).read().replace('\n', '')
+	m = re.match(sysvals.stampfmt, out)
+	if m and m.group('mode') == 'command':
+		sysvals.usetraceeventsonly = True
+		sysvals.usetraceevents = True
+		return
+	# figure out what level of trace events are supported
 	sysvals.usetraceeventsonly = True
 	sysvals.usetraceevents = False
 	for e in sysvals.traceevents:
-		out = os.popen('cat '+sysvals.ftracefile+' | grep "'+e+': "').read()
-		if(not out):
+		out = os.system('grep -q "'+e+': " '+sysvals.ftracefile)
+		if(out != 0):
 			sysvals.usetraceeventsonly = False
-		if(e == 'suspend_resume' and out):
+		if(e == 'suspend_resume' and out == 0):
 			sysvals.usetraceevents = True
+	# determine is this log is properly formatted
+	for e in ['SUSPEND START', 'RESUME COMPLETE']:
+		out = os.system('grep -q "'+e+'" '+sysvals.ftracefile)
+		if(out != 0):
+			sysvals.usetracemarkers = False
 
 # Function: appendIncompleteTraceLog
 # Description:
@@ -1588,44 +1864,42 @@ def appendIncompleteTraceLog(testruns):
 
 	# create TestRun vessels for ftrace parsing
 	testcnt = len(testruns)
-	testidx = -1
+	testidx = 0
 	testrun = []
 	for data in testruns:
 		testrun.append(TestRun(data))
 
 	# extract the callgraph and traceevent data
 	vprint('Analyzing the ftrace data...')
+	tp = TestProps()
 	tf = open(sysvals.ftracefile, 'r')
+	data = 0
 	for line in tf:
 		# remove any latent carriage returns
 		line = line.replace('\r\n', '')
-		# grab the time stamp first (signifies the start of the test run)
+		# grab the time stamp
 		m = re.match(sysvals.stampfmt, line)
 		if(m):
-			testidx += 1
-			parseStamp(m, testrun[testidx].data)
-			continue
-		# pull out any firmware data
-		if(re.match(sysvals.firmwarefmt, line)):
-			continue
-		# if we havent found a test time stamp yet keep spinning til we do
-		if(testidx < 0):
+			tp.stamp = line
 			continue
 		# determine the trace data type (required for further parsing)
 		m = re.match(sysvals.tracertypefmt, line)
 		if(m):
-			tracer = m.group('t')
-			testrun[testidx].setTracerType(tracer)
+			tp.setTracerType(m.group('t'))
+			continue
+		# device properties line
+		if(re.match(sysvals.devpropfmt, line)):
+			devProps(line)
 			continue
-		# parse only valid lines, if this isnt one move on
-		m = re.match(testrun[testidx].ftrace_line_fmt, line)
+		# parse only valid lines, if this is not one move on
+		m = re.match(tp.ftrace_line_fmt, line)
 		if(not m):
 			continue
 		# gather the basic message data from the line
 		m_time = m.group('time')
 		m_pid = m.group('pid')
 		m_msg = m.group('msg')
-		if(testrun[testidx].cgformat):
+		if(tp.cgformat):
 			m_param3 = m.group('dur')
 		else:
 			m_param3 = 'traceevent'
@@ -1637,119 +1911,114 @@ def appendIncompleteTraceLog(testruns):
 		# the line should be a call, return, or event
 		if(not t.fcall and not t.freturn and not t.fevent):
 			continue
-		# only parse the ftrace data during suspend/resume
-		data = testrun[testidx].data
-		if(not testrun[testidx].inthepipe):
-			# look for the suspend start marker
-			if(t.fevent):
-				if(t.name == 'SUSPEND START'):
-					testrun[testidx].inthepipe = True
-					data.setStart(t.time)
+		# look for the suspend start marker
+		if(t.startMarker()):
+			data = testrun[testidx].data
+			parseStamp(tp.stamp, data)
+			data.setStart(t.time)
+			continue
+		if(not data):
+			continue
+		# find the end of resume
+		if(t.endMarker()):
+			data.setEnd(t.time)
+			testidx += 1
+			if(testidx >= testcnt):
+				break
+			continue
+		# trace event processing
+		if(t.fevent):
+			# general trace events have two types, begin and end
+			if(re.match('(?P<name>.*) begin$', t.name)):
+				isbegin = True
+			elif(re.match('(?P<name>.*) end$', t.name)):
+				isbegin = False
+			else:
 				continue
-		else:
-			# trace event processing
-			if(t.fevent):
-				if(t.name == 'RESUME COMPLETE'):
-					testrun[testidx].inthepipe = False
-					data.setEnd(t.time)
-					if(testidx == testcnt - 1):
-						break
-					continue
-				# general trace events have two types, begin and end
-				if(re.match('(?P<name>.*) begin$', t.name)):
-					isbegin = True
-				elif(re.match('(?P<name>.*) end$', t.name)):
-					isbegin = False
+			m = re.match('(?P<name>.*)\[(?P<val>[0-9]*)\] .*', t.name)
+			if(m):
+				val = m.group('val')
+				if val == '0':
+					name = m.group('name')
 				else:
-					continue
-				m = re.match('(?P<name>.*)\[(?P<val>[0-9]*)\] .*', t.name)
-				if(m):
-					val = m.group('val')
-					if val == '0':
-						name = m.group('name')
-					else:
-						name = m.group('name')+'['+val+']'
+					name = m.group('name')+'['+val+']'
+			else:
+				m = re.match('(?P<name>.*) .*', t.name)
+				name = m.group('name')
+			# special processing for trace events
+			if re.match('dpm_prepare\[.*', name):
+				continue
+			elif re.match('machine_suspend.*', name):
+				continue
+			elif re.match('suspend_enter\[.*', name):
+				if(not isbegin):
+					data.dmesg['suspend_prepare']['end'] = t.time
+				continue
+			elif re.match('dpm_suspend\[.*', name):
+				if(not isbegin):
+					data.dmesg['suspend']['end'] = t.time
+				continue
+			elif re.match('dpm_suspend_late\[.*', name):
+				if(isbegin):
+					data.dmesg['suspend_late']['start'] = t.time
 				else:
-					m = re.match('(?P<name>.*) .*', t.name)
-					name = m.group('name')
-				# special processing for trace events
-				if re.match('dpm_prepare\[.*', name):
-					continue
-				elif re.match('machine_suspend.*', name):
-					continue
-				elif re.match('suspend_enter\[.*', name):
-					if(not isbegin):
-						data.dmesg['suspend_prepare']['end'] = t.time
-					continue
-				elif re.match('dpm_suspend\[.*', name):
-					if(not isbegin):
-						data.dmesg['suspend']['end'] = t.time
-					continue
-				elif re.match('dpm_suspend_late\[.*', name):
-					if(isbegin):
-						data.dmesg['suspend_late']['start'] = t.time
-					else:
-						data.dmesg['suspend_late']['end'] = t.time
-					continue
-				elif re.match('dpm_suspend_noirq\[.*', name):
-					if(isbegin):
-						data.dmesg['suspend_noirq']['start'] = t.time
-					else:
-						data.dmesg['suspend_noirq']['end'] = t.time
-					continue
-				elif re.match('dpm_resume_noirq\[.*', name):
-					if(isbegin):
-						data.dmesg['resume_machine']['end'] = t.time
-						data.dmesg['resume_noirq']['start'] = t.time
-					else:
-						data.dmesg['resume_noirq']['end'] = t.time
-					continue
-				elif re.match('dpm_resume_early\[.*', name):
-					if(isbegin):
-						data.dmesg['resume_early']['start'] = t.time
-					else:
-						data.dmesg['resume_early']['end'] = t.time
-					continue
-				elif re.match('dpm_resume\[.*', name):
-					if(isbegin):
-						data.dmesg['resume']['start'] = t.time
-					else:
-						data.dmesg['resume']['end'] = t.time
-					continue
-				elif re.match('dpm_complete\[.*', name):
-					if(isbegin):
-						data.dmesg['resume_complete']['start'] = t.time
-					else:
-						data.dmesg['resume_complete']['end'] = t.time
-					continue
-				# is this trace event outside of the devices calls
-				if(data.isTraceEventOutsideDeviceCalls(pid, t.time)):
-					# global events (outside device calls) are simply graphed
-					if(isbegin):
-						# store each trace event in ttemp
-						if(name not in testrun[testidx].ttemp):
-							testrun[testidx].ttemp[name] = []
-						testrun[testidx].ttemp[name].append(\
-							{'begin': t.time, 'end': t.time})
-					else:
-						# finish off matching trace event in ttemp
-						if(name in testrun[testidx].ttemp):
-							testrun[testidx].ttemp[name][-1]['end'] = t.time
+					data.dmesg['suspend_late']['end'] = t.time
+				continue
+			elif re.match('dpm_suspend_noirq\[.*', name):
+				if(isbegin):
+					data.dmesg['suspend_noirq']['start'] = t.time
 				else:
-					if(isbegin):
-						data.addIntraDevTraceEvent('', name, pid, t.time)
-					else:
-						data.capIntraDevTraceEvent('', name, pid, t.time)
-			# call/return processing
-			elif sysvals.usecallgraph:
-				# create a callgraph object for the data
-				if(pid not in testrun[testidx].ftemp):
-					testrun[testidx].ftemp[pid] = []
-					testrun[testidx].ftemp[pid].append(FTraceCallGraph())
-				# when the call is finished, see which device matches it
-				cg = testrun[testidx].ftemp[pid][-1]
-				if(cg.addLine(t, m)):
-					testrun[testidx].ftemp[pid].append(FTraceCallGraph())
+					data.dmesg['suspend_noirq']['end'] = t.time
+				continue
+			elif re.match('dpm_resume_noirq\[.*', name):
+				if(isbegin):
+					data.dmesg['resume_machine']['end'] = t.time
+					data.dmesg['resume_noirq']['start'] = t.time
+				else:
+					data.dmesg['resume_noirq']['end'] = t.time
+				continue
+			elif re.match('dpm_resume_early\[.*', name):
+				if(isbegin):
+					data.dmesg['resume_early']['start'] = t.time
+				else:
+					data.dmesg['resume_early']['end'] = t.time
+				continue
+			elif re.match('dpm_resume\[.*', name):
+				if(isbegin):
+					data.dmesg['resume']['start'] = t.time
+				else:
+					data.dmesg['resume']['end'] = t.time
+				continue
+			elif re.match('dpm_complete\[.*', name):
+				if(isbegin):
+					data.dmesg['resume_complete']['start'] = t.time
+				else:
+					data.dmesg['resume_complete']['end'] = t.time
+				continue
+			# skip trace events inside devices calls
+			if(not data.isTraceEventOutsideDeviceCalls(pid, t.time)):
+				continue
+			# global events (outside device calls) are simply graphed
+			if(isbegin):
+				# store each trace event in ttemp
+				if(name not in testrun[testidx].ttemp):
+					testrun[testidx].ttemp[name] = []
+				testrun[testidx].ttemp[name].append(\
+					{'begin': t.time, 'end': t.time})
+			else:
+				# finish off matching trace event in ttemp
+				if(name in testrun[testidx].ttemp):
+					testrun[testidx].ttemp[name][-1]['end'] = t.time
+		# call/return processing
+		elif sysvals.usecallgraph:
+			# create a callgraph object for the data
+			if(pid not in testrun[testidx].ftemp):
+				testrun[testidx].ftemp[pid] = []
+				testrun[testidx].ftemp[pid].append(FTraceCallGraph(pid))
+			# when the call is finished, see which device matches it
+			cg = testrun[testidx].ftemp[pid][-1]
+			if(cg.addLine(t)):
+				testrun[testidx].ftemp[pid].append(FTraceCallGraph(pid))
 	tf.close()
 
 	for test in testrun:
-- 
2.1.4

