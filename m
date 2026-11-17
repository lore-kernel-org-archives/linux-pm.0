Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930704;
	b=qQMJa4EqOa1Ec2ecT+Ykcolz+jE7Ten18n6an4+4qofV9eSGQDG37301B2C0D8cykhMi
	 2buoL0OYk71nmQ7pOlZyPbNJr92zck7vjNKgKxrtZIHAnKb6gjyy9xx8NJB4PkktHxjq7
	 i3qeNeDb45Lt+wKUOq/sKMSvVaUtUHRD24/KXWyur6P6rNeN54cwXrwJIKQ0PcPm9UwNZ
	 K49cTUX18sR9/MsQvtx6bHSqvxa6DCqF+ICqVyC8A7JySzGXXFIIiSgcKnUxq9DyTJt3/
	 JtBHdd5v2z0RnlrWRCvb9jLPkog/BuDyQ6GBG8F8TGlcs+blZJFbxTcEV1HQjfPJajg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930704;
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
	bh=p2zPqy6SH6U6PkMWGT2bfwFYhIC80bkGSZHeb0Kd8EE=;
	b=L/1Ju8zs+rJZcvRuK2eD/t2pG14fegHBLG0+DRWIzdvIbJgDN0/OClItZjLtv9ztRqDv
	 JmlKhgAlW3/6UWqJ/RXLeGm/vkim9lngZHDN9toZddrL+7tYI0mLAbSpza51N1J/Ou8Mg
	 2llwK95LWxBpZHb6onlNlzgYUu0IFTyFp22hRNDyGfWKLblUpRc1S14NYAX/POKO7fLn+
	 3r/Kd34ik4DpZZoYI/xKqqhBNp4POpIBBX3XwHb4RaxcA+cVteXhA6b5DPPbrW5zsWe6t
	 tSXl+iAi5YjNUoMnAs9zxUJU2QseYMxmLt78c9/K1fu1nhkPAJD8MUqPMHnoat/eFRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mBwQc9Mw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.56
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC5606A31C;
	Tue, 17 Nov 2026 15:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EFC5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mBwQc9Mw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+e1LIQsR/3//qWRtRfbkMfGgjnbaBVHX00DVgiN1O296OWKSYWt259eX/pGoYO/nNy7EKtS72CjroRBIIV9BgIoU/RSNS5OolfoHFH91Ij4HEz/kmd1ZisFabNW+6m2+chfybk4VGO0h8pYNp+gWh7/g9fdCut89iH8GlJEzybqpfv+ksmaXymogwiTvsQGnI502ah/exjoiUU6nEjoHZxwuO3pIf3yuM20GTJsW5z0N8vHLYdhriVOhWny4Js8MTpn2TJE+bD5e5M65c4l79f3f2yJinlqlKnbuDpUhyPmzRKXxr1fRCqLarzD6yW1HBFcluaYsX0ZU2ifOzJLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2zPqy6SH6U6PkMWGT2bfwFYhIC80bkGSZHeb0Kd8EE=;
 b=U5WE+chaxG1rtnLkuFyPBQRV2fhMdR6DlC/ObWdA9Jnt3+6F3uuSsvJ8GQVOZfA1QfRKLYy81UpI27G0KUDGGuBljw7cV7qPDPsAQQ9BKGrPZO+lg7Yf/VCJhPVma09JXBEnzTUxN1553UHGbA/ysIZVRtCcmifvkZ2ILIcaYDECbRnVkqc8a0HYk6fQwyQ6ny2pkaKftC+TE8BJM7goZNSO8WIDTkPODdIl+p5xyF3B+1lSIWDoTsBSUFecoSUB50HMtgQv+fhCZ2wJMMUUrI5YZT265myFk3CYbL8paT7ztFJnGGijrqr02XWwx1niYkEBJBDhngBRR8gffgBwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2zPqy6SH6U6PkMWGT2bfwFYhIC80bkGSZHeb0Kd8EE=;
 b=mBwQc9MwLLQ2vZjf/Gbo7eUZ7vrcpmLqOn7G2Gux8fZ5p3qbiLIvn5q3DTfcyF/teyzxeQMQ/+8ip2H3GG405QjYDwpcmnFNbLmqAjOX+n0goER2VzXMf9wLbZSxuveMgt6VVhXeabLlH2PlLm4rJ62r6vtVj0f4hvUq7JR8NA6zGHudsUtr7S4rfuSE9HBvb2gQS8qGZL5iRZd3E+9mGyImofmaouQbwPESkdUXKX7SwD/ZvPzGMAuoxF3zxmeU6siAfZpcUGj1576MIwqLX7YVr28gt84EKy9soLDDuwBDELImryFxp9N+1luTUlqgBjvnCtyj92CT7Fqnt6DMCQ==
Received: from BL1PR13CA0179.namprd13.prod.outlook.com (2603:10b6:208:2bd::34)
 by DM4PR12MB9071.namprd12.prod.outlook.com (2603:10b6:8:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:51:35 +0000
Received: from BN6PEPF00000073.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::70) by BL1PR13CA0179.outlook.office365.com
 (2603:10b6:208:2bd::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Tue, 17
 Nov 2026 15:51:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN6PEPF00000073.mail.protection.outlook.com (10.167.248.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:51:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:51:07 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:51:07 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:51:03 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 8/9] cpufreq: tegra194: Add support for Tegra264
Date: Tue, 17 Nov 2026 21:19:53 +0530
Message-ID: <20261117154954.625126-9-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000073:EE_|DM4PR12MB9071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f509dc2-b230-4e02-3f26-08df44c2a88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|7416014|1800799024|18002099003|22082099003|6133799003|921020|56012099006|11063799006|261026140227099003|261022075727099003|261028144727099003|261022105027099003|10067099003|261026121527099003|261102123227099003|261009223027099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	vHNrCgDIPzT+62xNmLI4+x7cVHF3+RzOD1WtXwU080fvMS7FYzpEBz8AUX5pXek+1UudQ2h2dDgb/ka44SLVwqvWftlT0cESJctmStbb4efgF7qewYVLcHvBWQ1pncv+6Xl5y6tkf6Yyd1Mb7xy2nrekv+mzqWFOQHG1dQhn8k0Vu5WawUN70ooBauWzbNiI6E9/ImJ5d0UnvenhuzLiZpXABj69suSvav7dYQMRvYQHCqqAa916gCsMMqM9BlGBzbtkNKJunyNSbV0rdA9pYF9orX7cdsNcaMP/6yKEueSGQNhTb80WrNr/4BmPOLUhlcQ5DGyy37Y2YqKeuwH9or1SChdM6J7mf+vPs5A2pKokbHdPJOLph+KdXrORbNgRXbR5IPGLu4QPdOlNWjEwU8PeheeoUjWlMEMKmnvTr6TPzsSh1gCxD5cZqSnmp+4irvMkFyy65yBYjzKiucpTm8X2D5N4WipajbKqggATIykk7GKYBc/gGddlN9x0TjE7ieQDZmSn+t2p72ldUT99cnL0arpJEcXmuKYhmJ8DAbSLC6S/9OuooChThrx0KMDjpPX20ZIXNRTaOQ840aj1QJdreob9l6w/AMbEPsnlI9s3f/gYGD4q9wbztjFXsCyWmQ8mXuUOFepUO0CJPWXwLGSufUL19eGhjWl3R6RdM7JyDcu3QEC2RMRQG0im0i7bZ+fdUcWXBzviKgEInHouLf3inPloE9lr9LKvQuOd2OgOtVgHjIkFRpJjuR2NnX9f
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(6133799003)(921020)(56012099006)(11063799006)(261026140227099003)(261022075727099003)(261028144727099003)(261022105027099003)(10067099003)(261026121527099003)(261102123227099003)(261009223027099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jzBdOb32qTWT78lXngHmd/Hs9clOWsIALqmro/5evy7V0lbUjHw4d5dzykB3NcgwjyMRjfGmY8dqK8xu5PKHvn9uyDJe8LRMlQYdrbLQzb1bE+g2MzazS56LFM5z9BZPxBWWm0KuqhPT1zpExkIJdDEZLe5IIqDwyXXXDHxkyo/0QrKZA1U0Bv9n6KNkJgYkSgxfj11xa946fDCypovyx7RAIx/V2iviUF7+Hp0XFHFp/9VuM0+CCqKLzGE7MDmdpGBDU05VmyPEW3JLIscl1xcndU3Kz7h2P7YO2yRvMkof53P90yaSFyNSkxLnfAdC8E6IBPNgNOJEIUZT+DT1icRzXLnMvWmx8OrCNPnPLBnlX+EJaxxpoH1outAeTVs41S2vxGq2Bvd/i2/kgoeLAyVl9isY4IpEHwO/Ky/AO6kCiLAqAmAa+B7tXUEIErth
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:51:35.0184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f509dc2-b230-4e02-3f26-08df44c2a88b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9071

Add cpufreq support for Tegra264. It requests and reads the CPU
frequency differently from earlier SoCs.

To request a frequency, the driver writes NDIV to a core_freq_req
register in the CCPLEX register space. Two clusters share a clock and
its register, so they always run at the same frequency. The driver
exposes each pair as one performance domain and one cpufreq policy.
Each CPU's "performance-domains" property gives the domain index, which
selects the register. If the CCPLEX node declares
"#performance-domain-cells", probe fails if any CPU lacks the property.

To read the frequency, the driver samples the per-CPU 64-bit AMU
counters through system registers. The AMU constant counter is the
reference. It ticks at the system counter rate, so the driver takes the
reference rate from CNTFRQ instead of the fixed 408 MHz clock. Probe
fails if CONFIG_ARM64_AMU_EXTN is disabled or a CPU lacks AMU.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/Kconfig.arm        |   4 +-
 drivers/cpufreq/tegra194-cpufreq.c | 161 ++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index a441668f9e0c..a5482b12be57 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -248,9 +248,9 @@ config ARM_TEGRA186_CPUFREQ
 
 config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
-	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || ARCH_TEGRA_264_SOC
 	depends on TEGRA_BPMP
-	default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC
+	default ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || ARCH_TEGRA_264_SOC
 	help
 	  This adds CPU frequency driver support for Tegra194 SOCs.
 
diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index fb95ddd66966..ddfb42231eaa 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cpufeature.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuhotplug.h>
 #include <linux/dma-mapping.h>
@@ -14,7 +15,9 @@
 #include <linux/slab.h>
 #include <linux/units.h>
 
+#include <asm/arch_timer.h>
 #include <asm/cputype.h>
+#include <asm/sysreg.h>
 
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
@@ -36,6 +39,18 @@
 			(data->regs + (MMCRAB_CLUSTER_BASE(cl) + data->soc->actmon_cntr_base))
 #define CORE_ACTMON_CNTR_REG(data, cl, cpu)	(CLUSTER_ACTMON_BASE(data, cl) + CORE_OFFSET(cpu))
 
+/*
+ * Tegra264 requests a frequency by writing the NDIV to a core_freq_req
+ * register in the CCPLEX register space.
+ *
+ * Two clusters that share a clock form a performance domain.
+ * Each domain has one core_freq_req register. The registers are grouped
+ * in blocks, two domains per block.
+ */
+#define T264_CORE_FREQ_REQ_BLOCK_SIZE		0x400000
+#define T264_CORE_FREQ_REQ_BLOCK_DOMAIN0_OFFSET	0x40000
+#define T264_CORE_FREQ_REQ_BLOCK_DOMAIN1_OFFSET	0x50000
+
 /* cpufreq transisition latency */
 #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
 
@@ -70,6 +85,8 @@ struct tegra_cpufreq_ops {
 struct tegra_cpufreq_soc {
 	struct tegra_cpufreq_ops *ops;
 	u64 cnt_mask;
+	/* AMU's constant counter ticks at the system counter rate. */
+	bool ref_clk_from_cntfrq;
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
 	bool needs_mmio;
@@ -79,8 +96,10 @@ struct tegra_cpufreq_soc {
 
 struct tegra194_cpufreq_data {
 	void __iomem *regs;
+	resource_size_t regs_size;
 	struct cpufreq_frequency_table **bpmp_luts;
 	const struct tegra_cpufreq_soc *soc;
+	u32 ref_clk_mhz;
 	bool icc_dram_bw_scaling;
 	struct tegra_cpu_data *cpu_data;
 	enum cpuhp_state cpuhp_state;
@@ -241,6 +260,78 @@ static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.refclk_delta_min = 16000,
 };
 
+static void __iomem *tegra264_core_freq_req_reg(struct tegra194_cpufreq_data *data,
+						u32 clkid)
+{
+	u64 offset = (u64)(clkid / 2) * T264_CORE_FREQ_REQ_BLOCK_SIZE;
+
+	offset += (clkid % 2) ? T264_CORE_FREQ_REQ_BLOCK_DOMAIN1_OFFSET :
+				T264_CORE_FREQ_REQ_BLOCK_DOMAIN0_OFFSET;
+
+	/*
+	 * clkid comes from the device tree. Reject an index whose 32-bit
+	 * register does not fit in the mapped region.
+	 */
+	if (offset + sizeof(u32) > data->regs_size)
+		return NULL;
+
+	return data->regs + offset;
+}
+
+static int tegra264_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	u32 clkid = data->cpu_data[cpu].clkid;
+	void __iomem *reg;
+
+	reg = tegra264_core_freq_req_reg(data, clkid);
+	if (!reg)
+		return -EINVAL;
+
+	*ndiv = readl(reg) & NDIV_MASK;
+
+	return 0;
+}
+
+static void tegra264_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
+{
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	u32 clkid = data->cpu_data[policy->cpu].clkid;
+	void __iomem *reg;
+
+	reg = tegra264_core_freq_req_reg(data, clkid);
+	if (reg)
+		writel(ndiv, reg);
+}
+
+/*
+ * The AMU counters are per-CPU system registers, so this must run on the CPU
+ * it samples. tegra194_calculate_speed() queues it there with queue_work_on().
+ */
+static void tegra264_sample_counters(struct tegra194_cpufreq_data *data,
+				     struct tegra_cpu_ctr *c)
+{
+	c->coreclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
+	c->refclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
+}
+
+static struct tegra_cpufreq_ops tegra264_cpufreq_ops = {
+	.sample_counters = tegra264_sample_counters,
+	.get_cpu_cluster_id = tegra234_get_cpu_cluster_id,
+	.get_cpu_ndiv = tegra264_get_cpu_ndiv,
+	.set_cpu_ndiv = tegra264_set_cpu_ndiv,
+};
+
+static const struct tegra_cpufreq_soc tegra264_cpufreq_soc = {
+	.ops = &tegra264_cpufreq_ops,
+	.cnt_mask = U64_MAX,
+	.ref_clk_from_cntfrq = true,
+	.needs_mmio = true,
+	.maxcpus_per_cluster = 1,
+	.num_clusters = 14,
+	.refclk_delta_min = 16000,
+};
+
 static void tegra194_get_cpu_cluster_id(u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
@@ -342,11 +433,11 @@ static void tegra_read_counters(struct work_struct *work)
  *	- Return Kcycles/second, freq in KHz
  *
  *	delta time period = x sec
- *			  = delta ref_clk_counter / (408 * 10^6) sec
+ *			  = delta ref_clk_counter / (ref_clk_mhz * 10^6) sec
  *	freq in Hz = cycles/sec
  *		   = (delta cycles / x sec
- *		   = (delta cycles * 408 * 10^6) / delta ref_clk_counter
- *	in KHz	   = (delta cycles * 408 * 10^3) / delta ref_clk_counter
+ *		   = (delta cycles * ref_clk_mhz * 10^6) / delta ref_clk_counter
+ *	in KHz	   = (delta cycles * ref_clk_mhz * 10^3) / delta ref_clk_counter
  *
  * @cpu - logical cpu whose freq to be updated
  * Returns freq in KHz on success, 0 if cpu is offline
@@ -380,7 +471,7 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
 		return 0;
 	}
-	rate_mhz = delta_ccnt * REF_CLK_MHZ / delta_refcnt;
+	rate_mhz = delta_ccnt * data->ref_clk_mhz / delta_refcnt;
 
 	return (rate_mhz * KHZ); /* in KHz */
 }
@@ -741,6 +832,42 @@ tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpm
 	return freq_table;
 }
 
+/*
+ * When the CCPLEX provides performance domains, the domain index selects the
+ * frequency request register. A CPU without "performance-domains" would fall
+ * back to domain 0, so require the property on every CPU.
+ */
+static int tegra_cpufreq_check_perf_domains(struct device *dev)
+{
+	struct device_node *np;
+	unsigned int cpu;
+	bool found;
+
+	if (!of_property_present(dev->of_node, "#performance-domain-cells"))
+		return 0;
+
+	for_each_possible_cpu(cpu) {
+		np = of_cpu_device_node_get(cpu);
+		found = of_property_present(np, "performance-domains");
+		of_node_put(np);
+
+		if (!found) {
+			dev_err(dev, "cpu%u: missing performance-domains\n", cpu);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static bool tegra_cpufreq_amu_present(void)
+{
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+	return IS_ENABLED(CONFIG_ARM64_AMU_EXTN) &&
+	       cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_EL1_AMU_SHIFT);
+}
+
 static int tegra194_cpufreq_probe(struct platform_device *pdev)
 {
 	const struct tegra_cpufreq_soc *soc;
@@ -763,15 +890,38 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (soc->ref_clk_from_cntfrq) {
+		if (!tegra_cpufreq_amu_present()) {
+			dev_err(&pdev->dev, "AMU not available\n");
+			return -ENODEV;
+		}
+		data->ref_clk_mhz = arch_timer_get_cntfrq() / HZ_PER_MHZ;
+	} else {
+		data->ref_clk_mhz = REF_CLK_MHZ;
+	}
+
+	if (!data->ref_clk_mhz) {
+		dev_err(&pdev->dev, "invalid reference clock rate\n");
+		return -EINVAL;
+	}
+
+	err = tegra_cpufreq_check_perf_domains(&pdev->dev);
+	if (err)
+		return err;
+
 	data->bpmp_luts = devm_kzalloc_objs(&pdev->dev, *data->bpmp_luts,
 					    data->soc->num_clusters);
 	if (!data->bpmp_luts)
 		return -ENOMEM;
 
 	if (soc->needs_mmio) {
-		data->regs = devm_platform_ioremap_resource(pdev, 0);
+		struct resource *res;
+
+		data->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(data->regs))
 			return PTR_ERR(data->regs);
+
+		data->regs_size = resource_size(res);
 	}
 
 	if (nr_cpu_ids > data->soc->num_clusters *
@@ -870,6 +1020,7 @@ static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
 	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
 	{ .compatible = "nvidia,tegra238-ccplex-cluster", .data = &tegra238_cpufreq_soc },
+	{ .compatible = "nvidia,tegra264-ccplex-cluster", .data = &tegra264_cpufreq_soc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
-- 
2.34.1

