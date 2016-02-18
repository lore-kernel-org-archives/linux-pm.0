From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] intel_pstate: Increase hold-off time before busyness
 is scaled
Date: Thu, 18 Feb 2016 20:43:17 +0100
Message-ID: <CAJZ5v0hSLJRkOKQ0UvJsSs0o-NuHiE+gOnC+f0q8vQtciABP2Q@mail.gmail.com>
References: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455793883-14214-1-git-send-email-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Matt Fleming <matt@codeblueprint.co.uk>, Mike Galbraith <umgwanakikbuti@gmail.com>, Linux-PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mel,

On Thu, Feb 18, 2016 at 12:11 PM, Mel Gorman
<mgorman@techsingularity.net> wrote:

[cut]

>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index cd83d477e32d..54250084174a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -999,7 +999,7 @@ static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu)
>         sample_time = pid_params.sample_rate_ms  * USEC_PER_MSEC;
>         duration_us = ktime_us_delta(cpu->sample.time,
>                                      cpu->last_sample_time);
> -       if (duration_us > sample_time * 3) {
> +       if (duration_us > sample_time * 12) {
>                 sample_ratio = div_fp(int_tofp(sample_time),
>                                       int_tofp(duration_us));
>                 core_busy = mul_fp(core_busy, sample_ratio);
> --

I've been considering making a change like this, but I wasn't quite
sure how much greater the multiplier should be, so I've queued this
one up for 4.6.

That said please note that we're planning to make one significant
change to intel_pstate in the 4.6 cycle that's very likely to affect
your results.

It is currently present in linux-next (commit 402c43ed2d74 "cpufreq:
intel_pstate: Replace timers with utilization update callbacks" in the
linux-next branch of the linux-pm.git tree, that depends on commit
fe7034338ba0 "cpufreq: Add mechanism for registering utilization
update callbacks" in the same branch).  Also you can just pull from
the pm-cpufreq-test branch in linux-pm.git, but that contains much
more material.

Thanks,
Rafael
