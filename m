From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH 3/3] cpufreq: governor: Replace timers with
 utilization update callbacks
Date: Thu, 4 Feb 2016 10:19:59 +0530
Message-ID: <20160204044959.GS3469@vireshk>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <4043287.vvCjrxyEmh@vostro.rjw.lan>
 <2546395.Be1INkvQBN@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2546395.Be1INkvQBN@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On 03-02-16, 02:16, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> -void gov_add_timers(struct cpufreq_policy *policy, unsigned int delay)
> +void gov_set_update_util(struct cpu_common_dbs_info *shared,
> +			 unsigned int delay_us)
>  {
> +	struct cpufreq_policy *policy = shared->policy;
>  	struct dbs_data *dbs_data = policy->governor_data;
> -	struct cpu_dbs_info *cdbs;
>  	int cpu;
>  
> +	shared->sample_delay_ns = delay_us * NSEC_PER_USEC;
> +	shared->time_stamp = ktime_get();
> +
>  	for_each_cpu(cpu, policy->cpus) {
> -		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> -		cdbs->timer.expires = jiffies + delay;
> -		add_timer_on(&cdbs->timer, cpu);
> +		struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> +
> +		cdbs->last_sample_time = 0;
> +		cpufreq_set_update_util_data(cpu, &cdbs->update_util);

Why no synchronize_rcu() here? This can be called from ondemand
governor on sampling-rate updates ..

>  	}
>  }
> -EXPORT_SYMBOL_GPL(gov_add_timers);
> +EXPORT_SYMBOL_GPL(gov_set_update_util);
>  
> -static inline void gov_cancel_timers(struct cpufreq_policy *policy)
> +static inline void gov_clear_update_util(struct cpufreq_policy *policy)
>  {
> -	struct dbs_data *dbs_data = policy->governor_data;
> -	struct cpu_dbs_info *cdbs;
>  	int i;
>  
> -	for_each_cpu(i, policy->cpus) {
> -		cdbs = dbs_data->cdata->get_cpu_cdbs(i);
> -		del_timer_sync(&cdbs->timer);
> -	}
> +	for_each_cpu(i, policy->cpus)
> +		cpufreq_set_update_util_data(i, NULL);
> +
> +	synchronize_rcu();
>  }
>  
>  void gov_cancel_work(struct cpu_common_dbs_info *shared)
>  {
> -	/* Tell dbs_timer_handler() to skip queuing up work items. */
> +	/* Tell dbs_update_util_handler() to skip queuing up work items. */
>  	atomic_inc(&shared->skip_work);
>  	/*
> -	 * If dbs_timer_handler() is already running, it may not notice the
> -	 * incremented skip_work, so wait for it to complete to prevent its work
> -	 * item from being queued up after the cancel_work_sync() below.
> -	 */
> -	gov_cancel_timers(shared->policy);
> -	/*
> -	 * In case dbs_timer_handler() managed to run and spawn a work item
> -	 * before the timers have been canceled, wait for that work item to
> -	 * complete and then cancel all of the timers set up by it.  If
> -	 * dbs_timer_handler() runs again at that point, it will see the
> -	 * positive value of skip_work and won't spawn any more work items.
> +	 * If dbs_update_util_handler() is already running, it may not notice
> +	 * the incremented skip_work, so wait for it to complete to prevent its
> +	 * work item from being queued up after the cancel_work_sync() below.
>  	 */
> +	gov_clear_update_util(shared->policy);
>  	cancel_work_sync(&shared->work);

How are we sure that the irq-work can't be pending at this point of
time, which will queue the above works again ?

> -	gov_cancel_timers(shared->policy);
>  	atomic_set(&shared->skip_work, 0);
>  }
>  EXPORT_SYMBOL_GPL(gov_cancel_work);
>  
> -/* Will return if we need to evaluate cpu load again or not */
> -static bool need_load_eval(struct cpu_common_dbs_info *shared,
> -			   unsigned int sampling_rate)
> -{
> -	if (policy_is_shared(shared->policy)) {
> -		ktime_t time_now = ktime_get();
> -		s64 delta_us = ktime_us_delta(time_now, shared->time_stamp);
> -
> -		/* Do nothing if we recently have sampled */
> -		if (delta_us < (s64)(sampling_rate / 2))
> -			return false;
> -		else
> -			shared->time_stamp = time_now;
> -	}
> -
> -	return true;
> -}
> -
>  static void dbs_work_handler(struct work_struct *work)
>  {
>  	struct cpu_common_dbs_info *shared = container_of(work, struct
> @@ -235,14 +212,10 @@ static void dbs_work_handler(struct work
>  	struct cpufreq_policy *policy;
>  	struct dbs_data *dbs_data;
>  	unsigned int sampling_rate, delay;
> -	bool eval_load;
>  
>  	policy = shared->policy;
>  	dbs_data = policy->governor_data;
>  
> -	/* Kill all timers */
> -	gov_cancel_timers(policy);
> -
>  	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
>  		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  
> @@ -253,37 +226,53 @@ static void dbs_work_handler(struct work
>  		sampling_rate = od_tuners->sampling_rate;
>  	}
>  
> -	eval_load = need_load_eval(shared, sampling_rate);
> -
>  	/*
> -	 * Make sure cpufreq_governor_limits() isn't evaluating load in
> +	 * Make sure cpufreq_governor_limits() isn't evaluating load or the
> +	 * ondemand governor isn't reading the time stamp and sampling rate in
>  	 * parallel.
>  	 */
>  	mutex_lock(&shared->timer_mutex);
> -	delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
> +	delay = dbs_data->cdata->gov_dbs_timer(policy);
> +	shared->sample_delay_ns = jiffies_to_nsecs(delay);
> +	shared->time_stamp = ktime_get();
>  	mutex_unlock(&shared->timer_mutex);
>  
> +	smp_mb__before_atomic();

And why is this required exactly ? Maybe a comment as well to clarify
this as this isn't obvious ?

>  	atomic_dec(&shared->skip_work);
> +}
>  
> -	gov_add_timers(policy, delay);
> +static void dbs_irq_work(struct irq_work *irq_work)
> +{
> +	struct cpu_common_dbs_info *shared;
> +
> +	shared = container_of(irq_work, struct cpu_common_dbs_info, irq_work);
> +	schedule_work(&shared->work);
>  }
>  
> -static void dbs_timer_handler(unsigned long data)
> +static void dbs_update_util_handler(struct update_util_data *data, u64 time,
> +				    unsigned long util, unsigned long max)
>  {
> -	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
> +	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
>  	struct cpu_common_dbs_info *shared = cdbs->shared;
>  
>  	/*
> -	 * Timer handler may not be allowed to queue the work at the moment,
> -	 * because:
> -	 * - Another timer handler has done that
> -	 * - We are stopping the governor
> -	 * - Or we are updating the sampling rate of the ondemand governor
> +	 * The work may not be allowed to be queued up right now.
> +	 * Possible reasons:
> +	 * - Work has already been queued up or is in progress.
> +	 * - The governor is being stopped.
> +	 * - It is too early (too little time from the previous sample).
>  	 */
> -	if (atomic_inc_return(&shared->skip_work) > 1)
> -		atomic_dec(&shared->skip_work);
> -	else
> -		queue_work(system_wq, &shared->work);
> +	if (atomic_inc_return(&shared->skip_work) == 1) {
> +		u64 delta_ns;
> +
> +		delta_ns = time - cdbs->last_sample_time;
> +		if ((s64)delta_ns >= shared->sample_delay_ns) {
> +			cdbs->last_sample_time = time;
> +			irq_work_queue_on(&shared->irq_work, smp_processor_id());
> +			return;
> +		}
> +	}
> +	atomic_dec(&shared->skip_work);
>  }
>  
>  static void set_sampling_rate(struct dbs_data *dbs_data,
> @@ -467,9 +456,6 @@ static int cpufreq_governor_start(struct
>  		io_busy = od_tuners->io_is_busy;
>  	}
>  
> -	shared->policy = policy;
> -	shared->time_stamp = ktime_get();
> -
>  	for_each_cpu(j, policy->cpus) {
>  		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
>  		unsigned int prev_load;
> @@ -485,10 +471,10 @@ static int cpufreq_governor_start(struct
>  		if (ignore_nice)
>  			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
>  
> -		__setup_timer(&j_cdbs->timer, dbs_timer_handler,
> -			      (unsigned long)j_cdbs,
> -			      TIMER_DEFERRABLE | TIMER_IRQSAFE);
> +		j_cdbs->update_util.func = dbs_update_util_handler;
>  	}
> +	shared->policy = policy;
> +	init_irq_work(&shared->irq_work, dbs_irq_work);
>  
>  	if (cdata->governor == GOV_CONSERVATIVE) {
>  		struct cs_cpu_dbs_info_s *cs_dbs_info =
> @@ -505,7 +491,7 @@ static int cpufreq_governor_start(struct
>  		od_ops->powersave_bias_init_cpu(cpu);
>  	}
>  
> -	gov_add_timers(policy, delay_for_sampling_rate(sampling_rate));
> +	gov_set_update_util(shared, sampling_rate);
>  	return 0;
>  }
>  
> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
> +++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> @@ -191,7 +191,7 @@ static void od_check_cpu(int cpu, unsign
>  	}
>  }
>  
> -static unsigned int od_dbs_timer(struct cpufreq_policy *policy, bool modify_all)
> +static unsigned int od_dbs_timer(struct cpufreq_policy *policy)
>  {
>  	struct dbs_data *dbs_data = policy->governor_data;
>  	unsigned int cpu = policy->cpu;
> @@ -200,9 +200,6 @@ static unsigned int od_dbs_timer(struct
>  	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
>  	int delay = 0, sample_type = dbs_info->sample_type;

Perhaps, the delay = 0 can be dropped now and ...

>  
> -	if (!modify_all)
> -		goto max_delay;
> -
>  	/* Common NORMAL_SAMPLE setup */
>  	dbs_info->sample_type = OD_NORMAL_SAMPLE;
>  	if (sample_type == OD_SUB_SAMPLE) {
> @@ -218,7 +215,6 @@ static unsigned int od_dbs_timer(struct
>  		}
>  	}
>  
> -max_delay:
>  	if (!delay)
>  		delay = delay_for_sampling_rate(od_tuners->sampling_rate
>  				* dbs_info->rate_mult);

^^ can be moved to the else part of above block ..

> @@ -264,7 +260,7 @@ static void update_sampling_rate(struct
>  		struct od_cpu_dbs_info_s *dbs_info;
>  		struct cpu_dbs_info *cdbs;
>  		struct cpu_common_dbs_info *shared;
> -		unsigned long next_sampling, appointed_at;
> +		ktime_t next_sampling, appointed_at;
>  
>  		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
>  		cdbs = &dbs_info->cdbs;
> @@ -292,16 +288,19 @@ static void update_sampling_rate(struct
>  			continue;
>  
>  		/*
> -		 * Checking this for any CPU should be fine, timers for all of
> -		 * them are scheduled together.
> +		 * Checking this for any CPU sharing the policy should be fine,
> +		 * they are all scheduled to sample at the same time.
>  		 */
> -		next_sampling = jiffies + usecs_to_jiffies(new_rate);
> -		appointed_at = dbs_info->cdbs.timer.expires;
> +		next_sampling = ktime_add_us(ktime_get(), new_rate);
>  
> -		if (time_before(next_sampling, appointed_at)) {
> -			gov_cancel_work(shared);
> -			gov_add_timers(policy, usecs_to_jiffies(new_rate));
> +		mutex_lock(&shared->timer_mutex);

Why is taking this lock important here ?

> +		appointed_at = ktime_add_ns(shared->time_stamp,

Also I failed to understand why we need time_stamp variable at all?
Why can't we use last_sample_time ?

> +					    shared->sample_delay_ns);
> +		mutex_unlock(&shared->timer_mutex);
>  
> +		if (ktime_before(next_sampling, appointed_at)) {
> +			gov_cancel_work(shared);
> +			gov_set_update_util(shared, new_rate);

You don't need to a complete update here, the pointers are all fine.

>  		}
>  	}

-- 
viresh
