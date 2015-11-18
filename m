From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 3/3] cpufreq: arm_big_little: Add support to register
 a cpufreq cooling device
Date: Wed, 18 Nov 2015 11:12:40 +0530
Message-ID: <20151118054216.GE7336@ubuntu>
References: <1447761983-12415-1-git-send-email-punit.agrawal@arm.com>
 <1447761983-12415-4-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33462 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbbKRFnE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 00:43:04 -0500
Received: by pabfh17 with SMTP id fh17so34485718pab.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 21:43:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1447761983-12415-4-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com, javi.merino@arm.com, rjw@rjwysocki.net, Sudeep Holla <sudeep.holla@arm.com>

On 17-11-15, 12:06, Punit Agrawal wrote:
> Register passive cooling devices when initialising cpufreq on
> big.LITTLE systems. If the device tree provides a dynamic power
> coefficient for the CPUs then the bound cooling device will support
> the extensions that allow it to be used with all the existing thermal
> governors including the power allocator governor.
> 
> A cooling device will be created per individual frequency domain and
> can be bound to thermal zones via the thermal DT bindings.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/cpufreq/Kconfig.arm      |  2 ++
>  drivers/cpufreq/arm_big_little.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 1582c1c..0e0052e 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -6,6 +6,8 @@
>  config ARM_BIG_LITTLE_CPUFREQ
>  	tristate "Generic ARM big LITTLE CPUfreq driver"
>  	depends on (ARM_CPU_TOPOLOGY || ARM64) && HAVE_CLK
> +	# if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> +	depends on !CPU_THERMAL || THERMAL
>  	select PM_OPP
>  	help
>  	  This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index c5d256c..c251247 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -55,6 +56,7 @@ static bool bL_switching_enabled;
>  #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
>  #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
>  
> +static struct thermal_cooling_device *cdev[MAX_CLUSTERS];
>  static struct cpufreq_arm_bL_ops *arm_bL_ops;
>  static struct clk *clk[MAX_CLUSTERS];
>  static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
> @@ -493,6 +495,12 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
>  static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct device *cpu_dev;
> +	int cur_cluster = cpu_to_cluster(policy->cpu);
> +
> +	if (cur_cluster < MAX_CLUSTERS) {
> +		cpufreq_cooling_unregister(cdev[cur_cluster]);
> +		cdev[cur_cluster] = NULL;
> +	}
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -507,6 +515,38 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> +static void bL_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	int cur_cluster = cpu_to_cluster(policy->cpu);
> +	struct device_node *np;
> +
> +	/* Do not register a cpu_cooling device if we are in IKS mode */
> +	if (cur_cluster >= MAX_CLUSTERS)
> +		return;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (WARN_ON(!np))
> +		return;
> +
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		u32 power_coefficient = 0;
> +
> +		of_property_read_u32(np, "dynamic-power-coefficient",
> +				     &power_coefficient);
> +
> +		cdev[cur_cluster] = of_cpufreq_power_cooling_register(np,
> +				policy->related_cpus, power_coefficient, NULL);
> +		if (IS_ERR(cdev[cur_cluster])) {
> +			dev_err(cpu_dev,
> +				"running cpufreq without cooling device: %ld\n",
> +				PTR_ERR(cdev[cur_cluster]));
> +			cdev[cur_cluster] = NULL;
> +		}
> +	}
> +	of_node_put(np);
> +}
> +
>  static struct cpufreq_driver bL_cpufreq_driver = {
>  	.name			= "arm-big-little",
>  	.flags			= CPUFREQ_STICKY |
> @@ -517,6 +557,7 @@ static struct cpufreq_driver bL_cpufreq_driver = {
>  	.get			= bL_cpufreq_get_rate,
>  	.init			= bL_cpufreq_init,
>  	.exit			= bL_cpufreq_exit,
> +	.ready			= bL_cpufreq_ready,
>  	.attr			= cpufreq_generic_attr,
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
