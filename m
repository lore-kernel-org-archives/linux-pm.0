From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Fri, 15 Dec 2017 12:03:31 +0000
Message-ID: <20171215120331.GA19821@e110439-lin>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161922.qbxq2ko5q6ttzu2p@hirez.programming.kicks-ass.net>
 <20171213163653.GD8264@e110439-lin>
 <20171213170309.5yk62ipzo3ckpw6o@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755031AbdLOMDj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 07:03:39 -0500
Content-Disposition: inline
In-Reply-To: <20171213170309.5yk62ipzo3ckpw6o@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 13-Dec 18:03, Peter Zijlstra wrote:
> On Wed, Dec 13, 2017 at 04:36:53PM +0000, Patrick Bellasi wrote:
> > On 13-Dec 17:19, Peter Zijlstra wrote:
> > > On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> > > > @@ -562,6 +577,12 @@ struct task_struct {
> > > >  
> > > >  	const struct sched_class	*sched_class;
> > > >  	struct sched_entity		se;
> > > > +	/*
> > > > +	 * Since we use se.avg.util_avg to update util_est fields,
> > > > +	 * this last can benefit from being close to se which
> > > > +	 * also defines se.avg as cache aligned.
> > > > +	 */
> > > > +	struct util_est			util_est;
> 
> The thing is, since sched_entity has a member with cacheline alignment,
> the whole structure must have cacheline alignment, and this util_est
> _will_ start on a new line.

Right, I was not considering that "aligned" affects also the
start of the following data. Thus

> See also:
> 
> $ pahole -EC task_struct defconfig/kernel/sched/core.o
> 
> ...
> 		struct sched_avg {
>                                 /* typedef u64 */ long long unsigned int last_update_time; /*   576     8 */
>                                 /* typedef u64 */ long long unsigned int load_sum;       /*   584     8 */
>                                 /* typedef u32 */ unsigned int util_sum;                 /*   592     4 */
>                                 /* typedef u32 */ unsigned int period_contrib;           /*   596     4 */
>                                 long unsigned int load_avg;                              /*   600     8 */
>                                 long unsigned int util_avg;                              /*   608     8 */
>                         } avg; /*   576    40 */
>                         /* --- cacheline 6 boundary (384 bytes) --- */
>                 } se; /*   192   448 */
>                 /* --- cacheline 8 boundary (512 bytes) was 24 bytes ago --- */
>                 struct util_est {
>                         long unsigned int last;                                          /*   640     8 */
>                         long unsigned int ewma;                                          /*   648     8 */
>                 } util_est; /*   640    16 */
> ...
> 
> The thing is somewhat confused on which cacheline is which, but you'll
> see sched_avg landing at 576 (cacheline #9) and util_est at 640 (line
> #10).
> 
> > > >  	struct sched_rt_entity		rt;
> > > >  #ifdef CONFIG_CGROUP_SCHED
> > > >  	struct task_group		*sched_task_group;
> 
> > One goal was to keep util_est variables close to the util_avg used to
> > load the filter, for caches affinity sakes.
> > 
> > The other goal was to have util_est data only for Tasks and CPU's
> > RQ, thus avoiding unused data for TG's RQ and SE.
> > 
> > Unfortunately the first goal does not allow to achieve completely the
> > second and, you right, the solution looks a bit inconsistent.
> > 
> > Do you think we should better disregard cache proximity and move
> > util_est_runnable to rq?
> 
> proximity is likely important; I'd suggest moving util_est into
> sched_entity.

So, by moving util_est right after sched_avg, here is what we get (with some
lines to better highlight 64B boundaries):

                const struct sched_class  * sched_class;                                 /*   152     8 */
                struct sched_entity {
			[...]
		---[ Line 9 ]-------------------------------------------------------------------------------
                        struct sched_avg {
                                /* typedef u64 */ long long unsigned int last_update_time; /*   576     8 */
                                /* typedef u64 */ long long unsigned int load_sum;       /*   584     8 */
                                /* typedef u64 */ long long unsigned int runnable_load_sum; /*   592     8 */
                                /* typedef u32 */ unsigned int util_sum;                 /*   600     4 */
                                /* typedef u32 */ unsigned int period_contrib;           /*   604     4 */
                                long unsigned int load_avg;                              /*   608     8 */
                                long unsigned int runnable_load_avg;                     /*   616     8 */
                                long unsigned int util_avg;                              /*   624     8 */
                        } avg; /*   576    56 */
                        /* --- cacheline 6 boundary (384 bytes) was 24 bytes ago --- */
                        struct util_est {
                                long unsigned int last;                                  /*   632     8 */
		---[ Line 10 ]------------------------------------------------------------------------------
                                long unsigned int ewma;                                  /*   640     8 */
                        } util_est; /*   632    16 */
                } se; /*   192   512 */
		---[ Line 11 ]------------------------------------------------------------------------------
                /* --- cacheline 9 boundary (576 bytes) was 24 bytes ago --- */
                struct sched_rt_entity {
                        struct list_head {
                                struct list_head * next;                                 /*   704     8 */
                                struct list_head * prev;                                 /*   712     8 */
                        } run_list; /*   704    16 */


As you can see we still end up with util_est spanning acrosss two cache and
even worst with an almost empty Line 10. The point is that sched_avg already
uses 56B... which leave just 8bytes left.

So, I can to move util_est there and use unsigned int for "last" and "ewma"
storage. This should fix the cache alignment but only until we do not add
other stuff to sched_avg.

BTW, should not be possible to use a similar "fasting" approach for load_avg
and runnable_load_avg? Given their range a u32 should be just good enough,
isn't it?

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi
