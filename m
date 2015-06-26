From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 07/10] cpufreq: ondemand: queue work for policy->cpus
 together
Date: Fri, 26 Jun 2015 13:58:34 +0530
Message-ID: <558D0D32.7060001@linux.vnet.ibm.com>
References: <cover.1434959517.git.viresh.kumar@linaro.org> <66980e2b51a83bf34f6fd18ee55155b6c667aa6a.1434959517.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:47543 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbbFZI2k (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 04:28:40 -0400
Received: from /spool/local
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 26 Jun 2015 02:28:39 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 92EB51FF0046
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 02:19:47 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5Q8RuSt59113496
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 01:27:56 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5Q8Sb3O007384
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 02:28:37 -0600
In-Reply-To: <66980e2b51a83bf34f6fd18ee55155b6c667aa6a.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> Currently update_sampling_rate() runs over each online CPU and
> cancels/queues work on it. Its very inefficient for the case where a
> single policy manages multiple CPUs, as they can be processed together.
> 
> Also drop the unnecessary cancel_delayed_work_sync() as we are doing a
> mod_delayed_work_on() in gov_queue_work(), which will take care of
> pending works for us.

This looks fine, except for one point. See below:
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 841e1fa96ee7..cfecd3b67cb3 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -247,40 +247,48 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
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
> +
>  		if (policy->governor != &cpufreq_gov_ondemand) {
>  			cpufreq_cpu_put(policy);
>  			continue;
>  		}
> +
>  		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
>  		cpufreq_cpu_put(policy);
> 
> +		/*
> +		 * Checking this for any CPU of the policy is fine. As either
> +		 * all would have queued work or none.

Are you sure that the state of the work will be the same across all
policy cpus ? 'Pending' only refers to twork awaiting for the timer to
fire and then queue itself on the runqueue right ? On some of the
policy->cpus, timers may be yet to fire, while on others it might
already have ?

> +		 */
>  		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
>  			continue;
> 
>  		next_sampling = jiffies + usecs_to_jiffies(new_rate);
>  		appointed_at = dbs_info->cdbs.dwork.timer.expires;
> 
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

Regards
Preeti U Murthy

