From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 7/7] cpufreq: Remove cpufreq_governor_lock
Date: Thu, 4 Feb 2016 12:13:04 +0530
Message-ID: <20160204064304.GA3469@vireshk>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
 <75f5a53c38b1efcfe7dc496525b0e96b6343a93e.1454507872.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <75f5a53c38b1efcfe7dc496525b0e96b6343a93e.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03-02-16, 19:32, Viresh Kumar wrote:
> We used to drop policy->rwsem just before calling __cpufreq_governor()
> in some cases earlier and so it was possible that __cpufreq_governor()
> runs concurrently via separate threads.
> 
> In order to guarantee valid state transitions for governors,
> 'governor_enabled' was required to be protected using some locking and
> we created cpufreq_governor_lock for that.
> 
> But now, __cpufreq_governor() is always called from within policy->rwsem
> held and so 'governor_enabled' is protected against races even without
> cpufreq_governor_lock.
> 
> Get rid of the extra lock now.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4fc3889ca7c9..7bc8a5ed97e5 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -102,7 +102,6 @@ static LIST_HEAD(cpufreq_governor_list);
>  static struct cpufreq_driver *cpufreq_driver;
>  static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
>  static DEFINE_RWLOCK(cpufreq_driver_lock);
> -DEFINE_MUTEX(cpufreq_governor_lock);
>  
>  /* Flag to suspend/resume CPUFreq governors */
>  static bool cpufreq_suspended;
> @@ -1963,11 +1962,9 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  
>  	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
>  
> -	mutex_lock(&cpufreq_governor_lock);
>  	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
>  	    || (!policy->governor_enabled
>  	    && (event == CPUFREQ_GOV_LIMITS || event == CPUFREQ_GOV_STOP))) {
> -		mutex_unlock(&cpufreq_governor_lock);
>  		return -EBUSY;
>  	}
>  
> @@ -1976,8 +1973,6 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  	else if (event == CPUFREQ_GOV_START)
>  		policy->governor_enabled = true;
>  
> -	mutex_unlock(&cpufreq_governor_lock);
> -
>  	ret = policy->governor->governor(policy, event);
>  
>  	if (!ret) {
> @@ -1987,12 +1982,10 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  			policy->governor->initialized--;
>  	} else {
>  		/* Restore original values */
> -		mutex_lock(&cpufreq_governor_lock);
>  		if (event == CPUFREQ_GOV_STOP)
>  			policy->governor_enabled = true;
>  		else if (event == CPUFREQ_GOV_START)
>  			policy->governor_enabled = false;
> -		mutex_unlock(&cpufreq_governor_lock);
>  	}
>  
>  	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||

+ minor cleanup:

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index ed328a39c4ac..7bed63e14e7d 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -214,7 +214,6 @@ static inline int delay_for_sampling_rate(unsigned int sampling_rate)
        return delay;
 }
 
-extern struct mutex cpufreq_governor_lock;
 extern const struct sysfs_ops governor_sysfs_ops;
 
 void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay);

-- 
viresh
