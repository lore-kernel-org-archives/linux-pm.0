Return-Path: <SRS0=knII=5K=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9157BC1975A
	for <linux-pm@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7459320774
	for <linux-pm@archiver.kernel.org>; Wed, 25 Mar 2020 15:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCYPSM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:18:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:51317 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYPSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 11:18:12 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 37eb982999ca91a4; Wed, 25 Mar 2020 16:18:09 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Simplify intel_pstate_cpu_init()
Date:   Wed, 25 Mar 2020 16:18:09 +0100
Message-ID: <2521958.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The initial policy value set by intel_pstate_cpu_init() depends on
whether or not CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is set, but
that is not necessary, because the core will set the policy to
"performance" in cpufreq_init_policy() if the default governor is
"performance" anyway.

Accordingly, change intel_pstate_cpu_init() to always set policy
to CPUFREQ_POLICY_POWERSAVE initially to provide a valid fallback
value to cpufreq_init_policy() in case the default cpufreq governor
is neither "powersave" nor "performance".

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2247,10 +2247,11 @@ static int intel_pstate_cpu_init(struct
 	if (ret)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE))
-		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-	else
-		policy->policy = CPUFREQ_POLICY_POWERSAVE;
+	/*
+	 * Set the policy to powersave to provide a valid fallback value in case
+	 * the default cpufreq governor is neither powersave nor performance.
+	 */
+	policy->policy = CPUFREQ_POLICY_POWERSAVE;
 
 	return 0;
 }



