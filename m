Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086791;
	b=kJngg0b+RG2pHVAPErMy4MKPPdHmiTSL1dfSpG+yU5SLrahPgslwBvVUdkWKvJWmixsL
	 zlDibkJ8fquBhkXpSTYH4O353mRLt+BTMRfQ94eII1IASxftcRJbHuh4LD1OeHD8h7Uph
	 8t4rTF0tg0AvYBZAv4ySArH7H+gMUOgSehvWGCQ2gYihhrR7ojmZAdarFDkxPAqmYW6b1
	 mGwDVGv4Xx2rnhl3+1/aNSkATrcHNnCQMwrIpZMu2ojQ60gfiacrCsS5A+6QlZlLAiiqp
	 UTqkOwiXhs4dMIEqL+2KL0Jk/1h4tlFSe8cl8Fcon5BvB8OP5bzih9E9VH/8S6aWA0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086791;
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
	bh=vZAKq2q/iKQly9GDBLGj/DYer4ziGMfz74QlDeC/rs0=;
	b=ToUVv+3SUrZqAh8c3Tkw17jIrmBuE29GQvphIgYLRJyGGvH4J95J0FHjwExEn06zi/E4
	 2z9bV+jfpOgOh7MzZRygnACi9WCSiihd3YgzQkR+yxBkX1OZBk30jHkDzhMLa8TB6ReAJ
	 4xjGtVABkPIxrpD+ji4/qdP3KMhHP5f9B3Wlp0ufE9fCyNrRc/PSMnfJ++intMT+2GyvZ
	 y/vdPt9Kl8QR5+OykZ2YDOmH6E5xq89zj7w6BU4O5bWw9U1ZqQjEz00c7E9KsZudCTBeG
	 vVKpF97TBNZi8J+jTmEU4lubd0IiDwuMdN6LTw0lESUxnmMyDnLYyNz0ch3djN66qcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="AV28HWN/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52417606A330;
	Thu, 19 Nov 2026 11:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52417606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AV28HWN/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs/jcaGqMjkE4/w5wcXWmOmA81v3PwHQBh/CRRlPaGK3QZqcl2oq2XFUlC9yHSCLOOUGApwLly3xbasrQK5oeUk1HLakGIrY65/rPtEgrjBhTjpyWAUMyXG/OAS7TOt9c45/Rvfut4KWRyw0KpTnx89N/LLKUzVqHq+RgusRAq8QtPvBqX+Jyv+m7ynYo6lD7b+4dJOI+vygmD0RXrRttlqVdP1Hh8LU+cO0VsnWLULu2gUt/bN2VQVeJ1dXM1cr9TqKnhlHKYWJLkBjZegs9iuHuZ19kNQwpFbtZnJW26fQu9VSIEVUzDBQymBe/0oSzEYcBI5VZBpRoAiYCD37Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZAKq2q/iKQly9GDBLGj/DYer4ziGMfz74QlDeC/rs0=;
 b=JhUocQ2KA3M4isVuxq6N5Btr89//86c3N1Kixzg/lL34g3J4I4P2WBLFWUIoLsgcy5+TE2MFxCfizNssVwIYDnWWYo9CtmpjfIQh8INxTNu3uQxVxpGnE2gvG/k6iX10zIYgokGHkrK8nlLvzZ/MFv5n0DqiKlFUZ2wllX0dilX1DoL3qBjwC9FPKQyDTecPPAjqIXMMJCVPGuxZrdpjhIuuEc93SCqyBCYJsTSFLL1sRSlpyz79EVx4MyRPaKLGAaglJsil1wewos0SBfhLCvUdLCayqZ/gDVty6V5hrdZdvx1qRVO/ZqVGAnyuq6d1ZlXoo777YENicZ0uV6+YyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZAKq2q/iKQly9GDBLGj/DYer4ziGMfz74QlDeC/rs0=;
 b=AV28HWN/PgS2Gc2HSrfVrdZbEv6PTQiWSCxqwjp5ZRoWAJCzxFn80Y75dGkgP7KarTMYxJj4dXvvElmmcbkvL7l4wIoYHGIXlhPEWvg+nMpfnH5zHfaGwRmtRXxIdcsW01EEtl853tE6b1shkFgV2XBgSiplANP3JJUKnvMOG8xVbj812eOzqBr+ggk4ykakruLtb+mJzw1c4VSaeQ26ARkJk5IpKd+ouI+FZsiLy8dTHvYwsEpK7vueAdimYv1Sjdtz3J165wwtT8jGfh6SNQwloAhFz9dnpcq3wO7KNsGCETO4wavw5V6sEZzECUQ9IIchw1e0b4c/7PEeWPmCcw==
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 PH0PR12MB999112.namprd12.prod.outlook.com (2603:10b6:510:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 11:13:07 +0000
Received: from DS4PEPF000001C4.namprd21.prod.outlook.com
 (2603:10b6:8:56:cafe::4d) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.2 via Frontend Transport; Thu, 19
 Nov 2026 11:13:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS4PEPF000001C4.mail.protection.outlook.com (10.167.23.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Thu, 19 Nov 2026 11:13:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:54 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:53 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:12:49 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 4/9] cpufreq: tegra194: add per-SoC counter mask
Date: Thu, 19 Nov 2026 16:42:12 +0530
Message-ID: <20261119111217.902071-5-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C4:EE_|PH0PR12MB999112:EE_
X-MS-Office365-Filtering-Correlation-Id: a687724c-d29d-4884-aec7-08df462e16d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|921020|10067099003|11063799006|261102123227099003|261026121527099003|261021123027099003|56012099006|261021121427099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gZcGpNtwhX2esIfYtiI9DRu0ghuL8JB50ALdDsR+6jDoY0mhRljWvPnxirfe0qjuPeR/0kLFtO37y05ERTVB/uuePd/8aRfeN4f/dVZGkyvF4sjGBSOPa1nnJInDzRdiuPKh8zXVeyUNtO2sQoSMT0UPgOJ8pJ1QgVtrgpSsxEDUd6V7TQuck9dBSEH5RX0ddUTV30UjbslMQBUGl+bcVEXv/C4Fw/X+Q6rwiz/gees39ne17U6ChDVCTtPozxxEzrDZ3Dc8aK6yCqyO5EG6SSXX+OV0XIfojALzFb0ut5226i4Npu4n+Jo53AQF2imwqInfs1yCAR1VoA+MyZB7ML7NPGgnJzGf1hVK5CrTJkiw/ePlFsyULObC9smplbslwtA8tdLrj31OXoJCCybq0j+Et7BlSbNFLzOgpzRS4F2f7lIeZ3/qE2eCIPuY/WtTI1PWOIA6Wku41BpdN0oh+RpnbDe98Xyd7QHR3t2HfgWSXrTewusnu50dktSC40+/UbSsAKPYkFpyMcfjRucqihD9XUeRtXk8g6DPpwdKYGYaUeFzbqLu95+XBZi4boUxRAKx70Alt+PP0WjSWYES8I5tRXUAWgDp6DCGgMx480rpaolnRWiIxFddRrU5nSS+4yquB0uUt99WPcGxtcrncU6Ojftg9a5FnW7jCutLOvLTz8zW0l81Ofg74r4M3JvJq6lPAyqs0/4T6Ue+igEeGZMnWUb4KyOfqbktfpq5VyHfd2ddmG99uJC6kFXMEcT5
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(261102123227099003)(261026121527099003)(261021123027099003)(56012099006)(261021121427099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MQzu+X0y4nDcEZBhVj/fMfJyucCHULquWHH2WEZJypJ819dLYw8VHfuEk7/HSrBo98ET5F0i44GxOlod+xkXanqIfwDosoTT2C/+T2rdvIZW570NDGOfOA/kcEemwGsJt0Sr5LgemyUe38d2kj/IEqh0GSvWMtmh2fuhEcYgkakpfZv9LWGDHAg2TjEHjc1LM5R0jEjFgVbjv6KjA8QH5SkcpowGzEJqtVy+PCOoUXYBYJntx8zk0uMQsj8k/VOKXWFn6IuQN6jSIc05RkAONS+zO6EnnqMRo4k+C4cT/b69iyVaEvDXX7DcChJfbo5jKdfTzlMGPRtDkvYHroLmgHIcKeodiR7Ql/YUEUtLzL55XMt1o6k2RwndtN1BbUZ0howFvGzsPqMBSRgJJAPCPAhzHlHR+rC8jYgPBrxlBlSH6Rh6CLBT5aDOhehlh3Fy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:13:07.3841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a687724c-d29d-4884-aec7-08df462e16d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001C4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999112

Frequency readback handles counter wrap-around with MAX_CNT, which is
hardcoded to 32 bits. Move the counter's maximum value into the SoC
data, in preparation for adding support for Tegra264, whose AMU counters
are 64-bit.

Add cnt_mask to tegra_cpufreq_soc and set it to U32_MAX on
Tegra194/234/238, which matches MAX_CNT. Also widen tegra_cpu_ctr to
u64, so it can hold counters of either width.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index e5ad2108a670..1a5b78ff2c4a 100644
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
@@ -221,6 +221,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
 
 static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
@@ -229,6 +230,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 
 static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
@@ -315,7 +317,7 @@ static void tegra_read_counters(struct work_struct *work)
 	do {
 		data->soc->ops->sample_counters(data, c);
 		delta_refcnt = tegra_counter_delta(c->refclk_cnt, c->last_refclk_cnt,
-						   MAX_CNT);
+						   data->soc->cnt_mask);
 		if (++cnt >= 0xFFFF) {
 			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%llu, cnt:%d\n",
 				c->cpu, delta_refcnt, cnt);
@@ -347,8 +349,10 @@ static void tegra_read_counters(struct work_struct *work)
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
@@ -363,11 +367,11 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
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
@@ -626,6 +630,7 @@ static struct tegra_cpufreq_ops tegra194_cpufreq_ops = {
 
 static const struct tegra_cpufreq_soc tegra194_cpufreq_soc = {
 	.ops = &tegra194_cpufreq_ops,
+	.cnt_mask = U32_MAX,
 	.maxcpus_per_cluster = 2,
 	.num_clusters = 4,
 	.refclk_delta_min = 16000,
@@ -721,7 +726,8 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 
 	soc = of_device_get_match_data(&pdev->dev);
 
-	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters && soc->refclk_delta_min) {
+	if (soc->ops && soc->maxcpus_per_cluster && soc->num_clusters &&
+	    soc->refclk_delta_min && soc->cnt_mask) {
 		data->soc = soc;
 	} else {
 		dev_err(&pdev->dev, "soc data missing\n");
-- 
2.34.1

