From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 06/10] timer: Restructure internal locking
Date: Wed, 19 Apr 2017 09:07:04 +0200
Message-ID: <20170419070704.b6f7cdej4uxxhd5w@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111400.856441536@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51954 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933339AbdDSHHM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 03:07:12 -0400
Content-Disposition: inline
In-Reply-To: <20170418111400.856441536@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Richard Cochran <rcochran@linutronix.de>

On Tue, Apr 18, 2017 at 01:11:08PM +0200, Thomas Gleixner wrote:

> +++ b/kernel/time/timer.c
> @@ -1651,17 +1651,14 @@ void update_process_times(int user_tick)
>  /**
>   * __run_timers - run all expired timers (if any) on this CPU.
>   * @base: the timer vector to be processed.
> + *
> + * Caller must hold the base lock.
>   */
>  static inline void __run_timers(struct timer_base *base)
>  {
>  	struct hlist_head heads[LVL_DEPTH];
>  	int levels;
>  
> -	if (!time_after_eq(jiffies, base->clk))
> -		return;
> -
> -	spin_lock_irq(&base->lock);
> -

	lockdep_assert_held(&base->lock);


Is so ever much more useful than a comment.

>  	while (time_after_eq(jiffies, base->clk)) {
>  
>  		levels = collect_expired_timers(base, heads);
