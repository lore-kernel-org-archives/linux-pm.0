From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Date: Thu, 31 Jan 2019 12:56:33 +0530
Message-ID: <20190131072633.bcqc75s6jmyt7fgx@vireshk-i7>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190130170506.20450-2-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: sudeep.holla@arm.com, rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org, mka@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 30-01-19, 17:05, Quentin Perret wrote:
> +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> +					 int cpu)
> +{
> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	unsigned long mV, Hz;
> +	u32 cap;
> +	u64 tmp;
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
> +	Hz = *kHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	mV = dev_pm_opp_get_voltage(opp) / 1000;

The voltage is also stored as triplet now a days and we must consider
the higher value for these calculations. Also what about the case of
multiple regulators here or performance-states ?

> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	tmp = (u64)cap * mV * mV * (Hz / 1000000);
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;

I was thinking will it be better if we just save this information in
opp->power field during init, so we can just read a value here
instead. But I am still not sure :(

> +	*kHz = Hz / 1000;
> +
> +	return 0;
> +}
> +
> +/**
> + * dev_pm_opp_of_register_em() - Attempt to register an Energy Model
> + * @cpus	: CPUs for which an Energy Model has to be registered
> + * @nr_opp	: Number of OPPs to register in the Energy Model
> + *
> + * This checks whether the "dynamic-power-coefficient" devicetree binding has
> + * been specified, and tries to register an Energy Model with it if it has.
> + */
> +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> +{
> +	struct em_data_callback em_cb = EM_DATA_CB(_get_cpu_power);
> +	int ret, cpu = cpumask_first(cpus);
> +	struct device *cpu_dev;
> +	struct device_node *np;
> +	u32 cap;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return;
> +
> +	/* Don't register an EM without the right DT binding */
> +	ret = of_property_read_u32(np, "dynamic-power-coefficient", &cap);
> +	of_node_put(np);
> +	if (ret || !cap)
> +		return;

What if no voltage is supplied in DT ?

> +
> +	em_register_perf_domain(cpus, nr_opp, &em_cb);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_of_register_em);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index b895f4e79868..58ae08b024bd 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -327,6 +327,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
>  struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
>  struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
>  int of_get_required_opp_performance_state(struct device_node *np, int index);
> +void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp);
>  #else
>  static inline int dev_pm_opp_of_add_table(struct device *dev)
>  {
> @@ -365,6 +366,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
>  {
>  	return NULL;
>  }
> +
> +static inline void dev_pm_opp_of_register_em(struct cpumask *cpus, int nr_opp)
> +{
> +}
> +
>  static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
>  {
>  	return -ENOTSUPP;
> -- 
> 2.20.1

-- 
viresh
