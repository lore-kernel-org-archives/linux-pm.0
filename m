Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086963;
	b=Xxdkz7IGbHUdjNEDr90GMYyG8RLlmtj0AABVsA7VKT2HFMCnGB4gBJ3oZ7kYbj/Q5o+N
	 WCOwCZ+B9nPLrVq4lBEDeczP5H/B6Wz2/5fLRo+Sg2zCf5U0Os/W4HBOD9+LRAFmEfA7f
	 Bmq8i+/GflaPsn2TSJ/Dt4cfiUIS1x9jNNOPmUI/dxqfGlV81gw5O7avuNOJZv71y8SlL
	 Dj+1Uz4cqNZXTQ0m2L6w1yYXeT/DxWM/ZkbfrvlMZmdEd1AlZ0MmZl0YzhIBl3vIwrbb+
	 Dt6nt9Po2QU1S0q2mlEoGDWCtjJtU+TKdlBnbc11zwjexAV5vp0IcbjsRsruODDas6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086963;
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
	bh=JP/Wwvy4zJsS8akiAanZvn8glikrz0S03HVWsTYGyzc=;
	b=D79tRzxgtQx2N+NpITy2WWwXLwofbAGLN0CotA12nEsNcZI5s//UNFkRQWGJF/VgWDhq
	 IHlM/b/N7vwLhXUHaeLaL2Ne8VgW4F4uUA9zPDXAnw6f/TnHgbPSu47PmO5gVWiIZR6T7
	 uEiHrJlpfGrf5toidHDUS5mXCDEBSWD06C6km4lSzvLNliZkRgUJQYt22i0TacchUJkgZ
	 hl7caISWzHm/JovMGD8+0NnZIQneFhgmfvwpzUprqXJR9OGcVchu4Soztv+MAijo3z1vW
	 GUGbd/llVlNaaG1O6lCeF2Fgc8GaBgXnmyr3F3zrOWY2MhHRzooemlS+bnQ/0dqbiqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CcSpVQOV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.32
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010032.outbound.protection.outlook.com [40.93.198.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54266606A320;
	Thu, 19 Nov 2026 11:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54266606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CcSpVQOV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvkaMPlv6YGXTh6GD1eSVVnNILC6UtcyhAl9gJCE7FyDYhbLSz+NiMLj5hoe86LiSCzjuQjlTWh2dktXC4vCStkgYoMx6EEH9JZyWZvicgtgaVGSWJLoYwYU8bh6ymqJ/9Oa84Po7YYZQIbnIJRHWjKlleaDFYZ7b7xVTOU3CupjNdyo9/EmjrsGF0SoGlE8O0Zz0X2IGkV1qkd+K+EzEknhjz1ARlqwjR6DU1ekvdYpvILH9QBxrQ71X8rW2fdcik3/4Mpxtnl8v88zLcV8Pk749FeHT+POl0e2bxenWu5CJJqTgKemyNeBfuvNlXS90KJEeFDiOn41nN9SsmcPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP/Wwvy4zJsS8akiAanZvn8glikrz0S03HVWsTYGyzc=;
 b=mp/qKKRryGGbM4tc1DqqjwSaOlZyfsr5iz65QxZfaZw1/s0Tdb1wxN0Ks+NiVOnjmhkyFnV6H6r2GcDO5X+MJnFbOSPD5vj1dPbokKHJAOGfrhoCyA/6tNnAgbrCjgrhDGJTMGQ/Fo+C3pNj0GJKzRkRSgixGWefQb1yW65cqs5JYXvKYaiJCs4Qt7kVHK2uePPBdoGt4ftI93ihoHg/4gnGceC8bsuXQsAXLnjNJEcgNiJoKoxIyl3U44m1kalS6my8xDdiellviGXi9/FyOGELZpJGY+PrQ2s27dtyoD8oDwe3b0YWi4X31rKY+FYi/iJMrAG8ZTQ6GK+d/HesRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP/Wwvy4zJsS8akiAanZvn8glikrz0S03HVWsTYGyzc=;
 b=CcSpVQOVvjcFo8YYE7Gp6xVj7SSeFdmLlIDuNH1l0hj2OcKA9NIBA4tWM2YtZGcwZaF+Kcvr2FzsWzQ8Gy44erVEaqDktqsbXrrz26bm68b4k4VwiJilxLy8sMLZX05fpf6ENixX+Qo1fZ8YFFm/eOUFaPqBIkwBPlciGk/BkcpVdJxKtKxogH7+iU7AgS2JZxF1DIy1H3F/u5mMOJHzEx9u34RJwErPzoKZjZYCiTu0wXgYr8Rj5D9/r/zaTSu3jaVXf0B2smy7N7XXpFL4L8CBnIaQ6/3T9eOoF8xUOJqfv6wggxiTJJnZ4l2h+Htqn9iuqg94yNHPPFfu8b0hQA==
Received: from CH5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:1f4::19)
 by CH3PR12MB8994.namprd12.prod.outlook.com (2603:10b6:610:171::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 11:13:51 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:610:1f4:cafe::72) by CH5PR04CA0022.outlook.office365.com
 (2603:10b6:610:1f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.10 via Frontend Transport; Thu,
 19 Nov 2026 11:13:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 11:13:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:13:34 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:13:33 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:13:28 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 8/9] cpufreq: tegra194: Add support for Tegra264
Date: Thu, 19 Nov 2026 16:42:16 +0530
Message-ID: <20261119111217.902071-9-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|CH3PR12MB8994:EE_
X-MS-Office365-Filtering-Correlation-Id: f700e5ad-3edd-436c-7f9c-08df462e310e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|7416014|376014|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|261026121527099003|921020|261028144727099003|11063799006|261026140227099003|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	pSInvsnQwJxQpgG0GJQhEXzxH97KMW+TVSx5Hye65q3/NXV7O6h3Hk9xFIfz/dJm/m3uAUMj2xfM1BYAhjkbelJsr4ek8xWc1q+8apMgPEAGRebCqJVCFI/Bab5uZGU6Kwn+m1WVBsN9JE48alnfkzV/UaqDO9j7TyvCl3HVUH9QONqhr+LlV/qQzF88tGQsFJhj44KYcwP6idzGScj1R2eXIUgK83MjlPLBvLbL7rAFZ+3rHqoTEVggn/HtAvtjai0WOt6/RRdeUg+DutLAZMQRLOlcb0XyN2DgSSbf6TvbThlTgFFSHWKvWXOr1YQcMti29FCF65L8e/NmJaO7eYNYS6UIiXI9iyVyXuKODygnRTCGe9jakhmvIZbeHx/WijUiRkGlVJAuCKzWWS5JTbXbnZZxhGljj9u9QTIm5TC1FubRTZb4d1XyceoC0igjWr9Cq8ZU8ZKpCZRocD3uWq0zw7qJ1qEPv2CNgWFy0+FWaNk8W+8cfX4RLyf7oOq3z1+1QNDQPVhJBmBZeUtPB7KrM0G/6SsHEBlFFTSbRuTY69zjm3Hmq2DKvsQwZ2eB7n4Mt3s0QSDcDGosjnodz//5n/PYJQMVTte1/Q3G9javVLGVUUccXtrf1T5kF9lJPasakdSgNGthGw6WVibm6f3wGKk8caF9i4HwWXcB6kH+Ayqpx8SdxhBm5qy1AT8L8J6wY3IuHg/ojsxWOkC7YM0X0xnEJ1UWrTnJiybOeDjG+FnCC23w+1W1X2PXOuen
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(7416014)(376014)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(261026121527099003)(921020)(261028144727099003)(11063799006)(261026140227099003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q7U/xGBCKwEcW0fr6qb4/YgORa2ZZbvS56un/z2ZoWkJ3QgTzK6ZgGCOqjxlhnLmNBY+J2FtK/G6e3/tURsar4O0RtIzNWqM09CpSa9qhOKiQulI2hEbxJuKQ6ONlPCJRI2c0snuxy6VsMiEWe/WCRNzzifvS1UiuCWRtAWSOpj6qo1+kZh2CDBFjWUVspzVqwXdaZw6zYGIsUwJ3Jn9378VPQPCcAhhzxDBI9Dq7h1jG2tuFHqHPLuqL5FPb1r5RuWOAkolMT7JRMlf0Hnb4O1NZtSsuPO/4BytEgjAAsFNeFkbApOWVgoWPhBcGb1VYGWJfuL9xvh1leo0k33l57UWdMqmVYlaF+ybvjFk+EgE6HFLeXIatp85PLewrmwihHVtYOBy+GdmrQxM6FRzMYsaX7mTITqff2ylmunABhv2IHp3k63jVjXQTiV0VZW5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:13:51.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f700e5ad-3edd-436c-7f9c-08df462e310e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8994

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
 drivers/cpufreq/tegra194-cpufreq.c | 166 ++++++++++++++++++++++++++++-
 2 files changed, 163 insertions(+), 7 deletions(-)

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
index fb95ddd66966..cf493a03b6e5 100644
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
@@ -241,6 +260,83 @@ static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
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
+	unsigned long flags;
+
+	/* Keep interrupts off so both counters are read at the same moment. */
+	local_irq_save(flags);
+	c->coreclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CORE_EL0);
+	c->refclk_cnt = read_sysreg_s(SYS_AMEVCNTR0_CONST_EL0);
+	local_irq_restore(flags);
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
@@ -342,11 +438,11 @@ static void tegra_read_counters(struct work_struct *work)
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
@@ -380,7 +476,7 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
 		return 0;
 	}
-	rate_mhz = delta_ccnt * REF_CLK_MHZ / delta_refcnt;
+	rate_mhz = delta_ccnt * data->ref_clk_mhz / delta_refcnt;
 
 	return (rate_mhz * KHZ); /* in KHz */
 }
@@ -741,6 +837,42 @@ tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpm
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
@@ -763,15 +895,38 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
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
@@ -870,6 +1025,7 @@ static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
 	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
 	{ .compatible = "nvidia,tegra238-ccplex-cluster", .data = &tegra238_cpufreq_soc },
+	{ .compatible = "nvidia,tegra264-ccplex-cluster", .data = &tegra264_cpufreq_soc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
-- 
2.34.1

