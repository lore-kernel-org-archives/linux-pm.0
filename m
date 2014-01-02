From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] cpufreq: Fix timer/workqueue corruption by protecting
 reading governor_enabled
Date: Thu, 2 Jan 2014 15:26:38 -0800
Message-ID: <20140102232638.GA21548@core.coreip.homeip.net>
References: <1388632482-16921-1-git-send-email-jiel@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388632482-16921-1-git-send-email-jiel@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiel@marvell.com
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jane:

On Thu, Jan 02, 2014 at 11:14:42AM +0800, jiel@marvell.com wrote:
> @@ -119,8 +121,11 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  {
>  	int i;
>  
> -	if (!policy->governor_enabled)
> +	mutex_lock(&cpufreq_governor_lock);
> +	if (!policy->governor_enabled) {
> +		mutex_unlock(&cpufreq_governor_lock);
>  		return;
> +	}
>  
>  	if (!all_cpus) {
>  		/*
> @@ -135,6 +140,7 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  		for_each_cpu(i, policy->cpus)
>  			__gov_queue_work(i, dbs_data, delay);
>  	}
> +	mutex_unlock(&cpufreq_governor_lock);

Unlocking in different branches is not the best practice IMO, I'd
recommend doing:

	mutex_lock(&cpufreq_governor_lock);

	if (!policy->governor_enabled)
		goto out_unlock;

	...

out_unlock:
	mutex_unlock(&cpufreq_governor_lock);

Thanks!

-- 
Dmitry
