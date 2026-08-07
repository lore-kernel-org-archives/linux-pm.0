Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498F3546CF;
	Fri,  7 Aug 2026 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139363; cv=fail; b=XJXZ8SNM6Y4Dcyr29fKM5JvhmYuwxSReGfnGPPF0XVjckPzuH713LU7AZHob0p0bv0bKwNlz8EluKepQLy2XfS2qO4GjejCvWW2FMWVJVaxLyKl6fhe11sl8hE/ymjtJnXyJvClsoR0Qw2fubVEIbd/azh0zU/vy2U3XzCAqRM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139363; c=relaxed/simple;
	bh=+Hjgi4bILmzpM9PDpY9hg4q1Bad38plV5ie36/SNSUY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BTo1zekntRsdeHPA3m/6Mr1JfuR145x/zZ3qUbF+YDbGVwblKg4PrlCVDg5+hiX/Hw9ucnMrPq6x6RZ81MB+/Ycd/ZDXLkQ5dzAOZhXHGPciCS0JdRsByG172S9EvjvDoTQ5gFCWIyE1gSFZDASBM0psED7dcjHquW2JQu4/XAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PZKMkIHu; arc=fail smtp.client-ip=52.101.53.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZKMkIHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7UFUcFSP3DqCpoY+sUrbX0+mzEXljCVxY70N7FoG+bc0HNLXaOGaTwssOdwIduHWjUPw+wUezOsU8BcIY983Aojlh8QMs9nXp0qVrOAcaEo4mNQYWY6Zk0fgMfRbxR3Q3CJQrhVOFOFFMUzhBshg/k3LrGx5P9jrSncSwy9PL0SCG8ORfdpf1TXhxInJzR8OpUqGLijxU0wGSnpjVsB1XrjAdxPC04Nx7yMVtmSFclQnpLbF+XmzfkGsiQVAWBc2ZNPH0VqB087HLyXTMqRonBYgtMYDf3D0/8QsAJ/7lgHAAAhqnEqAXpLyOW4TA/p3cvM3indWCPetP/0pI+uVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMhesy9ER0eTiVNPZIuNBUCbNR0C5eh1JKA7mMZvcYA=;
 b=ShVIoHCtARD0jg1Qhh2kGHWxlvfK3k+w2X86EbDWSyA4CO4Hq+Jy196ooq4nK6CEQe817sa3sv+19KryoiA+pjQ21XUi2SPEbuSSH91tUA48Hm9/iyFA7C8TTOzTXmgUvW0Bn4dHxBfQ476N6boGGea6QKHGr+oDnRfezSP9nEPMlX9fBUPyfJA1PYmOI7uVsjxKPUnIpP0wdvO3GjL3TD3X+3B7iBLUaln6CawXCkPIJ0EpvIAhfaKzXWPiaEgNwftGvBKuWFVKH2Gwa2bVLngjjP+zkqW/Ozp53CaCaLiq0Ki0Ec6apwo+xm/PWftmg7KOj/i7EtPWP/JfmMUIGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMhesy9ER0eTiVNPZIuNBUCbNR0C5eh1JKA7mMZvcYA=;
 b=PZKMkIHu5QrswkkYHBb2nYPsUv1OYzYJ148D9Ac9W7EyL70VvmNRpkcircjUQdh1WeAi3D4ORMAd9e1SmzdaXyNdr6VG1yq6MX2KOMijVtq6NbZ7IgmIQXaVsKPJCFbMya5I7DVmbmsoGkureXQgA87e9X8m/eJQc3lRZ9iTRFVbXcWSr0xS52mli63E8FCTdM7w+DQTJJwGvBmguVugddpiQWH9JeHZcn98cguCMZUr/WWZ1F4X4hnY+Mkdy7XnAzVXHW6PFIkrrBWU1Dwq+KiZ5cQntku+VQI4LHIl96FJSPT6REUnXkqNOT7TuYN03iWiuRXUx9CeL0jmTfnpLQ==
Received: from SJ0PR03CA0300.namprd03.prod.outlook.com (2603:10b6:a03:39e::35)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 21:49:15 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:39e:cafe::7b) by SJ0PR03CA0300.outlook.office365.com
 (2603:10b6:a03:39e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 21:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 21:49:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 14:48:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Aug
 2026 14:48:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Aug 2026 14:48:52 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <mario.limonciello@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v7 0/3] ACPI / cpufreq: CPPC: Add ospm_nominal_perf support
Date: Sat, 8 Aug 2026 03:18:34 +0530
Message-ID: <20260807214837.863209-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: c799c5e3-b031-439b-8edf-08def4cdb99d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|82310400026|1800799024|6133799003|56012099006|10067099003|11063799006|13003099007|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	589Gn4iyItpUG2APRpRinaWoLnWZ/hCILNNM7qoploTZ2wmiAGOKTXDI3eNbIK9QLOb8bR9EI3ILDbtU7HI7VkJec5L4+PoCIagDTO2WQiPu3e4+m8tua5BhSDckoMPmuxCuJjhuqrDptF8Vweny+CNe10vffQ/InmDHk+MFRGcHz5mAY7mXhm39KBsFXrTonYnnmzpPfwl4Q0nZ4EjaOdt8nWS9IuL10/13p/ob8OqI/eOpE4aX8PBm0rng0aH8Rsb/tZkTOg9q6I/UW4qdQPOD5Cyjc3eUvudc664tjFA4MGo0coqpWOp4pNaTM0P0kra0z+4LzUiwZadRl+K9e4vogp4007Nff8uvNxaufgWoMnDCPO9Yh/cTKEevsNFoDr0FV96GCSIOb0E2gMmtFy7WFT47Ue2p37HVreGrwcGMaYkbkdNkygDPKvTLh7IZhUGTM47M8Yx0fl/jEIOUhoBcXILNsF3LFoWWJVZ8RLtWNRnIwh3pgK7wgDFJY4VnhMypQn8Ig5qLRJx/mVf1HV96LmfV+M/sAbzcokLnCTPsIhuOilTeJpWAWcdnivybJuhUDNLqCrMMmNm97SXREFvEn5yG2qTBUDQh2273/kMGvQSaeeSDuLkaWNn2SjJnI+8xny468O7+HpTl7FZazKAd0v1FdSLTPx4jgg/G+7OGPxZ539yB0L575VzMmnuenY3r0JUZ8Df17MKQpAcZTruEvybLfnUm+yaYvefbHnZof902LBmAWZR+0eT+bNTO
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(82310400026)(1800799024)(6133799003)(56012099006)(10067099003)(11063799006)(13003099007)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Xt0F77SWXQXY4If8HfgKk7oRzBrmCy2Mhhu27Q6TFILySEEexEtwKRt2lXOMGpz9l7uNahROxXSDsCh85LVKWrd9aK4/YvZG70LEVU49DCrkJY2YHf4G+DfyZNofuM01ciYzlRW48VUYZjm7lEaimXWy7tVjzdWlvA7wL5M/TThsMmC49lPffF/uYD9ys9eOVdVER0zFizIDr6Xg8E1mbl56KkuiagOe+s2Z+cKLtXsCeI2X7Cy8akdYq0blpkokWpNFl1f4/q/VJR8yagdr+8hh5IxB1+w8Bxf9T+x6ZrFOjel6bpC/fiQY1wu3uVPHbMu8kY89nvtHQjvSttluiTNhFgtnt4nvTT5/DriL6p9uIaIKZFORkTHMRupt7f0/Qu7Le41q4MsCfLKpRQaxCPJPsZAcX9sRkHBH0iNoZ0RQe+uSvcI0Zn3I+6ij4/OJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 21:49:15.1531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c799c5e3-b031-439b-8edf-08def4cdb99d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901

This series adds support for the OSPM Nominal Performance register
(ACPI 6.6, Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.

Unlike the read-only Nominal Performance register, OSPM Nominal
Performance is writable and lets OSPM request a nominal level below
the platform-reported nominal. The platform treats performance above
this level as boost and below as throttle for its power and thermal
decisions.

 - Patch 1: adds cppc_set_ospm_nominal_perf() and
   cppc_ospm_nominal_perf_supported().

 - Patch 2: adds the per-policy ospm_nominal_freq attribute in kHz, and
   tracks the register in the OSPM-set save/restore table. The register
   cannot be read back, so the attribute is write-only.

 - Patch 3: reflects the OSPM nominal in the cpufreq policy, so that
   boost and the frequency limits stay consistent with the register.

This series applies on top of the following series, which provides the
save/restore table that patch 2 hooks into:
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidia.com/

v6[6] -> v7:
 - Split patch 1 into an ACPI patch and a cpufreq patch.
 - Patch 1:
   - drop cppc_get_ospm_nominal_perf(), as the register is write-only.
   - add cppc_ospm_nominal_perf_supported(), sharing the setter's
     writable check via the new cpc_reg_writable() helper.
 - Patch 2:
   - make ospm_nominal_freq write-only, and track the requested value
     in software instead of reading the register back.
   - place the register before auto_sel in the save/restore table.
 - Patch 3:
   - rename *_reflect_nominal() to *_update_nominal_limits().
   - do not fail the sysfs write when cppc_cpufreq_update_nominal_limits()
     fails to update the QoS limit.
   - skip the limit update while boost is enabled.
   - make cppc_cpufreq_effective_nominal() take the value from the
     software-tracked state, so it returns it directly and cannot fail.
   - init() checks cppc_ospm_nominal_perf_supported() directly, instead
     of using cppc_cpufreq_effective_nominal().

Sumit Gupta (3):
  ACPI: CPPC: Add ospm_nominal_perf support
  cpufreq: CPPC: Add ospm_nominal_freq attribute
  cpufreq: CPPC: Reflect the OSPM nominal in boost and limits

 .../ABI/testing/sysfs-devices-system-cpu      |  24 ++++
 drivers/acpi/cppc_acpi.c                      |  48 ++++++-
 drivers/cpufreq/cppc_cpufreq.c                | 135 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |  10 ++
 4 files changed, 208 insertions(+), 9 deletions(-)

v6: https://lore.kernel.org/lkml/20260717215330.2215058-1-sumitg@nvidia.com/
v5: https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
v4: https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/
v3: https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/
v2: https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
v1: https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/

-- 
2.34.1

