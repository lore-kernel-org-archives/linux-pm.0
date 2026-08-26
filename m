Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C683BBA0A;
	Wed, 26 Aug 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725884; cv=none; b=ivigUv+U2zCq5ht79H/e7qwX/AE0+I0/6qKDVEINWnBw9hqcQdRhqD9fG7Z2/EAfxDF/Hr5GX2bnazyR1kjUZpJCIk7VfIMURYEL4u4agqPmVO6zpTKvGbRyWFpd1FeDRIQU32OvHIE4WbleANcN4q13+LyUUIHgxZ02uDvLKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725884; c=relaxed/simple;
	bh=dod/31aalkw5NC++ec7S5xfDDRiYIPjZyStVMp6Ok5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kwb7OaRG6MbXzoqChojatC5LWz/u6WY9igHpzr/Twh0MsmQMK/PzzWQOo3OKe+vyfiRsLM1GAGO5JcDUFDtWVW2n+VDR98emuwIxzvkkDt6LjCb58XX4LeLMp+4onLB4msUkjYLFVRod1mvKKlIqummPy158EBBzxLKcWjON11g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=joLhqmF7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="joLhqmF7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAF9D1D31;
	Tue, 25 Aug 2026 23:31:11 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 970E53F7D8;
	Tue, 25 Aug 2026 23:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725875; bh=dod/31aalkw5NC++ec7S5xfDDRiYIPjZyStVMp6Ok5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joLhqmF7uCXLIHzRKS/Je1bRvUT+miU8A0lLF4WEYObdV1LCVl/Jt4Ft/TzSDflZo
	 zH3wu7BlpbXR/akRjoC/jNibW3sztObe98RRVUjGrDm1zytb9OzM0BfpzkyVs9Qeac
	 ZQzsjwEsktt5e9gi9CYrLKwc2ltsd2LdLoK5cMUA=
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
Subject: [PATCH v4 15/15] ACPI: CPPC: Clear Performance Limited without a stale read
Date: Wed, 26 Aug 2026 07:30:19 +0100
Message-Id: <20260826063019.670240-16-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260826063019.670240-1-christian.loehle@arm.com>
References: <20260826063019.670240-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Performance Limited status bits are sticky and write-zero-to-clear.
ACPI 6.6 Section 8.4.6.1.3.2 also requires both entities to use interlocked
accesses.

cppc_set_perf_limited() currently reads the register, computes a new value,
and writes it in a separate transaction. If the platform reports another
excursion between those transactions, the stale write can clear that new
event.

Write zero to the requested bits and one to the other defined status bits
directly. Keep reserved bits zero as required for hardware status registers
by ACPI 6.6 Section 4.6.1. This removes the stale read window.

A partial SystemMemory field would still make the generic writer perform a
read-modify-write to preserve the containing access unit. The
per-descriptor spinlock cannot interlock that RMW with platform updates, so
reject clears of such a field. Keep the descriptor mapped and readable,
because reading the containing access unit once and extracting the field
does not require RMW.

Also reject another writable SystemMemory field sharing Performance
Limited's access unit. Its RMW could similarly replay stale status bits,
and an OSPM lock cannot serialize against the platform.

Also reject 64-bit SystemMemory descriptions on 32-bit kernels, where
generic readq()/writeq() may be split into two 32-bit operations and cannot
provide the required portable interlocked access. A naturally aligned
full-width QWord remains supported on 64-bit kernels, where the
architecture provides a native 64-bit MMIO accessor.

Performance Limited status is not required for CPPC control. If firmware
describes it using an access which Linux cannot read safely, disable that
status register instead of rejecting the processor's otherwise usable _CPC
package. Report reads as unsupported rather than returning a synthetic
zero, and emit a single warning for each nonfatal fallback.

Fixes: 13c45a26635f ("ACPI: CPPC: add APIs and sysfs interface for perf_limited")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260807111303.1062391-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 74 +++++++++++++++++++++++++++-------------
 include/acpi/cppc_acpi.h |  1 +
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2d9c04a8c93c..b97227a661f5 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -193,7 +193,8 @@ static struct cpc_sysmem_node *cpc_sysmem_next(struct cpc_sysmem_node *node,
 static bool cpc_is_writable(const struct cpc_register_resource *cpc)
 {
 	return cpc->type == ACPI_TYPE_BUFFER &&
-	       !IS_NULL_REG(&cpc->cpc_entry.reg);
+	       !IS_NULL_REG(&cpc->cpc_entry.reg) &&
+	       !cpc->cpc_entry.write_unsupported;
 }
 
 static bool cpc_entry_present(const struct cpc_register_resource *cpc)
@@ -382,7 +383,7 @@ static bool cpc_sysmem_reg_needs_rmw(const struct cpc_register_resource *reg)
 	return gas->bit_offset || gas->bit_width != access_size * 8;
 }
 
-static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
+static int cpc_validate_sysmem_reg(struct cpc_desc *cpc_desc,
 				   const struct cpc_reg *gas,
 				   unsigned int reg_idx)
 {
@@ -404,6 +405,17 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
 	if (gas->address & (access_size - 1))
 		goto invalid;
 
+	if (reg_idx == PERF_LIMITED) {
+		if (access_width == 64 && !IS_ENABLED(CONFIG_64BIT))
+			return -EINVAL;
+
+		if (gas->bit_offset || gas->bit_width != access_width) {
+			pr_warn("CPU%d: Performance Limited register cannot be cleared safely; keeping it readable\n",
+				cpc_desc->cpu_id);
+			cpc_desc->cpc_regs[reg_idx].cpc_entry.write_unsupported = true;
+		}
+	}
+
 	return 0;
 
 invalid:
@@ -430,6 +442,14 @@ static int cpc_resolve_unsupported(struct cpc_desc *cpc_desc,
 		if (!(unsupported & BIT(i)))
 			continue;
 
+		/* CPPC control does not depend on Performance Limited status. */
+		if (i == PERF_LIMITED) {
+			pr_warn("CPU%d: ignoring inaccessible Performance Limited register\n",
+				cpc_desc->cpu_id);
+			cpc_disable_reg(cpc_desc, i);
+			continue;
+		}
+
 		if (i == DESIRED_PERF && cpc_immutable_autonomous(cpc_desc)) {
 			pr_warn("CPU%d: ignoring inaccessible Desired Performance register in autonomous mode\n",
 				cpc_desc->cpu_id);
@@ -716,7 +736,8 @@ static void cpc_mark_rmw_lock_users(struct cpc_desc *cpc_desc)
 	for (i = 0; i < cpc_desc->num_entries - 2; i++) {
 		struct cpc_register_resource *reg = &cpc_desc->cpc_regs[i];
 
-		if (CPC_SUPPORTED(reg) && CPC_IN_SYSTEM_MEMORY(reg))
+		if (CPC_SUPPORTED(reg) && CPC_IN_SYSTEM_MEMORY(reg) &&
+		    cpc_is_writable(reg))
 			reg->cpc_entry.use_rmw_lock =
 				cpc_sysmem_reg_needs_rmw(reg);
 	}
@@ -797,10 +818,11 @@ static int cpc_validate_sysmem_pair(const struct cpc_desc *a_desc,
 
 	if (cpc_same_sysmem_register(a_idx, a, b_idx, b)) {
 		/*
-		 * Cross-CPU partial writes were never safely serialized, and a
-		 * 64-bit MMIO write may be split on 32-bit kernels.
+		 * Identical read-only registers may be shared. Cross-CPU partial
+		 * writes were never safely serialized, and a 64-bit MMIO write may
+		 * be split on 32-bit kernels.
 		 */
-		if (!a_writable ||
+		if ((!cpc_is_writable(a) && !cpc_is_writable(b)) ||
 		    (!cpc_sysmem_reg_needs_rmw(a) &&
 		     (cpc_sysmem_access_size(a) < sizeof(u64) ||
 		      IS_ENABLED(CONFIG_64BIT))))
@@ -808,6 +830,15 @@ static int cpc_validate_sysmem_pair(const struct cpc_desc *a_desc,
 		goto conflict;
 	}
 
+	/*
+	 * The platform may set Performance Limited asynchronously.  A write to
+	 * another field in the same access unit could write back stale status
+	 * bits, which an OSPM lock cannot prevent.
+	 */
+	if ((a_idx == PERF_LIMITED && b_writable && cpc_is_writable(b)) ||
+	    (b_idx == PERF_LIMITED && a_writable && cpc_is_writable(a)))
+		goto conflict;
+
 	/*
 	 * A full-width writable register owns its access unit.  It cannot
 	 * coexist with another logical field because it has no bits to
@@ -2026,13 +2057,10 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	unsigned int i;
 	bool locked = false;
 
-	if (reg_res->type != ACPI_TYPE_BUFFER)
+	if (!cpc_is_writable(reg_res))
 		return -EOPNOTSUPP;
 
 	reg = &reg_res->cpc_entry.reg;
-	if (IS_NULL_REG(reg))
-		return -EOPNOTSUPP;
-
 	size = GET_BIT_WIDTH(reg);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -2194,9 +2222,13 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-	/* Desired may be absent for immutable autonomous selection. */
+	/*
+	 * Desired and Performance Limited may be disabled despite not being
+	 * generally optional.
+	 */
 	if ((reg->type == ACPI_TYPE_INTEGER &&
-	     (IS_OPTIONAL_CPC_REG(reg_idx) || reg_idx == DESIRED_PERF) &&
+	     (IS_OPTIONAL_CPC_REG(reg_idx) || reg_idx == DESIRED_PERF ||
+	      reg_idx == PERF_LIMITED) &&
 	     !reg->cpc_entry.int_value) || (reg->type != ACPI_TYPE_INTEGER &&
 	     IS_NULL_REG(&reg->cpc_entry.reg))) {
 		pr_debug("CPC register is not supported\n");
@@ -3117,9 +3149,6 @@ EXPORT_SYMBOL_GPL(cppc_get_perf_limited);
  */
 int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 {
-	u64 current_val, new_val;
-	int ret;
-
 	/* Only bits 0 and 1 are valid */
 	if (bits_to_clear & ~CPPC_PERF_LIMITED_MASK)
 		return -EINVAL;
@@ -3127,14 +3156,13 @@ int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 	if (!bits_to_clear)
 		return 0;
 
-	ret = cppc_get_perf_limited(cpu, &current_val);
-	if (ret)
-		return ret;
-
-	/* Clear the specified bits */
-	new_val = current_val & ~bits_to_clear;
-
-	return cppc_set_reg_val(cpu, PERF_LIMITED, new_val);
+	/*
+	 * Performance Limited is write-zero-to-clear.  Write one to the other
+	 * defined sticky bits so a concurrently reported event is not cleared
+	 * using a value obtained by an earlier, separate read transaction.
+	 */
+	return cppc_set_reg_val(cpu, PERF_LIMITED,
+				CPPC_PERF_LIMITED_MASK & ~bits_to_clear);
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 3275ecb51ca5..91635fcac3c5 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -72,6 +72,7 @@ struct cpc_register_resource {
 		struct {
 			struct cpc_reg reg;
 			bool use_rmw_lock;
+			bool write_unsupported;
 		};
 		u64 int_value;
 	} cpc_entry;
-- 
2.34.1

