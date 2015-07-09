From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 45/46] sched/cpufreq_sched: modify pcpu_capacity
 handling
Date: Thu, 09 Jul 2015 17:55:03 +0100
Message-ID: <559EA767.3030102@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-46-git-send-email-morten.rasmussen@arm.com> <20150708164235.9112.55369@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:27145 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753206AbbGIQyv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jul 2015 12:54:51 -0400
In-Reply-To: <20150708164235.9112.55369@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>
Cc: "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Mike,

On 08/07/15 17:42, Michael Turquette wrote:
> Quoting Morten Rasmussen (2015-07-07 11:24:28)
>> From: Juri Lelli <juri.lelli@arm.com>
>>
>> Use the cpu argument of cpufreq_sched_set_cap() to handle per_cpu writes,
>> as the thing can be called remotely (e.g., from load balacing code).
>>
>> cc: Ingo Molnar <mingo@redhat.com>
>> cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> 
> Looks good to me. Feel free to add my Reviewed-by or Acked-by as
> appropriate.
> 

Thanks for reviewing it! :)

Best,

- Juri

> Regards,
> Mike
> 
>> ---
>>  kernel/sched/cpufreq_sched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
>> index 06ff183..b81ac779 100644
>> --- a/kernel/sched/cpufreq_sched.c
>> +++ b/kernel/sched/cpufreq_sched.c
>> @@ -151,7 +151,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>>         unsigned long capacity_max = 0;
>>  
>>         /* update per-cpu capacity request */
>> -       __this_cpu_write(pcpu_capacity, capacity);
>> +       per_cpu(pcpu_capacity, cpu) = capacity;
>>  
>>         policy = cpufreq_cpu_get(cpu);
>>         if (IS_ERR_OR_NULL(policy)) {
>> -- 
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 

