From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Fix double addition of sysfs links
Date: Thu, 23 Jul 2015 11:24:57 +0530
Message-ID: <20150723055457.GC5322@linux>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
 <35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
 <20150722131539.GU7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:32941 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbGWFzD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 01:55:03 -0400
Received: by pdbnt7 with SMTP id nt7so80411698pdb.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2015 22:55:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150722131539.GU7557@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 22-07-15, 14:15, Russell King - ARM Linux wrote:
> > +	/* sysfs links are only created on subsys callback */
> > +	if (sif && policy) {
> > +		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
> 
> dev_dbg() ?

Hmm, right.

> > +		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> > +		if (ret) {
> > +			dev_err(dev, "%s: Failed to create link for cpu %d (%d)\n",

Rafael updated this instead with dev_dbg :), I am sending separate
patches to fix that now.

> > +				__func__, cpu, ret);
> 
> I wonder why we print the CPU number - since it's from dev->id, isn't it
> included in the struct device name printed by dev_err() already?

:(

> > +			return ret;
> > +		}
> > +
> > +		/* Track CPUs for which sysfs links are created */
> > +		cpumask_set_cpu(cpu, policy->symlinks);
> > +	}
> > +
> 
> I guess this will do for -rc, but it's not particularly nice.  Can I
> suggest splitting the two operations here - the add_dev callback from
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
> 	pr_debug("bringing CPU%d online\n", dev->id);
> 	... stuff to do when CPU is online ...
> }
> 
> static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> {
> 	unsigned int cpu = dev->id;
> 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> 
> 	pr_debug("adding CPU %u\n", cpu);
> 
> 	if (policy && policy->kobj_cpu != cpu) {
> 		dev_dbg(dev, "%s: Adding cpufreq symlink\n", __func__);
> 		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> 		if (ret) {
> 			dev_err(dev,
> 				"%s: Failed to create cpufreq symlink (%d)\n",
> 				__func__, ret);
> 			return ret;
> 		}
> 
> 		/* Track CPUs for which sysfs links are created */
> 		cpumask_set_cpu(cpu, policy->symlinks);
> 	}
> 
> 	/* Now do the remainder if the CPU is already online */
> 	if (cpu_online(cpu))
> 		return cpufreq_cpu_online(dev);
> 
> 	return 0;
> }
> 
> Next, change the cpufreq_add_dev(dev, NULL) in the hotplug notifier call
> to cpufreq_cpu_online(dev) instead.
> 
> Doing the similar thing for the cpufreq_remove_dev() path would also make
> sense.

Hmmm, Looks better ofcourse.

> > @@ -1521,42 +1472,54 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
> >  static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
> >  {
> >  	unsigned int cpu = dev->id;
> > +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> >  	int ret;
> >  
> > -	/*
> > -	 * Only possible if 'cpu' is getting physically removed now. A hotplug
> > -	 * notifier should have already been called and we just need to remove
> > -	 * link or free policy here.
> > -	 */
> > -	if (cpu_is_offline(cpu)) {
> > -		struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> > -		struct cpumask mask;
> > +	if (!policy)
> > +		return 0;
> >  
> > -		if (!policy)
> > -			return 0;
> > +	if (cpu_online(cpu)) {
> > +		ret = __cpufreq_remove_dev_prepare(dev, sif);
> > +		if (!ret)
> > +			ret = __cpufreq_remove_dev_finish(dev, sif);
> > +		if (ret)
> > +			return ret;
> 
> Here, I have to wonder about this.  If you look at the code in
> drivers/base/bus.c, you'll notice that the ->remove_dev return code is
> not used

Its not even using the return type of ->add_dev :), I have send an
update for that recently as that was required for cpufreq-drivers.
Greg must be applying that for 4.3 I hope :)

> (personally, I hate interfaces which are created with an int
> return type for a removal operation, but then ignore the return code.
> Either have the return code and use it, or don't confuse driver authors
> by having one.)

+1

> What this means is that in the remove path, the device _is_ going away,
> whether you like it or not.  So, if you have an error early in your
> remove path, returning that error does you no good - you end up leaking
> memory because subsequent cleanup doesn't get done.
> 
> It's better to either ensure that your removal path can't fail, or if it
> can, to reasonably clean up as much as you can (which here, means
> continuing to remove the symlink.)
> 
> If you adopt my suggestion above, then cpufreq_remove_dev() becomes
> something like:
> 
> static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
> {
> 	unsigned int cpu = dev->id;
> 	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> 
> 	if (cpu_is_online(cpu))
> 		cpufreq_cpu_offline(dev);
> 
> 	if (policy) {
> 		if (cpumask_test_cpu(cpu, policy->symlinks)) {
> 			dev_dbg(dev, "%s: Removing cpufreq symlink\n",
> 				__func__);
> 			cpumask_clear_cpu(cpu, policy->symlinks);
> 			sysfs_remove_link(&dev->kobj, "cpufreq");
> 		}
> 
> 		if (policy->kobj_cpu == cpu) {
> 			... migration code and final CPU deletion code ...
> 		}
> 	}
> 
> 	return 0;
> }
> 
> which IMHO is easier to read and follow, and more symetrical with
> cpufreq_add_dev().

Ack.

> Now, I'm left wondering about a few things:
> 
> 1. whether having a CPU "own" the policy, and having the cpufreq/ directory
>    beneath the cpuN node is a good idea, or whether it would be better to
>    place this in the /sys/devices/system/cpufreq/ subdirectory and always
>    symlink to there.  It strikes me that would simplify the code a little.

Hmm, but there can be multiple policies in a system and that would
surely confuse people.

> 2. whether using a kref to track the usage of the policy would be better
>    than tracking symlink weight (or in the case of (1) being adopted,
>    whether the symlink cpumask becomes empty.)


>    Note that the symlink
>    weight becoming zero without (1) (in other words, no symlinks) is not
>    the correct condition for freeing the policy - we still have one CPU,
>    that being the CPU for policy->kobj_cpu.

But that's the cpu which is getting removed now, so it was really the
last cpu and we can free the policy.

> 3. what happens when 'policy' is NULL at the point when the first (few) CPUs
>    are added

The first CPU that comes up has to create the policy.

>    - how do the symlinks get created later if/when policy becomes
>    non-NULL (can it?)

It can't.

> 4. what about policy->related_cpus ?  What if one of the CPUs being added is
>    not in policy->related_cpus?  Should we still go ahead and create the
>    symlink?

Let me explain a bit around how policy are managed, you might already
know this but I got a bit confused by your question.

Consider a octa-core big LITTLE platform. All big core share
clock/voltage rails and all LITTLE too..

The system will have two policies:
- big: This will manage four CPUs (0-3)
  - policy->related_cpus = 0 1 2 3
  - policy->cpus = all online CPUs from 0-3
- LITTLE: This will manage four CPUs (4-7)
  - policy->related_cpus = 4 5 6 7
  - policy->cpus = all online CPUs from 4-7

So if a CPU (say 5) doesn't find a place in big cluster's
policy->related_cpus, then it must belong to a different policy.

Does that clear your query? Or did I completely miss your concern ?

-- 
viresh
