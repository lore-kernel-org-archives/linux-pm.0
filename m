From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH 03/11] sched: Extend scheduler's asym packing
Date: Fri, 26 Aug 2016 11:39:46 +0100
Message-ID: <20160826103945.GC1323@e105550-lin.cambridge.arm.com>
References: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1471559812-19967-4-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20160825112251.GA1323@e105550-lin.cambridge.arm.com>
 <20160825114522.GD10138@twins.programming.kicks-ass.net>
 <20160825131836.GB1323@e105550-lin.cambridge.arm.com>
 <20160825134503.GH10138@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160825134503.GH10138@twins.programming.kicks-ass.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 25, 2016 at 03:45:03PM +0200, Peter Zijlstra wrote:
> On Thu, Aug 25, 2016 at 02:18:37PM +0100, Morten Rasmussen wrote:
> 
> > But why not just pass the customized list into the scheduler? Seems
> > simpler?
> 
> Mostly because I didn't want to regress Power I suppose. The ITMT stuff
> needs an extra load, whereas the Power stuff can use the CPU number we
> already have.

The customized list wouldn't have to be mandatory. You could easily
create a default list that would match current behaviour for Power.

To pass in a custom list of priorities you could either extend struct
sched_domain_topology_level to have another function pointer that
returns the cpu priority, or introduce an arch_cpu_priotity() function.
Either of them could be used in the sched_domain hierarchy to set the
sched_group priority cpu and if you add a rq->cpu_priority, the
asymmetric packing comparison would be a simple comparison between
rq->cpu_priority of the two cpus in question.

What is the 'extra load' needed for ITMT? Isn't it just a priority list,
or does the absolute priority value have a meaning? I only saw it used
for less_than comparison, maybe I missed it.

If you need to express the difference in compute capability, why not use
capacity?

> Also, since we need an interface to pass in this custom list, I don't
> see the distinction, you can do the same manipulation by constantly
> updating the prio list.

Sure, but the overhead of rebuilding the sched_domain hierarchy is huge
compared to just tweaking the result of the less_than operator that get
called from the scheduler frequently. However, updating
group_priority_cpu() would require a rebuild too in this patch set.

> But not of this stuff should be EXPORT'ed, so its only available to the
> core kernel, which greatly limits the potential for abuse. We can see
> arch code just fine.

I don't see why it can't be wired up to be controlled by entities
outside arch code, e.g. cpufreq or the thermal framework, or even code
outside the kernel (firmware).

> And if you spin a custom kernel, you can already wreck the load
> balancer.

You can wreck any software where you have the source code and a compiler
:)
