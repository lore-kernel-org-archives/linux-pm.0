From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v8 4/9] ACPI: Introduce CPU performance controls using CPPC
Date: Thu, 27 Aug 2015 11:48:55 -0400
Message-ID: <CAJ5Y-ea9rna+T1sM1AnUtq6hAoRmJ4yU7PMQrBYwNFaqnsztig@mail.gmail.com>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
	<93681be9e10a2977c9b70ec1e52e0eccb25e081c.1438781668.git.ashwin.chaugule@linaro.org>
	<5149112.uli93SOdxV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:36298 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207AbbH0Ps5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 11:48:57 -0400
Received: by labia3 with SMTP id ia3so15393305lab.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2015 08:48:55 -0700 (PDT)
In-Reply-To: <5149112.uli93SOdxV@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Patch Tracking <patches@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "rwells@codeaurora.org" <rwells@codeaurora.org>

Hi Rafael,
On 25 August 2015 at 21:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, August 05, 2015 09:40:27 AM Ashwin Chaugule wrote:
>> CPPC stands for Collaborative Processor Performance Controls
>> and is defined in the ACPI v5.0+ spec. It describes CPU
>> performance controls on an abstract and continuous scale
>> allowing the platform (e.g. remote power processor) to flexibly
>> optimize CPU performance with its knowledge of power budgets
>> and other architecture specific knowledge.
>>
>> This patch adds a shim which exports commonly used functions
>> to get and set CPPC specific controls for each CPU. This enables
>> CPUFreq drivers to gather per CPU performance data and use
>> with exisiting governors or even allows for customized governors
>> which are implemented inside CPUFreq drivers.
>>
>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> Reviewed-by: Al Stone <al.stone@linaro.org>
>> ---
>>  drivers/acpi/Kconfig     |  14 +
>>  drivers/acpi/Makefile    |   1 +
>>  drivers/acpi/cppc_acpi.c | 812 +++++++++++++++++++++++++++++++++++++++++++++++
>>  include/acpi/cppc_acpi.h | 137 ++++++++
>>  4 files changed, 964 insertions(+)
>>  create mode 100644 drivers/acpi/cppc_acpi.c
>>  create mode 100644 include/acpi/cppc_acpi.h
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 54e9729..c6ec903 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -197,6 +197,20 @@ config ACPI_PROCESSOR_IDLE
>>       bool
>>       select CPU_IDLE
>>
>> +config ACPI_CPPC_LIB
>> +     bool
>> +     depends on ACPI_PROCESSOR
>> +     depends on !ACPI_CPU_FREQ_PSS
>> +     select MAILBOX
>> +     select PCC
>> +     help
>> +       This file implements common functionality to parse
>
> It's better to start with "If this option is enabled".

Done.

>> +/*
>> + * CPPC (Collaborative Processor Performance Control) methods used
>> + * by CPUfreq drivers.
>
> One line please.

Done.

>> + * Finer details about the PCC and CPPC spec are available in the latest
>> + * ACPI 5.1 specification.
>
> ACPI 5.1 is not the latest any more.  I'd say "ACPI 6.0 or later" to be on the
> safe side.

Done.

>> +static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>
> A description of what the per-CPU thing is and how it is used would be good
> to have here.

Done.

>
>> +
>> +/* This layer handles all the PCC specifics for CPPC. */
>> +static struct mbox_chan *pcc_channel;
>> +static void __iomem *pcc_comm_addr;
>> +static u64 comm_base_addr;
>> +static int pcc_subspace_idx = -1;
>> +static u16 pcc_cmd_delay;
>> +static int pcc_channel_acquired;
>> +
>> +#define NUM_RETRIES 500
>
> How did you get that number?

Loosely based on pcc-cpufreq.c which implements an out-of-ACPI-spec
CPPC + PCC-ish driver. I added a comment now to describe what its for.
In reality on silicon, we hope there's no more than a couple of
retries at worst, but its hard to tell whats out there.

>> +     /* Retry in case the remote processor was too slow to catch up. */
>> +     while (retries--) {
>
> It looks like this can be written as
>
>         for (retries = NUM_RETRIES; retries > 0; retries--) {
>
>> +             result = readw_relaxed(&generic_comm_base->status)
>> +                     & PCC_CMD_COMPLETE ? 0 : -EIO;
>
> I'm not sure why do you need the ternary operator here.
>
> You could just do
>
>                 if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
>                         result = 0;
>                         break;
>                 }
>
> and set "result" to -EIO beforehand.
>
>> +             if (!result) {
>> +                     /* Success. */
>> +                     retries = NUM_RETRIES;
>
> We break out of the loop in the next statement, so why is this needed?
>
> BTW, why do you need both "err" and "result"?  Why not to use "result"
> everywhere?
>

True. Done.

>
>> +                     break;
>> +             }
>> +     }
>> +
>> +     mbox_client_txdone(pcc_channel, result);
>> +     return result;
>> +}
>> +
>> +static void cppc_chan_tx_done(struct mbox_client *cl, void *mssg, int ret)
>> +{
>> +     if (ret)
>> +             pr_debug("TX did not complete: CMD sent:%x, ret:%d\n",
>> +                             *(u16 *)mssg, ret);
>> +     else
>> +             pr_debug("TX completed. CMD sent:%x, ret:%d\n",
>> +                             *(u16 *)mssg, ret);
>
> It would be good to identify the client somehow in these messages.  Otherwise
> they may not be quite useful.
>

For more details, I'd have to pack the CPU id in the PCC cmd field and
unpack it here. But from the PCC point of view, CPPC as a whole is a
client, so the pr_fmt prefix at least helps to identify it. Seemed
helpful enough for debug so far.

>> +     psd = buffer.pointer;
>> +     if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
>> +             pr_err("Invalid _PSD data\n");
>> +             result = -ENODATA;
>> +             goto end;
>> +     }
>
> acpi_evaluate_object_typed() can be used here and then you save one "if".
>

Ok. I suppose it helps readability here, although that function has
many more if's inside it. :)

>> +
>> +     if (psd->package.count != 1) {
>> +             pr_err("Invalid _PSD data\n");
>> +             result = -ENODATA;
>> +             goto end;
>> +     }
>> +
>> +     pdomain = &(cpc_ptr->domain_info);
>> +
>> +     state.length = sizeof(struct acpi_psd_package);
>> +     state.pointer = pdomain;
>> +
>
> So beyond this point, if there's an error, you always set "result" to -ENODATA.
> Why not to set it to -ENODATA upfront and then reset it to 0 on success only?
> That would save you a bunch of statements.

True. Done.

>
>> +     status = acpi_extract_package(&(psd->package.elements[0]),
>> +             &format, &state);
>> +     if (ACPI_FAILURE(status)) {
>> +             pr_err("Invalid _PSD data\n");
>
> Why is that error priority and what can users see from the error message?
>
> Same pretty much everywhere below?
>

So, I ported all this PSD stuff over from processor_perflib.c assuming
it "just works" there. FWIW I couldn't reuse that function since it is
tied too closely to _PSS structures. This err would indicate the PSD
package itself is screwed up, otherwise the errs below indicate
specific entries within PSD could be wrong. I'll make them pr_debugs
here though.

>> +             result = -ENODATA;
>> +             goto end;
>> +     }
>> +
>> +     if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
>> +             pr_err("Unknown _PSD:num_entries\n");
>> +             result = -ENODATA;
>> +             goto end;
>> +     }
>> +
>> +     if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
>> +             pr_err("Unknown _PSD:revision\n");
>> +             result = -ENODATA;
>> +             goto end;
>> +     }
>> +
>> +     if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
>> +         pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
>> +         pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
>> +             pr_err("Invalid _PSD:coord_type\n");
>> +             result = -ENODATA;
>> +             goto end;
>> +     }
>> +end:
>> +     kfree(buffer.pointer);
>> +     return result;
>> +}
>> +
>> +int acpi_get_psd_map(struct cpudata **all_cpu_data)
>> +{
>> +     int count_target;
>> +     int retval = 0;
>> +     unsigned int i, j;
>> +     cpumask_var_t covered_cpus;
>> +     struct cpudata *pr, *match_pr;
>> +     struct acpi_psd_package *pdomain;
>> +     struct acpi_psd_package *match_pdomain;
>> +     struct cpc_desc *cpc_ptr, *match_cpc_ptr;
>> +
>> +     if (!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL))
>> +             return -ENOMEM;
>> +
>> +     /*
>> +      * Now that we have _PSD data from all CPUs, lets setup P-state
>> +      * domain info.
>> +      */
>> +     for_each_possible_cpu(i) {
>> +             pr = all_cpu_data[i];
>> +             if (!pr)
>> +                     continue;
>> +
>> +             if (cpumask_test_cpu(i, covered_cpus))
>> +                     continue;
>> +
>> +             cpc_ptr = per_cpu(cpc_desc_ptr, i);
>> +             if (!cpc_ptr)
>> +                     continue;
>
> Well, is this actually safe?  What if we have CPPC control for some CPUs in a
> domain only?

I dont think thats possible since we can't have CPPC and any other
scheme (e.g. PSS) actively running at the same time. Also in this
case, IIUC there could be some CPUs in a domain that are present but
not available at bootup so their cpc_desc ptr could be NULL.

>
>> +
>> +             pdomain = &(cpc_ptr->domain_info);
>> +             cpumask_set_cpu(i, pr->shared_cpu_map);
>> +             cpumask_set_cpu(i, covered_cpus);
>> +             if (pdomain->num_processors <= 1)
>> +                     continue;
>> +
>> +             /* Validate the Domain info */
>> +             count_target = pdomain->num_processors;
>> +             if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
>> +                     pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
>> +             else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
>> +                     pr->shared_type = CPUFREQ_SHARED_TYPE_HW;
>> +             else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
>> +                     pr->shared_type = CPUFREQ_SHARED_TYPE_ANY;
>> +
>> +             for_each_possible_cpu(j) {
>> +                     if (i == j)
>> +                             continue;
>> +
>> +                     match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
>> +                     if (!match_cpc_ptr)
>> +                             continue;
>> +
>> +                     match_pdomain = &(match_cpc_ptr->domain_info);
>> +                     if (match_pdomain->domain != pdomain->domain)
>> +                             continue;
>> +
>> +                     /* Here i and j are in the same domain */
>> +
>> +                     if (match_pdomain->num_processors != count_target) {
>> +                             retval = -EINVAL;
>
> So we do bail out here, so why don't we bail out on any errors?  Why do we
> silently ignore some of them (like NULL cpc_ptr above)?

I think the idea is that you cant have a system with matching PSDs and
mismatching entries within. processor_perflib.c has the same
assumption.

>
>> +                             goto err_ret;
>> +                     }
>> +
>> +                     if (pdomain->coord_type != match_pdomain->coord_type) {
>> +                             retval = -EINVAL;
>> +                             goto err_ret;
>> +                     }
>> +
>> +                     cpumask_set_cpu(j, covered_cpus);
>> +                     cpumask_set_cpu(j, pr->shared_cpu_map);
>> +             }
>> +
>> +             for_each_possible_cpu(j) {
>
> Why do we need a separate loop over all CPUs for this?  Could not the loops
> be combined?

Without getting too fancy, I dont see how to avoid this O(n^2) looping.


>> +static int register_pcc_channel(unsigned pcc_subspace_idx)
>> +{
>> +     struct acpi_pcct_subspace *cppc_ss;
>> +     unsigned int len;
>> +
>> +     if (pcc_subspace_idx >= 0) {
>
> I'd check the reverse (ie. < 0) here and return immediately if that's the case.
>

Ok.

>> +             pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
>> +                             pcc_subspace_idx);
>> +
>> +             if (IS_ERR(pcc_channel)) {
>> +                     pr_err("No PCC communication channel found\n");
>> +                     return -ENODEV;
>> +             }
>> +
>> +             /*
>> +              * The PCC mailbox controller driver should
>> +              * have parsed the PCCT (global table of all
>> +              * PCC channels) and stored pointers to the
>> +              * subspace communication region in con_priv.
>> +              */
>> +             cppc_ss = pcc_channel->con_priv;
>> +
>> +             if (!cppc_ss) {
>> +                     pr_err("No PCC subspace found for CPPC\n");
>> +                     return -ENODEV;
>> +             }
>> +
>> +             /*
>> +              * This is the shared communication region
>> +              * for the OS and Platform to communicate over.
>> +              */
>> +             comm_base_addr = cppc_ss->base_address;
>> +             len = cppc_ss->length;
>> +             pcc_cmd_delay = cppc_ss->min_turnaround_time;
>> +
>> +             pcc_comm_addr = ioremap(comm_base_addr, len);
>> +             if (!pcc_comm_addr) {
>> +                     pr_err("Failed to ioremap PCC comm region mem\n");
>> +                     return -ENOMEM;
>> +             }
>> +
>> +             /* Set flag so that we dont come here for each CPU. */
>> +             pcc_channel_acquired = 1;
>
> Should pcc_channel_acquired be a bool variable rather?

Sure.

>> +
>> +     } else
>> +             /*
>> +              * For the case where registers are not defined as PCC regs.
>> +              * Assuming all regs are FFH / SystemIO.
>> +              */
>> +             pr_debug("No PCC subspace detected in any CPC entries.\n");
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * acpi_cppc_processor_probe - The _CPC table is a per CPU table
>
> One line description here, please.

Done.

>
>> + * which a bunch of entries which may be registers or integers.
>
> Move the example to a separate comment above the kerneldoc.
>

Ok.

>> + *   This function walks through all the per CPU _CPC entries and extracts
>> + *   the Register details.
>> + *
>> + *   Return: 0 for success or negative value for err.
>
> And the argument needs to be documented in the kerneldoc too.


Gah! Right.

>
>> + */
>> +int acpi_cppc_processor_probe(struct acpi_processor *pr)
>> +{
>> +     struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
>> +     union acpi_object *out_obj, *cpc_obj;
>> +     struct cpc_desc *cpc_ptr;
>> +     struct cpc_reg *gas_t;
>> +     acpi_handle handle = pr->handle;
>> +     unsigned int num_ent, i, cpc_rev, ret = 0;
>> +     acpi_status status;
>> +
>> +     /* Parse the ACPI _CPC table for this cpu. */
>> +     if (!acpi_has_method(handle, "_CPC")) {
>> +             pr_debug("_CPC table not found\n");
>> +             ret = -ENODEV;
>> +             goto out_buf_free;
>> +     }
>
> You don't need to do the above (the below will fail if _CPC is not present)
> and I'm not sure if the debug message is worth it.
>

Ok.

>> +
>> +     status = acpi_evaluate_object(handle, "_CPC", NULL, &output);
>> +     if (ACPI_FAILURE(status)) {
>> +             ret = -ENODEV;
>> +             goto out_buf_free;
>> +     }
>> +
>> +     out_obj = (union acpi_object *) output.pointer;
>> +     if (out_obj->type != ACPI_TYPE_PACKAGE) {
>> +             ret = -ENODEV;
>> +             goto out_buf_free;
>> +     }
>
> Again, acpi_evaluate_object_typed() would save you one branch.

Ok.

>> +     /* Only support CPPCv2. Bail otherwise. */
>> +     if (num_ent != CPPC_NUM_ENT) {
>> +             pr_err("Firmware exports %d entries. Expected: %d\n",
>> +                             num_ent, CPPC_NUM_ENT);
>> +             ret = -EINVAL;
>
> Why -EINVAL?  It doesn't mean "invalid argument" surely?

:) Changed to -EFAULT.

>> +                     /*
>> +                      * The PCC Subspace index is encoded inside
>> +                      * the CPC table entries. The same PCC index
>> +                      * will be used for all the PCC entries,
>> +                      * so extract it only once.
>> +                      */
>> +                     if (gas_t->space_id ==
>> +                                     ACPI_ADR_SPACE_PLATFORM_COMM) {
>
> Please don't break lines like this.  I know that it'll be more than 80 chars,
> but that's OK.  Or if you really care, you can move that code to a helper
> function.
>

Works for me. Thanks.

>> +                             if (pcc_subspace_idx < 0)
>> +                                     pcc_subspace_idx =
>> +                                             gas_t->access_width;
>> +                             else if (pcc_subspace_idx !=
>> +                                             gas_t->access_width) {
>> +                                     /*
>> +                                      * Mismatched PCC id detected.
>> +                                      * Firmware bug.
>> +                                      */
>> +                                     goto out_free;
>> +                             }
>> +                     }
>> +
>> +                     cpc_ptr->cpc_regs[i-2].type =
>> +                             ACPI_TYPE_BUFFER;
>> +                     cpc_ptr->cpc_regs[i-2].cpc_entry.reg =
>> +                             (struct cpc_reg) {
>> +                                     .space_id = gas_t->space_id,
>> +                                     .length = gas_t->length,
>> +                                     .bit_width = gas_t->bit_width,
>> +                                     .bit_offset = gas_t->bit_offset,
>> +                                     .address = gas_t->address,
>> +                                     .access_width =
>> +                                             gas_t->access_width,
>
> Why don't you use memcpy() for copying this?
>
Will do. I think previously I had gas_t as a generic register type,
which has a slightly different layout than the PCC register.

>> +
>> +     /* Register PCC channel once for all CPUs. */
>> +     if (!pcc_channel_acquired) {
>> +             ret = register_pcc_channel(pcc_subspace_idx);
>
> So here's a question: What if pcc_subspace_idx for the new CPU is different
> from the one we've registered the channel with?
>

That would be a bug in the CPC tables. CPPC being one client of PCC is
assigned only one PCC subspace, so all CPUs should have the same PCC
subspace id. This is caught in the check above.

> Also, is this guaranteed to be run sequentially for all of the different CPUs?

Yes. IIUC its called sequentially when the processor_driver detects a
Processor object.

>
> If not, what if they race with each other here and the channel is
> registered twice as a result?
>

I couldn't find a place in the ACPI boot flow where the Processor
object probing could happen in parallel, but you're more familiar with
this than me. :)

>> +     /* PCC communication addr space begins at byte offset 0x8. */
>> +     addr = is_pcc ? (u64)pcc_comm_addr + 0x8 + reg->cpc_entry.reg.address :
>> +             reg->cpc_entry.reg.address;
>
> Move the above to a separate function and document the formula.
>

Done.

>> +
>> +     if (reg->type == ACPI_TYPE_BUFFER) {
>
> Quite a bit of code duplication below.  Any chance to reduce it?
>

Will rethink. Doubt I can avoid the switch-case though.

>> +             switch (reg->cpc_entry.reg.bit_width) {
>> +             case 8:
>> +                     if (cmd == CMD_READ)
>> +                             read_val = readb((void *) (addr));
>> +                     else if (cmd == CMD_WRITE)
>> +                             writeb(write_val, (void *)(addr));
>> +                     else
>> +                             pr_debug("Unsupported cmd type: %d\n", cmd);
>> +                     break;
>> +             case 16:
>> +                     if (cmd == CMD_READ)
>> +                             read_val = readw((void *) (addr));
>> +                     else if (cmd == CMD_WRITE)
>> +                             writew(write_val, (void *)(addr));
>> +                     else
>> +                             pr_debug("Unsupported cmd type: %d\n", cmd);
>> +                     break;
>> +             case 32:
>> +                     if (cmd == CMD_READ)
>> +                             read_val = readl((void *) (addr));
>> +                     else if (cmd == CMD_WRITE)
>> +                             writel(write_val, (void *)(addr));
>> +                     else
>> +                             pr_debug("Unsupported cmd type: %d\n", cmd);
>> +                     break;
>> +             case 64:
>> +                     if (cmd == CMD_READ)
>> +                             read_val = readq((void *) (addr));
>> +                     else if (cmd == CMD_WRITE)
>> +                             writeq(write_val, (void *)(addr));
>> +                     else
>> +                             pr_debug("Unsupported cmd type: %d\n", cmd);
>> +                     break;
>> +             default:
>> +                     pr_debug("Unsupported bit width for CPC cmd:%d\n",
>> +                                     cmd);
>> +                     break;
>> +             }
>> +     } else if (reg->type == ACPI_TYPE_INTEGER) {
>> +             if (cmd == CMD_READ)
>> +                     read_val = reg->cpc_entry.int_value;
>> +             else if (cmd == CMD_WRITE)
>> +                     reg->cpc_entry.int_value = write_val;
>> +             else
>> +                     pr_debug("Unsupported cmd type: %d\n", cmd);
>> +     } else
>> +             pr_debug("Unsupported CPC entry type:%d\n", reg->type);
>> +
>> +     return read_val;
>> +}
>> +
>> +/**
>> + * cppc_get_perf_caps - Get a CPUs performance capabilities.
>> + * @cpunum: CPU from which to get capabilities info.
>> + * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
>> + *
>> + * Return - 0 for success with perf_caps populated else
>> + *   -ERRNO.
>> + */
>> +int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
>> +     struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
>> +                                  *nom_perf;
>> +     u64 min, max, ref, nom;
>> +     bool is_pcc = false;
>> +     int ret;
>> +
>> +     if (!cpc_desc) {
>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
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
> Are we only going to acquire this spinlock from IRQ context of from
> process context or from both?  If from both, what prevents deadlocks
> from happening if the below is interrupted and the interrupt context
> attempts to acquire the lock?

IIUC Process context only. Looking around at other cpufreq drivers,
(e.g. pcc-cpufreq.c) I dont think the deadlock is a possibility here
either.

>> +     if (!perf_caps->highest_perf ||
>> +                     !perf_caps->lowest_perf ||
>> +                     !perf_caps->reference_perf ||
>> +                     !perf_caps->nominal_perf) {
>> +             return -EINVAL;
>
> Again, why -EINVAL?

Changed to -EFAULT.
>
>> +     if (is_pcc) {
>> +             /*
>> +              * Min time OS should wait before sending
>> +              * next command.
>> +              */
>> +             udelay(pcc_cmd_delay);
>> +             /* Ring doorbell */
>> +             ret = send_pcc_cmd(CMD_READ);
>> +             if (ret) {
>> +                     spin_unlock(&pcc_lock);
>> +                     return -EIO;
>> +             }
>
> The above looks like some duplicated code.  Any chance to move it into a separate
> routine and call from both places?
>

Yep. Done.

>> +
>> +     if (!delivered || !reference)
>> +             return -EINVAL;
>
> Why -EINVAL?
>

:) Changed to -EFAULT.

>
> The header looks OK to me.
>
Great!

> That's it for now, I need to move to other stuff probably for the rest
> of this week.
>

Thanks for the follow up! I'll update this patch and resend for review
sometime next week.

Regards,
Ashwin.
