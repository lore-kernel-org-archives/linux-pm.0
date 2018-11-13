From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v5 06/15] sched/core: uclamp: enforce last task UCLAMP_MAX
Date: Tue, 13 Nov 2018 07:14:24 -0800
Message-ID: <20181113151424.GB7681@darkstar>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-8-patrick.bellasi@arm.com>
 <20181111170848.GB3038@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181111170848.GB3038@worktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 11-Nov 18:08, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:33:01PM +0000, Patrick Bellasi wrote:
> > When a util_max clamped task sleeps, its clamp constraints are removed
> > from the CPU. However, the blocked utilization on that CPU can still be
> > higher than the max clamp value enforced while that task was running.
> > 
> > The release of a util_max clamp when a CPU is going to be idle could
> > thus allow unwanted CPU frequency increases while tasks are not
> > running. This can happen, for example, when a frequency update is
> > triggered from another CPU of the same frequency domain.
> > In this case, when we aggregate the utilization of all the CPUs in a
> > shared frequency domain, schedutil can still see the full not clamped
> > blocked utilization of all the CPUs and thus, eventually, increase the
> > frequency.
> 
> > @@ -810,6 +811,28 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id)
> >  		if (max_value >= SCHED_CAPACITY_SCALE)
> >  			break;
> >  	}
> > +
> > +	/*
> > +	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
> > +	 * task, we want to keep the CPU clamped to the last task's clamp
> > +	 * value. This is to avoid frequency spikes to MAX when one CPU, with
> > +	 * an high blocked utilization, sleeps and another CPU, in the same
> > +	 * frequency domain, do not see anymore the clamp on the first CPU.
> > +	 *
> > +	 * The UCLAMP_FLAG_IDLE is set whenever we detect, from the above
> > +	 * loop, that there are no more RUNNABLE taks on that CPU.
> > +	 * In this case we enforce the CPU util_max to that of the last
> > +	 * dequeued task.
> > +	 */
> > +	if (max_value < 0) {
> > +		if (clamp_id == UCLAMP_MAX) {
> > +			rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
> > +			max_value = last_clamp_value;
> > +		} else {
> > +			max_value = uclamp_none(UCLAMP_MIN);
> > +		}
> > +	}
> > +
> >  	rq->uclamp.value[clamp_id] = max_value;
> >  }
> 
> *groan*, so it could be jet-lag, but I find the comment really hard to
> understand.
> 
> Would not something like:
> 
> 	/*
> 	 * Avoid blocked utilization pushing up the frequency when we go
> 	 * idle (which drops the max-clamp) by retaining the last known
> 	 * max-clamp.
> 	 */
> 
> Be more clear?

It works: short and effective... will update in v6.

Thanks.

-- 
#include <best/regards.h>

Patrick Bellasi
