Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086780;
	b=jD510QaRgjTQAR3bcbmL+N/oy5tW80OpvRgykZOnXlolvP2NRzPd6K4TdOn1cApajwEg
	 MoGGFuHPEYbw4Q0/erBlAkabzoGJEa/DGuAvRt3AJU1akoAXdw8iBBvVX9TcamJyxlti0
	 ss3iEWdkRqn9rAnwNzPifkbSK4rrXrMW3Boivy8OY4j7qbjMbARyslDmEtRfBJBLFrLKM
	 kLfNCxyEwmAN8MwmlA8Pa1vZeYmzmgzjcA08MFR1Oi2QJJjnKY65n3/9FCMM3894Vk64c
	 fyRq9XLMa+NXNFEsZqxtT9Lrzet6WO1gNn9PTOEBGgyolGzZEgX2qSNvFqhH97EVjgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086780;
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
	bh=H5zG61kqVm8ZtyvyyHYeTTZaUPWjIPBzSZJ/pX2bvTI=;
	b=Bg3lvlZnWTxab1xnj1IBy9pbtV09+WUmDYyI4nl38Cel90jW4hu0PqLP5d96i+SFwSfD
	 LLU21iFvb8MfOvQFdTReP8sS4H34zvRp0YbDemfaZIXlulgkSRO/r5BCFJPwJzcPf7nQk
	 HupFrdtkL3ugYXU2HTI6NLt1N+st9yZ2A38M00+hJFp/nhW4Ei+OVmwLSQxwiCPVTyGl3
	 +UW1Qx3m3qRD5bbuEuK32ui2t9mTwMP+kMeAvxLg5HmPTRX7mZ2b8GD07apeqSWP4S3Yr
	 NzrJ5as1SafK1SpA8Fu89uoHOkjnYHPejOT4dzVNH+eYn3m+yeHO0/hPvhBwIqgQhMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="M/poHtw8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.52
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00543606A33C;
	Thu, 19 Nov 2026 11:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00543606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=M/poHtw8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQCF9LcSq4+L/xrtjhycofJPMNBaraxTVGDS/ZAK7b2o666fED4Jqh2efE+8hQ3kDDD7demhAa8V0YZfodeQxfRudUgrmodo+z5SAnLtujFaYsib/8YU6G0fRH3lNCynFmgRmFlWlVBcvi7VRcoFXLuI5u71PV6Wdv+HNVlCzRxkrbIuuNh8NkZeWAJtY1yR7aiFaprWP51Sq+yiCaQEdbg0z6SPSwM9DGDFHCRKa/YrD4qOxIhWfXVohB74cPn9/1Jlah90br02uORn8EXMlOXzXN2a7Y35/VPJ96WuxIPmMAnpJMVBb7348zLPPhUBH1VjNsIWkI8Nwe8IR/9v1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5zG61kqVm8ZtyvyyHYeTTZaUPWjIPBzSZJ/pX2bvTI=;
 b=ljL70nl6I165tAMvp/e4P8vy4d5Gg3r3+bUW3+YTQDAn5qHUU2dnw3i/yW7jMph6BS+zSNwksS3D4LME3EjxWiUoFy6q1To5zyydta4MckYpg/vCBdoesq38QMbolahwR/XSeoB+eCIkVwdSTJ+D4DXAIhg8+armzEWrq4CVcOWhpyqTZiXe5SV3X+vbjLCAFr5dckOu6zo6gHD8szhont8Dz4S05gKTw3FxPoG7XDcWc8x1er1mZWXFjziQjjvsIUhJNLW1hFS51QYhun9oRmqdaKQFNZidFWCGi3Avdc4u8whxQ3c/Fv614hbOEUGq8TGF1PsHFKoaXzb1cZsOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5zG61kqVm8ZtyvyyHYeTTZaUPWjIPBzSZJ/pX2bvTI=;
 b=M/poHtw8o0ZwVs0ToSXZoYU92IsM78z8h+MdrrcF9aPXj4C8DRy38DUEkFYzAAcshWjAjuyReD170jGMCX4zVNtscQxE1rprjSJwC6ZxpOG1aPR5FtVWBdhHg7X1WbridYZB28l62TfEOBJrJeM64Qdg2H9gVAZIALUASUVYVfBEbImKUtb+5LOoODotxcgneNMoN5jdpI4JD3faGh6+OryPpH5ZMt/XB584VTTBBYTcfUVKzF0GRGqa7xb/q38IPm1EnStmpgRn642aAfu+WVSoySKKB/IwNR6IlK6Ce3EFr7PkKPo876jB1kZGAmd5QwewVvyvGQ7ulW//ez51PA==
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 11:12:56 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::15) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 11:12:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 11:12:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:40 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:39 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:12:35 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 2/9] cpufreq: tegra194: remove duplicate counter sampling loops
Date: Thu, 19 Nov 2026 16:42:10 +0530
Message-ID: <20261119111217.902071-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 14056f83-75b5-4220-bc0e-08df462e0fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|82310400026|1800799024|261026121527099003|261102123227099003|921020|261021121427099003|10067099003|56012099006|11063799006|261021123027099003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aQmzplBNL4hAu58iVoV6/qKOr3pGoTMVlV4MifUfvoJPlujFhmfCQJ80I0OkK3LsfmPXosi9D42VzDd2JBpmaUJROMWHXxLNavVIziq3bzAQ1VFpZPJByXNsZQPQSo89Z4Dh77dfU4WrLMTVh/DRaw3wEfabIJTeqiAuhcV5OHScfcznWQa4/eBmKtYFscrSK4T/F0+yB6HrDBULzO6vKShr1yxPKSlKGli3ev5b6BQnXiBQhsFl+ZLcvkyux988DmNzOhey5im9a7C37bM/jezEpVJ8Vy01O2+/LsKog2aZeDZU2TJidnjHSbFcZQ5Cd11qIdKzbqaJqKfTSez94HjiKeduUULJieiy5zanlp72HU/FE7mYw8fA7o8jpNoIJjy9hsWCoxSn7J7GrhYQ8IUDyrMbJMcc6JCZ7v2i3cgNvxKLjmhVW5xKsdcXhvNyLfob2pqXUp1yS3Yh+gYtitvHOqOrzgE5uWcPbsLTgRbpNW3n/XIvNL1kC7XwyGE9RM9ZMKJcDgBrN+CTUlgd59NPWb9CrTD7YpH4HjzFdyhDwPiY/Pe46Q+HiAIA9Zgb+jer0ORbKODGc7utwlMF99NmVbvANtZ9qCcts2/JrzyIPX8f+cnYMGJtV8bKVxQdYhs5Be7LXBscs+3bxdGiGMnJTxpBywkfngE/wBw7yO5Ei6WhgLjajGzBeocYqaaIbehvbrMkrM+r5MAjBzj7EdBFg4ffUIDALBCLurI76p+qt8PQABeVMOmTK9o7irrd
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(82310400026)(1800799024)(261026121527099003)(261102123227099003)(921020)(261021121427099003)(10067099003)(56012099006)(11063799006)(261021123027099003)(18002099003)(261009223027099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sqOMd5wj0mggAyNl8XJ9V/vBjdv82xklRchYf2YNwsXVfWkF5/L0SivTdWVRZh1NbrvtjNNKAR78mfWVSyUm4zMICoEVo0QSEC8Y73X9yjd8ngcjYUFxx3DXpJ77VaqLIajHmpGzXn+thRCCy14ICfBfImNYBYg5CrRWcH/Pjbxz1ZbWiZizSsot8UZ5IBBSwCq1o+e62N524szv1Gdd1Z4i9ggcgvflL1/geh27IQzFPPbNsHWj04fNhzs/T0L/lp5nII7es6Xuttx1fiCoQa/9cvkbFzoiV2Ufme4K996FYyY/6LmgsrFWe1JTnjL4rSCEK9i0iwj9ycd5w0BDMKMNauujudds8WGVvS/J9WeMxBWGKY1fIEa+lGBmiFbUbiSDv2Tptp+8nhKP1mGtIKoH7/15yiqak2fLotngXhzjJI7BX34NBNr8EqdmrnGC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:12:55.7723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14056f83-75b5-4220-bc0e-08df462e0fec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394

Tegra194 and Tegra234 read their counters differently. Tegra194 reads
a system register and Tegra234 reads its ACTMON registers through MMIO.
Each SoC therefore has its own read_counters op. Both ops open-code the
same sampling loop.

Move the loop to common code and replace read_counters with a
sample_counters op that takes a single sample. The per-SoC op also
prepares for Tegra264, which reads its counters from the AMU.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
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

