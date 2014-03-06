From: Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH] cpufreq: use cpufreq_cpu_get to avoid cpufreq_get race
 conditions
Date: Wed, 5 Mar 2014 17:14:26 -0800
Message-ID: <5317CBF2.40908@nvidia.com>
References: <1393965735-15610-1-git-send-email-aplattner@nvidia.com> <2327882.a9zobM63G6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2327882.a9zobM63G6@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/05/14 17:23, Rafael J. Wysocki wrote:
> On Tuesday, March 04, 2014 12:42:15 PM Aaron Plattner wrote:
>> If a module calls cpufreq_get while cpufreq is initializing, it's possible for
>> it to be called after cpufreq_driver is set but before cpufreq_cpu_data is
>> written during subsys_interface_register.  This happens because cpufreq_get
>> doesn't take the cpufreq_driver_lock around its use of cpufreq_cpu_data.
>
> Is this a theoretical race, or can you actually reproduce it?  If so, on what
> system/driver?  Or are there any bug reports related to this you can point me
> to?

It reproduces on my Arch Linux system at home with the nvidia driver, 
and there has been at least one bug report that looks like the same thing:

https://bbs.archlinux.org/viewtopic.php?id=177934

I reproduced the problem with v3.13.5, then applied this change and was 
able to boot successfully 10/10 times.  So I guess that means you can add

Tested-by: Aaron Plattner <aplattner@nvidia.com>

to the commit.

-- Aaron

>> Fix this by using cpufreq_cpu_get(cpu) to look up the policy rather than reading
>> it out of cpufreq_cpu_data directly.  cpufreq_cpu_get takes the appropriate
>> locks to prevent this race from happening.
>>
>> Since it's possible for policy to be NULL if the caller passes in an invalid CPU
>> number or calls the function before cpufreq is initialized, delete the
>> BUG_ON(!policy) and simply return 0.  Don't try to return -ENOENT because that's
>> negative and the function returns an unsigned integer.
>>
>> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
>
> Viresh, have you seen this?
>
>> ---
>>   drivers/cpufreq/cpufreq.c | 21 +++++++--------------
>>   1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 8d19f7c..158d0b5 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1447,23 +1447,16 @@ static unsigned int __cpufreq_get(unsigned int cpu)
>>    */
>>   unsigned int cpufreq_get(unsigned int cpu)
>>   {
>> -	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>> +	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
>>   	unsigned int ret_freq = 0;
>>
>> -	if (cpufreq_disabled() || !cpufreq_driver)
>> -		return -ENOENT;
>> -
>> -	BUG_ON(!policy);
>> -
>> -	if (!down_read_trylock(&cpufreq_rwsem))
>> -		return 0;
>> -
>> -	down_read(&policy->rwsem);
>> -
>> -	ret_freq = __cpufreq_get(cpu);
>> +	if (policy) {
>> +		down_read(&policy->rwsem);
>> +		ret_freq = __cpufreq_get(cpu);
>> +		up_read(&policy->rwsem);
>>
>> -	up_read(&policy->rwsem);
>> -	up_read(&cpufreq_rwsem);
>> +		cpufreq_cpu_put(policy);
>> +	}
>>
>>   	return ret_freq;
>>   }
>>
>

