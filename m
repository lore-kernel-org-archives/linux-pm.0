Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81738E12D;
	Wed, 26 Aug 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725878; cv=none; b=m8dKJQv+Yz2e0TF0F9ztb3lfo03wbVnGtVmX6ZSr3aB2GrOPr9JWPGnhf1VfH0UuxdmMZk5+yioR5ziaRrblnISzraLA9128yrYzQNLA6gBKU7nWVDn6Q0XlnQhGyJhgSvZwzRb+7rw+Ud4S+diRKkDmXJHch9Z/Z+ZoyB/K3Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725878; c=relaxed/simple;
	bh=mCo6FTl8TUg7DidPzuG4UHJrvXGEMK4GSvWzpujvz/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4912zRqos24cAVyVi7RZWK8BecvfLhnYGIEHlnMZ9Nr4laAvla2DbQDC8cS6quC9UIz3XrxVJo3BwQPiG4iz12vpJiBMFtd0gNy5HatDWDs+nB0baLbi2s54uOKFUBZuvQU72ilmvZO10aB4/6zIYzqIwNZyMuDvT4FNSoZM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LPbmn44S; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LPbmn44S"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 466151BCA;
	Tue, 25 Aug 2026 23:31:08 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A6303F7D8;
	Tue, 25 Aug 2026 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725872; bh=mCo6FTl8TUg7DidPzuG4UHJrvXGEMK4GSvWzpujvz/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPbmn44SMcwfo140h5jgMe75XlcGPpq1iPAJVoxSsTLKt670+nV0mvd3pWQbqxJ++
	 TSu2YkdgLDNt9ELNoYgKVpdB5rBjAUA0afhx/rjXgWFt0bGlc1MXBe1rp4C22YlB7u
	 lD768tp5CF/DFxCE/V8R3CWZPO/QLAy5/5p0ikZs=
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
Subject: [PATCH v4 14/15] ACPI: CPPC: Validate SystemIO overlaps across processors
Date: Wed, 26 Aug 2026 07:30:18 +0100
Message-Id: <20260826063019.670240-15-christian.loehle@arm.com>
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
 drivers/acpi/cppc_acpi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 338fa34a2232..2d9c04a8c93c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -138,6 +138,7 @@ INTERVAL_TREE_DEFINE(struct cpc_non_mmio_node, rb, u64, subtree_last,
 		     cpc_non_mmio_itree)
 
 static struct rb_root_cached cpc_pcc_trees[MAX_PCC_SUBSPACES];
+static struct rb_root_cached cpc_sysio_tree = RB_ROOT_CACHED;
 static DEFINE_MUTEX(cpc_non_mmio_lock);
 
 static struct cpc_sysmem_node *cpc_sysmem_first(u64 start, u64 last)
@@ -579,6 +580,8 @@ static struct rb_root_cached *cpc_non_mmio_tree(u8 space_id, u8 pcc_ss_id)
 {
 	if (space_id == ACPI_ADR_SPACE_PLATFORM_COMM)
 		return &cpc_pcc_trees[pcc_ss_id];
+	if (space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		return &cpc_sysio_tree;
 	return NULL;
 }
 
@@ -596,7 +599,8 @@ static int cpc_validate_non_mmio_pair(const struct cpc_non_mmio_node *a,
 	    a->last == b->last)
 		return 0;
 
-	name = "PCC";
+	name = a->space_id == ACPI_ADR_SPACE_PLATFORM_COMM ?
+	       "PCC" : "SystemIO";
 	pr_err("CPU%d: %s _CPC register %u conflicts with CPU%d register %u\n",
 	       a->desc->cpu_id, name, a->reg_idx, b->desc->cpu_id,
 	       b->reg_idx);
@@ -651,10 +655,11 @@ static int cpc_register_non_mmio_desc(struct cpc_desc *cpc_desc,
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
@@ -666,7 +671,8 @@ static int cpc_register_non_mmio_desc(struct cpc_desc *cpc_desc,
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

