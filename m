From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v7] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 16 Dec 2014 03:15:33 -0500
Message-ID: <CAJvTdKmCwJTWE4t9YuWn+OLxG5EWZDXo5LZ1Bxq45ECiOvQmsA@mail.gmail.com>
References: <20141211081438.GA2885@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:46287 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaLPIPe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Dec 2014 03:15:34 -0500
Received: by mail-yk0-f169.google.com with SMTP id 79so5740232ykr.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Dec 2014 00:15:33 -0800 (PST)
In-Reply-To: <20141211081438.GA2885@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com

> diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/asm/msr-index.h
> index e21331ce368f..4f6dae67dd10 100644
> --- a/arch/x86/include/uapi/asm/msr-index.h
> +++ b/arch/x86/include/uapi/asm/msr-index.h
> @@ -318,6 +318,7 @@
>
>  #define MSR_IA32_PERF_STATUS           0x00000198
>  #define MSR_IA32_PERF_CTL              0x00000199
> +#define INTEL_PERF_CTL_MASK            0xffff
>  #define MSR_AMD_PSTATE_DEF_BASE                0xc0010064
>  #define MSR_AMD_PERF_STATUS            0xc0010063
>  #define MSR_AMD_PERF_CTL               0xc0010062
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 89ae88f91895..dd2b6f541f33 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -57,6 +57,16 @@ config X86_ACPI_CPUFREQ_CPB
>           By enabling this option the acpi_cpufreq driver provides the old
>           entry in addition to the new boost ones, for compatibility reasons.
>
> +config X86_SFI_CPUFREQ
> +       tristate "SFI P-States driver"

I guess since you are editing it anyway, spell out "Performance-State"
instead of P-state.  bytes are free:-)

> +       depends on X86_INTEL_MID && SFI
> +       help
> +         This adds a CPUFreq driver for some Silvermont based Intel Atom
> +         architectures like Z34xx and Z35xx which enumerate processor
> +         performance states through SFI.
> +
> +         If in doubt, say N.
> +
>  config ELAN_CPUFREQ
>         tristate "AMD Elan SC400 and SC410"
>         depends on MELAN
...
> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> new file mode 100644
> index 000000000000..118aa5eba628
> --- /dev/null
> +++ b/drivers/cpufreq/sfi-cpufreq.c
> @@ -0,0 +1,165 @@
> +/*
> + *  SFI Processor P-States Driver
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License.
> + *
> + *  This program is distributed in the hope that it will be useful, but
> + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  Author: Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>
> + *  Author: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> + */
> +
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sfi.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +
> +#include <asm/msr.h>
> +
> +#define SFI_FREQ_MAX           32

please delete definition of SFI_FREQ_MAX, per comment below  in sfi_parse_freq()

> +#define SFI_FREQ_MASK          0xff00

please delete definition of SFI_FREQ_MASK
it is unused since get_cur_freq_on_cpu() is gone -- yay:-)

> +
> +static DEFINE_PER_CPU(struct cpufreq_frequency_table *, drv_data);
> +static struct sfi_freq_table_entry sfi_cpufreq_array[SFI_FREQ_MAX];

above will become a pointer to a kzalloc array.

> +static int num_freq_table_entries;
> +
> +static int sfi_parse_freq(struct sfi_table_header *table)
> +{
> +       struct sfi_table_simple *sb;
> +       struct sfi_freq_table_entry *pentry;
> +       int totallen;
> +
> +       sb = (struct sfi_table_simple *)table;
> +       num_freq_table_entries = SFI_GET_NUM_ENTRIES(sb,
> +                       struct sfi_freq_table_entry);
> +       if (num_freq_table_entries <= 1) {
> +               pr_err("No p-states discovered\n");
> +               return -ENODEV;
> +       }
> +
> +       pentry = (struct sfi_freq_table_entry *)sb->pentry;
> +       totallen = num_freq_table_entries * sizeof(*pentry);

if num_freq_table_entries exceeds SFI_FREQ_MAX,
then the following line would over-write random kernel data.

Better to simply kzalloc this array,
and delete the arbitrary #define SFI_FREQ_MAX

> +       memcpy(sfi_cpufreq_array, pentry, totallen);
> +
> +       return 0;
> +}
> +
> +static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> +                               unsigned int index)

fits into 80 columns on 1 line, yes?

> +{
> +       struct cpufreq_frequency_table *freq_table =
> +                       per_cpu(drv_data, policy->cpu);
> +       unsigned int next_perf_state = 0; /* Index into perf table */
> +       u32 lo, hi;
> +
> +       next_perf_state = freq_table[index].driver_data;
> +
> +       rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> +       lo = (lo & ~INTEL_PERF_CTL_MASK) |
> +               ((u32) sfi_cpufreq_array[next_perf_state].ctrl_val &
> +               INTEL_PERF_CTL_MASK);
> +       wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
> +
> +       return 0;
> +}
> +
> +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_frequency_table *freq_table;
> +       unsigned int i, result, valid_states = 0;
> +       unsigned int cpu = policy->cpu;
> +
> +       freq_table = kzalloc(sizeof(*freq_table) *
> +                       (num_freq_table_entries + 1), GFP_KERNEL);
> +       if (!freq_table)
> +               return -ENOMEM;
> +
> +       per_cpu(drv_data, cpu) = freq_table;
> +
> +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> +
> +       policy->cpuinfo.transition_latency = 0;

replace line above with...

policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;

ondemand will compare this to TRANSITION_LATENCY_LIMIT (10 * 1000 * 1000)
and since -1 is less than 10,000,000; it will be happy.

> +       for (i = 0; i < num_freq_table_entries; i++) {
> +               /* detect transition latency */
> +               if ((sfi_cpufreq_array[i].latency * 1000) >
> +                   policy->cpuinfo.transition_latency)
> +                       policy->cpuinfo.transition_latency =
> +                               sfi_cpufreq_array[i].latency * 1000;

delete above 5 lines.  every SFI system will have latency
plenty lower than that required by ondemand governor.

> +
> +               /* initialize the freq table */
> +               freq_table[valid_states].driver_data = i;
> +               freq_table[valid_states].frequency =
> +                               sfi_cpufreq_array[i].freq_mhz * 1000;
> +               valid_states++;
> +
> +               pr_debug("     P%d: %d MHz, %d uS\n",
> +                       i,
> +                       (u32) sfi_cpufreq_array[i].freq_mhz,
> +                       (u32) sfi_cpufreq_array[i].latency);

I don't think anybody cares what the latency field is,
so you don't have to print it.

cpufreq_table_validate_and_show already does a pr_debug()
showing the mhz for each p-state -- so you can delete this pr_debug entirely.

> +       }
> +       freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
> +
> +       result = cpufreq_table_validate_and_show(policy, freq_table);
> +       if (result)
> +               goto err_free;
> +
> +       pr_debug("CPU%u - SFI performance management activated.\n", cpu);
> +
> +       return result;
> +
> +err_free:
> +       per_cpu(drv_data, cpu) = NULL;
> +       kfree(freq_table);
> +
> +       return result;
> +}
> +
> +static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> +{
> +       struct cpufreq_frequency_table *freq_table =
> +                       per_cpu(drv_data, policy->cpu);
> +
> +       kfree(freq_table);
> +       return 0;
> +}
> +
> +static struct cpufreq_driver sfi_cpufreq_driver = {
> +       .flags          = CPUFREQ_CONST_LOOPS,
> +       .verify         = cpufreq_generic_frequency_table_verify,
> +       .target_index   = sfi_cpufreq_target,
> +       .init           = sfi_cpufreq_cpu_init,
> +       .exit           = sfi_cpufreq_cpu_exit,
> +       .name           = "sfi-cpufreq",
> +       .attr           = cpufreq_generic_attr,
> +};
> +
> +static int __init sfi_cpufreq_init(void)
> +{
> +       int ret;
> +
> +       /* parse the freq table from SFI */
> +       ret = sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, sfi_parse_freq);
> +       if (ret)
> +               return ret;
> +
> +       return cpufreq_register_driver(&sfi_cpufreq_driver);
> +}
> +late_initcall(sfi_cpufreq_init);
> +
> +static void __exit sfi_cpufreq_exit(void)
> +{
> +       cpufreq_unregister_driver(&sfi_cpufreq_driver);
> +}
> +module_exit(sfi_cpufreq_exit);
> +
> +MODULE_AUTHOR("Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>");
> +MODULE_DESCRIPTION("SFI P-States Driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5


-- 
Len Brown, Intel Open Source Technology Center
