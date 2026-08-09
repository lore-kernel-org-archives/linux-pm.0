Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE70392825;
	Sun,  9 Aug 2026 06:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786256806; cv=none; b=I3Jo5F8h0mE9bhL4yRyq1w9asQiAPMI8i5N+6yB0wCjviSdzXz5r5WolTEff2+7QoiiuQMWlKZZuxm3G6wWwmA91WBkRHcX9tUvaAmBZr3aiZ/+2dwecwiLz+qjW+awjqzgfD7pbAH6R2uJp+oa+1aCGxxuKf4QaFvKJpXXYr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786256806; c=relaxed/simple;
	bh=kZkYoH7pODWk5yGySjOTBvti8dGCeCwPcdc3Ct1UEPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CRKobsM4KncjE2yYacJqW34yRNM7nOvPW1GeSUBaG+zDm4S2xMCZdB9B5ML624OtfQVkCw66LzuNItk7anJcHoCTDWVKDBVFGhl+jdNvXNbmKriPdpgCYEa7rwt6IRBnjeC0cS2anr7E/N6WfLNGHuLykpbWQTo8PeeqICmnH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UpK1dRTb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UpK1dRTb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76B65152B;
	Sat,  8 Aug 2026 23:26:40 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.4.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F1113F9A2;
	Sat,  8 Aug 2026 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786256804; bh=kZkYoH7pODWk5yGySjOTBvti8dGCeCwPcdc3Ct1UEPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpK1dRTbtdLEDiquhmWfaSxKPodjqdTY4XpPHrCk88c71iYTLpfzUhC+QM7ao8RAT
	 99Tl/eMTSBKgracb5kdSuIbxJUlwZBHP7SconJNK6H2xz1aqKAFeJUbRVYzAbfXJbY
	 aUj6/1BTHQgJvoRyuPSn1VhNUbZtqwfljcq3Cahs=
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
Subject: [PATCH v3 13/15] ACPI: CPPC: Validate PCC overlaps across processors
Date: Sun,  9 Aug 2026 07:25:47 +0100
Message-Id: <20260809062549.1415955-14-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260809062549.1415955-1-christian.loehle@arm.com>
References: <20260809062549.1415955-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCC shared-memory offsets are physical within a subspace, but the existing
overlap check stops at one _CPC package. Two processors can therefore pass
probe with writable ranges which overlap in the same PCC subspace.

This is unsafe in the performance path, where CPUs may stage requests
concurrently while holding the shared side of pcc_lock. Partially
overlapping stores can construct a payload which belongs to neither request
before a doorbell submits it.

Index retained PCC byte ranges by subspace and physical interval. Permit
read-only overlap and exact aliases of the same logical CPPC entry. The
per-subspace payload lock serializes exact writable aliases, including
multi-byte fields copied with byte-oriented I/O. Reject every other overlap
involving a writable entry.

The interval tree keeps registration proportional to real overlaps rather
than to the number of processors. Remove entries when processor teardown
unpublishes its CPC descriptor, including every probe-failure path after
registration.

Fixes: 85b1407bf6d2 ("ACPI / CPPC: Make CPPC ACPI driver aware of PCC subspace IDs")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 157 +++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |   2 +
 2 files changed, 159 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9c3d278243ca..a7141f4d9d0f 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -108,6 +108,18 @@ struct cpc_sysmem_node {
 	bool registered;
 };
 
+struct cpc_non_mmio_node {
+	struct rb_node rb;
+	u64 subtree_last;
+	u64 start;
+	u64 last;
+	struct cpc_desc *desc;
+	unsigned int reg_idx;
+	u8 space_id;
+	u8 pcc_ss_id;
+	bool registered;
+};
+
 #define CPC_SYSMEM_START(node) ((node)->start)
 #define CPC_SYSMEM_LAST(node) ((node)->last)
 
@@ -118,6 +130,16 @@ INTERVAL_TREE_DEFINE(struct cpc_sysmem_node, rb, u64, subtree_last,
 static struct rb_root_cached cpc_sysmem_tree = RB_ROOT_CACHED;
 static DEFINE_MUTEX(cpc_sysmem_lock);
 
+#define CPC_NON_MMIO_START(node) ((node)->start)
+#define CPC_NON_MMIO_LAST(node) ((node)->last)
+
+INTERVAL_TREE_DEFINE(struct cpc_non_mmio_node, rb, u64, subtree_last,
+		     CPC_NON_MMIO_START, CPC_NON_MMIO_LAST, static inline,
+		     cpc_non_mmio_itree)
+
+static struct rb_root_cached cpc_pcc_trees[MAX_PCC_SUBSPACES];
+static DEFINE_MUTEX(cpc_non_mmio_lock);
+
 static struct cpc_sysmem_node *cpc_sysmem_first(u64 start, u64 last)
 {
 	return cpc_sysmem_itree_iter_first(&cpc_sysmem_tree, start, last);
@@ -564,6 +586,134 @@ static int cpc_validate_non_mmio_overlaps(struct cpc_desc *cpc_desc,
 	return 0;
 }
 
+static struct rb_root_cached *cpc_non_mmio_tree(u8 space_id, u8 pcc_ss_id)
+{
+	if (space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
+		return &cpc_pcc_trees[pcc_ss_id];
+	return NULL;
+}
+
+static int cpc_validate_non_mmio_pair(const struct cpc_non_mmio_node *a,
+				      const struct cpc_non_mmio_node *b)
+{
+	bool a_writable = cpc_reg_is_writable(a->reg_idx);
+	bool b_writable = cpc_reg_is_writable(b->reg_idx);
+	const char *name;
+
+	if (!a_writable && !b_writable)
+		return 0;
+
+	if (a->reg_idx == b->reg_idx && a->start == b->start &&
+	    a->last == b->last)
+		return 0;
+
+	name = "PCC";
+	pr_err("CPU%d: %s _CPC register %u conflicts with CPU%d register %u\n",
+	       a->desc->cpu_id, name, a->reg_idx, b->desc->cpu_id,
+	       b->reg_idx);
+	return -EINVAL;
+}
+
+static void cpc_unregister_non_mmio_desc_locked(struct cpc_desc *cpc_desc)
+{
+	unsigned int i;
+
+	if (!cpc_desc->non_mmio_nodes)
+		return;
+
+	for (i = 0; i < cpc_desc->num_entries - 2; i++) {
+		struct cpc_non_mmio_node *node = &cpc_desc->non_mmio_nodes[i];
+		struct rb_root_cached *tree;
+
+		if (!node->registered)
+			continue;
+
+		tree = cpc_non_mmio_tree(node->space_id, node->pcc_ss_id);
+		cpc_non_mmio_itree_remove(node, tree);
+	}
+
+	kfree(cpc_desc->non_mmio_nodes);
+	cpc_desc->non_mmio_nodes = NULL;
+}
+
+static int cpc_register_non_mmio_desc(struct cpc_desc *cpc_desc,
+				      int pcc_ss_id)
+{
+	unsigned int nr_regs = cpc_desc->num_entries - 2;
+	unsigned int i;
+	int ret = 0;
+
+	cpc_desc->non_mmio_nodes = kcalloc(nr_regs,
+					   sizeof(*cpc_desc->non_mmio_nodes),
+					   GFP_KERNEL);
+	if (!cpc_desc->non_mmio_nodes)
+		return -ENOMEM;
+
+	mutex_lock(&cpc_non_mmio_lock);
+
+	for (i = 0; i < nr_regs; i++) {
+		struct cpc_register_resource *reg = &cpc_desc->cpc_regs[i];
+		struct cpc_non_mmio_node *match, *node;
+		struct rb_root_cached *tree;
+		u8 space_id;
+		u64 size;
+
+		if (!CPC_SUPPORTED(reg) || reg->type != ACPI_TYPE_BUFFER)
+			continue;
+
+		space_id = reg->cpc_entry.reg.space_id;
+		if (space_id != ACPI_ADR_SPACE_PLATFORM_COMM)
+			continue;
+
+		if (pcc_ss_id < 0) {
+			ret = -EINVAL;
+			goto out_unregister;
+		}
+
+		node = &cpc_desc->non_mmio_nodes[i];
+		size = cpc_non_mmio_access_size(reg);
+		node->start = reg->cpc_entry.reg.address;
+		node->last = node->start + size - 1;
+		node->desc = cpc_desc;
+		node->reg_idx = i;
+		node->space_id = space_id;
+		node->pcc_ss_id = pcc_ss_id;
+		tree = cpc_non_mmio_tree(space_id, node->pcc_ss_id);
+
+		match = cpc_non_mmio_itree_iter_first(tree, node->start,
+						      node->last);
+		while (match) {
+			ret = cpc_validate_non_mmio_pair(node, match);
+			if (ret)
+				goto out_unregister;
+
+			match = cpc_non_mmio_itree_iter_next(match, node->start,
+							     node->last);
+		}
+
+		cpc_non_mmio_itree_insert(node, tree);
+		node->registered = true;
+	}
+
+	mutex_unlock(&cpc_non_mmio_lock);
+	return 0;
+
+out_unregister:
+	cpc_unregister_non_mmio_desc_locked(cpc_desc);
+	mutex_unlock(&cpc_non_mmio_lock);
+	return ret;
+}
+
+static void cpc_unregister_non_mmio_desc(struct cpc_desc *cpc_desc)
+{
+	if (!cpc_desc->non_mmio_nodes)
+		return;
+
+	mutex_lock(&cpc_non_mmio_lock);
+	cpc_unregister_non_mmio_desc_locked(cpc_desc);
+	mutex_unlock(&cpc_non_mmio_lock);
+}
+
 static void cpc_mark_rmw_lock_users(struct cpc_desc *cpc_desc)
 {
 	int i;
@@ -797,6 +947,7 @@ static void cppc_free_desc(struct cpc_desc *cpc_ptr)
 {
 	unsigned int i;
 
+	cpc_unregister_non_mmio_desc(cpc_ptr);
 	cpc_unregister_sysmem_desc(cpc_ptr);
 
 	for (i = 2; i < cpc_ptr->num_entries; i++) {
@@ -1641,6 +1792,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	if (ret)
 		goto out_free;
 
+	ret = cpc_register_non_mmio_desc(cpc_ptr, pcc_subspace_id);
+	if (ret)
+		goto out_free;
+
 	/* Everything looks okay */
 	pr_debug("Parsed CPC struct for CPU: %d\n", pr->id);
 
@@ -1658,6 +1813,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			"acpi_cppc");
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
+		cpc_unregister_non_mmio_desc(cpc_ptr);
 		cpc_unregister_sysmem_desc(cpc_ptr);
 		kobject_put(&cpc_ptr->kobj);
 		goto out_pcc_put;
@@ -1701,6 +1857,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 	per_cpu(cpc_desc_ptr, pr->id) = NULL;
 	kobject_del(&cpc_ptr->kobj);
+	cpc_unregister_non_mmio_desc(cpc_ptr);
 	cpc_unregister_sysmem_desc(cpc_ptr);
 
 	pcc_data_put(pcc_ss_id);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index c4f47c312054..dbcd25878ab6 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -78,6 +78,7 @@ struct cpc_register_resource {
 };
 
 struct cpc_sysmem_node;
+struct cpc_non_mmio_node;
 
 /* Container to hold the CPC details for each CPU */
 struct cpc_desc {
@@ -91,6 +92,7 @@ struct cpc_desc {
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct cpc_sysmem_node *sysmem_nodes;
+	struct cpc_non_mmio_node *non_mmio_nodes;
 	struct kobject kobj;
 };
 
-- 
2.34.1

