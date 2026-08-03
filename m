Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82B3B71C6;
	Mon,  3 Aug 2026 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791145; cv=none; b=nPLCqE3qfK0Om2bN1C9w+hVrZSH4kc+n87mcRNG0h1TQJdp/1CfvoFUGFkIxxYWvYv55vSHjGOQ5EALbgjvZBGKOwaeQEJqnwSqO6KZXkEeerWUjxRN1oQGqHeItwSzp28wheRG7MxtMzufp0lqUZXp/xbefWVsjwVdTRqZOqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791145; c=relaxed/simple;
	bh=gq9J1RvWC89pSiDbdZPLorYduWb+4Hbnf2Jhd3DjhiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H83zOPNCccbRgjhUAeZTQw5u1XLzCb4QblIUVK0Zu99CF1ljdIbsGsw33FxByCzJT0P1ECCWgk2raymYdgQo/ZZx6qDQlvBSjT3E8pRWL3yDEzaIU9YTWe9mFiE6TvedPcBx2S1E9/ojuueny76/CMD/fFQTpldElRKGOeJR+90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=q79hImrF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q79hImrF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B03E143D;
	Mon,  3 Aug 2026 14:05:39 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.0.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CFE803F86F;
	Mon,  3 Aug 2026 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785791143; bh=gq9J1RvWC89pSiDbdZPLorYduWb+4Hbnf2Jhd3DjhiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q79hImrFDuwV9ADDuIoiwjGdoSYITlBcVg83GjTBIwbSj88kOzwnjDf1qkPh+4sxf
	 WMPfxFHC+dHHrL74KgxihIcUNzNBdn2qOveHJteQAse6u1t2O9+OY7y0DRQ11H0YsF
	 yEiKaa0MNfX5kpdn9N58HTdeYxNpHudRJKUlqfeM=
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
Subject: [PATCH 2/3] ACPI: CPPC: Avoid locking standalone full-width registers
Date: Mon,  3 Aug 2026 22:05:26 +0100
Message-Id: <20260803210527.1285229-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803210527.1285229-1-christian.loehle@arm.com>
References: <20260803210527.1285229-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpc_write() serializes every SystemMemory write with the per-CPU
rmw_lock. The lock is required for read-modify-write fields and for
registers whose access units overlap, but not for a full-width register
in a standalone access unit.

The _CPC layout is immutable after it has been parsed. Classify each
SystemMemory register at probe time and retain locking for partial
fields, invalid access widths, and overlapping access units. Allow
standalone full-width registers to bypass the descriptor lookup and
spinlock.

Store the classification in existing structure padding so that struct
cpc_register_resource does not grow.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 97 ++++++++++++++++++++++++++++++++++------
 include/acpi/cppc_acpi.h |  5 ++-
 2 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9b8d68b44ea9..2793d6b7d40d 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -200,6 +200,72 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 	((((val) & GENMASK(((reg)->bit_width) - 1, 0)) << (reg)->bit_offset) |		\
 	((prev_val) & ~(GENMASK(((reg)->bit_width) - 1, 0) << (reg)->bit_offset)))	\
 
+static u64 cpc_sysmem_access_size(const struct cpc_register_resource *reg)
+{
+	const struct cpc_reg *gas = &reg->cpc_entry.reg;
+	unsigned int width;
+
+	if (gas->access_width > 4)
+		return 0;
+
+	width = GET_BIT_WIDTH(gas);
+
+	if (width != 8 && width != 16 && width != 32 && width != 64)
+		return 0;
+
+	return width / 8;
+}
+
+static bool cpc_sysmem_access_units_overlap(const struct cpc_register_resource *a,
+					    const struct cpc_register_resource *b)
+{
+	const struct cpc_reg *a_gas = &a->cpc_entry.reg;
+	const struct cpc_reg *b_gas = &b->cpc_entry.reg;
+	u64 a_size = cpc_sysmem_access_size(a);
+	u64 b_size = cpc_sysmem_access_size(b);
+
+	/* Keep the conservative locking path for malformed access widths. */
+	if (!a_size || !b_size)
+		return true;
+
+	if (a_gas->address < b_gas->address)
+		return b_gas->address - a_gas->address < a_size;
+
+	return a_gas->address - b_gas->address < b_size;
+}
+
+static void cpc_mark_rmw_lock_users(struct cpc_desc *cpc_desc)
+{
+	int i, j;
+
+	for (i = 0; i < cpc_desc->num_entries - 2; i++) {
+		struct cpc_register_resource *a = &cpc_desc->cpc_regs[i];
+		struct cpc_reg *gas;
+		u64 access_size;
+
+		if (!CPC_SUPPORTED(a) || !CPC_IN_SYSTEM_MEMORY(a))
+			continue;
+
+		gas = &a->cpc_entry.reg;
+		access_size = cpc_sysmem_access_size(a);
+		if (gas->bit_offset || !access_size ||
+		    gas->bit_width != access_size * 8)
+			a->cpc_entry.use_rmw_lock = true;
+
+		for (j = i + 1; j < cpc_desc->num_entries - 2; j++) {
+			struct cpc_register_resource *b = &cpc_desc->cpc_regs[j];
+
+			if (!CPC_SUPPORTED(b) || !CPC_IN_SYSTEM_MEMORY(b))
+				continue;
+			if (!cpc_sysmem_access_units_overlap(a, b))
+				continue;
+
+			a->cpc_entry.use_rmw_lock = true;
+			b->cpc_entry.use_rmw_lock = true;
+		}
+	}
+}
+
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
@@ -904,6 +970,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
+	cpc_mark_rmw_lock_users(cpc_ptr);
 	raw_spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
@@ -1123,6 +1190,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 	struct cpc_desc *cpc_desc;
 	unsigned long flags;
+	bool locked = false;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1156,18 +1224,20 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 				val, size);
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-		if (!cpc_desc) {
-			pr_debug("No CPC descriptor for CPU:%d\n", cpu);
-			return -ENODEV;
-		}
-
 		/*
-		 * Only partial fields need the previous contents to preserve bits
-		 * outside the field. Keep serializing full-width writes because
-		 * another _CPC entry may share the access unit and require RMW.
+		 * The _CPC layout is immutable after probe. The precomputed flag
+		 * retains serialization for partial fields or overlapping access
+		 * units; standalone full-width registers avoid the lock.
 		 */
-		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
+		locked = reg_res->cpc_entry.use_rmw_lock;
+		if (locked) {
+			cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+			if (!cpc_desc) {
+				pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+				return -ENODEV;
+			}
+			raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
+		}
 
 		if (reg->bit_offset || reg->bit_width != size) {
 			switch (size) {
@@ -1184,8 +1254,9 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 				prev_val = readq_relaxed(vaddr);
 				break;
 			default:
-				raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock,
-							   flags);
+				if (locked)
+					raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock,
+								   flags);
 				return -EFAULT;
 			}
 			val = MASK_VAL_WRITE(reg, prev_val, val);
@@ -1217,7 +1288,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 		break;
 	}
 
-	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
+	if (locked)
 		raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 
 	return ret_val;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8c191b9ac18f..19830146c644 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -69,7 +69,10 @@ struct cpc_register_resource {
 	acpi_object_type type;
 	u64 __iomem *sys_mem_vaddr;
 	union {
-		struct cpc_reg reg;
+		struct {
+			struct cpc_reg reg;
+			bool use_rmw_lock;
+		};
 		u64 int_value;
 	} cpc_entry;
 };
-- 
2.34.1

