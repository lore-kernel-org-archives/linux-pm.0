Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930626;
	b=eyX5bJDroKAnKhTKggbHlwuTxGJ+XhvH0pRca6AahVH8rQ8FOXQSpBy1qlJTkbvbOGpe
	 pT1Ytxf4FsVSHoOWycCWnM0i7n3gNCQ9Ez38Af5J1nHrOfqFARtI+Yq1sHn/2ZQ03We9m
	 sxeGb3D94uD8vX7Y7mRAMsSShHMU2Wkhk8swNN7ncYCnM7DL53mqwty0aqTu9ERo7gxQO
	 h6PIqK1OYYT5mmQI7Zvy1X2Hc8l88lXc3Tz/I04zaNDPXvap6LBWg9bT7yaD2IlyXcQUk
	 7j1ewm2igfi6oO7P3Wglsi0cLC5k8kRemGeoB025AnDg9jbTtKvbvZ6eUg9ImyHMuaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930626;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MC5o/USjbZny1eEd3PMPAbp451+2/6/OdDEjm0f9IHA=;
	b=KGYm9/jADuloJztd2B8CdTwQceHk+QdJD+kfYI9TaLPbKom8FUo3Ov230JsjaRvTseBD
	 wwe23V9bSx0uwzP6bBi6QpmfGmEOOrgz5HFi8p9AMMMx8/bWELxRCJ/38HVQWlhKVIpaG
	 15OsONh4ITy7i6N/EIko9aJUPuu9Y2+Epy88B0M4GnOI8iiSPlEpgOXPIM5tRT7d6nAtH
	 /bq9mvaxCjX59eweGhz6EuahqvTTRsqktGNkplO8kZs2LpxRbrf5TDQ4XkFwKKeoekRQH
	 meA2vO8WwzAoBDE262s/mRNVRmmC8wA6gDKTNdt6hyiULlL8nh4cbNTDXTQmqs1+qfA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Wd/wlQku";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.9
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF0606A32A;
	Tue, 17 Nov 2026 15:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FCF0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Wd/wlQku
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHenrQ6/H6TkAK6Eg5EnoZvRimt7FVTO8WHkiLSUbGdnsqssQvP/C/A0lpJUudIAjIwMI9rY2QPnI+NjAwWs0TQ+P0UStj8Xo7Q8bmPaFSDHg5RT7wtnHR3v7oYif8ZkgrpCO/GgZ1gSGX0HhVHizEgVZqo7lClZMgUSGDGMsjqgwSTVR4tmVqHjIT0ny8GKcKhauvG2ZT+rJ6oXFJIV7WalaF8l588aOjxQSevF2ZJ2O/QpUauVROgeSuua2dC4Xj6ztgBSJ7r3espzDTGJO8ZsfRy3+TKRv5vPL0f+R+/Jwhdkp6ZP0mJdkRB7qS/5+Df6yDBxcSDWr1KyeZat2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC5o/USjbZny1eEd3PMPAbp451+2/6/OdDEjm0f9IHA=;
 b=MbQk3bKjo7kdR8YUI7NZq9u3uSo46Of1Kw6A/Ws4obUDY8BoT3mYpF3mzVaiaaw7dJcS2uhFMU9dfiEq/uNUdslKfNcuF+6cbN6F0JGJGMhlE3LzSmTNLgpFEq+oPjzzbfM2ZryQh+1N7kziW/gJ/khVUhq8OmgQ8IOUDKysdROfnMHGfiTZ01S4ZOf9BcfcDMA4OP6MAarF32OY9VVZ1+ouqtsPWS5yGKDw2ogoChriUfTii1Lvn/WvXzqP50GXMp3akDQKUTWKE1cdH1TtHDLputixAdJxTDsOnI5jfd2br/7ylLKY5KwgOGyoKPF8Mu2eIZIFIqFjGgfy898SYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC5o/USjbZny1eEd3PMPAbp451+2/6/OdDEjm0f9IHA=;
 b=Wd/wlQku70A91bb7P+N8pKJxpj5Mv1PKUjqIHQhn9bVdV7tN8mcj7JD4FFRyzVR/eoJXuZpDLC61sy464dqJryRPb6DWjGiKSfQCTJhDa/AC7SrVo5F2GHDAK/1OT79FwRqQI6y1f2y6tcGjXhsHijdajZpve5ENx3kRL1sdZBXtA4pnCn/yTI2loiuc16Hzp1MKFQK0sLWaCBMvD26Xr3EfzlPBnTGFF5+HoVJ209yvblqyCJQZwTPQHryDTCUyxHj31HSrh/GMVSUFYnpJMLtYnwREx/rZWdHAIRlM9w8/sjZ0H3FYqsZidlILm7u8DopJYJKdvROaaAEeyFBBtg==
Received: from MW4PR03CA0152.namprd03.prod.outlook.com (2603:10b6:303:8d::7)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:50:19 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::91) by MW4PR03CA0152.outlook.office365.com
 (2603:10b6:303:8d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 15:50:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:50:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:01 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:00 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:49:57 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 0/9] cpufreq: tegra194: add Tegra264 support
Date: Tue, 17 Nov 2026 21:19:45 +0530
Message-ID: <20261117154954.625126-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d424ee-5307-442c-e82e-08df44c27b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|23010399003|18002099003|261009221227099003|261009223027099003|13003099007|261021123027099003|261021121427099003|261022105027099003|261022075727099003|921020|261102123227099003|261028144727099003|261026121527099003|261026140227099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	EBTxuc51855rdSzcMjsL2DCucjhfvq7V6rtpJcH1nfQmUdwnZpfsRkSjmFte+PpgEy+kv3yuxip4NTkDDd9+6FJgsCe1j2/COS/zlOCH1rLEqAMkAYbLhNPzU9eWgKeKo/JxfpDkchSxpNnNlnvJ+blu+a2l11wCvf6lAGPBY2XAPCKZnjtL8A0zyzn9e3BKhpJmFQZh0WuSCvz14y0nBnd3mMngQKqZfGIbKoWXP51l5/SerHPpa6HGla7j2DNtcaBdoV5ecMVzIDsmKo0OYEyQC1kkk816Dug5j4pOWJem/bunCDIkWF0n0bKOAnbmiALVDa/8vRP/oDQmy9DeaEZVNn+7r+aW397pHy/ZhpLgnsVurTYailkJS81kptPpzgNdUlE5dT63S6iIN/j4nfxeHb/ypYQissy8ZOEb21fYTC59+zw0KMPYHgDwekLSe8xGIFPuCD7NsyqXViIDW9+9B7R95qckHSfQtNnN/e9ulRg3TqcBWftxrGPjzrlCguieyIb8/kvqgui5gwcLj5zc5ZP4uIShWL4aXRK0psm8B3iLZ/qR9WwKZcJtO20gvyiL17v1TGxAdgOxIz86/Af6vyTW1TNLaHUKwhRC+Jc76ylthC3iV7MN7LgQznDKvMHPcycUnn69OO05xqA0yXjkxI1fIIVCUPOPYEIHwUpDHq2SYAob1LQ6FTOL+kIkKYQUoUfX6XZIrPViv4ka/x/iYQIt4To98aPVY4O5gGhrP9BPCzvPAHeJkTVOrvyG
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(23010399003)(18002099003)(261009221227099003)(261009223027099003)(13003099007)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(921020)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FlsW6R6SgQ39UEuTtDIzu9IgjT+PyApUjRigv0HF1/J55GBJf8MRLTxRHMLk/IV0zjAUvxKvycdBR3qiUQwtAnpY8ahZ/aue96Q6WRQkO4TH00MEZztA3v5WSC/5fqhuLmQP8y3NhmBDfF3SGevGwv7tEHoP50HVh8PZfxEsvbwp4yXE3wUA14SW9mgI6tSpTqVyaVdEB98+D6A6f60A34di4GLfz5ARbMbr+TzDGXvQxVT9OCsfY8YJU2tXrmpemX+JtRjfMAGO5seAqz3LNKWNQRS7N14PFmmpQ8k4XerOJow/fOaYPi88e9x7XNm7djWhy2bDh7DyM9bliQWstcplRdVJus06Kvf5OSA30CarDOoBDhBOSjpQaAnyJ6smWXKiB7GElLI3bxKANGMA3CIM2niGzz8+X2prcvi+fiLQ+g/YBNfkIyLe3BkhGKlm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:50:18.7956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d424ee-5307-442c-e82e-08df44c27b05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

This series adds cpufreq support for Tegra264, which joins the SoCs
already supported by the tegra194-cpufreq driver.

Tegra264 keeps the existing model, where BPMP provides the NDIV limits.
The driver derives the current frequency from the core clock and
reference counters.

The main differences are:
 - Frequency read: through system registers, as on Tegra194, but from
   the 64-bit architected AMU counters. The reference counter ticks at
   the system counter rate (CNTFRQ).

 - Frequency request: through MMIO, as on Tegra234. The driver writes
   NDIV to a core_freq_req register in the CCPLEX register space. Each
   register controls a clock shared by two single-CPU clusters, so both
   CPUs form one cpufreq policy.

The patches fall into four groups:
 - Fix (patch 1): read each CPU's MPIDR from a CPU hotplug callback
   instead of at probe. A CPU that is offline at probe then also gets
   valid cluster and core IDs.

 - Preparation (patches 2 to 5): cleanups, mostly of the counter code,
   to make room for a 64-bit counter and for an MMIO mapping without
   ACTMON counters.

 - Improvement (patches 6 and 7): group CPUs by the generic
   "performance-domains" property, which cluster-based grouping cannot
   express on Tegra264. Device trees without it keep the existing
   grouping.

 - Tegra264 support (patches 8 and 9): the driver support, followed by
   the device tree changes it relies on.

Patch 9 depends on:
 [1] "arm64: tegra: Fix address translation on Tegra264"
 Thierry has applied it to the Tegra tree. Without it, the
 ccplex@30000000 node does not translate to the CCPLEX registers.

Changes in v2:
 - Patch 1: drop the cpu argument of get_cpu_cluster_id() (Zhongqiu).
            Check for a bad MPIDR in tegra194_get_speed() (Sashiko).
 - Patch 7: check the BPMP table in tegra194_get_speed() (Sashiko).
 - Patch 8: fail probe if AMU is not available (Zhongqiu).

Sumit Gupta (9):
  cpufreq: tegra194: move MPIDR read to CPU hotplug callback
  cpufreq: tegra194: remove duplicate counter sampling loops
  cpufreq: tegra194: add tegra_counter_delta helper
  cpufreq: tegra194: add per-SoC counter mask
  cpufreq: tegra194: split MMIO mapping from ACTMON offset
  dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
  cpufreq: tegra194: derive frequency domain from device tree
  cpufreq: tegra194: Add support for Tegra264
  arm64: tegra: Add CCPLEX cluster node for Tegra264

 .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  27 +-
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  21 +
 drivers/cpufreq/Kconfig.arm                   |   4 +-
 drivers/cpufreq/tegra194-cpufreq.c            | 451 +++++++++++++-----
 4 files changed, 382 insertions(+), 121 deletions(-)

[1] https://lore.kernel.org/linux-tegra/20261030141101.845044-1-thierry.reding@kernel.org/
v1: https://lore.kernel.org/lkml/20261104181521.3003578-1-sumitg@nvidia.com/

base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
prerequisite-message-id: <20261030141101.845044-1-thierry.reding@kernel.org>
prerequisite-patch-id: ba5cb48e4083d98b7c88166e68fe25f3dcb80650
-- 
2.34.1

