From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/9] cpufreq: governor: Avoid atomic operations in hot
 paths
Date: Mon, 15 Feb 2016 11:47:10 +0530
Message-ID: <20160215061710.GC6334@vireshk-i7>
References: <3329748.lhJgppdTt9@vostro.rjw.lan>
 <8782327.qY15U8QUIT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33577 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbcBOGRS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 01:17:18 -0500
Received: by mail-pf0-f179.google.com with SMTP id q63so81987758pfb.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Feb 2016 22:17:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8782327.qY15U8QUIT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>

On 15-02-16, 02:13, Rafael J. Wysocki wrote:
>  static void dbs_irq_work(struct irq_work *irq_work)
> @@ -357,6 +360,7 @@ static void dbs_update_util_handler(stru
>  {
>  	struct cpu_dbs_info *cdbs = container_of(data, struct cpu_dbs_info, update_util);
>  	struct policy_dbs_info *policy_dbs = cdbs->policy_dbs;
> +	u64 delta_ns;
>  
>  	/*
>  	 * The work may not be allowed to be queued up right now.
> @@ -364,17 +368,30 @@ static void dbs_update_util_handler(stru
>  	 * - Work has already been queued up or is in progress.
>  	 * - It is too early (too little time from the previous sample).
>  	 */
> -	if (atomic_inc_return(&policy_dbs->work_count) == 1) {
> -		u64 delta_ns;
> +	if (policy_dbs->work_in_progress)
> +		return;
>  
> -		delta_ns = time - policy_dbs->last_sample_time;
> -		if ((s64)delta_ns >= policy_dbs->sample_delay_ns) {
> -			policy_dbs->last_sample_time = time;
> -			gov_queue_irq_work(policy_dbs);
> -			return;
> -		}
> -	}
> -	atomic_dec(&policy_dbs->work_count);
> +	/*
> +	 * If the reads below are reordered before the check above, the value
> +	 * of sample_delay_ns used in the computation may be stale.
> +	 */
> +	smp_rmb();
> +	delta_ns = time - policy_dbs->last_sample_time;
> +	if ((s64)delta_ns < policy_dbs->sample_delay_ns)
> +		return;
> +
> +	/*
> +	 * If the policy is not shared, the irq_work may be queued up right away
> +	 * at this point.  Otherwise, we need to ensure that only one of the
> +	 * CPUs sharing the policy will do that.
> +	 */
> +	if (policy_dbs->is_shared &&
> +	    !atomic_add_unless(&policy_dbs->work_count, 1, 1))
> +		return;
> +
> +	policy_dbs->last_sample_time = time;
> +	policy_dbs->work_in_progress = true;
> +	gov_queue_irq_work(policy_dbs);
>  }
>  
>  static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *policy,
> @@ -551,6 +568,8 @@ static int cpufreq_governor_start(struct
>  	if (!policy->cur)
>  		return -EINVAL;
>  
> +	policy_dbs->is_shared = policy_is_shared(policy);
> +
>  	sampling_rate = dbs_data->sampling_rate;
>  	ignore_nice = dbs_data->ignore_nice_load;
>  
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.h
> @@ -130,6 +130,9 @@ struct policy_dbs_info {
>  	/* dbs_data may be shared between multiple policy objects */
>  	struct dbs_data *dbs_data;
>  	struct list_head list;
> +	/* Status indicators */
> +	bool is_shared;		/* This object is used by multiple CPUs */
> +	bool work_in_progress;	/* Work is being queued up or in progress */
>  };
>  
>  static inline void gov_update_sample_delay(struct policy_dbs_info *policy_dbs,

-- 
viresh
