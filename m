From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 08/19] cpufreq: fix warning for cpufreq_init_policy
 unlocked access to cpufreq_governor_list
Date: Tue, 12 Jan 2016 15:39:45 +0530
Message-ID: <20160112100945.GZ1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-9-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-9-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 17:35, Juri Lelli wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7dae7f3..d065435 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -969,6 +969,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  
>  	memcpy(&new_policy, policy, sizeof(*policy));
>  
> +	mutex_lock(&cpufreq_governor_mutex);
>  	/* Update governor of new_policy to the governor used before hotplug */
>  	gov = find_governor(policy->last_governor);

You should take the lock within find_governor() instead, i.e.  around
the while loop.

>  	if (gov)
> @@ -976,6 +977,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  				policy->governor->name, policy->cpu);
>  	else
>  		gov = CPUFREQ_DEFAULT_GOVERNOR;
> +	mutex_unlock(&cpufreq_governor_mutex);
>  
>  	new_policy.governor = gov;
>  
> -- 
> 2.2.2

-- 
viresh
