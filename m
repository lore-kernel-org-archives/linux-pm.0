From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sched: Factor out nr_iowait and nr_iowait_cpu
Date: Thu, 4 Oct 2018 09:46:30 +0200
Message-ID: <CAJZ5v0jEGB6iwK5nc3VRNcrPRvoQUk0qRn-W-y6nRTB0uoRTHQ@mail.gmail.com>
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 4, 2018 at 9:42 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The function nr_iowait_cpu() can be used directly by nr_iowait() instead
> of duplicating code.
>
> Call nr_iowait_cpu() from nr_iowait()
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  kernel/sched/core.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc98..b88a145 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2873,6 +2873,24 @@ unsigned long long nr_context_switches(void)
>
>         return sum;
>  }
> +/*
> + * Consumers of these two interfaces, like for example the cpufreq menu
> + * governor are using nonsensical data. Boosting frequency for a CPU that has
> + * IO-wait which might not even end up running the task when it does become
> + * runnable.
> + */
> +
> +unsigned long nr_iowait_cpu(int cpu)
> +{
> +       return atomic_read(&cpu_rq(cpu)->nr_iowait);
> +}
> +
> +void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> +{
> +       struct rq *rq = this_rq();
> +       *nr_waiters = atomic_read(&rq->nr_iowait);
> +       *load = rq->load.weight;
> +}
>
>  /*
>   * IO-wait accounting, and how its mostly bollocks (on SMP).
> @@ -2909,31 +2927,11 @@ unsigned long nr_iowait(void)
>         unsigned long i, sum = 0;
>
>         for_each_possible_cpu(i)
> -               sum += atomic_read(&cpu_rq(i)->nr_iowait);
> +               sum += nr_iowait_cpu(i);
>
>         return sum;
>  }
>
> -/*
> - * Consumers of these two interfaces, like for example the cpufreq menu
> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> - * IO-wait which might not even end up running the task when it does become
> - * runnable.
> - */
> -
> -unsigned long nr_iowait_cpu(int cpu)
> -{
> -       struct rq *this = cpu_rq(cpu);
> -       return atomic_read(&this->nr_iowait);
> -}
> -
> -void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> -{
> -       struct rq *rq = this_rq();
> -       *nr_waiters = atomic_read(&rq->nr_iowait);
> -       *load = rq->load.weight;
> -}
> -
>  #ifdef CONFIG_SMP
>
>  /*
> --
> 2.7.4
>
