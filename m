From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] tools/power/x86/intel_pstate_tracer: Free the trace buffer memory
Date: Fri,  5 Jan 2018 14:31:16 -0800
Message-ID: <1515191476-3424-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36542 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753271AbeAEWbm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 17:31:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com
Cc: dsmythies@telus.net, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

The trace buffer memory should be, mostly, freed after
the buffer has been output.

This patch is required before a future patch that will allow
the user to override the default, and specify the trace buffer
memory allocation as a command line option.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 .../power/x86/intel_pstate_tracer/intel_pstate_tracer.py  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 0b24dd9..29f50d4 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -411,6 +411,16 @@ def set_trace_buffer_size():
         print('IO error setting trace buffer size ')
         quit()
 
+def free_trace_buffer():
+    """ Free the trace buffer memory """
+
+    try:
+       open('/sys/kernel/debug/tracing/buffer_size_kb'
+                 , 'w').write("1")
+    except:
+        print('IO error setting trace buffer size ')
+        quit()
+
 def read_trace_data(filename):
     """ Read and parse trace data """
 
@@ -583,4 +593,9 @@ for root, dirs, files in os.walk('.'):
     for f in files:
         fix_ownership(f)
 
+clear_trace_file()
+# Free the memory
+if interval:
+    free_trace_buffer()
+
 os.chdir('../../')
-- 
2.7.4
