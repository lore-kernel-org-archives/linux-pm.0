Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A755285CBC;
	Thu, 16 Jul 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216353; cv=fail; b=QtJYzLH9SSh5nJfGMRiBwtS4BkQc1dTJYKMICqQuTXpwKFQ1EBarULs6lSH/bJkh4xLQQjSp+1W683gGWIjc28b4dg0L6wPpjlkBSIaJmfQLCRxm5utGXAVWPYrJK0qFGev1hY4KFqhZ0F66pv2SsUqhAZm5n5IVe4pjFRvHOX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216353; c=relaxed/simple;
	bh=d2PSAbTmjWx6RT0Yg/Lp19MhxeVFqCVplsu/5ocYk1c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pntHOYuE57ZUy9W9yyLgUph3PJB5TwSGBaDp6A+WYj0AzDM3z6fyK/X8VYMMDEWzSBjR83ui/0U2cvmgyshDovFUSZoCn2BKb5jWhi1rtasQwWzjILjQrpaj8aicHE89LwzGvo9crGp5Kp83EI17GOHX+4A7HAdoMxKe7ZcQMIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WyxTlSg5; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WyxTlSg5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXh1P4zDegrqcPvU8bKDHz30UHDLd/x+eaxTj1SR3wKnum/Z+It/U2oMeMF8+nsCvvjXB4Gd71BFGN5O7kwNii/pnBdJXGIALNfVCYwEbDSicwZCtwRfurDgVt+1l1tBho/DEosJKUEndRTWX7t+odGO3CLKZUe76gvXV1zHVq2vshZura/O4dMfYQpADkeD6/DuHaMh9xQqFvjP/TcRl2QH8Eo/tad0nsa+ga29yJL0b8GJGSW7g7urMdwTykQiJskzQh9/Wk8SPY2sXmLe/lML1d29sSHea5BvJnQ9Wfk190pBmcCIG+AmCVegxhteY85vwwrINAJndb/IoCR/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9aQ0FKviIrwAU1z9r0zpqhw2RVOVJjbEE1wFNmDAAo=;
 b=NC4316o42vNUInXXkF9HVFwoVLeIPALsbpEWdbA/LEkWP4IqnlT5iujXClwcBmaOjBqUxftM/dzWqohYUP+Tpalgzi4EMqZdVCfxfvA6rFK6MbMlf1TAr2EcrzDCJY0XCJb4zV9unk/Zd8CzuGXqxtK+LNuelTkJ51BmqNu1WewQ8jNcZdFtdsIPGvOtd3J7VWJWoyqMxDfSepQxy6yak8Ala++zMruqlr/Vyj3mNyklLGTmgZ41ZGjtGjYb7mj5syM7vsAPGqJg4LSKuoN9ULEsWiu/bpfg4l1wVFOsqeolmOtX/0EPv56pFGUn1sPlGwZTLp4ZxOH9vpeeG6kmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9aQ0FKviIrwAU1z9r0zpqhw2RVOVJjbEE1wFNmDAAo=;
 b=WyxTlSg5tlzGhKtllAEDmN0iR2uAf7HVMlclHtcT3BgDGfDqqpg996WJGZSw6qyE45eoxfyZV/EE+1Hk9NjKBY5j00bNSzCPxdvxdEUoud5SG0SWousNAacURWX6yMaCBWHPZkahb70uo8rk3uR+38Ditv2ZYBDqAX/w7dSnxE0HWTUzUuu0pX9NzVSPdKcjTgGqGmeq/fKqAS/XUTXp9tEg7rJT0iYqBnuuFWu4DPUwQiQYdmTJBHxzzJ/9nPXBL9keUHXKp9mOHLZ32AEkfEPFhqwHNpGRGVt58sc+N91HRrBtg/3ueWFBgW3UX62ulXQg5t2RCeFe3RpqWQn6RQ==
Received: from MN2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:208:1a0::38)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 15:39:01 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::92) by MN2PR07CA0028.outlook.office365.com
 (2603:10b6:208:1a0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 15:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 15:39:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Jul
 2026 08:38:29 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Jul 2026 08:38:24 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <saket.dumbre@intel.com>, <lenb@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 0/3] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Thu, 16 Jul 2026 21:08:17 +0530
Message-ID: <20260716153820.2007095-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: a3102bb9-d1b7-4e1b-69b2-08dee3505b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|36860700016|82310400026|1800799024|13003099007|921020|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	BK3yEEr0Vrv4JKTn9LVFubtYVrp2B3VQmY0H8YGTMHhDVWz09p3XFbMc17qnN2c3Zp2lLf4YaOimxAQckUYoG5EQXS+99lSXNEkXGjAR019GWrIK0VLWjvo6zYBDbYAENmrQHNWjEyslRlKazxMCvwHDLx/HgiuSM6iewWPgBcyO6dJ3Gueo32isXWwQeKkcY5Qd1dPGnXkcX6wMYdWmcTZ0RTgTMAl7lq9Tbuthm4CSEvgkT3APd7JkmmhDljf0KPYaLN4nnMqRYM7hRa73EbW/qNwuI29JwVCRxWYtyTXmESHH5A5zpAw9GqBSfMoxJTTzJEl7vL4eRenQV0gGLtxoYIth+tMriVwUrdzBI9aCMfyipaFviXePTvcgAvXBSTYSwxZ+xHEMk5FonjyS10Ucojn4BzOx3o50A5i9FT1I3R0Gpy9BzdfwXI1veJdq0xEcXhLS7OPgXfu55JR60ojHwlerxCxjrKL74QgiDbRaVqY8hBO18lnFu+2nRkngmFyluONARYpNzYs/tsqF9gBGRaQxvYZpFezY2banwFDezhPo4tBsVUcBN09q7v6p6BSyZSICZL5l+aFqLEE/YgMF9NQyvya9daR+cJtoH3n2LcCMLXaot73M6tY5tPcd//UAZR6RLfmKhx27MnAdDO1FG1f8XfWUnU5iXUf4l9vh+6NVvjoXWXE9OClrtC/NYydTc7gxouxV09TuOBlpxQmGB+BzjOva0WiFEFMCaXVMqo4eoAfszM3CN9SZlAsC
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(36860700016)(82310400026)(1800799024)(13003099007)(921020)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJ3uox+V/S0Cwn+SrmuO2koBgpRDMsO+mWvqgQSmScbsZY/+T0uDpEM+dDBooN84rZosnNqxopyg5zBqE4/hqs2vnYJAh48S85IsxoBw8CYIHSIAJqg/HkOjhegLc2+lLxBSGBwdI63zE5bojtYmCpQGNykBJdQIntKkmI9IrAdmEWp7lwDP/s8YJVi2sVVZ5zDcClXoa0qUuKpIl0SqopnYR0lh3BY2b+4Zvii6OsmsG+7tVZSaQ5aLU5S0jZJOn+QAHWz6vgwsRrrqw5N9ate0LNUc1eYozCztnjREJ8ciFgRPRHjZt67pDUts7g0tsnx2wMzhogSzvxzKXBLFyTz2cT/756S0v5sfwvUouT+1d3JWHNfqKZ+p8lKt65TtjdL2wY/yKZ0wvNQ/eVMcPHsYjMPF8Mccn4qRogaHTZ0C+i8e0BXtFcOC+dB/jCyn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:39:00.2330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3102bb9-d1b7-4e1b-69b2-08dee3505b78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

CPPC registers that OSPM programs at runtime, via sysfs (auto_sel,
energy_performance_preference, auto_act_window) or via the autonomous
mode boot parameter, can be silently lost across CPU hotplug or left
behind on driver unload:

 - Across CPU hotplug: the cpufreq core tears the policy down and the
   platform may reset the registers while the CPU is offline.
 - On driver unload: the value the driver wrote is left in the register
   instead of returning to its pre-driver state.

This series makes cppc_cpufreq keep these values consistent:

 - Patch 1: adds online()/offline() callbacks so core keeps the policy
   alive across CPU hotplug instead of tearing it down and rebuilding it.
 - Patch 2: adds u64 wrappers for the autonomous selection register.
 - Patch 3: adds a table-driven mechanism that captures each register's
   firmware value, restores it when the policy goes down, and reapplies
   the OSPM-set value when the policy comes back online.

v[1] -> v2:
 - New patch 1: keep policy across hotplug by adding online()/offline().
 - New patch 2: move the auto_sel u64 wrappers into cppc_acpi.c.
 - Restore fw values from offline(), which covers both hotplug and unload
 - Drop cppc_cache_perf_ctrls() and read reg values at offline() instead
   of caching them.
 - Add auto_act_window and defer OSPM Nominal Perf to a later series.

Sumit Gupta (3):
  cpufreq: CPPC: Keep the policy across CPU hotplug
  ACPI: CPPC: Add u64 wrappers for the autonomous selection register
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload

 drivers/acpi/cppc_acpi.c       |  40 +++++++++
 drivers/cpufreq/cppc_cpufreq.c | 156 +++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  10 +++
 3 files changed, 206 insertions(+)

[1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/

-- 
2.34.1

