From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] genirq / PM: Add flag for shared NO_SUSPEND interrupt
 lines
Date: Wed, 4 Mar 2015 19:42:46 +0000
Message-ID: <20150304194246.GF22156@leverpostej>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan>
 <20150226191724.0ae4ca4e@bbrezillon>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54627 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754279AbbCDTnQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Mar 2015 14:43:16 -0500
Content-Disposition: inline
In-Reply-To: <6864616.1aRDSmSsvx@vostro.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,

I'm a little late to the party here, but I have just a couple of minor
comments...

[...]

> Link: http://marc.info/?l=linux-kernel&m=142252777602084&w=2
> Link: http://marc.info/?t=142252775300011&r=1&w=2
> Linx: https://lkml.org/lkml/2014/12/15/552

s/x/k/ ?

> Reported-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/interrupt.h |    5 +++++
>  include/linux/irqdesc.h   |    1 +
>  kernel/irq/manage.c       |    7 ++++++-
>  kernel/irq/pm.c           |    7 ++++++-
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/include/linux/interrupt.h
> ===================================================================
> --- linux-pm.orig/include/linux/interrupt.h
> +++ linux-pm/include/linux/interrupt.h
> @@ -57,6 +57,10 @@
>   * IRQF_NO_THREAD - Interrupt cannot be threaded
>   * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
>   *                resume time.
> + * IRQF_COND_SUSPEND - If the IRQ is shared with a NO_SUSPEND user, execute this
> + *                interrupt handler after suspending interrupts. For system
> + *                wakeup devices users need to implement wakeup detection in
> + *                their interrupt handlers.

It's probably worth documenting this in suspend-and-interrupts.txt, as
this invalidates some of the "IRQF_NO_SUSPEND and enable_irq_wake()"
section. I'll send a patch momentarily to that effect.

Otherwise, this patch looks good, thanks for handling this!

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
