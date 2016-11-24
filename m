From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 1/3] idle: add support for tasks that inject idle
Date: Thu, 24 Nov 2016 12:04:54 +0100
Message-ID: <20161124110454.GA22551@gmail.com>
References: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1479931990-11732-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20161124095016.GD3092@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124095016.GD3092@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 23, 2016 at 12:13:08PM -0800, Jacob Pan wrote:
> > @@ -280,6 +272,58 @@ bool cpu_in_idle(unsigned long pc)
> >  		pc < (unsigned long)__cpuidle_text_end;
> >  }
> >  
> > +static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *hrtimer)
> > +{
> > +	set_tsk_need_resched(current);
> > +	return HRTIMER_NORESTART;
> > +}
> > +
> > +void play_idle(unsigned long duration_ms)
> > +{
> > +	struct hrtimer timer;
> > +	unsigned long end_time;
> > +
> > +	/*
> > +	 * Only FIFO tasks can disable the tick since they don't need the forced
> > +	 * preemption.
> > +	 */
> > +	WARN_ON_ONCE(current->policy != SCHED_FIFO);
> > +	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
> > +	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
> > +	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
> > +
> > +	rcu_sleep_check();
> > +	preempt_disable();
> > +	current->flags |= PF_IDLE;
> > +	cpuidle_use_deepest_state(true);
> > +
> > +	/*
> > +	 * If duration is 0, we will return after a natural wake event occurs. If
> > +	 * duration is none zero, we will go back to sleep if we were woken up earlier.
> > +	 * We also set up a timer to make sure we don't oversleep in deep idle.
> > +	 */
> > +	if (!duration_ms)
> > +		do_idle();
> 
> OK, so that doesn't make any sense, you should not be calling this
> without a timeout.
> 
> > +	else {
> > +		hrtimer_init_on_stack(&timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +		timer.function = idle_inject_timer_fn;
> > +		hrtimer_start(&timer, ms_to_ktime(duration_ms),
> > +			HRTIMER_MODE_REL_PINNED);
> > +		end_time = jiffies + msecs_to_jiffies(duration_ms);
> > +
> > +		while (time_after(end_time, jiffies))
> > +			do_idle();
> > +	}
> > +	hrtimer_cancel(&timer);
> > +
> > +	cpuidle_use_deepest_state(false);
> > +	current->flags &= ~PF_IDLE;
> > +
> > +	preempt_fold_need_resched();
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL_GPL(play_idle);
> 
> 
> How about something like so... (since I had to edit, I fixed up most
> things Ingo complained about as well).
> 
> Note that it doesn't build because of a distinct lack of
> cpuidle_use_deepest_state() in my kernel tree.

Ok, I really like this one, it so much cleaner!

If the patch builds & works:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
