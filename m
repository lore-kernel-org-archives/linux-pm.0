From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: discard duplicate OPP additions
Date: Thu, 15 May 2014 14:25:52 +0530
Message-ID: <CAKohpom1t2sOWr_S5Xzhx_OG=2qmgkZ5Z6UJ4TKAmJgeq0TU2Q@mail.gmail.com>
References: <1399966890-22926-1-git-send-email-k.chander@samsung.com>
	<CAGo_u6qTZ-yq26+K5nHut92d=-9nrCHKDNK9EMLK5kGMQc+dOw@mail.gmail.com>
	<CANuQgHGehqDD8-SKTfEKMEZmT5KwofFL8bhYqge0uNm6kpPgUQ@mail.gmail.com>
	<CAKohponfdoPG7H4h-5s+V7CwB_SgnyqqUm9aa6G-K_cX3DOcfA@mail.gmail.com>
	<53737D34.5040307@ti.com>
	<CANuQgHG23F7zGxbNJVzGAeCsNNPU_CwSu5veK2-CCjnc1RE-UQ@mail.gmail.com>
	<CAKohpo=O_=PVpFCnTWA=0R6deMFHgWx8dxOecro1dMwGVwxong@mail.gmail.com>
	<CANuQgHEECW3c2C5+h7vUp5RuWJin3PPaos_BY1VoqzR=jTwGFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49612 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbaEOIzx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 May 2014 04:55:53 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so863261obc.7
        for <linux-pm@vger.kernel.org>; Thu, 15 May 2014 01:55:52 -0700 (PDT)
In-Reply-To: <CANuQgHEECW3c2C5+h7vUp5RuWJin3PPaos_BY1VoqzR=jTwGFQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 15 May 2014 14:16, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> Yes exactly. All users of this API need to be modified to handle
> EEXIST as success.

There are very few:

arch/arm/mach-omap2/opp.c
arch/arm/mach-vexpress/spc.c
drivers/devfreq/exynos/exynos4_bus.c
drivers/devfreq/exynos/exynos5_bus.c

So shouldn't be a problem fixing them..

> To avoid this returning 0 was suggested

But the bigger problem is that all new users have to know about this
and must take care of it, would also result in code duplication.

So, if I think this way:

The purpose of dev_pm_opp_add() is to make sure the OPP is
present with the device, when this function returns..

And with a duplicate entry, we can still confirm that. Over that, I couldn't
think of any situation where the caller wants to react to -EXIST separately.
They will still consider it as success.

So, maybe returning '0' isn't that bad of an idea :)

@Nishanth ?
