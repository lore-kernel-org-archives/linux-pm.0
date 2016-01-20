From: Juri Lelli <Juri.Lelli@arm.com>
Subject: Re: sched-freq locking
Date: Wed, 20 Jan 2016 15:58:29 +0000
Message-ID: <20160120155829.GV8573@e106622-lin>
References: <569D568D.5000500@linaro.org>
 <CAEG3pNDoDHpgO7WdC8n7C8Ri+KNKZqOi9rKHMkTV0c5dkyevOw@mail.gmail.com>
 <CAKfTPtCYUWBm_=GQ-NLLZ01xJqG+83vy4uapxRLjqMx_61HSew@mail.gmail.com>
 <569E90CF.9050503@linaro.org>
 <CAEG3pND5kHqJhrvwVjsnCnfT-nSrV8SrUaNk2p=ZfEx0MmmB=A@mail.gmail.com>
 <569EB225.4040707@linaro.org>
 <CAEG3pNBgpsdX8Lk7_3nHd31_bsq2sLB_f+=4_xiFFbiAWiKsxg@mail.gmail.com>
 <569EE1E1.3050407@linaro.org>
 <20160120121801.GR8573@e106622-lin>
 <569F9EB3.60600@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46226 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933838AbcATP6C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Jan 2016 10:58:02 -0500
Content-Disposition: inline
In-Reply-To: <569F9EB3.60600@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

On 20/01/16 06:50, Steve Muckle wrote:
> On 01/20/2016 04:18 AM, Juri Lelli wrote:
> > I fear that caching could break thermal. If everybody was already using
> > sched-freq interface to control frequency this won't probably be a
> > problem, but we are not yet there :(. So, IIUC by caching policy->max,
> > for example, we might affect what thermal expects from cpufreq.
> 
> I think we could probably just access policy->max without rwsem, as long
> as we ensure policy is valid. Cpufreq will take care to cap a frequency
> request to an upper limit put in by thermal anyway so I don't think it's
> a problematic race. But I haven't spent much time thinking about it.
> 

Mmm, can't the fact that the scheduler might think it can still request
a frequency above max be problematic?

Anyway, thermal seems to use cpufreq_set_policy() for changing max (if I
got it right Punit :)), so we might be able to intercept such sites and
do proper update of cached values.

> >
> ...
> >> Done (added linux-pm, PeterZ and Rafael as well).
> >>
> > 
> > This discussion is pretty interesting, yes. I'm a bit afraid people
> > bumped into this might have troubles understanding context, though.
> > And I'm not sure how to give them that context; maybe start a new thread
> > summarizing what has been discussed so far?
> 
> Yeah, that occurred to me as well. I wasn't sure whether to restart the
> thread or put in the locking I had in mind and just send it with the
> next schedfreq RFC series, which should be in the next few weeks. I was
> going to do the latter but here is a recap of the topic from my side:
> 

Thanks a lot for writing this down!

> Currently schedfreq has to go through two stages of aggregation. The
> first is aggregating the capacity request votes from the different sched
> classes within a CPU. The second is aggregating the capacity request
> votes from the CPUs within a frequency domain. I'm looking to solve the
> locking issues with both of these stages as well as those with calling
> into cpufreq in the fast path.
> 
> For the first stage, currently we assume that the rq lock is held. This
> is the case for the existing calls into schedfreq (the load balancer
> required a minor change). There are a few more hooks that need to go
> into migration paths in core.c which will be slightly more painful, but
> they are IMO doable.
> 
> For the second stage I believe an internal schedfreq spinlock is
> required, for one thing to protect against competing updates within the
> same frequency domain from different CPUs, but also so that we can
> guarantee the cpufreq policy is valid, which can be done if the
> governor_start/stop callbacks take the spinlock as well.
> 

Does this need to nest within the rq lock?

> As for accessing various things in cpufreq->policy and trying to take
> rwsem in the fast path, we should be able to either cache some of the
> items in the governor_start() path, eliminate the references, or access
> them without locking rwsem (as long as we know the policy is valid,

If we only need to guarantee existence of the policy, without any direct
updates, RCU might be a good fit.

> which we do by taking the spinlock in governor_start()). Here are the
> things we currently reference in the schedfreq set capacity hook and my
> thoughts on each of them:
> 
> policy->governor: this is currently tested to see if schedfreq is
> enabled, but this can be tracked internally to schedfreq and set in the
> governor_start/stop callbacks
> 
> policy->governor_data: used to access schedfreq's data for the policy,
> could be changed to an internal schedfreq percpu pointer
> 
> policy->cpus, policy->freq_table: these can be cached internally to
> schedfreq on governor_start/stop
> 
> policy->max: as mentioned above I *think* we could get away with
> accessing this without locking rwsem as discussed above
> 
> policy->transition_ongoing: this isn't strictly required as schedfreq
> could track internally whether it has a transition outstanding, but we
> should also be okay to look at this without policy->rwsem since
> schedfreq is the only one queuing transitions, again assuming we take
> care to ensure policy is valid as above
> 
> Finally when actually requesting a frequency change in the fast path, we
> can trylock policy->rwsem and fall back to the slow path (kthread) if
> that fails.
> 

OTOH, all the needed aggregation could make the fast path not so fast in
the end. So, maybe having a fast and a slow path is always good?

Thanks,

- Juri
