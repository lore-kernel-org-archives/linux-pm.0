Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086842;
	b=QRuZz0qKwT47LKVzd2I8lQRXbqwRJDSaSCP512DkZBDk8kOtmWCJSFeHMnir1PCzG5EU
	 lCihVKYjxR+e9f9h1OViKdF90ReOq+hMDnyvnam6JWV0nJYaRtq9ZFfe9H28uXOmKMa/O
	 AHletzC0JMjrjBCYgbESRXQOFirCT85n/GgPffLj6kXaVFETyUTM2FgTlO0UGA1JcGlcH
	 iNGrNzyF7zfTgM6lbfhLeBF1L+m1V41Wxk6jn5vaS4fuxhAvzQgUSc8CGYXh2NM9wikXN
	 /JkajVLs8VqKCLr81vsZyH4SFesrPQmeQ8hrw6dLiLpa67YpcpQPIxguFA6Icqae0EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086842;
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
	bh=Sqt3Nlln4mx6T+bv5kAjO4Y5kp6x4oV5pG5EEXcLYVI=;
	b=4m9O3n+te2Hnu2vQAg16JMzOrwUK2TCUN2TA552tz6dq/Q046/fWNZL8w1Ym9v7Nqh3D
	 4EnmhvhYFg+j8sPZzmpyGrRJdIVSfr478in8h7zcitEOyKesksYxrr/YQtN6qG8a5W2TY
	 i5Adi3qaC546+W/+BFN0K+JCSW8j5vq6zMhLqkgcL8+UW8ulxYcpBRuIu7QsJQZEGmwDQ
	 80EhX95yldpioL/O39kYB37RZ9fwaiEy1Jg/yLXMELs45xGP2UoqmDjapNi5EzTBUU8eT
	 OFKnCL3gvGAJuxlZItIey43lqnBJEwmADOVrM1oi1WS/jYj7AWsIH/YiIK33UfO6dWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HsyUMU2J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.42
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5E606A320;
	Thu, 19 Nov 2026 11:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD5E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HsyUMU2J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/QjjF85AnJFIFinojBWjCVzomJCDeK8eoZJpwFjExfgz3l+o1QX9rb01FoJBBdjZcAEuXkffIpAdT+6braiEBLxTUz1KLv+UBytMTnGXy6H26Oq5G4QNr/e4xxwEqz5SaocNZ2JDmAx/gsseZgeUHP5QJo/JH7HquocKW7HNNyWF3SRA7wJLsXF4LpPH0pe89FUw5J+ox38CqqeQ+rvaW63uTjwwfItv6fVsWkIiTF7DnGRb8k5K6tTplcQ1vf2tvtBkGLPSTRt/NdzWXvhkjLHGjtJSMW+V25V7rvDSX9ypSPY64YFYWT1fVFj07IrlHaoZETZ9y//K/vmhJPYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sqt3Nlln4mx6T+bv5kAjO4Y5kp6x4oV5pG5EEXcLYVI=;
 b=a+TopTHWs0XYr+yr6/PmqZ9/geMLJilecdVI934IPD3hwZxRwtBmwWtx1cxNP13f4I55wl4TsR+BQiGq8PRX3pdRz+/1DN9KILSy9+kVFYysQ/FB7oBlOIe59M2qA338cAyQ7Qpaz7bjBjK1qiuk0dWyYpEhbMRGN6GRJrVE952MvLtHTn/7Dvdpe+O+5IFhQHSxsMfcsnEM40ecpPc48vuL4SWbvRYwsWB6pw3ST70yH0IaTy6DVOybdAV0DZ0jS9dq45n9UBAXYP6b0cK5xgJ4rRsuumA7o1RFMCy2OvV0Prbt1bppS6wmHDB1V+0jWT/iOJJa548VE67bKyF51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sqt3Nlln4mx6T+bv5kAjO4Y5kp6x4oV5pG5EEXcLYVI=;
 b=HsyUMU2JKwd3SUVKXf22eJZRvOzlwcIrt1Y6w32z6WLCVwqKFbIFnaAGttVMWzKRRCH2FVYV2DRCOk5MSEMskHqnXdYkZgzE6EI2mykQV8hU5iKhsKAfcGQul4YPbgNx+eMr3JQjbrcXbFcv0yunJ3dzSBB39W3m50DEHwiUDS3xzOp0ixMnWazvM7dL5XAzZy5DK4zkQiWiPg2tSKKFRsDJ0p6kg/rG4NL+XQAQGq/nfkY0KXVcW051eJiEu1KqrDqJ3XlQgRtEtgNjG9ztqrk4F1jXNqRej+OTOqZzRzEsEDyM1g/0xoR1/aBKwOc7vDWUN754NAXz+x7mpnqBWA==
Received: from DS7P220CA0108.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::14) by
 PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 11:13:24 +0000
Received: from DS4PEPF000001C5.namprd21.prod.outlook.com
 (2603:10b6:8:25d:cafe::5e) by DS7P220CA0108.outlook.office365.com
 (2603:10b6:8:25d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 11:13:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS4PEPF000001C5.mail.protection.outlook.com (10.167.23.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Thu, 19 Nov 2026 11:13:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:13:09 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 03:13:08 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:13:04 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 5/9] cpufreq: tegra194: split MMIO mapping from ACTMON offset
Date: Thu, 19 Nov 2026 16:42:13 +0530
Message-ID: <20261119111217.902071-6-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119111217.902071-1-sumitg@nvidia.com>
References: <20261119111217.902071-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C5:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: cda82419-4053-48a1-5c00-08df462e20ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|22082099003|18002099003|261009223027099003|921020|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QCogr7OM/Kl9iOki1zZYOw+Mj72gXdnyGhgTXaoYeLcKSKLJBjanyLz9Lz2SdhnCsw0MtByFhle6Cv5d8FaGMIuo0e7lIatFHTTrUjSQ7zz4Xgug/Uul6JfhQqbVGHBh1905C9z+UVhVG9xfRf2usCMfKcjgTljTfum+1/qAF0q5EURSoY5xWta0bijgT4oxnctpuJm+fN68KOD3crU1dOjD16r4pVbiOe7IdmkDhmIPokRuepk1EvpqrjMdTrSJIJ9r+H/JDlypzxGW27/BVuwqEzjCs5nM/NgmcWrjxpPy7ZOXo/79mEI+UTNdOoewV9mibV5aIYn+8/6eewn6frz07mNzyCMwhWkEqjmOn1V0BL9rkQxCr2klPqpWCOcjSgDOxLDutcn224yCmelqv/F44gGOWUCKfjICg7wYu2nilVeDJRJOGUix4bp/PkdeRUKLLIiLcCE7U1VtO5Y+inI3RskiMluje85O1mXE6fj+CaerKrL95xrJ5Fox964gY6XQgsxjRFgIJDFQV2eOxz8VikenGy0XSPb15GxmHPNe3oUqxriLB+7L/SYfQh/eAVQGFXwY2l6/9X5xB7E82houx5OPlk0Hm0akqDKiW8nOlaKtfGtJOIqZn7zwrV8HAcNeuzrT1cb1Alti3xVOBsBjcuJ5G1AgqOiLnxth1JyrFFEvFqaxMUWgrs6xk/iw7UtHHtDDL6b12T+w8WjtQCellixCRH9lC+x/vQd7bQFRSvDZP31b3aw3+upeFL8Z
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(22082099003)(18002099003)(261009223027099003)(921020)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qZyN0lrQiVUH3G3k7zJWXfq1bpUIkJq0msd5gAi+EsfC3hWw44GamWYkj9juwuUXJYUO33DQSrArHGsbCa5AkXKmLpTRZ/zGaXY8SLd/6hC4R/Lv7HrkUJpztvLtyVmyMGwPFr5Asq55sdf18amhEEZElmlN5HIjrpt+iStnKrstFdIO1PrQSijOU/gUmFrgANhI6o/rzOS+B1/Klas8RzszuG1dGP/cy/R3lPqQUapcvyV6adZqCySo0187/SeHA3vnqjSYoIObKdphgKi7ZvRe+yH+X+R/IuT7+M3PejeU3FWfzZZNdBMkBwyJI4tktqCL884lVo6fe5r26bKF+/aOYVbtHFSjj6mTYaPkTateoT/0YtrZlvj/Nz7ahzRA50AaNQ7rEQcFt5DKciA8ieqawvVaRf0MqZHsMB1Yx+9rrH9q+Q6Dzcs60661pTZf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:13:24.4595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cda82419-4053-48a1-5c00-08df462e20ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001C5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738

Probe maps the CCPLEX registers only when actmon_cntr_base is set. This
has worked so far because each SoC uses one interface for both
requesting and reading frequency. Tegra234/238 use MMIO, and Tegra194
uses system registers.

Tegra264 requests frequency through MMIO but reads its counters from
system registers. It needs the mapping but has no ACTMON counters.

Add a needs_mmio flag so the mapping no longer depends on
actmon_cntr_base.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 1a5b78ff2c4a..e12e02d14d73 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -71,6 +71,7 @@ struct tegra_cpufreq_soc {
 	u64 cnt_mask;
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
+	bool needs_mmio;
 	phys_addr_t actmon_cntr_base;
 	u32 refclk_delta_min;
 };
@@ -222,6 +223,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
 static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.cnt_mask = U32_MAX,
+	.needs_mmio = true,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
@@ -231,6 +233,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.cnt_mask = U32_MAX,
+	.needs_mmio = true,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
@@ -739,8 +742,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (!data->bpmp_luts)
 		return -ENOMEM;
 
-	if (soc->actmon_cntr_base) {
-		/* mmio registers are used for frequency request and re-construction */
+	if (soc->needs_mmio) {
 		data->regs = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(data->regs))
 			return PTR_ERR(data->regs);
-- 
2.34.1

