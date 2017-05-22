From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Set default policy->transition_delay_ns
Date: Mon, 22 May 2017 16:57:27 +0530
Message-ID: <20170522112727.GI6510@vireshk-i7>
References: <16157eb75bb26cca73a0da930e49f2549b96fd65.1495429745.git.viresh.kumar@linaro.org>
 <87h90d2mqm.fsf@arm.com>
 <20170522105522.GG6510@vireshk-i7>
 <20170522111738.GB9325@leoy-ThinkPad-T440>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32803 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdEVL1a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 May 2017 07:27:30 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so79716151pfh.0
        for <linux-pm@vger.kernel.org>; Mon, 22 May 2017 04:27:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170522111738.GB9325@leoy-ThinkPad-T440>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Brendan Jackman <brendan.jackman@arm.com>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>

On 22-05-17, 19:17, Leo Yan wrote:
> This afternoon Amit pointed me for this patch, should fix as below?
> Otherwise it seems directly assign the same value from unit 'ns' to
> 'us' but without any value conversion.
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 76877a6..dcc90fc 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -538,7 +538,7 @@ static int sugov_init(struct cpufreq_policy *policy)
>                 unsigned int lat;
>  
>                 tunables->rate_limit_us = LATENCY_MULTIPLIER;
> -               lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> +               lat = policy->cpuinfo.transition_latency / NSEC_PER_MSEC;
>                 if (lat)
>                         tunables->rate_limit_us *= lat;
>         }

I will let Rafael comment in as well. NSEC_PER_USEC is used in the
earlier governors as well (ondemand/conservative) in exactly the same
way as schedutil is using.

-- 
viresh
