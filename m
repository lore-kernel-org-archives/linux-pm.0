Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6DBC433E6
	for <linux-pm@archiver.kernel.org>; Thu,  4 Feb 2021 17:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F7A64F60
	for <linux-pm@archiver.kernel.org>; Thu,  4 Feb 2021 17:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbhBDRhm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 4 Feb 2021 12:37:42 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51120 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbhBDRgP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 12:36:15 -0500
Received: from 89-64-81-64.dynamic.chello.pl (89.64.81.64) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 39f69ac353cce522; Thu, 4 Feb 2021 18:35:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Larabel <Michael@phoronix.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v1 0/2] cpufreq: ACPI: Address performance regression related to scale-invariance
Date:   Thu, 04 Feb 2021 18:23:58 +0100
Message-ID: <13690581.X0sz4iL7V8@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

These 2 patches address a performance regression related to scale-invariance
found by Michael and analyzed by Giovanni (see the patch from Giovanni at
https://lore.kernel.org/linux-pm/20210203135321.12253-2-ggherdovich@suse.cz/).

Patch [1/2] is a replacement for the one mentioned above (it was posted without
a changelog and tested somewhat) and patch [2/2] takes care of systems without
CPPC on top of that.

Please see the patch changelogs for details and let me know if you have any
concerns.

Thanks!



