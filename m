From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v6 7/7][Resend] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 25 Mar 2016 18:12:18 -0700
Message-ID: <56F5E1F2.5090100@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35496 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbcCZBMU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 21:12:20 -0400
Received: by mail-pf0-f180.google.com with SMTP id n5so92787451pfn.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Mar 2016 18:12:20 -0700 (PDT)
In-Reply-To: <6666532.7ULg06hQ7e@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

Hi Rafael,

On 03/21/2016 06:54 PM, Rafael J. Wysocki wrote:
...
> +config CPU_FREQ_GOV_SCHEDUTIL
> +	tristate "'schedutil' cpufreq policy governor"
> +	depends on CPU_FREQ
> +	select CPU_FREQ_GOV_ATTR_SET
> +	select IRQ_WORK
> +	help
> +	  The frequency selection formula used by this governor is analogous
> +	  to the one used by 'ondemand', but instead of computing CPU load
> +	  as the "non-idle CPU time" to "total CPU time" ratio, it uses CPU
> +	  utilization data provided by the scheduler as input.

The formula's changed a bit from ondemand - can the formula description
in the commit text be repackaged a bit and used here?

...
> +
> +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> +				unsigned int next_freq)
> +{
> +	struct cpufreq_policy *policy = sg_policy->policy;
> +
> +	sg_policy->last_freq_update_time = time;
> +
> +	if (policy->fast_switch_enabled) {
> +		if (next_freq > policy->max)
> +			next_freq = policy->max;
> +		else if (next_freq < policy->min)
> +			next_freq = policy->min;

The __cpufreq_driver_target() interface has this capping in it. For
uniformity should this be pushed into cpufreq_driver_fast_switch()?

> +
> +		if (sg_policy->next_freq == next_freq) {
> +			trace_cpu_frequency(policy->cur, smp_processor_id());
> +			return;
> +		}

I fear this may bloat traces unnecessarily as there may be long
stretches when a frequency domain is at the same frequency (especially
fmin or fmax).

...
> +static unsigned int sugov_next_freq_shared(struct sugov_policy *sg_policy,
> +					   unsigned long util, unsigned long max)
> +{
> +	struct cpufreq_policy *policy = sg_policy->policy;
> +	unsigned int max_f = policy->cpuinfo.max_freq;
> +	u64 last_freq_update_time = sg_policy->last_freq_update_time;
> +	unsigned int j;
> +
> +	if (util == ULONG_MAX)
> +		return max_f;
> +
> +	for_each_cpu(j, policy->cpus) {
> +		struct sugov_cpu *j_sg_cpu;
> +		unsigned long j_util, j_max;
> +		u64 delta_ns;
> +
> +		if (j == smp_processor_id())
> +			continue;
> +
> +		j_sg_cpu = &per_cpu(sugov_cpu, j);
> +		/*
> +		 * If the CPU utilization was last updated before the previous
> +		 * frequency update and the time elapsed between the last update
> +		 * of the CPU utilization and the last frequency update is long
> +		 * enough, don't take the CPU into account as it probably is
> +		 * idle now.
> +		 */
> +		delta_ns = last_freq_update_time - j_sg_cpu->last_update;
> +		if ((s64)delta_ns > TICK_NSEC)

Why not declare delta_ns as an s64 (also in suguv_should_update_freq)
and avoid the cast?

...
> +static int sugov_limits(struct cpufreq_policy *policy)
> +{
> +	struct sugov_policy *sg_policy = policy->governor_data;
> +
> +	if (!policy->fast_switch_enabled) {
> +		mutex_lock(&sg_policy->work_lock);
> +
> +		if (policy->max < policy->cur)
> +			__cpufreq_driver_target(policy, policy->max,
> +						CPUFREQ_RELATION_H);
> +		else if (policy->min > policy->cur)
> +			__cpufreq_driver_target(policy, policy->min,
> +						CPUFREQ_RELATION_L);
> +
> +		mutex_unlock(&sg_policy->work_lock);
> +	}

Is the expectation that in the fast_switch_enabled case we should
re-evaluate soon enough that an explicit fixup is not required here? I'm
worried as to whether that will always be true given the possible
criticality of applying frequency limits (thermal for example).

thanks,
Steve
