From: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 4/8] arm64: parse cpu capacity-dmips-mhz from DT
Date: Mon, 12 Sep 2016 10:37:55 +0200
Message-ID: <CAKfTPtCN9zMtL82zc_=-KZ6U+cMORi+JTBVLDxKccY2hbJ=3vw@mail.gmail.com>
References: <1473085372-2840-1-git-send-email-juri.lelli@arm.com> <1473085372-2840-5-git-send-email-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473085372-2840-5-git-send-email-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Juri,

On 5 September 2016 at 16:22, Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org> wrote:
> With the introduction of cpu capacity-dmips-mhz bindings, CPU capacities
> can now be calculated from values extracted from DT and information
> coming from cpufreq. Add parsing of DT information at boot time, and
> complement it with cpufreq information. Also, store such information
> using per CPU variables, as we do for arm.
>
> Caveat: the information provided by this patch will start to be used in
> the future. We need to #define arch_scale_cpu_capacity to something
> provided in arch, so that scheduler's default implementation (which gets
> used if arch_scale_cpu_capacity is not defined) is overwritten.
>
> Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>

Acked-by: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

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
>
> Changes from v6:
>   - use cpuinfo.max_freq instead of policy->max
>   - add delayed work to unregister cpufreq notifier
> ---
>  arch/arm64/kernel/topology.c | 159 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index 694f6deedbab..b75b0ba2e113 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -19,10 +19,162 @@
>  #include <linux/nodemask.h>
>  #include <linux/of.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/cpufreq.h>
>
>  #include <asm/cputype.h>
>  #include <asm/topology.h>
>
> +static DEFINE_PER_CPU(unsigned long, cpu_scale) = SCHED_CAPACITY_SCALE;
> +
> +unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
> +{
> +       return per_cpu(cpu_scale, cpu);
> +}
> +
> +static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
> +{
> +       per_cpu(cpu_scale, cpu) = capacity;
> +}
> +
> +static u32 capacity_scale;
> +static u32 *raw_capacity;
> +static bool cap_parsing_failed;
> +
> +static void __init parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> +{
> +       int ret;
> +       u32 cpu_capacity;
> +
> +       if (cap_parsing_failed)
> +               return;
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
> +                               return;
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
> +               pr_debug("cpu_capacity: cpu=%d raw_capacity=%u\n",
> +                        cpu, raw_capacity[cpu]);
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
> +static void parsing_done_workfn(struct work_struct *work);
> +static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
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
> +                                           policy->cpuinfo.max_freq / 1000UL;
> +                       capacity_scale = max(raw_capacity[cpu], capacity_scale);
> +               }
> +               if (cpumask_empty(cpus_to_visit)) {
> +                       normalize_cpu_capacity();
> +                       kfree(raw_capacity);
> +                       pr_debug("cpu_capacity: parsing done\n");
> +                       cap_parsing_done = true;
> +                       schedule_work(&parsing_done_work);
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
> +
> +static void parsing_done_workfn(struct work_struct *work)
> +{
> +       cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
> +                                        CPUFREQ_POLICY_NOTIFIER);
> +}
> +
> +#else
> +static int __init free_raw_capacity(void)
> +{
> +       kfree(raw_capacity);
> +
> +       return 0;
> +}
> +core_initcall(free_raw_capacity);
> +#endif
> +
>  static int __init get_cpu_for_node(struct device_node *node)
>  {
>         struct device_node *cpu_node;
> @@ -34,6 +186,7 @@ static int __init get_cpu_for_node(struct device_node *node)
>
>         for_each_possible_cpu(cpu) {
>                 if (of_get_cpu_node(cpu, NULL) == cpu_node) {
> +                       parse_cpu_capacity(cpu_node, cpu);
>                         of_node_put(cpu_node);
>                         return cpu;
>                 }
> @@ -178,13 +331,17 @@ static int __init parse_dt_topology(void)
>          * cluster with restricted subnodes.
>          */
>         map = of_get_child_by_name(cn, "cpu-map");
> -       if (!map)
> +       if (!map) {
> +               cap_parsing_failed = true;
>                 goto out;
> +       }
>
>         ret = parse_cluster(map, 0);
>         if (ret != 0)
>                 goto out_map;
>
> +       normalize_cpu_capacity();
> +
>         /*
>          * Check that all cores are in the topology; the SMP code will
>          * only mark cores described in the DT as possible.
> --
> 2.7.0
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
