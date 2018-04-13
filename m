From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Date: Fri, 13 Apr 2018 12:17:53 +0100
Message-ID: <20180413111753.GT14248@e110439-lin>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
 <20180413084019.GQ4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180413084019.GQ4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 13-Apr 10:40, Peter Zijlstra wrote:
> On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> > +static inline void init_uclamp(void)
> 
> WTH is that inline?

You mean I can avoid the attribute?
... or that I should do it in another way?

> > +{
> > +	struct uclamp_cpu *uc_cpu;
> > +	int clamp_id;
> > +	int cpu;
> > +
> > +	mutex_init(&uclamp_mutex);
> > +
> > +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> > +		/* Init CPU's clamp groups */
> > +		for_each_possible_cpu(cpu) {
> > +			uc_cpu = &cpu_rq(cpu)->uclamp[clamp_id];
> > +			memset(uc_cpu, UCLAMP_NONE, sizeof(struct uclamp_cpu));
> > +		}
> > +	}
> 
> Those loops are the wrong way around, this shreds your cache. This is a
> slow path so it doesn't much matter, but it is sloppy.

Yess... my bad!... good catch! ;)

> 
> > +}

-- 
#include <best/regards.h>

Patrick Bellasi
