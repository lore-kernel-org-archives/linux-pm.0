Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311D3B71D0;
	Fri, 17 Jul 2026 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784325268; cv=fail; b=tab+RQ3UqxsFyjN+VLkxXtXrXEehgW0uM7DAeuQ0/MpXIx92EhAum4ZeBGm0yMpgAug08S8l9SECDdK2Fbi5ZOeORFOtnQGriZMqLgPCBinAV22vrdqRcylL43Pc9zNSBdeNrGPM70bZvu5og88fktx8IEoRKubdfTFGPVOsuow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784325268; c=relaxed/simple;
	bh=aWG6WgsAHyfeKJza4zO9L7ZiG3sDZVfPklxQom//P1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FKljuQnYQZHdl/kb4r7uWTsqIdIzXuIG/7MuS26jBKKMsFiq9FN+tLMeCK55T4H4x6b/Lf2oeXNF5hRPEIoGfv+qzHJR5+eMRcpxIEOPtJ+zvTOhqikuEmOIwcck4nKpeJ8qGmOXvoxuj7Xs7mtG2rp9kHi6Pw0ArjoxLKXS9qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OBjJxsOf; arc=fail smtp.client-ip=52.101.46.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OBjJxsOf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5jyA8V8OoDJTse+lr22X0GJ157E3PSa96EaRZhKZAbFgH2Y4u4d/TsN0TXBQqSE8zknyi+9w2p84C4obqSTCei2vWiaew/V8psrZOn1N8Phk4Ge6NuuByDkFSVLp0q51HTs2WGU2xg3VbUyR+g2X6rUeStFvKWQJAX96Os8yo5iLyVJC0KoC6AmmIuZGR0N/gipE9XAGmSG0jatYfnLFiRPjYiTbdsSdl6AUVoG8MmsLuYezFdyUfAeaeFJR0hiAHNMfWoFzRx1uvJtdM3kwoH0MuWtF20au8ub1dayc7oicvZ9cAbQvVlHTupSV3AQnhgHlHrO9s2bHHgt6SvLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S33eV/oA2+Jf6ISDgozGtgkq0ME/cT+celhez7vcRts=;
 b=xSYiD95L+z0PBu3emj5CJ3DtDL7bIpoLb5EEXcuGUULORqYVSDe5m3GS0Of5zU4MMMWcRgeupHXAZAUgdtYJHrVQozA3ubTYoBR85DcQCUeehG//Z+QPf3NGJLmWhJPlj9JDecoEUV4qHKVNeBz8thD6odfZr44h+iJspeFelpFpJnxDgD8w5u6NlONwHjJ0WLXkx80fdEnA9aFhFiqGWRrJZWk3ObwebsKxrZmUZyKti1tpWtrNxblfbhGBoWCPMrRw+HlyBHTeinjsn/EX/h+TVrsekzZhHmWqml8ozbgEAnLQy4fvjXqweysnGPI7LzdRZVVPg7S1gNRbcAgNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S33eV/oA2+Jf6ISDgozGtgkq0ME/cT+celhez7vcRts=;
 b=OBjJxsOf6SYQSTTU+YPHhIqLJPNbkFDzOE/akNGf6ZmT1y+HEi9wUaZSHjscaQmBR3lvkjsFWpNfu5xGMS/sIX/Aeu5Mf+SE0zLBoP+Jt2iSqnTsNwlkbyARqipvhW7XZnIyVmst2E87S4P9mGC8+6zzdt1R42AJKmk3w9lx7+fXtL5h4ClFHx0U+WUVNnjwdKkXGQJpkE9RJaqwpNE79t141XP6pUjf6e1s7qiLUk+IMDBEoaCOuoW7aXmYExl/FQzeGWZKMfbAZH6udF9uQLFanoU52pbSYz7MU32mDbQxAhwNpxGfHI4dOR9MGJl+trAoSXgyu0IsrC4i3GE2oQ==
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 21:53:51 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::9e) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 21:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 21:53:50 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 17 Jul
 2026 14:53:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 17 Jul 2026 14:53:40 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Jul 2026 14:53:34 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v6 0/2] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
Date: Sat, 18 Jul 2026 03:23:28 +0530
Message-ID: <20260717215330.2215058-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 09770b31-7a94-43ce-abd1-08dee44de333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|36860700016|1800799024|921020|13003099007|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8/mdmfw9rsCmh3K1UaDDxL0NNFPAzajf7Nyt+lYlTSNIe8fKKM1EVjUZtj4et9L/02z/9UZ2hHD0fgeL445NryF/Fq6GhthS8hjP/7EnzZu580tRXtxKbVub8wGBkhWlYfD3otG8lAL9NVhmqV0VtHqb09YFoLRCbCTibTYyswlZnAiL9xtBIN2KTAgxRZUEllO0klXo0NZt8ZldqLP1PKROxvzVIxq7MZkIDMgaYhj1Mln8hMRnHDFctolbZwnKC5WPfd7BLKwltV2n7fdFMOZZXa149Jg5h88YBg5uLl1XE+Qi/J2mqdl6w2SeFCdWoCo+Oj7cO70Uzh/hOSdGfrGvtKB5GJl2c3BvT83X7BweOLbzdR+ijDOzlp5xjdGCQSK+zK80KtG+gttvIm2W9yGZNTbShncaOLQj1q3lCrk60Mxed1RW4yfHu+Ik48MCu8/+PR6RZ3ryP2W9ljkpiWokTl20cznGg3bYQ49wV8fpp004a31ze40AtKRgJlO9LBCtBFqepK64dWHu8Hj0hvfrv3FVfUdNPcblOR9fM8UZJmk2Ybw5OyUWyHKX5sSQnSRH6c7dYh9TZMmrPtUpNAFm/NqtERyhrlXVVC2YbV4y3+7NaXEiaCTeYu7R4zDWOlKCfB9GLOleobvz6NKFLR8MGtlXOJIV1tIpY0iZfp1Bb9Ie9owo41uQnZnPfjglDNJ/b2l9iFoZW8ITbyNuw6kWTV4OseeePz0TVPClY5ohnKnHBo95ovwVApuQtadc
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(921020)(13003099007)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eq1f0rPbzvG0HGbWVZOveB8HD/UWogK+LZuothbvYLNtI2PLvXAj9lPrpzPYNMAjAe50htMRnIr6YZh9RdeD6FCLkTA6nNJxs5RNVcUlfC7euvbz2qFx81czdx/Jgn4PWvvE5GbuioW7wscMdZ0Mjcwu7Wj6iuxiNC2Ziz2w9FtbDSMLXwI3LkS5KhY4gqfKeSFFj1LXkrLFW8ekB2FUPqAAVGZNTH26v3lDqYNlfpwu+fQpqfIeh4K/8xPolf2GY0PFdpH/IhNEcLq6CBjzvkWfNNv/M+sPma+vN1jZLX968wp+5GFKw1gtPeGHY4K6x62mupyCTz8RDhlhb9mRn0h4cINWgbLpv8gR+EA4HKOq4UAbyUy8rgGbbvDXkp8WzrF+fno0/lU69M4aGtlkDx1rO/Jo6Crghx5aMawJ7r5rde8IQOukMasbXOgiBFSF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 21:53:50.7155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09770b31-7a94-43ce-abd1-08dee44de333
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

This series adds support for the OSPM Nominal Performance register
(ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.

Unlike the read-only Nominal Performance register, OSPM Nominal
Performance is writable and lets OSPM request a nominal level below
the platform-reported nominal. The platform treats performance above
this level as boost and below as throttle for its power and thermal
decisions.

Patch 1: adds the cppc_{get,set}_ospm_nominal_perf() helpers, a
per-policy cpufreq sysfs attribute (ospm_nominal_freq, in kHz), and
hooks the register into the OSPM-set save/restore table.

Patch 2: reflects the OSPM nominal in the cpufreq policy so that boost
and the frequency limits stay consistent with the register.

This series applies on top of the series
"cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload",
which provides the save/restore table that patch 1 hooks into:
https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/

v5[5] -> v6:
- New patch 2: reflect the OSPM nominal in the policy's boost state
  and frequency limits.
- Patch 1:
  - write only policy->cpu instead of looping over policy->cpus with
    rollback. the register is treated as shared across a policy's CPUs.
  - add the register to the OSPM-set save/restore table.

Sumit Gupta (2):
  ACPI: CPPC: Add ospm_nominal_perf support
  cpufreq: CPPC: Reflect ospm_nominal_perf in boost and limits

 .../ABI/testing/sysfs-devices-system-cpu      |  26 +++
 drivers/acpi/cppc_acpi.c                      |  32 ++++
 drivers/cpufreq/cppc_cpufreq.c                | 166 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  10 ++
 4 files changed, 226 insertions(+), 8 deletions(-)

v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/

-- 
2.34.1

