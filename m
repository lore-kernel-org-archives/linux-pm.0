Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EB5476C9;
	Tue, 22 Sep 2026 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081039; cv=none; b=IxTZ22zKY42vYxhcTBAg8wZRMrZQmA4s06lN9ErWYnAv/MHJUha29HQoy5WxwdpbzPfjmXLsmbDMRTwrNJJQCmz3HARNYnQtm4NNBAb08uVmdPK8pmKGu8wKBg4TyfhUKOq5Mv/uqczGAx/uLp9wUTFsLcEZ41kMAR5xt+lK0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081039; c=relaxed/simple;
	bh=N4HtkiWf7I6T2lTSMu8KrEBHfC1CNXw2MeRawSnuvXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ER++QxDI7+37RuOAtKSOLUJAQ/bckzaVE6brCaN9AUN+SVo6GfzsxBsOZCWD8dl7spgRmPdEKZTcysmbRTcCr+C60ifyEyW/69DR51DmovFsp3/kh5vfr60VbIuDSjMnouvt3GoQ8lCYjamyP1/PRR12uvJOSOc0hBVL9wYoDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=A6MLL1lL; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="A6MLL1lL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uuTlAjbFVG3K4wNEikSMGRwn8CiTCyTwtRqd8LgITfc=;
	b=A6MLL1lLoqRqLjMnIUrkIz7uyVDYEI7+6iMBwg379KlmGhDk2YI4eNS+GqCXAfUABQafn2U9p
	k5VwnFEKgWv6vb/w2CNZrvQOGeiOxdDzfuxq9C5JYIKiIW6RBiO/lRBs+NB+Uo26BE3mTyy9vEe
	zicGgEAClSO49nqGfFRLpLY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hpzyP0v8lznTWH;
	Tue, 22 Sep 2026 20:32:45 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id A739A40586;
	Tue, 22 Sep 2026 20:43:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 20:43:45 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v4 6/8] ACPI: CPPC: Factor out cpc_read_reg() and cpc_write_reg()
Date: Tue, 22 Sep 2026 20:41:19 +0800
Message-ID: <20260922124121.3426219-7-zhenglifeng1@huawei.com>
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
index 53c71888108d..2c2b25ec3e27 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1374,7 +1374,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	return ret_val;
 }
 
-static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
+static int cpc_read_in_pcc(int cpu, struct cpc_register_resource *reg, u64 *val)
 {
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cppc_pcc_data *pcc_ss_data = NULL;
@@ -1399,35 +1399,52 @@ static int cppc_get_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
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
@@ -1452,18 +1469,16 @@ static int cppc_set_reg_val_in_pcc(int cpu, struct cpc_register_resource *reg, u
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
@@ -1471,11 +1486,23 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
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

