From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: Avoid a couple of races related to cpufreq_cpu_get()
Date: Thu, 17 Nov 2016 14:35:54 +0100
Message-ID: <CAJZ5v0hYfDr0P6zG9GcCr_x_epQihxB8FdzpYH_hOUDSEc18BQ@mail.gmail.com>
References: <7191200.L2L3Fy8tSf@vostro.rjw.lan> <20161117063306.GC4894@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161117063306.GC4894@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 17, 2016 at 7:33 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> I still have few concerns that I would like to share ..
>
> On 16-11-16, 03:38, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> The cpumask_test_cpu() check in cpufreq_cpu_get_raw() is sort of
>> pointless, because it may be racy with respect to CPU online/offline
>> which sets/clears the policy->cpus mask.
>>
>> Some of the races resulting from that are benign (worst case, stale
>> values may be returned from some sysfs attribute for a relatively
>> short period), but some of them may lead to invocations of low-level
>> cpufreq driver callbacks for offline CPUs which is not guaranteed to
>> work in general.
>>
>> For this reason, move the cpumask_test_cpu() check away from
>> cpufreq_cpu_get_raw() and reserve it for the ondemand governor,
>> which calls it for online CPUs only and with CPU online/offline
>> locked anyway, and make the other callers of it use the per-CPU
>> variable whose value is returned by it directly.
>>
>> With that, add the cpumask_test_cpu() check to cpufreq_generic_get()
>> to preserve its current behavior for offline CPUs and to the callers
>> of cpufreq_cpu_get().  There, in the cases when the races might
>> lead to invocations of driver callbacks for offline CPUs, put it
>> under policy->rwsem.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>
>> -> v2:
>>  * Modify the changelog to make it better explain what's going on.
>>  * Add the missing cpumask_test_cpu() check to cpufreq_offline().
>>
>> ---
>>  drivers/cpufreq/cpufreq.c |   52 ++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 37 insertions(+), 15 deletions(-)
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
> There are many other users of cpufreq_cpu_get() outside of cpufreq
> core which aren't updated in this patch.

OK, fair enough.  I obviously overlooked that.

>>               if (policy)
>>                       kobject_get(&policy->kobj);
>>       }
>> @@ -1328,13 +1327,19 @@ static int cpufreq_offline(unsigned int
>>
>>       pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
>>
>> -     policy = cpufreq_cpu_get_raw(cpu);
>> +     policy = per_cpu(cpufreq_cpu_data, cpu);
>>       if (!policy) {
>>               pr_debug("%s: No cpu_data found\n", __func__);
>>               return 0;
>>       }
>>
>>       down_write(&policy->rwsem);
>> +
>> +     if (!cpumask_test_cpu(cpu, policy->cpus)) {
>> +             pr_debug("%s: CPU %u is offline\n", __func__, cpu);
>> +             goto unlock;
>> +     }
>> +
>
> Is it really important for this change to be present within the lock?
> I am not 100% sure.
>
> cpufreq_offline() can get called via two paths:
> - CPU hot-unplug
> - cpufreq driver getting unregistered
>
> The second path calls get_online_cpus() and so these two shall never
> race against each other.

OK

> And so it shall not be possible that
> policy->cpus is getting cleared for 'cpu' while this routine is
> running.
>
> Though I agree that this check is required for sure, but perhaps
> without the lock. Which also means that cpufreq_cpu_get_raw() wasn't
> required to get updated considering this case.

Right.

>>       if (has_target())
>>               cpufreq_stop_governor(policy);
>>
>> @@ -1455,7 +1460,9 @@ unsigned int cpufreq_quick_get(unsigned
>>
>>       policy = cpufreq_cpu_get(cpu);
>>       if (policy) {
>> -             ret_freq = policy->cur;
>> +             if (cpumask_test_cpu(cpu, policy->cpus))
>> +                     ret_freq = policy->cur;
>> +
>>               cpufreq_cpu_put(policy);
>>       }
>>
>> @@ -1475,7 +1482,9 @@ unsigned int cpufreq_quick_get_max(unsig
>>       unsigned int ret_freq = 0;
>>
>>       if (policy) {
>> -             ret_freq = policy->max;
>> +             if (cpumask_test_cpu(cpu, policy->cpus))
>> +                     ret_freq = policy->max;
>> +
>>               cpufreq_cpu_put(policy);
>>       }
>>
>> @@ -1526,7 +1535,10 @@ unsigned int cpufreq_get(unsigned int cp
>>
>>       if (policy) {
>>               down_read(&policy->rwsem);
>> -             ret_freq = __cpufreq_get(policy);
>> +
>> +             if (cpumask_test_cpu(cpu, policy->cpus))
>> +                     ret_freq = __cpufreq_get(policy);
>
> As __cpufreq_get() receives 'policy' as a parameter and not 'cpu',
> its always safe to call this if the policy isn't going away.
>
> i.e. cpumask_test_cpu() check can be done without down_read() here as
> well.

That unless cpu == policy->cpu and it is going offline I suppose?

The scenario is as follows.  cpufreq_get() is invoked for policy->cpu
and cpufreq_offline() runs for it at the same time.

cpufreq_get() calls cpufreq_cpu_get() which does the policy->cpus
check which passes, because cpufreq_offline() hasn't updated the mask
yet.  Now cpufreq_offline() updates the mask and proceeds with
cpufreq_driver->stop_cpu() and cpufreq_driver->exit().  Then, it drops
the lock.

cpufreq_get() acquires the lock.  The policy is still there, but it
may be inactive at this point.  Still, cpufreq_get() doesn't check
that, but invokes __cpufreq_get() unconditionally, which calls
cpufreq_driver->get(policy->cpu).  Is this still guaranteed to work?
I don't think so.

It looks like a policy_is_inactive() check should be there in
cpufreq_get() at least.

>> +
>>               up_read(&policy->rwsem);
>>
>>               cpufreq_cpu_put(policy);
>> @@ -2142,6 +2154,11 @@ int cpufreq_get_policy(struct cpufreq_po
>>       if (!cpu_policy)
>>               return -EINVAL;
>>
>> +     if (!cpumask_test_cpu(cpu, policy->cpus)) {
>> +             cpufreq_cpu_put(cpu_policy);
>> +             return -EINVAL;
>> +     }
>> +
>
> We are just copying the policy here, so it should be always safe.

So the check is not necessary at all?

>>       memcpy(policy, cpu_policy, sizeof(*policy));
>>
>>       cpufreq_cpu_put(cpu_policy);
>> @@ -2265,6 +2282,11 @@ int cpufreq_update_policy(unsigned int c
>>
>>       down_write(&policy->rwsem);
>>
>> +     if (!cpumask_test_cpu(cpu, policy->cpus)) {
>> +             ret = -ENODEV;
>> +             goto unlock;
>> +     }
>> +
>
> Here as well the test isn't required to be within the lock, as we are
> working on the policy and not CPU and at least one CPU is guaranteed
> to be online for now.

Say the CPU is the only one in the policy and it is going offline.

cpufreq_update_policy() is invoked at the same time and calls
cpufreq_cpu_get() which checks policy->cpus and the test passes,
because cpufreq_offline() hasn't updated the mask yet.  The
cpufreq_offline() updates the mask and the policy becomes inactive,
but there are no checks for that going forward, unless Im overlooking
something again.

> For the summary, I would like to understand a bit more on which
> particular code segment are we worried about, which will behave
> improperly without this change.

I described the two races above.

> Also, even if we have some real cases for cpufreq_cpu_get_raw(), which
> needs to get fixed, I believe that we can move the check to
> cpufreq_cpu_get() and not to every caller.

I disagree, but for now I'm going to leave cpufreq_cpu_get() alone.
To me, the policy->cpus check in cpufreq_cpu_get_raw() is just
confusing (it isn't even needed by some callers of that function),
which is the reason why I'd prefer to get rid of it.

I'll add policy_is_inactive() checks to cpufreq_get() and
cpufreq_update_policy() at this point.

> Sorry for the noise :(

No problem, you had some valid points.

Thanks,
Rafael
