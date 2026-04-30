Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BD1632DD;
	Thu, 30 Apr 2026 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559153; cv=fail; b=jLURSvSk7v+LDMaBVb/0MSPMYa0PfchuMbnQ+vi0LqqJl75alZddeTGZJP81iiX5IdhIv8YMj9oqKhzFz4XKy/9oqKddRrTIt3IfV8+HSunxMd8xE7pi2WZDn7/W17Ox7ZC+PaxLU6+cFmIDgtgH+YRjQWHPckvtWr2t7r2BTE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559153; c=relaxed/simple;
	bh=d+t3hkcKxRZBFCLtwYamub9azgMcDvSvvCqVuUpECDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVqKj4pWmOuYKQ9Ty+rZnXRIunfUuDBW60OC/ANAF3+SUU+y3P70SVkRfuRIQpU/+M98EgyWoSkv5kY3sjSLstUVs3fnUJAQz+/t18D5hio6wePiwSvzwWCCmI82QZTUSyivgQ7LUrMVf8XNwjBInMQCrfGiZfIluoakp/lkc1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HPXtHLGe; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HPXtHLGe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4fBy+3wXi5HMuJSNi4fdUGGrcoaY0A2e6rdSIkT8VxpFegjIwexr/oymHqxmR/yL9OWJod4hKoaV2+8hXtgaq+jiQep7V3Z3DgtlBtZuXrBWh9UmOm2hfU6kwulVHyyFHJbOlJu+ISOd9hkPCAP4BSH5yNkIUMe7o3VxRDIiUfkH5hrV0bZOcWrCJZ9W8WLgF8qp9YX632baE5zBSrkj4Qdwe3ijcpvlRwDGxTMavCK/rANCPBMO27pu939W6kYMOcmOcrh+y4OjWhiqqp2dYdqUF5J/IsQLWepQXPghTxxE6FhHksvQgwRHHRaE10wcoYl044gJtk3ELFlL97lTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+sXHacD671Yd0OHPqEbP3kfZ2B2fr16BGxH8jgQwgQ=;
 b=vXSRvi0ELDaVL/KZjQ2YMkZenQ+f3RWyjML5qOkB6UT82qIqLStx1DS/xhmvT6h80YQs8O9VCagYId1LfbxhCVarkDJd+wFsn32tKQwsFWZ7+qJbwDQzSVhXIf6IjZzBNo7W16dlsvy19v4mREbSg+5z10gC2iNbIQUkAfDs8hIgmDnIss+yYQM3dQPut8vLrmISJIcSWfAAG4uJVu/3NkxiQPISfkNw+UiVfmDtZkTzRFDxF0OyLLAeO+lyQvzSrva7w4393jDdn7qOIq0kl6shQv0GwDOCrPMQ5zi76k6LK5Dotmd6qAzZvKY6dNhHWtWtyxpvhdjvCIACrNxgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+sXHacD671Yd0OHPqEbP3kfZ2B2fr16BGxH8jgQwgQ=;
 b=HPXtHLGe8y9kW6p3VFLD2cusRIozZkSMm6vHdgr1t4bt/cxTqFx5sa/m11MNMBOH8XAjsPP0wL6VgpbE0m9KVuiANrbD21uiejClEeFX4t6osWeZLvjQhCErjIXw3szZ6rI75pszllol+k1Jz0si+rk/SVq3bsQV1OZlyQawE0TzKbQoGf1KMLBjITlBkpeVw71v5M9vXxaA1XAURfCMDl/CIuAw7BvkoLrUrG7zw2kMYoBasc6Ob0CN85Xq9uhtlIdUcoVI9I1oIO/WBbKfM8pw6G4axpfb5rR/RYNy5vME32hXtIRkOub/hABSRodIoi3ylfUpmZbjf38Ue5FH4A==
Received: from SJ0PR03CA0282.namprd03.prod.outlook.com (2603:10b6:a03:39e::17)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 14:25:43 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::fc) by SJ0PR03CA0282.outlook.office365.com
 (2603:10b6:a03:39e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 14:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 14:25:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 07:25:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 07:25:16 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 07:25:11 -0700
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
Subject: [PATCH v2 2/2] ACPI: CPPC: Add ospm_nominal_perf support
Date: Thu, 30 Apr 2026 19:54:30 +0530
Message-ID: <20260430142430.755437-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430142430.755437-1-sumitg@nvidia.com>
References: <20260430142430.755437-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4e98e6-8982-4d3e-bc76-08dea6c45cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	oqsc8I2D2yYS321klZLrmmrARAlPIkcXnwn3JoLQ/OsLvoDhZyU9KjZ3RCAOcfD8CVntDUvuef6NMNhiksdhL4p6Lw3HxgjWrRIBFRIxbmri0qqQAhJ4tArjnnmHxQfqlyhGaCvV0BjCjf2U33EYGRKy6dADCmQMIJMMZxoC8kQIpMvw0EHBD9pzk7ga7syiDlaKRAGrm8BEofz5NwXiumkGEFfNba+aGk96Dq0shfoxOFcyP+OEYE62ry4VCU2DSi1u+wdPVPWhbUFEJx9vJv5WKCw0etzmr/LE5QEO5zRyKHb4aF3LmSlDFyb1ySHVCCsxbSxSMqpaFQEu1VtKB5QUK4vtuVaHI06PKVCTyTnbDykqXqJpsWJw5TY2VfS9BAqNNOhSjXgNYsRFOjbjeTQstmi13lOJ2zUIs+ElzeKTxQohhClZd1U6JDhET8Jw02y5NzRtTstt95cSxB1q1m7jVLh0UgvTYld7YCL53tiG1EsK6iRC7XwHRJuDyoNlYszyMCqeSUE5Gs4eVxk1ooBvs1DGQLfTRH1KU0yqORQNgWIHsiZyBziWbDz5kQK9e6oLmMt3qNesjZGcHIoljsmxtVmmuLy7q8GubF7tr31ikwfBlBrF8x5wHJ+kmKCpYWwkzmB21xjJC9bEOkMLud/pZQLsdH3kgjoFZseC+JK4SRy1Uaj+zxWyokvYGBUjMKntG8Eq8rvsaeF70xwCUU+z1Kxtdij/T2MB0CnPvS/YaRccsUFcynmceUtpe8iEkOhmhLItzby6FF/p3miWonvR40jqP6Y8OabnPXgmOKRmtjRuh+48EbLftCVAf1i3
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zuiU5y9LvH0F5pQejtQXwCbKb9LU5Wngal/44h1F3yhw+TqUYh+luBEC3W0W5qP9Sn/IjxfjUZIDWyTbaWQ0t+R6wnXfb0Ngbwj1ZsbEA+JGtPMJfj4hmayNhwmcWAn2xGy1l1LQO1KsPmr046uiMV2kI6xtskTP3jVu+dExkVy9c8xFkTgUAK+18Rn946Tt/pKBQ5ZRR3+tv49BdHfXpF6TGkP97p0yoeGKMS5lLjVP6WpMUOJFIOgTDlxI2ohzlIhnxQ4b0iwRPR2kw/us+nIomG55MPrf3FrP9CUiKHK3zVFniU3R5yqRwkGGB8TVZbokxDtCa4lOETq49bEdHd3czPjXiF6Qwz7qY1aRBVF6UXjz32Ma37wiYopSRgxdNuxlrQS2gcC4JFxsBMCgLNGU9HZf3Ay7JUnfZW91I4PZqv0LN7M99C2mSVG8BeQ0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:25:43.1431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4e98e6-8982-4d3e-bc76-08dea6c45cb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346

Add acpi_cppc/ospm_nominal_perf sysfs attribute (read-write) and
cppc_set_ospm_nominal_perf() API for the OSPM Nominal Performance
register (ACPI 6.6, Section 8.4.6.1.2.6).

The register conveys the desired nominal performance level at which
the platform may run. OSPM can request a lower level than platform
nominal. Valid range is [Lowest Performance, Nominal Performance].
The value tells the platform what OSPM considers nominal. The
platform classifies performance above this as boosted and below as
throttled. It uses that for its power/thermal decisions.

Although the register is write-only per spec, cache the OSPM-written
value in cpc_desc so userspace can observe it via sysfs, and to
skip redundant writes.

Initialize to platform nominal at policy init. Override via sysfs
if needed.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c       | 69 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 10 +++++
 include/acpi/cppc_acpi.h       |  6 +++
 3 files changed, 85 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a1c91ce20cc8..fbc620adafad 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -155,6 +155,10 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
 static struct kobj_attribute _name =		\
 __ATTR(_name, 0444, show_##_name, NULL)
 
+#define define_one_cppc_rw(_name)		\
+static struct kobj_attribute _name =		\
+__ATTR(_name, 0644, show_##_name, store_##_name)
+
 #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
 
 #define show_cppc_data(access_fn, struct_name, member_name)		\
@@ -211,6 +215,38 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
 }
 define_one_cppc_ro(feedback_ctrs);
 
+static ssize_t show_ospm_nominal_perf(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
+	u64 val = READ_ONCE(cpc_ptr->ospm_nominal_perf);
+
+	if (!val)
+		return -ENODATA;
+
+	return sysfs_emit(buf, "%llu\n", val);
+}
+
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
+define_one_cppc_rw(ospm_nominal_perf);
+
 static struct attribute *cppc_attrs[] = {
 	&feedback_ctrs.attr,
 	&reference_perf.attr,
@@ -222,6 +258,7 @@ static struct attribute *cppc_attrs[] = {
 	&nominal_perf.attr,
 	&nominal_freq.attr,
 	&lowest_freq.attr,
+	&ospm_nominal_perf.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cppc);
@@ -1683,6 +1720,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
 }
 EXPORT_SYMBOL_GPL(cppc_set_epp);
 
+/**
+ * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
+ * @cpu: CPU on which to write register.
+ * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
+ *
+ * OSPM Nominal Performance allows OSPM to inform the platform of the nominal
+ * performance level it intends to maintain.
+ *
+ * Return: 0 for success, -EINVAL on invalid input, -EOPNOTSUPP if not
+ * supported, -EIO otherwise.
+ */
+int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
+	int ret;
+
+	if (!ospm_nominal_perf || ospm_nominal_perf > U32_MAX)
+		return -EINVAL;
+
+	if (cpc_desc &&
+	    READ_ONCE(cpc_desc->ospm_nominal_perf) == ospm_nominal_perf)
+		return 0;
+
+	ret = cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(cpc_desc->ospm_nominal_perf, ospm_nominal_perf);
+	return 0;
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
index 8693890a7275..3771e2ed507d 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -86,6 +86,7 @@ struct cpc_desc {
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
+	u32 ospm_nominal_perf;
 };
 
 /* These are indexes into the per-cpu cpc_regs[]. Order is important. */
@@ -180,6 +181,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
 extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
 extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
 extern int cppc_set_epp(int cpu, u64 epp_val);
+extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
 extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
@@ -266,6 +268,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
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

