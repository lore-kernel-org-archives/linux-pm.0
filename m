From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from
 menu_select()
Date: Thu, 4 Oct 2018 16:51:17 +0200
Message-ID: <20181004145116.GB1881@mai>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <4130376.2FFt7p4687@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4130376.2FFt7p4687@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rearrange the code in menu_select() so that the loop over idle states
> always starts from 0 and get rid of the first_idx variable.
> 
> While at it, add two empty lines to separate conditional statements
> one another.
> 
> No intentional behavior changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

This code is becoming a bit complex to follow :/

May be I missed something, but it is not possible to enter the condition without
idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
FLAG_POLLING))

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/cpuidle/governors/menu.c |   32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> Index: linux-pm/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-pm.orig/drivers/cpuidle/governors/menu.c
> +++ linux-pm/drivers/cpuidle/governors/menu.c
> @@ -285,7 +285,6 @@ static int menu_select(struct cpuidle_dr
>  	struct menu_device *data = this_cpu_ptr(&menu_devices);
>  	int latency_req = cpuidle_governor_latency_req(dev->cpu);
>  	int i;
> -	int first_idx;
>  	int idx;
>  	unsigned int interactivity_req;
>  	unsigned int expected_interval;
> @@ -348,36 +347,33 @@ static int menu_select(struct cpuidle_dr
>  			latency_req = interactivity_req;
>  	}
>  
> -	first_idx = 0;
> -	if (drv->states[0].flags & CPUIDLE_FLAG_POLLING) {
> -		struct cpuidle_state *s = &drv->states[1];
> -		unsigned int polling_threshold;
> -
> -		/*
> -		 * Default to a physical idle state, not to busy polling, unless
> -		 * a timer is going to trigger really really soon.
> -		 */
> -		polling_threshold = max_t(unsigned int, 20, s->target_residency);
> -		if (data->next_timer_us > polling_threshold &&
> -		    latency_req > s->exit_latency && !s->disabled &&
> -		    !dev->states_usage[1].disable)
> -			first_idx = 1;
> -	}
> -
>  	/*
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
>  	 */
>  	idx = -1;
> -	for (i = first_idx; i < drv->state_count; i++) {
> +	for (i = 0; i < drv->state_count; i++) {
>  		struct cpuidle_state *s = &drv->states[i];
>  		struct cpuidle_state_usage *su = &dev->states_usage[i];
>  
>  		if (s->disabled || su->disable)
>  			continue;
> +
>  		if (idx == -1)
>  			idx = i; /* first enabled state */
> +
>  		if (s->target_residency > predicted_us) {
> +			/*
> +			 * Use a physical idle state, not busy polling, unless
> +			 * a timer is going to trigger really really soon.
> +			 */
> +			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
> +			    i == idx + 1 && latency_req > s->exit_latency &&
> +			    data->next_timer_us > max_t(unsigned int, 20,
> +							s->target_residency)) {
> +				idx = i;
> +				break;
> +			}
>  			if (predicted_us < TICK_USEC)
>  				break;
>  
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
