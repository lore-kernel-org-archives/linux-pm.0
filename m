From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 12:38:19 +0000
Message-ID: <20171222123819.GD30968@e110439-lin>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
 <20171222100626.7g5yklspjofcp2we@hirez.programming.kicks-ass.net>
 <20171222110206.GA6414@e110439-lin>
 <20171222114618.mlbqdbagrbr7oert@hirez.programming.kicks-ass.net>
 <20171222120737.GA30968@e110439-lin>
 <20171222121954.x3vgj7s6infdox46@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755901AbdLVMiY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 Dec 2017 07:38:24 -0500
Content-Disposition: inline
In-Reply-To: <20171222121954.x3vgj7s6infdox46@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 22-Dec 13:19, Peter Zijlstra wrote:
> On Fri, Dec 22, 2017 at 12:07:37PM +0000, Patrick Bellasi wrote:
> > > I was thinking that since dl is a 'global' scheduler the reservation
> > > would be too and thus the freq just needs a single CPU to be observed;
> > 
> > AFAIU global is only the admission control (which is something worth a
> > thread by itself...) while the dl_se->dl_bw are aggregated into the
> > dl_rq->running_bw, which ultimately represents the DL bandwidth
> > required for just a CPU.
> 
> Oh urgh yes, forgot that.. then the dl freq stuff isn't strictly correct
> I think. But yes, that's another thread.

Mmm... maybe I don't get your point... I was referring to the global
admission control of DL. If you have for example 3 60% DL tasks on a
2CPU system, AFAIU the CBS will allow the tasks in the system (since
the overall utilization is 180 < 200 * 0.95) although that workload is
not necessarily schedule (for example if the tasks wakeups at the
same time one of them will miss its deadline).

But, yeah... maybe I'm completely wrong or, in any case, it's for a
different thread...

> > > but I suppose there's nothing stopping anybody from splitting a clock
> > > domain down the middle scheduling wise. So yes, good point.
> > 
> > That makes sense... moreover, using the global utilization, we would
> > end up asking for capacities which cannot be provided by a single CPU.
> 
> Yes, but that _should_ not be a problem if you clock them all high
> enough. But this gets to be complicated real fast I think.

IMO the current solution with Juri's patches is working as expected:
we know how many DL tasks are runnable on a CPU and we properly
account for their utilization.

The only "issue/limitation" is (eventually) the case described above.
Dunno if we can enqueue 2 60% DL tasks on the same CPU... in that case
we will ask for 120% Utilization?

> > > Blergh that'd make a mess of things again.
> > 
> > Actually, looking better at your patch: are we not just ok with that?
> > 
> > I mean, we don't need this check on idle_cpu since in
> > sugov_aggregate_util we already skip the util=sg_cpu->max in case of
> > !rq->rt.rt_nr_running, while we aggregate just CFS and DL requests.
> 
> Right, well, I don't actually have an environment to test this sanely,
> so someone will have to go play with the various variations and see what
> works.

Definitively, we have some synthetics for mainline... as well as we
can easily backport this series to v4.9 and test for power/perf using
a full Android stack. But, give today is the 22th, I guess we can do
that after holidays (in ~2 weeks).

-- 
#include <best/regards.h>

Patrick Bellasi
