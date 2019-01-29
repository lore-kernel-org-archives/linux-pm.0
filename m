From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Date: Tue, 29 Jan 2019 10:40:30 +0530
Message-ID: <20190129051030.gu5nhr6vmcd35bzk@vireshk-i7>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-2-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

On 28-01-19, 16:55, Quentin Perret wrote:
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 06f0f632ec47..7572a2eb2fd4 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -1047,3 +1047,63 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  	return of_node_get(opp->np);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
> +
> +/**
> + * of_dev_pm_opp_get_cpu_power() - Estimates the power of a CPU
> + * @mW:		pointer to the power estimate in milli-watts
> + * @KHz:	pointer to the OPP's frequency, in kilo-hertz
> + * @cpu:	CPU for which power needs to be estimated
> + *
> + * Computes the power estimated by @CPU at the first OPP above @KHz (ceil),
> + * and updates @KHz and @mW accordingly.
> + *
> + * The power is estimated as P = C * V^2 * f, with C the CPU's capacitance
> + * (read from the 'dynamic-power-coefficient' devicetree binding) and V and f
> + * respectively the voltage and frequency of the OPP.
> + *
> + * Return: -ENODEV if the CPU device cannot be found, -EINVAL if the power
> + * calculation failed because of missing parameters, 0 otherwise.
> + */
> +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)

I would suggest to change the return type to unsigned long and return 0 for
errors and positive values for mW.

> +{
> +	unsigned long mV, Hz, MHz;

MHz is used only once, I think you can get rid of it just open code the division
by 1000000. Maybe remove Hz as well and directly use kHz.

> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	u32 cap;
> +	u64 tmp;

Name this mW with the above changes.

> +	int ret;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return -EINVAL;
> +
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret)
> +		return -EINVAL;
> +
> +	Hz = *KHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	MHz = Hz / 1000000;
> +	tmp = (u64)cap * mV * mV * MHz;
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;
> +	*KHz = Hz / 1000;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_dev_pm_opp_get_cpu_power);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 0a2a88e5a383..fedde14f5187 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> +int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
>  {
>  	return -ENOTSUPP;
>  }

Add a blank line here. We missed adding the same before
of_get_required_opp_performance_state() earlier, maybe add the new routine
before of_get_required_opp_performance_state() and add blank line before and
after it :)

> +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif
>  
>  #endif		/* __LINUX_OPP_H__ */
> -- 
> 2.20.1

-- 
viresh
