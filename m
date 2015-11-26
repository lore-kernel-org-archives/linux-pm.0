From: Denis Kirjanov <kda-u1c8ncikuMvVAZt0uhVF+Ni2O/JbrIOy@public.gmane.org>
Subject: Re: [PATCH V2] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Thu, 26 Nov 2015 11:32:17 +0300
Message-ID: <CAOJe8K3g_B=Pa7U9zFY6RjqrKOPY2a3mqMAw6uSqQBVz9qW7Zg@mail.gmail.com>
References: <1448519249-11449-1-git-send-email-hongtao.jia@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448519249-11449-1-git-send-email-hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 11/26/15, Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
> Register the qoriq cpufreq driver as a cooling device, based on the
> thermal device tree framework. When temperature crosses the passive trip
> point cpufreq is used to throttle CPUs.
>
> Signed-off-by: Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> Changes for V2:
> * Using ->ready callback for cpu cooling device registering.
>
>  drivers/cpufreq/qoriq-cpufreq.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c
> b/drivers/cpufreq/qoriq-cpufreq.c
> index 4f53fa2..a39f868 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -33,6 +34,7 @@
>  struct cpu_data {
>  	struct clk **pclk;
>  	struct cpufreq_frequency_table *table;
> +	struct thermal_cooling_device *cdev;
>  };
>
>  /*
> @@ -260,6 +262,30 @@ static int qoriq_cpufreq_target(struct cpufreq_policy
> *policy,
>  	return clk_set_parent(policy->clk, parent);
>  }
>
> +
> +static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
> +{
> +	struct cpu_data *cpud = policy->driver_data;
> +	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
> +
> +	if (WARN_ON(!np))
> +		return;
I doubt that WARN_ON is necessary here. Do you know the exact case
where the np is NULL?
> +
> +	if (of_find_property(np, "#cooling-cells", NULL)) {
> +		cpud->cdev = of_cpufreq_cooling_register(np,
> +							 policy->related_cpus);
> +
> +		if (IS_ERR(cpud->cdev)) {
> +			pr_err("Failed to register cooling device cpu%d: %ld\n",
> +					policy->cpu, PTR_ERR(cpud->cdev));
> +
> +			cpud->cdev = NULL;
> +		}
> +	}
> +
> +	of_node_put(np);
> +}
> +
>  static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.name		= "qoriq_cpufreq",
>  	.flags		= CPUFREQ_CONST_LOOPS,
> @@ -268,6 +294,7 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> +	.ready		= qoriq_cpufreq_ready,
>  	.attr		= cpufreq_generic_attr,
>  };
>
> --
> 2.1.0.27.g96db324
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
