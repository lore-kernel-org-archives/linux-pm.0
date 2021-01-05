Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB99C433DB
	for <linux-pm@archiver.kernel.org>; Tue,  5 Jan 2021 18:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A05A22D57
	for <linux-pm@archiver.kernel.org>; Tue,  5 Jan 2021 18:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhAESVM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 Jan 2021 13:21:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61280 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbhAESVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 13:21:12 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 71a2e7a3474a6b66; Tue, 5 Jan 2021 19:20:30 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Use HWP capabilities in intel_cpufreq_adjust_perf()
Date:   Tue, 05 Jan 2021 19:20:29 +0100
Message-ID: <1784464.uM0JrOW1fs@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If turbo P-states cannot be used, either due to the configuration of
the processor, or because intel_pstate is not allowed to used them,
the maximum available P-state with HWP enabled corresponds to the
HWP_CAP.GUARANTEED value which is not static.  It can be adjusted by
an out-of-band agent or during an Intel Speed Select performance
level change, so long as it remains less than or equal to
HWP_CAP.MAX.

However, if turbo P-states cannot be used, intel_cpufreq_adjust_perf()
always uses pstate.max_pstate (set during the initialization of the
driver only) as the maximum available P-state, so it may miss a change
of the HWP_CAP.GUARANTEED value.

Prevent that from happening by modifyig intel_cpufreq_adjust_perf()
to always read the "guaranteed" and "maximum turbo" performance
levels from the cached HWP_CAP value.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2653,12 +2653,13 @@ static void intel_cpufreq_adjust_perf(un
 				      unsigned long capacity)
 {
 	struct cpudata *cpu = all_cpu_data[cpunum];
+	u64 hwp_cap = READ_ONCE(cpu->hwp_cap_cached);
 	int old_pstate = cpu->pstate.current_pstate;
 	int cap_pstate, min_pstate, max_pstate, target_pstate;
 
 	update_turbo_state();
-	cap_pstate = global.turbo_disabled ? cpu->pstate.max_pstate :
-					     cpu->pstate.turbo_pstate;
+	cap_pstate = global.turbo_disabled ? HWP_GUARANTEED_PERF(hwp_cap) :
+					     HWP_HIGHEST_PERF(hwp_cap);
 
 	/* Optimization: Avoid unnecessary divisions. */
 



