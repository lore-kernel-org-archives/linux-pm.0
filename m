From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH v3 4/4] AnalyzeSuspend v4.5: fix drag and zoom bug in javascript
Date: Thu,  9 Feb 2017 13:27:43 -0800
Message-ID: <2a82a0c85f1339704f09e45f2da94b7e4af781cc.1486675333.git.todd.e.brandt@linux.intel.com>
References: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44799 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753245AbdBIV2u (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Feb 2017 16:28:50 -0500
In-Reply-To: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
In-Reply-To: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
References: <cover.1486675333.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: todd.e.brandt@intel.com, rjw@rjwysocki.net, rafael.j.wysocki@intel.com, Todd Brandt <todd.e.brandt@linux.intel.com>

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
v2 changes:
 - added fixes since initial upstream attempt

 scripts/analyze_suspend.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/analyze_suspend.py b/scripts/analyze_suspend.py
index 383df79..20cdb2b 100755
--- a/scripts/analyze_suspend.py
+++ b/scripts/analyze_suspend.py
@@ -3846,6 +3846,7 @@ def addScriptCode(hf, testruns):
 	'	function zoomTimeline() {\n'\
 	'		var dmesg = document.getElementById("dmesg");\n'\
 	'		var zoombox = document.getElementById("dmesgzoombox");\n'\
+	'		var left = zoombox.scrollLeft;\n'\
 	'		var val = parseFloat(dmesg.style.width);\n'\
 	'		var newval = 100;\n'\
 	'		var sh = window.outerWidth / 2;\n'\
@@ -3853,12 +3854,12 @@ def addScriptCode(hf, testruns):
 	'			newval = val * 1.2;\n'\
 	'			if(newval > 910034) newval = 910034;\n'\
 	'			dmesg.style.width = newval+"%";\n'\
-	'			zoombox.scrollLeft = ((zoombox.scrollLeft + sh) * newval / val) - sh;\n'\
+	'			zoombox.scrollLeft = ((left + sh) * newval / val) - sh;\n'\
 	'		} else if (this.id == "zoomout") {\n'\
 	'			newval = val / 1.2;\n'\
 	'			if(newval < 100) newval = 100;\n'\
 	'			dmesg.style.width = newval+"%";\n'\
-	'			zoombox.scrollLeft = ((zoombox.scrollLeft + sh) * newval / val) - sh;\n'\
+	'			zoombox.scrollLeft = ((left + sh) * newval / val) - sh;\n'\
 	'		} else {\n'\
 	'			zoombox.scrollLeft = 0;\n'\
 	'			dmesg.style.width = "100%";\n'\
@@ -4068,7 +4069,7 @@ def addScriptCode(hf, testruns):
 	'	window.addEventListener("load", function () {\n'\
 	'		var dmesg = document.getElementById("dmesg");\n'\
 	'		dmesg.style.width = "100%"\n'\
-	'		document.onmousedown = onMouseDown;\n'\
+	'		dmesg.onmousedown = onMouseDown;\n'\
 	'		document.onmouseup = onMouseUp;\n'\
 	'		document.onkeypress = onKeyPress;\n'\
 	'		document.getElementById("zoomin").onclick = zoomTimeline;\n'\
-- 
2.1.4

