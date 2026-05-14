Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61403D0914;
	Thu, 14 May 2026 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795815; cv=fail; b=GrY45Qqs5kW/t4UNSFfpmm2Z4Ak00wE/zZ32qi3zmMTmptBnZTSP6FbnGuH2IVowPnFkW5h+Pp2vXurNM/ur0j4+tv20qkjJGFGvOFpLnjj/1+m4IACrt8elJDjVDR7c6sgr9kgn9pPCmQR+JDb6MabMqC77hoOZqI0CNkUz9I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795815; c=relaxed/simple;
	bh=PuRoDAdx5hzeDVK+2QbajURDfEmf877XItdsAZt9wns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/QQl4VUq3SlhEIoooFgRaedqOPRpgaMyYvccYKvWTBUtJhqz/8SPxuuAV4srJhrssl/3TAIF2NmJC74epKofw23Z0qWIv+3gxhEbDFa31NrLHWH2R30nMXoFbf2OA/irA/pzMtmXMkKOedVgI4ulO8aPY5Ky/pe9I9vGgryQSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lAA6ymh0; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lAA6ymh0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUDKFnpYDIo7/vCulK7YTfLrpjsQh0BfmsTFCCb2saum8nHmnQ/k4i/uIRFuwLjVPbImjn6LMv/4kNSvmSrxk8ZbDe2lb8KtSX+IJhmOQe46IX1deDp/pY88+/NjE05cv0DAXEBR3rNvqYKig6tNqttJnaLKqVhQfIdNUs2FcyTbpRgyl4tH7mZeaPCGyknEbyj+7Eo78IiB6Te64PmthX92Z68XqLK4sU1aSaKa7YRygCNGP2J0/1UcyfrfHco9U0ayzQtNgHpqgY8H0Qu/uQ54e5e/TewpAGywV4O27xCdQGeVbP8ZOWaqed8HiOBfXFjLHO/4iKSlP2LpTqNZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88sh/qqzfjFL3I7/v2js9czdWWG3HbqriL4dgXJNNrk=;
 b=nZvu0avFnXH8xcuWy/bpu6YBTv3qLQfYj85nw3wCDb8FIOzKp3TvvVatHU5/QgSJrZY5U/7a8y71JBKUPM+iEwXb07VYX6UlmRBov0i1z7YMdgUNM3pix7AoCcOupgak5kutRKebyHrUFBS90LVC7nyZqUu6txGICSL8pZRPzbrBkBzzsdnQd0g9NAqq29xJElsM9eQcJgUf3H6uyw++kAh0x47uQCGhbfX5LZTBr0GNYM/HkCNPDYNX1Q75rmukP1ptvoKVfORVRZUcTDchUbNRcW8049fY+q3swsy/KWBPmYxdgX66xcDG9duw4Ni8F1Ont5wHaC1jJ70KnaoXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88sh/qqzfjFL3I7/v2js9czdWWG3HbqriL4dgXJNNrk=;
 b=lAA6ymh0KNU3iawGhldAk4B3SMNxZIjG+v8Iwy8dqsWS7LnxtXh4y9Y0hflQzqcyO+XXzfaUOatppy9HSpeOizOkmV1SPg6GJC8MrC5a0MwXdS8mFkW5DCMKGg1fTo92LCkwavXlhamg/1N2AGv/llKOP4wwicCnw+5WogGrEMU=
Received: from SJ0PR03CA0206.namprd03.prod.outlook.com (2603:10b6:a03:2ef::31)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 21:56:49 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::b7) by SJ0PR03CA0206.outlook.office365.com
 (2603:10b6:a03:2ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 21:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 21:56:48 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 16:56:47 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 0/4] Add CPPC HighestFreq support
Date: Thu, 14 May 2026 16:56:22 -0500
Message-ID: <20260514215626.35327-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bf4e38-a42d-4cad-628d-08deb203b2d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|13003099007|11063799003;
X-Microsoft-Antispam-Message-Info:
	MFbruAVTGD40MEwAGbQM34qdIEJvHofhYkCiKiOtZRMn2xSH7lWwiYzDDL1upmPAw3U7OXzKk9CvpNLI94LYY4c6bFqOlYFFUO1h9mTZTzu72j/lTFDt25lnkWvlXNZG0L279d1xrsRnsz6epIYyKZBZQQmAYec7jafHTM31EBZ7yHnp8/ElHq/CtdLCE/L3Pg/YoNEG5YCCaJKHweJfEEr1DctvSueHZUFnL4a9IviLsQuSsIGnyLbAEkcLWOd/fpHBlgrcgQfeaoymGCtxOTaY1xWgf0dQfBrtSeJW7/9LsGCznf5tBPpitpq1D1108xaAQpOXF93VFuo9YQKovDVU9LoOMiSd47K03xMbdCx3BOdohu+ej6E6/c4j6Yy6c3oYN/UVHZVyWE3OMLBYciTjaKOgJvKh/sK11zEq312cMivTsCcyZ+a92fi3Dtoc043zEalU9Dskd1hMRM1DPXzcA4/DeMRidao6JJ0JfPIR8tVNvlqNNSBCG7lqnRWVsYge2NplfoEMGNo6o+kUAxrZ+obKreDBSuIToMBWufiii44W7h2YQ8yU0DxmzkVzyo5AQ+Ej69RW6s4oUlAlTnXbDjygszahi4FwWrvLlq6wJl3firQkcl+2HfEjQYGhWMuYdNfI/cKnCFeFjsJFfLC/UM0RZCIIu8ynENARq0mdyoisXY6ZiY0DCkhY12xo98S5mDQTBgdYoZiYt7eY1sxi1IasV3RqEtZC7lyIYi8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(13003099007)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jnkkmCoed7LU6mDTgwODyUxREOvyC9dZNGiRjKG4cyrO/HuY0ToLEPDJHjjQ9kpX/N3pARIXZQI/Vwvm3+NfixI7hsOblmxUhu/SlD09ZIxsIaeNb91X2t19FTk0gsZ6sjt4YkJr2CEfXMcktXCgbKjBpVaqx2tGUfaNc2xzcRdcSIfO/DJovPR8qSO1ALXyusp+AiQ3JdEKD8C4KKTsiJZk18zKUofmXDcUwfKllne7qdl+xeswDUD3CF/NesxEIyberxOLDjOITuFC4KL2sHqnFNAoFEIJNv8tmU9UGG+GWxO0EOtZ9SOVzt9vVtlSnHhHE1r0x4Ww2tTt/SjkjmkIVq0o9HC0PbmIalCPiGENtdi2JFqmf37Og3+IQcZmEEkyR+pJLa57XL5zHsGnQoDcoWwZCKmaY3cCkm31AeSjvyv20dIHLhmPa2MmGmYn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 21:56:48.7363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bf4e38-a42d-4cad-628d-08deb203b2d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050

On some systems, the boost ratio cannot be accurately calculated
using linear interpolation of CPPC performance values because the
performance-to-frequency mapping is not linear across all cores.

This series introduces support for the CPPC HighestFreq register.  This
register is under a proposal with ASWG at the moment and trending for
inclusion in ACPI 6.7.

This optionally provides the actual highest frequency eliminating
the need for interpolation. When available, this frequency value is used
for more accurate CPU capacity calculations and boost ratio determination.

This series adds support for the ACPI 6.7 proposal. It require's Sumit's
CPPC v4 patches.

---
v3:
 * Rebase on Sumit's CPPCv4 v3 submission [1]
 * Drop "Revert "ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"
   as this was merged through the PM tree already in 7.1-rc3.
 * Add tags for Prateek.
v2:
 * Drop CPPC v4 patches, these are submitted separately by Sumit Gupta [2]

Link: https://lore.kernel.org/linux-pm/20260514194822.1841748-1-sumitg@nvidia.com/ [1]
Link: https://lore.kernel.org/linux-pm/20260430142430.755437-1-sumitg@nvidia.com/ [2]

Mario Limonciello (4):
  ACPI: CPPC: Add support for reading HighestFreq
  ACPI: CPPC: Refactor boost ratio handling
  cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
  cpufreq/amd-pstate: Get highest freq from CPPC if available

 arch/x86/kernel/acpi/cppc.c    | 122 ++++++++++++++++++---------------
 drivers/acpi/cppc_acpi.c       |  31 ++++++---
 drivers/cpufreq/acpi-cpufreq.c |  17 +++--
 drivers/cpufreq/amd-pstate.c   |  18 +++--
 include/acpi/cppc_acpi.h       |  16 ++++-
 5 files changed, 123 insertions(+), 81 deletions(-)

-- 
2.54.0

