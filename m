From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/7] arm, arm64: factorize common cpu capacity default
 code
Date: Thu, 19 Jan 2017 15:51:40 +0000
Message-ID: <20170119155140.GK30747@e106622-lin>
References: <20170119143757.14537-1-juri.lelli@arm.com>
 <20170119143757.14537-7-juri.lelli@arm.com>
 <20170119145333.GB27312@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170119145333.GB27312-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19/01/17 14:53, Russell King - ARM Linux wrote:
> On Thu, Jan 19, 2017 at 02:37:56PM +0000, Juri Lelli wrote:
> > +extern unsigned long
> > +arch_scale_cpu_capacity(struct sched_domain *sd, int cpu);
> > +extern void set_capacity_scale(unsigned int cpu, unsigned long capacity);
> 
> These should be in a header file (please run your code through sparse).
> 
> > +extern bool cap_parsing_failed;
> > +extern void normalize_cpu_capacity(void);
> > +extern int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu);
> 
> Same for these.
> 

Right, I was wondering where to put these in the cover letter. New
header file (e.g., include/linux/arch_topology.h) or some existing one? 

> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > new file mode 100644
> > index 000000000000..3faf89518892
> > --- /dev/null
> > +++ b/drivers/base/arch_topology.c
> > @@ -0,0 +1,240 @@
> > +/*
> > + * driver/base/arch_topology.c - Arch specific cpu topology information
> > + *
> > + * Written by: Juri Lelli, ARM Ltd.
> > + *
> > + * Copyright (C) 2016, ARM Ltd.
> > + *
> > + * All rights reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> 
> The files that you've taken this code from are GPLv2, but you've thrown
> a GPLv2+ header on a file that's merely a copy of the original code.
> As some of the code you've moved to this new file is from Nicolas and
> Vincent, you need to seek their approval to make this change of license
> terms, or keep the original license terms.
> 

Apologies. I'd say we keep the original one. I'll modify it in the next
version.

Thanks,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
