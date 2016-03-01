From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC/RFT][PATCH v4 1/2] cpufreq: New governor using utilization
 data from the scheduler
Date: Mon, 29 Feb 2016 20:10:07 -0800
Message-ID: <56D5161F.1030701@linaro.org>
References: <5059413.77KZsd2lep@vostro.rjw.lan>
 <1825489.pc33SqXSIB@vostro.rjw.lan> <56D1270F.4010106@linaro.org>
 <2754630.1sRldKdOu8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36827 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbcCAEKK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Feb 2016 23:10:10 -0500
Received: by mail-pf0-f169.google.com with SMTP id l6so7247517pfl.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Feb 2016 20:10:10 -0800 (PST)
In-Reply-To: <2754630.1sRldKdOu8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

On 02/27/2016 07:24 AM, Rafael J. Wysocki wrote:
>>> +static unsigned int sugov_next_freq(struct policy_dbs_info *policy_dbs,
>>> +				    unsigned long util, unsigned long max,
>>> +				    u64 last_sample_time)
>>> +{
>>> +	struct cpufreq_policy *policy = policy_dbs->policy;
>>> +	unsigned int min_f = policy->min;
>>> +	unsigned int max_f = policy->max;
>>> +	unsigned int j;
>>> +
>>> +	if (util > max || min_f >= max_f)
>>> +		return max_f;
>>> +
>>> +	for_each_cpu(j, policy->cpus) {
>>> +		struct sugov_cpu *j_sg_cpu;
>>> +		unsigned long j_util, j_max;
>>> +
>>> +		if (j == smp_processor_id())
>>> +			continue;
>>> +
>>> +		j_sg_cpu = &per_cpu(sugov_cpu, j);
>>> +		/*
>>> +		 * If the CPU was last updated before the previous sampling
>>> +		 * time, we don't take it into account as it probably is idle
>>> +		 * now.
>>> +		 */
>>
>> If the sampling rate is less than the tick, it seems possible a busy CPU
>> may not manage to get an update in within the current sampling period.
> 
> Right.
> 
> sampling_rate is more of a rate limit here, though, because the governor doesn't
> really do any sampling (I was talking about that in the intro message at
> http://marc.info/?l=linux-pm&m=145609673008122&w=2).
> 
> It was easy to re-use the existing show/store for that, so I took the shortcut,
> but I'm considering to introduce a new attribute with a more suitable name for
> that.  That would help to avoid a couple of unclean things in patch [2/2] as
> well if I'm not mistaken.
> 
>> What about checking to see if there was an update within the last tick
>> period, rather than sample period?
> 
> If your rate limit is set below the rate of the updates (scheduling rate more
> or less), it simply has no effect.  To me, that case doesn't require any
> special care.

I'm specifically worried about the check below where we omit a CPU's
capacity request if its last update came before the last sample time.

Say there are 2 CPUs in a frequency domain, HZ is 100 and the sample
delay here is 4ms. At t=0ms CPU0 starts running a CPU hog and reports
being fully busy. At t=5ms CPU1 starts running a task - CPU0's vote is
kept and factored in and last_sample_time is updated to t=5ms. At t=9ms
CPU1 stops running the task and updates again, but this time CPU0's vote
is discarded because its last update is t=0ms, and last_sample_time is
5ms. But CPU0 is fully busy and the freq is erroneously dropped.

> 
>>> +		if (j_sg_cpu->last_update < last_sample_time)
>>> +			continue;
>>> +
>>> +		j_util = j_sg_cpu->util;
>>> +		j_max = j_sg_cpu->max;
>>> +		if (j_util > j_max)
>>> +			return max_f;
>>> +
>>> +		if (j_util * max > j_max * util) {
>>> +			util = j_util;
>>> +			max = j_max;
>>> +		}
>>> +	}
>>> +
>>> +	return min_f + util * (max_f - min_f) / max;
>>> +}
...
>>> +static unsigned int sugov_set_freq(struct cpufreq_policy *policy)
>>> +{
>>> +	struct policy_dbs_info *policy_dbs = policy->governor_data;
>>> +	struct sugov_policy *sg_policy = to_sg_policy(policy_dbs);
>>> +
>>> +	__cpufreq_driver_target(policy, sg_policy->next_freq, CPUFREQ_RELATION_C);
>>
>> Similar to the concern raised in the acpi changes I think this should be
>> CPUFREQ_RELATION_L, otherwise you may not run fast enough to meet demand.
> 
> "ondemand" uses CPUFREQ_RELATION_C when powersave_bias is unset and that's why
> I used it here.
> 
> Like I said in my reply to Peter in that thread, using RELATION_L here is likely
> to make us avoid the min frequency almost entirely even if the system is almost
> completely idle.  I don't think that would be OK really.
> 
> That said my opinion about this particular item isn't really strong.

I think the calculation for required CPU bandwidth needs tweaking.

Aside from always wanting something past fmin, currently the amount of
extra CPU capacity given for a particular % utilization depends on how
high the platform's fmin happens to be, even if the fmax speeds are the
same. For example given two platforms with the following available
frequencies (MHz):

platform A: 100, 300, 500, 700, 900, 1100
platform B: 500, 700, 900, 1100

A 50% utilization load on platform A will want 600 MHz (rounding up to
700 MHz perhaps) whereas platform B will want 800 MHz (again likely
rounding up to 900 MHz), even though the load consumes 550 MHz on both
platforms.

One possibility would be something like we had in schedfreq, getting the
absolute CPU bw requirement (util/max) * fmax and then adding some %
margin, which I think is more consistent. It is true that it means
figuring out what the right margin is and now there's a magic number
(and potentially a tunable), but it would be more consistent.

thanks,
Steve

