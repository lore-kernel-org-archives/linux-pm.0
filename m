From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 4/9] ACPI: Introduce CPU performance controls using CPPC
Date: Wed, 26 Aug 2015 03:46:08 +0200
Message-ID: <5149112.uli93SOdxV@vostro.rjw.lan>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org> <93681be9e10a2977c9b70ec1e52e0eccb25e081c.1438781668.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <93681be9e10a2977c9b70ec1e52e0eccb25e081c.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: jaswinder.singh@linaro.org, sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 05, 2015 09:40:27 AM Ashwin Chaugule wrote:
> CPPC stands for Collaborative Processor Performance Controls
> and is defined in the ACPI v5.0+ spec. It describes CPU
> performance controls on an abstract and continuous scale
> allowing the platform (e.g. remote power processor) to flexibly
> optimize CPU performance with its knowledge of power budgets
> and other architecture specific knowledge.
> 
> This patch adds a shim which exports commonly used functions
> to get and set CPPC specific controls for each CPU. This enables
> CPUFreq drivers to gather per CPU performance data and use
> with exisiting governors or even allows for customized governors
> which are implemented inside CPUFreq drivers.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/Kconfig     |  14 +
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/cppc_acpi.c | 812 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h | 137 ++++++++
>  4 files changed, 964 insertions(+)
>  create mode 100644 drivers/acpi/cppc_acpi.c
>  create mode 100644 include/acpi/cppc_acpi.h
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 54e9729..c6ec903 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -197,6 +197,20 @@ config ACPI_PROCESSOR_IDLE
>  	bool
>  	select CPU_IDLE
>  
> +config ACPI_CPPC_LIB
> +	bool
> +	depends on ACPI_PROCESSOR
> +	depends on !ACPI_CPU_FREQ_PSS
> +	select MAILBOX
> +	select PCC
> +	help
> +	  This file implements common functionality to parse

It's better to start with "If this option is enabled".

> +	  CPPC tables as described in the ACPI 5.1+ spec. The
> +	  routines implemented are meant to be used by other
> +	  drivers to control CPU performance using CPPC semantics.
> +	  If your platform does not support CPPC in firmware,
> +	  leave this option disabled.
> +
>  config ACPI_PROCESSOR
>  	tristate "Processor"
>  	depends on X86 || IA64
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3ea59ae..4c393a69 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_HED)		+= hed.o
>  obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>  obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
> +obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> new file mode 100644
> index 0000000..9c89767
> --- /dev/null
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -0,0 +1,812 @@
> +/*
> + * CPPC (Collaborative Processor Performance Control) methods used
> + * by CPUfreq drivers.

One line please.

> + *
> + * (C) Copyright 2014, 2015 Linaro Ltd.
> + * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; version 2
> + * of the License.
> + *
> + * CPPC describes a few methods for controlling CPU performance using
> + * information from a per CPU table called CPC. This table is described in
> + * the ACPI v5.0+ specification. The table consists of a list of
> + * registers which may be memory mapped or hardware registers and also may
> + * include some static integer values.
> + *
> + * CPU performance is on an abstract continuous scale as against a discretized
> + * P-state scale which is tied to CPU frequency only. In brief, the basic
> + * operation involves:
> + *
> + * - OS makes a CPU performance request. (Can provide min and max bounds)
> + *
> + * - Platform (such as BMC) is free to optimize request within requested bounds
> + *   depending on power/thermal budgets etc.
> + *
> + * - Platform conveys its decision back to OS
> + *
> + * The communication between OS and platform occurs through another medium
> + * called (PCC) Platform Communication Channel. This is a generic mailbox like
> + * mechanism which includes doorbell semantics to indicate register updates.
> + * See drivers/mailbox/pcc.c for details on PCC.
> + *
> + * Finer details about the PCC and CPPC spec are available in the latest
> + * ACPI 5.1 specification.

ACPI 5.1 is not the latest any more.  I'd say "ACPI 6.0 or later" to be on the
safe side.

> + */
> +
> +#define pr_fmt(fmt)	"ACPI CPPC: " fmt
> +
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +
> +#include <acpi/cppc_acpi.h>
> +/*
> + * Lock to provide mutually exclusive access to the PCC
> + * channel. e.g. When the remote updates the shared region
> + * with new data, the reader needs to be protected from
> + * other CPUs activity on the same channel.
> + */
> +static DEFINE_SPINLOCK(pcc_lock);
> +
> +static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);

A description of what the per-CPU thing is and how it is used would be good
to have here.

> +
> +/* This layer handles all the PCC specifics for CPPC. */
> +static struct mbox_chan *pcc_channel;
> +static void __iomem *pcc_comm_addr;
> +static u64 comm_base_addr;
> +static int pcc_subspace_idx = -1;
> +static u16 pcc_cmd_delay;
> +static int pcc_channel_acquired;
> +
> +#define NUM_RETRIES 500

How did you get that number?

> +
> +static int send_pcc_cmd(u16 cmd)
> +{
> +	int err, result = 0;
> +	int retries = NUM_RETRIES;
> +	struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
> +	struct acpi_pcct_shared_memory *generic_comm_base =
> +		(struct acpi_pcct_shared_memory *) pcc_comm_addr;
> +	u32 cmd_latency = pcct_ss->latency;
> +
> +	/* Write to the shared comm region. */
> +	writew(cmd, &generic_comm_base->command);
> +
> +	/* Flip CMD COMPLETE bit */
> +	writew(0, &generic_comm_base->status);
> +
> +	err = mbox_send_message(pcc_channel, &cmd);
> +	if (err < 0) {
> +		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
> +				cmd, err);
> +		return err;
> +	}
> +
> +	/* Wait for a nominal time to let platform processes command. */
> +	udelay(cmd_latency);
> +
> +	/* Retry in case the remote processor was too slow to catch up. */
> +	while (retries--) {

It looks like this can be written as

	for (retries = NUM_RETRIES; retries > 0; retries--) {

> +		result = readw_relaxed(&generic_comm_base->status)
> +			& PCC_CMD_COMPLETE ? 0 : -EIO;

I'm not sure why do you need the ternary operator here.

You could just do

		if (readw_relaxed(&generic_comm_base->status) & PCC_CMD_COMPLETE) {
			result = 0;
			break;
		}

and set "result" to -EIO beforehand.

> +		if (!result) {
> +			/* Success. */
> +			retries = NUM_RETRIES;

We break out of the loop in the next statement, so why is this needed?

BTW, why do you need both "err" and "result"?  Why not to use "result"
everywhere?


> +			break;
> +		}
> +	}
> +
> +	mbox_client_txdone(pcc_channel, result);
> +	return result;
> +}
> +
> +static void cppc_chan_tx_done(struct mbox_client *cl, void *mssg, int ret)
> +{
> +	if (ret)
> +		pr_debug("TX did not complete: CMD sent:%x, ret:%d\n",
> +				*(u16 *)mssg, ret);
> +	else
> +		pr_debug("TX completed. CMD sent:%x, ret:%d\n",
> +				*(u16 *)mssg, ret);

It would be good to identify the client somehow in these messages.  Otherwise
they may not be quite useful.

> +}
> +
> +struct mbox_client cppc_mbox_cl = {
> +	.tx_done = cppc_chan_tx_done,
> +	.knows_txdone = true,
> +};
> +
> +static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
> +{
> +	int result = 0;
> +	acpi_status status = AE_OK;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
> +	struct acpi_buffer state = {0, NULL};
> +	union acpi_object  *psd = NULL;
> +	struct acpi_psd_package *pdomain;
> +
> +	status = acpi_evaluate_object(handle, "_PSD", NULL, &buffer);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	psd = buffer.pointer;
> +	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
> +		pr_err("Invalid _PSD data\n");
> +		result = -ENODATA;
> +		goto end;
> +	}

acpi_evaluate_object_typed() can be used here and then you save one "if".

> +
> +	if (psd->package.count != 1) {
> +		pr_err("Invalid _PSD data\n");
> +		result = -ENODATA;
> +		goto end;
> +	}
> +
> +	pdomain = &(cpc_ptr->domain_info);
> +
> +	state.length = sizeof(struct acpi_psd_package);
> +	state.pointer = pdomain;
> +

So beyond this point, if there's an error, you always set "result" to -ENODATA.
Why not to set it to -ENODATA upfront and then reset it to 0 on success only?
That would save you a bunch of statements.

> +	status = acpi_extract_package(&(psd->package.elements[0]),
> +		&format, &state);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("Invalid _PSD data\n");

Why is that error priority and what can users see from the error message?

Same pretty much everywhere below?

> +		result = -ENODATA;
> +		goto end;
> +	}
> +
> +	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
> +		pr_err("Unknown _PSD:num_entries\n");
> +		result = -ENODATA;
> +		goto end;
> +	}
> +
> +	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
> +		pr_err("Unknown _PSD:revision\n");
> +		result = -ENODATA;
> +		goto end;
> +	}
> +
> +	if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
> +	    pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
> +	    pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
> +		pr_err("Invalid _PSD:coord_type\n");
> +		result = -ENODATA;
> +		goto end;
> +	}
> +end:
> +	kfree(buffer.pointer);
> +	return result;
> +}
> +
> +int acpi_get_psd_map(struct cpudata **all_cpu_data)
> +{
> +	int count_target;
> +	int retval = 0;
> +	unsigned int i, j;
> +	cpumask_var_t covered_cpus;
> +	struct cpudata *pr, *match_pr;
> +	struct acpi_psd_package *pdomain;
> +	struct acpi_psd_package *match_pdomain;
> +	struct cpc_desc *cpc_ptr, *match_cpc_ptr;
> +
> +	if (!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	/*
> +	 * Now that we have _PSD data from all CPUs, lets setup P-state
> +	 * domain info.
> +	 */
> +	for_each_possible_cpu(i) {
> +		pr = all_cpu_data[i];
> +		if (!pr)
> +			continue;
> +
> +		if (cpumask_test_cpu(i, covered_cpus))
> +			continue;
> +
> +		cpc_ptr = per_cpu(cpc_desc_ptr, i);
> +		if (!cpc_ptr)
> +			continue;

Well, is this actually safe?  What if we have CPPC control for some CPUs in a
domain only?

> +
> +		pdomain = &(cpc_ptr->domain_info);
> +		cpumask_set_cpu(i, pr->shared_cpu_map);
> +		cpumask_set_cpu(i, covered_cpus);
> +		if (pdomain->num_processors <= 1)
> +			continue;
> +
> +		/* Validate the Domain info */
> +		count_target = pdomain->num_processors;
> +		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
> +			pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
> +			pr->shared_type = CPUFREQ_SHARED_TYPE_HW;
> +		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
> +			pr->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +
> +		for_each_possible_cpu(j) {
> +			if (i == j)
> +				continue;
> +
> +			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
> +			if (!match_cpc_ptr)
> +				continue;
> +
> +			match_pdomain = &(match_cpc_ptr->domain_info);
> +			if (match_pdomain->domain != pdomain->domain)
> +				continue;
> +
> +			/* Here i and j are in the same domain */
> +
> +			if (match_pdomain->num_processors != count_target) {
> +				retval = -EINVAL;

So we do bail out here, so why don't we bail out on any errors?  Why do we
silently ignore some of them (like NULL cpc_ptr above)?

> +				goto err_ret;
> +			}
> +
> +			if (pdomain->coord_type != match_pdomain->coord_type) {
> +				retval = -EINVAL;
> +				goto err_ret;
> +			}
> +
> +			cpumask_set_cpu(j, covered_cpus);
> +			cpumask_set_cpu(j, pr->shared_cpu_map);
> +		}
> +
> +		for_each_possible_cpu(j) {

Why do we need a separate loop over all CPUs for this?  Could not the loops
be combined?

> +			if (i == j)
> +				continue;
> +
> +			match_pr = all_cpu_data[j];
> +			if (!match_pr)
> +				continue;
> +
> +			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
> +			if (!match_cpc_ptr)
> +				continue;
> +
> +			match_pdomain = &(match_cpc_ptr->domain_info);
> +			if (match_pdomain->domain != pdomain->domain)
> +				continue;
> +
> +			match_pr->shared_type = pr->shared_type;
> +			cpumask_copy(match_pr->shared_cpu_map,
> +				     pr->shared_cpu_map);
> +		}
> +	}
> +
> +err_ret:
> +	for_each_possible_cpu(i) {
> +		pr = all_cpu_data[i];
> +		if (!pr)
> +			continue;
> +
> +		/* Assume no coordination on any error parsing domain info */
> +		if (retval) {
> +			cpumask_clear(pr->shared_cpu_map);
> +			cpumask_set_cpu(i, pr->shared_cpu_map);
> +			pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
> +		}
> +	}
> +
> +	free_cpumask_var(covered_cpus);
> +	return retval;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_psd_map);
> +
> +static int register_pcc_channel(unsigned pcc_subspace_idx)
> +{
> +	struct acpi_pcct_subspace *cppc_ss;
> +	unsigned int len;
> +
> +	if (pcc_subspace_idx >= 0) {

I'd check the reverse (ie. < 0) here and return immediately if that's the case. 

> +		pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
> +				pcc_subspace_idx);
> +
> +		if (IS_ERR(pcc_channel)) {
> +			pr_err("No PCC communication channel found\n");
> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * The PCC mailbox controller driver should
> +		 * have parsed the PCCT (global table of all
> +		 * PCC channels) and stored pointers to the
> +		 * subspace communication region in con_priv.
> +		 */
> +		cppc_ss = pcc_channel->con_priv;
> +
> +		if (!cppc_ss) {
> +			pr_err("No PCC subspace found for CPPC\n");
> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * This is the shared communication region
> +		 * for the OS and Platform to communicate over.
> +		 */
> +		comm_base_addr = cppc_ss->base_address;
> +		len = cppc_ss->length;
> +		pcc_cmd_delay = cppc_ss->min_turnaround_time;
> +
> +		pcc_comm_addr = ioremap(comm_base_addr, len);
> +		if (!pcc_comm_addr) {
> +			pr_err("Failed to ioremap PCC comm region mem\n");
> +			return -ENOMEM;
> +		}
> +
> +		/* Set flag so that we dont come here for each CPU. */
> +		pcc_channel_acquired = 1;

Should pcc_channel_acquired be a bool variable rather?

> +
> +	} else
> +		/*
> +		 * For the case where registers are not defined as PCC regs.
> +		 * Assuming all regs are FFH / SystemIO.
> +		 */
> +		pr_debug("No PCC subspace detected in any CPC entries.\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * acpi_cppc_processor_probe - The _CPC table is a per CPU table

One line description here, please.

> + * which a bunch of entries which may be registers or integers.

Move the example to a separate comment above the kerneldoc.

> + * An example table looks like the following.
> + *
> + *	Name(_CPC, Package()
> + *			{
> + *			17,
> + *			NumEntries
> + *			1,
> + *			// Revision
> + *			ResourceTemplate(){Register(PCC, 32, 0, 0x120, 2)},
> + *			// Highest Performance
> + *			ResourceTemplate(){Register(PCC, 32, 0, 0x124, 2)},
> + *			// Nominal Performance
> + *			ResourceTemplate(){Register(PCC, 32, 0, 0x128, 2)},
> + *			// Lowest Nonlinear Performance
> + *			ResourceTemplate(){Register(PCC, 32, 0, 0x12C, 2)},
> + *			// Lowest Performance
> + *			ResourceTemplate(){Register(PCC, 32, 0, 0x130, 2)},
> + *			// Guaranteed Performance Register
> + *			ResourceTemplate(){Register(PCC, 32, 0, 0x110, 2)},
> + *			// Desired Performance Register
> + *			ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)},
> + *			..
> + *			..
> + *			..
> + *
> + *		}
> + * Each Register() encodes how to access that specific register.
> + * e.g. a sample PCC entry has the following encoding:
> + *
> + *	Register (
> + *		PCC,
> + *		AddressSpaceKeyword
> + *		8,
> + *		//RegisterBitWidth
> + *		8,
> + *		//RegisterBitOffset
> + *		0x30,
> + *		//RegisterAddress
> + *		9
> + *		//AccessSize (subspace ID)
> + *		0
> + *		)
> + *		}
> + *
> + *	This function walks through all the per CPU _CPC entries and extracts
> + *	the Register details.
> + *
> + *	Return: 0 for success or negative value for err.

And the argument needs to be documented in the kerneldoc too.

> + */
> +int acpi_cppc_processor_probe(struct acpi_processor *pr)
> +{
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	union acpi_object *out_obj, *cpc_obj;
> +	struct cpc_desc *cpc_ptr;
> +	struct cpc_reg *gas_t;
> +	acpi_handle handle = pr->handle;
> +	unsigned int num_ent, i, cpc_rev, ret = 0;
> +	acpi_status status;
> +
> +	/* Parse the ACPI _CPC table for this cpu. */
> +	if (!acpi_has_method(handle, "_CPC")) {
> +		pr_debug("_CPC table not found\n");
> +		ret = -ENODEV;
> +		goto out_buf_free;
> +	}

You don't need to do the above (the below will fail if _CPC is not present)
and I'm not sure if the debug message is worth it.

> +
> +	status = acpi_evaluate_object(handle, "_CPC", NULL, &output);
> +	if (ACPI_FAILURE(status)) {
> +		ret = -ENODEV;
> +		goto out_buf_free;
> +	}
> +
> +	out_obj = (union acpi_object *) output.pointer;
> +	if (out_obj->type != ACPI_TYPE_PACKAGE) {
> +		ret = -ENODEV;
> +		goto out_buf_free;
> +	}

Again, acpi_evaluate_object_typed() would save you one branch.

> +
> +	cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
> +	if (!cpc_ptr)
> +		return -ENOMEM;
> +
> +	/* First entry is NumEntries. */
> +	cpc_obj = &out_obj->package.elements[0];
> +	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
> +		num_ent = cpc_obj->integer.value;
> +	} else {
> +		pr_debug("Unexpected entry type(%d) for NumEntries\n",
> +				cpc_obj->type);
> +		goto out_free;
> +	}
> +
> +	/* Only support CPPCv2. Bail otherwise. */
> +	if (num_ent != CPPC_NUM_ENT) {
> +		pr_err("Firmware exports %d entries. Expected: %d\n",
> +				num_ent, CPPC_NUM_ENT);
> +		ret = -EINVAL;

Why -EINVAL?  It doesn't mean "invalid argument" surely?

> +		goto out_free;
> +	}
> +
> +	/* Second entry should be revision. */
> +	cpc_obj = &out_obj->package.elements[1];
> +	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
> +		cpc_rev = cpc_obj->integer.value;
> +	} else {
> +		pr_debug("Unexpected entry type(%d) for Revision\n",
> +				cpc_obj->type);
> +		goto out_free;
> +	}
> +
> +	if (cpc_rev != CPPC_REV) {
> +		pr_err("Firmware exports revision:%d. Expected:%d\n",
> +				cpc_rev, CPPC_REV);
> +		goto out_free;
> +	}
> +
> +	/* Iterate through remaining entries in _CPC */
> +	for (i = 2; i < num_ent; i++) {
> +		cpc_obj = &out_obj->package.elements[i];
> +
> +		if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
> +			cpc_ptr->cpc_regs[i-2].type =
> +				ACPI_TYPE_INTEGER;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value =
> +				cpc_obj->integer.value;
> +		} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
> +			gas_t = (struct cpc_reg *)
> +				cpc_obj->buffer.pointer;
> +
> +			/*
> +			 * The PCC Subspace index is encoded inside
> +			 * the CPC table entries. The same PCC index
> +			 * will be used for all the PCC entries,
> +			 * so extract it only once.
> +			 */
> +			if (gas_t->space_id ==
> +					ACPI_ADR_SPACE_PLATFORM_COMM) {

Please don't break lines like this.  I know that it'll be more than 80 chars,
but that's OK.  Or if you really care, you can move that code to a helper
function.

> +				if (pcc_subspace_idx < 0)
> +					pcc_subspace_idx =
> +						gas_t->access_width;
> +				else if (pcc_subspace_idx !=
> +						gas_t->access_width) {
> +					/*
> +					 * Mismatched PCC id detected.
> +					 * Firmware bug.
> +					 */
> +					goto out_free;
> +				}
> +			}
> +
> +			cpc_ptr->cpc_regs[i-2].type =
> +				ACPI_TYPE_BUFFER;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.reg =
> +				(struct cpc_reg) {
> +					.space_id = gas_t->space_id,
> +					.length	= gas_t->length,
> +					.bit_width = gas_t->bit_width,
> +					.bit_offset = gas_t->bit_offset,
> +					.address = gas_t->address,
> +					.access_width =
> +						gas_t->access_width,

Why don't you use memcpy() for copying this?

> +				};
> +		} else {
> +			pr_debug("Error in entry:%d in CPC table.\n", i);
> +			ret = -EINVAL;
> +			goto out_free;
> +		}
> +	}
> +
> +	/* Plug it into this CPUs CPC descriptor. */
> +	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
> +
> +	/* Parse PSD data for this CPU */
> +	ret = acpi_get_psd(cpc_ptr, handle);
> +	if (ret)
> +		goto out_free;
> +
> +	/* Register PCC channel once for all CPUs. */
> +	if (!pcc_channel_acquired) {
> +		ret = register_pcc_channel(pcc_subspace_idx);

So here's a question: What if pcc_subspace_idx for the new CPU is different
from the one we've registered the channel with?

Also, is this guaranteed to be run sequentially for all of the different CPUs?

If not, what if they race with each other here and the channel is
registered twice as a result?

> +		if (ret)
> +			goto out_free;
> +	}
> +
> +	/* Everything looks okay */
> +	pr_info("Successfully parsed CPC struct for CPU: %d\n", pr->id);
> +
> +	kfree(output.pointer);
> +	return 0;
> +
> +out_free:
> +	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
> +	kfree(cpc_ptr);
> +
> +out_buf_free:
> +	kfree(output.pointer);
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
> +
> +static u64 cpc_trans(struct cpc_register_resource *reg, int cmd, u64 write_val,
> +		bool is_pcc)
> +{
> +	u64 addr;
> +	u64 read_val = 0;
> +
> +	/* PCC communication addr space begins at byte offset 0x8. */
> +	addr = is_pcc ? (u64)pcc_comm_addr + 0x8 + reg->cpc_entry.reg.address :
> +		reg->cpc_entry.reg.address;

Move the above to a separate function and document the formula.

> +
> +	if (reg->type == ACPI_TYPE_BUFFER) {

Quite a bit of code duplication below.  Any chance to reduce it?

> +		switch (reg->cpc_entry.reg.bit_width) {
> +		case 8:
> +			if (cmd == CMD_READ)
> +				read_val = readb((void *) (addr));
> +			else if (cmd == CMD_WRITE)
> +				writeb(write_val, (void *)(addr));
> +			else
> +				pr_debug("Unsupported cmd type: %d\n", cmd);
> +			break;
> +		case 16:
> +			if (cmd == CMD_READ)
> +				read_val = readw((void *) (addr));
> +			else if (cmd == CMD_WRITE)
> +				writew(write_val, (void *)(addr));
> +			else
> +				pr_debug("Unsupported cmd type: %d\n", cmd);
> +			break;
> +		case 32:
> +			if (cmd == CMD_READ)
> +				read_val = readl((void *) (addr));
> +			else if (cmd == CMD_WRITE)
> +				writel(write_val, (void *)(addr));
> +			else
> +				pr_debug("Unsupported cmd type: %d\n", cmd);
> +			break;
> +		case 64:
> +			if (cmd == CMD_READ)
> +				read_val = readq((void *) (addr));
> +			else if (cmd == CMD_WRITE)
> +				writeq(write_val, (void *)(addr));
> +			else
> +				pr_debug("Unsupported cmd type: %d\n", cmd);
> +			break;
> +		default:
> +			pr_debug("Unsupported bit width for CPC cmd:%d\n",
> +					cmd);
> +			break;
> +		}
> +	} else if (reg->type == ACPI_TYPE_INTEGER) {
> +		if (cmd == CMD_READ)
> +			read_val = reg->cpc_entry.int_value;
> +		else if (cmd == CMD_WRITE)
> +			reg->cpc_entry.int_value = write_val;
> +		else
> +			pr_debug("Unsupported cmd type: %d\n", cmd);
> +	} else
> +		pr_debug("Unsupported CPC entry type:%d\n", reg->type);
> +
> +	return read_val;
> +}
> +
> +/**
> + * cppc_get_perf_caps - Get a CPUs performance capabilities.
> + * @cpunum: CPU from which to get capabilities info.
> + * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
> + *
> + * Return - 0 for success with perf_caps populated else
> + *	-ERRNO.
> + */
> +int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
> +				     *nom_perf;
> +	u64 min, max, ref, nom;
> +	bool is_pcc = false;
> +	int ret;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	highest_reg = &cpc_desc->cpc_regs[HIGHEST_PERF];
> +	lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
> +	ref_perf = &cpc_desc->cpc_regs[REFERENCE_PERF];
> +	nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
> +
> +	spin_lock(&pcc_lock);

Are we only going to acquire this spinlock from IRQ context of from
process context or from both?  If from both, what prevents deadlocks
from happening if the below is interrupted and the interrupt context
attempts to acquire the lock?

> +
> +	/* Are any of the regs PCC ?*/
> +	if ((highest_reg->cpc_entry.reg.space_id ==
> +				ACPI_ADR_SPACE_PLATFORM_COMM) ||
> +			(lowest_reg->cpc_entry.reg.space_id ==
> +			 ACPI_ADR_SPACE_PLATFORM_COMM) ||
> +			(ref_perf->cpc_entry.reg.space_id ==
> +			 ACPI_ADR_SPACE_PLATFORM_COMM) ||
> +			(nom_perf->cpc_entry.reg.space_id ==
> +			 ACPI_ADR_SPACE_PLATFORM_COMM))
> +		is_pcc = true;
> +
> +	if (is_pcc) {
> +		/*
> +		 * Min time OS should wait before sending
> +		 * next command.
> +		 */
> +		udelay(pcc_cmd_delay);
> +		/* Ring doorbell */
> +		ret = send_pcc_cmd(CMD_READ);
> +		if (ret) {
> +			spin_unlock(&pcc_lock);
> +			return -EIO;
> +		}
> +	}
> +
> +	max = cpc_trans(highest_reg, CMD_READ, 0, is_pcc);
> +	perf_caps->highest_perf = max;
> +
> +	min = cpc_trans(lowest_reg, CMD_READ, 0, is_pcc);
> +	perf_caps->lowest_perf = min;
> +
> +	ref = cpc_trans(ref_perf, CMD_READ, 0, is_pcc);
> +	perf_caps->reference_perf = ref;
> +
> +	nom = cpc_trans(nom_perf, CMD_READ, 0, is_pcc);
> +	perf_caps->nominal_perf = nom;
> +
> +	if (!ref)
> +		perf_caps->reference_perf = perf_caps->nominal_perf;
> +
> +	spin_unlock(&pcc_lock);
> +
> +	if (!perf_caps->highest_perf ||
> +			!perf_caps->lowest_perf ||
> +			!perf_caps->reference_perf ||
> +			!perf_caps->nominal_perf) {
> +		return -EINVAL;

Again, why -EINVAL?

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
> +
> +/**
> + * cppc_get_perf_ctrs - Read a CPUs performance feedback counters.
> + * @cpunum: CPU from which to read counters.
> + * @perf_fb_ctrs: ptr to cppc_perf_fb_ctrs. See cppc_acpi.h
> + *
> + * Return - 0 for success with perf_fb_ctrs populated else
> + *	-ERRNO.
> + */
> +int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *delivered_reg, *reference_reg;
> +	u64 delivered, reference;
> +	bool is_pcc = false;
> +	int ret;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
> +	reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
> +
> +	spin_lock(&pcc_lock);
> +
> +	/* Are any of the regs PCC ?*/
> +	if ((delivered_reg->cpc_entry.reg.space_id ==
> +				ACPI_ADR_SPACE_PLATFORM_COMM) ||
> +			(reference_reg->cpc_entry.reg.space_id ==
> +			 ACPI_ADR_SPACE_PLATFORM_COMM))
> +		is_pcc = true;
> +
> +	if (is_pcc) {
> +		/*
> +		 * Min time OS should wait before sending
> +		 * next command.
> +		 */
> +		udelay(pcc_cmd_delay);
> +		/* Ring doorbell */
> +		ret = send_pcc_cmd(CMD_READ);
> +		if (ret) {
> +			spin_unlock(&pcc_lock);
> +			return -EIO;
> +		}

The above looks like some duplicated code.  Any chance to move it into a separate
routine and call from both places?

> +	}
> +
> +	delivered = cpc_trans(delivered_reg, CMD_READ, 0, is_pcc);
> +	reference = cpc_trans(reference_reg, CMD_READ, 0, is_pcc);
> +
> +	spin_unlock(&pcc_lock);
> +
> +	if (!delivered || !reference)
> +		return -EINVAL;

Why -EINVAL?

> +
> +	perf_fb_ctrs->delivered = delivered;
> +	perf_fb_ctrs->reference = reference;
> +
> +	perf_fb_ctrs->delivered -= perf_fb_ctrs->prev_delivered;
> +	perf_fb_ctrs->reference -= perf_fb_ctrs->prev_reference;
> +
> +	perf_fb_ctrs->prev_delivered = delivered;
> +	perf_fb_ctrs->prev_reference = reference;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> +
> +/**
> + * cppc_set_perf - Set a CPUs performance controls.
> + * @cpu: CPU for which to set performance controls.
> + * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
> + *
> + * Return: 0 for success, -ERRNO otherwise.
> + */
> +int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cpc_register_resource *desired_reg;
> +	int ret = 0;
> +	bool is_pcc = false;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
> +		return -ENODEV;
> +	}
> +
> +	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +
> +	spin_lock(&pcc_lock);
> +
> +	/* Is this a PCC reg ?*/
> +	if (desired_reg->cpc_entry.reg.space_id ==
> +			ACPI_ADR_SPACE_PLATFORM_COMM)
> +		is_pcc = true;
> +
> +	cpc_trans(desired_reg, CMD_WRITE,
> +			perf_ctrls->desired_perf, is_pcc);
> +
> +	if (is_pcc) {
> +		/*
> +		 * Min time OS should wait before sending
> +		 * next command.
> +		 */
> +		udelay(pcc_cmd_delay);
> +		/* Ring doorbell */
> +		ret = send_pcc_cmd(CMD_READ);
> +	}
> +
> +	spin_unlock(&pcc_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_perf);

The header looks OK to me.

That's it for now, I need to move to other stuff probably for the rest
of this week.

Thanks,
Rafael

