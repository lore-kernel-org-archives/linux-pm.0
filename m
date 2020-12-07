Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD770C2BB3F
	for <linux-pm@archiver.kernel.org>; Mon,  7 Dec 2020 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9008A206C1
	for <linux-pm@archiver.kernel.org>; Mon,  7 Dec 2020 16:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgLGQkf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:40:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44414 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgLGQkf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 11:40:35 -0500
Received: from 89-64-79-106.dynamic.chello.pl (89.64.79.106) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id c811ea54e7d6c95c; Mon, 7 Dec 2020 17:39:53 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [PATCH v1 0/4] cpufreq: Allow drivers to receive more information from the governor
Date:   Mon, 07 Dec 2020 17:25:38 +0100
Message-ID: <20360841.iInq7taT2Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is based on the RFC posted a few days ago:

https://lore.kernel.org/linux-pm/1817571.2o5Kk4Ohv2@kreacher/

The majority of the original cover letter still applies, so let me quote it
here:

 Using intel_pstate in the passive mode with HWP enabled, in particular under
 the schedutil governor, is still kind of problematic, because it has to assume
 that it should not allow the frequency to fall below the one requested by the
 governor.  For this reason, it translates the target frequency into HWP.REQ.MIN
 which generally causes the processor to run a bit too fast.

 Moreover, this allows the HWP algorithm to use any frequency between the target
 one and HWP.REQ.MAX that corresponds to the policy max limit and some workloads
 cause it to go for the max turbo frequency prematurely which hurts energy-
 efficiency without improving performance, even though the schedutil governor
 itself would not allow the frequency to ramp up so fast.

 This patch series attempts to improve the situation by introducing a new driver
 callback allowing the driver to receive more information from the governor.  In
 particular, this allows the min (required) and target (desired) performance
 levels to be passed to it and those can be used to give better hints to the
 hardware.

There are two additional schedutil patches this time (IMO they kind of make
sense without the other two, even though the first one increases the amount of
memory used by schedutil) and patches [2-3/4] correspond to the two patches
in the RFC, respectively.

Please refer to the patch changelogs for details.

Thanks!



