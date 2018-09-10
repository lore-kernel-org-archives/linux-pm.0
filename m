From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Date: Mon, 10 Sep 2018 11:38:05 +0100
Message-ID: <20180910103802.l4zhewxgskchflsa@queper01-lin>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <1866195.ZKEIBQluJJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1866195.ZKEIBQluJJ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 10 Sep 2018 at 11:44:33 (+0200), Rafael J. Wysocki wrote:
> A kerneldoc comment would be useful here IMO.

OK

> > +struct em_cap_state {
> > +	unsigned long frequency; /* Kilo-hertz */
> 
> I wonder if the "frequency" field here could be changed into something a bit
> more abstract like "level" or similar?
> 
> The reason why is because in some cases we may end up with somewhat artificial
> values of "frequency" like when the intel_pstate driver is in use (it uses
> abstract "p-state" values internally and only produces "frequency" numbers for
> the cpufreq core and the way they are derived from the "p-states" is not always
> entirely clean).
> 
> The "level" could just be frequency on systems where cpufreq drivers operate on
> frequencies directly or something else on the other systems.

I see your point (and TBH we start to have same sort of problems on
Arm) but at this stage I would rather keep this field coherent with
what CPUFreq manages, that is, KHz. The only reason for that is because
the thermal subsystem (IPA) will look at this table to apply a max freq
capping on CPUFreq policies, so things need to be aligned.

I agree that even if the unit of this field wasn't specified we could
still build a system that works just fine. However if things are too
loosely specified, problems are allowed to happen, so they will.

Now, if the CPUFreq core is modified to manipulate abstract performance
levels one day, I'll be happy to change the EM framework the same way :-)

> 
> > +	unsigned long power; /* Milli-watts */
> > +	unsigned long cost; /* power * max_frequency / frequency */
> > +};
> > +
> 
> Like above, a kerneldoc comment documenting the structure below would be useful.

OK for that one too.

> > +struct em_perf_domain {
> > +	struct em_cap_state *table; /* Capacity states, in ascending order. */
> > +	int nr_cap_states;
> > +	unsigned long cpus[0]; /* CPUs of the frequency domain. */
> > +};
> > +
> > +#define EM_CPU_MAX_POWER 0xFFFF
> > +
> > +struct em_data_callback {
> > +	/**
> > +	 * active_power() - Provide power at the next capacity state of a CPU
> > +	 * @power	: Active power at the capacity state in mW (modified)
> > +	 * @freq	: Frequency at the capacity state in kHz (modified)
> > +	 * @cpu		: CPU for which we do this operation
> > +	 *
> > +	 * active_power() must find the lowest capacity state of 'cpu' above
> > +	 * 'freq' and update 'power' and 'freq' to the matching active power
> > +	 * and frequency.
> > +	 *
> > +	 * The power is the one of a single CPU in the domain, expressed in
> > +	 * milli-watts. It is expected to fit in the [0, EM_CPU_MAX_POWER]
> > +	 * range.
> > +	 *
> > +	 * Return 0 on success.
> > +	 */
> > +	int (*active_power)(unsigned long *power, unsigned long *freq, int cpu);
> > +};
> > +#define EM_DATA_CB(_active_power_cb) { .active_power = &_active_power_cb }
> > +
> > +struct em_perf_domain *em_cpu_get(int cpu);
> > +int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
> > +						struct em_data_callback *cb);
> > +
> > +/**
> > + * em_pd_energy() - Estimates the energy consumed by the CPUs of a perf. domain
> > + * @pd		: performance domain for which energy has to be estimated
> > + * @max_util	: highest utilization among CPUs of the domain
> > + * @sum_util	: sum of the utilization of all CPUs in the domain
> > + *
> > + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> > + * a capacity state satisfying the max utilization of the domain.
> 
> Well, this confuses energy with power AFAICS.  The comment talks about energy,
> but the return value is in the units of power.
> 
> I guess this assumes constant power over the next scheduling interval, which is
> why energy and power can be treated as equivalent here, but that needs to be
> clarified as it is somewhat confusing right now.

That's right, manipulating power or energy is equivalent here (as in, it
leads to the same conclusions).

I can explain that better in the comment.

Thanks,
Quentin
