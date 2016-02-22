From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 16:42:46 +0100
Message-ID: <20160222154246.GJ6357@twins.programming.kicks-ass.net>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2044559.7ypXocW9OZ@vostro.rjw.lan>
 <3499355.2JlaSruvOa@vostro.rjw.lan>
 <16016177.YFqb4gVNBo@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
 <20160219080917.GE22643@pablo>
 <1455900129.7375.231.camel@linux.intel.com>
 <56C750B7.6090701@linaro.org>
 <20160222105224.GE6356@twins.programming.kicks-ass.net>
 <20160222144001.GG27380@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:53203 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbcBVPmu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2016 10:42:50 -0500
Content-Disposition: inline
In-Reply-To: <20160222144001.GG27380@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Mon, Feb 22, 2016 at 02:40:01PM +0000, Juri Lelli wrote:

> > For one, the migration bits don't really make sense. We typically do not
> > call migration code local on both cpus, typically just one, but possibly
> > neither. That means you cannot actually update the relevant CPU state
> > from these sites anyway.
> > 
> 
> I might actually have one point regarding migrations. See below. And I'm
> not sure I understand why you are saying that we can't update the
> relevant CPU state on migrations; we do know src and dst cpus, don't we?
> 
> [...]
> 
> > @@ -4320,7 +4333,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  		if (cfs_rq_throttled(cfs_rq))
> >  			break;
> >  
> > -		update_load_avg(se, 1);
> > +		update_load_avg(se, 1, LOAD_ENQUEUE + (p->on_rq & TASK_ON_RQ_MIGRATING));
> >  		update_cfs_shares(cfs_rq);
> >  	}
> >  
> > @@ -4380,7 +4393,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  		if (cfs_rq_throttled(cfs_rq))
> >  			break;
> >  
> > -		update_load_avg(se, 1);
> > +		update_load_avg(se, 1, LOAD_DEQUEUE + (p->on_rq & TASK_ON_RQ_MIGRATING));
> >  		update_cfs_shares(cfs_rq);
> >  	}
> >  

Well, yes, you have the src and dst cpu numbers, but if you want to
access that data remotely you'll have to go add atomic ops or locking.

And you'll have to go trigger IPIs to program remote state (or wait for
the next event on the CPU).

That all is expensive.

> What we are trying to do with the sched-freq approach (and maybe that is
> just broken :-/) is to wait until all tasks are detached from src cpu
> and attached to dst cpu to trigger updates on such cpus. I fear that if
> don't do that we might have problems with any sort of rate limiting for
> freq transitions we might need to put in place.

Hurm.. tricky that :-)
