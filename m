Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B103101A0;
	Thu, 16 Jul 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216354; cv=fail; b=TfYB67SosVJ3p1TRwfBsz7dyIf8GsJMbTbjCOW764E5tGvvJpx9UyDse5KG1wVrg64WdtVpsfImEZPswCeEll9XDrExmz4VBIPqpTY+1UVOKb7Zja3jUJWla4gkkNJByrXKRsUjJtvlbKnV58+8tvqHCcQJqYl5DK6OlFdjg4rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216354; c=relaxed/simple;
	bh=wfqDfs4fkDnnvgIcNBYGTJHDDQ59MSNDr2A1kR2FTOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYwhY4qnR0XgwH64L965j3yEX5aWkOiKN69X59MklmwHktkj1tqyjwgGIY1GNCT/dU/rBUrckqDnPl+AL4cprFQIH0oibEwtfGor7PXkJk40vuv5c5IZGhZ593qakS6HlR9kqZNEQXXnTRkM9aZg04OvHCV1ZEnmNHxcP4xns8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=euLtzcbG; arc=fail smtp.client-ip=52.101.56.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="euLtzcbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhVbJcTA/hCsdN8JUfBmRj4cSqKK5QqnOIz4Wx98wn/g4jfJ+SleV19ie7s74xOgRQbsxOu/eTEGK8AnsjmElBVFFaVdF65sAtneMbEsOuwoJ5LsfB4SvN5oSDgyCA2oRPnP1z00YXc666bxDzG7ID4Y4uWIcTlspOYP1DssNoZgh3jeBR0bA00VWE0X1vWGOes2GRceaeKzTWuYV909P+ELK+3hmwFUockglh/eWWxgYaZd5zm6Bzdya2b4fO1MX5+T37WMKzEA1VeTxgC/M1Yt4iUdmgs8a4gHza0zXxltPGW8HqDv89hHBP9xGGEX843H8VF+hbWDca4fbQ6D3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj29c/cEEAd4OFDhrjYA4g8m4A6zm2sncScEnwvYe20=;
 b=pAliB7OAz5AogneHh84oqeBpRpyyn2sZzxp3rA6Q0iqbyZhXf9Pi8NNpJNPDKQquftOQsr5fVbrK3iudrbyXbKz37N77kuTPH5sq0kk5rEj39kMfS+LZHY5n0KqJI1GgTHp/u0yJYIODC5vML4NQzNZJn0es59FnSHOft1ScNKkL9hxgVLfl3y047yu+wEH076/YgN5V59uzwF0Bhg3TOf35074qBxeDdju0lSfoSBVr47JALlG9QNKXWEpkDEqrd+UsTfqCW/WVqpC8td/duyuVoIsxEPQT+yBrxhjmlHo3wT/HGMmERIVjLclHYQSCmuMJUuccUDjYcQOLxuKw8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj29c/cEEAd4OFDhrjYA4g8m4A6zm2sncScEnwvYe20=;
 b=euLtzcbGj944xg8YRcCJ8O+0vrZuRY/CmzpG8sClB6DMKytFXmf2gOFtAUVYJV3Efk5dHClzWd06u7nHW2wRPHOuPsufQQXd7znPZGFzyinnuQ6Z98ZML12EKGASaoqhpORPdvit24U7i1s/vC2toWi1m5l8Kp11sDQy/iRSmfh5Q3tcsAmL6ICiIvlmHnmy2XSaZjBMR+L367acuPI52yyu4+KREHI2VFTPz3scd3XxLMYUzkkD93E1d8xqgWWn+icXz4o+F41zTu0QRUXNSi5A0/KRjOYizrERrcYNKZSov2kE0MNIhEfb32wcLloH59I5E2rCUz6AsZpbcb3xkQ==
Received: from BN9PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:fb::26)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:39:06 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::5e) by BN9PR03CA0051.outlook.office365.com
 (2603:10b6:408:fb::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 15:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 15:39:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:36 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Jul 2026 08:38:31 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <saket.dumbre@intel.com>, <lenb@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 1/3] cpufreq: CPPC: Keep the policy across CPU hotplug
Date: Thu, 16 Jul 2026 21:08:18 +0530
Message-ID: <20260716153820.2007095-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716153820.2007095-1-sumitg@nvidia.com>
References: <20260716153820.2007095-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 9922cd42-52cf-4fde-96f4-08dee3505ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|36860700016|1800799024|921020|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M9R5+jd+iVJxTgPeZRvA9eRQO0i397r3irU95YMSWhguHuaBnNG2hTFBGWXh+yWSOz50Fojaps3jZ3XElAU8YErxWpxH3nEeuSYIJsJ8jr229avD1yiwK4BQPAN3TbOZf2iuB/EK0rxQXM2McIj7Cz1wfrLzKK6eLPA27+xydDktUIr2I1Lvrst6vNWsTwt1TFsuce5kWlWL6CKLCZPtiJpqLrUg+XgKKcx4VNc76PguKwyqRsWZC1UtCZGZZT+qZrR9PVpuaJJrEkAj8sV6zBdXt9Ki7bjf5X+UKniipT+LZiAIo0gA2vRnXBQUN2MZKB/zKmB6u9xNSlobc/9dCyTxkct3hFx3RtBe5reAfIUTLy3LMA/DhExIVH7GYLs2LSmVkQdaskF0ezDEacw9DZb8NAG6mxhSuGDZf+JnVHx0sAqA8+3qoDhmD1mkUE9rcSnvAwY9L73Ma4qRTSTUQ386icPz7SPgXRdYZ+6n/UNUnlbQcg51mOI5+iJedwt+DlD3z5kniNXS1LcyXtT7i+vFAUukNE0M+qU6Wxt/q/fHZ9fhL/LlpO5oSFhaFdm1d2KyjSaYJGhun2vqbYADJiOV/RJovxlHYuICX7ZRf5ZunsvcsLCo8v/naPaaDwS8Ff1W77pmAC0cnKvKfvLoNhtGTX74M2MqGzuqybtfrDwgT8JOqtzPg7QnMG39REYCY3B43vcd1MCjhMbRJ9027bLXXGNQjQUqkYoAKaT3D6YhzOAJhfGuPPspy1kMpwf8
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(36860700016)(1800799024)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gxXIfFLoXS+QXl1tOPBLl5DmbhdkL/1pQjmWXv8DV58QW1yCPP/nNgfSBh+/zvLBjEIXZhQyISJq55V5hBBRhdc1sWZ0V5z/KDT9t18lz1sGfGDhX24D6fkxM8LCcpx7o/9VxvxVV8i2wzkWAuLZhyeEn7szx9rGtiZ4o+fDRmcx9dT3txZy+utqFVzjbRvA902TZMG96KCilrOMaV7J59Byojm2+rwxpOQtLRpfsgWWZ3CZAJgUGGgQ/gMNH1VclvgroFIPGZ+Ug54g45YVJLvlT7WyaBJ4NEZyu8onEcrJtBzxGHTQ9NrHRmvAhVlIP0wraWvqsI+mOT2kfcpdOgmX3ypd9CF4rF4slmo67XD/Lq6YG0rA8Vs9Z8+6hnJ+XiA7UEFGtjZbEcyCx3cJlPedteCQ4ORY0YCuU4y4v/LeRdwF1O1DlN647+cPByL5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:39:05.7582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9922cd42-52cf-4fde-96f4-08dee3505ebe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

Without online()/offline() callbacks, the cpufreq core fully tears
down a policy during exit() when its last online CPU is offlined,
and rebuilds it during init() when it comes back.

Add lightweight online()/offline() callbacks so the core instead
keeps the policy live and reuses the driver's cpu_data across
CPU hotplug. This avoids re-reading the CPPC capabilities on every
offline/online, making CPU hotplug faster.

Re-enable CPPC from online(), as it may have been disabled while
the CPU was offline.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index f6cea0c54dd9..432c6a6288a7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -722,6 +722,31 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
+
+	return 0;
+}
+
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1034,6 +1059,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
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

