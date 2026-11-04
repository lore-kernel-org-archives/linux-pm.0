Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816194;
	b=X3/V74qgRLWG/Q7yrAwHcyMTuRWiLH2Sd4p8DkpXrpwBWVFTCcKdQISsZVxtpCKHk5fZ
	 WkR2h4An+UqbfqGSzhSp3pRZ/Bu6Zb1uDmD5H58j5NnOFVRYVTvFLkTM58cHM3VXYds5O
	 yoscWtU1/Bx+9zhAdNCvhd083zozPcn2Qmzz2POZcGwv/j6wEPzs2DgGAzbco+TCs2THy
	 rbUjjAZCS0JEEFIliYD93SU4myCnNeitnJPsuDyFeJnEp+NM+yuEwpTWKexRhPcUC6gdA
	 JcTPdjWAJwhzwaL7LuvHo9YIbVGc4uC+S8b8bQKv69MjQo+QYIxEsQcbuDYZ+XGZuYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816194;
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
	bh=RDZrW9KMpa7ByN4Q89Tc/+71RiQV+ZSQWGahPlhzdMU=;
	b=4T4URe5V90KoDGlb2tcwNCJ32gOLT4dMby4Uh8G0lM+rlmadFC7wrXaUik7iSR/oxusL
	 hGbUNKRkf2/9odRNnviVW6rfoooMzZFE1DmpafpK8Hr+8VbpECMSFTTTEZNYJJalsecWd
	 x3aHpU+v7soACXwbk6Yj5yCeP/5p9Gkr2wNnbbe4BiHTxiq1fvpBK3kEV8L5execwo3e8
	 6fUCLKCWneLlqUh4NtJ711LWi+kPI8y44CXKIRbj0RVhteaZT11fGFsCj/gokbeVsQhCc
	 xFfr7y3Rgfy081stUvC6kmnC/uUmVc6GnJRFsBIUZtZRtHDvHHOqSELYyIO0LI9wqXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mKbjIIar;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.38
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF0606D80D;
	Wed,  4 Nov 2026 18:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0AF0606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mKbjIIar
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeDu0B+0GDbx3Usr01H17SFff6bCmISm7tybMAk4ZiqirWU4jFb3kQECV5PhL7sCU/PEaj/2ZVlhmAVsu9ZNrXLe2qBn4BQe7d0o2k5xYq0sWoiHni8Hg5HSjkFh2n3wFQbjFRxfoZQA5IbltmJ+4gERxgly+bK2vcDCEB//wODUnxxOSKN5jnwfjej/0dPzBKl+H/ZRLF6oPv3+XtN1Bhv0meDl1zT2MWLB/PPtt9Le+cfn71hrj0jY4KWOIF2chkqIsf3xdtSlUfKwbByoUqPnEqAJ4VYpDqp5ZoIiD7JgbqQSJeSvSxvy2JAdqUcF2nP2XeaYZuH611aCud7z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDZrW9KMpa7ByN4Q89Tc/+71RiQV+ZSQWGahPlhzdMU=;
 b=NwDv0YiybtN1wQCPbOWbuQLoNwWh8hg+QodRRfqL9awL43p7mwci895DIvCTZ0yMFXSdlh94vq06Km5ML7N1tud8n8baOXY17pb9KprV3tAlvy1d/GdB9R8krmrwzWBKfrDqVDCO5X5gi3zGXhlJiIlQzj+tXT7SIW1c/uc622GqDTnXYgwMlnyaj0adKs6Uh4SN3uUmf2Z//26VnJpZP6fhvnOVfQnst9H+kaXBWvIgosvFRVixpWo4lb+icr069iRTd5+jk4KtuKVStu2kOgqQgl4Uahoo9+cfu5BqZgOdPwy9XQCngtlgImgpFops3a6gjLG4sBJTjWZY031iJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDZrW9KMpa7ByN4Q89Tc/+71RiQV+ZSQWGahPlhzdMU=;
 b=mKbjIIariWN8RGA3S9JhcOwA4qFjbEcpNt1ntycAXBzLC+E820RZs2pWZEksCfY1a1fOPBkdvrGdlHYWIcX4rpMnSRQmAzdhhz25u8u7SfCkd2Cmdyg6o9O7SK/Px4WT0Em1xT9NEETmT3a4/KZIe79VDpteA/oAFBIefPGFk7I/ECubzVy1spfyh11IVddj/z6+F32ijqn1E8+HCJa0J+f35bCnq4NFO964imDZTGRZxGI7hwmX11zrztBaSkmwpgGwdYta07sm6FF/b0s2ycs1lYO8IHc+r8yHZ3BRYrYz48v+NxqHITKfIj3hQBHxu2FmvgYag51MfnCta2+HYg==
Received: from SJ0PR05CA0162.namprd05.prod.outlook.com (2603:10b6:a03:339::17)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 4 Nov
 2026 18:16:26 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::2) by SJ0PR05CA0162.outlook.office365.com
 (2603:10b6:a03:339::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.6 via Frontend Transport; Wed, 4
 Nov 2026 18:16:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:16:03 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:15:53 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:15:50 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 5/9] cpufreq: tegra194: split MMIO mapping from ACTMON offset
Date: Wed, 4 Nov 2026 23:45:17 +0530
Message-ID: <20261104181521.3003578-6-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: bed10448-089e-46a2-b055-08df3a9fbc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|921020|11063799006|261021123027099003|56012099006|261009223027099003|261021121427099003|18002099003|261102123227099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bGK/tu/eu6pt//atSiJ/ewK4LZGlYJL8j+bYJghtL/lsn3xTC1vW8Gen6WEq63N19gYZOMDE3AZKZZCfrQUc674d6/S4NWOuZ/fkPD13BTEy8J7sehBODvC35xrE67mb2shpHtfqKeIv95bcuKhVMnpDgZHzDxjSKByNpB2wM+v6BzdFtklAs545MIS/LEtPblBj1v6miaZhQpBzhMvI/oapZOnEDgthxhEI6YR4JsT0F+zQgdFYg3UX2ifeooGHDjXKI1trvhSlTMvrmFJ+tJPeHGU6BmPn4YG/ip6yIQpjWqIPotV8NZ8QBeNEDTWhinDfOsZFBKdtcNa9MAEVRvJTPTWcHRTvDAv6cTbfH6KDHlRNigNgznhKQqDbi9uHHwDX6+urDNzYmx5xGocM79hRj7C0J3n71B+LaObjq3A5GzcM5/HBxDfH9mFsdbPdcB5LuxRCm2VLU4tGSl9dmz/FREfr8aXT/wKCZgJGtXAqVZ8FHLH+ocgiRdIcV2TCIBi5iFMOimaTKbB/+MQi+6bd8XSmMFxYCjO1P+m+Z8BkC/ZO0+IQ+fFk9wb76kLtiOBTi0VmwUVwupWaYXOpNoJXv72B79NKb4uz7V0Jfmhyf/8DmexcQfRKH4XELDTYx5FAwLXlXP2vnx5H3RyfwXgKNdDloDS77C+uRVLRlCinPUoHUam7LUMaYMGf8vL0iCbl5AZFmQmiv4vzawpXsrpJRPWTsgE+0UNoW1J8w3YbGEwtBmUHPKRpw1khuMCV
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(921020)(11063799006)(261021123027099003)(56012099006)(261009223027099003)(261021121427099003)(18002099003)(261102123227099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	j7OsTt4tJLTAOwnhlUWMgwrSVTsqFFhSfJA7NqKh1RlS4l+W+BscJa0DhHaUR87EDQbbulme8Jgtv5E66mXWJNyOPjO8svbDuk8Mq0EMZW5xR0UUY72CF4AZXyn1mUnMxNqfPyLNKhbaemUcjWF32uUU8htAR7aszWK+hJ7yPqpx95gBwe/c4/Zvwji8nGqd3e7mZejCujMzhm+8kTWeghWCPo68m+GfvRMulfWBz9SmQlxBI/bg8XL8p8cu28yIqWTULs6twjAIPwQ/C6xYxZuOUwYqe0zqi4y0OZ28HBo2cH6nyVk3jcx7PjY1gTg4+P7rHDr9Ask0eLeGufYw5XpROw83cdipiNxSkBDdXwqNyEELBlS62Bn5w2B1GnjWTiXBRpFgydFQZfybmNJ/u0/Utl41ja+d9HHwgW3SxKpmkcOmra/WNACbL1JLL9VJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:24.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed10448-089e-46a2-b055-08df3a9fbc4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850

Probe maps the ccplex-cluster registers only when actmon_cntr_base is
set. This has worked so far because each SoC uses one interface for
both requesting and reading frequency. Tegra234/238 use MMIO, and
Tegra194 uses system registers.

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
index a3aaebde41cc..047166463efe 100644
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
@@ -221,6 +222,7 @@ static struct tegra_cpufreq_ops tegra234_cpufreq_ops = {
 static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.cnt_mask = U32_MAX,
+	.needs_mmio = true,
 	.actmon_cntr_base = 0x9000,
 	.maxcpus_per_cluster = 4,
 	.num_clusters = 3,
@@ -230,6 +232,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.cnt_mask = U32_MAX,
+	.needs_mmio = true,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
 	.num_clusters = 1,
@@ -734,8 +737,7 @@ static int tegra194_cpufreq_probe(struct platform_device *pdev)
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

