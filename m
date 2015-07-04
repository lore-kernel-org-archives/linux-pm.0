From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] idle: move latency tracing stop/start calls deeper inside the idle loop
Date: Sat, 04 Jul 2015 02:08:54 +0200
Message-ID: <5187102.4yxZOPaqsB@vostro.rjw.lan>
References: <1435933180-5660-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:43319 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755571AbbGCXmd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 19:42:33 -0400
In-Reply-To: <1435933180-5660-1-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, patchwork-lst@pengutronix.de

On Friday, July 03, 2015 04:19:40 PM Lucas Stach wrote:
> Make sure to stop tracing only once we are past a point where all
> latency tracing events have been processed (irqs are not enabled
> again). This has the slight advantage of capturing more latency
> related events in the idle path, but most importantly it makes sure
> that latency tracing doesn't get re-enabled inadvertently when
> new events are coming in.
> 
> This makes the irqsoff latency tracer useful again, as we stop
> capturing CPU sleep time as IRQ latency.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/cpuidle/cpuidle.c |  2 ++
>  kernel/sched/idle.c       | 14 +++++---------
>  2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 61c417b9e53f..d78514ac3f5d 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -173,7 +173,9 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	trace_cpu_idle_rcuidle(index, dev->cpu);
>  	time_start = ktime_get();
>  
> +	stop_critical_timings();
>  	entered_state = target_state->enter(dev, drv, index);
> +	start_critical_timings();
>  
>  	time_end = ktime_get();
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index fefcb1fa5160..30b799bfc3c6 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -93,12 +93,6 @@ static void cpuidle_idle_call(void)
>  	}
>  
>  	/*
> -	 * During the idle period, stop measuring the disabled irqs
> -	 * critical sections latencies
> -	 */
> -	stop_critical_timings();
> -
> -	/*
>  	 * Tell the RCU framework we are entering an idle section,
>  	 * so no more rcu read side critical sections and one more
>  	 * step to the grace period
> @@ -181,7 +175,6 @@ exit_idle:
>  		local_irq_enable();
>  
>  	rcu_idle_exit();
> -	start_critical_timings();

Are you sure we can safely reorder stop/start_critical_timings() with respect
to rcu_idle_enter/exit()?

>  	return;
>  
>  use_default:
> @@ -189,10 +182,13 @@ use_default:
>  	 * We can't use the cpuidle framework, let's use the default
>  	 * idle routine.
>  	 */
> -	if (current_clr_polling_and_test())
> +	if (current_clr_polling_and_test()) {
>  		local_irq_enable();
> -	else
> +	} else {
> +		stop_critical_timings();
>  		arch_cpu_idle();
> +		start_critical_timings();
> +	}
>  
>  	goto exit_idle;
>  }

And what about enter_freeze_proper()?  Don't we need those in there too?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
