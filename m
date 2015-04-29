From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 16/20] sched/idle: Use explicit broadcast oneshot control
 function
Date: Wed, 29 Apr 2015 10:57:24 +0200
Message-ID: <20150429085724.GN5029@twins.programming.kicks-ass.net>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
 <553F920D.6090404@arm.com>
 <2361707.7eGhMTvCz6@vostro.rjw.lan>
 <6185796.9I7OmaAAcQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6185796.9I7OmaAAcQ@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 29, 2015 at 03:04:47AM +0200, Rafael J. Wysocki wrote:
> > Below is the patch I came up with in the meantime.
> > 
> > This moves the "switch to broadcast" timer logic into
> > cpuidle_enter_state() which allows tick_broadcast_exit() to be
> > called directly with interrupts disabled (as required), but
> > it also adds a fallback branch reflecting the 4.0 and earlier
> > behavior for idle states that enable interrupts on exit
> > from their ->enter callbacks.
> > 
> > I'm not aware of any valid cases when CPUIDLE_FLAG_TIMER_STOP can be
> > set for such states, but people may try to add stuff like that in the
> > future, so it's better to catch that (hence the WARN_ON_ONCE) and do
> > our best to handle it gracefully anyway, IMO.
> > 
> > The "if (entered_state == -EBUSY)" check is conservative.  It may
> > be better to do "if (entered_state < 0)" and fall back to the default
> > on all errors, but that's not what we do today (I guess the concern
> > would be "what if the state ->enter returns an error after entering
> > and exiting the idle state, in which case we may miss a wakeup event
> > if we fall back to the default").
> 
> Actually, if my understanding of things is correct (the local clock event
> device cannot go away from under code executed with interrupts disabled
> on the local CPU), the simplified one below should be sufficient.

Afaict both tick_broadcast_{enter,exit}() end up calling
tick_broadcast_oneshot_control() which is serialized with the
tick_broadcast_lock.

But yes, the local device is strictly managed from the local cpu, so any
other CPU wanting to muck with it would have to IPI and therefore
disabling the local IRQs would make it safe.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

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
> 
