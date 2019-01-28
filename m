From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 5/9] cpufreq: cpufreq-dt: Use auto-registration of
 thermal cooling device
Date: Mon, 28 Jan 2019 09:35:41 +0100
Message-ID: <52fd659d-b5a2-b0dc-b901-9bc33d7d6721@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <cb7296e38ec506b008e65ecf5f80ccb356f67fb8.1548654899.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cb7296e38ec506b008e65ecf5f80ccb356f67fb8.1548654899.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28/01/2019 07:41, Amit Kucheria wrote:
> Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
> automatically register as a thermal cooling device.
> 
> This allows removal of boiler plate code from the driver.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpufreq/cpufreq-dt.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb1169e..2a4c4ea7980b 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -13,7 +13,6 @@
>  
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
>  #include <linux/err.h>
> @@ -30,7 +29,6 @@
>  struct private_data {
>  	struct opp_table *opp_table;
>  	struct device *cpu_dev;
> -	struct thermal_cooling_device *cdev;
>  	const char *reg_name;
>  	bool have_static_opps;
>  };
> @@ -301,7 +299,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>  {
>  	struct private_data *priv = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(priv->cdev);
>  	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
>  	if (priv->have_static_opps)
>  		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
> @@ -314,21 +311,14 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static void cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct private_data *priv = policy->driver_data;
> -
> -	priv->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static struct cpufreq_driver dt_cpufreq_driver = {
> -	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = set_target,
>  	.get = cpufreq_generic_get,
>  	.init = cpufreq_init,
>  	.exit = cpufreq_exit,
> -	.ready = cpufreq_ready,
>  	.name = "cpufreq-dt",
>  	.attr = cpufreq_dt_attr,
>  	.suspend = cpufreq_generic_suspend,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
