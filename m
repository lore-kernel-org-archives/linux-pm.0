From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Thu, 7 Jun 2018 18:04:19 +0200
Message-ID: <20180607160419.GD3311@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/06/18 16:19, Quentin Perret wrote:
> Hi Juri,
> 
> On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
> > On 21/05/18 15:24, Quentin Perret wrote:

[...]

> > > +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> > > +{
> > > +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> > > +	int max_cap_state = cs_table->nr_cap_states - 1;
> >                  ^
> > You don't need this on the stack, right?
> 
> Oh, why not ?
> 

Because you use it only once here below? Anyway, more a (debatable)
nitpick than anything.

> > > +	unsigned long fmax = cs_table->state[max_cap_state].frequency;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < cs_table->nr_cap_states; i++)
> > > +		cs_table->state[i].capacity = cmax *
> > > +					cs_table->state[i].frequency / fmax;
> > > +}
> > > +
> > > +static struct em_freq_domain *em_create_fd(cpumask_t *span, int nr_states,
> > > +						struct em_data_callback *cb)
> > > +{
> > > +	unsigned long opp_eff, prev_opp_eff = ULONG_MAX;
> > > +	int i, ret, cpu = cpumask_first(span);
> > > +	struct em_freq_domain *fd;
> > > +	unsigned long power, freq;
> > > +
> > > +	if (!cb->active_power)
> > > +		return NULL;
> > > +
> > > +	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
> > > +	if (!fd)
> > > +		return NULL;
> > > +
> > > +	fd->cs_table = alloc_cs_table(nr_states);
> > 
> > Mmm, don't you need to rcu_assign_pointer this first one as well?
> 
> Hmmmm, nobody can be using this at this point, but yes, it'd be better
> to keep that consistent I suppose ...

Yeah, same thing I thought as well.

> > > +	if (!fd->cs_table)
> > > +		goto free_fd;
> > > +
> > > +	/* Copy the span of the frequency domain */
> > > +	cpumask_copy(&fd->cpus, span);
> > > +
> > > +	/* Build the list of capacity states for this freq domain */
> > > +	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
> >                      ^                              ^
> > The fact that this relies on active_power() to use ceil OPP for a given
> > freq might deserve a comment. Also, is this behaviour of active_power()
> > standardized?
> 
> Right, this can get confusing pretty quickly. There is a comment in
> include/linux/energy_model.h where the expected behaviour of
> active_power is explained, but a reminder above this function shouldn't
> hurt.

Mmm, not sure if you could actually check that returned freq values are
actually consistent with the assumption (just in case one didn't do
homework).

> > > +		ret = cb->active_power(&power, &freq, cpu);
> > > +		if (ret)
> > > +			goto free_cs_table;

[...]

> > > +/**
> > > + * em_rescale_cpu_capacity() - Re-scale capacity values of the Energy Model
> > > + *
> > > + * This re-scales the capacity values for all capacity states of all frequency
> > > + * domains of the Energy Model. This should be used when the capacity values
> > > + * of the CPUs are updated at run-time, after the EM was registered.
> > > + */
> > > +void em_rescale_cpu_capacity(void)
> > 
> > So, is this thought to be called eventually also after thermal capping
> > events and such?
> 
> The true reason is that the frequency domains will typically be
> registered in the EM framework _before_ the arch_topology driver kicks
> in on arm/arm64. That means that the EM tables are created, and only
> after, the cpu capacities are updated. So we basically need to update
> those capacities to be up-to-date.
> 
> The reason we need to keep those two steps separate (registering the
> freq domains and re-scaling the capacities) in the EM framework is
> because thermal doesn't care about the cpu capacities. It is a perfectly
> acceptable configuration to use IPA without having dmips-capacity-mhz
> values in the DT for ex.
> 
> Now, since we have a RCU protection on the EM tables, we might decide in
> the future to use the opportunity to modify the tables at run-time for
> other reasons. Thermal capping could be one I guess.

OK. Makes sense.

> > > +{
> > > +	struct em_cs_table *old_table, *new_table;
> > > +	struct em_freq_domain *fd;
> > > +	unsigned long flags;
> > > +	int nr_states, cpu;
> > > +
> > > +	read_lock_irqsave(&em_data_lock, flags);
> > 
> > Don't you need write_lock_ here, since you are going to exchange the
> > em tables?
> 
> This lock protects the per_cpu() variable itself. Here we only read
> pointers from that per_cpu variable, and we modify one attribute in
> the pointed structure. We don't modify the per_cpu table itself. Does
> that make sense ?

So, I don't seem to understand what protects the rcu_assign_pointer(s)
below (as in
https://elixir.bootlin.com/linux/latest/source/Documentation/RCU/whatisRCU.txt#L395).

> > > +	for_each_cpu(cpu, cpu_possible_mask) {
> > > +		fd = per_cpu(em_data, cpu);
> > > +		if (!fd || cpu != cpumask_first(&fd->cpus))
> > > +			continue;
> > > +
> > > +		/* Copy the existing table. */
> > > +		old_table = rcu_dereference(fd->cs_table);
> > > +		nr_states = old_table->nr_cap_states;
> > > +		new_table = alloc_cs_table(nr_states);
> > > +		if (!new_table) {
> > > +			read_unlock_irqrestore(&em_data_lock, flags);
> > > +			return;
> > > +		}
> > > +		memcpy(new_table->state, old_table->state,
> > > +					nr_states * sizeof(*new_table->state));
> > > +
> > > +		/* Re-scale the capacity values on the copy. */
> > > +		fd_update_cs_table(new_table, cpumask_first(&fd->cpus));
> > > +
> > > +		/* Replace the table with the rescaled version. */
> > > +		rcu_assign_pointer(fd->cs_table, new_table);
> > > +		call_rcu(&old_table->rcu, rcu_free_cs_table);
> > > +	}
> > > +	read_unlock_irqrestore(&em_data_lock, flags);
> > > +	pr_debug("Re-scaled CPU capacities\n");
> > > +}
> > > +EXPORT_SYMBOL_GPL(em_rescale_cpu_capacity);
> > > +
> > > +/**
> > > + * em_cpu_get() - Return the frequency domain for a CPU
> > > + * @cpu : CPU to find the frequency domain for
> > > + *
> > > + * Return: the frequency domain to which 'cpu' belongs, or NULL if it doesn't
> > > + * exist.
> > > + */
> > > +struct em_freq_domain *em_cpu_get(int cpu)
> > > +{
> > > +	struct em_freq_domain *fd;
> > > +	unsigned long flags;
> > > +
> > > +	read_lock_irqsave(&em_data_lock, flags);
> > > +	fd = per_cpu(em_data, cpu);
> > > +	read_unlock_irqrestore(&em_data_lock, flags);
> > > +
> > > +	return fd;
> > > +}
> > > +EXPORT_SYMBOL_GPL(em_cpu_get);
> > 
> > Mmm, this gets complicated pretty fast eh? :)
> 
> Yeah, hopefully I'll be able to explain/clarify that :-).
> 
> > 
> > I had to go back and forth between patches to start understanding the
> > different data structures and how they are use, and I'm not sure yet
> > I've got the full picture. I guess some nice diagram (cover letter or
> > documentation patch) would help a lot.
> 
> Right, so I'd like very much to write a nice documentation patch once we
> are more or less OK with the overall design of this framework, but I
> felt like it was a little bit early for that. If we finally decide that
> what I did is totally stupid and that it'd be better to do things
> completely differently, my nice documentation patch would be a lot of
> efforts for nothing.
> 
> But I agree that at the same time all this complex code has to be
> explained. Hopefully the existing comments can help with that.
> Otherwise, I'm more than happy to answer all questions :-)

Thanks for your answers, but I guess my point was that a bit more info
about how this all stay together (maybe in the cover letter) would have
still helped reviewers.

Anyway, no big deal.

> > Locking of such data structures is pretty involved as well, adding
> > comments/docs shouldn't harm. :)
> 
> Message received. If I do need to come-up with a brand new
> design/implementation for v4, I'll make sure to add more comments.

I'd vote for adding docs even if design turns out to be good and you
only need to refresh patches. ;)
