From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 34/46] sched: Enable idle balance to pull single
 task towards cpu with higher capacity
Date: Sat, 15 Aug 2015 11:15:23 +0200
Message-ID: <20150815091523.GB10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-35-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44993 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbbHOTv3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 15:51:29 -0400
Content-Disposition: inline
In-Reply-To: <1436293469-25707-35-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:17PM +0100, Morten Rasmussen wrote:
> +++ b/kernel/sched/fair.c
> @@ -7569,6 +7569,13 @@ static int need_active_balance(struct lb_env *env)
>  			return 1;
>  	}
>  
> +	if ((capacity_of(env->src_cpu) < capacity_of(env->dst_cpu)) &&
> +				env->src_rq->cfs.h_nr_running == 1 &&
> +				cpu_overutilized(env->src_cpu) &&
> +				!cpu_overutilized(env->dst_cpu)) {
> +			return 1;
> +	}
> +
>  	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
>  }

Doesn't this allow for a nice game of ping-pong? Where if a task runs on
CPU X and generates interrupts there, its capacity will lower and we'll
migrate it over to CPU Y because that isn't receiving interrupts.

Now the task is running on Y, will generate interrupts there, and sees X
as a more attractive destination.

goto 1
