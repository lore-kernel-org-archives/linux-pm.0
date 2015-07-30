From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Lock CPU online/offline in
 cpufreq_register_driver()
Date: Thu, 30 Jul 2015 12:42:05 +0530
Message-ID: <20150730071205.GC31351@linux>
References: <2126034.7irFieEIfi@vostro.rjw.lan>
 <20150730054801.GJ5100@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150730054801.GJ5100@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Fixing Russell's id.

On 30-07-15, 11:18, Viresh Kumar wrote:
> On 30-07-15, 01:45, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > To protect against races with concurrent CPU online/offline, call
> > get_online_cpus() before registering a cpufreq driver.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |   13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > Index: linux-pm/drivers/cpufreq/cpufreq.c
> > ===================================================================
> > --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> > +++ linux-pm/drivers/cpufreq/cpufreq.c
> > @@ -2471,10 +2471,14 @@ int cpufreq_register_driver(struct cpufr
> >  
> >  	pr_debug("trying to register driver %s\n", driver_data->name);
> >  
> > +	/* Protect against concurrent CPU online/offline. */
> > +	get_online_cpus();
> > +
> >  	write_lock_irqsave(&cpufreq_driver_lock, flags);
> >  	if (cpufreq_driver) {
> >  		write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > -		return -EEXIST;
> > +		ret = -EEXIST;
> > +		goto out;
> >  	}
> >  	cpufreq_driver = driver_data;
> >  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > @@ -2513,7 +2517,10 @@ int cpufreq_register_driver(struct cpufr
> >  	register_hotcpu_notifier(&cpufreq_cpu_notifier);
> >  	pr_debug("driver %s up and running\n", driver_data->name);
> >  
> > -	return 0;
> > +out:
> > +	put_online_cpus();
> > +	return ret;
> > +
> >  err_if_unreg:
> >  	subsys_interface_unregister(&cpufreq_interface);
> >  err_boost_unreg:
> > @@ -2523,7 +2530,7 @@ err_null_driver:
> >  	write_lock_irqsave(&cpufreq_driver_lock, flags);
> >  	cpufreq_driver = NULL;
> >  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> > -	return ret;
> > +	goto out;
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_register_driver);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> -- 
> viresh

-- 
viresh
