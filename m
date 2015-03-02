From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] cpuidle: Clean up fallback handling in
 cpuidle_idle_call()
Date: Mon, 2 Mar 2015 16:05:36 +0000
Message-ID: <20150302160536.GA5515@red-moon>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1809382.kscziWfTPN@vostro.rjw.lan>
 <1882932.aLeaejbmMz@vostro.rjw.lan>
 <49170765.GVk6ROgF6X@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <49170765.GVk6ROgF6X@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 02, 2015 at 02:51:35PM +0000, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the fallback code path in cpuidle_idle_call() to the end of the
> function to avoid jumping to a label in a an if () branch.

Nit: "in an if () branch"

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/idle.c |   29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> Index: linux-pm/kernel/sched/idle.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/idle.c
> +++ linux-pm/kernel/sched/idle.c
> @@ -124,20 +124,8 @@ static void cpuidle_idle_call(void)
>  	 * Fall back to the default arch idle method on errors.
>  	 */
>  	next_state = cpuidle_select(drv, dev);
> -	if (next_state < 0) {
> -use_default:
> -		/*
> -		 * We can't use the cpuidle framework, let's use the default
> -		 * idle routine.
> -		 */
> -		if (current_clr_polling_and_test())
> -			local_irq_enable();
> -		else
> -			arch_cpu_idle();
> -
> -		goto exit_idle;
> -	}
> -
> +	if (next_state < 0)
> +		goto use_default;
>  
>  	/*
>  	 * The idle task must be scheduled, it is pointless to
> @@ -195,6 +183,19 @@ exit_idle:
>  
>  	rcu_idle_exit();
>  	start_critical_timings();
> +	return;
> +
> +use_default:
> +	/*
> +	 * We can't use the cpuidle framework, let's use the default
> +	 * idle routine.
> +	 */
> +	if (current_clr_polling_and_test())
> +		local_irq_enable();
> +	else
> +		arch_cpu_idle();
> +
> +	goto exit_idle;

I wonder whether making the code at label use_default a function saves us
some jumping around, not sure it is worth the churn, your call, I am ok as
it is.

Lorenzo
