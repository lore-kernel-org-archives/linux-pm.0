From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Fri, 7 Jul 2017 17:01:28 +0100
Message-ID: <c92f1bd0-6611-8eec-51d7-f6d7754a5870@arm.com>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170706094948.8779-3-dietmar.eggemann@arm.com>
 <20170706104027.GB13048@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbdGGQBc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jul 2017 12:01:32 -0400
In-Reply-To: <20170706104027.GB13048@vireshk-i7>
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On 06/07/17 11:40, Viresh Kumar wrote:
> On 06-07-17, 10:49, Dietmar Eggemann wrote:

[...]

>> In case arch_set_freq_scale() is not defined (and because of the
>> pr_debug() drivers/cpufreq/cpufreq.c is not compiled with -DDEBUG)
> 
> The line within () needs to be improved to convey a clear message.

Probably not needed anymore. See below.

[...]

>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 9bf97a366029..a04c5886a5ce 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -347,6 +347,28 @@ static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
>>  	}
>>  }
>>  
>> +/*********************************************************************
>> + *           FREQUENCY INVARIANT CPU CAPACITY SUPPORT                *
>> + *********************************************************************/
>> +
>> +#ifndef arch_set_freq_scale
>> +static void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>> +				unsigned long max_freq)
>> +{}
>> +#endif
>> +
>> +static void cpufreq_set_freq_scale(struct cpufreq_policy *policy,
>> +				   struct cpufreq_freqs *freqs)
>> +{
>> +	unsigned long cur_freq = freqs ? freqs->new : policy->cur;
>> +	unsigned long max_freq = policy->cpuinfo.max_freq;
>> +
>> +	pr_debug("cpus %*pbl cur/cur max freq %lu/%lu kHz\n",
>> +		 cpumask_pr_args(policy->related_cpus), cur_freq, max_freq);
>> +
>> +	arch_set_freq_scale(policy->related_cpus, cur_freq, max_freq);
> 
> I am not sure why all these are required to be sent here and will come back to
> it later on after going through other patches.

See below.

>> +}
>> +
>>  /**
>>   * cpufreq_notify_transition - call notifier chain and adjust_jiffies
>>   * on frequency transition.
>> @@ -405,6 +427,8 @@ void cpufreq_freq_transition_begin(struct cpufreq_policy *policy,
>>  
>>  	spin_unlock(&policy->transition_lock);
>>  
>> +	cpufreq_set_freq_scale(policy, freqs);
>> +
> 
> Why do this before even changing the frequency ? We may fail while changing it.
> 
> IMHO, you should call this routine whenever we update policy->cur and that
> happens regularly in __cpufreq_notify_transition() and few other places..

See below.
 
>>  	cpufreq_notify_transition(policy, freqs, CPUFREQ_PRECHANGE);
>>  }
>>  EXPORT_SYMBOL_GPL(cpufreq_freq_transition_begin);
>> @@ -2203,6 +2227,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>>  	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>  			CPUFREQ_NOTIFY, new_policy);
>>  
>> +	cpufreq_set_freq_scale(new_policy, NULL);
> 
> Why added it here ? To get it initialized ? If yes, then we should do that in
> cpufreq_online() where we first initialize policy->cur.

I agree. This can go away. Initialization is not really needed here. We initialize
the scale values to SCHED_CAPACITY_SCALE at boot-time. 

> Apart from this, you also need to update this in the schedutil governor (if you
> haven't done that in this series later) as that also updates policy->cur in the
> fast path.

So what about I call arch_set_freq_scale() in __cpufreq_notify_transition() in the
CPUFREQ_POSTCHANGE case for slow-switching and in cpufreq_driver_fast_switch() for
fast-switching?

Like this: (only slow-path slightly tested):

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9bf97a366029..77c4d5e7a598 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -301,6 +301,12 @@ static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
 #endif
 }
 
+#ifndef arch_set_freq_scale
+static void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
+                               unsigned long max_freq)
+{}
+#endif
+
 static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
                struct cpufreq_freqs *freqs, unsigned int state)
 {
@@ -343,6 +349,8 @@ static void __cpufreq_notify_transition(struct cpufreq_policy *policy,
                                CPUFREQ_POSTCHANGE, freqs);
                if (likely(policy) && likely(policy->cpu == freqs->cpu))
                        policy->cur = freqs->new;
+               arch_set_freq_scale(policy->related_cpus, policy->cur,
+                                   policy->cpuinfo.max_freq);
                break;
        }
 }
@@ -1824,9 +1832,18 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
                                        unsigned int target_freq)
 {
+       unsigned int ret;
+
        target_freq = clamp_val(target_freq, policy->min, policy->max);
 
-       return cpufreq_driver->fast_switch(policy, target_freq);
+       ret = cpufreq_driver->fast_switch(policy, target_freq);
+
+       if (ret != CPUFREQ_ENTRY_INVALID) {
+               arch_set_freq_scale(policy->related_cpus, target_freq,
+                                   policy->cpuinfo.max_freq);
+       }
+
+       return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
