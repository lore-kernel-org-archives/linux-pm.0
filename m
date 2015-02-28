From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 0/2] drivers: cpuidle: minor suspend-to-idle fixes
Date: Sat, 28 Feb 2015 11:54:23 +0000
Message-ID: <20150228115422.GA27046@e102568-lin.cambridge.arm.com>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
 <4425438.YlYNQyf1hp@vostro.rjw.lan>
 <20150227100000.GA5975@red-moon>
 <3517340.oYgK5BBDND@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44882 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbbB1Lyc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 28 Feb 2015 06:54:32 -0500
Content-Disposition: inline
In-Reply-To: <3517340.oYgK5BBDND@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>

On Fri, Feb 27, 2015 at 10:11:54PM +0000, Rafael J. Wysocki wrote:
> On Friday, February 27, 2015 10:00:00 AM Lorenzo Pieralisi wrote:
> > [CC'ed Preeti]
> > 
> > On Thu, Feb 26, 2015 at 11:37:54PM +0000, Rafael J. Wysocki wrote:
> > > Me versions of the two $subject patches follow.
> > 
> > Thank you. I am testing them and I have run into the following issue.
> > 
> > Starting with:
> > 
> > 3810631 ("PM / sleep: Re-implement suspend-to-idle handling")
> > 
> > the suspend-to-idle code path in the cpuidle_idle_call() bypasses
> > the CPUIDLE_FLAG_TIMER_STOP code path entirely.
> 
> Hmm, this looks like a mistake.  Sorry about that.

Thank you for looking into this !

> > Now, on most of
> > the current ARM platforms, the deepest idle state loses the tick device
> > context, therefore this means that going to idle through
> > suspend-to-idle becomes a brute force way of nuking the tick,
> > unless I am missing something here.
> > 
> > I am experiencing hangs on resume from suspend-to-idle when the broadcast
> > timer is the broadast-hrtimer (ie there is no HW broadcast timer in the
> > platform) and the deepest idle states lose the tick device context (ie
> > they are CPUIDLE_FLAG_TIMER_STOP), I hope Preeti can help me test this on
> > Power, still chasing the issue.
> > 
> > I could not reproduce the issue with a HW broadcast timer device.
> > 
> > Platform has deepest idle states that allow CPUs shutdown where the
> > local tick device is gone on entry, I am trying to provide you with a
> > backtrace, I need time to debug.
> > 
> > The question I have: is it safe to bypass the CPUIDLE_FLAG_TIMER_STOP
> > and related broadcast mode entry/exit in the suspend-to-idle path ?
> > 
> > I do not think it is, but I am asking.
> 
> It isn't in general, but it would be OK in the enter_freeze_proper() path
> where the tick is suspended anyway.

Entering state through enter_freeze() (ie adding the function pointer
in the idle states, on platforms where it is appropriate), therefore
freezing the tick solves the issue, so I think we should patch all ARM
drivers that can benefit from this interesting new feature.

> > I can "force" tick freeze by initializing the enter_freeze pointer
> > in the idle states (that's the next thing I will test), but still, for
> > platforms where that's not possible my question above is still valid.
> 
> Right.
> 
> Does the patch below help (on top of the previous ones)?

I need HW to test, I will do that first thing on Monday, and send
you the appropriate tags. I already put together a similar patch
and tested it yesterday, so I can say already that it solves the
problem, I will test your patch on Monday and get back to you
(patch 1 and 2 in this series already tested on a platform with no
CPUidle driver registered, and they work and fix the NULL drv
dereference issue).

Thank you !
Lorenzo

> 
> Rafael
> 
> 
> ---
>  drivers/cpuidle/cpuidle.c |   31 ++++++++++++++++++++++++++-----
>  kernel/sched/idle.c       |   17 ++---------------
>  2 files changed, 28 insertions(+), 20 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/cpuidle.c
> +++ linux-pm/drivers/cpuidle/cpuidle.c
> @@ -230,15 +230,36 @@ int cpuidle_select(struct cpuidle_driver
>   * @dev:   the cpuidle device
>   * @index: the index in the idle state table
>   *
> - * Returns the index in the idle state, < 0 in case of error.
> - * The error code depends on the backend driver
> + * Returns the index in the idle state, < 0 in case of error.  -EBUSY is
> + * returned to indicate that the target state was temporarily unavailable.
> + * The other error codes depend on the backend driver.
>   */
>  int cpuidle_enter(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>  		  int index)
>  {
> -	if (cpuidle_state_is_coupled(dev, drv, index))
> -		return cpuidle_enter_state_coupled(dev, drv, index);
> -	return cpuidle_enter_state(dev, drv, index);
> +	unsigned int broadcast;
> +	int ret;
> +
> +	broadcast = drv->states[index].flags & CPUIDLE_FLAG_TIMER_STOP;
> +
> +	/*
> +	 * Tell the time framework to switch to a broadcast timer
> +	 * because our local timer will be shutdown. If a local timer
> +	 * is used from another cpu as a broadcast timer, this call may
> +	 * fail if it is not available
> +	 */
> +	if (broadcast &&
> +	    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu))
> +		return -EBUSY;
> +
> +	ret = cpuidle_state_is_coupled(dev, drv, index) ?
> +		cpuidle_enter_state_coupled(dev, drv, index) :
> +		cpuidle_enter_state(dev, drv, index);
> +
> +	if (broadcast)
> +		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> +
> +	return ret;
>  }
>  
>  /**
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -81,7 +81,6 @@ static void cpuidle_idle_call(void)
>  	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
>  	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>  	int next_state, entered_state;
> -	unsigned int broadcast;
>  
>  	/*
>  	 * Check if the idle task must be rescheduled. If it is the
> @@ -151,18 +150,6 @@ use_default:
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
> -	if (broadcast &&
> -	    clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu))
> -		goto use_default;
> -
>  	/* Take note of the planned idle state. */
>  	idle_set_state(this_rq(), &drv->states[next_state]);
>  
> @@ -176,8 +163,8 @@ use_default:
>  	/* The cpu is no longer idle or about to enter idle. */
>  	idle_set_state(this_rq(), NULL);
>  
> -	if (broadcast)
> -		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
> +	if (entered_state == -EBUSY)
> +		goto use_default;
>  
>  	/*
>  	 * Give the governor an opportunity to reflect on the outcome
> 
> 
> 
