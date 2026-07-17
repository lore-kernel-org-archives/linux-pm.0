Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E52FDC53;
	Fri, 17 Jul 2026 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256421; cv=none; b=t5aYQJt2SuCYjHcZtKjtb9NqmZe27R6TAhrKWdRC57x/c0pusPV9JSX+2DbtrxmKjk3JYF3K1BE/eEuAHz6ycnM7pUFrZluRRYnXj3Hc52Wz59k1rzsewywc8YwIExC3b3fh9gdzE2vDrX/774n8RRycWGKwVvREoapCZY2mF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256421; c=relaxed/simple;
	bh=aj2/1FoBAbPQ5UNkEYCQD0HUBE7zR3L/cqMz8pIQrmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KE0In6vduPVvAHqtF/mTrgAJaOgiRyK3vIkSPMxsDbvVtkaDskov3yTM6p0MfCbKlLEU5L8qXwYOogY8/a3jYNYpTIh1PiP7dpwghDYHoAc6DH7xgmm2bPC5BZKeoRPjB4Al2OjQoUPV4GK07qggdeFTuLezTQO05B3+XmxFFgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=emLOYlTI; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="emLOYlTI"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m3qOPmBnKIpyYgkwdWQ0ZW/IYIyKdTGwEkjgt1jSqPA=;
	b=emLOYlTIKz9BppCM6jXFkpWIjoRJEdLhtydojpD+vOW7pL9hjJP9/msimP732nmGi5OXqoAKk
	nXoXVhXRBQcgK21nHYuCR64urbO4fUkD/Yi2O0RmLTjDjwIKVAA/DAOyGsJpQQGMlWAFAmuwSET
	2a93wi43+s1+GZAmudwatio=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4h1YwG5Lbhz12LDF;
	Fri, 17 Jul 2026 10:37:18 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DC482012A;
	Fri, 17 Jul 2026 10:46:55 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 10:46:54 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH 6/8] ACPI: CPPC: Factor out cpc_read_reg() and cpc_write_reg()
Date: Fri, 17 Jul 2026 10:45:00 +0800
Message-ID: <20260717024502.3520445-7-zhenglifeng1@huawei.com>
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

cppc_get_reg_val() and cppc_set_reg_val() combine two responsibilities:
looking up the per-CPU cpc_desc and then performing the actual register
read/write (including null/optional checks and PCC handling).

Split out the register I/O logic into cpc_read_reg() and cpc_write_reg()
that accept a struct cpc_register_resource pointer directly.  This allows
callers that already hold a register reference -- such as the upcoming
Resource Priority accessors -- to read or write a register without going
through the per-CPU descriptor lookup by index.

Also rename the PCC wrappers from cppc_get/set_reg_val_in_pcc() to
cpc_read/write_in_pcc() to align with the new naming convention.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 89 ++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 31 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3f1b61c984d4..0037fca47eea 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1378,7 +1378,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
-static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
+static int cpc_read_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
@@ -1403,35 +1403,52 @@ static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
 	return ret;
 }
 
-static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
+/**
+ * cpc_read_reg - Read value from a register element that may be Integer or Buffer.
+ * @cpu: CPU number.
+ * @reg: Pointer to the CPC register element.
+ * @val: Output value.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if null/unsupported, negative on error.
+ */
+static int cpc_read_reg(int cpu, struct cpc_register_resource *reg, u64 *val)
 {
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *reg;
-
 	if (val == NULL)
 		return -EINVAL;
 
-	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
-		return -ENODEV;
-	}
-
-	reg = &cpc_desc->cpc_regs[reg_idx];
-
-	if ((reg->type == ACPI_TYPE_INTEGER && reg->optional &&
-	     !reg->cpc_entry.int_value) || (reg->type != ACPI_TYPE_INTEGER &&
-	     IS_NULL_REG(&reg->cpc_entry.reg))) {
-		pr_debug("CPC register is not supported\n");
-		return -EOPNOTSUPP;
+	if (reg->type == ACPI_TYPE_INTEGER) {
+		if (reg->optional && !reg->cpc_entry.int_value)
+			goto err_unsupported;
+	} else if (reg->type == ACPI_TYPE_BUFFER) {
+		if (IS_NULL_REG(&reg->cpc_entry.reg))
+			goto err_unsupported;
+	} else {
+		goto err_unsupported;
 	}
 
 	if (CPC_IN_PCC(reg))
-		return cppc_get_reg_val_in_pcc(cpu, reg, val);
+		return cpc_read_in_pcc(cpu, reg, val);
 
 	return cpc_read(cpu, reg, val);
+
+err_unsupported:
+	pr_debug("CPC register is not supported\n");
+	return -EOPNOTSUPP;
+}
+
+static int cppc_get_reg_val(int cpu, enum cppc_regs reg_idx, u64 *val)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	return cpc_read_reg(cpu, &cpc_desc->cpc_regs[reg_idx], val);
 }
 
-static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
+static int cpc_write_in_pcc(int cpu, struct cpc_register_resource *reg, u64 val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
@@ -1456,18 +1473,16 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
 	return ret;
 }
 
-static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
+/**
+ * cpc_write_reg - Write a CPC register.
+ * @cpu: CPU number.
+ * @reg: Pointer to the CPC register resource.
+ * @val: Value to write.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int cpc_write_reg(int cpu, struct cpc_register_resource *reg, u64 val)
 {
-	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
-	struct cpc_register_resource *reg;
-
-	if (!cpc_desc) {
-		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
-		return -ENODEV;
-	}
-
-	reg = &cpc_desc->cpc_regs[reg_idx];
-
 	/* if a register is writeable, it must be a buffer and not null */
 	if ((reg->type != ACPI_TYPE_BUFFER) || IS_NULL_REG(&reg->cpc_entry.reg)) {
 		pr_debug("CPC register is not supported\n");
@@ -1475,11 +1490,23 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
 	}
 
 	if (CPC_IN_PCC(reg))
-		return cppc_set_reg_val_in_pcc(cpu, reg, val);
+		return cpc_write_in_pcc(cpu, reg, val);
 
 	return cpc_write(cpu, reg, val);
 }
 
+static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+
+	if (!cpc_desc) {
+		pr_debug("No CPC descriptor for CPU:%d\n", cpu);
+		return -ENODEV;
+	}
+
+	return cpc_write_reg(cpu, &cpc_desc->cpc_regs[reg_idx], val);
+}
+
 /**
  * cppc_get_desired_perf - Get the desired performance register value.
  * @cpunum: CPU from which to get desired performance.
-- 
2.33.0

