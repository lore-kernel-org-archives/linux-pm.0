From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 6/9] cpufreq: ondemand: queue work for policy->cpus together
Date: Tue, 08 Sep 2015 03:33:45 +0200
Message-ID: <2662457.Ri7bTTTVA1@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <d2760eca0b3fd5e427d004120bdb82c1aed215ca.1437999691.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d2760eca0b3fd5e427d004120bdb82c1aed215ca.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, July 27, 2015 05:58:11 PM Viresh Kumar wrote:
> Currently update_sampling_rate() runs over each online CPU and
> cancels/queues work on it. Its very inefficient for the case where a
> single policy manages multiple CPUs, as they can be processed together.
> 
> Also drop the unnecessary cancel_delayed_work_sync() as we are doing a
> mod_delayed_work_on() in gov_queue_work(), which will take care of
> pending works for us.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index f1551fc7b4fd..a6f579e40ce2 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -247,40 +247,45 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
>  		unsigned int new_rate)
>  {
>  	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
> +	struct cpufreq_policy *policy;
> +	struct od_cpu_dbs_info_s *dbs_info;
> +	unsigned long next_sampling, appointed_at;
> +	struct cpumask cpumask;
>  	int cpu;
>  
> +	cpumask_copy(&cpumask, cpu_online_mask);
> +
>  	od_tuners->sampling_rate = new_rate = max(new_rate,
>  			dbs_data->min_sampling_rate);
>  
> -	for_each_online_cpu(cpu) {
> -		struct cpufreq_policy *policy;
> -		struct od_cpu_dbs_info_s *dbs_info;
> -		unsigned long next_sampling, appointed_at;
> -
> +	for_each_cpu(cpu, &cpumask) {
>  		policy = cpufreq_cpu_get(cpu);
>  		if (!policy)
>  			continue;
> +
> +		/* clear all CPUs of this policy */
> +		cpumask_andnot(&cpumask, &cpumask, policy->cpus);

Well, this is not exactly straightforward, but should work.

> +
>  		if (policy->governor != &cpufreq_gov_ondemand) {
>  			cpufreq_cpu_put(policy);
>  			continue;
>  		}
> +
>  		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
>  		cpufreq_cpu_put(policy);
>  
> -		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
> +		/* Make sure the work is not canceled on policy->cpus */

I'm not sure what scenario can lead to that.  Care to explain?

> +		if (!dbs_info->cdbs.shared->policy)
>  			continue;
>  
>  		next_sampling = jiffies + usecs_to_jiffies(new_rate);
>  		appointed_at = dbs_info->cdbs.dwork.timer.expires;

For that to work we always need to do stuff for policy->cpus in sync.
Do we?

> -		if (time_before(next_sampling, appointed_at)) {
> -			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
> -
> -			gov_queue_work(dbs_data, policy,
> -				       usecs_to_jiffies(new_rate),
> -				       cpumask_of(cpu));
> +		if (!time_before(next_sampling, appointed_at))
> +			continue;
>  
> -		}
> +		gov_queue_work(dbs_data, policy, usecs_to_jiffies(new_rate),
> +			       policy->cpus);
>  	}
>  }
>  
> 

Thanks,
Rafael
