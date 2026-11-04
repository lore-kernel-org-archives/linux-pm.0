Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816176;
	b=bOlHSXVghOtHlGQl7wPIZYowSuxOydQFbOI5gxznNugyTXU6tJclwIan4pWfpsc+lFlL
	 XVOz/7kK5fTBUVwXksjBuSuEiiejq1NYf3KWJo44L0rFPVCuyUIfDymllF9kFId6vfZzh
	 lAEPyklfBerZd+rYwUkDiR0Aljcgz0xWdI4R2f7kySeglxvUmkBc+SlG7s+BH0VPZIcI/
	 nnWywgsMmoWo2Ohpcmd0RQoJ3xxo40bSh+KcwFl5tmjv38jEyM7uUIeVt2vZ/iiobZzPD
	 36l4P50bGpsEb5pp5o3t8E041NYE24yVHIWGk2h/ah9OXUqc4zYgHVmeF5i1HeJ/0tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816176;
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
	bh=mmvwVsgKCKjEEKNf1Sb4GOacrpbCa2iMzkpiU0Nx0Js=;
	b=NE811/UlQMC1UT+vfu/gTwgtSCcBNfBeYqytjicS2IN63hAQN1KekiIXog1FXrpHmcfg
	 bZdfTEyf/6HED0FDE7rGHDwyVGVg35Ca0Bxo3T1VfYRCCf+ZNSqpZJ5r0GZNVzu0OJp7g
	 w1/wn1UiqQM2dGye1lTl7uTvjrL8F2p600ne1JXUbDOSvanKa+kbIA/XF+oyy3Hq07ewV
	 9K+od5g+HrU1POzzkAHo6ndFfLcuV+Yy8EiFhBUbwMrtabJnJpHnUav5GhWTA1irX9Syv
	 PvWl864s8TC0GqeVYly49T4Xbs6yRaVCV4S8q0njsOGzn35MhK8AbvEPDijl5fokcEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NfCER5zc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.62
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81FE606A332;
	Wed,  4 Nov 2026 18:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81FE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NfCER5zc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYUDkaXkiiZaNcF5EJ61r2vGC2gpE4A6yInTSTdYb8PPuTNL64UF+y5qpdb3u6OdnxMlVLPkSdEuX0Xi31UAVJZBrvTLNLN4YE6rh/sC14qLIwNBdFCv8nNXBFD4kfQ7fGVPw+TY7flVw+UHdAweswKmt6vddLU3FfdhzNeUknXaz1qd5/vRChdSZ7CIxS1xIro5NlNlfFF1nk/fEiLVQqq3gS94CqNujxhzofVJR9Q8bDAncofTex1Qond08lb+LWQbENiWcxe0seiD1pRMCdtc1Z7Kkn6gsV/jgm0A9EJRtShccXgVKr6CUKK9m1ZCCW2LFeK34/rZtsy0J39K6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmvwVsgKCKjEEKNf1Sb4GOacrpbCa2iMzkpiU0Nx0Js=;
 b=nhKpI3yK7fjxW+L06FTZ0jmssFrINlU/Cv7NkFtA1cOB2KXwtliJq6AG0hYw8sVsGmklecnm897YvjtiAXynsBGeiDcJFwkWSC2K2wociRpJqQBce9uO18n5PYK38R4MBRsAWK+CferZootTJ+eUvDNPMYmzgZ/ormrZcuNymPSW7lN1OJL0CA2XBXkOkeTJoX/pdxHTng4b371E6FCc7V4JXVGvH/DEWDemKfWhghzd31fMxuDADHarM2z/yYCiKFVWSjsy1jcz3xvpNaswxW1kvEh7UXqS62wU8N5kYuerYWyOISGiqqfiC0GmjGG0ThE6gcKk+uwMWh6ZopvkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmvwVsgKCKjEEKNf1Sb4GOacrpbCa2iMzkpiU0Nx0Js=;
 b=NfCER5zcToylhTe5K/pdJnig6jSvjj2VysHEgyQTB4HJuALflybkHk/hp+KeCJ6yjVHwVYOKnj9qKC9kO2fiO1Q67bRPyShqzmhSA9vZe9UnsZVoKOMqawFB8kR4L6/M/102jAAbabmnhNnHvDTtAc/zmswd+p+8D8cnlxvXBjVQO6yhNc2xbZCsFvLqe7F2nBtVA/diLuConP6Y8PWFf7pD+I3g5CPEeUq3AHUu04zoXGJlhkEKLWqqZzDBd9V0yz+vBuPTdBs5pn62PJKLW4gLnl1B3La6RFRnzAxpzhm0Wv4yEsSafZDyTQAnHhRi7Ta9rlYJZabeMOjv8m5lMg==
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:16:10 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::85) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Wed, 4
 Nov 2026 18:16:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:15:38 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:15:38 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:15:34 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 2/9] cpufreq: tegra194: remove duplicate counter sampling loops
Date: Wed, 4 Nov 2026 23:45:14 +0530
Message-ID: <20261104181521.3003578-3-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 54147a74-2084-4eb5-7719-08df3a9fb39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|921020|56012099006|261102123227099003|261021121427099003|11063799006|261009223027099003|261026121527099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AymMedXsO+iBwIYQLnO90QcfjiTw66nt/hTCbIzbtt3GoR0N4MjwM9vzm/y0xhR3dASwNJPte0C8e7ZNsSsGn7BZ3/O7KTwUchjMmE6XbE3VhXyDk2xtfQBEoy2/ruVd88sdTT87vKADEjhFlzy6sWCiyZ4HpOSkpZwNCDkwLy1JyBIzmNeeoY+gCAdhFrbXs8EzXN8quhrNLU5QJnsvNAqFBd/POpc75TJf+szsLa2oOvzKHhFeUDZvHSBEmW9Sy1umTnuhrYMa5uxjJLLiyEPi7ztLQpHbfTfMB8BUQ+0jGuIisSi1BX5nxw5Vk2d2Z+4gVxU7nIlaVFJ9GgnlyGDfiCLymItUk0aa1KvYgHEcWFT9KyGtzYCTuaknJTVh3ayfQ6einzBQCeyPoZjt9YQHvxYctCH8BaOzCI3ziN8ibvsyezJqJ283VWvFebiVTGOEsrsBgRqGTaPBSeirGbWDV+4Il7jJEzsdlznTtzhE7nhC2etqPjd0g1zy04HKgfIKp0Z4Kz4vJMv/P0bB76C9y5sSteYP/YFpkPWlfRHNnse3zblCs9v4/1xPjM1p7wmprOO0Q0nOKDz+s/7PMjZwPyrC7BDSPtYUVi1y5jB0nz8IrOU8ehfi7KBqle2MMoblxzEYAXrWWAIjyPxDVuOv51YCH1KsSBn+pOPf+NfMREAc5+NBkwDWZWQ8+iXqVyYH0RMrKGrBef52KjTFbjnnIIiyYzkz5PXn36JVnsVPQ9Qh/I85ZvebNH6zKdH5
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(921020)(56012099006)(261102123227099003)(261021121427099003)(11063799006)(261009223027099003)(261026121527099003)(261021123027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dm/H5LZT8YB8Z1aFTK2574Sc2ZudtfO21UA4aaBYYEbHpKLs6qMFcCEDfoe9xNA69YBVEjMfum73RvknuRBrX6d6qjHgKkUoPDkf8aF7l05LEx0tgoOwShFdgfkolXQE9bRWm9GXSha1Sj6pcITDi2RjFPZNRTUXXyVJ21FDRvYLenQkVjg+BMDUaiSUXYvew7UgPMC6EgFCJmn5kw+bEx9gCprRiEnTG6wN3jZpzkqgTNaJgH0gjovoWXaRvZuRWtaE9tvB/tJanbeg2r5O8SvFUILIzRe2s4cH6afCu8MItDuKMGblRxwnsTFrTHyS7bb3RNnDKMzExPevUVPdAWPVje+qPTpX97MpT9HXQYVKXTlcdrnDVvdY3rc6XPIX5PO5gLAUAaFLU8DmEV6Zxuz57LkEL3rAkyPFChMin47LI9NLonYm1iynlpowpe30
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:09.7382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54147a74-2084-4eb5-7719-08df3a9fb39d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750

Tegra194 and Tegra234 read their counters differently. Tegra194 reads
a system register and Tegra234 reads its ACTMON registers through MMIO.
Each SoC therefore has its own read_counters op. Both ops open code the
same sampling loop.

Move the loop to common code and replace read_counters with a
sample_counters op that takes a single sample. Keeping the read per-SoC
also prepares for adding support for Tegra264, which reads its counters
from the AMU.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 93 ++++++++++++------------------
 1 file changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index be81ffd23edd..0f350b4db6cd 100644
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
 	void (*get_cpu_cluster_id)(u32 cpu, u32 *cpuid, u32 *clusterid);
 	int (*get_cpu_ndiv)(u32 cpu, u32 cpuid, u32 clusterid, u64 *ndiv);
@@ -186,43 +189,22 @@ static void tegra234_set_cpu_ndiv(struct cpufreq_policy *policy, u64 ndiv)
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
@@ -280,35 +262,13 @@ static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
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
@@ -316,6 +276,8 @@ static void tegra_read_counters(struct work_struct *work)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work *read_counters_work;
 	struct tegra_cpu_ctr *c;
+	u32 delta_refcnt;
+	int cnt = 0;
 
 	/*
 	 * ref_clk_counter(32 bit counter) runs on constant clk,
@@ -333,7 +295,26 @@ static void tegra_read_counters(struct work_struct *work)
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
@@ -632,7 +613,7 @@ static struct cpufreq_driver tegra194_cpufreq_driver = {
 };
 
 static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
-	.read_counters = tegra194_read_counters,
+	.sample_counters = tegra194_sample_counters,
 	.get_cpu_cluster_id = tegra194_get_cpu_cluster_id,
 	.get_cpu_ndiv = tegra194_get_cpu_ndiv,
 	.set_cpu_ndiv = tegra194_set_cpu_ndiv,
-- 
2.34.1

