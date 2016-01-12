From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH 05/19] cpufreq: assert locking when accessing
 cpufreq_policy_list
Date: Tue, 12 Jan 2016 11:44:54 +0000
Message-ID: <20160112114454.GB7015@e106622-lin>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-6-git-send-email-juri.lelli@arm.com>
 <20160112093452.GW1084@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160112093452.GW1084@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 12/01/16 15:04, Viresh Kumar wrote:
> On 11-01-16, 17:35, Juri Lelli wrote:
> > cpufreq_policy_list is guarded by cpufreq_driver_lock. Add appropriate
> > locking assertions to check that we always access the list while holding
> > the associated lock.
> > 
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 00a00cd..63d6efb 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -65,6 +65,7 @@ static bool suitable_policy(struct cpufreq_policy *policy, bool active)
> >  static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
> >  					  bool active)
> >  {
> > +	lockdep_assert_held(&cpufreq_driver_lock);
> >  	do {
> >  		policy = list_next_entry(policy, policy_list);
> >  
> > @@ -80,6 +81,7 @@ static struct cpufreq_policy *first_policy(bool active)
> >  {
> >  	struct cpufreq_policy *policy;
> >  
> > +	lockdep_assert_held(&cpufreq_driver_lock);
> 
> Because both first_policy() and next_policy() are parts of
> for_each_suitable_policy() macro, checking this in first_policy() is
> sufficient. next_policy() isn't designed to be used by any other code.
> 

But next_policy is called multiple times as part of
for_each_suitable_policy().  What if someone thinks she/he can release
cpufreq_driver_lock inside for_each_(in)active_policy() loop? Not that
it makes sense, but don't you think it could happen?

> >  	/* No policies in the list */
> >  	if (list_empty(&cpufreq_policy_list))
> >  		return NULL;
> > @@ -2430,6 +2432,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> >  	if (ret)
> >  		goto err_boost_unreg;
> >  
> > +	lockdep_assert_held(&cpufreq_driver_lock);
> 
> Why do you need a cpufreq_driver_lock here? And the above change
> should generate a lockdep here as the lock isn't taken right now.
> 

Because you are checking cpufreq_policy_list to see if it's empty. And
it generates a lockdep warning, yes; fixed by next patch. Maybe putting
fixes before warnings, as you are suggesting, is better.

Thanks,

- Juri

> >  	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
> >  	    list_empty(&cpufreq_policy_list)) {
> >  		/* if all ->init() calls failed, unregister */
> > -- 
> > 2.2.2
> 
> -- 
> viresh
> 
