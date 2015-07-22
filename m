From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] cpufreq: Fix double addition of sysfs links
Date: Wed, 22 Jul 2015 18:42:36 +0200
Message-ID: <CAJZ5v0jGPHq0P90pTbWGSnydgCQ5TcSxQ-KFuRjZ=qT6gNp_cg@mail.gmail.com>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
	<35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
	<20150722131539.GU7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34167 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934767AbbGVQmi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 12:42:38 -0400
In-Reply-To: <20150722131539.GU7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Russell,

On Wed, Jul 22, 2015 at 3:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 22, 2015 at 05:37:18PM +0530, Viresh Kumar wrote:

[cut]

>> @@ -1252,26 +1196,37 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>>  {
>>       unsigned int j, cpu = dev->id;
>>       int ret = -ENOMEM;
>> -     struct cpufreq_policy *policy;
>> +     struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>>       unsigned long flags;
>>       bool recover_policy = !sif;
>>
>>       pr_debug("adding CPU %u\n", cpu);
>>
>> +     /* sysfs links are only created on subsys callback */
>> +     if (sif && policy) {
>> +             pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
>
> dev_dbg() ?

Right.

>> +             ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
>> +             if (ret) {
>> +                     dev_err(dev, "%s: Failed to create link for cpu %d (%d)\n",
>> +                             __func__, cpu, ret);
>
> I wonder why we print the CPU number - since it's from dev->id, isn't it
> included in the struct device name printed by dev_err() already?

It is AFAICS.

>> +                     return ret;
>> +             }
>> +
>> +             /* Track CPUs for which sysfs links are created */
>> +             cpumask_set_cpu(cpu, policy->symlinks);
>> +     }
>> +
>
> I guess this will do for -rc, but it's not particularly nice.

Right.

This is what I'm queuing up for -rc:
http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=9b07109f06a1edd6e636b1e7397157eae0e6baa4

I've made a few other minor changes (discussed with Viresh on IRC) to it.

> Can I suggest splitting the two operations here - the add_dev callback from
> the subsys interface, and the handling of hotplug online/offline
> notifications.
>
> You only need to do the above for the subsys interface, and you only
> need to do the remainder if the CPU was online.
>
> Also, what about the CPU "owning" the policy?
>
> So, this would become:
>
> static int cpufreq_cpu_online(struct device *dev)
> {
>         pr_debug("bringing CPU%d online\n", dev->id);
>         ... stuff to do when CPU is online ...
> }
>
> static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> {
>         unsigned int cpu = dev->id;
>         struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>
>         pr_debug("adding CPU %u\n", cpu);
>
>         if (policy && policy->kobj_cpu != cpu) {
>                 dev_dbg(dev, "%s: Adding cpufreq symlink\n", __func__);
>                 ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
>                 if (ret) {
>                         dev_err(dev,
>                                 "%s: Failed to create cpufreq symlink (%d)\n",
>                                 __func__, ret);
>                         return ret;
>                 }
>
>                 /* Track CPUs for which sysfs links are created */
>                 cpumask_set_cpu(cpu, policy->symlinks);
>         }
>
>         /* Now do the remainder if the CPU is already online */
>         if (cpu_online(cpu))
>                 return cpufreq_cpu_online(dev);
>
>         return 0;
> }
>
> Next, change the cpufreq_add_dev(dev, NULL) in the hotplug notifier call
> to cpufreq_cpu_online(dev) instead.

These are good suggestions.  I actually have a plan to do that cleanup
on top of the VIresh's patch.

> Doing the similar thing for the cpufreq_remove_dev() path would also make
> sense.

cpufreq_remove_dev() is only called from bus.c already, but it also
has to handle the driver removal case.

And I already have a patch to drop the "sif" argument from
__cpufreq_remove_dev_prepare/finish() that are called on CPU offline.

>>       /*
>> -      * Only possible if 'cpu' wasn't physically present earlier and we are
>> -      * here from subsys_interface add callback. A hotplug notifier will
>> -      * follow and we will handle it like logical CPU hotplug then. For now,
>> -      * just create the sysfs link.
>> +      * A hotplug notifier will follow and we will take care of rest
>> +      * of the initialization then.
>>        */
>>       if (cpu_is_offline(cpu))
>> -             return add_cpu_dev_symlink(per_cpu(cpufreq_cpu_data, cpu), cpu);
>> +             return 0;
>>
>>       if (!down_read_trylock(&cpufreq_rwsem))
>>               return 0;
>>
>>       /* Check if this CPU already has a policy to manage it */
>> -     policy = per_cpu(cpufreq_cpu_data, cpu);
>>       if (policy && !policy_is_inactive(policy)) {
>>               WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
>>               ret = cpufreq_add_policy_cpu(policy, cpu, dev);
>> @@ -1506,10 +1461,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>>       if (cpufreq_driver->exit)
>>               cpufreq_driver->exit(policy);
>>
>> -     /* Free the policy only if the driver is getting removed. */
>> -     if (sif)
>> -             cpufreq_policy_free(policy, true);
>> -
>>       return 0;
>>  }
>>
>> @@ -1521,42 +1472,54 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>>  static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>>  {
>>       unsigned int cpu = dev->id;
>> +     struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>>       int ret;
>>
>> -     /*
>> -      * Only possible if 'cpu' is getting physically removed now. A hotplug
>> -      * notifier should have already been called and we just need to remove
>> -      * link or free policy here.
>> -      */
>> -     if (cpu_is_offline(cpu)) {
>> -             struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>> -             struct cpumask mask;
>> +     if (!policy)
>> +             return 0;
>>
>> -             if (!policy)
>> -                     return 0;
>> +     if (cpu_online(cpu)) {
>> +             ret = __cpufreq_remove_dev_prepare(dev, sif);
>> +             if (!ret)
>> +                     ret = __cpufreq_remove_dev_finish(dev, sif);
>> +             if (ret)
>> +                     return ret;
>
> Here, I have to wonder about this.  If you look at the code in
> drivers/base/bus.c, you'll notice that the ->remove_dev return code is
> not used (personally, I hate interfaces which are created with an int
> return type for a removal operation, but then ignore the return code.
> Either have the return code and use it, or don't confuse driver authors
> by having one.)
>
> What this means is that in the remove path, the device _is_ going away,
> whether you like it or not.  So, if you have an error early in your
> remove path, returning that error does you no good - you end up leaking
> memory because subsequent cleanup doesn't get done.

Right.

> It's better to either ensure that your removal path can't fail, or if it
> can, to reasonably clean up as much as you can (which here, means
> continuing to remove the symlink.)
>
> If you adopt my suggestion above, then cpufreq_remove_dev() becomes
> something like:
>
> static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
> {
>         unsigned int cpu = dev->id;
>         struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
>
>         if (cpu_is_online(cpu))
>                 cpufreq_cpu_offline(dev);
>
>         if (policy) {
>                 if (cpumask_test_cpu(cpu, policy->symlinks)) {
>                         dev_dbg(dev, "%s: Removing cpufreq symlink\n",
>                                 __func__);
>                         cpumask_clear_cpu(cpu, policy->symlinks);
>                         sysfs_remove_link(&dev->kobj, "cpufreq");
>                 }
>
>                 if (policy->kobj_cpu == cpu) {
>                         ... migration code and final CPU deletion code ...
>                 }
>         }
>
>         return 0;
> }
>
> which IMHO is easier to read and follow, and more symetrical with
> cpufreq_add_dev().

Agreed (in general).

> Now, I'm left wondering about a few things:
>
> 1. whether having a CPU "own" the policy, and having the cpufreq/ directory
>    beneath the cpuN node is a good idea, or whether it would be better to
>    place this in the /sys/devices/system/cpufreq/ subdirectory and always
>    symlink to there.  It strikes me that would simplify the code a little.

That is a good idea IMO.  A small complication here is that there may
be multiple policies in the system and a kobject is needed for each of
them.

> 2. whether using a kref to track the usage of the policy would be better
>    than tracking symlink weight (or in the case of (1) being adopted,
>    whether the symlink cpumask becomes empty.)  Note that the symlink
>    weight becoming zero without (1) (in other words, no symlinks) is not
>    the correct condition for freeing the policy - we still have one CPU,
>    that being the CPU for policy->kobj_cpu.

Well, if we do (1), it certainly would be more straightforward to use
krefs for that.

> 3. what happens when 'policy' is NULL at the point when the first (few) CPUs
>    are added - how do the symlinks get created later if/when policy becomes
>    non-NULL (can it?)

Yes, it can, and we have a design issue here that bothers me a bit.
Namley, we need a driver's ->init callback to populate policy->cpus
for us, but this is not the only thing it is doing, so the concern is
that it may not be able to deal with CPUs that aren't online.

I was thinking about an additional driver callback that would *only*
populate a mask of CPUs that should use the same policy as the given
one.  We'd be able to call that from cpufreq_add_dev() for offline
CPUs too and this way the policy object could be created for the first
CPU using the policy that is registered instead of being added for the
first CPU using that policy that becomes online (which happens today).

> 4. what about policy->related_cpus ?  What if one of the CPUs being added is
>    not in policy->related_cpus?

It will need a new policy.

>  Should we still go ahead and create the  symlink?

There's nothing to link to then.  The policy object will be created
when that CPU becomes online (as per the above).

Thanks,
Rafael
