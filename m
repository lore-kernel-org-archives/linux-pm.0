Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4844477F7;
	Tue,  4 Aug 2026 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833568; cv=none; b=trndi8ULz4mzcJdPxZqxhL1biljr6InP/dLWlQ/IovjsD4lbptlW/LZZyF/e6ihYQO/iA9lZ1XFFM2hB8wpuUdA4bEhDhxzZ7B9kkkYo921lsxjj0veGSetHT7RyI8//mdxgDwC6wWNnI+rkvPb3cIdblZko5WuFo58QfZdv3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833568; c=relaxed/simple;
	bh=v9eqNpUCx6NTF1oHzMEWrtU48JOjtDnMHnv4y2Ul9jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emNOS+ndIjX1IjXuUexjA6VXq8C65o53tmcu8sL3wVuEaiCW36IOakGWL9I+/FGcxbsQrQrBIeruEyZY0UN6fnvpWe49fUEoaSVzkv+R8gWSuKahrhScJ0Jak0FDZIEyDWV7LCXh6bIoHrejF1xsLaGVUpu1tZ3q3zmu57D+dsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ygB4tqGd; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ygB4tqGd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ubp0CYfg6H9oYSUH2H4vmsj8WpkpSWexvrFKW+7mSg0=;
	b=ygB4tqGd7cx8iEL2uOEKwNFLdTGWTUfbPhb83TYll4+oOdGRIAG09VlBVWN8w+HdNDIdeC5yU
	4iTTsfD4SDObi/F3XHyMjFcCLw/WXjdmciooRGltE2r9yi27iRiKgglYie3FOdwFqQrFG2mxhPK
	XCDKvGtCZRFlyvar1RlMk48=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hDn945gJjznTVy;
	Tue,  4 Aug 2026 16:42:16 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id D804E4056C;
	Tue,  4 Aug 2026 16:52:43 +0800 (CST)
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
Subject: [PATCH v2 4/8] ACPI: CPPC: Parse Resource Priority Register entries from _CPC package
Date: Tue, 4 Aug 2026 16:50:38 +0800
Message-ID: <20260804085042.4118193-5-zhenglifeng1@huawei.com>
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

CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) defines the Resource Priority
entry as a Package of sub-packages, each containing:

  - CONTROLLED_RESOURCES: a Package of integer resource IDs
  - ENABLE_VALUE / ENABLE_REGISTER: enable/disable control
  - PRIORITY_COUNT / PRIORITY_REGISTER: priority level setting

These allow OSPM to set relative priority among processors for shared
resources such as boost, throttle, L2/L3 cache, and memory bandwidth.

Implement parse_priority_regs() which:

  1. Validates each sub-package has the expected element count
     (RESOURCE_PRIORITY_NUM).
  2. Allocates cpc_register_resource arrays for the sub-package
     elements and the nested CONTROLLED_RESOURCES list.
  3. Parses CONTROLLED_RESOURCES as integers and the remaining
     entries (ENABLE_REGISTER, PRIORITY_REGISTER, etc.) via
     parse_cpc_element() so that register descriptors, PCC subspace
     tracking, and ioremap are handled consistently.
  4. Wires the parser into the main _CPC probe loop, replacing the
     previous "package type not supported" stub with full parsing for
     RESOURCE_PRIORITY while rejecting unexpected Package entries.

The probe and _exit() error/cleanup paths already use
free_reg_resource(), which recursively frees Package-type entries,
so no additional cleanup changes are needed.

Add the resource_priority_regs enumeration that defines the indices
into each Resource Priority sub-package (CONTROLLED_RESOURCES,
ENABLE_VALUE, ENABLE_REGISTER, PRIORITY_COUNT, PRIORITY_REGISTER)
and RESOURCE_PRIORITY_NUM as the element count sentinel.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 134 +++++++++++++++++++++++++++++++++++++--
 include/acpi/cppc_acpi.h |  13 ++++
 2 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index da8399efc6a6..fde51823e938 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -777,6 +777,91 @@ static void free_reg_resource(struct cpc_register_resource *cpc_reg)
 	}
 }
 
+/**
+ * parse_priority_regs - Parse the RESOURCE_PRIORITY nested package structure.
+ * @cpc_obj:         ACPI Package object for the RESOURCE_PRIORITY entry.
+ * @regs:            Output array of cpc_register_resource to fill.
+ * @pcc_subspace_id: In/out pointer to PCC subspace ID.
+ * @cpu:             CPU number, used for debug messages.
+ *
+ * The RESOURCE_PRIORITY entry (CPPC v4) is a Package of sub-packages.
+ * Each sub-package has RESOURCE_PRIORITY_NUM elements:
+ *   [0] = Package of integers (CONTROLLED_RESOURCES list)
+ *   [1] = ENABLE_VALUE, [2] = ENABLE_REGISTER,
+ *   [3] = PRIORITY_COUNT, [4] = PRIORITY_REGISTER
+ *
+ * Return: 0 on success, -ENODATA on malformed data, -ENOMEM on allocation failure.
+ */
+static int parse_priority_regs(union acpi_object *cpc_obj,
+			       struct cpc_register_resource *regs,
+			       int *pcc_subspace_id, u32 cpu)
+{
+	struct cpc_register_resource *reg_elements;
+	union acpi_object reg_desc_obj;
+	unsigned int i, j, resources_count;
+	int ret;
+
+	for (i = 0; i < cpc_obj->package.count; i++) {
+		reg_desc_obj = cpc_obj->package.elements[i];
+		if (reg_desc_obj.type != ACPI_TYPE_PACKAGE ||
+		    reg_desc_obj.package.count != RESOURCE_PRIORITY_NUM) {
+			pr_debug("Malformed priority regs sub-pkg: type %d count %d, expected %d for CPU:%d\n",
+				 reg_desc_obj.type, reg_desc_obj.package.count,
+				 RESOURCE_PRIORITY_NUM, cpu);
+			return -ENODATA;
+		}
+
+		reg_elements = kzalloc_objs(struct cpc_register_resource, RESOURCE_PRIORITY_NUM);
+		if (!reg_elements) {
+			pr_debug("Failed to allocate reg_elements for CPU:%d\n", cpu);
+			return -ENOMEM;
+		}
+
+		/*
+		 * Assign values immediately after successful allocation to ensure that resources
+		 * can be properly released.
+		 */
+		regs[i].type = ACPI_TYPE_PACKAGE;
+		regs[i].cpc_entry.package.count = RESOURCE_PRIORITY_NUM;
+		regs[i].cpc_entry.package.elements = reg_elements;
+
+		resources_count = reg_desc_obj.package.elements[0].package.count;
+
+		if (reg_desc_obj.package.elements[0].type != ACPI_TYPE_PACKAGE ||
+		    !resources_count) {
+			pr_debug("Invalid priority sub-elements: type %d count %d for CPU:%d\n",
+				 reg_desc_obj.package.elements[0].type, resources_count, cpu);
+			return -ENODATA;
+		}
+
+		reg_elements[0].cpc_entry.package.elements =
+			kzalloc_objs(struct cpc_register_resource, resources_count);
+		if (!reg_elements[0].cpc_entry.package.elements) {
+			pr_debug("Failed to allocate %d priority sub-elements for CPU:%d\n",
+				 resources_count, cpu);
+			return -ENOMEM;
+		}
+
+		reg_elements[0].type = ACPI_TYPE_PACKAGE;
+		reg_elements[0].cpc_entry.package.count = resources_count;
+
+		for (j = 0; j < reg_elements[0].cpc_entry.package.count; j++) {
+			reg_elements[0].cpc_entry.package.elements[j].type = ACPI_TYPE_INTEGER;
+			reg_elements[0].cpc_entry.package.elements[j].cpc_entry.int_value =
+				reg_desc_obj.package.elements[0].package.elements[j].integer.value;
+		}
+
+		for (j = 1; j < RESOURCE_PRIORITY_NUM; j++) {
+			ret = parse_cpc_element(&reg_desc_obj.package.elements[j], &reg_elements[j],
+						pcc_subspace_id, cpu, RESOURCE_PRIORITY);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * An example CPC table looks like the following.
  *
@@ -815,6 +900,7 @@ static void free_reg_resource(struct cpc_register_resource *cpc_reg)
 int acpi_cppc_processor_probe(struct acpi_processor *pr)
 {
 	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct cpc_register_resource *pkg_elements;
 	union acpi_object *out_obj, *cpc_obj;
 	struct cpc_desc *cpc_ptr;
 	struct device *cpu_dev;
@@ -823,6 +909,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	int pcc_subspace_id = -1;
 	acpi_status status;
 	int ret = -ENODATA;
+	u32 pkg_count;
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
@@ -904,16 +991,49 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	for (i = 2; i < num_ent; i++) {
 		cpc_obj = &out_obj->package.elements[i];
 
+		/*
+		 * Package-type entries are used for nested structures such as
+		 * RESOURCE_PRIORITY (CPPC v4). Only RESOURCE_PRIORITY is
+		 * currently supported; any other Package entry is rejected.
+		 */
 		if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
+			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_PACKAGE;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.package.count = 0;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.package.elements = NULL;
+
+			pkg_count = cpc_obj->package.count;
+			if (!pkg_count) {
+				pr_debug("Empty package entry at index %d for CPU:%d\n",
+					 i, pr->id);
+				continue;
+			}
+
+			pkg_elements = kzalloc_objs(struct cpc_register_resource, pkg_count);
+			if (!pkg_elements) {
+				ret = -ENOMEM;
+				goto out_free;
+			}
+
 			/*
-			 * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priority as a
-			 * Package of Resource Priority Register Descriptor sub-packages.
-			 * Parsing the full structure is not yet supported.
-			 * Mark the register as unsupported for now.
+			 * Assign values immediately after successful allocation to ensure that
+			 * resources can be properly released.
 			 */
-			pr_debug("CPU:%d Resource Priority not supported\n", pr->id);
-			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
-			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.package.count = pkg_count;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.package.elements = pkg_elements;
+
+			if (i - 2 == RESOURCE_PRIORITY) {
+				ret = parse_priority_regs(cpc_obj, pkg_elements,
+							  &pcc_subspace_id, pr->id);
+				if (ret)
+					goto out_free;
+
+				pr_debug("Parsed RESOURCE_PRIORITY (%d sub-pkgs) for CPU:%d\n",
+					 pkg_count, pr->id);
+			} else {
+				pr_debug("Unexpected ACPI_TYPE_PACKAGE at index %d for CPU:%d\n",
+					 i, pr->id);
+				goto out_free;
+			}
 		} else {
 			ret = parse_cpc_element(cpc_obj, &cpc_ptr->cpc_regs[i-2],
 						&pcc_subspace_id, pr->id, i);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 1839582b80be..19f8a722654b 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -123,6 +123,19 @@ enum cppc_regs {
 	RESOURCE_PRIORITY,
 };
 
+/*
+ * Indices into each sub-package of the RESOURCE_PRIORITY entry.
+ * RESOURCE_PRIORITY_NUM serves as the element count / loop bound.
+ */
+enum resource_priority_regs {
+	CONTROLLED_RESOURCES,	/* Package of integer resource IDs */
+	ENABLE_VALUE,		/* Enable/disable value */
+	ENABLE_REGISTER,	/* Register for enable/disable control */
+	PRIORITY_COUNT,		/* Number of priority levels */
+	PRIORITY_REGISTER,	/* Register for priority setting */
+	RESOURCE_PRIORITY_NUM,	/* Number of elements (sentinel) */
+};
+
 /*
  * Categorization of registers as described
  * in the ACPI v.5.1 spec.
-- 
2.33.0

