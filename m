Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816201;
	b=wiGbmfx7hynavUo/By+Vx4RYMJwkkfdf1QOywaQDIctrvczk14Py3QhD7vYVczxXZLv8
	 ZWIG+4r52ZK5iX4Hy6XFexKpY99K5nCSI9ewfwM0MgVRVpaZegw9cjUqx/Lk3Ptyly/xz
	 G3vdFGMFaYaBs6X6CmhGMTajdRMkf0LtEl+CX4QyWbijP6U3V5oML1Iu7z2im+cpFlAn7
	 hoiGnWs00yhA2rW/jWSJVhSaMW+WmkrsjK4C7EhBvYFzg8ZaY7givxL938PpUHTEyfe6A
	 ECWhNXxca7V+s/tsnaARny1mZ0E7wSjV2hwKeQejUVBpIsLOgPI6S4J2q1fxfJ0pKPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816201;
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
	bh=ZBv7uJrWsoVczpHeGhpL5zNgFUmyB/lsmCkIp650GOI=;
	b=LncAuqgYp6q/mMQ+Jwu2Ys1GgqGC5KIiD7Zr4mWvcKPXxdoqdnakhEsCh6hWqbUzhM7K
	 FjUL/iKKEivIlen6akN8FPVpCHD2OJ0DYcyQrEVYXNAFipNJn7Cds8ZbW4Wp9e+RxzbEO
	 NfNqfFoRz2SnUW0WWE3Rvtep7xuOyDi7UpXZhQyo+PZCsqzPNFGMxbeiLa5uvuQhm1JM4
	 nLQDOCYDEV72X2rPgfNLkHTWQe9eWAz3soBn8o0X/vxWkH37rpDDhFrA2N9Wwp4jvcWeL
	 uFDLfxjWuoQxg/qESKlSr/nJbgTv9VVkmfz2IPsjbjl6VnO2fm+0eaIAtvM+k2zjbQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ISbpNtIw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.59
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F0606EE9D;
	Wed,  4 Nov 2026 18:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A73F0606EE9D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ISbpNtIw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8cp/5PpMLAYsK630wIms8wP2Wkhgqb8wg9k68RflyJaBLjtTsg7igq/4bK+XNNW9CRj+eH/OJ2zDoiAQn27RASGVj47KebZeNezPj8xG5mG37AvRbnDeAQV1KajtGsv6V+2rjoyLZ5+I6e7hSRxm00Enk7KPXaDZ9tgIrsRXE83Gv1n+n235kNpy/szPmmmudUXk/dpG8uf6TP0dAb9xAZENCLlF/aiE2H7qe8Yzr58RfJuAp855twgVX1nJE0GItQeJ1+NjDluIalXr1m6OOBY3kUtmktivD9GL2iALqu1rzgybC3GJdwBj/9CAHwWOw8Sit/eOqthcsvvq0foTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBv7uJrWsoVczpHeGhpL5zNgFUmyB/lsmCkIp650GOI=;
 b=QporLzrbMuOuRM5+5HNROZAcvRLb+WoJWIFGFDYYz3Ao+9S7J7tUe8iwsXPKf2faVrG9OWcUXxphvwgJckq9lmbjc0GoeAvCiLgTGYuiLS+bSjjziGM4A1qc3W/+YmbW2zGeYlqARTkrP5/aO9ryUQJcr/Pb4cJtng3SuIngSEOjdvWLNuxYJCa3OA7KZWqmqRZKA6D2JsGzQXoo2luMbE9VSpbsj+jefRuZ/VIRjkWGg/hWprMpyae4j2FHePhs0tALaDCfoLVjgrXmJFEJDWQbue7P4qxFR5ahi4W3uaax2reotyweV4sAri6IgPtcdNpwq2EMZqmRj6WYmixctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBv7uJrWsoVczpHeGhpL5zNgFUmyB/lsmCkIp650GOI=;
 b=ISbpNtIwq4GtdOU5cnM7h8aBixgMxOEHld7C7I663A+pvU0A+AS8Lh9wz/gHC2W7Iba/1LPMvcf/9nwMVTTGtccHxjsysHcEe8NOsqdG0/2JPflkMZcWj7F09D9RJTz+nIZPGUrPCgHsMth0D6kVInwlpYtKCNDAL2ZROMIwLkwwRosmhfT9p8kqHX0f62/pOhxIDM9APtzrhZLUDPaPQNYvFbLVgtEzbaRXlgogMHbKmfwb8X61aP0hAMrZvnfo+hSwQA7rMQnn6vmbMmUl5kpw+8xdEx/v80P4feQ1EH+ujY3gxa7AwJlT8gY7vsTV08Z/WrDmN5kQUAV4PVskpw==
Received: from PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::8)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:16:35 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:510:349:cafe::1a) by PH8P221CA0055.outlook.office365.com
 (2603:10b6:510:349::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 18:16:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:16:16 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:16:15 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:16:12 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 8/9] cpufreq: tegra194: Add support for Tegra264
Date: Wed, 4 Nov 2026 23:45:20 +0530
Message-ID: <20261104181521.3003578-9-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104181521.3003578-1-sumitg@nvidia.com>
References: <20261104181521.3003578-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3f4790-d0c7-45cd-2a9e-08df3a9fc2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|921020|11063799006|261026140227099003|261022075727099003|261028144727099003|261026121527099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	LVw/hSPZd+oeUyRiPtLi2e3C0kTJC8UlHbII0jMMWqpe2qpQtR17x+Kxrs47hbuZcvGL1/FhJkE8iqcT83EvOxmR3gpxAz3VO8j4YUXNTmop3HYPjicJA2E73D4d85aUlHgGsNxQYn67mox/OCKVmIhs4RzjbYZXlGq7UD80wBPS7aQjtvs2s4mIX444rKjHsi3PWxVv+2zecvZxUZOPdeP/SYQ6nBAcWenM7ADz3qnGoJqBpLhZoN2WOrc/IT9We6wv6s8FeudXN0Ika8BprSkxSECBuDCI+1PIrDtYlyJfJTeuVnzxlq1LAvENjSvazarxWkbaNYY/BISK5UZJFIQNSaN+UzDWJFmBqNIDCm8f4e4FCVU4eAov0Ff3Zn6b90d2lwTpoK/5/8iAwXPm1lbNPqWdxUSNK2rAPJ9QabMCb7KrYyauz8+U7EwQF7wSZu57l3rxfF4FaHpN1hKOx0pte0MqyVS8NrQtzw7prsGHGfzNJZLYP29wytTXwinLgHgTMUOeKvznbP1eqvAAJGoeN7XOQ3cNsBfDjgf79E3FCmVKUy+X+qfjLk/68zP7dUUSndzS4+tiu1l2IKLN9vw1We9K0KhbVeiZhuH7z6Ms+4AskhoZod44O8bWb/zgF4k7W1nNPByl7GDAF8v6WwYF+VdHRpA6bGtB5auN07oy3GRMcf554D5BsyNcKAXTHKqOi0rcXCcgbWctoc58T9vc1KZd63UOQ89vREUSgcJeIzWSxFe7WHzHgzJ2m4bC
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(921020)(11063799006)(261026140227099003)(261022075727099003)(261028144727099003)(261026121527099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZMxDs14CAQFxmjo0P6sX4maZhfpDrUo1f4wX+hJdOJs9a8EUwb2rxyKjDIaYlvSZ/Ilulq/ZZIb8QcM4i0pxsYmcSMA2/Om1ugoZLErvXeRpTq1tk4oY+CL2nQjXV0hhL0nWNosj31SAED+uU+Dliiz8JcsYM9Xol0ZZg8UHzq4akhHPv3jFNJomaOvyxC6otXUhqYf6N//ltDvkgTZVHeum//dd011w7o31fMvzrJS8Mm8ZUCnHjVBof5r43GwwoAATBQ9vFoFLAqEAKhsIJ5ZD6KRxUODL3XLjnsCRPpx4v385QT5bqerRHJmjorknjbTfuutv1T1+fxLk/BtXCFdJrjalbBLXE1aYCgGxpFKi/zTVcC2Uwc3L2yBIrmWUfhQjCHwDvdVNNgJvt/f66Q4edLIzoWYqoN8BPEfszUXj3ZnzskxtbYYYVIeYUyH9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:35.2637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3f4790-d0c7-45cd-2a9e-08df3a9fc2d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712

Add cpufreq support for Tegra264. It requests and reads the CPU
frequency differently from earlier SoCs.

To request a frequency, the driver writes NDIV to a core_freq_req
register in the CCPLEX register space. Two clusters share a
cluster-clock unit and its register, so they always run at the same
frequency. The driver exposes each pair as one performance domain and
one cpufreq policy. Each CPU's "performance-domains" property gives the
domain index, which selects the register. If the CCPLEX node declares
"#performance-domain-cells", probe fails if any CPU lacks the property.

To read the frequency, the driver samples the per-CPU 64-bit AMU
counters through system registers. The AMU constant counter is the
reference. It ticks at the system counter rate, so the driver takes the
reference rate from CNTFRQ instead of the fixed 408 MHz clock.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/Kconfig.arm        |   4 +-
 drivers/cpufreq/tegra194-cpufreq.c | 147 ++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 7 deletions(-)

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
index 1328aa0a1bd1..0767a6fd6bdc 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -14,7 +14,9 @@
 #include <linux/slab.h>
 #include <linux/units.h>
 
+#include <asm/arch_timer.h>
 #include <asm/cputype.h>
+#include <asm/sysreg.h>
 
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
@@ -36,6 +38,18 @@
 			(data->regs + (MMCRAB_CLUSTER_BASE(cl) + data->soc->actmon_cntr_base))
 #define CORE_ACTMON_CNTR_REG(data, cl, cpu)	(CLUSTER_ACTMON_BASE(data, cl) + CORE_OFFSET(cpu))
 
+/*
+ * Tegra264 requests a frequency by writing the NDIV to a core_freq_req
+ * register in the CCPLEX register space.
+ *
+ * Two clusters that share a cluster-clock unit form a performance domain.
+ * Each domain has one core_freq_req register. The registers are grouped
+ * in blocks, two domains per block.
+ */
+#define T264_CORE_FREQ_REQ_BLOCK_SIZE		0x400000
+#define T264_CORE_FREQ_REQ_BLOCK_DOMAIN0_OFFSET	0x40000
+#define T264_CORE_FREQ_REQ_BLOCK_DOMAIN1_OFFSET	0x50000
+
 /* cpufreq transisition latency */
 #define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
 
@@ -70,6 +84,8 @@ struct tegra_cpufreq_ops {
 struct tegra_cpufreq_soc {
 	struct tegra_cpufreq_ops *ops;
 	u64 cnt_mask;
+	/* AMU's constant counter ticks at the system counter rate. */
+	bool ref_clk_from_cntfrq;
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
 	bool needs_mmio;
@@ -79,8 +95,10 @@ struct tegra_cpufreq_soc {
 
 struct tegra194_cpufreq_data {
 	void __iomem *regs;
+	resource_size_t regs_size;
 	struct cpufreq_frequency_table **bpmp_luts;
 	const struct tegra_cpufreq_soc *soc;
+	u32 ref_clk_mhz;
 	bool icc_dram_bw_scaling;
 	struct tegra_cpu_data *cpu_data;
 	enum cpuhp_state cpuhp_state;
@@ -240,6 +258,78 @@ static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
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
 static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
@@ -341,11 +431,11 @@ static void tegra_read_counters(struct work_struct *work)
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
@@ -379,7 +469,7 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
 		return 0;
 	}
-	rate_mhz = delta_ccnt * REF_CLK_MHZ / delta_refcnt;
+	rate_mhz = delta_ccnt * data->ref_clk_mhz / delta_refcnt;
 
 	return (rate_mhz * KHZ); /* in KHz */
 }
@@ -735,6 +825,34 @@ tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpm
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
 static int tegra194_cpufreq_probe(struct platform_device *pdev)
 {
 	const struct tegra_cpufreq_soc *soc;
@@ -757,15 +875,33 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (soc->ref_clk_from_cntfrq)
+		data->ref_clk_mhz = arch_timer_get_cntfrq() / HZ_PER_MHZ;
+	else
+		data->ref_clk_mhz = REF_CLK_MHZ;
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
 	data->bpmp_luts = devm_kcalloc(&pdev->dev, data->soc->num_clusters,
 				       sizeof(*data->bpmp_luts), GFP_KERNEL);
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
@@ -865,6 +1001,7 @@ static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
 	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
 	{ .compatible = "nvidia,tegra238-ccplex-cluster", .data = &tegra238_cpufreq_soc },
+	{ .compatible = "nvidia,tegra264-ccplex-cluster", .data = &tegra264_cpufreq_soc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
-- 
2.34.1

