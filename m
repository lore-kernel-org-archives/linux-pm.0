From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 15/19] cpufreq: remove useless usage of
 cpufreq_governor_mutex in __cpufreq_governor
Date: Tue, 12 Jan 2016 16:36:58 +0530
Message-ID: <20160112110658.GG1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 17:35, Juri Lelli wrote:
> Commit 6f1e4efd882e ("cpufreq: Fix timer/workqueue corruption by
> protecting reading governor_enabled") made policy->governor_enabled
> guarded by cpufreq_governor_mutex in __cpufreq_governor. Now that
> holding of policy->rwsem is asserted in __cpufreq_governor,
> cpufreq_governor_mutex is overkilling.

I am sure that is going to break it. Try that x86, somehow I don't get
it on my exynos boards.

> -	mutex_lock(&cpufreq_governor_mutex);
>  	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
>  	    || (!policy->governor_enabled
>  	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
> -		mutex_unlock(&cpufreq_governor_mutex);
>  		return -EBUSY;
>  	}

Actually the above checks should also be removed as the governors are
responsible for maintaining their state machines. But
userspace/powersave/performance don't have that support yet and so
these checks save them from going into undefined states.

Over that, above and below checks are incomplete..

> @@ -2006,8 +2004,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  	else if (event == CPUFREQ_GOV_START)
>  		policy->governor_enabled = true;
>  
> -	mutex_unlock(&cpufreq_governor_mutex);
> -
>  	ret = policy->governor->governor(policy, event);
>  
>  	if (!ret) {
> @@ -2017,12 +2013,10 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  			policy->governor->initialized--;
>  	} else {
>  		/* Restore original values */
> -		mutex_lock(&cpufreq_governor_mutex);
>  		if (event == CPUFREQ_GOV_STOP)
>  			policy->governor_enabled = true;
>  		else if (event == CPUFREQ_GOV_START)
>  			policy->governor_enabled = false;
> -		mutex_unlock(&cpufreq_governor_mutex);
>  	}
>  
>  	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
> -- 
> 2.2.2

-- 
viresh
