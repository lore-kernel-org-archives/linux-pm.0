From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Fix policy data management in passive mode
Date: Sat, 18 Mar 2017 02:36:36 +0100
Message-ID: <48065078.runFWWt2Wa@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56683 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751023AbdCRBsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2017 21:48:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The policy->cpuinfo.max_freq and policy->max updates in
intel_cpufreq_turbo_update() are excessive as they are done for no
good reason and may lead to problems in principle, so drop them.

Moreover, fix intel_cpufreq_verify_policy() so that it checks
global.no_turbo in addition to global.turbo_disabled when updating
policy->cpuinfo.max_freq to make it consistent with
intel_pstate_verify_policy().

Fixes: 001c76f05b01 (cpufreq: intel_pstate: Generic governors support)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

One more fix related to the passive mode.

---
 drivers/cpufreq/intel_pstate.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2247,7 +2247,7 @@ static int intel_cpufreq_verify_policy(s
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
 	update_turbo_state();
-	policy->cpuinfo.max_freq = global.turbo_disabled ?
+	policy->cpuinfo.max_freq = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
 
 	cpufreq_verify_within_cpu_limits(policy);
@@ -2265,10 +2265,6 @@ static unsigned int intel_cpufreq_turbo_
 
 	max_freq = global.no_turbo || global.turbo_disabled ?
 			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
-	policy->cpuinfo.max_freq = max_freq;
-	if (policy->max > max_freq)
-		policy->max = max_freq;
-
 	if (target_freq > max_freq)
 		target_freq = max_freq;
 
