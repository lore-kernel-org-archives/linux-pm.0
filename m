Return-Path: <SRS0=t+QV=ZO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD22C432C0
	for <linux-pm@archiver.kernel.org>; Fri, 22 Nov 2019 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC27E20714
	for <linux-pm@archiver.kernel.org>; Fri, 22 Nov 2019 17:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKVR3o (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:29:44 -0500
Received: from mailbackend.panix.com ([166.84.1.89]:56279 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVR3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Nov 2019 12:29:44 -0500
Received: from hp-x360n.lan (ip68-111-223-64.sd.sd.cox.net [68.111.223.64])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 47KNj14fQ9z1FMX;
        Fri, 22 Nov 2019 12:29:41 -0500 (EST)
Date:   Fri, 22 Nov 2019 09:29:40 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Help me fix a regression caused by 56b9918490 (PM: sleep: Simplify
 suspend-to-idle control flow)
In-Reply-To: <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911220920500.24730@hp-x360n>
References: <alpine.DEB.2.21.1911211549500.3167@hp-x360n> <CAJZ5v0jQ3RY8An+V2VYH+ZKLC6=HrCYUMomM6jyEXJ47aeLT+A@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Fri, 22 Nov 2019, Rafael J. Wysocki wrote:

> First off, please try to change the sleep_no_lps0 ACPI module
> parameter (/sys/module/acpi/parameters/sleep_no_lps0) to 1 and see if
> that makes any difference.

I did try that; didn't seem to help. I will run a few tests to make sure,
though.

> If it helps, I don't think we can do much except for blacklisting your machine.

Urgh. Blacklisting from what/which facility?

Every now and then, when this thing goes to sleep it mostly goes down to 50mA
(measured by the USB-C charging port) idle current; I wish it were less, but
this is "modern" suspend. But every Nth suspend it will draw 180 to 240 mA for
reasons I can't deduce, and I was wondering if perhaps we're getting wedged in
an intermediate state on the way into s2idle. That's why I'm trying to make
sure I have access to every possible suspend enhancement.

At one point it was a regression in i915 that caused a high suspend current
at all times and I helped Chris Wilson and those guys track down, but that's
been OK for a while.

One thing that I do get is the dump on resume when it doesn't go into S0ix
(intel_pmc_core.warn_on_s0ix_failures=1) and there's a number of what I
assume are clocks and power rails that are still "on"; I imagine some of
that is done by the BIOS (e.g., "MPHY_CORE_GATED", "CNV_VNNAON_REQ_ACT").
Do you know what these are mnemonics for?

Thanks,

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Silicon Valley
