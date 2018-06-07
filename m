From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v3 05/10] sched/topology: Reference the Energy Model
 of CPUs when available
Date: Thu, 7 Jun 2018 18:29:10 +0200
Message-ID: <20180607162910.GE3311@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-6-quentin.perret@arm.com>
 <20180607144422.GA17216@localhost.localdomain>
 <20180607160200.GB3597@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607160200.GB3597@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/06/18 17:02, Quentin Perret wrote:
> On Thursday 07 Jun 2018 at 16:44:22 (+0200), Juri Lelli wrote:
> > Hi,
> > 
> > On 21/05/18 15:25, Quentin Perret wrote:
> > > In order to use EAS, the task scheduler has to know about the Energy
> > > Model (EM) of the platform. This commit extends the scheduler topology
> > > code to take references on the frequency domains objects of the EM
> > > framework for all online CPUs. Hence, the availability of the EM for
> > > those CPUs is guaranteed to the scheduler at runtime without further
> > > checks in latency sensitive code paths (i.e. task wake-up).
> > > 
> > > A (RCU-protected) private list of online frequency domains is maintained
> > > by the scheduler to enable fast iterations. Furthermore, the availability
> > > of an EM is notified to the rest of the scheduler with a static key,
> > > which ensures a low impact on non-EAS systems.
> > > 
> > > Energy Aware Scheduling can be started if and only if:
> > >    1. all online CPUs are covered by the EM;
> > >    2. the EM complexity is low enough to keep scheduling overheads low;
> > >    3. the platform has an asymmetric CPU capacity topology (detected by
> > >       looking for the SD_ASYM_CPUCAPACITY flag in the sched_domain
> > >       hierarchy).
> > 
> > Not sure about this. How about multi-freq domain same max capacity
> > systems. I understand that most of the energy saving come from selecting
> > the right (big/LITTLE) cluster, but EM should still be useful to drive
> > OPP selection (that was one of the use-cases we discussed lately IIRC)
> > and also to decide between packing or spreading, no?
> 
> So, let's discuss the usage of the EM for frequency selection first,
> and its usage for task placement after.
> 
> For frequency selection, schedutil could definitely use the EM as
> provided by the framework introduced in patch 03/10. We could definitely
> use that to make policy decisions (jump faster to the so called "knee"
> if there is one for ex). This is true for symmetric and asymmetric
> system. And I consider that independent from this patch. This patch is
> about providing the scheduler with an EM to biais _task placement_.
> 
> So, about the task placement ... There are cases (at least theoretical
> ones) where EAS _could_ help on symmetric systems, but I have never
> been able to measure any real benefits in practice. Most of the time,
> it's a good idea from an energy standpoint to just spread the tasks
> and to keep the OPPs as low as possible on symmetric systems, which is
> already what CFS does. Of course you can come-up with specific counter
> examples, but the question is whether or not these (corner) cases are
> that important. They might or might not, it's not so easy to tell.
> 
> On asymmetric systems, it is pretty clear that there is a massive
> potential for saving energy with a different task placement strategy.
> So, since the big savings are there, our idea was basically to address
> that first, while we minimize the risk of hurting others (server folks
> for ex). I guess that enabling EAS for asymmetric systems can be seen as
> an incremental step. We should be able to extend the scope of EAS to
> symmetric systems later, if proven useful.
> 
> Another thing is that, if you are using an asymmetric system (e.g.
> big.LITTLE), it is a good indication that energy/battery life is probably
> important for your use-case, and that you might be ready to "pay" the
> cost of EAS to save energy. This isn't that obvious for symmetric
> systems.

Ok, I buy the step by step approach starting from the use case that
seems to fit most. But I still feel that having something like 3. stated
(or in the code) might stop people from trying to see if having an EM
around might help other cases (freq, sym, etc.).

Also, if no EM data is present should equally result in disabling the
whole thing, so not much (at all?) overhead for who is simply not
providing data, no?

[...]

> > > +	list_for_each_entry_safe(sfd, tmp, &sched_energy_fd_list, next) {
> > > +		if (cpumask_intersects(freq_domain_span(sfd),
> > > +							cpu_online_mask)) {
> > > +			nr_opp += em_fd_nr_cap_states(sfd->fd);
> > > +			nr_fd++;
> > > +			continue;
> > > +		}
> > > +
> > > +		/* Remove the unused frequency domains */
> > > +		list_del_rcu(&sfd->next);
> > > +		call_rcu(&sfd->rcu, free_sched_energy_fd);
> > 
> > Unused because of? Hotplug?
> 
> Yes. The list of frequency domains is just convenient because we need to
> iterate over them in the wake-up path. Now, if you hotplug out all the
> CPUs of a frequency domain, it is safe to remove it from the list
> because the scheduler shouldn't migrate task to/from those CPUs while
> they're offline. And that's one less element in the list, so iterating
> over the entire list is faster.

OK, I mainly asked to be sure that I understood the comment. I guess
some stress test involving hotplug and iterating over the list would
best answer which way is the safest. :)
