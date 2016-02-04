From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Thu, 04 Feb 2016 09:44:52 -0800
Message-ID: <56B38E14.5060705@codeaurora.org>
References: <cover.1454507872.git.viresh.kumar@linaro.org> <20160203155428.GY3947@e106622-lin> <20160203161059.GH3469@vireshk> <20160203172009.GC12132@e106622-lin> <CAJZ5v0hdn6bM8J97O_GFrvi2O7LfuGv0oaZu7KH+cj1TJy+4CQ@mail.gmail.com> <CAMSceqiFG47G=mvzY8-tUL=sHdkkjVQaWzEA1aN+-ym0F_n6Gw@mail.gmail.com> <CAJZ5v0hbhoS+1AaU12SFxz=r1-TOWq10yJ+ST7mVWcUubTbxFw@mail.gmail.com> <20160204110907.GE3469@vireshk> <56B38DC8.8060606@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43170 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757877AbcBDRoy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 12:44:54 -0500
In-Reply-To: <56B38DC8.8060606@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shilpa Bhat <shilpabhatppc@gmail.com>, Juri Lelli <juri.lelli@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02/04/2016 09:43 AM, Saravana Kannan wrote:
> On 02/04/2016 03:09 AM, Viresh Kumar wrote:
>> On 04-02-16, 00:50, Rafael J. Wysocki wrote:
>>> This is exactly right.  We've avoided one deadlock only to trip into
>>> another one.
>>>
>>> This happens because update_sampling_rate() acquires
>>> od_dbs_cdata.mutex which is held around cpufreq_governor_exit() by
>>> cpufreq_governor_dbs().
>>>
>>> Worse yet, a deadlock can still happen without (the new)
>>> dbs_data->mutex, just between s_active and od_dbs_cdata.mutex if
>>> update_sampling_rate() runs in parallel with
>>> cpufreq_governor_dbs()->cpufreq_governor_exit() and the latter wins
>>> the race.
>>>
>>> It looks like we need to drop the governor mutex before putting the
>>> kobject in cpufreq_governor_exit().
>>
>> I have tried to explore all possible ways of fixing this, and every
>> other way looked to be racy in some way.
>>
>> Does anyone else have a better idea (untested):
>>
>> -------------------------8<-------------------------
>>
>> Subject: [PATCH] cpufreq: ondemand: Shoot update_sampling_rate with a
>> separate
>>   work
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   drivers/cpufreq/cpufreq_governor.h |  2 ++
>>   drivers/cpufreq/cpufreq_ondemand.c | 39
>> +++++++++++++++++++++++++++++---------
>>   2 files changed, 32 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_governor.h
>> b/drivers/cpufreq/cpufreq_governor.h
>> index 7bed63e14e7d..97e604356b20 100644
>> --- a/drivers/cpufreq/cpufreq_governor.h
>> +++ b/drivers/cpufreq/cpufreq_governor.h
>> @@ -141,6 +141,8 @@ struct od_dbs_tuners {
>>       unsigned int powersave_bias;
>>       unsigned int io_is_busy;
>>       unsigned int min_sampling_rate;
>> +    struct work_struct work;
>> +    struct dbs_data *dbs_data;
>>   };
>>
>>   struct cs_dbs_tuners {
>> diff --git a/drivers/cpufreq/cpufreq_ondemand.c
>> b/drivers/cpufreq/cpufreq_ondemand.c
>> index 82ed490f7de0..93ad7a226aee 100644
>> --- a/drivers/cpufreq/cpufreq_ondemand.c
>> +++ b/drivers/cpufreq/cpufreq_ondemand.c
>> @@ -242,20 +242,27 @@ static struct common_dbs_data od_dbs_cdata;
>>    * reducing the sampling rate, we need to make the new value effective
>>    * immediately.
>>    */
>> -static void update_sampling_rate(struct dbs_data *dbs_data,
>> -        unsigned int new_rate)
>> +static void update_sampling_rate(struct work_struct *work)
>>   {
>> -    struct od_dbs_tuners *od_tuners = dbs_data->tuners;
>> +    struct od_dbs_tuners *od_tuners = container_of(work, struct
>> +                               od_dbs_tuners, work);
>> +    unsigned int new_rate = od_tuners->sampling_rate;
>> +    struct dbs_data *dbs_data = od_tuners->dbs_data;
>>       struct cpumask cpumask;
>>       int cpu;
>>
>> -    od_tuners->sampling_rate = new_rate = max(new_rate,
>> -            od_tuners->min_sampling_rate);
>> -
>>       /*
>>        * Lock governor so that governor start/stop can't execute in
>> parallel.
>> +     *
>> +     * We can't do a regular mutex_lock() here, as that may deadlock
>> against
>> +     * another thread performing CPUFREQ_GOV_POLICY_EXIT event on the
>> +     * governor, which might have already taken od_dbs_cdata.mutex
>> and is
>> +     * waiting for this work to finish.
>>        */
>> -    mutex_lock(&od_dbs_cdata.mutex);
>> +    if (!mutex_trylock(&od_dbs_cdata.mutex)) {
>> +        queue_work(system_wq, &od_tuners->work);
>> +        return;
>> +    }
>>
>>       cpumask_copy(&cpumask, cpu_online_mask);
>>
>> @@ -311,13 +318,22 @@ static void update_sampling_rate(struct dbs_data
>> *dbs_data,
>>   static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const
>> char *buf,
>>           size_t count)
>>   {
>> +    struct od_dbs_tuners *od_tuners = dbs_data->tuners;
>>       unsigned int input;
>>       int ret;
>>       ret = sscanf(buf, "%u", &input);
>>       if (ret != 1)
>>           return -EINVAL;
>>
>> -    update_sampling_rate(dbs_data, input);
>> +    od_tuners->sampling_rate = max(input, od_tuners->min_sampling_rate);
>> +
>> +    /*
>> +     * update_sampling_rate() requires to hold od_dbs_cdata.mutex,
>> but we
>> +     * can't take that from this thread, otherwise it results in ABBA
>> +     * lockdep between s_active and od_dbs_cdata.mutex locks.
>> +     */
>> +    queue_work(system_wq, &od_tuners->work);
>> +
>>       return count;
>>   }
>>
>> @@ -501,6 +517,8 @@ static int od_init(struct dbs_data *dbs_data, bool
>> notify)
>>       tuners->ignore_nice_load = 0;
>>       tuners->powersave_bias = default_powersave_bias;
>>       tuners->io_is_busy = should_io_be_busy();
>> +    INIT_WORK(&tuners->work, update_sampling_rate);
>> +    tuners->dbs_data = dbs_data;
>>
>>       dbs_data->tuners = tuners;
>>       return 0;
>> @@ -508,7 +526,10 @@ static int od_init(struct dbs_data *dbs_data,
>> bool notify)
>>
>>   static void od_exit(struct dbs_data *dbs_data, bool notify)
>>   {
>> -    kfree(dbs_data->tuners);
>> +    struct od_dbs_tuners *tuners = dbs_data->tuners;
>> +
>> +    cancel_work_sync(&tuners->work);
>> +    kfree(tuners);
>>   }
>>
>>   define_get_cpu_dbs_routines(od_cpu_dbs_info);
>>
>
> No no no no! Let's not open up this can of worms of queuing up the work
> to handle a write to a sysfs file. It *MIGHT* work for this specific
> tunable (I haven't bothered to analyze), but this makes it impossible to
> return a useful/proper error value.

Sent too soon. Not only that, but it can also cause the writes to the 
sysfs files to get processed in a different order and I don't know what 
other issues/races THAT will open up.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
