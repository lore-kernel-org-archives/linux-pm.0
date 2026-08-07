Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3E342D75C;
	Fri,  7 Aug 2026 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786101200; cv=none; b=T2YABXiRtLcvaZlr400XST4jeGnFrCIHmiqNEFUK4KI2ZJhXWKcT2K/omKNJ2s7X/wq1hFqBPJR328B7ZA9WnXm8ykT12dDLqFfMXdFqPBWfYBmHUGKrf0TccQKZmc1bOmAOPFnYIxqlfRYrrRtf4NkAa4yZsBz1rBEjAROf7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786101200; c=relaxed/simple;
	bh=dPqJFZm95erqq2da1bU+YLQ8/TemeVaKvGWUw+WwSPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuVTR3nb/p6UKBAQnB2UbFVnXeCZdEc8dr4uHU+vfhgt7eb4dC7E/UZ4GO2yUqbYo6zDLOb/Ha5fUIb1lwTTO4Jw8qQOiqiucuoL6Pf+A42jpx/GE7afNV9A0ZFWn4ZGltUQBfG9NSsehiHOqn2Z+x/biJHqYepskCgAZLudhEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cVKFRGfK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cVKFRGfK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98B021516;
	Fri,  7 Aug 2026 04:13:13 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 761513F86F;
	Fri,  7 Aug 2026 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786101197; bh=dPqJFZm95erqq2da1bU+YLQ8/TemeVaKvGWUw+WwSPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVKFRGfKkFu/mnWoPs1RqQRfa1oQeIH3Zc6vJuiGBZPjthzysRG1NxCCPYcqjJabu
	 Dx8KP7jkpZYmPNew2Dme75FvD9KHbfDxqP9GZkSpVdZLQcxcknRCMnObzZn4e+kUy0
	 7dSe3m53ZSnmVLh1cTWOfv5nq1FWXVKBUm4F0xXA=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	zhongqiu.han@oss.qualcomm.com,
	Christian Loehle <christian.loehle@arm.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH 02/15] ACPI: CPPC: Validate _CPC entry and control semantics
Date: Fri,  7 Aug 2026 12:12:50 +0100
Message-Id: <20260807111303.1062391-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807111303.1062391-1-christian.loehle@arm.com>
References: <20260807111303.1062391-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writable _CPC controls are Register descriptors encoded as Buffer objects.
Integer entries represent fixed values or unsupported optional registers;
Autonomous Selection Integer 1 is the special immutable form which enables
operation without Desired Performance.

The parser accepts arbitrary object types and cpc_write() assumes that its
argument contains a GAS. Malformed firmware can therefore make it interpret
an Integer union member as a register.

Validate the portion of each encoding consumed by Linux: bound Integer
DWORD forms to 32 bits, and require Buffer entries to start with a complete
Generic Register descriptor with the expected header. Continue tolerating
Integer 0 for an absent optional register and retain type checks in
cpc_write() as defense in depth.

Check mandatory object presence separately from the Integer-zero convention
for absent optional fields. ACPI does not reserve zero in the abstract
Lowest Performance scale, so accept a present Lowest Performance DWORD of
zero and remove the matching runtime rejection.

Performance Limited is listed as a required Buffer, but the interface does
not depend on it to control performance and the specification permits a
platform with no limiting indication to always report zero. Preserve
Linux's compatibility with firmware that represents that case using a NULL
register descriptor instead of disabling CPPC entirely.

Emit an error when a present _CPC package fails parsing or initialization
so such firmware and resource failures no longer silently suppress cpufreq.

Fixes: 337aadff8e45 ("ACPI: Introduce CPU performance controls using CPPC")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 112 +++++++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a3a203f8e816..15d2bbc62278 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -129,6 +129,21 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				!!(cpc)->cpc_entry.int_value :		\
 				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
 
+static bool cpc_is_writable(const struct cpc_register_resource *cpc)
+{
+	return cpc->type == ACPI_TYPE_BUFFER &&
+	       !IS_NULL_REG(&cpc->cpc_entry.reg);
+}
+
+static bool cpc_entry_present(const struct cpc_register_resource *cpc)
+{
+	if (cpc->type == ACPI_TYPE_INTEGER)
+		return true;
+
+	return cpc->type == ACPI_TYPE_BUFFER &&
+	       !IS_NULL_REG(&cpc->cpc_entry.reg);
+}
+
 /*
  * Each bit indicates the optionality of the register in per-cpu
  * cpc_regs[] with the corresponding index. 0 means mandatory and 1
@@ -142,6 +157,29 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
  */
 #define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
 
+static bool cpc_integer_entry_valid(unsigned int reg_idx, u64 value)
+{
+	switch (reg_idx) {
+	case HIGHEST_PERF:
+	case NOMINAL_PERF:
+	case LOW_NON_LINEAR_PERF:
+	case LOWEST_PERF:
+	case CTR_WRAP_TIME:
+	case REFERENCE_PERF:
+	case LOWEST_FREQ:
+	case NOMINAL_FREQ:
+		return value <= U32_MAX;
+	case AUTO_SEL_ENABLE:
+		return value <= 1;
+	case DESIRED_PERF:
+		/* Validated against Autonomous Selection after parsing. */
+		return value == 0;
+	default:
+		/* Tolerate the customary Integer 0 for an absent option. */
+		return value == 0 && IS_OPTIONAL_CPC_REG(reg_idx);
+	}
+}
+
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
  * to PCC commands. Keeping it high enough to cover emulators where
@@ -150,6 +188,8 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 #define NUM_RETRIES 500ULL
 
 #define OVER_16BTS_MASK ~0xFFFFULL
+#define CPC_GENERIC_REGISTER_DESCRIPTOR 0x82
+#define CPC_GENERIC_REGISTER_LENGTH (sizeof(struct cpc_reg) - 3)
 
 #define define_one_cppc_ro(_name)		\
 static struct kobj_attribute _name =		\
@@ -870,11 +910,32 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		cpc_obj = &out_obj->package.elements[i];
 
 		if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
-			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
-			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = cpc_obj->integer.value;
+			if (!cpc_integer_entry_valid(i - 2,
+						     cpc_obj->integer.value)) {
+				pr_debug("Invalid Integer _CPC register %u for CPU:%d\n",
+					 i - 2, pr->id);
+				ret = -EINVAL;
+				goto out_free;
+			}
+			cpc_ptr->cpc_regs[i - 2].type = ACPI_TYPE_INTEGER;
+			cpc_ptr->cpc_regs[i - 2].cpc_entry.int_value = cpc_obj->integer.value;
 		} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
+			if (cpc_obj->buffer.length < sizeof(*gas_t)) {
+				pr_debug("Invalid register descriptor for CPU:%d\n",
+					 pr->id);
+				ret = -EINVAL;
+				goto out_free;
+			}
+
 			gas_t = (struct cpc_reg *)
 				cpc_obj->buffer.pointer;
+			if (gas_t->descriptor != CPC_GENERIC_REGISTER_DESCRIPTOR ||
+			    gas_t->length != CPC_GENERIC_REGISTER_LENGTH) {
+				pr_debug("Invalid register resource for CPU:%d\n",
+					 pr->id);
+				ret = -EINVAL;
+				goto out_free;
+			}
 
 			/*
 			 * The PCC Subspace index is encoded inside
@@ -960,15 +1021,35 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
 
+	/*
+	 * Performance Limited is required by the specification, but tolerate a
+	 * NULL descriptor used by firmware which cannot report limiting events.
+	 * CPPC control does not depend on this status.
+	 */
+	for (i = 0; i < num_ent - 2; i++) {
+		if (i != DESIRED_PERF && i != PERF_LIMITED &&
+		    !IS_OPTIONAL_CPC_REG(i) &&
+		    !cpc_entry_present(&cpc_ptr->cpc_regs[i])) {
+			pr_debug("CPU:%d lacks mandatory _CPC register %u\n",
+				 pr->id, i);
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
 	/*
 	 * In CPPC v1, DESIRED_PERF is mandatory. In CPPC v2, it is optional
 	 * only when AUTO_SEL_ENABLE is supported.
 	 */
-	if (!CPC_SUPPORTED(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
+	if (!cpc_is_writable(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
 	    (!osc_sb_cppc2_support_acked ||
-	     !CPC_SUPPORTED(&cpc_ptr->cpc_regs[AUTO_SEL_ENABLE])))
-		pr_warn("Desired perf. register is mandatory if CPPC v2 is not supported "
-			"or autonomous selection is disabled\n");
+	     cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].type != ACPI_TYPE_INTEGER ||
+	     cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].cpc_entry.int_value != 1)) {
+		pr_debug("CPU:%d lacks a writable Desired Performance register\n",
+			 pr->id);
+		ret = -EINVAL;
+		goto out_free;
+	}
 
 	/*
 	 * Initialize the remaining cpc_regs as unsupported.
@@ -1026,6 +1107,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	return 0;
 
 out_free:
+	pr_err("CPU%d: failed to initialize _CPC: %d\n", pr->id, ret);
+
 	/* Free all the mapped sys mem areas for this CPU */
 	for (i = 2; i < cpc_ptr->num_entries; i++) {
 		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
@@ -1200,11 +1283,18 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	u64 prev_val;
 	void __iomem *vaddr = NULL;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
-	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
+	struct cpc_reg *reg;
 	struct cpc_desc *cpc_desc;
 	unsigned long flags;
 	bool locked = false;
 
+	if (reg_res->type != ACPI_TYPE_BUFFER)
+		return -EOPNOTSUPP;
+
+	reg = &reg_res->cpc_entry.reg;
+	if (IS_NULL_REG(reg))
+		return -EOPNOTSUPP;
+
 	size = GET_BIT_WIDTH(reg);
 
 	if (IS_ENABLED(CONFIG_HAS_IOPORT) &&
@@ -1398,7 +1488,7 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
 	/* if a register is writeable, it must be a buffer and not null */
-	if ((reg->type != ACPI_TYPE_BUFFER) || IS_NULL_REG(&reg->cpc_entry.reg)) {
+	if (!cpc_is_writable(reg)) {
 		pr_debug("CPC register is not supported\n");
 		return -EOPNOTSUPP;
 	}
@@ -1571,7 +1661,7 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		goto out_err;
 	perf_caps->lowest_nonlinear_perf = min_nonlinear;
 
-	if (!high || !low || !nom || !ref || !min_nonlinear) {
+	if (!high || !nom || !ref || !min_nonlinear) {
 		ret = -EFAULT;
 		goto out_err;
 	}
@@ -1750,13 +1840,13 @@ int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable)
 			return -ENODEV;
 		}
 
-		if (CPC_SUPPORTED(auto_sel_reg)) {
+		if (cpc_is_writable(auto_sel_reg)) {
 			ret = cpc_write(cpu, auto_sel_reg, enable);
 			if (ret)
 				return ret;
 		}
 
-		if (CPC_SUPPORTED(epp_set_reg)) {
+		if (cpc_is_writable(epp_set_reg)) {
 			ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
 			if (ret)
 				return ret;
-- 
2.34.1

