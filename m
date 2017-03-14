From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 4/9] PM / cpu_domains: Setup PM domains for CPUs/clusters
Date: Tue, 14 Mar 2017 10:24:06 +0100
Message-ID: <CAPDyKFp2v+YGiqAERQF_LZfgyT8fp+9bix_2DF=n+Bffo53pPw@mail.gmail.com>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org> <1488573695-106680-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:34878 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdCNJYI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 05:24:08 -0400
Received: by mail-ua0-f182.google.com with SMTP id q7so150430984uaf.2
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2017 02:24:07 -0700 (PDT)
In-Reply-To: <1488573695-106680-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

On 3 March 2017 at 21:41, Lina Iyer <lina.iyer@linaro.org> wrote:
> Define and add Generic PM domains (genpd) for CPU clusters. Many new
> SoCs group CPUs as clusters. Clusters share common resources like power
> rails, caches, VFP, Coresight etc. When all CPUs in the cluster are
> idle, these shared resources may also be put in their idle state.
>
> CPUs may be associated with their domain providers. The domains in
> turn may be associated with their providers. This is clean way to model
> the cluster hierarchy like that of ARM's big.little architecture.

Perhaps mentions this needs representation in DT.

>
> Platform drivers may initialize generic PM domains and setup the CPU PM
> domains for the genpd and attach CPUs to the domain. In the following
> patches, the CPUs are hooked up to runtime PM framework which helps
> power down the domain, when all the CPUs in the domain are idle.

I think you could elaborate a bit more on the new APIs, as to provide
a better overview of what you add in this change.

>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Suggested-by: Kevin Hilman <khilman@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/Makefile      |   2 +-
>  drivers/base/power/cpu_domains.c | 192 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpu_domains.h      |  48 ++++++++++
>  3 files changed, 241 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/power/cpu_domains.c
>  create mode 100644 include/linux/cpu_domains.h

A couple of new files.

I assume Rafael appreciate some help to maintain this, so we should
update the MAINTAINERS as well. Feel free to add my name in there as
well, if you think it makes sense.

>
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 5998c53..ee383f1 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -2,7 +2,7 @@ obj-$(CONFIG_PM)        += sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
>  obj-$(CONFIG_PM_SLEEP) += main.o wakeup.o
>  obj-$(CONFIG_PM_TRACE_RTC)     += trace.o
>  obj-$(CONFIG_PM_OPP)   += opp/
> -obj-$(CONFIG_PM_GENERIC_DOMAINS)       +=  domain.o domain_governor.o
> +obj-$(CONFIG_PM_GENERIC_DOMAINS)       += domain.o domain_governor.o cpu_domains.o
>  obj-$(CONFIG_HAVE_CLK) += clock_ops.o
>
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> diff --git a/drivers/base/power/cpu_domains.c b/drivers/base/power/cpu_domains.c
> new file mode 100644
> index 0000000..04891dc
> --- /dev/null
> +++ b/drivers/base/power/cpu_domains.c
> @@ -0,0 +1,192 @@
> +/*
> + * drivers/base/power/cpu_domains.c - Helper functions to create CPU PM domains.
> + *
> + * Copyright (C) 2016 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_domains.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/pm_domain.h>
> +#include <linux/rculist.h>
> +#include <linux/rcupdate.h>
> +#include <linux/slab.h>
> +
> +#define CPU_PD_NAME_MAX 36
> +
> +struct cpu_pm_domain {
> +       struct list_head link;
> +       struct cpu_pd_ops ops;
> +       struct generic_pm_domain *genpd;
> +       struct cpu_pm_domain *parent;
> +       cpumask_var_t cpus;
> +};
> +
> +/* List of CPU PM domains we care about */
> +static LIST_HEAD(of_cpu_pd_list);
> +static DEFINE_MUTEX(cpu_pd_list_lock);
> +
> +static inline struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
> +{
> +       struct cpu_pm_domain *pd;
> +       struct cpu_pm_domain *res = NULL;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(pd, &of_cpu_pd_list, link)
> +               if (pd->genpd == d) {
> +                       res = pd;
> +                       break;
> +               }
> +       rcu_read_unlock();
> +
> +       return res;
> +}
> +
> +static int cpu_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +       struct cpu_pm_domain *pd = to_cpu_pd(genpd);

I don't get why you need to walk a list of cpu_pm_domain's to find the
correct handle?

Couldn't you just do:

pd = container_of(genpd, struct cpu_pm_domain, pd);

> +
> +       return pd->ops.power_on ? pd->ops.power_on() : 0;
> +}
> +
> +static int cpu_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +       struct cpu_pm_domain *pd = to_cpu_pd(genpd);

Ditto.

> +
> +       return pd->ops.power_off ? pd->ops.power_off(genpd->state_idx,
> +                                       genpd->states[genpd->state_idx].param,
> +                                       pd->cpus) : 0;
> +}
> +
> +/**
> + * cpu_pd_attach_domain:  Attach a child CPU PM to its parent
> + *
> + * @parent: The parent generic PM domain
> + * @child: The child generic PM domain

The genpd terminology are rather "masters", "subdomains" and sometimes
"slaves". Let's try to stick to that to avoid confusion. Please try to
replace this for the entire file, as I think I have seen some more
places.

> + *
> + * Generally, the child PM domain is the one to which CPUs are attached.
> + */
> +int cpu_pd_attach_domain(struct generic_pm_domain *parent,
> +                               struct generic_pm_domain *child)

I think the name of this function is a bit confusing. We "attach"
devices to their PM domains. But for PM domains, we usually use
add/remove instead.

Perhaps rename this function to cpu_pd_add_subdomain()?

> +{
> +       struct cpu_pm_domain *cpu_pd, *parent_cpu_pd;
> +       int ret;
> +
> +       ret = pm_genpd_add_subdomain(parent, child);

Perhaps check whether it would make better sense to use
of_genpd_add_subdomain() instead.

> +       if (ret) {
> +               pr_err("%s: Unable to add sub-domain (%s) to %s.\n err=%d",
> +                               __func__, child->name, parent->name, ret);
> +               return ret;
> +       }
> +
> +       cpu_pd = to_cpu_pd(child);
> +       parent_cpu_pd = to_cpu_pd(parent);
> +
> +       if (cpu_pd && parent_cpu_pd)
> +               cpu_pd->parent = parent_cpu_pd;

This seems like duplicating the hierarchy information, which is
already being managed by genpd.

Why do you need this?

> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(cpu_pd_attach_domain);
> +
> +/**
> + * cpu_pd_attach_cpu:  Attach a CPU to its CPU PM domain.
> + *
> + * @genpd: The parent generic PM domain

Parent?

> + * @cpu: The CPU number

Maybe elaborate a bit that this uses a PM domain specifier in DT to be
able to attach the cpu device?

> + */
> +int cpu_pd_attach_cpu(struct generic_pm_domain *genpd, int cpu)
> +{
> +       int ret;
> +       struct device *cpu_dev;
> +       struct cpu_pm_domain *cpu_pd = to_cpu_pd(genpd);
> +
> +       cpu_dev = get_cpu_device(cpu);
> +       if (!cpu_dev) {
> +               pr_warn("%s: Unable to get device for CPU%d\n",
> +                               __func__, cpu);
> +               return -ENODEV;
> +       }
> +
> +       ret = genpd_dev_pm_attach(cpu_dev);

I wonder whether of_genpd_add_device() could be a better match for this case.

> +       if (ret)
> +               dev_warn(cpu_dev,
> +                       "%s: Unable to attach to power-domain: %d\n",
> +                       __func__, ret);
> +       else
> +               dev_dbg(cpu_dev, "Attached to domain\n");
> +
> +       while (!ret && cpu_pd) {
> +               cpumask_set_cpu(cpu, cpu_pd->cpus);
> +               cpu_pd = cpu_pd->parent;
> +       };
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(cpu_pd_attach_cpu);
> +
> +/**
> + * cpu_pd_init: Initialize a CPU PM domain for a genpd
> + *
> + * @genpd: The initialized generic PM domain object.
> + * @ops: The power_on/power_off ops for the domain controller.
> + *
> + * Initialize a CPU PM domain based on a generic PM domain. The platform driver
> + * is expected to setup the genpd object and the states associated with the
> + * generic PM domain, before calling this function.
> + */
> +int cpu_pd_init(struct generic_pm_domain *genpd, const struct cpu_pd_ops *ops)
> +{
> +       int ret = -ENOMEM;
> +       struct cpu_pm_domain *pd;
> +
> +       if (IS_ERR_OR_NULL(genpd))
> +               return -EINVAL;
> +
> +       pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +       if (!pd)
> +               goto fail;
> +
> +       if (!zalloc_cpumask_var(&pd->cpus, GFP_KERNEL))
> +               goto fail;
> +
> +       genpd->power_off = cpu_pd_power_off;
> +       genpd->power_on = cpu_pd_power_on;
> +       genpd->flags |= GENPD_FLAG_IRQ_SAFE;
> +       pd->genpd = genpd;

Ah, now I get it. This is why you can't use the container_of() thing,
but instead need to walk the cpu_pd_list at some places.

Perhaps you can fix this by adding a pair of cpu_pd_alloc|free()
functions, which deals with the allocation, including what is needed
for client. A *void pointer can be added in the cpu_pm_domain struct
to allow the client to assign private data. Do you think that would
work?

Also, perhaps that removes the need for the cpu_pd_list?

> +       if (ops) {
> +               pd->ops.power_on = ops->power_on;
> +               pd->ops.power_off = ops->power_off;
> +       }
> +
> +       INIT_LIST_HEAD_RCU(&pd->link);
> +       mutex_lock(&cpu_pd_list_lock);
> +       list_add_rcu(&pd->link, &of_cpu_pd_list);
> +       mutex_unlock(&cpu_pd_list_lock);
> +
> +       ret = pm_genpd_init(genpd, &simple_qos_governor, false);
> +       if (ret) {
> +               pr_err("Unable to initialize domain %s\n", genpd->name);
> +               goto fail;
> +       }
> +
> +       pr_debug("adding %s as CPU PM domain\n", pd->genpd->name);
> +
> +       return 0;
> +fail:
> +       kfree(genpd->name);
> +       kfree(genpd);
> +       if (pd)
> +               kfree(pd->cpus);
> +       kfree(pd);
> +       return ret;
> +}
> +EXPORT_SYMBOL(cpu_pd_init);
> diff --git a/include/linux/cpu_domains.h b/include/linux/cpu_domains.h
> new file mode 100644
> index 0000000..7e71291
> --- /dev/null
> +++ b/include/linux/cpu_domains.h
> @@ -0,0 +1,48 @@
> +/*
> + * include/linux/cpu_domains.h
> + *
> + * Copyright (C) 2016 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __CPU_DOMAINS_H__
> +#define __CPU_DOMAINS_H__
> +
> +#include <linux/types.h>
> +
> +struct generic_pm_domain;
> +struct cpumask;
> +
> +struct cpu_pd_ops {
> +       int (*power_off)(u32 state_idx, u32 param, const struct cpumask *mask);
> +       int (*power_on)(void);
> +};
> +
> +#ifdef CONFIG_PM_GENERIC_DOMAINS
> +
> +int cpu_pd_init(struct generic_pm_domain *genpd, const struct cpu_pd_ops *ops);
> +
> +int cpu_pd_attach_domain(struct generic_pm_domain *parent,
> +                               struct generic_pm_domain *child);
> +
> +int cpu_pd_attach_cpu(struct generic_pm_domain *genpd, int cpu);
> +
> +#else
> +
> +static inline int cpu_pd_init(struct generic_pm_domain *genpd,
> +                               const struct cpu_pd_ops *ops)
> +{ return ERR_PTR(-ENODEV); }
> +
> +static inline int cpu_pd_attach_domain(struct generic_pm_domain *parent,
> +                               struct generic_pm_domain *child)
> +{ return -ENODEV; }
> +
> +static inline int cpu_pd_attach_cpu(struct generic_pm_domain *genpd, int cpu)
> +{ return -ENODEV; }
> +
> +#endif /* CONFIG_PM_GENERIC_DOMAINS */
> +
> +#endif /* __CPU_DOMAINS_H__ */
> --
> 2.7.4
>

Kind regards
Uffe
