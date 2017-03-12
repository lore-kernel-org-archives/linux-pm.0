From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 14/14] cpufreq: intel_pstate: Introduce pid_in_use()
Date: Sun, 12 Mar 2017 18:26:40 +0100
Message-ID: <2052751.2pq54OkNPE@aspire.rjw.lan>
References: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53402 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934542AbdCLRcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Mar 2017 13:32:36 -0400
In-Reply-To: <5656785.7SEhxaGEOz@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new function pid_in_use() to return the information on whether
or not the PID-based P-state selection algorithm is in use.

That allows a couple of complicated conditions in the code to be
reduced to simple checks against the new function's return value.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -1949,6 +1949,8 @@ static const struct x86_cpu_id intel_pst
 	{}
 };
 
+static bool pid_in_use(void);
+
 static int intel_pstate_init_cpu(unsigned int cpunum)
 {
 	struct cpudata *cpu;
@@ -1986,7 +1988,7 @@ static int intel_pstate_init_cpu(unsigne
 			intel_pstate_disable_ee(cpunum);
 
 		intel_pstate_hwp_enable(cpu);
-	} else if (pstate_funcs.update_util == intel_pstate_update_util_pid) {
+	} else if (pid_in_use()) {
 		intel_pstate_pid_reset(cpu);
 	}
 
@@ -2360,6 +2362,12 @@ static struct cpufreq_driver intel_cpufr
 
 static struct cpufreq_driver *default_driver = &intel_pstate;
 
+static bool pid_in_use(void)
+{
+	return intel_pstate_driver == &intel_pstate &&
+		pstate_funcs.update_util == intel_pstate_update_util_pid;
+}
+
 static void intel_pstate_driver_cleanup(void)
 {
 	unsigned int cpu;
@@ -2397,8 +2405,7 @@ static int intel_pstate_register_driver(
 		return ret;
 	}
 
-	if (intel_pstate_driver == &intel_pstate && !hwp_active &&
-	    pstate_funcs.update_util == intel_pstate_update_util_pid)
+	if (pid_in_use())
 		intel_pstate_debug_expose_params();
 
 	return 0;
@@ -2409,8 +2416,7 @@ static int intel_pstate_unregister_drive
 	if (hwp_active)
 		return -EBUSY;
 
-	if (intel_pstate_driver == &intel_pstate &&
-	    pstate_funcs.update_util == intel_pstate_update_util_pid)
+	if (pid_in_use())
 		intel_pstate_debug_hide_params();
 
 	cpufreq_unregister_driver(intel_pstate_driver);
