From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 6/9] cpufreq: mediatek: Use auto-registration of
 thermal cooling device
Date: Wed, 6 Feb 2019 14:55:03 +0100
Message-ID: <b745a0be-c3ca-00d3-50c3-8ec560548da7@gmail.com>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
 <36eb429112e84263bdbd26d8ea3027f71eeb862e.1548737236.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36eb429112e84263bdbd26d8ea3027f71eeb862e.1548737236.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Sean Wang <sean.wang@mediatek.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pm@vger.kernel.org



On 29/01/2019 05:55, Amit Kucheria wrote:
> Use the CPUFREQ_IS_COOLING_DEV flag to allow cpufreq core to
> automatically register as a thermal cooling device.
> 
> This allows removal of boiler plate code from the driver.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index eb8920d39818..4229fcc31310 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -14,7 +14,6 @@
>  
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/module.h>
> @@ -48,7 +47,6 @@ struct mtk_cpu_dvfs_info {
>  	struct regulator *sram_reg;
>  	struct clk *cpu_clk;
>  	struct clk *inter_clk;
> -	struct thermal_cooling_device *cdev;
>  	struct list_head list_head;
>  	int intermediate_voltage;
>  	bool need_voltage_tracking;
> @@ -307,13 +305,6 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  #define DYNAMIC_POWER "dynamic-power-coefficient"
>  
> -static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct mtk_cpu_dvfs_info *info = policy->driver_data;
> -
> -	info->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>  {
>  	struct device *cpu_dev;
> @@ -472,7 +463,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct mtk_cpu_dvfs_info *info = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(info->cdev);
>  	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
>  
>  	return 0;
> @@ -480,13 +470,13 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
>  
>  static struct cpufreq_driver mtk_cpufreq_driver = {
>  	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +		 CPUFREQ_IS_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = mtk_cpufreq_set_target,
>  	.get = cpufreq_generic_get,
>  	.init = mtk_cpufreq_init,
>  	.exit = mtk_cpufreq_exit,
> -	.ready = mtk_cpufreq_ready,
>  	.name = "mtk-cpufreq",
>  	.attr = cpufreq_generic_attr,
>  };
> 
