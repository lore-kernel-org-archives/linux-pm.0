From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Date: Tue, 10 Apr 2018 19:29:32 +0200
Message-ID: <20180410172932.GD4043@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-6-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 06, 2018 at 04:36:06PM +0100, Dietmar Eggemann wrote:
> +	for_each_freq_domain(fd) {
> +		unsigned long spare_cap, max_spare_cap = 0;
> +		int max_spare_cap_cpu = -1;
> +		unsigned long util;
> +
> +		/* Find the CPU with the max spare cap in the freq. dom. */
> +		for_each_cpu_and(cpu, freq_domain_span(fd), sched_domain_span(sd)) {
> +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> +				continue;
> +
> +			if (cpu == prev_cpu)
> +				continue;
> +
> +			util = cpu_util_wake(cpu, p);
> +			cpu_cap = capacity_of(cpu);
> +			if (!util_fits_capacity(util + task_util, cpu_cap))
> +				continue;
> +
> +			spare_cap = cpu_cap - util;
> +			if (spare_cap > max_spare_cap) {
> +				max_spare_cap = spare_cap;
> +				max_spare_cap_cpu = cpu;
> +			}
> +		}
> +
> +		/* Evaluate the energy impact of using this CPU. */
> +		if (max_spare_cap_cpu >= 0) {
> +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> +			if (cur_energy < best_energy) {
> +				best_energy = cur_energy;
> +				best_energy_cpu = max_spare_cap_cpu;
> +			}
> +		}
> +	}

If each CPU has its own frequency domain, then the above loop ends up
being O(n^2), no? Is there really nothing we can do about that? Also, I
feel that warrants a comment warning about this.

Someone, somewhere will try and build a 64+64 cpu system and get
surprised it doesn't work :-)
