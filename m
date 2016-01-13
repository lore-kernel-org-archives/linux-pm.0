From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 05/19] cpufreq: assert locking when accessing
 cpufreq_policy_list
Date: Wed, 13 Jan 2016 11:29:17 +0530
Message-ID: <20160113055917.GG6050@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-6-git-send-email-juri.lelli@arm.com>
 <20160112093452.GW1084@ubuntu>
 <20160112114454.GB7015@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160112114454.GB7015@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 12-01-16, 11:44, Juri Lelli wrote:
> But next_policy is called multiple times as part of
> for_each_suitable_policy().  What if someone thinks she/he can release
> cpufreq_driver_lock inside for_each_(in)active_policy() loop? Not that
> it makes sense, but don't you think it could happen?

Okay, I don't have strong opinion about using that only in the first
routine. No issues.

> > >  	/* No policies in the list */
> > >  	if (list_empty(&cpufreq_policy_list))
> > >  		return NULL;
> > > @@ -2430,6 +2432,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
> > >  	if (ret)
> > >  		goto err_boost_unreg;
> > >  
> > > +	lockdep_assert_held(&cpufreq_driver_lock);
> > 
> > Why do you need a cpufreq_driver_lock here? And the above change
> > should generate a lockdep here as the lock isn't taken right now.
> > 
> 
> Because you are checking cpufreq_policy_list to see if it's empty. And
> it generates a lockdep warning, yes; fixed by next patch. Maybe putting
> fixes before warnings, as you are suggesting, is better.

Well, locking isn't required because we think we need to protect every
access of a variable (like cpufreq_policy_list here). But we need to
protect its access from possible races.

What I am saying is, we can't have a race here. And so no need to lock
it down.

-- 
viresh
