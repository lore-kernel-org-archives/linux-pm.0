From: Ricky Liang <jcliang@chromium.org>
Subject: Re: [RFCv7 PATCH 04/10] sched/fair: add triggers for OPP change requests
Date: Tue, 1 Mar 2016 14:51:12 +0800
Message-ID: <CAAJzSMcf69vWKWYR09cp8e11D0dYRDmVm91ietfshy3UgmMEiA@mail.gmail.com>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
	<1456190570-4475-5-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456190570-4475-5-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Steve,

On Tue, Feb 23, 2016 at 9:22 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> From: Juri Lelli <juri.lelli@arm.com>
>
> Each time a task is {en,de}queued we might need to adapt the current
> frequency to the new usage. Add triggers on {en,de}queue_task_fair() for
> this purpose.  Only trigger a freq request if we are effectively waking up
> or going to sleep.  Filter out load balancing related calls to reduce the
> number of triggers.
>
> [smuckle@linaro.org: resolve merge conflicts, define task_new,
>  use renamed static key sched_freq]
>
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/fair.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3437e01..f1f00a4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4283,6 +4283,21 @@ static inline void hrtick_update(struct rq *rq)
>  }
>  #endif
>
> +static unsigned long capacity_orig_of(int cpu);
> +static int cpu_util(int cpu);
> +
> +static void update_capacity_of(int cpu)
> +{
> +       unsigned long req_cap;
> +
> +       if (!sched_freq())
> +               return;
> +
> +       /* Convert scale-invariant capacity to cpu. */
> +       req_cap = cpu_util(cpu) * SCHED_CAPACITY_SCALE / capacity_orig_of(cpu);
> +       set_cfs_cpu_capacity(cpu, true, req_cap);
> +}
> +

The change hunks of this patch should probably all depend on
CONFIG_SMP as capacity_orig_of() and cpu_util() are only available
when CONFIG_SMP is enabled.

[snip...]

Thanks,
Ricky
