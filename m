From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/2] cpufreq / sched: Pass flags to cpufreq_update_util()
Date: Fri, 19 Aug 2016 15:26:21 +0200
Message-ID: <CAJKOXPdjkO4ZvQ1kijfVCMKaNBaoYDEOZpQ-+ZmyWVpL1jdPpg@mail.gmail.com>
References: <6346523.ZooER3FGDH@vostro.rjw.lan> <2163011.yGXeHau4eM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2163011.yGXeHau4eM@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 12, 2016 at 2:04 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is useful to know the reason why cpufreq_update_util() has just
> been called and that can be passed as flags to cpufreq_update_util()
> and to the ->func() callback in struct update_util_data.  However,
> doing that in addition to passing the util and max arguments they
> already take would be clumsy, so avoid it.
>
> Instead, use the observation that the schedutil governor is part
> of the scheduler proper, so it can access scheduler data directly.
> This allows the util and max arguments of cpufreq_update_util()
> and the ->func() callback in struct update_util_data to be replaced
> with a flags one, but schedutil has to be modified to follow.
>
> Thus make the schedutil governor obtain the CFS utilization
> information from the scheduler and use the "RT" and "DL" flags
> instead of the special utilization value of ULONG_MAX to track
> updates from the RT and DL sched classes.  Make it non-modular
> too to avoid having to export scheduler variables to modules at
> large.
>
> Next, update all of the other users of cpufreq_update_util()
> and the ->func() callback in struct update_util_data accordingly.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> v1 -> v2: Do not check cpu_of(rq) against smp_processor_id() in
>           cfs_rq_util_change().
>
> ---
>  drivers/cpufreq/Kconfig            |    5 --
>  drivers/cpufreq/cpufreq_governor.c |    2 -
>  drivers/cpufreq/intel_pstate.c     |    2 -
>  include/linux/sched.h              |   12 ++++--
>  kernel/sched/cpufreq.c             |    2 -
>  kernel/sched/cpufreq_schedutil.c   |   67 ++++++++++++++++++++-----------------
>  kernel/sched/deadline.c            |    4 +-
>  kernel/sched/fair.c                |   10 +----
>  kernel/sched/rt.c                  |    4 +-
>  kernel/sched/sched.h               |   31 +++++------------
>  10 files changed, 66 insertions(+), 73 deletions(-)

(...)

> --- linux-pm.orig/drivers/cpufreq/Kconfig
> +++ linux-pm/drivers/cpufreq/Kconfig
> @@ -194,7 +194,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
>           If in doubt, say N.
>
>  config CPU_FREQ_GOV_SCHEDUTIL
> -       tristate "'schedutil' cpufreq policy governor"
> +       bool "'schedutil' cpufreq policy governor"

If you change such symbols please remember to update also all the
defconfigs. Without the update they start to show errors.

Best regards,
Krzysztof
