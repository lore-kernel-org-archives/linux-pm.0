From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: use last policy after online
Date: Wed, 02 Dec 2015 14:05:27 -0800
Message-ID: <1449093927.3240.37.camel@spandruv-desk3.jf.intel.com>
References: <1449017534-6127-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <3188790.ma3TNFyjuZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:15448 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbbLBWG2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 2 Dec 2015 17:06:28 -0500
In-Reply-To: <3188790.ma3TNFyjuZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rafael.j.wysocki@intel.com, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Wed, 2015-12-02 at 03:05 +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 01, 2015 04:52:14 PM Srinivas Pandruvada wrote:
> > For cpufreq drivers which use setpolicy interface, after offline->online
> > the policy is set to default. This can be reproduced by setting the
> > default policy of intel_pstate or longrun to ondemand and then change to
> > "performance". After offline and online, the setpolicy will be called with
> > the policy=ondemand.
> > For drivers using governors this condition is handled by storing
> > last_governor, during offline and restoring during online. The same should
> > be done for drivers using setpolicy interface. Storing last_policy during
> > offline and restoring during online.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> I guess this is urgent, right?
I don't think. I tried couple of old kernels, same issue.

Thanks,
Srinivas
> 
> Is it a regression fix or has it just never worked?
> 
> > ---
> >  drivers/cpufreq/cpufreq.c | 14 ++++++++++----
> >  include/linux/cpufreq.h   |  1 +
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index a83c995..8412ce5 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -976,10 +976,14 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
> >  
> >  	new_policy.governor = gov;
> >  
> > -	/* Use the default policy if its valid. */
> > -	if (cpufreq_driver->setpolicy)
> > -		cpufreq_parse_governor(gov->name, &new_policy.policy, NULL);
> > -
> > +	/* Use the default policy if there is no last_policy. */
> > +	if (cpufreq_driver->setpolicy) {
> > +		if (policy->last_policy)
> > +			new_policy.policy = policy->last_policy;
> > +		else
> > +			cpufreq_parse_governor(gov->name, &new_policy.policy,
> > +					       NULL);
> > +	}
> >  	/* set default policy */
> >  	return cpufreq_set_policy(policy, &new_policy);
> >  }
> > @@ -1330,6 +1334,8 @@ static void cpufreq_offline_prepare(unsigned int cpu)
> >  		if (has_target())
> >  			strncpy(policy->last_governor, policy->governor->name,
> >  				CPUFREQ_NAME_LEN);
> > +		else
> > +			policy->last_policy = policy->policy;
> >  	} else if (cpu == policy->cpu) {
> >  		/* Nominate new CPU */
> >  		policy->cpu = cpumask_any(policy->cpus);
> > diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> > index ef4c5b1..177c768 100644
> > --- a/include/linux/cpufreq.h
> > +++ b/include/linux/cpufreq.h
> > @@ -77,6 +77,7 @@ struct cpufreq_policy {
> >  	unsigned int		suspend_freq; /* freq to set during suspend */
> >  
> >  	unsigned int		policy; /* see above */
> > +	unsigned int		last_policy; /* policy before unplug */
> >  	struct cpufreq_governor	*governor; /* see below */
> >  	void			*governor_data;
> >  	bool			governor_enabled; /* governor start/stop flag */
> > 
> 
> Thanks,
> Rafael
> 


