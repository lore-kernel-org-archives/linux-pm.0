From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] cpufreq: schedutil: remove redundant code from sugov_next_freq_shared()
Date: Wed, 8 Mar 2017 13:54:30 +0100
Message-ID: <CAJZ5v0iV0Ltj98ieChRfU7JyFF9fSZJj_OUc6T6aYQt6KvTpkQ@mail.gmail.com>
References: <cover.1488437503.git.viresh.kumar@linaro.org> <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org>
 <1772276.4tCnP8C0XV@aspire.rjw.lan> <1668614.4zDQWLsnmH@aspire.rjw.lan>
 <20170306044553.GE8206@vireshk-i7> <CAJZ5v0hov8Lz_MK9dxP9MyqSmPNRfWV9Wia4DtAZtOPmoTOqAw@mail.gmail.com>
 <20170307103108.GA4526@vireshk-i7> <CAJZ5v0itZo-tybgz2p49VxkGzFL9EZBB-4aZg6R5sthVrBiAYQ@mail.gmail.com>
 <20170308041823.GB4526@vireshk-i7> <CAJZ5v0jyX8DashfzBPmLxwRDqQsA_QK4OR=g7-R=jERyfOqAcw@mail.gmail.com>
 <20170308111539.GA3062@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170308111539.GA3062@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 8, 2017 at 12:15 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-03-17, 11:50, Rafael J. Wysocki wrote:
>> So overall, maybe you can move the flags check to
>> sugov_update_shared(), so that you don't need to pass flags to
>> sugov_next_freq_shared(), and then do what you did to util and max.
>
> Just to confirm, below is what you are suggesting ?

Yes, it is.

> -------------------------8<-------------------------
>
>  1 file changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 78468aa051ab..f5ffe241812e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -217,30 +217,19 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         sugov_update_commit(sg_policy, time, next_f);
>  }
>
> -static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
> -                                          unsigned long util, unsigned long max,
> -                                          unsigned int flags)
> +static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
>  {
>         struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>         struct cpufreq_policy *policy = sg_policy->policy;
> -       unsigned int max_f = policy->cpuinfo.max_freq;
>         u64 last_freq_update_time = sg_policy->last_freq_update_time;
> +       unsigned long util = 0, max = 1;
>         unsigned int j;
>
> -       if (flags & SCHED_CPUFREQ_RT_DL)
> -               return max_f;
> -
> -       sugov_iowait_boost(sg_cpu, &util, &max);
> -
>         for_each_cpu(j, policy->cpus) {
> -               struct sugov_cpu *j_sg_cpu;
> +               struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
>                 unsigned long j_util, j_max;
>                 s64 delta_ns;
>
> -               if (j == smp_processor_id())
> -                       continue;
> -
> -               j_sg_cpu = &per_cpu(sugov_cpu, j);
>                 /*
>                  * If the CPU utilization was last updated before the previous
>                  * frequency update and the time elapsed between the last update
> @@ -254,7 +243,7 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu,
>                         continue;
>                 }
>                 if (j_sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
> -                       return max_f;
> +                       return policy->cpuinfo.max_freq;
>
>                 j_util = j_sg_cpu->util;
>                 j_max = j_sg_cpu->max;
> @@ -289,7 +278,11 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>         sg_cpu->last_update = time;
>
>         if (sugov_should_update_freq(sg_policy, time)) {
> -               next_f = sugov_next_freq_shared(sg_cpu, util, max, flags);
> +               if (flags & SCHED_CPUFREQ_RT_DL)
> +                       next_f = sg_policy->policy->cpuinfo.max_freq;
> +               else
> +                       next_f = sugov_next_freq_shared(sg_cpu);
> +
>                 sugov_update_commit(sg_policy, time, next_f);
>         }
>
>> But that would be a 4.12 change anyway.
>
> Sure.

And IMO the subject/changelog should not talk about "redundant code",
because the code in question is not in fact redundant, but about
refactoring the code to eliminate one conditional from the
for_each_cpu() loop and to make that loop treat all CPUs in the same
way (more symmetrically).

Thanks,
Rafael
