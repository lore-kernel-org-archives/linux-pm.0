From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/7] sched: Clean up preempt_enable_no_resched() abuse
Date: Wed, 20 Nov 2013 19:15:36 +0100
Message-ID: <20131120181536.GW16796@laptop.programming.kicks-ass.net>
References: <20131120160450.072555619@infradead.org>
 <20131120162736.691879744@infradead.org>
 <528CF94E.8020300@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50411 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab3KTSPr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Nov 2013 13:15:47 -0500
Content-Disposition: inline
In-Reply-To: <528CF94E.8020300@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eliezer Tamir <eliezer.tamir@linux.intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Nov 20, 2013 at 08:02:54PM +0200, Eliezer Tamir wrote:
> On 20/11/2013 18:04, Peter Zijlstra wrote:
> > The only valid use of preempt_enable_no_resched() is if the very next
> > line is schedule() or if we know preemption cannot actually be enabled
> > by that statement due to known more preempt_count 'refs'.
> 
> The reason I used the no resched version is that busy_poll_end_time()
> is almost always called with rcu read lock held, so it seemed the more
> correct option.
> 
> I have no issue with you changing this.

There are options (CONFIG_PREEMPT_RCU) that allow scheduling while
holding rcu_read_lock().

Also, preempt_enable() only schedules when its possible to schedule, so
calling it when you know you cannot schedule is no issue.

> > As to the busy_poll mess; that looks to be completely and utterly
> > broken, sched_clock() can return utter garbage with interrupts enabled
> > (rare but still), it can drift unbounded between CPUs, so if you get
> > preempted/migrated and your new CPU is years behind on the previous
> > CPU we get to busy spin for a _very_ long time. There is a _REASON_
> > sched_clock() warns about preemptability - papering over it with a
> > preempt_disable()/preempt_enable_no_resched() is just terminal brain
> > damage on so many levels.
> 
> IMHO This has been reviewed thoroughly.

At the very least you completely forgot to preserve any of that. The
changelog that introduced it is completely void of anything useful and
the code has a distinct lack of comments.

> When Ben Hutchings voiced concerns I rewrote the code to use time_after,
> so even if you do get switched over to a CPU where the time is random
> you will at most poll another full interval.
> 
> Linus asked me to remove this since it makes us use two time values
> instead of one. see https://lkml.org/lkml/2013/7/8/345.

My brain is fried for today, I'll have a look tomorrow.

But note that with patch 7/7 in place modular code an no longer use
preempt_enable_no_resched(). I'm not sure net/ipv4/tcp.c can be build
modular -- but istr a time when it was.
