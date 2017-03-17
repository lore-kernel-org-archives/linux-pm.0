From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Restore policy min/max limits on CPU online
Date: Fri, 17 Mar 2017 17:31:46 +0100
Message-ID: <CAJZ5v0jNp9t8uu0S4yRjT-TLHOcrAeMmjFzU6eBaaCp+C4j5Wg@mail.gmail.com>
References: <2084010.4xkKok06Gp@aspire.rjw.lan> <20170317032016.GC31040@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317032016.GC31040@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 17, 2017 at 4:20 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 16-03-17, 23:42, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> On CPU online the cpufreq core restores the previous governor (or
>> the previous "policy" setting for ->setpolicy drivers), but it does
>> not restore the min/max limits at the same time, which is confusing,
>> inconsistent and real pain for users who set the limits and then
>> suspend/resume the system (using full suspend), in which case the
>> limits are reset on all CPUs except for the boot one.
>>
>> Fix this by making cpufreq_init_policy() restore the limits when it
>> sees that this is CPU online and not initialization from scratch.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpufreq/cpufreq.c |    9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
>> +++ linux-pm/drivers/cpufreq/cpufreq.c
>> @@ -979,6 +979,8 @@ static int cpufreq_init_policy(struct cp
>>       /* Update governor of new_policy to the governor used before hotplug */
>>       gov = find_governor(policy->last_governor);
>>       if (gov) {
>> +             new_policy.min = policy->user_policy.min;
>> +             new_policy.max = policy->user_policy.max;
>>               pr_debug("Restoring governor %s for cpu %d\n",
>>                               policy->governor->name, policy->cpu);
>>       } else {
>> @@ -991,11 +993,14 @@ static int cpufreq_init_policy(struct cp
>>
>>       /* Use the default policy if there is no last_policy. */
>>       if (cpufreq_driver->setpolicy) {
>> -             if (policy->last_policy)
>> +             if (policy->last_policy) {
>>                       new_policy.policy = policy->last_policy;
>> -             else
>> +                     new_policy.min = policy->user_policy.min;
>> +                     new_policy.max = policy->user_policy.max;
>> +             } else {
>>                       cpufreq_parse_governor(gov->name, &new_policy.policy,
>>                                              NULL);
>> +             }
>>       }
>>       /* set default policy */
>>       return cpufreq_set_policy(policy, &new_policy);
>
> What about something like this instead ?

It generally would work, but I don't like it.

> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b8ff617d449d..5dbdd261aa73 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1184,6 +1184,9 @@ static int cpufreq_online(unsigned int cpu)
>                 for_each_cpu(j, policy->related_cpus)
>                         per_cpu(cpufreq_cpu_data, j) = policy;
>                 write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +       } else {
> +               policy->min = policy->user_policy.min;
> +               policy->max = policy->user_policy.max;
>         }
>
>         if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
>
>
> --

IMO if we are not going to restore the governor, we also should not
restore the limits as those things are related.  Now, the governor can
be unloaded while the CPU is offline.

Code duplication can be addressed by adding a helper function to do
the copying.  I can do that later if you insist.

Thanks,
Rafael
