From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 7/9] cpufreq: qoriq: Use auto-registration of thermal
 cooling device
Date: Mon, 28 Jan 2019 09:37:48 +0100
Message-ID: <1b5ecceb-f7b4-903b-4158-394618fab8d3@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f33f279a20f9125ffbec96bfbf1aa9153baebab8.1548654899.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f33f279a20f9125ffbec96bfbf1aa9153baebab8.1548654899.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Markus Elfring <elfring@users.sourceforge.net>, linux-pm@vger.kernel.org
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
>  drivers/cpufreq/qoriq-cpufreq.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 3d773f64b4df..b206e6cb55f0 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -13,7 +13,6 @@
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/cpufreq.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -31,7 +30,6 @@
>  struct cpu_data {
>  	struct clk **pclk;
>  	struct cpufreq_frequency_table *table;
> -	struct thermal_cooling_device *cdev;
>  };
>  
>  /*
> @@ -239,7 +237,6 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	struct cpu_data *data = policy->driver_data;
>  
> -	cpufreq_cooling_unregister(data->cdev);
>  	kfree(data->pclk);
>  	kfree(data->table);
>  	kfree(data);
> @@ -258,23 +255,15 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
>  	return clk_set_parent(policy->clk, parent);
>  }
>  
> -
> -static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	struct cpu_data *cpud = policy->driver_data;
> -
> -	cpud->cdev = of_cpufreq_cooling_register(policy);
> -}
> -
>  static struct cpufreq_driver qoriq_cpufreq_driver = {
>  	.name		= "qoriq_cpufreq",
> -	.flags		= CPUFREQ_CONST_LOOPS,
> +	.flags		= CPUFREQ_CONST_LOOPS |
> +			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.init		= qoriq_cpufreq_cpu_init,
>  	.exit		= qoriq_cpufreq_cpu_exit,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qoriq_cpufreq_target,
>  	.get		= cpufreq_generic_get,
> -	.ready		= qoriq_cpufreq_ready,
>  	.attr		= cpufreq_generic_attr,
>  };
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
