Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23546545DA0;
	Tue, 22 Sep 2026 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081038; cv=none; b=Is6G/ALmE+g/NGDWAC8sjRLoMnh75E1CiIAgx1du0SY6iX+dPRogQrnBNvvXVa574iDnb7ukxcwUiDwNJL4BAKZI+VbUlcjRfKuHd16CnhMuEgAM/orwbTUwiBhOTFwgfcFeCoJoX6e9rBYuxT7SoMNpObzvXLPXCbq3uoIM+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081038; c=relaxed/simple;
	bh=kDpK7Seh/MxWoKpik6r7NblQ5wfpHGUwrsILNj5QaYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nixFFgGZ0gV/ogwXlQUK+McJae3+uKMIu2tf0aWhHtfqhwq8FE1jAQEkKIxo2In2yhtW9B/nw+W1jgX2xx3vjwMzv6GcApHq4Qx63IJbqz3Mq0reMCpijGQQxvuozhsvV5tRGOJxSIXSHHZxbwbUFaxsbfS8I4Fnjyc4VBzHYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=D66CmRTe; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="D66CmRTe"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FCtyezrfFYHAsq12yeCIgaKi9Rbow+xBWuIlKanOkyk=;
	b=D66CmRTe0YZORKY7r8ATMMk2H/F/vX4IrE3iMes4ZC5WIuOJUw8idDe2tMPcYt9MQ1cx40+wf
	Kemo7oJQAFNmsyHd1FCNNxywrW5f1FZpCUX8l5j/zhWG4HONjLcobSD6wMr9dCpayYajAqrgO62
	TnJudJ+lMKD4BghxDsUpFls=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4hpzyL1RMTzLlSh;
	Tue, 22 Sep 2026 20:32:42 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id A6CC940580;
	Tue, 22 Sep 2026 20:43:44 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 20:43:43 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v4 3/8] ACPI: CPPC: Refactor resource cleanup into free_reg_resource()
Date: Tue, 22 Sep 2026 20:41:16 +0800
Message-ID: <20260922124121.3426219-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
References: <20260922124121.3426219-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
index 47ececf214c4..dce15d875c62 100644
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

