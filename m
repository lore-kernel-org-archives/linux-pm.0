From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] Revert "cpuidle: Replace ktime_get() with local_clock()"
Date: Thu, 20 Apr 2017 15:07:13 +0200
Message-ID: <20170420130713.GD2523@mai>
References: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: ville.syrjala@linux.intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 20, 2017 at 03:44:47PM +0300, ville.syrjala@linux.intel.com wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> This reverts commit e93e59ce5b85e6c2b444f09fd1f707274ec066dc.
> 
> The TSC stops in deeper C states, so using local_clock() in cpuidle
> to track the C state residency seems like a bad idea. With local_clock()
> powertop is reporting mostly 0% residency for C states here. Presumably
> the core is still spending most of its time in some deep C-state since
> the totals typically add up to only 5% or so, so perhaps the governor
> isn't getting totally confused by these bogus numbers. But let's go
> back to using ktime_get() as that at least works correctly across the
> board.

The local clock is faster, more accurate and more stable. We saw ktime_get()
can be expensive, especially on slower CPUs.

Why not add flag for the idle state to tell the local clocksource stops and use
in this case ktime_get() ?

This flag can be set on the idle state at init time in intel_idle.c around:

	...
        if (((mwait_cstate + 1) > 2) &&
              !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
               mark_tsc_unstable("TSC halts in idle"
               " states deeper than C2");
	...

and in processor_idlec.c around:

	...
	tsc_check_state(cx->type);
	...

So we keep using local_clock() in most of the cases, for most of the boards.


 
> Note that the code has changed somewhat since the regression happened,
> so this isn't a 1:1 revert of the offending commit.
> 
> Cc: stable@vger.kernel.org
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/cpuidle/cpuidle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 548b90be7685..24a52805527f 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -213,13 +213,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
>  	sched_idle_set_state(target_state);
>  
>  	trace_cpu_idle_rcuidle(index, dev->cpu);
> -	time_start = ns_to_ktime(local_clock());
> +	time_start = ktime_get();
>  
>  	stop_critical_timings();
>  	entered_state = target_state->enter(dev, drv, index);
>  	start_critical_timings();
>  
> -	time_end = ns_to_ktime(local_clock());
> +	time_end = ktime_get();
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
>  
>  	/* The cpu is no longer idle or about to enter idle. */
> -- 
> 2.10.2
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
