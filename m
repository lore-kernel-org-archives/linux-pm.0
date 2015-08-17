From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 45/46] sched/cpufreq_sched: modify pcpu_capacity
 handling
Date: Mon, 17 Aug 2015 12:16:12 +0100
Message-ID: <55D1C27C.2030600@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-46-git-send-email-morten.rasmussen@arm.com> <20150816203512.GK10304@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:6313 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751073AbbHQLPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 07:15:30 -0400
In-Reply-To: <20150816203512.GK10304@worktop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Peter,

On 16/08/15 21:35, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:28PM +0100, Morten Rasmussen wrote:
>> From: Juri Lelli <juri.lelli@arm.com>
>>
>> Use the cpu argument of cpufreq_sched_set_cap() to handle per_cpu writes,
>> as the thing can be called remotely (e.g., from load balacing code).
>>
>> cc: Ingo Molnar <mingo@redhat.com>
>> cc: Peter Zijlstra <peterz@infradead.org>
>>
>> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
>> ---
>>  kernel/sched/cpufreq_sched.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
>> index 06ff183..b81ac779 100644
>> --- a/kernel/sched/cpufreq_sched.c
>> +++ b/kernel/sched/cpufreq_sched.c
>> @@ -151,7 +151,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>>  	unsigned long capacity_max = 0;
>>  
>>  	/* update per-cpu capacity request */
>> -	__this_cpu_write(pcpu_capacity, capacity);
>> +	per_cpu(pcpu_capacity, cpu) = capacity;
>>  
>>  	policy = cpufreq_cpu_get(cpu);
>>  	if (IS_ERR_OR_NULL(policy)) {
> 
> Uhm,.. this function seems to hard assume its called for the local CPU.
> It will only use the irq_queue_work_on() if the cpufreq thing requires
> the thread, otherwise it will call the method directly on the calling
> cpu.
> 

True, but we still retrieve policy from cpu passed as argument; and
then we use policy to request a freq transition, that should end up
updating the right cpu.

Thanks,

- Juri

