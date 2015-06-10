From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for
 cpu domain
Date: Wed, 10 Jun 2015 10:57:42 -0600
Message-ID: <20150610165742.GB4497@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <5574121F.2000806@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33166 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358AbbFJQ5p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 12:57:45 -0400
Received: by padev16 with SMTP id ev16so38514307pad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2015 09:57:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5574121F.2000806@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, mathieu.poirier@linaro.org, linux-pm@vger.kernel.org, galak@codeaurora.org, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Sun, Jun 07 2015 at 03:43 -0600, Krzysztof Kozlowski wrote:
>W dniu 05.06.2015 o 07:29, Lina Iyer pisze:
>> Generally cpus are grouped under a power domain in a SoC. When all cpus
>> in the domain are in their power off state,
>
>What do you exactly mean here by "CPU in power off state"? How does it
>map to kernel understanding of CPU device (hotplug? cpuidle?)?
>
Both cpuidle and hotplug could end with with core being powered down at
the platform driver or at PSCI (on V8). It does not matter which of
these two frameworks resulted in the cpu being powered off. But, if all
cpus in the domain are powered off, then the domain could be powered off
as well. This is the premise of this change. It is probably easier to
power off the domain when the cores in that domain/cluster have been
hotplugged off. It saves power to turn off the domain at that time, but
more power savings can be achieved if the domain could also be powered
off during cpuidle. Hotplug is not a common occurance, while cpuidle is.

>> the cpu domain can also be
>> powered off. Genpd provides the framework for defining cpus as devices
>> that are part of a cpu domain.
>
>The problem which is solved looks to me like the same problem which
>coupled cpuidle tried to solve: a certain deep sleep mode (e.g. power
>off) can be entered when whole cluster is idle or other CPUs in cluster
>are powered off completely.
>
>It seems a little like duplicating the effort around coupled cpuidle.
>
I see where are you are going with this, but genpd solution is not
exactly a duplicate of the solution.

Couple state is used to put the cpus in a deeper sleep state, which
could also result in powering off the domain. Coupled cpuidle is a
cpuidle mechanism for choosing a deeper sleep mode on certain hardware
that can only enter such a mode when all cpus cooperate.

This patch attempts to describe the backend of a cpu domain. CPUs are
responsible for individual cpuidle states, cpus do enter their
recommended deepest idle state at the time of no activity. A cpu-domain
could be comprised of cpus, and other devices like GIC, busses etc, that
all need to idle before the domain can be powered off. This patch does
not dictate which idle state any those devices should enter, or
coordinate the idle states between devices. But, if cpus, choose to
power down, then this patch recognizes that and reduces the reference
usage count on the domain. Only when all devices in the domain remove
their usage count, will the domain be powered off. 

There are two things this patch provides -

i. A generic way to initialize a genpd specifically for cpus. (The
platform specifies the relation between a cpu and its domain in the DT
and provides the memory for the genpd structure)

ii. On behalf of a platform, we track when the cpus power up and down
and use runtime_get and runtime_put on the genpd.

Unlike coupled cpuidle, individual cpu idle state is not manipulated.
Coupled cpuidle does not care if the domain is powered off, it is used
to allow a certain C-state for the cpu, based on the idleness of other
cpus in that cluster. The focus of the series is powering down the
domain when the devices (cpus included) are powered off. You could see
this patch as a cpu-pm and runtime-pm interface layer.

Hope that helps.

Thanks,
Lina

>
>>
>> Introduce support for defining and adding a generic power domain for the
>> cpus based on the DT specification of power domain providers and
>> consumers.  SoC's that have the cpu domain defined in their DT, can
>> setup a genpd with a name and the power_on/power_off callbacks. Calling
>> pm_cpu_domain_init() will register the genpd and attach the cpus for
>> this domain with the genpd.
>>
>> CPU_PM notifications for are used to pm_runtime_get_sync() and
>> pm_runtime_put_sync() for each cpu.  When all cpus are powered off, the
>> last cpu going down would call the genpd->power_off(). Correspondingly,
>> the first cpu up would call the genpd->power_on() callback before
>> resuming from idle.
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/Makefile     |   1 +
>>  drivers/base/power/cpu_domain.c | 187 ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h       |  12 +++
>>  kernel/power/Kconfig            |  12 +++
>>  4 files changed, 212 insertions(+)
>>  create mode 100644 drivers/base/power/cpu_domain.c
>>
>> diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
>> index 1cb8544..debfc74 100644
>> --- a/drivers/base/power/Makefile
>> +++ b/drivers/base/power/Makefile
>> @@ -4,5 +4,6 @@ obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
>>  obj-$(CONFIG_PM_OPP)	+= opp.o
>>  obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
>>  obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
>> +obj-$(CONFIG_PM_CPU_DOMAIN)	+= cpu_domain.o
>>
>>  ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
>> diff --git a/drivers/base/power/cpu_domain.c b/drivers/base/power/cpu_domain.c
>> new file mode 100644
>> index 0000000..ee90094
>> --- /dev/null
>> +++ b/drivers/base/power/cpu_domain.c
>> @@ -0,0 +1,187 @@
>> +/*
>> + * Generic CPU domain runtime power on/off support
>> + *
>> + * Copyright (C) 2015 Linaro Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/pm_domain.h>
>> +#include <linux/pm_runtime.h>
>> +
>> +static struct cpumask cpus_handled;
>> +
>> +static void do_cpu(void *unused)
>> +{
>> +	int cpu = smp_processor_id();
>> +	struct device *dev = get_cpu_device(cpu);
>> +
>> +	pm_runtime_get_sync(dev);
>> +}
>> +
>> +static int cpuidle_genpd_device_init(int cpu)
>> +{
>> +	struct device *dev = get_cpu_device(cpu);
>> +
>> +	/*
>> +	 * CPU device have to be irq safe for use with cpuidle, which runs
>> +	 * with irqs disabled.
>> +	 */
>> +	pm_runtime_irq_safe(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	genpd_dev_pm_attach(dev);
>> +
>> +	/*
>> +	 * Execute the below on 'that' cpu to ensure that the reference
>> +	 * counting is correct. Its possible that while this code is
>> +	 * executed, the cpu may be in idle but we may incorrectly
>> +	 * increment the usage. By executing the do_cpu on 'that' cpu,
>> +	 * we can ensure that the cpu and the usage count are matched.
>> +	 */
>> +	return smp_call_function_single(cpu, do_cpu, NULL, true);
>> +}
>> +
>> +static int cpu_state_notifier(struct notifier_block *n,
>> +			unsigned long action, void *hcpu)
>> +{
>> +	int cpu = smp_processor_id();
>> +	struct device *dev = get_cpu_device(cpu);
>> +
>> +	if (!cpumask_test_cpu(cpu, &cpus_handled))
>> +		return NOTIFY_DONE;
>> +
>> +	switch (action) {
>> +	case CPU_PM_ENTER:
>> +		pm_runtime_put_sync(dev);
>> +		break;
>> +
>> +	case CPU_PM_ENTER_FAILED:
>> +	case CPU_PM_EXIT:
>> +		pm_runtime_get_sync(dev);
>> +		break;
>> +
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static int cpu_online_notifier(struct notifier_block *n,
>> +			unsigned long action, void *hcpu)
>> +{
>> +	int cpu = (unsigned long)hcpu;
>> +	struct device *dev = get_cpu_device(cpu);
>> +
>> +	if (!cpumask_test_cpu(cpu, &cpus_handled))
>> +		return NOTIFY_DONE;
>> +
>> +	switch (action) {
>> +	case CPU_STARTING:
>> +	case CPU_STARTING_FROZEN:
>> +		/*
>> +		 * Attach the cpu to its domain if the cpu is coming up
>> +		 * for the first time.
>> +		 * Called from the cpu that is coming up.
>> +		 */
>> +		if (!genpd_dev_pm_attach(dev))
>> +			do_cpu(NULL);
>> +		break;
>> +
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block hotplug_notifier = {
>> +	.notifier_call = cpu_online_notifier,
>> +};
>> +
>> +static struct notifier_block cpu_pm_notifier = {
>> +	.notifier_call = cpu_state_notifier,
>> +};
>> +
>> +static struct generic_pm_domain *get_cpu_domain(int cpu)
>> +{
>> +	struct device *dev = get_cpu_device(cpu);
>> +	struct of_phandle_args pd_args;
>> +	int ret;
>> +
>> +	/* Make sure we are a domain consumer */
>> +	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>> +				"#power-domain-cells", 0, &pd_args);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	/* Attach cpus only for this domain */
>> +	return of_genpd_get_from_provider(&pd_args);
>> +}
>> +
>> +int pm_cpu_domain_init(struct generic_pm_domain *genpd, struct device_node *dn)
>> +{
>> +	int cpu;
>> +	int ret;
>> +	cpumask_var_t tmpmask;
>> +	struct generic_pm_domain *cpupd;
>> +
>> +	if (!genpd || !dn)
>> +		return -EINVAL;
>> +
>> +	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
>> +		return -ENOMEM;
>> +
>> +	/* CPU genpds have to operate in IRQ safe mode */
>> +	genpd->flags |= GENPD_FLAG_IRQ_SAFE;
>> +
>> +	pm_genpd_init(genpd, NULL, false);
>> +	ret = of_genpd_add_provider_simple(dn, genpd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Only add those cpus to whom we are the domain provider */
>> +	for_each_online_cpu(cpu) {
>> +		cpupd = get_cpu_domain(cpu);
>> +
>> +		if (IS_ERR(cpupd))
>> +			continue;
>> +
>> +		if (genpd == cpupd) {
>> +			cpuidle_genpd_device_init(cpu);
>> +			cpumask_set_cpu(cpu, tmpmask);
>> +		}
>> +	}
>> +
>> +	if (cpumask_empty(tmpmask))
>> +		goto done;
>> +
>> +	/*
>> +	 * Not all cpus may be online at this point. Use the hotplug
>> +	 * notifier to be notified of when the cpu comes online, then
>> +	 * attach it to the domain.
>> +	 *
>> +	 * Register hotplug and cpu_pm notification once for all
>> +	 * domains.
>> +	 */
>> +	if (cpumask_empty(&cpus_handled)) {
>> +		cpu_pm_register_notifier(&cpu_pm_notifier);
>> +		register_cpu_notifier(&hotplug_notifier);
>> +	}
>> +
>> +	cpumask_copy(&cpus_handled, tmpmask);
>> +
>> +done:
>> +	free_cpumask_var(tmpmask);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(pm_cpu_domain_init);
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index dc7cb53..fc97ad8 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -280,6 +280,7 @@ struct generic_pm_domain *__of_genpd_xlate_onecell(
>>  					void *data);
>>
>>  int genpd_dev_pm_attach(struct device *dev);
>> +
>>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>>  static inline int __of_genpd_add_provider(struct device_node *np,
>>  					genpd_xlate_t xlate, void *data)
>> @@ -325,4 +326,15 @@ static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
>>  static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
>>  #endif
>>
>> +#ifdef CONFIG_PM_CPU_DOMAIN
>> +extern int pm_cpu_domain_init(struct generic_pm_domain *genpd,
>> +			struct device_node *dn);
>> +#else
>> +static inline int pm_cpu_domain_init(struct generic_pm_domain *genpd,
>> +			struct device_node *dn)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
>> +
>>  #endif /* _LINUX_PM_DOMAIN_H */
>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> index 7e01f78..55d49f6 100644
>> --- a/kernel/power/Kconfig
>> +++ b/kernel/power/Kconfig
>> @@ -301,3 +301,15 @@ config PM_GENERIC_DOMAINS_OF
>>
>>  config CPU_PM
>>  	bool
>> +
>> +config PM_CPU_DOMAIN
>> +	def_bool y
>> +	depends on PM_GENERIC_DOMAINS_OF && CPU_PM
>> +	help
>> +	  When cpuidle powers of the cpus in a domain, the domain can also be
>> +	  powered off.
>> +	  This config option allow for cpus to be registered with the domain
>> +	  provider specified in the DT and when the cpu is powered off, calls
>> +	  the runtime PM methods to do the reference counting. The last cpu
>> +	  going down powers the domain off as well.
>> +
>>
>
