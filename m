From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sun, 16 Jul 2017 12:22:08 +0200
Message-ID: <3675920.H2f5xgTCgu@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net> <1703157.S2GHVxrQk4@aspire.rjw.lan> <e680f86a-88db-8a53-dca6-a79d120d480b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65217 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751048AbdGPK34 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 06:29:56 -0400
In-Reply-To: <e680f86a-88db-8a53-dca6-a79d120d480b@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mason <slash.tmp@free.fr>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Saturday, July 15, 2017 07:36:21 PM Florian Fainelli wrote:
> 
> On 07/15/2017 04:38 PM, Rafael J. Wysocki wrote:
> > On Sunday, July 16, 2017 01:34:53 AM Mason wrote:
> >> On 16/07/2017 01:24, Rafael J. Wysocki wrote:
> >>
> >>> On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
> >>>
> >>>> The enum offers the advantage of centralizing how many different states
> >>>> exist for all the platforms we know about in the kernel, it's easy to
> >>>> define common values for platforms that have the same semantics, just
> >>>> like it's simple to add new values for platform specific details.
> >>>
> >>> Well, you seem to be liking this, so why don't you just implement it?
> >>
> >> At the end of his message, Florian wrote:
> >>
> >>> In any case, just agree and I will be happy to follow-up with patches.
> > 
> > But it may be hard to convince everybody without posting code changes
> > and often enough showing a patch makes a good argument.
> 
> I had the patches ready last night, saw the emails this morning and
> decided to go mountain bike for a bit to think about it some more. You
> will find my follow-up patches that hopefully implement your recommendation.

OK, thanks!

There is one problem with this I missed before, though, sorry about that.

Drivers need to be able to distinguish between suspend-to-idle and the platform
states too, so we need to store the argument passed to suspend_devices_and_enter()
somewhere too, either in the core or in the platform code.

And if we need to store it anyway, let's just store it in the core in a global var
(say pm_suspend_target_state), export that and be done.

There still will be a concern regarding drivers that care about differences between
PM_SUSPEND_MEM and PM_SUSPEND_STANDBY, because those differences are
platform-dependent, but let's defer addressing this until we have a driver
that needs to run on different platforms with different definitions for those
things.

That should address the Pavel's objections too I guess.

Thanks,
Rafael
