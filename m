From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v1 8/8] sched/deadline: make bandwidth enforcement
 scale-invariant
Date: Wed, 19 Jul 2017 09:21:43 +0200
Message-ID: <20170719072143.lploljodns3kfucf@hirez.programming.kicks-ass.net>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-9-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55625 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdGSHWD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 03:22:03 -0400
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-9-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Jul 05, 2017 at 09:59:05AM +0100, Juri Lelli wrote:
> @@ -1156,9 +1157,26 @@ static void update_curr_dl(struct rq *rq)
>  	if (unlikely(dl_entity_is_special(dl_se)))
>  		return;
>  
> -	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM))
> -		delta_exec = grub_reclaim(delta_exec, rq, &curr->dl);
> -	dl_se->runtime -= delta_exec;
> +	/*
> +	 * For tasks that participate in GRUB, we implement GRUB-PA: the
> +	 * spare reclaimed bandwidth is used to clock down frequency.
> +	 *
> +	 * For the others, we still need to scale reservation parameters
> +	 * according to current frequency and CPU maximum capacity.
> +	 */
> +	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
> +		scaled_delta_exec = grub_reclaim(delta_exec,
> +						 rq,
> +						 &curr->dl);
> +	} else {
> +		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
> +		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
> +
> +		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
> +		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
> +	}
> +
> +	dl_se->runtime -= scaled_delta_exec;
>  

This I don't get... 
