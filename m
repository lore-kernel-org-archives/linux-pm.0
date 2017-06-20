From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] drivers base/arch_topology: frequency-invariant
 load-tracking support
Date: Tue, 20 Jun 2017 11:47:18 +0530
Message-ID: <CAOh2x=k1Zr15vAq8LA0+Sg3Cz7o=dL5C-erkEx_py7g56b7BwA@mail.gmail.com>
References: <20170608075513.12475-1-dietmar.eggemann@arm.com> <20170608075513.12475-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35452 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdFTGRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 02:17:20 -0400
In-Reply-To: <20170608075513.12475-3-dietmar.eggemann@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaor.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On Thu, Jun 8, 2017 at 1:25 PM, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c

>  static int
>  init_cpu_capacity_callback(struct notifier_block *nb,
> @@ -185,6 +192,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
>                                cpus_to_visit,
>                                policy->related_cpus);
>                 for_each_cpu(cpu, policy->related_cpus) {
> +                       per_cpu(max_freq, cpu) = policy->cpuinfo.max_freq;

I am not sure about this but why shouldn't we use policy->max here ?
As that is the
max, we can set the frequency to right now.

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

Any specific reason on why are we doing this from PRECHANGE and
not POSTCHANGE ? i.e. we are doing this before the frequency is
really updated.

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

Wanted to make sure that we all understand the constraints this is going to add
for the ARM64 platforms.

With the introduction of this transition notifier, we would not be able to use
the fast-switch path in the schedutil governor. I am not sure if there are any
ARM platforms that can actually use the fast-switch path in future or not
though. The requirement of fast-switch path is that the freq can be changed
without sleeping in the hot-path.

So, will we ever want fast-switching for ARM platforms ?

--
viresh
