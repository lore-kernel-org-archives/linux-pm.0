From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sat, 5 Nov 2016 16:28:37 +0100 (CET)
Message-ID: <1113068116.152452.34665947-6f6b-41d6-92af-eabcbcb794ea.open-xchange@email.1und1.de>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
 <20161023133134.GI1041@n2100.armlinux.org.uk>
 <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <20161031161700.GH1041@n2100.armlinux.org.uk>
 <847975190.29034.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
 <20161101092304.GM1041@n2100.armlinux.org.uk>
 <322177156.158733.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <1478345972.2206.15.camel@intel.com>
 <122295766.159553.9867e3e7-5710-4844-a098-6f44bd852a6d.open-xchange@email.1und1.de>
 <20161105130034.GG15759@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:59565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755658AbcKEP3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Nov 2016 11:29:30 -0400
In-Reply-To: <20161105130034.GG15759@mai>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@nxp.com>

Hi Daniel,

> Daniel Lezcano <daniel.lezcano@linaro.org> hat am 5. November 2016 um 14:00
> geschrieben:
> 
> 
> On Sat, Nov 05, 2016 at 01:01:26PM +0100, Stefan Wahren wrote:
> 
> [ ... ]
> 
> > > > CONFIG_SUSPEND=y
> > > > CONFIG_SUSPEND_FREEZER=y
> > > > CONFIG_PM=y
> > > > CONFIG_CPU_IDLE is not set
> > > 
> > > hmmm, why not have CONFIG_CPU_IDLE set?
> > 
> > I'm using mxs_defconfig which doesn't select the ARM CPU idle. Is this
> > necessary?
> 
> Very likely :) suspend_freezer and cpuidle are tied together.
> 
> Moreover, while reading the code, it appears without CONFIG_CPU_IDLE the
> function cpuidle_idle_call is constantly failing, ending up by having the
> cpu looping again and again in the idle loop. The function stubs return
> -ENODEV in the cpuidle's header when CONFIG_CPU_IDLE is not set.
> 
> If I'm not wrong the traces should show the cpu actually does never go
> to suspend. As soon as it enters the state, it should exit immediately
> without an interrupt event.
> 
> Probably there is an inconsistent configuration leaving the kernel with
> a strange wakeup condition or a race with the short the suspend/resume
> cycle delay.
> 
> First test would be to enable CONFIG_CPU_IDLE.
> 
> If it is confirmed, it would be nice to feed bugzilla.

first i tried with CONFIG_CPU_IDLE=Y and then additionally with
CONFIG_ARM_CPUIDLE=y.

In both cases the issue is still reproducible.

As i wrote in my email before, i added a pr_info() into freeze_wake. But i never
see the output of this message. So i assume freeze_wake is never called. Again,
how could this happen?
