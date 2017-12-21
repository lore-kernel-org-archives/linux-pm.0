From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Thu, 21 Dec 2017 14:45:02 +0530
Message-ID: <20171221091502.GE19815@vireshk-i7>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220154358.663yoodeoxkqghx7@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:39589 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdLUJPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Dec 2017 04:15:05 -0500
Received: by mail-pf0-f172.google.com with SMTP id l24so13726962pfj.6
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2017 01:15:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171220154358.663yoodeoxkqghx7@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 20-12-17, 16:43, Peter Zijlstra wrote:
> The below makes more sense to me too; hmm?
> 
> @@ -335,12 +335,11 @@ static unsigned int sugov_next_freq_shar
>  
>  		j_max = j_sg_cpu->max;
>  		j_util = sugov_aggregate_util(j_sg_cpu);
> +		sugov_iowait_boost(j_sg_cpu, &util, &max);
>  		if (j_util * max > j_max * util) {
>  			util = j_util;
>  			max = j_max;
>  		}
> -
> -		sugov_iowait_boost(j_sg_cpu, &util, &max);

Sorry if I am being a fool here, I had 3 different interpretations of
the results after this change in the last 15 minutes. It was confusing
for somehow..

Why do you think above change matters ? I think nothing changed after
this diff at all.

We have three different values here:

util/max, j_util/j_max, and j_boost_util/j_boost_max.

And we are trying to find the max among them and changing the order of
comparisons doesn't change anything.

Am I reading the code correctly ?

-- 
viresh
