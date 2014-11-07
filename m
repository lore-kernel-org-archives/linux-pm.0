From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v4] cpufreq: Add SFI based cpufreq driver support
Date: Fri, 7 Nov 2014 01:18:47 -0500
Message-ID: <CAJvTdKkUR5OfdEjyhPrh3PzkvPce2aYRT59YhvOGwco-jLSZ=g@mail.gmail.com>
References: <20141104170031.GA25991@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:43553 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbaKGGSv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 01:18:51 -0500
Received: by mail-yh0-f44.google.com with SMTP id b6so1367831yha.31
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2014 22:18:48 -0800 (PST)
In-Reply-To: <20141104170031.GA25991@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh.kumar@linaro.org, Linux PM list <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, "Brown, Len" <len.brown@intel.com>

On Tue, Nov 4, 2014 at 12:00 PM, Srinidhi Kasagar
<srinidhi.kasagar@intel.com> wrote:
> This adds the SFI based cpu freq driver for some of the Intel's
> Silvermont based Atom architectures like Z34xx and Z35xx.
>
> Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
...
>
>  drivers/cpufreq/Kconfig.x86   |   10 ++
>  drivers/cpufreq/Makefile      |    1 +

Please update MAINTAINERS to indicate who will maintain this driver.

>  drivers/cpufreq/sfi-cpufreq.c |  317 +++++++++++++++++++++++++++++++++++++++++

As this driver is called sfi-cpufreq.c
Its private functions and data structures below should best be called
sfi_cpufreq_* instead of
sfi_processor_* -- which looks like they are calling some other sub-system...

>  3 files changed, 328 insertions(+)
>  create mode 100644 drivers/cpufreq/sfi-cpufreq.c
>
> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> index 89ae88f91895..8860e8062b53 100644
> --- a/drivers/cpufreq/Kconfig.x86
> +++ b/drivers/cpufreq/Kconfig.x86
> @@ -57,6 +57,16 @@ config X86_ACPI_CPUFREQ_CPB
>           By enabling this option the acpi_cpufreq driver provides the old
>           entry in addition to the new boost ones, for compatibility reasons.
>
> +config X86_SFI_CPUFREQ
> +       tristate "SFI Processor P-States driver"
> +       depends on X86_INTEL_MID && SFI
> +       help
> +         This adds a CPUFreq driver for some Silvermont based Intel Atom
> +         platforms (like INTEL_MID) which enumerates processor performance
> +         states through SFI.

s/enumerates/enumerate/

Also, perhaps add the real HW names that are present in the commit message?

> +
> +         If in doubt, say N.
> +
>  config ELAN_CPUFREQ
>         tristate "AMD Elan SC400 and SC410"
>         depends on MELAN
...
> diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> new file mode 100644
> index 000000000000..d5e11dca739d
> --- /dev/null
> +++ b/drivers/cpufreq/sfi-cpufreq.c
> @@ -0,0 +1,317 @@
> +/*
> + *  SFI Processor P-States Driver
> + *  Based on ACPI Processor P-States Driver
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
> +#include <linux/cpuidle.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sfi.h>
> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +
> +#include <asm/msr.h>
> +#include <asm/processor.h>
> +
> +#define SFI_FREQ_MAX           32

Delete this #define, and the array where it is used.
Neither are necessary.

> +#define INTEL_MSR_RANGE                0xffff

I see this was copied INTEL_MSR_RANGE from acpi-cpufreq.c, but
two wrongs don't make a right.  Instead it should be something like

msr-index.h
#define MSR_IA32_PERF_CTL               0x00000199
+#define INTEL_PERF_CTL_MASK      0xffff

as it is (Intel) architecture generic (and it is a mask, not a range:-)

> +#define INTEL_MSR_BUSRATIO_MASK        0xff00

Please delete this #define, and the code that references it.

If this definition were architectural, we'd also see it in msr-index.h
under the definition of PERF_STATUS msr.
But it isn't architectural.  I don't like seeing it manufactured for this code,
and I don't like seeing the unreliable PERF_STATUS MSR accessed.

For the driver.get current frequency, it would be better to either
simply return the last value written to PERF_CTRL, or if you really
want to get fance, use APERF/MPERF to actually calcuate the frequency,
like intel_pstate.c does.
In either case, this #define and the code it references should go.

> +
> +static DEFINE_PER_CPU(struct sfi_cpufreq_data *, drv_data);
> +static DEFINE_MUTEX(performance_mutex);
> +static struct sfi_freq_table_entry sfi_cpufreq_array[SFI_FREQ_MAX];
> +
> +/* sfi_perf_data is a pointer to percpu data. */
> +static struct sfi_processor_performance *sfi_perf_data;
> +static struct cpufreq_driver sfi_cpufreq_driver;
> +static int sfi_cpufreq_num;
> +
> +/* Performance management */
> +struct sfi_processor_px {
> +       u32 core_frequency;     /* megahertz */
> +       u32 transition_latency; /* microseconds */
> +       u32 control;    /* control value */
> +};

delete the definition of sfi_processor_px.
it is already defined in sfi.h as sfi_freq_table_entry.

> +
> +struct sfi_processor_performance {
> +       unsigned int state;
> +       unsigned int state_count;
> +       struct sfi_processor_px *states;
> +};
> +
> +struct sfi_cpufreq_data {
> +       struct sfi_processor_performance *sfi_data;
> +       struct cpufreq_frequency_table *freq_table;
> +};
> +
> +static int parse_freq(struct sfi_table_header *table)
> +{
> +       struct sfi_table_simple *sb;
> +       struct sfi_freq_table_entry *pentry;
> +       int total_len;
> +
> +       sb = (struct sfi_table_simple *)table;
> +       if (!sb) {
> +               pr_warn("SFI: Unable to map frequency table\n");
> +               return -ENODEV;

Delete this check, it is impossible for it to execute.
The calling function, sfi_table_parse()
already checked for !table.

> +       }
> +
> +       if (!sfi_cpufreq_num) {

Why is there a check for sfi_cpufreq_num?
Do you expect to find more than one SFI_SIG_FREQ,
and here you are implementing a policy of using the 1st
and ignoring the 2nd?

> +               sfi_cpufreq_num = SFI_GET_NUM_ENTRIES(sb,
> +                        struct sfi_freq_table_entry);
> +               pentry = (struct sfi_freq_table_entry *)sb->pentry;
> +               total_len = sfi_cpufreq_num * sizeof(*pentry);
> +               memcpy(sfi_cpufreq_array, pentry, total_len);

you went to the trouble of defining SFI_FREQ_MAX,
but I don't see a check here to make sure that you are
not copying over the end of that array...

Why are you copying the entries to sfi_cpu_freq_array[]
in the first place?  Wouldn't it be a better delete
SFI_FREQ_MAX, delete this copy, and simply read the table
entries from where they already are?

> +       }
> +
> +       return 0;
> +}
> +
> +static int sfi_processor_get_performance_states(
> +                       struct sfi_processor_performance *performance)
> +{
> +       int result = 0;
> +       int i;
> +
> +       performance->state_count = sfi_cpufreq_num;
> +       performance->states =
> +           kmalloc(sizeof(struct sfi_processor_px) * sfi_cpufreq_num,
> +                   GFP_KERNEL);
> +       if (!performance->states)
> +               result = -ENOMEM;

don't you mean *return* -ENOMEM?
If you continue here, below you're going to try to write to the structure
you just failed to allocate....

But again, unclear you need to allocate this memory in the first place...

> +
> +       /* Populate the P-states info from the SFI table */
> +       for (i = 0; i < sfi_cpufreq_num; i++) {
> +               performance->states[i].core_frequency =
> +                       sfi_cpufreq_array[i].freq_mhz;
> +               performance->states[i].transition_latency =
> +                       sfi_cpufreq_array[i].latency;
> +               performance->states[i].control =
> +                       sfi_cpufreq_array[i].ctrl_val;
> +               pr_debug("State [%d]: core_frequency[%d] transition_latency[%d] control[0x%x]\n",
> +                       i,
> +                       (u32) performance->states[i].core_frequency,
> +                       (u32) performance->states[i].transition_latency,
> +                       (u32) performance->states[i].control);
> +       }
> +
> +       return result;

It really does seem that sfi_processor_get_performance_states()
can be replaced with 1 line in your parse routine to point
performance->states to the address of the 0th entry in sfi_freq table.

> +}
> +
> +static int sfi_processor_register_performance(
> +                       struct sfi_processor_performance *performance)
> +{
> +       mutex_lock(&performance_mutex);
> +
> +       /* parse the freq table from SFI */
> +       sfi_cpufreq_num = 0;
> +       sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, parse_freq);

why do you ignore sfi_table_parse()'s possible error return value?

> +
> +       sfi_processor_get_performance_states(performance);

again, should look at error return values,
but even better to delete the called routine entirely.

> +
> +       mutex_unlock(&performance_mutex);
> +
> +       return 0;
> +}
> +
> +void sfi_processor_unregister_performance(
> +                       struct sfi_processor_performance *performance)
> +{
> +       mutex_lock(&performance_mutex);
> +       kfree(performance->states);
> +       mutex_unlock(&performance_mutex);
> +}
> +
> +static unsigned extract_freq(u32 msr, unsigned int cpu)

delete this routine.

> +{
> +       struct cpufreq_frequency_table *pos;
> +       struct sfi_processor_performance *perf;
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, cpu);
> +       u32 sfi_ctrl;
> +
> +       msr &= INTEL_MSR_BUSRATIO_MASK;
> +       perf = data->sfi_data;
> +
> +       cpufreq_for_each_entry(pos, data->freq_table) {
> +               sfi_ctrl = perf->states[pos->driver_data].control
> +                       & INTEL_MSR_BUSRATIO_MASK;
> +               if (sfi_ctrl == msr)
> +                       return pos->frequency;
> +       }
> +       return data->freq_table[0].frequency;
> +}
> +
> +static u32 get_cur_val(const struct cpumask *mask)
> +{

delete this routine

> +       u32 val, dummy;
> +
> +       if (unlikely(cpumask_empty(mask)))
> +               return 0;
> +
> +       rdmsr_on_cpu(cpumask_any(mask), MSR_IA32_PERF_STATUS, &val, &dummy);
> +
> +       return val;
> +}
> +
> +static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
> +{

replace this routine with one that
simply returns the latest requested freq on that cpu.
or if you want to get fancy, calculate actual average frequency
like intel_pstate.c does.

> +       return extract_freq(get_cur_val(cpumask_of(cpu)), cpu);
> +}
> +
> +static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> +                               unsigned int index)
> +{
> +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> +       struct sfi_processor_performance *perf;
> +       unsigned int next_perf_state = 0; /* Index into perf table */
> +       u32 lo, hi;
> +
> +       perf = data->sfi_data;
> +       next_perf_state = data->freq_table[index].driver_data;
> +
> +       rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> +       lo = (lo & ~INTEL_MSR_RANGE) |
> +               ((u32) perf->states[next_perf_state].control & INTEL_MSR_RANGE);
> +       wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
> +
> +       perf->state = next_perf_state;
> +
> +       return 0;
> +}
> +
> +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> +{
> +       unsigned int i, result = 0, valid_states = 0;
> +       unsigned int cpu = policy->cpu;
> +       struct sfi_cpufreq_data *data;
> +       struct sfi_processor_performance *perf;
> +
> +       data = kzalloc(sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->sfi_data = per_cpu_ptr(sfi_perf_data, cpu);
> +       per_cpu(drv_data, cpu) = data;
> +
> +       result = sfi_processor_register_performance(data->sfi_data);
> +       if (result)
> +               goto err_free;
> +
> +       perf = data->sfi_data;
> +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> +
> +       /* capability check */
> +       if (perf->state_count <= 1) {

yes, I know you copied this from acpi-cpufreq.c, but
wouldn't it make more sense for register_performance(), which discovers
the number of states and makes the allocation, to handle this internally
and simply return success/fail?

> +               pr_err("No P-States\n");
> +               result = -ENODEV;
> +               goto err_unreg;
> +       }
> +
...

thanks,
Len Brown, Intel Open Source Technology Center
