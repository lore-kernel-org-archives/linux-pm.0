From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 05/10] cpufreq: imx6q: Use auto-registration of
 thermal cooling device
Date: Thu, 17 Jan 2019 10:19:06 +0530
Message-ID: <20190117044906.jomvwecvjrkgsuak@vireshk-i7>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <49e531e140f299127ae6c0bc905b993b97c269e2.1547481320.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49e531e140f299127ae6c0bc905b993b97c269e2.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Anson Huang <anson.huang@nxp.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 14-01-19, 22:04, Amit Kucheria wrote:
> Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
> automatically register as a thermal cooling device.
> 
> This allows removal of boiler plate code from the driver.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/imx6q-cpufreq.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 9fedf627e000..ffb00291f48e 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -9,7 +9,6 @@
>  #include <linux/clk.h>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> -#include <linux/cpu_cooling.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-consumer.h>
> @@ -52,7 +51,6 @@ static struct clk_bulk_data clks[] = {
>  };
>  
>  static struct device *cpu_dev;
> -static struct thermal_cooling_device *cdev;
>  static bool free_opp;
>  static struct cpufreq_frequency_table *freq_table;
>  static unsigned int max_freq;
> @@ -193,16 +191,6 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
>  	return 0;
>  }
>  
> -static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
> -{
> -	cdev = of_cpufreq_cooling_register(policy);
> -
> -	if (!cdev)
> -		dev_err(cpu_dev,
> -			"running cpufreq without cooling device: %ld\n",
> -			PTR_ERR(cdev));
> -}
> -
>  static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -216,20 +204,18 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
>  
>  static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
>  {
> -	cpufreq_cooling_unregister(cdev);
> -
>  	return 0;
>  }

Remove the empty routine as well.

>  static struct cpufreq_driver imx6q_cpufreq_driver = {
> -	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
> +	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify = cpufreq_generic_frequency_table_verify,
>  	.target_index = imx6q_set_target,
>  	.get = cpufreq_generic_get,
>  	.init = imx6q_cpufreq_init,
>  	.exit = imx6q_cpufreq_exit,
>  	.name = "imx6q-cpufreq",
> -	.ready = imx6q_cpufreq_ready,
>  	.attr = cpufreq_generic_attr,
>  	.suspend = cpufreq_generic_suspend,
>  };
> -- 
> 2.17.1

-- 
viresh
