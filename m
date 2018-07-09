From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 09/12] sched/fair: Introduce an energy estimation
 helper function
Date: Mon, 9 Jul 2018 14:01:38 +0200
Message-ID: <20180709120138.GQ2494@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-10-quentin.perret@arm.com>
 <20180706131243.GV2458@hirez.programming.kicks-ass.net>
 <20180706151212.GD17577@e108498-lin.cambridge.arm.com>
 <20180706154949.GO2494@hirez.programming.kicks-ass.net>
 <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706170443.GE17577@e108498-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 06, 2018 at 06:04:44PM +0100, Quentin Perret wrote:
> 'max_util' is basically the util we use to request an OPP. 'sum_util' is
> how long the CPUs will be running.

A indeed. But yes bit of a mess, but it wants doing I think.
Perhaps a little something like the below... The alternative is two
separate but closely related functions, not sure which is better.


enum schedutil_type {
	frequency_util,
	energy_util,
};

unsigned long
schedutil_freq_util(int cpu, unsigned long util_cfs, enum schedutil_type type)
{
	struct rq *rq = cpu_rq(cpu);
	unsigned long util, irq, max;

	max = arch_scale_cpu_capacity(NULL, cpu);

	if (type == frequency_util && rt_rq_is_runnable(&rq->rt))
		return max;

	/*
	 * Early check to see if IRQ/steal time saturates the CPU, can be
	 * because of inaccuracies in how we track these -- see
	 * update_irq_load_avg().
	 */
	irq = cpu_util_irq(rq);
	if (unlikely(irq >= max))
		return max;

	/*
	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
	 * CFS tasks and we use the same metric to track the effective
	 * utilization (PELT windows are synchronized) we can directly add them
	 * to obtain the CPU's actual utilization.
	 */
	util = util_cfs;
	util += cpu_util_rt(rq);

	if (type == frequency_util) {
		/*
		 * For frequency selection we do not make cpu_util_dl()
		 * a permanent part of this sum because we want to use
		 * cpu_bw_dl() later on, but we need to check if the
		 * CFS+RT+DL sum is saturated (ie. no idle time) such
		 * that we select f_max when there is no idle time.
		 *
		 * NOTE: numerical errors or stop class might cause us
		 * to not quite hit saturation when we should --
		 * something for later.
		 */
		if ((util + cpu_util_dl(rq)) >= max)
			return max;
	} else {
		/*
		 * OTOH, for energy computation we need the estimated
		 * running time, so include util_dl and ignore dl_bw.
		 */
		util += cpu_util_dl(rq);
		if (util >= max)
			return max;
	}

	/*
	 * There is still idle time; further improve the number by using the
	 * irq metric. Because IRQ/steal time is hidden from the task clock we
	 * need to scale the task numbers:
	 *
	 *              1 - irq
	 *   U' = irq + ------- * U
	 *                max
	 */
	util *= (max - irq);
	util /= max;
	util += irq;

	if (type == frequency_util) {
		/*
		 * Bandwidth required by DEADLINE must always be granted
		 * while, for FAIR and RT, we use blocked utilization of
		 * IDLE CPUs as a mechanism to gracefully reduce the
		 * frequency when no tasks show up for longer periods of
		 * time.
		 *
		 * Ideally we would like to set bw_dl as min/guaranteed
		 * freq and util + bw_dl as requested freq. However,
		 * cpufreq is not yet ready for such an interface. So,
		 * we only do the latter for now.
		 */
		util += cpu_bw_dl(rq);
	}

	return min(max, util);
}
