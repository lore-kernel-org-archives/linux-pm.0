From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Date: Tue, 2 Oct 2018 13:54:17 +0100
Message-ID: <20181002125414.aufsalllqf25rwsq@queper01-lin>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002122535.GY3439@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002122535.GY3439@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 Oct 2018 at 14:25:35 (+0200), Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 10:12:58AM +0100, Quentin Perret wrote:
> > +/**
> > + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> > + * @pd		: performance domain for which energy has to be estimated
> > + * @max_util	: highest utilization among CPUs of the domain
> > + * @sum_util	: sum of the utilization of all CPUs in the domain
> > + *
> > + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> > + * a capacity state satisfying the max utilization of the domain.
> > + */
> > +static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
> > +				unsigned long max_util, unsigned long sum_util)
> > +{
> > +	unsigned long freq, scale_cpu;
> > +	struct em_cap_state *cs;
> > +	int i, cpu;
> > +
> > +	/*
> > +	 * In order to predict the capacity state, map the utilization of the
> > +	 * most utilized CPU of the performance domain to a requested frequency,
> > +	 * like schedutil.
> > +	 */
> > +	cpu = cpumask_first(to_cpumask(pd->cpus));
> > +	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> > +	cs = &pd->table[pd->nr_cap_states - 1];
> > +	freq = map_util_freq(max_util, cs->frequency, scale_cpu);
> > +
> > +	/*
> > +	 * Find the lowest capacity state of the Energy Model above the
> > +	 * requested frequency.
> > +	 */
> > +	for (i = 0; i < pd->nr_cap_states; i++) {
> > +		cs = &pd->table[i];
> > +		if (cs->frequency >= freq)
> > +			break;
> > +	}
> > +
> > +	/*
> > +	 * The capacity of a CPU in the domain at that capacity state (cs)
> > +	 * can be computed as:
> > +	 *
> > +	 *             cs->freq * scale_cpu
> > +	 *   cs->cap = --------------------                          (1)
> > +	 *                 cpu_max_freq
> > +	 *
> > +	 * So, the energy consumed by this CPU at that capacity state is:
> > +	 *
> > +	 *             cs->power * cpu_util
> > +	 *   cpu_nrg = --------------------                          (2)
> > +	 *                   cs->cap
> > +	 *
> > +	 * since 'cpu_util / cs->cap' represents its percentage of busy time.
> > +	 *
> > +	 *   NOTE: Although the result of this computation actually is in
> > +	 *         units of power, it can be manipulated as an energy value
> > +	 *         over a scheduling period, since it is assumed to be
> > +	 *         constant during that interval.
> > +	 *
> > +	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
> > +	 * of two terms:
> > +	 *
> > +	 *             cs->power * cpu_max_freq   cpu_util
> > +	 *   cpu_nrg = ------------------------ * ---------          (3)
> > +	 *                    cs->freq            scale_cpu
> > +	 *
> > +	 * The first term is static, and is stored in the em_cap_state struct
> > +	 * as 'cs->cost'.
> > +	 *
> > +	 * Since all CPUs of the domain have the same micro-architecture, they
> > +	 * share the same 'cs->cost', and the same CPU capacity. Hence, the
> > +	 * total energy of the domain (which is the simple sum of the energy of
> > +	 * all of its CPUs) can be factorized as:
> > +	 *
> > +	 *            cs->cost * \Sum cpu_util
> > +	 *   pd_nrg = ------------------------                       (4)
> > +	 *                  scale_cpu
> > +	 */
> > +	return cs->cost * sum_util / scale_cpu;
> > +}
> 
> Should we explicitly mention that this ignores idle costs?

More doc shouldn't hurt so I can add a little something if you feel it's
needed.

Thanks,
Quentin
