From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Date: Fri, 9 Feb 2018 09:02:34 +0100
Message-ID: <197c26ba-c2a6-2de7-dffa-5b884079f746@evidence.eu.com>
References: <1518109302-8239-1-git-send-email-claudio@evidence.eu.com>
 <20180209035143.GX28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33250 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbeBIICg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 03:02:36 -0500
Received: by mail-wr0-f195.google.com with SMTP id s5so7280820wra.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2018 00:02:35 -0800 (PST)
In-Reply-To: <20180209035143.GX28462@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Viresh,

Il 09/02/2018 04:51, Viresh Kumar ha scritto:
> On 08-02-18, 18:01, Claudio Scordino wrote:
>> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
>> we should not wait for the rate limit, otherwise we may miss some deadline.
>>
>> Tests using rt-app on Exynos5422 have shown reductions of about 10% of deadline
>> misses for tasks with low RT periods.
>>
>> The patch applies on top of the one recently proposed by Peter to drop the
>> SCHED_CPUFREQ_* flags.
>>
>> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
>> CC: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
>> CC: Patrick Bellasi <patrick.bellasi@arm.com>
>> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> CC: Morten Rasmussen <morten.rasmussen@arm.com>
>> CC: Juri Lelli <juri.lelli@redhat.com>
>> CC: Viresh Kumar <viresh.kumar@linaro.org>
>> CC: Vincent Guittot <vincent.guittot@linaro.org>
>> CC: Todd Kjos <tkjos@android.com>
>> CC: Joel Fernandes <joelaf@google.com>
>> CC: linux-pm@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> So the previous commit was surely incorrect as it relied on comparing
> frequencies instead of dl-util, and freq requirements could have even
> changed due to CFS.

You're right.
The very original patch (not posted) added a specific SCHED_CPUFREQ flag to let the scheduling class ask for ignoring the rate limit.
However, polluting the API with further flags is not such a good approach.
The next patches didn't introduce such flag, but were incorrect.

> 
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index b0bd77d..d8dcba2 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -74,7 +74,10 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>>   
>>   /************************ Governor internals ***********************/
>>   
>> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy,
>> +				     u64 time,
>> +				     struct sugov_cpu *sg_cpu_old,
>> +				     struct sugov_cpu *sg_cpu_new)
>>   {
>>   	s64 delta_ns;
>>   
>> @@ -111,6 +114,10 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>>   		return true;
>>   	}
>>   
>> +	/* Ignore rate limit when DL increased utilization. */
>> +	if (sg_cpu_new->util_dl > sg_cpu_old->util_dl)
>> +		return true;
>> +
> 
> Changing the frequency has a penalty, specially in the ARM world (and
> that's where you are testing your stuff). I am worried that we will
> have (corner) cases where we will waste a lot of time changing the
> frequencies. For example (I may be wrong here), what if 10 small DL
> tasks are queued one after the other? The util will keep on changing
> and so will the frequency ? There may be more similar cases ?

I forgot to say that I've not observed any relevant increase of the energy consumption (measured through a Baylibre Cape).
However, the tests had a very small number of RT tasks.

If I'm not wrong, at the hardware level we do have a physical rate limit (as we cannot trigger a frequency update when there is one already on-going).
Don't know if this could somehow mitigate such effect.

Anyway, I'll repeat the tests with a considerable amount of RT tasks to check if I can reproduce such "ramp up" situation.
Depending on the energy results, we may have to choose between meeting more RT deadlines and consuming less energy.

> 
> Is it possible to (somehow) check here if the DL tasks will miss
> deadline if we continue to run at current frequency? And only ignore
> rate-limit if that is the case ?

I need to think further about it.

> 
>>   	delta_ns = time - sg_policy->last_freq_update_time;
>>   	return delta_ns >= sg_policy->freq_update_delay_ns;
>>   }
>> @@ -271,6 +278,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>>   				unsigned int flags)
>>   {
>>   	struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>> +	struct sugov_cpu sg_cpu_old = *sg_cpu;
> 
> Not really a big deal, but this structure is 80 bytes on ARM64, why
> copy everything when what we need is just 8 bytes ?

I didn't want to add deadline-specific code into the sugov_should_update_freq() signature as it should remain independent from the scheduling classes.
In my opinion, the best approach would be to group util_cfs and util_dl in a struct within sugov_cpu and pass that struct to sugov_should_update_freq().

Thanks for your comments.

                Claudio
