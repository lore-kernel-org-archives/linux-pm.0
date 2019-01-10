From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date: Thu, 10 Jan 2019 10:52:59 +0100
Message-ID: <e89ee355-3d87-1fe7-a1ff-91a1dd43177b@linaro.org>
References: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 10/12/2018 12:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add two new metrics for CPU idle states, "above" and "below", to count
> the number of times the given state had been asked for (or entered
> from the kernel's perspective), but the observed idle duration turned
> out to be too short or too long for it (respectively).
> 
> These metrics help to estimate the quality of the CPU idle governor
> in use.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Fix a leftover in the documentation from the previous versions
>        of the patch and a typo in the changelog.
> 
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |    7 ++++
>  Documentation/admin-guide/pm/cpuidle.rst           |   10 ++++++
>  drivers/cpuidle/cpuidle.c                          |   31 ++++++++++++++++++++-
>  drivers/cpuidle/sysfs.c                            |    6 ++++
>  include/linux/cpuidle.h                            |    2 +
>  5 files changed, 55 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -202,7 +202,6 @@ int cpuidle_enter_state(struct cpuidle_d
>  	struct cpuidle_state *target_state = &drv->states[index];
>  	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>  	ktime_t time_start, time_end;
> -	s64 diff;
>  
>  	/*
>  	 * Tell the time framework to switch to a broadcast timer because our
> @@ -248,6 +247,9 @@ int cpuidle_enter_state(struct cpuidle_d
>  		local_irq_enable();
>  
>  	if (entered_state >= 0) {
> +		s64 diff, delay = drv->states[entered_state].exit_latency;
> +		int i;
> +
>  		/*
>  		 * Update cpuidle counters
>  		 * This can be moved to within driver enter routine,
> @@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
>  		dev->last_residency = (int)diff;

Shouldn't we subtract the 'delay' from the computed 'diff' in any case ?

Otherwise the 'last_residency' accumulates the effective sleep time and
the time to wakeup. We are interested in the sleep time only for
prediction and metrics no ?

>  		dev->states_usage[entered_state].time += dev->last_residency;
>  		dev->states_usage[entered_state].usage++;
> +
> +		if (diff < drv->states[entered_state].target_residency) {
> +			for (i = entered_state - 1; i >= 0; i--) {
> +				if (drv->states[i].disabled ||
> +				    dev->states_usage[i].disable)
> +					continue;
> +
> +				/* Shallower states are enabled, so update. */
> +				dev->states_usage[entered_state].above++;
> +				break;
> +			}
> +		} else if (diff > delay) {
> +			for (i = entered_state + 1; i < drv->state_count; i++) {
> +				if (drv->states[i].disabled ||
> +				    dev->states_usage[i].disable)
> +					continue;
> +
> +				/*
> +				 * Update if a deeper state would have been a
> +				 * better match for the observed idle duration.
> +				 */
> +				if (diff - delay >= drv->states[i].target_residency)
> +					dev->states_usage[entered_state].below++;
> +
> +				break;
> +			}
> +		}
>  	} else {


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
