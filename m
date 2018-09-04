From: Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v4 14/16] sched/core: uclamp: request CAP_SYS_ADMIN by
 default
Date: Tue, 4 Sep 2018 15:47:48 +0200
Message-ID: <20180904134748.GA4974@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-15-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-15-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 28/08/18 14:53, Patrick Bellasi wrote:
> The number of clamp groups supported is limited and defined at compile
> time. However, a malicious user can currently ask for many different

Even if not malicious.. :-)

> clamp values thus consuming all the available clamp groups.
> 
> Since on properly configured systems we expect only a limited set of
> different clamp values, the previous problem can be mitigated by
> allowing access to clamp groups configuration only to privileged tasks.
> This should still allow a System Management Software to properly
> pre-configure the system.
> 
> Let's restrict the tuning of utilization clamp values, by default, to
> tasks with CAP_SYS_ADMIN capabilities.
> 
> Whenever this should be considered too restrictive and/or not required
> for a specific platforms, a kernel boot option is provided to change
> this default behavior thus allowing non privileged tasks to change their
> utilization clamp values.
> 
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Quentin Perret <quentin.perret@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> 
> ---
> Changes in v4:
>  Others:
>  - new patch added in this version
>  - rebased on v4.19-rc1
> ---
>  .../admin-guide/kernel-parameters.txt         |  3 +++
>  kernel/sched/core.c                           | 22 ++++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9871e649ffef..481f8214ea9a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4561,6 +4561,9 @@
>  			<port#>,<js1>,<js2>,<js3>,<js4>,<js5>,<js6>,<js7>
>  			See also Documentation/input/devices/joystick-parport.rst
>  
> +	uclamp_user	[KNL] Enable task-specific utilization clamping tuning
> +			also from tasks without CAP_SYS_ADMIN capability.
> +
>  	udbg-immortal	[PPC] When debugging early kernel crashes that
>  			happen after console_init() and before a proper
>  			console driver takes over, this boot options might
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 222397edb8a7..8341ce580a9a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1510,14 +1510,29 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
>  static inline void free_uclamp_sched_group(struct task_group *tg) { }
>  #endif /* CONFIG_UCLAMP_TASK_GROUP */
>  
> +static bool uclamp_user_allowed __read_mostly;
> +static int __init uclamp_user_allow(char *str)
> +{
> +	uclamp_user_allowed = true;
> +
> +	return 0;
> +}
> +early_param("uclamp_user", uclamp_user_allow);
> +
>  static inline int __setscheduler_uclamp(struct task_struct *p,
> -					const struct sched_attr *attr)
> +					const struct sched_attr *attr,
> +					bool user)

Wondering if you want to fold the check below inside the

 if (user && !capable(CAP_SYS_NICE)) {
   ...
 }

block. It would also save you from adding another parameter to the
function.

>  {
>  	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
>  	int lower_bound, upper_bound;
>  	struct uclamp_se *uc_se;
>  	int result = 0;
>  
> +	if (!capable(CAP_SYS_ADMIN) &&
> +	    user && !uclamp_user_allowed) {
> +		return -EPERM;
> +	}
> +

Best,

- Juri
