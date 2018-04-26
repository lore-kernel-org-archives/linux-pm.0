From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info
 available
Date: Thu, 26 Apr 2018 13:52:43 +0200
Message-ID: <20180426115243.GK4064@hirez.programming.kicks-ass.net>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin>
 <20180411151450.GK4043@hirez.programming.kicks-ass.net>
 <CAKfTPtC+-FR3ZD_t1vkGR2gVoUyxXpE=i4g9zqqLXu4jKKqgUA@mail.gmail.com>
 <20180411153710.GN4082@hirez.programming.kicks-ass.net>
 <20180426111533.GX14248@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180426111533.GX14248@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 26, 2018 at 12:15:33PM +0100, Patrick Bellasi wrote:
> > Yes, these patches predate those, but indeed, now that we age the
> > blocked load consistently it should no longer be required.
> 
> After this discussion, I think there is a general consensus about
> always add sg_cpu->util_cfs in cpufreq_schedutil.c::sugov_aggregate_util.
> 
> Is that right?

Yes I think so. I've been waiting to see the problem with the blocked
load aging patches sorted though. Because if we'd have to revert those
we'd be back to needing the current stuff again.

Luckily it appears Vincent found something there, so fingers crossed.

> For the rest, what this patch proposes is a code reorganization which
> is not required anymore to fix this specific issue but, it's still
> required to fix the other issue reported by Vincent: i.e. util_est is
> not updated before schedutil.
> 
> Thus, I would propose to still keep this refactoring but in the
> context of a different patch to specifically fixes the util_est case.
> 
> If there are not major complains, I'll post a new series in the next
> few days.

Fair enough..
