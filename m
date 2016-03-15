From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/8] sched/fair: add margin to utilization update
Date: Tue, 15 Mar 2016 22:16:14 +0100
Message-ID: <20160315211614.GC6344@twins.programming.kicks-ass.net>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
 <1457932932-28444-3-git-send-email-mturquette+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from [198.137.202.9] ([198.137.202.9]:41368 "EHLO
	bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751312AbcCOVTT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 17:19:19 -0400
Content-Disposition: inline
In-Reply-To: <1457932932-28444-3-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

On Sun, Mar 13, 2016 at 10:22:06PM -0700, Michael Turquette wrote:
> @@ -2840,6 +2853,8 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
>  
>  	if (cpu == smp_processor_id() && &rq->cfs == cfs_rq) {
>  		unsigned long max = rq->cpu_capacity_orig;
> +		unsigned long cap = cfs_rq->avg.util_avg *
> +			cfs_capacity_margin / max;
>  
>  		/*
>  		 * There are a few boundary cases this might miss but it should
> @@ -2852,8 +2867,7 @@ static inline void update_load_avg(struct sched_entity *se, int update_tg)
>  		 * thread is a different class (!fair), nor will the utilization
>  		 * number include things like RT tasks.
>  		 */
> -		cpufreq_update_util(rq_clock(rq),
> -				    min(cfs_rq->avg.util_avg, max), max);
> +		cpufreq_update_util(rq_clock(rq), min(cap, max), max);
>  	}
>  }

I really don't see why that is here, and not inside whatever uses
cpufreq_update_util().
