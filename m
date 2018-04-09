From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Date: Mon, 9 Apr 2018 14:45:11 +0100
Message-ID: <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180409120111.GA4043@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409120111.GA4043@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Monday 09 Apr 2018 at 14:01:11 (+0200), Peter Zijlstra wrote:
> On Tue, Mar 20, 2018 at 09:43:08AM +0000, Dietmar Eggemann wrote:
> > From: Quentin Perret <quentin.perret@arm.com>
> > 
> > The energy consumption of each CPU in the system is modeled with a list
> > of values representing its dissipated power and compute capacity at each
> > available Operating Performance Point (OPP). These values are derived
> > from existing information in the kernel (currently used by the thermal
> > subsystem) and don't require the introduction of new platform-specific
> > tunables. The energy model is also provided with a simple representation
> > of all frequency domains as cpumasks, hence enabling the scheduler to be
> > aware of dependencies between CPUs. The data required to build the energy
> > model is provided by the OPP library which enables an abstract view of
> > the platform from the scheduler. The new data structures holding these
> > models and the routines to populate them are stored in
> > kernel/sched/energy.c.
> > 
> > For the sake of simplicity, it is assumed in the energy model that all
> > CPUs in a frequency domain share the same micro-architecture. As long as
> > this assumption is correct, the energy models of different CPUs belonging
> > to the same frequency domain are equal. Hence, this commit builds only one
> > energy model per frequency domain, and links all relevant CPUs to it in
> > order to save time and memory. If needed for future hardware platforms,
> > relaxing this assumption should imply relatively simple modifications in
> > the code but a significantly higher algorithmic complexity.
> 
> What this doesn't mention is why this isn't part of the regular topology
> bits. IIRC this is because the frequency domains don't necessarily need
> to align with the existing topology, but this completely fails to state
> any of that.

Yes that's the main reason. Frequency domains and scheduling domains don't
necessarily align. That used to be the case for big.LITTLE platforms, but
not anymore with DynamIQ ...

> 
> Also, since I'm not at all familiar with DT and the OPP library stuff,
> this code is completely unreadable to me and there isn't a nice comment
> to help me along.

Right, so I can definitely fix that. Comments in the code and a better
commit message should help hopefully. And also, it has already been
suggested that a documentation file should be added alongside the code
for this patchset, so I'll make sure we add that for the next version.
In the meantime, here is a (hopefully) better explanation below.

In this specific patch, we are basically trying to figure out the
boundaries of frequency domains, and the power consumed by each CPU
at each OPP, to make them available to the scheduler. The important
thing here is that, in both cases, we rely on the OPP library to
keep the code as platform-agnostic as possible.

In the case of the frequency domains for example, the cpufreq driver is
in charge of specifying the CPUs that are sharing frequencies. That
information can come from DT, or SCPI, or SCMI, or whatever -- we
probably shouldn't have to care about that from the scheduler's
standpoint. That's why using dev_pm_opp_get_sharing_cpus() is handy,
the OPP library gives us the digested information we need.

The power values (dev_pm_opp_get_power) we use right now are those
already used by the thermal subsystem (IPA), which means we don't have
to introduce any new DT binding whatsoever. In a close future, the power
values could also come from other sources (SCMI for ex), and again it's
probably not the scheduler's job to care about those things, so the OPP
library is helping us again. As mentioned in the notes, as of today, this
approach has dependencies on other patches relating to these things which
are already on the list [1].

The rest of the code in this patch is just about iterating over the
CPUs/freq. domains/OPPs. The algorithm is more or less the following:

 1. find a frequency domain which hasn't been visited yet;
 2. estimate the power and capacity of a CPU in this freq domain at each
    possible OPP;
 3. map all CPUs in the freq domain to this list of <capacity, power> tuples;
 4. go to 1.

I hope that makes sense.

Thanks,
Quentin

[1] https://marc.info/?l=linux-pm&m=151635516419249&w=2
