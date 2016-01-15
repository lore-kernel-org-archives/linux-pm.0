From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 13/19] cpufreq: fix locking of policy->rwsem in
 cpufreq_offline_prepare
Date: Fri, 15 Jan 2016 12:37:08 +0000
Message-ID: <20160115123708.GR18603@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-14-git-send-email-juri.lelli@arm.com>
 <20160112105447.GE1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52501 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbcAOMgo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 Jan 2016 07:36:44 -0500
Content-Disposition: inline
In-Reply-To: <20160112105447.GE1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 12/01/16 16:24, Viresh Kumar wrote:
> On 11-01-16, 17:35, Juri Lelli wrote:
> > There are paths in cpufreq_offline_prepare where policy is used, but its
> > rwsem is not held.
> > 
> > Fix it.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> I know the locking in general in cpufreq core is poor. We recently
> fixed lots of issues in governors ..
> 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 2c7cc6c73..91158b0 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1332,13 +1332,13 @@ static void cpufreq_offline_prepare(unsigned int cpu)
> >  		return;
> >  	}
> >  
> > +	down_write(&policy->rwsem);
> >  	if (has_target()) {
> >  		int ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
> >  		if (ret)
> >  			pr_err("%s: Failed to stop governor\n", __func__);
> >  	}
> >  
> > -	down_write(&policy->rwsem);
> >  	cpumask_clear_cpu(cpu, policy->cpus);
> >  
> >  	if (policy_is_inactive(policy)) {
> > @@ -1356,12 +1356,16 @@ static void cpufreq_offline_prepare(unsigned int cpu)
> >  	/* Start governor again for active policy */
> >  	if (!policy_is_inactive(policy)) {
> 
> Why shouldn't this be under the lock?
> 
> >  		if (has_target()) {
> > -			int ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
> > +			int ret;
> > +
> > +			down_write(&policy->rwsem);
> > +			ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
> >  			if (!ret)
> >  				ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
> >  
> >  			if (ret)
> >  				pr_err("%s: Failed to start governor\n", __func__);
> > +			up_write(&policy->rwsem);
> >  		}
> >  	} else if (cpufreq_driver->stop_cpu) {
> >  		cpufreq_driver->stop_cpu(policy);
> 
> And this ?
> 

Right. Releasing rwsem at the end seems to work.

Best,

- Juri
