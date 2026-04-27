Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A035F602;
	Mon, 27 Apr 2026 05:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267142; cv=fail; b=HSo7XJ7OTVjd9LcrwvKetLksIPkbinMCLM03Up5poCHdwhueIWJUBZxRb6gHZorAbKM2EalsnQQptC0Cbiq7Mjn+XOzgcTf87X4YFjUYe3iFM/7kS8ZPcBJs/4Ir82eGW3UEVrYVI7gAi+PvEh/eycShn9AUAOY2jRELMjtjrgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267142; c=relaxed/simple;
	bh=qmpeEUrIOKVVXsJefT0UrFeFqQRV50+a8JFC0PTjUNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKDIrF5T1667eDyhdejfxMPioJgRb98mpZ4MRSiM8ELycQLzZOb06gBLZYSGGqjjelfbPHM39gDv0bkFHSb1LwBX6dJ/SHZiMxJzYIAydkvQ3Kfxc2YrpdCmBkKceds8O71muw+rpbABg6wqdMBlTG3uzXYut0rWLsPK37eLRg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJfTTz+v; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJfTTz+v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmm6PZ/ezqUl67T9C3QKjJv9MMIaCnmqiKfzlIUrYdcmkgnLBBFsUzBwYNuEFkDooIHIbf90WpF0ZV4P94hFPB/fbFXMYSf0V3uBO0aL0mKsEGkb7zl4E1IFnvrpF0J7u6SAt4TWoByoO4t9GxWEyJjYpLdcYkaxnr2isBK/y2H16LzXHp72diHuhpt3vLmXHm+tvXaTfP4J6vPlV5jRaSAZX8dTtmhEcwcgKgb3bsn9S4ctYekhye5T6VTJgjCo9hy7AyyvqJ5bV0G5gTTnMKLe/+vuOlb9tSGpSUgmNuB/7FI4OJ+1xrMpkraVo1ZWXHBkbCjUf8apY0sQKhoh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYc0+VoraSLsMMuYXl2pIoQLrcMNiRDZlRYD2XzqdhA=;
 b=F7bVJqtk/itDhOYTcDZobg00P+99FqHJDFQTh+Bh74+mmWYT6AZ/uBQAY42SyDf3ygDU8cyaByLM7V1bnU5XIW0KxJ4Hm/0Yr/mpUfQ3VFqFUdTGez0/w00ok+XY4QlrR/8PF9/i8M+Q80zOci9TcRR7vpK8ubu1piMS6bPzMrnnWFQCeuMnUPc3DkW3H1JsUd6U6t2UKNTM1fSTbnd0pRUAEO7nDaMjJ/U7DwdYCYYf0jCUVfIjyRBUoKzO9cNlhvoId7/bTqFVmkcMYWc2GS7CHkeP6lP0po8w5CWWr+RtK9xaBwh/TUGl3Fsudg9DymJ4InOPCJadiJ6/zklv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYc0+VoraSLsMMuYXl2pIoQLrcMNiRDZlRYD2XzqdhA=;
 b=OJfTTz+vfKaOZE3yu+y4UxkPqWNXpH3uIAs1Ez5WyqUKEFcQJr/Wu5yV/d2t/BeK3y7zIww/4fDZgP98OMITOUNeH4HClAsU7mYRljW59LKTm5s9VVQRbGFDBiVYmw15eebfGGaHXrX7B3xuebAl7IV5wYWOvFF8piZbQAza3MacqbdVGC4qRP7ECrObnsd8HupQfcawyv9s3lBb7LmUagRg942TEIjfOy7AwaMdlGXUWfZ6Bbz8kBfjOx0zt3PZtltYYWOLtzw4i5hYjRqi5udHBe+Bc+rttXN+FccyN5I3qiV9YKv0nAh1R7JnoydChIJ5hv6Zxwj0ljS4QWnSCA==
Received: from BY5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:180::19)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Mon, 27 Apr
 2026 05:18:55 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::9c) by BY5PR13CA0006.outlook.office365.com
 (2603:10b6:a03:180::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 05:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Mon, 27 Apr 2026 05:18:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:18:45 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Apr
 2026 22:18:44 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Apr 2026 22:18:39 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH 2/2] ACPI: CPPC: Add ospm_nominal_perf support
Date: Mon, 27 Apr 2026 10:48:23 +0530
Message-ID: <20260427051823.280419-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427051823.280419-1-sumitg@nvidia.com>
References: <20260427051823.280419-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0e6e0c-6aac-4a95-efff-08dea41c7a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hpCuWmaK7GjjJY4K1Ow7wLAZ8r8Xg/d4+GgA/wsmzI4ru4Lh2DEuh2zratgQNYZlxqKdmhowIwTWy01qiC3POFsAqXKDl8RalZ+Ch3DUBRINfHl6VjoEidCcYBdz4BjVCinWldMwkQVh90RW3STakXjNgiFp3GT7kBHWHI9llbmhW7BdGTsol9dz6jncFdvg7zhbiCNczeUKJBZuFu1g23TqLgTbrTibDvVueaRSbtqPlWF2VuyCiAUs6Sk5uKqHq9e6RVHBh+blJRaW26AsKZAGffY2dSNQsmDjOvDJPI6xzUUjH9tbSFBjF8sYWUkglo8dbgy3jO3iLFxJ9AMhZcgkPHXYUtSi7AQpeoCS2l839e2/ueOerYvyxafAgmlvIEr1IVNztozSrlXzI+0hKHG6fz6gHAAXwB9HU00KS1UXXWeg5syk2vswoq4BaLglhWoWEI2RqYQnJRf7lS3F3SRvw0Yw55FWhBfaHOiwGxMDh0EX2ehKvFOYWnEApUlB8o/UG070zuzWTatcCSLIsz8fsO2pJL/7aW68+a4hvlBD5x8cNObjT47CePtEuRjHNnzogCWYib3gSfIP3u2UtDTjV65jB+cNWeeum39NUNbr0KHuXGLTP3rFa6W7Ox9+wj9QVBAN9NgprvfMBXeaHDsDi5gWeQloPyArhz9KJR0nG8iWJZLol/+PE91F8QV/JAmvaexDu4DdbcDVh2cvIUb7KXF4r+txxdth5LTEWQjFwSmkUtWwNNdBgKcKdyIZcTVpiqby0nUJqI8pqFUfv/QrqmZrfe/6ivN/mG6EeCwYhbh3r419rYK3EIAWV7bK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aP/tdozjv6yOQveuZxec36jL0vs8AS7V6eV3WEpFArTsMp+PFKEORJT56UJ2BvGABLF2qm2sczHAXBYbt5O62+nnoK5eY7wEwTsePFIbX5w2JkkIOQcDREOND34biKO7/NmHqmS7PoPZHu+t0lyfC1HaTlP2GJGkz+Ptw/PMwSr86RXigngCpqFkBroDyEN7D5AgIhi7JvdD5pKciD1lzTLbYOqDMWDFeya+X8UYTxsI74WPL+99/m7pEmZ3O20xtmH60cN+FxmAzXnkRbo+tZr1SctzctGNveh4HTCPBGeckea5B3dwOHljsH0ro/os1tawiMsUYNx0E6iJpC1vgeuaWEnxtQVd/gnWu7xERYnq6LSXT+0sRI2y/vgs1YfFgV4YRBH9Pnlbc7wZI17TCYED6yVTMeBe71ZAjWRiKucWayPJ6dOAUqHNaNAqETrO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 05:18:55.3663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0e6e0c-6aac-4a95-efff-08dea41c7a88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

Add acpi_cppc/ospm_nominal_perf sysfs attribute (write-only) and
cppc_set_ospm_nominal_perf() API for the OSPM Nominal Performance
register (ACPI 6.6, Section 8.4.6.1.2.6).

The register conveys the desired nominal performance level at which
the platform may run. OSPM can request a lower level than platform
nominal. Valid range is [Lowest Performance, Nominal Performance].
The value tells the platform what OSPM considers nominal. The
platform classifies performance above this as boosted and below as
throttled. It uses that for its power/thermal decisions.

Initialize to platform nominal at policy init. Override via sysfs
if needed.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 42 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 10 ++++++++
 include/acpi/cppc_acpi.h       |  5 ++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a1c91ce20cc8..83b4b14652fb 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -155,6 +155,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 static struct kobj_attribute _name =		\
 __ATTR(_name, 0444, show_##_name, NULL)
 
+#define define_one_cppc_wo(_name)		\
+static struct kobj_attribute _name =		\
+__ATTR(_name, 0200, NULL, store_##_name)
+
 #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
 
 #define show_cppc_data(access_fn, struct_name, member_name)		\
@@ -211,6 +215,26 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
 }
 define_one_cppc_ro(feedback_ctrs);
 
+static ssize_t store_ospm_nominal_perf(struct kobject *kobj,
+				       struct kobj_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	u64 val;
+	int ret;
+
+	ret = kstrtou64(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = cppc_set_ospm_nominal_perf(cpc_ptr->cpu_id, val);
+	if (ret)
+		return ret;
+
+	return count;
+}
+define_one_cppc_wo(ospm_nominal_perf);
+
 static struct attribute *cppc_attrs[] = {
 	&feedback_ctrs.attr,
 	&reference_perf.attr,
@@ -222,6 +246,7 @@ static struct attribute *cppc_attrs[] = {
 	&nominal_perf.attr,
 	&nominal_freq.attr,
 	&lowest_freq.attr,
+	&ospm_nominal_perf.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cppc);
@@ -1683,6 +1708,23 @@ int cppc_set_epp(int cpu, u64 epp_val)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp);
 
+/**
+ * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
+ * @cpu: CPU on which to write register.
+ * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
+ *
+ * OSPM Nominal Performance allows OSPM to inform the platform of the nominal
+ * performance level it intends to maintain. This is a write-only register per
+ * ACPI specification.
+ *
+ * Return: 0 for success, -EOPNOTSUPP if not supported, -EIO otherwise.
+ */
+int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+}
+EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
+
 /**
  * cppc_get_auto_act_window() - Read autonomous activity window register.
  * @cpu: CPU from which to read register.
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7e7f9dfb7a24..d06cba963550 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -715,6 +715,16 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 
+	/*
+	 * Initialize OSPM Nominal Performance to inform firmware of
+	 * OSPM's nominal level. Performance above this value = boost;
+	 * below = throttle. Uses platform nominal by default.
+	 */
+	ret = cppc_set_ospm_nominal_perf(cpu, caps->nominal_perf);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_debug("Failed to set ospm_nominal_perf for CPU%d: %d\n",
+			 cpu, ret);
+
 	cppc_cpufreq_cpu_fie_init(policy);
 	return 0;
 
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..ad1035b0e1de 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -180,6 +180,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
@@ -266,6 +267,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

