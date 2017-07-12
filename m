From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq: schedutil: Update cached "current frequency"
 when limits change
Date: Wed, 12 Jul 2017 10:44:01 -0700
Message-ID: <59665FE1.3070305@codeaurora.org>
References: <1499826256-23491-1-git-send-email-skannan@codeaurora.org> <20170712052448.GI17115@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45228 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbdGLRoD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jul 2017 13:44:03 -0400
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
>>   }
>>
>>   static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
>> @@ -637,10 +639,14 @@ static void sugov_stop(struct cpufreq_policy *policy)
>>   static void sugov_limits(struct cpufreq_policy *policy)
>>   {
>>   	struct sugov_policy *sg_policy = policy->governor_data;
>> +	unsigned long flags;
>>
>>   	if (!policy->fast_switch_enabled) {
>>   		mutex_lock(&sg_policy->work_lock);
>>   		cpufreq_policy_apply_limits(policy);
>> +		raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
>> +		sg_policy->next_freq = policy->cur;
>> +		raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
>>   		mutex_unlock(&sg_policy->work_lock);
>>   	}
>
> Did you miss the following part which is after the closing } here ?
>
>          sg_policy->need_freq_update = true;
>
> As this should already take care of the problem you are worried about. Or did I
> misunderstood your problem completely ?
>
Yup, I did. Thanks! Ignore patch please.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
