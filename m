From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq: Fix race between sysfs writes and hotplug/policy
 update
Date: Mon, 24 Jun 2013 12:19:46 -0700
Message-ID: <51C89BD2.4010901@codeaurora.org>
References: <1371956540-8830-1-git-send-email-skannan@codeaurora.org> <CAKohpom74ZX90j3f3kcLxPjYBWjHbd3urJ2MXQwtNWKwwpi=xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpom74ZX90j3f3kcLxPjYBWjHbd3urJ2MXQwtNWKwwpi=xQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 06/23/2013 11:08 PM, Viresh Kumar wrote:
> Hi Saravana,
>
> On 23 June 2013 08:32, Saravana Kannan <skannan@codeaurora.org> wrote:
>> The sysfs store ops need to grab the policy write semaphore to avoid race
>> with hotplug and cpufreq_update_policy() calls. Without this, we could end
>> up with simultaneous calls to cpufreq_driver->target()
>
> Interesting.
>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 2d53f47..37db7f0 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -420,9 +420,13 @@ static ssize_t store_##file_name                                   \
>>          if (ret != 1)                                                   \
>>                  return -EINVAL;                                         \
>>                                                                          \
>> +       lock_policy_rwsem_write(policy->cpu);                           \
>> +                                                                       \
>>          ret = __cpufreq_set_policy(policy, &new_policy);                \
>>          policy->user_policy.object = policy->object;                    \
>>                                                                          \
>> +       unlock_policy_rwsem_write(policy->cpu);                         \
>> +                                                                       \
>>          return ret ? ret : count;                                       \
>>   }
>
> As far as I know, this protection already exists. Check this
> function, which eventually calls all **store() related to
> struct freq_attr
>
> static ssize_t store(struct kobject *kobj, struct attribute *attr,
> 		     const char *buf, size_t count)
> {
> 	struct cpufreq_policy *policy = to_policy(kobj);
> 	struct freq_attr *fattr = to_attr(attr);
> 	ssize_t ret = -EINVAL;
> 	policy = cpufreq_cpu_get_sysfs(policy->cpu);
> 	if (!policy)
> 		goto no_policy;
>
> 	if (lock_policy_rwsem_write(policy->cpu) < 0)
> 		goto fail;
>
> 	if (fattr->store)
> 		ret = fattr->store(policy, buf, count);
> 	else
> 		ret = -EIO;
>
> 	unlock_policy_rwsem_write(policy->cpu);
> fail:
> 	cpufreq_cpu_put_sysfs(policy);
> no_policy:
> 	return ret;
> }
>

You are right. I did look at this, but looks like I skimmed some code 
too fast. But the race is certainly happening. I'll have to dig deeper I 
guess. I do see some patches you have for serializing driver->target() 
calls. Haven't looked at them yet, but maybe they'll help.

I'll dig deeper.

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
