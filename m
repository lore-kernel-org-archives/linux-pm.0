From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] genirq / PM: Add flag for shared NO_SUSPEND interrupt
 lines
Date: Fri, 27 Feb 2015 09:38:59 +0100
Message-ID: <20150227083859.GD21418@twins.programming.kicks-ass.net>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan>
 <20150226191724.0ae4ca4e@bbrezillon>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33613 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbbB0IjI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Feb 2015 03:39:08 -0500
Content-Disposition: inline
In-Reply-To: <6864616.1aRDSmSsvx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Feb 27, 2015 at 12:07:55AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It currently is required that all users of NO_SUSPEND interrupt
> lines pass the IRQF_NO_SUSPEND flag when requesting the IRQ or the
> WARN_ON_ONCE() in irq_pm_install_action() will trigger.  That is
> done to warn about situations in which unprepared interrupt handlers
> may be run unnecessarily for suspended devices and may attempt to
> access those devices by mistake.  However, it may cause drivers
> that have no technical reasons for using IRQF_NO_SUSPEND to set
> that flag just because they happen to share the interrupt line
> with something like a timer.
> 
> Moreover, the generic handling of wakeup interrupts introduced by
> commit 9ce7a25849e8 (genirq: Simplify wakeup mechanism) only works
> for IRQs without any NO_SUSPEND users, so the drivers of wakeup
> devices needing to use shared NO_SUSPEND interrupt lines for
> signaling system wakeup generally have to detect wakeup in their
> interrupt handlers.  Thus if they happen to share an interrupt line
> with a NO_SUSPEND user, they also need to request that their
> interrupt handlers be run after suspend_device_irqs().
> 
> In both cases the reason for using IRQF_NO_SUSPEND is not because
> the driver in question has a genuine need to run its interrupt
> handler after suspend_device_irqs(), but because it happens to
> share the line with some other NO_SUSPEND user.  Otherwise, the
> driver would do without IRQF_NO_SUSPEND just fine.
> 
> To make it possible to specify that condition explicitly, introduce
> a new IRQ action handler flag for shared IRQs, IRQF_COND_SUSPEND,
> that, when set, will indicate to the IRQ core that the interrupt
> user is generally fine with suspending the IRQ, but it also can
> tolerate handler invocations after suspend_device_irqs() and, in
> particular, it is capable of detecting system wakeup and triggering
> it as appropriate from its interrupt handler.
> 
> That will allow us to work around a problem with a shared timer
> interrupt line on at91 platforms.
> 
> Link: http://marc.info/?l=linux-kernel&m=142252777602084&w=2
> Link: http://marc.info/?t=142252775300011&r=1&w=2
> Linx: https://lkml.org/lkml/2014/12/15/552
> Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Seems good to me. Should I take this through tip/irq ?

Also, should we warn if people use enable_irq_wake() where there is only
a single descriptor with NO_SUSPEND?
