Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816192;
	b=MOydLprPvUUoRPn07QFxTX00tccKbQVJQm2cnbxNwoyv7ra53J/aBGdwX3Uhtavpm7gw
	 ySREnHOkx0+/a5fB78O6oGUYFqIZLkG5PIqgZxlq0bbctutt57CwMxrHJjN85XJ/lI1hC
	 CnTHAIOv/O6FWTx7N4NTo2e9VsxJSW6yUt8lClAL9EOZ8FA44xv8aZCvceTFbh8cT5SCO
	 3nwRoU7rv84jiFAYoBa2D5+5aIybb6vxigvfregulBWN6m1+S7atq2Y7VBhzMR1CGyjSq
	 bcXTmYBqgQvsGYV4Mf8GBaLhNfwkhzYhlrViBiBauQpgXSQQpGm7FFIvUFsNA4e3EIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816192;
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
	bh=X9sqxIQcw8slm1Q/xRNZAxawHmGIEXFXjCrCAZ4Oxb0=;
	b=i2q3iZp6ySl88HQROvy2mbQebD1xU5h4BgsedH5RhHc3yK0NroQzQIh3QUfUS/m8yiUZ
	 iPJ7x9918SeZ2jz4GpaOeBze2u2bufzHlZewM06PLTv7RVqb1E/6J1R9Q0+MJYBgB8n6x
	 HVmIjf2jNcQOdMGzy+6/4fj+gg9WuQ5scilnHhf7tSTeoq5kUnlRjSTG6dgi2vgzvRsD7
	 iGZwu25Xlbd/HtjijIYsnyREZHuhHbRoj90if9P5a28eGYegPCHwEqAnbofhCzdzeHB/o
	 jXy5nQs1csT3GDOkKrXV4YRkUxk1F+0ljWJ1tu3XlotcjYaV6hguOZ1YZthni1V0WGg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZPimVrpj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.53
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7B606A31B;
	Wed,  4 Nov 2026 18:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6C7B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZPimVrpj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMoBT3DxeQzdlOhmIVDstxaqtEvzPxFd00dYY4xabWIbsKKDqrX1zVoK13BWlicaKagz8YQO6UUV/nJpKy6Veav3gyrQnHsfH5U4OkajWueFXXuw+T1/ofr+M75CViYTVjw31lPYzWoqzoADb4zgkEzlAISbp60M75WRrB16/p1KeW22SyCJnStWReDV+ARSpFoXAjcOLr5Jjvvk8lpYX6EPvvaLrSKlBSL45uqH4Q1cWIy14q7ErYek7c1SrnGAvX+ROlVqjtBR32JKl/QSCS69OrqO9n1FrcikEf10OPkL0IqOaN82YylqSziVymaTUn1BggRaw67gtl9Iedgflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9sqxIQcw8slm1Q/xRNZAxawHmGIEXFXjCrCAZ4Oxb0=;
 b=v8TradJENocwSCoo72pWlJNtPqbg/7VNxcgmwuWkFDp8R/7kzGrq8fUaZIDv7RIOhBNJTqOuK9qx/Y59zEvh9HFu2mPsi29ZjJ4sHv9zQOQWgN6njiYPltDiPr37f+epLfQ3mk0CGlrlI0SJGtff3nDfM3NVRuXmS/dUuyDiYsEVq78M9OGOTYx5P1rROCWqAg/SrwEI6dQ3iwR5DLNRaT+hry8Re2f63frP0muMDmlzNXuIMo5FzfKTdUyv2o5iP64KEfxuNGPg/sfMcHU1YeXJRk8YIZQv5cwUrrbVdgGOBhyHHFieZWGRWA47AtjPqVLvgGv5m7qrH95lmcDvoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9sqxIQcw8slm1Q/xRNZAxawHmGIEXFXjCrCAZ4Oxb0=;
 b=ZPimVrpjC2o1ModwFXXLA0yhWMX7qEso56GQgQkNyIQParMpg9/iJWwI9kY9t3YO0oJ1RTvsxMuVy2cjPJFln+lYHol+4hcuggaRsw2e8jypQFwvdXez8IsChrwkK010g6vPrxY/U5CLgRgG0CBloC5rm2HD1K4DupiGt1qGs90jXC4uiHWeJjKvPSV0QJX707WoVJ8ByyjkrWasB5v33r87onXz0FDWDWXwcvbbWGZ88kkLquGuHt3CG/CLcb0nldaZtjEBN0pCT3zPB55CKjdk+Ss9lx0gAcL1OTFksru7Ca18WHhX1ZDGiS2GxaMVBSeSn6DNpMUgFGUYDHbFRg==
Received: from PH7P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::16)
 by CH9PR12MB389485.namprd12.prod.outlook.com (2603:10b6:610:312::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:16:25 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:510:338:cafe::36) by PH7P223CA0021.outlook.office365.com
 (2603:10b6:510:338::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 18:16:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:16:05 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:16:05 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:16:02 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 7/9] cpufreq: tegra194: derive frequency domain from device tree
Date: Wed, 4 Nov 2026 23:45:19 +0530
Message-ID: <20261104181521.3003578-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|CH9PR12MB389485:EE_
X-MS-Office365-Filtering-Correlation-Id: 503809b1-af2b-48c6-f938-08df3a9fbcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|921020|261021123027099003|261102123227099003|11063799006|261021121427099003|261009223027099003|261026121527099003|56012099006|261028144727099003|261022105027099003|261026140227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	848XOY+QVmHbFa77ZdvOjgtVoWd/nxLlYA5f4wQfMIZT3jbYZZR7kj1zIQ/8lGRkRqaxU5kgeBMbTKWsqCMNamMZYI4JVz4fGqFBKkdPbQl0jNLXZk06RNTahJH76IhdvRLsKzdmL3g7qSCwMmnVHdkF7GoLrCvdj3yIIZAodXa8k8BmOraa6lMJpVH/mlPH4OdpauphlfcwfmHxi5jhxReshTQkkr8Mmuk3OQvcHm9tHnEcT8DW4QLeoLu+AJCt312Qqfej8hddDUaR5gTCx98ZniPjaKlWH/+bG0DeQ1UKHrOQEtf8HIo52mA0Cinm69eINHce2y2hH+ByUtIYV7lXRuVTyFjaJPBgcan84h1NmMhPELlEUH4L0qBrXeM6Xkh9czSdsNZTW4DxMbx/Q5qJkeGZ7/bnuvEtjp3EMeI/4aZFZXAvYpRv/jUbXAPLLXl67cali2q7IxTIYZSdG8pNqjVkmNtIyocZyvFxYG4krGDYX8xG8pQR3RFjS5Qry65rkpskiceC3/KVgB5BRDTbJqOYF6Y/CDdoeNeVSV5BL4wfuoLZO4VQy7wZ40oTvUPdAMFqLkC1sA6ue6pQBtPFWm7B9uFSnb7i8EUezWiXlB09+m6g195Knv8L7lwZOz1uQ1dmdC19+47EgQiRXnmR4p8CkdCLybKe7Eu5y0dEA2gJPv6RzRULQ4147NIMYL/Gzw4FRJVoKSTxsHRl4ogUFt6B+yKes8EeGP4pHUFI3hZW0ztU3NYtUfjezwJf
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(921020)(261021123027099003)(261102123227099003)(11063799006)(261021121427099003)(261009223027099003)(261026121527099003)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rnnkyG+G0+azx60LAyuU5KdU4apWNJrrS4kY+aX8KEqsfivpiIhNzTJij0aNBvuKMqbUI8peXHVzeI+lswlTVnrzhNUcfUdwqEn8elyK9YzaPCmps0rbDqFpi6UU/isaR4SJtDen9UR/XqYGAslQa1GcWLw4qI+Zr2nyzx48BVSYXHoL+oQHs0AVeHE6C8VjTDHNA7UqMFRSWeTF7xL6cB4Yrkzns6WYRWBS4CL0MUWUfI8XJBGpgRndj2GDI7LDhiZwZfqDOAb5eEKgNxhDu6c99cVrjofOGgKr+ga774ut8ecNjbYwRU9vJEXNjrlEbM8KG08hisHaAvM8iQb5m0W8sutD0Bd/NuSSp/5ln2qeXFvKdU/WtQY7Fc5Xgz1DyzQP7jTIy5WVJptF/Lqpuxf/G2rxSE6ZbNNkRSTSKT3oQV/rKlb4nDFusHb37Sbn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:25.1789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 503809b1-af2b-48c6-f938-08df3a9fbcd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR12MB389485

The driver currently creates one policy per cluster, so a frequency
domain that spans clusters cannot form a single policy.

Group CPUs by the generic "performance-domains" property instead.
of_perf_domain_get_sharing_cpumask() adds to the policy each CPU that
names the same domain, including offline ones. Without the property,
CPUs keep the cluster grouping, so current Tegra194/234/238 device
trees are unaffected.

A policy can now span clusters. It still uses one cluster's BPMP
frequency table. Clusters in a domain share a clock and report the same
NDIV limits, so that table fits the whole domain.

Store the domain index as clkid for every CPU in the policy. It can
then be used to select the domain's frequency register, whichever CPU
manages the policy.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 41 ++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 047166463efe..1328aa0a1bd1 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -42,6 +42,7 @@
 struct tegra_cpu_data {
 	u32 cpuid;
 	u32 clusterid;
+	u32 clkid;		/* performance-domain id */
 	void __iomem *freq_core_reg;
 };
 
@@ -528,21 +529,45 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	int maxcpus_per_cluster = data->soc->maxcpus_per_cluster;
-	u32 clusterid = data->cpu_data[policy->cpu].clusterid;
 	struct cpufreq_frequency_table *freq_table;
 	struct cpufreq_frequency_table *bpmp_lut;
-	u32 start_cpu, cpu;
+	struct of_phandle_args args;
+	u32 start_cpu, cpu, clusterid;
 	int ret;
 
+	/* Covers all possible CPUs, so offline siblings are grouped too. */
+	ret = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
+						 "#performance-domain-cells",
+						 policy->cpus, &args);
+	if (!ret) {
+		if (args.args_count != 1) {
+			pr_err("cpufreq: cpu%u: invalid #performance-domain-cells\n",
+			       policy->cpu);
+			of_node_put(args.np);
+			return -EINVAL;
+		}
+
+		for_each_cpu(cpu, policy->cpus)
+			data->cpu_data[cpu].clkid = args.args[0];
+
+		of_node_put(args.np);
+	} else if (ret == -ENOENT) {
+		/* Legacy grouping for DTs without performance-domains. */
+		start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
+		for (cpu = start_cpu; cpu < (start_cpu + maxcpus_per_cluster); cpu++)
+			if (cpu_possible(cpu))
+				cpumask_set_cpu(cpu, policy->cpus);
+	} else {
+		pr_err("cpufreq: cpu%u: failed to get performance domain: %d\n",
+		       policy->cpu, ret);
+		return ret;
+	}
+
+	/* The BPMP LUT is indexed by the MPIDR cluster id, not clkid. */
+	clusterid = data->cpu_data[policy->cpu].clusterid;
 	if (clusterid >= data->soc->num_clusters || !data->bpmp_luts[clusterid])
 		return -EINVAL;
 
-	start_cpu = rounddown(policy->cpu, maxcpus_per_cluster);
-	/* set same policy for all cpus in a cluster */
-	for (cpu = start_cpu; cpu < (start_cpu + maxcpus_per_cluster); cpu++) {
-		if (cpu_possible(cpu))
-			cpumask_set_cpu(cpu, policy->cpus);
-	}
 	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
 
 	bpmp_lut = data->bpmp_luts[clusterid];
-- 
2.34.1

