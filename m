From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU
 on task wake-up
Date: Tue, 19 Jun 2018 08:57:23 +0100
Message-ID: <20180619075723.GQ17720@e108498-lin.cambridge.arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
 <20180619050601.GA9208@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180619050601.GA9208@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Pavan,

On Tuesday 19 Jun 2018 at 10:36:01 (+0530), Pavan Kondeti wrote:
> On Mon, May 21, 2018 at 03:25:04PM +0100, Quentin Perret wrote:
> 
> <snip>
> 
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
> > +		for_each_cpu_and(cpu, freq_domain_span(sfd), sched_domain_span(sd)) {
> > +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> > +				continue;
> > +
> > +			if (cpu == prev_cpu)
> > +				continue;
> > +
> > +			/* Skip CPUs that will be overutilized */
> > +			util = cpu_util_wake(cpu, p) + task_util;
> > +			cpu_cap = capacity_of(cpu);
> > +			if (cpu_cap * 1024 < util * capacity_margin)
> > +				continue;
> > +
> > +			spare_cap = cpu_cap - util;
> > +			if (spare_cap > max_spare_cap) {
> > +				max_spare_cap = spare_cap;
> > +				max_spare_cap_cpu = cpu;
> > +			}
> > +		}
> > +
> > +		/* Evaluate the energy impact of using this CPU. */
> > +		if (max_spare_cap_cpu >= 0) {
> > +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> > +			if (cur_energy < best_energy) {
> > +				best_energy = cur_energy;
> > +				best_energy_cpu = max_spare_cap_cpu;
> > +			}
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * We pick the best CPU only if it saves at least 1.5% of the
> > +	 * energy used by prev_cpu.
> > +	 */
> > +	if ((prev_energy - best_energy) > (prev_energy >> 6))
> > +		return best_energy_cpu;
> > +
> > +	return prev_cpu;
> > +}
> 
> We are comparing the best_energy_cpu against prev_cpu even when prev_cpu
> can't accommodate the waking task. Is this intentional? Should not we
> discard the prev_cpu if it can't accommodate the task.
> 
> This can potentially make a BIG task run on a lower capacity CPU until
> load balancer kicks in and corrects the situation.

We shouldn't enter find_energy_efficient_cpu() in the first place if the
system is overutilized, so that shouldn't too much of an issue in
general.

But yeah, there is one small corner case where prev_cpu is overutilized
and the system has not been flagged as such yet (when the tasks wakes-up
shortly before the tick for ex). I think it's possible to cover this case
by extending the "if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))"
condition at the top of the function with a check on capacity_margin.

I'll change that in v4.

Thanks !
Quentin
