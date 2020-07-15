Return-Path: <SRS0=OhA8=A2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D2C433E2
	for <linux-pm@archiver.kernel.org>; Wed, 15 Jul 2020 13:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602B7206E9
	for <linux-pm@archiver.kernel.org>; Wed, 15 Jul 2020 13:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgGONzA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:55:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53536 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGONzA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 09:55:00 -0400
Received: from 89-64-84-223.dynamic.chello.pl (89.64.84.223) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id b1c849740f9f9775; Wed, 15 Jul 2020 15:54:58 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] cpufreq: intel_pstate: Clean up aperf_mperf_shift description
Date:   Wed, 15 Jul 2020 15:54:57 +0200
Message-ID: <1695770.kLfQgcESsc@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The kerneldoc description of the aperf_mperf_shift field in
struct global_params is unclear and there is a typo in it, so
simplify it and clean it up.

Reported-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -202,9 +202,7 @@ struct global_params {
  * @pstate:		Stores P state limits for this CPU
  * @vid:		Stores VID limits for this CPU
  * @last_sample_time:	Last Sample time
- * @aperf_mperf_shift:	Number of clock cycles after aperf, merf is incremented
- *			This shift is a multiplier to mperf delta to
- *			calculate CPU busy.
+ * @aperf_mperf_shift:	APERF vs MPERF counting frequency difference
  * @prev_aperf:		Last APERF value read from APERF MSR
  * @prev_mperf:		Last MPERF value read from MPERF MSR
  * @prev_tsc:		Last timestamp counter (TSC) value



