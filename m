Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930641;
	b=Mz9toAsB99A/vbgFwOhs+UcecUByWEmVuJ9POo5zi2jkQRT5RO/OR366+WBN3YBhDxNe
	 k/JJW2ppQbrIufSTGrQwSPszIUgG+/B9NtTOhBHW2QpSJnj4KnUIKa47VYFWqlFObND6m
	 cfTjxYoTxYvWUC6C7JbSYZN2JO06ql7d2+E9+gWgXNpdwYAbZY5X+4zHbnJkc3l0gz673
	 p8hlHmVYDYiEKEn0txh/wWA9qVypPau50H+Jh9J1s1Nr3s5BQEkA9yX3UBM/wAPtC765O
	 ucVSW7qM3zyODp4yrGNwR1Tpgp5PogfoAY1ZkYseCPaLZ2CVOjacn9NIBwKzDwScPNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930641;
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
	bh=34r/BrnqoFXcU3BhMNMWp6BX8tNNnBj4+HTJBqK5pA0=;
	b=bzkJDushEv7ou9B9mKzd0UmNNqi8K1vZDVtBaqcdZWHaKY+t5LTExPmQQ1i9XqwBmsEm
	 XFtVOeC1KsDrjqi666lI1RvKhjS4lG+qoOCTA7jVa2QpMWvrEZ8GV1kkluQnWYaP+hyzl
	 xmArOxvDYy73aL68ISYHMMmUpDcPcVbcfkpzOHAhnPVt4uryWBAFG9GHHLJW0/jLb1Z11
	 ihbhox/gVW/NRAZqLR7RKIVXuSQ/mhvjhtw5G6Rgj1mCkDdvPpqv1/Znl/kUzjPx5zvlR
	 EnHKH2bmyTM2D7Y6GBMaeeVglG3whUkANTC9W4aAUY479+o7tegu57S8I+ctCnhkhVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gnNXfnNM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.7
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B0606A32C;
	Tue, 17 Nov 2026 15:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37B0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gnNXfnNM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ3vs4Yp3DosN6DJURsh9NkG4J6jyKlFx0URL9ZSwC0LNkpaECXveX30bDTm5cCK1SlhWsXhhF34F4HDHiDK4wdn0qUVnTc6p9eFA4Fy6Q8Gpg8qg5w6j1GgrDuHA1f6Xp1Z42e5dA2OU46vKUw54pRNck2X7V3m/1c3v7iPGarhsIibo1p7VzJRXJaBFA2Zu//X3Wrz/42scAW6SNtNZM2/h/XcGIR6d72L7LlQps7+UctTozaWNCZcXyrKWHlHMlG3fMX/+9/T4WcVumFepixnxunLTmhaCubYJUAsObgCoan9+H1vE7VhuDGthhcSh9bYGjqkJtXt9KZHQZO+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34r/BrnqoFXcU3BhMNMWp6BX8tNNnBj4+HTJBqK5pA0=;
 b=rkyUcA19t5SIowaug8MG/bsdkTEA1C63bjYxtlAG4bDKhFzBQiMCw1J+AtCxhFyKWl0XAxAeA+VL7fkdadZ0zQ/lzZFXQGXXYpa9dB6sOyX5UmVZ+KI+spXHKnPelv2I7T6rXxwcUBvTo8MmSdGtroxySmkVCFexYLHT497AwpespahbzmJ6Ac7k63ny+JrUnCxStUoEm9QNlrryeZsX/sj6L1hcNQZx2alUkdI+HYTp5hB5fm8qCaNEaCmjQI2gSisn9y3vh5A4mQttnDa0Lf7Kh6v29BLIBh3yT9TRPr+2z2AsL1TDdnugl/kDkm8rq+ODdEJHvWRb20C5xY3GaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34r/BrnqoFXcU3BhMNMWp6BX8tNNnBj4+HTJBqK5pA0=;
 b=gnNXfnNMHkaOnAHAJpPQmKHWU39cL2OLHf3BkkHfNQ4Z8HAe9bJ9tXdTEx3678tpVGk8+UF+AospHFYHX1MiAdy823zauXfWQtNGDurRvRMhc1aDV43z6CZ0hC14wn8jQIWG0aaYFSaPOWULEUd3axNB9PmFTT/bFQ0F0TdqIHi0hwplAcxkb4+Tj/ci9JPcJje23z0wzchptZGwPSwnhGUyE/y4iA6Ifu6aHZUMq3vBj2YpdtpW3nxqlesodhOcxD1dOyJBYtTDs+VaaN/Sy5m85g9TeQA3jAMaibaXbRgbPnYXE1SFid1aYH5PXj1wx6ARi+t2oRZu6UpaYD32Kg==
Received: from MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 15:50:31 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:87:cafe::7a) by MW4PR04CA0211.outlook.office365.com
 (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Tue, 17
 Nov 2026 15:50:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:50:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:12 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:11 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:50:08 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 2/9] cpufreq: tegra194: remove duplicate counter sampling loops
Date: Tue, 17 Nov 2026 21:19:47 +0530
Message-ID: <20261117154954.625126-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc09dc0-e074-438f-4931-08df44c28281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|36860700016|18002099003|22082099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|10067099003|261026121527099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	YOzwo6P5N0SoVPjWLwCXHwUuqXTsuZ+uPKLogV7QcdxfWf9XXCczNYNnqGk9Q0Rk4zCPPmmlkYFTlA07VkToMPf4m47XERqG9JZcEbvX+hkZOadJOJpqgdlYJLsMiNkPhfJEmgXhUuAQI1UZWY2YFmfKhHm+vnCgpI/Yz539ZSLmT4tGJqb5918/o8DUO0FVRm1Sd3NskFZL6HWdi3ng0DMxHVdH9ERijhgDVfCCGYVIfpeTwUhUZCFxXbmHmDw+XB60zmztjqFrZ9pjgDV4dVI13RejH7lIRwl6UeVHCKBdCUdYrJlOf09v4Tx9sWYeArK0hKTPxkUojJlgWL/lKjgFZpior61Sp1Zm80/0UJSx/tf65LrMMdN7+Gk54uXinRWa38ipQ2m/QkYqp8YxVUIWphBCGr/RmpE4JEAClW2UBcMcXPU1TjlaRbkmTBv5brMV5poWuaGmw6qwJyTA8yLgCK8RlhLsYLUKDTHvW59YE9VHCvzckAbHiR0ZzfriclIjHmDdugdEpdloGZAU0aCozBW/oSw49/JR/Wot1a6dF/7wYuXzmQvFKyJ9dt7UJTi8GlVloRsg5GuB0h6t4aFwmH3/L+0wZECNS2+Kl2rBhcOHAGAr4kzfDlxEP1ViFMUQrr93Yn6VnNpDogqiRn6IoGTmZrEqy56lPQFWucEObFtoOy+DyEuq2263FUKyrwpfE74DyQOVp/ZiZOTzVYM1E5ePtuMXhK0mu1oylJZShBPUYe1dfgusKiTmaUTo
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(10067099003)(261026121527099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W0oHs9VoXP8FqALivb4fL75gPkCcmVX/SUu+HKoUjpQ+VlnJAjh6IzuusXlVg2hp+gjHC/HbTZHh1otnqxfIGEU0nooiurGs1AOUdmcpzViAyTy1oRWE6R4P6ZCk+CTbDZKUFJ4tA98qasPq+rirsnI3nhDuR/5CkkoBkVqjDB9NcTBVzmQCiRHRtXXAVTkxqrVMN0gjx7YF488UvdZRr5OeTrYi69zE30emTm2AqmQriJ6/Z5jVooUFvSuObmLHj1W2wsFf41v8LAgcTus0e+pxoU8whNpTBZCyWd4SVqnRfCEH+Fgxja9+YS0bcXcQbQw4DMfmxcP/hdNH3lmNfb6J6qywhjhjrFskMT+tP02iTFu5Y9ToACSuv4qTEXC2n5H7KCaxOYHxwnl4E7318mec+08kvfd/EAPeorSn6T6OsiHyO9S+76auNe4qlWZ3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:50:31.3379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc09dc0-e074-438f-4931-08df44c28281
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635

Tegra194 and Tegra234 read their counters differently. Tegra194 reads
a system register and Tegra234 reads its ACTMON registers through MMIO.
Each SoC therefore has its own read_counters op. Both ops open-code the
same sampling loop.

Move the loop to common code and replace read_counters with a
sample_counters op that takes a single sample. The per-SoC op also
prepares for Tegra264, which reads its counters from the AMU.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 93 ++++++++++++------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 8d47fa746142..f190de8c2cea 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -57,8 +57,11 @@ struct read_counters_work {
 	struct tegra_cpu_ctr c;
 };
 
+struct tegra194_cpufreq_data;
+
 struct tegra_cpufreq_ops {
-	void (*read_counters)(struct tegra_cpu_ctr *c);
+	void (*sample_counters)(struct tegra194_cpufreq_data *data,
+				struct tegra_cpu_ctr *c);
 	void (*set_cpu_ndiv)(struct cpufreq_policy *policy, u64 ndiv);
 	void (*get_cpu_cluster_id)(u32 *cpuid, u32 *clusterid);
 	int (*get_cpu_ndiv)(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv);
@@ -187,43 +190,22 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
  *     [63:32] PLLP counter: Counts at fixed frequency (408 MHz)
  *     [31:0] Core clock counter: Counts on every core clock cycle
  */
-static void tegra234_read_counters(struct tegra_cpu_ctr *c)
+static void tegra234_sample_counters(struct tegra194_cpufreq_data *data,
+				     struct tegra_cpu_ctr *c)
 {
-	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	void __iomem *actmon_reg;
-	u32 delta_refcnt;
-	int cnt = 0;
 	u64 val;
 
 	actmon_reg = CORE_ACTMON_CNTR_REG(data, data->cpu_data[c->cpu].clusterid,
 					  data->cpu_data[c->cpu].cpuid);
 
 	val = readq(actmon_reg);
-	c->last_refclk_cnt = upper_32_bits(val);
-	c->last_coreclk_cnt = lower_32_bits(val);
-
-	/*
-	 * The sampling window is based on the minimum number of reference
-	 * clock cycles which is known to give a stable value of CPU frequency.
-	 */
-	do {
-		val = readq(actmon_reg);
-		c->refclk_cnt = upper_32_bits(val);
-		c->coreclk_cnt = lower_32_bits(val);
-		if (c->refclk_cnt < c->last_refclk_cnt)
-			delta_refcnt = c->refclk_cnt + (MAX_CNT - c->last_refclk_cnt);
-		else
-			delta_refcnt = c->refclk_cnt - c->last_refclk_cnt;
-		if (++cnt >= 0xFFFF) {
-			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%u, cnt:%d\n",
-				c->cpu, delta_refcnt, cnt);
-			break;
-		}
-	} while (delta_refcnt < data->soc->refclk_delta_min);
+	c->refclk_cnt = upper_32_bits(val);
+	c->coreclk_cnt = lower_32_bits(val);
 }
 
 static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
-	.read_counters = tegra234_read_counters,
+	.sample_counters = tegra234_sample_counters,
 	.get_cpu_cluster_id = tegra234_get_cpu_cluster_id,
 	.get_cpu_ndiv = tegra234_get_cpu_ndiv,
 	.set_cpu_ndiv = tegra234_set_cpu_ndiv,
@@ -281,35 +263,13 @@ static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
 	return nltbl->ref_clk_hz / KHZ * ndiv / (nltbl->pdiv * nltbl->mdiv);
 }
 
-static void tegra194_read_counters(struct tegra_cpu_ctr *c)
+static void tegra194_sample_counters(struct tegra194_cpufreq_data *data,
+				     struct tegra_cpu_ctr *c)
 {
-	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
-	u32 delta_refcnt;
-	int cnt = 0;
-	u64 val;
+	u64 val = read_freq_feedback();
 
-	val = read_freq_feedback();
-	c->last_refclk_cnt = lower_32_bits(val);
-	c->last_coreclk_cnt = upper_32_bits(val);
-
-	/*
-	 * The sampling window is based on the minimum number of reference
-	 * clock cycles which is known to give a stable value of CPU frequency.
-	 */
-	do {
-		val = read_freq_feedback();
-		c->refclk_cnt = lower_32_bits(val);
-		c->coreclk_cnt = upper_32_bits(val);
-		if (c->refclk_cnt < c->last_refclk_cnt)
-			delta_refcnt = c->refclk_cnt + (MAX_CNT - c->last_refclk_cnt);
-		else
-			delta_refcnt = c->refclk_cnt - c->last_refclk_cnt;
-		if (++cnt >= 0xFFFF) {
-			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%u, cnt:%d\n",
-				c->cpu, delta_refcnt, cnt);
-			break;
-		}
-	} while (delta_refcnt < data->soc->refclk_delta_min);
+	c->refclk_cnt = lower_32_bits(val);
+	c->coreclk_cnt = upper_32_bits(val);
 }
 
 static void tegra_read_counters(struct work_struct *work)
@@ -317,6 +277,8 @@ static void tegra_read_counters(struct work_struct *work)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work *read_counters_work;
 	struct tegra_cpu_ctr *c;
+	u32 delta_refcnt;
+	int cnt = 0;
 
 	/*
 	 * ref_clk_counter(32 bit counter) runs on constant clk,
@@ -334,7 +296,26 @@ static void tegra_read_counters(struct work_struct *work)
 					  work);
 	c = &read_counters_work->c;
 
-	data->soc->ops->read_counters(c);
+	data->soc->ops->sample_counters(data, c);
+	c->last_refclk_cnt = c->refclk_cnt;
+	c->last_coreclk_cnt = c->coreclk_cnt;
+
+	/*
+	 * The sampling window is based on the minimum number of reference
+	 * clock cycles which is known to give a stable value of CPU frequency.
+	 */
+	do {
+		data->soc->ops->sample_counters(data, c);
+		if (c->refclk_cnt < c->last_refclk_cnt)
+			delta_refcnt = c->refclk_cnt + (MAX_CNT - c->last_refclk_cnt);
+		else
+			delta_refcnt = c->refclk_cnt - c->last_refclk_cnt;
+		if (++cnt >= 0xFFFF) {
+			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%u, cnt:%d\n",
+				c->cpu, delta_refcnt, cnt);
+			break;
+		}
+	} while (delta_refcnt < data->soc->refclk_delta_min);
 }
 
 /*
@@ -638,7 +619,7 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 };
 
 static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
-	.read_counters = tegra194_read_counters,
+	.sample_counters = tegra194_sample_counters,
 	.get_cpu_cluster_id = tegra194_get_cpu_cluster_id,
 	.get_cpu_ndiv = tegra194_get_cpu_ndiv,
 	.set_cpu_ndiv = tegra194_set_cpu_ndiv,
-- 
2.34.1

