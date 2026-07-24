Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2E3EDABA;
	Fri, 24 Jul 2026 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930412; cv=fail; b=G1dx9a9FBRf/ePNJLbgMftl9fq4gkJ6SJyGfQmZAODZKmF+B1bZ9H9zj7T1KsNPpe1AjU5NK1gSLTwdDNzxWcdZca9nItzx8gd88QnX7qoHIcWW/7w+iC7d/3cVLrvDXDsUul0Fdqr4P4nlfuRYsx85vS4pfJAzHkFLG2iUlPmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930412; c=relaxed/simple;
	bh=8rh0ko5IMZcp06SSR4+X+byTOUHg/VrFiO0QuJ35qng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rp7YTjWfyiF/jm1Yl38B1YSsmDcwKBqqWU7G7jZqT5sCBFW5quOMGGXNRpuKd10RFkbvkMwRD1+LehXGG0UZNRv0bk+J/y0WeFwOLovnZRSwKESp3euLARyIqS3T/Ygj4sd08POIQyK/AaNeRWyjV3SeAczqSa12kpReQOMbbJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LQCIDMkB; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LQCIDMkB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGAFUNRQGtPfhjZTPGgJzG+EdaR79XFKkQGI38jbxeP0Rq+ZtXC7be8mN/GufGH22P0AzYPi4MynDBSj+WH0HqY5YFWQFbmS2IzjdaNtjtRbJNBlRqucmtRoLwQAx7jNunR2wAH1884Owl8R0HXwd9hCUGMPt68l2ghUjo3KOVG8FqjNfyWrKEQZ7dPXoFhTVv0nTU5SzKVc+mVYt77q3rzd4WwatvlYj8gQ7AE5HPwL0LsFpHOm4noIsRUxKwyvkisqqEC2FJHByZscLR3yW5gmF2o6CZyomI1rIh7nGH5cZbdMTMNz/M2CAYMr4QLY1fQbF+s3YChKw+MLoasmZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Th8olKAAh4WujN4mPDuSng0+K86P/YQ6M2cI2jR/eIs=;
 b=AgoreK6+F9AgSMuXqdfHAeiu5ozbe7U0ZgdH51SWnZrm3oNkK6Sz4zEd5x5Q9KerXQczDwht5DG19tpv518hD5ml9SodMsMXmmVgTM7kwbvoKz0d3OWenb9j/zStjiAQbaKExmi0J1Cw8KqtgP+5TX53Eunpp8pKY/uGVvVQaQ22JMWueQmO6xm5nGcmqIsc4H6Vm9M+oqhKXNIAkB/7w5E86d0vqJvNlfxQpxArF2OhklnooBQed39yd8OD++6aRTKLY87qUBo15d6mIkB4sFW1XSn2lcNCfnUCib9sIZGIrWsKmjd1dqRZqyils+5ALr4aMRp+pxd8KOh6bLQY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Th8olKAAh4WujN4mPDuSng0+K86P/YQ6M2cI2jR/eIs=;
 b=LQCIDMkBBRTUZ3kx5TUQk0MtJ677P8b9xj942ghspzKYLYIVD2v4sEF9mwczPr1By+pifHlwhVSLVEMYtsumd8V8UdWN2IGsqswVDtYIcUQ1ZDAr5iwYb2Tu3EF1l8/+JwVihtsqtxn/tqBmUgrKI0vZ51bntb3ZRF7ruDpxOzTSSXTpkPRZq+AxGtTEYuDmOVxBZi9zgTQRI2KGCMkpt+nHFivY1eELxk/Z3XNRHlm1rmu4K6GrTr65cuZSlQMAP94XuNjspWRNeczMz4itYJ467TJbw9C36BTNYevOrq+Rbuq7bBcQIXy1BLE3pPGHKBvolwlEK72r/k1CzHqsiw==
Received: from SJ0PR03CA0061.namprd03.prod.outlook.com (2603:10b6:a03:331::6)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 21:59:59 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::5c) by SJ0PR03CA0061.outlook.office365.com
 (2603:10b6:a03:331::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 21:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 21:59:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 24 Jul
 2026 14:59:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 14:59:45 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 14:59:39 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 0/4] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Sat, 25 Jul 2026 03:29:33 +0530
Message-ID: <20260724215937.3368276-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ede28ef-760d-42f3-89be-08dee9cee74d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|13003099007|921020|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	yi/ISrAnMF462teD0IGdOk4g0ruG07Q6PniMjpPeb3s6mOz/7682Vr0lzqeOrUpODPcZGroFvYbfKOmLvPvaugeB1uKvDT349+Vh/GLZEKDId0j8q07UYhmjzlCMJVjrQCLf6MgJdNJQr/R8nl14Fvl9hxcqOoAxPFT79dia3d3OjI9TEtGEaeH3BsJpHkF1NHHyjdUkIsothZ5oWTv+3Fb2h0yzJroFfc/YlFXMz5vo+N5FMzXaSH7yI8NaK6bodEErkINwMRCxlIV87mGVYKV/RX/3enPFZzLn8/FwE5dbJ0Iq7FrtuoS0EcjWSreStXgRHtNeLL461k7v1SKVYSzaTSxMVTrcR5rWJFcD8RyMci6uDynhyMm/2YI5drYL/+nW0zPkXdM3VNpZJ1O/bkqpkXuCOzbXI4ditSeqqyQEmU/Wb/WriVrPKm11292Mb3UHaSaSh5NzYBTVPNnU4z49k5L+sKZqfjlcsrwSplOclmsupu/Cbg5a14jIF2xXoDAyqb3ld3aiytW3ZHzuf4reOjpZHk/p3kdmn2Xnl9tSyAgHwRo0eAOGfPV3oxE+PXLPcA39a55RD38c4FCumrMw5ZzqXvpp2v/MM71HXI6RvKiLwKlSESPPgQ9bP0cKqUK4OTS0ey71s+/KRgTwRzI97/DrGh1yp9Mp8tAeiJIVVox7AEHaoWkLgAJLrNYZc5asABbJ/ZyQSOWmNIUzJV3I6GhfJSfW44TE/TvjCdO7zxsbLdnQo54P19cLWE4C
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(13003099007)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C4x7NFgS4H7gYF6IYuNEZiEpxbchZJq34GZ4TwdTtt0zNKmSBawagOS3Xk7/TihWme08dZxl9DnCgIeiotpcCKns/nHV5s6y44V/2xLXH+kHh8IziIxGDNwjjIQ1C+aSNZGYM0S/98pziayy3Ad6ceDAZeTyZSK0qzG0t5CwVeQF0nBpTWO+llEZ4iYHTgkgEN9ixAO/mk14pdSKA6bu9IESA7tJlU5ioZkHcSjIH+lB9779zzptKjuJTAHydKlrQgVRKohOP9nAAUkpC8TGQYZux0F0EzJrRzU2R6kNv0ugv04eq0AqfXVFQTd/4MWvVXdUcNpRw2+HecudOB118TvFG3IsuIyFMBZrdxH3ymTgXJMG7zsKT6sFEY6Kb2IJCtqQlgRt6YtfuFumg8sLEZmieTTnCjRjiADXFZclgscWed8/nkVsJ1IL2COhk7G6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:59:58.5388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ede28ef-760d-42f3-89be-08dee9cee74d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339

This series keeps the CPPC cpufreq policy alive across CPU hotplug and
preserves the OSPM-set CPPC registers (Energy Performance Preference,
Autonomous Activity Window, Autonomous Selection) set via sysfs or the
autonomous boot parameter.

Without online()/offline() callbacks, the core tears a policy down when
its last CPU goes offline and rebuilds it on the way back, re-reading the
CPPC capabilities each time. The values written to these registers can
be lost:

 - Across CPU hotplug or suspend/resume: the platform may reset them
   while the CPU is offline.
 - On driver unload: the driver-written value is left in the register
   instead of returning to its pre-driver state.

Handle these with:
 - Patch 1: adds online()/offline() callbacks so the core keeps the policy
   alive across CPU hotplug instead of tearing it down and rebuilding it.
 - Patch 2: makes the autonomous selection register helpers take a u64.
 - Patch 3: adds a table-driven mechanism that captures each register's
   firmware value, restores it when the policy goes down, and reapplies
   the OSPM-set value when the policy comes back online.
 - Patch 4: extends the same save/restore to system suspend/resume.

v2[2] -> v3:
 - Patch 1: online() now re-establishes the desired/min/max tuple.
 - Patch 2: make cppc_get/set_auto_sel() take a u64 arg.
 - Patch 3: skip restoring/reapplying a reg whose value couldn't be read.
 - Patch 3: split save_req_and_restore_firmware_regs() so patch 4 can
   reuse save_requested_regs() for save-only suspend.
 - New patch 4: preserve the OSPM-set registers across suspend/resume.

Sumit Gupta (4):
  cpufreq: CPPC: Keep the policy across CPU hotplug
  ACPI: CPPC: Make autonomous selection helpers take a u64
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume

 drivers/acpi/cppc_acpi.c       |  20 +--
 drivers/cpufreq/amd-pstate.c   |   2 +-
 drivers/cpufreq/cppc_cpufreq.c | 223 ++++++++++++++++++++++++++++++++-
 include/acpi/cppc_acpi.h       |   8 +-
 4 files changed, 230 insertions(+), 23 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/

-- 
2.34.1

