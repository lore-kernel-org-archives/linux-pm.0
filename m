From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] sched: Extend scheduler's asym packing
Date: Fri, 26 Aug 2016 14:42:07 +0200
Message-ID: <20160826124207.GM10121@twins.programming.kicks-ass.net>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160825112251.GA1323@e105550-lin.cambridge.arm.com>
 <20160825114522.GD10138@twins.programming.kicks-ass.net>
 <20160825131836.GB1323@e105550-lin.cambridge.arm.com>
 <20160825134503.GH10138@twins.programming.kicks-ass.net>
 <20160826103945.GC1323@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160826103945.GC1323@e105550-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 26, 2016 at 11:39:46AM +0100, Morten Rasmussen wrote:
> On Thu, Aug 25, 2016 at 03:45:03PM +0200, Peter Zijlstra wrote:
> > On Thu, Aug 25, 2016 at 02:18:37PM +0100, Morten Rasmussen wrote:
> > 
> > > But why not just pass the customized list into the scheduler? Seems
> > > simpler?
> > 
> > Mostly because I didn't want to regress Power I suppose. The ITMT stuff
> > needs an extra load, whereas the Power stuff can use the CPU number we
> > already have.
> 
> The customized list wouldn't have to be mandatory. You could easily
> create a default list that would match current behaviour for Power.

Sure, but then you have the extra load.. probably not an issue but
still.

> What is the 'extra load' needed for ITMT? Isn't it just a priority list,
> or does the absolute priority value have a meaning? I only saw it used
> for less_than comparison, maybe I missed it.

LOAD as in a memop, we need to go fetch the priority from wherever we
put it in memory, be it rq->cpu_priority or a percpu variable on its
own.

> If you need to express the difference in compute capability, why not use
> capacity?

Doesn't work, capacity is actually equal with these things.

Think of one core having more turbo range when thermals allow it. But
the moment you run multiple cores the thermal head-room dissipates and
they all end up running at more or less the same (lower) frequency.

All of this asym/prio stuff only matters when cores (Power) / packages
(Intel) are mostly idle.

On Power SMT0 can go faster than SMT7 when all other siblings are idle,
with ITMT some core can go faster than other when the rest is idle.

I suppose we _could_ model it with a dynamic capacity value, but last
time I looked at that it made my head hurt.

> > Also, since we need an interface to pass in this custom list, I don't
> > see the distinction, you can do the same manipulation by constantly
> > updating the prio list.
> 
> Sure, but the overhead of rebuilding the sched_domain hierarchy is huge
> compared to just tweaking the result of the less_than operator that get
> called from the scheduler frequently. However, updating
> group_priority_cpu() would require a rebuild too in this patch set.

You don't actually need to rebuild the domains to change the priorities.
We only need to rebuild the domains when we add/remove SD_ASYM_PACKING.

Yes, the sched_group::asym_prefer_cpu thing is tedious, but you could
actually update that without a rebuild if one wanted.

Note that there's actually a semi useful use case for dynamically
updating the cpu priorities: core hopping.

  https://www.researchgate.net/publication/279915789_Evaluation_of_Core_Hopping_on_POWER7

Again, that's something only relevant to mostly idle packages.

> > But not of this stuff should be EXPORT'ed, so its only available to the
> > core kernel, which greatly limits the potential for abuse. We can see
> > arch code just fine.
> 
> I don't see why it can't be wired up to be controlled by entities
> outside arch code, e.g. cpufreq or the thermal framework, or even code
> outside the kernel (firmware).

I suppose an arch could do that, but then we'd see that, wouldn't we?

The firmware and kernel would need to co-ordinate where the prio value
lives, which is not something trivially done. And even if the value
lives in rq->cpu_priority, it _could_ do that.


In any case, I don't feel too strongly about this, if you want to stick
the value in rq->cpu_priority and have Power use that we can do that I
suppose.
