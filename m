From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Resend][PATCH] cpufreq: conservative: Decrease frequency faster
 when the timer deferred
Date: Mon, 7 Nov 2016 11:42:34 +0530
Message-ID: <20161107061234.GD21030@vireshk-i7>
References: <973ac1ee-ff65-9190-762d-13deefdccba2@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35059 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcKGGMj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2016 01:12:39 -0500
Received: by mail-pf0-f181.google.com with SMTP id i88so85642438pfk.2
        for <linux-pm@vger.kernel.org>; Sun, 06 Nov 2016 22:12:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <973ac1ee-ff65-9190-762d-13deefdccba2@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

For the record, I have never got the original mail with this subject.

On 06-11-16, 11:19, Stratos Karafotis wrote:
> Conservative governor changes the CPU frequency in steps.
> That means that if a CPU runs at max frequency, it will need several
> sampling periods to return at min frequency when the workload
> is finished.
> 
> If the timer that calculates the load and target frequency is deferred,
> the governor might need even more time to decrease the frequency.
> 
> This may have impact to power consumption and after all conservative
> should decrease the frequency if there is no workload every sampling
> rate.
> 
> To resolve the above issue calculate the number of sampling periods
> that the timer deferred. Considering that for each sampling period
> conservative should drop the frequency by a freq_step because the
> CPU was idle apply the proper subtraction to requested frequency.
> 
> Below, the kernel trace with and without this patch. First an
> intensive workload is applied on a specific CPU. Then the workload
> is removed and the CPU goes to idle.
> 
> WITHOUT
> -------
>      <idle>-0     [007] dN..   620.329153: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   620.350857: cpu_frequency: state=1700000 cpu_id=7
> kworker/7:2-556   [007] ....   620.370856: cpu_frequency: state=1900000 cpu_id=7
> kworker/7:2-556   [007] ....   620.390854: cpu_frequency: state=2100000 cpu_id=7
> kworker/7:2-556   [007] ....   620.411853: cpu_frequency: state=2200000 cpu_id=7
> kworker/7:2-556   [007] ....   620.432854: cpu_frequency: state=2400000 cpu_id=7
> kworker/7:2-556   [007] ....   620.453854: cpu_frequency: state=2600000 cpu_id=7
> kworker/7:2-556   [007] ....   620.494856: cpu_frequency: state=2900000 cpu_id=7
> kworker/7:2-556   [007] ....   620.515856: cpu_frequency: state=3100000 cpu_id=7
> kworker/7:2-556   [007] ....   620.536858: cpu_frequency: state=3300000 cpu_id=7
> kworker/7:2-556   [007] ....   620.557857: cpu_frequency: state=3401000 cpu_id=7
>      <idle>-0     [007] d...   669.591363: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   669.591939: cpu_idle: state=4294967295 cpu_id=7
>      <idle>-0     [007] d...   669.591980: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] dN..   669.591989: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   670.201224: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   670.221975: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   670.222016: cpu_frequency: state=3300000 cpu_id=7
>      <idle>-0     [007] d...   670.222026: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   670.234964: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   670.801251: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.236046: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   671.236073: cpu_frequency: state=3100000 cpu_id=7
>      <idle>-0     [007] d...   671.236112: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.393437: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   671.401277: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.404083: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   671.404111: cpu_frequency: state=2900000 cpu_id=7
>      <idle>-0     [007] d...   671.404125: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.404974: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   671.501180: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.995414: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   671.995459: cpu_frequency: state=2800000 cpu_id=7
>      <idle>-0     [007] d...   671.995469: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   671.996287: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.001305: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.078374: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.078410: cpu_frequency: state=2600000 cpu_id=7
>      <idle>-0     [007] d...   672.078419: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.158020: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.158040: cpu_frequency: state=2400000 cpu_id=7
>      <idle>-0     [007] d...   672.158044: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.160038: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.234557: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.237121: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.237174: cpu_frequency: state=2100000 cpu_id=7
>      <idle>-0     [007] d...   672.237186: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.237778: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.267902: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.269860: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.269906: cpu_frequency: state=1900000 cpu_id=7
>      <idle>-0     [007] d...   672.269914: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.271902: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...   672.751342: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...   672.823056: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-556   [007] ....   672.823095: cpu_frequency: state=1600000 cpu_id=7
> 
> WITH
> ----
>      <idle>-0     [007] dN..  4380.928009: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4380.949767: cpu_frequency: state=2000000 cpu_id=7
> kworker/7:2-399   [007] ....  4380.969765: cpu_frequency: state=2200000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.009766: cpu_frequency: state=2500000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.029767: cpu_frequency: state=2600000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.049769: cpu_frequency: state=2800000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.069769: cpu_frequency: state=3000000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.089771: cpu_frequency: state=3100000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.109772: cpu_frequency: state=3400000 cpu_id=7
> kworker/7:2-399   [007] ....  4381.129773: cpu_frequency: state=3401000 cpu_id=7
>      <idle>-0     [007] d...  4428.226159: cpu_idle: state=1 cpu_id=7
>      <idle>-0     [007] d...  4428.226176: cpu_idle: state=4294967295 cpu_id=7
>      <idle>-0     [007] d...  4428.226181: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.227177: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...  4428.551640: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.649239: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4428.649268: cpu_frequency: state=2800000 cpu_id=7
>      <idle>-0     [007] d...  4428.649278: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.689856: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...  4428.799542: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.801683: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4428.801748: cpu_frequency: state=1700000 cpu_id=7
>      <idle>-0     [007] d...  4428.801761: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4428.806545: cpu_idle: state=4294967295 cpu_id=7
> ...
>      <idle>-0     [007] d...  4429.051880: cpu_idle: state=4 cpu_id=7
>      <idle>-0     [007] d...  4429.086240: cpu_idle: state=4294967295 cpu_id=7
> kworker/7:2-399   [007] ....  4429.086293: cpu_frequency: state=1600000 cpu_id=7
> 
> Without the patch the CPU dropped to min frequency after 3.2s
> With the patch applied the CPU dropped to min frequency after 0.86s
> 
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |  9 +++++++++
>  drivers/cpufreq/cpufreq_governor.c     | 18 +++++++++++++-----
>  drivers/cpufreq/cpufreq_governor.h     |  1 +
>  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 1347589..07dac72 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -74,6 +74,15 @@ static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
>  	if (cs_tuners->freq_step == 0)
>  		goto out;
> 
> +	if (policy_dbs->deferred_periods < UINT_MAX) {

Perhaps this all should be done only if we are going to decrease the frequency,
i.e. somewhere down than what you are proposing.

> +		unsigned int freq_target = policy_dbs->deferred_periods *
> +				get_freq_target(cs_tuners, policy);
> +		if (requested_freq > freq_target)
> +			requested_freq -= freq_target;
> +		else
> +			requested_freq = policy->min;
> +		policy_dbs->deferred_periods = UINT_MAX;
> +	}
>  	/*
>  	 * If requested_freq is out of range, it is likely that the limits
>  	 * changed in the meantime, so fall back to current frequency in that
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 642dd0f..0d498a0 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -117,7 +117,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  	struct dbs_data *dbs_data = policy_dbs->dbs_data;
>  	unsigned int ignore_nice = dbs_data->ignore_nice_load;
> -	unsigned int max_load = 0;
> +	unsigned int max_load = 0, deferred_periods = UINT_MAX;
>  	unsigned int sampling_rate, io_busy, j;
> 
>  	/*
> @@ -163,8 +163,13 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  			 * calls, so the previous load value can be used then.
>  			 */
>  			load = j_cdbs->prev_load;
> -		} else if (unlikely(time_elapsed > 2 * sampling_rate &&
> -				    j_cdbs->prev_load)) {
> +		} else if (unlikely(time_elapsed > 2 * sampling_rate)) {
> +			unsigned int periods = time_elapsed / sampling_rate;
> +
> +			if (periods < deferred_periods)
> +				deferred_periods = periods;
> +
> +			if (j_cdbs->prev_load) {
>  			/*

You forgot to shift the below comment by a tab. Maybe just position the above
'if' statement after the comment.

>  			 * If the CPU had gone completely idle and a task has
>  			 * just woken up on this CPU now, it would be unfair to
> @@ -189,8 +194,9 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  			 * 'time_elapsed' (as compared to the sampling rate)
>  			 * indicates this scenario.
>  			 */
> -			load = j_cdbs->prev_load;
> -			j_cdbs->prev_load = 0;
> +				load = j_cdbs->prev_load;
> +				j_cdbs->prev_load = 0;
> +			}
>  		} else {
>  			if (time_elapsed >= idle_time) {
>  				load = 100 * (time_elapsed - idle_time) / time_elapsed;
> @@ -218,6 +224,8 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
>  		if (load > max_load)
>  			max_load = load;
>  	}
> +	policy_dbs->deferred_periods = deferred_periods;
> +
>  	return max_load;
>  }
>  EXPORT_SYMBOL_GPL(dbs_update);
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index ef1037e..48efeb5 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -97,6 +97,7 @@ struct policy_dbs_info {
>  	struct list_head list;
>  	/* Multiplier for increasing sample delay temporarily. */
>  	unsigned int rate_mult;
> +	unsigned int deferred_periods;
>  	/* Status indicators */
>  	bool is_shared;		/* This object is used by multiple CPUs */
>  	bool work_in_progress;	/* Work is being queued up or in progress */
> -- 
> 2.7.4

-- 
viresh
