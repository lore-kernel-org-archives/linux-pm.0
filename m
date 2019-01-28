From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Date: Mon, 28 Jan 2019 09:29:09 +0100
Message-ID: <8dc3dcab-c1f5-2f6a-69fd-0283735e6241@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tao Wang <kevin.wangtao@hisilicon.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28/01/2019 07:41, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
> 
> In order to allow this, we add a struct thermal_cooling_device pointer
> to struct cpufreq_policy so that drivers don't need to store it in a
> private data structure.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>



>  drivers/cpufreq/cpufreq.c | 9 +++++++++
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..29ed78b0b77b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -19,6 +19,7 @@
>  
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -1318,6 +1319,9 @@ static int cpufreq_online(unsigned int cpu)
>  	if (cpufreq_driver->ready)
>  		cpufreq_driver->ready(policy);
>  
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
> +		policy->cdev = of_cpufreq_cooling_register(policy);
> +
>  	pr_debug("initialization complete\n");
>  
>  	return 0;
> @@ -1405,6 +1409,11 @@ static int cpufreq_offline(unsigned int cpu)
>  		goto unlock;
>  	}
>  
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +		cpufreq_cooling_unregister(policy->cdev);
> +		policy->cdev = NULL;
> +	}
> +
>  	if (cpufreq_driver->stop_cpu)
>  		cpufreq_driver->stop_cpu(policy);
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index bd7fbd6a4478..55ca61a64fc2 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -151,6 +151,9 @@ struct cpufreq_policy {
>  
>  	/* For cpufreq driver's internal use */
>  	void			*driver_data;
> +
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;
>  };
>  
>  /* Only for ACPI */
> @@ -386,6 +389,12 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
>  
> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device.
> + */
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
