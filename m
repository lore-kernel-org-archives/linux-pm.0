From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/12] cpufreq: governor: Keep single copy of information
 common to policy->cpus
Date: Mon, 15 Jun 2015 12:16:24 +0530
Message-ID: <20150615064624.GK30078@linux>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
 <ca16538aebad3c886092c11dc3cc22e1385f2415.1434019473.git.viresh.kumar@linaro.org>
 <557E6D6E.1070200@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36506 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbFOGqc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 02:46:32 -0400
Received: by pabqy3 with SMTP id qy3so59401637pab.3
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 23:46:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <557E6D6E.1070200@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 15-06-15, 11:45, Preeti U Murthy wrote:
> On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> > @@ -320,6 +363,7 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
> >  		}
> > 
> >  		cdata->exit(dbs_data, policy->governor->initialized == 1);
> > +		free_ccdbs(policy, cdata);
> 
> This is a per-policy data structure, so why free it only when all the
> users of the governor are gone ? We should be freeing it when a policy
> is asked to exit, which is independent of references to this governor by
> other policy cpus. This would mean freeing it outside this if condition.

Right.

> > @@ -348,11 +393,13 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
> >  		io_busy = od_tuners->io_is_busy;
> >  	}
> > 
> > +	ccdbs->time_stamp = ktime_get();
> > +	mutex_init(&ccdbs->timer_mutex);
> > +
> >  	for_each_cpu(j, policy->cpus) {
> >  		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
> >  		unsigned int prev_load;
> > 
> > -		j_cdbs->policy = policy;
> 
> This is not convincing. INIT and EXIT should be typically used to
> initiate and free 'governor' specific data structures. START and STOP
> should be used for 'policy wide/cpu wide' initialization and making
> NULL. Atleast thats how the current code appears to be designed.
> 
> Now, ccdbs is a policy wide data structure. We can perhaps allocate and
> free ccdbs during INIT and EXIT, but initiating the values and making
> them NULL must be done in START and STOP respectively. You initiate the
> time_stamp and timer_mutex in START, why not initialize policy also
> here? This will help maintain consistency in code too.

I don't think it was done to use it early and so moving it to
START/STOP should be fine.
 
> > @@ -406,10 +452,7 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
> >  		cs_dbs_info->enable = 0;
> >  	}
> > 
> > -	gov_cancel_work(dbs_data, policy);
> > -
> > -	mutex_destroy(&cdbs->timer_mutex);
> > -	cdbs->policy = NULL;
> 
> Same here. For the same reason as above, the value for policy must be
> nullified in STOP. Besides, policy is initiated a value explicitly in
> INIT, but invalidated in EXIT by freeing ccdbs in this patch. There is
> lack of consistency.
> 
> There is another consequence. Freeing a data structure does not
> necessarily mean setting it to NULL. It can be some random address. This
> will break places which check for NULL policy.

If we are freeing ccdbs, then using ccdbs->policy isn't valid anymore.
And so while freeing ccdbs, we don't really need to set its fields to
NULL.

> > +	mutex_destroy(&ccdbs->timer_mutex);
> 
> Another point which you may have taken care of in the subsequent
> patches. I will mention here nevertheless.
> 
> The timer_mutex is destroyed, but the cdbs->policy is not NULL until we
> call EXIT. So when cpufreq_governor_limits() is called, it checks for
> the existence of ccdbs, which succeeds. But when it tries to take the
> timer_mutex it dereferences NULL.

Hmm, so I should keep checking for cdbs->ccdbs->policy instead and
make it NULL in STOP..

Nice work Preeti. Thanks.

-- 
viresh
