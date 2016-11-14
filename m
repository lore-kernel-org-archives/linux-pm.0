From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/3] idle: add support for tasks that inject idle
Date: Mon, 14 Nov 2016 08:20:28 -0800
Message-ID: <20161114082028.6c0ce338@jacob-builder>
References: <1478718312-12847-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1478718312-12847-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20161114150119.GG3142@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54760 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932809AbcKNQSe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Nov 2016 11:18:34 -0500
In-Reply-To: <20161114150119.GG3142@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Arjan van de Ven <arjan@linux.intel.com>, jacob.jun.pan@linux.intel.com

On Mon, 14 Nov 2016 16:01:19 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 09, 2016 at 11:05:10AM -0800, Jacob Pan wrote:
> > +void play_idle()
> > +{
> > +	/*
> > +	 * Only FIFO tasks can disable the tick since they don't
> > need the forced
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
> > +
> > +	preempt_fold_need_resched();
> > +	preempt_enable();
> > +}
> > +EXPORT_SYMBOL_GPL(play_idle);  
> 
> Hurm.. didn't this initially also include the setup of the timer and
> take an timeout argument?

right, the initial version has a timeout and
	init_timer_on_stack(timer);

I thought since this play_idle timer is likely to expire instead of
being canceled, so I switched to hrtimer by caller. We don't have an on
stack hrtimer, right? or Should we consider adding one?

Thanks,

Jacob
