From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 05/10] cpufreq: governor: Drop __gov_queue_work()
Date: Fri, 26 Jun 2015 12:33:14 +0530
Message-ID: <558CF932.4070409@linux.vnet.ibm.com>
References: <cover.1434959517.git.viresh.kumar@linaro.org> <c4dfd8121fd454a04a8d700a5a0f8b7858f7aed3.1434959517.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:59613 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbbFZHDv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 03:03:51 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Fri, 26 Jun 2015 01:03:51 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 322FA19D803E
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 00:54:48 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5Q73m1743778186
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 00:03:48 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5Q73llD015123
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 01:03:47 -0600
In-Reply-To: <c4dfd8121fd454a04a8d700a5a0f8b7858f7aed3.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> __gov_queue_work() isn't required anymore and can be merged with
> gov_queue_work(). Do it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 416a8c5665dd..ac288f0efb06 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -158,25 +158,20 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
>  }
>  EXPORT_SYMBOL_GPL(dbs_check_cpu);
> 
> -static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
> -		unsigned int delay)
> -{
> -	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> -
> -	mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
> -}

Looking at this patch I feel now that, you can simply make the above
function non static and call the same from update_sampling_rate() in
patch[04/10] It already gives scope to pass in the cpu parameter, if not
the mask. Anyway you want to pass in a single cpu from
update_sampling_rate(). This will avoid having to change the other call
sites of gov_queue_work().

I also see elsewhere in the kernel where a fn() and __fn() are sometimes
both non-static, with __fn() giving you the additional benefit of
passing a critical parameter. Eg:
__hrtimer_start_range_ns() and hrtimer_start_range_ns().

Regards
Preeti U Murthy
> -
>  void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>  		    unsigned int delay, const struct cpumask *cpus)
>  {
> -	int i;
> +	struct cpu_dbs_info *cdbs;
> +	int cpu;
> 
>  	mutex_lock(&cpufreq_governor_lock);
>  	if (!policy->governor_enabled)
>  		goto out_unlock;
> 
> -	for_each_cpu(i, cpus)
> -		__gov_queue_work(i, dbs_data, delay);
> +	for_each_cpu(cpu, cpus) {
> +		cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
> +		mod_delayed_work_on(cpu, system_wq, &cdbs->dwork, delay);
> +	}
> 
>  out_unlock:
>  	mutex_unlock(&cpufreq_governor_lock);
> 

