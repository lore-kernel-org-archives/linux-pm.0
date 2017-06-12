From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Mon, 12 Jun 2017 16:27:30 +0200
Message-ID: <CAKfTPtDB=5mQnJfzES+iU-nmNjVDM48f_iKuc7WefkRVWW4JOQ@mail.gmail.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com> <20170608075513.12475-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36831 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdFLO1x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2017 10:27:53 -0400
Received: by mail-lf0-f45.google.com with SMTP id o83so51795497lff.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2017 07:27:52 -0700 (PDT)
In-Reply-To: <20170608075513.12475-3-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, LAK <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On 8 June 2017 at 09:55, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> Implements an arch-specific frequency-scaling function
> topology_get_freq_scale() which provides the following frequency
> scaling factor:
>
>   current_freq(cpu) << SCHED_CAPACITY_SHIFT / max_supported_freq(cpu)
>
> The debug output in init_cpu_capacity_callback() has been changed to be
> able to distinguish whether cpu capacity and max frequency or only max
> frequency has been set. The latter case happens on systems where there
> is no or broken cpu capacity binding (cpu node property
> capacity-dmips-mhz) information.
>
> One possible consumer of this is the Per-Entity Load Tracking (PELT)
> mechanism of the task scheduler.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Juri Lelli <juri.lelli@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  drivers/base/arch_topology.c  | 52 ++++++++++++++++++++++++++++++++++++++++---
>  include/linux/arch_topology.h |  2 ++
>  2 files changed, 51 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 272831c89feb..f6f14670bdab 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -24,12 +24,18 @@
>
>  static DEFINE_MUTEX(cpu_scale_mutex);
>  static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> +static DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>
>  unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
>  {
>         return per_cpu(cpu_scale, cpu);
>  }
>
> +unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu)
> +{
> +       return per_cpu(freq_scale, cpu);
> +}
> +
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity)
>  {
>         per_cpu(cpu_scale, cpu) = capacity;
> @@ -164,6 +170,7 @@ static cpumask_var_t cpus_to_visit;
>  static bool cap_parsing_done;
>  static void parsing_done_workfn(struct work_struct *work);
>  static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
> +static DEFINE_PER_CPU(unsigned long, max_freq);
>
>  static int
>  init_cpu_capacity_callback(struct notifier_block *nb,
> @@ -185,6 +192,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>                                cpus_to_visit,
>                                policy->related_cpus);
>                 for_each_cpu(cpu, policy->related_cpus) {
> +                       per_cpu(max_freq, cpu) = policy->cpuinfo.max_freq;
>                         if (cap_parsing_failed)
>                                 continue;
>                         raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
> @@ -195,8 +203,10 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>                         if (!cap_parsing_failed) {
>                                 topology_normalize_cpu_scale();
>                                 kfree(raw_capacity);
> +                               pr_debug("cpu_capacity: parsing done\n");
> +                       } else {
> +                               pr_debug("cpu_capacity: max frequency parsing done\n");
>                         }
> -                       pr_debug("cpu_capacity: parsing done\n");
>                         cap_parsing_done = true;
>                         schedule_work(&parsing_done_work);
>                 }
> @@ -208,8 +218,38 @@ static struct notifier_block init_cpu_capacity_notifier = {
>         .notifier_call = init_cpu_capacity_callback,
>  };
>
> +static void set_freq_scale(unsigned int cpu, unsigned long freq)
> +{
> +       unsigned long max = per_cpu(max_freq, cpu);
> +
> +       if (!max)
> +               return;
> +
> +       per_cpu(freq_scale, cpu) = (freq << SCHED_CAPACITY_SHIFT) / max;
> +}
> +
> +static int set_freq_scale_callback(struct notifier_block *nb,
> +                                  unsigned long val,
> +                                  void *data)
> +{
> +       struct cpufreq_freqs *freq = data;
> +
> +       switch (val) {
> +       case CPUFREQ_PRECHANGE:
> +               set_freq_scale(freq->cpu, freq->new);
> +       }
> +
> +       return 0;
> +}
> +
> +static struct notifier_block set_freq_scale_notifier = {
> +       .notifier_call = set_freq_scale_callback,
> +};
> +
>  static int __init register_cpufreq_notifier(void)
>  {
> +       int ret;
> +
>         /*
>          * on ACPI-based systems we need to use the default cpu capacity
>          * until we have the necessary code to parse the cpu capacity, so
> @@ -225,8 +265,14 @@ static int __init register_cpufreq_notifier(void)
>
>         cpumask_copy(cpus_to_visit, cpu_possible_mask);
>
> -       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
> -                                        CPUFREQ_POLICY_NOTIFIER);
> +       ret = cpufreq_register_notifier(&init_cpu_capacity_notifier,
> +                                       CPUFREQ_POLICY_NOTIFIER);
> +
> +       if (ret)

Don't you have to free memory allocated for cpus_to_visit in case of
errot ? it was not done before your patch as well

> +               return ret;
> +
> +       return cpufreq_register_notifier(&set_freq_scale_notifier,
> +                                        CPUFREQ_TRANSITION_NOTIFIER);

Don't you have to unregister the other cpufreq notifier if an error is
returned and free the mem allocated for cpus_to_visit ?

>  }
>  core_initcall(register_cpufreq_notifier);
>
> diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> index 9af3c174c03a..3fb4d8ccb179 100644
> --- a/include/linux/arch_topology.h
> +++ b/include/linux/arch_topology.h
> @@ -12,6 +12,8 @@ int topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu);
>  struct sched_domain;
>  unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu);
>
> +unsigned long topology_get_freq_scale(struct sched_domain *sd, int cpu);
> +
>  void topology_set_cpu_scale(unsigned int cpu, unsigned long capacity);
>
>  #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
> --
> 2.11.0
>
