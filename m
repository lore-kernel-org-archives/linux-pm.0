From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for
 cpu domain
Date: Sun, 07 Jun 2015 18:42:55 +0900
Message-ID: <5574121F.2000806@samsung.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org> <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36126 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbFGJnE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2015 05:43:04 -0400
Received: by pdjm12 with SMTP id m12so80619092pdj.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2015 02:43:02 -0700 (PDT)
In-Reply-To: <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: mathieu.poirier@linaro.org, linux-pm@vger.kernel.org, galak@codeaurora.org, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

W dniu 05.06.2015 o 07:29, Lina Iyer pisze:
> Generally cpus are grouped under a power domain in a SoC. When all cpus
> in the domain are in their power off state,

What do you exactly mean here by "CPU in power off state"? How does it
map to kernel understanding of CPU device (hotplug? cpuidle?)?

> the cpu domain can also be
> powered off. Genpd provides the framework for defining cpus as devices
> that are part of a cpu domain.

The problem which is solved looks to me like the same problem which
coupled cpuidle tried to solve: a certain deep sleep mode (e.g. power
off) can be entered when whole cluster is idle or other CPUs in cluster
are powered off completely.

It seems a little like duplicating the effort around coupled cpuidle.

Best regards,
Krzysztof

> 
> Introduce support for defining and adding a generic power domain for the
> cpus based on the DT specification of power domain providers and
> consumers.  SoC's that have the cpu domain defined in their DT, can
> setup a genpd with a name and the power_on/power_off callbacks. Calling
> pm_cpu_domain_init() will register the genpd and attach the cpus for
> this domain with the genpd.
> 
> CPU_PM notifications for are used to pm_runtime_get_sync() and
> pm_runtime_put_sync() for each cpu.  When all cpus are powered off, the
> last cpu going down would call the genpd->power_off(). Correspondingly,
> the first cpu up would call the genpd->power_on() callback before
> resuming from idle.
> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/Makefile     |   1 +
>  drivers/base/power/cpu_domain.c | 187 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h       |  12 +++
>  kernel/power/Kconfig            |  12 +++
>  4 files changed, 212 insertions(+)
>  create mode 100644 drivers/base/power/cpu_domain.c
> 
> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
> index 1cb8544..debfc74 100644
> --- a/drivers/base/power/Makefile
> +++ b/drivers/base/power/Makefile
> @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>  obj-$(CONFIG_PM_OPP)	+= opp.o
>  obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
>  obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
> +obj-$(CONFIG_PM_CPU_DOMAIN)	+= cpu_domain.o
>  
>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
> diff --git a/drivers/base/power/cpu_domain.c b/drivers/base/power/cpu_domain.c
> new file mode 100644
> index 0000000..ee90094
> --- /dev/null
> +++ b/drivers/base/power/cpu_domain.c
> @@ -0,0 +1,187 @@
> +/*
> + * Generic CPU domain runtime power on/off support
> + *
> + * Copyright (C) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +
> +static struct cpumask cpus_handled;
> +
> +static void do_cpu(void *unused)
> +{
> +	int cpu = smp_processor_id();
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	pm_runtime_get_sync(dev);
> +}
> +
> +static int cpuidle_genpd_device_init(int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	/*
> +	 * CPU device have to be irq safe for use with cpuidle, which runs
> +	 * with irqs disabled.
> +	 */
> +	pm_runtime_irq_safe(dev);
> +	pm_runtime_enable(dev);
> +
> +	genpd_dev_pm_attach(dev);
> +
> +	/*
> +	 * Execute the below on 'that' cpu to ensure that the reference
> +	 * counting is correct. Its possible that while this code is
> +	 * executed, the cpu may be in idle but we may incorrectly
> +	 * increment the usage. By executing the do_cpu on 'that' cpu,
> +	 * we can ensure that the cpu and the usage count are matched.
> +	 */
> +	return smp_call_function_single(cpu, do_cpu, NULL, true);
> +}
> +
> +static int cpu_state_notifier(struct notifier_block *n,
> +			unsigned long action, void *hcpu)
> +{
> +	int cpu = smp_processor_id();
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	if (!cpumask_test_cpu(cpu, &cpus_handled))
> +		return NOTIFY_DONE;
> +
> +	switch (action) {
> +	case CPU_PM_ENTER:
> +		pm_runtime_put_sync(dev);
> +		break;
> +
> +	case CPU_PM_ENTER_FAILED:
> +	case CPU_PM_EXIT:
> +		pm_runtime_get_sync(dev);
> +		break;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int cpu_online_notifier(struct notifier_block *n,
> +			unsigned long action, void *hcpu)
> +{
> +	int cpu = (unsigned long)hcpu;
> +	struct device *dev = get_cpu_device(cpu);
> +
> +	if (!cpumask_test_cpu(cpu, &cpus_handled))
> +		return NOTIFY_DONE;
> +
> +	switch (action) {
> +	case CPU_STARTING:
> +	case CPU_STARTING_FROZEN:
> +		/*
> +		 * Attach the cpu to its domain if the cpu is coming up
> +		 * for the first time.
> +		 * Called from the cpu that is coming up.
> +		 */
> +		if (!genpd_dev_pm_attach(dev))
> +			do_cpu(NULL);
> +		break;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block hotplug_notifier = {
> +	.notifier_call = cpu_online_notifier,
> +};
> +
> +static struct notifier_block cpu_pm_notifier = {
> +	.notifier_call = cpu_state_notifier,
> +};
> +
> +static struct generic_pm_domain *get_cpu_domain(int cpu)
> +{
> +	struct device *dev = get_cpu_device(cpu);
> +	struct of_phandle_args pd_args;
> +	int ret;
> +
> +	/* Make sure we are a domain consumer */
> +	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
> +				"#power-domain-cells", 0, &pd_args);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* Attach cpus only for this domain */
> +	return of_genpd_get_from_provider(&pd_args);
> +}
> +
> +int pm_cpu_domain_init(struct generic_pm_domain *genpd, struct device_node *dn)
> +{
> +	int cpu;
> +	int ret;
> +	cpumask_var_t tmpmask;
> +	struct generic_pm_domain *cpupd;
> +
> +	if (!genpd || !dn)
> +		return -EINVAL;
> +
> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	/* CPU genpds have to operate in IRQ safe mode */
> +	genpd->flags |= GENPD_FLAG_IRQ_SAFE;
> +
> +	pm_genpd_init(genpd, NULL, false);
> +	ret = of_genpd_add_provider_simple(dn, genpd);
> +	if (ret)
> +		return ret;
> +
> +	/* Only add those cpus to whom we are the domain provider */
> +	for_each_online_cpu(cpu) {
> +		cpupd = get_cpu_domain(cpu);
> +
> +		if (IS_ERR(cpupd))
> +			continue;
> +
> +		if (genpd == cpupd) {
> +			cpuidle_genpd_device_init(cpu);
> +			cpumask_set_cpu(cpu, tmpmask);
> +		}
> +	}
> +
> +	if (cpumask_empty(tmpmask))
> +		goto done;
> +
> +	/*
> +	 * Not all cpus may be online at this point. Use the hotplug
> +	 * notifier to be notified of when the cpu comes online, then
> +	 * attach it to the domain.
> +	 *
> +	 * Register hotplug and cpu_pm notification once for all
> +	 * domains.
> +	 */
> +	if (cpumask_empty(&cpus_handled)) {
> +		cpu_pm_register_notifier(&cpu_pm_notifier);
> +		register_cpu_notifier(&hotplug_notifier);
> +	}
> +
> +	cpumask_copy(&cpus_handled, tmpmask);
> +
> +done:
> +	free_cpumask_var(tmpmask);
> +	return 0;
> +}
> +EXPORT_SYMBOL(pm_cpu_domain_init);
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index dc7cb53..fc97ad8 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -280,6 +280,7 @@ struct generic_pm_domain *__of_genpd_xlate_onecell(
>  					void *data);
>  
>  int genpd_dev_pm_attach(struct device *dev);
> +
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int __of_genpd_add_provider(struct device_node *np,
>  					genpd_xlate_t xlate, void *data)
> @@ -325,4 +326,15 @@ static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
>  static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
>  #endif
>  
> +#ifdef CONFIG_PM_CPU_DOMAIN
> +extern int pm_cpu_domain_init(struct generic_pm_domain *genpd,
> +			struct device_node *dn);
> +#else
> +static inline int pm_cpu_domain_init(struct generic_pm_domain *genpd,
> +			struct device_node *dn)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  #endif /* _LINUX_PM_DOMAIN_H */
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 7e01f78..55d49f6 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -301,3 +301,15 @@ config PM_GENERIC_DOMAINS_OF
>  
>  config CPU_PM
>  	bool
> +
> +config PM_CPU_DOMAIN
> +	def_bool y
> +	depends on PM_GENERIC_DOMAINS_OF && CPU_PM
> +	help
> +	  When cpuidle powers of the cpus in a domain, the domain can also be
> +	  powered off.
> +	  This config option allow for cpus to be registered with the domain
> +	  provider specified in the DT and when the cpu is powered off, calls
> +	  the runtime PM methods to do the reference counting. The last cpu
> +	  going down powers the domain off as well.
> +
> 

