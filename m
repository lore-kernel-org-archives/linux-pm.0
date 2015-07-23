From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpufreq: Separate CPU device removal from CPU online
Date: Thu, 23 Jul 2015 22:56:34 +0200
Message-ID: <1532128.uWbA5iRc7E@vostro.rjw.lan>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan> <15986005.VczafT3nkj@vostro.rjw.lan> <20150723063942.GF5322@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52477 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754046AbbGWU3p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 16:29:45 -0400
In-Reply-To: <20150723063942.GF5322@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Thursday, July 23, 2015 12:09:42 PM Viresh Kumar wrote:
> On 23-07-15, 02:04, Rafael J. Wysocki wrote:
> > +static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> > +{
> > +	unsigned int cpu = dev->id;
> > +	struct cpufreq_policy *policy = per_cpu(cpufreq_cpu_data, cpu);
> > +
> > +	pr_debug("%s: adding CPU %u\n", __func__, cpu);
> > +
> > +	if (policy && policy->kobj_cpu != cpu) {
> 
> Why are you comparing cpu against kobj_cpu ? I don't think it can ever
> be false.

It can.  When we're adding a CPU that has a policy already, because it is
"related" to a previously registered CPU.


> > +		int ret;
> > +
> > +		pr_debug("%s: Adding symlink for CPU: %u\n", __func__, cpu);
> 
> dev_dbg

OK

> > +		ret = sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq");
> > +		if (ret) {
> > +			dev_dbg(dev, "%s: Failed to create link (%d)\n",
> 
> dev_err

Well, I'm wondering about this.  Why does this have to be dev_err()?


> > +				__func__, ret);
> > +			return ret;
> > +		}
> > +
> > +		/* Track CPUs for which sysfs links are created */
> > +		cpumask_set_cpu(cpu, policy->linked_cpus);
> > +	}
> > +
> > +	return cpu_online(cpu) ? cpufreq_dev_online(dev, false) : 0;
> > +}
> 
> Looks fine otherwise. Thanks for getting your hands dirty :)
> 
> >  static void cpufreq_offline_prepare(unsigned int cpu)
> >  {
> >  	struct cpufreq_policy *policy;
> > @@ -2344,31 +2343,35 @@ unlock:
> >  }
> >  EXPORT_SYMBOL(cpufreq_update_policy);
> >  
> > +static void cpufreq_cpu_online(unsigned int cpu)
> > +{
> > +	struct device *dev = get_cpu_device(cpu);
> > +
> > +	if (dev)
> > +		cpufreq_dev_online(dev, true);
> > +}
> 
> What about dropping this wrapper function and ...
> 
> >  static int cpufreq_cpu_callback(struct notifier_block *nfb,
> >  					unsigned long action, void *hcpu)
> >  {
> >  	unsigned int cpu = (unsigned long)hcpu;
> > -	struct device *dev;
> >  
> > -	dev = get_cpu_device(cpu);
> 
> ... keeping this as is? And then we can do
> s/cpufreq_dev_online/cpufreq_cpu_online which suits better.

Well, we don't need the dev things for DOWN_PREPARE and POST_DEAD.

We actually only need it in a few places in cpufreq_dev_online(), or
maybe simply cpufreq_online(), so it can take the cpu argument too.

> > -	if (dev) {
> > -		switch (action & ~CPU_TASKS_FROZEN) {
> > -		case CPU_ONLINE:
> > -			cpufreq_add_dev(dev, NULL);
> > -			break;
> > -
> > -		case CPU_DOWN_PREPARE:
> > -			cpufreq_offline_prepare(cpu);
> > -			break;
> > -
> > -		case CPU_POST_DEAD:
> > -			cpufreq_offline_finish(cpu);
> > -			break;
> > -
> > -		case CPU_DOWN_FAILED:
> > -			cpufreq_add_dev(dev, NULL);
> > -			break;
> > -		}
> > +	switch (action & ~CPU_TASKS_FROZEN) {
> > +	case CPU_ONLINE:
> > +		cpufreq_cpu_online(cpu);
> > +		break;
> > +
> > +	case CPU_DOWN_PREPARE:
> > +		cpufreq_offline_prepare(cpu);
> > +		break;
> > +
> > +	case CPU_POST_DEAD:
> > +		cpufreq_offline_finish(cpu);
> > +		break;
> > +
> > +	case CPU_DOWN_FAILED:
> > +		cpufreq_cpu_online(cpu);
> > +		break;
> >  	}
> >  	return NOTIFY_OK;
> >  }
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
