From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 1/3] pm-graph: AnalyzeSuspend v4.6
Date: Fri,  7 Apr 2017 11:05:35 -0700
Message-ID: <a41de5f439109f73dbe0b3b9186376ec8458eefa.1491587995.git.todd.e.brandt@linux.intel.com>
References: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932863AbdDGSFk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Apr 2017 14:05:40 -0400
In-Reply-To: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
References: <cover.1491587995.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, rjw@rjwysocki.net
Cc: arjan@linux.intel.com, len.brown@intel.com, todd.e.brandt@intel.com, todd.e.brandt@linux.intel.com

Moved from scripts into tools, and updated from 4.5 to 4.6
- Changed the tool title to SleepGraph
- Reformatted the code so analyze_suspend can be used as a library
- Reorganized all html/js/css handling code to be used by other tools
- upgraded the -summary feature to work faster with better readability

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 .../power/pm-graph}/analyze_suspend.py             | 916 +++++++++++----------
 1 file changed, 495 insertions(+), 421 deletions(-)
 rename {scripts => tools/power/pm-graph}/analyze_suspend.py (91%)

diff --git a/scripts/analyze_suspend.py b/tools/power/pm-graph/analyze_suspend.py
similarity index 91%
rename from scripts/analyze_suspend.py
rename to tools/power/pm-graph/analyze_suspend.py
index 20cdb2b..a9206e6 100755
--- a/scripts/analyze_suspend.py
+++ b/tools/power/pm-graph/analyze_suspend.py
@@ -12,10 +12,6 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 #
-# You should have received a copy of the GNU General Public License along with
-# this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Authors:
 #	 Todd Brandt <todd.e.brandt@linux.intel.com>
 #
@@ -23,7 +19,7 @@
 #	 Home Page
 #	   https://01.org/suspendresume
 #	 Source repo
-#	   https://github.com/01org/suspendresume
+#	   https://github.com/01org/pm-graph
 #
 # Description:
 #	 This tool is designed to assist kernel and OS developers in optimizing
@@ -71,14 +67,16 @@ from subprocess import call, Popen, PIPE
 #	 A global, single-instance container used to
 #	 store system values and test parameters
 class SystemValues:
+	title = 'SleepGraph'
+	version = '4.6'
 	ansi = False
-	version = '4.5'
 	verbose = False
 	addlogs = False
 	mindevlen = 0.0
 	mincglen = 0.0
 	cgphase = ''
 	cgtest = -1
+	max_graph_depth = 0
 	callloopmaxgap = 0.0001
 	callloopmaxlen = 0.005
 	srgap = 0
@@ -106,8 +104,8 @@ class SystemValues:
 	ftracefile = ''
 	htmlfile = ''
 	embedded = False
-	rtcwake = False
-	rtcwaketime = 10
+	rtcwake = True
+	rtcwaketime = 15
 	rtcpath = ''
 	devicefilter = []
 	stamp = 0
@@ -235,6 +233,12 @@ class SystemValues:
 			self.rtcpath = rtc
 		if (hasattr(sys.stdout, 'isatty') and sys.stdout.isatty()):
 			self.ansi = True
+	def rootUser(self, fatal=False):
+		if 'USER' in os.environ and os.environ['USER'] == 'root':
+			return True
+		if fatal:
+			doError('This command must be run as root')
+		return False
 	def setPrecision(self, num):
 		if num < 0 or num > 6:
 			return
@@ -564,7 +568,7 @@ class SystemValues:
 		self.fsetVal('global', 'trace_clock')
 		# set trace buffer to a huge value
 		self.fsetVal('nop', 'current_tracer')
-		self.fsetVal('100000', 'buffer_size_kb')
+		self.fsetVal('131073', 'buffer_size_kb')
 		# go no further if this is just a status check
 		if testing:
 			return
@@ -583,7 +587,7 @@ class SystemValues:
 			self.fsetVal('nofuncgraph-overhead', 'trace_options')
 			self.fsetVal('context-info', 'trace_options')
 			self.fsetVal('graph-time', 'trace_options')
-			self.fsetVal('0', 'max_graph_depth')
+			self.fsetVal('%d' % self.max_graph_depth, 'max_graph_depth')
 			cf = ['dpm_run_callback']
 			if(self.usetraceeventsonly):
 				cf += ['dpm_prepare', 'dpm_complete']
@@ -639,6 +643,12 @@ class SystemValues:
 		return '\x1B[%d;40m%s\x1B[m' % (color, str)
 
 sysvals = SystemValues()
+suspendmodename = {
+	'freeze': 'Freeze (S0)',
+	'standby': 'Standby (S1)',
+	'mem': 'Suspend (S3)',
+	'disk': 'Hibernate (S4)'
+}
 
 # Class: DevProps
 # Description:
@@ -1013,6 +1023,8 @@ class Data:
 		tmp = dict()
 		for devname in list:
 			dev = list[devname]
+			if dev['length'] == 0:
+				continue
 			tmp[dev['start']] = devname
 		for t in sorted(tmp):
 			slist.append(tmp[t])
@@ -1477,12 +1489,14 @@ class FTraceLine:
 #	 Each instance is tied to a single device in a single phase, and is
 #	 comprised of an ordered list of FTraceLine objects
 class FTraceCallGraph:
+	id = ''
 	start = -1.0
 	end = -1.0
 	list = []
 	invalid = False
 	depth = 0
 	pid = 0
+	name = ''
 	def __init__(self, pid):
 		self.start = -1.0
 		self.end = -1.0
@@ -1631,9 +1645,17 @@ class FTraceCallGraph:
 				return True
 		return False
 	def postProcess(self, debug=False):
+		if len(self.list) > 0:
+			self.name = self.list[0].name
 		stack = dict()
 		cnt = 0
+		last = 0
 		for l in self.list:
+			# ftrace bug: reported duration is not reliable
+			# check each leaf and clip it at max possible length
+			if(last and last.freturn and last.fcall):
+				if last.length > l.time - last.time:
+					last.length = l.time - last.time
 			if(l.fcall and not l.freturn):
 				stack[l.depth] = l
 				cnt += 1
@@ -1643,11 +1665,12 @@ class FTraceCallGraph:
 						print 'Post Process Error: Depth missing'
 						l.debugPrint()
 					return False
-				# transfer total time from return line to call line
-				stack[l.depth].length = l.length
+				# calculate call length from call/return lines
+				stack[l.depth].length = l.time - stack[l.depth].time
 				stack.pop(l.depth)
 				l.length = 0
 				cnt -= 1
+			last = l
 		if(cnt == 0):
 			# trace caught the whole call tree
 			return True
@@ -1664,8 +1687,8 @@ class FTraceCallGraph:
 			'dpm_prepare': 'suspend_prepare',
 			'dpm_complete': 'resume_complete'
 		}
-		if(self.list[0].name in borderphase):
-			p = borderphase[self.list[0].name]
+		if(self.name in borderphase):
+			p = borderphase[self.name]
 			list = data.dmesg[p]['list']
 			for devname in list:
 				dev = list[devname]
@@ -1690,7 +1713,7 @@ class FTraceCallGraph:
 				break
 		return found
 	def newActionFromFunction(self, data):
-		name = self.list[0].name
+		name = self.name
 		if name in ['dpm_run_callback', 'dpm_prepare', 'dpm_complete']:
 			return
 		fs = self.start
@@ -1710,7 +1733,7 @@ class FTraceCallGraph:
 			phase, myname = out
 			data.dmesg[phase]['list'][myname]['ftrace'] = self
 	def debugPrint(self):
-		print('[%f - %f] %s (%d)') % (self.start, self.end, self.list[0].name, self.pid)
+		print('[%f - %f] %s (%d)') % (self.start, self.end, self.name, self.pid)
 		for l in self.list:
 			if(l.freturn and l.fcall):
 				print('%f (%02d): %s(); (%.3f us)' % (l.time, \
@@ -1738,7 +1761,7 @@ class DevItem:
 #	 A container for a device timeline which calculates
 #	 all the html properties to display it correctly
 class Timeline:
-	html = {}
+	html = ''
 	height = 0	# total timeline height
 	scaleH = 20	# timescale (top) row height
 	rowH = 30	# device row height
@@ -1746,14 +1769,28 @@ class Timeline:
 	rows = 0	# total timeline rows
 	rowlines = dict()
 	rowheight = dict()
+	html_tblock = '<div id="block{0}" class="tblock" style="left:{1}%;width:{2}%;"><div class="tback" style="height:{3}px"></div>\n'
+	html_device = '<div id="{0}" title="{1}" class="thread{7}" style="left:{2}%;top:{3}px;height:{4}px;width:{5}%;{8}">{6}</div>\n'
+	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}px;height:{3}px;background:{4}">{5}</div>\n'
+	html_phaselet = '<div id="{0}" class="phaselet" style="left:{1}%;width:{2}%;background:{3}"></div>\n'
 	def __init__(self, rowheight, scaleheight):
 		self.rowH = rowheight
 		self.scaleH = scaleheight
-		self.html = {
-			'header': '',
-			'timeline': '',
-			'legend': '',
-		}
+		self.html = ''
+	def createHeader(self, sv, suppress=''):
+		if(not sv.stamp['time']):
+			return
+		self.html += '<div class="version"><a href="https://01.org/suspendresume">%s v%s</a></div>' \
+			% (sv.title, sv.version)
+		if sv.logmsg and 'log' not in suppress:
+			self.html += '<button id="showtest" class="logbtn">log</button>'
+		if sv.addlogs and 'dmesg' not in suppress:
+			self.html += '<button id="showdmesg" class="logbtn">dmesg</button>'
+		if sv.addlogs and sv.ftracefile and 'ftrace' not in suppress:
+			self.html += '<button id="showftrace" class="logbtn">ftrace</button>'
+		headline_stamp = '<div class="stamp">{0} {1} {2} {3}</div>\n'
+		self.html += headline_stamp.format(sv.stamp['host'], sv.stamp['kernel'],
+			sv.stamp['mode'], sv.stamp['time'])
 	# Function: getDeviceRows
 	# Description:
 	#    determine how may rows the device funcs will take
@@ -1880,10 +1917,8 @@ class Timeline:
 				break
 			top += self.rowheight[test][phase][i]
 		return top
-	# Function: calcTotalRows
-	# Description:
-	#	 Calculate the heights and offsets for the header and rows
 	def calcTotalRows(self):
+		# Calculate the heights and offsets for the header and rows
 		maxrows = 0
 		standardphases = []
 		for t in self.rowlines:
@@ -1901,6 +1936,20 @@ class Timeline:
 		for t, p in standardphases:
 			for i in sorted(self.rowheight[t][p]):
 				self.rowheight[t][p][i] = self.bodyH/len(self.rowlines[t][p])
+	def createZoomBox(self, mode='command', testcount=1):
+		# Create bounding box, add buttons
+		html_zoombox = '<center><button id="zoomin">ZOOM IN +</button><button id="zoomout">ZOOM OUT -</button><button id="zoomdef">ZOOM 1:1</button></center>\n'
+		html_timeline = '<div id="dmesgzoombox" class="zoombox">\n<div id="{0}" class="timeline" style="height:{1}px">\n'
+		html_devlist1 = '<button id="devlist1" class="devlist" style="float:left;">Device Detail{0}</button>'
+		html_devlist2 = '<button id="devlist2" class="devlist" style="float:right;">Device Detail2</button>\n'
+		if mode != 'command':
+			if testcount > 1:
+				self.html += html_devlist2
+				self.html += html_devlist1.format('1')
+			else:
+				self.html += html_devlist1.format('')
+		self.html += html_zoombox
+		self.html += html_timeline.format('dmesg', self.height)
 	# Function: createTimeScale
 	# Description:
 	#	 Create the timescale for a timeline block
@@ -1913,7 +1962,7 @@ class Timeline:
 	#	 The html code needed to display the time scale
 	def createTimeScale(self, m0, mMax, tTotal, mode):
 		timescale = '<div class="t" style="right:{0}%">{1}</div>\n'
-		rline = '<div class="t" style="left:0;border-left:1px solid black;border-right:0;">Resume</div>\n'
+		rline = '<div class="t" style="left:0;border-left:1px solid black;border-right:0;">{0}</div>\n'
 		output = '<div class="timescale">\n'
 		# set scale for timeline
 		mTotal = mMax - m0
@@ -1926,21 +1975,20 @@ class Timeline:
 		divEdge = (mTotal - tS*(divTotal-1))*100/mTotal
 		for i in range(divTotal):
 			htmlline = ''
-			if(mode == 'resume'):
-				pos = '%0.3f' % (100 - ((float(i)*tS*100)/mTotal))
-				val = '%0.fms' % (float(i)*tS*1000)
-				htmlline = timescale.format(pos, val)
-				if(i == 0):
-					htmlline = rline
-			else:
+			if(mode == 'suspend'):
 				pos = '%0.3f' % (100 - ((float(i)*tS*100)/mTotal) - divEdge)
 				val = '%0.fms' % (float(i-divTotal+1)*tS*1000)
 				if(i == divTotal - 1):
-					val = 'Suspend'
+					val = mode
+				htmlline = timescale.format(pos, val)
+			else:
+				pos = '%0.3f' % (100 - ((float(i)*tS*100)/mTotal))
+				val = '%0.fms' % (float(i)*tS*1000)
 				htmlline = timescale.format(pos, val)
+				if(i == 0):
+					htmlline = rline.format(mode)
 			output += htmlline
-		output += '</div>\n'
-		return output
+		self.html += output+'</div>\n'
 
 # Class: TestProps
 # Description:
@@ -2009,7 +2057,7 @@ class ProcessMonitor:
 				val['kern'] = kern
 			if ujiff > 0 or kjiff > 0:
 				running[pid] = ujiff + kjiff
-		result = process.wait()
+		process.wait()
 		out = ''
 		for pid in running:
 			jiffies = running[pid]
@@ -2071,26 +2119,6 @@ def parseStamp(line, data):
 	if not sysvals.stamp:
 		sysvals.stamp = data.stamp
 
-# Function: diffStamp
-# Description:
-#	compare the host, kernel, and mode fields in 3 stamps
-# Arguments:
-#	 stamp1: string array with mode, kernel, and host
-#	 stamp2: string array with mode, kernel, and host
-# Return:
-#	True if stamps differ, False if they're the same
-def diffStamp(stamp1, stamp2):
-	if 'host' in stamp1 and 'host' in stamp2:
-		if stamp1['host'] != stamp2['host']:
-			return True
-	if 'kernel' in stamp1 and 'kernel' in stamp2:
-		if stamp1['kernel'] != stamp2['kernel']:
-			return True
-	if 'mode' in stamp1 and 'mode' in stamp2:
-		if stamp1['mode'] != stamp2['mode']:
-			return True
-	return False
-
 # Function: doesTraceLogHaveTraceEvents
 # Description:
 #	 Quickly determine if the ftrace log has some or all of the trace events
@@ -2722,7 +2750,7 @@ def parseTraceLog():
 			# create blocks for orphan cg data
 			for sortkey in sorted(sortlist):
 				cg = sortlist[sortkey]
-				name = cg.list[0].name
+				name = cg.name
 				if sysvals.isCallgraphFunc(name):
 					vprint('Callgraph found for task %d: %.3fms, %s' % (cg.pid, (cg.end - cg.start)*1000, name))
 					cg.newActionFromFunction(data)
@@ -3100,149 +3128,154 @@ def parseKernelLog(data):
 	data.fixupInitcallsThatDidntReturn()
 	return True
 
+def callgraphHTML(sv, hf, num, cg, title, color, devid):
+	html_func_top = '<article id="{0}" class="atop" style="background:{1}">\n<input type="checkbox" class="pf" id="f{2}" checked/><label for="f{2}">{3} {4}</label>\n'
+	html_func_start = '<article>\n<input type="checkbox" class="pf" id="f{0}" checked/><label for="f{0}">{1} {2}</label>\n'
+	html_func_end = '</article>\n'
+	html_func_leaf = '<article>{0} {1}</article>\n'
+
+	cgid = devid
+	if cg.id:
+		cgid += cg.id
+	cglen = (cg.end - cg.start) * 1000
+	if cglen < sv.mincglen:
+		return num
+
+	fmt = '<r>(%.3f ms @ '+sv.timeformat+' to '+sv.timeformat+')</r>'
+	flen = fmt % (cglen, cg.start, cg.end)
+	hf.write(html_func_top.format(cgid, color, num, title, flen))
+	num += 1
+	for line in cg.list:
+		if(line.length < 0.000000001):
+			flen = ''
+		else:
+			fmt = '<n>(%.3f ms @ '+sv.timeformat+')</n>'
+			flen = fmt % (line.length*1000, line.time)
+		if(line.freturn and line.fcall):
+			hf.write(html_func_leaf.format(line.name, flen))
+		elif(line.freturn):
+			hf.write(html_func_end)
+		else:
+			hf.write(html_func_start.format(num, line.name, flen))
+			num += 1
+	hf.write(html_func_end)
+	return num
+
+def addCallgraphs(sv, hf, data):
+	hf.write('<section id="callgraphs" class="callgraph">\n')
+	# write out the ftrace data converted to html
+	num = 0
+	for p in data.phases:
+		if sv.cgphase and p != sv.cgphase:
+			continue
+		list = data.dmesg[p]['list']
+		for devname in data.sortedDevices(p):
+			dev = list[devname]
+			color = 'white'
+			if 'color' in data.dmesg[p]:
+				color = data.dmesg[p]['color']
+			if 'color' in dev:
+				color = dev['color']
+			name = devname
+			if(devname in sv.devprops):
+				name = sv.devprops[devname].altName(devname)
+			if sv.suspendmode in suspendmodename:
+				name += ' '+p
+			if('ftrace' in dev):
+				cg = dev['ftrace']
+				num = callgraphHTML(sv, hf, num, cg,
+					name, color, dev['id'])
+			if('ftraces' in dev):
+				for cg in dev['ftraces']:
+					num = callgraphHTML(sv, hf, num, cg,
+						name+' &rarr; '+cg.name, color, dev['id'])
+
+	hf.write('\n\n    </section>\n')
+
 # Function: createHTMLSummarySimple
 # Description:
 #	 Create summary html file for a series of tests
 # Arguments:
 #	 testruns: array of Data objects from parseTraceLog
-def createHTMLSummarySimple(testruns, htmlfile):
-	# print out the basic summary of all the tests
-	hf = open(htmlfile, 'w')
-
+def createHTMLSummarySimple(testruns, htmlfile, folder):
 	# write the html header first (html head, css code, up to body start)
 	html = '<!DOCTYPE html>\n<html>\n<head>\n\
 	<meta http-equiv="content-type" content="text/html; charset=UTF-8">\n\
-	<title>AnalyzeSuspend Summary</title>\n\
+	<title>SleepGraph Summary</title>\n\
 	<style type=\'text/css\'>\n\
-		body {overflow-y: scroll;}\n\
-		.stamp {width: 100%;text-align:center;background-color:#495E09;line-height:30px;color:white;font: 25px Arial;}\n\
+		.stamp {width: 100%;text-align:center;background:#888;line-height:30px;color:white;font: 25px Arial;}\n\
 		table {width:100%;border-collapse: collapse;}\n\
-		.summary {font: 22px Arial;border:1px solid;}\n\
-		th {border: 1px solid black;background-color:#A7C942;color:white;}\n\
-		td {text-align: center;}\n\
-		tr.alt td {background-color:#EAF2D3;}\n\
-		tr.avg td {background-color:#BDE34C;}\n\
-		a:link {color: #90B521;}\n\
-		a:visited {color: #495E09;}\n\
-		a:hover {color: #B1DF28;}\n\
-		a:active {color: #FFFFFF;}\n\
+		.summary {border:1px solid;}\n\
+		th {border: 1px solid black;background:#222;color:white;}\n\
+		td {font: 16px "Times New Roman";text-align: center;}\n\
+		tr.alt td {background:#ddd;}\n\
+		tr.avg td {background:#aaa;}\n\
 	</style>\n</head>\n<body>\n'
 
 	# group test header
-	count = len(testruns)
-	headline_stamp = '<div class="stamp">{0} {1} {2} {3} ({4} tests)</div>\n'
-	html += headline_stamp.format(sysvals.stamp['host'],
-		sysvals.stamp['kernel'], sysvals.stamp['mode'],
-		sysvals.stamp['time'], count)
-
-	# check to see if all the tests have the same value
-	stampcolumns = False
-	for data in testruns:
-		if diffStamp(sysvals.stamp, data.stamp):
-			stampcolumns = True
-			break
-
+	html += '<div class="stamp">%s (%d tests)</div>\n' % (folder, len(testruns))
 	th = '\t<th>{0}</th>\n'
 	td = '\t<td>{0}</td>\n'
-	tdlink = '\t<td><a href="{0}">Click Here</a></td>\n'
+	tdlink = '\t<td><a href="{0}">html</a></td>\n'
 
 	# table header
-	html += '<table class="summary">\n<tr>\n'
-	html += th.format("Test #")
-	if stampcolumns:
-		html += th.format("Hostname")
-		html += th.format("Kernel Version")
-		html += th.format("Suspend Mode")
-	html += th.format("Test Time")
-	html += th.format("Suspend Time")
-	html += th.format("Resume Time")
-	html += th.format("Detail")
-	html += '</tr>\n'
+	html += '<table class="summary">\n<tr>\n' + th.format('#') +\
+		th.format('Mode') + th.format('Host') + th.format('Kernel') +\
+		th.format('Test Time') + th.format('Suspend') + th.format('Resume') +\
+		th.format('Detail') + '</tr>\n'
 
 	# test data, 1 row per test
-	sTimeAvg = 0.0
-	rTimeAvg = 0.0
-	num = 1
-	for data in testruns:
-		# data.end is the end of post_resume
-		resumeEnd = data.dmesg['resume_complete']['end']
+	avg = '<tr class="avg"><td></td><td></td><td></td><td></td>'+\
+		'<td>Average of {0} {1} tests</td><td>{2}</td><td>{3}</td><td></td></tr>\n'
+	sTimeAvg = rTimeAvg = 0.0
+	mode = ''
+	num = 0
+	for data in sorted(testruns, key=lambda v:(v['mode'], v['host'], v['kernel'])):
+		if mode != data['mode']:
+			# test average line
+			if(num > 0):
+				sTimeAvg /= (num - 1)
+				rTimeAvg /= (num - 1)
+				html += avg.format('%d' % (num - 1), mode,
+					'%3.3f ms' % sTimeAvg, '%3.3f ms' % rTimeAvg)
+			sTimeAvg = rTimeAvg = 0.0
+			mode = data['mode']
+			num = 1
+		# alternate row color
 		if num % 2 == 1:
 			html += '<tr class="alt">\n'
 		else:
 			html += '<tr>\n'
-
-		# test num
-		html += td.format("test %d" % num)
+		html += td.format("%d" % num)
 		num += 1
-		if stampcolumns:
-			# host name
-			val = "unknown"
-			if('host' in data.stamp):
-				val = data.stamp['host']
-			html += td.format(val)
-			# host kernel
+		# basic info
+		for item in ['mode', 'host', 'kernel', 'time']:
 			val = "unknown"
-			if('kernel' in data.stamp):
-				val = data.stamp['kernel']
+			if(item in data):
+				val = data[item]
 			html += td.format(val)
-			# suspend mode
-			val = "unknown"
-			if('mode' in data.stamp):
-				val = data.stamp['mode']
-			html += td.format(val)
-		# test time
-		val = "unknown"
-		if('time' in data.stamp):
-			val = data.stamp['time']
-		html += td.format(val)
 		# suspend time
-		sTime = (data.tSuspended - data.start)*1000
+		sTime = float(data['suspend'])
 		sTimeAvg += sTime
-		html += td.format("%3.3f ms" % sTime)
+		html += td.format('%.3f ms' % sTime)
 		# resume time
-		rTime = (resumeEnd - data.tResumed)*1000
+		rTime = float(data['resume'])
 		rTimeAvg += rTime
-		html += td.format("%3.3f ms" % rTime)
+		html += td.format('%.3f ms' % rTime)
 		# link to the output html
-		html += tdlink.format(data.outfile)
-
-		html += '</tr>\n'
-
-	# last line: test average
-	if(count > 0):
-		sTimeAvg /= count
-		rTimeAvg /= count
-	html += '<tr class="avg">\n'
-	html += td.format('Average') 	# name
-	if stampcolumns:
-		html += td.format('')			# host
-		html += td.format('')			# kernel
-		html += td.format('')			# mode
-	html += td.format('')			# time
-	html += td.format("%3.3f ms" % sTimeAvg)	# suspend time
-	html += td.format("%3.3f ms" % rTimeAvg)	# resume time
-	html += td.format('')			# output link
-	html += '</tr>\n'
+		html += tdlink.format(data['url']) + '</tr>\n'
+	# last test average line
+	if(num > 0):
+		sTimeAvg /= (num - 1)
+		rTimeAvg /= (num - 1)
+		html += avg.format('%d' % (num - 1), mode,
+			'%3.3f ms' % sTimeAvg, '%3.3f ms' % rTimeAvg)
 
 	# flush the data to file
-	hf.write(html+'</table>\n')
-	hf.write('</body>\n</html>\n')
+	hf = open(htmlfile, 'w')
+	hf.write(html+'</table>\n</body>\n</html>\n')
 	hf.close()
 
-def htmlTitle():
-	modename = {
-		'freeze': 'Freeze (S0)',
-		'standby': 'Standby (S1)',
-		'mem': 'Suspend (S3)',
-		'disk': 'Hibernate (S4)'
-	}
-	kernel = sysvals.stamp['kernel']
-	host = sysvals.hostname[0].upper()+sysvals.hostname[1:]
-	mode = sysvals.suspendmode
-	if sysvals.suspendmode in modename:
-		mode = modename[sysvals.suspendmode]
-	return host+' '+mode+' '+kernel
-
 def ordinal(value):
 	suffix = 'th'
 	if value < 10 or value > 19:
@@ -3272,24 +3305,11 @@ def createHTML(testruns):
 			kerror = True
 		data.normalizeTime(testruns[-1].tSuspended)
 
-	x2changes = ['', 'absolute']
-	if len(testruns) > 1:
-		x2changes = ['1', 'relative']
 	# html function templates
-	headline_version = '<div class="version"><a href="https://01.org/suspendresume">AnalyzeSuspend v%s</a></div>' % sysvals.version
-	headline_stamp = '<div class="stamp">{0} {1} {2} {3}</div>\n'
-	html_devlist1 = '<button id="devlist1" class="devlist" style="float:left;">Device Detail%s</button>' % x2changes[0]
-	html_zoombox = '<center><button id="zoomin">ZOOM IN +</button><button id="zoomout">ZOOM OUT -</button><button id="zoomdef">ZOOM 1:1</button></center>\n'
-	html_devlist2 = '<button id="devlist2" class="devlist" style="float:right;">Device Detail2</button>\n'
-	html_timeline = '<div id="dmesgzoombox" class="zoombox">\n<div id="{0}" class="timeline" style="height:{1}px">\n'
-	html_tblock = '<div id="block{0}" class="tblock" style="left:{1}%;width:{2}%;"><div class="tback" style="height:{3}px"></div>\n'
-	html_device = '<div id="{0}" title="{1}" class="thread{7}" style="left:{2}%;top:{3}px;height:{4}px;width:{5}%;{8}">{6}</div>\n'
 	html_error = '<div id="{1}" title="kernel error/warning" class="err" style="right:{0}%">ERROR&rarr;</div>\n'
 	html_traceevent = '<div title="{0}" class="traceevent{6}" style="left:{1}%;top:{2}px;height:{3}px;width:{4}%;line-height:{3}px;{7}">{5}</div>\n'
 	html_cpuexec = '<div class="jiffie" style="left:{0}%;top:{1}px;height:{2}px;width:{3}%;background:{4};"></div>\n'
-	html_phase = '<div class="phase" style="left:{0}%;width:{1}%;top:{2}px;height:{3}px;background-color:{4}">{5}</div>\n'
-	html_phaselet = '<div id="{0}" class="phaselet" style="left:{1}%;width:{2}%;background:{3}"></div>\n'
-	html_legend = '<div id="p{3}" class="square" style="left:{0}%;background-color:{1}">&nbsp;{2}</div>\n'
+	html_legend = '<div id="p{3}" class="square" style="left:{0}%;background:{1}">&nbsp;{2}</div>\n'
 	html_timetotal = '<table class="time1">\n<tr>'\
 		'<td class="green" title="{3}">{2} Suspend Time: <b>{0} ms</b></td>'\
 		'<td class="yellow" title="{4}">{2} Resume Time: <b>{1} ms</b></td>'\
@@ -3311,20 +3331,18 @@ def createHTML(testruns):
 		'</tr>\n</table>\n'
 
 	# html format variables
-	hoverZ = 'z-index:8;'
-	if sysvals.usedevsrc:
-		hoverZ = ''
 	scaleH = 20
-	scaleTH = 20
 	if kerror:
 		scaleH = 40
-		scaleTH = 60
 
 	# device timeline
 	vprint('Creating Device Timeline...')
 
 	devtl = Timeline(30, scaleH)
 
+	# write the test title and general info header
+	devtl.createHeader(sysvals)
+
 	# Generate the header for this timeline
 	for data in testruns:
 		tTotal = data.end - data.start
@@ -3346,7 +3364,7 @@ def createHTML(testruns):
 			if(len(testruns) > 1):
 				testdesc = ordinal(data.testnumber+1)+' '+testdesc
 			thtml = html_timetotal3.format(run_time, testdesc)
-			devtl.html['header'] += thtml
+			devtl.html += thtml
 		elif data.fwValid:
 			suspend_time = '%.0f'%(sktime + (data.fwSuspend/1000000.0))
 			resume_time = '%.0f'%(rktime + (data.fwResume/1000000.0))
@@ -3363,10 +3381,10 @@ def createHTML(testruns):
 			else:
 				thtml = html_timetotal2.format(suspend_time, low_time, \
 					resume_time, testdesc1, stitle, rtitle)
-			devtl.html['header'] += thtml
+			devtl.html += thtml
 			sftime = '%.3f'%(data.fwSuspend / 1000000.0)
 			rftime = '%.3f'%(data.fwResume / 1000000.0)
-			devtl.html['header'] += html_timegroups.format('%.3f'%sktime, \
+			devtl.html += html_timegroups.format('%.3f'%sktime, \
 				sftime, rftime, '%.3f'%rktime, testdesc2, sysvals.suspendmode)
 		else:
 			suspend_time = '%.3f' % sktime
@@ -3382,7 +3400,7 @@ def createHTML(testruns):
 			else:
 				thtml = html_timetotal2.format(suspend_time, low_time, \
 					resume_time, testdesc, stitle, rtitle)
-			devtl.html['header'] += thtml
+			devtl.html += thtml
 
 	# time scale for potentially multiple datasets
 	t0 = testruns[0].start
@@ -3429,15 +3447,8 @@ def createHTML(testruns):
 			devtl.getPhaseRows(threadlist, devtl.rows)
 	devtl.calcTotalRows()
 
-	# create bounding box, add buttons
-	if sysvals.suspendmode != 'command':
-		devtl.html['timeline'] += html_devlist1
-		if len(testruns) > 1:
-			devtl.html['timeline'] += html_devlist2
-	devtl.html['timeline'] += html_zoombox
-	devtl.html['timeline'] += html_timeline.format('dmesg', devtl.height)
-
 	# draw the full timeline
+	devtl.createZoomBox(sysvals.suspendmode, len(testruns))
 	phases = {'suspend':[],'resume':[]}
 	for phase in data.dmesg:
 		if 'resume' in phase:
@@ -3452,37 +3463,36 @@ def createHTML(testruns):
 			# draw suspend and resume blocks separately
 			bname = '%s%d' % (dir[0], data.testnumber)
 			if dir == 'suspend':
-				m0 = testruns[data.testnumber].start
-				mMax = testruns[data.testnumber].tSuspended
-				mTotal = mMax - m0
+				m0 = data.start
+				mMax = data.tSuspended
 				left = '%f' % (((m0-t0)*100.0)/tTotal)
 			else:
-				m0 = testruns[data.testnumber].tSuspended
-				mMax = testruns[data.testnumber].end
+				m0 = data.tSuspended
+				mMax = data.end
 				# in an x2 run, remove any gap between blocks
 				if len(testruns) > 1 and data.testnumber == 0:
 					mMax = testruns[1].start
-				mTotal = mMax - m0
 				left = '%f' % ((((m0-t0)*100.0)+sysvals.srgap/2)/tTotal)
+			mTotal = mMax - m0
 			# if a timeline block is 0 length, skip altogether
 			if mTotal == 0:
 				continue
 			width = '%f' % (((mTotal*100.0)-sysvals.srgap/2)/tTotal)
-			devtl.html['timeline'] += html_tblock.format(bname, left, width, devtl.scaleH)
+			devtl.html += devtl.html_tblock.format(bname, left, width, devtl.scaleH)
 			for b in sorted(phases[dir]):
 				# draw the phase color background
 				phase = data.dmesg[b]
 				length = phase['end']-phase['start']
 				left = '%f' % (((phase['start']-m0)*100.0)/mTotal)
 				width = '%f' % ((length*100.0)/mTotal)
-				devtl.html['timeline'] += html_phase.format(left, width, \
+				devtl.html += devtl.html_phase.format(left, width, \
 					'%.3f'%devtl.scaleH, '%.3f'%devtl.bodyH, \
 					data.dmesg[b]['color'], '')
 			for e in data.errorinfo[dir]:
 				# draw red lines for any kernel errors found
 				t, err = e
 				right = '%f' % (((mMax-t)*100.0)/mTotal)
-				devtl.html['timeline'] += html_error.format(right, err)
+				devtl.html += html_error.format(right, err)
 			for b in sorted(phases[dir]):
 				# draw the devices for this phase
 				phaselist = data.dmesg[b]['list']
@@ -3496,7 +3506,7 @@ def createHTML(testruns):
 					if 'htmlclass' in dev:
 						xtraclass = dev['htmlclass']
 					if 'color' in dev:
-						xtrastyle = 'background-color:%s;' % dev['color']
+						xtrastyle = 'background:%s;' % dev['color']
 					if(d in sysvals.devprops):
 						name = sysvals.devprops[d].altName(d)
 						xtraclass = sysvals.devprops[d].xtraClass()
@@ -3521,7 +3531,7 @@ def createHTML(testruns):
 							title += 'post_resume_process'
 					else:
 						title += b
-					devtl.html['timeline'] += html_device.format(dev['id'], \
+					devtl.html += devtl.html_device.format(dev['id'], \
 						title, left, top, '%.3f'%rowheight, width, \
 						d+drv, xtraclass, xtrastyle)
 					if('cpuexec' in dev):
@@ -3535,7 +3545,7 @@ def createHTML(testruns):
 							left = '%f' % (((start-m0)*100)/mTotal)
 							width = '%f' % ((end-start)*100/mTotal)
 							color = 'rgba(255, 0, 0, %f)' % j
-							devtl.html['timeline'] += \
+							devtl.html += \
 								html_cpuexec.format(left, top, height, width, color)
 					if('src' not in dev):
 						continue
@@ -3548,20 +3558,20 @@ def createHTML(testruns):
 						xtrastyle = ''
 						if e.color:
 							xtrastyle = 'background:%s;' % e.color
-						devtl.html['timeline'] += \
+						devtl.html += \
 							html_traceevent.format(e.title(), \
 								left, top, height, width, e.text(), '', xtrastyle)
 			# draw the time scale, try to make the number of labels readable
-			devtl.html['timeline'] += devtl.createTimeScale(m0, mMax, tTotal, dir)
-			devtl.html['timeline'] += '</div>\n'
+			devtl.createTimeScale(m0, mMax, tTotal, dir)
+			devtl.html += '</div>\n'
 
 	# timeline is finished
-	devtl.html['timeline'] += '</div>\n</div>\n'
+	devtl.html += '</div>\n</div>\n'
 
 	# draw a legend which describes the phases by color
 	if sysvals.suspendmode != 'command':
 		data = testruns[-1]
-		devtl.html['legend'] = '<div class="legend">\n'
+		devtl.html += '<div class="legend">\n'
 		pdelta = 100.0/len(data.phases)
 		pmargin = pdelta / 4.0
 		for phase in data.phases:
@@ -3571,127 +3581,41 @@ def createHTML(testruns):
 				id += tmp[1][0]
 			order = '%.2f' % ((data.dmesg[phase]['order'] * pdelta) + pmargin)
 			name = string.replace(phase, '_', ' &nbsp;')
-			devtl.html['legend'] += html_legend.format(order, \
+			devtl.html += html_legend.format(order, \
 				data.dmesg[phase]['color'], name, id)
-		devtl.html['legend'] += '</div>\n'
+		devtl.html += '</div>\n'
 
 	hf = open(sysvals.htmlfile, 'w')
 
-	if not sysvals.cgexp:
-		cgchk = 'checked'
-		cgnchk = 'not(:checked)'
-	else:
-		cgchk = 'not(:checked)'
-		cgnchk = 'checked'
-
-	# write the html header first (html head, css code, up to body start)
-	html_header = '<!DOCTYPE html>\n<html>\n<head>\n\
-	<meta http-equiv="content-type" content="text/html; charset=UTF-8">\n\
-	<title>'+htmlTitle()+'</title>\n\
-	<style type=\'text/css\'>\n\
-		body {overflow-y:scroll;}\n\
-		.stamp {width:100%;text-align:center;background-color:gray;line-height:30px;color:white;font:25px Arial;}\n\
-		.callgraph {margin-top:30px;box-shadow:5px 5px 20px black;}\n\
-		.callgraph article * {padding-left:28px;}\n\
-		h1 {color:black;font:bold 30px Times;}\n\
-		t0 {color:black;font:bold 30px Times;}\n\
-		t1 {color:black;font:30px Times;}\n\
-		t2 {color:black;font:25px Times;}\n\
-		t3 {color:black;font:20px Times;white-space:nowrap;}\n\
-		t4 {color:black;font:bold 30px Times;line-height:60px;white-space:nowrap;}\n\
-		cS {font:bold 13px Times;}\n\
-		table {width:100%;}\n\
-		.gray {background-color:rgba(80,80,80,0.1);}\n\
-		.green {background-color:rgba(204,255,204,0.4);}\n\
-		.purple {background-color:rgba(128,0,128,0.2);}\n\
-		.yellow {background-color:rgba(255,255,204,0.4);}\n\
-		.time1 {font:22px Arial;border:1px solid;}\n\
-		.time2 {font:15px Arial;border-bottom:1px solid;border-left:1px solid;border-right:1px solid;}\n\
-		td {text-align:center;}\n\
-		r {color:#500000;font:15px Tahoma;}\n\
-		n {color:#505050;font:15px Tahoma;}\n\
-		.tdhl {color:red;}\n\
-		.hide {display:none;}\n\
-		.pf {display:none;}\n\
-		.pf:'+cgchk+' + label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/><rect x="8" y="4" width="2" height="10" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
-		.pf:'+cgnchk+' ~ label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
-		.pf:'+cgchk+' ~ *:not(:nth-child(2)) {display:none;}\n\
-		.zoombox {position:relative;width:100%;overflow-x:scroll;-webkit-user-select:none;-moz-user-select:none;user-select:none;}\n\
-		.timeline {position:relative;font-size:14px;cursor:pointer;width:100%; overflow:hidden;background:linear-gradient(#cccccc, white);}\n\
-		.thread {position:absolute;height:0%;overflow:hidden;z-index:7;line-height:30px;font-size:14px;border:1px solid;text-align:center;white-space:nowrap;}\n\
-		.thread.ps {border-radius:3px;background:linear-gradient(to top, #ccc, #eee);}\n\
-		.thread:hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
-		.thread.sec,.thread.sec:hover {background-color:black;border:0;color:white;line-height:15px;font-size:10px;}\n\
-		.hover {background-color:white;border:1px solid red;'+hoverZ+'}\n\
-		.hover.sync {background-color:white;}\n\
-		.hover.bg,.hover.kth,.hover.sync,.hover.ps {background-color:white;}\n\
-		.jiffie {position:absolute;pointer-events: none;z-index:8;}\n\
-		.traceevent {position:absolute;font-size:10px;z-index:7;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,#CCC,#969696);}\n\
-		.traceevent:hover {color:white;font-weight:bold;border:1px solid white;}\n\
-		.phase {position:absolute;overflow:hidden;border:0px;text-align:center;}\n\
-		.phaselet {position:absolute;overflow:hidden;border:0px;text-align:center;height:100px;font-size:24px;}\n\
-		.t {position:absolute;line-height:'+('%d'%scaleTH)+'px;pointer-events:none;top:0;height:100%;border-right:1px solid black;z-index:6;}\n\
-		.err {position:absolute;top:0%;height:100%;border-right:3px solid red;color:red;font:bold 14px Times;line-height:18px;}\n\
-		.legend {position:relative; width:100%; height:40px; text-align:center;margin-bottom:20px}\n\
-		.legend .square {position:absolute;cursor:pointer;top:10px; width:0px;height:20px;border:1px solid;padding-left:20px;}\n\
-		button {height:40px;width:200px;margin-bottom:20px;margin-top:20px;font-size:24px;}\n\
-		.logbtn {position:relative;float:right;height:25px;width:50px;margin-top:3px;margin-bottom:0;font-size:10px;text-align:center;}\n\
-		.devlist {position:'+x2changes[1]+';width:190px;}\n\
-		a:link {color:white;text-decoration:none;}\n\
-		a:visited {color:white;}\n\
-		a:hover {color:white;}\n\
-		a:active {color:white;}\n\
-		.version {position:relative;float:left;color:white;font-size:10px;line-height:30px;margin-left:10px;}\n\
-		#devicedetail {height:100px;box-shadow:5px 5px 20px black;}\n\
-		.tblock {position:absolute;height:100%;background-color:#ddd;}\n\
-		.tback {position:absolute;width:100%;background:linear-gradient(#ccc, #ddd);}\n\
-		.bg {z-index:1;}\n\
-	</style>\n</head>\n<body>\n'
-
 	# no header or css if its embedded
 	if(sysvals.embedded):
 		hf.write('pass True tSus %.3f tRes %.3f tLow %.3f fwvalid %s tSus %.3f tRes %.3f\n' %
 			(data.tSuspended-data.start, data.end-data.tSuspended, data.tLow, data.fwValid, \
 				data.fwSuspend/1000000, data.fwResume/1000000))
 	else:
-		hf.write(html_header)
-
-	# write the test title and general info header
-	if(sysvals.stamp['time'] != ""):
-		hf.write(headline_version)
-		if sysvals.logmsg:
-			hf.write('<button id="showtest" class="logbtn">log</button>')
-		if sysvals.addlogs and sysvals.dmesgfile:
-			hf.write('<button id="showdmesg" class="logbtn">dmesg</button>')
-		if sysvals.addlogs and sysvals.ftracefile:
-			hf.write('<button id="showftrace" class="logbtn">ftrace</button>')
-		hf.write(headline_stamp.format(sysvals.stamp['host'],
-			sysvals.stamp['kernel'], sysvals.stamp['mode'], \
-				sysvals.stamp['time']))
+		addCSS(hf, sysvals, len(testruns), kerror)
 
 	# write the device timeline
-	hf.write(devtl.html['header'])
-	hf.write(devtl.html['timeline'])
-	hf.write(devtl.html['legend'])
+	hf.write(devtl.html)
 	hf.write('<div id="devicedetailtitle"></div>\n')
 	hf.write('<div id="devicedetail" style="display:none;">\n')
 	# draw the colored boxes for the device detail section
 	for data in testruns:
 		hf.write('<div id="devicedetail%d">\n' % data.testnumber)
 		pscolor = 'linear-gradient(to top left, #ccc, #eee)'
-		hf.write(html_phaselet.format('pre_suspend_process', \
+		hf.write(devtl.html_phaselet.format('pre_suspend_process', \
 			'0', '0', pscolor))
 		for b in data.phases:
 			phase = data.dmesg[b]
 			length = phase['end']-phase['start']
 			left = '%.3f' % (((phase['start']-t0)*100.0)/tTotal)
 			width = '%.3f' % ((length*100.0)/tTotal)
-			hf.write(html_phaselet.format(b, left, width, \
+			hf.write(devtl.html_phaselet.format(b, left, width, \
 				data.dmesg[b]['color']))
-		hf.write(html_phaselet.format('post_resume_process', \
+		hf.write(devtl.html_phaselet.format('post_resume_process', \
 			'0', '0', pscolor))
 		if sysvals.suspendmode == 'command':
-			hf.write(html_phaselet.format('cmdexec', '0', '0', pscolor))
+			hf.write(devtl.html_phaselet.format('cmdexec', '0', '0', pscolor))
 		hf.write('</div>\n')
 	hf.write('</div>\n')
 
@@ -3701,52 +3625,7 @@ def createHTML(testruns):
 	else:
 		data = testruns[-1]
 	if(sysvals.usecallgraph and not sysvals.embedded):
-		hf.write('<section id="callgraphs" class="callgraph">\n')
-		# write out the ftrace data converted to html
-		html_func_top = '<article id="{0}" class="atop" style="background-color:{1}">\n<input type="checkbox" class="pf" id="f{2}" checked/><label for="f{2}">{3} {4}</label>\n'
-		html_func_start = '<article>\n<input type="checkbox" class="pf" id="f{0}" checked/><label for="f{0}">{1} {2}</label>\n'
-		html_func_end = '</article>\n'
-		html_func_leaf = '<article>{0} {1}</article>\n'
-		num = 0
-		for p in data.phases:
-			if sysvals.cgphase and p != sysvals.cgphase:
-				continue
-			list = data.dmesg[p]['list']
-			for devname in data.sortedDevices(p):
-				if('ftrace' not in list[devname]):
-					continue
-				devid = list[devname]['id']
-				cg = list[devname]['ftrace']
-				clen = (cg.end - cg.start) * 1000
-				if clen < sysvals.mincglen:
-					continue
-				fmt = '<r>(%.3f ms @ '+sysvals.timeformat+' to '+sysvals.timeformat+')</r>'
-				flen = fmt % (clen, cg.start, cg.end)
-				name = devname
-				if(devname in sysvals.devprops):
-					name = sysvals.devprops[devname].altName(devname)
-				if sysvals.suspendmode == 'command':
-					ftitle = name
-				else:
-					ftitle = name+' '+p
-				hf.write(html_func_top.format(devid, data.dmesg[p]['color'], \
-					num, ftitle, flen))
-				num += 1
-				for line in cg.list:
-					if(line.length < 0.000000001):
-						flen = ''
-					else:
-						fmt = '<n>(%.3f ms @ '+sysvals.timeformat+')</n>'
-						flen = fmt % (line.length*1000, line.time)
-					if(line.freturn and line.fcall):
-						hf.write(html_func_leaf.format(line.name, flen))
-					elif(line.freturn):
-						hf.write(html_func_end)
-					else:
-						hf.write(html_func_start.format(num, line.name, flen))
-						num += 1
-				hf.write(html_func_end)
-		hf.write('\n\n    </section>\n')
+		addCallgraphs(sysvals, hf, data)
 
 	# add the test log as a hidden div
 	if sysvals.logmsg:
@@ -3788,6 +3667,100 @@ def createHTML(testruns):
 	hf.close()
 	return True
 
+def addCSS(hf, sv, testcount=1, kerror=False, extra=''):
+	kernel = sv.stamp['kernel']
+	host = sv.hostname[0].upper()+sv.hostname[1:]
+	mode = sv.suspendmode
+	if sv.suspendmode in suspendmodename:
+		mode = suspendmodename[sv.suspendmode]
+	title = host+' '+mode+' '+kernel
+
+	# various format changes by flags
+	cgchk = 'checked'
+	cgnchk = 'not(:checked)'
+	if sv.cgexp:
+		cgchk = 'not(:checked)'
+		cgnchk = 'checked'
+
+	hoverZ = 'z-index:8;'
+	if sv.usedevsrc:
+		hoverZ = ''
+
+	devlistpos = 'absolute'
+	if testcount > 1:
+		devlistpos = 'relative'
+
+	scaleTH = 20
+	if kerror:
+		scaleTH = 60
+
+	# write the html header first (html head, css code, up to body start)
+	html_header = '<!DOCTYPE html>\n<html>\n<head>\n\
+	<meta http-equiv="content-type" content="text/html; charset=UTF-8">\n\
+	<title>'+title+'</title>\n\
+	<style type=\'text/css\'>\n\
+		body {overflow-y:scroll;}\n\
+		.stamp {width:100%;text-align:center;background:gray;line-height:30px;color:white;font:25px Arial;}\n\
+		.callgraph {margin-top:30px;box-shadow:5px 5px 20px black;}\n\
+		.callgraph article * {padding-left:28px;}\n\
+		h1 {color:black;font:bold 30px Times;}\n\
+		t0 {color:black;font:bold 30px Times;}\n\
+		t1 {color:black;font:30px Times;}\n\
+		t2 {color:black;font:25px Times;}\n\
+		t3 {color:black;font:20px Times;white-space:nowrap;}\n\
+		t4 {color:black;font:bold 30px Times;line-height:60px;white-space:nowrap;}\n\
+		cS {font:bold 13px Times;}\n\
+		table {width:100%;}\n\
+		.gray {background:rgba(80,80,80,0.1);}\n\
+		.green {background:rgba(204,255,204,0.4);}\n\
+		.purple {background:rgba(128,0,128,0.2);}\n\
+		.yellow {background:rgba(255,255,204,0.4);}\n\
+		.blue {background:rgba(169,208,245,0.4);}\n\
+		.time1 {font:22px Arial;border:1px solid;}\n\
+		.time2 {font:15px Arial;border-bottom:1px solid;border-left:1px solid;border-right:1px solid;}\n\
+		td {text-align:center;}\n\
+		r {color:#500000;font:15px Tahoma;}\n\
+		n {color:#505050;font:15px Tahoma;}\n\
+		.tdhl {color:red;}\n\
+		.hide {display:none;}\n\
+		.pf {display:none;}\n\
+		.pf:'+cgchk+' + label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/><rect x="8" y="4" width="2" height="10" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
+		.pf:'+cgnchk+' ~ label {background:url(\'data:image/svg+xml;utf,<?xml version="1.0" standalone="no"?><svg xmlns="http://www.w3.org/2000/svg" height="18" width="18" version="1.1"><circle cx="9" cy="9" r="8" stroke="black" stroke-width="1" fill="white"/><rect x="4" y="8" width="10" height="2" style="fill:black;stroke-width:0"/></svg>\') no-repeat left center;}\n\
+		.pf:'+cgchk+' ~ *:not(:nth-child(2)) {display:none;}\n\
+		.zoombox {position:relative;width:100%;overflow-x:scroll;-webkit-user-select:none;-moz-user-select:none;user-select:none;}\n\
+		.timeline {position:relative;font-size:14px;cursor:pointer;width:100%; overflow:hidden;background:linear-gradient(#cccccc, white);}\n\
+		.thread {position:absolute;height:0%;overflow:hidden;z-index:7;line-height:30px;font-size:14px;border:1px solid;text-align:center;white-space:nowrap;}\n\
+		.thread.ps {border-radius:3px;background:linear-gradient(to top, #ccc, #eee);}\n\
+		.thread:hover {background:white;border:1px solid red;'+hoverZ+'}\n\
+		.thread.sec,.thread.sec:hover {background:black;border:0;color:white;line-height:15px;font-size:10px;}\n\
+		.hover {background:white;border:1px solid red;'+hoverZ+'}\n\
+		.hover.sync {background:white;}\n\
+		.hover.bg,.hover.kth,.hover.sync,.hover.ps {background:white;}\n\
+		.jiffie {position:absolute;pointer-events: none;z-index:8;}\n\
+		.traceevent {position:absolute;font-size:10px;z-index:7;overflow:hidden;color:black;text-align:center;white-space:nowrap;border-radius:5px;border:1px solid black;background:linear-gradient(to bottom right,#CCC,#969696);}\n\
+		.traceevent:hover {color:white;font-weight:bold;border:1px solid white;}\n\
+		.phase {position:absolute;overflow:hidden;border:0px;text-align:center;}\n\
+		.phaselet {float:left;overflow:hidden;border:0px;text-align:center;min-height:100px;font-size:24px;}\n\
+		.t {position:absolute;line-height:'+('%d'%scaleTH)+'px;pointer-events:none;top:0;height:100%;border-right:1px solid black;z-index:6;}\n\
+		.err {position:absolute;top:0%;height:100%;border-right:3px solid red;color:red;font:bold 14px Times;line-height:18px;}\n\
+		.legend {position:relative; width:100%; height:40px; text-align:center;margin-bottom:20px}\n\
+		.legend .square {position:absolute;cursor:pointer;top:10px; width:0px;height:20px;border:1px solid;padding-left:20px;}\n\
+		button {height:40px;width:200px;margin-bottom:20px;margin-top:20px;font-size:24px;}\n\
+		.logbtn {position:relative;float:right;height:25px;width:50px;margin-top:3px;margin-bottom:0;font-size:10px;text-align:center;}\n\
+		.devlist {position:'+devlistpos+';width:190px;}\n\
+		a:link {color:white;text-decoration:none;}\n\
+		a:visited {color:white;}\n\
+		a:hover {color:white;}\n\
+		a:active {color:white;}\n\
+		.version {position:relative;float:left;color:white;font-size:10px;line-height:30px;margin-left:10px;}\n\
+		#devicedetail {min-height:100px;box-shadow:5px 5px 20px black;}\n\
+		.tblock {position:absolute;height:100%;background:#ddd;}\n\
+		.tback {position:absolute;width:100%;background:linear-gradient(#ccc, #ddd);}\n\
+		.bg {z-index:1;}\n\
+'+extra+'\
+	</style>\n</head>\n<body>\n'
+	hf.write(html_header)
+
 # Function: addScriptCode
 # Description:
 #	 Adds the javascript code to the output html
@@ -3809,7 +3782,7 @@ def addScriptCode(hf, testruns):
 	'	var resolution = -1;\n'\
 	'	var dragval = [0, 0];\n'\
 	'	function redrawTimescale(t0, tMax, tS) {\n'\
-	'		var rline = \'<div class="t" style="left:0;border-left:1px solid black;border-right:0;"><cS>&larr;R</cS></div>\';\n'\
+	'		var rline = \'<div class="t" style="left:0;border-left:1px solid black;border-right:0;">\';\n'\
 	'		var tTotal = tMax - t0;\n'\
 	'		var list = document.getElementsByClassName("tblock");\n'\
 	'		for (var i = 0; i < list.length; i++) {\n'\
@@ -3824,19 +3797,23 @@ def addScriptCode(hf, testruns):
 	'			var pos = 0.0, val = 0.0;\n'\
 	'			for (var j = 0; j < divTotal; j++) {\n'\
 	'				var htmlline = "";\n'\
-	'				if(list[i].id[5] == "r") {\n'\
-	'					pos = 100 - (((j)*tS*100)/mTotal);\n'\
-	'					val = (j)*tS;\n'\
-	'					htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
-	'					if(j == 0)\n'\
-	'						htmlline = rline;\n'\
-	'				} else {\n'\
+	'				var mode = list[i].id[5];\n'\
+	'				if(mode == "s") {\n'\
 	'					pos = 100 - (((j)*tS*100)/mTotal) - divEdge;\n'\
 	'					val = (j-divTotal+1)*tS;\n'\
 	'					if(j == divTotal - 1)\n'\
 	'						htmlline = \'<div class="t" style="right:\'+pos+\'%"><cS>S&rarr;</cS></div>\';\n'\
 	'					else\n'\
 	'						htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
+	'				} else {\n'\
+	'					pos = 100 - (((j)*tS*100)/mTotal);\n'\
+	'					val = (j)*tS;\n'\
+	'					htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
+	'					if(j == 0)\n'\
+	'						if(mode == "r")\n'\
+	'							htmlline = rline+"<cS>&larr;R</cS></div>";\n'\
+	'						else\n'\
+	'							htmlline = rline+"<cS>0ms</div>";\n'\
 	'				}\n'\
 	'				html += htmlline;\n'\
 	'			}\n'\
@@ -4002,12 +3979,80 @@ def addScriptCode(hf, testruns):
 	'				}\n'\
 	'			}\n'\
 	'		}\n'\
+	'		if(typeof devstats !== \'undefined\')\n'\
+	'			callDetail(this.id, this.title);\n'\
 	'		var cglist = document.getElementById("callgraphs");\n'\
 	'		if(!cglist) return;\n'\
 	'		var cg = cglist.getElementsByClassName("atop");\n'\
 	'		if(cg.length < 10) return;\n'\
 	'		for (var i = 0; i < cg.length; i++) {\n'\
-	'			if(idlist.indexOf(cg[i].id) >= 0) {\n'\
+	'			cgid = cg[i].id.split("x")[0]\n'\
+	'			if(idlist.indexOf(cgid) >= 0) {\n'\
+	'				cg[i].style.display = "block";\n'\
+	'			} else {\n'\
+	'				cg[i].style.display = "none";\n'\
+	'			}\n'\
+	'		}\n'\
+	'	}\n'\
+	'	function callDetail(devid, devtitle) {\n'\
+	'		if(!(devid in devstats) || devstats[devid].length < 1)\n'\
+	'			return;\n'\
+	'		var list = devstats[devid];\n'\
+	'		var tmp = devtitle.split(" ");\n'\
+	'		var name = tmp[0], phase = tmp[tmp.length-1];\n'\
+	'		var dd = document.getElementById(phase);\n'\
+	'		var total = parseFloat(tmp[1].slice(1));\n'\
+	'		var mlist = [];\n'\
+	'		var maxlen = 0;\n'\
+	'		var info = []\n'\
+	'		for(var i in list) {\n'\
+	'			if(list[i][0] == "@") {\n'\
+	'				info = list[i].split("|");\n'\
+	'				continue;\n'\
+	'			}\n'\
+	'			var tmp = list[i].split("|");\n'\
+	'			var t = parseFloat(tmp[0]), f = tmp[1], c = parseInt(tmp[2]);\n'\
+	'			var p = (t*100.0/total).toFixed(2);\n'\
+	'			mlist[mlist.length] = [f, c, t.toFixed(2), p+"%"];\n'\
+	'			if(f.length > maxlen)\n'\
+	'				maxlen = f.length;\n'\
+	'		}\n'\
+	'		var pad = 5;\n'\
+	'		if(mlist.length == 0) pad = 30;\n'\
+	'		var html = \'<div style="padding-top:\'+pad+\'px"><t3> <b>\'+name+\':</b>\';\n'\
+	'		if(info.length > 2)\n'\
+	'			html += " start=<b>"+info[1]+"</b>, end=<b>"+info[2]+"</b>";\n'\
+	'		if(info.length > 3)\n'\
+	'			html += ", length<i>(w/o overhead)</i>=<b>"+info[3]+" ms</b>";\n'\
+	'		if(info.length > 4)\n'\
+	'			html += ", return=<b>"+info[4]+"</b>";\n'\
+	'		html += "</t3></div>";\n'\
+	'		if(mlist.length > 0) {\n'\
+	'			html += \'<table class=fstat style="padding-top:\'+(maxlen*5)+\'px;"><tr><th>Function</th>\';\n'\
+	'			for(var i in mlist)\n'\
+	'				html += "<td class=vt>"+mlist[i][0]+"</td>";\n'\
+	'			html += "</tr><tr><th>Calls</th>";\n'\
+	'			for(var i in mlist)\n'\
+	'				html += "<td>"+mlist[i][1]+"</td>";\n'\
+	'			html += "</tr><tr><th>Time(ms)</th>";\n'\
+	'			for(var i in mlist)\n'\
+	'				html += "<td>"+mlist[i][2]+"</td>";\n'\
+	'			html += "</tr><tr><th>Percent</th>";\n'\
+	'			for(var i in mlist)\n'\
+	'				html += "<td>"+mlist[i][3]+"</td>";\n'\
+	'			html += "</tr></table>";\n'\
+	'		}\n'\
+	'		dd.innerHTML = html;\n'\
+	'		var height = (maxlen*5)+100;\n'\
+	'		dd.style.height = height+"px";\n'\
+	'		document.getElementById("devicedetail").style.height = height+"px";\n'\
+	'	}\n'\
+	'	function callSelect() {\n'\
+	'		var cglist = document.getElementById("callgraphs");\n'\
+	'		if(!cglist) return;\n'\
+	'		var cg = cglist.getElementsByClassName("atop");\n'\
+	'		for (var i = 0; i < cg.length; i++) {\n'\
+	'			if(this.id == cg[i].id) {\n'\
 	'				cg[i].style.display = "block";\n'\
 	'			} else {\n'\
 	'				cg[i].style.display = "none";\n'\
@@ -4093,6 +4138,9 @@ def addScriptCode(hf, testruns):
 	'			dev[i].onmouseover = deviceHover;\n'\
 	'			dev[i].onmouseout = deviceUnhover;\n'\
 	'		}\n'\
+	'		var dev = dmesg.getElementsByClassName("srccall");\n'\
+	'		for (var i = 0; i < dev.length; i++)\n'\
+	'			dev[i].onclick = callSelect;\n'\
 	'		zoomTimeline();\n'\
 	'	});\n'\
 	'</script>\n'
@@ -4675,7 +4723,7 @@ def rootCheck(fatal):
 	if(os.access(sysvals.powerfile, os.W_OK)):
 		return True
 	if fatal:
-		doError('This command must be run as root')
+		doError('This command requires sysfs mount and root access')
 	return False
 
 # Function: getArgInt
@@ -4767,51 +4815,62 @@ def runTest(subdir, testpath=''):
 		cmd = 'chown -R {0}:{0} {1} > /dev/null 2>&1'
 		call(cmd.format(os.environ['SUDO_USER'], sysvals.testdir), shell=True)
 
+def find_in_html(html, strs, div=False):
+	for str in strs:
+		l = len(str)
+		i = html.find(str)
+		if i >= 0:
+			break
+	if i < 0:
+		return ''
+	if not div:
+		return re.search(r'[-+]?\d*\.\d+|\d+', html[i+l:i+l+50]).group()
+	n = html[i+l:].find('</div>')
+	if n < 0:
+		return ''
+	return html[i+l:i+l+n]
+
 # Function: runSummary
 # Description:
 #	 create a summary of tests in a sub-directory
-def runSummary(subdir, output):
-	# get a list of ftrace output files
-	files = []
+def runSummary(subdir, local=True):
+	inpath = os.path.abspath(subdir)
+	outpath = inpath
+	if local:
+		outpath = os.path.abspath('.')
+	print('Generating a summary of folder "%s"' % inpath)
+	testruns = []
 	for dirname, dirnames, filenames in os.walk(subdir):
 		for filename in filenames:
-			if(re.match('.*_ftrace.txt', filename)):
-				files.append("%s/%s" % (dirname, filename))
-
-	# process the files in order and get an array of data objects
-	testruns = []
-	for file in sorted(files):
-		if output:
-			print("Test found in %s" % os.path.dirname(file))
-		sysvals.ftracefile = file
-		sysvals.dmesgfile = file.replace('_ftrace.txt', '_dmesg.txt')
-		doesTraceLogHaveTraceEvents()
-		sysvals.usecallgraph = False
-		if not sysvals.usetraceeventsonly:
-			if(not os.path.exists(sysvals.dmesgfile)):
-				print("Skipping %s: not a valid test input" % file)
+			if(not re.match('.*.html', filename)):
 				continue
-			else:
-				if output:
-					f = os.path.basename(sysvals.ftracefile)
-					d = os.path.basename(sysvals.dmesgfile)
-					print("\tInput files: %s and %s" % (f, d))
-				testdata = loadKernelLog()
-				data = testdata[0]
-				parseKernelLog(data)
-				testdata = [data]
-				appendIncompleteTraceLog(testdata)
-		else:
-			if output:
-				print("\tInput file: %s" % os.path.basename(sysvals.ftracefile))
-			testdata = parseTraceLog()
-			data = testdata[0]
-		data.normalizeTime(data.tSuspended)
-		link = file.replace(subdir+'/', '').replace('_ftrace.txt', '.html')
-		data.outfile = link
-		testruns.append(data)
-
-	createHTMLSummarySimple(testruns, subdir+'/summary.html')
+			file = os.path.join(dirname, filename)
+			html = open(file, 'r').read(10000)
+			suspend = find_in_html(html,
+				['Kernel Suspend: ', 'Kernel Suspend Time: '])
+			resume = find_in_html(html,
+				['Kernel Resume: ', 'Kernel Resume Time: '])
+			line = find_in_html(html, ['<div class="stamp">'], True)
+			stmp = line.split()
+			if not suspend or not resume or len(stmp) < 4:
+				continue
+			data = {
+				'host': stmp[0],
+				'kernel': stmp[1],
+				'mode': stmp[2],
+				'time': string.join(stmp[3:], ' '),
+				'suspend': suspend,
+				'resume': resume,
+				'url': os.path.relpath(file, outpath),
+			}
+			if len(stmp) == 7:
+				data['kernel'] = 'unknown'
+				data['mode'] = stmp[1]
+				data['time'] = string.join(stmp[2:], ' ')
+			testruns.append(data)
+	outfile = os.path.join(outpath, 'summary.html')
+	print('Summary file: %s' % outfile)
+	createHTMLSummarySimple(testruns, outfile, inpath)
 
 # Function: checkArgBool
 # Description:
@@ -4869,9 +4928,14 @@ def configFromFile(file):
 				sysvals.predelay = getArgInt('-predelay', value, 0, 60000, False)
 			elif(opt.lower() == 'postdelay'):
 				sysvals.postdelay = getArgInt('-postdelay', value, 0, 60000, False)
+			elif(opt.lower() == 'maxdepth'):
+				sysvals.max_graph_depth = getArgInt('-maxdepth', value, 0, 1000, False)
 			elif(opt.lower() == 'rtcwake'):
-				sysvals.rtcwake = True
-				sysvals.rtcwaketime = getArgInt('-rtcwake', value, 0, 3600, False)
+				if value.lower() == 'off':
+					sysvals.rtcwake = False
+				else:
+					sysvals.rtcwake = True
+					sysvals.rtcwaketime = getArgInt('-rtcwake', value, 0, 3600, False)
 			elif(opt.lower() == 'timeprec'):
 				sysvals.setPrecision(getArgInt('-timeprec', value, 0, 6, False))
 			elif(opt.lower() == 'mindev'):
@@ -4969,8 +5033,8 @@ def printHelp():
 	modes = getModes()
 
 	print('')
-	print('AnalyzeSuspend v%s' % sysvals.version)
-	print('Usage: sudo analyze_suspend.py <options>')
+	print('%s v%s' % (sysvals.title, sysvals.version))
+	print('Usage: sudo sleepgraph <options> <commands>')
 	print('')
 	print('Description:')
 	print('  This tool is designed to assist kernel and OS developers in optimizing')
@@ -4981,22 +5045,22 @@ def printHelp():
 	print('  a detailed view of which devices/subsystems are taking the most')
 	print('  time in suspend/resume.')
 	print('')
+	print('  If no specific command is given, the default behavior is to initiate')
+	print('  a suspend/resume and capture the dmesg/ftrace output as an html timeline.')
+	print('')
 	print('  Generates output files in subdirectory: suspend-mmddyy-HHMMSS')
 	print('   HTML output:                    <hostname>_<mode>.html')
 	print('   raw dmesg output:               <hostname>_<mode>_dmesg.txt')
 	print('   raw ftrace output:              <hostname>_<mode>_ftrace.txt')
 	print('')
 	print('Options:')
-	print('  [general]')
 	print('   -h           Print this help text')
 	print('   -v           Print the current tool version')
 	print('   -config fn   Pull arguments and config options from file fn')
 	print('   -verbose     Print extra information during execution and analysis')
-	print('   -status      Test to see if the system is enabled to run this tool')
-	print('   -modes       List available suspend modes')
 	print('   -m mode      Mode to initiate for suspend %s (default: %s)') % (modes, sysvals.suspendmode)
 	print('   -o subdir    Override the output subdirectory')
-	print('   -rtcwake t   Use rtcwake to autoresume after <t> seconds (default: disabled)')
+	print('   -rtcwake t   Wakeup t seconds after suspend, set t to "off" to disable (default: 15)')
 	print('   -addlogs     Add the dmesg and ftrace logs to the html output')
 	print('   -srgap       Add a visible gap in the timeline between sus/res (default: disabled)')
 	print('  [advanced]')
@@ -5012,23 +5076,25 @@ def printHelp():
 	print('                be created in a new subdirectory with a summary page.')
 	print('  [debug]')
 	print('   -f           Use ftrace to create device callgraphs (default: disabled)')
+	print('   -maxdepth N  limit the callgraph data to N call levels (default: 0=all)')
 	print('   -expandcg    pre-expand the callgraph data in the html output (default: disabled)')
-	print('   -flist       Print the list of functions currently being captured in ftrace')
-	print('   -flistall    Print all functions capable of being captured in ftrace')
 	print('   -fadd file   Add functions to be graphed in the timeline from a list in a text file')
 	print('   -filter "d1,d2,..." Filter out all but this comma-delimited list of device names')
 	print('   -mincg  ms   Discard all callgraphs shorter than ms milliseconds (e.g. 0.001 for us)')
 	print('   -cgphase P   Only show callgraph data for phase P (e.g. suspend_late)')
 	print('   -cgtest N    Only show callgraph data for test N (e.g. 0 or 1 in an x2 run)')
 	print('   -timeprec N  Number of significant digits in timestamps (0:S, [3:ms], 6:us)')
-	print('  [utilities]')
+	print('  [commands]')
+	print('   -ftrace ftracefile  Create HTML output using ftrace input (used with -dmesg)')
+	print('   -dmesg dmesgfile    Create HTML output using dmesg (used with -ftrace)')
+	print('   -summary directory  Create a summary of all test in this dir')
+	print('   -modes       List available suspend modes')
+	print('   -status      Test to see if the system is enabled to run this tool')
 	print('   -fpdt        Print out the contents of the ACPI Firmware Performance Data Table')
 	print('   -usbtopo     Print out the current USB topology with power info')
 	print('   -usbauto     Enable autosuspend for all connected USB devices')
-	print('  [re-analyze data from previous runs]')
-	print('   -ftrace ftracefile  Create HTML output using ftrace input')
-	print('   -dmesg dmesgfile    Create HTML output using dmesg (not needed for kernel >= 3.15)')
-	print('   -summary directory  Create a summary of all test in this dir')
+	print('   -flist       Print the list of functions currently being captured in ftrace')
+	print('   -flistall    Print all functions capable of being captured in ftrace')
 	print('')
 	return True
 
@@ -5076,9 +5142,18 @@ if __name__ == '__main__':
 			sysvals.useprocmon = True
 		elif(arg == '-dev'):
 			sysvals.usedevsrc = True
+		elif(arg == '-maxdepth'):
+			sysvals.max_graph_depth = getArgInt('-maxdepth', args, 0, 1000)
 		elif(arg == '-rtcwake'):
-			sysvals.rtcwake = True
-			sysvals.rtcwaketime = getArgInt('-rtcwake', args, 0, 3600)
+			try:
+				val = args.next()
+			except:
+				doError('No rtcwake time supplied', True)
+			if val.lower() == 'off':
+				sysvals.rtcwake = False
+			else:
+				sysvals.rtcwake = True
+				sysvals.rtcwaketime = getArgInt('-rtcwake', val, 0, 3600, False)
 		elif(arg == '-timeprec'):
 			sysvals.setPrecision(getArgInt('-timeprec', args, 0, 6))
 		elif(arg == '-mindev'):
@@ -5201,7 +5276,6 @@ if __name__ == '__main__':
 		elif(cmd == 'usbauto'):
 			setUSBDevicesAuto()
 		elif(cmd == 'summary'):
-			print("Generating a summary of folder \"%s\"" % cmdarg)
 			runSummary(cmdarg, True)
 		sys.exit()
 
-- 
2.7.4
