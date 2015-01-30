From: amit daniel kachhap <amit.daniel-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/1] PM / domains: Add support for virtual power domains
Date: Fri, 30 Jan 2015 14:13:22 +0530
Message-ID: <CADGdYn5E9P7cT-bndL4u9g9XRO=BvE5hb1+TEF0mkwkWOmK1VA@mail.gmail.com>
References: <1422555176-13054-1-git-send-email-k.wrona@samsung.com>
	<1422555176-13054-2-git-send-email-k.wrona@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422555176-13054-2-git-send-email-k.wrona-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Karol Wrona <k.wrona-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Karol Wrona <wrona.vy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Karol,

I guess this patch series is not complete and use case implementation
will be more helpful for clarity. Also I can think of another way in
which this complete implementation can be done with pd name as
something "pd-virt". This pd can be handled differently inside the
platform specific exynos power off/on function.

Regards,
Amit D

On Thu, Jan 29, 2015 at 11:42 PM, Karol Wrona <k.wrona-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> There are the power domains which are turned off or put to retention only during
> suspend or special processor states.  In such case there is a need to register
> some devices which belong to such domain that PM core could know the state of
> such devices and decide which power mode should be chosen i.e. the domain can
> not be put to retention if some devices are active.  Virtual power domain has
> empty power_on/off callbacks as there is no need to gate anything.
>
> Signed-off-by: Karol Wrona <k.wrona-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/base/power/Makefile          |    3 +-
>  drivers/base/power/pm_domains_virt.c |   54 ++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/power/pm_domains_virt.c
>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 1cb8544..360a0e2 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -2,7 +2,8 @@ obj-$(CONFIG_PM)        += sysfs.o generic_ops.o common.o qos.o runtime.o
>  obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o
>  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
>  obj-$(CONFIG_PM_OPP)   += opp.o
> -obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=  domain.o domain_governor.o
> +obj-$(CONFIG_PM_GENERIC_DOMAINS)       += domain.o domain_governor.o \
> +                                          pm_domains_virt.o
>  obj-$(CONFIG_HAVE_CLK) += clock_ops.o
>
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> diff --git a/drivers/base/power/pm_domains_virt.c b/drivers/base/power/pm_domains_virt.c
> new file mode 100644
> index 0000000..bd4d6b6
> --- /dev/null
> +++ b/drivers/base/power/pm_domains_virt.c
> @@ -0,0 +1,54 @@
> +/*
> + *  Copyright (C) 2015, Samsung Electronics Co. Ltd. All Rights Reserved.
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/pm_domain.h>
> +#include <linux/slab.h>
> +
> +static int pd_power_off(struct generic_pm_domain *domain)
> +{
> +       return 0;
> +}
> +
> +static int pd_power_on(struct generic_pm_domain *domain)
> +{
> +       return 0;
> +}
> +
> +int __init virt_pm_domains_init(void)
> +{
> +       struct device_node *np;
> +
> +       for_each_compatible_node(np, NULL, "linux,virtual-pm-domains") {
> +               struct generic_pm_domain *pd;
> +
> +               pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +               if (!pd)
> +                       return -ENOMEM;
> +
> +               pd->power_off = pd_power_off;
> +               pd->power_on = pd_power_on;
> +               pd->name = kstrdup(np->name, GFP_KERNEL);
> +               if (!pd->name)
> +                       return -ENOMEM;
> +
> +               pm_genpd_init(pd, NULL, false);
> +               of_genpd_add_provider_simple(np, pd);
> +       }
> +
> +       return 0;
> +}
> +arch_initcall(virt_pm_domains_init);
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
