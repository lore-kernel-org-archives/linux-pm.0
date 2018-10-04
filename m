From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/6] cpuidle: menu: Fix wakeup statistics updates for
 polling state
Date: Thu, 4 Oct 2018 10:19:32 +0200
Message-ID: <bced15a8-44f2-ea0c-a87c-ac6aae2969ae@linaro.org>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <1561295.epLgDtImU0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1561295.epLgDtImU0@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02/10/2018 23:42, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the CPU exits the "polling" state due to the time limit in the
> loop in poll_idle(), this is not a real wakeup and it just means
> that the "polling" state selection was not adequate.  The governor
> mispredicted short idle duration, but had a more suitable state been
> selected, the CPU might have spent more time in it.  In fact, there
> is no reason to expect that there would have been a wakeup event
> earlier than the next timer in that case.
> 
> Handling such cases as regular wakeups in menu_update() may cause the
> menu governor to make suboptimal decisions going forward, but ignoring
> them altogether would not be correct either, because every time
> menu_select() is invoked, it makes a separate new attempt to predict
> the idle duration taking distinct time to the closest timer event as
> input and the outcomes of all those attempts should be recorded.
> 
> For this reason, make menu_update() always assume that if the
> "polling" state was exited due to the time limit, the next proper
> wakeup event for the CPU would be the next timer event (not
> including the tick).
> 
> Fixes: a37b969a61c1 "cpuidle: poll_state: Add time limit to poll_idle()"
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/cpuidle/governors/menu.c |   10 ++++++++++
>  drivers/cpuidle/poll_state.c     |    6 +++++-
>  include/linux/cpuidle.h          |    1 +
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -511,6 +511,16 @@ static void menu_update(struct cpuidle_d
>  		 * duration predictor do a better job next time.
>  		 */
>  		measured_us = 9 * MAX_INTERESTING / 10;
> +	} else if ((drv->states[last_idx].flags & CPUIDLE_FLAG_POLLING) &&
> +		   dev->poll_time_limit) {
> +		/*
> +		 * The CPU exited the "polling" state due to a time limit, so
> +		 * the idle duration prediction leading to the selection of that
> +		 * state was inaccurate.  If a better prediction had been made,
> +		 * the CPU might have been woken up from idle by the next timer.
> +		 * Assume that to be the case.
> +		 */
> +		measured_us = data->next_timer_us;
>  	} else {
>  		/* measured value */
>  		measured_us = dev->last_residency;
> Index: linux-pm/include/linux/cpuidle.h
> ===================================================================
> --- linux-pm.orig/include/linux/cpuidle.h
> +++ linux-pm/include/linux/cpuidle.h
> @@ -81,6 +81,7 @@ struct cpuidle_device {
>  	unsigned int		registered:1;
>  	unsigned int		enabled:1;
>  	unsigned int		use_deepest_state:1;
> +	unsigned int		poll_time_limit:1;
>  	unsigned int		cpu;
>  
>  	int			last_residency;
> Index: linux-pm/drivers/cpuidle/poll_state.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/poll_state.c
> +++ linux-pm/drivers/cpuidle/poll_state.c
> @@ -17,6 +17,8 @@ static int __cpuidle poll_idle(struct cp
>  {
>  	u64 time_start = local_clock();
>  
> +	dev->poll_time_limit = false;
> +
>  	local_irq_enable();
>  	if (!current_set_polling_and_test()) {
>  		unsigned int loop_count = 0;
> @@ -27,8 +29,10 @@ static int __cpuidle poll_idle(struct cp
>  				continue;
>  
>  			loop_count = 0;
> -			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT)
> +			if (local_clock() - time_start > POLL_IDLE_TIME_LIMIT) {
> +				dev->poll_time_limit = true;
>  				break;
> +			}
>  		}
>  	}
>  	current_clr_polling();
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
