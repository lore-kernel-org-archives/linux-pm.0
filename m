From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 06/12] cpufreq: governor: Keep single copy of information
 common to policy->cpus
Date: Mon, 15 Jun 2015 11:45:10 +0530
Message-ID: <557E6D6E.1070200@linux.vnet.ibm.com>
References: <cover.1434019473.git.viresh.kumar@linaro.org> <ca16538aebad3c886092c11dc3cc22e1385f2415.1434019473.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e17.ny.us.ibm.com ([129.33.205.207]:51072 "EHLO
	e17.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbbFOGPV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 02:15:21 -0400
Received: from /spool/local
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Mon, 15 Jun 2015 02:15:20 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 3234CC9003C
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 02:06:23 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5F6FGoa60686420
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 06:15:16 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5F6FE3g007703
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 02:15:16 -0400
In-Reply-To: <ca16538aebad3c886092c11dc3cc22e1385f2415.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> Some information is common to all CPUs belonging to a policy, but are
> kept on per-cpu basis. Lets keep that in another structure common to all
> policy->cpus. That will make updates/reads to that less complex and less
> error prone.

Good point.

> 
> The memory for ccdbs is allocated/freed at INIT/EXIT, so that it we
> don't reallocate it for STOP/START sequence. It will be also be used (in
> next patch) while the governor is stopped and so must not be freed that
> early.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index c0566f86caed..0ebff6fd0a0b 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> +static int alloc_ccdbs(struct cpufreq_policy *policy,
> +		       struct common_dbs_data *cdata)
> +{
> +	struct cpu_common_dbs_info *ccdbs;
> +	int j;
> +
> +	/* Allocate memory for the common information for policy->cpus */
> +	ccdbs = kzalloc(sizeof(*ccdbs), GFP_KERNEL);
> +	if (!ccdbs)
> +		return -ENOMEM;
> +
> +	ccdbs->policy = policy;
> +
> +	/* Set ccdbs for all CPUs, online+offline */
> +	for_each_cpu(j, policy->related_cpus)
> +		cdata->get_cpu_cdbs(j)->ccdbs = ccdbs;
> +
> +	return 0;
> +}
> +
> +static void free_ccdbs(struct cpufreq_policy *policy,
> +		       struct common_dbs_data *cdata)
> +{
> +	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
> +	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
> +	int j;
> +
> +	for_each_cpu(j, policy->cpus)
> +		cdata->get_cpu_cdbs(j)->ccdbs = NULL;
> +
> +	kfree(ccdbs);
> +}
> +
>  static int cpufreq_governor_init(struct cpufreq_policy *policy,
>  				 struct dbs_data *dbs_data,
>  				 struct common_dbs_data *cdata)
> @@ -248,6 +280,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
>  	if (dbs_data) {
>  		if (WARN_ON(have_governor_per_policy()))
>  			return -EINVAL;
> +
> +		ret = alloc_ccdbs(policy, cdata);
> +		if (ret)
> +			return ret;
> +
>  		dbs_data->usage_count++;
>  		policy->governor_data = dbs_data;
>  		return 0;
> @@ -257,12 +294,16 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
>  	if (!dbs_data)
>  		return -ENOMEM;
> 
> +	ret = alloc_ccdbs(policy, cdata);
> +	if (ret)
> +		goto free_dbs_data;
> +
>  	dbs_data->cdata = cdata;
>  	dbs_data->usage_count = 1;
> 
>  	ret = cdata->init(dbs_data, !policy->governor->initialized);
>  	if (ret)
> -		goto free_dbs_data;
> +		goto free_ccdbs;
> 
>  	/* policy latency is in ns. Convert it to us first */
>  	latency = policy->cpuinfo.transition_latency / 1000;
> @@ -299,6 +340,8 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
>  	}
>  cdata_exit:
>  	cdata->exit(dbs_data, !policy->governor->initialized);
> +free_ccdbs:
> +	free_ccdbs(policy, cdata);
>  free_dbs_data:
>  	kfree(dbs_data);
>  	return ret;
> @@ -320,6 +363,7 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
>  		}
> 
>  		cdata->exit(dbs_data, policy->governor->initialized == 1);
> +		free_ccdbs(policy, cdata);

This is a per-policy data structure, so why free it only when all the
users of the governor are gone ? We should be freeing it when a policy
is asked to exit, which is independent of references to this governor by
other policy cpus. This would mean freeing it outside this if condition.

>  		kfree(dbs_data);
>  	}
>  }
> @@ -330,6 +374,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  	struct common_dbs_data *cdata = dbs_data->cdata;
>  	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
>  	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
> +	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
>  	int io_busy = 0;
> 
>  	if (!policy->cur)
> @@ -348,11 +393,13 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  		io_busy = od_tuners->io_is_busy;
>  	}
> 
> +	ccdbs->time_stamp = ktime_get();
> +	mutex_init(&ccdbs->timer_mutex);
> +
>  	for_each_cpu(j, policy->cpus) {
>  		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
>  		unsigned int prev_load;
> 
> -		j_cdbs->policy = policy;

This is not convincing. INIT and EXIT should be typically used to
initiate and free 'governor' specific data structures. START and STOP
should be used for 'policy wide/cpu wide' initialization and making
NULL. Atleast thats how the current code appears to be designed.

Now, ccdbs is a policy wide data structure. We can perhaps allocate and
free ccdbs during INIT and EXIT, but initiating the values and making
them NULL must be done in START and STOP respectively. You initiate the
time_stamp and timer_mutex in START, why not initialize policy also
here? This will help maintain consistency in code too.


>  		j_cdbs->prev_cpu_idle =
>  			get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
> 
> @@ -364,7 +411,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  		if (ignore_nice)
>  			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
> 
> -		mutex_init(&j_cdbs->timer_mutex);
>  		INIT_DEFERRABLE_WORK(&j_cdbs->dwork, cdata->gov_dbs_timer);
>  	}
> 
> @@ -384,9 +430,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
>  		od_ops->powersave_bias_init_cpu(cpu);
>  	}
> 
> -	/* Initiate timer time stamp */
> -	cdbs->time_stamp = ktime_get();
> -
>  	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
>  		       true);
>  	return 0;
> @@ -398,6 +441,9 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
>  	struct common_dbs_data *cdata = dbs_data->cdata;
>  	unsigned int cpu = policy->cpu;
>  	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
> +	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
> +
> +	gov_cancel_work(dbs_data, policy);
> 
>  	if (cdata->governor == GOV_CONSERVATIVE) {
>  		struct cs_cpu_dbs_info_s *cs_dbs_info =
> @@ -406,10 +452,7 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
>  		cs_dbs_info->enable = 0;
>  	}
> 
> -	gov_cancel_work(dbs_data, policy);
> -
> -	mutex_destroy(&cdbs->timer_mutex);
> -	cdbs->policy = NULL;

Same here. For the same reason as above, the value for policy must be
nullified in STOP. Besides, policy is initiated a value explicitly in
INIT, but invalidated in EXIT by freeing ccdbs in this patch. There is
lack of consistency.

There is another consequence. Freeing a data structure does not
necessarily mean setting it to NULL. It can be some random address. This
will break places which check for NULL policy.

> +	mutex_destroy(&ccdbs->timer_mutex);

Another point which you may have taken care of in the subsequent
patches. I will mention here nevertheless.

The timer_mutex is destroyed, but the cdbs->policy is not NULL until we
call EXIT. So when cpufreq_governor_limits() is called, it checks for
the existence of ccdbs, which succeeds. But when it tries to take the
timer_mutex it dereferences NULL.

>  }
> 
>  static void cpufreq_governor_limits(struct cpufreq_policy *policy,
> @@ -419,18 +462,18 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
>  	unsigned int cpu = policy->cpu;
>  	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
> 
> -	if (!cdbs->policy)
> +	if (!cdbs->ccdbs)
>  		return;
> 
> -	mutex_lock(&cdbs->timer_mutex);
> -	if (policy->max < cdbs->policy->cur)
> -		__cpufreq_driver_target(cdbs->policy, policy->max,
> +	mutex_lock(&cdbs->ccdbs->timer_mutex);
> +	if (policy->max < cdbs->ccdbs->policy->cur)
> +		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->max,
>  					CPUFREQ_RELATION_H);
> -	else if (policy->min > cdbs->policy->cur)
> -		__cpufreq_driver_target(cdbs->policy, policy->min,
> +	else if (policy->min > cdbs->ccdbs->policy->cur)
> +		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->min,
>  					CPUFREQ_RELATION_L);
>  	dbs_check_cpu(dbs_data, cpu);
> -	mutex_unlock(&cdbs->timer_mutex);
> +	mutex_unlock(&cdbs->ccdbs->timer_mutex);
>  }
> 
>  int cpufreq_governor_dbs(struct cpufreq_policy *policy,


Regards
Preeti U Murthy

