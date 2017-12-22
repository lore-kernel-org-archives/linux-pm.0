From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 22 Dec 2017 12:46:18 +0100
Message-ID: <20171222114618.mlbqdbagrbr7oert@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220173814.GC22246@localhost.localdomain>
 <20171222100626.7g5yklspjofcp2we@hirez.programming.kicks-ass.net>
 <20171222110206.GA6414@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46508 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbdLVLqd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Dec 2017 06:46:33 -0500
Content-Disposition: inline
In-Reply-To: <20171222110206.GA6414@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Fri, Dec 22, 2017 at 11:02:06AM +0000, Patrick Bellasi wrote:
> > @@ -315,8 +315,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
> >  		unsigned long j_util, j_max;
> >  		s64 delta_ns;
> >  
> > -		if (j_sg_cpu != sg_cpu)
> > -			sugov_get_util(j_sg_cpu);
> > +		if (idle_cpu(j))
> > +			continue;
> 
> That should work to skip IDLE CPUs... however I'm missing where now we
> get the sugov_get_util(j_sg_cpu) for active CPUs. It has been moved
> somewhere else I guess...

No, I'm just an idiot... lemme fix that.

> Moreover, that way don't we completely disregard CFS blocked load for
> IDLE CPUs... as well as DL reserved utilization, which should be
> released only at the 0-lag time?

I was thinking that since dl is a 'global' scheduler the reservation
would be too and thus the freq just needs a single CPU to be observed;
but I suppose there's nothing stopping anybody from splitting a clock
domain down the middle scheduling wise. So yes, good point.

Blergh that'd make a mess of things again.
