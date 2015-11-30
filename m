From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 3/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
Date: Mon, 30 Nov 2015 11:08:45 +0530
Message-ID: <20151130053845.GM3373@ubuntu>
References: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
 <1448616727-29367-4-git-send-email-dawei.chien@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448616727-29367-4-git-send-email-dawei.chien@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dawei Chien <dawei.chien@mediatek.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On 27-11-15, 17:32, Dawei Chien wrote:
> MT8173 cpufreq driver use of_cpufreq_power_cooling_register registering
> cooling devices with dynamic power coefficient.
> 
> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> ---
> This patch is base on patchset:
> https://lkml.org/lkml/2015/11/17/251
> ---
>  drivers/cpufreq/mt8173-cpufreq.c |   28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> index 83001dc..4d39468 100644
> --- a/drivers/cpufreq/mt8173-cpufreq.c
> +++ b/drivers/cpufreq/mt8173-cpufreq.c
> @@ -263,24 +263,34 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  	return 0;
>  }
>  
> +#define DYNAMIC_POWER "dynamic-power-coefficient"
> +
>  static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
>  {
>  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
>  	struct device_node *np = of_node_get(info->cpu_dev->of_node);
> +	u32 capacitance;
>  
>  	if (WARN_ON(!np))
>  		return;
>  
>  	if (of_find_property(np, "#cooling-cells", NULL)) {
> -		info->cdev = of_cpufreq_cooling_register(np,
> -							 policy->related_cpus);
> +		if (!info->cdev) {

Why will info->cdev be non-NULL here ?

> +			of_property_read_u32(np, DYNAMIC_POWER, &capacitance);

This can fail, in which case capacitance will be used uninitialized.
Fix that by initializing it with 0 at the beginning of this routine.

> +			info->cdev = of_cpufreq_power_cooling_register(np,
> +							policy->related_cpus,
> +							capacitance,
> +							NULL);
>  
> -		if (IS_ERR(info->cdev)) {
> -			dev_err(info->cpu_dev,
> -				"running cpufreq without cooling device: %ld\n",
> -				PTR_ERR(info->cdev));
> +			if (IS_ERR(info->cdev)) {
> +				dev_err(info->cpu_dev,
> +					"running cpufreq without cooling device: %ld\n",
> +					PTR_ERR(info->cdev));
>  
> -			info->cdev = NULL;
> +				info->cdev = NULL;
> +			}
>  		}
>  	}
>  
> @@ -460,7 +470,9 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(info->cdev);
> +	if (info->cdev)
> +		cpufreq_cooling_unregister(info->cdev);
> +

Why do you need to update this?

>  	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
>  	mtk_cpu_dvfs_info_release(info);
>  	kfree(info);
> -- 
> 1.7.9.5

-- 
viresh
