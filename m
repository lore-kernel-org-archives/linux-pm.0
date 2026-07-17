Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E722A80D;
	Fri, 17 Jul 2026 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256420; cv=none; b=Tfb1Fvo28+7+v5QVMepHoT6+4b2Wu4G9AQIcsN0/bHLDYDFYbO+3hos8teJLzuCjfWrm6a+jMX64eBHnVP8AmHA5McS/vu95A3Kqv9dF4oaQ5UreYa7ATpQ3BcAYaevlFYZKU9bbLq5gj8lEWN9IYQyUThZKe+/GzuF0l0oXvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256420; c=relaxed/simple;
	bh=uFzWyoEP0LY8WqMpLfSonKkCk/Yi7nl5d/qURvVgh6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDh/KE/LV87L3ms8524BviTBbq3f6E//GFr+dmgbtRSscUK3srf1zOtIr04GOUsSigwykYZRzcxszuA8xJwSxrfYuWyKoGBalL1ox33VighuyJ/CNHdEGPa77elVFyqAe//Wi33xZtmbkS72oqRwfX3ZaZfWi6vlm8haiu5haYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Sa7QzRkz; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Sa7QzRkz"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=58zYSO7RrOaHioCSn5ndyn/HuJQ2XrwleS0HIZkFe6w=;
	b=Sa7QzRkzOqN37i9aptDSGN1Q4gybA6UfL9+rrfQAcDWoTTs+Qb9smOwtPKi6BZI33Jgvcv2uY
	GKneNXwkSnSdBB0gTyV+FTwIVf/0MeI0sSL5wceD3NbGZeXRClgFAsBT1q71LwzJ/4OStLOFCJh
	NG1ONK7fbpv243KcB8L5d7U=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h1Yx23zzhzpStj;
	Fri, 17 Jul 2026 10:37:58 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F5142012A;
	Fri, 17 Jul 2026 10:46:54 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 10:46:53 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 3/8] ACPI: CPPC: Refactor resource cleanup into free_reg_resource()
Date: Fri, 17 Jul 2026 10:44:57 +0800
Message-ID: <20260717024502.3520445-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260717024502.3520445-1-zhenglifeng1@huawei.com>
References: <20260717024502.3520445-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
index ac4d4d002d40..bad959f46f90 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -759,6 +759,30 @@ static int parse_cpc_element(union acpi_object *cpc_obj,
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
@@ -972,12 +996,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
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
@@ -996,7 +1017,6 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
 {
 	struct cpc_desc *cpc_ptr;
 	unsigned int i;
-	void __iomem *addr;
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, pr->id);
 
 	if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
@@ -1014,12 +1034,9 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
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

