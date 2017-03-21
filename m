From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3] cpufreq: intel_pstate: Fix policy data management in passive mode
Date: Tue, 21 Mar 2017 01:56:33 +0100
Message-ID: <5948160.vOMzsooekK@aspire.rjw.lan>
References: <48065078.runFWWt2Wa@aspire.rjw.lan> <1972182.uOfXaANt30@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52812 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753629AbdCUBIr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 21:08:47 -0400
In-Reply-To: <1972182.uOfXaANt30@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The policy->cpuinfo.max_freq and policy->max updates in
intel_cpufreq_turbo_update() are excessive as they are done for no
good reason and may lead to problems in principle, so they should be
dropped.  However, after dropping them intel_cpufreq_turbo_update()
becomes almost entirely pointless, because the check made by it is
made again down the road in intel_pstate_prepare_request().  The
only thing in it that still needs to be done is the call to
update_turbo_state(), so drop intel_cpufreq_turbo_update() altogether
and make its callers invoke update_turbo_state() directly instead of
it.

In addition to that, fix intel_cpufreq_verify_policy() so that it
checks global.no_turbo in addition to global.turbo_disabled when
updating policy->cpuinfo.max_freq to make it consistent with
intel_pstate_verify_policy().

Fixes: 001c76f05b01 (cpufreq: intel_pstate: Generic governors support)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
Make the previous callers of intel_cpufreq_turbo_update() invoke
update_turbo_state() directly (since it was called by the former).

-> v2:
Drop intel_cpufreq_turbo_update() as it is pointless without the
excessive updates that need to be dropped.

---
 drivers/cpufreq/intel_pstate.c |   29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

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
@@ -2255,26 +2255,6 @@ static int intel_cpufreq_verify_policy(s
 	return 0;
 }
 
-static unsigned int intel_cpufreq_turbo_update(struct cpudata *cpu,
-					       struct cpufreq_policy *policy,
-					       unsigned int target_freq)
-{
-	unsigned int max_freq;
-
-	update_turbo_state();
-
-	max_freq = global.no_turbo || global.turbo_disabled ?
-			cpu->pstate.max_freq : cpu->pstate.turbo_freq;
-	policy->cpuinfo.max_freq = max_freq;
-	if (policy->max > max_freq)
-		policy->max = max_freq;
-
-	if (target_freq > max_freq)
-		target_freq = max_freq;
-
-	return target_freq;
-}
-
 static int intel_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int target_freq,
 				unsigned int relation)
@@ -2283,8 +2263,10 @@ static int intel_cpufreq_target(struct c
 	struct cpufreq_freqs freqs;
 	int target_pstate;
 
+	update_turbo_state();
+
 	freqs.old = policy->cur;
-	freqs.new = intel_cpufreq_turbo_update(cpu, policy, target_freq);
+	freqs.new = target_freq;
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 	switch (relation) {
@@ -2316,7 +2298,8 @@ static unsigned int intel_cpufreq_fast_s
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	int target_pstate;
 
-	target_freq = intel_cpufreq_turbo_update(cpu, policy, target_freq);
+	update_turbo_state();
+
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	intel_pstate_update_pstate(cpu, target_pstate);
