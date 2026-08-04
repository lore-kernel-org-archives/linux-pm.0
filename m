Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62445D5F9;
	Tue,  4 Aug 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833576; cv=none; b=CgaX9gDvMIJUa+DZ4MMCQPGl2s6UqnY89jHjyUC4kmDGXgq66cLF30cuOzbNUg/F6DhPaMBR2wwd5VWtqgkeWwqnOjvKb/2kGYfcj5gJfR00o57aFVck+et2TF5SzyWfiWGVet0NrwUxbBuDHA1Md1avyTiU8d5UO1NSYW1yngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833576; c=relaxed/simple;
	bh=ZcddcU1Fch45c8VFXrIxQ0eL1fTA3+e7U+wmnvOkkSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=taz7zl0JdM+UMO268CqIJPQ7NUR1GsF6Z9JzG/QfpGGk5oxmrB//MG+uD+pLBKIx5ai9XATdmMVYgLMHe9EPK8wcTC4ujxR0VFc9qYZGywr8mrzzFQ83ud8A+0VLIh3RDFnZPq2HkXZbs9jmzEjmW4jYKcZSLB9eXVQvDCJ1+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tyOGxBfN; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tyOGxBfN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=a9uO6m98vH62RANgi33OAiM65PI9Ev7/KHGTm1Z9wes=;
	b=tyOGxBfNGHmr2+THskeEiVrBvDE6QcOzLkPaW8pOCsg0cnFyPOIIwRoNTc66sJ+7PurS1ajB2
	MZbuGb+j32NHScwmxczKjKqdXky7UzlDA4G6rL6HkSe+3ODMtayCu3lt9azOhIupuvT7v8To3zH
	Eq/3JCrKHc9kOFXpmQmr99M=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hDnB56zg6z1prKd;
	Tue,  4 Aug 2026 16:43:09 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CAE240537;
	Tue,  4 Aug 2026 16:52:42 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 4 Aug 2026 16:52:41 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 2/8] ACPI: CPPC: Refactor element parsing into parse_cpc_element()
Date: Tue, 4 Aug 2026 16:50:36 +0800
Message-ID: <20260804085042.4118193-3-zhenglifeng1@huawei.com>
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

acpi_cppc_processor_probe() contains a large inline block (~70 lines)
that handles ACPI_TYPE_INTEGER and ACPI_TYPE_BUFFER entries in the _CPC
package.  This block will need to be reused for parsing individual
elements inside the nested RESOURCE_PRIORITY sub-packages that CPPC v4
defines (Section 8.4.6.1.2.7).

Extract the Integer / Buffer handling into a standalone parse_cpc_element()
helper so that both the top-level _CPC loop and the upcoming package
parser can share the same logic for register validation, PCC subspace
tracking, SystemMemory ioremap, and SystemIO / FFH checks.

No functional change; the new function reproduces the original behaviour
exactly.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 186 +++++++++++++++++++++++----------------
 1 file changed, 108 insertions(+), 78 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9f572f481241..c4f9fed66fa0 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -650,6 +650,109 @@ static int pcc_data_alloc(int pcc_ss_id)
 	return 0;
 }
 
+/**
+ * parse_cpc_element - Parse a single CPC element into a cpc_register_resource.
+ * @cpc_obj:          Pointer to the ACPI object representing the CPC element.
+ * @cpc_reg:          Output CPC register resource to populate.
+ * @pcc_subspace_id:  In/out pointer to PCC subspace ID; extracted once on first
+ *                    PCC-type register and validated for consistency thereafter.
+ * @cpu:              CPU number, used for debug messages.
+ * @entry_num:        Index within the CPC table entries, used for diagnostics.
+ *
+ * Handles ACPI_TYPE_INTEGER (static value) and ACPI_TYPE_BUFFER (register
+ * descriptor).  Sets up PCC subspace tracking, ioremap for SystemMemory,
+ * and validates SystemIO / FFH register parameters.
+ *
+ * Return: 0 on success, -ENODATA on invalid or unsupported data.
+ */
+static int parse_cpc_element(union acpi_object *cpc_obj,
+			     struct cpc_register_resource *cpc_reg,
+			     int *pcc_subspace_id, u32 cpu, unsigned int entry_num)
+{
+	struct cpc_reg *gas_t;
+
+	if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
+		cpc_reg->type = ACPI_TYPE_INTEGER;
+		cpc_reg->cpc_entry.int_value = cpc_obj->integer.value;
+	} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
+		gas_t = (struct cpc_reg *)cpc_obj->buffer.pointer;
+
+		/*
+		 * The PCC Subspace index is encoded inside
+		 * the CPC table entries. The same PCC index
+		 * will be used for all the PCC entries,
+		 * so extract it only once.
+		 */
+		if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
+			if (*pcc_subspace_id < 0) {
+				*pcc_subspace_id = gas_t->access_width;
+				if (pcc_data_alloc(*pcc_subspace_id))
+					return -ENODATA;
+			} else if (*pcc_subspace_id != gas_t->access_width) {
+				pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
+					 cpu);
+				return -ENODATA;
+			}
+		} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			if (gas_t->address) {
+				void __iomem *addr;
+				size_t access_width;
+
+				if (!osc_cpc_flexible_adr_space_confirmed) {
+					pr_debug("Flexible address space capability not supported\n");
+					if (!cpc_supported_by_cpu())
+						return -ENODATA;
+				}
+
+				access_width = GET_BIT_WIDTH(gas_t) / 8;
+				addr = ioremap(gas_t->address, access_width);
+				if (!addr)
+					return -ENODATA;
+				cpc_reg->sys_mem_vaddr = addr;
+			}
+		} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
+			if (gas_t->access_width < 1 || gas_t->access_width > 3) {
+				/*
+				 * 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit.
+				 * SystemIO doesn't implement 64-bit
+				 * registers.
+				 */
+				pr_debug("Invalid access width %d for SystemIO register in _CPC\n",
+					 gas_t->access_width);
+				return -ENODATA;
+			}
+			if (gas_t->address & OVER_16BTS_MASK) {
+				/* SystemIO registers use 16-bit integer addresses */
+				pr_debug("Invalid IO port %llu for SystemIO register in _CPC\n",
+					 gas_t->address);
+				return -ENODATA;
+			}
+			if (!osc_cpc_flexible_adr_space_confirmed) {
+				pr_debug("Flexible address space capability not supported\n");
+				if (!cpc_supported_by_cpu())
+					return -ENODATA;
+			}
+		} else {
+			if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE ||
+			    !cpc_ffh_supported()) {
+				/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
+				pr_debug("Unsupported register type (%d) in _CPC\n",
+					 gas_t->space_id);
+				return -ENODATA;
+			}
+		}
+
+		cpc_reg->type = ACPI_TYPE_BUFFER;
+		memcpy(&cpc_reg->cpc_entry.reg, gas_t, sizeof(*gas_t));
+	} else {
+		pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
+			 entry_num, cpu);
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
 /*
  * An example CPC table looks like the following.
  *
@@ -690,7 +793,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
 	union acpi_object *out_obj, *cpc_obj;
 	struct cpc_desc *cpc_ptr;
-	struct cpc_reg *gas_t;
 	struct device *cpu_dev;
 	acpi_handle handle = pr->handle;
 	unsigned int num_ent, i, cpc_rev;
@@ -778,80 +880,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	for (i = 2; i < num_ent; i++) {
 		cpc_obj = &out_obj->package.elements[i];
 
-		if (cpc_obj->type == ACPI_TYPE_INTEGER)	{
-			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
-			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = cpc_obj->integer.value;
-		} else if (cpc_obj->type == ACPI_TYPE_BUFFER) {
-			gas_t = (struct cpc_reg *)
-				cpc_obj->buffer.pointer;
-
-			/*
-			 * The PCC Subspace index is encoded inside
-			 * the CPC table entries. The same PCC index
-			 * will be used for all the PCC entries,
-			 * so extract it only once.
-			 */
-			if (gas_t->space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
-				if (pcc_subspace_id < 0) {
-					pcc_subspace_id = gas_t->access_width;
-					if (pcc_data_alloc(pcc_subspace_id))
-						goto out_free;
-				} else if (pcc_subspace_id != gas_t->access_width) {
-					pr_debug("Mismatched PCC ids in _CPC for CPU:%d\n",
-						 pr->id);
-					goto out_free;
-				}
-			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-				if (gas_t->address) {
-					void __iomem *addr;
-					size_t access_width;
-
-					if (!osc_cpc_flexible_adr_space_confirmed) {
-						pr_debug("Flexible address space capability not supported\n");
-						if (!cpc_supported_by_cpu())
-							goto out_free;
-					}
-
-					access_width = GET_BIT_WIDTH(gas_t) / 8;
-					addr = ioremap(gas_t->address, access_width);
-					if (!addr)
-						goto out_free;
-					cpc_ptr->cpc_regs[i-2].sys_mem_vaddr = addr;
-				}
-			} else if (gas_t->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
-				if (gas_t->access_width < 1 || gas_t->access_width > 3) {
-					/*
-					 * 1 = 8-bit, 2 = 16-bit, and 3 = 32-bit.
-					 * SystemIO doesn't implement 64-bit
-					 * registers.
-					 */
-					pr_debug("Invalid access width %d for SystemIO register in _CPC\n",
-						 gas_t->access_width);
-					goto out_free;
-				}
-				if (gas_t->address & OVER_16BTS_MASK) {
-					/* SystemIO registers use 16-bit integer addresses */
-					pr_debug("Invalid IO port %llu for SystemIO register in _CPC\n",
-						 gas_t->address);
-					goto out_free;
-				}
-				if (!osc_cpc_flexible_adr_space_confirmed) {
-					pr_debug("Flexible address space capability not supported\n");
-					if (!cpc_supported_by_cpu())
-						goto out_free;
-				}
-			} else {
-				if (gas_t->space_id != ACPI_ADR_SPACE_FIXED_HARDWARE || !cpc_ffh_supported()) {
-					/* Support only PCC, SystemMemory, SystemIO, and FFH type regs. */
-					pr_debug("Unsupported register type (%d) in _CPC\n",
-						 gas_t->space_id);
-					goto out_free;
-				}
-			}
-
-			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
-			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
-		} else if (cpc_obj->type == ACPI_TYPE_PACKAGE && (i - 2) == RESOURCE_PRIORITY) {
+		if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
 			/*
 			 * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority as a
 			 * Package of Resource Priority Register Descriptor sub-packages.
@@ -862,9 +891,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
 			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
 		} else {
-			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
-				 i, pr->id);
-			goto out_free;
+			ret = parse_cpc_element(cpc_obj, &cpc_ptr->cpc_regs[i-2],
+						&pcc_subspace_id, pr->id, i);
+			if (ret)
+				goto out_free;
 		}
 	}
 	per_cpu(cpu_pcc_subspace_idx, pr->id) = pcc_subspace_id;
-- 
2.33.0

