From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] cpufreq: intel_pstate: Enforce _PPC limits
Date: Wed, 27 Apr 2016 21:45:23 +0200
Message-ID: <CAJZ5v0gJKGGgE_TrQJ99Q5LdOsbqp0n1L0FHXhk=JpcXB6kHaw@mail.gmail.com>
References: <1461384068-23969-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1461384068-23969-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36807 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbcD0TpZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 15:45:25 -0400
Received: by mail-lf0-f66.google.com with SMTP id y84so9281318lfc.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 12:45:24 -0700 (PDT)
In-Reply-To: <1461384068-23969-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sat, Apr 23, 2016 at 6:01 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Use ACPI _PPC notification to limit max P state driver will request.
> ACPI _PPC change notification is sent by BIOS to limit max P state
> in several cases:
> - Reduce impact of platform thermal condition
> - When Config TDP feature is used, a changed _PPC is sent to
> follow TDP change
> - Remote node managers in server want to control platform power
> via baseboard management controller (BMC)
>
> This change registers with ACPI processor performance lib so that
> _PPC changes are notified to cpufreq core, which in turns will
> result in call to .setpolicy() callback. Also the way _PSS
> table identifies a turbo frequency is not compatible to max turbo
> frequency in intel_pstate, so the very first entry in _PSS needs
> to be adjusted.
>
> This feature can be turned on by using kernel parameters:
> intel_pstate=support_acpi_ppc
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

One nit (I haven't spotted it before, sorry about that) ->

> ---
>  Documentation/kernel-parameters.txt |   2 +
>  drivers/cpufreq/Kconfig.x86         |   1 +
>  drivers/cpufreq/intel_pstate.c      | 142 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 143 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 0b3de80..4199a1b 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1661,6 +1661,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>                 hwp_only
>                         Only load intel_pstate on systems which support
>                         hardware P state control (HWP) if available.
> +               support_acpi_ppc
> +                       Enforce ACPI _PPC performance limits.
>
>         intremap=       [X86-64, Intel-IOMMU]
>                         on      enable Interrupt Remapping (default)
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index c59bdcb..adbd1de 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -5,6 +5,7 @@
>  config X86_INTEL_PSTATE
>         bool "Intel P state control"
>         depends on X86
> +       select ACPI_PROCESSOR if ACPI
>         help
>            This driver provides a P state for Intel core processors.
>           The driver implements an internal governor and will become
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 03f94c2..b3e8124 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -39,6 +39,10 @@
>  #define ATOM_TURBO_RATIOS      0x66c
>  #define ATOM_TURBO_VIDS                0x66d
>
> +#ifdef CONFIG_ACPI
> +#include <acpi/processor.h>
> +#endif
> +
>  #define FRAC_BITS 8
>  #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
>  #define fp_toint(X) ((X) >> FRAC_BITS)
> @@ -172,6 +176,8 @@ struct _pid {
>   * @prev_cummulative_iowait: IO Wait time difference from last and
>   *                     current sample
>   * @sample:            Storage for storing last Sample data
> + * @acpi_perf_data:    Stores ACPI perf information read from _PSS
> + * @valid_pss_table:   Set to true for valid ACPI _PSS entries found
>   *
>   * This structure stores per CPU instance data for all CPUs.
>   */
> @@ -190,6 +196,10 @@ struct cpudata {
>         u64     prev_tsc;
>         u64     prev_cummulative_iowait;
>         struct sample sample;
> +#ifdef CONFIG_ACPI
> +       struct acpi_processor_performance acpi_perf_data;
> +       bool valid_pss_table;
> +#endif
>  };
>
>  static struct cpudata **all_cpu_data;
> @@ -258,6 +268,9 @@ static struct pstate_adjust_policy pid_params;
>  static struct pstate_funcs pstate_funcs;
>  static int hwp_active;
>
> +#ifdef CONFIG_ACPI
> +static bool acpi_ppc;
> +#endif
>
>  /**
>   * struct perf_limits - Store user and policy limits
> @@ -331,6 +344,115 @@ static struct perf_limits *limits = &performance_limits;
>  static struct perf_limits *limits = &powersave_limits;
>  #endif
>
> +#ifdef CONFIG_ACPI
> +/*
> + * The max target pstate ratio is a 8 bit value in both PLATFORM_INFO MSR and
> + * in TURBO_RATIO_LIMIT MSR, which pstate driver stores in max_pstate and
> + * max_turbo_pstate fields. The PERF_CTL MSR contains 16 bit value for P state
> + * ratio, out of it only high 8 bits are used. For example 0x1700 is setting
> + * target ratio 0x17. The _PSS control value stores in a format which can be
> + * directly written to PERF_CTL MSR. But in intel_pstate driver this shift
> + * occurs during write to PERF_CTL (E.g. for cores core_set_pstate()).
> + * This function converts the _PSS control value to intel pstate driver format
> + * for comparison and assignment.
> + */
> +static int convert_to_native_pstate_format(struct cpudata *cpu, int index)
> +{
> +       return cpu->acpi_perf_data.states[index].control >> 8;
> +}
> +
> +static int intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)

The only caller of this ignores the return value, so why bother with
returning it?
