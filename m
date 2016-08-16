From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 2/8] arm: parse cpu capacity-dmips-mhz from DT
Date: Tue, 16 Aug 2016 10:20:57 +0200
Message-ID: <CAKfTPtBy7LGCW2T4AGoqL5L_1AHtW6KxHigxFVFVc_EU4oUO0g@mail.gmail.com>
References: <1468932048-31635-1-git-send-email-juri.lelli@arm.com> <1468932048-31635-3-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468932048-31635-3-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Juri,


On 19 July 2016 at 14:40, Juri Lelli <juri.lelli@arm.com> wrote:
> With the introduction of cpu capacity-dmips-mhz bindings, CPU capacities
> can now be calculated from values extracted from DT and information
> coming from cpufreq. Add parsing of DT information at boot time, and
> complement it with cpufreq information. We keep code that can produce
> same information, based on different DT properties and hard-coded
> values, as fall-back for backward compatibility.
>
> Caveat: the information provided by this patch will start to be used in
> the future. We need to #define arch_scale_cpu_capacity to something
> provided in arch, so that scheduler's default implementation (which gets
> used if arch_scale_cpu_capacity is not defined) is overwritten.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>
> Changes from v1:
>   - normalize w.r.t. highest capacity found in DT
>   - bailout conditions (all-or-nothing)
>
> Changes from v4:
>   - parsing modified to reflect change in binding (capacity-dmips-mhz)
>
> Changes from v5:
>   - allocate raw_capacity array with kcalloc()
>   - pr_err() only for partial capacity information
> ---
>  arch/arm/kernel/topology.c | 145 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index ec279d161b32..b3094e6eb1f5 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -78,6 +78,134 @@ static unsigned long *__cpu_capacity;
>  #define cpu_capacity(cpu)      __cpu_capacity[cpu]
>
>  static unsigned long middle_capacity = 1;
> +static bool cap_from_dt = true;
> +static u32 *raw_capacity;
> +static bool cap_parsing_failed;
> +static u32 capacity_scale;
> +
> +static int __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> +{
> +       int ret = 1;
> +       u32 cpu_capacity;
> +
> +       if (cap_parsing_failed)
> +               return !ret;
> +
> +       ret = of_property_read_u32(cpu_node,
> +                                  "capacity-dmips-mhz",
> +                                  &cpu_capacity);
> +       if (!ret) {
> +               if (!raw_capacity) {
> +                       raw_capacity = kcalloc(num_possible_cpus(),
> +                                              sizeof(*raw_capacity),
> +                                              GFP_KERNEL);
> +                       if (!raw_capacity) {
> +                               pr_err("cpu_capacity: failed to allocate memory for raw capacities\n");
> +                               cap_parsing_failed = true;
> +                               return !ret;
> +                       }
> +               }
> +               capacity_scale = max(cpu_capacity, capacity_scale);
> +               raw_capacity[cpu] = cpu_capacity;
> +               pr_debug("cpu_capacity: %s cpu_capacity=%u (raw)\n",
> +                       cpu_node->full_name, raw_capacity[cpu]);
> +       } else {
> +               if (raw_capacity) {
> +                       pr_err("cpu_capacity: missing %s raw capacity\n",
> +                               cpu_node->full_name);
> +                       pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
> +               }
> +               cap_parsing_failed = true;
> +               kfree(raw_capacity);
> +       }
> +
> +       return !ret;
> +}
> +
> +static void normalize_cpu_capacity(void)
> +{
> +       u64 capacity;
> +       int cpu;
> +
> +       if (!raw_capacity || cap_parsing_failed)
> +               return;
> +
> +       pr_debug("cpu_capacity: capacity_scale=%u\n", capacity_scale);
> +       for_each_possible_cpu(cpu) {
> +               capacity = (raw_capacity[cpu] << SCHED_CAPACITY_SHIFT)
> +                       / capacity_scale;
> +               set_capacity_scale(cpu, capacity);
> +               pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
> +                       cpu, arch_scale_cpu_capacity(NULL, cpu));
> +       }
> +}
> +
> +#ifdef CONFIG_CPU_FREQ
> +static cpumask_var_t cpus_to_visit;
> +static bool cap_parsing_done;
> +
> +static int
> +init_cpu_capacity_callback(struct notifier_block *nb,
> +                          unsigned long val,
> +                          void *data)
> +{
> +       struct cpufreq_policy *policy = data;
> +       int cpu;
> +
> +       if (cap_parsing_failed || cap_parsing_done)
> +               return 0;
> +
> +       switch (val) {
> +       case CPUFREQ_NOTIFY:
> +               pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
> +                               cpumask_pr_args(policy->related_cpus),
> +                               cpumask_pr_args(cpus_to_visit));
> +               cpumask_andnot(cpus_to_visit,
> +                              cpus_to_visit,
> +                              policy->related_cpus);
> +               for_each_cpu(cpu, policy->related_cpus) {
> +                       raw_capacity[cpu] = arch_scale_cpu_capacity(NULL, cpu) *
> +                                           policy->max / 1000UL;

Should it be policy->cpuinfo.max_freq instead of policy->max ?

> +                       capacity_scale = max(raw_capacity[cpu], capacity_scale);
> +               }
> +               if (cpumask_empty(cpus_to_visit)) {
> +                       normalize_cpu_capacity();
> +                       kfree(raw_capacity);
> +                       pr_debug("cpu_capacity: parsing done\n");
> +                       cap_parsing_done = true;

ok so you do that once with the 1st governor that will be registered
for the CPU. Can't you unregister the notifier then ?

> +               }
> +       }
> +       return 0;
> +}
> +
> +static struct notifier_block init_cpu_capacity_notifier = {
> +       .notifier_call = init_cpu_capacity_callback,
> +};
> +
> +static int __init register_cpufreq_notifier(void)
> +{
> +       if (cap_parsing_failed)
> +               return -EINVAL;
> +
> +       if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
> +               pr_err("cpu_capacity: failed to allocate memory for cpus_to_visit\n");
> +               return -ENOMEM;
> +       }
> +       cpumask_copy(cpus_to_visit, cpu_possible_mask);
> +
> +       return cpufreq_register_notifier(&init_cpu_capacity_notifier,
> +                                        CPUFREQ_POLICY_NOTIFIER);
> +}
> +core_initcall(register_cpufreq_notifier);
> +#else
> +static int __init free_raw_capacity(void)
> +{
> +       kfree(raw_capacity);
> +
> +       return 0;
> +}
> +core_initcall(free_raw_capacity);
> +#endif
>
>  /*
>   * Iterate all CPUs' descriptor in DT and compute the efficiency
> @@ -99,6 +227,12 @@ static void __init parse_dt_topology(void)
>         __cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
>                                  GFP_NOWAIT);
>
> +       cn = of_find_node_by_path("/cpus");
> +       if (!cn) {
> +               pr_err("No CPU information found in DT\n");
> +               return;
> +       }
> +
>         for_each_possible_cpu(cpu) {
>                 const u32 *rate;
>                 int len;
> @@ -110,6 +244,13 @@ static void __init parse_dt_topology(void)
>                         continue;
>                 }
>
> +               if (parse_cpu_capacity(cn, cpu)) {
> +                       of_node_put(cn);
> +                       continue;
> +               }
> +
> +               cap_from_dt = false;
> +
>                 for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
>                         if (of_device_is_compatible(cn, cpu_eff->compatible))
>                                 break;
> @@ -151,6 +292,8 @@ static void __init parse_dt_topology(void)
>                 middle_capacity = ((max_capacity / 3)
>                                 >> (SCHED_CAPACITY_SHIFT-1)) + 1;
>
> +       if (cap_from_dt && !cap_parsing_failed)
> +               normalize_cpu_capacity();
>  }
>
>  /*
> @@ -160,7 +303,7 @@ static void __init parse_dt_topology(void)
>   */
>  static void update_cpu_capacity(unsigned int cpu)
>  {
> -       if (!cpu_capacity(cpu))
> +       if (!cpu_capacity(cpu) || cap_from_dt)
>                 return;
>
>         set_capacity_scale(cpu, cpu_capacity(cpu) / middle_capacity);
> --
> 2.7.0
>
