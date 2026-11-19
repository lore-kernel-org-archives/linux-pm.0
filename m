Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086789;
	b=s2bw/MGw5FGpkoMdEulM3VspueGSQfusfDtmRlne2D305GNxmh35Ra1eSlLhZ1yIvCc8
	 RkmVLCpS+ngv+6HVKsiZQQCOImRVlRbVPuR8AFRAeDBNOuPgPI16bS50SU6Hdxh99e7PC
	 7363mE02pdbYWL/tZrlkt/7xUkpzylG5ajJq4FA6S9rqrGB27KtUemzOqQ0nNuPnQLuyp
	 IDsvYHoNFsPo4rHbn/+iMpl9CCPaCGzz26W52WyxwFZ0QPMpK76Y07r47o2I0rAy7OUEJ
	 lDaqRCpRsR+wTmdJ5gR5FEtgpoUB4FlCECYOE/WSjiKy3AMyMUa2qJPGAMe43/BX3jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086789;
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
	bh=ovT6uRf6/4HiVo5H8DaoMiuQe97VZmnqBuJXfgGc+nM=;
	b=DKB49hhAQHWDDwwQW6OdFOGZcNoWJbnt1gZKR/SFbnZOuyAkloVLEECPYUXwQN7Su8WZ
	 lD+F/vLLNL+Z25cbXbQ++0TdcLgIDrD0yJdwj0+XkB9/U70vZr3v/fshhj8YP59Z0ANrk
	 VBXyb8LDaL/jnTnazwFTScgjzrQtAA6yZE/MZpZlQpzUI8bS/3M/nE347QfFVFljEvXhr
	 Wlc4W66S4to30DMAjkRXANHz8zLFitlamYDzqLsjFc7nZLMf/+j8SLj2/fphkVI96vpkc
	 pRWcPSxuymonJHMTQGVuXcPR+PUBTesUNGXK4RKr77dLvfYSOhE/dr2UzTAsGHGZwPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RKKeIVMs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.7
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF08606A324;
	Thu, 19 Nov 2026 11:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF08606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RKKeIVMs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJTbAS7v97OKn8iQMZhUrsR3xpXlQM9TJWYvJN9APS/FkDC+JywB+RHEN7b6hXJc4bATia5NE35Kr9FCK3FHXTri8d0L4qCt9z50nrNgLdU51x6a94Bx/prHRAUHNLmKq2pMZquOKvuR3zNxGRz6ng2r7pZA+NyMk7g4WJh8vmr/WzY8uSWjv1YzSLIu7ZyJUYzRBMIM8U8DB+DG/G2Rf7FqpyQJuzz3+F4PuVenQuPdL80cd0+XZlud9j3jIORdtPgr0P5VDPJbK0itqL97tWIrWAFzufU6iTkJZc3lcbbGBscX8I13SdwH/3t9fe0vhPgFvmGaLVyBRX/z3m1utg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovT6uRf6/4HiVo5H8DaoMiuQe97VZmnqBuJXfgGc+nM=;
 b=o5se/GPEsS2MBqZZDEhK33oZOtoUEXYtU7MDWxk9nGejbg5OME0KjzvVOHu3yt4r6LUm1xVhMkXy2S5rMxe5Sgw4WW6R7kJehaat/qbPlxQp7IPfr+OxzpCULg6o3+muu7yQ9OVh9OoUZ5gA2VeAHxTbLzn7c9v1SerS1cLlwLD3lFgMFVHO8sDFCX5R7gHaU0OBqTP9uXOpEAXy+I8KoIsHwBY7BwYUP2iV9nRYNxi2SIFGMZvuxz2Ce1Td7mrBkTN91quCiGNxpTdJ4vFmBsSQP8MZEW0k6fEFLrDtu/2lPfatJEPtOBgw/VW6fZLHqZgJSLOTjYcGAfCGOSbQKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovT6uRf6/4HiVo5H8DaoMiuQe97VZmnqBuJXfgGc+nM=;
 b=RKKeIVMsmFQ/9IZiS2P/3T+p1I+t6M+DwjEl3zl6ZyM7kMWKHOcSVOwWAGgPHXWA1ebUHGE686+Dno1TDwAuaXzp7f7zvkLaedWwe4X1Fm+QgkJT9BPpze8PMBos7bPxAtc9Z/67KqLj1Y9iFCbnSwQYx6ta1V2QR1cX4eseMkzmgjIJoaPYpSgnvyd64vpY39nR18LV6vg5Uso3HrpNOmkdlfMwFZBUMJ/ofkZvEbrS9A0PMjUgRiRiInDHb/dBHXlWGGll6xsQzcNs8kFxJaJX3+iGqa5pO+60nK2iNb4QFAZxElDuwtFYYnJ2b7syMO55G5kdx6mXlCaXpVk31A==
Received: from CH2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:5a::40)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 11:13:04 +0000
Received: from BN1PEPF0001854B.namprd05.prod.outlook.com
 (2603:10b6:610:5a:cafe::7c) by CH2PR08CA0030.outlook.office365.com
 (2603:10b6:610:5a::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 19
 Nov 2026 11:13:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0001854B.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 11:13:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:12:47 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:12:42 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 3/9] cpufreq: tegra194: add tegra_counter_delta helper
Date: Thu, 19 Nov 2026 16:42:11 +0530
Message-ID: <20261119111217.902071-4-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854B:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d483da-eba6-4a02-8235-08df462e14f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|921020|261102123227099003|10067099003|261026121527099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lDV15SIuVCpBg+LRP2brugLsV4GLoZ4UgdYmqqoRyq2CDGPPAtTyelUlUsm9sFox8WHm79Ie7U+lUKSoZBil/X8LcZth47+AgxzWpUWNt2kGeTvWFx5+xJwTn2MSPv9b8DeK6vlmx+V/OLEM/LcWTd+acgAoqbyhg7yxdpdDYGk2SGeR+moUie5kHXdtt8MgcGvr1O503mi7yNoi0LAmrPBLwySlBkwmBbZBwiHnJRme8xEOe9/zmSzOUTirsMeQA784U/4lBZzAlPeEj/Lo/5GIWscyuIWQWqHCw5CrXo4blwhBI+XmVO1Exwr9NzxlXhnM5RD+zsd4U7T6S5h3cL7NYR/NIjk7z0N12mCwchR8mP/30oY1EaAs2yQkpoUIUKQ/RiW3CwpWzyNoV8JHQYDs4w/sVtsme74ud5vK0iLtXEtSUSwYJXiRV1dY7gB+xNxp4OtdTXr4J5TcyFoOc69aTwx+3JVq23wtCu1y/8fynfPmBKXXVwG7gAZ6XsdbYUSv42urEzXfDcmxBw9Qan4K/M7K8Ofd5W0xpo8rhDb/HbmjSM5cK0qPgmZcDqIUxKsX6pPP1k2PQzuXf7HCEqIqdGOK0/jLQBWQQhclGpeVUfrAbGBOA1XH/mIi91tKa4VxgLFm6UABYIkKdR0BjrwSR0xID7icplwaOkXfKuo15QWrnodiDO/aJHUI5MR+PuWm9m8xys+2rBmZ2E92O7uACVDIj8UddClNnVEWR0deLT6bq8WCa4oqKilAipAp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(921020)(261102123227099003)(10067099003)(261026121527099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+zUTCMi/KhtUptP9HS2zCoQ+jzaxkCqma2mj7u66PLgEyZIVnDqJ6RIs3i7swr8AQkt6Bwd8bxBfWBGqOjacwz7wp3FBAa6SuhpEXXFX2QYQFVxnC7TKCwP4ft9/0M0CxVVWnBFeKTnFtovB+gW/goTMELtWbnIw6McKqcvDl83cuz63QJjsYPT8CxyMfF+j2l3Je0cv9UqsnhU20tPDhKiMW5i+jXTHDsluVHwiHNRmj88qbqwIMMpIUkT/cRicm2uqmtY3aFaG2sU76QfmTtlYZZ4H0TNAoODKh5LP0Pf3bQ3CqWzf4J+Vf17zfJ0IGSedWplIIuwGDQegff+8PmfUo2jGeFyc+gWOigqi2m1ppT02XtrINUHi582XRFaOVTVFV4Dl3B00nRYv5rn51UZ+qR6I7s7xz/EwMIsoSxpxzp6HyJzXI+pDh0gS7Fg2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:13:04.2264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d483da-eba6-4a02-8235-08df462e14f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001854B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768

Frequency readback open-codes the same counter wrap-around subtraction in
three places. Move it into a single helper.

The helper works on u64 values, so the frequency multiply now runs in
64 bits. The old (unsigned long) cast applied to the result of the 32-bit
multiply, not to its operands, so it had no effect. Drop it.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 37 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index f190de8c2cea..e5ad2108a670 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -110,6 +110,14 @@ static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long fre
 	return ret;
 }
 
+static u64 tegra_counter_delta(u64 after, u64 before, u64 mask)
+{
+	if (after < before)
+		return after + (mask - before);
+
+	return after - before;
+}
+
 static void tegra_get_cpu_mpidr(void *mpidr)
 {
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
@@ -277,7 +285,7 @@ static void tegra_read_counters(struct work_struct *work)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work *read_counters_work;
 	struct tegra_cpu_ctr *c;
-	u32 delta_refcnt;
+	u64 delta_refcnt;
 	int cnt = 0;
 
 	/*
@@ -306,12 +314,10 @@ static void tegra_read_counters(struct work_struct *work)
 	 */
 	do {
 		data->soc->ops->sample_counters(data, c);
-		if (c->refclk_cnt < c->last_refclk_cnt)
-			delta_refcnt = c->refclk_cnt + (MAX_CNT - c->last_refclk_cnt);
-		else
-			delta_refcnt = c->refclk_cnt - c->last_refclk_cnt;
+		delta_refcnt = tegra_counter_delta(c->refclk_cnt, c->last_refclk_cnt,
+						   MAX_CNT);
 		if (++cnt >= 0xFFFF) {
-			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%u, cnt:%d\n",
+			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%llu, cnt:%d\n",
 				c->cpu, delta_refcnt, cnt);
 			break;
 		}
@@ -343,9 +349,9 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 {
 	struct read_counters_work read_counters_work;
 	struct tegra_cpu_ctr c;
-	u32 delta_refcnt;
-	u32 delta_ccnt;
-	u32 rate_mhz;
+	u64 delta_refcnt;
+	u64 delta_ccnt;
+	u64 rate_mhz;
 
 	/*
 	 * Reconstruct cpu frequency over an observation/sampling window.
@@ -357,23 +363,16 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 	flush_work(&read_counters_work.work);
 	c = read_counters_work.c;
 
-	if (c.coreclk_cnt < c.last_coreclk_cnt)
-		delta_ccnt = c.coreclk_cnt + (MAX_CNT - c.last_coreclk_cnt);
-	else
-		delta_ccnt = c.coreclk_cnt - c.last_coreclk_cnt;
+	delta_ccnt = tegra_counter_delta(c.coreclk_cnt, c.last_coreclk_cnt, MAX_CNT);
 	if (!delta_ccnt)
 		return 0;
 
-	/* ref clock is 32 bits */
-	if (c.refclk_cnt < c.last_refclk_cnt)
-		delta_refcnt = c.refclk_cnt + (MAX_CNT - c.last_refclk_cnt);
-	else
-		delta_refcnt = c.refclk_cnt - c.last_refclk_cnt;
+	delta_refcnt = tegra_counter_delta(c.refclk_cnt, c.last_refclk_cnt, MAX_CNT);
 	if (!delta_refcnt) {
 		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
 		return 0;
 	}
-	rate_mhz = ((unsigned long)(delta_ccnt * REF_CLK_MHZ)) / delta_refcnt;
+	rate_mhz = delta_ccnt * REF_CLK_MHZ / delta_refcnt;
 
 	return (rate_mhz * KHZ); /* in KHz */
 }
-- 
2.34.1

