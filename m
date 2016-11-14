From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] idle: add support for tasks that inject idle
Date: Mon, 14 Nov 2016 16:01:56 +0100
Message-ID: <20161114150156.GQ3157@twins.programming.kicks-ass.net>
References: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1478718312-12847-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20161114145721.GE3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34132 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbcKNPB4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2016 10:01:56 -0500
Content-Disposition: inline
In-Reply-To: <20161114145721.GE3142@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>

On Mon, Nov 14, 2016 at 03:57:21PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 09, 2016 at 11:05:10AM -0800, Jacob Pan wrote:
> >  static inline bool is_idle_task(const struct task_struct *p)
> >  {
> > -	return p->pid == 0;
> > +	return !!(p->flags & PF_IDLE);
> >  }
> 
> > +void play_idle()
> > +{
> > +	/*
> > +	 * Only FIFO tasks can disable the tick since they don't need the forced
> > +	 * preemption.
> > +	 */
> > +	WARN_ON_ONCE(current->policy != SCHED_FIFO);
> > +	WARN_ON_ONCE(current->nr_cpus_allowed != 1);
> > +	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
> > +	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
> > +	rcu_sleep_check();
> > +
> > +	preempt_disable();
> > +	current->flags |= PF_IDLE;
> > +	do_idle();
> > +	current->flags &= ~PF_IDLE;
> 
> Whoops, that will clear PF_IDLE from the idle thread. Maybe do something
> like:
> 
> 	unsigned int idle_flag = (~current->flags & PF_IDLE)
> 
> 	current->flags |= PF_IDLE;
> 
> 	current->flags ^= idle_flag;
> 
> > +
> > +	preempt_fold_need_resched();
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL_GPL(play_idle);

n/m I cannot read, the actual idle loop below uses do_idle(), not
play_idle.

> > @@ -299,5 +313,7 @@ void cpu_startup_entry(enum cpuhp_state state)
> >  #endif
> >  	arch_cpu_idle_prepare();
> >  	cpuhp_online_idle(state);
> > -	cpu_idle_loop();
> > +	while (1)
> > +		do_idle();
> > +
> >  }
