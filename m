From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Date: Thu, 2 Aug 2018 15:08:01 +0200
Message-ID: <20180802130801.GL2494@hirez.programming.kicks-ass.net>
References: <20180724122521.22109-1-quentin.perret@arm.com>
 <20180724122521.22109-10-quentin.perret@arm.com>
 <20180802122629.GU2476@hirez.programming.kicks-ass.net>
 <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180802130337.uf6tlac2hg4nkbwr@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 02, 2018 at 02:03:38PM +0100, Quentin Perret wrote:
> On Thursday 02 Aug 2018 at 14:26:29 (+0200), Peter Zijlstra wrote:
> > On Tue, Jul 24, 2018 at 01:25:16PM +0100, Quentin Perret wrote:
> > > @@ -5100,8 +5118,17 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >  		update_cfs_group(se);
> > >  	}
> > >  
> > > -	if (!se)
> > > +	if (!se) {
> > >  		add_nr_running(rq, 1);
> > > +		/*
> > > +		 * The utilization of a new task is 'wrong' so wait for it
> > > +		 * to build some utilization history before trying to detect
> > > +		 * the overutilized flag.
> > > +		 */
> > > +		if (flags & ENQUEUE_WAKEUP)
> > > +			update_overutilized_status(rq);
> > > +
> > > +	}
> > >  
> > >  	hrtick_update(rq);
> > >  }
> > 
> > That is a somewhat dodgy hack. There is no guarantee what so ever that
> > when the task wakes next its history is any better. The comment doesn't
> > reflect this I feel.
> 
> AFAICT the main use-case here is to avoid re-enabling the load balance
> and ruining all the task placement because of a tiny task. I don't
> really see how we can do that differently ...

Sure I realize that.. but it doesn't completely avoid it. Suppose this
new task instantly blocks and wakes up again. Then its util signal will
be exactly what you didn't want but we'll account it and cause the above
scenario you wanted to avoid.

Now, I suppose in practise it works well enough.

The alternative is trying to track when a running signal has converged,
but that's not a simple problem either I suppose.
