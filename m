From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/7] PM / OPP: Introduce a power estimation helper
Date: Mon, 28 Jan 2019 11:02:51 -0800
Message-ID: <20190128190251.GH81583@google.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
 <20190128165522.31749-2-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128165522.31749-2-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

rHi Quentin,

On Mon, Jan 28, 2019 at 04:55:16PM +0000, Quentin Perret wrote:
> The Energy Model (EM) framework provides an API to let drivers register
> the active power of CPUs. The drivers are expected to provide a callback
> method which estimates the power consumed by a CPU at each available
> performance levels. How exactly this should be implemented, however,
> depends on the platform.
> 
> On some systems, PM_OPP knows the voltage and frequency at which CPUs
> can run. When coupled with the CPU 'capacitance' (as provided by the
> 'dynamic-power-coefficient' devicetree binding), it is possible to
> estimate the dynamic power consumption of a CPU as P = C * V^2 * f, with
> C its capacitance and V and f respectively the voltage and frequency of
> the OPP. The Intelligent Power Allocator (IPA) thermal governor already
> implements that estimation method, in the thermal framework.
> 
> However, this power estimation method can be applied to any platform
> where all the parameters are known (C, V and f), and not only those
> suffering thermal issues. As such, the code implementing this feature
> can be re-used to also populate the EM framework now used by EAS.
> 
> As a first step, introduce in PM_OPP a helper function which CPUFreq
> drivers can use to register into the EM framework. This duplicates the
> power estimation done in IPA until it can be migrated to using the EM
> framework. This will be done later, once the EM framework has support
> for at least all platforms currently supported by IPA.
> 
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/opp/of.c       | 60 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  5 ++++
>  2 files changed, 65 insertions(+)
> 
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

nit: should be kHz

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

I think it is more common to put the input parameters first, then the
output ones, i.e. cpu, kHz, mW.

> +{
> +	unsigned long mV, Hz, MHz;
> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
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
> +static inline int of_dev_pm_opp_get_cpu_power(unsigned long *mW, unsigned long *KHz, int cpu)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif
>  
>  #endif		/* __LINUX_OPP_H__ */

Besides the nits above:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
