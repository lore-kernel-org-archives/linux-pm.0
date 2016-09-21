From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 10/10] cpufreq: intel_pstate: Use CPPC to get max performance
Date: Wed, 21 Sep 2016 22:30:03 +0200
Message-ID: <CAJZ5v0h3=JLw8mH=x4jXNec9CGZWiCt+pPmrD1L4=QutT8=g0Q@mail.gmail.com>
References: <1474485552-141429-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1474485552-141429-11-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1474485552-141429-11-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com, jolsa@redhat.com
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 21, 2016 at 9:19 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> This change uses acpi cppc_lib interface to get CPPC performance limits.
> Once CPPC limits of all online cores are read, first check if there is
> difference in max performance. If there is a difference, then the
> scheduler interface is called to update per cpu priority and enable
> ITMT feature.
>
> Here sched_set_itmt_core_prio() is called to set priorities and
> sched_set_itmt_support() is called to enable ITMT feature.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/Kconfig.x86    |   1 +
>  drivers/cpufreq/intel_pstate.c | 103 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 103 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index adbd1de..3328c6b 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -6,6 +6,7 @@ config X86_INTEL_PSTATE
>         bool "Intel P state control"
>         depends on X86
>         select ACPI_PROCESSOR if ACPI
> +       select ACPI_CPPC_LIB if X86_64 && ACPI

Do we need to select CPPC here if SCHED_ITMT is unset?

>         help
>            This driver provides a P state for Intel core processors.
>           The driver implements an internal governor and will become
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index c877e70..d226a64 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -44,6 +44,7 @@
>
>  #ifdef CONFIG_ACPI
>  #include <acpi/processor.h>
> +#include <acpi/cppc_acpi.h>
>  #endif
>
>  #define FRAC_BITS 8
> @@ -195,6 +196,7 @@ struct _pid {
>   * @sample:            Storage for storing last Sample data
>   * @acpi_perf_data:    Stores ACPI perf information read from _PSS
>   * @valid_pss_table:   Set to true for valid ACPI _PSS entries found
> + * @cppc_perf:         Stores CPPC performance information
>   *
>   * This structure stores per CPU instance data for all CPUs.
>   */
> @@ -218,6 +220,7 @@ struct cpudata {
>  #ifdef CONFIG_ACPI
>         struct acpi_processor_performance acpi_perf_data;
>         bool valid_pss_table;
> +       struct cppc_perf_caps *cppc_perf;
>  #endif
>         unsigned int iowait_boost;
>  };
> @@ -377,14 +380,105 @@ static bool intel_pstate_get_ppc_enable_status(void)
>         return acpi_ppc;
>  }
>

The new code below is only useful if CONFIG_SCHED_ITMT is set, so
maybe it's better to put it into a #ifdef block?

> +/* Mask of CPUs for which CPCC data has been read */
> +static cpumask_t cppc_read_cpu_mask;
> +
> +/*
> + * Can't call sched_set_itmt_support() in hotcpu notifier callback path
> + * as this function uses hotplug locks in its path. So call from
> + * a work function.
> + */
> +static void intel_pstste_sched_itmt_work_fn(struct work_struct *work)
> +{
> +       sched_set_itmt_support(true);
> +}
> +
> +static DECLARE_WORK(sched_itmt_work, intel_pstste_sched_itmt_work_fn);
> +
> +static void intel_pstate_check_and_enable_itmt(int cpu)
> +{
> +       /*
> +        * For checking whether there is any difference in the maximum
> +        * performance for each CPU, need to wait till we have CPPC
> +        * data from all CPUs called from the cpufreq core. If there is a
> +        * difference in the maximum performance, then we have ITMT support.
> +        * If ITMT is supported, update the scheduler core priority for each
> +        * CPU and call to enable the ITMT feature.
> +        */
> +       if (cpumask_subset(topology_core_cpumask(cpu), &cppc_read_cpu_mask)) {
> +               int cpu_index;
> +               int max_prio;
> +               struct cpudata *cpu;
> +               bool itmt_support = false;
> +
> +               cpu = all_cpu_data[cpumask_first(&cppc_read_cpu_mask)];
> +               max_prio = cpu->cppc_perf->highest_perf;
> +               for_each_cpu(cpu_index, &cppc_read_cpu_mask) {
> +                       cpu = all_cpu_data[cpu_index];
> +                       if (max_prio != cpu->cppc_perf->highest_perf) {
> +                               itmt_support = true;
> +                               break;
> +                       }
> +               }
> +
> +               if (!itmt_support)
> +                       return;
> +
> +               for_each_cpu(cpu_index, &cppc_read_cpu_mask) {
> +                       cpu = all_cpu_data[cpu_index];
> +                       sched_set_itmt_core_prio(cpu->cppc_perf->highest_perf,
> +                                                cpu_index);
> +               }

My current understanding is that we need to rebuild sched domains
after setting the priorities, so what if there are two CPU packages
and there are highest_perf differences in both, and we first enumerate
the first package entirely before getting to the second one?

In that case we'll schedule the work item after enumerating the first
package and it may rebuild the sched domains before all priorities are
set for the second package, may it not?

This seems to require some more consideration.

> +               /*
> +                * Since this function is in the hotcpu notifier callback
> +                * path, submit a task to workqueue to call
> +                * sched_set_itmt_support().
> +                */
> +               schedule_work(&sched_itmt_work);

It doesn't make sense to do this more than once IMO and what if we
attempt to schedule the work item again when it has been scheduled
once already?  Don't we need any protection here?

> +       }
> +}
> +
> +/*
> + * Process ACPI CPPC information. Currently it is only used to for enabling
> + * ITMT feature. This driver still uses MSRs to manage HWP, not CPPC.
> + */
> +static void intel_pstate_process_acpi_cppc(struct cpufreq_policy *policy)
> +{
> +       struct cpudata *cpu;
> +       int ret;
> +
> +       cpu = all_cpu_data[policy->cpu];
> +       cpu->cppc_perf = kzalloc(sizeof(struct cppc_perf_caps), GFP_KERNEL);
> +       if (!cpu->cppc_perf)
> +               return;
> +
> +       ret = cppc_get_perf_caps(policy->cpu, cpu->cppc_perf);
> +       if (ret) {
> +               kfree(cpu->cppc_perf);
> +               cpu->cppc_perf = NULL;
> +               return;
> +       }
> +
> +       pr_debug("cpu:%d H:0x%x N:0x%x L:0x%x\n", policy->cpu,
> +                cpu->cppc_perf->highest_perf, cpu->cppc_perf->nominal_perf,
> +                cpu->cppc_perf->lowest_perf);
> +
> +       /* Mark that the CPPC data for the policy->cpu is read */
> +       cpumask_set_cpu(policy->cpu, &cppc_read_cpu_mask);
> +
> +       intel_pstate_check_and_enable_itmt(policy->cpu);
> +}
> +
>  static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
>  {
>         struct cpudata *cpu;
>         int ret;
>         int i;
>
> -       if (hwp_active)
> +       if (hwp_active) {
> +               intel_pstate_process_acpi_cppc(policy);
>                 return;
> +       }
>
>         if (!intel_pstate_get_ppc_enable_status())
>                 return;
> @@ -450,6 +544,13 @@ static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>         struct cpudata *cpu;
>
>         cpu = all_cpu_data[policy->cpu];
> +
> +       if (cpu->cppc_perf) {
> +               cpumask_clear_cpu(policy->cpu, &cppc_read_cpu_mask);
> +               kfree(cpu->cppc_perf);
> +               cpu->cppc_perf = NULL;
> +       }
> +
>         if (!cpu->valid_pss_table)
>                 return;
>
> --

Thanks,
Rafael
