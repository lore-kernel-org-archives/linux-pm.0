From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v4 03/12] PM: Introduce an Energy Model management
 framework
Date: Thu, 5 Jul 2018 16:24:38 +0100
Message-ID: <20180705152438.GG32579@e108498-lin.cambridge.arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-4-quentin.perret@arm.com>
 <20180705143151.GN2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705143151.GN2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 05 Jul 2018 at 16:31:51 (+0200), Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:34PM +0100, Quentin Perret wrote:
> > +/**
> > + * em_fd_energy() - Estimates the energy consumed by the CPUs of a freq. domain
> > + * @fd		: frequency domain for which energy has to be estimated
> > + * @max_util	: highest utilization among CPUs of the domain
> > + * @sum_util	: sum of the utilization of all CPUs in the domain
> > + *
> > + * em_fd_energy() dereferences the capacity state table of the frequency
> > + * domain, so it must be called under RCU read lock.
> > + *
> > + * Return: the sum of the energy consumed by the CPUs of the domain assuming
> > + * a capacity state satisfying the max utilization of the domain.
> > + */
> > +static inline unsigned long em_fd_energy(struct em_freq_domain *fd,
> > +				unsigned long max_util, unsigned long sum_util)
> > +{
> > +	struct em_cs_table *cs_table;
> > +	struct em_cap_state *cs;
> > +	unsigned long freq;
> > +	int i;
> > +
> > +	cs_table = rcu_dereference(fd->cs_table);
> > +	if (!cs_table)
> > +		return 0;
> > +
> > +	/* Map the utilization value to a frequency */
> > +	cs = &cs_table->state[cs_table->nr_cap_states - 1];
> > +	freq = map_util_freq(max_util, cs->frequency, cs->capacity);
> > +
> > +	/* Find the lowest capacity state above this frequency */
> > +	for (i = 0; i < cs_table->nr_cap_states; i++) {
> > +		cs = &cs_table->state[i];
> > +		if (cs->frequency >= freq)
> > +			break;
> > +	}
> > +
> > +	return cs->power * sum_util / cs->capacity;
> > +}
> 
> I keep reading @max_util as the highest possible util (iow capacity) of
> the freq domain, instead of the current highest instant capacity across
> the CPUs in the domain.
> 
> At the same time I'm struggling for a better name. Maybe just @util? But
> that would then maybe confuse against @sum_util. argh..

Right, I see your point ... I'm happy to change to 'util' if you prefer.
One can argue that this is more consistent with the 'util' used in
sugov_next_freq_shared() ...

> 
> And I'm confused by what exactly this function computes; are you
> (through sum_util) effectively setting idle power at 0?

Yes, the EM only includes costs for active states, at least for now, so
we don't take idle time into consideration. Extending the model should
be doable later I suppose, as a second step (if proven useful ...).
