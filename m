Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD43B443F;
	Wed, 26 Aug 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725858; cv=none; b=k8t3YXqBAU20Oo1Pl97/Y7WqnxbXzd2OIRTZOtSS6nsCQYm8biRX96Ieg/Gg2efUGJ71CxqeEkG3NsDHUOO466hBPUUGJoNnfSBNPY1DTeY00ElhoPvXhS3j23RLgo92WbcFZ6C+1kyHzYUs4MbmLFgn2N18DKqxTxHhP61lzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725858; c=relaxed/simple;
	bh=XnvVkGaPH3glCJjFcZ2eEDxtkRfMAihbq5uoR2pcYAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kibJD4nseNET7ITywAwO6q7YJWUPZFQe/dMvWzm7HBBkMPAWmZCw3fqpRLrkNuvbJDJ2pKe6L5nGnbWfWZNQj30JZ5XAuox1wSS+6RyTRvchAWRWNQSE/TTZy8cdIfDpznymUkm9+EZVyFGlN6ZSA4GkvWHX9lMheUBnpplkUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=RGkIHqtu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="RGkIHqtu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 672ED16F2;
	Tue, 25 Aug 2026 23:30:46 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.6.192])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE5D63F7D8;
	Tue, 25 Aug 2026 23:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787725850; bh=XnvVkGaPH3glCJjFcZ2eEDxtkRfMAihbq5uoR2pcYAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGkIHqtuC8zNyTkSfoqPf5erxcsrUaE/Y10JgBzi9lDfmw06vxQ8BypClxd9cjL1v
	 I0BWDAsDBN8LhmM19ssXERs6wp7QL6N4xP54KZWbuwSbcOyVVi+tpEf5eBJJj6/+Zt
	 EmKbWyFvFZ6LFXNLFukMbGerJF4h1ogTEykDBHPg=
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
Subject: [PATCH v4 07/15] ACPI: CPPC: Release CPC descriptors through kobject
Date: Wed, 26 Aug 2026 07:30:11 +0100
Message-Id: <20260826063019.670240-8-christian.loehle@arm.com>
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

The CPC descriptor embeds the kobject used for its sysfs directory, but
it has no release callback and processor exit frees the descriptor
immediately after kobject_put(). It also unmaps register resources and
releases PCC state before sysfs removal has drained active attribute
callbacks.

Provide a release callback which unmaps and frees the descriptor, and use
the same cleanup helper before kobject initialization. Once initialized,
let kobject_put() own descriptor cleanup so its error path cannot free the
object twice.

On processor exit, first unpublish the per-CPU descriptor and remove its
sysfs directory, then release PCC state and drop the kobject reference.
This keeps all resources valid while sysfs callbacks are active and also
works with delayed kobject release.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724134251.1632824-1-christian.loehle%40arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 50 +++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 5a94317e9a03..50e3a3b4416c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -337,7 +337,27 @@ static struct attribute *cppc_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cppc);
 
+static void cppc_free_desc(struct cpc_desc *cpc_ptr)
+{
+	unsigned int i;
+
+	for (i = 2; i < cpc_ptr->num_entries; i++) {
+		void __iomem *addr = cpc_ptr->cpc_regs[i - 2].sys_mem_vaddr;
+
+		if (addr)
+			iounmap(addr);
+	}
+
+	kfree(cpc_ptr);
+}
+
+static void cppc_kobj_release(struct kobject *kobj)
+{
+	cppc_free_desc(to_cpc_desc(kobj));
+}
+
 static const struct kobj_type cppc_ktype = {
+	.release = cppc_kobj_release,
 	.sysfs_ops = &kobj_sysfs_ops,
 	.default_groups = cppc_groups,
 };
@@ -1120,7 +1140,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
 		kobject_put(&cpc_ptr->kobj);
-		goto out_free;
+		goto out_buf_free;
 	}
 
 	kfree(output.pointer);
@@ -1128,15 +1148,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 out_free:
 	pr_err("CPU%d: failed to initialize _CPC: %d\n", pr->id, ret);
-
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-
-		if (addr)
-			iounmap(addr);
-	}
-	kfree(cpc_ptr);
+	cppc_free_desc(cpc_ptr);
 
 out_buf_free:
 	kfree(output.pointer);
@@ -1153,10 +1165,14 @@ EXPORT_SYMBOL_GPL(acpi_cppc_processor_probe);
 void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	struct cpc_desc *cpc_ptr;
-	unsigned int i;
-	void __iomem *addr;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 
+	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
+	if (cpc_ptr) {
+		per_cpu(cpc_desc_ptr, pr->id) = NULL;
+		kobject_del(&cpc_ptr->kobj);
+	}
+
 	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
 		if (pcc_data[pcc_ss_id]->pcc_channel_acquired) {
 			pcc_data[pcc_ss_id]->refcount--;
@@ -1167,20 +1183,12 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 			}
 		}
 	}
+	per_cpu(cpu_pcc_subspace_idx, pr->id) = -1;
 
-	cpc_ptr = per_cpu(cpc_desc_ptr, pr->id);
 	if (!cpc_ptr)
 		return;
 
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-		if (addr)
-			iounmap(addr);
-	}
-
 	kobject_put(&cpc_ptr->kobj);
-	kfree(cpc_ptr);
 }
 EXPORT_SYMBOL_GPL(acpi_cppc_processor_exit);
 
-- 
2.34.1

