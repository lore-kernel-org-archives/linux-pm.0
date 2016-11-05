From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sat, 5 Nov 2016 18:05:42 +0000
Message-ID: <20161105180542.GE1041@n2100.armlinux.org.uk>
References: <20161023133134.GI1041@n2100.armlinux.org.uk>
 <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <20161031161700.GH1041@n2100.armlinux.org.uk>
 <847975190.29034.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
 <20161101092304.GM1041@n2100.armlinux.org.uk>
 <322177156.158733.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <1478345972.2206.15.camel@intel.com>
 <122295766.159553.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <20161105130034.GG15759@mai>
 <1113068116.152452.34665947-6f6b-41d6-92af-eabcbcb794ea.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56302 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752918AbcKESGI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Nov 2016 14:06:08 -0400
Content-Disposition: inline
In-Reply-To: <1113068116.152452.34665947-6f6b-41d6-92af-eabcbcb794ea.open-xchange@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@nxp.com>

On Sat, Nov 05, 2016 at 04:28:37PM +0100, Stefan Wahren wrote:
> As i wrote in my email before, i added a pr_info() into freeze_wake.
> But i never see the output of this message. So i assume freeze_wake
> is never called. Again, how could this happen?

Hmm, so the bit that you're getting stuck on is:

        wait_event(suspend_freeze_wait_head,
                   suspend_freeze_state == FREEZE_STATE_WAKE);

Now there's two things about this here - it's a non-interruptible wait,
so I think the hung task detection may trigger on that (I'm not entirely
sure on that point though, and I don't have time this evening to read
the code to find out.)

The second thing is, that in order to pass this point, something has to
call freeze_wake().

There's not that many possibilities for that:

$ git grep freeze_wake drivers kernel
drivers/base/power/wakeup.c:    freeze_wake();
drivers/base/power/wakeup.c:    freeze_wake();
kernel/power/suspend.c:void freeze_wake(void)
kernel/power/suspend.c:EXPORT_SYMBOL_GPL(freeze_wake);

One of those is pm_system_wakeup(), the other is wakeup_source_activate()
via wakeup_source_report_event() via __pm_stay_awake() or
__pm_wakeup_event().

Looking at the results of:

$ grep 'pm_wakeup_event\|pm_stay_awake\|pm_system_wakeup' drivers kernel -r

it looks like for freeze support to work, various drivers need to call
one of these functions.

The iMX serial driver doesn't call any of these functions, so I can't
see how we'd get past this point - and from that grep you'll see nothing
in kernel/irq touches any of these functions.

Documentation/power/suspend-and-interrupts.txt does a very poor job
(which is typical) of describing what the requirements are for
"suspend-to-idle", it doesn't really say that any of the above
functions must be called and it doesn't say who's responsible for
calling these functions.  It does talk about "pm_system_wakeup()"
for "rare cases".

So my conclusion, based on the poor documentation and the results of
my greps, is that "freeze" aka "suspend-to-idle" is not supported on
the majority of hardware, and attempting to use it will result in the
system locking up in exactly the way you're seeing.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
