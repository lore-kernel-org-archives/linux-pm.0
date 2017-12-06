From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 1/4] sched/fair: always used unsigned long for utilization
Date: Wed, 6 Dec 2017 09:56:34 +0100
Message-ID: <CAKfTPtCmMFPWP6XtngGujfL+b4hw0LHkX_A9K+_P=CMnzaazBw@mail.gmail.com>
References: <20171205171018.9203-1-patrick.bellasi@arm.com> <20171205171018.9203-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:44645 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753961AbdLFI4z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Dec 2017 03:56:55 -0500
Received: by mail-it0-f68.google.com with SMTP id b5so6337581itc.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2017 00:56:55 -0800 (PST)
In-Reply-To: <20171205171018.9203-2-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

On 5 December 2017 at 18:10, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Utilization and capacity are tracked as unsigned long, however some
> functions using them return an int which is ultimately assigned back to
> unsigned long variables.
>
> Since there is not scope on using a different and signed type, this
> consolidate the signature of functions returning utilization to always
> use the native type.
> As well as improving code consistency this is expected also benefits
> code paths where utilizations should be clamped by avoiding further type
> conversions or ugly type casts.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Chris Redpath <chris.redpath@arm.com>
> Reviewed-by: Brendan Jackman <brendan.jackman@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> ---
> Changes v1->v2:
>  - rebase on top of v4.15-rc2
>  - tested that overhauled PELT code does not affect the util_est
> ---
>  kernel/sched/fair.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4037e19bbca2..ad21550d008c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5721,8 +5721,8 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>         return affine;
>  }
>
> -static inline int task_util(struct task_struct *p);
> -static int cpu_util_wake(int cpu, struct task_struct *p);
> +static inline unsigned long task_util(struct task_struct *p);
> +static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
>
>  static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
>  {
> @@ -6203,7 +6203,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * capacity_orig) as it useful for predicting the capacity required after task
>   * migrations (scheduler-driven DVFS).
>   */
> -static int cpu_util(int cpu)
> +static unsigned long cpu_util(int cpu)
>  {
>         unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
>         unsigned long capacity = capacity_orig_of(cpu);
> @@ -6211,7 +6211,7 @@ static int cpu_util(int cpu)
>         return (util >= capacity) ? capacity : util;
>  }
>
> -static inline int task_util(struct task_struct *p)
> +static inline unsigned long task_util(struct task_struct *p)
>  {
>         return p->se.avg.util_avg;
>  }
> @@ -6220,7 +6220,7 @@ static inline int task_util(struct task_struct *p)
>   * cpu_util_wake: Compute cpu utilization with any contributions from
>   * the waking task p removed.
>   */
> -static int cpu_util_wake(int cpu, struct task_struct *p)
> +static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
>  {
>         unsigned long util, capacity;
>
> --
> 2.14.1
>
