From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 17/18] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Date: Wed, 9 Aug 2017 09:48:40 +0530
Message-ID: <20170809041840.GH28857@vireshk-i7>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-18-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36779 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbdHIESp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 00:18:45 -0400
Received: by mail-pf0-f171.google.com with SMTP id c28so22806671pfe.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2017 21:18:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1501857104-11279-18-git-send-email-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Alexey Klimov <alexey.klimov@arm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On 04-08-17, 15:31, Sudeep Holla wrote:

I don't think its the Microsoft exchange server which screwed up tabs and
spaces, but you.

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 2011fec2d6ad..c34633855bc7 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -215,6 +215,17 @@ config ARM_SA1100_CPUFREQ
>  config ARM_SA1110_CPUFREQ
>  	bool
>  
> +config ARM_SCMI_CPUFREQ
> +        tristate "SCMI based CPUfreq driver"

You have used spaces here instead of tab and at multiple other places, can you
please fix them all ?

> +	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	select PM_OPP
> +        help
> +	  This adds the CPUfreq driver support for ARM platforms using SCMI
> +	  protocol for CPU power management.
> +
> +	  This driver uses SCMI Message Protocol driver to interact with the
> +	  firmware providing the CPU DVFS functionality.
> +
>  config ARM_SCPI_CPUFREQ
>          tristate "SCPI based CPUfreq driver"
>  	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index ab3a42cd29ef..4810b45568d3 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -72,6 +72,7 @@ obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
>  obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
>  obj-$(CONFIG_ARM_SA1100_CPUFREQ)	+= sa1100-cpufreq.o
>  obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
> +obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
>  obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
>  obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
>  obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> new file mode 100644
> index 000000000000..034359cafea5
> --- /dev/null
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -0,0 +1,268 @@
> +/*
> + * System Control and Power Interface (SCMI) based CPUFreq Interface driver
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + * Sudeep Holla <sudeep.holla@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_cooling.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/types.h>
> +
> +struct scmi_data {
> +	int domain_id;
> +	struct device *cpu_dev;
> +	struct thermal_cooling_device *cdev;
> +	const struct scmi_handle *handle;

This stores the same handle pointer which is stored in the global variable
below. Right? Why keep a local variable here at all ?

> +};
> +
> +static const struct scmi_handle *handle;
> +
> +unsigned int scmi_cpufreq_get_rate(unsigned int cpu)
> +{
> +	int ret;
> +	unsigned long rate;
> +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> +	struct scmi_data *priv = policy->driver_data;
> +	struct scmi_perf_ops *perf_ops = priv->handle->perf_ops;

Normally people prefer to keep these definitions in decreasing order of their
lengths. i.e. ret and rate would be defined in the last line. Though I would
leave it to you to decide.

> +
> +	ret = perf_ops->freq_get(priv->handle, priv->domain_id, &rate, false);
> +	if (ret)
> +		return CPUFREQ_ENTRY_INVALID;

This is something special which is used only when we are returning indexes and
I am not sure if this will have benefit here. I will rather return 0 here.
That's what other drivers are doing.

> +	return rate / 1000;
> +}
> +
> +static int
> +scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
> +{
> +	struct scmi_data *priv = policy->driver_data;
> +	struct scmi_perf_ops *perf_ops = priv->handle->perf_ops;
> +	u64 freq = policy->freq_table[index].frequency * 1000;
> +
> +	return perf_ops->freq_set(priv->handle, priv->domain_id, freq, false);
> +}

I suppose any CPU can change the frequency of any other CPU here, right? You
must set policy->dvfs_possible_from_any_cpu = true, from ->init() then.

> +static int
> +scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
> +{
> +	int cpu, domain, ret = 0;

You don't need to initialize ret here and I would rather name it tdomain or
something else. ret is a lot used to store error/success values, which isn't
your case.

> +	struct device *tcpu_dev;
> +
> +	domain = handle->perf_ops->device_domain_id(cpu_dev);
> +	if (domain < 0)
> +		return domain;
> +
> +	cpumask_set_cpu(cpu_dev->id, cpumask);

The mask already have this set from the core, you don't need to do it again.

> +	for_each_possible_cpu(cpu) {
> +		if (cpu == cpu_dev->id)
> +			continue;
> +
> +		tcpu_dev = get_cpu_device(cpu);
> +		if (!tcpu_dev)
> +			continue;
> +
> +		ret = handle->perf_ops->device_domain_id(tcpu_dev);
> +		if (ret == domain)
> +			cpumask_set_cpu(cpu, cpumask);
> +	}
> +
> +	return 0;
> +}
> +
> +static int scmi_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	int ret;
> +	unsigned int latency;
> +	struct device *cpu_dev;
> +	struct scmi_data *priv;
> +	struct cpufreq_frequency_table *freq_table;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu%d device\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	ret = handle->perf_ops->add_opps_to_device(cpu_dev);
> +	if (ret) {
> +		dev_warn(cpu_dev, "failed to add opps to the device\n");
> +		return ret;
> +	}
> +
> +	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
> +	if (ret) {
> +		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
> +	if (ret) {
> +		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * But we need OPP table to function so if it is not there let's
> +	 * give platform code chance to provide it for us.
> +	 */

How are we getting the OPPs? DT or non DT ?

> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
> +		ret = -EPROBE_DEFER;
> +		goto out_free_opp;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto out_free_opp;
> +	}
> +
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> +		goto out_free_priv;
> +	}
> +
> +	priv->handle = handle;
> +	priv->cpu_dev = cpu_dev;
> +	priv->domain_id = handle->perf_ops->device_domain_id(cpu_dev);
> +
> +	policy->driver_data = priv;
> +
> +	ret = cpufreq_table_validate_and_show(policy, freq_table);
> +	if (ret) {
> +		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
> +			ret);
> +		goto out_free_cpufreq_table;
> +	}
> +
> +	latency = handle->perf_ops->get_transition_latency(cpu_dev);
> +	if (!latency)
> +		latency = CPUFREQ_ETERNAL;
> +
> +	policy->cpuinfo.transition_latency = latency;
> +
> +	return 0;
> +
> +out_free_cpufreq_table:
> +	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
> +out_free_priv:
> +	kfree(priv);
> +out_free_opp:
> +	dev_pm_opp_cpumask_remove_table(policy->cpus);
> +
> +	return ret;
> +}
> +
> +static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	struct scmi_data *priv = policy->driver_data;
> +
> +	cpufreq_cooling_unregister(priv->cdev);
> +	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
> +	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
> +	kfree(priv);

I would rather swap the above two lines to keep the same order as in probe.
Though nothing would fail with the current code as well.

> +
> +	return 0;
> +}
> +
> +static void scmi_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct scmi_data *priv = policy->driver_data;
> +	struct device_node *np = of_node_get(priv->cpu_dev->of_node);
> +
> +	if (WARN_ON(!np))
> +		return;
> +
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		u32 pcoeff = 0;
> +
> +		of_property_read_u32(np, "dynamic-power-coefficient",
> +				     &pcoeff);
> +
> +		priv->cdev = of_cpufreq_power_cooling_register(np, policy,
> +							       pcoeff, NULL);
> +		if (IS_ERR(priv->cdev)) {
> +			dev_err(priv->cpu_dev,
> +				"running cpufreq without cooling device: %ld\n",
> +				PTR_ERR(priv->cdev));
> +
> +			priv->cdev = NULL;
> +		}
> +	}
> +
> +	of_node_put(np);
> +}
> +
> +static struct cpufreq_driver scmi_cpufreq_driver = {
> +	.name			= "scmi",
> +	.flags			= CPUFREQ_STICKY |
> +					CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.verify			= cpufreq_generic_frequency_table_verify,
> +	.attr			= cpufreq_generic_attr,
> +	.target_index		= scmi_cpufreq_set_target,
> +	.get			= scmi_cpufreq_get_rate,
> +	.init			= scmi_cpufreq_init,
> +	.exit			= scmi_cpufreq_exit,
> +	.ready			= scmi_cpufreq_ready,
> +};

Above block has lots of space/tab issues. Can you please use tabs before "="
instead?

> +static int scmi_cpufreq_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	handle = devm_scmi_handle_get(&pdev->dev);

What code is creating this pdev ?

> +
> +	if (IS_ERR_OR_NULL(handle) || !handle->perf_ops)
> +		return -EPROBE_DEFER;
> +
> +	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s: registering cpufreq failed, err: %d\n",
> +			__func__, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static int scmi_cpufreq_remove(struct platform_device *pdev)
> +{
> +	cpufreq_unregister_driver(&scmi_cpufreq_driver);
> +	return 0;
> +}
> +
> +static struct platform_driver scmi_cpufreq_platdrv = {
> +	.driver = {
> +		.name	= "scmi-cpufreq",
> +	},
> +	.probe		= scmi_cpufreq_probe,
> +	.remove		= scmi_cpufreq_remove,
> +};
> +module_platform_driver(scmi_cpufreq_platdrv);
> +
> +MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
> +MODULE_DESCRIPTION("ARM SCMI CPUFreq interface driver");
> +MODULE_LICENSE("GPL v2");

-- 
viresh
