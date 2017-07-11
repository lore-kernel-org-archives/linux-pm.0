From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v1 5/8] sched/cpufreq_schedutil: always consider all
 CPUs when deciding next freq
Date: Tue, 11 Jul 2017 18:17:31 +0200
Message-ID: <20170711161731.plbzv42yv7l66fwh@hirez.programming.kicks-ass.net>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170705085905.6558-6-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932731AbdGKQR4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2017 12:17:56 -0400
Content-Disposition: inline
In-Reply-To: <20170705085905.6558-6-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Wed, Jul 05, 2017 at 09:59:02AM +0100, Juri Lelli wrote:
>  		delta_ns = time - j_sg_cpu->last_update;
>  		if (delta_ns > TICK_NSEC) {
>  			j_sg_cpu->iowait_boost = 0;
> -			continue;
> +			j_sg_cpu->util_cfs = 0;

this is slighly confusing. Is this because we might not 'continue' with
the new code?

> +			if (j_sg_cpu->util_dl == 0)
> +				continue;
>  		}
> +
>  		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
>  			return policy->cpuinfo.max_freq;
>  
> -- 
> 2.11.0
> 
