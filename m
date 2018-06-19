From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Tue, 19 Jun 2018 18:20:42 +0200
Message-ID: <20180619162042.GT2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180619122632.GS2458@hirez.programming.kicks-ass.net>
 <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619132449.GA17720@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 19, 2018 at 02:24:49PM +0100, Quentin Perret wrote:
> On Tuesday 19 Jun 2018 at 14:26:32 (+0200), Peter Zijlstra wrote:

> > I'm confused by this patch,... what does it do? Why is em_cpu_get()
> > (after you fix it) not sufficient?
> 
> Hmm, so maybe the confusing part is that this patch does two things:
> 1. it checks all conditions for starting EAS are met
>   (SD_ASYM_CPUCAPACITY is set, the EM covers all online CPUs, the EM
>   isn't too complex to be used during wakeup);
> 2. it builds a list of frequency domains for the private use of the
>    scheduler in latency sensitive code paths,
  3. and sets the static key

> So I guess your question is more about 2. It is nice to have a list of
> frequency domains because that makes iteration over frequency domains
> in the wake-up path very easy, and efficient (for_each_freq_domain() is
> used in find_energy_efficient_cpu() and compute_energy(), patches 07 and
> 09/10).
> And also, by making the scheduler maintain that list, we can be more
> hotplug-aware. If you hotplug out all CPUs of a freq domain, the scheduler
> can remove it from its list and have one less element to iterate against.
> The idea was tp remove the unused things on hotplug, just like for
> sched domains.
> 
> I think that not having that list would mean to play with cpumasks in
> find_energy_efficient_cpu() and in compute_energy() to keep track of the
> CPUs we have visited and stuff like that. That's doable but probably more
> complex, and not more efficient, I think.
> 
> Is the overall idea any clearer ?

Right, so I would not do that many things at once. Also be more explicit
about what data structure, and why.

That said, I think the whole for_each_freq_domain() thing as done is
broken. You've completely ignored the arguments to
partition_sched_domains(). What happens if you create partitions right
along the frequency domains?

So you really want an argument to for_each_freq_domain() to indicate
who's frequency domains you want to iterate. And then I think it's
easiest if you hook into build_sched_domains() instead, because you
really want a list per root_domain I suspect (and an empty list if there
is but one entry on).
