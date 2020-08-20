Return-Path: <SRS0=iPxC=B6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBB1C433E5
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 16:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77A1207DE
	for <linux-pm@archiver.kernel.org>; Thu, 20 Aug 2020 16:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgHTQjV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:39:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65018 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729981AbgHTQjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2020 12:39:12 -0400
Received: from 89-64-87-57.dynamic.chello.pl (89.64.87.57) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.459)
 id e9198aecfb4d7553; Thu, 20 Aug 2020 18:39:11 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH 0/4] cpufreq: intel_pstate: Address some HWP-related oddities
Date:   Thu, 20 Aug 2020 18:35:20 +0200
Message-ID: <2283366.Lr8yYYnyev@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

The purpose of this series is to address some peculiarities related to
taking CPUs offline/online and switching between different operation
modes with HWP enabled that have become visible after allowing the
driver to work in the passive mode with HWP enabled in 5.9-rc1 (and
one that was there earlier, but can be addressed easily after the
changes madein 5.9-rc1).

Please refer to the patch changelogs for details.

For easier testing/review, the series is available from the git branch at:

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 intel_pstate-testing

Thanks,
Rafael



