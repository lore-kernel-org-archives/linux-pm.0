From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Wed, 20 Dec 2017 16:43:58 +0100
Message-ID: <20171220154358.663yoodeoxkqghx7@hirez.programming.kicks-ass.net>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:38683 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754664AbdLTPoE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 10:44:04 -0500
Content-Disposition: inline
In-Reply-To: <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On Wed, Dec 20, 2017 at 04:30:29PM +0100, Peter Zijlstra wrote:
> @@ -314,6 +315,9 @@ static unsigned int sugov_next_freq_shar
>  		unsigned long j_util, j_max;
>  		s64 delta_ns;
>  
> +		if (j_sg_cpu != sg_cpu)
> +			sugov_get_util(j_sg_cpu);
> +
>  		/*
>  		 * If the CFS CPU utilization was last updated before the
>  		 * previous frequency update and the time elapsed between the
> @@ -327,12 +331,7 @@ static unsigned int sugov_next_freq_shar
>  		if (delta_ns > TICK_NSEC) {
>  			j_sg_cpu->iowait_boost = 0;
>  			j_sg_cpu->iowait_boost_pending = false;
> -			j_sg_cpu->util_cfs = 0;
> -			if (j_sg_cpu->util_dl == 0)
> -				continue;
>  		}
> -		if (j_sg_cpu->flags & SCHED_CPUFREQ_RT)
> -			return policy->cpuinfo.max_freq;
>  
>  		j_max = j_sg_cpu->max;
>  		j_util = sugov_aggregate_util(j_sg_cpu);

The below makes more sense to me too; hmm?

@@ -335,12 +335,11 @@ static unsigned int sugov_next_freq_shar
 
 		j_max = j_sg_cpu->max;
 		j_util = sugov_aggregate_util(j_sg_cpu);
+		sugov_iowait_boost(j_sg_cpu, &util, &max);
 		if (j_util * max > j_max * util) {
 			util = j_util;
 			max = j_max;
 		}
-
-		sugov_iowait_boost(j_sg_cpu, &util, &max);
 	}
 
 	return get_next_freq(sg_policy, util, max);
