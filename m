From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [Update][PATCH 1/2] cpufreq / sched: Pass flags to
 cpufreq_update_util()
Date: Thu, 11 Aug 2016 11:03:47 -0700
Message-ID: <20160811180347.GB14324@graphite.smuckle.net>
References: <4498725.ix9jPCHteg@vostro.rjw.lan>
 <14590530.PIp5juoJ7q@vostro.rjw.lan>
 <1878295.pk6FjfzjrR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35276 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbcHKSDv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 14:03:51 -0400
Received: by mail-pa0-f49.google.com with SMTP id i5so798979pat.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Aug 2016 11:03:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1878295.pk6FjfzjrR@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Aug 10, 2016 at 03:49:07AM +0200, Rafael J. Wysocki wrote:
> Index: linux-pm/kernel/sched/fair.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/fair.c
> +++ linux-pm/kernel/sched/fair.c
> @@ -2875,11 +2875,8 @@ static inline void update_tg_load_avg(st
>  
>  static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
>  {
> -	struct rq *rq = rq_of(cfs_rq);
> -	int cpu = cpu_of(rq);
> -
> -	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
> -		unsigned long max = rq->cpu_capacity_orig;
> +	if (&this_rq()->cfs == cfs_rq) {
> +		struct rq *rq = rq_of(cfs_rq);
>  
>  		/*
>  		 * There are a few boundary cases this might miss but it should
> @@ -2897,8 +2894,8 @@ static inline void cfs_rq_util_change(st
>  		 *
>  		 * See cpu_util().
>  		 */
> -		cpufreq_update_util(rq_clock(rq),
> -				    min(cfs_rq->avg.util_avg, max), max);
> +		if (cpu_of(rq) == smp_processor_id())

Isn't this test against smp_processor_id() redundant since
this_rq()->cfs == cfs_rq?

> +			cpufreq_update_util(rq_clock(rq), 0);

All else looked good to me.

thanks,
Steve
