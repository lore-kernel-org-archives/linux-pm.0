From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: docs: Drop intel_pstate.txt from index.txt
Date: Thu, 28 Sep 2017 01:56:58 +0200
Message-ID: <2401157.mvXUDI8C0e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 33fc30b47098 (cpufreq: intel_pstate: Document the current
behavior and user interface) dropped the intel-pstate.txt file
from Documentation/cpu-freq/, but it did not update the index.txt
file in there accordingly, so do that now.

Fixes: 33fc30b47098 (cpufreq: intel_pstate: Document the current behavior and user interface)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/cpu-freq/index.txt |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/Documentation/cpu-freq/index.txt
===================================================================
--- linux-pm.orig/Documentation/cpu-freq/index.txt
+++ linux-pm/Documentation/cpu-freq/index.txt
@@ -32,8 +32,6 @@ cpufreq-stats.txt -	General description
 
 index.txt	-	File index, Mailing list and Links (this document)
 
-intel-pstate.txt -	Intel pstate cpufreq driver specific file.
-
 pcc-cpufreq.txt -	PCC cpufreq driver specific file.
 
 

