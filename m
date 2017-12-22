From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 13:19:54 +0100
Message-ID: <20171222121954.x3vgj7s6infdox46@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
 <20171222100626.7g5yklspjofcp2we@hirez.programming.kicks-ass.net>
 <20171222110206.GA6414@e110439-lin>
 <20171222114618.mlbqdbagrbr7oert@hirez.programming.kicks-ass.net>
 <20171222120737.GA30968@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46672 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbdLVMUE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 07:20:04 -0500
Content-Disposition: inline
In-Reply-To: <20171222120737.GA30968@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Fri, Dec 22, 2017 at 12:07:37PM +0000, Patrick Bellasi wrote:
> > I was thinking that since dl is a 'global' scheduler the reservation
> > would be too and thus the freq just needs a single CPU to be observed;
> 
> AFAIU global is only the admission control (which is something worth a
> thread by itself...) while the dl_se->dl_bw are aggregated into the
> dl_rq->running_bw, which ultimately represents the DL bandwidth
> required for just a CPU.

Oh urgh yes, forgot that.. then the dl freq stuff isn't strictly correct
I think. But yes, that's another thread.

> > but I suppose there's nothing stopping anybody from splitting a clock
> > domain down the middle scheduling wise. So yes, good point.
> 
> That makes sense... moreover, using the global utilization, we would
> end up asking for capacities which cannot be provided by a single CPU.

Yes, but that _should_ not be a problem if you clock them all high
enough. But this gets to be complicated real fast I think.

> > Blergh that'd make a mess of things again.
> 
> Actually, looking better at your patch: are we not just ok with that?
> 
> I mean, we don't need this check on idle_cpu since in
> sugov_aggregate_util we already skip the util=sg_cpu->max in case of
> !rq->rt.rt_nr_running, while we aggregate just CFS and DL requests.

Right, well, I don't actually have an environment to test this sanely,
so someone will have to go play with the various variations and see what
works.
