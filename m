From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 02/10] cpufreq: Add a flag to auto-register a cooling device
Date: Thu, 17 Jan 2019 00:03:03 +0100
Message-ID: <15792961.Mmjk2FNQN5@aspire.rjw.lan>
References: <cover.1547481320.git.amit.kucheria@linaro.org> <c1e460c49ad2f16b15ace909514a770c9753d1b1.1547481320.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1e460c49ad2f16b15ace909514a770c9753d1b1.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, January 14, 2019 5:34:54 PM CET Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 17 +++++++++++++++++
>  include/linux/cpufreq.h   |  6 ++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6f23ebb395f1..cd6e750d3d82 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -30,6 +30,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/tick.h>
>  #include <trace/events/power.h>
> +#include <linux/cpu_cooling.h>
>  
>  static LIST_HEAD(cpufreq_policy_list);
>  
> @@ -1318,6 +1319,14 @@ static int cpufreq_online(unsigned int cpu)
>  	if (cpufreq_driver->ready)
>  		cpufreq_driver->ready(policy);
>  
> +#ifdef CONFIG_CPU_THERMAL
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +		struct thermal_cooling_device **cdev = &policy->cooldev;
> +
> +		*cdev = of_cpufreq_cooling_register(policy);

What would be wrong with

		policy->cooldev = of_cpufreq_cooling_register(policy);

> +	}
> +#endif

Please remove the #ifdefs from cpufreq_online() and cpufreq_offline().

Use wrappers that would become empty stubs for CONFIG_CPU_THERMAL unset.

> +
>  	pr_debug("initialization complete\n");
>  
>  	return 0;
> @@ -1411,6 +1420,14 @@ static int cpufreq_offline(unsigned int cpu)
>  	if (has_target())
>  		cpufreq_exit_governor(policy);
>  
> +#ifdef CONFIG_CPU_THERMAL
> +	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +		struct thermal_cooling_device **cdev = &policy->cooldev;
> +
> +		cpufreq_cooling_unregister(*cdev);

Again, why don't you simply pass policy->cooldev here?

Also, would it make sense to clear policy->cooldev at this point?  It points
to freed memory after cpufreq_cooling_unregister().

> +	}
> +#endif
> +
>  	/*
>  	 * Perform the ->exit() even during light-weight tear-down,
>  	 * since this is a core component, and is essential for the
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 7d0cf54125fa..70ad02088825 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -390,6 +390,12 @@ struct cpufreq_driver {
>   */
>  #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
>  
> +/*
> + * Set by drivers that want the core to automatically register the cpufreq
> + * driver as a thermal cooling device
> + */
> +#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
> +
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data);
>  int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
>  
> 
