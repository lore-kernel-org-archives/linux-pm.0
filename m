From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 05/14] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Date: Wed, 8 Aug 2018 15:18:59 +0200
Message-ID: <CAKfTPtC2adLupg7wy1JU9zxKx1466Sza6fSCcr92wcawm1OYkg@mail.gmail.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com> <20180806163946.28380-6-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806163946.28380-6-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, viresh kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Mon, 6 Aug 2018 at 18:40, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>

> @@ -222,8 +222,13 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)

>         util = cpu_util_cfs(rq);
> +       if (util)
> +               util = uclamp_util(cpu_of(rq), util);
>         util += cpu_util_rt(rq);
>
>         /*

> @@ -322,11 +328,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,

> +       max_boost = sg_cpu->iowait_boost_max;
> +       if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
> +               max_boost = uclamp_util(sg_cpu->cpu, max_boost);
> +

> +static inline unsigned int uclamp_value(unsigned int cpu, int clamp_id)
> +{
> +       struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
> +
> +       if (uc_cpu->value[clamp_id] == UCLAMP_NOT_VALID)
> +               return uclamp_none(clamp_id);
> +
> +       return uc_cpu->value[clamp_id];
> +}
> +

> +static inline unsigned int uclamp_util(unsigned int cpu, unsigned int util)

using struct *rq rq instead of cpu as parameter would align
uclamp_util() interface with other cpu_util_*() interface and remove
some cpu_of(rq) and  cpu_rq(cpu)
> +{
> +       unsigned int min_util = uclamp_value(cpu, UCLAMP_MIN);
> +       unsigned int max_util = uclamp_value(cpu, UCLAMP_MAX);
> +
> +       return clamp(util, min_util, max_util);
> +}
