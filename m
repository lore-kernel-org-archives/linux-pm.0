From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 1/3] idle: add support for tasks that inject idle
Date: Thu, 24 Nov 2016 05:18:48 +0100
Message-ID: <20161124041848.GB29338@gmail.com>
References: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1479931990-11732-2-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479931990-11732-2-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Idle injection drivers such as Intel powerclamp and ACPI PAD drivers use
> realtime tasks to take control of CPU then inject idle. There are two issues
> with this approach:

'CPU' is capitalized properly here.

And here:

>  #define PF_VCPU		0x00000010	/* I'm a virtual CPU */

But not later in the patch.

> +++ b/kernel/fork.c
> @@ -1819,6 +1819,9 @@ static __latent_entropy struct task_struct *copy_process(
>  	threadgroup_change_end(current);
>  	perf_event_fork(p);
>  
> +	/* do not inherit idle task */
> +	p->flags &= ~PF_IDLE;

Sloppy formulation: how can the idle task be inherited? Also, capitalize comments 
please.

> +	/*
> +	 * If the arch has a polling bit, we maintain an invariant:
> +	 *
> +	 * Our polling bit is clear if we're not scheduled (i.e. if
> +	 * rq->curr != rq->idle).  This means that, if rq->idle has
> +	 * the polling bit set, then setting need_resched is
> +	 * guaranteed to cause the cpu to reschedule.
> +	 */

'CPU' is not properly capitalized here.

> +	/* In poll mode we reenable interrupts and spin.
> +	 * Also if we detected in the wakeup from idle
> +	 * path that the tick broadcast device expired
> +	 * for us, we don't want to go deep idle as we
> +	 * know that the IPI is going to arrive right
> +	 * away
> +	 */
> +		if (cpu_idle_force_poll || tick_check_broadcast_expired())
> +			cpu_idle_poll();
> +		else
> +			cpuidle_idle_call();
> +		arch_cpu_idle_exit();

Sigh: that's not standard comment style, nor is it standard coding style.

Also, multi-sentence comments should end with a full stop.

> +	/*
> +	 * We promise to call sched_ttwu_pending and reschedule
> +	 * if need_resched is set while polling is set.  That
> +	 * means that clearing polling needs to be visible
> +	 * before doing these things.
> +	 */

When referring to functions in comments please spell them as "fn()", i.e. with 
parentheses.

> +	/*
> +	 * If duration is 0, we will return after a natural wake event occurs. If
> +	 * duration is none zero, we will go back to sleep if we were woken up earlier.
> +	 * We also set up a timer to make sure we don't oversleep in deep idle.
> +	 */
> +	if (!duration_ms)
> +		do_idle();
> +	else {
> +		hrtimer_init_on_stack(&timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +		timer.function = idle_inject_timer_fn;
> +		hrtimer_start(&timer, ms_to_ktime(duration_ms),
> +			HRTIMER_MODE_REL_PINNED);
> +		end_time = jiffies + msecs_to_jiffies(duration_ms);
> +
> +		while (time_after(end_time, jiffies))
> +			do_idle();
> +	}

Curly braces should be balanced and nonsensical line breaks should be omitted.

Also, comments should be read and grammar should be fixed.

Thanks,

	Ingo
