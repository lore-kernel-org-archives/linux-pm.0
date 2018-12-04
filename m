From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 5/7] sched/fair: Enable CFS periodic tick to update
 thermal pressure
Date: Tue, 4 Dec 2018 16:43:58 +0100
Message-ID: <CAKfTPtB18Fh3neT7d6m0fgthE6Zo0am4i9WQ9OriD3FCuZgrRw@mail.gmail.com>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org> <1539102302-9057-6-git-send-email-thara.gopinath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539102302-9057-6-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thara Gopinath <thara.gopinath@linaro.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Zhang Rui <rui.zhang@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Amit Kachhap <amit.kachhap@gmail.com>, viresh kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Quentin Perret <quentin.perret@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Thara,

On Tue, 9 Oct 2018 at 18:25, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> Introduce support in CFS periodic tick to trigger the process of
> computing average thermal pressure for a cpu.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b39fb59..7deb1d0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -21,6 +21,7 @@
>   *  Copyright (C) 2007 Red Hat, Inc., Peter Zijlstra
>   */
>  #include "sched.h"
> +#include "thermal.h"
>
>  #include <trace/events/sched.h>
>
> @@ -9557,6 +9558,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>
>         if (static_branch_unlikely(&sched_numa_balancing))
>                 task_tick_numa(rq, curr);
> +
> +       update_periodic_maxcap(rq);

You have to call update_periodic_maxcap() in update_blocked_averages() too
Otherwise, the thermal pressure will not always be updated correctly
for tickless system

>  }
>
>  /*
> --
> 2.1.4
>
