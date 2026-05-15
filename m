Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D73A1681;
	Fri, 15 May 2026 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848013; cv=fail; b=kC50rRZTW86qBh1pPN+S6dFjsYSSLzeSX/f1vxfhmVhsZOUonMQccEUQ2yB/3BfGAUOMCLHfEyBIefMnBLBFV34Lks5t4e7kGmCbcDUxrEtl8H81f6Q5T/aIbLjLkzy1WAxqj90wC7e/LWtUuZ97333fvm23zA8olYxD1DHb2gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848013; c=relaxed/simple;
	bh=J76OTy76s1x1TSuYT7q0MceegW+0jeBI5ldZUoANzFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=use4BwB8NYSdd2CyWYYZVRQxotlUmozG7bmSynvj8Hib9DIPsRJlgkv0pigWtKxOSm+8DKp5QJTIaMIvu9Nz7IV1xewYsbm/9vuVmxFj03NPZLL4aCVdgAr8ksJfoN2DhhQ95jjC6IPzUYdgn7d+FltFC/NGoBzSiQWTRcBzJDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d6t+z8aW; arc=fail smtp.client-ip=52.101.61.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d6t+z8aW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUmiq0rg+Hh0p0MWqySqkTind/St2Ttz3dco/+iFPfZn9O4qONyTws1g6LUUIuE8xzr1OcKqIfOgREBP91yt6L9mJo59d7FHRto+YKrCRTEdm1IDH7saDsRjVIOB2TulljXlI1jBX3c8Keh6BNzslBav9DILlkXEeY3QNhreuQ9MwatVh9zrmVYoriWrbBAixOERMFwLEJXxG9I/rqtTkxf2QJQPbfMi80Tg2QaV/CxulP6dZ5kN9PtR7ZK2SToj0bWZGcScIfyaA4tp0EszNVh+JEHjy+3h+MCie3H4Y4sBKy2tmLxyGg356LZinsiAf/tL+1VqTXfYhWAeVs5gXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrjhVTNyKzEKpk12obB/PerKrjPsoYql18vyhbxcRTs=;
 b=mS3h4aJTqqnKhKkituIcCNqL0ZPukaaSUZbZgl+AprARXjp2DEMOT2gUtnCXN2EaYSWOJ04qCl5cxPePUBG+ZXNkhEpB5zz3ruHFkYBvoZ9fhHGVzTpXEAV4EhXirxGSgKgPjhz4vDCZ4cFFPXGu9RJZ6oxV4p3gZmBFP/KDL5LWngwlrs+JXop1puLg/n42Qo2fmqdyZ87XkxRjXJGFTjXRw4CpWGsB6GmYGczSzaaqDFLCPWPGNv66TexPqRQoL7rZ86078MsRAHIuwI1aYMTdXE/s7bI7zJveO7d8ch4lbpMVvgucM/AgVx5Z99L+3FENsam3ixX0dNcVcpdEwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrjhVTNyKzEKpk12obB/PerKrjPsoYql18vyhbxcRTs=;
 b=d6t+z8aWyEnzIy0T4rtdgDzlp4E79XuLz5v4uVec8PulNyAD6GMWmJPdaKoLXBn7iRjpIUewXNBwyWzS2TnqLsMqZEm2PVP6S9ROMg18JyCkLK3W6fo1caFTxixsCc75Xu/J8nZNLFhbC8uptjTryIzXOxsJGxRdA0ig60DP4un0ehRCr28ByMtofTagFgjObuEDU+asJdDjSv7Oia46HiWExR7H+wBYR5wXGbBRoZIzQS66bCb4TqUKJ/Wk6GInqABtYYhZYmozijvzp/GiFrEO3jKNV2o+XS7G9ti47zo53NVU8IxHMVMbZD8FVUZxw0RTYcd/3Y1tNQnK1XvXxw==
Received: from BY3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:254::27)
 by DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.19; Fri, 15 May 2026 12:26:43 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::7a) by BY3PR05CA0022.outlook.office365.com
 (2603:10b6:a03:254::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.9 via Frontend Transport; Fri, 15
 May 2026 12:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 12:26:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 15 May
 2026 05:26:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 15 May 2026 05:26:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 15 May 2026 05:26:27 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v3 0/2] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Fri, 15 May 2026 17:56:22 +0530
Message-ID: <20260515122624.1920637-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: efae3e97-5dcc-452f-0d67-08deb27d3682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700016|56012099003|18002099003|13003099007|921020|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	rWUeJ1XI5uwzBC7KJyK6a/vGr8K5uA9UFzxz2Vv3l5yavufRQFvDtEf9RevXL8gCEqpeJSXX99qO0brhZvgjB3MwKr729RXlxXAB+YFqnrvcGXBDOhpdraMY2JpikjOGh8u6CYltnkNTu3KClh8mIFJTyu0qgC6Syj4YRsxdiw1LV8Y89qrXKDf8ZCmUKM4Idd1xvZXQpZuG6bELFaZUJzWVVgwVvdg1nAeaQRoOEWjWvTNnKOruNHCFJEIrFdC0SYJQZhAaKMjHoiFgQppp1cEB6d3K+8VzNmTG6KPcgV93nInM6IzInqendNKPM/0zvK1vIN8FyzkTFGFkQsxeY5pisv6Ail9GR48jcv5zoOsXgTs+nYK9qZFBw1febdr36IeZ+IdWLYxjRCBETGBti2Y+S8T2yz1umsc+NPOTMdzYta0awV8bS8+2bmhmHmnKdqEQpq0WsjWo3GYOIvYSL8IEDjax/X5OodWMbZE3Q3J8LFtNV0XRLeDm3asBzH2eDg6gosqRalcUsNnb4Bwn3z2Kez4DpntrFErjCb3p8yKaLaU3ruNP1z3e5LYhrTUSzC/atd3vAI8CjoaZWmyj8xBR7JlNfkSWwGK6ZxPlnKbyhX5Yj5r9UAb0IzPMYhnkjmkH2xjUVulgleCzzlVqEraF9ALg0XgDqEW2MbS0SAmhaK+smMFGUylq/Y63wQf7/mSu/m4Z0dGnayFGa4ixzMHDBWVyxCcfIzAp2/ZxgRDKJZ/BB0wCQlWrfn3HpWWDaUcHnp+8JLX19ieZcMss+4MKSYyaor2KN7TQoY+22+Q=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700016)(56012099003)(18002099003)(13003099007)(921020)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GVj66gF9RET/jibH1VskvUfjH0leWStYT05m4+BdNT3eKc4wTzm4y9YbNKmxlrtKyf8SjOPY40Dsjz+Hc0vNhxt3bQ99sX11tmSost0/FJBdsi2DNOGXEQG2wmisgtZu8SvtEUsk9mhy5s8MumV0IynDRpOHIIoETluUemUfZdbUt9VRGPNPMSPzvbMonhoqnTBHcR9OSZQNeBHA0q2M+P9N5auBluxfDYwPcvcSDY/Hhn9i10JWo4y2alpXLzw7I5y0BBHrUVlrBttd4wFDU+S1PX76iMKykbNGUUv18iSo8FKRd+ahZ+ZzRmG2pmHLhwM5J4q7AzGU/oPjkoQBGf7QVP3ACGTEdqDleUOHqZGbcG4ShPsHqE2zvgNgAEjqGNFm7GiHcGzS24d1VZ+Pqs/XbD3LKCyG9KpCDvXIzyhe1C61LyHknwh34Hzrp8Tq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 12:26:38.8092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efae3e97-5dcc-452f-0d67-08deb27d3682
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117

This series adds a kernel boot parameter 'cppc_cpufreq.auto_sel_mode'
to enable CPPC autonomous performance selection on all CPUs at system
startup, avoiding per-CPU sysfs scripting at every boot.

When autonomous mode is enabled, the hardware automatically adjusts
CPU performance based on workload demands using Energy Performance
Preference (EPP) hints.

Patch 1: sets CPPC Enable Register for both OS-driven and autonomous
CPPC control modes. It can be applied independently of patch 2.

Patch 2: adds the auto_sel_mode boot parameter with two modes:
  - performance (or 1): override EPP to performance preference (0x0)
  - default_epp (or 2): preserve EPP value programmed by BIOS/firmware

Patch 2 depends on Pierre's series [3] ("cpufreq: Set policy->min and
max as real QoS constraints") so that policy->min/max set during
cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy().

v2[2] -> v3:
- Split cppc_set_enable() into a separate patch (1/2).
- Change auto_sel_mode to accept EPP mode (string or numeric).
- Drop clamp on desired_perf; initialize it to max_perf as a starting hint.
- cppc_set_perf() failure during autonomous setup is non-fatal.
- cppc_set_auto_sel() failure: fall back to OS-driven mode.
- Documentation: list 'performance' and 'default_epp' modes as per code.
- Removed Randy Dunlap's reviewed-by from documentation as some change.

Sumit Gupta (2):
  cpufreq: CPPC: Set CPPC Enable register in cpu_init
  cpufreq: CPPC: add autonomous mode boot parameter support

 .../admin-guide/kernel-parameters.txt         |  16 +++
 drivers/cpufreq/cppc_cpufreq.c                | 130 +++++++++++++++++-
 2 files changed, 141 insertions(+), 5 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260424201814.230071-1-sumitg@nvidia.com/ 
[3] https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/

-- 
2.34.1

