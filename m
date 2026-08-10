Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73A3BAD80;
	Mon, 10 Aug 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356677; cv=fail; b=mp3TV9qpP7JehQQ+hBbjB1Za4aa2dbU4W0+hjNxk9dJCB1xdR7ap/lGbuxcoaQ6CaUhc8LmKxPU+Y9Qpp5aHgqDG/6BEFEBlj+z9Ifr71qAsdENmPJpr8iGQyMlNSWlnrxTrZzI4fHr2rrT7ddNa3ip41OAkCyhZQup/29bQORE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356677; c=relaxed/simple;
	bh=XVcWAnQryTnYFKuQXBveX82Z6vPuaIFg5eQUjIrAB/Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7C3WiuSqKOl1xisqGpTjeLtXP2wQLgu+2LoR1pDhVF6M7zRzAex9L6pzeQI8H9/CCWc7GvAPEtl4epuNn3lWcEHtlUVHYiyLgVRqdJivSHU08Er1j887k0PXaWIE7SNFbVmRUPw/uogbFSe9HJF6yIf0V0yrIxYJOrn44uelVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pqvkVVjf; arc=fail smtp.client-ip=52.101.53.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pqvkVVjf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHRcfWwOt7qqXRWaQv9jtEyaQNxlQCge+/VlCf0X6/PWSP+nqekGPTsdFV1e/UmR0CZGet6r80N68Fo4qv/eI8RrB3w6IWmpfUnVUqEMji4RyYzLNtPSGuvJjeFkaTMvs60zjoQvwrDLxls8I9O81qxprks6MXFF9+O8Ko97NWAbZx30IkraDGpdjFMojsYyAJu/NI9+OxueE1z0NUamF7Bu462/DP9DJpEfcfTb6vQc5ouh9jZHxxtvq04tu5jwXPeVgACFnA4cF3ePPPsPVQO/OQbjuYjbPSb7e3J+H0ADvd6Czik1xvdODMo6ok9+qDDqlkf8Klv+0zXKboECjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DjqyBNzxA1ViQxJSWQYyUd1ijn6N1GL89MwWMG1XPg=;
 b=KluXb0hB3N2shsnIwV1hKug3L/q7zAC3CSvChsd2N6oPNdD45hXXuQ0GiovvEa6vSDuPnwWmMtkP1uQGJeRdj3oQQH8xDL0JWsZM9n7BMubTuK6qMYnYeQh19337ifuFC5gVRJv9+ne8iOInDA1ZcaZoT6h1VEi5ESOSafFuxFO7M+73OmC+VtD56SRG8ouiKWOpU1V6i5NpnjT/oXJYnlLPnYxVWxLKC5UHLrVpPDkx8YGbG49AShTnf8twspSOhqMfB007vPeBQ/ITSsCnwPlyXzocd1MHabU8T0rVd8BesLDhFApi1qATVGMmDmRuVsDGYsBgPPSwMG1R8Ewqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DjqyBNzxA1ViQxJSWQYyUd1ijn6N1GL89MwWMG1XPg=;
 b=pqvkVVjfI/+Gm2m32mEU64xxQdvP2At2esJxosYLg2rOkmAab0wBIMjacnJ8EZYmJ8jacbErwAiF9368dSTLpEykqS3iHvrFMyfqFTRMxDe3asS4qgIVdLU41bm/N74MZRPtsFt4DzskJUuva/HprezOQg30SoV0o2DJab/D8jc=
Received: from MW4PR03CA0350.namprd03.prod.outlook.com (2603:10b6:303:dc::25)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:11:11 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::1) by MW4PR03CA0350.outlook.office365.com
 (2603:10b6:303:dc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 10:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 10:11:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:10:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 05:04:56 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 10 Aug 2026 05:04:53 -0500
From: Golla Nagendra <nagendra.golla@amd.com>
To: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <michal.simek@amd.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<rafael@kernel.org>
CC: <git@amd.com>, <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <nagendra.golla@amd.com>
Subject: [PATCH V3 0/6] dmaengine: zynqmp_dma: Per-channel reset, IRQ guard improvements, and PM fixes 
Date: Mon, 10 Aug 2026 15:34:46 +0530
Message-ID: <20260810100452.426320-1-nagendra.golla@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 826d9bb0-0d5f-436a-603d-08def6c7b3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	9LDRnEHOKCjB6PyaJI5WeAA5vj5nRdjY+TVOzHZz/NRwA6MAWKFEZAK2X18+a3l6jRTlcC4Hor+v+OFY4uh4me9iFLNAi+OkOYmyFGWTlUZDi1Gzyc81+g5KsO/866CObU2y/2puemtCH2LKSoQHnIGQ3ER8ywZCHhmjK1iCUGvZS24OBJMgm/lg+AYxhPPuzkfskXjz/mh3Kbne7JfMXpaWzy8SQDe7YpiA3yIKkzX7cJUhH4o+fXQc1Xt09iGeM7+wkHWMq6i+s4OzW+RBjRQpSCOc4EwbdjQ3JOAmrHSy6L15rRuq2qamIsyqPtYYp2UNlc+JVKNdsmMlC3tFoOmJLgpCuWvOHVd1cyIJ+MBznMEYry4X1BQPKXSKWG0mmS/wZfXACwtpw3pdTW5kmzVCxNemhLogz0TOkQsdThXayBV3jDY/R9rQi1s2T3bO6wiyft+XCxhT0M1Xqmjq03WtfprWJHDNi1xHZGt50iqv/xHBB8gwK30rQJ0+FFyj8JcvQtje10Vog7USiANaQZjyXVHruDlIe+xtSHx+/xgjcuphz+20zwK1/2Cow8zaYB5ES6Tv+GihqWoqsyvE/xmoOwq7oOTetIwSI1NyMIwCUq6oFISgmfUz8y1DwiNhTJkJLxY0Q11ac5XeCzR14EzDA+2Q32h2HmFMtckC7VBHdv+j9rtIxtqeLaInnDASg3boBn2Giu+V8F4SHZkj1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6teNXUQ8lR7xdCvFmrRNhmNelshGYOR6oYDv949jrF113iVNtPVFuFWBZm0qUfK1mSUSku0YwzlTqxLvU0gxxNGMAaLcCcaSKJnz904fNg49HxwHFsSnyOljr7/7VsWWxSgpwYPidCSgAmJEGKGUxa5zL90gUwkQ3YB/m93Ku1SYU2XtGXUpizh3PNBWBxF/8fgb5dha6DbN9+Ff0odgg4fnk17A9IPt+ubk8jvxUN/H4MZ+TiuDAyA7BHvB8li4AkQEysf+5VIbn/CjybDkc8axnektp05VILgwjSPj70HtdhUkYqs0nlNRpl92NbfDUoezuYnh/e1LJmdQ00bXf7H1Ig95kxENYSwgVYFGpa3BAQhFrP8FQmsJMuTi1cmoC0cRH3Rw6d4Po1BaYVmqOHGvHM52HRI27OfmCn7YTE79e+e3GmDpqTSFYafs8d7S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:11:10.9493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 826d9bb0-0d5f-436a-603d-08def6c7b3ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

This series extends the ZynqMP DMA driver with per-channel reset support
for Versal Gen2 and Versal Net, improves the runtime PM guard in the IRQ
handler, and fixes a PM usage count leak in the probe error path.

Patch 1 fixes a PM usage count leak in the probe error path where
pm_runtime_resume_and_get() succeeds but a later step (e.g., channel
probe) fails, leaving the usage count incremented and clocks enabled.

Patch 2 adds a PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard macro to pm_runtime.h
so drivers can conditionally acquire a runtime PM reference only when the
device is already active, with automatic release on scope exit.

Patch 3 uses PM_RUNTIME_ACQUIRE_IF_ACTIVE() in zynqmp_dma_irq_handler()
to safely guard against spurious interrupts arriving while the device is
runtime-suspended. When runtime PM is disabled (probe fallback path) the
handler falls through to normal processing unchanged.

Patch 4 updates the dt-binding to add the amd,versal-net-dma-1.0
compatible string and restricts the resets property per-compatible using
allOf:if:then:, making it required for Versal Gen2 and Versal Net and
explicitly absent for all other platforms.

Patch 5 adds the amd,versal-net-dma-1.0 entry to the driver match table
with a dedicated versal_net_dma_config carrying has_reset=true.

Patch 6 adds reset control handling in the channel probe path, using the
has_reset field in zynqmp_dma_config to conditionally call device_reset()
on Versal Gen2 and Versal Net channels.

Changes in V3:
- Patch 1: New patch - split PM usage count fix into a separate patch as
- Patch 2: New patch - add PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard and its
  backing infrastructure to pm_runtime.h 
- Patch 3: Use PM_RUNTIME_ACQUIRE_IF_ACTIVE() guard instead of the manual
  pm_runtime_get_if_active()/pm_runtime_put() pair from V2
- Patch 4: Use allOf:if:then: to restrict the resets property per-
  compatible with resets: false for non-matching platforms 
  also expand to include amd,versal-net-dma-1.0
- Patch 5: New patch - add amd,versal-net-dma-1.0 compatible to driver
- Patch 6: Introduce has_reset flag in zynqmp_dma_config to gate the
  reset path; PM usage count fix split into patch 1/6

Golla Nagendra (5):
  dmaengine: zynqmp_dma: Fix PM usage count handling in probe error path
  PM: runtime: Add pm_runtime_if_active guard and conditional variant
  dmaengine: zynqmp_dma: Guard IRQ handler against spurious interrupts
  dmaengine: zynqmp_dma: Add new compatible string for Versal Net
  dmaengine: zynqmp_dma: Add per-channel reset support

Jay Buddhabhatti (1):
  dt-bindings: dma: xlnx,zynqmp-dma: Add Versal Net compatible support

 .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       | 25 ++++++++++++++++---
 drivers/dma/xilinx/zynqmp_dma.c               | 25 ++++++++++++++++++-
 include/linux/pm_runtime.h                    | 12 +++++++++
 3 files changed, 58 insertions(+), 4 deletions(-)

-- 
2.43.7

