From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/cpufreq_schedutil: use now as reference when
 aggregating shared policy requests
Date: Thu, 4 May 2017 16:41:28 +0200
Message-ID: <CAKfTPtBD+46p+AcL9kMjZu3rOexcuVVqCcKdAxoKmjWfatjz9g@mail.gmail.com>
References: <20170503133048.8742-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170503133048.8742-1-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, viresh kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 3 May 2017 at 15:30, Juri Lelli <juri.lelli@arm.com> wrote:
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

FWIW

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
