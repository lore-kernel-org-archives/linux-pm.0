From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 01/12] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Date: Tue, 17 Jul 2018 11:04:34 -0700
Message-ID: <20180717180434.GB150378@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716082906.6061-2-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2018 at 09:28:55AM +0100, Patrick Bellasi wrote:
> The SCHED_DEADLINE scheduling class provides an advanced and formal
> model to define tasks requirements which can be translated into proper
> decisions for both task placements and frequencies selections.
> Other classes have a more simplified model which is essentially based on
> the relatively simple concept of POSIX priorities.
> 
> Such a simple priority based model however does not allow to exploit
> some of the most advanced features of the Linux scheduler like, for
> example, driving frequencies selection via the schedutil cpufreq
> governor. However, also for non SCHED_DEADLINE tasks, it's still
> interesting to define tasks properties which can be used to better
> support certain scheduler decisions.
> 
> Utilization clamping aims at exposing to user-space a new set of
> per-task attributes which can be used to provide the scheduler with some
> hints about the expected/required utilization for a task.
> This will allow to implement a more advanced per-task frequency control
> mechanism which is not based just on a "passive" measured task
> utilization but on a more "active" approach. For example, it could be
> possible to boost interactive tasks, thus getting better performance, or
> cap background tasks, thus being more energy efficient.
> Ultimately, such a mechanism can be considered similar to the cpufreq's
> powersave, performance and userspace governor but with a much fine
> grained and per-task control.
> 
> Let's introduce a new API to set utilization clamping values for a
> specified task by extending sched_setattr, a syscall which already
> allows to define task specific properties for different scheduling
> classes.
> Specifically, a new pair of attributes allows to specify a minimum and
> maximum utilization which the scheduler should consider for a task.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  include/linux/sched.h            | 16 ++++++++
>  include/uapi/linux/sched.h       |  4 +-
>  include/uapi/linux/sched/types.h | 64 +++++++++++++++++++++++++++-----
>  init/Kconfig                     | 19 ++++++++++
>  kernel/sched/core.c              | 39 +++++++++++++++++++
>  5 files changed, 132 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 43731fe51c97..fd8495723088 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -279,6 +279,17 @@ struct vtime {
>  	u64			gtime;
>  };
>  
> +enum uclamp_id {
> +	/* No utilization clamp group assigned */
> +	UCLAMP_NONE = -1,
> +
> +	UCLAMP_MIN = 0, /* Minimum utilization */
> +	UCLAMP_MAX,     /* Maximum utilization */
> +
> +	/* Utilization clamping constraints count */
> +	UCLAMP_CNT
> +};
> +
>  struct sched_info {
>  #ifdef CONFIG_SCHED_INFO
>  	/* Cumulative counters: */
> @@ -649,6 +660,11 @@ struct task_struct {
>  #endif
>  	struct sched_dl_entity		dl;
>  
> +#ifdef CONFIG_UCLAMP_TASK
> +	/* Utlization clamp values for this task */
> +	int				uclamp[UCLAMP_CNT];
> +#endif

Seems a bit wasteful to me. Seems you need 2 values that are in the range
0..1024.  Can we not do better with task_struct space usage?

thanks!

 - Joel
