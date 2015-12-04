From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Fri, 04 Dec 2015 02:18:41 +0100
Message-ID: <10439879.00aCyM9quW@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <691a3524afaa8d08d61987b1c2913948b4e59f01.1449115453.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <691a3524afaa8d08d61987b1c2913948b4e59f01.1449115453.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 03, 2015 09:37:53 AM Viresh Kumar wrote:
> cpufreq governors evaluate load at sampling rate and based on that they
> update frequency for a group of CPUs belonging to the same cpufreq
> policy.
> 
> This is required to be done in a single thread for all policy->cpus, but
> because we don't want to wakeup idle CPUs to do just that, we use
> deferrable work for this. If we would have used a single delayed
> deferrable work for the entire policy, there were chances that the CPU
> required to run the handler can be in idle and we might end up not
> changing the frequency for the entire group with load variations.
> 
> And so we were forced to keep per-cpu works, and only the one that
> expires first need to do the real work and others are rescheduled for
> next sampling time.
> 
> We have been using the more complex solution until now, where we used a
> delayed deferrable work for this, which is a combination of a timer and
> a work.
> 
> This could be made lightweight by keeping per-cpu deferred timers with a
> single work item, which is scheduled by the first timer that expires.
> 
> This patch does just that and here are important changes:
> - The timer handler will run in irq context and so we need to use a
>   spin_lock instead of the timer_mutex. And so a separate timer_lock is
>   created. This also makes the use of the mutex and lock quite clear, as
>   we know what exactly they are protecting.
> - A new field 'skip_work' is added to track when the timer handlers can
>   queue a work. More comments present in code.
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>

I've tentatively queued this one up, but I still have a couple of questions.

> ---
>  drivers/cpufreq/cpufreq_governor.c | 139 +++++++++++++++++++++----------------
>  drivers/cpufreq/cpufreq_governor.h |  20 ++++--
>  drivers/cpufreq/cpufreq_ondemand.c |   8 +--
>  3 files changed, 98 insertions(+), 69 deletions(-)

[cut]

> @@ -250,14 +247,44 @@ static void dbs_timer(struct work_struct *work)
>  		sampling_rate = od_tuners->sampling_rate;
>  	}
>  
> -	if (!need_load_eval(cdbs->shared, sampling_rate))
> -		modify_all = false;
> +	eval_load = need_load_eval(shared, sampling_rate);
>  
> -	delay = dbs_data->cdata->gov_dbs_timer(policy, modify_all);
> -	gov_queue_work(dbs_data, policy, delay, modify_all);
> +	/*
> +	 * Make sure cpufreq_governor_limits() isn't evaluating load in
> +	 * parallel.
> +	 */
> +	mutex_lock(&shared->timer_mutex);
> +	delay = dbs_data->cdata->gov_dbs_timer(policy, eval_load);
> +	mutex_unlock(&shared->timer_mutex);
> +
> +	shared->skip_work--;

Is there any reason for incrementing and decrementing this instead of setting
it to either 0 or 1 (or maybe either 'true' or 'false' for that matter)?

If my reading of the patch is correct, it can only be either 0 or 1 anyway, right?

> +	gov_add_timers(policy, delay);
> +}
> +
> +static void dbs_timer_handler(unsigned long data)
> +{
> +	struct cpu_dbs_info *cdbs = (struct cpu_dbs_info *)data;
> +	struct cpu_common_dbs_info *shared = cdbs->shared;
> +	struct cpufreq_policy *policy;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&shared->timer_lock, flags);
> +	policy = shared->policy;

Why do we need policy here?

> +
> +	/*
> +	 * Timer handler isn't allowed to queue work at the moment, because:
> +	 * - Another timer handler has done that
> +	 * - We are stopping the governor
> +	 * - Or we are updating the sampling rate of ondemand governor
> +	 */
> +	if (shared->skip_work)
> +		goto unlock;
> +
> +	shared->skip_work++;
> +	queue_work(system_wq, &shared->work);
>  
>  unlock:

What about writing the above as

	if (!shared->work_in_progress) {
		shared->work_in_progress = true;
		queue_work(system_wq, &shared->work);
	}

and then you won't need the unlock label.

> -	mutex_unlock(&shared->timer_mutex);
> +	spin_unlock_irqrestore(&shared->timer_lock, flags);
>  }
>  
>  static void set_sampling_rate(struct dbs_data *dbs_data,

Thanks,
Rafael
