Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930668;
	b=U22XtYmCU0/edgCggOUNiIN2tdc90jOb7AsADFDw8ghwMjOeojsONihVudvED040x9+L
	 Hks2YR8Rx0MwVkPNrV258sftbdUNJCKHMQOLkLwXTit+dlfb1yqdTJNs5ELNflX1wV8Pq
	 HNMFRsDKj6Ds4cp21kngCYELyD+E/lzt2Bsw9JkTKWIjUWjwWfaOpWIv6CZwjFOP8NM+E
	 zGTI+JbRu/jrysCfETGkze2HoA1bSCW+UmtQg/f42LQL/3vZt9CYmlSaXCnz+lDkooGnZ
	 N/kqxdV3Kix1GykDp67UeoOpMz76lmdsgvNwvaYUfwHCVrbK0t5PtJL4z2+cbpMvdiQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930668;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=F/1G5fYSX4+5CczSwEjqaHiv8/pPmShfo+WdQHc3w6o=;
	b=dbNpOhvmWuNWLqP8GjfPg+7MKi64bEfqfU7OE6Aa5QKSSh0liBd84m1T0guTGCxv1/SO
	 moRmIdWU/lELBEXJipdj9rUlcdfEDfmMjb9dYJMLzLuHBXnsJgN2HRpjSfB8TwbZMde4K
	 Gzk4G+mBwXEDOArFuvtUbnUnU+D3g3xu1XrZNLhmrpmcRBFmXxQD25oMudHNlGA4zrGY3
	 hy5zxcyXR3itYRTi7T4a96d8l9GY81jivwVXBR6f7cdhAlmNi8n09ZhySL+OC1uKyuwsk
	 UOjFmdJV7ILQyT4KYQEvUexx8fj4y4k++1P020+59uRz9m11fPMx+iJutRNm4soojwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Oe7qRCKb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.60
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27513606A32C;
	Tue, 17 Nov 2026 15:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27513606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Oe7qRCKb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZIOLs0cDiwO/GZRPyThLZE0lQUud3CdE8ru+42N/Z6tLnh5D+xoVZrHWePFyQjOOxPtfNgByfyFMxjQOsxXo48HRPXUq96OxdOb3gQT3OThLgsStAza70yBLo/Dvl01+x/aybsxVcO+aqdzUNk56uvqGFzgWwoOPWd/wSg0AB+mQE5UZxwVHjhLdZbmqDbrXce0s2w3q5wJD/X2pxpD1bxotS4ykmCh6IaofhIIPm0hsgUlHPPXaVygqC2+PRSczRT0jc135wh3f3MGhEqSijfd6udZe2AL2YSn+M0zk93nU4RKO2v2mH4+Li75QYmSfkzfplWALk5PEOEcfHn4B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/1G5fYSX4+5CczSwEjqaHiv8/pPmShfo+WdQHc3w6o=;
 b=yiK4hrqVZvno26La20rWv6J2TzNPTcv9ywP4XsLgilf4oDwv+uBilx23NK+3DfPSaTtliLiD0OsrTqWNa+gFJ+ymZBSRYLKxT8x5ntTyKxyGiNuXNJEvuPXkJ1PCLijD8OOR6aCz5rMi3Jp2rUgLDISf2owx+dUIqgANOHdJfNBXBh3vnahMpKd+xXn3H5lcTyFqUeAgowqSSzofHVI6SIES5YO8P/G8Mt32iUznpjJkEDGUomPxeMpOfGKgn2n2ohpOx2TU4npGkuiOOf0BXvxig8ikDgpICjD3o9bIWiJDa0q4h5KX3ul27lnO+odn37JuxnU5AsRYTv+gxfDwrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/1G5fYSX4+5CczSwEjqaHiv8/pPmShfo+WdQHc3w6o=;
 b=Oe7qRCKb2Qp1fpVn5Wlj8O0SHayoN1DsweRyeYREi5EC4r+aI+Q5C960Sn9O8a5J1uJ1SugLvEMJghC/JmxUkRw933hyUTm3f7sU9HU82LYEqJdykJVZTWAJUPf7YEBExpAbTUdiZlbvVkKEAyKVzx1pz5wX58r2HN0hSErAF/aAyW55TP6NM2Ex2qtN1O+LdJNo+fN9/jTFHh+haSYHhQ/foWOiqNGFGJ8qCzLQm7hxVJ/W9CjJk46O7oDLaqoYPk8nrkmSjP7Wya2vI3sCjdp7azWoh3orz2VM2hDmhR56igPZqiY0SEdnphzTmyiLXyv/G2bIXNRJLfHeuUR0Ag==
Received: from MW4PR04CA0233.namprd04.prod.outlook.com (2603:10b6:303:87::28)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:51:01 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::7d) by MW4PR04CA0233.outlook.office365.com
 (2603:10b6:303:87::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 15:51:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:51:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:36 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:50:32 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 4/9] cpufreq: tegra194: add per-SoC counter mask
Date: Tue, 17 Nov 2026 21:19:49 +0530
Message-ID: <20261117154954.625126-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117154954.625126-1-sumitg@nvidia.com>
References: <20261117154954.625126-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c44ab61-1769-45e4-d2c6-08df44c29406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|22082099003|18002099003|261009223027099003|921020|56012099006|11063799006|261102123227099003|261021121427099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	aTt8qIdcGexzFpxOWTLMA0HIjBYWDP6VnigjrvlqeGb5Bdt2lvQTpRidg/wDMizG5Ic1QOEIB+o5O/im0TA/yyK5QcXsuvIrep+qTnhNydgr4gVNyTFgA/7vRPH00fJHdaRNsu55cAyM1VtEA233oKjwIeDsyV5XvYAo36UDIqwBlEXr6FWUFdGI0o8VNmFJBKBrPCZhmZFzLFJHUhYib/TpvUNOPBp+PVGB+uNA3iEYGPxIQkGiiLEXuKurZfRIjrNAhXJw+rQTodMKriQ3CzMTcsG+xocsvafzzRBcxvmxWKplVRIHQY1f/mKCxFgpt/N+eox4t8BmkEYBQhRs+W4rcESyqwoP5Zxk9RpvHrrKS6ffplMBY3RPlPYEMVlJQh2cvSNIPfLPolj9229bSsV8PFq2u88A+lhEP85/ClSz6KmhI5X1Mr4QECm9F2lzOERmR1i3WoT8x5q7Guzxm67SjRH4QlZMd38w3YqO3CACHskeSSfQwliJlRZjXjanJxLJEJGOEbTBDuNvwhwU5QtVKZEQcnkfbawUJb++5df/hsdl1QCuK8JYYPNCogZu+17oP4vrSyvdMT5IytWCvm7B37euNlW7OuHugKkIHKiRCTlzw/5WHZSFzDEA2AqXBXcetru3Co07mhzQrdj5iW53fakjMuex1KA8aTWSvKCLoNWdvfMNzmJq9qKlDxqJyzLwGEZjSVByrYxEGp6IBRsj7jVRGwZjLkmdDffCqICVur/MC4SYfI7Jw6PbibVG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(921020)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261026121527099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OCvBINXrlYZCJO+dsiqU9kYyWfUuGeRWl+jJ5ODF8dhOAU4H4bBqYk4MbvLMOxusUptAV2XTO8FRyXoWd69ZeWFDnjJnVfiGVazGNm5hxg+Atz1mtF2wEIFR1kuLtvO13W81KAU/zYn7zMTQvJwLEre61w9Yh+463ln4vPeq4c7bHoHyCw8YeSPy/EkcAISJBDnRCUvosjcjogffKPJm/5y4T49PXQKmrCn6rH7BrCOSzN+kstcdb57RyfwRLgTozN7U3yHvePvfd5AG5Ge0k+1BU0YGvLyBvFPbxEpAd0lKAi9fbYz0GcQf6iQcKDuivlpfCofiwHV+XBXOUCBcOLBh2sIDUwdMhqjbRz9y8dgdDu/VuKyEngMP7F4abvvi7aWD1cHqinDO1Q648WqhQNqmYapsrIu7VMG8FraSl2kIN+Mb+FoNOaeI3eGyzWak
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:51:00.7429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c44ab61-1769-45e4-d2c6-08df44c29406
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967

Frequency readback handles counter wrap-around with MAX_CNT, which is
hardcoded to 32 bits. Move the counter's maximum value into the SoC
data, in preparation for adding support for Tegra264, whose AMU counters
are 64-bit.

Add cnt_mask to tegra_cpufreq_soc and set it to U32_MAX on
Tegra194/234/238, which matches MAX_CNT. Also widen tegra_cpu_ctr to
u64, so it can hold counters of either width.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index e5ad2108a670..1a5b78ff2c4a 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -22,7 +22,6 @@
 #define KHZ                     1000
 #define REF_CLK_MHZ             408 /* 408 MHz */
 #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
-#define MAX_CNT                 ~0U
 
 #define MAX_DELTA_KHZ          115200
 
@@ -48,8 +47,8 @@ struct tegra_cpu_data {
 
 struct tegra_cpu_ctr {
 	u32 cpu;
-	u32 coreclk_cnt, last_coreclk_cnt;
-	u32 refclk_cnt, last_refclk_cnt;
+	u64 coreclk_cnt, last_coreclk_cnt;
+	u64 refclk_cnt, last_refclk_cnt;
 };
 
 struct read_counters_work {
@@ -69,6 +68,7 @@ struct tegra_cpufreq_ops {
 
 struct tegra_cpufreq_soc {
 	struct tegra_cpufreq_ops *ops;
+	u64 cnt_mask;
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
 	phys_addr_t actmon_cntr_base;
@@ -221,6 +221,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
 
 static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
@@ -229,6 +230,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 
 static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
@@ -315,7 +317,7 @@ static void tegra_read_counters(struct work_struct *work)
 	do {
 		data->soc->ops->sample_counters(data, c);
 		delta_refcnt = tegra_counter_delta(c->refclk_cnt, c->last_refclk_cnt,
-						   MAX_CNT);
+						   data->soc->cnt_mask);
 		if (++cnt >= 0xFFFF) {
 			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%llu, cnt:%d\n",
 				c->cpu, delta_refcnt, cnt);
@@ -347,8 +349,10 @@ static void tegra_read_counters(struct work_struct *work)
  */
 static unsigned int tegra194_calculate_speed(u32 cpu)
 {
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work read_counters_work;
 	struct tegra_cpu_ctr c;
+	u64 cnt_mask = data->soc->cnt_mask;
 	u64 delta_refcnt;
 	u64 delta_ccnt;
 	u64 rate_mhz;
@@ -363,11 +367,11 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 	flush_work(&read_counters_work.work);
 	c = read_counters_work.c;
 
-	delta_ccnt = tegra_counter_delta(c.coreclk_cnt, c.last_coreclk_cnt, MAX_CNT);
+	delta_ccnt = tegra_counter_delta(c.coreclk_cnt, c.last_coreclk_cnt, cnt_mask);
 	if (!delta_ccnt)
 		return 0;
 
-	delta_refcnt = tegra_counter_delta(c.refclk_cnt, c.last_refclk_cnt, MAX_CNT);
+	delta_refcnt = tegra_counter_delta(c.refclk_cnt, c.last_refclk_cnt, cnt_mask);
 	if (!delta_refcnt) {
 		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
 		return 0;
@@ -626,6 +630,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
 
 static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.maxcpus_per_cluster = 2,
 	.num_clusters = 4,
 	.refclk_delta_min = 16000,
@@ -721,7 +726,8 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters && soc->refclk_delta_min) {
+	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters &&
+	    soc->refclk_delta_min && soc->cnt_mask) {
 		data->soc = soc;
 	} else {
 		dev_err(&pdev->dev, "soc data missing\n");
-- 
2.34.1

