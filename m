From: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 3/3] cpufreq: arm_big_little: Add support to register
 a cpufreq cooling device
Date: Tue, 10 Nov 2015 12:34:52 +0000
Message-ID: <20151110123452.GD3551@e104805>
References: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
 <1447090163-13700-4-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1447090163-13700-4-git-send-email-punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 09, 2015 at 05:29:23PM +0000, Punit Agrawal wrote:
> Register passive cooling devices when initialising cpufreq on
> big.LITTLE systems. If the device tree provides a dynamic power
> coefficient for the CPUs then the bound cooling device will support
> the extensions that allow it to be used with all the existing thermal
> governors including the power allocator governor.
> 
> A cooling device will be created per individual frequency domain and
> can be bound to thermal zones via the thermal DT bindings.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>
> Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/cpufreq/arm_big_little.c | 52 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index f1e42f8..72a2777 100644
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
> @@ -55,6 +56,10 @@ static bool bL_switching_enabled;
>  #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
>  #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
>  
> +struct private_data {
> +	struct thermal_cooling_device *cdev;
> +};
> +

My first impression was that this is redundant and you could store the
pointer to cdev in driver_data itself.  But seeing that it's mirroring
the structure in cpufreq-dt and it's simpler to do it this way I guess
it's ok to create this struct with only one pointer.  You can add my

Reviewed-by: Javi Merino <javi.merino-5wv7dgnIgG8@public.gmane.org>

>  static struct cpufreq_arm_bL_ops *arm_bL_ops;
>  static struct clk *clk[MAX_CLUSTERS];
>  static struct cpufreq_frequency_table *freq_table[MAX_CLUSTERS + 1];
> @@ -440,6 +445,7 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	u32 cur_cluster = cpu_to_cluster(policy->cpu);
>  	struct device *cpu_dev;
> +	struct private_data *priv;
>  	int ret;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
> @@ -457,9 +463,15 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
>  	if (ret) {
>  		dev_err(cpu_dev, "CPU %d, cluster: %d invalid freq table\n",
>  				policy->cpu, cur_cluster);
> -		put_cluster_clk_and_freq_table(cpu_dev);
> -		return ret;
> +		goto out_free_cpufreq_table;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto out_free_cpufreq_table;
>  	}
> +	policy->driver_data = priv;
>  
>  	if (cur_cluster < MAX_CLUSTERS) {
>  		int cpu;
> @@ -484,12 +496,19 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
>  
>  	dev_info(cpu_dev, "%s: CPU %d initialized\n", __func__, policy->cpu);
>  	return 0;
> +
> +out_free_cpufreq_table:
> +	put_cluster_clk_and_freq_table(cpu_dev);
> +
> +	return ret;
>  }
>  
>  static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct device *cpu_dev;
> +	struct private_data *priv = policy->driver_data;
>  
> +	cpufreq_cooling_unregister(priv->cdev);
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
>  		pr_err("%s: failed to get cpu%d device\n", __func__,
> @@ -498,11 +517,39 @@ static int bL_cpufreq_exit(struct cpufreq_policy *policy)
>  	}
>  
>  	put_cluster_clk_and_freq_table(cpu_dev);
> +	kfree(priv);
>  	dev_dbg(cpu_dev, "%s: Exited, cpu: %d\n", __func__, policy->cpu);
>  
>  	return 0;
>  }
>  
> +static void bL_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> +	struct device_node *np = of_node_get(cpu_dev->of_node);
> +	struct private_data *priv = policy->driver_data;
> +
> +	if (WARN_ON(!np))
> +		return;
> +
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		u32 power_coefficient = 0;
> +
> +		of_property_read_u32(np, "dynamic-power-coefficient",
> +				     &power_coefficient);
> +
> +		priv->cdev = of_cpufreq_power_cooling_register(np,
> +				policy->related_cpus, power_coefficient, NULL);
> +		if (IS_ERR(priv->cdev)) {
> +			dev_err(cpu_dev,
> +				"running cpufreq without cooling device: %ld\n",
> +				PTR_ERR(priv->cdev));
> +			priv->cdev = NULL;
> +		}
> +	}
> +	of_node_put(np);
> +}
> +
>  static struct cpufreq_driver bL_cpufreq_driver = {
>  	.name			= "arm-big-little",
>  	.flags			= CPUFREQ_STICKY |
> @@ -513,6 +560,7 @@ static struct cpufreq_driver bL_cpufreq_driver = {
>  	.get			= bL_cpufreq_get_rate,
>  	.init			= bL_cpufreq_init,
>  	.exit			= bL_cpufreq_exit,
> +	.ready			= bL_cpufreq_ready,
>  	.attr			= cpufreq_generic_attr,
>  };
>  
> -- 
> 2.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
