From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH] cpufreq: Use list_is_last() to check last entry of the
 policy list
Date: Mon, 25 Jan 2016 11:18:24 +0000
Message-ID: <20160125111824.GH10898@e106622-lin>
References: <1453715167-26165-1-git-send-email-ego@linux.vnet.ibm.com>
 <20160125095029.GE3183@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35965 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755674AbcAYLRv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Jan 2016 06:17:51 -0500
Content-Disposition: inline
In-Reply-To: <20160125095029.GE3183@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Hi,

On 25/01/16 15:20, Viresh Kumar wrote:
> On 25-01-16, 15:16, Gautham R. Shenoy wrote:
> > Currently next_policy() explicitly checks if a policy is the last
> > policy in the cpufreq_policy_list. Use the standard list_is_last
> > primitive instead.
> > 
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 78b1e2f..b3059a3 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -67,11 +67,11 @@ static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> >  {
> >  	lockdep_assert_held(&cpufreq_driver_lock);

Which branch is this patch based on?

Thanks,

- Juri

> >  	do {
> > -		policy = list_next_entry(policy, policy_list);
> > -
> >  		/* No more policies in the list */
> > -		if (&policy->policy_list == &cpufreq_policy_list)
> > +		if (list_is_last(&policy->policy_list, &cpufreq_policy_list))
> >  			return NULL;
> > +
> > +		policy = list_next_entry(policy, policy_list);
> >  	} while (!suitable_policy(policy, active));
> >  
> >  	return policy;
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> -- 
> viresh
> 
