From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 14:01:18 +0100
Message-ID: <20171222130118.GO18612@localhost.localdomain>
References: <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
 <20171222100626.7g5yklspjofcp2we@hirez.programming.kicks-ass.net>
 <20171222110206.GA6414@e110439-lin>
 <20171222114618.mlbqdbagrbr7oert@hirez.programming.kicks-ass.net>
 <20171222120737.GA30968@e110439-lin>
 <20171222121954.x3vgj7s6infdox46@hirez.programming.kicks-ass.net>
 <20171222123819.GD30968@e110439-lin>
 <20171222124308.GN18612@localhost.localdomain>
 <20171222125048.GE30968@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40220 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbdLVNBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 08:01:23 -0500
Received: by mail-wr0-f195.google.com with SMTP id p17so4136052wre.7
        for <linux-pm@vger.kernel.org>; Fri, 22 Dec 2017 05:01:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171222125048.GE30968@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 22/12/17 12:50, Patrick Bellasi wrote:
> On 22-Dec 13:43, Juri Lelli wrote:
> > On 22/12/17 12:38, Patrick Bellasi wrote:
> > > On 22-Dec 13:19, Peter Zijlstra wrote:
> > > > On Fri, Dec 22, 2017 at 12:07:37PM +0000, Patrick Bellasi wrote:
> > > > > > I was thinking that since dl is a 'global' scheduler the reservation
> > > > > > would be too and thus the freq just needs a single CPU to be observed;
> > > > > 
> > > > > AFAIU global is only the admission control (which is something worth a
> > > > > thread by itself...) while the dl_se->dl_bw are aggregated into the
> > > > > dl_rq->running_bw, which ultimately represents the DL bandwidth
> > > > > required for just a CPU.
> > > > 
> > > > Oh urgh yes, forgot that.. then the dl freq stuff isn't strictly correct
> > > > I think. But yes, that's another thread.
> > > 
> > > Mmm... maybe I don't get your point... I was referring to the global
> > > admission control of DL. If you have for example 3 60% DL tasks on a
> > > 2CPU system, AFAIU the CBS will allow the tasks in the system (since
> > > the overall utilization is 180 < 200 * 0.95) although that workload is
> > > not necessarily schedule (for example if the tasks wakeups at the
> > > same time one of them will miss its deadline).
> > > 
> > > But, yeah... maybe I'm completely wrong or, in any case, it's for a
> > > different thread...
> > > 
> > > > > > but I suppose there's nothing stopping anybody from splitting a clock
> > > > > > domain down the middle scheduling wise. So yes, good point.
> > > > > 
> > > > > That makes sense... moreover, using the global utilization, we would
> > > > > end up asking for capacities which cannot be provided by a single CPU.
> > > > 
> > > > Yes, but that _should_ not be a problem if you clock them all high
> > > > enough. But this gets to be complicated real fast I think.
> > > 
> > > IMO the current solution with Juri's patches is working as expected:
> > > we know how many DL tasks are runnable on a CPU and we properly
> > > account for their utilization.
> > > 
> > > The only "issue/limitation" is (eventually) the case described above.
> > > Dunno if we can enqueue 2 60% DL tasks on the same CPU... in that case
> > > we will ask for 120% Utilization?
> > 
> > In general it depends on the other parameters, deadline and period.
> 
> Right, but what about the case dealdine==period, with 60% utilization?
> AFAIU, 3 DL tasks with same parameters like above will be accepted on
> a 2 CPU system, isn't it?
> 
> And thus, in that case, we can end up with a 120% utlization request
> from DL for a single CPU... but, considering it's lunch o'clock,
> I'm likely missing something...

Nope. CBS on SMP only gives you bounded tardiness (at least with the AC
kernel does). Some deadlines might be missed.
