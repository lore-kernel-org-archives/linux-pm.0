From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: conservative: Decrease frequency faster when
 the update deferred
Date: Wed, 16 Nov 2016 09:25:44 +0530
Message-ID: <20161116035544.GF17245@vireshk-i7>
References: <faad4ff0-8115-059b-2ebc-2cec2a76fafe@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34877 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752445AbcKPDzr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 22:55:47 -0500
Received: by mail-pg0-f53.google.com with SMTP id p66so74164188pga.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2016 19:55:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <faad4ff0-8115-059b-2ebc-2cec2a76fafe@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 15-11-16, 23:25, Stratos Karafotis wrote:
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 0681fcf..808cc4d 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -66,6 +66,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  	struct dbs_data *dbs_data = policy_dbs->dbs_data;
>  	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  	unsigned int load = dbs_update(policy);
> +	unsigned int freq_step;
> 
>  	/*
>  	 * break out if we 'cannot' reduce the speed as the user might
> @@ -82,6 +83,22 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  	if (requested_freq > policy->max || requested_freq < policy->min)
>  		requested_freq = policy->cur;
> 
> +	freq_step = get_freq_step(cs_tuners, policy);
> +
> +	/*
> +	 * Decrease requested_freq one freq_step for each idle period that
> +	 * we didn't update the frequency.
> +	 */
> +	if (policy_dbs->idle_periods < UINT_MAX) {
> +		unsigned int freq_steps = policy_dbs->idle_periods * freq_step;
> +
> +		if (requested_freq > freq_steps)
> +			requested_freq -= freq_steps;
> +		else
> +			requested_freq = policy->min;

Need a blank line here.

> +		policy_dbs->idle_periods = UINT_MAX;
> +	}
> +
>  	/* Check for frequency increase */
>  	if (load > dbs_data->up_threshold) {
>  		dbs_info->down_skip = 0;
> @@ -90,7 +107,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  		if (requested_freq == policy->max)
>  			goto out;
> 
> -		requested_freq += get_freq_step(cs_tuners, policy);
> +		requested_freq += freq_step;
>  		if (requested_freq > policy->max)
>  			requested_freq = policy->max;
> 
> @@ -106,14 +123,12 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
> 
>  	/* Check for frequency decrease */
>  	if (load < cs_tuners->down_threshold) {
> -		unsigned int freq_step;
>  		/*
>  		 * if we cannot reduce the frequency anymore, break out early
>  		 */
>  		if (requested_freq == policy->min)
>  			goto out;
> 
> -		freq_step = get_freq_step(cs_tuners, policy);
>  		if (requested_freq > freq_step)
>  			requested_freq -= freq_step;
>  		else
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 3729474..9780f50 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -117,7 +117,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  	struct dbs_data *dbs_data = policy_dbs->dbs_data;
>  	unsigned int ignore_nice = dbs_data->ignore_nice_load;
> -	unsigned int max_load = 0;
> +	unsigned int max_load = 0, idle_periods = UINT_MAX;
>  	unsigned int sampling_rate, io_busy, j;
> 
>  	/*
> @@ -214,10 +214,17 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  			}
>  			j_cdbs->prev_load = load;
>  		}

Here as well..

> +		if (time_elapsed > 2 * sampling_rate) {
> +			unsigned int periods = time_elapsed / sampling_rate;
> 
> +			if (periods < idle_periods)
> +				idle_periods = periods;
> +		}

Here too

>  		if (load > max_load)
>  			max_load = load;
>  	}

And here..

> +	policy_dbs->idle_periods = idle_periods;
> +
>  	return max_load;
>  }
>  EXPORT_SYMBOL_GPL(dbs_update);
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 9660cc6..10a3e0a 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -97,6 +97,7 @@ struct policy_dbs_info {
>  	struct list_head list;
>  	/* Multiplier for increasing sample delay temporarily. */
>  	unsigned int rate_mult;
> +	unsigned int idle_periods;
>  	/* Status indicators */
>  	bool is_shared;		/* This object is used by multiple CPUs */
>  	bool work_in_progress;	/* Work is being queued up or in progress */

And after fixing this trivial things, you can add

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
