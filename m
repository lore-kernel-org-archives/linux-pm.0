Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCEDC433E0
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9AF233CE
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 18:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbhAGSpM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:45:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50092 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbhAGSpM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 13:45:12 -0500
Received: from 89-64-81-64.dynamic.chello.pl (89.64.81.64) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 8eddfbd0a4e78645; Thu, 7 Jan 2021 19:44:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v1 3/3] cpufreq: intel_pstate: Rename two functions
Date:   Thu, 07 Jan 2021 19:44:18 +0100
Message-ID: <6740994.gz1i9f73Yi@kreacher>
In-Reply-To: <5701645.lOV4Wx5bFT@kreacher>
References: <5701645.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename intel_cpufreq_adjust_hwp() and intel_cpufreq_adjust_perf_ctl()
to intel_cpufreq_hwp_update() and intel_cpufreq_perf_ctl_update(),
respectively, to avoid possible confusion with the ->adjist_perf()
callback function, intel_cpufreq_adjust_perf().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2527,7 +2527,7 @@ static void intel_cpufreq_trace(struct c
 		fp_toint(cpu->iowait_boost * 100));
 }
 
-static void intel_cpufreq_adjust_hwp(struct cpudata *cpu, u32 min, u32 max,
+static void intel_cpufreq_hwp_update(struct cpudata *cpu, u32 min, u32 max,
 				     u32 desired, bool fast_switch)
 {
 	u64 prev = READ_ONCE(cpu->hwp_req_cached), value = prev;
@@ -2551,7 +2551,7 @@ static void intel_cpufreq_adjust_hwp(str
 		wrmsrl_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 }
 
-static void intel_cpufreq_adjust_perf_ctl(struct cpudata *cpu,
+static void intel_cpufreq_perf_ctl_update(struct cpudata *cpu,
 					  u32 target_pstate, bool fast_switch)
 {
 	if (fast_switch)
@@ -2573,10 +2573,10 @@ static int intel_cpufreq_update_pstate(s
 		int max_pstate = policy->strict_target ?
 					target_pstate : cpu->max_perf_ratio;
 
-		intel_cpufreq_adjust_hwp(cpu, target_pstate, max_pstate, 0,
+		intel_cpufreq_hwp_update(cpu, target_pstate, max_pstate, 0,
 					 fast_switch);
 	} else if (target_pstate != old_pstate) {
-		intel_cpufreq_adjust_perf_ctl(cpu, target_pstate, fast_switch);
+		intel_cpufreq_perf_ctl_update(cpu, target_pstate, fast_switch);
 	}
 
 	cpu->pstate.current_pstate = target_pstate;
@@ -2674,7 +2674,7 @@ static void intel_cpufreq_adjust_perf(un
 
 	target_pstate = clamp_t(int, target_pstate, min_pstate, max_pstate);
 
-	intel_cpufreq_adjust_hwp(cpu, min_pstate, max_pstate, target_pstate, true);
+	intel_cpufreq_hwp_update(cpu, min_pstate, max_pstate, target_pstate, true);
 
 	cpu->pstate.current_pstate = target_pstate;
 	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);



