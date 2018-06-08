From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [RFC PATCH v3 07/10] sched/fair: Introduce an energy estimation
 helper function
Date: Fri, 8 Jun 2018 12:30:52 +0200
Message-ID: <20180608103052.GF658@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-8-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-8-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 21/05/18 15:25, Quentin Perret wrote:

[...]

> +static long compute_energy(struct task_struct *p, int dst_cpu)
> +{
> +	long util, max_util, sum_util, energy = 0;
> +	struct sched_energy_fd *sfd;
> +	int cpu;
> +
> +	for_each_freq_domain(sfd) {
> +		max_util = sum_util = 0;
> +		for_each_cpu_and(cpu, freq_domain_span(sfd), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util += cpu_util_dl(cpu_rq(cpu));
> +			/* XXX: add RT util_avg when available. */

em_fd_energy() below uses this to know which power to pick in the freq
table. So, if you have any RT task running on cpu freq will be at max
anyway. It seems to me that in this case max_util for the freq_domain
must be max_freq (w/o considering rt.util_avg as schedutil does). Then
you could probably still use rt.util_avg to get the percentage of busy
time with sum_util?

> +
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		energy += em_fd_energy(sfd->fd, max_util, sum_util);
> +	}
> +
> +	return energy;
> +}

Best,

- Juri
