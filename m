Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930695;
	b=a4/QhYnWP8G1KvfZFOJG9jGq6LwLyi7w01vRSMNhAfy9foqjLrmzqL7jQjx1W7Rk6I2f
	 iB18mKgNZbFof0ewOVhgrww73ygtTSLIbVQ+w3yOEbR8bc6gTKZNx96PPwux4+OnTE4f4
	 t9A80n5NVE7IO1kurXDw9r+isVcFNDNDuv12vkhv6dxdCkYfDEPvo9HypwG8IV/yn6WyD
	 JQ+e/l7RQD8oUyYdDb3UumxXhOkSBEM0K1WzDTs6QLoMLuGxKiyO8hUqn8DuMyPc9Skjr
	 +edr5AnUswcQ04FeyoCx1p+UT08BoJb/rxbmXkXE9gXcU7K9PhSGvRGsOU86u+u407A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930695;
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
	bh=TKvqZ+9nN6vHsZtStojZVFN+hP4TWyCIXzEre4P78lg=;
	b=1tzsvNnbPgadXgZKNcI40zM/gowNmLS11nWXUEM+4xFNPiJHQreWCYby53mztbZeUwU1
	 KIvhjx2tHLo+RGzDIUlwQ0cCs207xK8z8mF6X8z7GraXouw4K8uzR7G1JMFQ4iUk3VaKb
	 aU/d8e0TIOqldEShmNB6VTo+wnKvJ0Ze3cbsdhyAqqiy9Y+ix5HRNcFJA2qHbAEy/fm++
	 f6INsy8x22aZjuUniUz7HduDJxt1iL+0KdqB7Wp3zmyx2pqUVFE8ghCFE2Jf47YVa3/Rn
	 fYFcj7S14M2WJSw71/+jYaY7zgWxmDwOBLVLvEOL/OOyrMdkqO6/OdK4XkbYRvdrYVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jWbgsQlr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.24
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBC7606A333;
	Tue, 17 Nov 2026 15:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BBC7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jWbgsQlr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfee+VLP+6shA5PyD7Zlddv9aHYLqUIE8kzzEEr51Zf+tYWg2cNntlS/ooypFUyEGURRcfYrC27F7de689MgyzJSC9LFyLPeDvsH2p9QALSn9qXkWnjVDa80g8x48yrYd28za9ezU+qM/sUvmMuFxiWctpTdw86+/j1MTZSbLOyRB7dMYguQ5xoEl+1g6RA1scQPGwynqqeVhnjNpGSGMsWcqhWB78SezgBv1FecMwHbuHH5xgVDJIpVl5xKXUUNJdPDB9chQD1mHx+hzR7NDL3BD+7xxF+jNvlbZyo8nCZiqeyP23Zpv7WRYO6HuzRdFqHtuH97UYJXa2yCVX/vCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKvqZ+9nN6vHsZtStojZVFN+hP4TWyCIXzEre4P78lg=;
 b=dSth/FlP+hkjnjXKGTcmsGVnAjPAzj0QYi652R6oB3aZhrXpWBNnEZTT6spNm0IKKJkDQgMq0vbXNdVtfAmB/QU65wzC2bBC4Vq8D7ddRGm06Dk5qSs0tosL/kq7/+Zzje5cWKWyWuSWMbmhtCYGG8kbfUDhAL7IIcqZIv5x9P0UGaj+j5thT2FxfpC9B/4TREg709aefI3R+caeExb/yzAUcpH9hK/IqnHUCfSSR3Wje/25WDhBOSNwoXk9p1SipYNFVPJtd8hgZJsVBSMUiapA4fug/wQ9QPnrAWpbf1pk9o1AOEbZB5oQTTAxnZt+T7p6OsW8Sn+eggjlhoIPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKvqZ+9nN6vHsZtStojZVFN+hP4TWyCIXzEre4P78lg=;
 b=jWbgsQlrz1Ev1Li67ZOPfUEwcHDJNvK113xY2OjFl/eud2S3N6VrwCuIRchJ4JamUBLvDRzMbMWoyxVRwsHFHWKXY/ZHXFueYWF3xpkU/IyUnoUfgV47Ag39t0BfaunHB2cItd9uFpSQp65yJ0I9oq58HasvudcPyDNkO7GZPLL+YuJ+x0e4O1DBWmU+dzrVbtm/s/crWNBW2VdvIe1Q6WSBg+OxoaPikr5eCsDSfbfRL7Nwkd0tb/S9YMoj1nhop4jrLkKUaW+w9aM8o7WoVmUJn2u9n/yZ4yiYPQhrjzoTQItg/FRodBa8dYeNidDLPd/cOD3K2DFIaAORSkuRmA==
Received: from SJ0PR05CA0208.namprd05.prod.outlook.com (2603:10b6:a03:330::33)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:51:26 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::17) by SJ0PR05CA0208.outlook.office365.com
 (2603:10b6:a03:330::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 17
 Nov 2026 15:51:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:51:22 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:57 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:57 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:50:53 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 7/9] cpufreq: tegra194: derive frequency domain from device tree
Date: Tue, 17 Nov 2026 21:19:52 +0530
Message-ID: <20261117154954.625126-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e8406e-c80b-4b90-02b6-08df44c2a0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|23010399003|376014|1800799024|82310400026|921020|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261026121527099003|261022105027099003|261028144727099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hFq3sL8zKKlisbphVKDnZfoN1Ynyh9IZps8f0AHSWzpcCgpGAWVmn3qX6XSZ6bpPq+V44/H45S/aO4wxP+rzIYXwkBJj0NUF0cadhlTpWFLZDVjBNa3i+kaxymP7gXwpZQ9nK4NfnWY2K+WeOV7Ots3ADpN3V09lBXhkuLg5kHrS0yS29s2WMUpP+cbgb5jscKtdjH+Qk56dfayyniwOaBTkwT2pjlEZxJGGh8i+o9ChOdB9vuddOfDrR/dWy44BIJ0gtC4rZn0/hB5kB26DlGI8bNzanVOPI3rrmlNCPIDhV1gt9SMNzyY/OEdP8If6Gyu4IrcDAx21DUpLF6VmV3dBPJbdX9i8pofk2N6YnjPUkbsNrMk1AjCiMy4vW/HiePCdq2gSt4CZ8aAUDjZ15qqcLo3UyU6DTBZ84qkLvPsi+l45cmfRfbwwqctglkCgDq5wihIQtf+edgGhA5thsMrSeFQVgmczN3xeTUVJcwhmUZP9snwSAviOYSAonmm1SzU516oX3rUTld2qM2Svo1sLj1/94kftLWpuDg8eKIG65K0xwY/T7KBBP+aKEhrJFnLnsoYuBnu9z3ZEla+gDXMyJrSqn/HDT/CWO0fqVbiczxlc/IEtDBpCPTb/WDz4Er7ypLYXxoF2MLLwJRwf0jNBRi+tjvgBQCZSaQfGiSYDFb7Ukw6GrxtheQ72ZzyqzW0Nz3iNdIXXLv/QY99F7sXhVqlOIkvjElZ+2WqAwi0pM8FcoEhP8sppOlTLr2vz
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hPVKSwz9HMXjL55+deI/tacLltd8da2isCl8PqP4/zqWWJaEUX2hZbnQdsFbiIEh2pD+XnVFaby6bqEuX2WmUsV9b1HyHhwsNT+85p/yNn4OK6BJNEpdD5TNajCqkYNhkWF8mNMSLkofiOrWf4uPNVa/WpvH8lC1P1F14oqzIOR6I3x1o6RleE9/BsaZ/4dWt9aFDaV2/+RRzCnKcD/YbcXKXeVU5mr0Gge4v93DXzdG64ESZOdTYpvyE9hwLHCv9lJGMwOYemKmB1ZLjfUV1lcLR62GwA7ksip8DZZtls6ZiQB4cW9NJqUMSK0vwKNVAilDHL0Umlxj17F/k52NJC8rsvMO//CDnRYTOVBLV26/0tK86vUlpX7zZViwIki1IsVd0VFjqaP/ISyizJTsXBuXKJQMmC/XyFG9yuuA8DuvW/Jic+GCOubEEgvrexwx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:51:22.4838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e8406e-c80b-4b90-02b6-08df44c2a0fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684

The driver currently creates one policy per cluster, so a frequency
domain that spans clusters cannot form a single policy.

Group CPUs by the generic "performance-domains" property instead.
of_perf_domain_get_sharing_cpumask() adds to the policy each CPU that
names the same domain, including offline ones. Without the property,
CPUs keep the cluster grouping, so current Tegra194/234/238 device
trees are unaffected.

Store the domain index as clkid for every CPU in the policy. It can
then be used to select the domain's frequency register, whichever CPU
manages the policy.

A policy can now span clusters. It still uses one cluster's BPMP
frequency table. Clusters in a domain share a clock and report the same
NDIV limits, so that table fits the whole domain.

policy->cpu can move to a CPU in another cluster. tegra194_get_speed()
then uses that cluster's table, so check it as tegra194_cpufreq_init()
does.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 44 ++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index e12e02d14d73..fb95ddd66966 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -42,6 +42,7 @@
 struct tegra_cpu_data {
 	u32 cpuid;
 	u32 clusterid;
+	u32 clkid;		/* performance-domain id */
 	void __iomem *freq_core_reg;
 };
 
@@ -421,7 +422,8 @@ static unsigned int tegra194_get_speed(u32 cpu)
 	int ret;
 
 	if (clusterid >= data->soc->num_clusters ||
-	    cpuid >= data->soc->maxcpus_per_cluster)
+	    cpuid >= data->soc->maxcpus_per_cluster ||
+	    !data->bpmp_luts[clusterid])
 		return 0;
 
 	/* reconstruct actual cpu freq using counters */
@@ -534,21 +536,45 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
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

