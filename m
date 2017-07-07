From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH v1 4/8] sched/cpufreq_schedutil: split utilization
 signals
Date: Fri, 7 Jul 2017 14:28:48 +0530
Message-ID: <20170707085848.GA32542@vireshk-i7>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-5-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33059 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbdGGI6w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 04:58:52 -0400
Received: by mail-pf0-f170.google.com with SMTP id e7so14228338pfk.0
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2017 01:58:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-5-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 05-07-17, 09:59, Juri Lelli wrote:
> To be able to treat utilization signals of different scheduling classes
> in different ways (e.g., CFS signal might be stale while DEADLINE signal
> is never stale by design) we need to split sugov_cpu::util signal in two:
> util_cfs and util_dl.
> 
> This patch does that by also changing sugov_get_util() parameter list.
> After this change, aggregation of the different signals has to be performed
> by sugov_get_util() users (so that they can decide what to do with the
> different signals).
> 
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Are you referring to this response here ?

https://marc.info/?l=linux-kernel&m=149095102600847&w=2

If yes, then I don't think it was about having separate APIs, but just storing
util_cfs/dl separately.

> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu)
>  {
>  	struct rq *rq = this_rq();
> -	unsigned long dl_util = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
> -				>> BW_SHIFT;
>  
> -	*max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +	sg_cpu->max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +	sg_cpu->util_cfs = rq->cfs.avg.util_avg;
> +	sg_cpu->util_dl = (rq->dl.running_bw * SCHED_CAPACITY_SCALE)
> +			  >> BW_SHIFT;
> +}
>  
> +static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)

As Joel already mentioned, I don't think we should create two separate routines
here.

-- 
viresh
