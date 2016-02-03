From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 2/6] drivers/cpufreq: implement init_cpu_capacity_default()
Date: Wed, 3 Feb 2016 22:04:37 +0100
Message-ID: <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com> <1454500799-18451-3-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:32943 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbcBCVE7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 16:04:59 -0500
Received: by mail-lf0-f54.google.com with SMTP id m1so23493808lfg.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 13:04:58 -0800 (PST)
In-Reply-To: <1454500799-18451-3-git-send-email-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On 3 February 2016 at 12:59, Juri Lelli <juri.lelli@arm.com> wrote:
> To get default values for CPUs capacity we profile a simple (bogus)
> integer benchmark on such CPUs; then we normalize results to 1024
> (highest capacity in the system).
>
> Architectures that want this during boot have to define a weak function
> (arch_wants_init_cpu_capacity) to return true.
>
> Also, kernel has to boot with init_cpu_capacity parameter if profiling
> is needed, as it can be expensive and might add ~1 sec to boot time.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  Changes since v1:
>  - add kernel command line parameter to enable profiling
>  - add define for max trials
>
>  Documentation/kernel-parameters.txt |   4 +
>  arch/arm/kernel/topology.c          |   2 +-
>  arch/arm64/kernel/topology.c        |  12 +++
>  drivers/cpufreq/Makefile            |   2 +-
>  drivers/cpufreq/cpufreq.c           |   1 +
>  drivers/cpufreq/cpufreq_capacity.c  | 174 ++++++++++++++++++++++++++++++++++++
>  include/linux/cpufreq.h             |   2 +
>  7 files changed, 195 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/cpufreq/cpufreq_capacity.c
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 87d40a7..fad2b89 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1570,6 +1570,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>
>         initrd=         [BOOT] Specify the location of the initial ramdisk
>
> +       init_cpu_capacity
> +                       [KNL,ARM] Enables dynamic CPUs capacity benchmarking
> +                       at boot.
> +
>         inport.irq=     [HW] Inport (ATI XL and Microsoft) busmouse driver
>                         Format: <irq>
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index ec279d1..c9c87a5 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -47,7 +47,7 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
>         return per_cpu(cpu_scale, cpu);
>  }
>
> -static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> +void set_capacity_scale(unsigned int cpu, unsigned long capacity)
>  {
>         per_cpu(cpu_scale, cpu) = capacity;
>  }
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 694f6de..3b75d63 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -23,6 +23,18 @@
>  #include <asm/cputype.h>
>  #include <asm/topology.h>
>
> +static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> +
> +unsigned long arm_arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> +{
> +       return per_cpu(cpu_scale, cpu);
> +}
> +
> +void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> +{
> +       per_cpu(cpu_scale, cpu) = capacity;
> +}
> +
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
>         struct device_node *cpu_node;
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 9e63fb1..c4025fd 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -1,5 +1,5 @@
>  # CPUfreq core
> -obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
> +obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o cpufreq_capacity.o

Do you really want to have the calibration of capacity dependent of
cpufreq ? It means that we can't use it without a cpufreq driver.
IMHO, this creates a unnecessary dependency. I understand that you
must ensure that core runs at max fequency if a driver is present but
you should be able to calibrate the capacity if cpufreq is not
available but you have different capacity because micro architecture

>
>  # CPUfreq stats
>  obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e979ec7..b22afe8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2440,6 +2440,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>         }
>
>         register_hotcpu_notifier(&cpufreq_cpu_notifier);
> +       cpufreq_init_cpu_capacity();
>         pr_debug("driver %s up and running\n", driver_data->name);
>
>  out:
> diff --git a/drivers/cpufreq/cpufreq_capacity.c b/drivers/cpufreq/cpufreq_capacity.c
> new file mode 100644
> index 0000000..e54310b
> --- /dev/null
> +++ b/drivers/cpufreq/cpufreq_capacity.c
> @@ -0,0 +1,174 @@
> +/*
> + * Default CPU capacity calculation for u-arch invariance
> + *
> + * Copyright (C) 2015 ARM Ltd.
> + * Juri Lelli <juri.lelli@arm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/cpufreq.h>
> +#include <linux/sched.h>
> +
> +#define MAX_TRIALS 10 /* how many times benchmark is executed */
> +static unsigned long long elapsed[NR_CPUS];
> +
> +/*
> + * Don't let compiler optimize following two functions; we want to avoid any
> + * microarchitecture specific optimization that compiler would do and favour
> + * one CPU vs. another. Also, my_int_sqrt is cut-and-paste from
> + * lib/int_sqrt.c.
> + */
> +static unsigned long __attribute__((optimize("O0")))
> +my_int_sqrt(unsigned long x)
> +{
> +       unsigned long b, m, y = 0;
> +
> +       if (x <= 1)
> +               return x;
> +
> +       m = 1UL << (BITS_PER_LONG - 2);
> +       while (m != 0) {
> +               b = y + m;
> +               y >>= 1;
> +
> +               if (x >= b) {
> +                       x -= b;
> +                       y += m;
> +               }
> +               m >>= 2;
> +       }
> +
> +       return y;
> +}
> +
> +static unsigned long __attribute__((optimize("O0")))
> +bogus_bench(void)
> +{
> +       unsigned long i, res;
> +
> +       for (i = 0; i < 100000; i++)
> +               res = my_int_sqrt(i);
> +
> +       return res;
> +}
> +
> +static int run_bogus_benchmark(int cpu)
> +{
> +       int ret, trials = MAX_TRIALS;
> +       u64 begin, end, sample, mean = 0, count = 0;
> +       unsigned long res;
> +
> +       ret = set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +       if (ret) {
> +               pr_warn("%s: failed to set allowed ptr\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       while (trials--) {
> +               begin = local_clock();
> +               res = bogus_bench();
> +               end = local_clock();
> +               sample = end - begin;
> +
> +               mean = mean * count + sample;
> +               mean = div64_u64(mean, ++count);
> +               pr_debug("%s: cpu=%d begin=%llu end=%llu"
> +                        " sample=%llu mean=%llu count=%llu res=%lu\n",
> +                       __func__, cpu, begin, end, sample,
> +                       mean, count, res);
> +       }
> +       elapsed[cpu] = mean;
> +
> +       ret = set_cpus_allowed_ptr(current, cpu_active_mask);
> +       if (ret) {
> +               pr_warn("%s: failed to set allowed ptr\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +bool __weak arch_wants_init_cpu_capacity(void)
> +{
> +       return false;
> +}
> +
> +void __weak set_capacity_scale(int cpu, unsigned long capacity) { }
> +
> +static __read_mostly bool init_cpu_capacity_enabled;
> +
> +static int __init init_cpu_capacity_setup(char *str)
> +{
> +       init_cpu_capacity_enabled = true;
> +
> +       return 0;
> +}
> +early_param("init_cpu_capacity", init_cpu_capacity_setup);
> +
> +void cpufreq_init_cpu_capacity(void)
> +{
> +       int cpu, fcpu;
> +       unsigned long long elapsed_min = ULLONG_MAX;
> +       unsigned int curr_min, curr_max;
> +       struct cpufreq_policy *policy;
> +
> +       if (!arch_wants_init_cpu_capacity() || !init_cpu_capacity_enabled)
> +               return;
> +
> +       for_each_possible_cpu(cpu) {
> +               policy = cpufreq_cpu_get(cpu);
> +               if (IS_ERR_OR_NULL(policy))
> +                       return;
> +
> +               /*
> +                * We profile only first CPU of each frequency domain;
> +                * and use that value as capacity of every CPU in the domain.
> +                */
> +               fcpu = cpumask_first(policy->related_cpus);
> +               if (cpu != fcpu) {
> +                       elapsed[cpu] = elapsed[fcpu];
> +                       cpufreq_cpu_put(policy);
> +                       continue;
> +               }
> +
> +               down_write(&policy->rwsem);
> +               curr_min = policy->user_policy.min;
> +               curr_max = policy->user_policy.max;
> +               policy->user_policy.min = policy->cpuinfo.max_freq;
> +               policy->user_policy.max = policy->cpuinfo.max_freq;
> +               up_write(&policy->rwsem);
> +               cpufreq_cpu_put(policy);
> +               cpufreq_update_policy(cpu);
> +
> +               run_bogus_benchmark(cpu);
> +               if (elapsed[cpu] < elapsed_min)
> +                       elapsed_min = elapsed[cpu];
> +               pr_debug("%s: cpu=%d elapsed=%llu (min=%llu)\n",
> +                               __func__, cpu, elapsed[cpu], elapsed_min);
> +
> +               policy = cpufreq_cpu_get(cpu);
> +               down_write(&policy->rwsem);
> +               policy->user_policy.min = curr_min;
> +               policy->user_policy.max = curr_max;
> +               up_write(&policy->rwsem);
> +               cpufreq_cpu_put(policy);
> +               cpufreq_update_policy(cpu);
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               unsigned long capacity;
> +
> +               capacity = div64_u64((elapsed_min << 10), elapsed[cpu]);
> +               pr_debug("%s: CPU%d capacity=%lu\n", __func__, cpu, capacity);
> +               set_capacity_scale(cpu, capacity);
> +       }
> +
> +       pr_info("dynamic CPUs capacity installed\n");
> +}
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 88a4215..9924351 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -419,6 +419,8 @@ static inline unsigned long cpufreq_scale(unsigned long old, u_int div,
>  #endif
>  }
>
> +void cpufreq_init_cpu_capacity(void);
> +
>  /*********************************************************************
>   *                          CPUFREQ GOVERNORS                        *
>   *********************************************************************/
> --
> 2.7.0
>
