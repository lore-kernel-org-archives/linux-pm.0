From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 14/19] cpufreq: fix locking of policy->rwsem in
 cpufreq_offline_finish
Date: Tue, 12 Jan 2016 16:32:17 +0530
Message-ID: <20160112110217.GF1084@ubuntu>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-15-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452533760-13787-15-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On 11-01-16, 17:35, Juri Lelli wrote:
> There are paths in cpufreq_offline_prepare where policy is used, but its
> rwsem is not held.
> 
> Fix it.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 91158b0..ba452c3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1381,9 +1381,13 @@ static void cpufreq_offline_finish(unsigned int cpu)
>  		return;
>  	}
>  
> +	down_write(&policy->rwsem);
> +
>  	/* Only proceed for inactive policies */
> -	if (!policy_is_inactive(policy))
> +	if (!policy_is_inactive(policy)) {
> +		up_write(&policy->rwsem);
>  		return;
> +	}
>  
>  	/* If cpu is last user of policy, free policy */
>  	if (has_target()) {
> @@ -1392,6 +1396,8 @@ static void cpufreq_offline_finish(unsigned int cpu)
>  			pr_err("%s: Failed to exit governor\n", __func__);
>  	}
>  
> +	up_write(&policy->rwsem);
> +
>  	/*
>  	 * Perform the ->exit() even during light-weight tear-down,
>  	 * since this is a core component, and is essential for the

I think we need to nail down the purpose of the lock first and discuss
the races we are trying to fix. For example, policy is used by all
cpufreq drivers, etc and no one is stopping them to use it without
taking the lock..

FWIW, I have also tried to do some cleanups earlier, but was never
able to send them upstream due to busy schedule.

ssh://git@git.linaro.org/people/viresh.kumar/linux.git
cpufreq/core/locking

You might find some interesting bits there.

-- 
viresh
