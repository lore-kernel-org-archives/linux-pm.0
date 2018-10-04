From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from
 menu_select()
Date: Thu, 4 Oct 2018 09:46:27 +0200
Message-ID: <20181004074627.GE19272@hirez.programming.kicks-ass.net>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <4130376.2FFt7p4687@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4130376.2FFt7p4687@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
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

Not new in this patch, but this is where I really noticed it; that 20,
should that not be something like: POLL_IDLE_TIME_LIMIT / NSEC_PER_USEC
?

> +				idx = i;
> +				break;
> +			}
>  			if (predicted_us < TICK_USEC)
>  				break;
>  
> 
