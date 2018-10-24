From: Nick Hu <nickhu@andestech.com>
Subject: Re: [PATCH 1/1] nds32: Power management for nds32
Date: Wed, 24 Oct 2018 17:38:43 +0800
Message-ID: <20181024093843.GA18476@andestech.com>
References: <cover.1540349342.git.nickhu@andestech.com>
 <ccc18702a8d93c0a31e46f53c498b6d34c9c17e1.1540349342.git.nickhu@andestech.com>
 <20181024065117.GA18779@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024065117.GA18779@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= <greentime@andestech.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "tglx@linutronix.de" <tglx@linutronix.de>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, Zong Zong-Xian =?utf-8?B?TGko5p2O5a6X5oayKQ==?= <zong@andestech.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= <alankao@andestech.com>, "green.hu@gmail.com" <green.hu@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

On Wed, Oct 24, 2018 at 02:51:17PM +0800, Pavel Machek wrote:
> On Wed 2018-10-24 11:40:07, Nickhu wrote:
> > There are three sleep states in nds32:
> > 	suspend to idle,
> > 	suspend to standby,
> > 	suspend to ram
> > 
> > In suspend to ram, we use the 'standby' instruction to emulate
> > power management device to hang the system util wakeup source
> > send wakeup events to break the loop.
> > 
> > First, we push the general purpose registers and system registers
> > to stack. Second, we translate stack pointer to physical address
> > and store to memory to save the stack pointer. Third, after write
> > back and invalid the cache we hang in 'standby' intruction.
> > When wakeup source trigger wake up events, the loop will be break
> > and resume the system.
> > 
> > Signed-off-by: Nickhu <nickhu@andestech.com>
> 
> Is "Nickhu" complete name?
>
Oh, Nick Hu is my complete name.
I will fix it.
Thanks!
 
> > diff --git a/arch/nds32/kernel/pm.c b/arch/nds32/kernel/pm.c
> > new file mode 100644
> > index 000000000000..e1eaf3bac709
> > --- /dev/null
> > +++ b/arch/nds32/kernel/pm.c
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (C) 2008-2017 Andes Technology Corporation
> > +
> > +/*
> > + * nds32 Power Management Routines
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License.
> > + *
> > + *  Abstract:
> > + *
> > + *    This program is for nds32 power management routines.
> > + *
> > + */
> 
> I'd get rid of "abstract" here, repeating GPL twice and "nds32 power
> management routines" twice does not make much sense either.
> 
Ok, I will get rid of it.

> > @@ -0,0 +1,129 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright (C) 2017 Andes Technology Corporation */
> > +
> > +#include<asm/memory.h>
> 
> Missing space.
> 
> > +static int nointc_set_wake(struct irq_data *data, unsigned int on)
> > +{
> > +	unsigned long int_mask = __nds32__mfsr(NDS32_SR_INT_MASK);
> > +	static bool is_bit_1[NR_IRQS] = {false};
> > +	u32 bit = 1 << data->hwirq;
> > +
> > +	if (on) {
> > +		if (int_mask & bit)
> > +			is_bit_1[data->hwirq] = true;
> > +		else
> > +			is_bit_1[data->hwirq] = false;
> > +
> > +		int_mask |= bit;
> > +		wake_mask |= bit;
> > +	} else {
> > +		if (!is_bit_1[data->hwirq])
> > +			int_mask &= ~bit;
> > +
> > +		wake_mask &= ~bit;
> > +		is_bit_1[data->hwirq] = false;
> > +	}
> 
> Can we get rid of "is_bit_1" array here, and use normal bit operations
> on another variable here?
>
Do you mean like this:

 static int nointc_set_wake(struct irq_data *data, unsigned int on)  {
        unsigned long int_mask = __nds32__mfsr(NDS32_SR_INT_MASK);
        static unsigned long irq_orig_bit = 0;
        u32 bit = 1 << data->hwirq;

        if (on) {
                if (int_mask & bit)
                        __assign_bit(data->hwirq, &irq_orig_bit, true);
                else
                        __assign_bit(data->hwirq, &irq_orig_bit, false);
 
                __assign_bit(data->hwirq, &int_mask, true);
                __assign_bit(data->hwirq, &wake_mask, true);

        } else {
                if (!(irq_orig_bit & bit))
                        __assign_bit(data->hwirq, &int_mask, false);

                __assign_bit(data->hwirq, &wake_mask, false);
                __assign_bit(data->hwirq, &irq_orig_bit, false);
        }

        __nds32__mtsr_dsb(int_mask, NDS32_SR_INT_MASK);
 
        return 0;
 }

> Thanks,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Thank your for quick reply,
Nick Hu.
