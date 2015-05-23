From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: Fix compiler errors for NO_SMP machines
Date: Sat, 23 May 2015 16:52:23 +0200
Message-ID: <20150523145223.GA16405@gmail.com>
References: <1431459549-18343-26-git-send-email-morten.rasmussen@arm.com>
 <1432324094-29573-1-git-send-email-abelvesa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33454 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757881AbbEWOw2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 May 2015 10:52:28 -0400
Content-Disposition: inline
In-Reply-To: <1432324094-29573-1-git-send-email-abelvesa@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abel Vesa <abelvesa@gmail.com>
Cc: morten.rasmussen@arm.com, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, Dietmar.Eggemann@arm.com, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri.Lelli@arm.com, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


* Abel Vesa <abelvesa@gmail.com> wrote:

> Trivial fixes forh machines without SMP.
> 
> Signed-off-by: Abel Vesa <abelvesa@gmail.com>
> ---
>  kernel/sched/fair.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e6d32e6..dae3db7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -672,6 +672,8 @@ static unsigned long task_h_load(struct task_struct *p);
>  static inline void __update_task_entity_contrib(struct sched_entity *se);
>  static inline void __update_task_entity_utilization(struct sched_entity *se);
>  
> +static bool cpu_overutilized(int cpu);
> +
>  /* Give new task start runnable values to heavy its load in infant time */
>  void init_task_runnable_average(struct task_struct *p)
>  {
> @@ -4266,8 +4268,6 @@ static inline void hrtick_update(struct rq *rq)
>  }
>  #endif
>  
> -static bool cpu_overutilized(int cpu);
> -

What tree is this against? Neither the upstream kernel nor 
tip:sched/core (the scheduler development tree) has this function.

Thanks,

	Ingo
