From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v1 5/8] sched/cpufreq_schedutil: always consider all
 CPUs when deciding next freq
Date: Tue, 11 Jul 2017 18:18:34 +0100
Message-ID: <20170711171834.7kldjsjg7utsc2jl@e106622-lin>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-6-juri.lelli@arm.com>
 <20170711161731.plbzv42yv7l66fwh@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47492 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753681AbdGKRSl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Jul 2017 13:18:41 -0400
Content-Disposition: inline
In-Reply-To: <20170711161731.plbzv42yv7l66fwh@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 11/07/17 18:17, Peter Zijlstra wrote:
> On Wed, Jul 05, 2017 at 09:59:02AM +0100, Juri Lelli wrote:
> >  		delta_ns = time - j_sg_cpu->last_update;
> >  		if (delta_ns > TICK_NSEC) {
> >  			j_sg_cpu->iowait_boost = 0;
> > -			continue;
> > +			j_sg_cpu->util_cfs = 0;
> 
> this is slighly confusing. Is this because we might not 'continue' with
> the new code?
> 

This is because, after TICK_NSEC, we only want to discard CFS
contribution and (yes) continue (so don't take into account
j_sg_cpu contribution) if DEADLINE contribution is zero as well.

> > +			if (j_sg_cpu->util_dl == 0)
> > +				continue;
> >  		}
> > +

With this change we might not continue if some DEADLINE utilization is
present for j_sg_cpu.

> >  		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
> >  			return policy->cpuinfo.max_freq;
> >  
> > -- 
> > 2.11.0
> > 
