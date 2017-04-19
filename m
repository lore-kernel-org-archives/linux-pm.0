From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 11:20:51 +0200
Message-ID: <20170419092051.rumeh5t7gnd5itap@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:60880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761446AbdDSJU6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 05:20:58 -0400
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> +#ifdef CONFIG_SMP
> +static u64
> +tick_tmigr_idle(struct tick_sched *ts, u64 next_global, u64 next_local)
> +{
> +	ts->tmigr_idle = 1;
> +
> +	/*
> +	 * If next_global is after next_local, event does not have to
> +	 * be queued in the timer migration hierarchy, but cpu needs
> +	 * to be marked as idle.
> +	 */
> +	if (next_global >= next_local)
> +		next_global = KTIME_MAX;
> +
> +	next_global = tmigr_cpu_idle(next_global);
> +
> +	return min_t(u64, next_local, next_global);
> +}
> +
> +static void tick_tmigr_stop_idle(struct tick_sched *ts)
> +{
> +	if (ts->tmigr_idle) {
> +		ts->tmigr_idle = 0;
> +		tmigr_cpu_activate();
> +	}
> +}
> +#else
> +static u64
> +tick_tmigr_idle(struct tick_sched *ts, u64 next_global, u64 next_local)
> +{
> +	return min_t(u64, next_global, next_local);
> +}
> +static inline void tick_tmigr_stop_idle(struct tick_sched *ts) { }
> +#endif /*CONFIG_SMP*/

Naming seems inconsistent with the rest of the file;

  s/tick_tmigr_idle/tick_tmigr_idle_enter/
  s/tick_tmigr_stop_idle/tick_tmigr_idle_exit/

Or something would fit better.
