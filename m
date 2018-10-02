From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v7 03/14] PM: Introduce an Energy Model management
 framework
Date: Tue, 2 Oct 2018 21:12:17 +0200
Message-ID: <20181002191217.GA4160@andrea>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-4-quentin.perret@arm.com>
 <20181002123031.GZ3439@hirez.programming.kicks-ass.net>
 <20181002125115.245r3ocusvyiexno@queper01-lin>
 <20181002134857.GE26858@hirez.programming.kicks-ass.net>
 <20181002140430.fpeiqzblbcaewg6n@queper01-lin>
 <20181002142924.GI26858@hirez.programming.kicks-ass.net>
 <20181002144025.wnanxibhdcnl23sf@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181002144025.wnanxibhdcnl23sf@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 02, 2018 at 03:40:28PM +0100, Quentin Perret wrote:
> On Tuesday 02 Oct 2018 at 16:29:24 (+0200), Peter Zijlstra wrote:
> > On Tue, Oct 02, 2018 at 03:05:23PM +0100, Quentin Perret wrote:
> > > On Tuesday 02 Oct 2018 at 15:48:57 (+0200), Peter Zijlstra wrote:
> > > > +/**
> > > > + * em_cpu_get() - Return the performance domain for a CPU
> > > > + * @cpu : CPU to find the performance domain for
> > > > + *
> > > > + * Return: the performance domain to which 'cpu' belongs, or NULL if it doesn't
> > > > + * exist.
> > > > + */
> > > > +struct em_perf_domain *em_cpu_get(int cpu)
> > > > +{
> > > > +       return READ_ONCE(per_cpu(em_data, cpu));
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(em_cpu_get);
> > > > 
> > > > But your read side doesn't take, not is required to take em_pd_mutex.
> > > > 
> > > > At that point, the mutex_unlock() doesn't guarantee anything.
> > > > 
> > > > A CPU observing the em_data store, doesn't need to observe the store
> > > > that filled the data structure it points to.
> > > 
> > > Right but even if I add the smp_store_release(), I can still have a
> > > CPU observing em_data while another is in the process of updating it.
> > > So, if smp_store_release() doesn't guarantee that readers will see a
> > > complete update, do I actually get something interesting from it ?
> > > (That's not a rhetorical question, I'm actually wondering :-)
> > 
> > I thought the update would fail if em_data was already set.
> > 
> > That is, you can only set this thing up _once_ and then you'll have to
> > forever live with it.
> > 
> > Or did I read that wrong?
> 
> No no, that's correct. em_data is populated once and kept as-is
> forever.
> 
> What I was trying to say is, when em_data is being populated for the
> first time, nothing prevents a reader from using em_cpu_get()
> concurrently. And in this case, it doesn't matter if you use
> smp_store_release() or not, the reader might see the table half-updated.
> 
> So, basically, smp_store_release() doesn't guarantee that readers won't
> see a half-baked em_data. That's the point I'm trying to make at least :-)

An example might help clarify this: here is a scenario I can _imagine,
based on your description.

CPU0 (em_register_perf_domain())	CPU1 (reader)

[...]					my_pd = READ_ONCE(per_cpu(em_data, 1)); /* em_cpu_get() */
pd->table = table			if (my_pd)
WRITE_ONCE(per_cpu(em_data, 1), pd);		my_table = my_pd->table; /* process, dereference, ... my_table */

In this scenario, we'd like CPU1 to see CPU0's store to ->table (as well
as the stores to table[]) _if CPU1 sees CPU0's store to em_data (that is,
if my_pd != NULL).

This guarantee does not hold with the WRITE_ONCE(), because CPU0 could
propagate the store to ->table and the store to em_data out-of-order.
The smp_store_release(), together with the address dependency headed by
the READ_ONCE(), provides this guarantee (and more...).

(Enclosing the reader into an em_pd_mutex critical section would also
provide this guarantee, but I can imagine a few arguments for not using
a mutex... ;-) ).

The question, I guess, is whether you want such a guarantee.

  Andrea
