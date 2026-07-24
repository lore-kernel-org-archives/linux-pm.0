Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011054.outbound.protection.outlook.com [40.93.194.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD53C7DE1;
	Fri, 24 Jul 2026 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930422; cv=fail; b=CU5e53T9UvBYSUla95GTxcwPsyTNLyivZOkpms6rKaZuqQM2FLB+HAzFhs8OjOC8UP31tN5mif7I+yfLJ0IReueOGi9csJEQbmZxHbuF+5QfjVhdYglTRXiyOV5kgrEevhWHMf/ev02ZHkw7923u0kurUbZveExzcFylPbSyECQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930422; c=relaxed/simple;
	bh=d0ybNoDVIgaPlfalCibBMavJ0CX+g4tQGkvviMmzCdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rtn4dr8NE6GvcBLB4B6nx+ErhEDeurxoTXcp8Lf3UsRP2nlYJ0GyesEOwJ1rJ74UJ1B5jMsyD0uoIUpb+DYKMcZshvEKi0lIJglhB02hB3lX+QqpeEgPUqBLWI9kV4AXx64QUgy5Ipi3Ogm+MmFwe1dkr8Noq67emfiOBGdLZs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P+zSiEvR; arc=fail smtp.client-ip=40.93.194.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P+zSiEvR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHI3Jg8MFU3o7Os6uVayx7xcvqoLArJT/GG/laiPGA2jnU5PG8shshB2gopkZMDYGBNWf2CCkdwuuC1AflcuaQxIqL305FjhHAfmral03VFw8YLRl9AChSoCIN6D9wFZCyoQHxShdDHH3ovw3bXXR2XTkqwoeFv1NhYj+Gew1rz5FK8dLRnoMT9tcng2qIdFXSxxTy9dYb6cFa+1XKCcq9Q4ihiPiF0riZZIci2ldKXgkjVRog6IjyTY0q7eKDApZIUeKym//EJr0/cntmEPdtVE9cErLR1n3BWLQs8R7AbO1+mAtmkXECMyJZTjvkT1GTc3Z42PG0VyiPDTdO8RiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcQakqzXCozHk1wQwCVuCnd+7hOEbpKtzRROHOTDYWw=;
 b=oVY3GwamOO2oRIL/AiWBQFIsiU6NVEblYuxJYYEw47yU0os4E9aCBcDlMBgD2ht38HUcw4Fs88bcfi+JXtgT3cZQsuGXyTpNsmpD8p3FkemRTxeKXRPTGU5kXBhWySTuwxbtkg/EoVeMMUgNzGZ5k9opAaUw/AzdYoMF+D8rhY7sDXMx5baVAF5gE6eSGxbNToxXUMWwRC28BnBwx0FgDTo7TfSiKa9bp3urg1dQ+6G0qFbjVVyCjhZmugPHKkcTZjiMj3/v5SlU6P8XejY/XffxRLrjhIgXECoqnFdDhoMnYl7glG5wIKG53mlOdsIq9JXIsjQPeRygc1C36rCk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcQakqzXCozHk1wQwCVuCnd+7hOEbpKtzRROHOTDYWw=;
 b=P+zSiEvRow/uaioISucwct93dAmEAd9i5QJzmET4agDjLqthc0a/9m07LofpOFTJP8Vf/kVLjB/y5DWcXntCVhSMrAE/0npVc0RKGXW/gMT7xt2yj9YUjoW0spg7zM2oTsHGHeqj2nwO9P3ZVyCecz5ATuSaEjFJrvKoLDthsRjVtoVruS9aQ3LtVp71PGm0Dl1WidGYguWBdfixDXQNOws8wED/FhvCqtwYYTyPpBS/6QkPXeXykiyQ2euqPp4M4eoR5sxiilXjS0+dCSOv5IISprcrYZnc/7ZFK4VFTJgNSA3wLgZ1dpey0xbKfNHQz1pKV27HiqWW5Es4adyuYw==
Received: from MN2PR15CA0046.namprd15.prod.outlook.com (2603:10b6:208:237::15)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Fri, 24 Jul
 2026 22:00:13 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::97) by MN2PR15CA0046.outlook.office365.com
 (2603:10b6:208:237::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 22:00:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 22:00:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Jul
 2026 14:59:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 14:59:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 14:59:52 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
Date: Sat, 25 Jul 2026 03:29:34 +0530
Message-ID: <20260724215937.3368276-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724215937.3368276-1-sumitg@nvidia.com>
References: <20260724215937.3368276-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 311b1acb-48ce-40d9-d3e0-08dee9ceefa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|7416014|82310400026|10067099003|56012099006|11063799006|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ctvcSUMh9eepBv1x+f3uVNb9F7A+eDAKkX2GHpvv7WK/wawmdQDu43HanpNyQCF2o/3NBw4VYjP7pjeVf1hrRNHhUreN1PO+EX03wPNvu0+T+WPMHtODiHBv419WpktWDGrcXpaHJPZtUZpKnZbU6HNcLoDVWhsZl+/b0/58MOa2tkOQDBuqukxSB4gavvsoRLkLQdyCRaOCyYXBcbdpGn28EFfbWbKOGnVqCtbxZbEhdJMYbx9l2ZqiDBvCe6cjU/bj42m7Fe1vpQF7JsimDW+e49Fc6cox0PRhKiUkpFiS0vMeqKw1K5+eh/0BeKbraoqt58sToZZ5z+E/NT3ZHIgddpfVdhmSkIxaqNuZPB5dYB2roiqtuDLD6nE9xEHioUPM/Z/8cKB/2gwjlvozIah1VZLMmNwJlw0RKe5rnpvimeT8VYTjtYfJjTwEkvW73v5zB4DOdCi7+uPlG3ybAuJPGoSvQ8feluyXPA5VwR7HkFx52hjEVKEMwVeZNajF4OKdvnb3fOeu5uWuoFt+Gz+FqCbFb21MUx6ewgTLx7Z/CjbCjzRsoL4jOuEjges/ncjF+xXrY2bC/KPXFWOy1A1LuSQ0S6+J0BYemrCgBCL9K5sQLEZKvkat//tSZNuomywJjfnbK86MPyqtUoE90nc6mFamRMK20QBvydAWiOIaTUf9edIH0M4+jnV4FrouR2MADYy0YvXke8Uh/tCgHnkKSQw2UEeLKdy6qQHG+nd2T+uvPWrxCdmVIDOzlNRJ
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(7416014)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BN5a8muNLwD4m7g5QcFlqRpeh7m7bkzIAGV/golAf2FlDhjvpvuVoXwnAn/G5ePjnK1b7WOAmrHOIUTa1vH19LR8BxdC0NcFAcyJV/j/OQtto0nDvCWEubEbaJKf2OFLFBsyptORfUgfxlTX/6FYRmXCDM9IssZo/Y0OkukhTf0xknGEuXHju3lrFt5B3kL2ZLWFfM8x40q5kt1q10kOOrNW7IWu48I74706Adxfp5tASdbZg9igjsg8zBIgStMeFFFIsuJtYr6nIEtiaqsm5RC5WaINEKnZsjrWA/1fqpqmmbgw13Q2Or4f7iog+U2x9AiE/ZYngDC+HALsBPoii+kC7KP1bcfxeJp056v2lheqn8GWkHGsJjG44O/ShopEr6g9RrJjVUCYRcvH4tqw3wOt3anFsQUyHBPkN+jj1u+uyu6p9yqevDRq6lMhA7wD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 22:00:12.4195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b1acb-48ce-40d9-d3e0-08dee9ceefa0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

Without online()/offline() callbacks, the cpufreq core fully tears
down a policy during exit() when its last online CPU is offlined, and
rebuilds it during init() when it comes back.

Add lightweight online()/offline() callbacks so the core instead keeps
the policy live and reuses the driver's cpu_data across CPU hotplug.
This avoids re-reading the CPPC capabilities on every offline/online,
making CPU hotplug faster.

From online(), re-enable CPPC, as the platform may have disabled it
while the CPU was offline. Since the policy is no longer rebuilt via
init(), online() also reprograms the CPPC performance controls
(desired/min/max).

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f6cea0c54dd9..6dc59f99d880 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -722,6 +722,48 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+/*
+ * With offline() defined, the cpufreq core keeps the policy alive when
+ * a CPU is hotplugged out.
+ */
+static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+/*
+ * Re-enable CPPC when the policy's CPU comes back online, since the platform
+ * may have disabled it while the CPU was offline.
+ */
+static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
+
+	/*
+	 * The platform may reset the controls while the CPU is offline, so
+	 * recompute min/max, clamp desired_perf into range, and reprogram them.
+	 */
+	cppc_cpufreq_update_perf_limits(cpu_data, policy);
+
+	cpu_data->perf_ctrls.desired_perf =
+		clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
+			cpu_data->perf_ctrls.min_perf,
+			cpu_data->perf_ctrls.max_perf);
+
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret)
+		pr_debug("Failed to reapply perf request on CPU%d (%d)\n",
+			 cpu, ret);
+
+	return 0;
+}
+
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1034,6 +1076,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.fast_switch = cppc_cpufreq_fast_switch,
 	.init = cppc_cpufreq_cpu_init,
 	.exit = cppc_cpufreq_cpu_exit,
+	.online = cppc_cpufreq_cpu_online,
+	.offline = cppc_cpufreq_cpu_offline,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.34.1

