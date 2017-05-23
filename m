From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Tue, 23 May 2017 21:04:51 +0200
Message-ID: <20170523190451.3flxegqt7ttmorw6@hirez.programming.kicks-ass.net>
References: <20170523085351.18586-1-juri.lelli@arm.com>
 <20170523085351.18586-5-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:46153 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdEWTFB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 15:05:01 -0400
Content-Disposition: inline
In-Reply-To: <20170523085351.18586-5-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Tue, May 23, 2017 at 09:53:47AM +0100, Juri Lelli wrote:
> @@ -157,14 +158,13 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	return cpufreq_driver_resolve_freq(policy, freq);
>  }
>  
> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = this_rq();
> -	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> 20;
>  
> -	*max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> -
> -	*util = min(rq->cfs.avg.util_avg + dl_util, *max);
> +	sg_cpu->max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +	sg_cpu->util_cfs = rq->cfs.avg.util_avg;
> +	sg_cpu->util_dl = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> 20;
>  }

Luca just introduced a nice BW_SHIFT for that '20' thing.
