Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCE44A404;
	Thu,  6 Aug 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786046980; cv=fail; b=syL98MQqigJadUNq2m7tT1zZDqcLzXbzPL+pX1VW/u072WLLi6mf+Nbv2ups/iTWFj4Om+pRZCd7PgE0UybbRVFfMKX4h6aVIfmUWnpz1sTBVsPg9nvzKLfCcf0WB//IQwRF8RxUNqa//iIGKA6rQYrc0081fdvy/z0MEVrHoTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786046980; c=relaxed/simple;
	bh=iKHi2bOlifKAHyMmt9hV8OdYcNTtlXNL0+cnQB5WxyE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvprLc2pMFtjuHMYUR8ohGzKVX1tEff5xZwBFfcAGMyCuXEcJ55nG7WfWjB1+SQN0g3FQZkHNaDIjqSf7i36URb+qINMJYtuCBLlcphuaUjom9qNAtp2vyvLZKoLsOEhfCp0WfDpbqIjhAHuq7Ev4IVYgytDyMtef8/j63gkT00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IyBOCeyd; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IyBOCeyd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFB/lQuvJ/7MeUmZUbafJktXMRl9ABnUMNtk6l86gjPYJVGBq/iXkrLS6JF+ei7L6/71C7O/x+liSg3ZyWsBO/KC0CvyRVbjyVR7Dj3Lqwr71ncVXyMuKMNDl3nzmsbTieLxzpU0Wy+WGN8bTKe7qxXkegPngAUasOtYYEtEKQJhJKfoZL7PflWukEbQpkShmTy+K4Hmd0UKhfQpfjP5ef9iBpI+C71KR+yx8CJsqstDMX8goNVbFxgdtk9IN8vQo+xg54M5th5qtaLrPr/y7ZM8XXv6COqTfHoriXdl4+qamAp2UESLG1++YFcCeYMY00RkbwVMvM3pWwqccc0n2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ziuOsuJmsayPCZY6XNuMMx7wMPhUF3rlHqTFLY84HY=;
 b=BwtJ6lRVJ/KDp63l9GmI2TcnyYT1pOIrcsb7cvbudMbizT8+0ZuVuJpR11kJUnVjGfeKTCwMG9F8Fg5P79q3Jiap26lk8pTuOOKg8Dp/dYWDFiRE+HWqhGYLNUHvWj8Un77RSfCU8uI4SaAomu4y4t144/Bgozvcfgdwwv1tladUPcAq7F32ivCyHq93X+vpuhTeFaxzhTFER1yyxg2k7loPsG7rn4pMRsLHaczSTAIz66LdVSR4gQBU5GvIuMuUM7eGuocQE2UQ9a/nJVHVIJ/jmGpVwIFwGnialVjA4TUvE3eXR3VJvR29bdvrWv096ELubIxNhmOg0c8MeGstjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ziuOsuJmsayPCZY6XNuMMx7wMPhUF3rlHqTFLY84HY=;
 b=IyBOCeyddZ0WZ9b8bBWQvkWmmby+bigIf6E3MGL7CHzxv9mnwKG2pZ8CqZqyTGSLqOQH+lDoVUsjvFn4F/FN2Ihc3+Q1BhCgPmqjl2gY6RrzgropwYnbJrPl+phEd0cRjShoRUfz9raOTPpyIQXY7ZTCSnKvceYALmkR0G/LTy0G0leGokkx9h+vNF4zbDE21MkZnIWt8vFOuKzcAkQ5fXECJT9IuhW12vHgUep/NVXsXbKuH+CMJXqzp3A8S4AvmJdX3jRjhgr082j2M/alwYtQqprJ7z0xVhePLPQJEw2GYWEiouqxfcGjqN9CKGzJsXhiqa+479OIdaVm8zwOFA==
Received: from PH7P221CA0036.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::6)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 20:09:31 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:33c:cafe::43) by PH7P221CA0036.outlook.office365.com
 (2603:10b6:510:33c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 20:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 20:09:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 6 Aug
 2026 13:09:09 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Aug
 2026 13:09:08 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Aug 2026 13:09:02 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.com>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v4 0/4] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Fri, 7 Aug 2026 01:38:53 +0530
Message-ID: <20260806200857.601152-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 889fc566-07b3-4dd4-dc16-08def3f6a023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|23010399003|36860700016|13003099007|921020|6133799003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QlAUMX0mfY5bAi9PVFpm+eM6fVgBcBkY/mG/ygFRn5dgnNUSc9G5FKhyvkKkEWjMk19VQDmFbfJgpgV5O3KcivJg+kn8BGaLCSDQl9GUqLmwvBEW0M5NKgh93T1HfPE2l6Thewe5dIAa86nQ2WvUYwSJTFw14VTz7TWi/Xng6Lo9J59a8ecYjqYo6xaAPwiouBkvTYxGvcIDEwYWmvgTjYYvmynddYnDpRhZ5ZoFX9ZQA7hUDbaQ+yaTGPO5jwCJkave48UahziwaFimuuBMzF2UoBoAanvdIGo0E6QDD8r0X+0JlHqrWSspZwGo7TgRrua6dZOd0YYJjXRy0Cx9lRt0Y3UY36zOTih1bf8TdpJWJTgcjiA1/g7zboyIRRd4b/CSj3cB74B0FrhaN7nHc3Ib7SwCZhLn6VxPg6qniI2YrKkAwFii2oW8JLV2SdRa8fiXPJbYT03oQOBHP1r/kU27+UHDwuT553hdfqNRm4yHpuDxlO+ZxaO2Qu114jS4xU4jgGe5H4j020qBoBN80Cmj8H+n+X9UqCiHvAvrLbI2N9LboSKF9+MObK6bGo9YPSHZ3lPolO/TA37fQOtxnUdVnmlQ/FeJinr0liXQA6KBAQOqNeNDruwONZcNt8Az2/i/GhJAmCMUGfXnVC0RCuuvyHEA53NXYQpv8NaWcFEQ5Gx4CzwP5QC5LXkS9IKjCP00znxHIwhObft/xHEyJjo0E3dLHrsEKOQDwNa+nu2I8Ij3YZVwes1TgkQbbu3d
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(23010399003)(36860700016)(13003099007)(921020)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qf+ZN9jhEOIrJrKNnlDnCExuZBzT+zlbbTqQIzct8sNSWYPLCSCTsFOwsmKHzRUL/xnCJdKMgizrU52OvWncQmoZMuFD9kJNqoMV2CLMuwc5nlEIRAEliZd6y6sVOgR+s7ePT+5qV5YfCb7Ug2NTelFzTavmZ96IDmH/QrqriXrJ1jHKLd/+F2c/OJnEV1Vr5VMjGDXUc5/QYlBe3pt34l8RZqvrKYAjD2H9CrpWPJyZfvNoDif+cuZ/0O22qVRQHsapIPAdXKsmDFH5QMwx3XUGCDiRB4IEOlVnMx/esbG27RItECogpC7UtrBP+XoC4yEbcEw+wCXqGQxQ0HMJDngDT9UEOkYDcBU5iAd40zIaVoVYOwBIcH1OqJ+WJM77el41iupiGbmr6YbpWMHQ6PC2NrI6Tsw/Em91He24SeFKu6UVgFpyRm4/BrbHIeFh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 20:09:30.5997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889fc566-07b3-4dd4-dc16-08def3f6a023
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282

This series keeps the CPPC cpufreq policy alive across CPU hotplug and
preserves the OSPM-set CPPC registers (Energy Performance Preference,
Autonomous Activity Window, Autonomous Selection - set via sysfs).

Without online()/offline() callbacks, the core tears a policy down when
its last CPU goes offline and rebuilds it on the way back, re-reading the
CPPC capabilities each time. The values written to these registers can
be lost:

 - Across CPU hotplug or suspend/resume: the platform may reset them
   while the CPU is offline.
 - On driver unload: the driver-written value is left in the register
   instead of returning to its pre-driver state.

Handle these with:

 - Patch 1: adds online()/offline() callbacks so the core keeps policy
   alive across CPU hotplug instead of tearing it down and rebuilding it.
 - Patch 2: makes the autonomous selection register helpers take a u64.
 - Patch 3: adds a table-driven mechanism that captures each register's
   firmware value at init(), restores it from offline(), and reapplies
   the OSPM-set value from online().
 - Patch 4: extends the same save/restore to system suspend/resume.

v3[3] -> v4:
 - Patch 1:
   - offline() parks the perf request at lowest_perf, as exit() did.
   - online() resyncs the frequency invariance counters.
   - raise MAX before the perf restore when the saved MIN is above it.
 - Patch 3:
   - write auto_sel first when enabling it and last when disabling it.
   - replace the four save/restore helpers into save_regs() and
     apply_saved_regs(), each taking the firmware or requested type.
   - keep the per-policy saved values in one struct, and name each
     register for the pr_debug diagnostics.
 - Patch 4:
   - suspend() also restores the firmware values and flags it, so
     offline() skips them and resume() only handles still-online policies.

Sumit Gupta (4):
  cpufreq: CPPC: Keep the policy across CPU hotplug
  ACPI: CPPC: Make autonomous selection helpers take a u64
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume

 drivers/acpi/cppc_acpi.c       |  20 +-
 drivers/cpufreq/amd-pstate.c   |   2 +-
 drivers/cpufreq/cppc_cpufreq.c | 369 ++++++++++++++++++++++++++++++++-
 include/acpi/cppc_acpi.h       |   8 +-
 4 files changed, 376 insertions(+), 23 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
[3] v3: https://lore.kernel.org/lkml/20260724215937.3368276-1-sumitg@nvidia.com/

-- 
2.34.1

