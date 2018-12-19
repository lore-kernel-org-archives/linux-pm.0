From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 04/27] PM / Domains: Add genpd governor for CPUs
Date: Wed, 19 Dec 2018 10:54:26 +0100
Message-ID: <5529fc0a-af96-b10a-ca4a-f1417598f4ee@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-5-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129174700.16585-5-ulf.hansson@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29/11/2018 18:46, Ulf Hansson wrote:
> As it's now perfectly possible that a PM domain managed by genpd contains
> devices belonging to CPUs, we should start to take into account the
> residency values for the idle states during the state selection process.
> The residency value specifies the minimum duration of time, the CPU or a
> group of CPUs, needs to spend in an idle state to not waste energy entering
> it.
> 
> To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
> may be used for a PM domain that have CPU devices attached or if the CPUs
> are attached through subdomains.
> 
> The new governor computes the minimum expected idle duration time for the
> online CPUs being attached to the PM domain and its subdomains. Then in the
> state selection process, trying the deepest state first, it verifies that
> the idle duration time satisfies the state's residency value.
> 
> It should be noted that, when computing the minimum expected idle duration
> time, we use the information from tick_nohz_get_next_wakeup(), to find the
> next wakeup for the related CPUs. Future wise, this may deserve to be
> improved, as there are more reasons to why a CPU may be woken up from idle.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v10:
> 	- Fold in patch that extended the new genpd CPU governor to cope with
> 	  QoS constraints, as to avoid confusion.
> 	- Simplified the code according to suggestions from Rafael.
> 
> ---
>  drivers/base/power/domain_governor.c | 61 +++++++++++++++++++++++++++-
>  include/linux/pm_domain.h            |  3 ++
>  2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index 99896fbf18e4..61a7c3c03c98 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -10,6 +10,9 @@
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
>  #include <linux/hrtimer.h>
> +#include <linux/cpumask.h>
> +#include <linux/ktime.h>
> +#include <linux/tick.h>
>  
>  static int dev_update_qos_constraint(struct device *dev, void *data)
>  {
> @@ -211,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>  	struct generic_pm_domain *genpd = pd_to_genpd(pd);
>  	struct gpd_link *link;
>  
> -	if (!genpd->max_off_time_changed)
> +	if (!genpd->max_off_time_changed) {
> +		genpd->state_idx = genpd->cached_power_down_state_idx;
>  		return genpd->cached_power_down_ok;
> +	}
>  
>  	/*
>  	 * We have to invalidate the cached results for the masters, so
> @@ -237,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
>  		genpd->state_idx--;
>  	}
>  
> +	genpd->cached_power_down_state_idx = genpd->state_idx;
>  	return genpd->cached_power_down_ok;
>  }
>  
> @@ -245,6 +251,54 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>  	return false;
>  }
>  
> +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> +{
> +	struct generic_pm_domain *genpd = pd_to_genpd(pd);
> +	ktime_t domain_wakeup, cpu_wakeup;
> +	s64 idle_duration_ns;
> +	int cpu, i;
> +
> +	/* Validate dev PM QoS constraints. */
> +	if (!default_power_down_ok(pd))
> +		return false;
> +
> +	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
> +		return true;

Is it possible to have this function called without the
GENPD_FLAG_CPU_DOMAIN flag set in the genpd?

> +	/*
> +	 * Find the next wakeup for any of the online CPUs within the PM domain
> +	 * and its subdomains. Note, we only need the genpd->cpus, as it already
> +	 * contains a mask of all CPUs from subdomains.
> +	 */
> +	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> +	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> +		cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
> +		if (ktime_before(cpu_wakeup, domain_wakeup))
> +			domain_wakeup = cpu_wakeup;
> +	}
> +
> +	/* The minimum idle duration is from now - until the next wakeup. */
> +	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
> +	if (idle_duration_ns <= 0)
> +		return false;
> +
> +	/*
> +	 * Find the deepest idle state that has its residency value satisfied
> +	 * and by also taking into account the power off latency for the state.
> +	 * Start at the state picked by the dev PM QoS constraint validation.
> +	 */
> +	i = genpd->state_idx;
> +	do {
> +		if (idle_duration_ns >= (genpd->states[i].residency_ns +
> +		    genpd->states[i].power_off_latency_ns)) {
> +			genpd->state_idx = i;
> +			return true;
> +		}
> +	} while (--i >= 0);
> +
> +	return false;
> +}
> +
>  struct dev_power_governor simple_qos_governor = {
>  	.suspend_ok = default_suspend_ok,
>  	.power_down_ok = default_power_down_ok,
> @@ -257,3 +311,8 @@ struct dev_power_governor pm_domain_always_on_gov = {
>  	.power_down_ok = always_on_power_down_ok,
>  	.suspend_ok = default_suspend_ok,
>  };
> +
> +struct dev_power_governor pm_domain_cpu_gov = {
> +	.suspend_ok = default_suspend_ok,
> +	.power_down_ok = cpu_power_down_ok,
> +};
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 5a4673605d22..969a9b36c0db 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -116,6 +116,7 @@ struct generic_pm_domain {
>  	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
>  	bool max_off_time_changed;
>  	bool cached_power_down_ok;
> +	bool cached_power_down_state_idx;
>  	int (*attach_dev)(struct generic_pm_domain *domain,
>  			  struct device *dev);
>  	void (*detach_dev)(struct generic_pm_domain *domain,
> @@ -195,6 +196,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> +extern struct dev_power_governor pm_domain_cpu_gov;
>  #else
>  
>  static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
> @@ -238,6 +240,7 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>  
>  #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
> +#define pm_domain_cpu_gov		(*(struct dev_power_governor *)(NULL))
>  #endif
>  
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
