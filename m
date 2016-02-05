From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 9/10] cpufreq: governor: Rearrange governor data
 structures
Date: Fri, 5 Feb 2016 14:43:57 +0530
Message-ID: <20160205091357.GL21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <13133705.tMsel709A1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34644 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbcBEJOB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 04:14:01 -0500
Received: by mail-pa0-f52.google.com with SMTP id uo6so31759998pac.1
        for <linux-pm@vger.kernel.org>; Fri, 05 Feb 2016 01:14:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <13133705.tMsel709A1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 05-02-16, 03:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The struct policy_dbs_info objects representing per-policy governor
> data are not accessible directly from the corresponding policy
> objects.  To access them, one has to get a pointer to the
> struct cpu_dbs_info of policy->cpu and use the "shared" field of
> that which isn't really straightforward.
> 
> To address that rearrange the governor data structures so the
> governor_data pointer in struct cpufreq_policy will point to
> struct policy_dbs_info and that will contain a pointer to
> struct dbs_data.

IMHO, this patch has done way too much over what's mentioned here.

> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -297,16 +298,22 @@ static int alloc_policy_dbs_info(struct
>  	/* Allocate memory for the common information for policy->cpus */
>  	policy_dbs = kzalloc(sizeof(*policy_dbs), GFP_KERNEL);
>  	if (!policy_dbs)
> -		return -ENOMEM;
> -
> -	/* Set policy_dbs for all CPUs, online+offline */
> -	for_each_cpu(j, policy->related_cpus)
> -		gov->get_cpu_cdbs(j)->shared = policy_dbs;
> +		return NULL;
>  
> +	policy_dbs->policy = policy;

Value of policy_dbs->policy was used to verify the state machine of
the governor and so was updated only in start/stop.

You have moved it to INIT first (which shouldn't have been part of
this patch at the least), and then there is no reasoning given on why
that isn't required as part of the state machine now, which I believe
is still required the way it was.

>  	mutex_init(&policy_dbs->timer_mutex);
>  	atomic_set(&policy_dbs->skip_work, 0);
> +	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
> +	init_completion(&policy_dbs->irq_work_done);
>  	INIT_WORK(&policy_dbs->work, dbs_work_handler);
> -	return 0;
> +	/* Set policy_dbs for all CPUs, online+offline */
> +	for_each_cpu(j, policy->related_cpus) {
> +		struct cpu_dbs_info *j_cdbs = gov->get_cpu_cdbs(j);
> +
> +		j_cdbs->shared = policy_dbs;
> +		j_cdbs->update_util.func = dbs_update_util_handler;
> +	}

All other initializations are moved here for the good, but I think it
could have been done in a separate patch as to make review of this
trivial patch, which isn't so easy to review, easy :)

>  static int cpufreq_governor_exit(struct cpufreq_policy *policy)
>  {
>  	struct dbs_governor *gov = dbs_governor_of(policy);
> -	struct dbs_data *dbs_data = policy->governor_data;
> -	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
> +	struct policy_dbs_info *policy_dbs = policy->governor_data;
> +	struct dbs_data *dbs_data = policy_dbs->dbs_data;
>  
>  	/* State should be equivalent to INIT */
> -	if (!cdbs->shared || cdbs->shared->policy)

For example, to make sure the current state is equivalent to INIT, we
had two checks earlier:
- First one made sure that cdbs->shared is allocated (which was done
  in INIT)
- And second one makes sure that shared->policy is NULL, as that is
  initialized in START.

> +	if (!dbs_data)
>  		return -EBUSY;

But now, the current state can be INIT or START, you can't
differentiate.

>  static int cpufreq_governor_start(struct cpufreq_policy *policy)
>  {
>  	struct dbs_governor *gov = dbs_governor_of(policy);
> -	struct dbs_data *dbs_data = policy->governor_data;
> +	struct policy_dbs_info *policy_dbs = policy->governor_data;
> +	struct dbs_data *dbs_data = policy_dbs->dbs_data;
>  	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
> -	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
> -	struct policy_dbs_info *policy_dbs = cdbs->shared;
>  	int io_busy = 0;
>  
>  	if (!policy->cur)
>  		return -EINVAL;
>  
>  	/* State should be equivalent to INIT */
> -	if (!policy_dbs || policy_dbs->policy)
> +	if (!dbs_data)

Same here.. 

>  static int cpufreq_governor_stop(struct cpufreq_policy *policy)
>  {
> -	struct dbs_governor *gov = dbs_governor_of(policy);
> -	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(policy->cpu);
> -	struct policy_dbs_info *policy_dbs = cdbs->shared;
> -
> -	/* State should be equivalent to START */
> -	if (!policy_dbs || !policy_dbs->policy)

And here ..

> -		return -EBUSY;
> -
> -	gov_cancel_work(policy_dbs);
> -	policy_dbs->policy = NULL;
> -
> +	gov_cancel_work(policy->governor_data);
>  	return 0;
>  }
>  
>  static int cpufreq_governor_limits(struct cpufreq_policy *policy)
>  {
> -	struct dbs_governor *gov = dbs_governor_of(policy);
> -	unsigned int cpu = policy->cpu;
> -	struct cpu_dbs_info *cdbs = gov->get_cpu_cdbs(cpu);
> +	struct policy_dbs_info *policy_dbs = policy->governor_data;
>  
>  	/* State should be equivalent to START */
> -	if (!cdbs->shared || !cdbs->shared->policy)
> +	if (!policy_dbs->dbs_data)

And here...

>  		return -EBUSY;
>  
> -	mutex_lock(&cdbs->shared->timer_mutex);
> -	if (policy->max < cdbs->shared->policy->cur)
> -		__cpufreq_driver_target(cdbs->shared->policy, policy->max,
> -					CPUFREQ_RELATION_H);
> -	else if (policy->min > cdbs->shared->policy->cur)
> -		__cpufreq_driver_target(cdbs->shared->policy, policy->min,
> -					CPUFREQ_RELATION_L);
> -	dbs_check_cpu(policy, cpu);
> -	mutex_unlock(&cdbs->shared->timer_mutex);
> +	mutex_lock(&policy_dbs->timer_mutex);
> +	if (policy->max < policy->cur)
> +		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
> +	else if (policy->min > policy->cur)
> +		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
> +	dbs_check_cpu(policy, policy->cpu);
> +	mutex_unlock(&policy_dbs->timer_mutex);
>  
>  	return 0;
>  }

-- 
viresh
