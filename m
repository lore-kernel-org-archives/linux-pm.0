Return-Path: <SRS0=iPxC=B6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E8BC433E1
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711E3208A9
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 16:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgHTQjM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:39:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57068 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgHTQjL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 12:39:11 -0400
Received: from 89-64-87-57.dynamic.chello.pl (89.64.87.57) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id a3d0785267e228d1; Thu, 20 Aug 2020 18:39:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 3/4] cpufreq: intel_pstate: Add ->offline and ->online callbacks
Date:   Thu, 20 Aug 2020 18:38:01 +0200
Message-ID: <1879185.C8Vd3vmt8n@kreacher>
In-Reply-To: <2283366.Lr8yYYnyev@kreacher>
References: <2283366.Lr8yYYnyev@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Add ->offline and ->online driver callbacksto to do the cleanup
before taking a CPU offline and to restore its working configuration
when it goes back online, respectively, to avoid invoking the ->init
callback on every CPU online which is quite a bit of unnecessary
overhead.

Define ->offline and ->online so that they can be used in the
passive as well as in the active mode and because ->offline will
do the majority of ->stop_cpu work, the passive mode does not
need that callback any more, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3d18934fa975..aca0587b176f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2297,28 +2297,51 @@ static int intel_pstate_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static void intel_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
+	pr_debug("CPU %d going offline\n", policy->cpu);
+
+	intel_pstate_exit_perf_limits(policy);
+
+	/*
+	 * If the CPU is an SMT thread and it goes offline with the performance
+	 * settings different from the minimum, it will prevent its sibling
+	 * from getting to lower performance levels, so force the minimum
+	 * performance on CPU offline to prevent that form happening.
+	 */
 	if (hwp_active)
 		intel_pstate_hwp_force_min_perf(policy->cpu);
 	else
 		intel_pstate_set_min_pstate(all_cpu_data[policy->cpu]);
+
+	return 0;
+}
+
+static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
+{
+	pr_debug("CPU %d going online\n", policy->cpu);
+
+	intel_pstate_init_acpi_perf_limits(policy);
+
+	if (hwp_active)
+		wrmsrl_on_cpu(policy->cpu, MSR_HWP_REQUEST,
+			      all_cpu_data[policy->cpu]->hwp_req_cached);
+
+	return 0;
 }
 
 static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
 {
-	pr_debug("CPU %d exiting\n", policy->cpu);
+	pr_debug("CPU %d stopping\n", policy->cpu);
 
 	intel_pstate_clear_update_util_hook(policy->cpu);
 	if (hwp_active)
 		intel_pstate_hwp_save_state(policy);
-
-	intel_cpufreq_stop_cpu(policy);
 }
 
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
-	intel_pstate_exit_perf_limits(policy);
+	pr_debug("CPU %d exiting\n", policy->cpu);
 
 	policy->fast_switch_possible = false;
 
@@ -2398,6 +2421,8 @@ static struct cpufreq_driver intel_pstate = {
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
 	.stop_cpu	= intel_pstate_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_pstate",
 };
@@ -2652,7 +2677,8 @@ static struct cpufreq_driver intel_cpufreq = {
 	.fast_switch	= intel_cpufreq_fast_switch,
 	.init		= intel_cpufreq_cpu_init,
 	.exit		= intel_cpufreq_cpu_exit,
-	.stop_cpu	= intel_cpufreq_stop_cpu,
+	.offline	= intel_pstate_cpu_offline,
+	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
 	.name		= "intel_cpufreq",
 };
-- 
2.26.2




