Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC5A3AD52A;
	Wed, 26 Aug 2026 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725870; cv=none; b=OO6yZPqLREe0sNxd88g6k9QwbKousi1xEYRnT/IHq53rZXCkDp3dZJjrw4COYOSVU1M06YZCEOpElpBX5PJWCsiPRBrQBbRTVLHLUIMsUZS1R7CSp3LSLJGOkF3aDO9HCzjUqHQ+bNcmgJxEQdmeyNkco4uiZOyklWdTmxeLQKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725870; c=relaxed/simple;
	bh=Up8LTLFJ4mP3dFoCSAbi0pgkXmzgH2mtWAqiy4O49Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKYzJI5Og3XxBBBICOXNDdJaNwt+eYCgrxpWKJfzqPJQuKp7VtHYQBXPlivGnjkshy8vipAuGmYSEJ6Te+XICf1VRpDRKhqpKQlq2k0h+/SfQx2SUd2e8D+8w42NxI3ikzo0nIIQWNOfbLl+bFYbU0xKwSrwcZtT6weYRsG+Mj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HZll/IIW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HZll/IIW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E1F71BCA;
	Tue, 25 Aug 2026 23:30:58 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3EB93F7D8;
	Tue, 25 Aug 2026 23:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725862; bh=Up8LTLFJ4mP3dFoCSAbi0pgkXmzgH2mtWAqiy4O49Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZll/IIW0pIQI0hFKdVcC6kUUN35T9xB5BA0QUVDXbm7Au3V3cm7yVQAXvyP13LQF
	 R25ProVL1tAnCaOvSu7pxWScGL4u6tPbzEcItCEeqd7JFBoOJNgEQ2cLyad+uVL4+w
	 f6Q70R8WwSnIwrtejGd3Yk+t5viOUCi3YVvCxVzY=
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
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v4 11/15] ACPI: CPPC: Validate and access PCC register layouts
Date: Wed, 26 Aug 2026 07:30:15 +0100
Message-Id: <20260826063019.670240-12-christian.loehle@arm.com>
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

PCC GAS Access Size identifies the subspace, so the accessors use Bit Width
as the field size. Their typed readw/readl/readq operations require natural
alignment and support only 8, 16, 32, or 64 bits. This rejects valid
firmware: ACPI 6.6 shows a mandatory 32-bit Delivered Performance Counter
at unaligned offset 0x116, and performance controls may use byte-multiple
widths such as 24 bits.

Support zero-offset, byte-multiple fields up to 64 bits with byte-oriented
I/O and explicit little-endian encoding. A short per-subspace raw spinlock
serializes aliased payload copies performed concurrently under the shared
side of pcc_lock. Fields with a nonzero bit offset or non-byte width still
need unsupported RMW semantics and are rejected or disabled.

Defer that decision until the entire package is known. A provided but
inaccessible CPPC Enable control fails probe because OSPM must write it
before using CPPC. An inaccessible Desired control can be ignored only for
immutable autonomous operation. Inaccessible Minimum or Maximum controls
fail probe, and the post-sanitization check enforces the specification
requirement that both controls exist or neither does. Other inaccessible
optional controls are marked absent; mandatory controls fail.

Keep the eventual probe result negative while temporary validation helpers
succeed. This prevents a later malformed entry, unsupported address space,
or mapping failure from freeing the descriptor and nevertheless returning
success.

Apply the same control-specific policy to unsupported SystemMemory
geometry. Once the PCC channel is available, verify every retained field
fits after the eight-byte header and within shared memory, and reject
overlapping logical ranges when either is writable.

This deliberately does not implement bit-level PCC RMW. In particular, the
one-bit CPPC Enable field in the specification example now produces an
explicit probe failure instead of being silently treated as absent.

Fixes: 85b1407bf6d2 ("ACPI / CPPC: Make CPPC ACPI driver aware of PCC subspace IDs")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 305 ++++++++++++++++++++++++++++++++-------
 1 file changed, 255 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a5920e627d00..68125e9cf977 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -73,6 +73,8 @@ struct cppc_pcc_data {
 	 *	Take write_lock for all purposes which gives exclusive access
 	 */
 	struct rw_semaphore pcc_lock;
+	/* Serialize byte-oriented accesses to aliased PCC payload fields. */
+	raw_spinlock_t payload_lock;
 
 	/* Wait queue for CPUs whose requests were batched */
 	wait_queue_head_t pcc_write_wait_q;
@@ -127,9 +129,11 @@ static struct cpc_sysmem_node *cpc_sysmem_next(struct cpc_sysmem_node *node,
 	return cpc_sysmem_itree_iter_next(node, start, last);
 }
 
+#define CPC_PCC_HEADER_SIZE	0x8
+
 /* pcc mapped address + header size + offset within PCC subspace */
 #define GET_PCC_VADDR(offs, pcc_ss_id) (pcc_data[pcc_ss_id]->pcc_channel->shmem + \
-						0x8 + (offs))
+						CPC_PCC_HEADER_SIZE + (offs))
 
 /* Check if a CPC register is in PCC */
 #define CPC_IN_PCC(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&		\
@@ -386,6 +390,170 @@ static int cpc_validate_sysmem_reg(const struct cpc_desc *cpc_desc,
 	return -EINVAL;
 }
 
+static bool cpc_immutable_autonomous(const struct cpc_desc *cpc_desc)
+{
+	const struct cpc_register_resource *reg;
+
+	reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
+	return osc_sb_cppc2_support_acked && reg->type == ACPI_TYPE_INTEGER &&
+	       reg->cpc_entry.int_value == 1;
+}
+
+static int cpc_resolve_unsupported(struct cpc_desc *cpc_desc,
+				   u32 unsupported)
+{
+	unsigned int i;
+
+	for (i = 0; i < cpc_desc->num_entries - 2; i++) {
+		if (!(unsupported & BIT(i)))
+			continue;
+
+		if (i == DESIRED_PERF && cpc_immutable_autonomous(cpc_desc)) {
+			pr_warn("CPU%d: ignoring inaccessible Desired Performance register in autonomous mode\n",
+				cpc_desc->cpu_id);
+			cpc_disable_reg(cpc_desc, i);
+			continue;
+		}
+
+		/* A present Enable control must be usable to enter CPPC mode. */
+		if (i == ENABLE || i == MIN_PERF || i == MAX_PERF ||
+		    !IS_OPTIONAL_CPC_REG(i)) {
+			pr_err("CPU%d: cannot access _CPC register %u\n",
+			       cpc_desc->cpu_id, i);
+			return -EINVAL;
+		}
+
+		pr_warn("CPU%d: ignoring inaccessible optional _CPC register %u\n",
+			cpc_desc->cpu_id, i);
+		cpc_disable_reg(cpc_desc, i);
+	}
+
+	return 0;
+}
+
+static int cpc_validate_required_controls(struct cpc_desc *cpc_desc)
+{
+	bool have_min, have_max;
+	unsigned int i;
+
+	/*
+	 * Performance Limited is required by the specification, but tolerate a
+	 * NULL descriptor used by firmware which cannot report limiting events.
+	 * CPPC control does not depend on this status.
+	 */
+	for (i = 0; i < cpc_desc->num_entries - 2; i++) {
+		if (i != DESIRED_PERF && i != PERF_LIMITED &&
+		    !IS_OPTIONAL_CPC_REG(i) &&
+		    !cpc_entry_present(&cpc_desc->cpc_regs[i])) {
+			pr_debug("CPU:%d lacks mandatory _CPC register %u\n",
+				 cpc_desc->cpu_id, i);
+			return -EINVAL;
+		}
+	}
+
+	/* Desired may be absent only for immutable autonomous operation. */
+	if (!cpc_is_writable(&cpc_desc->cpc_regs[DESIRED_PERF]) &&
+	    !cpc_immutable_autonomous(cpc_desc)) {
+		pr_debug("CPU:%d lacks a writable Desired Performance register\n",
+			 cpc_desc->cpu_id);
+		return -EINVAL;
+	}
+
+	have_min = cpc_is_writable(&cpc_desc->cpc_regs[MIN_PERF]);
+	have_max = cpc_is_writable(&cpc_desc->cpc_regs[MAX_PERF]);
+	if (have_min != have_max) {
+		pr_err("CPU%d: _CPC must provide both Minimum and Maximum Performance or neither\n",
+		       cpc_desc->cpu_id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cpc_validate_pcc_bounds(struct cpc_desc *cpc_desc,
+				   struct cppc_pcc_data *data,
+				   u32 *unsupported)
+{
+	u64 shmem_size = data->pcc_channel->shmem_size;
+	unsigned int i;
+
+	for (i = 0; i < cpc_desc->num_entries - 2; i++) {
+		struct cpc_register_resource *reg = &cpc_desc->cpc_regs[i];
+		struct cpc_reg *gas;
+		u64 access_size;
+
+		if ((*unsupported & BIT(i)) || !CPC_SUPPORTED(reg) ||
+		    !CPC_IN_PCC(reg))
+			continue;
+
+		gas = &reg->cpc_entry.reg;
+		access_size = gas->bit_width / 8;
+		if (shmem_size >= CPC_PCC_HEADER_SIZE &&
+		    gas->address <= shmem_size - CPC_PCC_HEADER_SIZE &&
+		    access_size <= shmem_size - CPC_PCC_HEADER_SIZE - gas->address)
+			continue;
+
+		pr_debug("CPU%d: _CPC register %u exceeds the PCC shared region\n",
+			 cpc_desc->cpu_id, i);
+		*unsupported |= BIT(i);
+	}
+
+	return 0;
+}
+
+static u64 cpc_non_mmio_access_size(const struct cpc_register_resource *reg)
+{
+	const struct cpc_reg *gas = &reg->cpc_entry.reg;
+
+	if (gas->space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
+		return gas->bit_width / 8;
+
+	return cpc_reg_access_width(gas) / 8;
+}
+
+static int cpc_validate_non_mmio_overlaps(struct cpc_desc *cpc_desc,
+					  u8 space_id, const char *name)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < cpc_desc->num_entries - 2; i++) {
+		struct cpc_register_resource *a = &cpc_desc->cpc_regs[i];
+		const struct cpc_reg *a_gas;
+		u64 a_size;
+
+		if (!CPC_SUPPORTED(a) || a->type != ACPI_TYPE_BUFFER ||
+		    a->cpc_entry.reg.space_id != space_id)
+			continue;
+
+		a_gas = &a->cpc_entry.reg;
+		a_size = cpc_non_mmio_access_size(a);
+		for (j = i + 1; j < cpc_desc->num_entries - 2; j++) {
+			struct cpc_register_resource *b = &cpc_desc->cpc_regs[j];
+			const struct cpc_reg *b_gas;
+			u64 b_size;
+
+			if (!CPC_SUPPORTED(b) || b->type != ACPI_TYPE_BUFFER ||
+			    b->cpc_entry.reg.space_id != space_id)
+				continue;
+
+			b_gas = &b->cpc_entry.reg;
+			b_size = cpc_non_mmio_access_size(b);
+			if (!cpc_reg_is_writable(i) && !cpc_reg_is_writable(j))
+				continue;
+			if (a_gas->address < b_gas->address ?
+			    b_gas->address - a_gas->address >= a_size :
+			    a_gas->address - b_gas->address >= b_size)
+				continue;
+
+			pr_err("CPU%d: overlapping writable %s _CPC registers %u and %u\n",
+			       cpc_desc->cpu_id, name, i, j);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static void cpc_mark_rmw_lock_users(struct cpc_desc *cpc_desc)
 {
 	int i;
@@ -1081,6 +1249,7 @@ static int pcc_data_alloc(int pcc_ss_id)
 		pcc_data[pcc_ss_id] = kzalloc_obj(struct cppc_pcc_data);
 		if (!pcc_data[pcc_ss_id])
 			return -ENOMEM;
+		raw_spin_lock_init(&pcc_data[pcc_ss_id]->payload_lock);
 		pcc_data[pcc_ss_id]->refcount++;
 	}
 
@@ -1149,10 +1318,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	struct device *cpu_dev;
 	acpi_handle handle = pr->handle;
 	unsigned int num_ent, i, cpc_rev;
+	u32 unsupported_regs = 0;
 	int pcc_subspace_id = -1;
 	bool pcc_data_ref = false;
 	acpi_status status;
-	int ret = -ENODATA;
+	int ret = -EINVAL;
 	int err;
 
 	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
@@ -1280,6 +1450,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 				goto out_free;
 			}
 
+			cpc_ptr->cpc_regs[i - 2].type = ACPI_TYPE_BUFFER;
+			memcpy(&cpc_ptr->cpc_regs[i - 2].cpc_entry.reg, gas_t,
+			       sizeof(*gas_t));
+
 			/*
 			 * The PCC Subspace index is encoded inside
 			 * the CPC table entries. The same PCC index
@@ -1287,6 +1461,12 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			 * so extract it only once.
 			 */
 			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+				if (!gas_t->bit_width || gas_t->bit_width > 64 ||
+				    gas_t->bit_offset || gas_t->bit_width % 8) {
+					unsupported_regs |= BIT(i - 2);
+					continue;
+				}
+
 				if (pcc_subspace_id < 0) {
 					pcc_subspace_id = gas_t->access_width;
 					err = pcc_data_alloc(pcc_subspace_id);
@@ -1298,6 +1478,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 				} else if (pcc_subspace_id != gas_t->access_width) {
 					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
 						 pr->id);
+					ret = -EINVAL;
 					goto out_free;
 				}
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
@@ -1305,21 +1486,11 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					void __iomem *addr;
 					size_t access_width;
 
-					err = cpc_validate_sysmem_reg(cpc_ptr, gas_t, i - 2);
-					if (err && (i - 2 == DESIRED_PERF ||
-						    i - 2 == OSPM_NOMINAL_PERF)) {
-						const char *name = i - 2 == DESIRED_PERF ?
-								   "Desired Performance" :
-								   "OSPM Nominal Performance";
-
-						pr_warn("CPU%d: disabling inaccessible %s register\n",
-							pr->id, name);
-						cpc_disable_reg(cpc_ptr, i - 2);
-						continue;
-					}
+					err = cpc_validate_sysmem_reg(cpc_ptr, gas_t,
+								      i - 2);
 					if (err) {
-						ret = err;
-						goto out_free;
+						unsupported_regs |= BIT(i - 2);
+						continue;
 					}
 
 					if (!osc_cpc_flexible_adr_space_confirmed) {
@@ -1331,8 +1502,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					access_width = cpc_reg_access_width(gas_t);
 					access_width /= 8;
 					addr = ioremap(gas_t->address, access_width);
-					if (!addr)
+					if (!addr) {
+						ret = -ENOMEM;
 						goto out_free;
+					}
 					cpc_ptr->cpc_regs[i - 2].sys_mem_vaddr = addr;
 				}
 			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
@@ -1365,10 +1538,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 					goto out_free;
 				}
 			}
-
-			cpc_ptr->cpc_regs[i - 2].type = ACPI_TYPE_BUFFER;
-			memcpy(&cpc_ptr->cpc_regs[i - 2].cpc_entry.reg, gas_t,
-			       sizeof(*gas_t));
 		} else if (cpc_obj->type == ACPI_TYPE_PACKAGE && (i - 2) == RESOURCE_PRIORITY) {
 			/*
 			 * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority as a
@@ -1387,35 +1556,14 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	}
 	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
 
-	/*
-	 * Performance Limited is required by the specification, but tolerate a
-	 * NULL descriptor used by firmware which cannot report limiting events.
-	 * CPPC control does not depend on this status.
-	 */
-	for (i = 0; i < num_ent - 2; i++) {
-		if (i != DESIRED_PERF && i != PERF_LIMITED &&
-		    !IS_OPTIONAL_CPC_REG(i) &&
-		    !cpc_entry_present(&cpc_ptr->cpc_regs[i])) {
-			pr_debug("CPU:%d lacks mandatory _CPC register %u\n",
-				 pr->id, i);
-			ret = -EINVAL;
-			goto out_free;
-		}
-	}
+	ret = cpc_resolve_unsupported(cpc_ptr, unsupported_regs);
+	if (ret)
+		goto out_free;
+	unsupported_regs = 0;
 
-	/*
-	 * In CPPC v1, DESIRED_PERF is mandatory. In CPPC v2, it is optional
-	 * only when AUTO_SEL_ENABLE is supported.
-	 */
-	if (!cpc_is_writable(&cpc_ptr->cpc_regs[DESIRED_PERF]) &&
-	    (!osc_sb_cppc2_support_acked ||
-	     cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].type != ACPI_TYPE_INTEGER ||
-	     cpc_ptr->cpc_regs[AUTO_SEL_ENABLE].cpc_entry.int_value != 1)) {
-		pr_debug("CPU:%d lacks a writable Desired Performance register\n",
-			 pr->id);
-		ret = -EINVAL;
+	ret = cpc_validate_required_controls(cpc_ptr);
+	if (ret)
 		goto out_free;
-	}
 
 	/*
 	 * Initialize the remaining cpc_regs as unsupported.
@@ -1449,6 +1597,27 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		init_rwsem(&pcc_data[pcc_subspace_id]->pcc_lock);
 		init_waitqueue_head(&pcc_data[pcc_subspace_id]->pcc_write_wait_q);
 	}
+	if (pcc_subspace_id >= 0) {
+		ret = cpc_validate_pcc_bounds(cpc_ptr,
+					      pcc_data[pcc_subspace_id],
+					      &unsupported_regs);
+		if (ret)
+			goto out_free;
+
+		ret = cpc_resolve_unsupported(cpc_ptr, unsupported_regs);
+		if (ret)
+			goto out_free;
+	}
+
+	ret = cpc_validate_non_mmio_overlaps(cpc_ptr,
+					     ACPI_ADR_SPACE_PLATFORM_COMM,
+					     "PCC");
+	if (ret)
+		goto out_free;
+
+	ret = cpc_validate_required_controls(cpc_ptr);
+	if (ret)
+		goto out_free;
 
 	/* Everything looks okay */
 	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
@@ -1574,6 +1743,9 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 {
 	void __iomem *vaddr = NULL;
+	unsigned long flags;
+	u8 buf[sizeof(*val)];
+	unsigned int i;
 	int size;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
@@ -1601,13 +1773,29 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
 
 		*val = val_u32;
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		if (pcc_ss_id < 0 || !pcc_data[pcc_ss_id])
+			return -ENODEV;
+
 		/*
 		 * For registers in PCC space, the register size is determined
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+		size = reg->bit_width / 8;
+		if (!size || size > sizeof(buf) || reg->bit_width % 8)
+			return -EFAULT;
+
+		raw_spin_lock_irqsave(&pcc_data[pcc_ss_id]->payload_lock, flags);
+		memcpy_fromio(buf, vaddr, size);
+		raw_spin_unlock_irqrestore(&pcc_data[pcc_ss_id]->payload_lock,
+					   flags);
+
+		*val = 0;
+		for (i = 0; i < size; i++)
+			*val |= (u64)buf[i] << (i * 8);
+		return 0;
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
@@ -1657,6 +1845,8 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	struct cpc_reg *reg;
 	struct cpc_desc *cpc_desc;
 	unsigned long flags;
+	u8 buf[sizeof(val)];
+	unsigned int i;
 	bool locked = false;
 
 	if (reg_res->type != ACPI_TYPE_BUFFER)
@@ -1681,13 +1871,28 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		}
 
 		return 0;
-	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id >= 0) {
+	} else if (reg->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		if (pcc_ss_id < 0 || !pcc_data[pcc_ss_id])
+			return -ENODEV;
+
 		/*
 		 * For registers in PCC space, the register size is determined
 		 * by the bit width field; the access size is used to indicate
 		 * the PCC subspace id.
 		 */
 		vaddr = GET_PCC_VADDR(reg->address, pcc_ss_id);
+		size = reg->bit_width / 8;
+		if (!size || size > sizeof(buf) || reg->bit_width % 8)
+			return -EFAULT;
+
+		for (i = 0; i < size; i++)
+			buf[i] = val >> (i * 8);
+
+		raw_spin_lock_irqsave(&pcc_data[pcc_ss_id]->payload_lock, flags);
+		memcpy_toio(vaddr, buf, size);
+		raw_spin_unlock_irqrestore(&pcc_data[pcc_ss_id]->payload_lock,
+					   flags);
+		return 0;
 	}
 	else if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
 		vaddr = reg_res->sys_mem_vaddr;
-- 
2.34.1

