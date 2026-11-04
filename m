Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816172;
	b=xDjC+ZxJchqr7+l4VXJtmy8BjYXP2jBd/FqRh9Dw86GaKnZvvkbJF+nFbXrrZi5USGE8
	 mIbUEdPiRvHomSawqhnI40r+R8K2jhi5nzezy/+GcQzKIhEdBGdKYEvLt5/apJE9x6FUG
	 iiPYQzjLe6zsdcGkeyQek4t2RiApGLA754sVGXiK/wfaxjgjoJwgqHztcSjCJehGUWmbs
	 Ad2uMCo3tPPKLf/qgmauXf0RkOVoSgpq6i62+Tv6vxbXKsMGjS1YoZcQ50uoFyVhdkHu1
	 oLUQKKDtvxLXbtDRJitePHpM9cReWT9XbsEF7N8ks3zM8Ykf/7N5Pr4ezNwL+relUVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816172;
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
	bh=ndLpJ/WAbJWOVZAVhN+HtMGz1LcxyQt/VW2vPmERU5M=;
	b=aqlTw1jif2UYb2PczegXmxsk/AG/CreKe17Tqw5bXvh8Hl6jrpAo4eu0Jbx3462Onx+V
	 4xTOi5yZDFla91Cfx5t0i4DQKvB9UMO9zDEIVXbAibngvn3NaInmseiq99x3zE5zYdI/H
	 F8g/JNN+6llJUChIPclQP7ppqjao+nBw9BmemTVmeB1Npj+Tjqc5eGARUJwu87C1A3CqJ
	 VZPPvPDjAMWLBZk1L7MexG3K2WqSsnwmgkoWDIrXk9eJIO1ew0M42TJ6UrmtDRYGYNxG4
	 QTShvv2gJq+FvR51GI4nm3SVsaQT0tjZOSQlWgYq62bE37PtZ+UvGtKm14nNtH7MjNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NoVDiYo7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.54
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A66606A31B;
	Wed,  4 Nov 2026 18:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39A66606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NoVDiYo7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl0UvG1Uw1dEP7IEMUSUINvLDWZJwor6iexSiW/yB2N+6Mx69SN/W8iNQ3hLEuDfzv5YBL8aB3mKUvNnB1H8OBCOrEf6YsUTbldKVaLxnsH0gLiduxFdg6al7T9Skf10el0aebORuGZUen3pdK+4USnkaZv/s/4HCF55Q0zBZgdYH5lZwZhcqdxyJEHpe5dFs+2Lk7ly/1axkcAxKTSdrHeNP9OqBYpx1tEJx6h5h+H08Gtz/MGaZc04X7MHzaVz3mDfF3UBayYFiPMlu8i5H0z9xtj4JvcNvnCaBOmzI7hjJUMFJpgz/vKAuEigSnA72JqKxy7nhrmX/jjv4UxRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndLpJ/WAbJWOVZAVhN+HtMGz1LcxyQt/VW2vPmERU5M=;
 b=thDnnLcuFwYcnwXG92suJRkkaF1mp0+Mrz3P7LWI23/FNqIPgdd7AZx5WH4a6/KRjAoDkzpIVrylVZVYbhC03Jm1T9geFnSmBPQpD7lME2pr7gqZdSZ4hAASp7ZD63k5HSzL4FEN3HnkFu9SER/e+DGaKebsYoHKOAsAIP1R0sIq4uv1cBQCG0G+gTA3uvE8Zv7lvE2f2gGfIyt4BqYphNowNQTlG0d0QXqIFt5l78uXqExQNGt2owimtnGJMVe1hmPRAOc90uxu30+JMbe6sYKJdnK2pSgKUNNw4JrmTkLpPSC40wUh3PJYEvH3zFmprMUs1YdcjtE8qZ8ZaUe1MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndLpJ/WAbJWOVZAVhN+HtMGz1LcxyQt/VW2vPmERU5M=;
 b=NoVDiYo7udAzOst1wJ5/7V60Y5HZuCcYUvQmXptYx/KEBRR/kznyd43s5ah0TnEgyGcBMpmAUwUWlyZk1S5txgKjVDgdmuSL+eSV81qIRvN2R04R9QMZ4/T3Ha1XKn24MMfoVoAiS/hccPheR9TfKB04PgDB3UObvtIgKo7U5PMbDPRCxvGN6Sd4ktVSH7VAGorB5mFtYNS2SduzJNWRHF6Wme33PeuwpHbwq6GAooM9baaIfFeBO6K/fV/uTKE2zLJ4iXZCBXlsTS9bJPl6LM53KsFw+cYPKjurIzvssYzz34GOGtoRxOJ0LbXoC+sb0BJ36FWJgTYI2Tg4G8AyRg==
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:16:05 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::77) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.7 via Frontend Transport; Wed, 4
 Nov 2026 18:16:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:15:33 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:15:33 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:15:29 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 1/9] cpufreq: tegra194: move MPIDR read to CPU hotplug callback
Date: Wed, 4 Nov 2026 23:45:13 +0530
Message-ID: <20261104181521.3003578-2-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 84221d7e-ff19-4df0-1ec5-08df3a9fb0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|261026140227099003|261028144727099003|261026121527099003|261009223027099003|261009221227099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|11063799006|56012099006|10067099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	WlNu09r5lfsygusZuIzSbXOjMq2BC1eMQXMRjjigIJ1rNAuGrSA6AQ/cE3zBfj1D/mB+kf5FZ0cbePPnM7TwwrUFvIJMOs+CbG27tz/9GZ1fyQx5N0So10A5u+AmVQO1Tl1/Q+ATI+kJ+Ke+IFs556Lx0cmpvFXFhQKOBQo54tInh6gB5ia3VZsiCj4jgZV/35+A8QFKE7LQT6oz4MFFBcnI+BIM0dhBAo1DRx32A03s8g9vorpB7+w5m1bvvNCZTusCXvKGq8MKwoxyRpvDOAgrQnugs7NO0CxTz/owRgLy+xv9UyAKtpIzHOclQHjWfM/XUhEuvAp630vRTgOFpEukXOC9nFU2LYFFw8Tpt7qWMXyTEuR11awoEDjE7qwJxi70Qk2m5okqwg6n7ZF7WFunw3IEUs3Xuly7Z9kmdrIqzz6RmS+rbknY5gtRdNDoVS9M0M0WkWjWr2l2nsY5NG7phzmEB99QqJoL7iylWMpCwkXimwAiiQEtfV0nY9YqiziF41mwQc/CGChrQwgUlpX47FXLftDyhk1N6BuuNgOtDjFye5cV61bFd1bQKkWV/4efHvmrUJdxqIQyDpNlta1JsrdcDgA6lZn3fZu/Ea3xkME2KOz5I6yCHVJ6Sy889EeMVpqMdxZipaTheCRxoR/1lUJeafET1mkjFbmqMh6mh5FGc2Fxma+tpGkjCXCazyDsNUbrCH4MunLtj4WQyKUd779Xuz4Nn1aP9WRhE5sDpx2Nhty84Lg8plRel2pS
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(261026140227099003)(261028144727099003)(261026121527099003)(261009223027099003)(261009221227099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ynoBBxXsdto4oQQPmO/cCXAj24rxlZQMh2XFOxGoBUoQEy7C9YqdzPA4a6voMcWE9crIGwwL98eL7GKGMcy0uN3ucItAQNzFaHknZ/KgtR0iGJOLnc3JaF+P9oYFjTyvRLsNe/2OjXM5xRO9an9fcLfs7xKiXmSDek4AE19zSdf3d2F9a2862jfLyRxyYwoIXLvpYeFro/Ba2QqlueFK9uq9vVhNeYusPuval/j57XUX0zI/PkEflxifBCrAVT82cAjjzvxZEgLiykxR0bPbMYtDSjoTsNO4NojpFvlQq/0QDtBp/8vCxMVqnxNMEP6sgW7VIc9xBgc4EOTEKy0hZCWjReO5IKnW5fq6zXgLIzNu+13voeaV/4czWlJzp+EC5FMLeBCPciTXdTwtWVjacmuaCWwZfxaU6pyqryJ5UJwfXnsbzdHo9567pehheJXG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:05.2715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84221d7e-ff19-4df0-1ec5-08df3a9fb0f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

At probe the driver reads the MPIDR of every possible CPU with
smp_call_function_single(). For a CPU that is offline at boot, the call
fails and the error is ignored, so the CPU's core and cluster IDs come
from an uninitialised variable.

Read MPIDR from a CPU-hotplug online callback instead, which runs on the
target CPU and caches its core and cluster IDs and MMIO scratch address.
This covers CPUs online at probe and CPUs onlined later.

The check that the SoC data covers all CPUs moves to probe, against
nr_cpu_ids. A CPU whose MPIDR does not fit the SoC data gets no scratch
address, and its NDIV access is skipped.

Fixes: 6b121b4cf7e1 ("cpufreq: tegra194: save CPU data to avoid repeated SMP calls")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 114 ++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 1eb96e9f3310..be81ffd23edd 100644
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
@@ -77,6 +78,8 @@ struct tegra194_cpufreq_data {
 	const struct tegra_cpufreq_soc *soc;
 	bool icc_dram_bw_scaling;
 	struct tegra_cpu_data *cpu_data;
+	enum cpuhp_state cpuhp_state;
+	struct hlist_node cpuhp_node;
 };
 
 static struct workqueue_struct *read_counters_wq;
@@ -113,7 +116,7 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
 
-	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
+	tegra_get_cpu_mpidr(&mpidr);
 
 	if (cpuid)
 		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 1);
@@ -121,11 +124,44 @@ static void tegra234_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 		*clusterid = MPIDR_AFFINITY_LEVEL(mpidr, 2);
 }
 
+static int tegra_cpufreq_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct tegra194_cpufreq_data *data;
+	u32 cpuid, clusterid;
+
+	data = hlist_entry(node, struct tegra194_cpufreq_data, cpuhp_node);
+
+	data->soc->ops->get_cpu_cluster_id(cpu, &cpuid, &clusterid);
+
+	data->cpu_data[cpu].cpuid = cpuid;
+	data->cpu_data[cpu].clusterid = clusterid;
+
+	/* Derive per-core register address only when ccplex MMIO is mapped. */
+	if (data->regs) {
+		if (clusterid >= data->soc->num_clusters ||
+		    cpuid >= data->soc->maxcpus_per_cluster) {
+			pr_warn_once("cpufreq: cpu%u: bad MPIDR (cluster %u, core %u)\n",
+				     cpu, clusterid, cpuid);
+		} else {
+			u32 index = clusterid * data->soc->maxcpus_per_cluster + cpuid;
+
+			data->cpu_data[cpu].freq_core_reg =
+				SCRATCH_FREQ_CORE_REG(data, index);
+		}
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
@@ -135,8 +171,12 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
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
@@ -208,7 +248,7 @@ static void tegra194_get_cpu_cluster_id(u32 cpu, u32 *cpuid, u32 *clusterid)
 {
 	u64 mpidr;
 
-	smp_call_function_single(cpu, tegra_get_cpu_mpidr, &mpidr, true);
+	tegra_get_cpu_mpidr(&mpidr);
 
 	if (cpuid)
 		*cpuid = MPIDR_AFFINITY_LEVEL(mpidr, 0);
@@ -682,28 +722,6 @@ tegra_cpufreq_bpmp_read_lut(struct platform_device *pdev, struct tegra_bpmp *bpm
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
@@ -711,7 +729,6 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	struct tegra_bpmp *bpmp;
 	struct device *cpu_dev;
 	int err, i;
-	u32 cpu;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -738,6 +755,12 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 			return PTR_ERR(data->regs);
 	}
 
+	if (nr_cpu_ids > data->soc->num_clusters *
+			 data->soc->maxcpus_per_cluster) {
+		dev_err(&pdev->dev, "wrong num of cpus or clusters in soc data\n");
+		return -EINVAL;
+	}
+
 	data->cpu_data = devm_kcalloc(&pdev->dev, data->soc->num_clusters *
 				      data->soc->maxcpus_per_cluster,
 				      sizeof(*data->cpu_data), GFP_KERNEL);
@@ -766,11 +789,24 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
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
 
@@ -778,7 +814,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev) {
 		err = -EPROBE_DEFER;
-		goto err_free_res;
+		goto remove_cpuhp_instance;
 	}
 
 	if (dev_pm_opp_of_get_opp_desc_node(cpu_dev)) {
@@ -791,6 +827,10 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (!err)
 		goto put_bpmp;
 
+remove_cpuhp_instance:
+	cpuhp_state_remove_instance(data->cpuhp_state, &data->cpuhp_node);
+remove_cpuhp_state:
+	cpuhp_remove_multi_state(data->cpuhp_state);
 err_free_res:
 	tegra194_cpufreq_free_resources();
 put_bpmp:
@@ -800,7 +840,11 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
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

