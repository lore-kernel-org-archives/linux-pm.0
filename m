From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v4 2/2] CPPC: Add CPUFreq driver based on CPPC methods
Date: Mon, 11 May 2015 13:35:39 -0400
Message-ID: <CAJ5Y-eZzfkXOm4t_+7aNhoTuaLe58TXUvAs3QzJARjLNh1mO7w@mail.gmail.com>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
	<1422392638-31334-3-git-send-email-ashwin.chaugule@linaro.org>
	<13016106.2mAMigVNLP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35504 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbEKRfk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 13:35:40 -0400
Received: by obcus9 with SMTP id us9so75793751obc.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 10:35:40 -0700 (PDT)
In-Reply-To: <13016106.2mAMigVNLP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "rwells@codeaurora.org" <rwells@codeaurora.org>, Linda Knippers <linda.knippers@hp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Patch Tracking <patches@linaro.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>

Hi Rafael,


On 8 May 2015 at 18:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, January 27, 2015 04:03:58 PM Ashwin Chaugule wrote:
>> CPPC stands for Collaborative Processor Performance Controls
>> and is defined in the ACPI v5.0+ spec. It describes CPU
>> performance controls on an abstract and continuous scale
>> allowing the platform (e.g. remote power processor) to flexibly
>> optimize CPU performance with its knowledge of power budgets
>> and other architecture specific knowledge.
>>
>> This patch introduces a CPUFreq driver which works with
>> existing CPUFreq governors. The backend CPPC methods for
>> parsing the CPPC table and reading/writing using CPPC semantics
>> are abstracted away such that they can be used by any other CPPC
>> based CPUFreq driver in the future.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>
> I promised to review this one (long ago, sorry about that).

Thanks for your time!


>> +
>> +     /* Wait till platform processes command. */
>> +     udelay(cmd_latency);
>> +
>> +     if (!(readw_relaxed(&generic_comm_base->status)
>> +                 & PCC_CMD_COMPLETE))
>> +             mbox_client_txdone(pcc_channel, -EIO);
>> +     else
>> +             /* Success */
>> +             mbox_client_txdone(pcc_channel, 0);
>
> What about doing
>
>         int result;
>
>         result = readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE ? 0 : -EIO;
>         mbox_client_txdone(pcc_channel, result);

Looks cleaner.

>
>> +
>> +     return 0;
>
> Why do we want to return 0 even if 'result' is not 0?

I'd fixed this locally, by putting a retry loop around the
readw_relaxed() and returning an error if the PCC command doesn't
complete. That would indicate a possible crash on the remote
processor.

>
>> +}
>> +
>> +static void cppc_chan_tx_done(struct mbox_client *cl, void *mssg, int ret)
>> +{
>> +     if (!ret)
>> +             pr_debug("CPPC TX completed. CMD sent = %x, ret = %d\n",
>> +                             *(u16 *)mssg, ret);
>> +     else
>> +             pr_warn("CPPC TX did not complete: CMD sent = %x, ret = %d\n",
>> +                             *(u16 *)mssg, ret);
>
> Should that be pr_debug() too?  Also I'd prefer the
>
>         if (ret) ... else ...
>
> ordering as it avoids the extra logical negation.

Fixed locally.

>> +
>> +/* XXX: Temp adaptation from processor_perflib.c
>> + * until we get ACPI CPU idle support on ARM64.
>> + */
>> +
>> +static int acpi_get_psd(struct cpudata *pr)
>> +{
>> +     int result = 0;
>> +     acpi_status status = AE_OK;
>> +     struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
>> +     struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
>> +     struct acpi_buffer state = {0, NULL};
>> +     union acpi_object  *psd = NULL;
>> +     struct acpi_psd_package *pdomain;
>> +     acpi_handle handle;
>> +     char proc_name[11];
>> +
>> +     sprintf(proc_name, "\\_PR.CPU%d", pr->cpu);
>> +
>> +     status = acpi_get_handle(NULL, proc_name, &handle);
>> +     if (ACPI_FAILURE(status))
>> +             return -ENODEV;
>> +
>> +     status = acpi_evaluate_object(handle, "_PSD", NULL, &buffer);
>> +     if (ACPI_FAILURE(status))
>> +             return -ENODEV;
>> +
>> +     psd = buffer.pointer;
>> +     if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
>> +             pr_err("Invalid _PSD data\n");
>
> _debug(), please?  And what about using acpi_handle_debug() for that matter?

>> +             result = -EFAULT;
>
> -ENODATA would be better.
>
>> +             goto end;
>> +     }
>> +
>> +     if (psd->package.count != 1) {
>> +             pr_err("Invalid _PSD data\n");
>> +             result = -EFAULT;
>
> Likewise.  And below too.

Ok. (All this came from processor_perflib.c)

>> +int acpi_get_psd_map(struct cpudata **all_cpu_data)
>> +{
>> +     int count_target;
>> +     int retval = 0;
>> +     unsigned int i, j;
>> +     cpumask_var_t covered_cpus;
>> +     struct cpudata *pr;
>> +     struct acpi_psd_package *pdomain;
>> +     struct cpudata *match_pr;
>> +     struct acpi_psd_package *match_pdomain;
>> +
>> +     if (!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL))
>> +             return -ENOMEM;
>> +
>> +     /* Call _PSD for all CPUs */
>> +     for_each_online_cpu(i) {
>
> Why do we do that for online CPUs only?

I've changed this to for_each_possible_cpu(). I was experimenting with
some "partial goods" scenarios. More on that later.

>
>> +             pr = all_cpu_data[i];
>> +             if (!pr)
>> +                     continue;
>> +
>> +             if (!zalloc_cpumask_var_node(&pr->shared_cpu_map,
>> +                                     GFP_KERNEL, cpu_to_node(pr->cpu))) {
>> +                     pr_err("No mem for shared_cpus cpumask\n");
>
> Again, this doesn't need to be an error-level kernel message.  And please say
> "memory" instead of "mem".

Ok. (Came from processor_perflib.c)


>> +
>> +                     match_pr->shared_type =
>> +                                     pr->shared_type;
>
>
> Line break not needed here.

Ok.

>
>> +                     cpumask_copy(match_pr->shared_cpu_map,
>> +                                  pr->shared_cpu_map);
>> +             }
>> +     }
>> +
>> +err_ret:
>> +     for_each_online_cpu(i) {
>> +             pr = all_cpu_data[i];
>> +             if (!pr)
>> +                     continue;
>> +
>> +             /* Assume no coordination on any error parsing domain info */
>> +             if (retval) {
>> +                     cpumask_clear(pr->shared_cpu_map);
>> +                     cpumask_set_cpu(i, pr->shared_cpu_map);
>> +                     pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
>> +             }
>> +     }
>> +
>> +     free_cpumask_var(covered_cpus);
>> +     return retval;
>> +}
>> +EXPORT_SYMBOL(acpi_get_psd_map);
>> +
>> +/**
>> + * acpi_cppc_processor_probe -
>
> No line break here, please and this should be a single line.

Ok.
>

>> +                                     };
>> +                     } else {
>> +                             pr_err("Error in entry:%d in CPC table.\n", i);
>
> Again, lower message lever.
>
>> +                             ret = -EINVAL;
>
> -EINVAL means "invalid argument".  Is this what you want here?

Its an argument from the CPC table. :)
Happy to replace with anything else.


>> +
>> +     /* PCC communication addr space begins at byte offset 0x8. */
>> +     if (is_pcc == true)
>
> Ugh.
>
>> +             addr = (u64)pcc_comm_addr + 0x8 + reg->cpc_entry.reg.address;
>> +     else
>> +             addr = reg->cpc_entry.reg.address;
>
>
> What about
>
>         addr = is_pcc ? (u64)pcc_comm_addr + 0x8 + reg->cpc_entry.reg.address :
>                         reg->cpc_entry.reg.address;
>

Much better. Thanks!


>> +
>> +     if (reg->type == ACPI_TYPE_BUFFER) {
>> +             switch (reg->cpc_entry.reg.bit_width) {
>> +             case 8:
>> +                     if (cmd == CMD_READ)
>> +                             read_val = readb((void *) (addr));
>> +                     else if (cmd == CMD_WRITE)
>> +                             writeb(write_val, (void *)(addr));
>> +                     else
>> +                             pr_err("Unsupported cmd type: %d\n", cmd);
>
> Please reduce the log level of *all* debug messages in this patch.  Also please
> add information allowing whoever reads those messages to identify the affected
> device in the first place to all of them.

Yep. Added a pr_fmt and reduced a lot of prints.


>> + */
>> +int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> +     struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
>> +                                  *nom_perf;
>> +     u64 min, max, ref, nom;
>> +     bool is_pcc = false;
>> +
>> +     if (!cpc_desc) {
>> +             pr_err("No CPC descriptor for CPU:%d\n", cpunum);
>> +             return -ENODEV;
>> +     }
>> +
>> +     highest_reg = &cpc_desc->cpc_regs[HIGHEST_PERF];
>> +     lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
>> +     ref_perf = &cpc_desc->cpc_regs[REFERENCE_PERF];
>> +     nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
>> +
>> +     spin_lock(&pcc_lock);
>
> Don't you need to disable interrupts here?

I don't see the case where IRQs could affect this path.

>
>> +
>> +     /* Are any of the regs PCC ?*/
>> +     if ((highest_reg->cpc_entry.reg.space_id ==
>> +                             ACPI_ADR_SPACE_PLATFORM_COMM) ||
>> +                     (lowest_reg->cpc_entry.reg.space_id ==
>> +                      ACPI_ADR_SPACE_PLATFORM_COMM) ||
>> +                     (ref_perf->cpc_entry.reg.space_id ==
>> +                      ACPI_ADR_SPACE_PLATFORM_COMM) ||
>> +                     (nom_perf->cpc_entry.reg.space_id ==
>> +                      ACPI_ADR_SPACE_PLATFORM_COMM))
>> +             is_pcc = true;
>> +
>> +     if (is_pcc == true) {
>
> Again.  Please do
>
>         if (is_pcc) {

Done.


>> +     return 0;
>> +}
>> +EXPORT_SYMBOL(cppc_get_perf_caps);
>
> EXPORT_SYMBOL_GPL(), please.
>
> Here and elsewhere.

Done.


>> diff --git a/drivers/cpufreq/cppc_acpi.h b/drivers/cpufreq/cppc_acpi.h
>> new file mode 100644
>> index 0000000..a6c7ff6
>> --- /dev/null
>> +++ b/drivers/cpufreq/cppc_acpi.h
>> @@ -0,0 +1,134 @@
>> +/*
>> + * CPPC (Collaborative Processor Performance Control) methods used
>> + * by CPUfreq drivers.
>> + *
>> + * (C) Copyright 2014 Linaro Ltd.
>> + * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; version 2
>> + * of the License.
>> + */
>> +
>> +#ifndef _CPPC_ACPI_H
>> +#define _CPPC_ACPI_H
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/mailbox_controller.h>
>> +#include <linux/mailbox_client.h>
>> +#include <linux/types.h>
>> +
>> +#include <acpi/processor.h>
>> +
>> +#define PCC_CMD_COMPLETE 1
>> +#define MAX_CPC_REG_ENT 19
>> +
>> +/* CPPC specific PCC commands. */
>> +#define      CMD_READ 0
>> +#define      CMD_WRITE 1
>> +
>> +/* Each register has the folowing format. */
>> +struct cpc_reg {
>> +     u8 descriptor;
>> +     u16 length;
>> +     u8 space_id;
>> +     u8 bit_width;
>> +     u8 bit_offset;
>> +     u8 access_width;
>> +     u64 __iomem address;
>> +} __packed;
>> +
>> +/*
>> + * Each entry in the CPC table is either
>> + * of type ACPI_TYPE_BUFFER or
>> + * ACPI_TYPE_INTEGER.
>> + */
>> +struct cpc_register_resource {
>> +     acpi_object_type type;
>> +     union {
>> +             struct cpc_reg reg;
>> +             u64 int_value;
>> +     } cpc_entry;
>> +};
>> +
>> +/* Container to hold the CPC details for each CPU */
>> +struct cpc_desc {
>> +     int num_entries;
>> +     int version;
>> +     struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
>> +};
>> +
>> +/* These are indexes into the per-cpu cpc_regs[]. Order is important. */
>> +enum cppc_regs {
>> +     HIGHEST_PERF,
>> +     NOMINAL_PERF,
>> +     LOW_NON_LINEAR_PERF,
>> +     LOWEST_PERF,
>> +     GUARANTEED_PERF,
>> +     DESIRED_PERF,
>> +     MIN_PERF,
>> +     MAX_PERF,
>> +     PERF_REDUC_TOLERANCE,
>> +     TIME_WINDOW,
>> +     CTR_WRAP_TIME,
>> +     REFERENCE_CTR,
>> +     DELIVERED_CTR,
>> +     PERF_LIMITED,
>> +     ENABLE,
>> +     AUTO_SEL_ENABLE,
>> +     AUTO_ACT_WINDOW,
>> +     ENERGY_PERF,
>> +     REFERENCE_PERF,
>> +};
>> +
>> +/*
>> + * Categorization of registers as described
>> + * in the ACPI v.5.1 spec.
>> + * XXX: Only filling up ones which are used by governors
>> + * today.
>> + */
>> +struct cppc_perf_caps {
>> +     u32 highest_perf;
>> +     u32 nominal_perf;
>> +     u32 reference_perf;
>> +     u32 lowest_perf;
>> +};
>> +
>> +struct cppc_perf_ctrls {
>> +     u32 max_perf;
>> +     u32 min_perf;
>> +     u32 desired_perf;
>> +};
>> +
>> +struct cppc_perf_fb_ctrs {
>> +     u64 reference;
>> +     u64 prev_reference;
>> +     u64 delivered;
>> +     u64 prev_delivered;
>> +};
>> +
>> +/* Per CPU container for runtime CPPC management. */
>> +struct cpudata {
>> +     int cpu;
>> +     struct cppc_perf_caps perf_caps;
>> +     struct cppc_perf_ctrls perf_ctrls;
>> +     struct cppc_perf_fb_ctrs perf_fb_ctrs;
>> +     struct cpufreq_policy *cur_policy;
>> +     struct acpi_psd_package domain_info;
>> +     unsigned int shared_type;
>> +     cpumask_var_t shared_cpu_map;
>> +};
>> +
>
> Shouldn't the above definitions go into ACPICA?

I thought about moving this into include/acpi/processor.h along with
all the _PSS etc. stuff. But frankly I'm not sure. For now, I've moved
the cppc_acpi.[c,h] files into drivers/acpi/ and conditionally compile
them via a Kconfig option which is enabled only if
CONFIG_ACPI_PSS(new) is disabled. This is along the lines of what I
wrote in reply to Sudeep's patch[1]. I'd really like to know your
opinions on that approach.

Thanks,
Ashwin.

[1] - http://www.spinics.net/lists/linux-acpi/msg57374.html
