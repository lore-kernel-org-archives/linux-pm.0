From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 40/46] sched/cpufreq_sched: compute freq_new based
 on capacity_orig_of()
Date: Mon, 17 Aug 2015 13:19:59 +0100
Message-ID: <55D1D16F.1070106@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-41-git-send-email-morten.rasmussen@arm.com> <20150815124638.GG10304@worktop.programming.kicks-ass.net> <20150816040333.31346.22542@quantum> <20150816202401.GJ10304@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:28659 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751073AbbHQMTQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 08:19:16 -0400
In-Reply-To: <20150816202401.GJ10304@worktop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>, "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 16/08/15 21:24, Peter Zijlstra wrote:
> On Sat, Aug 15, 2015 at 09:03:33PM -0700, Michael Turquette wrote:
>> Quoting Peter Zijlstra (2015-08-15 05:46:38)
>>> On Tue, Jul 07, 2015 at 07:24:23PM +0100, Morten Rasmussen wrote:
>>>> diff --git a/kernel/sched/cpufreq_sched.c b/kernel/sched/cpufreq_sched.c
>>>> index 2968f3a..7071528 100644
>>>> --- a/kernel/sched/cpufreq_sched.c
>>>> +++ b/kernel/sched/cpufreq_sched.c
>>>> @@ -184,7 +184,7 @@ void cpufreq_sched_set_cap(int cpu, unsigned long capacity)
>>>>               goto out;
>>>>  
>>>>       /* Convert the new maximum capacity request into a cpu frequency */
>>>> -     freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;
>>>> +     freq_new = (capacity * policy->max) / capacity_orig_of(cpu);
>>>>  
>>>>       /* No change in frequency? Bail and return current capacity. */
>>>>       if (freq_new == policy->cur)
>>>
>>> Can't we avoid exporting that lot by simply passing in the right values
>>> to begin with?
>>
>> By "right value" do you mean, "pass the frequency from cfs"?
> 
> Nah, just maybe: (capacity << SCHED_CAPACITY_SHIFT) / capacity_orig_of()
> such that you don't have to export that knowledge to this thing.
> 

Oh, right. I guess we can just go with something like:

 req_cap = get_cpu_usage(cpu) * capacity_margin / capacity_orig_of(cpu);

on fair.c side and switch back to

 freq_new = capacity * policy->max >> SCHED_CAPACITY_SHIFT;

on cpufreq_sched.c side. That saves us exporting capacity_orig_of().

Thanks,

- Juri

