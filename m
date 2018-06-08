From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU
 on task wake-up
Date: Fri, 8 Jun 2018 12:19:09 +0100
Message-ID: <20180608111909.GC418@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
 <20180608102446.GE658@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180608102446.GE658@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 08 Jun 2018 at 12:24:46 (+0200), Juri Lelli wrote:
> Hi,
> 
> On 21/05/18 15:25, Quentin Perret wrote:
> 
> [...]
> 
> > +static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > +{
> > +	unsigned long cur_energy, prev_energy, best_energy, cpu_cap, task_util;
> > +	int cpu, best_energy_cpu = prev_cpu;
> > +	struct sched_energy_fd *sfd;
> > +	struct sched_domain *sd;
> > +
> > +	sync_entity_load_avg(&p->se);
> > +
> > +	task_util = task_util_est(p);
> > +	if (!task_util)
> > +		return prev_cpu;
> > +
> > +	/*
> > +	 * Energy-aware wake-up happens on the lowest sched_domain starting
> > +	 * from sd_ea spanning over this_cpu and prev_cpu.
> > +	 */
> > +	sd = rcu_dereference(*this_cpu_ptr(&sd_ea));
> > +	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
> > +		sd = sd->parent;
> > +	if (!sd)
> > +		return -1;
> 
> Shouldn't this be return prev_cpu?

Well, you shouldn't be entering this function without an sd_ea pointer,
so this case is a sort of bug I think. By returning -1 I think we should
end-up picking a CPU using select_fallback_rq(), which sort of makes
sense ?

> 
> > +
> > +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> > +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> > +	else
> > +		prev_energy = best_energy = ULONG_MAX;
> > +
> > +	for_each_freq_domain(sfd) {
> > +		unsigned long spare_cap, max_spare_cap = 0;
> > +		int max_spare_cap_cpu = -1;
> > +		unsigned long util;
> > +
> > +		/* Find the CPU with the max spare cap in the freq. dom. */
> 
> I undestand this being a heuristic to cut some overhead, but shouldn't
> the model tell between packing vs. spreading?

Ah, that's a very interesting one :-) !

So, with only active costs of the CPUs in the model, we can't really
tell what's best between packing or spreading between identical CPUs if
the migration of the task doesn't change the OPP request.

In a frequency domain, all the "best" CPU candidates for a task are
those for which we'll request a low OPP. When there are several CPUs for
which the OPP request will be the same, we just don't know which one to
pick from an energy standpoint, because we don't have other energy costs
(for idle states for ex) to break the tie.

With this EM, the interesting thing is that if you assume that OPP
requests follow utilization, you are _guaranteed_ that the CPU with
the max spare capacity in a freq domain will always be among the best
candidates of this freq domain. And since we don't know how to
differentiate those candidates, why not using this one ?

Yes, it _might_ be better from an energy standpoint to pack small tasks
on a CPU in order to let other CPUs go in deeper idle states. But that
also hurts your chances to go cluster idle. Which solution is the best ?
It depends, and we have no ways to tell with this EM.

This approach basically favors cluster-packing, and spreading inside a
cluster. That should at least be a good thing for latency, and this is
consistent with the idea that most of the energy savings come from the
asymmetry of the system, and not so much from breaking the tie between
identical CPUs. That's also the reason why EAS is enabled only if your
system has SD_ASYM_CPUCAPACITY set, as we already discussed for patch
05/10 :-).

Does that make sense ?

Thanks,
Quentin
