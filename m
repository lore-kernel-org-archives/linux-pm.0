From: leo.yan@linaro.org
Subject: Re: [PATCH v3] cpuidle: menu: Handle stopped tick more aggressively
Date: Sun, 12 Aug 2018 22:55:15 +0800
Message-ID: <20180812145515.GB28966@leoy-ThinkPad-X240s>
References: <1951009.1jlQfyrxio@aspire.rjw.lan>
 <3174357.2tBMdxG3bF@aspire.rjw.lan>
 <1754612.IcCR94pSYR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1754612.IcCR94pSYR@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 10, 2018 at 01:15:58PM +0200, Rafael J . Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states
> with stopped tick) missed the case when the target residencies of
> deep idle states of CPUs are above the tick boundary which may cause
> the CPU to get stuck in a shallow idle state for a long time.
> 
> Say there are two CPU idle states available: one shallow, with the
> target residency much below the tick boundary and one deep, with
> the target residency significantly above the tick boundary.  In
> that case, if the tick has been stopped already and the expected
> next timer event is relatively far in the future, the governor will
> assume the idle duration to be equal to TICK_USEC and it will select
> the idle state for the CPU accordingly.  However, that will cause the
> shallow state to be selected even though it would have been more
> energy-efficient to select the deep one.
> 
> To address this issue, modify the governor to always assume idle
> duration to be equal to the time till the closest timer event if
> the tick is not running which will cause the selected idle states
> to always match the known CPU wakeup time.
> 
> Also make it always indicate that the tick should be stopped in
> that case for consistency.
> 
> Fixes: 87c9fe6ee495 (cpuidle: menu: Avoid selecting shallow states with stopped tick)
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2: Initialize first_idx properly in the stopped tick case.
> 
> -> v3: Compute data->bucket before checking whether or not the tick has been
>        stopped already to prevent it from becoming stale.
> 
> ---
>  drivers/cpuidle/governors/menu.c |   55 +++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 30 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -285,9 +285,8 @@ static int menu_select(struct cpuidle_dr
>  {
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
>  	int latency_req = cpuidle_governor_latency_req(dev->cpu);
> -	int i;
> -	int first_idx;
> -	int idx;
> +	int first_idx = 0;
> +	int idx, i;
>  	unsigned int interactivity_req;
>  	unsigned int expected_interval;
>  	unsigned long nr_iowaiters, cpu_load;
> @@ -311,6 +310,18 @@ static int menu_select(struct cpuidle_dr
>  	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
>  
>  	/*
> +	 * If the tick is already stopped, the cost of possible short idle
> +	 * duration misprediction is much higher, because the CPU may be stuck
> +	 * in a shallow idle state for a long time as a result of it.  In that
> +	 * case say we might mispredict and use the known time till the closest
> +	 * timer event for the idle state selection.
> +	 */
> +	if (tick_nohz_tick_stopped()) {
> +		data->predicted_us = ktime_to_us(delta_next);
> +		goto select;
> +	}

I tried this patch at my side, firstly just clarify this patch is okay
for me, but there have other underlying issues I observed the CPU
staying shallow idle state with tick stopped, so just note at here.

>From my understanding, the rational for this patch is we
only use the timer event as the reliable wake up source; if there have
one short timer event then we can select shallow state, otherwise we
also can select deepest idle state for long expired timer.

This means the idle governor needs to know the reliable info for the
timer event, so far I observe there at least have two issues for timer
event delta value cannot be trusted.

The first one issue is caused by timer cancel, I wrote one case for
CPU_0 starting a hrtimer with pinned mode with short expire time and
when the CPU_0 goes to sleep this short timeout timer can let idle
governor selects a shallow state; at the meantime another CPU_1 will
be used to try to cancel the timer, my purpose is to cheat CPU_0 so can
see the CPU_0 staying in shallow state for long time;  it has low
percentage to cancel the timer successfully, but I do see seldomly the
timer can be canceled successfully so CPU_0 will stay in idle for long
time (I cannot explain why the timer cannot be canceled successfully
for every time, this might be another issue?).  This case is tricky,
but it's possible happen in drivers with timer cancel.

Another issue is caused by spurious interrupts; if we review the
function tick_nohz_get_sleep_length(), it uses 'ts->idle_entrytime' to
calculate tick or timer delta, so every time when exit from interrupt
and before enter idle governor, it needs to update
'ts->idle_entrytime'; but for spurious interrupts, it will not call
irq_enter() and irq_exit() pairs, so it doesn't invoke below flows:

  irq_exit()
    `->tick_irq_exit()
         `->tick_nohz_irq_exit()
              `->tick_nohz_start_idle()

As result, after spurious interrupts handling, the idle loop doesn't
update for ts->idle_entrytime so the governor might read back a stale
value.  I don't really locate this issue, but I can see the CPU is
waken up without any interrupt handling and then directly go to
sleep again, the menu governor selects one shallow state so the cpu
stay in shallow state for long time.

> +
> +	/*
>  	 * Force the result of multiplication to be 64 bits even if both
>  	 * operands are 32 bits.
>  	 * Make sure to round up for half microseconds.
> @@ -322,7 +333,6 @@ static int menu_select(struct cpuidle_dr
>  	expected_interval = get_typical_interval(data);
>  	expected_interval = min(expected_interval, data->next_timer_us);
>  
> -	first_idx = 0;
>  	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
>  		struct cpuidle_state *s = &drv->states[1];
>  		unsigned int polling_threshold;
> @@ -344,29 +354,15 @@ static int menu_select(struct cpuidle_dr
>  	 */
>  	data->predicted_us = min(data->predicted_us, expected_interval);
>  
> -	if (tick_nohz_tick_stopped()) {
> -		/*
> -		 * If the tick is already stopped, the cost of possible short
> -		 * idle duration misprediction is much higher, because the CPU
> -		 * may be stuck in a shallow idle state for a long time as a
> -		 * result of it.  In that case say we might mispredict and try
> -		 * to force the CPU into a state for which we would have stopped
> -		 * the tick, unless a timer is going to expire really soon
> -		 * anyway.
> -		 */
> -		if (data->predicted_us < TICK_USEC)
> -			data->predicted_us = min_t(unsigned int, TICK_USEC,
> -						   ktime_to_us(delta_next));
> -	} else {
> -		/*
> -		 * Use the performance multiplier and the user-configurable
> -		 * latency_req to determine the maximum exit latency.
> -		 */
> -		interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> -		if (latency_req > interactivity_req)
> -			latency_req = interactivity_req;
> -	}
> +	/*
> +	 * Use the performance multiplier and the user-configurable latency_req
> +	 * to determine the maximum exit latency.
> +	 */
> +	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> +	if (latency_req > interactivity_req)
> +		latency_req = interactivity_req;
>  
> +select:
>  	expected_interval = data->predicted_us;
>  	/*
>  	 * Find the idle state with the lowest power while satisfying
> @@ -403,14 +399,13 @@ static int menu_select(struct cpuidle_dr
>  	 * Don't stop the tick if the selected state is a polling one or if the
>  	 * expected idle duration is shorter than the tick period length.
>  	 */
> -	if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> -	    expected_interval < TICK_USEC) {
> +	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
> +	    expected_interval < TICK_USEC) && !tick_nohz_tick_stopped()) {
>  		unsigned int delta_next_us = ktime_to_us(delta_next);
>  
>  		*stop_tick = false;
>  
> -		if (!tick_nohz_tick_stopped() && idx > 0 &&
> -		    drv->states[idx].target_residency > delta_next_us) {
> +		if (idx > 0 && drv->states[idx].target_residency > delta_next_us) {
>  			/*
>  			 * The tick is not going to be stopped and the target
>  			 * residency of the state to be returned is not within
> 
