From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: Update scaling_cur_freq documentation
Date: Thu, 29 Jun 2017 01:49:44 +0200
Message-ID: <3486081.4q1pf2aZmx@aspire.rjw.lan>
References: <5158983.ihgooJZPke@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63043 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751572AbdF1X5V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jun 2017 19:57:21 -0400
In-Reply-To: <5158983.ihgooJZPke@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit f8475cef9008 "x86: use common aperfmperf_khz_on_cpu() to
calculate KHz using APERF/MPERF" modified the way the scaling_cur_freq
cpufreq policy attribute in sysfs is handled on contemporary
Intel-based x86 systems, so update the documentation to reflect
that change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpufreq.rst |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/cpufreq.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-pm/Documentation/admin-guide/pm/cpufreq.rst
@@ -269,16 +269,16 @@ are the following:
 ``scaling_cur_freq``
 	Current frequency of all of the CPUs belonging to this policy (in kHz).
 
-	For the majority of scaling drivers, this is the frequency of the last
-	P-state requested by the driver from the hardware using the scaling
+	In the majority of cases, this is the frequency of the last P-state
+	requested by the scaling driver from the hardware using the scaling
 	interface provided by it, which may or may not reflect the frequency
 	the CPU is actually running at (due to hardware design and other
 	limitations).
 
-	Some scaling drivers (e.g. |intel_pstate|) attempt to provide
-	information more precisely reflecting the current CPU frequency through
-	this attribute, but that still may not be the exact current CPU
-	frequency as seen by the hardware at the moment.
+	Some architectures (e.g. ``x86``) may attempt to provide information
+	more precisely reflecting the current CPU frequency through this
+	attribute, but that still may not be the exact current CPU frequency as
+	seen by the hardware at the moment.
 
 ``scaling_driver``
 	The scaling driver currently in use.
