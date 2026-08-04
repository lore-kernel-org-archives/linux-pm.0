Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5845D1B9;
	Tue,  4 Aug 2026 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833575; cv=none; b=iYR8JFgANFzhTH7sBMfedcVjNlQPj4jGTLJaN/ySbD96SL63ZyCAKwUoO9NzpYX0gABLcd/pMPq5Rx6iKOL1OSqeMbFPpPA6ftC7DER8lsLUA5QWh2mECrEfcvOLauzz8IWS/fEDQhMWbVJOkdoEe4lo35QB6ysfbecMNbIjXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833575; c=relaxed/simple;
	bh=fCvi3PY3G9Pl7oJtr8AMDFn8t31S61YAPDMYYAacnNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZzfPsAKs+TZU5XQRNcvqsz92jYT0dmL6JIb9E/WQgIZEY1uvEhirLwiXo+XshbN9/VU7cLl8kaSEP7dNnp3oQAWf7iAYIvB3dSgmhVz/rCQ/82SLfh+xm6KDqEDXwFu6RqNbiSazkix/CEUaDmubZVn8ESDh6338qx72ccBSL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=J+1gedoz; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="J+1gedoz"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GwWtHiSLFC5apSRQw/9w6bb01yBTkaA7vglgEwclPrg=;
	b=J+1gedozy+bFl61yy78Xqy1wOPaeNwEcthRtfgb8YPSPIw2F/+rNy1aXAeZirIPen6yJan+7l
	yj+TCQ3Ne5urOsFXFMq8HlvwUhizIkuiKL5ASCmXvZF+qEUG5R4rKJ19K6hgZ/QPidT9eFzlVMq
	GAEqm7H4UOzNjFvbs62V7XQ=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hDnBD5xd5z12LDV;
	Tue,  4 Aug 2026 16:43:16 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FBB3202E6;
	Tue,  4 Aug 2026 16:52:43 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 4 Aug 2026 16:52:42 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 3/8] ACPI: CPPC: Refactor resource cleanup into free_reg_resource()
Date: Tue, 4 Aug 2026 16:50:37 +0800
Message-ID: <20260804085042.4118193-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260804085042.4118193-1-zhenglifeng1@huawei.com>
References: <20260804085042.4118193-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100001.china.huawei.com (7.202.181.215)

Both the error path of acpi_cppc_processor_probe() and the normal
cleanup in acpi_cppc_processor_exit() iterate over the cpc_regs[]
array and iounmap() any SystemMemory virtual addresses that were
set up during probe.

CPPC v4 adds Package-type entries that own dynamically allocated
sub-elements which also need to be freed.  Inlining this recursive
cleanup at every call-site would be error-prone and repetitive.

Extract the per-register cleanup logic into free_reg_resource(),
which releases any iomapped address and, for Package-type entries,
recursively frees all child elements and the elements array itself.
Convert both the probe error path and _exit() to use the new helper.

No functional change for existing Integer / Buffer entries.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 41 ++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index c4f9fed66fa0..da8399efc6a6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -753,6 +753,30 @@ static int parse_cpc_element(union acpi_object *cpc_obj,
 	return 0;
 }
 
+/**
+ * free_reg_resource - Free resources held by a CPC register resource.
+ * @cpc_reg: Pointer to the CPC register resource to clean up.
+ *
+ * Releases any iomapped SystemMemory address and, for Package-type
+ * resources, recursively frees all nested elements before freeing the
+ * elements array itself.
+ */
+static void free_reg_resource(struct cpc_register_resource *cpc_reg)
+{
+	void __iomem *addr = cpc_reg->sys_mem_vaddr;
+	int i;
+
+	if (addr)
+		iounmap(addr);
+
+	if (cpc_reg->type == ACPI_TYPE_PACKAGE) {
+		for (i = 0; i < cpc_reg->cpc_entry.package.count; i++)
+			free_reg_resource(&cpc_reg->cpc_entry.package.elements[i]);
+
+		kfree(cpc_reg->cpc_entry.package.elements);
+	}
+}
+
 /*
  * An example CPC table looks like the following.
  *
@@ -965,12 +989,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 out_free:
 	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		void __iomem *addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
+	for (i = 2; i < cpc_ptr->num_entries; i++)
+		free_reg_resource(&cpc_ptr->cpc_regs[i-2]);
 
-		if (addr)
-			iounmap(addr);
-	}
 	kfree(cpc_ptr);
 
 out_buf_free:
@@ -989,7 +1010,6 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	struct cpc_desc *cpc_ptr;
 	unsigned int i;
-	void __iomem *addr;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 
 	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
@@ -1007,12 +1027,9 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 	if (!cpc_ptr)
 		return;
 
-	/* Free all the mapped sys mem areas for this CPU */
-	for (i = 2; i < cpc_ptr->num_entries; i++) {
-		addr = cpc_ptr->cpc_regs[i-2].sys_mem_vaddr;
-		if (addr)
-			iounmap(addr);
-	}
+	/* Free all the mapped sys mem areas and nested package resources for this CPU */
+	for (i = 2; i < cpc_ptr->num_entries; i++)
+		free_reg_resource(&cpc_ptr->cpc_regs[i-2]);
 
 	kobject_put(&cpc_ptr->kobj);
 	kfree(cpc_ptr);
-- 
2.33.0

