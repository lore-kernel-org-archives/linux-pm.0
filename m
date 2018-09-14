From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
Date: Fri, 14 Sep 2018 09:40:52 +0200
Message-ID: <20180914074052.GF24124@hirez.programming.kicks-ass.net>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9611469.2z7W9akjOQ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 14, 2018 at 08:59:03AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a difference in behavior between suspend-to-idle and
> suspend-to-RAM in the timekeeping handling that leads to functional
> issues.  Namely, every iteration of the loop in s2idle_loop()
> increases the monotinic clock somewhat, even if timekeeping_suspend()
> and timekeeping_resume() are invoked from s2idle_enter(), and if
> many of them are carried out in a row, the monotonic clock can grow
> significantly while the system is regarded as suspended, which
> doesn't happen during suspend-to-RAM and so it is unexpected and
> leads to confusion and misbehavior in user space (similar to what
> ensued when we tried to combine the boottime and monotonic clocks).
> 
> To avoid that, count all iterations of the loop in s2idle_loop()
> as "sleep time" and adjust the clock for that on exit from
> suspend-to-idle.
> 
> [That also covers systems on which timekeeping is not suspended
>  by by s2idle_enter().]
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do we want a 'warning' of sorts when the delta becomes significant (for
whatever that is) ? That might be an indication that there are frequent
wakeups which we might not be expecting. Of keep the number of spurious
wakeups in a stat counter somewhere -- something to look at if the
battery drains faster than expected.

Otherwise:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

One minor nit below:

> ---
>  kernel/power/suspend.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -109,8 +109,12 @@ static void s2idle_enter(void)
>  
>  static void s2idle_loop(void)
>  {
> +	ktime_t start, delta;
> +
>  	pm_pr_dbg("suspend-to-idle\n");
>  
> +	start = ktime_get();
> +
>  	for (;;) {
>  		int error;
>  
> @@ -150,6 +154,20 @@ static void s2idle_loop(void)
>  		pm_wakeup_clear(false);
>  	}
>  
> +	/*
> +	 * If the monotonic clock difference between the start of the loop and
> +	 * this point is too large, user space may get confused about whether or
> +	 * not the system has been suspended and tasks may get killed by
> +	 * watchdogs etc., so count the loop as "sleep time" to compensate for
> +	 * that.
> +	 */
> +	delta = ktime_sub(ktime_get(), start);
> +	if (ktime_to_ns(delta) > 0) {
> +		struct timespec64 timespec64_delta = ktime_to_timespec64(delta);
> +
> +		timekeeping_inject_sleeptime64(&timespec64_delta);
> +	}
> +
>  	pm_pr_dbg("resume from suspend-to-idle\n");
>  }

Like I mentioned yesterday; I myself prefer the form:


	u64 stamp = ktimer_get_ns();

	for (;;) {
		/* ... */
	}

	stamp = ktime_get_ns() - stamp;
	if (stamp)
		timekeeping_inject_sleeptime64(ns_to_timespec64(ns));


Esp. since ktime_t _is_ s64 these days, there is no point in keep using
all the weird ktime helpers that make the code harder to read.
