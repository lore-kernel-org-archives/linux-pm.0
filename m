From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/4] sched/fair: add util_est on top of PELT
Date: Wed, 13 Dec 2017 18:03:09 +0100
Message-ID: <20171213170309.5yk62ipzo3ckpw6o@hirez.programming.kicks-ass.net>
References: <20171205171018.9203-1-patrick.bellasi@arm.com>
 <20171205171018.9203-3-patrick.bellasi@arm.com>
 <20171213161922.qbxq2ko5q6ttzu2p@hirez.programming.kicks-ass.net>
 <20171213163653.GD8264@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753356AbdLMRDP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 12:03:15 -0500
Content-Disposition: inline
In-Reply-To: <20171213163653.GD8264@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Wed, Dec 13, 2017 at 04:36:53PM +0000, Patrick Bellasi wrote:
> On 13-Dec 17:19, Peter Zijlstra wrote:
> > On Tue, Dec 05, 2017 at 05:10:16PM +0000, Patrick Bellasi wrote:
> > > @@ -562,6 +577,12 @@ struct task_struct {
> > >  
> > >  	const struct sched_class	*sched_class;
> > >  	struct sched_entity		se;
> > > +	/*
> > > +	 * Since we use se.avg.util_avg to update util_est fields,
> > > +	 * this last can benefit from being close to se which
> > > +	 * also defines se.avg as cache aligned.
> > > +	 */
> > > +	struct util_est			util_est;

The thing is, since sched_entity has a member with cacheline alignment,
the whole structure must have cacheline alignment, and this util_est
_will_ start on a new line.

See also:

$ pahole -EC task_struct defconfig/kernel/sched/core.o

...
		struct sched_avg {
                                /* typedef u64 */ long long unsigned int last_update_time; /*   576     8 */
                                /* typedef u64 */ long long unsigned int load_sum;       /*   584     8 */
                                /* typedef u32 */ unsigned int util_sum;                 /*   592     4 */
                                /* typedef u32 */ unsigned int period_contrib;           /*   596     4 */
                                long unsigned int load_avg;                              /*   600     8 */
                                long unsigned int util_avg;                              /*   608     8 */
                        } avg; /*   576    40 */
                        /* --- cacheline 6 boundary (384 bytes) --- */
                } se; /*   192   448 */
                /* --- cacheline 8 boundary (512 bytes) was 24 bytes ago --- */
                struct util_est {
                        long unsigned int last;                                          /*   640     8 */
                        long unsigned int ewma;                                          /*   648     8 */
                } util_est; /*   640    16 */
...

The thing is somewhat confused on which cacheline is which, but you'll
see sched_avg landing at 576 (cacheline #9) and util_est at 640 (line
#10).

> > >  	struct sched_rt_entity		rt;
> > >  #ifdef CONFIG_CGROUP_SCHED
> > >  	struct task_group		*sched_task_group;

> One goal was to keep util_est variables close to the util_avg used to
> load the filter, for caches affinity sakes.
> 
> The other goal was to have util_est data only for Tasks and CPU's
> RQ, thus avoiding unused data for TG's RQ and SE.
> 
> Unfortunately the first goal does not allow to achieve completely the
> second and, you right, the solution looks a bit inconsistent.
> 
> Do you think we should better disregard cache proximity and move
> util_est_runnable to rq?

proximity is likely important; I'd suggest moving util_est into
sched_entity.
