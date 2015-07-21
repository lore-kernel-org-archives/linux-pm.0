From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFCv5 PATCH 31/46] sched: Consider spare cpu capacity at task
 wake-up
Date: Mon, 20 Jul 2015 17:37:20 -0700
Message-ID: <55AD9440.8090802@nvidia.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-32-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15749 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755847AbbGUAis (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 20:38:48 -0400
In-Reply-To: <1436293469-25707-32-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pboonstoppel@nvidia.com

Hi Morten,

On 07/07/2015 11:24 AM, Morten Rasmussen wrote:
> In mainline find_idlest_group() selects the wake-up target group purely
> based on group load which leads to suboptimal choices in low load
> scenarios. An idle group with reduced capacity (due to RT tasks or
> different cpu type) isn't necessarily a better target than a lightly
> loaded group with higher capacity.
> 
> The patch adds spare capacity as an additional group selection
> parameter. The target group is now selected based on the following
> criteria listed by highest priority first:
> 
> 1. If energy-aware scheduling is enabled the group with the lowest
> capacity containing a cpu with enough spare capacity to accommodate the
> task (with a bit to spare) is selected if such exists.
> 
> 2. Return the group with the cpu with most spare capacity and this
> capacity is significant if such group exists. Significant spare capacity
> is currently at least 20% to spare.
> 
> 3. Return the group with the lowest load, unless it is the local group
> in which case NULL is returned and the search is continued at the next
> (lower) level.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  kernel/sched/fair.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b0294f0..0f7dbda4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5247,9 +5247,10 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  		  int this_cpu, int sd_flag)
>  {
>  	struct sched_group *idlest = NULL, *group = sd->groups;
> -	struct sched_group *fit_group = NULL;
> +	struct sched_group *fit_group = NULL, *spare_group = NULL;
>  	unsigned long min_load = ULONG_MAX, this_load = 0;
>  	unsigned long fit_capacity = ULONG_MAX;
> +	unsigned long max_spare_capacity = capacity_margin - SCHED_LOAD_SCALE;
>  	int load_idx = sd->forkexec_idx;
>  	int imbalance = 100 + (sd->imbalance_pct-100)/2;
>  
> @@ -5257,7 +5258,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  		load_idx = sd->wake_idx;
>  
>  	do {
> -		unsigned long load, avg_load;
> +		unsigned long load, avg_load, spare_capacity;
>  		int local_group;
>  		int i;
>  
> @@ -5290,6 +5291,16 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  				fit_capacity = capacity_of(i);
>  				fit_group = group;
>  			}
> +
> +			/*
> +			 * Look for group which has most spare capacity on a
> +			 * single cpu.
> +			 */
> +			spare_capacity = capacity_of(i) - get_cpu_usage(i);
> +			if (spare_capacity > max_spare_capacity) {
> +				max_spare_capacity = spare_capacity;
> +				spare_group = group;
> +			}

Another minor buglet: get_cpu_usage(i) here could be > capacity_of(i)
because usage is bounded by capacity_orig_of(i). Should it be bounded by
capacity_of() instead?

>  		}
>  
>  		/* Adjust by relative CPU capacity of the group */
> @@ -5306,6 +5317,9 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p,
>  	if (fit_group)
>  		return fit_group;
>  
> +	if (spare_group)
> +		return spare_group;
> +
>  	if (!idlest || 100*this_load < imbalance*min_load)
>  		return NULL;
>  	return idlest;
> 

Thanks,
-Sai
