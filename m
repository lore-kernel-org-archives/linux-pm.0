From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 05/10] timer: Retrieve next expiry of
 pinned/non-pinned timers seperately
Date: Wed, 19 Apr 2017 09:05:58 +0200
Message-ID: <20170419070558.eq3rdqyesvstuq4r@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111400.778021491@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:44628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760273AbdDSHGH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 03:06:07 -0400
Content-Disposition: inline
In-Reply-To: <20170418111400.778021491@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>

On Tue, Apr 18, 2017 at 01:11:07PM +0200, Thomas Gleixner wrote:
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1472,23 +1472,27 @@ static u64 cmp_next_hrtimer_event(u64 ba
>   * get_next_timer_interrupt - return the time (clock mono) of the next timer
>   * @basej:	base time jiffies
>   * @basem:	base time clock monotonic
> + * @global_evt:	Pointer to store the expiry time of the next global timer
>   *
>   * Returns the tick aligned clock monotonic time of the next pending
>   * timer or KTIME_MAX if no timer is pending.
>   */
> -u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
> +u64 get_next_timer_interrupt(unsigned long basej, u64 basem, u64 *global_evt)

Another tortured function signature. It seems entirely possible
@global_evt will be the next.


> +
> +	/*
> +	 * If the local queue expires first, there is no requirement for
> +	 * queuing the CPU in the global expiry mechanism.

The comment doesn't make sense... (maybe at this stage)

> +	 */
> +	if (!local_first && !global_empty)
> +		*global_evt = basem + (nextevt_global - basej) * TICK_NSEC;

I was initially thinking !local_first would have to imply !global_empty,
but after going back and reading the previous patches again, I found
this was not so. Still slightly surprising.

> +
> +	return cmp_next_hrtimer_event(basem, local_evt);
>  }
>  
>  /**
> 
> 
