From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 12/19] cpufreq: fix locking of policy->rwsem in
 cpufreq_init_policy
Date: Thu, 14 Jan 2016 17:58:32 +0000
Message-ID: <20160114175832.GO18603@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-13-git-send-email-juri.lelli@arm.com>
 <20160112103956.GD1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48383 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756559AbcANR6J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jan 2016 12:58:09 -0500
Content-Disposition: inline
In-Reply-To: <20160112103956.GD1084@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 12/01/16 16:09, Viresh Kumar wrote:
> On 11-01-16, 17:35, Juri Lelli wrote:
> > There are paths in cpufreq_init_policy where policy is used, but its rwsem
> > is not held.
> > 
> > Fix it.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e7fc5c9..2c7cc6c73 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -998,21 +998,24 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
> >  {
> >  	int ret = 0;
> >  
> > +	down_write(&policy->rwsem);
> > +
> >  	/* Has this CPU been taken care of already? */
> > -	if (cpumask_test_cpu(cpu, policy->cpus))
> > +	if (cpumask_test_cpu(cpu, policy->cpus)) {
> > +		up_write(&policy->rwsem);
> 
> Perhaps create a label at the end to unlock the rwsem and jump to it?
> 

Yep, done.

Thanks,

- Juri
