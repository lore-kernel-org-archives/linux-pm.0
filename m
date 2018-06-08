From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v3 09/10] sched/fair: Select an energy-efficient CPU
 on task wake-up
Date: Fri, 8 Jun 2018 12:24:46 +0200
Message-ID: <20180608102446.GE658@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-10-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-10-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 21/05/18 15:25, Quentin Perret wrote:

[...]

> +static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> +{
> +	unsigned long cur_energy, prev_energy, best_energy, cpu_cap, task_util;
> +	int cpu, best_energy_cpu = prev_cpu;
> +	struct sched_energy_fd *sfd;
> +	struct sched_domain *sd;
> +
> +	sync_entity_load_avg(&p->se);
> +
> +	task_util = task_util_est(p);
> +	if (!task_util)
> +		return prev_cpu;
> +
> +	/*
> +	 * Energy-aware wake-up happens on the lowest sched_domain starting
> +	 * from sd_ea spanning over this_cpu and prev_cpu.
> +	 */
> +	sd = rcu_dereference(*this_cpu_ptr(&sd_ea));
> +	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
> +		sd = sd->parent;
> +	if (!sd)
> +		return -1;

Shouldn't this be return prev_cpu?

> +
> +	if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> +		prev_energy = best_energy = compute_energy(p, prev_cpu);
> +	else
> +		prev_energy = best_energy = ULONG_MAX;
> +
> +	for_each_freq_domain(sfd) {
> +		unsigned long spare_cap, max_spare_cap = 0;
> +		int max_spare_cap_cpu = -1;
> +		unsigned long util;
> +
> +		/* Find the CPU with the max spare cap in the freq. dom. */

I undestand this being a heuristic to cut some overhead, but shouldn't
the model tell between packing vs. spreading?

Thanks,

 -Juri
