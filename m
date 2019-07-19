Return-Path: <SRS0=bJFD=VQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54762C76195
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jul 2019 13:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340562173B
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jul 2019 13:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbfGSNEC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:04:02 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:52493 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfGSNEC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jul 2019 09:04:02 -0400
Received: from hp-x360 (173-8-203-89-Oregon.hfc.comcastbusiness.net [173.8.203.89])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 45qrmb0FNsz1Y8B;
        Fri, 19 Jul 2019 09:03:58 -0400 (EDT)
Date:   Fri, 19 Jul 2019 06:03:57 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Fwd: Commit 555c45fe0d0 ("int340X/processor_thermal_device:
 add support for MMIO RAPL") boot failure]
In-Reply-To: <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907190601580.2769@hp-x360>
References: <alpine.DEB.2.21.1907181955330.2769@hp-x360> <1563514893.2433.3.camel@intel.com> <alpine.DEB.2.21.1907182308321.2769@hp-x360> <CAJZ5v0jYdV3esYfj9Yc2NRkdTFNdDvFnuuOe-rTwFQFhFvRH=g@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 19 Jul 2019, Rafael J. Wysocki wrote:

> So can you disable PROC_THERMAL_MMIO_RAPL in Kconfig and retest?

It can't be manually disabled, as it's auto-selected:

	Depends on: THERMAL [=y] && (X86 [=y] || X86_INTEL_QUARK [=n] ||
	COMPILE_TEST [=n]) && INT340X_THERMAL [=y] && 64BIT [=y] && POWERCAP [=y]

so I just reverted the commit to get going again,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
