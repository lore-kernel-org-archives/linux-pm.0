From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Thu, 18 Feb 2016 21:22:37 +0100
Message-ID: <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<2044559.7ypXocW9OZ@vostro.rjw.lan>
	<3499355.2JlaSruvOa@vostro.rjw.lan>
	<16016177.YFqb4gVNBo@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <16016177.YFqb4gVNBo@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Introduce a mechanism by which parts of the cpufreq subsystem
> ("setpolicy" drivers or the core) can register callbacks to be
> executed from cpufreq_update_util() which is invoked by the
> scheduler's update_load_avg() on CPU utilization changes.
>
> This allows the "setpolicy" drivers to dispense with their timers
> and do all of the computations they need and frequency/voltage
> adjustments in the update_load_avg() code path, among other things.
>
> The update_load_avg() changes were suggested by Peter Zijlstra.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>
> Changes from v9:
> - Move the additional RT/DL hooks back to update_curr_rt/dl() (Peter says
>   that's OK), but only call them if updating the current CPU's rq, update
>   the cpufreq_trigger_update() kerneldoc.
>
> Changes from v8:
> - Peter thinks that cpufreq hooks in update_curr_rt/dl() are overkill so
>   move them to task_tick_rt/dl() and enqueue_task_rt/dl() (in case RT/DL
>   tasks are only active between ticks), update the cpufreq_trigger_update()
>   kerneldoc.
>
> Changes from v7
> - cpufreq_trigger_update() has a kerneldoc describing it as a band-aid to
>   be replaced in the future and the comments next to its call sites ask
>   the reader to see that comment.
>
>   No functional changes.
>
> Changes from v6:
> - Steve suggested to use rq_clock() instead of rq_clock_task() as the time
>   argument for cpufreq_update_util() as that seems to be more suitable for
>   this purpose.
>
> ---
>  drivers/cpufreq/cpufreq.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h   |   34 ++++++++++++++++++++++++++++++++++
>  kernel/sched/deadline.c   |    4 ++++
>  kernel/sched/fair.c       |   26 +++++++++++++++++++++++++-
>  kernel/sched/rt.c         |    4 ++++
>  kernel/sched/sched.h      |    1 +
>  6 files changed, 113 insertions(+), 1 deletion(-)

So if anyone has any issues with this one, please let me know.

It has been in linux-next for a few days and seems to be doing well.

As I said previously, there is a metric ton of cpufreq improvements
depending on it, so I'd rather not delay integrating it any more.

Thanks,
Rafael
