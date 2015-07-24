From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Fri, 24 Jul 2015 22:20:29 +0200
Message-ID: <1509688.KKhdi8M36y@vostro.rjw.lan>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan> <20150724140943.GC16336@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150724140943.GC16336@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Friday, July 24, 2015 07:39:43 PM Viresh Kumar wrote:
> On 23-07-15, 23:14, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > After commit 87549141d516 (cpufreq: Stop migrating sysfs files on
> > hotplug) there is a problem with CPUs that share cpufreq policy
> > objects with other CPUs and are initially offline.
> > 
> > Say CPU1 shares a policy with CPU0 which is online and is registered
> > first.  As part of the registration process, cpufreq_add_dev() is
> > called for it.  It creates the policy object and a symbolic link
> > to it from the CPU1's sysfs directory.  If CPU1 is registered
> > subsequently and it is offline at that time, cpufreq_add_dev() will
> > attempt to create a symbolic link to the policy object for it, but
> > that link is present already, so a warning about that will be
> > triggered.
> > 
> > To avoid that warning, make cpufreq use an additional CPU mask
> > containing related CPUs that are actually present for each policy
> > object.  That mask is initialized when the policy object is populated
> > after its creation (for the first online CPU using it) and it includes
> > CPUs from the "policy CPUs" mask returned by the cpufreq driver's
> > ->init() callback that are physically present at that time.  Symbolic
> > links to the policy are created only for the CPUs in that mask.
> > 
> > If cpufreq_add_dev() is invoked for an offline CPU, it checks the
> > new mask and only creates the symlink if the CPU was not in it (the
> > CPU is added to the mask at the same time).
> > 
> > In turn, cpufreq_remove_dev() drops the given CPU from the new mask,
> > removes its symlink to the policy object and returns, unless it is
> > the CPU owning the policy object.  In that case, the policy object
> > is moved to a new CPU's sysfs directory or deleted if the CPU being
> > removed was the last user of the policy.
> > 
> > While at it, notice that cpufreq_remove_dev() can't fail, because
> > its return value is ignored, so make it ignore return values from
> > __cpufreq_remove_dev_prepare() and __cpufreq_remove_dev_finish()
> > and prevent these functions from aborting on errors returned by
> > __cpufreq_governor().
> > 
> > Fixes: 87549141d516 (cpufreq: Stop migrating sysfs files on hotplug)
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reported-by: Russell King <linux@arm.linux.org.uk>
> > ---
> > 
> > This is supposed to replace the other patches sent so far to address the issue
> > at hand.
> 
> Lets take this one and leave my patches. They are generating more
> diff and actually doing part of the general improvements Russell
> suggested.

OK, but we can do better than this. :-) (See below)

> > +	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
> 
> I was wondering if we should use cpumask_t type variables, so that we
> don't have to allocate these masks. They are always with policies.

We can do that, but let's do it as a cleanup later.

> > @@ -1307,6 +1316,9 @@ static int cpufreq_add_dev(struct device
> >  	/* related cpus should atleast have policy->cpus */
> >  	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
> >  
> > +	cpumask_and(policy->cpus, policy->cpus, cpu_present_mask);
> > +	cpumask_or(policy->real_cpus, policy->real_cpus, policy->cpus);
> > +
> 
> I will do this differently:
>         cpumask_and(policy->real_cpus, policy->cpus, cpu_present_mask);
> 
> policy->cpus is anyway going to be anded with online mask.

Right.

> >  	/*
> >  	 * affected cpus must always be the one, which are online. We aren't
> >  	 * managing offline cpus here.
> 
> 
> >  static int cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
> >  {
> 
> > -	ret = __cpufreq_remove_dev_prepare(dev, sif);
> > +	if (cpu != policy->kobj_cpu) {
> > +		remove_cpu_dev_symlink(policy, cpu);
> > +	} else {
> > +		/*
> > +		 * This is the CPU owning the policy object.  Move it to another
> > +		 * suitable CPU.
> > +		 */
> > +		unsigned int new_cpu = cpumask_first(policy->real_cpus);
> > +		struct device *new_dev = get_cpu_device(new_cpu);
> >  
> > -	if (!ret)
> > -		ret = __cpufreq_remove_dev_finish(dev, sif);
> > +		dev_dbg(dev, "%s: Moving policy object to CPU%u\n", __func__, new_cpu);
> >  
> > -	return ret;
> > +		policy->kobj_cpu = new_cpu;
> 
> You need to remove the link for the target cpu, like what I did in my
> patch:

Right.

Plus I forgot to drop the policy freeing from __cpufreq_remove_dev_finish().

>                sysfs_remove_link(&new_dev->kobj, "cpufreq");
> 
> > +		WARN_ON(kobject_move(&policy->kobj, &new_dev->kobj));
> > +	}
> > +
> > +	return 0;
> >  }
> >  
> >  static void handle_update(struct work_struct *work)

Still, as I said before, we can do better here.

The key observation is that if a CPU doesn't go online at all, we don't need to
care about it.  Hence, we can ignore a CPU until it goes online for the first
time and we only need to create policy symlinks for online CPUs (just like we
only create policy objects for online CPUs).

Of course, we need to avoid creating a duplicate policy symlink if the CPU
has been online at least once before, but that's quite straightforward.

I'll send an updated patch shortly.

Thanks,
Rafael
