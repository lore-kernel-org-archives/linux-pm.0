From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC][PATCH 5/7] cpufreq / sched: UUF_IO flag to indicate iowait
 condition
Date: Mon, 1 Aug 2016 18:22:09 -0700
Message-ID: <20160802012209.GB9332@graphite.smuckle.net>
References: <3752826.3sXAQIvcIA@vostro.rjw.lan>
 <3009663.9YcxTKseiO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36305 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbcHBBXd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2016 21:23:33 -0400
Received: by mail-pf0-f173.google.com with SMTP id h186so60362218pfg.3
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2016 18:22:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3009663.9YcxTKseiO@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Aug 01, 2016 at 01:37:23AM +0200, Rafael J. Wysocki wrote:
...
> For this purpose, define a new cpufreq_update_util() flag
> UUF_IO and modify enqueue_task_fair() to pass that flag to
> cpufreq_update_util() in the in_iowait case.  That generally
> requires cpufreq_update_util() to be called directly from there,
> because update_load_avg() is not likely to be invoked in that
> case.

I didn't follow why the cpufreq hook won't likely be called if
in_iowait is set? AFAICS update_load_avg() gets called in the second loop
and calls update_cfs_rq_load_avg (triggers the hook).

> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/sched.h |    1 +
>  kernel/sched/fair.c   |    8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> Index: linux-pm/kernel/sched/fair.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/fair.c
> +++ linux-pm/kernel/sched/fair.c
> @@ -4459,6 +4459,14 @@ enqueue_task_fair(struct rq *rq, struct
>  	struct cfs_rq *cfs_rq;
>  	struct sched_entity *se = &p->se;
>  
> +	/*
> +	 * If in_iowait is set, it is likely that the loops below will not
> +	 * trigger any cpufreq utilization updates, so do it here explicitly
> +	 * with the IO flag passed.
> +	 */
> +	if (p->in_iowait)
> +		cpufreq_update_util(rq, UUF_IO);
> +
>  	for_each_sched_entity(se) {
>  		if (se->on_rq)
>  			break;
> Index: linux-pm/include/linux/sched.h
> ===================================================================
> --- linux-pm.orig/include/linux/sched.h
> +++ linux-pm/include/linux/sched.h
> @@ -3376,6 +3376,7 @@ static inline unsigned long rlimit_max(u
>  }
>  
>  #define UUF_RT	0x01
> +#define UUF_IO	0x02
>  
>  #ifdef CONFIG_CPU_FREQ
>  struct update_util_data {

thanks,
Steve
