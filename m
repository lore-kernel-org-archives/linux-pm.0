Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A4A38736E;
	Tue, 25 Aug 2026 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648982; cv=none; b=NSBN0zmjWt/oEKpWYHVYzPjJe2BBDC5MNw/W8wSHRXQtTl6C+fuUzp+XC3T6SxU+sFcz6ZPxesaoxbpILFs4Fb3OYk1MvSTtZ2cB/p3rloM2uklxg1AuG1EiLxxCoryH+7YPrYiFa4IlytMz9t+QIxwDBKq/vuQr38ybc+5wZr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648982; c=relaxed/simple;
	bh=qyJbzCm9WvvcYKk1IUxTFDaekDGR85smTHTMHubRBRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl+1vIlKljK1y81jDtL7ZojeyzcPqtAqYhGiKi9Ik+P6v+L8Y1TOyDEvjUdELaV9wJ8LILPDO7l4m/jfP0lnzSyYLGvIyFPM8ldsoEHsOBIsJ4sBl3L6HYvgKjvX1aczyrzHNZudAeL1XVJYbDt0J6SBzXobUuV8fMWBal/Gpdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZbBVz0Sw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZbBVz0Sw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EEF61BF7;
	Tue, 25 Aug 2026 02:00:54 -0700 (PDT)
Received: from [10.57.6.192] (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35D5E3F7D8;
	Tue, 25 Aug 2026 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787648458; bh=qyJbzCm9WvvcYKk1IUxTFDaekDGR85smTHTMHubRBRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZbBVz0SwUeV3JKmY3f1lTzgdmhFF2/n1bm44p7h8/ZHf06VkWFJs4UuKwrLWPm7KB
	 s11qSNcT9JSLDbjgc9uCqUiCFTaKSY6CScqPWTwNPKQ4mdIKJ9BphB422UPAaWpDkK
	 3ZIbR2VmnIihVfDXBXjFA2rDLLhYpKCouP/AZsW8=
Message-ID: <31716152-14b6-46bc-88f6-b7fccc1e9377@arm.com>
Date: Tue, 25 Aug 2026 10:00:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/cpufreq: Reevaluate frequency before tickless idle
To: Hongyan Xia <hongyan.xia@transsion.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>
Cc: "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
 "frederic@kernel.org" <frederic@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "jstultz@google.com" <jstultz@google.com>,
 "qyousef@layalina.io" <qyousef@layalina.io>,
 "sibi.sankar@oss.qualcomm.com" <sibi.sankar@oss.qualcomm.com>,
 "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
 "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>
References: <20260824131842.2443385-1-christian.loehle@arm.com>
 <14b8edb7-3515-42dd-86bc-c61872921b5d@transsion.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <14b8edb7-3515-42dd-86bc-c61872921b5d@transsion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 03:51, Hongyan Xia wrote:
> On 8/24/2026 9:18 PM, Christian Loehle wrote:
>> sugov_hold_freq() can preserve a UCLAMP_MIN-driven high frequency when
>> the runqueue goes idle. If cpuidle then stops the tick, no later
>> utilization update is guaranteed and a CPU using WFI can remain at an
>> unnecessarily high voltage for the entire idle period.
>>
>> Issue a final cpufreq update when the idle tick actually transitions to
>> stopped and force single-policy schedutil past its rate limit. Keep the
>> existing hold behavior when the tick is retained.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>   include/linux/sched/cpufreq.h    |  1 +
>>   kernel/sched/cpufreq_schedutil.c |  5 ++++-
>>   kernel/sched/idle.c              | 29 +++++++++++++++++++++++++++--
>>   3 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
>> index bdd31ab93bc5..0814f6c79315 100644
>> --- a/include/linux/sched/cpufreq.h
>> +++ b/include/linux/sched/cpufreq.h
>> @@ -9,6 +9,7 @@
>>    */
>>   
>>   #define SCHED_CPUFREQ_IOWAIT	(1U << 0)
>> +#define SCHED_CPUFREQ_IDLE	(1U << 1)
>>   
>>   #ifdef CONFIG_CPU_FREQ
>>   struct cpufreq_policy;
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index a1782755efcc..90bf8d8bffb7 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -100,7 +100,7 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>>   
>>   		return true;
>>   	} else if (sg_policy->need_freq_update) {
>> -		/* ignore_dl_rate_limit() wants a new frequency to be found. */
>> +		/* A forced update needs a new frequency to be found. */
>>   		return true;
>>   	}
>>   
>> @@ -407,6 +407,9 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
>>   	sugov_iowait_boost(sg_cpu, time, flags);
>>   	sg_cpu->last_update = time;
>>   
>> +	if (flags & SCHED_CPUFREQ_IDLE)
>> +		sg_cpu->sg_policy->need_freq_update = true;
>> +
>>   	ignore_dl_rate_limit(sg_cpu);
>>   
>>   	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
>> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
>> index eb73b65ce6c4..36f8840d0562 100644
>> --- a/kernel/sched/idle.c
>> +++ b/kernel/sched/idle.c
>> @@ -161,10 +161,35 @@ static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>   	return cpuidle_enter(drv, dev, next_state);
>>   }
>>   
>> +static void idle_stop_tick(void)
>> +{
>> +#ifdef CONFIG_CPU_FREQ
>> +	bool was_stopped = tick_nohz_tick_stopped();
>> +#endif
>> +
>> +	tick_nohz_idle_stop_tick();
>> +
>> +#ifdef CONFIG_CPU_FREQ
>> +	/*
>> +	 * Run one last cpufreq update before entering idle with the tick
>> +	 * stopped, because no later update is guaranteed.
>> +	 */
>> +	if (!was_stopped && tick_nohz_tick_stopped()) {
>> +		struct rq *rq = this_rq();
>> +		struct rq_flags rf;
>> +
>> +		rq_lock(rq, &rf);
>> +		update_rq_clock(rq);
>> +		cpufreq_update_util(rq, SCHED_CPUFREQ_IDLE);
>> +		rq_unlock(rq, &rf);
>> +	}
>> +#endif
>> +}
>> +
>>   static void idle_call_stop_or_retain_tick(bool stop_tick)
>>   {
>>   	if (stop_tick || tick_nohz_tick_stopped())
>> -		tick_nohz_idle_stop_tick();
>> +		idle_stop_tick();
>>   	else
>>   		tick_nohz_idle_retain_tick();
>>   }
>> @@ -225,7 +250,7 @@ static void cpuidle_idle_call(bool stop_tick)
>>   			max_latency_ns = dev->forced_idle_latency_limit_ns;
>>   		}
>>   
>> -		tick_nohz_idle_stop_tick();
>> +		idle_stop_tick();
>>   
>>   		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>>   		call_cpuidle(drv, dev, next_state);
> 
> LGTM, minus the Sashiko issue.
> 
> One side note is that I briefly looked at similar things before, not 
> just for sugov_hold_freq() but for going idle in general. It might be 
> desirable to predict the util *after* wake-up and use it to drive 
> frequency one last time before going idle for any CPU. This avoids 
> holding high frequencies in update_single() and also avoids idling CPUs 
> holding high frequencies for the entire cluster in update_shared().
> 
> But predictions are hard and the energy savings aren't much so I didn't 
> spend much time on it. Not sure if there are better ideas.

Funnily enough the slow-switch case makes this a lot more complicated,
in particular with PREEMPT_RT :/
My current approach is to have an irq work for the next tick for
the sugov_hold_freq() case, that checks if it hasn't seen another update
for the tick duration and then drops the hold_freq.
It's not ideal because of course it disabled the tick-stop by one tick,
but it's the best approach I can come up with now.
We could do something similar for decayed blocked utilization (i.e. have
an irq work for when utilization would reach lowest OPP (or an intermediate
step?) and decay that then).

That being said I do think the hold_freq and the blocked utilization are
separate issues, they just might have a similar-looking solution...
I can post an RFC for the latter, that being said I'm not entirely convinced
myself that it's worth it, while I think the hold_freq is just clearly wrong
behavior.
