From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH][Fix] cpuidle: Run tick_broadcast_exit() with disabled
 interrupts
Date: Thu, 30 Apr 2015 09:17:43 +0530
Message-ID: <5541A5DF.4080700@linux.vnet.ibm.com>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <6185796.9I7OmaAAcQ@vostro.rjw.lan> <5540A981.6060209@arm.com> <2872649.RClMYKns0i@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2872649.RClMYKns0i@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/29/2015 07:37 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 335f49196fd6 (sched/idle: Use explicit broadcast oneshot
> control function) replaced clockevents_notify() invocations in
> cpuidle_idle_call() with direct calls to tick_broadcast_enter()
> and tick_broadcast_exit(), but it overlooked the fact that
> interrupts were already enabled before calling the latter which
> led to functional breakage on systems using idle states with the
> CPUIDLE_FLAG_TIMER_STOP flag set.
> 
> Fix that by moving the invocations of tick_broadcast_enter()
> and tick_broadcast_exit() down into cpuidle_enter_state() where
> interrupts are still disabled when tick_broadcast_exit() is
> called.  Also ensure that interrupts will be disabled before
> running tick_broadcast_exit() even if they have been enabled by
> the idle state's ->enter callback.  Trigger a WARN_ON_ONCE() in
> that case, as we generally don't want that to happen for states
> with CPUIDLE_FLAG_TIMER_STOP set.
> 
> Fixes: 335f49196fd6 (sched/idle: Use explicit broadcast oneshot control function)
> Reported-and-tested-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-and-tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Thanks for the testing and ACKs, here it goes again with all tags and
> a changelog.
> 
> If anything is missing/incorrect, please let me know ASAP as I'm going to
> push this to Linus in a couple of days.
> 
> ---
>  drivers/cpuidle/cpuidle.c |   16 ++++++++++++++++
>  kernel/sched/idle.c       |   16 ++--------------
>  2 files changed, 18 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -81,7 +81,6 @@ static void cpuidle_idle_call(void)
>  	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>  	int next_state, entered_state;
> -	unsigned int broadcast;
>  	bool reflect;
> 
>  	/*
> @@ -150,17 +149,6 @@ static void cpuidle_idle_call(void)
>  		goto exit_idle;
>  	}
> 
> -	broadcast = drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP;
> -
> -	/*
> -	 * Tell the time framework to switch to a broadcast timer
> -	 * because our local timer will be shutdown. If a local timer
> -	 * is used from another cpu as a broadcast timer, this call may
> -	 * fail if it is not available
> -	 */
> -	if (broadcast && tick_broadcast_enter())
> -		goto use_default;
> -
>  	/* Take note of the planned idle state. */
>  	idle_set_state(this_rq(), &drv->states[next_state]);
> 
> @@ -174,8 +162,8 @@ static void cpuidle_idle_call(void)
>  	/* The cpu is no longer idle or about to enter idle. */
>  	idle_set_state(this_rq(), NULL);
> 
> -	if (broadcast)
> -		tick_broadcast_exit();
> +	if (entered_state == -EBUSY)
> +		goto use_default;
> 
>  	/*
>  	 * Give the governor an opportunity to reflect on the outcome
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -158,9 +158,18 @@ int cpuidle_enter_state(struct cpuidle_d
>  	int entered_state;
> 
>  	struct cpuidle_state *target_state = &drv->states[index];
> +	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>  	ktime_t time_start, time_end;
>  	s64 diff;
> 
> +	/*
> +	 * Tell the time framework to switch to a broadcast timer because our
> +	 * local timer will be shut down.  If a local timer is used from another
> +	 * CPU as a broadcast timer, this call may fail if it is not available.
> +	 */
> +	if (broadcast && tick_broadcast_enter())
> +		return -EBUSY;
> +
>  	trace_cpu_idle_rcuidle(index, dev->cpu);
>  	time_start = ktime_get();
> 
> @@ -169,6 +178,13 @@ int cpuidle_enter_state(struct cpuidle_d
>  	time_end = ktime_get();
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> 
> +	if (broadcast) {
> +		if (WARN_ON_ONCE(!irqs_disabled()))
> +			local_irq_disable();
> +
> +		tick_broadcast_exit();
> +	}
> +
>  	if (!cpuidle_state_is_coupled(dev, drv, entered_state))
>  		local_irq_enable();
> 

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

