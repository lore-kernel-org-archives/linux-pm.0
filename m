From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] tools/power/x86/intel_pstate_tracer: Adjust directory permissions
Date: Mon,  6 Mar 2017 23:29:32 -0800
Message-ID: <1488871772-12624-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33248 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbdCGIgt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Mar 2017 03:36:49 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net, len.brown@intel.com
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Depending on what is being done, the intel_pstate_tracer.py script
needs to be run as root, or can be run as a regular user.
If run the first time as root the results directory will be
incorrect for any subsequent run as a regular user. For any run
as root the specific testname subdirectory will not allow any
subsequent file saves by a regular user. Typically, and for example,
the regular user might be attempting to save a .csv file converted to
a spreadsheet with added calculations or graphs.

Override the default folder permissions.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index fd706ac..7c855508 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -517,13 +517,19 @@ else:
         cpu_mask[i] = 1
 
 if not os.path.exists('results'):
+    # Setting permissions with the mode option doesn't work on all platforms
     os.mkdir('results')
+    # so use chmod to set them. Needed because user may or may not be root.
+    os.chmod('results', 0777)
 
 os.chdir('results')
 if os.path.exists(testname):
     print('The test name directory already exists. Please provide a unique test name. Test re-run not supported, yet.')
     sys.exit()
+# Setting permissions with the mode option doesn't work on all platforms
 os.mkdir(testname)
+os.chmod(testname, 0777)
+# so use chmod to set them. Needed because user may or may not be root.
 os.chdir(testname)
 
 # Temporary (or perhaps not)
-- 
2.7.4
