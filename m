Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A345DF5C;
	Tue,  4 Aug 2026 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833577; cv=none; b=HjL7Lce1q3qA33GUITq1G/TnlD0j3T5T3AMVPlnjW5srrq9xArWIRp++bofda5azyUqZp/rMurE9NyoJsgIrYeFiXQ/eXGaT4h9u8OUZ6Pqkfty9Wudb1/42QxzXIaMAg8Oq0fkuoNUGi0aJD/Sxx7x661D7T2urGDpf8cv3LJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833577; c=relaxed/simple;
	bh=lbfyjpQGikg2fwlU4B1wBMNg9ioxsQXwBSGp1X0dAaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBPENcR9j56zLCyayWFkS0hvr4QXQlAlmTaQRLeTvAXrBTbv5MgV2vCpBL6xORm11LXES+R1zpjecDQZpIUitxcg4JMASu7LtmbM6257tXOCjZKXqfBtdYft+2crwooKmU4ntwm/3iFXR7fukEMEFnhpv0s2zNKNKvwq4/3KxlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GbqsxbM8; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GbqsxbM8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qnmIKmDtED1A4RTC75yukztLHMsK8E6I1/QPQ2SMS0E=;
	b=GbqsxbM8b3I296YHsDAavRcC/UE3BLAJ2lZwoBykqlaB9MUuxtL2WddV/Gfg7n/1f1HYLaUXV
	niWpCvvp+wJzWf+AoiYkTb2UR3Zf/tSolUNqs/gSf6QUtxzehF+losN5MQSLFAJRljZdNvjTeo0
	exwJT6y5jHB1LO/SGHOYr9A=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hDnB13bqKz1T4Lb;
	Tue,  4 Aug 2026 16:43:05 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 7ABEC4057F;
	Tue,  4 Aug 2026 16:52:44 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 4 Aug 2026 16:52:43 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 5/8] ACPI: CPPC: Store optional flag in cpc_register_resource
Date: Tue, 4 Aug 2026 16:50:39 +0800
Message-ID: <20260804085042.4118193-6-zhenglifeng1@huawei.com>
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

The current optionality check uses a compile-time bitmask (REG_OPTIONAL)
applied at call sites via IS_OPTIONAL_CPC_REG(reg_idx).  This requires
every caller to know the register index, which will not work for registers
accessed without a fixed index (e.g. entries inside Resource Priority
sub-packages).

Add a boolean 'optional' field to cpc_register_resource so that each
register element carries its own optionality.  Populate the field during
_CPC probe (for main registers) and parse_priority_regs() (for Resource
Priority sub-packages), using the existing REG_OPTIONAL and
RES_PRIO_OPTIONAL bitmasks respectively.

Replace the IS_OPTIONAL_CPC_REG() check in cppc_get_reg_val() with a
direct test of reg->optional, and remove the IS_OPTIONAL_CPC_REG() macro.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 13 ++++++++-----
 include/acpi/cppc_acpi.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index fde51823e938..3b35c757a789 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -137,11 +137,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 #define REG_OPTIONAL (0x7FC7D0)
 
 /*
- * Use the index of the register in per-cpu cpc_regs[] to check if
- * it's an optional one.
+ * Each bit indicates the optionality of the register in resource
+ * priority register descriptor with the corresponding index. 0 means
+ * mandatory and 1 means optional.
  */
-#define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
-
+#define RES_PRIO_OPTIONAL (0x6)
 /*
  * Arbitrary Retries in case the remote processor is slow to respond
  * to PCC commands. Keeping it high enough to cover emulators where
@@ -844,6 +844,7 @@ static int parse_priority_regs(union acpi_object *cpc_obj,
 
 		reg_elements[0].type = ACPI_TYPE_PACKAGE;
 		reg_elements[0].cpc_entry.package.count = resources_count;
+		reg_elements[0].optional = RES_PRIO_OPTIONAL & 1U;
 
 		for (j = 0; j < reg_elements[0].cpc_entry.package.count; j++) {
 			reg_elements[0].cpc_entry.package.elements[j].type = ACPI_TYPE_INTEGER;
@@ -852,6 +853,7 @@ static int parse_priority_regs(union acpi_object *cpc_obj,
 		}
 
 		for (j = 1; j < RESOURCE_PRIORITY_NUM; j++) {
+			reg_elements[j].optional = RES_PRIO_OPTIONAL & (1U << j);
 			ret = parse_cpc_element(&reg_desc_obj.package.elements[j], &reg_elements[j],
 						pcc_subspace_id, cpu, RESOURCE_PRIORITY);
 			if (ret)
@@ -990,6 +992,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	/* Iterate through remaining entries in _CPC */
 	for (i = 2; i < num_ent; i++) {
 		cpc_obj = &out_obj->package.elements[i];
+		cpc_ptr->cpc_regs[i-2].optional = REG_OPTIONAL & (1U << (i-2));
 
 		/*
 		 * Package-type entries are used for nested structures such as
@@ -1409,7 +1412,7 @@ static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
 
 	reg = &cpc_desc->cpc_regs[reg_idx];
 
-	if ((reg->type == ACPI_TYPE_INTEGER && IS_OPTIONAL_CPC_REG(reg_idx) &&
+	if ((reg->type == ACPI_TYPE_INTEGER && reg->optional &&
 	     !reg->cpc_entry.int_value) || (reg->type != ACPI_TYPE_INTEGER &&
 	     IS_NULL_REG(&reg->cpc_entry.reg))) {
 		pr_debug("CPC register is not supported\n");
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 19f8a722654b..c0b8d52016cd 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -80,6 +80,7 @@ struct cpc_register_resource {
 			struct cpc_register_resource *elements;
 		} package;
 	} cpc_entry;
+	bool optional;
 };
 
 /* Container to hold the CPC details for each CPU */
-- 
2.33.0

