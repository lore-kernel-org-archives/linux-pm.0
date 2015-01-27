From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v4 2/2] CPPC: Add CPUFreq driver based on CPPC methods
Date: Tue, 27 Jan 2015 16:03:58 -0500
Message-ID: <1422392638-31334-3-git-send-email-ashwin.chaugule@linaro.org>
References: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:53541 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbbA0VE3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 16:04:29 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so21036336pdb.11
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 13:04:29 -0800 (PST)
In-Reply-To: <1422392638-31334-1-git-send-email-ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: rwells@codeaurora.org, linda.knippers@hp.com, linux-pm@vger.kernel.org, Catalin.Marinas@arm.com, patches@linaro.org, linaro-acpi@lists.linaro.org, ashwin.chaugule@linaro.org, viresh.kumar@linaro.org, jaswinder.singh@linaro.org, broonie@kernel.org, arnd.bergmann@linaro.org

CPPC stands for Collaborative Processor Performance Controls
and is defined in the ACPI v5.0+ spec. It describes CPU
performance controls on an abstract and continuous scale
allowing the platform (e.g. remote power processor) to flexibly
optimize CPU performance with its knowledge of power budgets
and other architecture specific knowledge.

This patch introduces a CPUFreq driver which works with
existing CPUFreq governors. The backend CPPC methods for
parsing the CPPC table and reading/writing using CPPC semantics
are abstracted away such that they can be used by any other CPPC
based CPUFreq driver in the future.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/cpufreq/Kconfig.arm    |  15 +
 drivers/cpufreq/Makefile       |   1 +
 drivers/cpufreq/cppc_acpi.c    | 801 +++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_acpi.h    | 134 +++++++
 drivers/cpufreq/cppc_cpufreq.c | 186 ++++++++++
 5 files changed, 1137 insertions(+)
 create mode 100644 drivers/cpufreq/cppc_acpi.c
 create mode 100644 drivers/cpufreq/cppc_acpi.h
 create mode 100644 drivers/cpufreq/cppc_cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0f9a2c3..a977d65 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -255,3 +255,18 @@ config ARM_PXA2xx_CPUFREQ
 	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
 
 	  If in doubt, say N.
+
+config ACPI_CPPC_CPUFREQ
+	tristate "CPUFreq driver based on the ACPI CPPC spec"
+	depends on PCC
+	help
+		This adds a CPUFreq driver which uses CPPC methods
+		as described in the ACPIv5.1 spec. CPPC stands for
+		Collaborative Processor Performance Controls. It
+		is based on an abstract continuous scale of CPU
+		performance values which allows the remote power
+		processor to flexibly optimize for power and
+		performance. CPPC relies on power management firmware
+		for its operation.
+
+		If in doubt, say N.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index b3ca7b0..a7b0b41 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_ARM_SA1110_CPUFREQ)	+= sa1110-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA_CPUFREQ)		+= tegra-cpufreq.o
 obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
+obj-$(CONFIG_ACPI_CPPC_CPUFREQ) += cppc_cpufreq.o cppc_acpi.o
 
 ##################################################################################
 # PowerPC platform drivers
diff --git a/drivers/cpufreq/cppc_acpi.c b/drivers/cpufreq/cppc_acpi.c
new file mode 100644
index 0000000..0df80af
--- /dev/null
+++ b/drivers/cpufreq/cppc_acpi.c
@@ -0,0 +1,801 @@
+/*
+ * CPPC (Collaborative Processor Performance Control) methods used
+ * by CPUfreq drivers.
+ *
+ * (C) Copyright 2014 Linaro Ltd.
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
+#include <linux/cpufreq.h>
+#include <linux/delay.h>
+
+#include "cppc_acpi.h"
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
+
+static int send_pcc_cmd(u16 cmd)
+{
+	int err;
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
+		pr_err("Err sending PCC mbox message. cmd = %d, ret = %d\n",
+				cmd, err);
+		return err;
+	}
+
+	/* Wait till platform processes command. */
+	udelay(cmd_latency);
+
+	if (!(readw_relaxed(&generic_comm_base->status)
+		    & PCC_CMD_COMPLETE))
+		mbox_client_txdone(pcc_channel, -EIO);
+	else
+		/* Success */
+		mbox_client_txdone(pcc_channel, 0);
+
+	return 0;
+}
+
+static void cppc_chan_tx_done(struct mbox_client *cl, void *mssg, int ret)
+{
+	if (!ret)
+		pr_debug("CPPC TX completed. CMD sent = %x, ret = %d\n",
+				*(u16 *)mssg, ret);
+	else
+		pr_warn("CPPC TX did not complete: CMD sent = %x, ret = %d\n",
+				*(u16 *)mssg, ret);
+}
+
+struct mbox_client cppc_mbox_cl = {
+	.tx_done = cppc_chan_tx_done,
+	.knows_txdone = true,
+};
+
+/* XXX: Temp adaptation from processor_perflib.c
+ * until we get ACPI CPU idle support on ARM64.
+ */
+
+static int acpi_get_psd(struct cpudata *pr)
+{
+	int result = 0;
+	acpi_status status = AE_OK;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_buffer format = {sizeof("NNNNN"), "NNNNN"};
+	struct acpi_buffer state = {0, NULL};
+	union acpi_object  *psd = NULL;
+	struct acpi_psd_package *pdomain;
+	acpi_handle handle;
+	char proc_name[11];
+
+	sprintf(proc_name, "\\_PR.CPU%d", pr->cpu);
+
+	status = acpi_get_handle(NULL, proc_name, &handle);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	status = acpi_evaluate_object(handle, "_PSD", NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	psd = buffer.pointer;
+	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
+		pr_err("Invalid _PSD data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (psd->package.count != 1) {
+		pr_err("Invalid _PSD data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	pdomain = &(pr->domain_info);
+
+	state.length = sizeof(struct acpi_psd_package);
+	state.pointer = pdomain;
+
+	status = acpi_extract_package(&(psd->package.elements[0]),
+		&format, &state);
+	if (ACPI_FAILURE(status)) {
+		pr_err("Invalid _PSD data\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
+		pr_err("Unknown _PSD:num_entries\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
+		pr_err("Unknown _PSD:revision\n");
+		result = -EFAULT;
+		goto end;
+	}
+
+	if (pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ALL &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_SW_ANY &&
+	    pdomain->coord_type != DOMAIN_COORD_TYPE_HW_ALL) {
+		pr_err("Invalid _PSD:coord_type\n");
+		result = -EFAULT;
+		goto end;
+	}
+end:
+	kfree(buffer.pointer);
+	return result;
+}
+
+/* XXX: Temp adaptation from processor_perflib.c
+ * until we get ACPI CPU idle support on ARM64.
+ */
+int acpi_get_psd_map(struct cpudata **all_cpu_data)
+{
+	int count_target;
+	int retval = 0;
+	unsigned int i, j;
+	cpumask_var_t covered_cpus;
+	struct cpudata *pr;
+	struct acpi_psd_package *pdomain;
+	struct cpudata *match_pr;
+	struct acpi_psd_package *match_pdomain;
+
+	if (!zalloc_cpumask_var(&covered_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	/* Call _PSD for all CPUs */
+	for_each_online_cpu(i) {
+		pr = all_cpu_data[i];
+		if (!pr)
+			continue;
+
+		if (!zalloc_cpumask_var_node(&pr->shared_cpu_map,
+					GFP_KERNEL, cpu_to_node(pr->cpu))) {
+			pr_err("No mem for shared_cpus cpumask\n");
+			return -ENOMEM;
+		}
+
+		cpumask_set_cpu(i, pr->shared_cpu_map);
+		if (acpi_get_psd(pr)) {
+			retval = -EINVAL;
+			continue;
+		}
+	}
+	if (retval)
+		goto err_ret;
+
+	/*
+	 * Now that we have _PSD data from all CPUs, lets setup P-state
+	 * domain info.
+	 */
+	for_each_online_cpu(i) {
+		pr = all_cpu_data[i];
+		if (!pr)
+			continue;
+
+		if (cpumask_test_cpu(i, covered_cpus))
+			continue;
+
+		pdomain = &(pr->domain_info);
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
+		for_each_online_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_pr = all_cpu_data[j];
+			if (!match_pr)
+				continue;
+
+			match_pdomain = &(match_pr->domain_info);
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
+		for_each_online_cpu(j) {
+			if (i == j)
+				continue;
+
+			match_pr = all_cpu_data[j];
+			if (!match_pr)
+				continue;
+
+			match_pdomain = &(match_pr->domain_info);
+			if (match_pdomain->domain != pdomain->domain)
+				continue;
+
+			match_pr->shared_type =
+					pr->shared_type;
+			cpumask_copy(match_pr->shared_cpu_map,
+				     pr->shared_cpu_map);
+		}
+	}
+
+err_ret:
+	for_each_online_cpu(i) {
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
+EXPORT_SYMBOL(acpi_get_psd_map);
+
+/**
+ * acpi_cppc_processor_probe -
+ * The _CPC table is a per CPU table which a bunch of entries which
+ * may be registers or integers.
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
+int acpi_cppc_processor_probe(void)
+{
+	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *out_obj, *cpc_obj;
+	struct cpc_desc *current_cpu_cpc;
+	struct cpc_reg *gas_t;
+	struct acpi_pcct_subspace *cppc_ss;
+	char proc_name[11];
+	unsigned int num_ent, ret = 0, i, cpu, len;
+	acpi_handle handle;
+	acpi_status status;
+
+	/* Parse the ACPI _CPC table for each cpu. */
+	for_each_online_cpu(cpu) {
+		sprintf(proc_name, "\\_PR.CPU%d", cpu);
+
+		status = acpi_get_handle(NULL, proc_name, &handle);
+		if (ACPI_FAILURE(status)) {
+			ret = -ENODEV;
+			goto out_free;
+		}
+
+		if (!acpi_has_method(handle, "_CPC")) {
+			ret = -ENODEV;
+			goto out_free;
+		}
+
+		status = acpi_evaluate_object(handle, "_CPC", NULL, &output);
+		if (ACPI_FAILURE(status)) {
+			ret = -ENODEV;
+			goto out_free;
+		}
+
+		out_obj = (union acpi_object *) output.pointer;
+		if (out_obj->type != ACPI_TYPE_PACKAGE) {
+			ret = -ENODEV;
+			goto out_free;
+		}
+
+		current_cpu_cpc = kzalloc(sizeof(struct cpc_desc), GFP_KERNEL);
+		if (!current_cpu_cpc)
+			return -ENOMEM;
+
+		num_ent = out_obj->package.count;
+
+		pr_debug("num_ent in CPC table:%d\n", num_ent);
+
+		/* Iterate through each entry in _CPC */
+		for (i = 2; i < num_ent; i++) {
+			cpc_obj = &out_obj->package.elements[i];
+
+			if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
+				current_cpu_cpc->cpc_regs[i-2].type =
+					ACPI_TYPE_INTEGER;
+				current_cpu_cpc->cpc_regs[i-2].cpc_entry.int_value =
+					cpc_obj->integer.value;
+			} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
+				gas_t = (struct cpc_reg *)
+					cpc_obj->buffer.pointer;
+
+				/*
+				 * The PCC Subspace index is encoded inside
+				 * the CPC table entries. The same PCC index
+				 * will be used for all the PCC entries,
+				 * so extract it only once.
+				 */
+				if (gas_t->space_id ==
+						ACPI_ADR_SPACE_PLATFORM_COMM) {
+					if (pcc_subspace_idx < 0)
+						pcc_subspace_idx =
+							gas_t->access_width;
+				}
+
+				/*
+				 * First two entires are Version and num of
+				 * entries. Rest of them are registers or
+				 * ints. Hence the loop begins at 2.
+				 * Get each reg info.
+				 */
+				current_cpu_cpc->cpc_regs[i-2].type =
+					ACPI_TYPE_BUFFER;
+				current_cpu_cpc->cpc_regs[i-2].cpc_entry.reg =
+					(struct cpc_reg) {
+						.space_id = gas_t->space_id,
+						.length	= gas_t->length,
+						.bit_width = gas_t->bit_width,
+						.bit_offset = gas_t->bit_offset,
+						.address = gas_t->address,
+						.access_width =
+							gas_t->access_width,
+					};
+			} else {
+				pr_err("Error in entry:%d in CPC table.\n", i);
+				ret = -EINVAL;
+				goto out_free;
+			}
+		}
+
+		/* Plug it into this CPUs CPC descriptor. */
+		per_cpu(cpc_desc_ptr, cpu) = current_cpu_cpc;
+	}
+
+	/*
+	 * Now that we have all the information from the CPC table,
+	 * lets get a mailbox channel from the mailbox controller.
+	 * The channel for client is indexed using the subspace id
+	 * which was encoded in the Register(PCC.. entries.
+	 */
+	pr_debug("Completed parsing, now onto PCC init\n");
+
+	if (pcc_subspace_idx >= 0) {
+		pcc_channel = pcc_mbox_request_channel(&cppc_mbox_cl,
+				pcc_subspace_idx);
+
+		if (IS_ERR(pcc_channel)) {
+			pr_err("No PCC communication channel found\n");
+			ret = -ENODEV;
+			goto out_free;
+		}
+
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
+			ret = -ENODEV;
+			goto out_free;
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
+		pr_debug("From PCCT: CPPC subspace addr:%llx, len: %d\n",
+				comm_base_addr, len);
+		pcc_comm_addr = ioremap(comm_base_addr, len);
+		if (!pcc_comm_addr) {
+			ret = -ENOMEM;
+			pr_err("Failed to ioremap PCC comm region mem\n");
+			goto out_free;
+		}
+
+		pr_debug("New PCC comm space addr: %llx\n", (u64)pcc_comm_addr);
+
+	} else
+		/* For the case where registers are not defined as PCC regs. */
+		pr_warn("No PCC subspace detected in any CPC entries.\n");
+
+	/* Everything looks okay */
+	pr_info("Successfully parsed all CPC structs\n");
+
+	kfree(output.pointer);
+	return 0;
+
+out_free:
+	for_each_online_cpu(cpu) {
+		current_cpu_cpc = per_cpu(cpc_desc_ptr, cpu);
+		kfree(current_cpu_cpc);
+	}
+
+	kfree(output.pointer);
+	return -ENODEV;
+}
+EXPORT_SYMBOL(acpi_cppc_processor_probe);
+
+static u64 cpc_trans(struct cpc_register_resource *reg, int cmd, u64 write_val,
+		bool is_pcc)
+{
+	u64 addr;
+	u64 read_val = 0;
+
+	/* PCC communication addr space begins at byte offset 0x8. */
+	if (is_pcc == true)
+		addr = (u64)pcc_comm_addr + 0x8 + reg->cpc_entry.reg.address;
+	else
+		addr = reg->cpc_entry.reg.address;
+
+	if (reg->type == ACPI_TYPE_BUFFER) {
+		switch (reg->cpc_entry.reg.bit_width) {
+		case 8:
+			if (cmd == CMD_READ)
+				read_val = readb((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writeb(write_val, (void *)(addr));
+			else
+				pr_err("Unsupported cmd type: %d\n", cmd);
+			break;
+		case 16:
+			if (cmd == CMD_READ)
+				read_val = readw((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writew(write_val, (void *)(addr));
+			else
+				pr_err("Unsupported cmd type: %d\n", cmd);
+			break;
+		case 32:
+			if (cmd == CMD_READ)
+				read_val = readl((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writel(write_val, (void *)(addr));
+			else
+				pr_err("Unsupported cmd type: %d\n", cmd);
+			break;
+		case 64:
+			if (cmd == CMD_READ)
+				read_val = readq((void *) (addr));
+			else if (cmd == CMD_WRITE)
+				writeq(write_val, (void *)(addr));
+			else
+				pr_err("Unsupported cmd type: %d\n", cmd);
+			break;
+		default:
+			pr_err("Unsupported bit width for CPC read/write (cmd:%d)\n",
+					cmd);
+			break;
+		}
+	} else if (reg->type == ACPI_TYPE_INTEGER) {
+		if (cmd == CMD_READ)
+			read_val = reg->cpc_entry.int_value;
+		else if (cmd == CMD_WRITE)
+			reg->cpc_entry.int_value = write_val;
+		else
+			pr_err("Unsupported cmd type: %d\n", cmd);
+	} else
+		pr_err("Unsupported CPC entry type :%d\n", reg->type);
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
+
+	if (!cpc_desc) {
+		pr_err("No CPC descriptor for CPU:%d\n", cpunum);
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
+	if (is_pcc == true) {
+		/*
+		 * Min time OS should wait before sending
+		 * next command.
+		 */
+		udelay(pcc_cmd_delay);
+		/* Ring doorbell */
+		send_pcc_cmd(CMD_READ);
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
+	pr_err("Ref perf: %d\n", perf_caps->reference_perf);
+
+	nom = cpc_trans(nom_perf, CMD_READ, 0, is_pcc);
+	perf_caps->nominal_perf = nom;
+
+	pr_err("Nom perf: %d\n", perf_caps->nominal_perf);
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
+		pr_err("Err reading CPU performance limits\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(cppc_get_perf_caps);
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
+
+	if (!cpc_desc) {
+		pr_err("No CPC descriptor for CPU:%d\n", cpunum);
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
+	if (is_pcc == true) {
+		/*
+		 * Min time OS should wait before sending
+		 * next command.
+		 */
+		udelay(pcc_cmd_delay);
+		/* Ring doorbell */
+		send_pcc_cmd(CMD_READ);
+	}
+
+	delivered = cpc_trans(delivered_reg, CMD_READ, 0, is_pcc);
+	reference = cpc_trans(reference_reg, CMD_READ, 0, is_pcc);
+
+	spin_unlock(&pcc_lock);
+
+	if (!delivered || !reference) {
+		pr_err("Bogus values from Delivered or Reference counters\n");
+		return -EINVAL;
+	}
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
+EXPORT_SYMBOL(cppc_get_perf_ctrs);
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
+		pr_err("No CPC descriptor for CPU:%d\n", cpu);
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
+	if (is_pcc == true) {
+		/*
+		 * Min time OS should wait before sending
+		 * next command.
+		 */
+		udelay(pcc_cmd_delay);
+		/* Ring doorbell */
+		send_pcc_cmd(CMD_READ);
+	}
+
+	spin_unlock(&pcc_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(cppc_set_perf);
+
diff --git a/drivers/cpufreq/cppc_acpi.h b/drivers/cpufreq/cppc_acpi.h
new file mode 100644
index 0000000..a6c7ff6
--- /dev/null
+++ b/drivers/cpufreq/cppc_acpi.h
@@ -0,0 +1,134 @@
+/*
+ * CPPC (Collaborative Processor Performance Control) methods used
+ * by CPUfreq drivers.
+ *
+ * (C) Copyright 2014 Linaro Ltd.
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
+	struct acpi_psd_package domain_info;
+	unsigned int shared_type;
+	cpumask_var_t shared_cpu_map;
+};
+
+extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
+extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
+extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
+extern int acpi_get_psd_map(struct cpudata **);
+extern int acpi_cppc_processor_probe(void);
+
+/* Methods to interact with the PCC mailbox controller. */
+extern struct mbox_chan *
+	pcc_mbox_request_channel(struct mbox_client *, unsigned int);
+extern int mbox_send_message(struct mbox_chan *chan, void *mssg);
+
+#endif /* _CPPC_ACPI_H*/
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
new file mode 100644
index 0000000..258e27f1
--- /dev/null
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -0,0 +1,186 @@
+/*
+ * CPPC (Collaborative Processor Performance Control) driver for
+ * interfacing with the CPUfreq layer and governors. See
+ * cppc_acpi.c for CPPC specific methods.
+ *
+ * (C) Copyright 2014 Linaro Ltd.
+ * Author: Ashwin Chaugule <ashwin.chaugule@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2
+ * of the License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/vmalloc.h>
+
+#include "cppc_acpi.h"
+
+static struct cpudata **all_cpu_data;
+
+static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
+		unsigned int target_freq,
+		unsigned int relation)
+{
+	struct cpudata *cpu;
+	struct cpufreq_freqs freqs;
+	int ret;
+
+	cpu = all_cpu_data[policy->cpu];
+
+	cpu->perf_ctrls.desired_perf = target_freq;
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	ret = cppc_set_perf(cpu->cpu, &cpu->perf_ctrls);
+	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
+
+	if (ret) {
+		pr_debug("Failed to set target on CPU:%d\n", cpu->cpu);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static unsigned int cppc_cpufreq_get_perf(unsigned int cpu_num)
+{
+	struct cpudata *cpu;
+	int32_t delivered_perf = 1;
+
+	cpu = all_cpu_data[cpu_num];
+	if (!cpu)
+		return 0;
+
+	cppc_get_perf_ctrs(cpu_num, &cpu->perf_fb_ctrs);
+
+	delivered_perf = cpu->perf_caps.reference_perf *
+		cpu->perf_fb_ctrs.delivered;
+	delivered_perf /= cpu->perf_fb_ctrs.reference;
+	pr_debug("delivered_perf: %d\n", delivered_perf);
+	pr_debug("reference_perf: %d\n",
+			cpu->perf_caps.reference_perf);
+	pr_debug("delivered, reference deltas: %lld, %lld\n",
+			cpu->perf_fb_ctrs.delivered,
+			cpu->perf_fb_ctrs.reference);
+
+	return delivered_perf;
+}
+
+static int cppc_verify_policy(struct cpufreq_policy *policy)
+{
+	cpufreq_verify_within_cpu_limits(policy);
+	return 0;
+}
+
+static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
+{
+	int cpu_num = policy->cpu;
+	struct cpudata *cpu = all_cpu_data[cpu_num];
+	int ret;
+
+	pr_info("CPPC ondemand CPU %d exiting\n", cpu_num);
+
+	cpu->perf_ctrls.desired_perf = cpu->perf_caps.lowest_perf;
+
+	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
+	if (ret)
+		pr_err("Err setting perf value:%d on CPU:%d\n",
+				cpu->perf_caps.lowest_perf, cpu_num);
+}
+
+static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct cpudata *cpu;
+	int ret;
+
+	cpu = all_cpu_data[policy->cpu];
+
+	cpu->cpu = policy->cpu;
+	ret = cppc_get_perf_caps(policy->cpu, &cpu->perf_caps);
+
+	if (ret) {
+		pr_err("Err reading CPU%d, perf capabilities\n", cpu->cpu);
+		return -ENODEV;
+	}
+
+	policy->min = cpu->perf_caps.lowest_perf;
+	policy->max = cpu->perf_caps.highest_perf;
+	/* cpuinfo and default policy values */
+	policy->cpuinfo.min_freq = cpu->perf_caps.lowest_perf;
+	policy->cpuinfo.max_freq = cpu->perf_caps.highest_perf;
+
+	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL ||
+	    policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
+
+	cpumask_set_cpu(policy->cpu, policy->cpus);
+	cpu->cur_policy = policy;
+
+	return 0;
+}
+
+static struct cpufreq_driver cppc_cpufreq_driver = {
+	.flags = CPUFREQ_CONST_LOOPS,
+	.verify = cppc_verify_policy,
+	.target = cppc_cpufreq_set_target,
+	.get = cppc_cpufreq_get_perf,
+	.init = cppc_cpufreq_cpu_init,
+	.stop_cpu = cppc_cpufreq_stop_cpu,
+	.name = "cppc_cpufreq",
+};
+
+static int __init cppc_cpufreq_init(void)
+{
+	int cpu, rc = 0;
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	if (acpi_cppc_processor_probe()) {
+		pr_err("Err initializing CPC structures\n");
+		return -ENODEV;
+	}
+
+	pr_info("ACPI CPPC CPUFreq driver initializing.\n");
+
+	all_cpu_data = vzalloc(sizeof(void *) * num_possible_cpus());
+	if (!all_cpu_data)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		all_cpu_data[cpu] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
+		if (!all_cpu_data[cpu])
+			return -ENOMEM;
+	}
+
+	rc = acpi_get_psd_map(all_cpu_data);
+	if (rc) {
+		pr_err("Err parsing PSD data\n");
+		goto out;
+	}
+
+	rc = cpufreq_register_driver(&cppc_cpufreq_driver);
+	if (rc)
+		goto out;
+
+	return rc;
+
+out:
+	get_online_cpus();
+	for_each_online_cpu(cpu)
+		if (all_cpu_data[cpu])
+			kfree(all_cpu_data[cpu]);
+
+	put_online_cpus();
+	vfree(all_cpu_data);
+	return -ENODEV;
+}
+
+late_initcall(cppc_cpufreq_init);
-- 
1.9.1

