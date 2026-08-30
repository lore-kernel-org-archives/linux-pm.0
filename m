Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8B3B38BE;
	Sun, 30 Aug 2026 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788091090; cv=none; b=QFt0qrJxbfWh7JRZP5oeQXyPZaDb5NPPfup0SXFaJ8w4PGxR4CDEhyQ2EaDmVrtsr03U6qqAQOo9deubixwI20SQRd7kJ+YtfqSUEX2IJevURZ8STuhMVv+Xo07Wr/suwUo8+EWdFfZBZoKxv9Q0W5XorJyu67f7a+KyHI72zjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788091090; c=relaxed/simple;
	bh=VBtMR7xIqLL0SHRmdyl5scW8ygK5+fLjY+mi/LdPXfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiJBsPmEhXNs+eDLwtjvwbkVXoRNj6KoNuKRwN8SzLi7EVj+Do67YnVNT13b19UwSz/69MDEqvaUQb9WyvTeplB8jF3POY3+v+BmfG56FhlFasuhbWmlQ8D4aV6YJ9OBdnuNC/U9nnlUE7S3zOrLcTlKVb1SfQD888t2JymBx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L60VKMiQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L60VKMiQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8229314BF;
	Sun, 30 Aug 2026 04:58:01 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.5.212])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E00E3F66F;
	Sun, 30 Aug 2026 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788091085; bh=VBtMR7xIqLL0SHRmdyl5scW8ygK5+fLjY+mi/LdPXfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L60VKMiQYI9me/DgeEnIqvM7D/sGLy8fDraN6t224XeSiDHNsJz436fMoDoG4+iYZ
	 vpch/pSKGDhkenK67nsXVfvh3sueTbMYwdd9xLVP+D3HjHstWEvt+UKksm/YPZYkA9
	 O312rS0akT3uEJK69qOHf8xuzssN7/LAWG2Ec9nc=
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
Subject: [PATCH v6 14/15] ACPI: CPPC: Validate SystemIO overlaps across processors
Date: Sun, 30 Aug 2026 12:56:43 +0100
Message-Id: <20260830115644.2056983-15-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260830115644.2056983-1-christian.loehle@arm.com>
References: <20260830115644.2056983-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System I/O port space is global, but the overlap check only compares
registers within one _CPC package.  Whole-width accesses from different
processors can therefore target partially overlapping port ranges and
clobber each other.

Extend the physical interval registry to SystemIO.  Permit read-only
overlap and exact full-width aliases of the same logical CPPC entry.
Reject every other cross-processor overlap involving a writable entry.

Fixes: a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index cc749a487373..25bccd4cfb34 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -143,6 +143,7 @@ INTERVAL_TREE_DEFINE(struct cpc_non_mmio_node, rb, u64, subtree_last,
 		     cpc_non_mmio_itree)
 
 static struct rb_root_cached cpc_pcc_trees[MAX_PCC_SUBSPACES];
+static struct rb_root_cached cpc_sysio_tree = RB_ROOT_CACHED;
 static DEFINE_MUTEX(cpc_non_mmio_lock);
 
 static struct cpc_sysmem_node *cpc_sysmem_first(u64 start, u64 last)
@@ -649,6 +650,8 @@ static struct rb_root_cached *cpc_non_mmio_tree(u8 space_id, u8 pcc_ss_id)
 {
 	if (space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
 		return &cpc_pcc_trees[pcc_ss_id];
+	if (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		return &cpc_sysio_tree;
 	return NULL;
 }
 
@@ -666,7 +669,8 @@ static int cpc_validate_non_mmio_pair(const struct cpc_non_mmio_node *a,
 	    a->last == b->last)
 		return 0;
 
-	name = "PCC";
+	name = a->space_id == ACPI_ADR_SPACE_PLATFORM_COMM ?
+	       "PCC" : "SystemIO";
 	pr_err("CPU%d: %s _CPC register %u conflicts with CPU%d register %u\n",
 	       a->desc->cpu_id, name, a->reg_idx, b->desc->cpu_id,
 	       b->reg_idx);
@@ -710,7 +714,8 @@ static int cpc_register_non_mmio_desc(struct cpc_desc *cpc_desc,
 		if (!CPC_SUPPORTED(reg) || reg->type != ACPI_TYPE_BUFFER)
 			continue;
 		space_id = reg->cpc_entry.reg.space_id;
-		if (space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+		if (space_id == ACPI_ADR_SPACE_PLATFORM_COMM ||
+		    space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
 			found = true;
 			break;
 		}
@@ -737,10 +742,11 @@ static int cpc_register_non_mmio_desc(struct cpc_desc *cpc_desc,
 			continue;
 
 		space_id = reg->cpc_entry.reg.space_id;
-		if (space_id != ACPI_ADR_SPACE_PLATFORM_COMM)
+		if (space_id != ACPI_ADR_SPACE_PLATFORM_COMM &&
+		    space_id != ACPI_ADR_SPACE_SYSTEM_IO)
 			continue;
 
-		if (pcc_ss_id < 0) {
+		if (space_id == ACPI_ADR_SPACE_PLATFORM_COMM && pcc_ss_id < 0) {
 			ret = -EINVAL;
 			goto out_unregister;
 		}
@@ -752,7 +758,8 @@ static int cpc_register_non_mmio_desc(struct cpc_desc *cpc_desc,
 		node->desc = cpc_desc;
 		node->reg_idx = i;
 		node->space_id = space_id;
-		node->pcc_ss_id = pcc_ss_id;
+		node->pcc_ss_id = space_id == ACPI_ADR_SPACE_PLATFORM_COMM ?
+				      pcc_ss_id : 0;
 		tree = cpc_non_mmio_tree(space_id, node->pcc_ss_id);
 
 		match = cpc_non_mmio_itree_iter_first(tree, node->start,
-- 
2.34.1

