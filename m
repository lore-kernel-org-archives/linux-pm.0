From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Thu, 9 Oct 2014 00:44:54 +0530
Message-ID: <20141008191454.GA6504@intel-desktop>
References: <20141007140734.GB24200@intel-desktop>
 <CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20675 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbaJHLPR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Oct 2014 07:15:17 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpokLcZPcMUjXYNNxDcwHUzsL1ejYBYd0cDmnAHQu+cBYGA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, vishwesh.m.rudramuni@intel.com, srinidhi.kasagar@intel.com

The author is on vacation, let me take some of your comments as i'm in the
delivery path..

On Tue, Oct 07, 2014 at 03:52:42PM +0530, Viresh Kumar wrote:
> Adding Dirk as well..
> 
> On 7 October 2014 19:37, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> > From b3037348db47f0629316dd0027c7f1a1b28be959 Mon Sep 17 00:00:00 2001
> > From: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> > Date: Fri, 12 Sep 2014 22:52:37 +0530
> > Subject: [PATCH] cpufreq: Add sfi based cpufreq driver support
> 
> You didn't use git send-email ?

No, looks like it is broken. Will fix it anyway.

> 
> > This adds the sfi based cpu freq driver for some of the
> > Intel's Silver Mont based atom architectures like
> > Merrifield and Moorfield (intel-mid)
> >
> > Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
> > Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> > ---
> >  drivers/cpufreq/Kconfig.x86   |   10 +
> >  drivers/cpufreq/Makefile      |    1 +
> >  drivers/cpufreq/sfi-cpufreq.c |  426 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cpufreq/sfi-cpufreq.h |   53 +++++
> >  4 files changed, 490 insertions(+)
> >  create mode 100644 drivers/cpufreq/sfi-cpufreq.c
> >  create mode 100644 drivers/cpufreq/sfi-cpufreq.h
> >
> > diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
> > index 89ae88f91895..3d6886b558fa 100644
> > --- a/drivers/cpufreq/Kconfig.x86
> > +++ b/drivers/cpufreq/Kconfig.x86
> > @@ -57,6 +57,16 @@ config X86_ACPI_CPUFREQ_CPB
> >           By enabling this option the acpi_cpufreq driver provides the old
> >           entry in addition to the new boost ones, for compatibility reasons.
> >
> > +config X86_SFI_CPUFREQ
> > +       tristate "SFI Processor P-States driver"
> > +       depends on X86_INTEL_MID && SFI
> > +       help
> > +         This driver adds a CPUFreq driver which utilizes the SFI
> 
> s/This driver/This/

Thanks, will fix.

> 
> > +         Processor Performance States enumeration on some Silver Mont
> > +         based Intel Atom architecture (like intel-mid)
> 
> Looks like the sentence isn't complete here, would you like to?

This is good enough..let me rephrase it.


> 
> > +
> > +         If in doubt, say N.
> > +
> >  config ELAN_CPUFREQ
> >         tristate "AMD Elan SC400 and SC410"
> >         depends on MELAN
> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> > index db6d9a2fea4d..c3b51efd4a85 100644
> > --- a/drivers/cpufreq/Makefile
> > +++ b/drivers/cpufreq/Makefile
> > @@ -41,6 +41,7 @@ obj-$(CONFIG_X86_P4_CLOCKMOD)         += p4-clockmod.o
> >  obj-$(CONFIG_X86_CPUFREQ_NFORCE2)      += cpufreq-nforce2.o
> >  obj-$(CONFIG_X86_INTEL_PSTATE)         += intel_pstate.o
> >  obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY) += amd_freq_sensitivity.o
> > +obj-$(CONFIG_X86_SFI_CPUFREQ)          += sfi-cpufreq.o
> >
> >  ##################################################################################
> >  # ARM SoC drivers
> > diff --git a/drivers/cpufreq/sfi-cpufreq.c b/drivers/cpufreq/sfi-cpufreq.c
> > new file mode 100644
> > index 000000000000..1400e0387528
> > --- /dev/null
> > +++ b/drivers/cpufreq/sfi-cpufreq.c
> > @@ -0,0 +1,426 @@
> > +/*
> > + *  sfi_cpufreq.c - sfi Processor P-States Driver
> 
> No need of mentioning file name here.

Thanks for spotting..these are all left over stuffs from the original code.
Let me clean up further..

> 
> > + *  Based on ACPI Processor P-States Driver
> > + *
> 
> How much different is it from that ? Sorry I haven't checked :(
> 
> I mean, will it be possible to make changes to acpi-cpufreq driver or
> get the common part out?

I dont think so. That is ACPI, this one is SFI. Both are architecturally not
aligned.

> 
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; either version 2 of the License.
> > + *
> > + *  This program is distributed in the hope that it will be useful, but
> > + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  General Public License for more details.
> > + *
> > + *  Author: Vishwesh M Rudramuni <vishwesh.m.rudramuni@intel.com>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/smp.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/slab.h>
> > +#include <linux/sfi.h>
> 
> Keep them in ascending order please.

Hm..Will fix.

> 
> > +#include <asm/msr.h>
> > +#include <asm/processor.h>
> > +
> > +#include "sfi-cpufreq.h"
> 
> Do you plan to share the definitions here with any other file? If no, please
> merge the .h file here only.

No, will fix it.

> 
> > +#define SFI_FREQ_MAX           32
> > +#define INTEL_MSR_RANGE                0xffff
> > +#define INTEL_MSR_BUSRATIO_MASK        0xff00
> > +#define SFI_CPU_MAX            8
> 
> Aligning the values in a single column is preferred for readability.

I did, not sure how it got realigned. Let me take a look.


[...]

> > +}
> > +
> > +static int sfi_cpufreq_target(struct cpufreq_policy *policy,
> > +                               unsigned int index)
> > +{
> > +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> > +       struct sfi_processor_performance *perf;
> > +       unsigned int next_perf_state = 0; /* Index into perf table */
> > +       u32 lo, hi;
> 
> You meant unsigned int only?

Yes.

> 
> > +
> > +       if (unlikely(data == NULL ||
> > +            data->sfi_data == NULL || data->freq_table == NULL)) {
> > +               return -ENODEV;
> > +       }
> 
> Probably this looks better:
>        if (unlikely(!data || !data->sfi_data || !data->freq_table))
>                return -ENODEV;

Why not?

> 
> But do we need this check at all ? Also same comments for similar usage
> in above routines.

Not really..Will remove these stuffs. 

> 
> > +
> > +       perf = data->sfi_data;
> > +       next_perf_state = data->freq_table[index].driver_data;
> > +       if (perf->state == next_perf_state) {
> 
> Can this happen? Probably cpufreq core will never do it ?

I think it did. Let me keep this.

> 
> > +               if (unlikely(data->resume)) {
> > +                       pr_debug("Called after resume, resetting to P%d\n",
> > +                               next_perf_state);
> > +                       data->resume = 0;
> > +               } else {
> > +                       pr_debug("Already at target state (P%d)\n",
> > +                               next_perf_state);
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       rdmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, &lo, &hi);
> > +       lo = (lo & ~INTEL_MSR_RANGE) |
> > +               ((u32) perf->states[next_perf_state].control & INTEL_MSR_RANGE);
> > +       wrmsr_on_cpu(policy->cpu, MSR_IA32_PERF_CTL, lo, hi);
> > +
> > +       perf->state = next_perf_state;
> > +
> > +       return 0;
> > +}
> > +
> > +static int sfi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> > +{
> > +       unsigned int i;
> > +       unsigned int valid_states = 0;
> > +       unsigned int cpu = policy->cpu;
> > +       struct sfi_cpufreq_data *data;
> > +       unsigned int result = 0;
> 
> Can merge all definitions of similar data type in a single line.

Why not?

> 
> > +       struct sfi_processor_performance *perf;
> > +       struct sfi_processor *pr;
> > +
> > +       pr = kzalloc(sizeof(struct sfi_processor), GFP_KERNEL);
> 
> sizeof(*pr)

Style issues. Will fix.

> 
> > +       if (!pr)
> > +               return -ENOMEM;
> > +
> > +       per_cpu(sfi_processors, cpu) = pr;
> > +
> > +       pr_debug("sfi_cpufreq_cpu_init CPU:%d\n", policy->cpu);
> 
> I would prefer
> pr_debug("%s: CPU:%d\n", __func__, policy->cpu);

Me too. Will fix.

> 
> > +
> > +       data = kzalloc(sizeof(struct sfi_cpufreq_data), GFP_KERNEL);
> 
> sizeof(*data)

ditto..

> 
> > +       if (!data)
> > +               return -ENOMEM;
> 
> What about freeing pr ?

My bad. Will fix.

> 
> > +
> > +       data->sfi_data = per_cpu_ptr(sfi_perf_data, cpu);
> > +       per_cpu(drv_data, cpu) = data;
> > +
> > +       sfi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
> 
> Why here? and not in the structure definition itself..

Hmm..another legacy style. Will add it in the definition rather..Thanks. 

> 
> > +
> > +       result = sfi_processor_register_performance(data->sfi_data, cpu);
> > +       if (result)
> > +               goto err_free;
> > +
> > +       perf = data->sfi_data;
> > +       policy->shared_type = CPUFREQ_SHARED_TYPE_HW;
> > +
> > +       cpumask_set_cpu(policy->cpu, policy->cpus);
> > +       cpumask_set_cpu(policy->cpu, policy->related_cpus);
> 
> You don't have to set related_cpus, its done by core. Also policy->cpus
> is already set by core to policy->cpu.

Yes, Will fix.

> 
> > +
> > +       /* capability check */
> > +       if (perf->state_count <= 1) {
> > +               pr_debug("No P-States\n");
> > +               result = -ENODEV;
> > +               goto err_unreg;
> > +       }
> > +
> > +       data->freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
> 
> sizeof (*data->freq_table)

ok..

> 
> Also, you want to do kzalloc? or kmalloc will work as well ?

kmalloc makes my table corrupted, perhaps the addition of new flag variable.
Let me keep kzalloc.

> 
> > +                   (perf->state_count+1), GFP_KERNEL);
> > +       if (!data->freq_table) {
> > +               result = -ENOMEM;
> > +               goto err_unreg;
> > +       }
> > +
> > +       /* detect transition latency */
> > +       policy->cpuinfo.transition_latency = 0;
> > +       for (i = 0; i < perf->state_count; i++) {
> > +               if ((perf->states[i].transition_latency * 1000) >
> > +                   policy->cpuinfo.transition_latency)
> > +                       policy->cpuinfo.transition_latency =
> > +                           perf->states[i].transition_latency * 1000;
> > +       }
> > +
> > +       /* initialize the freq table */
> > +       for (i = 0; i < perf->state_count; i++) {
> > +               if (i > 0 && perf->states[i].core_frequency >=
> > +                   data->freq_table[valid_states-1].frequency / 1000)
> > +                       continue;
> 
> What are you doing here ?

This is unncessary check, not needed. Again a left over stuff. Will clean it.

> 
> > +
> > +               data->freq_table[valid_states].driver_data = i;
> > +               data->freq_table[valid_states].frequency =
> > +                   perf->states[i].core_frequency * 1000;
> > +               valid_states++;
> > +       }
> > +       data->freq_table[valid_states].frequency = CPUFREQ_TABLE_END;
> > +       perf->state = 0;
> > +
> > +       result = cpufreq_table_validate_and_show(policy, data->freq_table);
> > +       if (result)
> > +               goto err_freqfree;
> > +
> > +       policy->cur = get_cur_freq_on_cpu(cpu);
> 
> This is done by core and so you need to do it.

Agree. Will remove.


> 
> > +       pr_debug("CPU%u - SFI performance management activated.\n", cpu);
> > +       for (i = 0; i < perf->state_count; i++)
> > +               pr_debug("     %cP%d: %d MHz, %d uS\n",
> > +                       (i == perf->state ? '*' : ' '), i,
> > +                       (u32) perf->states[i].core_frequency,
> > +                       (u32) perf->states[i].transition_latency);
> 
> What about printing this in the above for loop only?

Why not?

> 
> > +
> > +       data->resume = 1;
> > +
> > +       return result;
> > +
> > +err_freqfree:
> > +       kfree(data->freq_table);
> > +err_unreg:
> > +       sfi_processor_unregister_performance(perf, cpu);
> > +err_free:
> > +       kfree(data);
> > +       per_cpu(drv_data, cpu) = NULL;
> 
> Free pr ?

My bad. Wilf fix

> 
> > +
> > +       return result;
> > +}
> > +
> > +static int sfi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
> > +{
> > +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> > +       struct sfi_processor *pr = per_cpu(sfi_processors, policy->cpu);
> > +
> > +       pr_debug("sfi_cpufreq_cpu_exit\n");
> > +
> > +       if (data) {
> 
> Why will data be NULL here ?

Perhaps to satisfy the static code check tools. Will remove.

> 
> > +               per_cpu(drv_data, policy->cpu) = NULL;
> > +               sfi_processor_unregister_performance(data->sfi_data,
> > +                                               policy->cpu);
> > +               kfree(data->freq_table);
> > +               kfree(data);
> > +               kfree(pr);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int sfi_cpufreq_resume(struct cpufreq_policy *policy)
> > +{
> > +       struct sfi_cpufreq_data *data = per_cpu(drv_data, policy->cpu);
> 
> Your code is dependent on policy->cpu at multiple places and it can change on
> CPU hotplug. You should worry about it only if there can be more than one CPU
> in a single policy, which doesn't look like the case.

Not sure what do you mean by not using policy->cpu. I need all of these
to support hotplug. Can you elaborate if you mean otherwise please?

> 
> Also there is a patch from Thomas Petazzoni
> [PATCHv2 1/4] cpufreq: allow driver-specific data
> https://www.mail-archive.com/linux-arm-msm@vger.kernel.org/msg10696.html
> 
> you can use that for data.
> 
> > +
> > +       pr_debug("sfi_cpufreq_resume\n");
> > +
> > +       data->resume = 1;
> > +
> > +       return 0;
> > +}
> > +
> > +static struct freq_attr *sfi_cpufreq_attr[] = {
> > +       &cpufreq_freq_attr_scaling_available_freqs,
> > +       NULL,
> > +};
> 
> Can reuse cpufreq_generic_attr ??

We should be using that. Will fix.

> 
> > +
> > +static struct cpufreq_driver sfi_cpufreq_driver = {
> > +       .get = get_cur_freq_on_cpu,
> > +       .verify = cpufreq_generic_frequency_table_verify,
> > +       .target_index = sfi_cpufreq_target,
> > +       .init = sfi_cpufreq_cpu_init,
> > +       .exit = sfi_cpufreq_cpu_exit,
> > +       .resume = sfi_cpufreq_resume,
> > +       .name = "sfi-cpufreq",
> > +       .attr = sfi_cpufreq_attr,
> > +};
> > +
> > +static int __init sfi_cpufreq_init(void)
> > +{
> > +       sfi_perf_data = alloc_percpu(struct sfi_processor_performance);
> > +       if (!sfi_perf_data) {
> > +               pr_debug("Memory allocation error for sfi_perf_data.\n");
> 
> Shouldn't this be pr_err ??

Yes. Will fix.

> 
> > +               return -ENOMEM;
> > +       }
> > +
> > +       return cpufreq_register_driver(&sfi_cpufreq_driver);
> > +}
> > +
> > +static void __exit sfi_cpufreq_exit(void)
> > +{
> > +       struct sfi_processor *pr;
> > +
> > +       pr = per_cpu(sfi_processors, 0);
> > +       kfree(pr);
> 
> What about: kfree(per_cpu(sfi_processors, 0)); instead of above 4 lines.
> Also why here when its already done in sfi_cpufreq_cpu_exit ?

I think it is not required. Will remove them.

> 
> > +
> > +       cpufreq_unregister_driver(&sfi_cpufreq_driver);
> > +
> > +       free_percpu(sfi_perf_data);
> > +}
> > +late_initcall(sfi_cpufreq_init);
> > +module_exit(sfi_cpufreq_exit);
> 
> Normally we add them just below the respective routines.

Some prefer like this :)

> 
> > +
> > +MODULE_ALIAS("sfi");
> > +MODULE_AUTHOR("Vishwesh Rudramuni");
> 
> Can add email address as well..

Yes..Will add.

Srinidhi
