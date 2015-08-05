From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 4/9] ACPI: Introduce CPU performance controls using CPPC
Date: Wed,  5 Aug 2015 09:40:27 -0400
Message-ID: <93681be9e10a2977c9b70ec1e52e0eccb25e081c.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36306 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbHENk6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 09:40:58 -0400
Received: by ykeo23 with SMTP id o23so35159105yke.3
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 06:40:58 -0700 (PDT)
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

CPPC stands for Collaborative Processor Performance Controls
and is defined in the ACPI v5.0+ spec. It describes CPU
performance controls on an abstract and continuous scale
allowing the platform (e.g. remote power processor) to flexibly
optimize CPU performance with its knowledge of power budgets
and other architecture specific knowledge.

This patch adds a shim which exports commonly used functions
to get and set CPPC specific controls for each CPU. This enables
CPUFreq drivers to gather per CPU performance data and use
with exisiting governors or even allows for customized governors
which are implemented inside CPUFreq drivers.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/acpi/Kconfig     |  14 +
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/cppc_acpi.c | 812 +++++++++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 137 ++++++++
 4 files changed, 964 insertions(+)
 create mode 100644 drivers/acpi/cppc_acpi.c
 create mode 100644 include/acpi/cppc_acpi.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 54e9729..c6ec903 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -197,6 +197,20 @@ config ACPI_PROCESSOR_IDLE
 	bool
 	select CPU_IDLE
 
+config ACPI_CPPC_LIB
+	bool
+	depends on ACPI_PROCESSOR
+	depends on !ACPI_CPU_FREQ_PSS
+	select MAILBOX
+	select PCC
+	help
+	  This file implements common functionality to parse
+	  CPPC tables as described in the ACPI 5.1+ spec. The
+	  routines implemented are meant to be used by other
+	  drivers to control CPU performance using CPPC semantics.
+	  If your platform does not support CPPC in firmware,
+	  leave this option disabled.
+
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on X86 || IA64
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 3ea59ae..4c393a69 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_ACPI_HED)		+= hed.o
 obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
+obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
new file mode 100644
index 0000000..9c89767
--- /dev/null
+++ b/drivers/acpi/cppc_acpi.c
@@ -0,0 +1,812 @@
+/*
+ * CPPC (Collaborative Processor Performance Control) methods used
+ * by CPUfreq drivers.
+ *
+ * (C) Copyright 2014, 2015 Linaro Ltd.
+ * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ *
+ * CPPC describes a few methods for controlling CPU performance using
+ * information from a per CPU table called CPC. This table is described in
+ * the ACPI v5.0+ specification. The table consists of a list of
+ * registers which may be memory mapped or hardware registers and also may
+ * include some static integer values.
+ *
+ * CPU performance is on an abstract continuous scale as against a discretized
+ * P-state scale which is tied to CPU frequency only. In brief, the basic
+ * operation involves:
+ *
+ * - OS makes a CPU performance request. (Can provide min and max bounds)
+ *
+ * - Platform (such as BMC) is free to optimize request within requested bounds
+ *   depending on power/thermal budgets etc.
+ *
+ * - Platform conveys its decision back to OS
+ *
+ * The communication between OS and platform occurs through another medium
+ * called (PCC) Platform Communication Channel. This is a generic mailbox like
+ * mechanism which includes doorbell semantics to indicate register updates.
+ * See drivers/mailbox/pcc.c for details on PCC.
+ *
+ * Finer details about the PCC and CPPC spec are available in the latest
+ * ACPI 5.1 specification.
+ */
+
+#define pr_fmt(fmt)	"ACPI CPPC: " fmt
+
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+
+#include <acpi/cppc_acpi.h>
+/*
+ * Lock to provide mutually exclusive access to the PCC
+ * channel. e.g. When the remote updates the shared region
+ * with new data, the reader needs to be protected from
+ * other CPUs activity on the same channel.
+ */
+static DEFINE_SPINLOCK(pcc_lock);
+
+static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
+
+/* This layer handles all the PCC specifics for CPPC. */
+static struct mbox_chan *pcc_channel;
+static void __iomem *pcc_comm_addr;
+static u64 comm_base_addr;
+static int pcc_subspace_idx = -1;
+static u16 pcc_cmd_delay;
+static int pcc_channel_acquired;
+
+#define NUM_RETRIES 500
+
+static int send_pcc_cmd(u16 cmd)
+{
+	int err, result = 0;
+	int retries = NUM_RETRIES;
+	struct acpi_pcct_hw_reduced *pcct_ss = pcc_channel->con_priv;
+	struct acpi_pcct_shared_memory *generic_comm_base =
+		(struct acpi_pcct_shared_memory *) pcc_comm_addr;
+	u32 cmd_latency = pcct_ss->latency;
+
+	/* Write to the shared comm region. */
+	writew(cmd, &generic_comm_base->command);
+
+	/* Flip CMD COMPLETE bit */
+	writew(0, &generic_comm_base->status);
+
+	err = mbox_send_message(pcc_channel, &cmd);
+	if (err < 0) {
+		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
+				cmd, err);
+		return err;
+	}
+
+	/* Wait for a nominal time to let platform processes command. */
+	udelay(cmd_latency);
+
+	/* Retry in case the remote processor was too slow to catch up. */
+	while (retries--) {
+		result = readw_relaxed(&generic_comm_base->status)
+			& PCC_CMD_COMPLETE ? 0 : -EIO;
+		if (!result) {
+			/* Success. */
+			retries = NUM_RETRIES;
+			break;
+		}
+	}
+
+	mbox_client_txdone(pcc_channel, result);
+	return result;
+}
+
+static void cppc_chan_tx_done(struct mbox_client *cl, void *mssg, int ret)
+{
+	if (ret)
+		pr_debug("TX did not complete: CMD sent:%x, ret:%d\n",
+				*(u16 *)mssg, ret);
+	else
+		pr_debug("TX completed. CMD sent:%x, ret:%d\n",
+				*(u16 *)mssg, ret);
+}
+
+struct mbox_client cppc_mbox_cl = {
+	.tx_done = cppc_chan_tx_done,
+	.knows_txdone = true,
+};
+
+static int acpi_get_psd(struct cpc_desc *cpc_ptr, acpi_handle handle)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
+	struct acpi_buffer state = {0, NULL};
+	union acpi_object  *psd = NULL;
+	struct acpi_psd_package *pdomain;
+
+	status = acpi_evaluate_object(handle, "_PSD", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	psd = buffer.pointer;
+	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
+		pr_err("Invalid _PSD data\n");
+		result = -ENODATA;
+		goto end;
+	}
+
+	if (psd->package.count != 1) {
+		pr_err("Invalid _PSD data\n");
+		result = -ENODATA;
+		goto end;
+	}
+
+	pdomain = &(cpc_ptr->domain_info);
+
+	state.length = sizeof(struct acpi_psd_package);
+	state.pointer = pdomain;
+
+	status = acpi_extract_package(&(psd->package.elements[0]),
+		&format, &state);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Invalid _PSD data\n");
+		result = -ENODATA;
+		goto end;
+	}
+
+	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
+		pr_err("Unknown _PSD:num_entries\n");
+		result = -ENODATA;
+		goto end;
+	}
+
+	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
+		pr_err("Unknown _PSD:revision\n");
+		result = -ENODATA;
+		goto end;
+	}
+
+	if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
+		pr_err("Invalid _PSD:coord_type\n");
+		result = -ENODATA;
+		goto end;
+	}
+end:
+	kfree(buffer.pointer);
+	return result;
+}
+
+int acpi_get_psd_map(struct cpudata **all_cpu_data)
+{
+	int count_target;
+	int retval = 0;
+	unsigned int i, j;
+	cpumask_var_t covered_cpus;
+	struct cpudata *pr, *match_pr;
+	struct acpi_psd_package *pdomain;
+	struct acpi_psd_package *match_pdomain;
+	struct cpc_desc *cpc_ptr, *match_cpc_ptr;
+
+	if (!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	/*
+	 * Now that we have _PSD data from all CPUs, lets setup P-state
+	 * domain info.
+	 */
+	for_each_possible_cpu(i) {
+		pr = all_cpu_data[i];
+		if (!pr)
+			continue;
+
+		if (cpumask_test_cpu(i, covered_cpus))
+			continue;
+
+		cpc_ptr = per_cpu(cpc_desc_ptr, i);
+		if (!cpc_ptr)
+			continue;
+
+		pdomain = &(cpc_ptr->domain_info);
+		cpumask_set_cpu(i, pr->shared_cpu_map);
+		cpumask_set_cpu(i, covered_cpus);
+		if (pdomain->num_processors <= 1)
+			continue;
+
+		/* Validate the Domain info */
+		count_target = pdomain->num_processors;
+		if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ALL)
+			pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_HW_ALL)
+			pr->shared_type = CPUFREQ_SHARED_TYPE_HW;
+		else if (pdomain->coord_type == DOMAIN_COORD_TYPE_SW_ANY)
+			pr->shared_type = CPUFREQ_SHARED_TYPE_ANY;
+
+		for_each_possible_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
+			if (!match_cpc_ptr)
+				continue;
+
+			match_pdomain = &(match_cpc_ptr->domain_info);
+			if (match_pdomain->domain != pdomain->domain)
+				continue;
+
+			/* Here i and j are in the same domain */
+
+			if (match_pdomain->num_processors != count_target) {
+				retval = -EINVAL;
+				goto err_ret;
+			}
+
+			if (pdomain->coord_type != match_pdomain->coord_type) {
+				retval = -EINVAL;
+				goto err_ret;
+			}
+
+			cpumask_set_cpu(j, covered_cpus);
+			cpumask_set_cpu(j, pr->shared_cpu_map);
+		}
+
+		for_each_possible_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_pr = all_cpu_data[j];
+			if (!match_pr)
+				continue;
+
+			match_cpc_ptr = per_cpu(cpc_desc_ptr, j);
+			if (!match_cpc_ptr)
+				continue;
+
+			match_pdomain = &(match_cpc_ptr->domain_info);
+			if (match_pdomain->domain != pdomain->domain)
+				continue;
+
+			match_pr->shared_type = pr->shared_type;
+			cpumask_copy(match_pr->shared_cpu_map,
+				     pr->shared_cpu_map);
+		}
+	}
+
+err_ret:
+	for_each_possible_cpu(i) {
+		pr = all_cpu_data[i];
+		if (!pr)
+			continue;
+
+		/* Assume no coordination on any error parsing domain info */
+		if (retval) {
+			cpumask_clear(pr->shared_cpu_map);
+			cpumask_set_cpu(i, pr->shared_cpu_map);
+			pr->shared_type = CPUFREQ_SHARED_TYPE_ALL;
+		}
+	}
+
+	free_cpumask_var(covered_cpus);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(acpi_get_psd_map);
+
+static int register_pcc_channel(unsigned pcc_subspace_idx)
+{
+	struct acpi_pcct_subspace *cppc_ss;
+	unsigned int len;
+
+	if (pcc_subspace_idx >= 0) {
+		pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
+				pcc_subspace_idx);
+
+		if (IS_ERR(pcc_channel)) {
+			pr_err("No PCC communication channel found\n");
+			return -ENODEV;
+		}
+
+		/*
+		 * The PCC mailbox controller driver should
+		 * have parsed the PCCT (global table of all
+		 * PCC channels) and stored pointers to the
+		 * subspace communication region in con_priv.
+		 */
+		cppc_ss = pcc_channel->con_priv;
+
+		if (!cppc_ss) {
+			pr_err("No PCC subspace found for CPPC\n");
+			return -ENODEV;
+		}
+
+		/*
+		 * This is the shared communication region
+		 * for the OS and Platform to communicate over.
+		 */
+		comm_base_addr = cppc_ss->base_address;
+		len = cppc_ss->length;
+		pcc_cmd_delay = cppc_ss->min_turnaround_time;
+
+		pcc_comm_addr = ioremap(comm_base_addr, len);
+		if (!pcc_comm_addr) {
+			pr_err("Failed to ioremap PCC comm region mem\n");
+			return -ENOMEM;
+		}
+
+		/* Set flag so that we dont come here for each CPU. */
+		pcc_channel_acquired = 1;
+
+	} else
+		/*
+		 * For the case where registers are not defined as PCC regs.
+		 * Assuming all regs are FFH / SystemIO.
+		 */
+		pr_debug("No PCC subspace detected in any CPC entries.\n");
+
+	return 0;
+}
+
+/**
+ * acpi_cppc_processor_probe - The _CPC table is a per CPU table
+ * which a bunch of entries which may be registers or integers.
+ * An example table looks like the following.
+ *
+ *	Name(_CPC, Package()
+ *			{
+ *			17,
+ *			NumEntries
+ *			1,
+ *			// Revision
+ *			ResourceTemplate(){Register(PCC, 32, 0, 0x120, 2)},
+ *			// Highest Performance
+ *			ResourceTemplate(){Register(PCC, 32, 0, 0x124, 2)},
+ *			// Nominal Performance
+ *			ResourceTemplate(){Register(PCC, 32, 0, 0x128, 2)},
+ *			// Lowest Nonlinear Performance
+ *			ResourceTemplate(){Register(PCC, 32, 0, 0x12C, 2)},
+ *			// Lowest Performance
+ *			ResourceTemplate(){Register(PCC, 32, 0, 0x130, 2)},
+ *			// Guaranteed Performance Register
+ *			ResourceTemplate(){Register(PCC, 32, 0, 0x110, 2)},
+ *			// Desired Performance Register
+ *			ResourceTemplate(){Register(SystemMemory, 0, 0, 0, 0)},
+ *			..
+ *			..
+ *			..
+ *
+ *		}
+ * Each Register() encodes how to access that specific register.
+ * e.g. a sample PCC entry has the following encoding:
+ *
+ *	Register (
+ *		PCC,
+ *		AddressSpaceKeyword
+ *		8,
+ *		//RegisterBitWidth
+ *		8,
+ *		//RegisterBitOffset
+ *		0x30,
+ *		//RegisterAddress
+ *		9
+ *		//AccessSize (subspace ID)
+ *		0
+ *		)
+ *		}
+ *
+ *	This function walks through all the per CPU _CPC entries and extracts
+ *	the Register details.
+ *
+ *	Return: 0 for success or negative value for err.
+ */
+int acpi_cppc_processor_probe(struct acpi_processor *pr)
+{
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *out_obj, *cpc_obj;
+	struct cpc_desc *cpc_ptr;
+	struct cpc_reg *gas_t;
+	acpi_handle handle = pr->handle;
+	unsigned int num_ent, i, cpc_rev, ret = 0;
+	acpi_status status;
+
+	/* Parse the ACPI _CPC table for this cpu. */
+	if (!acpi_has_method(handle, "_CPC")) {
+		pr_debug("_CPC table not found\n");
+		ret = -ENODEV;
+		goto out_buf_free;
+	}
+
+	status = acpi_evaluate_object(handle, "_CPC", NULL, &output);
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto out_buf_free;
+	}
+
+	out_obj = (union acpi_object *) output.pointer;
+	if (out_obj->type != ACPI_TYPE_PACKAGE) {
+		ret = -ENODEV;
+		goto out_buf_free;
+	}
+
+	cpc_ptr = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
+	if (!cpc_ptr)
+		return -ENOMEM;
+
+	/* First entry is NumEntries. */
+	cpc_obj = &out_obj->package.elements[0];
+	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
+		num_ent = cpc_obj->integer.value;
+	} else {
+		pr_debug("Unexpected entry type(%d) for NumEntries\n",
+				cpc_obj->type);
+		goto out_free;
+	}
+
+	/* Only support CPPCv2. Bail otherwise. */
+	if (num_ent != CPPC_NUM_ENT) {
+		pr_err("Firmware exports %d entries. Expected: %d\n",
+				num_ent, CPPC_NUM_ENT);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	/* Second entry should be revision. */
+	cpc_obj = &out_obj->package.elements[1];
+	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
+		cpc_rev = cpc_obj->integer.value;
+	} else {
+		pr_debug("Unexpected entry type(%d) for Revision\n",
+				cpc_obj->type);
+		goto out_free;
+	}
+
+	if (cpc_rev != CPPC_REV) {
+		pr_err("Firmware exports revision:%d. Expected:%d\n",
+				cpc_rev, CPPC_REV);
+		goto out_free;
+	}
+
+	/* Iterate through remaining entries in _CPC */
+	for (i = 2; i < num_ent; i++) {
+		cpc_obj = &out_obj->package.elements[i];
+
+		if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
+			cpc_ptr->cpc_regs[i-2].type =
+				ACPI_TYPE_INTEGER;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value =
+				cpc_obj->integer.value;
+		} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
+			gas_t = (struct cpc_reg *)
+				cpc_obj->buffer.pointer;
+
+			/*
+			 * The PCC Subspace index is encoded inside
+			 * the CPC table entries. The same PCC index
+			 * will be used for all the PCC entries,
+			 * so extract it only once.
+			 */
+			if (gas_t->space_id ==
+					ACPI_ADR_SPACE_PLATFORM_COMM) {
+				if (pcc_subspace_idx < 0)
+					pcc_subspace_idx =
+						gas_t->access_width;
+				else if (pcc_subspace_idx !=
+						gas_t->access_width) {
+					/*
+					 * Mismatched PCC id detected.
+					 * Firmware bug.
+					 */
+					goto out_free;
+				}
+			}
+
+			cpc_ptr->cpc_regs[i-2].type =
+				ACPI_TYPE_BUFFER;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.reg =
+				(struct cpc_reg) {
+					.space_id = gas_t->space_id,
+					.length	= gas_t->length,
+					.bit_width = gas_t->bit_width,
+					.bit_offset = gas_t->bit_offset,
+					.address = gas_t->address,
+					.access_width =
+						gas_t->access_width,
+				};
+		} else {
+			pr_debug("Error in entry:%d in CPC table.\n", i);
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	/* Plug it into this CPUs CPC descriptor. */
+	per_cpu(cpc_desc_ptr, pr->id) = cpc_ptr;
+
+	/* Parse PSD data for this CPU */
+	ret = acpi_get_psd(cpc_ptr, handle);
+	if (ret)
+		goto out_free;
+
+	/* Register PCC channel once for all CPUs. */
+	if (!pcc_channel_acquired) {
+		ret = register_pcc_channel(pcc_subspace_idx);
+		if (ret)
+			goto out_free;
+	}
+
+	/* Everything looks okay */
+	pr_info("Successfully parsed CPC struct for CPU: %d\n", pr->id);
+
+	kfree(output.pointer);
+	return 0;
+
+out_free:
+	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
+	kfree(cpc_ptr);
+
+out_buf_free:
+	kfree(output.pointer);
+	return -ENODEV;
+}
+EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
+
+static u64 cpc_trans(struct cpc_register_resource *reg, int cmd, u64 write_val,
+		bool is_pcc)
+{
+	u64 addr;
+	u64 read_val = 0;
+
+	/* PCC communication addr space begins at byte offset 0x8. */
+	addr = is_pcc ? (u64)pcc_comm_addr + 0x8 + reg->cpc_entry.reg.address :
+		reg->cpc_entry.reg.address;
+
+	if (reg->type == ACPI_TYPE_BUFFER) {
+		switch (reg->cpc_entry.reg.bit_width) {
+		case 8:
+			if (cmd == CMD_READ)
+				read_val = readb((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writeb(write_val, (void *)(addr));
+			else
+				pr_debug("Unsupported cmd type: %d\n", cmd);
+			break;
+		case 16:
+			if (cmd == CMD_READ)
+				read_val = readw((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writew(write_val, (void *)(addr));
+			else
+				pr_debug("Unsupported cmd type: %d\n", cmd);
+			break;
+		case 32:
+			if (cmd == CMD_READ)
+				read_val = readl((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writel(write_val, (void *)(addr));
+			else
+				pr_debug("Unsupported cmd type: %d\n", cmd);
+			break;
+		case 64:
+			if (cmd == CMD_READ)
+				read_val = readq((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writeq(write_val, (void *)(addr));
+			else
+				pr_debug("Unsupported cmd type: %d\n", cmd);
+			break;
+		default:
+			pr_debug("Unsupported bit width for CPC cmd:%d\n",
+					cmd);
+			break;
+		}
+	} else if (reg->type == ACPI_TYPE_INTEGER) {
+		if (cmd == CMD_READ)
+			read_val = reg->cpc_entry.int_value;
+		else if (cmd == CMD_WRITE)
+			reg->cpc_entry.int_value = write_val;
+		else
+			pr_debug("Unsupported cmd type: %d\n", cmd);
+	} else
+		pr_debug("Unsupported CPC entry type:%d\n", reg->type);
+
+	return read_val;
+}
+
+/**
+ * cppc_get_perf_caps - Get a CPUs performance capabilities.
+ * @cpunum: CPU from which to get capabilities info.
+ * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
+ *
+ * Return - 0 for success with perf_caps populated else
+ *	-ERRNO.
+ */
+int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	struct cpc_register_resource *highest_reg, *lowest_reg, *ref_perf,
+				     *nom_perf;
+	u64 min, max, ref, nom;
+	bool is_pcc = false;
+	int ret;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+		return -ENODEV;
+	}
+
+	highest_reg = &cpc_desc->cpc_regs[HIGHEST_PERF];
+	lowest_reg = &cpc_desc->cpc_regs[LOWEST_PERF];
+	ref_perf = &cpc_desc->cpc_regs[REFERENCE_PERF];
+	nom_perf = &cpc_desc->cpc_regs[NOMINAL_PERF];
+
+	spin_lock(&pcc_lock);
+
+	/* Are any of the regs PCC ?*/
+	if ((highest_reg->cpc_entry.reg.space_id ==
+				ACPI_ADR_SPACE_PLATFORM_COMM) ||
+			(lowest_reg->cpc_entry.reg.space_id ==
+			 ACPI_ADR_SPACE_PLATFORM_COMM) ||
+			(ref_perf->cpc_entry.reg.space_id ==
+			 ACPI_ADR_SPACE_PLATFORM_COMM) ||
+			(nom_perf->cpc_entry.reg.space_id ==
+			 ACPI_ADR_SPACE_PLATFORM_COMM))
+		is_pcc = true;
+
+	if (is_pcc) {
+		/*
+		 * Min time OS should wait before sending
+		 * next command.
+		 */
+		udelay(pcc_cmd_delay);
+		/* Ring doorbell */
+		ret = send_pcc_cmd(CMD_READ);
+		if (ret) {
+			spin_unlock(&pcc_lock);
+			return -EIO;
+		}
+	}
+
+	max = cpc_trans(highest_reg, CMD_READ, 0, is_pcc);
+	perf_caps->highest_perf = max;
+
+	min = cpc_trans(lowest_reg, CMD_READ, 0, is_pcc);
+	perf_caps->lowest_perf = min;
+
+	ref = cpc_trans(ref_perf, CMD_READ, 0, is_pcc);
+	perf_caps->reference_perf = ref;
+
+	nom = cpc_trans(nom_perf, CMD_READ, 0, is_pcc);
+	perf_caps->nominal_perf = nom;
+
+	if (!ref)
+		perf_caps->reference_perf = perf_caps->nominal_perf;
+
+	spin_unlock(&pcc_lock);
+
+	if (!perf_caps->highest_perf ||
+			!perf_caps->lowest_perf ||
+			!perf_caps->reference_perf ||
+			!perf_caps->nominal_perf) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_caps);
+
+/**
+ * cppc_get_perf_ctrs - Read a CPUs performance feedback counters.
+ * @cpunum: CPU from which to read counters.
+ * @perf_fb_ctrs: ptr to cppc_perf_fb_ctrs. See cppc_acpi.h
+ *
+ * Return - 0 for success with perf_fb_ctrs populated else
+ *	-ERRNO.
+ */
+int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	struct cpc_register_resource *delivered_reg, *reference_reg;
+	u64 delivered, reference;
+	bool is_pcc = false;
+	int ret;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
+		return -ENODEV;
+	}
+
+	delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
+	reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
+
+	spin_lock(&pcc_lock);
+
+	/* Are any of the regs PCC ?*/
+	if ((delivered_reg->cpc_entry.reg.space_id ==
+				ACPI_ADR_SPACE_PLATFORM_COMM) ||
+			(reference_reg->cpc_entry.reg.space_id ==
+			 ACPI_ADR_SPACE_PLATFORM_COMM))
+		is_pcc = true;
+
+	if (is_pcc) {
+		/*
+		 * Min time OS should wait before sending
+		 * next command.
+		 */
+		udelay(pcc_cmd_delay);
+		/* Ring doorbell */
+		ret = send_pcc_cmd(CMD_READ);
+		if (ret) {
+			spin_unlock(&pcc_lock);
+			return -EIO;
+		}
+	}
+
+	delivered = cpc_trans(delivered_reg, CMD_READ, 0, is_pcc);
+	reference = cpc_trans(reference_reg, CMD_READ, 0, is_pcc);
+
+	spin_unlock(&pcc_lock);
+
+	if (!delivered || !reference)
+		return -EINVAL;
+
+	perf_fb_ctrs->delivered = delivered;
+	perf_fb_ctrs->reference = reference;
+
+	perf_fb_ctrs->delivered -= perf_fb_ctrs->prev_delivered;
+	perf_fb_ctrs->reference -= perf_fb_ctrs->prev_reference;
+
+	perf_fb_ctrs->prev_delivered = delivered;
+	perf_fb_ctrs->prev_reference = reference;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
+
+/**
+ * cppc_set_perf - Set a CPUs performance controls.
+ * @cpu: CPU for which to set performance controls.
+ * @perf_ctrls: ptr to cppc_perf_ctrls. See cppc_acpi.h
+ *
+ * Return: 0 for success, -ERRNO otherwise.
+ */
+int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *desired_reg;
+	int ret = 0;
+	bool is_pcc = false;
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+
+	spin_lock(&pcc_lock);
+
+	/* Is this a PCC reg ?*/
+	if (desired_reg->cpc_entry.reg.space_id ==
+			ACPI_ADR_SPACE_PLATFORM_COMM)
+		is_pcc = true;
+
+	cpc_trans(desired_reg, CMD_WRITE,
+			perf_ctrls->desired_perf, is_pcc);
+
+	if (is_pcc) {
+		/*
+		 * Min time OS should wait before sending
+		 * next command.
+		 */
+		udelay(pcc_cmd_delay);
+		/* Ring doorbell */
+		ret = send_pcc_cmd(CMD_READ);
+	}
+
+	spin_unlock(&pcc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cppc_set_perf);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
new file mode 100644
index 0000000..b97d2b6
--- /dev/null
+++ b/include/acpi/cppc_acpi.h
@@ -0,0 +1,137 @@
+/*
+ * CPPC (Collaborative Processor Performance Control) methods used
+ * by CPUfreq drivers.
+ *
+ * (C) Copyright 2014, 2015 Linaro Ltd.
+ * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#ifndef _CPPC_ACPI_H
+#define _CPPC_ACPI_H
+
+#include <linux/acpi.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+#include <linux/types.h>
+
+#include <acpi/processor.h>
+
+/* Only support CPPCv2 for now. */
+#define CPPC_NUM_ENT	21
+#define CPPC_REV	2
+
+#define PCC_CMD_COMPLETE 1
+#define MAX_CPC_REG_ENT 19
+
+/* CPPC specific PCC commands. */
+#define	CMD_READ 0
+#define	CMD_WRITE 1
+
+/* Each register has the folowing format. */
+struct cpc_reg {
+	u8 descriptor;
+	u16 length;
+	u8 space_id;
+	u8 bit_width;
+	u8 bit_offset;
+	u8 access_width;
+	u64 __iomem address;
+} __packed;
+
+/*
+ * Each entry in the CPC table is either
+ * of type ACPI_TYPE_BUFFER or
+ * ACPI_TYPE_INTEGER.
+ */
+struct cpc_register_resource {
+	acpi_object_type type;
+	union {
+		struct cpc_reg reg;
+		u64 int_value;
+	} cpc_entry;
+};
+
+/* Container to hold the CPC details for each CPU */
+struct cpc_desc {
+	int num_entries;
+	int version;
+	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
+	struct acpi_psd_package domain_info;
+};
+
+/* These are indexes into the per-cpu cpc_regs[]. Order is important. */
+enum cppc_regs {
+	HIGHEST_PERF,
+	NOMINAL_PERF,
+	LOW_NON_LINEAR_PERF,
+	LOWEST_PERF,
+	GUARANTEED_PERF,
+	DESIRED_PERF,
+	MIN_PERF,
+	MAX_PERF,
+	PERF_REDUC_TOLERANCE,
+	TIME_WINDOW,
+	CTR_WRAP_TIME,
+	REFERENCE_CTR,
+	DELIVERED_CTR,
+	PERF_LIMITED,
+	ENABLE,
+	AUTO_SEL_ENABLE,
+	AUTO_ACT_WINDOW,
+	ENERGY_PERF,
+	REFERENCE_PERF,
+};
+
+/*
+ * Categorization of registers as described
+ * in the ACPI v.5.1 spec.
+ * XXX: Only filling up ones which are used by governors
+ * today.
+ */
+struct cppc_perf_caps {
+	u32 highest_perf;
+	u32 nominal_perf;
+	u32 reference_perf;
+	u32 lowest_perf;
+};
+
+struct cppc_perf_ctrls {
+	u32 max_perf;
+	u32 min_perf;
+	u32 desired_perf;
+};
+
+struct cppc_perf_fb_ctrs {
+	u64 reference;
+	u64 prev_reference;
+	u64 delivered;
+	u64 prev_delivered;
+};
+
+/* Per CPU container for runtime CPPC management. */
+struct cpudata {
+	int cpu;
+	struct cppc_perf_caps perf_caps;
+	struct cppc_perf_ctrls perf_ctrls;
+	struct cppc_perf_fb_ctrs perf_fb_ctrs;
+	struct cpufreq_policy *cur_policy;
+	unsigned int shared_type;
+	cpumask_var_t shared_cpu_map;
+};
+
+extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
+extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
+extern int acpi_get_psd_map(struct cpudata **);
+
+/* Methods to interact with the PCC mailbox controller. */
+extern struct mbox_chan *
+	pcc_mbox_request_channel(struct mbox_client *, unsigned int);
+extern int mbox_send_message(struct mbox_chan *chan, void *mssg);
+
+#endif /* _CPPC_ACPI_H*/
-- 
1.9.1

