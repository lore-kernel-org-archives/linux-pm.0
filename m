Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8C55448BD;
	Tue, 22 Sep 2026 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081035; cv=none; b=nBFCVC7L4XMZUr0Dg9KNNLr7fsyuRtCAfPwrDDenIcU2w8Mqm3m1pkoXIdT6nM866vo4dNXg7RjT9rUvdi+JTdpFUxC/lrhnrHWGsTjib2DHjc+SU8aUKx3ey5NO22yrAYrtCsl9eLQG55szWKT8wVwTpVEqzKMTpRaX2es15BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081035; c=relaxed/simple;
	bh=/B5NYFLugt9DIQ2id6d1oXbGd3V3fWNDJUDlnSTzymY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/CnW6Q21+YBq0x6zj6dwpa/wEqCgoNhtZyHo7kYaInR0BZrhxgpuqLxCzd/oW9XJfb/dC/CGKohaXQuz/OCQQYaRwV0r4NqjH6i/z06ZiHreEBo8bhKD+gvDGSkdllBC47FJv/h/C7+S5PcHTHvoi7EcR+yBhMTpiSR1QZ+2Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=m+8mqWQQ; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="m+8mqWQQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gk+Cw3lijNognwTB0VP6k3qTqQ7UBTDBC3Vxl2cQR8E=;
	b=m+8mqWQQVbQgZoOlCrVCz8CmyNI/Z2D1VSRnG8AMhyJPbU0kbVXBPfIKIOG+JeMqRTwqRgpq2
	E1YvK4PVmpiYTFG+i23vW96EavlHxk/XOO/D7Lj5FCyVROi9Pilu5nAc8z86jU1iGk3tZU0Vz40
	0cTY9heOSsDiiViZnPBMMmw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hpzxG4zTGzRhQs;
	Tue, 22 Sep 2026 20:31:46 +0800 (CST)
Received: from kwepemf100001.china.huawei.com (unknown [7.202.181.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 176054058C;
	Tue, 22 Sep 2026 20:43:48 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf100001.china.huawei.com (7.202.181.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 22 Sep 2026 20:43:47 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <saket.dumbre@intel.com>,
	<lenb@kernel.org>, <ionela.voinescu@arm.com>, <zhanjie9@hisilicon.com>,
	<pierre.gondois@arm.com>, <sumitg@nvidia.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v4 8/8] cpufreq: cppc: Expose Resource Priority attributes via sysfs
Date: Tue, 22 Sep 2026 20:41:21 +0800
Message-ID: <20260922124121.3426219-9-zhenglifeng1@huawei.com>
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

Add a "resource_priority" kobject directory under each cpufreq policy
that has CPPC v4 Resource Priority entries.  Inside it, create a
sub-directory per resource priority group (indexed 0..N-1) with the
following sysfs attributes:

  controlled_resources  (RO) -- resource type IDs as human-readable names
  enable                (RW) -- enable/disable the priority group
  priority_count        (RO) -- number of priority levels
  priority              (RW) -- current priority value

Create the sysfs hierarchy in cppc_cpufreq_cpu_init() and tear it down
in cppc_cpufreq_cpu_exit().  A void *res_prio_data pointer in
cppc_cpudata tracks the allocation.

These attributes allow administrators and power-management daemons to
inspect and tune Resource Priority settings at runtime without
requiring platform-specific tools.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 281 ++++++++++++++++++++++++++++++++-
 include/acpi/cppc_acpi.h       |   1 +
 2 files changed, 280 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f6cea0c54dd9..497c10e806ac 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -640,12 +640,15 @@ static void cppc_cpufreq_put_cpu_data(struct cpufreq_policy *policy)
 	policy->driver_data = NULL;
 }
 
+static int cppc_create_res_prio_sysfs(struct cpufreq_policy *policy);
+static void cppc_remove_res_prio_sysfs(struct cpufreq_policy *policy);
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int cpu = policy->cpu;
 	struct cppc_cpudata *cpu_data;
 	struct cppc_perf_caps *caps;
-	int ret;
+	int ret, retval;
 
 	cpu_data = cppc_cpufreq_get_cpu_data(cpu);
 	if (!cpu_data) {
@@ -715,7 +718,19 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	cppc_cpufreq_cpu_fie_init(policy);
-	return 0;
+
+	ret = cppc_create_res_prio_sysfs(policy);
+	if (!ret)
+		return 0;
+
+	cppc_cpufreq_cpu_fie_exit(policy);
+
+	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
+
+	retval = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	if (retval)
+		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+			 caps->lowest_perf, cpu, retval);
 
 out:
 	cppc_cpufreq_put_cpu_data(policy);
@@ -729,6 +744,7 @@ static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	unsigned int cpu = policy->cpu;
 	int ret;
 
+	cppc_remove_res_prio_sysfs(policy);
 	cppc_cpufreq_cpu_fie_exit(policy);
 
 	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
@@ -1026,6 +1042,267 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
 	NULL,
 };
 
+/* ====== Resource Priority sysfs interface (CPPC v4) ====== */
+
+struct cppc_res_prio_group {
+	struct kobject kobj;
+	int index;
+	unsigned int cpu;
+};
+
+struct cppc_res_prio_data {
+	struct kobject kobj;
+	int num_groups;
+	struct cppc_res_prio_group groups[];
+};
+
+static const char * const resource_type_names[] = {
+	NULL,
+	"processor_boost",
+	"processor_throttle",
+	"l2_cache",
+	"l3_cache",
+	"memory_bandwidth",
+};
+
+#define RESOURCE_TYPE_MAX 5
+
+static const char *resource_type_to_name(u32 id)
+{
+	if (id >= 1 && id <= RESOURCE_TYPE_MAX)
+		return resource_type_names[id];
+	return NULL;
+}
+
+static ssize_t controlled_resources_show(struct kobject *kobj,
+					 struct kobj_attribute *attr, char *buf)
+{
+	struct cppc_res_prio_group *grp =
+		container_of(kobj, struct cppc_res_prio_group, kobj);
+	u32 resources[32];
+	int num = ARRAY_SIZE(resources);
+	int ret, i, pos = 0;
+
+	ret = cppc_get_resource_priority_resources(grp->cpu, grp->index,
+						   resources, &num);
+	if (ret)
+		return ret;
+
+	if (num == 0)
+		return sysfs_emit(buf, "\n");
+
+	for (i = 0; i < num; i++) {
+		const char *name = resource_type_to_name(resources[i]);
+
+		if (name)
+			pos += sysfs_emit_at(buf, pos, "%s", name);
+		else
+			pos += sysfs_emit_at(buf, pos, "unknown(0x%02x)", resources[i]);
+
+		if (i < num - 1)
+			pos += sysfs_emit_at(buf, pos, " ");
+	}
+
+	pos += sysfs_emit_at(buf, pos, "\n");
+	return pos;
+}
+
+static ssize_t enable_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct cppc_res_prio_group *grp =
+		container_of(kobj, struct cppc_res_prio_group, kobj);
+	bool val;
+	int ret;
+
+	ret = cppc_get_res_priority_enable(grp->cpu, grp->index, &val);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", val);
+}
+
+static ssize_t enable_store(struct kobject *kobj,
+			    struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct cppc_res_prio_group *grp =
+		container_of(kobj, struct cppc_res_prio_group, kobj);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_res_priority_enable(grp->cpu, grp->index, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t priority_count_show(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   char *buf)
+{
+	struct cppc_res_prio_group *grp =
+		container_of(kobj, struct cppc_res_prio_group, kobj);
+	u64 val;
+	int ret;
+
+	ret = cppc_get_res_priority_count(grp->cpu, grp->index, &val);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t priority_show(struct kobject *kobj,
+			     struct kobj_attribute *attr, char *buf)
+{
+	struct cppc_res_prio_group *grp =
+		container_of(kobj, struct cppc_res_prio_group, kobj);
+	u64 val;
+	int ret;
+
+	ret = cppc_get_res_priority(grp->cpu, grp->index, &val);
+	if (ret == -EOPNOTSUPP)
+		return sysfs_emit(buf, "<unsupported>\n");
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
+static ssize_t priority_store(struct kobject *kobj,
+			      struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct cppc_res_prio_group *grp =
+		container_of(kobj, struct cppc_res_prio_group, kobj);
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_res_priority(grp->cpu, grp->index, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute attr_controlled_resources =
+	__ATTR(controlled_resources, 0444, controlled_resources_show, NULL);
+static struct kobj_attribute attr_enable =
+	__ATTR(enable, 0644, enable_show, enable_store);
+static struct kobj_attribute attr_priority_count =
+	__ATTR(priority_count, 0444, priority_count_show, NULL);
+static struct kobj_attribute attr_priority =
+	__ATTR(priority, 0644, priority_show, priority_store);
+
+static struct attribute *res_prio_group_attrs[] = {
+	&attr_controlled_resources.attr,
+	&attr_enable.attr,
+	&attr_priority_count.attr,
+	&attr_priority.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(res_prio_group);
+
+static void cppc_res_prio_group_release(struct kobject *kobj)
+{
+	/*
+	 * cppc_res_prio_group is embedded in the flexible array of
+	 * cppc_res_prio_data and freed when the parent is released.
+	 */
+}
+
+static const struct kobj_type cppc_res_prio_group_ktype = {
+	.release = cppc_res_prio_group_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = res_prio_group_groups,
+};
+
+static void cppc_res_prio_release(struct kobject *kobj)
+{
+	struct cppc_res_prio_data *data =
+		container_of(kobj, struct cppc_res_prio_data, kobj);
+
+	kfree(data);
+}
+
+static const struct kobj_type cppc_res_prio_ktype = {
+	.release = cppc_res_prio_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static void cppc_remove_res_prio_sysfs(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_res_prio_data *data = cpu_data->res_prio_data;
+	int i;
+
+	if (!data)
+		return;
+
+	for (i = 0; i < data->num_groups; i++)
+		kobject_put(&data->groups[i].kobj);
+
+	kobject_put(&data->kobj);
+	cpu_data->res_prio_data = NULL;
+}
+
+static int cppc_create_res_prio_sysfs(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_res_prio_data *data;
+	int num, i, ret;
+
+	ret = cppc_get_resource_priority_count(policy->cpu, &num);
+	if (ret || num <= 0)
+		return 0;
+
+	data = kzalloc(struct_size(data, groups, num), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->num_groups = num;
+
+	ret = kobject_init_and_add(&data->kobj, &cppc_res_prio_ktype,
+				   &policy->kobj, "resource_priority");
+	if (ret) {
+		kobject_put(&data->kobj);
+		return ret;
+	}
+
+	for (i = 0; i < num; i++) {
+		data->groups[i].index = i;
+		data->groups[i].cpu = policy->cpu;
+
+		ret = kobject_init_and_add(&data->groups[i].kobj,
+					   &cppc_res_prio_group_ktype,
+					   &data->kobj, "%d", i);
+		if (ret) {
+			for (; i >= 0; i--)
+				kobject_put(&data->groups[i].kobj);
+			kobject_put(&data->kobj);
+			return ret;
+		}
+	}
+
+	cpu_data->res_prio_data = data;
+	return 0;
+}
+
 static struct cpufreq_driver cppc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify = cppc_verify_policy,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 86a4764c504d..481fca627389 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -175,6 +175,7 @@ struct cppc_cpudata {
 	struct cppc_perf_fb_ctrs perf_fb_ctrs;
 	unsigned int shared_type;
 	cpumask_var_t shared_cpu_map;
+	void *res_prio_data;
 };
 
 #ifdef CONFIG_ACPI_CPPC_LIB
-- 
2.33.0

