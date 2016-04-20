From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] sched/cpufreq: don't trigger cpufreq update w/o real rt/deadline tasks running
Date: Wed, 20 Apr 2016 02:32:35 +0200
Message-ID: <6087716.bi8vDPiZNy@vostro.rjw.lan>
References: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56249 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753749AbcDTA3p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Apr 2016 20:29:45 -0400
In-Reply-To: <1460958684-32105-1-git-send-email-wanpeng.li@hotmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wanpeng Li <kernellwp@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Monday, April 18, 2016 01:51:24 PM Wanpeng Li wrote:
> Sometimes update_curr() is called w/o tasks actually running, it is
> captured by: 
> 	u64 delta_exec = rq_clock_task(rq) - curr->se.exec_start;
> We should not trigger cpufreq update in this case for rt/deadline
> classes, and this patch fix it.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>

The signed-off-by tag should agree with the From: header.  One way to achieve
that is to add an extra From: line at the start of the changelog.

That said, this looks like a good catch that should go into 4.6 to me.

Peter, what do you think?

> ---
>  kernel/sched/deadline.c | 8 ++++----
>  kernel/sched/rt.c       | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index affd97e..8f9b5af 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -717,10 +717,6 @@ static void update_curr_dl(struct rq *rq)
>  	if (!dl_task(curr) || !on_dl_rq(dl_se))
>  		return;
>  
> -	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
> -	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_trigger_update(rq_clock(rq));
> -
>  	/*
>  	 * Consumed budget is computed considering the time as
>  	 * observed by schedulable tasks (excluding time spent
> @@ -736,6 +732,10 @@ static void update_curr_dl(struct rq *rq)
>  		return;
>  	}
>  
> +	/* kick cpufreq (see the comment in linux/cpufreq.h). */
> +	if (cpu_of(rq) == smp_processor_id())
> +		cpufreq_trigger_update(rq_clock(rq));
> +
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
>  
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index c41ea7a..19e1306 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -953,14 +953,14 @@ static void update_curr_rt(struct rq *rq)
>  	if (curr->sched_class != &rt_sched_class)
>  		return;
>  
> -	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
> -	if (cpu_of(rq) == smp_processor_id())
> -		cpufreq_trigger_update(rq_clock(rq));
> -
>  	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
>  	if (unlikely((s64)delta_exec <= 0))
>  		return;
>  
> +	/* Kick cpufreq (see the comment in linux/cpufreq.h). */
> +	if (cpu_of(rq) == smp_processor_id())
> +		cpufreq_trigger_update(rq_clock(rq));
> +
>  	schedstat_set(curr->se.statistics.exec_max,
>  		      max(curr->se.statistics.exec_max, delta_exec));
>  
> 

