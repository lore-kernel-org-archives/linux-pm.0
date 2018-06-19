From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [RFC PATCH v3 06/10] sched: Add over-utilization/tipping point
 indicator
Date: Tue, 19 Jun 2018 12:31:03 +0530
Message-ID: <20180619070103.GB9208@codeaurora.org>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-7-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-7-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 03:25:01PM +0100, Quentin Perret wrote:

<snip>

>  	util_est_enqueue(&rq->cfs, p);
>  	hrtick_update(rq);
> @@ -8121,11 +8144,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
>   * @local_group: Does group contain this_cpu.
>   * @sgs: variable to hold the statistics for this group.
>   * @overload: Indicate more than one runnable task for any CPU.
> + * @overutilized: Indicate overutilization for any CPU.
>   */
>  static inline void update_sg_lb_stats(struct lb_env *env,
>  			struct sched_group *group, int load_idx,
>  			int local_group, struct sg_lb_stats *sgs,
> -			bool *overload)
> +			bool *overload, int *overutilized)
>  {
>  	unsigned long load;
>  	int i, nr_running;
> @@ -8152,6 +8176,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		if (nr_running > 1)
>  			*overload = true;
>  
> +		if (cpu_overutilized(i))
> +			*overutilized = 1;
> +

There is no need to check if every CPU is overutilized or not once
*overutilized is marked as true, right? 

<snip>

>  
> @@ -8586,6 +8621,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
>  	 * this level.
>  	 */
>  	update_sd_lb_stats(env, &sds);
> +
> +	if (sched_energy_enabled() && !READ_ONCE(env->dst_rq->rd->overutilized))
> +		goto out_balanced;
> +

Is there any reason for sending no-hz idle kicks but bailing out here when
system is not overutilized?

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
