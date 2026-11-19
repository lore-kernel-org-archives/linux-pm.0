Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086775;
	b=uBT56OZWa1qsIY1QL1yS6j6HZpfXv4tRu/PqMC9bMchrr+SiBiU1jY1T9eXOkKq8Grbm
	 a/FpkEpqsMPtKMMqmtjlcPf2ozy3oH18FfLeWwMEp0SAwsHtQQqmVxXKhjK9HRY/WuCXb
	 fBjRIVJ3XXg7Ne/74jfUv5/8Cqt1F0+sngxpbRjgMqnnABySzmWedyW497uymdLHhDH7K
	 zxtd8lhbhWon3/6xmKont3gH8XJk4EQf1FxlUPCc+XA6z98LcYVp+ytCNYkVHDNf9V4ad
	 ZAGAzjgYMwS0H4T9v/xoFs9B44jFYk1mErPITArwUYf0AY3P2Z3t5TNYHZVlI2YaVGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086775;
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
	bh=sYJ2FAYpzhJugg6mVxXs9eKlAMYJqZfB5OwWE1nAvK0=;
	b=uAlU4cubXvOuTXUvtw4dgvgx8pofB1orZw3bMBMdL4FSWHUn3Ev4BA+Q91RnVt8EfyOq
	 yh/38Z6GUzdJ8jecyGHciv2zdZywxHCokC/GnjkVoJVxVOpl8vv7U0FC5QzK3sk881BfB
	 BIenkrX61CjOp8ppTU7w2IBI6exc9/oxvhBJu7gFL2UXUASFJnh76ErLcz0OPq/gI/H12
	 bDl8QjAK40/4C1P8LRwIw4cdeLvWwFEJukHxQDKomPAKg52J2KNerN0AFHg4x4mxrT7to
	 wUAJiTq1FpUMwjS3ba04qXiCv6wL9bGV7UiUKGTJB6JBZb80PjNy5MShkogyCAfvcjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b6GnI3o7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.20
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2DA606A320;
	Thu, 19 Nov 2026 11:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2DA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=b6GnI3o7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxNjZdCEIdpLlb3BoMTz8QCuNYqi2u9uujOuMBNG93uCFLDDP/g9NxxZ0CSjbE+fA16K8iwQnf18Nd2gZ2SdEp8dC16KmBJEYC4mLY6OcshQPEqQ0w8RnzGwmDkcMP5aq0z7HcixeQqUdplWRlMMzb8k2cin3d3ZJAsynKybTgRJ8TG/JaGExIRYbtHLvvJ+A47MwHnFcfzu4owE4Oe+Sil9CPiGvmga1EW1WF7sVhjAuFqo+R+k7PKwdKy1ouixUoK2hWaHywBDyqm2PrRIP1lBCMg5EsEF/ccr//BTgMtzUtztnibZ/aajvQL3Po6QwC8CNRY4U6kzqTwSBg2IRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYJ2FAYpzhJugg6mVxXs9eKlAMYJqZfB5OwWE1nAvK0=;
 b=GbbG3ByVblGlOu0g0irHSoLerAxojFwr3mskeJEYzh+9Ks8crtiVAQfb/zrqBgx+nTQIPOOADTUMiOELAfaKdnNifSKHhaMiAg6Cr8pAtZScl9JhzUqtHSrrANKCbblIEcxEajdnbcgR95vOeLRiaazylerMxTFfq9QDfXYQcydbqq97ekXN/Atgme3CWlrZB3N8+aON2Y7D+uJGvTxgbKTx+wjSoJuEMkTyp5Hg2oyG47viU8LtG7LnKNC4Pj8h/AyzPCizfu3jhJOIg2s1b8u/jhXFr6WMH4bF6OamvUA95TFVtsNndVqxuYwR87pInfOZ9LPd3M6Jxl1TRCrgWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYJ2FAYpzhJugg6mVxXs9eKlAMYJqZfB5OwWE1nAvK0=;
 b=b6GnI3o7Rbz/0iYdOmU5VWVCsTYsm/oSj9bZlX4WempGZeBPsym99IdR4lG8bD/opEy2UqIxjwwTPvpJ3nfFmPyZvdEpldClZgmgYbcJLz+DaK1jwG2IE9o8Fc7ZfVK0c4Y9GuhmVoOu6RMp0jBS3//0WCaMEFm6kpqW6LJKxbE8EHlFUeCcDBYrIZg/XTvGr1bNAeabkqO3+nIPJkU0nQeoJx/rGuBRsRJy/3bl4axYPr0ofu6eqE0wiec5auoLuJuy2vRXLP/i3jhBBAHi9zt1IRq+UonfGe/TPMeTcsDkQ/YsTGcAURShJGDGaf2MUMzmc5x6lIHxE/qVmvs5Zg==
Received: from CH0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:610:11a::26)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 11:12:50 +0000
Received: from DS4PEPF000001BF.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::59) by CH0PR03CA0347.outlook.office365.com
 (2603:10b6:610:11a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 11:12:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS4PEPF000001BF.mail.protection.outlook.com (10.167.23.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Thu, 19 Nov 2026 11:12:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:32 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:12:28 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 1/9] cpufreq: tegra194: move MPIDR read to CPU hotplug callback
Date: Thu, 19 Nov 2026 16:42:09 +0530
Message-ID: <20261119111217.902071-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS4PEPF000001BF:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b5d955-895e-4f45-b438-08df462e0c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|22082099003|18002099003|921020|261026121527099003|11063799006|56012099006|261022105027099003|261022075727099003|10067099003|261021123027099003|261021121427099003|261026140227099003|261009221227099003|261028144727099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	RD7LCXbg3GhsTTshzbhRVymd3GsaVtpdWa9tx1Qeg1qlrH7FgY7ssmnySCuVEW3zcg3k71VECqfqVCr9A+2z2pLTWBkFy/7dPFMdptQkmyEhdSvJJphjo7jnEnKN6ALEw+ww6qhk/RS3vE2XEl2rgCwOGT847fe5/FzkK8eE/WCtP5CJe7lJcl55t8zaFIU++lzlBJ71WhfR82lsv/+wD9HNsqNmta5+X1BIzzsy3nk2pcOvSuEC9urjkESq58uF60wPGEI0kiEg8DAtlhEE2IxeYvRfr+mKMDULtzViAOpXtCyWPBtD44pZXB7jCdzvyIaXJCnurDxwW96q4wNZLWzzZXPWl8nFr+AbK0fw35xOW2jSoDDfnjwkm9SYIoeKJjxSPNwfR3r+XqMWOdLXkYLH93I19pW3UUCpPQjgJA0GKWl+O2tFLAAj0pu/An/7p3iKzNRoEbxyusktZx8U9jay0Hpczossp4J2Otp7b80SqTJGwyRXKlaHRj/qLOiY1eSZsETBQT0MQcNFOMl05e8cC8hF/eshftXgjfteBUfmbdPbCEMEueZnO4IjX3q/WE7PK+zfqCV03aYf7xrkXI66ehuGQza54KjqkBQkJFxwpOMYba2f6RLbqlwUK6z0QoYlG73M32OHmb7chG42tbiRjoeZstrl9wxb+9amHgZEPgt87FZrEAfuaz00jsdsoQnBbM080juHDpjb/MFyPKnTUh60aVUOUoOz9O/q136pjsH+UFab0B3/9RFKIstj
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(921020)(261026121527099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(10067099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009221227099003)(261028144727099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ysJNwPBFbiSNVUqPKD60Inc/IU0Y9y1z2V5wdG0rbFQLnV8vgot5DVC1Pwz4q55zTGhD2QsNarstw1IEwreODWZnhnYF3XEcs+6oey3ubakJeJOfN/DUArtgsrOrqUuPUDKtF8lKkN+9UwVupYlGHDnzawGediLRqyStIllkKsvcGz1ODdoqZsYnvZ2Tuv7KQednNA36lcmI6Fnrz1UH9MoZwKRxqfzY2o86nLZYd8sZFG1F4UzQIuhXfa6iCt/l/0g32Oo5R29oOEmwoHlGj7m3bUzbbg3IsWAG0F/eVCCJ6tBX6PsN627qPMByk7Esvy0K2nsMQmT8Gq7f+bOkH5FKmymYAHFAc3U/FpbiCyvRg1Q+TfhNvjMsGjkXxdAFYpafnCzLGXzkWXMeHe5mmnx1EKmYEUKOq1nGVdhDPQ23HNQthkk305ajmrK6BS6V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:12:49.8310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b5d955-895e-4f45-b438-08df462e0c5a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001BF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479

At probe the driver reads the MPIDR of every possible CPU with
smp_call_function_single(). For a CPU that is offline at boot, the call
fails and the error is ignored. The CPU's core and cluster IDs then come
from an uninitialised variable, and the driver later uses them to pick
the CPU's registers.

Read MPIDR from a CPU hotplug online callback instead. The callback runs
on the target CPU and caches its core and cluster IDs and scratch
register address. This covers CPUs online at probe and CPUs onlined
later. get_cpu_cluster_id() then needs no CPU argument.

Probe now checks nr_cpu_ids against the SoC data, instead of checking
each CPU. A CPU whose MPIDR does not fit the SoC data gets a warning and
no scratch register address. The driver reports no frequency for it.

Fixes: 6b121b4cf7e1 ("cpufreq: tegra194: save CPU data to avoid repeated SMP calls")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 128 ++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 39 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 8599914f2194..8d47fa746142 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -5,6 +5,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpuhotplug.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -13,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/units.h>
 
-#include <asm/smp_plat.h>
+#include <asm/cputype.h>
 
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
@@ -59,7 +60,7 @@ struct read_counters_work {
 struct tegra_cpufreq_ops {
 	void (*read_counters)(struct tegra_cpu_ctr *c);
 	void (*set_cpu_ndiv)(struct cpufreq_policy *policy, u64 ndiv);
-	void (*get_cpu_cluster_id)(u32 cpu, u32 *cpuid, u32 *clusterid);
+	void (*get_cpu_cluster_id)(u32 *cpuid, u32 *clusterid);
 	int (*get_cpu_ndiv)(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv);
 };
 
@@ -77,6 +78,8 @@ struct tegra194_cpufreq_data {
 	const struct tegra_cpufreq_soc *soc;
 	bool icc_dram_bw_scaling;
 	struct tegra_cpu_data *cpu_data;
+	enum cpuhp_state cpuhp_state;
+	struct hlist_node cpuhp_node;
 };
 
 static struct workqueue_struct *read_counters_wq;
@@ -109,11 +112,11 @@ static void tegra_get_cpu_mpidr(void *mpidr)
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
 }
 
-static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
+static void tegra234_get_cpu_cluster_id(u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
 
-	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
+	tegra_get_cpu_mpidr(&mpidr);
 
 	if (cpuid)
 		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
@@ -121,11 +124,45 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 		*clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 2);
 }
 
+static int tegra_cpufreq_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct tegra194_cpufreq_data *data;
+	u32 cpuid, clusterid;
+
+	data = hlist_entry(node, struct tegra194_cpufreq_data, cpuhp_node);
+
+	data->soc->ops->get_cpu_cluster_id(&cpuid, &clusterid);
+
+	data->cpu_data[cpu].cpuid = cpuid;
+	data->cpu_data[cpu].clusterid = clusterid;
+
+	if (clusterid >= data->soc->num_clusters ||
+	    cpuid >= data->soc->maxcpus_per_cluster) {
+		pr_warn_once("cpufreq: cpu%u: bad MPIDR (cluster %u, core %u)\n",
+			     cpu, clusterid, cpuid);
+		return 0;
+	}
+
+	/* Derive per-core register address only when ccplex MMIO is mapped. */
+	if (data->regs) {
+		u32 index = clusterid * data->soc->maxcpus_per_cluster + cpuid;
+
+		data->cpu_data[cpu].freq_core_reg =
+			SCRATCH_FREQ_CORE_REG(data, index);
+	}
+
+	return 0;
+}
+
 static int tegra234_get_cpu_ndiv(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
+	void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
+
+	if (!reg)
+		return -EINVAL;
 
-	*ndiv = readl(data->cpu_data[cpu].freq_core_reg) & NDIV_MASK;
+	*ndiv = readl(reg) & NDIV_MASK;
 
 	return 0;
 }
@@ -135,8 +172,12 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	u32 cpu;
 
-	for_each_cpu(cpu, policy->cpus)
-		writel(ndiv, data->cpu_data[cpu].freq_core_reg);
+	for_each_cpu(cpu, policy->cpus) {
+		void __iomem *reg = data->cpu_data[cpu].freq_core_reg;
+
+		if (reg)
+			writel(ndiv, reg);
+	}
 }
 
 /*
@@ -204,11 +245,11 @@ static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.refclk_delta_min = 16000,
 };
 
-static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
+static void tegra194_get_cpu_cluster_id(u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
 
-	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
+	tegra_get_cpu_mpidr(&mpidr);
 
 	if (cpuid)
 		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
@@ -386,16 +427,21 @@ static unsigned int tegra194_get_speed(u32 cpu)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	u32 clusterid = data->cpu_data[cpu].clusterid;
+	u32 cpuid = data->cpu_data[cpu].cpuid;
 	struct cpufreq_frequency_table *pos;
 	unsigned int rate;
 	u64 ndiv;
 	int ret;
 
+	if (clusterid >= data->soc->num_clusters ||
+	    cpuid >= data->soc->maxcpus_per_cluster)
+		return 0;
+
 	/* reconstruct actual cpu freq using counters */
 	rate = tegra194_calculate_speed(cpu);
 
 	/* get last written ndiv value */
-	ret = data->soc->ops->get_cpu_ndiv(cpu, data->cpu_data[cpu].cpuid, clusterid, &ndiv);
+	ret = data->soc->ops->get_cpu_ndiv(cpu, cpuid, clusterid, &ndiv);
 	if (WARN_ON_ONCE(ret))
 		return rate;
 
@@ -681,28 +727,6 @@ tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpm
 	return freq_table;
 }
 
-static int tegra194_cpufreq_store_physids(unsigned int cpu, struct tegra194_cpufreq_data *data)
-{
-	int num_cpus = data->soc->maxcpus_per_cluster * data->soc->num_clusters;
-	u32 cpuid, clusterid;
-	u64 mpidr_id;
-
-	if (cpu > (num_cpus - 1)) {
-		pr_err("cpufreq: wrong num of cpus or clusters in soc data\n");
-		return -EINVAL;
-	}
-
-	data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
-
-	mpidr_id = (clusterid * data->soc->maxcpus_per_cluster) + cpuid;
-
-	data->cpu_data[cpu].cpuid = cpuid;
-	data->cpu_data[cpu].clusterid = clusterid;
-	data->cpu_data[cpu].freq_core_reg = SCRATCH_FREQ_CORE_REG(data, mpidr_id);
-
-	return 0;
-}
-
 static int tegra194_cpufreq_probe(struct platform_device *pdev)
 {
 	const struct tegra_cpufreq_soc *soc;
@@ -710,7 +734,6 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	struct tegra_bpmp *bpmp;
 	struct device *cpu_dev;
 	int err, i;
-	u32 cpu;
 
 	data = devm_kzalloc_obj(&pdev->dev, *data);
 	if (!data)
@@ -737,6 +760,12 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 			return PTR_ERR(data->regs);
 	}
 
+	if (nr_cpu_ids > data->soc->num_clusters *
+			 data->soc->maxcpus_per_cluster) {
+		dev_err(&pdev->dev, "wrong num of cpus or clusters in soc data\n");
+		return -EINVAL;
+	}
+
 	data->cpu_data = devm_kzalloc_objs(&pdev->dev, *data->cpu_data,
 					   data->soc->num_clusters * data->soc->maxcpus_per_cluster);
 	if (!data->cpu_data)
@@ -764,11 +793,24 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		err = tegra194_cpufreq_store_physids(cpu, data);
-		if (err)
-			goto err_free_res;
-	}
+	/*
+	 * Install the hotplug state before cpufreq_register_driver(), so that
+	 * cpu_data is filled in before cpufreq uses a CPU. This covers the
+	 * CPUs online now and those onlined later.
+	 *
+	 * cpufreq_get_driver_data() returns NULL until the driver is
+	 * registered. The _multi variant passes the callback its data
+	 * through cpuhp_node instead.
+	 */
+	err = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "cpufreq/tegra194:online",
+				      tegra_cpufreq_cpu_online, NULL);
+	if (err < 0)
+		goto err_free_res;
+	data->cpuhp_state = err;
+
+	err = cpuhp_state_add_instance(data->cpuhp_state, &data->cpuhp_node);
+	if (err)
+		goto remove_cpuhp_state;
 
 	tegra194_cpufreq_driver.driver_data = data;
 
@@ -776,7 +818,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
 		err = -EPROBE_DEFER;
-		goto err_free_res;
+		goto remove_cpuhp_instance;
 	}
 
 	if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
@@ -789,6 +831,10 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (!err)
 		goto put_bpmp;
 
+remove_cpuhp_instance:
+	cpuhp_state_remove_instance(data->cpuhp_state, &data->cpuhp_node);
+remove_cpuhp_state:
+	cpuhp_remove_multi_state(data->cpuhp_state);
 err_free_res:
 	tegra194_cpufreq_free_resources();
 put_bpmp:
@@ -798,7 +844,11 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 static void tegra194_cpufreq_remove(struct platform_device *pdev)
 {
+	struct tegra194_cpufreq_data *data = platform_get_drvdata(pdev);
+
 	cpufreq_unregister_driver(&tegra194_cpufreq_driver);
+	cpuhp_state_remove_instance(data->cpuhp_state, &data->cpuhp_node);
+	cpuhp_remove_multi_state(data->cpuhp_state);
 	tegra194_cpufreq_free_resources();
 }
 
-- 
2.34.1

