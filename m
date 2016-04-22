From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3] sched/cpufreq: optimize cpufreq update kicker to avoid
 update multiple times
Date: Fri, 22 Apr 2016 14:04:56 +0200
Message-ID: <571A1368.9060409@intel.com>
References: <1461316044-9520-1-git-send-email-wanpeng.li@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:37011 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbcDVMFI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Apr 2016 08:05:08 -0400
In-Reply-To: <1461316044-9520-1-git-send-email-wanpeng.li@hotmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM <linux-pm@vger.kernel.org>

[Added linux-pm to the CC - can you please do so for PM-related patches 
in the future?]

On 4/22/2016 11:07 AM, Wanpeng Li wrote:
> From: Wanpeng Li <wanpeng.li@hotmail.com>
>
> Sometimes delta_exec is 0 due to update_curr() is called multiple times,
> this is captured by:
>
> 	u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>
> This patch optimizes the cpufreq update kicker by bailing out when nothing
> changed, it will benefit the upcoming schedutil, since otherwise it will
> (over)react to the special util/max combination.
>
> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>

The changelog looks better now, thanks!

Peter, do I think correctly that you're going to take care of this one?  
Or do you want me to take it?

> ---
> v1 -> v2:
>   * add From: head
> v2 -> v3:
>   * update changelog
>
>   kernel/sched/deadline.c | 8 ++++----
>   kernel/sched/rt.c       | 8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index affd97e..8f9b5af 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -717,10 +717,6 @@ static void update_curr_dl(struct rq *rq)
>   	if (!dl_task(curr) || !on_dl_rq(dl_se))
>   		return;
>   
> -	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
> -	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_trigger_update(rq_clock(rq));
> -
>   	/*
>   	 * Consumed budget is computed considering the time as
>   	 * observed by schedulable tasks (excluding time spent
> @@ -736,6 +732,10 @@ static void update_curr_dl(struct rq *rq)
>   		return;
>   	}
>   
> +	/* kick cpufreq (see the comment in linux/cpufreq.h). */
> +	if (cpu_of(rq) == smp_processor_id())
> +		cpufreq_trigger_update(rq_clock(rq));
> +
>   	schedstat_set(curr->se.statistics.exec_max,
>   		      max(curr->se.statistics.exec_max, delta_exec));
>   
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index c41ea7a..19e1306 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -953,14 +953,14 @@ static void update_curr_rt(struct rq *rq)
>   	if (curr->sched_class != &rt_sched_class)
>   		return;
>   
> -	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
> -	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_trigger_update(rq_clock(rq));
> -
>   	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>   	if (unlikely((s64)delta_exec <= 0))
>   		return;
>   
> +	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
> +	if (cpu_of(rq) == smp_processor_id())
> +		cpufreq_trigger_update(rq_clock(rq));
> +
>   	schedstat_set(curr->se.statistics.exec_max,
>   		      max(curr->se.statistics.exec_max, delta_exec));
>   

