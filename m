Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDB333440;
	Thu, 16 Jul 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216365; cv=fail; b=byH10Oz7a4eOtkMArQavh6SXlUXO70NmkAIt1qItLtT+e2NM5E1ptzYwfeMC5CBe2+6DTMr93nh1PYXniEk+tv+cZ/F2ulsGIG9riYQLBC2+SomDXo/Tn+TgE03196Ew7pPinbggQc6ABg5e6Pf9HyL05LX/z2MExpBpdHpwHNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216365; c=relaxed/simple;
	bh=hbuqKV+RAPfPXquG/SYUIQxg6v+G+F1hAAzEcATKZVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTPUjGQymi5LyR0AzHnZIaX4dEcx6/xLbKwMcunmWpabLfTsh8THVHt2u6D3Vjena9I1iWyAqY+zB0jP7cWiWGfr5YfFbo3IbGMMgi4ctf/kk2v7BEkfUx/sMwlGf6kGI8C7SV9Ni7+MMiefP4JmfPFggIQ47MjEIJT+ecT58g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZAwvS1bM; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZAwvS1bM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIStR4tr/JjX58JGu+OudFnx/7OrQZxWyse9/V3+gPkT1ZmIJLCbuNsZePWy1b12Qa39NCkJr/Dt1/qJF/R83aRLJH2pNyhPMLbKSmSwBEKEq16INciQv8P6ipPpc6VKinLm88gl/L3J+WPEIuETbUnlOL4s1VvOPWLERNH8V6V491/yS13Wy8+zlwarDttJGnan1Ba9xLhclNMbOSiDpfzMx54jeaWcqWXZcgA+prQBqMTQujMz0a+N73bG2BxhVJOBv4omUNNY/t171n36sor6Rp9SjCU7gwA082EjkAWGPUDZzYLqxs0DMVQMDYCfHSP06Obl4FdvLHsrUcMsOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI7hfxx4xdVusRZ9Vg+gVsQAvKxEbnzuueppyHbUVu8=;
 b=G38CRQ8wQbNhTa+GR6kMAyqsYe5F/hqIaLCZVo9J562wWDT1OL6A+CTR+9KietpmhzLJcIlbI7HZQpBf2/O43BJv2o+2FEZZQxpeYwbAldfNdWbsmc7AsUPDfCjeqTyC7b1IKFIZ5JAFslcDRNkNlA8m/iDRuy9vL8xyNkc60NAW0F03yrZqe1dHCnpj6hJfxfi0BCSwKSHZVwHYh2gdAipZ4cExqnOQhHR0YzTWndDfKXylSy43BjizcI8ooF3KdoXf8w5EIghqgNaXePNqBuQ9lf2i9HCGnQiaF2WenZ8bBGWBh17RPUHLoxPiS+L5Z52jndURpfVDVBM4FztJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI7hfxx4xdVusRZ9Vg+gVsQAvKxEbnzuueppyHbUVu8=;
 b=ZAwvS1bM511xjPUWVYGrpeD7lsk8pK051003F5Inmt1EjxGM4E6J73yK3eqswC9WEbT9IvAxyjxqsJvfa7gG8gRAsqYsnJYmhQEsHPH9SGp2nR0lDE7TOg9Yje/h/7ca1HibcCnEl1qPPrv81X3yCAIArzbS/dIopO4qlAn44YabyAqACv58a0wApSjmAV2E5iYvG6PcWQUdALNNKEkoy72491NRue//LlvGjEnQa2P3AZZRFrgPBV/SjxaW5CPawzgr9sMOuhvxQVMSsF81X/jOR9stTrXlqi8IdCWB7mFXMouq3p3co7/7dLkVCoWYwCTXROmQIs6FSbbQDaVsAw==
Received: from SJ0PR05CA0133.namprd05.prod.outlook.com (2603:10b6:a03:33d::18)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 15:39:14 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:33d:cafe::43) by SJ0PR05CA0133.outlook.office365.com
 (2603:10b6:a03:33d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Thu,
 16 Jul 2026 15:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 15:39:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:45 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Jul 2026 08:38:40 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <saket.dumbre@intel.com>, <lenb@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 2/3] ACPI: CPPC: Add u64 wrappers for the autonomous selection register
Date: Thu, 16 Jul 2026 21:08:19 +0530
Message-ID: <20260716153820.2007095-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716153820.2007095-1-sumitg@nvidia.com>
References: <20260716153820.2007095-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: fe87c0c5-019f-497f-1e3a-08dee3506323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|23010399003|1800799024|921020|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	n0WcQl2xC0XI5KzkTasX/7QTubz8cix9t5rbEfI0UgqNzRNtu7ekosfn7TlqgOKJgaloPQCcOb4LTBm6n0FFhPdPXxb0EusnghULs7EcRJ3xapY9MnTfUOSeiHYFSIYI4tsWjzzcJ4bXckLqJMXYzW0WD/DSp21qYgYDzUmWJbw7G/KD+vPHYiks62sSyMXHr17EVr3AGMLhEBGIgiIENDKsPcNQsbJHC37MqhqN4oaEyHMq0stp9aiTCxg5UBrU8xsRXTIqXX97Li1keXBLZ+sf8YyL1Kt2XEBphNVpr8CAinGjzqIp8BgiNbH7g+iw+ftsIsDJxR/UI8JXtQpqHTCrEfheWq5htspIIm5H/giM/Lp5kW5rz/JzLlEa1gGkQtBJJbOItHzi8kprmrnU5bPQef7ITsN8t7/nJYXzEJRSMQj6BI8V/DFhNEtUoZ4jylIWqSkQLWq6BY8n69yrNWfjYB6cLsdtuzzMKGtBWr9pI5oqCWIkWjzkv9F7/xNBr0nMsZFu2bbyunk4QpdLcnHb+ULur+3ADuUPN4sN5i4VrelT/WxqKYM3PtxXysS5XIyIgTLo/okp7aDR8oIqnxLaAYMChFl8Nc3qqMkRpL1LcEuSbWkd3E2hX2vJNzwa5i/7QM/ff2BPNjQ/SVR4tVhKNEbBlyTQe4oFg1u5i0uH7QLEIOOAgaFQQFWfm7KtJCn5Pank9VABH+l6DEtUHowhlC94bMvQgmx0vFYk2eS+HuNrtaZ7dGWJ+AKEqEEV
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(23010399003)(1800799024)(921020)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NoAizYaF1YPBUgaVjnW6V/ip3XpE74zpnzp3hcJMQEThHs389L0G7jzRcYfdJi3Z3WUw40JSVUEjtHRvBpMW1G4MB8MWPIwvmVEvuPKmfC0ZogPR1tgeh1wnLAwc65vaScZGOefHFS34eiHpf8nSdy6FFvgoXvJ4B44f0qr9iOI3TzJYtQYxXY44jWth7Zzjf5/RU4ZyT53F/LlFWIvLPFwspLMFdt2no2N/GXzHqkNw9DxIShw57GHe831c9C+bGyZ7ZWvO7zm/E4jV9sq30QynCAX86X5G37reXeKdYeGfvJ/puY1S3kBbISKOpIA48tD/oQuncm2AxqXqiJvysYzQNSl2cm3vKgsAYuroa/z7CkEgzkaCvVyKtsICDgihHikWQJZPjrH+9YuX9Iqx+lXhabFJ7lJzSHGR+G9u1vddTVdWbXmXx8ydlItZGHcf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:39:13.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe87c0c5-019f-497f-1e3a-08dee3506323
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620

cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
CPPC register get/set helpers which use a u64.

The next patch in this series saves and restores the OSPM-set registers
across CPU hotplug using a common table of get/set helpers typed as
int (*)(int, u64 *) and int (*)(int, u64), which the bool autonomous
selection helpers do not fit.

Add cppc_get_auto_sel_u64()/cppc_set_auto_sel_u64() wrappers with the u64
signature so the autonomous selection register fits alongside the others.

Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/acpi/cppc_acpi.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h | 10 ++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 9f572f481241..a7fec6c93178 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1788,6 +1788,46 @@ int cppc_set_auto_sel(int cpu, bool enable)
 }
 EXPORT_SYMBOL_GPL(cppc_set_auto_sel);
 
+/**
+ * cppc_get_auto_sel_u64 - Read the autonomous selection register as a u64.
+ * @cpu: CPU from which to read the register.
+ * @val: Return address, set to 0 or 1.
+ *
+ * u64-typed wrapper around cppc_get_auto_sel() for callers that keep CPPC
+ * register accessors in a common table.
+ *
+ * Return: 0 for success, -ERRNO otherwise.
+ */
+int cppc_get_auto_sel_u64(int cpu, u64 *val)
+{
+	bool enable;
+	int ret;
+
+	ret = cppc_get_auto_sel(cpu, &enable);
+	if (ret)
+		return ret;
+
+	*val = enable;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_auto_sel_u64);
+
+/**
+ * cppc_set_auto_sel_u64 - Write the autonomous selection register from a u64.
+ * @cpu: CPU to which to write the register.
+ * @val: Value to write, any non-zero value enables autonomous selection.
+ *
+ * u64-typed wrapper around cppc_set_auto_sel().
+ *
+ * Return: 0 for success, -ERRNO otherwise.
+ */
+int cppc_set_auto_sel_u64(int cpu, u64 val)
+{
+	return cppc_set_auto_sel(cpu, !!val);
+}
+EXPORT_SYMBOL_GPL(cppc_set_auto_sel_u64);
+
 /**
  * cppc_set_enable - Set to enable CPPC on the processor by writing the
  * Continuous Performance Control package EnableRegister field.
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 8693890a7275..cd07e1e92bf4 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -184,6 +184,8 @@ extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
 extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
 extern int cppc_get_auto_sel(int cpu, bool *enable);
 extern int cppc_set_auto_sel(int cpu, bool enable);
+extern int cppc_get_auto_sel_u64(int cpu, u64 *val);
+extern int cppc_set_auto_sel_u64(int cpu, u64 val);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
@@ -282,6 +284,14 @@ static inline int cppc_set_auto_sel(int cpu, bool enable)
 {
 	return -EOPNOTSUPP;
 }
+static inline int cppc_get_auto_sel_u64(int cpu, u64 *val)
+{
+	return -EOPNOTSUPP;
+}
+static inline int cppc_set_auto_sel_u64(int cpu, u64 val)
+{
+	return -EOPNOTSUPP;
+}
 static inline int cppc_get_perf_limited(int cpu, u64 *perf_limited)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

