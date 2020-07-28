Return-Path: <SRS0=HuBt=BH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE4BC433EC
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9214F2065C
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgG1UlB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jul 2020 16:41:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50106 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgG1UlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2020 16:41:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 266ED1C0BEB; Tue, 28 Jul 2020 22:41:00 +0200 (CEST)
Date:   Tue, 28 Jul 2020 22:40:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     rjw@rjwysocki.net, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v2] powercap: Add Power Limit4 support
Message-ID: <20200728204059.GF1012@bug>
References: <1594715306-10411-1-git-send-email-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594715306-10411-1-git-send-email-sumeet.r.pawnikar@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> Modern Intel Mobile platforms support power limit4 (PL4), which is
> the SoC package level maximum power limit (in Watts). It can be used
> to preemptively limits potential SoC power to prevent power spikes
> from tripping the power adapter and battery over-current protection.
> This patch enables this feature by exposing package level peak power
> capping control to userspace via RAPL sysfs interface. With this,
> application like DTPF can modify PL4 power limit, the similar way
> of other package power limit (PL1).
> As this feature is not tested on previous generations, here it is
> enabled only for the platform that has been verified to work,
> for safety concerns.

So what happens when the user sets this too high? Battery on fire? Or just sudden
poweroff?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
