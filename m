Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930675;
	b=I6fJAeboU4dI4yTepx5BcJdgy793TX1BmQwoJV8FccYUllts4iFaEe9uwAJ2RPAtfo+I
	 zdnZhFPr1NV+kHE7G1RWAnywdI92y8GqpQPLX/jDUoofbBJurCI65QUu/rphYmu5Ffiou
	 hvaWypH2rIq0uY3uKXaE00XIuuFK1/Ghm/erm9S2uq4crkFCFMwJbrIa13CZ5A+ydlFLd
	 nuzAz1qeqJaupJQU/j8G3xi8/FAb4D0HKrIf692wlJQ7kn9AiSSWmwZPzh8eIE3bMpWHL
	 VB75YDeRaEEXLBF/A9nVMNA0B8PqsF8aRsjDSK80JZz4GfIzCdOOssZ1n4i+Yf4QrUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930675;
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
	bh=tMa+Tk0z1Cd8pPVWtWhOdx200l+yd8Jq7twKzGAUBGo=;
	b=UX8t3MKwo0/yyNXyfevDcLZzZMigqNR22Sn4WciUcD9KQmYRu4J2I6KZHdtL5k3nlcBt
	 xfxbDpABDtIQ11GVJmfg4x4/6GpZvA0nQn8JQQdqT24D7ZBn94WH+nOqkuLeW4z0jjz8l
	 Ky77lDLOG3k83NkF9KHo5thBBcbFyFKtQmnWbwHFSDYPZARmhdN04zRKHz7A9eCgWc6yq
	 g1ne1aqEW7t5ZiJ5f9W4metso+6UuSN0HvF6ExzuQNOfOqGARIgIqc9SX77OktEIDCq+7
	 quaT5uQh4ow76qs0lQspzZ8DQR1CpgjrXtvgMMwET+iUTxPSlyb8wmydHcF5NCH9YSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TkYXp97T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.63
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC578606A339;
	Tue, 17 Nov 2026 15:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC578606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TkYXp97T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCIOs/alr0OdYaKcx7Tl7ciRlrB2lkKquLXmlWp9XHg8VPPzpHOer08jj/nn1e9K1V23WkdjLv5Z+U0BaBgTAqVwunUjBOImU3Bf8rs+EV9Z1ZFhJURTBiZu3YxWwO3B6kN88YOvgNWnak0kRqQvkLs4Uqdw9hdj5XGS6ejMdC5R2RrB+WZVzk27bd3KNsdozJyoX2TEkVFtvviyc9cxpclZkcBWTTlUizE/kjWoWl+8LmgkoSflDHdSOoHzvXKlX7bTACtJzY4jL58TPI4JIRNAs02oW28DqzusenoX2BfQudHtJrAEDJAyPeo3URBAwpotCIQsy9LWs85MhLz7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMa+Tk0z1Cd8pPVWtWhOdx200l+yd8Jq7twKzGAUBGo=;
 b=fsG5YHNfFWhWC2w6rYuqloISOCnfpQXChvzY8GqpBriILvmddwHA5wdyU2Ubji21WytTxemmu0rASVUppIlfaYVFjSjAxwtChKZbF8M2OY+praLDrW8YpG9ZmTvtbtTWVRIpgTE4TXwS+lTrXH+DoEnGrTUQnDieXpco6LfpWBaOHwL/K5yKIuHZOi17wKkVjvTnTVtHBACU1UwnMuhkH+3ZAOIjZ8Dtf/sqcosONMbZg3yH4eaY6S3tdDo0TAnZxpfm91PNPI1j+shTwtn9KsjzR3UvsWUN2UnWZUHb0mbzta2Vl1ZtxOHFgiQCPQrfVEBFGg2hDCNOwoYBBHFg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMa+Tk0z1Cd8pPVWtWhOdx200l+yd8Jq7twKzGAUBGo=;
 b=TkYXp97TVYAOPeAW+QBPB1JTgcKlJ9zL4vtS9uCG+ULrr9B8EwFbGHbgO83+5TSf3r2Fw35F3yq+Xb5vIN5XG34XOxgmyuNHXzzb85JAMZjo2s+3BlMULvNKfq8flI9THxjV0mhLpchd0LyU8eh/rQd5Y7iUy2PTenkVpZVlCH2mQSzWaZg1RRewe152JOG491t74R1Y886mk9lhPNscp8x8VKhC8n/Fr9xs9nVMA+6j/jFWKJwpL4PRRan3RunGCSceea5ipybSL8idPVmNw0WNg/tEh3Xs/PA7n/q3U/LkCeDRhI71k5edY/qAf4SyK1aMZQlRR4OU5URKSuT17A==
Received: from MW3PR06CA0016.namprd06.prod.outlook.com (2603:10b6:303:2a::21)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:51:10 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::82) by MW3PR06CA0016.outlook.office365.com
 (2603:10b6:303:2a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 15:51:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 15:51:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:46 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:45 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:50:42 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 5/9] cpufreq: tegra194: split MMIO mapping from ACTMON offset
Date: Tue, 17 Nov 2026 21:19:50 +0530
Message-ID: <20261117154954.625126-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: e01da2c2-ae8d-4545-d3d3-08df44c29990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|22082099003|18002099003|261009223027099003|921020|11063799006|56012099006|261102123227099003|10067099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	ACHiRoN4Gs4RWn9pZ2D6cODqNoPJ1Zu2EkoRzz/wzLiiHO4dsJARvdQW/Okar8ABJIIk0o0xYIzZLh0uodlC3WlJgjmKTH38qTROA5vy9+Vwn8/BIRQINNep0rkRNhhFRSUoK7DHzUriXZP+a4jk1x66r2udl+Qmm5z7rN9WXKunaSoqDCPrUTd5/Q9ITpEsH3yvSaM48Gx95V7lu/hCjY8MaQgm+aQnoFoHU5O5CSQoylMEkOrx6Gw5bc4p3AN6FrU/C9ltaldypa/VFGQU6uazOBX9LUdT8gnKWo24vNL4NbiAR0Mh+5TafoMLXln9CTIC568S6F+WD/Mp5zJZ7xRGUct7FpaDJNsNbZFXAQYI6ASOJzIIvrCtF+J3q5UqciWbjb+rudnuE3JK2BK+44I+kWHNC5XuLrjPoIMSEwwG36w2xuekN/HZXmwwkueDRP1XmDghk5gVSvlwFKlEgoeZR6TI2UNdvXQniYro5HYc1+f+ZWy6rdAUB/PuI5TkZy888LKx7Xgc4v0KVgX88zF0O/TmO86IUsuvycIHuYxu0KtqTZK+qou/oiMjCltJSwHM+mBpnBQ61EL4T1OfJWELMq9+/KxOTWR3SafuiYP/y+u6mNm08WMg5GRMP46+iO/lE5rAP+zMZpxl7HaJ69Uqpn/NY586BcWF9wlillIBTKjfAL2nH68muSOy5rKCVhhFYnZYgcWzPl8MU4hhDt4XbKwEyESA2wb8njJakC1skmBoCg/yOkvn+U6dYevG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(261009223027099003)(921020)(11063799006)(56012099006)(261102123227099003)(10067099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QU80Mu2w+er9xbDF0sy1mI1ppEgGey0vizMZ1o0Z08iQ1x6gM4JYUCTb3MCdcovodjyAyqAi2QVekfl1KVmc6zkCm2ilwZsfXbwnM6flrmA7fUyZJef+8NAY2Vp96+drcQFpIu860AZZSOzevPmfyfeEhTRSnrZ0hfBbGr3z99Ls498v6O19uwjIEoGLwdbPGzWGPpt5Kxhs5zFU/dqOV0MkxikHnhjoPesIpNPo1m1/0bpEc6ze1cSOFqEG0sMcnp8y8gmcaAeAYkyugKIcoATHo0ofUDRgjDCX4kzY9bNtbHTbF1BMOoly2IG+KFwW6HMSZPPoS1cu8idrUuzvPsbMShTkL+bppZsa+ha97IYx16ImGvD0MSGyO5+l6h9sR9pC6UWeNhS5aGG1EcKCrdU8KOr06Kwqw7/pnv2ki3o3w3UGspFeCULjzxSyjxVF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:51:10.0378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e01da2c2-ae8d-4545-d3d3-08df44c29990
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

Probe maps the CCPLEX registers only when actmon_cntr_base is set. This
has worked so far because each SoC uses one interface for both
requesting and reading frequency. Tegra234/238 use MMIO, and Tegra194
uses system registers.

Tegra264 requests frequency through MMIO but reads its counters from
system registers. It needs the mapping but has no ACTMON counters.

Add a needs_mmio flag so the mapping no longer depends on
actmon_cntr_base.

No functional change.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 1a5b78ff2c4a..e12e02d14d73 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -71,6 +71,7 @@ struct tegra_cpufreq_soc {
 	u64 cnt_mask;
 	int maxcpus_per_cluster;
 	unsigned int num_clusters;
+	bool needs_mmio;
 	phys_addr_t actmon_cntr_base;
 	u32 refclk_delta_min;
 };
@@ -222,6 +223,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
 static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.cnt_mask = U32_MAX,
+	.needs_mmio = true,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
@@ -231,6 +233,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.cnt_mask = U32_MAX,
+	.needs_mmio = true,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
@@ -739,8 +742,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
 	if (!data->bpmp_luts)
 		return -ENOMEM;
 
-	if (soc->actmon_cntr_base) {
-		/* mmio registers are used for frequency request and re-construction */
+	if (soc->needs_mmio) {
 		data->regs = devm_platform_ioremap_resource(pdev, 0);
 		if (IS_ERR(data->regs))
 			return PTR_ERR(data->regs);
-- 
2.34.1

