From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 4/5] scripts: AnalyzeSuspend v4.2 part4
Date: Thu, 14 Jul 2016 14:09:28 -0700
Message-ID: <fbb56ea77d857adc64585a3eab038ac7f6fcd63a.1468530071.git.todd.e.brandt@linux.intel.com>
References: <cover.1468530071.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:56645 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150AbcGNVJh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
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
 scripts/analyze_suspend.py | 715 +++++++++++++++++++++++++++------------------
 1 file changed, 437 insertions(+), 278 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index c9c477e..b93bb07 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -3366,12 +3366,15 @@ def createHTML(testruns):
 			width = '%.3f' % ((length*100.0)/tTotal)
 			hf.write(html_phaselet.format(b, left, width, \
 				data.dmesg[b]['color']))
+		if sysvals.suspendmode == 'command':
+			hf.write(html_phaselet.format('cmdexec', '0', '0', \
+				data.dmesg['resume_complete']['color']))
 		hf.write('</div>\n')
 	hf.write('</div>\n')
 
 	# write the ftrace data (callgraph)
 	data = testruns[-1]
-	if(sysvals.usecallgraph):
+	if(sysvals.usecallgraph and not sysvals.embedded):
 		hf.write('<section id="callgraphs" class="callgraph">\n')
 		# write out the ftrace data converted to html
 		html_func_top = '<article id="{0}" class="atop" style="background-color:{1}">\n<input type="checkbox" class="pf" id="f{2}" checked/><label for="f{2}">{3} {4}</label>\n'
@@ -3384,22 +3387,29 @@ def createHTML(testruns):
 			for devname in data.sortedDevices(p):
 				if('ftrace' not in list[devname]):
 					continue
-				name = devname
-				if(devname in sysvals.altdevname):
-					name = sysvals.altdevname[devname]
 				devid = list[devname]['id']
 				cg = list[devname]['ftrace']
-				flen = '<r>(%.3f ms @ %.3f to %.3f)</r>' % \
-					((cg.end - cg.start)*1000, cg.start*1000, cg.end*1000)
+				clen = (cg.end - cg.start) * 1000
+				if clen < sysvals.mincglen:
+					continue
+				fmt = '<r>(%.3f ms @ '+sysvals.timeformat+' to '+sysvals.timeformat+')</r>'
+				flen = fmt % (clen, cg.start, cg.end)
+				name = devname
+				if(devname in sysvals.devprops):
+					name = sysvals.devprops[devname].altName(devname)
+				if sysvals.suspendmode == 'command':
+					ftitle = name
+				else:
+					ftitle = name+' '+p
 				hf.write(html_func_top.format(devid, data.dmesg[p]['color'], \
-					num, name+' '+p, flen))
+					num, ftitle, flen))
 				num += 1
 				for line in cg.list:
 					if(line.length < 0.000000001):
 						flen = ''
 					else:
-						flen = '<n>(%.3f ms @ %.3f)</n>' % (line.length*1000, \
-							line.time*1000)
+						fmt = '<n>(%.3f ms @ '+sysvals.timeformat+')</n>'
+						flen = fmt % (line.length*1000, line.time)
 					if(line.freturn and line.fcall):
 						hf.write(html_func_leaf.format(line.name, flen))
 					elif(line.freturn):
@@ -3409,9 +3419,40 @@ def createHTML(testruns):
 						num += 1
 				hf.write(html_func_end)
 		hf.write('\n\n    </section>\n')
-	# write the footer and close
-	addScriptCode(hf, testruns)
-	hf.write('</body>\n</html>\n')
+
+	# add the dmesg log as a hidden div
+	if sysvals.addlogs and sysvals.dmesgfile:
+		hf.write('<div id="dmesglog" style="display:none;">\n')
+		lf = open(sysvals.dmesgfile, 'r')
+		for line in lf:
+			hf.write(line)
+		lf.close()
+		hf.write('</div>\n')
+	# add the ftrace log as a hidden div
+	if sysvals.addlogs and sysvals.ftracefile:
+		hf.write('<div id="ftracelog" style="display:none;">\n')
+		lf = open(sysvals.ftracefile, 'r')
+		for line in lf:
+			hf.write(line)
+		lf.close()
+		hf.write('</div>\n')
+
+	if(not sysvals.embedded):
+		# write the footer and close
+		addScriptCode(hf, testruns)
+		hf.write('</body>\n</html>\n')
+	else:
+		# embedded out will be loaded in a page, skip the js
+		t0 = (testruns[0].start - testruns[-1].tSuspended) * 1000
+		tMax = (testruns[-1].end - testruns[-1].tSuspended) * 1000
+		# add js code in a div entry for later evaluation
+		detail = 'var bounds = [%f,%f];\n' % (t0, tMax)
+		detail += 'var devtable = [\n'
+		for data in testruns:
+			topo = data.deviceTopology()
+			detail += '\t"%s",\n' % (topo)
+		detail += '];\n'
+		hf.write('<div id=customcode style=display:none>\n'+detail+'</div>\n')
 	hf.close()
 	return True
 
@@ -3422,8 +3463,8 @@ def createHTML(testruns):
 #	 hf: the open html file pointer
 #	 testruns: array of Data objects from parseKernelLog or parseTraceLog
 def addScriptCode(hf, testruns):
-	t0 = (testruns[0].start - testruns[-1].tSuspended) * 1000
-	tMax = (testruns[-1].end - testruns[-1].tSuspended) * 1000
+	t0 = testruns[0].start * 1000
+	tMax = testruns[-1].end * 1000
 	# create an array in javascript memory with the device details
 	detail = '	var devtable = [];\n'
 	for data in testruns:
@@ -3433,8 +3474,43 @@ def addScriptCode(hf, testruns):
 	# add the code which will manipulate the data in the browser
 	script_code = \
 	'<script type="text/javascript">\n'+detail+\
+	'	var resolution = -1;\n'\
+	'	function redrawTimescale(t0, tMax, tS) {\n'\
+	'		var rline = \'<div class="t" style="left:0;border-left:1px solid black;border-right:0;"><cR><-R</cR></div>\';\n'\
+	'		var tTotal = tMax - t0;\n'\
+	'		var list = document.getElementsByClassName("tblock");\n'\
+	'		for (var i = 0; i < list.length; i++) {\n'\
+	'			var timescale = list[i].getElementsByClassName("timescale")[0];\n'\
+	'			var m0 = t0 + (tTotal*parseFloat(list[i].style.left)/100);\n'\
+	'			var mTotal = tTotal*parseFloat(list[i].style.width)/100;\n'\
+	'			var mMax = m0 + mTotal;\n'\
+	'			var html = "";\n'\
+	'			var divTotal = Math.floor(mTotal/tS) + 1;\n'\
+	'			if(divTotal > 1000) continue;\n'\
+	'			var divEdge = (mTotal - tS*(divTotal-1))*100/mTotal;\n'\
+	'			var pos = 0.0, val = 0.0;\n'\
+	'			for (var j = 0; j < divTotal; j++) {\n'\
+	'				var htmlline = "";\n'\
+	'				if(list[i].id[5] == "r") {\n'\
+	'					pos = 100 - (((j)*tS*100)/mTotal);\n'\
+	'					val = (j)*tS;\n'\
+	'					htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
+	'					if(j == 0)\n'\
+	'						htmlline = rline;\n'\
+	'				} else {\n'\
+	'					pos = 100 - (((j)*tS*100)/mTotal) - divEdge;\n'\
+	'					val = (j-divTotal+1)*tS;\n'\
+	'					if(j == divTotal - 1)\n'\
+	'						htmlline = \'<div class="t" style="right:\'+pos+\'%"><cS>S-></cS></div>\';\n'\
+	'					else\n'\
+	'						htmlline = \'<div class="t" style="right:\'+pos+\'%">\'+val+\'ms</div>\';\n'\
+	'				}\n'\
+	'				html += htmlline;\n'\
+	'			}\n'\
+	'			timescale.innerHTML = html;\n'\
+	'		}\n'\
+	'	}\n'\
 	'	function zoomTimeline() {\n'\
-	'		var timescale = document.getElementById("timescale");\n'\
 	'		var dmesg = document.getElementById("dmesg");\n'\
 	'		var zoombox = document.getElementById("dmesgzoombox");\n'\
 	'		var val = parseFloat(dmesg.style.width);\n'\
@@ -3442,7 +3518,7 @@ def addScriptCode(hf, testruns):
 	'		var sh = window.outerWidth / 2;\n'\
 	'		if(this.id == "zoomin") {\n'\
 	'			newval = val * 1.2;\n'\
-	'			if(newval > 40000) newval = 40000;\n'\
+	'			if(newval > 910034) newval = 910034;\n'\
 	'			dmesg.style.width = newval+"%";\n'\
 	'			zoombox.scrollLeft = ((zoombox.scrollLeft + sh) * newval / val) - sh;\n'\
 	'		} else if (this.id == "zoomout") {\n'\
@@ -3454,19 +3530,17 @@ def addScriptCode(hf, testruns):
 	'			zoombox.scrollLeft = 0;\n'\
 	'			dmesg.style.width = "100%";\n'\
 	'		}\n'\
-	'		var html = "";\n'\
+	'		var tS = [10000, 5000, 2000, 1000, 500, 200, 100, 50, 20, 10, 5, 2, 1];\n'\
 	'		var t0 = bounds[0];\n'\
 	'		var tMax = bounds[1];\n'\
 	'		var tTotal = tMax - t0;\n'\
 	'		var wTotal = tTotal * 100.0 / newval;\n'\
-	'		for(var tS = 1000; (wTotal / tS) < 3; tS /= 10);\n'\
-	'		if(tS < 1) tS = 1;\n'\
-	'		for(var s = ((t0 / tS)|0) * tS; s < tMax; s += tS) {\n'\
-	'			var pos = (tMax - s) * 100.0 / tTotal;\n'\
-	'			var name = (s == 0)?"S/R":(s+"ms");\n'\
-	'			html += "<div class=\\"t\\" style=\\"right:"+pos+"%\\">"+name+"</div>";\n'\
-	'		}\n'\
-	'		timescale.innerHTML = html;\n'\
+	'		var idx = 7*window.innerWidth/1100;\n'\
+	'		for(var i = 0; (i < tS.length)&&((wTotal / tS[i]) < idx); i++);\n'\
+	'		if(i >= tS.length) i = tS.length - 1;\n'\
+	'		if(tS[i] == resolution) return;\n'\
+	'		resolution = tS[i];\n'\
+	'		redrawTimescale(t0, tMax, tS[i]);\n'\
 	'	}\n'\
 	'	function deviceHover() {\n'\
 	'		var name = this.title.slice(0, this.title.indexOf(" ("));\n'\
@@ -3479,12 +3553,13 @@ def addScriptCode(hf, testruns):
 	'			cpu = parseInt(name.slice(8));\n'\
 	'		for (var i = 0; i < dev.length; i++) {\n'\
 	'			dname = dev[i].title.slice(0, dev[i].title.indexOf(" ("));\n'\
+	'			var cname = dev[i].className.slice(dev[i].className.indexOf("thread"));\n'\
 	'			if((cpu >= 0 && dname.match("CPU_O[NF]*\\\[*"+cpu+"\\\]")) ||\n'\
 	'				(name == dname))\n'\
 	'			{\n'\
-	'				dev[i].className = "thread hover";\n'\
+	'				dev[i].className = "hover "+cname;\n'\
 	'			} else {\n'\
-	'				dev[i].className = "thread";\n'\
+	'				dev[i].className = cname;\n'\
 	'			}\n'\
 	'		}\n'\
 	'	}\n'\
@@ -3492,7 +3567,7 @@ def addScriptCode(hf, testruns):
 	'		var dmesg = document.getElementById("dmesg");\n'\
 	'		var dev = dmesg.getElementsByClassName("thread");\n'\
 	'		for (var i = 0; i < dev.length; i++) {\n'\
-	'			dev[i].className = "thread";\n'\
+	'			dev[i].className = dev[i].className.slice(dev[i].className.indexOf("thread"));\n'\
 	'		}\n'\
 	'	}\n'\
 	'	function deviceTitle(title, total, cpu) {\n'\
@@ -3503,7 +3578,7 @@ def addScriptCode(hf, testruns):
 	'			total[2] = (total[2]+total[4])/2;\n'\
 	'		}\n'\
 	'		var devtitle = document.getElementById("devicedetailtitle");\n'\
-	'		var name = title.slice(0, title.indexOf(" "));\n'\
+	'		var name = title.slice(0, title.indexOf(" ("));\n'\
 	'		if(cpu >= 0) name = "CPU"+cpu;\n'\
 	'		var driver = "";\n'\
 	'		var tS = "<t2>(</t2>";\n'\
@@ -3535,6 +3610,8 @@ def addScriptCode(hf, testruns):
 	'		var dev = dmesg.getElementsByClassName("thread");\n'\
 	'		var idlist = [];\n'\
 	'		var pdata = [[]];\n'\
+	'		if(document.getElementById("devicedetail1"))\n'\
+	'			pdata = [[], []];\n'\
 	'		var pd = pdata[0];\n'\
 	'		var total = [0.0, 0.0, 0.0];\n'\
 	'		for (var i = 0; i < dev.length; i++) {\n'\
@@ -3590,6 +3667,7 @@ def addScriptCode(hf, testruns):
 	'		var cglist = document.getElementById("callgraphs");\n'\
 	'		if(!cglist) return;\n'\
 	'		var cg = cglist.getElementsByClassName("atop");\n'\
+	'		if(cg.length < 10) return;\n'\
 	'		for (var i = 0; i < cg.length; i++) {\n'\
 	'			if(idlist.indexOf(cg[i].id) >= 0) {\n'\
 	'				cg[i].style.display = "block";\n'\
@@ -3614,15 +3692,32 @@ def addScriptCode(hf, testruns):
 	'			dt = devtable[1];\n'\
 	'		win.document.write(html+dt);\n'\
 	'	}\n'\
+	'	function logWindow(e) {\n'\
+	'		var name = e.target.id.slice(4);\n'\
+	'		var win = window.open();\n'\
+	'		var log = document.getElementById(name+"log");\n'\
+	'		var title = "<title>"+document.title.split(" ")[0]+" "+name+" log</title>";\n'\
+	'		win.document.write(title+"<pre>"+log.innerHTML+"</pre>");\n'\
+	'		win.document.close();\n'\
+	'	}\n'\
+	'	function onClickPhase(e) {\n'\
+	'	}\n'\
+	'	window.addEventListener("resize", function () {zoomTimeline();});\n'\
 	'	window.addEventListener("load", function () {\n'\
 	'		var dmesg = document.getElementById("dmesg");\n'\
 	'		dmesg.style.width = "100%"\n'\
 	'		document.getElementById("zoomin").onclick = zoomTimeline;\n'\
 	'		document.getElementById("zoomout").onclick = zoomTimeline;\n'\
 	'		document.getElementById("zoomdef").onclick = zoomTimeline;\n'\
-	'		var devlist = document.getElementsByClassName("devlist");\n'\
-	'		for (var i = 0; i < devlist.length; i++)\n'\
-	'			devlist[i].onclick = devListWindow;\n'\
+	'		var list = document.getElementsByClassName("square");\n'\
+	'		for (var i = 0; i < list.length; i++)\n'\
+	'			list[i].onclick = onClickPhase;\n'\
+	'		var list = document.getElementsByClassName("logbtn");\n'\
+	'		for (var i = 0; i < list.length; i++)\n'\
+	'			list[i].onclick = logWindow;\n'\
+	'		list = document.getElementsByClassName("devlist");\n'\
+	'		for (var i = 0; i < list.length; i++)\n'\
+	'			list[i].onclick = devListWindow;\n'\
 	'		var dev = dmesg.getElementsByClassName("thread");\n'\
 	'		for (var i = 0; i < dev.length; i++) {\n'\
 	'			dev[i].onclick = deviceDetail;\n'\
@@ -3641,141 +3736,87 @@ def addScriptCode(hf, testruns):
 def executeSuspend():
 	global sysvals
 
-	detectUSB(False)
 	t0 = time.time()*1000
 	tp = sysvals.tpath
+	fwdata = []
+	# mark the start point in the kernel ring buffer just as we start
+	sysvals.initdmesg()
+	# start ftrace
+	if(sysvals.usecallgraph or sysvals.usetraceevents):
+		print('START TRACING')
+		sysvals.fsetVal('1', 'tracing_on')
 	# execute however many s/r runs requested
 	for count in range(1,sysvals.execcount+1):
-		# clear the kernel ring buffer just as we start
-		os.system('dmesg -C')
-		# enable callgraph ftrace only for the second run
-		if(sysvals.usecallgraph and count == 2):
-			# set trace type
-			os.system('echo function_graph > '+tp+'current_tracer')
-			os.system('echo "" > '+tp+'set_ftrace_filter')
-			# set trace format options
-			os.system('echo funcgraph-abstime > '+tp+'trace_options')
-			os.system('echo funcgraph-proc > '+tp+'trace_options')
-			# focus only on device suspend and resume
-			os.system('cat '+tp+'available_filter_functions | '+\
-				'grep dpm_run_callback > '+tp+'set_graph_function')
 		# if this is test2 and there's a delay, start here
 		if(count > 1 and sysvals.x2delay > 0):
 			tN = time.time()*1000
 			while (tN - t0) < sysvals.x2delay:
 				tN = time.time()*1000
 				time.sleep(0.001)
-		# start ftrace
-		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			print('START TRACING')
-			os.system('echo 1 > '+tp+'tracing_on')
 		# initiate suspend
 		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			os.system('echo SUSPEND START > '+tp+'trace_marker')
-		if(sysvals.rtcwake):
-			print('SUSPEND START')
-			print('will autoresume in %d seconds' % sysvals.rtcwaketime)
-			sysvals.rtcWakeAlarm()
+			sysvals.fsetVal('SUSPEND START', 'trace_marker')
+		if sysvals.suspendmode == 'command':
+			print('COMMAND START')
+			if(sysvals.rtcwake):
+				print('will issue an rtcwake in %d seconds' % sysvals.rtcwaketime)
+				sysvals.rtcWakeAlarmOn()
+			os.system(sysvals.testcommand)
 		else:
-			print('SUSPEND START (press a key to resume)')
-		pf = open(sysvals.powerfile, 'w')
-		pf.write(sysvals.suspendmode)
-		# execution will pause here
-		pf.close()
+			if(sysvals.rtcwake):
+				print('SUSPEND START')
+				print('will autoresume in %d seconds' % sysvals.rtcwaketime)
+				sysvals.rtcWakeAlarmOn()
+			else:
+				print('SUSPEND START (press a key to resume)')
+			pf = open(sysvals.powerfile, 'w')
+			pf.write(sysvals.suspendmode)
+			# execution will pause here
+			try:
+				pf.close()
+			except:
+				pass
 		t0 = time.time()*1000
+		if(sysvals.rtcwake):
+			sysvals.rtcWakeAlarmOff()
 		# return from suspend
 		print('RESUME COMPLETE')
 		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			os.system('echo RESUME COMPLETE > '+tp+'trace_marker')
-		# see if there's firmware timing data to be had
-		t = sysvals.postresumetime
-		if(t > 0):
-			print('Waiting %d seconds for POST-RESUME trace events...' % t)
-			time.sleep(t)
-		# stop ftrace
-		if(sysvals.usecallgraph or sysvals.usetraceevents):
-			os.system('echo 0 > '+tp+'tracing_on')
-			print('CAPTURING TRACE')
-			writeDatafileHeader(sysvals.ftracefile)
-			os.system('cat '+tp+'trace >> '+sysvals.ftracefile)
-			os.system('echo "" > '+tp+'trace')
-		# grab a copy of the dmesg output
-		print('CAPTURING DMESG')
-		writeDatafileHeader(sysvals.dmesgfile)
-		os.system('dmesg -c >> '+sysvals.dmesgfile)
-
-def writeDatafileHeader(filename):
+			sysvals.fsetVal('RESUME COMPLETE', 'trace_marker')
+		if(sysvals.suspendmode == 'mem'):
+			fwdata.append(getFPDT(False))
+	# look for post resume events after the last test run
+	t = sysvals.postresumetime
+	if(t > 0):
+		print('Waiting %d seconds for POST-RESUME trace events...' % t)
+		time.sleep(t)
+	# stop ftrace
+	if(sysvals.usecallgraph or sysvals.usetraceevents):
+		sysvals.fsetVal('0', 'tracing_on')
+		print('CAPTURING TRACE')
+		writeDatafileHeader(sysvals.ftracefile, fwdata)
+		os.system('cat '+tp+'trace >> '+sysvals.ftracefile)
+		sysvals.fsetVal('', 'trace')
+		devProps()
+	# grab a copy of the dmesg output
+	print('CAPTURING DMESG')
+	writeDatafileHeader(sysvals.dmesgfile, fwdata)
+	sysvals.getdmesg()
+
+def writeDatafileHeader(filename, fwdata):
 	global sysvals
 
-	fw = getFPDT(False)
 	prt = sysvals.postresumetime
 	fp = open(filename, 'a')
 	fp.write(sysvals.teststamp+'\n')
-	if(fw):
-		fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
+	if(sysvals.suspendmode == 'mem'):
+		for fw in fwdata:
+			if(fw):
+				fp.write('# fwsuspend %u fwresume %u\n' % (fw[0], fw[1]))
 	if(prt > 0):
 		fp.write('# post resume time %u\n' % prt)
 	fp.close()
 
-# Function: executeAndroidSuspend
-# Description:
-#	 Execute system suspend through the sysfs interface
-#	 on a remote android device, then transfer the output
-#	 dmesg and ftrace files to the local output directory.
-def executeAndroidSuspend():
-	global sysvals
-
-	# check to see if the display is currently off
-	tp = sysvals.tpath
-	out = os.popen(sysvals.adb+\
-		' shell dumpsys power | grep mScreenOn').read().strip()
-	# if so we need to turn it on so we can issue a new suspend
-	if(out.endswith('false')):
-		print('Waking the device up for the test...')
-		# send the KEYPAD_POWER keyevent to wake it up
-		os.system(sysvals.adb+' shell input keyevent 26')
-		# wait a few seconds so the user can see the device wake up
-		time.sleep(3)
-	# execute however many s/r runs requested
-	for count in range(1,sysvals.execcount+1):
-		# clear the kernel ring buffer just as we start
-		os.system(sysvals.adb+' shell dmesg -c > /dev/null 2>&1')
-		# start ftrace
-		if(sysvals.usetraceevents):
-			print('START TRACING')
-			os.system(sysvals.adb+" shell 'echo 1 > "+tp+"tracing_on'")
-		# initiate suspend
-		for count in range(1,sysvals.execcount+1):
-			if(sysvals.usetraceevents):
-				os.system(sysvals.adb+\
-					" shell 'echo SUSPEND START > "+tp+"trace_marker'")
-			print('SUSPEND START (press a key on the device to resume)')
-			os.system(sysvals.adb+" shell 'echo "+sysvals.suspendmode+\
-				" > "+sysvals.powerfile+"'")
-			# execution will pause here, then adb will exit
-			while(True):
-				check = os.popen(sysvals.adb+\
-					' shell pwd 2>/dev/null').read().strip()
-				if(len(check) > 0):
-					break
-				time.sleep(1)
-			if(sysvals.usetraceevents):
-				os.system(sysvals.adb+" shell 'echo RESUME COMPLETE > "+tp+\
-					"trace_marker'")
-		# return from suspend
-		print('RESUME COMPLETE')
-		# stop ftrace
-		if(sysvals.usetraceevents):
-			os.system(sysvals.adb+" shell 'echo 0 > "+tp+"tracing_on'")
-			print('CAPTURING TRACE')
-			os.system('echo "'+sysvals.teststamp+'" > '+sysvals.ftracefile)
-			os.system(sysvals.adb+' shell cat '+tp+\
-				'trace >> '+sysvals.ftracefile)
-		# grab a copy of the dmesg output
-		print('CAPTURING DMESG')
-		os.system('echo "'+sysvals.teststamp+'" > '+sysvals.dmesgfile)
-		os.system(sysvals.adb+' shell dmesg >> '+sysvals.dmesgfile)
-
 # Function: setUSBDevicesAuto
 # Description:
 #	 Set the autosuspend control parameter of all USB devices to auto
@@ -3785,7 +3826,7 @@ def executeAndroidSuspend():
 def setUSBDevicesAuto():
 	global sysvals
 
-	rootCheck()
+	rootCheck(True)
 	for dirname, dirnames, filenames in os.walk('/sys/devices'):
 		if(re.match('.*/usb[0-9]*.*', dirname) and
 			'idVendor' in filenames and 'idProduct' in filenames):
@@ -3830,9 +3871,7 @@ def ms2nice(val):
 # Description:
 #	 Detect all the USB hosts and devices currently connected and add
 #	 a list of USB device names to sysvals for better timeline readability
-# Arguments:
-#	 output: True to output the info to stdout, False otherwise
-def detectUSB(output):
+def detectUSB():
 	global sysvals
 
 	field = {'idVendor':'', 'idProduct':'', 'product':'', 'speed':''}
@@ -3843,18 +3882,18 @@ def detectUSB(output):
 			'runtime_suspended_time':'',
 			'active_duration':'',
 			'connected_duration':''}
-	if(output):
-		print('LEGEND')
-		print('---------------------------------------------------------------------------------------------')
-		print('  A = async/sync PM queue Y/N                       D = autosuspend delay (seconds)')
-		print('  S = autosuspend Y/N                         rACTIVE = runtime active (min/sec)')
-		print('  P = persist across suspend Y/N              rSUSPEN = runtime suspend (min/sec)')
-		print('  E = runtime suspend enabled/forbidden Y/N    ACTIVE = active duration (min/sec)')
-		print('  R = runtime status active/suspended Y/N     CONNECT = connected duration (min/sec)')
-		print('  U = runtime usage count')
-		print('---------------------------------------------------------------------------------------------')
-		print('  NAME       ID      DESCRIPTION         SPEED A S P E R U D rACTIVE rSUSPEN  ACTIVE CONNECT')
-		print('---------------------------------------------------------------------------------------------')
+
+	print('LEGEND')
+	print('---------------------------------------------------------------------------------------------')
+	print('  A = async/sync PM queue Y/N                       D = autosuspend delay (seconds)')
+	print('  S = autosuspend Y/N                         rACTIVE = runtime active (min/sec)')
+	print('  P = persist across suspend Y/N              rSUSPEN = runtime suspend (min/sec)')
+	print('  E = runtime suspend enabled/forbidden Y/N    ACTIVE = active duration (min/sec)')
+	print('  R = runtime status active/suspended Y/N     CONNECT = connected duration (min/sec)')
+	print('  U = runtime usage count')
+	print('---------------------------------------------------------------------------------------------')
+	print('  NAME       ID      DESCRIPTION         SPEED A S P E R U D rACTIVE rSUSPEN  ACTIVE CONNECT')
+	print('---------------------------------------------------------------------------------------------')
 
 	for dirname, dirnames, filenames in os.walk('/sys/devices'):
 		if(re.match('.*/usb[0-9]*.*', dirname) and
@@ -3863,35 +3902,149 @@ def detectUSB(output):
 				field[i] = os.popen('cat %s/%s 2>/dev/null' % \
 					(dirname, i)).read().replace('\n', '')
 			name = dirname.split('/')[-1]
-			if(len(field['product']) > 0):
-				sysvals.altdevname[name] = \
-					'%s [%s]' % (field['product'], name)
+			for i in power:
+				power[i] = os.popen('cat %s/power/%s 2>/dev/null' % \
+					(dirname, i)).read().replace('\n', '')
+			if(re.match('usb[0-9]*', name)):
+				first = '%-8s' % name
 			else:
-				sysvals.altdevname[name] = \
-					'%s:%s [%s]' % (field['idVendor'], \
-						field['idProduct'], name)
-			if(output):
-				for i in power:
-					power[i] = os.popen('cat %s/power/%s 2>/dev/null' % \
-						(dirname, i)).read().replace('\n', '')
-				if(re.match('usb[0-9]*', name)):
-					first = '%-8s' % name
-				else:
-					first = '%8s' % name
-				print('%s [%s:%s] %-20s %-4s %1s %1s %1s %1s %1s %1s %1s %s %s %s %s' % \
-					(first, field['idVendor'], field['idProduct'], \
-					field['product'][0:20], field['speed'], \
-					yesno(power['async']), \
-					yesno(power['control']), \
-					yesno(power['persist']), \
-					yesno(power['runtime_enabled']), \
-					yesno(power['runtime_status']), \
-					power['runtime_usage'], \
-					power['autosuspend'], \
-					ms2nice(power['runtime_active_time']), \
-					ms2nice(power['runtime_suspended_time']), \
-					ms2nice(power['active_duration']), \
-					ms2nice(power['connected_duration'])))
+				first = '%8s' % name
+			print('%s [%s:%s] %-20s %-4s %1s %1s %1s %1s %1s %1s %1s %s %s %s %s' % \
+				(first, field['idVendor'], field['idProduct'], \
+				field['product'][0:20], field['speed'], \
+				yesno(power['async']), \
+				yesno(power['control']), \
+				yesno(power['persist']), \
+				yesno(power['runtime_enabled']), \
+				yesno(power['runtime_status']), \
+				power['runtime_usage'], \
+				power['autosuspend'], \
+				ms2nice(power['runtime_active_time']), \
+				ms2nice(power['runtime_suspended_time']), \
+				ms2nice(power['active_duration']), \
+				ms2nice(power['connected_duration'])))
+
+# Function: devProps
+# Description:
+#	 Retrieve a list of properties for all devices in the trace log
+def devProps(data=0):
+	global sysvals
+	props = dict()
+
+	if data:
+		idx = data.index(': ') + 2
+		if idx >= len(data):
+			return
+		devlist = data[idx:].split(';')
+		for dev in devlist:
+			f = dev.split(',')
+			if len(f) < 3:
+				continue
+			dev = f[0]
+			props[dev] = DevProps()
+			props[dev].altname = f[1]
+			if int(f[2]):
+				props[dev].async = True
+			else:
+				props[dev].async = False
+			sysvals.devprops = props
+		if sysvals.suspendmode == 'command' and 'testcommandstring' in props:
+			sysvals.testcommand = props['testcommandstring'].altname
+		return
+
+	if(os.path.exists(sysvals.ftracefile) == False):
+		doError('%s does not exist' % sysvals.ftracefile, False)
+
+	# first get the list of devices we need properties for
+	msghead = 'Additional data added by AnalyzeSuspend'
+	alreadystamped = False
+	tp = TestProps()
+	tf = open(sysvals.ftracefile, 'r')
+	for line in tf:
+		if msghead in line:
+			alreadystamped = True
+			continue
+		# determine the trace data type (required for further parsing)
+		m = re.match(sysvals.tracertypefmt, line)
+		if(m):
+			tp.setTracerType(m.group('t'))
+			continue
+		# parse only valid lines, if this is not one move on
+		m = re.match(tp.ftrace_line_fmt, line)
+		if(not m or 'device_pm_callback_start' not in line):
+			continue
+		m = re.match('.*: (?P<drv>.*) (?P<d>.*), parent: *(?P<p>.*), .*', m.group('msg'));
+		if(not m):
+			continue
+		drv, dev, par = m.group('drv'), m.group('d'), m.group('p')
+		if dev not in props:
+			props[dev] = DevProps()
+	tf.close()
+
+	if not alreadystamped and sysvals.suspendmode == 'command':
+		out = '#\n# '+msghead+'\n# Device Properties: '
+		out += 'testcommandstring,%s,0;' % (sysvals.testcommand)
+		with open(sysvals.ftracefile, 'a') as fp:
+			fp.write(out+'\n')
+		sysvals.devprops = props
+		return
+
+	# now get the syspath for each of our target devices
+	for dirname, dirnames, filenames in os.walk('/sys/devices'):
+		if(re.match('.*/power', dirname) and 'async' in filenames):
+			dev = dirname.split('/')[-2]
+			if dev in props and (not props[dev].syspath or len(dirname) < len(props[dev].syspath)):
+				props[dev].syspath = dirname[:-6]
+
+	# now fill in the properties for our target devices
+	for dev in props:
+		dirname = props[dev].syspath
+		if not dirname or not os.path.exists(dirname):
+			continue
+		with open(dirname+'/power/async') as fp:
+			text = fp.read()
+			props[dev].async = False
+			if 'enabled' in text:
+				props[dev].async = True
+		fields = os.listdir(dirname)
+		if 'product' in fields:
+			with open(dirname+'/product') as fp:
+				props[dev].altname = fp.read()
+		elif 'name' in fields:
+			with open(dirname+'/name') as fp:
+				props[dev].altname = fp.read()
+		elif 'model' in fields:
+			with open(dirname+'/model') as fp:
+				props[dev].altname = fp.read()
+		elif 'description' in fields:
+			with open(dirname+'/description') as fp:
+				props[dev].altname = fp.read()
+		elif 'id' in fields:
+			with open(dirname+'/id') as fp:
+				props[dev].altname = fp.read()
+		elif 'idVendor' in fields and 'idProduct' in fields:
+			idv, idp = '', ''
+			with open(dirname+'/idVendor') as fp:
+				idv = fp.read().strip()
+			with open(dirname+'/idProduct') as fp:
+				idp = fp.read().strip()
+			props[dev].altname = '%s:%s' % (idv, idp)
+
+		if props[dev].altname:
+			out = props[dev].altname.strip().replace('\n', ' ')
+			out = out.replace(',', ' ')
+			out = out.replace(';', ' ')
+			props[dev].altname = out
+
+	# and now write the data to the ftrace file
+	if not alreadystamped:
+		out = '#\n# '+msghead+'\n# Device Properties: '
+		for dev in sorted(props):
+			out += props[dev].out(dev)
+		with open(sysvals.ftracefile, 'a') as fp:
+			fp.write(out+'\n')
+
+	sysvals.devprops = props
 
 # Function: getModes
 # Description:
@@ -3901,15 +4054,10 @@ def detectUSB(output):
 def getModes():
 	global sysvals
 	modes = ''
-	if(not sysvals.android):
-		if(os.path.exists(sysvals.powerfile)):
-			fp = open(sysvals.powerfile, 'r')
-			modes = string.split(fp.read())
-			fp.close()
-	else:
-		line = os.popen(sysvals.adb+' shell cat '+\
-			sysvals.powerfile).read().strip()
-		modes = string.split(line)
+	if(os.path.exists(sysvals.powerfile)):
+		fp = open(sysvals.powerfile, 'r')
+		modes = string.split(fp.read())
+		fp.close()
 	return modes
 
 # Function: getFPDT
@@ -3927,22 +4075,22 @@ def getFPDT(output):
 	prectype[0] = 'Basic S3 Resume Performance Record'
 	prectype[1] = 'Basic S3 Suspend Performance Record'
 
-	rootCheck()
+	rootCheck(True)
 	if(not os.path.exists(sysvals.fpdtpath)):
 		if(output):
-			doError('file doesnt exist: %s' % sysvals.fpdtpath, False)
+			doError('file does not exist: %s' % sysvals.fpdtpath, False)
 		return False
 	if(not os.access(sysvals.fpdtpath, os.R_OK)):
 		if(output):
-			doError('file isnt readable: %s' % sysvals.fpdtpath, False)
+			doError('file is not readable: %s' % sysvals.fpdtpath, False)
 		return False
 	if(not os.path.exists(sysvals.mempath)):
 		if(output):
-			doError('file doesnt exist: %s' % sysvals.mempath, False)
+			doError('file does not exist: %s' % sysvals.mempath, False)
 		return False
 	if(not os.access(sysvals.mempath, os.R_OK)):
 		if(output):
-			doError('file isnt readable: %s' % sysvals.mempath, False)
+			doError('file is not readable: %s' % sysvals.mempath, False)
 		return False
 
 	fp = open(sysvals.fpdtpath, 'rb')
@@ -3983,15 +4131,19 @@ def getFPDT(output):
 	while(i < len(records)):
 		header = struct.unpack('HBB', records[i:i+4])
 		if(header[0] not in rectype):
+			i += header[1]
 			continue
 		if(header[1] != 16):
+			i += header[1]
 			continue
 		addr = struct.unpack('Q', records[i+8:i+16])[0]
 		try:
 			fp.seek(addr)
 			first = fp.read(8)
 		except:
-			doError('Bad address 0x%x in %s' % (addr, sysvals.mempath), False)
+			if(output):
+				print('Bad address 0x%x in %s' % (addr, sysvals.mempath))
+			return [0, 0]
 		rechead = struct.unpack('4sI', first)
 		recdata = fp.read(rechead[1]-8)
 		if(rechead[0] == 'FBPT'):
@@ -4046,89 +4198,60 @@ def getFPDT(output):
 #	 print the results to the terminal
 # Output:
 #	 True if the test will work, False if not
-def statusCheck():
+def statusCheck(probecheck=False):
 	global sysvals
 	status = True
 
-	if(sysvals.android):
-		print('Checking the android system ...')
-	else:
-		print('Checking this system (%s)...' % platform.node())
-
-	# check if adb is connected to a device
-	if(sysvals.android):
-		res = 'NO'
-		out = os.popen(sysvals.adb+' get-state').read().strip()
-		if(out == 'device'):
-			res = 'YES'
-		print('    is android device connected: %s' % res)
-		if(res != 'YES'):
-			print('    Please connect the device before using this tool')
-			return False
+	print('Checking this system (%s)...' % platform.node())
 
 	# check we have root access
-	res = 'NO (No features of this tool will work!)'
-	if(sysvals.android):
-		out = os.popen(sysvals.adb+' shell id').read().strip()
-		if('root' in out):
-			res = 'YES'
-	else:
-		if(os.environ['USER'] == 'root'):
-			res = 'YES'
+	res = sysvals.colorText('NO (No features of this tool will work!)')
+	if(rootCheck(False)):
+		res = 'YES'
 	print('    have root access: %s' % res)
 	if(res != 'YES'):
-		if(sysvals.android):
-			print('    Try running "adb root" to restart the daemon as root')
-		else:
-			print('    Try running this script with sudo')
+		print('    Try running this script with sudo')
 		return False
 
 	# check sysfs is mounted
-	res = 'NO (No features of this tool will work!)'
-	if(sysvals.android):
-		out = os.popen(sysvals.adb+' shell ls '+\
-			sysvals.powerfile).read().strip()
-		if(out == sysvals.powerfile):
-			res = 'YES'
-	else:
-		if(os.path.exists(sysvals.powerfile)):
-			res = 'YES'
+	res = sysvals.colorText('NO (No features of this tool will work!)')
+	if(os.path.exists(sysvals.powerfile)):
+		res = 'YES'
 	print('    is sysfs mounted: %s' % res)
 	if(res != 'YES'):
 		return False
 
 	# check target mode is a valid mode
-	res = 'NO'
-	modes = getModes()
-	if(sysvals.suspendmode in modes):
-		res = 'YES'
-	else:
-		status = False
-	print('    is "%s" a valid power mode: %s' % (sysvals.suspendmode, res))
-	if(res == 'NO'):
-		print('      valid power modes are: %s' % modes)
-		print('      please choose one with -m')
-
-	# check if the tool can unlock the device
-	if(sysvals.android):
-		res = 'YES'
-		out1 = os.popen(sysvals.adb+\
-			' shell dumpsys power | grep mScreenOn').read().strip()
-		out2 = os.popen(sysvals.adb+\
-			' shell input').read().strip()
-		if(not out1.startswith('mScreenOn') or not out2.startswith('usage')):
-			res = 'NO (wake the android device up before running the test)'
-		print('    can I unlock the screen: %s' % res)
+	if sysvals.suspendmode != 'command':
+		res = sysvals.colorText('NO')
+		modes = getModes()
+		if(sysvals.suspendmode in modes):
+			res = 'YES'
+		else:
+			status = False
+		print('    is "%s" a valid power mode: %s' % (sysvals.suspendmode, res))
+		if(res == 'NO'):
+			print('      valid power modes are: %s' % modes)
+			print('      please choose one with -m')
 
 	# check if ftrace is available
-	res = 'NO'
-	ftgood = verifyFtrace()
+	res = sysvals.colorText('NO')
+	ftgood = sysvals.verifyFtrace()
 	if(ftgood):
 		res = 'YES'
 	elif(sysvals.usecallgraph):
 		status = False
 	print('    is ftrace supported: %s' % res)
 
+	# check if kprobes are available
+	res = sysvals.colorText('NO')
+	sysvals.usekprobes = sysvals.verifyKprobes()
+	if(sysvals.usekprobes):
+		res = 'YES'
+	else:
+		sysvals.usedevsrc = False
+	print('    are kprobes supported: %s' % res)
+
 	# what data source are we using
 	res = 'DMESG'
 	if(ftgood):
@@ -4136,14 +4259,8 @@ def statusCheck():
 		sysvals.usetraceevents = False
 		for e in sysvals.traceevents:
 			check = False
-			if(sysvals.android):
-				out = os.popen(sysvals.adb+' shell ls -d '+\
-					sysvals.epath+e).read().strip()
-				if(out == sysvals.epath+e):
-					check = True
-			else:
-				if(os.path.exists(sysvals.epath+e)):
-					check = True
+			if(os.path.exists(sysvals.epath+e)):
+				check = True
 			if(not check):
 				sysvals.usetraceeventsonly = False
 			if(e == 'suspend_resume' and check):
@@ -4155,13 +4272,48 @@ def statusCheck():
 	print('    timeline data source: %s' % res)
 
 	# check if rtcwake
-	res = 'NO'
+	res = sysvals.colorText('NO')
 	if(sysvals.rtcpath != ''):
 		res = 'YES'
 	elif(sysvals.rtcwake):
 		status = False
 	print('    is rtcwake supported: %s' % res)
 
+	if not probecheck:
+		return status
+
+	if (sysvals.usecallgraph and len(sysvals.debugfuncs) > 0) or len(sysvals.kprobes) > 0:
+		sysvals.initFtrace(True)
+
+	# verify callgraph debugfuncs
+	if sysvals.usecallgraph and len(sysvals.debugfuncs) > 0:
+		print('    verifying these ftrace callgraph functions work:')
+		sysvals.setFtraceFilterFunctions(sysvals.debugfuncs)
+		fp = open(sysvals.tpath+'set_graph_function', 'r')
+		flist = fp.read().split('\n')
+		fp.close()
+		for func in sysvals.debugfuncs:
+			res = sysvals.colorText('NO')
+			if func in flist:
+				res = 'YES'
+			else:
+				for i in flist:
+					if ' [' in i and func == i.split(' ')[0]:
+						res = 'YES'
+						break
+			print('         %s: %s' % (func, res))
+
+	# verify kprobes
+	if len(sysvals.kprobes) > 0:
+		print('    verifying these kprobes work:')
+		for name in sorted(sysvals.kprobes):
+			if name in sysvals.tracefuncs:
+				continue
+			res = sysvals.colorText('NO')
+			if sysvals.testKprobe(sysvals.kprobes[name]):
+				res = 'YES'
+			print('         %s: %s' % (name, res))
+
 	return status
 
 # Function: doError
@@ -4182,7 +4334,7 @@ def doError(msg, help):
 # Arguments:
 #	 msg: the warning message to print
 #	 file: If not empty, a filename to request be sent to the owner for debug
-def doWarning(msg, file):
+def doWarning(msg, file=''):
 	print('/* %s */') % msg
 	if(file):
 		print('/* For a fix, please send this'+\
@@ -4191,18 +4343,25 @@ def doWarning(msg, file):
 # Function: rootCheck
 # Description:
 #	 quick check to see if we have root access
-def rootCheck():
-	if(os.environ['USER'] != 'root'):
-		doError('This script must be run as root', False)
+def rootCheck(fatal):
+	global sysvals
+	if(os.access(sysvals.powerfile, os.W_OK)):
+		return True
+	if fatal:
+		doError('This command must be run as root', False)
+	return False
 
 # Function: getArgInt
 # Description:
 #	 pull out an integer argument from the command line with checks
-def getArgInt(name, args, min, max):
-	try:
-		arg = args.next()
-	except:
-		doError(name+': no argument supplied', True)
+def getArgInt(name, args, min, max, main=True):
+	if main:
+		try:
+			arg = args.next()
+		except:
+			doError(name+': no argument supplied', True)
+	else:
+		arg = args
 	try:
 		val = int(arg)
 	except:
-- 
2.1.4

