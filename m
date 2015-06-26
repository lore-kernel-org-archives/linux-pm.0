From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 06/10] cpufreq: ondemand: Drop unnecessary locks from
 update_sampling_rate()
Date: Fri, 26 Jun 2015 12:50:52 +0530
Message-ID: <558CFD54.7050005@linux.vnet.ibm.com>
References: <cover.1434959517.git.viresh.kumar@linaro.org> <88c876acc1389b613a7721afdd369d60841f93e9.1434959517.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:50378 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbbFZHVA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 03:21:00 -0400
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 26 Jun 2015 01:20:59 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4C2EB3E4003F
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 01:20:56 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5Q7KW3643450430
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 00:20:32 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5Q7KtKd028989
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 01:20:56 -0600
In-Reply-To: <88c876acc1389b613a7721afdd369d60841f93e9.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> 'timer_mutex' is required to sync work-handlers of policy->cpus.
> update_sampling_rate() is just canceling the works and queuing them
> again. This isn't protecting anything at all in update_sampling_rate()
> and is not gonna be of any use.
> 
> Even if a work-handler is already running for a CPU,
> cancel_delayed_work_sync() will wait for it to finish.
> 
> Drop these unnecessary locks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/cpufreq_ondemand.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
> index 774bbddae2c9..841e1fa96ee7 100644
> --- a/drivers/cpufreq/cpufreq_ondemand.c
> +++ b/drivers/cpufreq/cpufreq_ondemand.c
> @@ -267,28 +267,20 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
>  		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
>  		cpufreq_cpu_put(policy);
> 
> -		mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
> -
> -		if (!delayed_work_pending(&dbs_info->cdbs.dwork)) {
> -			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
> +		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
>  			continue;
> -		}
> 
>  		next_sampling = jiffies + usecs_to_jiffies(new_rate);
>  		appointed_at = dbs_info->cdbs.dwork.timer.expires;
> 
>  		if (time_before(next_sampling, appointed_at)) {
> -
> -			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
>  			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
> -			mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
> 
>  			gov_queue_work(dbs_data, policy,
>  				       usecs_to_jiffies(new_rate),
>  				       cpumask_of(cpu));
> 
>  		}
> -		mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
>  	}
>  }
> 

