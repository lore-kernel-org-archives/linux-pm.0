From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFT] irqchip: mxs: Enable SKIP_SET_WAKE and
 MASK_ON_SUSPEND
Date: Wed, 16 Nov 2016 17:40:17 +0100 (CET)
Message-ID: <385549534.180928.e7d7379f-2688-45de-8e73-a2f866d7cd9c.open-xchange@email.1und1.de>
References: <1478885208-18821-1-git-send-email-stefan.wahren@i2se.com>
 <40c3be7e-08c3-955c-746a-6906160e1e0a@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:53682 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbcKPQni (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Nov 2016 11:43:38 -0500
In-Reply-To: <40c3be7e-08c3-955c-746a-6906160e1e0a@rempel-privat.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Fabio Estevam <fabio.estevam@nxp.com>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <lw@karo-electronics.de>, Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>


> Oleksij Rempel <linux@rempel-privat.de> hat am 12. November 2016 um 20:24
> geschrieben:
> 
> 
> Am 11.11.2016 um 18:26 schrieb Stefan Wahren:
> > The ICOLL controller doesn't provide any facility to configure the
> > wakeup sources. That's the reason why this implementation lacks
> > the irq_set_wake implementation. But this prevent us from properly
> > entering power management states like "suspend to idle".
> > 
> > So enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND
> > to let the irqchip core allows and handles the power management.
> > 
> > This patch has been tested with a MX23 and a MX28 board. Any further
> > tests especially with ASM9260 would be appreciated.
> 
> Hi, I wont be able to test this patch on ASM9260 until March.
> Please roll it out, so far it looks ok for me.

Is this an "Acked-by" ?

> 
> 
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >  drivers/irqchip/irq-mxs.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
> > index 1730470..05fa9f7 100644
> > --- a/drivers/irqchip/irq-mxs.c
> > +++ b/drivers/irqchip/irq-mxs.c
> > @@ -131,12 +131,16 @@ static void asm9260_unmask_irq(struct irq_data *d)
> >  	.irq_ack = icoll_ack_irq,
> >  	.irq_mask = icoll_mask_irq,
> >  	.irq_unmask = icoll_unmask_irq,
> > +	.flags = IRQCHIP_MASK_ON_SUSPEND |
> > +		 IRQCHIP_SKIP_SET_WAKE,
> >  };
> >  
> >  static struct irq_chip asm9260_icoll_chip = {
> >  	.irq_ack = icoll_ack_irq,
> >  	.irq_mask = asm9260_mask_irq,
> >  	.irq_unmask = asm9260_unmask_irq,
> > +	.flags = IRQCHIP_MASK_ON_SUSPEND |
> > +		 IRQCHIP_SKIP_SET_WAKE,
> >  };
> >  
> >  asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs
> > *regs)
> > 
> 
> 
> -- 
> Regards,
> Oleksij
>
