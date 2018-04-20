From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Date: Fri, 20 Apr 2018 15:51:20 +0100
Message-ID: <20180420145120.GC14391@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180418092316.GB15682@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180418092316.GB15682@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 18 Apr 2018 at 17:23:16 (+0800), Leo Yan wrote:
> On Fri, Apr 06, 2018 at 04:36:05PM +0100, Dietmar Eggemann wrote:
> 
> [...]
> 
> > +/*
> > + * Estimates the system level energy assuming that p wakes-up on dst_cpu.
> > + *
> > + * compute_energy() is safe to call only if an energy model is available for
> > + * the platform, which is when sched_energy_enabled() is true.
> > + */
> > +static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> > +{
> > +	unsigned long util, max_util, sum_util;
> > +	struct capacity_state *cs;
> > +	unsigned long energy = 0;
> > +	struct freq_domain *fd;
> > +	int cpu;
> > +
> > +	for_each_freq_domain(fd) {
> > +		max_util = sum_util = 0;
> > +		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {
> > +			util = cpu_util_next(cpu, p, dst_cpu);
> > +			util += cpu_util_dl(cpu_rq(cpu));
> > +			max_util = max(util, max_util);
> > +			sum_util += util;
> > +		}
> > +
> > +		/*
> > +		 * Here we assume that the capacity states of CPUs belonging to
> > +		 * the same frequency domains are shared. Hence, we look at the
> > +		 * capacity state of the first CPU and re-use it for all.
> > +		 */
> > +		cpu = cpumask_first(freq_domain_span(fd));
> > +		cs = find_cap_state(cpu, max_util);
> > +		energy += cs->power * sum_util / cs->cap;
> 
> I am a bit worry about the resolution issue, especially when the
> capacity value is a quite high value and sum_util is a minor value.

Good point. As of now, the cs->power values happen to be in micro-watts
for the platforms we've been testing with, so they're typically high
enough to avoid significant resolution problem I guess.

Now, the energy model code has to be reworked significantly as we have
to remove the dependency on PM_OPP, so I'll try to make sure to keep
this issue in mind for the next version.

Thanks,
Quentin
