From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/2] thermal: mediatek: Add cpu power cooling model.
Date: Wed, 4 Nov 2015 11:40:00 -0800
Message-ID: <20151104193958.GC14127@localhost.localdomain>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <1445515359-8587-2-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445515359-8587-2-git-send-email-dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dawei Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 22, 2015 at 08:02:38PM +0800, Dawei Chien wrote:
> This power model is base on Intelligent Power Allocation (IPA)
> technical, requires that the operating-points of the CPUs are
> registered using the kernel's opp library and the
> `cpufreq_frequency_table` is assigned to the `struct device`
> of the cpu MT8173.
> 
> Signed-off-by: Dawei.Chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
> This patch is base on
> https://patchwork.kernel.org/patch/7034601/
> ---
>  drivers/cpufreq/mt8173-cpufreq.c |  152 ++++++++++++++++++++++++++++++++++++--

Given that you are proposing this on top a DT binding, why reading a
table of static power model applicable only to mt8173 cpufreq driver?

I have not seen anything specific (formula etc) that prevents this code
to be generalized to other CPUs.

Can you please help me to understand?

BR,

>  1 file changed, 144 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 49caed2..23c19c5 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -29,6 +29,16 @@
>  #define MAX_VOLT_LIMIT		(1150000)
>  #define VOLT_TOL		(10000)
>  
> +struct mtk_cpu_static_power {
> +	unsigned long voltage;
> +	unsigned int power;
> +};
> +
> +static struct mtk_cpu_static_power *mtk_ca53_static_power_table;
> +static struct mtk_cpu_static_power *mtk_ca57_static_power_table;
> +static int mtk_ca53_static_table_length;
> +static int mtk_ca57_static_table_length;
> +
>  /*
>   * The struct mtk_cpu_dvfs_info holds necessary information for doing CPU DVFS
>   * on each CPU power/clock domain of Mediatek SoCs. Each CPU cluster in
> @@ -51,6 +61,110 @@ struct mtk_cpu_dvfs_info {
>  	bool need_voltage_tracking;
>  };
>  
> +unsigned int mtk_cpufreq_lookup_power(const struct mtk_cpu_static_power *table,
> +		unsigned int count, unsigned long voltage)
> +{
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		if (voltage <= table[i].voltage)
> +			return table[i].power;
> +	}
> +
> +	return table[count - 1].power;
> +}
> +
> +int mtk_cpufreq_get_static(cpumask_t *cpumask, int interval,
> +		unsigned long voltage, u32 *power)
> +{
> +	int nr_cpus = cpumask_weight(cpumask);
> +
> +	*power = 0;
> +
> +	if (nr_cpus) {
> +		if (cpumask_test_cpu(0, cpumask))
> +			*power += mtk_cpufreq_lookup_power(
> +					mtk_ca53_static_power_table,
> +					mtk_ca53_static_table_length,
> +					voltage);
> +
> +		if (cpumask_test_cpu(2, cpumask))
> +			*power += mtk_cpufreq_lookup_power(
> +					mtk_ca57_static_power_table,
> +					mtk_ca57_static_table_length,
> +					voltage);
> +	}
> +
> +	return 0;
> +}
> +
> +unsigned int mtk_get_power_table_info(struct cpufreq_policy *policy,
> +		struct device_node *np, const char *node_name)
> +{
> +	int mtk_static_table_length;
> +	const struct property *prop;
> +	struct mtk_cpu_dvfs_info *info = policy->driver_data;
> +	struct device *cpu_dev = info->cpu_dev;
> +	const __be32 *val;
> +	int nr, i;
> +
> +	prop = of_find_property(np, node_name, NULL);
> +
> +	if (!prop) {
> +		pr_err("failed to get static-power-points\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!prop->value) {
> +		pr_err("failed to get static power array data\n");
> +		return -EINVAL;
> +	}
> +
> +	nr = prop->length / sizeof(u32);
> +
> +	if (nr % 2) {
> +		pr_err("Invalid OPP list\n");
> +		return -EINVAL;
> +	}
> +
> +	mtk_static_table_length = nr / 2;
> +
> +	if (cpumask_test_cpu(0, policy->related_cpus)) {
> +		mtk_ca53_static_table_length = mtk_static_table_length;
> +		mtk_ca53_static_power_table = devm_kcalloc(cpu_dev,
> +					mtk_static_table_length,
> +					sizeof(*mtk_ca53_static_power_table),
> +					GFP_KERNEL);
> +
> +		val = prop->value;
> +		for (i = 0; i < mtk_static_table_length; ++i) {
> +			unsigned long voltage = be32_to_cpup(val++);
> +			unsigned int power = be32_to_cpup(val++);
> +
> +			mtk_ca53_static_power_table[i].voltage = voltage;
> +			mtk_ca53_static_power_table[i].power = power;
> +			pr_info("volt:%ld uv, power:%d mW\n", voltage, power);
> +		}
> +	} else {
> +                mtk_ca57_static_table_length = mtk_static_table_length;
> +		mtk_ca57_static_power_table = devm_kcalloc(cpu_dev,
> +					mtk_static_table_length,
> +					sizeof(*mtk_ca57_static_power_table),
> +					GFP_KERNEL);
> +		val = prop->value;
> +		for (i = 0; i < mtk_static_table_length; ++i) {
> +			unsigned long voltage = be32_to_cpup(val++);
> +			unsigned int power = be32_to_cpup(val++);
> +
> +			mtk_ca57_static_power_table[i].voltage = voltage;
> +			mtk_ca57_static_power_table[i].power = power;
> +			pr_info("volt:%ld uv, power:%d mW\n", voltage, power);
> +		}
> +	}
> +
> +	return	0;
> +}
> +
>  static int mtk_cpufreq_voltage_tracking(struct mtk_cpu_dvfs_info *info,
>  					int new_vproc)
>  {
> @@ -267,20 +381,40 @@ static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
>  {
>  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
>  	struct device_node *np = of_node_get(info->cpu_dev->of_node);
> +	u32 capacitance;
> +	int ret;
>  
>  	if (WARN_ON(!np))
>  		return;
>  
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		info->cdev = of_cpufreq_cooling_register(np,
> -							 policy->related_cpus);
>  
> -		if (IS_ERR(info->cdev)) {
> -			dev_err(info->cpu_dev,
> -				"running cpufreq without cooling device: %ld\n",
> -				PTR_ERR(info->cdev));
> +		if (!info->cdev) {
> +
> +			of_property_read_u32(np,
> +					"dynamic-power-coefficient",
> +					&capacitance);
> +
> +			ret = mtk_get_power_table_info(policy, np,
> +						"static-power-points");
> +			if (ret) {
> +                                dev_err(info->cpu_dev,
> +                                        "cpufreq without static-points: %d\n",
> +                                        ret);
> +			}
> +
> +			info->cdev = of_cpufreq_power_cooling_register(np,
> +				policy->related_cpus,
> +				capacitance,
> +				mtk_cpufreq_get_static);
> +
> +			if (IS_ERR(info->cdev)) {
> +				dev_err(info->cpu_dev,
> +					"cpufreq without cdev: %ld\n",
> +					PTR_ERR(info->cdev));
> +					info->cdev = NULL;
> +			}
>  
> -			info->cdev = NULL;
>  		}
>  	}
>  
> @@ -460,7 +594,9 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(info->cdev);
> +	if (info->cdev)
> +		cpufreq_cooling_unregister(info->cdev);
> +
>  	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
>  	mtk_cpu_dvfs_info_release(info);
>  	kfree(info);
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
