From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: ARM: mxs: warnings on PM resume
Date: Sun, 12 Jun 2016 16:46:18 +0200 (CEST)
Message-ID: <1404923103.90724.9aa0b9cc-6e20-4fab-aeea-18352c528787.open-xchange@email.1und1.de>
References: <1713040590.199779.36789782-c361-4fe4-bc0d-b581fbce8069.open-xchange@email.1und1.de>
 <1955365225.76161.cd9a3eda-edc7-4bae-96f3-bdddccbb0478.open-xchange@email.1und1.de>
 <2607020.0FcLMf1DX6@vostro.rjw.lan>
 <908847370.85504.d47d66b7-356b-4e07-9e1d-807a299ea337.open-xchange@email.1und1.de>
 <20160612135428.GR1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:56817 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbcFLOrF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 12 Jun 2016 10:47:05 -0400
In-Reply-To: <20160612135428.GR1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Russell,

> Russell King - ARM Linux <linux@armlinux.org.uk> hat am 12. Juni 2016 um 15:54
> geschrieben:
> 
> 
> On Sun, Jun 12, 2016 at 12:27:02PM +0200, Stefan Wahren wrote:
> > Hi Rafael,
> > 
> > > "Rafael J. Wysocki" <rjw@rjwysocki.net> hat am 11. Juni 2016 um 03:42
> > > geschrieben:
> > > 
> > > Interrupts should not be enabled before syscore_resume() is called, but
> > > they
> > > are, apparently by the platform code.
> > 
> > sure, but it isn't that simple. I can't reproduce the warning everytime. At
> > least i need 5 tries and more to reproduce it.
> > 
> > I place the following code in the suspend code, before the low level suspend
> > code in SRAM gets executed:
> > 
> > if (!irqs_disabled())
> > 	pr_info("IRQs not disabled before suspend\n");
> > 
> > The info message above only get printed if the warning "Interrupts enabled
> > before system core resume." appears.
> > 
> > After that i dumped all enabled IRQs (at the same code place) from the
> > interrupt
> > collector (irqchip) and compared them with cat /proc/interrupts.
> 
> This isn't about the state of the interrupt controller.  It's about
> the state of the IRQ mask bit in the CPUs CPSR.
> 
> irq_disabled() returns true when the I bit in CPSR is set, false
> otherwise.
> 
> What it's pointing towards is some driver being unreasonable, and
> clearing the CPUs CPSR I bit after the core PM code has set it.  Causes
> can be using spin_lock_irq()/spin_unlock_irq()/local_irq_enable() etc
> inappropriately, rather than using the irqsave/irqrestore versions.
> 
> suspend_enter() does this:
> 
>         arch_suspend_disable_irqs();
>         BUG_ON(!irqs_disabled());
> 
>         error = syscore_suspend();
> 
> So, we can be sure that if we reach syscore_suspend(), then IRQs were
> disabled.
> 
> Now, syscore_suspend() calls a set of suspend callbacks, and verifies
> that interrupts are not re-enabled after each one.  So, you should be
> getting a complaint from the kernel if one of those does trigger, and
> these are about the last things that happen before the ->enter
> callback is called.  IRQs should be disabled when mxs_suspend_enter()
> is entered.

thanks for this explanation.

> 
> I'm confused by your statement about "the low level suspend code in SRAM
> gets executed" - from what I can see in arch/arm/mach-mxs (you said MXS
> in the subject), there is no SRAM code that gets executed for S2RAM.
> Since you also said MX23, that ties up with mach-mxs, so I can only
> conclude that you're using patches on top of mainline which change the
> platform suspend code.

Yes, as i wrote in my first email i'm working on this feature and i hope to
contribute it to mainline in the near future. My changes based on the old
Freescale BSP and the mainline i.MX5x S2RAM code [1].

Stefan

[1] - https://github.com/lategoodbye/linux-mxs-power/tree/rebase-4.5

> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
