From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC v2 4/4] sched: cpufreq_cfs: pelt-based cpu frequency scaling
Date: Sat, 23 May 2015 02:10:30 +0200
Message-ID: <49407954.UBSF2FlX46@vostro.rjw.lan>
References: <1431396795-32439-1-git-send-email-mturquette@linaro.org> <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55352 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757136AbbEVXpH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 19:45:07 -0400
In-Reply-To: <1431396795-32439-5-git-send-email-mturquette@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@linaro.org>
Cc: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, riel@redhat.com, efault@gmx.de, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, amit.kucheria@linaro.org, juri.lelli@arm.com, viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, alex.shi@linaro.org, abelvesa@gmail.com

On Monday, May 11, 2015 07:13:15 PM Michael Turquette wrote:
> Scheduler-driven cpu frequency selection is desirable as part of the
> on-going effort to make the scheduler better aware of energy
> consumption.  No piece of the Linux kernel has a better view of the
> factors that affect a cpu frequency selection policy than the
> scheduler[0], and this patch is an attempt to converge on an initial
> solution.
> 
> This patch implements a cpufreq governor that directly accesses
> scheduler statistics, in particular per-runqueue capacity utilization
> data from cfs via cfs.utilization_load_avg.
> 
> Put plainly, this governor selects the lowest cpu frequency that will
> prevent a runqueue from being over-utilized (until we hit the highest
> frequency of course). This is accomplished by requesting a frequency
> that matches the current capacity utilization, plus a margin.
> 
> Unlike the previous posting from 2014[1] this governor implements a
> "follow the utilization" method, where utilization is defined as the
> frequency-invariant product of cfs.utilization_load_avg and
> cpu_capacity_orig.
> 
> This governor is event-driven. There is no polling loop to check cpu
> idle time nor any other method which is unsynchronized with the
> scheduler. The entry points for this policy are in fair.c:
> enqueue_task_fair, dequeue_task_fair and task_tick_fair.
> 
> This policy is implemented using the cpufreq governor interface for two
> main reasons:
> 
> 1) re-using the cpufreq machine drivers without using the governor
> interface is hard.
> 
> 2) using the cpufreq interface allows us to switch between the
> scheduler-driven policy and legacy cpufreq governors such as ondemand at
> run-time. This is very useful for comparative testing and tuning.
> 
> Finally, it is worth mentioning that this approach neglects all
> scheduling classes except for cfs. It is possible to add support for
> deadline and other other classes here, but I also wonder if a
> multi-governor approach would be a more maintainable solution, where the
> cpufreq core aggregates the constraints set by multiple governors.
> Supporting such an approach in the cpufreq core would also allow for
> peripheral devices to place constraint on cpu frequency without having
> to hack such behavior in at the governor level.
> 
> Thanks to Juri Lelli <juri.lelli@arm.com> for contributing design ideas,
> code and test results.
> 
> [0] http://article.gmane.org/gmane.linux.kernel/1499836
> [1] https://lkml.org/lkml/2014/10/22/22
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Michael Turquette <mturquette@linaro.org>
> ---

[cut]

> +/**
> + * cpufreq_cfs_update_cpu - interface to scheduler for changing capacity values
> + * @cpu: cpu whose capacity utilization has recently changed
> + *
> + * cpufreq_cfs_update_cpu is an interface exposed to the scheduler so that the
> + * scheduler may inform the governor of updates to capacity utilization and
> + * make changes to cpu frequency. Currently this interface is designed around
> + * PELT values in CFS. It can be expanded to other scheduling classes in the
> + * future if needed.
> + *
> + * cpufreq_cfs_update_cpu raises an IPI. The irq_work handler for that IPI wakes up
> + * the thread that does the actual work, cpufreq_cfs_thread.
> + *
> + * This functions bails out early if either condition is true:
> + * 1) this cpu is not the new maximum utilization for its frequency domain
> + * 2) no change in cpu frequency is necessary to meet the new capacity request
> + *
> + * Returns the newly chosen capacity. Note that this may not reflect reality if
> + * the hardware fails to transition to this new capacity state.
> + */
> +unsigned long cpufreq_cfs_update_cpu(int cpu, unsigned long util)
> +{
> +	unsigned long util_new, util_old, util_max, capacity_new;
> +	unsigned int freq_new, freq_tmp, cpu_tmp;
> +	struct cpufreq_policy *policy;
> +	struct gov_data *gd;
> +	struct cpufreq_frequency_table *pos;
> +
> +	/* handle rounding errors */
> +	util_new = util > SCHED_LOAD_SCALE ? SCHED_LOAD_SCALE : util;
> +
> +	/* update per-cpu utilization */
> +	util_old = __this_cpu_read(pcpu_util);
> +	__this_cpu_write(pcpu_util, util_new);
> +
> +	/* avoid locking policy for now; accessing .cpus only */
> +	policy = per_cpu(pcpu_policy, cpu);
> +
> +	/* find max utilization of cpus in this policy */
> +	util_max = 0;
> +	for_each_cpu(cpu_tmp, policy->cpus)
> +		util_max = max(util_max, per_cpu(pcpu_util, cpu_tmp));
> +
> +	/*
> +	 * We only change frequency if this cpu's utilization represents a new
> +	 * max. If another cpu has increased its utilization beyond the
> +	 * previous max then we rely on that cpu to hit this code path and make
> +	 * the change. IOW, the cpu with the new max utilization is responsible
> +	 * for setting the new capacity/frequency.
> +	 *
> +	 * If this cpu is not the new maximum then bail, returning the current
> +	 * capacity.
> +	 */
> +	if (util_max > util_new)
> +		return capacity_of(cpu);
> +
> +	/*
> +	 * We are going to request a new capacity, which might result in a new
> +	 * cpu frequency. From here on we need to serialize access to the
> +	 * policy and the governor private data.
> +	 */
> +	policy = cpufreq_cpu_get(cpu);
> +	if (IS_ERR_OR_NULL(policy)) {
> +		return capacity_of(cpu);
> +	}
> +
> +	capacity_new = capacity_of(cpu);
> +	if (!policy->governor_data) {
> +		goto out;
> +	}
> +
> +	gd = policy->governor_data;
> +
> +	/* bail early if we are throttled */
> +	if (ktime_before(ktime_get(), gd->throttle)) {
> +		goto out;
> +	}
> +
> +	/*
> +	 * Convert the new maximum capacity utilization into a cpu frequency
> +	 *
> +	 * It is possible to convert capacity utilization directly into a
> +	 * frequency, but that implies that we would be 100% utilized. Instead,
> +	 * first add a margin (default 25% capacity increase) to the new
> +	 * capacity request. This provides some head room if load increases.
> +	 */
> +	capacity_new = util_new + (SCHED_CAPACITY_SCALE >> 2);
> +	freq_new = capacity_new * policy->max >> SCHED_CAPACITY_SHIFT;
> +
> +	/*
> +	 * If a frequency table is available then find the frequency
> +	 * corresponding to freq_new.
> +	 *
> +	 * For cpufreq drivers without a frequency table, use the frequency
> +	 * directly computed from capacity_new + 25% margin.
> +	 */
> +	if (policy->freq_table) {
> +		freq_tmp = policy->max;
> +		cpufreq_for_each_entry(pos, policy->freq_table) {
> +			if (pos->frequency >= freq_new &&
> +					pos->frequency < freq_tmp)
> +				freq_tmp = pos->frequency;
> +		}
> +		freq_new = freq_tmp;
> +		capacity_new = (freq_new << SCHED_CAPACITY_SHIFT) / policy->max;
> +	}
> +
> +	/* No change in frequency? Bail and return current capacity. */
> +	if (freq_new == policy->cur) {
> +		capacity_new = capacity_of(cpu);
> +		goto out;
> +	}
> +

At this point, if the underlying driver can switch the frequency (P-state in
general) from interrupt context, we might just ask it to do that here instead of
kicking the thread and do it from there (which may be too late already in some
cases).

So what about adding a new cpufreq driver callback that will be set if the
driver is capable of making P-state changes from interrupt context and using
that here if available?

> +	/* store the new frequency and kick the thread */
> +	gd->freq = freq_new;
> +
> +	/* XXX can we use something like try_to_wake_up_local here instead? */
> +	irq_work_queue_on(&gd->irq_work, cpu);
> +
> +out:
> +	cpufreq_cpu_put(policy);
> +	return capacity_new;
> +}


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
