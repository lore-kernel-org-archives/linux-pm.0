From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Fri, 1 Apr 2016 10:49:46 -0700
Message-ID: <56FEB4BA.4080403@linaro.org>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
 <6666532.7ULg06hQ7e@vostro.rjw.lan> <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33906 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbcDARtt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 13:49:49 -0400
Received: by mail-pa0-f54.google.com with SMTP id fe3so96401327pab.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2016 10:49:49 -0700 (PDT)
In-Reply-To: <145931680.Kk1xSBT0Ro@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>

On 03/29/2016 07:00 PM, Rafael J. Wysocki wrote:
...
> +config CPU_FREQ_GOV_SCHEDUTIL
> +	tristate "'schedutil' cpufreq policy governor"
> +	depends on CPU_FREQ
> +	select CPU_FREQ_GOV_ATTR_SET
> +	select IRQ_WORK
> +	help
> +	  This governor makes decisions based on the utilization data provided
> +	  by the scheduler.  It sets the CPU frequency to be proportional to
> +	  the utilization/capacity ratio coming from the scheduler.  If the
> +	  utilization is frequency-invariant, the new frequency is also
> +	  proportional to the maximum available frequency.  If that is not the
> +	  case, it is proportional to the current frequency of the CPU with the
> +	  tipping point at utilization/capacity equal to 80%.

This help text implies that the tipping point of 80% applies only to
non-frequency invariant configurations, rather than both. Possible to
rephrase?

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

>> Why not declare delta_ns as an s64 (also in suguv_should_update_freq)
>> and avoid the cast?
>
> I took this from __update_load_avg(), but it shouldn't matter here.

Did you mean to keep these casts?

thanks,
Steve

