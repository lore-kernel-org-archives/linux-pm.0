From: Doug Smythies <doug.smythies@gmail.com>
Subject: [PATCH] tools/power/x86/intel_pstate_tracer: Fix non root execution for post processing a trace file.
Date: Mon, 17 Dec 2018 23:34:04 -0800
Message-ID: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This script is supposed to be allowed to run with regular user privileges
if a previously captured trace is being post processed.

Commit fbe313884d7ddd73ce457473cbdf3763f5b1d3da
tools/power/x86/intel_pstate_tracer: Free the trace buffer memory
introduced a bug that breaks that option.

Commit 35459105deb26430653a7299a86bc66fb4dd5773
tools/power/x86/intel_pstate_tracer: Add optional setting of trace buffer memory allocation
moved the code but kept the bug.

This patch fixes the issue.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index 84e2b64..2fa3c57 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -585,9 +585,9 @@ current_max_cpu = 0
 
 read_trace_data(filename)
 
-clear_trace_file()
-# Free the memory
 if interval:
+    clear_trace_file()
+    # Free the memory
     free_trace_buffer()
 
 if graph_data_present == False:
-- 
2.7.4
