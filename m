Return-Path: <SRS0=LVfj=4W=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A80BC3F2D2
	for <linux-pm@archiver.kernel.org>; Thu,  5 Mar 2020 23:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F652073D
	for <linux-pm@archiver.kernel.org>; Thu,  5 Mar 2020 23:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEXFh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:05:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55902 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEXFh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 18:05:37 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a1f513d29558e684; Fri, 6 Mar 2020 00:05:35 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Consolidate policy verification
Date:   Fri, 06 Mar 2020 00:05:34 +0100
Message-ID: <226215910.rrICADBzDZ@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is still some code duplication between intel_pstate_verify_policy()
and intel_cpufreq_verify_policy(), so avoid it by moving the common
code into a separate function and calling it from both these places.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2155,15 +2155,19 @@ static void intel_pstate_adjust_policy_m
 	}
 }
 
-static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
+static void intel_pstate_verify_cpu_policy(struct cpudata *cpu,
+					   struct cpufreq_policy_data *policy)
 {
-	struct cpudata *cpu = all_cpu_data[policy->cpu];
-
 	update_turbo_state();
 	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
 				     intel_pstate_get_max_freq(cpu));
 
 	intel_pstate_adjust_policy_max(cpu, policy);
+}
+
+static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
+{
+	intel_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
 
 	return 0;
 }
@@ -2268,12 +2272,7 @@ static int intel_cpufreq_verify_policy(s
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 
-	update_turbo_state();
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     intel_pstate_get_max_freq(cpu));
-
-	intel_pstate_adjust_policy_max(cpu, policy);
-
+	intel_pstate_verify_cpu_policy(cpu, policy);
 	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
 	return 0;



