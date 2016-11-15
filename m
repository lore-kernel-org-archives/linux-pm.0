From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Avoid a couple of races related to cpufreq_cpu_get()
Date: Tue, 15 Nov 2016 13:59:07 +0100
Message-ID: <CAJZ5v0hzoeGdF30uTbAeQSDTAG3PRHxXnRBdEyeLM3REWUkzuw@mail.gmail.com>
References: <6245332.6H0YK9yF0m@vostro.rjw.lan> <20161115040952.GH4178@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36532 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbcKOM7J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 07:59:09 -0500
In-Reply-To: <20161115040952.GH4178@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, Nov 15, 2016 at 5:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14-11-16, 22:51, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The cpumask_test_cpu() check in cpufreq_cpu_get_raw() is sort of
>> pointless, because it may be racy with respect to CPU online/offline
>> which sets/clears the policy->cpus mask.
>>
>> For this reason, it is better to reserve cpufreq_cpu_get_raw() for
>> the ondemand governor, which calls it for online CPUs only with CPU
>> online/offline locked anyway, and move the cpumask_test_cpu() up the
>> call chain.
>>
>> Moreover, the callers of cpufreq_cpu_get() that really care about
>> avoiding races with CPU online/offline should better carry out that
>> check under policy->rwsem.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpufreq/cpufreq.c |   46 +++++++++++++++++++++++++++++++---------------
>>  1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
>> +++ linux-pm/drivers/cpufreq/cpufreq.c
>> @@ -65,6 +65,12 @@ static struct cpufreq_driver *cpufreq_dr
>>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>>  static DEFINE_RWLOCK(cpufreq_driver_lock);
>>
>> +struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>> +{
>> +     return per_cpu(cpufreq_cpu_data, cpu);
>> +}
>> +EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
>> +
>
> It may be better to move this to cpufreq.h and make it inline instead
> as this is really light weight now.

I wanted to avoid exporting cpufreq_cpu_data.

>>  /* Flag to suspend/resume CPUFreq governors */
>>  static bool cpufreq_suspended;
>>
>> @@ -192,19 +198,12 @@ int cpufreq_generic_init(struct cpufreq_
>>  }
>>  EXPORT_SYMBOL_GPL(cpufreq_generic_init);
>>
>> -struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
>> -{
>> -     struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>> -
>> -     return policy && cpumask_test_cpu(cpu, policy->cpus) ? policy : NULL;
>> -}
>> -EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
>> -
>>  unsigned int cpufreq_generic_get(unsigned int cpu)
>>  {
>> -     struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
>> +     struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>>
>> -     if (!policy || IS_ERR(policy->clk)) {
>> +     if (!policy || !cpumask_test_cpu(cpu, policy->cpus) ||
>
> The race you described in commit log is still valid at this point,
> isn't it ?

Yes, it is.

This just preserves the current behaviour and it only is racy during
CPU online/offline (if you are unlucky enough to invoke this at a
wrong time).  It does the right thing for offline CPUs, though.

>> +         IS_ERR(policy->clk)) {
>>               pr_err("%s: No %s associated to cpu: %d\n",
>>                      __func__, policy ? "clk" : "policy", cpu);
>>               return 0;
>> @@ -240,7 +239,7 @@ struct cpufreq_policy *cpufreq_cpu_get(u
>>
>>       if (cpufreq_driver) {
>>               /* get the CPU */
>> -             policy = cpufreq_cpu_get_raw(cpu);
>> +             policy = per_cpu(cpufreq_cpu_data, cpu);
>
> This changes the expectations of the users of cpufreq_cpu_get() as
> this will return policy for non policy->cpus as well now. I am sure
> this will break some of the assumptions at the callers and we need to
> visit all the sites to make sure it is fine.

Yes.  That's what the rest of the patch is for, pretty much. :-)

>>               if (policy)
>>                       kobject_get(&policy->kobj);
>>       }
>> @@ -1328,7 +1327,7 @@ static int cpufreq_offline(unsigned int
>>
>>       pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
>>
>> -     policy = cpufreq_cpu_get_raw(cpu);
>> +     policy = per_cpu(cpufreq_cpu_data, cpu);
>
> I think we can keep cpufreq_cpu_get_raw() here instead, as that will
> do exactly this. Also we need the policy->cpus test here.

No and not quite.

First, if someone wants to understand the code, it is easier to do
that if the per-CPU variable is accessed directly.

Second, I forgot about the driver unregistration case.  In that case
we need the check, but it needs to go under policy->rwsem.

>>       if (!policy) {
>>               pr_debug("%s: No cpu_data found\n", __func__);
>>               return 0;
>> @@ -1455,7 +1454,9 @@ unsigned int cpufreq_quick_get(unsigned
>>
>>       policy = cpufreq_cpu_get(cpu);
>>       if (policy) {
>> -             ret_freq = policy->cur;
>> +             if (cpumask_test_cpu(cpu, policy->cpus))
>
> We can still have the race here, isn't it ?

Yes.  That's to preserve the current behaviour.

>> +                     ret_freq = policy->cur;
>> +
>>               cpufreq_cpu_put(policy);
>>       }
>>
>> @@ -1475,7 +1476,9 @@ unsigned int cpufreq_quick_get_max(unsig
>>       unsigned int ret_freq = 0;
>>
>>       if (policy) {
>> -             ret_freq = policy->max;
>> +             if (cpumask_test_cpu(cpu, policy->cpus))
>
> Same here..

Right.

>> +                     ret_freq = policy->max;
>> +
>>               cpufreq_cpu_put(policy);
>>       }
>>
>> @@ -1526,7 +1529,10 @@ unsigned int cpufreq_get(unsigned int cp
>>
>>       if (policy) {
>>               down_read(&policy->rwsem);
>> -             ret_freq = __cpufreq_get(policy);
>> +
>> +             if (cpumask_test_cpu(cpu, policy->cpus))
>> +                     ret_freq = __cpufreq_get(policy);
>> +
>
> We don't have the race here ..

Well, what about the tegra-devfreq.c call site?

And I'm not sure what you mean.

Without the patch, CPU offline may take place after the policy check
above and before the down_read() AFAICS in which case we'll end up
invoking ->get() from the cpufreq driver on an offline CPU, which may
not be a good idea.

>>               up_read(&policy->rwsem);
>>
>>               cpufreq_cpu_put(policy);
>> @@ -2142,6 +2148,11 @@ int cpufreq_get_policy(struct cpufreq_po
>>       if (!cpu_policy)
>>               return -EINVAL;
>>
>> +     if (!cpumask_test_cpu(cpu, policy->cpus)) {
>
> This is still racy..

Yes.  Same comment as before: current behaviour.

>> +             cpufreq_cpu_put(cpu_policy);
>> +             return -EINVAL;
>> +     }
>> +
>>       memcpy(policy, cpu_policy, sizeof(*policy));
>>
>>       cpufreq_cpu_put(cpu_policy);
>> @@ -2265,6 +2276,11 @@ int cpufreq_update_policy(unsigned int c
>>
>>       down_write(&policy->rwsem);
>>
>> +     if (!cpumask_test_cpu(cpu, policy->cpus)) {
>
> This is not racy.

It is without the patch.

Again, the CPU may go offline between the policy check and the
down_write().  If that happens, we'll end up calling low-level stuff
on an offline CPU.

>> +             ret = -ENODEV;
>> +             goto unlock;
>> +     }
>> +
>>       pr_debug("updating policy for CPU %u\n", cpu);
>>       memcpy(&new_policy, policy, sizeof(*policy));
>>       new_policy.min = policy->user_policy.min;
>
> --

Thanks,
Rafael
