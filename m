From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq: schedutil: Update cached "current frequency"
 when limits change
Date: Thu, 13 Jul 2017 18:52:18 -0700
Message-ID: <596823D2.9010606@codeaurora.org>
References: <1499826256-23491-1-git-send-email-skannan@codeaurora.org> <20170712052448.GI17115@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56604 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbdGNBwU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 21:52:20 -0400
In-Reply-To: <20170712052448.GI17115@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/11/2017 10:24 PM, Viresh Kumar wrote:
> On 11-07-17, 19:24, Saravana Kannan wrote:
>> Currently, the governor calculates the next frequency, set the current CPU
>> frequency (policy->cur). It also assumes the current CPU frequency doesn't
>> change if the next frequency isn't calculated again and hence caches the
>> "current frequency".
>>
>> However, this isn't true when CPU min/max frequency limits are changed. So,
>> there's room for the CPU frequency to get stuck at the wrong level if the
>> calculated next frequency doesn't change across multiple limits updates.
>>
>> Fix this by updating the cached "current frequency" when limits changes the
>> current CPU frequency.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 076a2e3..fe0b2fb 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -226,6 +226,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>>
>>   	busy = sugov_cpu_is_busy(sg_cpu);
>>
>> +	raw_spin_lock(&sg_policy->update_lock);
>>   	if (flags & SCHED_CPUFREQ_RT_DL) {
>>   		next_f = policy->cpuinfo.max_freq;
>>   	} else {
>> @@ -240,6 +241,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>>   			next_f = sg_policy->next_freq;
>>   	}
>>   	sugov_update_commit(sg_policy, time, next_f);
>> +	raw_spin_unlock(&sg_policy->update_lock);
>
> We wouldn't allow locking here until the time we can :)
>

Actually, can you clarify why you can't allow locking here?

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
