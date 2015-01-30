From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 1/1] PM / domains: Add support for virtual power
 domains
Date: Fri, 30 Jan 2015 11:57:08 +0000
Message-ID: <20150130115708.GE8787@red-moon>
References: <1422555176-13054-1-git-send-email-k.wrona@samsung.com>
 <1422555176-13054-2-git-send-email-k.wrona@samsung.com>
 <CADGdYn5E9P7cT-bndL4u9g9XRO=BvE5hb1+TEF0mkwkWOmK1VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:46535 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbbA3L5I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 06:57:08 -0500
Content-Disposition: inline
In-Reply-To: <CADGdYn5E9P7cT-bndL4u9g9XRO=BvE5hb1+TEF0mkwkWOmK1VA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: Karol Wrona <k.wrona@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>

On Fri, Jan 30, 2015 at 08:43:22AM +0000, amit daniel kachhap wrote:
> Hi Karol,
> 
> I guess this patch series is not complete and use case implementation
> will be more helpful for clarity. Also I can think of another way in
> which this complete implementation can be done with pd name as
> something "pd-virt". This pd can be handled differently inside the
> platform specific exynos power off/on function.

Yes, it would be nice to provide an example to understand what this
patchset has to achieve. Is this supposed to be a power domain
used as a container to check for devices runtime state ie dependencies ?

Thanks,
Lorenzo

> Regards,
> Amit D
> 
> On Thu, Jan 29, 2015 at 11:42 PM, Karol Wrona <k.wrona@samsung.com> wrote:
> > There are the power domains which are turned off or put to retention only during
> > suspend or special processor states.  In such case there is a need to register
> > some devices which belong to such domain that PM core could know the state of
> > such devices and decide which power mode should be chosen i.e. the domain can
> > not be put to retention if some devices are active.  Virtual power domain has
> > empty power_on/off callbacks as there is no need to gate anything.
> >
> > Signed-off-by: Karol Wrona <k.wrona@samsung.com>
> > ---
> >  drivers/base/power/Makefile          |    3 +-
> >  drivers/base/power/pm_domains_virt.c |   54 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/base/power/pm_domains_virt.c
> >
> > diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> > index 1cb8544..360a0e2 100644
> > --- a/drivers/base/power/Makefile
> > +++ b/drivers/base/power/Makefile
> > @@ -2,7 +2,8 @@ obj-$(CONFIG_PM)        += sysfs.o generic_ops.o common.o qos.o runtime.o
> >  obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o
> >  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
> >  obj-$(CONFIG_PM_OPP)   += opp.o
> > -obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=  domain.o domain_governor.o
> > +obj-$(CONFIG_PM_GENERIC_DOMAINS)       += domain.o domain_governor.o \
> > +                                          pm_domains_virt.o
> >  obj-$(CONFIG_HAVE_CLK) += clock_ops.o
> >
> >  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> > diff --git a/drivers/base/power/pm_domains_virt.c b/drivers/base/power/pm_domains_virt.c
> > new file mode 100644
> > index 0000000..bd4d6b6
> > --- /dev/null
> > +++ b/drivers/base/power/pm_domains_virt.c
> > @@ -0,0 +1,54 @@
> > +/*
> > + *  Copyright (C) 2015, Samsung Electronics Co. Ltd. All Rights Reserved.
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/of.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/slab.h>
> > +
> > +static int pd_power_off(struct generic_pm_domain *domain)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int pd_power_on(struct generic_pm_domain *domain)
> > +{
> > +       return 0;
> > +}
> > +
> > +int __init virt_pm_domains_init(void)
> > +{
> > +       struct device_node *np;
> > +
> > +       for_each_compatible_node(np, NULL, "linux,virtual-pm-domains") {
> > +               struct generic_pm_domain *pd;
> > +
> > +               pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> > +               if (!pd)
> > +                       return -ENOMEM;
> > +
> > +               pd->power_off = pd_power_off;
> > +               pd->power_on = pd_power_on;
> > +               pd->name = kstrdup(np->name, GFP_KERNEL);
> > +               if (!pd->name)
> > +                       return -ENOMEM;
> > +
> > +               pm_genpd_init(pd, NULL, false);
> > +               of_genpd_add_provider_simple(np, pd);
> > +       }
> > +
> > +       return 0;
> > +}
> > +arch_initcall(virt_pm_domains_init);
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
