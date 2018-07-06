From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Date: Fri, 6 Jul 2018 15:12:43 +0200
Message-ID: <20180706131243.GV2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-10-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:40PM +0100, Quentin Perret wrote:
> +static long 
   compute_energy(struct task_struct *p, int dst_cpu, struct freq_domain *fd)
> +{
> +	long util, max_util, sum_util, energy = 0;
> +	int cpu;
> +
> +	while (fd) {
> +		max_util = sum_util = 0;
> +		for_each_cpu_and(cpu, freq_domain_span(fd), cpu_online_mask) {

I had a wee little wtf moment when I realized this crosses root_domain
boundaries but that that is actually desired. A comment might be in
order.

> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util += cpu_util_dl(cpu_rq(cpu));
> +			/* XXX: add RT util_avg when available. */
> +
> +			max_util = max(util, max_util);
> +			sum_util += util;

Did you want to use sugov_get_util() here? There is no way we're going
to duplicate all that.

ISTR we already established the whole EAS was going to require using
schedutil anyway.

> +		}
> +
> +		energy += em_fd_energy(fd->obj, max_util, sum_util);
> +		fd = fd->next;
> +	}
> +
> +	return energy;
> +}
