From: Chris Redpath <chris.redpath@arm.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Examine the correct CPU when we
 update util
Date: Thu, 2 Nov 2017 12:06:36 +0000
Message-ID: <037169f3-61f9-b29e-9561-0f7dba213cd5@arm.com>
References: <20171102111022.GB4240@vireshk-i7>
 <20171102113840.17439-1-chris.redpath@arm.com>
 <20171102114048.GC4240@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-eopbgr00058.outbound.protection.outlook.com ([40.107.0.58]:44096
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751974AbdKBMGl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Nov 2017 08:06:41 -0400
In-Reply-To: <20171102114048.GC4240@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hi Viresh

On 02/11/17 11:40, Viresh Kumar wrote:
> On 02-11-17, 11:38, Chris Redpath wrote:
>> Since:
>> 4296f23ed cpufreq: schedutil: Fix per-CPU structure initialization in
>>   sugov_start()
>
> This is still incorrect. This BUG has nothing to do with 4296f23ed
> AFAICT.
>

According to my diff, this was the commit which switched from assigning
the values directly (and not overwriting the cpu member, which was
introduced in the other commit you reference) to using a memset and
clearing the whole struct. I figured that the fix (which was for a
different issue) inadvertently exposed this, which was what I was trying
to convey here. I can remove this and just reference 674e75411fc2. It's
clear that what's broken is the remote update.

I'll reply with a v3 shortly.

--Chris


>> We lost the value of sg_cpu->cpu which is assigned during
>> sugov_register. The memset in sugov_start overwrites it with zero.
>>
>> The change here was triggered by the commit adding the remote update
>> functionality.
>> 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
>>
>> This leads to always looking at the utilization of CPU0 instead of
>> the one we just updated when we do a utilization update callback.
>>
>> Let's fix this by consolidating the initialization code into
>> sugov_start().
>>
>> Fixes: 674e75411fc2 ("sched: cpufreq: Allow remote cpufreq callbacks")
>> Signed-off-by: Chris Redpath <chris.redpath@arm.com>
>> Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>
>> Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sch=
edutil.c
>> index 6c1a7fcfa2a7..dc68a1ccdb33 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -728,6 +728,7 @@ static int sugov_start(struct cpufreq_policy *policy=
)
>>              struct sugov_cpu *sg_cpu =3D &per_cpu(sugov_cpu, cpu);
>>
>>              memset(sg_cpu, 0, sizeof(*sg_cpu));
>> +            sg_cpu->cpu =3D cpu;
>>              sg_cpu->sg_policy =3D sg_policy;
>>              sg_cpu->flags =3D SCHED_CPUFREQ_RT;
>>              sg_cpu->iowait_boost_max =3D policy->cpuinfo.max_freq;
>> @@ -793,11 +794,6 @@ struct cpufreq_governor *cpufreq_default_governor(v=
oid)
>>
>>   static int __init sugov_register(void)
>>   {
>> -    int cpu;
>> -
>> -    for_each_possible_cpu(cpu)
>> -            per_cpu(sugov_cpu, cpu).cpu =3D cpu;
>> -
>>      return cpufreq_register_governor(&schedutil_gov);
>>   }
>>   fs_initcall(sugov_register);
>> --
>> 2.13.1.449.g02a2850
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
