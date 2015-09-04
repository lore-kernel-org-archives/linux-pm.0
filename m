From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 4/7] PM / Domains: Introduce PM domains for
 CPUs/clusters
Date: Thu, 3 Sep 2015 20:54:22 -0700
Message-ID: <20150904035422.GK15099@codeaurora.org>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:38554 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757245AbbIDDyY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 23:54:24 -0400
Content-Disposition: inline
In-Reply-To: <1441310314-8857-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 09/03, Lina Iyer wrote:
> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
> new file mode 100644
> index 0000000..5f30025
> --- /dev/null
> +++ b/drivers/base/power/cpu-pd.c
> @@ -0,0 +1,206 @@
> +/*
> + * CPU Generic PM Domain.
> + *
> + * Copyright (C) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#define DEBUG
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>

Did you mean export.h here?

> +#include <linux/cpu_pm.h>
> +#include <linux/cpu-pd.h>
> +#include <linux/device.h>
> +#include <linux/of_platform.h>

Is this include used?

> +#include <linux/platform_device.h>

And this one?

> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>

Add list.h for LIST_HEAD usage here?

> +
> +#define NAME_MAX 36
> +
> +/* List of CPU PM domains we care about */
> +static LIST_HEAD(of_cpu_pd_list);
> +
> +static inline
> +struct cpu_pm_domain *to_cpu_pd(struct generic_pm_domain *d)
> +{
> +	struct cpu_pm_domain *pd;
> +
> +	list_for_each_entry(pd, &of_cpu_pd_list, link) {
> +		if (pd->genpd == d)
> +			return pd;
> +	}

Braces are unnecessary.

> +
> +	return NULL;
> +}
> +
> +static int cpu_pd_power_off(struct generic_pm_domain *genpd)
> +{
> +	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
> +
> +	if (pd->plat_ops.power_off)
> +		pd->plat_ops.power_off(genpd);
> +
> +	/*
> +	 * Notify CPU PM domain power down
> +	 * TODO: Call the notificated directly from here.
> +	 */
> +	cpu_cluster_pm_enter();
> +
> +	return 0;
> +}
> +
> +static int cpu_pd_power_on(struct generic_pm_domain *genpd)
> +{
> +	struct cpu_pm_domain *pd = to_cpu_pd(genpd);
> +
> +	if (pd->plat_ops.power_on)
> +		pd->plat_ops.power_on(genpd);
> +
> +	/* Notify CPU PM domain power up */
> +	cpu_cluster_pm_exit();

Perhaps we should swap these two so they're symmetric? 

> +
> +	return 0;
> +}
> +
> +static void run_cpu(void *unused)
> +{
> +	struct device *cpu_dev = get_cpu_device(smp_processor_id());
> +
> +	/* We are running, increment the usage count */
> +	pm_runtime_get_noresume(cpu_dev);
> +}
> +
> +static int of_pm_domain_attach_cpus(void)
> +{
> +	int cpuid, ret;
> +
> +	/* Find any CPU nodes with a phandle to this power domain */
> +	for_each_possible_cpu(cpuid) {
> +		struct device *cpu_dev;
> +
> +		cpu_dev = get_cpu_device(cpuid);
> +		if (!cpu_dev) {
> +			pr_warn("%s: Unable to get device for CPU%d\n",
> +					__func__, cpuid);
> +			return -ENODEV;
> +		}
> +
> +		if (cpu_online(cpuid)) {
> +			pm_runtime_set_active(cpu_dev);
> +			/*
> +			 * Execute the below on that 'cpu' to ensure that the
> +			 * reference counting is correct. Its possible that

s/Its/It's/

> +			 * while this code is executing, the 'cpu' may be
> +			 * powered down, but we may incorrectly increment the
> +			 * usage. By executing the get_cpu on the 'cpu',
> +			 * we can ensure that the 'cpu' and its usage count are
> +			 * matched.
> +			 */
> +			smp_call_function_single(cpuid, run_cpu, NULL, true);
> +		} else {
> +			pm_runtime_set_suspended(cpu_dev);
> +		}
> +		pm_runtime_enable(cpu_dev);
> +
> +		/*
> +		 * We attempt to attach the device to genpd again. We would
> +		 * have failed in our earlier attempt to attach to the domain
> +		 * provider as the CPU device would not have been IRQ safe,
> +		 * while the domain is defined as IRQ safe. IRQ safe domains
> +		 * can only have IRQ safe devices.
> +		 */
> +		ret = genpd_dev_pm_attach(cpu_dev);
> +		if (ret) {
> +			dev_warn(cpu_dev,
> +				"%s: Unable to attach to power-domain: %d\n",
> +				__func__, ret);
> +			pm_runtime_disable(cpu_dev);
> +		} else
> +			dev_dbg(cpu_dev, "Attached to PM domain\n");
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * of_register_cpu_pm_domain() - Register the CPU PM domain with GenPD
> + * framework
> + * @dn: PM domain provider device node
> + * @pd: The CPU PM domain that has been initialized
> + *
> + * This can be used by the platform code to setup the ->genpd of the @pd
> + * The platform can also set up its callbacks in the ->plat_ops.
> + */
> +int of_register_cpu_pm_domain(struct device_node *dn,
> +		struct cpu_pm_domain *pd)
> +{
> +
> +	if (!pd || !pd->genpd)
> +		return -EINVAL;
> +
> +	/*
> +	 * The platform should not set up the genpd callbacks.
> +	 * They should setup the pd->plat_ops instead.
> +	 */
> +	WARN_ON(pd->genpd->power_off);
> +	WARN_ON(pd->genpd->power_on);
> +
> +	pd->genpd->power_off = cpu_pd_power_off;
> +	pd->genpd->power_on = cpu_pd_power_on;
> +	pd->genpd->flags |= GENPD_FLAG_IRQ_SAFE;
> +
> +	INIT_LIST_HEAD(&pd->link);
> +	list_add(&pd->link, &of_cpu_pd_list);
> +	pd->dn = dn;
> +
> +	/* Register the CPU genpd */
> +	pr_debug("adding %s as generic power domain.\n", pd->genpd->name);

Maybe it should say CPU domain?

> +	pm_genpd_init(pd->genpd, &simple_qos_governor, false);
> +	of_genpd_add_provider_simple(dn, pd->genpd);
> +
> +	/* Attach the CPUs to the CPU PM domain */
> +	return of_pm_domain_attach_cpus();

Should we remove the provider on failure?

> +}
> +EXPORT_SYMBOL(of_register_cpu_pm_domain);
> +
> +/**
> + * of_init_cpu_pm_domain() - Initialize a CPU PM domain using the CPU pd
> + * provided
> + * @dn: PM domain provider device node
> + * @ops: CPU PM domain platform specific ops for callback
> + *
> + * This is a single step initialize the CPU PM domain with defaults,
> + * also register the genpd and attach CPUs to the genpd.
> + */
> +int of_init_cpu_pm_domain(struct device_node *dn, struct cpu_pm_ops *ops)
> +{
> +	struct cpu_pm_domain *pd;
> +
> +	if (!of_device_is_available(dn))
> +		return -ENODEV;
> +
> +	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		return -ENOMEM;
> +
> +	pd->genpd = kzalloc(sizeof(*(pd->genpd)), GFP_KERNEL);
> +	if (!pd->genpd) {
> +		kfree(pd);
> +		return -ENOMEM;
> +	}
> +
> +	if (ops) {
> +		pd->plat_ops.power_off = ops->power_off;
> +		pd->plat_ops.power_on = ops->power_on;
> +	}
> +
> +	pd->genpd->name = kstrndup(dn->full_name, NAME_MAX, GFP_KERNEL);

This could fail. We should check for a failure.

> +
> +	return of_register_cpu_pm_domain(dn, pd);

Did we just leak memory if this fails?

> +}
> +EXPORT_SYMBOL(of_init_cpu_pm_domain);
> diff --git a/include/linux/cpu-pd.h b/include/linux/cpu-pd.h
> new file mode 100644
> index 0000000..9ae6f5b
> --- /dev/null
> +++ b/include/linux/cpu-pd.h
> @@ -0,0 +1,35 @@
> +/*
> + * include/linux/cpu-pd.h
> + *
> + * Copyright (C) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __CPU_PD_H__
> +#define __CPU_PD_H__
> +
> +#include <linux/list.h>
> +#include <linux/of.h>
> +#include <linux/pm_domain.h>

These last two includes could be dropped and forward declare
generic_pm_domain and device_node instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
