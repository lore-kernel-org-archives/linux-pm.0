From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/9] cpufreq: ondemand: queue work for policy->cpus
 together
Date: Tue, 8 Sep 2015 07:41:01 +0530
Message-ID: <20150908021101.GA26760@linux>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
 <d2760eca0b3fd5e427d004120bdb82c1aed215ca.1437999691.git.viresh.kumar@linaro.org>
 <2662457.Ri7bTTTVA1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2662457.Ri7bTTTVA1@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08-09-15, 03:33, Rafael J. Wysocki wrote:
> > +		/* Make sure the work is not canceled on policy->cpus */
> 
> I'm not sure what scenario can lead to that.  Care to explain?

CPUFREQ_GOV_STOP event called for the policy and so all its works
are in canceled state.

> > +		if (!dbs_info->cdbs.shared->policy)
> >  			continue;
> >  
> >  		next_sampling = jiffies + usecs_to_jiffies(new_rate);
> >  		appointed_at = dbs_info->cdbs.dwork.timer.expires;
> 
> For that to work we always need to do stuff for policy->cpus in sync.
> Do we?

Hmm, we are not in 100% sync for sure. Will check that again.

-- 
viresh
