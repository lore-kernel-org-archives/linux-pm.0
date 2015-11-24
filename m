From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH RFC 10/27] drivers: power: Introduce PM domains for
 CPUs/clusters
Date: Tue, 24 Nov 2015 12:52:46 -0800
Message-ID: <20151124205246.GC25963@codeaurora.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-11-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56696 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbbKXUwt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 15:52:49 -0500
Content-Disposition: inline
In-Reply-To: <1447799871-56374-11-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Daniel Lezcano <daniel.lezcano@linaro.org>

On 11/17, Lina Iyer wrote:
> diff --git a/Documentation/arm/cpu-domains.txt b/Documentation/arm/cpu-domains.txt
> new file mode 100644
> index 0000000..ef5f215
> --- /dev/null
> +++ b/Documentation/arm/cpu-domains.txt
> @@ -0,0 +1,52 @@
> +CPU Clusters and PM domain
> +
> +Newer CPUs are grouped in a SoC as clusters. A cluster in addition to the
> +CPUs may have caches, GIC, VFP and architecture specific power controller to
> +power the cluster. A cluster may also be nested in another cluster, the
> +hierarchy of which is depicted in the device tree. CPUIdle frameworks enables

s/frameworks/framework/?

s/depicted/described/? Hopefully we aren't putting pictures or
art in DT for this sort of stuff.


> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
> new file mode 100644
> index 0000000..9758b8d
> --- /dev/null
> +++ b/drivers/base/power/cpu-pd.c
> @@ -0,0 +1,231 @@
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
> +#include <linux/export.h>
> +#include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/cpu-pd.h>
> +#include <linux/device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>

Is this used?

> +#include <linux/rculist.h>
> +#include <linux/slab.h>
> +
> +#define CPU_PD_NAME_MAX 36
> +
[...]
> +static int of_pm_domain_attach_cpus(struct device_node *dn)
> +{
> +	int cpuid, ret;
> +
> +	/* Find any CPU nodes with a phandle to this power domain */
> +	for_each_possible_cpu(cpuid) {
> +		struct device *cpu_dev;
> +		struct device_node *cpu_pd;
> +
> +		cpu_dev = get_cpu_device(cpuid);
> +		if (!cpu_dev) {
> +			pr_warn("%s: Unable to get device for CPU%d\n",
> +					__func__, cpuid);
> +			return -ENODEV;
> +		}
> +
> +		/* Only attach CPUs that are part of this domain */
> +		cpu_pd = of_parse_phandle(cpu_dev->of_node, "power-domains", 0);
> +		if (cpu_pd != dn)
> +			continue;
> +
> +		if (cpu_online(cpuid)) {

I guess we don't care if hotplug is running in parallel to this
code?

> +			pm_runtime_set_active(cpu_dev);
> +			/*
> +			 * Execute the below on that 'cpu' to ensure that the
> +			 * reference counting is correct. It's possible that
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
> +
> +		ret = genpd_dev_pm_attach(cpu_dev);
> +		if (ret) {
> +			dev_warn(cpu_dev,
> +				"%s: Unable to attach to power-domain: %d\n",
> +				__func__, ret);
> +		} else {
> +			pm_runtime_enable(cpu_dev);
> +			dev_dbg(cpu_dev, "Attached CPU%d to domain\n", cpuid);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int of_register_cpu_pm_domain(struct device_node *dn,

static?

> +		struct cpu_pm_domain *pd)
> +{
> +	int ret;
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
> +	INIT_LIST_HEAD_RCU(&pd->link);
> +	spin_lock(&cpu_pd_list_lock);
> +	list_add_rcu(&pd->link, &of_cpu_pd_list);
> +	spin_unlock(&cpu_pd_list_lock);
> +	pd->dn = dn;
> +
> +	/* Register the CPU genpd */
> +	pr_debug("adding %s as CPU PM domain.\n", pd->genpd->name);
> +	ret = of_pm_genpd_init(dn, pd->genpd, &simple_qos_governor, false);
> +	if (ret) {
> +		pr_err("Unable to initialize domain %s\n", dn->full_name);
> +		return ret;
> +	}
> +
> +	ret = of_genpd_add_provider_simple(dn, pd->genpd);
> +	if (ret)
> +		pr_warn("Unable to add genpd %s as provider\n",
> +				pd->genpd->name);
> +
> +	/* Attach the CPUs to the CPU PM domain */
> +	ret = of_pm_domain_attach_cpus(dn);
> +	if (ret)
> +		of_genpd_del_provider(dn);
> +
> +	return ret;
> +}
> +
> +/**
> + * of_init_cpu_pm_domain() - Initialize a CPU PM domain using the CPU pd
> + * provided
> + * @dn: PM domain provider device node
> + * @ops: CPU PM domain platform specific ops for callback
> + *
> + * This is a single step initialize the CPU PM domain with defaults,
> + * also register the genpd and attach CPUs to the genpd.

Returns?

> + */
> +struct generic_pm_domain *of_init_cpu_pm_domain(struct device_node *dn,
> +				const struct cpu_pd_ops *ops)
> +{
> +	struct cpu_pm_domain *pd;
> +	int ret;
> +
> +	if (!of_device_is_available(dn))
> +		return ERR_PTR(-ENODEV);
> +
> +	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
> +	if (!pd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pd->genpd = kzalloc(sizeof(*(pd->genpd)), GFP_KERNEL);
> +	if (!pd->genpd) {
> +		kfree(pd);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	pd->genpd->name = kstrndup(dn->full_name, CPU_PD_NAME_MAX, GFP_KERNEL);
> +	if (!pd->genpd->name) {
> +		kfree(pd->genpd);
> +		kfree(pd);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	if (ops) {
> +		pd->plat_ops.power_off = ops->power_off;
> +		pd->plat_ops.power_on = ops->power_on;
> +	}
> +
> +	ret = of_register_cpu_pm_domain(dn, pd);
> +	if (ret) {
> +		kfree(pd->genpd->name);
> +		kfree(pd->genpd);
> +		kfree(pd);
> +		return ERR_PTR(ret);

Maybe we can have a goto error path so that we don't duplicate
these kfree calls a bunch of times.

> +	}
> +
> +	return pd->genpd;
> +}
> +EXPORT_SYMBOL(of_init_cpu_pm_domain);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
