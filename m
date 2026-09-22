Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9FB5437CC;
	Tue, 22 Sep 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081034; cv=none; b=p00P96TZh7OyJC+WUoxrTIG1aqZusNAjpHhb0pKaMt0W/SL9kWpMbWIbDFZSucUsotMTjKaySh/YK6AuMt4kCtShD7pjbNYk9DP9+gV+F7mHF5FY/RsvaFfFK+cO9CLdMOjMNkF/qnALOX4m1Cfxe/VdZVrUAPaZmDgLrnvSeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081034; c=relaxed/simple;
	bh=mYSr0K4zrRaOvDJ4RTYqmqbIJNYtzjYqJJKzjZAl1Uc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blXOp7ooHQN0xSGewDE2/AvYrTIMcjE+Uh/3s3Q4kdm2b8QkoYmLv2ottqSKEucD8y4DNq0cqHtgcotdNhjDYACHI9ZVfkSlH9qEqwSjHk6tdcRjFCNnAeNTnnfmvNoSVMUumV4d8OdJWskNaChICcuAKeF5SzbjOuUBkE5MkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QSbzwbf5; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QSbzwbf5"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ruZedv3T9GAEEFlS4qhDZuZMFHjSElM+C872GQj8Nko=;
	b=QSbzwbf5iOXNxfklN5dHFd3rXrPZuGllejWqonfeOcTDr4n84cDEbRHt0PiuX2K2PROHirnS8
	4vzdRt0Lio/69yN+qiIP/kH0qVoM2ptPPNhUiC0UMUE1FZyHGFSv8H3ZXIgz7KAXReLlfyS3Y9Q
	WQYTcun5eo3ywMZJfSTSJvA=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hpzxT1PnQz1T4LY;
	Tue, 22 Sep 2026 20:31:57 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 64DAD4058C;
	Tue, 22 Sep 2026 20:43:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 20:43:46 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v4 7/8] ACPI: CPPC: Add Resource Priority accessors
Date: Tue, 22 Sep 2026 20:41:20 +0800
Message-ID: <20260922124121.3426219-8-zhenglifeng1@huawei.com>
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

CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) defines the Resource Priority
mechanism that lets OSPM control relative priority among processors for
shared resources such as processor boost, throttle, L2/L3 cache, and
memory bandwidth.

Add the following exported APIs for user-space and driver consumers:

  - cppc_get_resource_priority_count() -- number of sub-packages
  - cppc_get_resource_priority_resources() -- resource type IDs
  - cppc_get/set_res_priority_enable() -- enable/disable a group
  - cppc_get_res_priority_count() -- priority levels in a group
  - cppc_get/set_res_priority() -- read/write the priority value

These wrappers navigate the nested Package structure parsed earlier by
parse_priority_regs() and delegate register I/O to cpc_read_reg() /
cpc_write_reg().

Provide stubs returning -EOPNOTSUPP for the !CONFIG_ACPI_CPPC_LIB case.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 264 +++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  37 ++++++
 2 files changed, 301 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 2c2b25ec3e27..f90d727798e8 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -2284,6 +2284,270 @@ int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 }
 EXPORT_SYMBOL_GPL(cppc_set_perf_limited);
 
+/**
+ * get_res_prio_subpkg - Get pointer to the elements array of a RESOURCE_PRIORITY sub-package.
+ * @cpu: CPU number.
+ * @index: Sub-package index (0 to count-1).
+ *
+ * Return: Pointer to the sub-package's elements array, or NULL on error.
+ *
+ * The layout within each sub-package element is:
+ *   elements[CONTROLLED_RESOURCES] = [0]
+ *   elements[ENABLE_VALUE]         = [1]
+ *   elements[ENABLE_REGISTER]      = [2]
+ *   elements[PRIORITY_COUNT]       = [3]
+ *   elements[PRIORITY_REGISTER]    = [4]
+ */
+static struct cpc_register_resource *get_res_prio_subpkg(int cpu, int index)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *rp_pkg;
+
+	if (!cpc_desc)
+		return NULL;
+
+	rp_pkg = &cpc_desc->cpc_regs[RESOURCE_PRIORITY];
+	if (rp_pkg->type != ACPI_TYPE_PACKAGE)
+		return NULL;
+
+	if (index < 0 || index >= rp_pkg->cpc_entry.package.count)
+		return NULL;
+
+	return rp_pkg->cpc_entry.package.elements[index].cpc_entry.package.elements;
+}
+
+/**
+ * cppc_get_resource_priority_count - Get number of Resource Priority sub-packages.
+ * @cpu: CPU number.
+ * @count: Output number of resource priority groups.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if RESOURCE_PRIORITY not provided by firmware.
+ */
+int cppc_get_resource_priority_count(int cpu, int *count)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	struct cpc_register_resource *rp_pkg;
+
+	if (!count)
+		return -EINVAL;
+
+	if (!cpc_desc)
+		return -ENODEV;
+
+	rp_pkg = &cpc_desc->cpc_regs[RESOURCE_PRIORITY];
+	if (rp_pkg->type != ACPI_TYPE_PACKAGE)
+		return -EOPNOTSUPP;
+
+	*count = rp_pkg->cpc_entry.package.count;
+	if (*count <= 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_resource_priority_count);
+
+/**
+ * cppc_get_resource_priority_resources - Read Controlled Resources list for a sub-package.
+ * @cpu: CPU number.
+ * @index: Sub-package index (0 to count-1).
+ * @resources: Output array of resource type IDs (caller-allocated).
+ * @num_resources: Input = array capacity, output = actual count.
+ *
+ * Return: 0 on success, -EOPNOTSUPP, -EINVAL, etc.
+ */
+int cppc_get_resource_priority_resources(int cpu, int index,
+					 u32 *resources, int *num_resources)
+{
+	struct cpc_register_resource *elems;
+	struct cpc_register_resource *cr_pkg;
+	int i, cr_count;
+
+	if (!resources || !num_resources || *num_resources <= 0)
+		return -EINVAL;
+
+	elems = get_res_prio_subpkg(cpu, index);
+	if (!elems)
+		return -EOPNOTSUPP;
+
+	cr_pkg = &elems[CONTROLLED_RESOURCES];
+	if (cr_pkg->type != ACPI_TYPE_PACKAGE)
+		return -EOPNOTSUPP;
+
+	cr_count = cr_pkg->cpc_entry.package.count;
+	if (cr_count <= 0) {
+		*num_resources = 0;
+		return 0;
+	}
+
+	*num_resources = min(cr_count, *num_resources);
+
+	for (i = 0; i < *num_resources; i++)
+		resources[i] = cr_pkg->cpc_entry.package.elements[i].cpc_entry.int_value;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_resource_priority_resources);
+
+/**
+ * cppc_get_res_priority_enable - Read enable state of a Resource Priority register.
+ * @cpu: CPU number.
+ * @index: Sub-package index.
+ * @enable: Output true if enabled, false if disabled.
+ *
+ * Compares the current ENABLE_REGISTER value against ENABLE_VALUE.
+ * If ENABLE_REGISTER is null/unsupported, returns -EOPNOTSUPP.
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+int cppc_get_res_priority_enable(int cpu, int index, bool *enable)
+{
+	struct cpc_register_resource *elems;
+	struct cpc_register_resource *enable_reg;
+	u64 reg_val, enable_val;
+	int ret;
+
+	if (!enable)
+		return -EINVAL;
+
+	elems = get_res_prio_subpkg(cpu, index);
+	if (!elems)
+		return -EOPNOTSUPP;
+
+	enable_reg = &elems[ENABLE_REGISTER];
+	if (enable_reg->type != ACPI_TYPE_BUFFER ||
+	    IS_NULL_REG(&enable_reg->cpc_entry.reg))
+		return -EOPNOTSUPP;
+
+	ret = cpc_read_reg(cpu, enable_reg, &reg_val);
+	if (ret)
+		return ret;
+
+	ret = cpc_read_reg(cpu, &elems[ENABLE_VALUE], &enable_val);
+	if (ret)
+		return ret;
+
+	*enable = (reg_val == enable_val);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_res_priority_enable);
+
+/**
+ * cppc_set_res_priority_enable - Set enable state of a Resource Priority register.
+ * @cpu: CPU number.
+ * @index: Sub-package index.
+ * @enable: true to enable (write ENABLE_VALUE), false to disable (write 0).
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+int cppc_set_res_priority_enable(int cpu, int index, bool enable)
+{
+	struct cpc_register_resource *elems;
+	struct cpc_register_resource *enable_reg;
+	u64 val;
+	int ret;
+
+	elems = get_res_prio_subpkg(cpu, index);
+	if (!elems)
+		return -EOPNOTSUPP;
+
+	enable_reg = &elems[ENABLE_REGISTER];
+
+	if (enable) {
+		ret = cpc_read_reg(cpu, &elems[ENABLE_VALUE], &val);
+		if (ret)
+			return ret;
+	} else {
+		val = 0;
+	}
+
+	return cpc_write_reg(cpu, enable_reg, val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_res_priority_enable);
+
+/**
+ * cppc_get_res_priority_count - Read priority count for a Resource Priority register.
+ * @cpu: CPU number.
+ * @index: Sub-package index.
+ * @count: Output priority count (>= 2 per spec).
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+int cppc_get_res_priority_count(int cpu, int index, u64 *count)
+{
+	struct cpc_register_resource *elems;
+
+	if (!count)
+		return -EINVAL;
+
+	elems = get_res_prio_subpkg(cpu, index);
+	if (!elems)
+		return -EOPNOTSUPP;
+
+	return cpc_read_reg(cpu, &elems[PRIORITY_COUNT], count);
+}
+EXPORT_SYMBOL_GPL(cppc_get_res_priority_count);
+
+/**
+ * cppc_get_res_priority - Read priority value for a Resource Priority register.
+ * @cpu: CPU number.
+ * @index: Sub-package index.
+ * @priority: Output priority value.
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+int cppc_get_res_priority(int cpu, int index, u64 *priority)
+{
+	struct cpc_register_resource *elems;
+	struct cpc_register_resource *prio_reg;
+
+	if (!priority)
+		return -EINVAL;
+
+	elems = get_res_prio_subpkg(cpu, index);
+	if (!elems)
+		return -EOPNOTSUPP;
+
+	prio_reg = &elems[PRIORITY_REGISTER];
+	if (prio_reg->type != ACPI_TYPE_BUFFER ||
+	    IS_NULL_REG(&prio_reg->cpc_entry.reg))
+		return -EOPNOTSUPP;
+
+	return cpc_read_reg(cpu, prio_reg, priority);
+}
+EXPORT_SYMBOL_GPL(cppc_get_res_priority);
+
+/**
+ * cppc_set_res_priority - Write priority value for a Resource Priority register.
+ * @cpu: CPU number.
+ * @index: Sub-package index.
+ * @priority: Priority value to write (valid range: [0, PriorityCount - 1]).
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+int cppc_set_res_priority(int cpu, int index, u64 priority)
+{
+	struct cpc_register_resource *elems;
+	struct cpc_register_resource *prio_reg;
+	u64 prio_count;
+	int ret;
+
+	elems = get_res_prio_subpkg(cpu, index);
+	if (!elems)
+		return -EOPNOTSUPP;
+
+	ret = cpc_read_reg(cpu, &elems[PRIORITY_COUNT], &prio_count);
+	if (ret)
+		return ret;
+
+	if (priority >= prio_count)
+		return -EINVAL;
+
+	prio_reg = &elems[PRIORITY_REGISTER];
+
+	return cpc_write_reg(cpu, prio_reg, priority);
+}
+EXPORT_SYMBOL_GPL(cppc_set_res_priority);
+
 /**
  * cppc_get_transition_latency - returns frequency transition latency in ns
  * @cpu_num: CPU number for per_cpu().
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index c0b8d52016cd..86a4764c504d 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -208,6 +208,14 @@ extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
+extern int cppc_get_resource_priority_count(int cpu, int *count);
+extern int cppc_get_resource_priority_resources(int cpu, int index,
+						u32 *resources, int *num_resources);
+extern int cppc_get_res_priority_enable(int cpu, int index, bool *enable);
+extern int cppc_set_res_priority_enable(int cpu, int index, bool enable);
+extern int cppc_get_res_priority_count(int cpu, int index, u64 *count);
+extern int cppc_get_res_priority(int cpu, int index, u64 *priority);
+extern int cppc_set_res_priority(int cpu, int index, u64 priority);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
 extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
 extern int amd_detect_prefcore(bool *detected);
@@ -312,6 +320,35 @@ static inline int cppc_set_perf_limited(int cpu, u64 bits_to_clear)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_resource_priority_count(int cpu, int *count)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_resource_priority_resources(int cpu, int index,
+						       u32 *resources, int *num_resources)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_res_priority_enable(int cpu, int index, bool *enable)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_res_priority_enable(int cpu, int index, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_res_priority_count(int cpu, int index, u64 *count)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_get_res_priority(int cpu, int index, u64 *priority)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_res_priority(int cpu, int index, u64 priority)
+{
+	return -EOPNOTSUPP;
+}
 static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
-- 
2.33.0

