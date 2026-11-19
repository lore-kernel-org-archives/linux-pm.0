Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086828;
	b=S/Re15zW0ncK85I6z0tk4lNGu3azkt19v0u1ZWUd5lzmuPjQ9wrdEeUbLogLzI6uuK65
	 LFLEJUgV9TGm2E5B+SnDYh+8l/XaOIBYdQ96p+heom8x5bqKNT6nuCo0j26qP7vit6uTJ
	 UhxMy8Q6aABvrsXI4CRFPHwx33dSBm0AZAZGfwWsv7Tw916IS2ZcdcltDeyb6Wv7/iBnM
	 QWu6LC62seAB7Sx/LK7O6PtwumfDOaNhAxGGmIEFU5lGCgdwfFl+MK+c1sLJN4AIj9XjD
	 J0ZmS7GVrYKoDYCbAajfcvfQSxJreBw9w4/jazoMUx3uyG3kfo8NIDldGf9LZSGT4AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086828;
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
	bh=M6kPvuYYJQ0pAT19TwvLePgPnm4sH7Ztevxr9Yf1Mgk=;
	b=0hv1e3lulQQ65hiexpYfIycpzMJivLO2J8GBr4Jpe+0I0h10RBYAxIUPFZWHqr/Dy75s
	 S/gCUlqH5Zi9XJjuyXwAYh5+2kX/98OvaZysC3nuAc5zx+Cfma/dYB52P3fPl4KeqajUQ
	 31Q8yKQ+YWujcarVdbsJJqN8xY83zDfnhHRDRXtjzX1rfJQfJJaoX7F2I4/C7WNNAy4xG
	 vWIs24ccZQi0yKOaYSb/v901dJaGTB7GEPkfTR47OHB1CSNep+y4ihwARWuBTpG/0Ol+h
	 rhadxSigRCQ53zItFbibZiB0eVYgvwztgbZBeI7zcTZ7pcpHslGMsEe9ZmqEhcq3RTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B97yJLxw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.31
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58709606A32A;
	Thu, 19 Nov 2026 11:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58709606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=B97yJLxw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYFyOO7IqhQ5/FW2CJrj2HWho1dPxWtwVAQZ+dZ21aD06jsy8J7LC8gflgArefKVGXyKN+uaKdpAuE5tIUK8YG7MMHls4T//vfNS7DPAGQtwQGIKSnQNWJIpj0G+5a/5WmSg7IV9k/pYOYAVtOiugPAXsssfW1jBwWcwOEG6Vca6zEEP6am4aGkdkNBWi2st5DX87TPIwlWc5QNm5J/MCuEs2g24QEk92CMX8RVAgGyez6dWA9ZSdGunD6FW31nWj8A9zD0udAjauuvaoZ6gxb8rYmxW/PwhBLrIG+sIjeJ9G/SZo+3M4qC39Lz3rqPe1gYPvRG02nV+dK1sTDlhRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6kPvuYYJQ0pAT19TwvLePgPnm4sH7Ztevxr9Yf1Mgk=;
 b=bKEVAETQCDu+0vdLepM8fPGw/XDwIKe4TYwpjO2a/Fx/JWjZ5NUUdOKLMNqjPCvmDbVBrVYJuoG7nAikUqJPvRjc/CFSyb1qczy48SNVQuKqLDIRm9WqwZmLWoELzkQyorpaj8qpGMc9KX7oWaBWvCyfj8XYIxFvkIRifga1en4Cxb2q1dOZOuMw+2wlMDILwv83F/WhmikYGQxiuCLFj0e+1xUyxmF5NxZnE+hINMtQFvHA/6o6dqst6KloXU14JP9x6ibQg2Jqbjz73aTHZbpb+WyjK62KjpvtOxD4EEdadoZ8dKljaMQ8obVsfratKn44sNsISvQ4BZ79jBzxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6kPvuYYJQ0pAT19TwvLePgPnm4sH7Ztevxr9Yf1Mgk=;
 b=B97yJLxw50N6+OsuYjP0vjjzq4RLht4Eg7s4LYLLkIui7h/QedRF4KBnB94sZExquNyeNYHjsUPMKLXdtF2fm3fHJ3eIYBloeki7nFrS1KzKt5gliM6J4eVBAqckZwmavfZ3R0ND/ATbc+vrB9kb/r9ZF8ahpc0ao3AT6+X3XYcpwm89x5t4Ert4xknxWw0ZofU0qb6KaqwV1ugu1Rmu3tznnEdiMGOyQtKYPwlq5fwLZKFJlk0w773UP+rQepcCya/HFotEXPoR9H5lbMbUfNyS7kDJmwv8VKIIuwsIAWhvD7WZ5lSDVEUKfXL4Uw7DzqI6hl0yKYRy0c5oy/DwiQ==
Received: from CH5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:1f4::23)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 11:13:42 +0000
Received: from BN1PEPF00018545.namprd05.prod.outlook.com
 (2603:10b6:610:1f4:cafe::29) by CH5PR04CA0023.outlook.office365.com
 (2603:10b6:610:1f4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 11:13:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018545.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 11:13:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:13:24 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 03:13:24 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:13:19 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 7/9] cpufreq: tegra194: derive frequency domain from device tree
Date: Thu, 19 Nov 2026 16:42:15 +0530
Message-ID: <20261119111217.902071-8-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018545:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: f42a98b7-ca87-4d2c-8ce1-08df462e2b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|921020|56012099006|261009223027099003|11063799006|261021121427099003|261102123227099003|10067099003|261021123027099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Hc+EZMwPKgNcRB5y6IiiqVpNDmmIqpNjFdbY4V9YUKhPKfAPtVsCZnFcDzg/HNtOxgCIWscwZkIyS7/Au63oTXNnREsCCHNOeQmnbULRpSR+2Pke5RRTMZXkXxDCs1ZUv2aWfoAX/eOCTQXEdJYyLFpShV6peoAHatnj+JPlfQpb22vXsyIrAz71P/Mfk+/6O20PNXDB0B/gEM3q6AjnfalNig/mRopWErPhKYpzkhgdHKLHGdujqXmSHq8WRdfg49hlm4/8oQdABBOzQBe8Tn65i+YXwtzxVupOahdaeQnJ90Wl6YiqhzDCzOftau7d+zN77ffgTtmfn78dARZN1Rv3k2ZUzae31g8PTdESEV4pp9bGG3EQEosa++wf64uNoPZaNeAsIV8tEpgPIWbOeOm1MErMBidP3HQQeZJvmk+KaTPsznvO8nNrq8QjcNMIsOw5csj+CPBaxhcmenmSWnlJuEwh+Lu5ZghpMX5E4bu8732zNDVV6CF14O8OBcqzxow45GoWwK6WkEGjEQOU6Cq0RcEbJO4XmGRjOc/oCD1ml3wvdmlgdoE8vkE6f2+3KKfhlXaiGs+nuQnYiFN16TXHV81L2RG9V5i5UfayxU36wh74hijUHfvwNiC2BQJo0Dx4jfuiARqvjM9Il/webS5MsBbNqap3dIY+i0vXBn9cSHYkSg6kkIBgNknwP78FdkjDtyD66Vl4Id3mGoYGEuMQbMoRO35A6DopYdTguuiE759BmKHKfWhvOYqvsjZX
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(921020)(56012099006)(261009223027099003)(11063799006)(261021121427099003)(261102123227099003)(10067099003)(261021123027099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9I5h2Hwd2DhoSjJgdc1jxpX0abuJCPCsIKzid59oc8M7AKd0m1kRX5ntQLgj15Pg3VsZJoSliZ/YVaArjTWZz8mZJmfBsuOdQ3UpqqkSlRJtaJV7w1saIrAwUP4Wf9YFLpUW/4nGCWAMOKSa3uPSUNEUAOX0xIzaTd1o5gjAq/if4kfeX8wZLOfDYCx8snjXLrePlIOdAlLsJrXEQBKAW9Vg4g/u/AW+tZbGnWiBrqhVnSXmWLOJtB5edvMskVjG2U2bxDX2YiHwT80SeNpnqvMMqhJF/bkcifVTAEOMb0szzaT3UOoc+MNSceIf0CtYL4PvlmNtH+eb0Z/k/NC7gz7R6/5PEVrFNy4NpzY8dWte71Oj/fdQ7xOALj30V1QVicswMjdTRisDKN3wTkdbxPB/mSoRhubpybWi2uJU34m8S0EFl2oIvAPugmG0ur+5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:13:41.5607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42a98b7-ca87-4d2c-8ce1-08df462e2b35
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018545.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774

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
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
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

