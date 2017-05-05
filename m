From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] sched/cpufreq_schedutil: use now as reference when
 aggregating shared policy requests
Date: Fri, 5 May 2017 11:36:37 +0530
Message-ID: <20170505060637.GA5892@vireshk-i7>
References: <20170503133048.8742-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34917 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755110AbdEEGGl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 May 2017 02:06:41 -0400
Received: by mail-pg0-f50.google.com with SMTP id o3so3800491pgn.2
        for <linux-pm@vger.kernel.org>; Thu, 04 May 2017 23:06:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170503133048.8742-1-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, peterz@infradead.org, vincent.guittot@linaro.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On 03-05-17, 14:30, Juri Lelli wrote:
> Currently, sugov_next_freq_shared() uses last_freq_update_time as a
> reference to decide when to start considering CPU contributions as
> stale.
> 
> However, since last_freq_update_time is set by the last CPU that issued
> a frequency transition, this might cause problems in certain cases. In
> practice, the detection of stale utilization values fails whenever the
> CPU with such values was the last to update the policy. For example (and
> please note again that the SCHED_CPUFREQ_RT flag is not the problem
> here, but only the detection of after how much time that flag has to be
> considered stale), suppose a policy with 2 CPUs:
> 
>                CPU0                |               CPU1
>                                    |
>                                    |     RT task scheduled
>                                    |     SCHED_CPUFREQ_RT is set
>                                    |     CPU1->last_update = now
>                                    |     freq transition to max
>                                    |     last_freq_update_time = now
>                                    |
> 
>                         more than TICK_NSEC nsecs
> 
>                                    |
>      a small CFS wakes up          |
>      CPU0->last_update = now1      |
>      delta_ns(CPU0) < TICK_NSEC*   |
>      CPU0's util is considered     |
>      delta_ns(CPU1) =              |
>       last_freq_update_time -      |
>       CPU1->last_update = 0        |
>       < TICK_NSEC                  |
>      CPU1 is still considered      |
>      CPU1->SCHED_CPUFREQ_RT is set |
>      we stay at max (until CPU1    |
>      exits from idle)              |
> 
> * delta_ns is actually negative as now1 > last_freq_update_time
> 
> While last_freq_update_time is a sensible reference for rate limiting,
> it doesn't seem to be useful for working around stale CPU states.
> 
> Fix the problem by always considering now (time) as the reference for
> deciding when CPUs have stale contributions.
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  kernel/sched/cpufreq_schedutil.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
