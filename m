From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: governor: Don't use 'timer' keyword
Date: Mon, 14 Nov 2016 01:38:52 +0100
Message-ID: <4899721.6hMvosYmot@vostro.rjw.lan>
References: <915305fe119087769d62a95b8f22a95f9546b4f1.1478583385.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:45191 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750873AbcKNAbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Nov 2016 19:31:20 -0500
In-Reply-To: <915305fe119087769d62a95b8f22a95f9546b4f1.1478583385.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, November 08, 2016 11:06:33 AM Viresh Kumar wrote:
> The earlier implementation of governors used background timers and so
> functions, mutex, etc had 'timer' keyword in their names.
> 
> But that's not true anymore. Replace 'timer' with 'update', as those
> functions, variables are based around updates to frequency.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |  4 ++--
>  drivers/cpufreq/cpufreq_governor.c     | 18 +++++++++---------
>  drivers/cpufreq/cpufreq_governor.h     |  4 ++--
>  drivers/cpufreq/cpufreq_ondemand.c     | 15 +++++++--------
>  4 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 13475890d792..fa5ece3915a1 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -58,7 +58,7 @@ static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
>   * Any frequency increase takes it to the maximum frequency. Frequency reduction
>   * happens at minimum steps of 5% (default) of maximum frequency
>   */
> -static unsigned int cs_dbs_timer(struct cpufreq_policy *policy)
> +static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>  {
>  	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  	struct cs_policy_dbs_info *dbs_info = to_dbs_info(policy_dbs);
> @@ -305,7 +305,7 @@ static void cs_start(struct cpufreq_policy *policy)
>  static struct dbs_governor cs_governor = {
>  	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
>  	.kobj_type = { .default_attrs = cs_attributes },
> -	.gov_dbs_timer = cs_dbs_timer,
> +	.gov_dbs_update = cs_dbs_update,
>  	.alloc = cs_alloc,
>  	.free = cs_free,
>  	.init = cs_init,
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 642dd0f183a8..372947416b75 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -61,7 +61,7 @@ ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
>  	 * entries can't be freed concurrently.
>  	 */
>  	list_for_each_entry(policy_dbs, &attr_set->policy_list, list) {
> -		mutex_lock(&policy_dbs->timer_mutex);
> +		mutex_lock(&policy_dbs->update_mutex);
>  		/*
>  		 * On 32-bit architectures this may race with the
>  		 * sample_delay_ns read in dbs_update_util_handler(), but that
> @@ -76,7 +76,7 @@ ssize_t store_sampling_rate(struct gov_attr_set *attr_set, const char *buf,
>  		 * taken, so it shouldn't be significant.
>  		 */
>  		gov_update_sample_delay(policy_dbs, 0);
> -		mutex_unlock(&policy_dbs->timer_mutex);
> +		mutex_unlock(&policy_dbs->update_mutex);
>  	}
>  
>  	return count;
> @@ -236,9 +236,9 @@ static void dbs_work_handler(struct work_struct *work)
>  	 * Make sure cpufreq_governor_limits() isn't evaluating load or the
>  	 * ondemand governor isn't updating the sampling rate in parallel.
>  	 */
> -	mutex_lock(&policy_dbs->timer_mutex);
> -	gov_update_sample_delay(policy_dbs, gov->gov_dbs_timer(policy));
> -	mutex_unlock(&policy_dbs->timer_mutex);
> +	mutex_lock(&policy_dbs->update_mutex);
> +	gov_update_sample_delay(policy_dbs, gov->gov_dbs_update(policy));
> +	mutex_unlock(&policy_dbs->update_mutex);
>  
>  	/* Allow the utilization update handler to queue up more work. */
>  	atomic_set(&policy_dbs->work_count, 0);
> @@ -348,7 +348,7 @@ static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *poli
>  		return NULL;
>  
>  	policy_dbs->policy = policy;
> -	mutex_init(&policy_dbs->timer_mutex);
> +	mutex_init(&policy_dbs->update_mutex);
>  	atomic_set(&policy_dbs->work_count, 0);
>  	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
>  	INIT_WORK(&policy_dbs->work, dbs_work_handler);
> @@ -367,7 +367,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
>  {
>  	int j;
>  
> -	mutex_destroy(&policy_dbs->timer_mutex);
> +	mutex_destroy(&policy_dbs->update_mutex);
>  
>  	for_each_cpu(j, policy_dbs->policy->related_cpus) {
>  		struct cpu_dbs_info *j_cdbs = &per_cpu(cpu_dbs, j);
> @@ -547,10 +547,10 @@ void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>  {
>  	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  
> -	mutex_lock(&policy_dbs->timer_mutex);
> +	mutex_lock(&policy_dbs->update_mutex);
>  	cpufreq_policy_apply_limits(policy);
>  	gov_update_sample_delay(policy_dbs, 0);
>  
> -	mutex_unlock(&policy_dbs->timer_mutex);
> +	mutex_unlock(&policy_dbs->update_mutex);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index ef1037e9c92b..9660cc6b4b39 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -85,7 +85,7 @@ struct policy_dbs_info {
>  	 * Per policy mutex that serializes load evaluation from limit-change
>  	 * and work-handler.
>  	 */
> -	struct mutex timer_mutex;
> +	struct mutex update_mutex;
>  
>  	u64 last_sample_time;
>  	s64 sample_delay_ns;
> @@ -135,7 +135,7 @@ struct dbs_governor {
>  	 */
>  	struct dbs_data *gdbs_data;
>  
> -	unsigned int (*gov_dbs_timer)(struct cpufreq_policy *policy);
> +	unsigned int (*gov_dbs_update)(struct cpufreq_policy *policy);
>  	struct policy_dbs_info *(*alloc)(void);
>  	void (*free)(struct policy_dbs_info *policy_dbs);
>  	int (*init)(struct dbs_data *dbs_data);
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 3a1f49f5f4c6..1e2bd9851fba 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -169,7 +169,7 @@ static void od_update(struct cpufreq_policy *policy)
>  	}
>  }
>  
> -static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
> +static unsigned int od_dbs_update(struct cpufreq_policy *policy)
>  {
>  	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  	struct dbs_data *dbs_data = policy_dbs->dbs_data;
> @@ -191,7 +191,7 @@ static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
>  	od_update(policy);
>  
>  	if (dbs_info->freq_lo) {
> -		/* Setup timer for SUB_SAMPLE */
> +		/* Setup SUB_SAMPLE */
>  		dbs_info->sample_type = OD_SUB_SAMPLE;
>  		return dbs_info->freq_hi_delay_us;
>  	}
> @@ -255,11 +255,11 @@ static ssize_t store_sampling_down_factor(struct gov_attr_set *attr_set,
>  	list_for_each_entry(policy_dbs, &attr_set->policy_list, list) {
>  		/*
>  		 * Doing this without locking might lead to using different
> -		 * rate_mult values in od_update() and od_dbs_timer().
> +		 * rate_mult values in od_update() and od_dbs_update().
>  		 */
> -		mutex_lock(&policy_dbs->timer_mutex);
> +		mutex_lock(&policy_dbs->update_mutex);
>  		policy_dbs->rate_mult = 1;
> -		mutex_unlock(&policy_dbs->timer_mutex);
> +		mutex_unlock(&policy_dbs->update_mutex);
>  	}
>  
>  	return count;
> @@ -374,8 +374,7 @@ static int od_init(struct dbs_data *dbs_data)
>  		dbs_data->up_threshold = MICRO_FREQUENCY_UP_THRESHOLD;
>  		/*
>  		 * In nohz/micro accounting case we set the minimum frequency
> -		 * not depending on HZ, but fixed (very low). The deferred
> -		 * timer might skip some samples if idle/sleeping as needed.
> +		 * not depending on HZ, but fixed (very low).
>  		*/
>  		dbs_data->min_sampling_rate = MICRO_FREQUENCY_MIN_SAMPLE_RATE;
>  	} else {
> @@ -415,7 +414,7 @@ static struct od_ops od_ops = {
>  static struct dbs_governor od_dbs_gov = {
>  	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
>  	.kobj_type = { .default_attrs = od_attributes },
> -	.gov_dbs_timer = od_dbs_timer,
> +	.gov_dbs_update = od_dbs_update,
>  	.alloc = od_alloc,
>  	.free = od_free,
>  	.init = od_init,
> 

Applied.

Thanks,
Rafael

