From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 40/46] sched/cpufreq_sched: compute freq_new based
 on capacity_orig_of()
Date: Thu, 09 Jul 2015 17:21:18 +0100
Message-ID: <559E9F7E.1060906@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-41-git-send-email-morten.rasmussen@arm.com> <20150708152221.9112.2951@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:63594 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753412AbbGIQVG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jul 2015 12:21:06 -0400
In-Reply-To: <20150708152221.9112.2951@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>
Cc: "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Mike,

On 08/07/15 16:22, Michael Turquette wrote:
> Quoting Morten Rasmussen (2015-07-07 11:24:23)
>> From: Juri Lelli <juri.lelli@arm.com>
>>
>> capacity is both cpu and freq scaled with EAS. We thus need to compute
>> freq_new using capacity_orig_of(), so that we properly scale back the thing
>> on heterogeneous architectures. In fact, capacity_orig_of() returns only
>> the cpu scaled part of capacity (see update_cpu_capacity()). So, to scale
>> freq_new correctly, we multiply policy->max by capacity/capacity_orig_of()
>> instead of capacity/1024.
>>
>> cc: Ingo Molnar <mingo@redhat.com>
>> cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> 
> Looks good to me. Please feel free to add my Reviewed-by or Acked-by as
> appropriate.
> 

Thanks for reviewing it!

Best,

- Juri

> Regards,
> Mike
> 
>> ---
>>  kernel/sched/cpufreq_sched.c | 2 +-
>>  kernel/sched/fair.c          | 2 +-
>>  kernel/sched/sched.h         | 2 ++
>>  3 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
>> index 2968f3a..7071528 100644
>> --- a/kernel/sched/cpufreq_sched.c
>> +++ b/kernel/sched/cpufreq_sched.c
>> @@ -184,7 +184,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>>                 goto out;
>>  
>>         /* Convert the new maximum capacity request into a cpu frequency */
>> -       freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;
>> +       freq_new = (capacity * policy->max) / capacity_orig_of(cpu);
>>  
>>         /* No change in frequency? Bail and return current capacity. */
>>         if (freq_new == policy->cur)
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d395bc9..f74e9d2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4625,7 +4625,7 @@ static unsigned long capacity_of(int cpu)
>>         return cpu_rq(cpu)->cpu_capacity;
>>  }
>>  
>> -static unsigned long capacity_orig_of(int cpu)
>> +unsigned long capacity_orig_of(int cpu)
>>  {
>>         return cpu_rq(cpu)->cpu_capacity_orig;
>>  }
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index b5e27d9..1327dc7 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1476,6 +1476,8 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>>  }
>>  #endif
>>  
>> +unsigned long capacity_orig_of(int cpu);
>> +
>>  extern struct static_key __sched_energy_freq;
>>  static inline bool sched_energy_freq(void)
>>  {
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

