Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE619E992;
	Fri, 17 Jul 2026 02:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256420; cv=none; b=cYEpX5tlODUCoOK2LcBWUXlWwYKi1MoIYm29M98w+51r6fCIIkkRgnq9Si+w36OXgsI+pQrS+5JcX7uWlxNNKkmdZZCTnDmlq0z+diAsNrILeMaHYeb2WlcMRTQEJzAjFlTfuc4jm0+PnYi+9DGrZerhtYrhqK/tZ2uwyb+/l7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256420; c=relaxed/simple;
	bh=d1hTAeGLKYZJ1VeMNgcpy42nXEMYfzFIvAGGJNmdp08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VEytjbhYF+l+lK4tZxQML6GS2bb6VHeoruGZS+lcKLR7XHR1wBQSyJKQFkCOkotwi2FOBBmVvfvyjKunitMQ1lVCShM6g3VSQlF/Uu+6IphGxcTG1LOkxH0XhiUuFJOktntEHZhK1KT7jFdgSXs+x8eHgxHQWYwaPox/bC29HI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MOJ1UX40; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MOJ1UX40"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fjApW9cD3YHn24BaFclPyPFjS5WhEYtBx2272uoKIvU=;
	b=MOJ1UX40vzbzNpO4eeKMlvuswwype1vP+ArMFH/bhaEHqI8OeS2QgA/p4PyNTLTEjVW41CAAy
	iNfcPVsDb1z+3XjfoDjZ6mxmvhggaU73U8Mk2Pup4BEzlvh7zVaW2KwLn3VxLR5H3NFSIshUmJZ
	suNXzXklcVTo05tOh9HMAb0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h1YwZ1XJyzcZy9;
	Fri, 17 Jul 2026 10:37:34 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F31540577;
	Fri, 17 Jul 2026 10:46:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 10:46:52 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 1/8] ACPI: CPPC: Prepare cpc_register_resource for Package-type entries
Date: Fri, 17 Jul 2026 10:44:55 +0800
Message-ID: <20260717024502.3520445-2-zhenglifeng1@huawei.com>
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

CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) introduces the Resource
Priority entry, which is a Package of sub-packages rather than a
plain Integer or Buffer register.  The existing cpc_register_resource
union only accommodates Integer and Buffer (register descriptor)
fields.

Add a Package variant to the cpc_entry union so that nested
structures such as RESOURCE_PRIORITY can store their element count
and a dynamically allocated array of child cpc_register_resource
descriptors.

Update the CPC_SUPPORTED() macro to recognise Package-type entries
with a non-zero element count, and switch the unsupported-Package
fallback from a zero Integer to an empty Package (count = 0,
elements = NULL) so that CPC_SUPPORTED() correctly reports such
entries as unsupported.

No functional change intended; the new Package fields are not yet
consumed by any caller.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 19 +++++++++++++------
 include/acpi/cppc_acpi.h |  8 ++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9f572f481241..d7e654f2a66c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -124,10 +124,16 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 				(reg)->bit_offset == 0 &&		\
 				(reg)->access_width == 0)
 
-/* Evaluates to True if an optional cpc field is supported */
-#define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?		\
-				!!(cpc)->cpc_entry.int_value :		\
-				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
+/*
+ * Evaluates to True if an optional cpc field is supported.
+ * Integer: non-zero value; Buffer: non-NULL register; Package: non-empty.
+ */
+#define CPC_SUPPORTED(cpc) (((cpc)->type == ACPI_TYPE_INTEGER &&	\
+			     !!(cpc)->cpc_entry.int_value) ||		\
+			    ((cpc)->type == ACPI_TYPE_BUFFER &&		\
+			     !IS_NULL_REG(&(cpc)->cpc_entry.reg)) ||	\
+			    ((cpc)->type == ACPI_TYPE_PACKAGE &&	\
+			     (cpc)->cpc_entry.package.count != 0))
 
 /*
  * Each bit indicates the optionality of the register in per-cpu
@@ -859,8 +865,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			 * Mark the register as unsupported for now.
 			 */
 			pr_debug("CPU:%d Resource Priority not supported\n", pr->id);
-			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_INTEGER;
-			cpc_ptr->cpc_regs[i-2].cpc_entry.int_value = 0;
+			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_PACKAGE;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.package.count = 0;
+			cpc_ptr->cpc_regs[i-2].cpc_entry.package.elements = NULL;
 		} else {
 			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
 				 i, pr->id);
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..1839582b80be 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -71,6 +71,14 @@ struct cpc_register_resource {
 	union {
 		struct cpc_reg reg;
 		u64 int_value;
+		/*
+		 * CPPC v4: nested Package (e.g. RESOURCE_PRIORITY),
+		 * elements dynamically allocated
+		 */
+		struct {
+			u32 count;
+			struct cpc_register_resource *elements;
+		} package;
 	} cpc_entry;
 };
 
-- 
2.33.0

