From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 4/5] cpufreq: governor: Quit work-handlers early if governor is stopped
Date: Wed, 28 Oct 2015 08:10:40 +0100
Message-ID: <11662041.x9fsKCWszL@vostro.rjw.lan>
References: <cover.1444723240.git.viresh.kumar@linaro.org> <1e579d2bf8dbee09295725cda37bd92222fe61fb.1444723240.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1e579d2bf8dbee09295725cda37bd92222fe61fb.1444723240.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, October 13, 2015 01:39:04 PM Viresh Kumar wrote:
> cpufreq_governor_lock is abused by using it outside of cpufreq core,
> i.e. in cpufreq-governors. But we didn't had a better solution to the
> problem (described later) at that point of time, and following was the
> only acceptable solution:
> 
> 6f1e4efd882e ("cpufreq: Fix timer/workqueue corruption by protecting
> reading governor_enabled")
> 
> The cpufreq governor core is fixed against possible races now and things
> are in much better shape.
> 
> The original problem:
> 
> When a CPU is hot unplugged, we cancel delayed works for all
> policy->cpus via gov_cancel_work(). If the work is already running on
> any CPU, the workqueue code will wait for the work to finish, to prevent
> the work items from re-queuing themselves.
> 
> This works most of the time, except for the case where the work handler
> determines that it should adjust the delay for all other CPUs, that the
> policy is managing. When this happens, the canceling CPU will cancel its
> own work but can queue up the works on other policy->cpus.
> 
> For example, consider CPU 0-4 in a policy and we called
> gov_cancel_work() for them. Workqueue core canceled the works for 0-3
> and is waiting for the handler to finish on CPU4. At that time, handler
> on CPU4 can restart works on CPU 0-3 again. Which makes 0-3 run works,
> which the governor core thinks are canceled.
> 
> To fix that in a different (non-hacky) way, set set shared->policy to
> false before trying to cancel the work. It should be updated within
> timer_mutex, which will prevent the work-handlers to start. Once the
> work-handlers finds that we are already trying to stop the governor, it
> will exit early. And that will prevent queuing of works again as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I have a hard time figuring out what the patch is supposed to achieve from
the above.

Do we eventually want to get rid of cpufreq_governor_lock and that's why we're
doing this?

> ---
>  drivers/cpufreq/cpufreq_governor.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 750626d8fb03..931424ca96d9 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -171,10 +171,6 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  {
>  	int i;
>  
> -	mutex_lock(&cpufreq_governor_lock);
> -	if (!policy->governor_enabled)
> -		goto out_unlock;
> -
>  	if (!all_cpus) {
>  		/*
>  		 * Use raw_smp_processor_id() to avoid preemptible warnings.
> @@ -188,9 +184,6 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  		for_each_cpu(i, policy->cpus)
>  			__gov_queue_work(i, dbs_data, delay);
>  	}
> -
> -out_unlock:
> -	mutex_unlock(&cpufreq_governor_lock);
>  }
>  EXPORT_SYMBOL_GPL(gov_queue_work);
>  
> @@ -229,13 +222,24 @@ static void dbs_timer(struct work_struct *work)
>  	struct cpu_dbs_info *cdbs = container_of(work, struct cpu_dbs_info,
>  						 dwork.work);
>  	struct cpu_common_dbs_info *shared = cdbs->shared;
> -	struct cpufreq_policy *policy = shared->policy;
> -	struct dbs_data *dbs_data = policy->governor_data;
> +	struct cpufreq_policy *policy;
> +	struct dbs_data *dbs_data;
>  	unsigned int sampling_rate, delay;
>  	bool modify_all = true;
>  
>  	mutex_lock(&shared->timer_mutex);
>  
> +	policy = shared->policy;
> +
> +	/*
> +	 * Governor might already be disabled and there is no point continuing
> +	 * with the work-handler.
> +	 */
> +	if (!policy)
> +		goto unlock;
> +
> +	dbs_data = policy->governor_data;
> +
>  	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
>  		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
>  
> @@ -252,6 +256,7 @@ static void dbs_timer(struct work_struct *work)
>  	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
>  	gov_queue_work(dbs_data, policy, delay, modify_all);
>  
> +unlock:
>  	mutex_unlock(&shared->timer_mutex);
>  }
>  
> @@ -488,9 +493,17 @@ static int cpufreq_governor_stop(struct cpufreq_policy *policy,
>  	if (!shared || !shared->policy)
>  		return -EBUSY;
>  
> +	/*
> +	 * Work-handler must see this updated, as it should not proceed any
> +	 * further after governor is disabled. And so timer_mutex is taken while
> +	 * updating this value.
> +	 */
> +	mutex_lock(&shared->timer_mutex);
> +	shared->policy = NULL;
> +	mutex_unlock(&shared->timer_mutex);

So this assumes that dbs_timer() will acquire the mutex and see that
shared->policy is now NULL, so it will bail out immediately, but ->

> +
>  	gov_cancel_work(dbs_data, policy);
>  
> -	shared->policy = NULL;
>  	mutex_destroy(&shared->timer_mutex);

-> the mutex is destroyed here, so what the guarantee that the mutex will
still be around when dbs_timer() runs?

>  	return 0;
>  }
> 

Thanks,
Rafael
