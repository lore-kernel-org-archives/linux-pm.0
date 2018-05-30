From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH V2] cpufreq: reinitialize new policy min/max when writing
 scaling_(max|min)_freq
Date: Wed, 30 May 2018 16:03:37 +0800
Message-ID: <46d37d2b-f410-63de-721c-27843d25a326@hisilicon.com>
References: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1527319008-66663-1-git-send-email-kevin.wangtao@hisilicon.com>
 <20180529102638.ikmw2xjf523sf4kf@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529102638.ikmw2xjf523sf4kf@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gengyanping@hisilicon.com, sunzhaosheng@hisilicon.com
List-Id: linux-pm@vger.kernel.org



ÔÚ 2018/5/29 18:26, Viresh Kumar Ð´µÀ:
> On 26-05-18, 15:16, Kevin Wangtao wrote:
>> consider such situation, current user_policy.min is 1000000,
>> current user_policy.max is 1200000, in cpufreq_set_policy,
>> other driver may update policy.min to 1200000, policy.max to
>> 1300000. After that, If we input "echo 1300000 > scaling_min_freq",
>> then user_policy.min will be 1300000, and user_policy.max is
>> still 1200000, because the input value is checked with policy.max
>> not user_policy.max. if we get all related cpus offline and
>> online again, it will cause cpufreq_init_policy fail because
>> user_policy.min is higher than user_policy.max.
>>
>> The solution is when user space tries to write scaling_(max|min)_freq,
>> the min/max of new_policy should be reinitialized with min/max
>> of user_policy, like what cpufreq_update_policy does.
>>
>> Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index b79c532..82123a1 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -697,6 +697,8 @@ static ssize_t store_##file_name					\
>>   	struct cpufreq_policy new_policy;				\
>>   									\
>>   	memcpy(&new_policy, policy, sizeof(*policy));			\
> 
> Maybe add a comment here on why this is required ?
OK
> 
>> +	new_policy.min = policy->user_policy.min;			\
>> +	new_policy.max = policy->user_policy.max;			\
>>   									\
>>   	ret = sscanf(buf, "%u", &new_policy.object);			\
>>   	if (ret != 1)							\
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
