From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Thu, 7 Jun 2018 18:31:43 +0100
Message-ID: <20180607173143.GD3597@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <20180607160419.GD3311@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607160419.GD3311@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday 07 Jun 2018 at 18:04:19 (+0200), Juri Lelli wrote:
> On 07/06/18 16:19, Quentin Perret wrote:
> > On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
> > > > +	if (!fd->cs_table)
> > > > +		goto free_fd;
> > > > +
> > > > +	/* Copy the span of the frequency domain */
> > > > +	cpumask_copy(&fd->cpus, span);
> > > > +
> > > > +	/* Build the list of capacity states for this freq domain */
> > > > +	for (i = 0, freq = 0; i < nr_states; i++, freq++) {
> > >                      ^                              ^
> > > The fact that this relies on active_power() to use ceil OPP for a given
> > > freq might deserve a comment. Also, is this behaviour of active_power()
> > > standardized?
> > 
> > Right, this can get confusing pretty quickly. There is a comment in
> > include/linux/energy_model.h where the expected behaviour of
> > active_power is explained, but a reminder above this function shouldn't
> > hurt.
> 
> Mmm, not sure if you could actually check that returned freq values are
> actually consistent with the assumption (just in case one didn't do
> homework).

Right, that's a good point. I'll add checks on the parameters modified by
active_power(). Monotonically increasing freq, monotonically increasing
power as well I guess, something along those lines.

> > > > +{
> > > > +	struct em_cs_table *old_table, *new_table;
> > > > +	struct em_freq_domain *fd;
> > > > +	unsigned long flags;
> > > > +	int nr_states, cpu;
> > > > +
> > > > +	read_lock_irqsave(&em_data_lock, flags);
> > > 
> > > Don't you need write_lock_ here, since you are going to exchange the
> > > em tables?
> > 
> > This lock protects the per_cpu() variable itself. Here we only read
> > pointers from that per_cpu variable, and we modify one attribute in
> > the pointed structure. We don't modify the per_cpu table itself. Does
> > that make sense ?
> 
> So, I don't seem to understand what protects the rcu_assign_pointer(s)
> below (as in
> https://elixir.bootlin.com/linux/latest/source/Documentation/RCU/whatisRCU.txt#L395).

Sigh, that's not right :(
I take back my previous message, the write lock _is_ needed. Thanks for
pointing that out ...

Thanks,
Quentin
