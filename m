Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6D645D5FA;
	Tue,  4 Aug 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833575; cv=none; b=AJVoUvCNif2/ZLyaFx1Lefx12Zr24fB1NQ2a8xy+xbANnZAQgorXbYjd75bsC+cW+D6gpBlm6rKdcj7fYuo/3z1EMZx4TxSy+KSvqj5MaYuTTdxnj4rxtZ4EQ67JkbqkRL68LbcWp1yMawnF5orCFpuyqqUCbNf58WSXU0+m08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833575; c=relaxed/simple;
	bh=uj/4k3ahh5DQQDnMRlt+1fV7WBT846X7JsC4MJ6241I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0H4dCzwkz+47S7urAFmDHyt1NmK8rECnUfJs7t08cxvEIMIHh4FODCzDcHZsOHP8u1wMnbggTGisXRLrey0/YqdMsjfPcBzt+YjhKEpmnXhUq5/9ZvOyUYksK0OChEyD0Wy9U9jbGbL8rKhuB3ZO5NgJUWljbvbXRnE2Lfz3WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UTpCuniZ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UTpCuniZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=u127AWtuWEow6DhwkrykjEAAr5fTMXs9NBvexlTPfjI=;
	b=UTpCuniZKuMOYtawXAmqL3Rt96QIKGVWOrNN1B9xf59ie5VAISfTwKIzSpTdKDqLhXNk9QroW
	i+qAPFjKuDMJT/WeSpRdqXOobEUOP4A3hqdygU5qiYvuqyX8rXHieAbCjFiPs2NFtjq2mNKdl8S
	LGNEjGqqdghbmFRM6qNBrvA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hDnB83Vrpz1prKd;
	Tue,  4 Aug 2026 16:43:12 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 260C54057F;
	Tue,  4 Aug 2026 16:52:45 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 4 Aug 2026 16:52:44 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <zhanjie9@hisilicon.com>, <pierre.gondois@arm.com>,
	<sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhangpengjie2@huawei.com>, <wangzhi12@huawei.com>,
	<linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v2 6/8] ACPI: CPPC: Factor out cpc_read_reg() and cpc_write_reg()
Date: Tue, 4 Aug 2026 16:50:40 +0800
Message-ID: <20260804085042.4118193-7-zhenglifeng1@huawei.com>
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
index 3b35c757a789..bd6a26aa36cd 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1372,7 +1372,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
-static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
+static int cpc_read_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
@@ -1397,35 +1397,52 @@ static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
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
@@ -1450,18 +1467,16 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
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
@@ -1469,11 +1484,23 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
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

