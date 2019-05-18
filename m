Return-Path: <SRS0=4aLL=TS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0736FC04AAF
	for <linux-pm@archiver.kernel.org>; Sat, 18 May 2019 18:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB12B2087E
	for <linux-pm@archiver.kernel.org>; Sat, 18 May 2019 18:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfERSeD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 18 May 2019 14:34:03 -0400
Received: from muru.com ([72.249.23.125]:49852 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbfERSeD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 May 2019 14:34:03 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AD59E80AE;
        Sat, 18 May 2019 18:34:21 +0000 (UTC)
Date:   Sat, 18 May 2019 11:33:59 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/7] Some fixes and improvments for cpcap battery and
 charger
Message-ID: <20190518183359.GE5447@atomide.com>
References: <20190407181254.64537-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407181254.64537-1-tony@atomide.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Just to follow-up on the information below.

* Tony Lindgren <tony@atomide.com> [190407 11:13]:
> I've been trying to figure out how come the coulomb counter on droid 4 is off
> especially for the low power consumption values. Turns out the "coulomb counter"
> values correlate better with average power consumption if we divide the value with
> number of samples. Otherwise we have a curve instead of flat correlation between
> the register values and power consumed. I have some patches coming up eventually to
> fix that, but meanwhile I've noticed some minor issues in general that would be
> good to have out of the way.

So I've compared measurements from my power supply to measurements from
Baylibre ACME ina226, custom ina226 setup and ARM Energy Probe, and turns
out it's my power supply that has started wrong values and propably needs
calibration :)

So apologies for bashing the cpcap coulomb counter, it seems it's already
quite accurate showing average few mW less over 3 minute sample period
compared to my other measurements.

Regards,

Tony
