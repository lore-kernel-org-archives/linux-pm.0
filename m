Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816182;
	b=1kc8rLqlvceMgIIGZ9U/J+Ok7Qoq6uLQTPqSn1pZ2m2OB5V7OqGTUgGMS3fTXvZ6ZG0v
	 cOg3ZkkI+xiCfoyqSYjw40GZx8VBLQhmHebmT9veFjJ23PXJd8bAdkTsT0bsrH59fy8V9
	 l2+mfA3ir2LELJu1gWWKDmZUWpPjyUBn/hrXh93kmLxR+MdDZEIPOXB+bBjFsDD8z6eLc
	 Uq8PriRgEt2qF8BTLruMLpnaLEnIW857yJjmgdhrmVRfHRZeIRlBikVCWoXe/pQzinm4D
	 C27K5XuyWrK5GSJjFNYlNJbwsAicE+hRBfv8+O5+9+4JpieEufUKnmV9SQwTKMKnD7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816182;
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
	bh=G8X0vP5FpY9HZr4CpAGkyGFni/wtO6MXeSdIngNDiw4=;
	b=AFTVH7vJSHojXJJeY7IIHBtiRHyWdqAmVWpvzt7Y84D/fVjKeV/VjZK5o6k+0A/oBB4J
	 RIoc2LkhzsCz+0eHzOiw1tMUtdMBy951Txb+3FDVhnAwi7x/VnwVgblQBs5m+GNZLQx3B
	 G8IreL48NU/hnHMHlNOyXEt1a10fXuuFYjKXENk4/ZnBbF922A+n/p5eZaIcAp23L/4LD
	 qAVq3WFiimWB0io3uToJOPgSxOMo6AnYGr7L6zWWrpKkR4zKM8QuW85gKA+mBlnCcKCUp
	 CXUSmvXeq6auwvQC9mUOW/H8L2jgy32zCJbi7c+Y4ECnxrEp8LBAvuDBdQ7n64oP0sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="KR/v1IcI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.48
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75CA606A333;
	Wed,  4 Nov 2026 18:16:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A75CA606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KR/v1IcI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfLfeXzW6BwpNVKJF0NegciLdVoskqLHCI1cD0wdmNiGwU0uJbM+gI3y+VXLZVOpAwB7FlR0Y1T5lZrihcTyArgcAnLxpE9LOGr1vSipWHTnrfRC9SisM2p+5nEuZSANRBGDdmQoYVnCh9/snC81pjQrhoZ4IMZKvtoHBR1a+N+L8kTmHUGR3z6h22BZ9tda95LR8H36EDZ2RlhBDSNfAArx6vSm3fPVMmgS8b+EPhy1KUXtxbcFCOAjCsL7G4iHERX11oBx8xzyhujUEadIQ/CONuWyaC1Llg9ZbcGK1YXRXZnvAui9aFAgonz+w39ieTqPjLMa01yF4iN+qBuFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8X0vP5FpY9HZr4CpAGkyGFni/wtO6MXeSdIngNDiw4=;
 b=xWFNOSRKCUXSuPzb+g9zcor3qeaLxNUA4h5DysQ33uTqRxZJzBi6ZQVF7CGDkrVCIPoUJB6oo6mcSmc4HSUmnobqpTHCeJui779xwXpjhEaRWc6BZrz7+bKynX7AsqBAJ9wrZvebRaBOE+uXu/j5N9XWcy/E2WePakKutpYBdEiITbnnlXd1DEV4ZBopoNJkBvBoCQO8nymS5BdnVFUgRMF+kHvR9hv0in6uQyawUlVLRmjYSV5mdm74TEAhCcMDgBlOjMjLR+vqXqqa3TIt1B4MuuQm/kV1UL25vCirrfOZVfj9urDo3IGRO9L45jyKKkRuFQ+AxgQ5B41+IGvTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8X0vP5FpY9HZr4CpAGkyGFni/wtO6MXeSdIngNDiw4=;
 b=KR/v1IcIZE/XMUpHxwZX6IjUM5MiTPu+jXWduCtBQ1fip1j2346rjn4x2H1k91y1WLi6+sKA0EOo6o8zbWOec/fO78Ma6QnXrIKtmza2bDftGvqPV5PXfxIEwAv6x4tkhvIi6McXLj1NBsF4E6rF5HHl6o27CUsI8ZPDhlcIACSA3yjO7WWT0716RjKKpiPJlmyrKwVDi6K3A1a1PSdcSWwc8cOdrvXVaM0mmSPR4iALUN+4OHAL14Z3qH1N4Idgs0beu6gK4Q9z9eAq6Ly92KI0HrbBtJ0kEarDseYJCMc5Q5ze6YfCyBHqcae1e5rgQ41hfr3RL/R0sieeJwG4Cw==
Received: from SJ0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:a03:331::14)
 by CH4PR12MB093331.namprd12.prod.outlook.com (2603:10b6:610:507::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:16:16 +0000
Received: from BY1PEPF000264B6.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::99) by SJ0PR03CA0069.outlook.office365.com
 (2603:10b6:a03:331::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 4
 Nov 2026 18:16:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF000264B6.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:15:49 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:15:48 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:15:45 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 4/9] cpufreq: tegra194: add per-SoC counter mask
Date: Wed, 4 Nov 2026 23:45:16 +0530
Message-ID: <20261104181521.3003578-5-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B6:EE_|CH4PR12MB093331:EE_
X-MS-Office365-Filtering-Correlation-Id: c7c0e766-b029-4c3b-4b40-08df3a9fb71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|921020|261021123027099003|261102123227099003|11063799006|261021121427099003|261009223027099003|261026121527099003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	woGXlaa1RjtUmPt5ckkvY1FzH3Jk48Rdc19UwvWwJyj+rc/a6qQceiHagRjY2QeGSgcF5GKg/RaO4/zbJ1Qb9cvUrp/jXSK8qgoWILa/HrWirA8oQdWcOlfGISmNTicorrX5HQryC3e9vJtBjvLzBN+YaWT/OSDLoUZbS88mtvOchzBOyT7vsn0ZgWYgD2C0gh78io9RbsfDivNJv9v3le2FnjB8X9Ddwt+2oZ6NE8rcigwT2QgcJLg126a1KREgRbIkspSOGTx9HjNdxIS6wM+d2ZitXYy9X+am96elkSHIbr0fKS1cY+ICkstIrHU93626fktjXaXyPyWsJ695pYLDSX5dxib5yMd0nCcCDw5T05dj17SGKYSOgoVSArcXrJowEOqKR3ob55iE661FIsGK6J6g8rD4NgnKcKK3SphqOghBfPuMe3n4KqLm8BJPmhjyS/1SoXCyuxuiq4ZN8MFDnMQN8R0upTR/wsyJe9UnvyTc6SBw9GJXFKVYE6uWDnV+WBMXyr4dt6hynNaa/lLoqlchM/eNzvcYKMuqdRwVEF0v7y0+F+HG+H2xlPtFfcsyeDAYC2zmbD1bUKB8/9sI3K06BjsXAGD0jIUU9vXjDs31y39rrjButvEvfmKSfcEcPgzSUH8QFA4+9m/cuwohOl0MBcqCJWwjJsx0DpBZcdFR1In/mHQlCN3oEbMdMW+J6eFr6EGl23eFk33shnqUWHZTkN4kbDwzGiVTGuK0yoyiDeouG1rSOBVq+efw
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(921020)(261021123027099003)(261102123227099003)(11063799006)(261021121427099003)(261009223027099003)(261026121527099003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v2YFFkiQh8YmiAw+oUQ5hMH5xQO8OHJ5SqPazplnBaxrYAV/vwX7IsXrmSPNM6KxRfcxq3NOzgC4Heme680nlvsqfCynb6BJ1cfeB2vAkH9C+Wi1JduTCxxvybDZuarpV9N8Qbs3DxtYTIzXL7VlHGnHATiTfb4lZMBVJkpBDT10GdEcFReAtLQ0iAUP/FssbtxDknHKAlkt3w3chEUL4uq8LwjFqtyuCxM04md1WOONREeyrKDTFIlKhvGd+rAxHMY/dn6Y7i8Vf+zXQ6g3YFcKIA8NUhsxTSPwqY0kmPOyT+NwuPHC5qk3oAQtvpvZFE+cgdNLVB43u+4wRfbyDjfDkuVV6DBnu5+8SD2efyXpMCnLJLAKLoSV6S2TK4iCCWAdo7xz8zNEtaf6PdqfSG961ez9QbHzZ238kuFoKeQljJu7PkVI56r097O8s1JL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:15.5968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c0e766-b029-4c3b-4b40-08df3a9fb71b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB093331

Frequency readback handles counter wrap-around with MAX_CNT, which is
hardcoded to 32 bits. Move the counter's maximum value into the SoC
data, in preparation for adding support for Tegra264, whose AMU counters
are 64-bit.

Add cnt_mask to tegra_cpufreq_soc and set it to U32_MAX on
Tegra194/234/238, which matches MAX_CNT. Also widen tegra_cpu_ctr to
u64, so it can hold counters of either width.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index afc10c0b874e..a3aaebde41cc 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -22,7 +22,6 @@
 #define KHZ                     1000
 #define REF_CLK_MHZ             408 /* 408 MHz */
 #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
-#define MAX_CNT                 ~0U
 
 #define MAX_DELTA_KHZ          115200
 
@@ -48,8 +47,8 @@ struct tegra_cpu_data {
 
 struct tegra_cpu_ctr {
 	u32 cpu;
-	u32 coreclk_cnt, last_coreclk_cnt;
-	u32 refclk_cnt, last_refclk_cnt;
+	u64 coreclk_cnt, last_coreclk_cnt;
+	u64 refclk_cnt, last_refclk_cnt;
 };
 
 struct read_counters_work {
@@ -69,6 +68,7 @@ struct tegra_cpufreq_ops {
 
 struct tegra_cpufreq_soc {
 	struct tegra_cpufreq_ops *ops;
+	u64 cnt_mask;
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
 	phys_addr_t actmon_cntr_base;
@@ -220,6 +220,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
 
 static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
@@ -228,6 +229,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 
 static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
@@ -314,7 +316,7 @@ static void tegra_read_counters(struct work_struct *work)
 	do {
 		data->soc->ops->sample_counters(data, c);
 		delta_refcnt = tegra_counter_delta(c->refclk_cnt, c->last_refclk_cnt,
-						   MAX_CNT);
+						   data->soc->cnt_mask);
 		if (++cnt >= 0xFFFF) {
 			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%llu, cnt:%d\n",
 				c->cpu, delta_refcnt, cnt);
@@ -346,8 +348,10 @@ static void tegra_read_counters(struct work_struct *work)
  */
 static unsigned int tegra194_calculate_speed(u32 cpu)
 {
+	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work read_counters_work;
 	struct tegra_cpu_ctr c;
+	u64 cnt_mask = data->soc->cnt_mask;
 	u64 delta_refcnt;
 	u64 delta_ccnt;
 	u64 rate_mhz;
@@ -362,11 +366,11 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 	flush_work(&read_counters_work.work);
 	c = read_counters_work.c;
 
-	delta_ccnt = tegra_counter_delta(c.coreclk_cnt, c.last_coreclk_cnt, MAX_CNT);
+	delta_ccnt = tegra_counter_delta(c.coreclk_cnt, c.last_coreclk_cnt, cnt_mask);
 	if (!delta_ccnt)
 		return 0;
 
-	delta_refcnt = tegra_counter_delta(c.refclk_cnt, c.last_refclk_cnt, MAX_CNT);
+	delta_refcnt = tegra_counter_delta(c.refclk_cnt, c.last_refclk_cnt, cnt_mask);
 	if (!delta_refcnt) {
 		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
 		return 0;
@@ -620,6 +624,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
 
 static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.maxcpus_per_cluster = 2,
 	.num_clusters = 4,
 	.refclk_delta_min = 16000,
@@ -716,7 +721,8 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters && soc->refclk_delta_min) {
+	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters &&
+	    soc->refclk_delta_min && soc->cnt_mask) {
 		data->soc = soc;
 	} else {
 		dev_err(&pdev->dev, "soc data missing\n");
-- 
2.34.1

