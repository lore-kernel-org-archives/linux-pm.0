From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Wed, 13 Dec 2017 16:36:53 +0000
Message-ID: <20171213163653.GD8264@e110439-lin>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161922.qbxq2ko5q6ttzu2p@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdLMQg6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 Dec 2017 11:36:58 -0500
Content-Disposition: inline
In-Reply-To: <20171213161922.qbxq2ko5q6ttzu2p@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 13-Dec 17:19, Peter Zijlstra wrote:
> On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> > @@ -562,6 +577,12 @@ struct task_struct {
> >  
> >  	const struct sched_class	*sched_class;
> >  	struct sched_entity		se;
> > +	/*
> > +	 * Since we use se.avg.util_avg to update util_est fields,
> > +	 * this last can benefit from being close to se which
> > +	 * also defines se.avg as cache aligned.
> > +	 */
> > +	struct util_est			util_est;
> >  	struct sched_rt_entity		rt;
> >  #ifdef CONFIG_CGROUP_SCHED
> >  	struct task_group		*sched_task_group;
> 
> 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index b19552a212de..8371839075fa 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -444,6 +444,7 @@ struct cfs_rq {
> >  	 * CFS load tracking
> >  	 */
> >  	struct sched_avg avg;
> > +	unsigned long util_est_runnable;
> >  #ifndef CONFIG_64BIT
> >  	u64 load_last_update_time_copy;
> >  #endif
> 
> 
> So you put the util_est in task_struct (not sched_entity) but the
> util_est_runnable in cfs_rq (not rq). Seems inconsistent.

One goal was to keep util_est variables close to the util_avg used to
load the filter, for caches affinity sakes.

The other goal was to have util_est data only for Tasks and CPU's
RQ, thus avoiding unused data for TG's RQ and SE.

Unfortunately the first goal does not allow to achieve completely the
second and, you right, the solution looks a bit inconsistent.

Do you think we should better disregard cache proximity and move
util_est_runnable to rq?

-- 
#include <best/regards.h>

Patrick Bellasi
