From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 14:40:01 +0000
Message-ID: <20160222144001.GG27380@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2044559.7ypXocW9OZ@vostro.rjw.lan>
 <3499355.2JlaSruvOa@vostro.rjw.lan>
 <16016177.YFqb4gVNBo@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
 <20160219080917.GE22643@pablo>
 <1455900129.7375.231.camel@linux.intel.com>
 <56C750B7.6090701@linaro.org>
 <20160222105224.GE6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160222105224.GE6356@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

Hi Peter,

On 22/02/16 11:52, Peter Zijlstra wrote:
> On Fri, Feb 19, 2016 at 09:28:23AM -0800, Steve Muckle wrote:
> > On 02/19/2016 08:42 AM, Srinivas Pandruvada wrote:
> > > We did experiments using util/max in intel_pstate. For some benchmarks
> > > there were regression of 4 to 5%, for some benchmarks it performed at
> > > par with getting utilization from the processor. Further optimization
> > > in the algorithm is possible and still in progress. Idea is that we can
> > > change P-State fast enough and be more reactive. Once I have good data,
> > > I will send to this list. The algorithm can be part of the cpufreq
> > > governor too.
> > 
> > There has been a lot of work in the area of scheduler-driven CPU
> > frequency selection by Linaro and ARM as well. It was posted most
> > recently a couple months ago:
> > 
> > http://thread.gmane.org/gmane.linux.power-management.general/69176
> > 
> > It was also posted as part of the energy-aware scheduling series last
> > July. There's a new RFC series forthcoming which I had hoped (and
> > failed) to post prior to my business travel this week; it should be out
> > next week. It will address the feedback received thus far along with
> > locking and other things.
> 
> Right, so I had a wee look at that again, and had a quick chat with Juri
> on IRC. So the main difference seems to be that you guys want to know
> why the utilization changed, as opposed to purely _that_ it changed.
> 
> And hence you have callbacks all over the place.
> 
> I'm not too sure I really like that too much, it bloats the code and
> somewhat obfuscates the point.
> 
> So I would really like there to be just the one callback when we
> actually compute a new number, and that is update_load_avg().
> 
> Now I think we can 'easily' propagate the information you want into
> update_load_avg() (see below), but I would like to see actual arguments
> for why you would need this.
> 

Right. The information we propagate with your patch might be all we
need, but I'll have to play with it on top of Rafael's or Steve's
changes to fully convince myself. :-)

> For one, the migration bits don't really make sense. We typically do not
> call migration code local on both cpus, typically just one, but possibly
> neither. That means you cannot actually update the relevant CPU state
> from these sites anyway.
> 

I might actually have one point regarding migrations. See below. And I'm
not sure I understand why you are saying that we can't update the
relevant CPU state on migrations; we do know src and dst cpus, don't we?

[...]

> @@ -4320,7 +4333,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		if (cfs_rq_throttled(cfs_rq))
>  			break;
>  
> -		update_load_avg(se, 1);
> +		update_load_avg(se, 1, LOAD_ENQUEUE + (p->on_rq & TASK_ON_RQ_MIGRATING));
>  		update_cfs_shares(cfs_rq);
>  	}
>  
> @@ -4380,7 +4393,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		if (cfs_rq_throttled(cfs_rq))
>  			break;
>  
> -		update_load_avg(se, 1);
> +		update_load_avg(se, 1, LOAD_DEQUEUE + (p->on_rq & TASK_ON_RQ_MIGRATING));
>  		update_cfs_shares(cfs_rq);
>  	}
>  

What we are trying to do with the sched-freq approach (and maybe that is
just broken :-/) is to wait until all tasks are detached from src cpu
and attached to dst cpu to trigger updates on such cpus. I fear that if
don't do that we might have problems with any sort of rate limiting for
freq transitions we might need to put in place.

Best,

- Juri
