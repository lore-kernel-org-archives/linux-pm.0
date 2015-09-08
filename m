From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/9] cpufreq: conservative: remove 'enable' field
Date: Tue, 8 Sep 2015 07:03:09 +0530
Message-ID: <20150908013309.GX26760@linux>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
 <91abed4ff8fe68f26fe0bdc840982bb972dba6dc.1437999691.git.viresh.kumar@linaro.org>
 <2910194.KRcaApdNFO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33176 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbbIHBdO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 21:33:14 -0400
Received: by pacex6 with SMTP id ex6so108744940pac.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 18:33:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2910194.KRcaApdNFO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On 08-09-15, 02:17, Rafael J. Wysocki wrote:
> >  static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
> >  					   struct cpufreq_policy *policy)
> >  {
> > @@ -119,12 +132,14 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
> >  	struct cpufreq_freqs *freq = data;
> >  	struct cs_cpu_dbs_info_s *dbs_info =
> >  					&per_cpu(cs_cpu_dbs_info, freq->cpu);
> > -	struct cpufreq_policy *policy;
> > +	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
> >  
> > -	if (!dbs_info->enable)
> > +	if (!policy)
> >  		return 0;
> >  
> > -	policy = dbs_info->cdbs.shared->policy;
> 
> So here we could get to the policy directly.  After the change we have to:
> 
> - acquire cpufreq_rwsem
> - acquire cpufreq_driver_lock
> - go the kobject_get on policy->kobj

Hmm, actually we can do cpufreq_cpu_get_raw() here as this is getting
called from notifier and policy isn't going to get freed for sure.

And then it wouldn't be that bad.

> and then finally drop the reference to the kobject when we're done.
> 
> So may I ask where exactly is the improvement?

Agree. Let me resend it quickly.

> > +	/* policy isn't governed by conservative governor */
> > +	if (policy->governor != &cpufreq_gov_conservative)
> > +		goto policy_put;
> >  
> >  	/*
> >  	 * we only care if our internally tracked freq moves outside the 'valid'
> 
> Thanks,
> Rafael

-- 
viresh
