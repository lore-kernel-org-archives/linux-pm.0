Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB178391512;
	Mon,  4 May 2026 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935724; cv=fail; b=kkrOTSIf6WQZHRI6Mz2pwkRgC3pp6IGWvzL8VAz356m8cHQ8AUgLZs1juiX+e5SeA0VK5zkvRuh5wxIYsCKl1GUhU7GYGrOnvXohgPEk65RmnK2/uw7BhxrberzzKYw32LsEhSdlHFzeE4fvvPzyW7BcZbhZLR2mt7+bInAideA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935724; c=relaxed/simple;
	bh=pMtDMuohgq1JRnyR5cTOrOaP3FJ5hOFIH9lkDIQVFvQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O/vvs8e6PZKoK0vt0u1xFT/pAd0jaiI0DyiChenbL3FhaFlLpTLh5p7Ve22Wrs0JFGzpPNDArJEb1nde49L5SorVfEoObDar06F9MWYNDGPB3+XcP6t2U5HCXE0yUdlaRQYfMazOZI4+M3I8iQopV8jwm+LgDzmYld3bDUjXarc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6e07ZA8; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6e07ZA8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHUErE76P4p7a+hVxHh/DiOoG7Y4fDFRhDCbv45TJPBA0iyQJ74FUYrPaAwPBVViGk+G9l0eRuN2zKskmpj0ZD+jIMOdcRSfn7yPwYSeyWM6URSfVS9YFYUneFORSJVfZW2g+4w6X8C79gKheC8CpCIPEQ5VmUuESHdM9f9uRToa+KOZTqAwk9ZKrOZyAVm2JCOB22kX56UVxmf58eRwTXL2P0GiZqjcyEyu0F0IJQ5j/dx35CvnODGkyztJlqAcYs989GpEnxejahf0mLG25zppxrkgW+b3eH2Anq/0oRLY6j/9mWxexp1ICwki5V++Lcpvo3WxUzMINKJjX2RGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCdpH72xpBQCrB6d0R4T3/3OwAt0pOsfZzWfixpkT5Q=;
 b=VQYdSFOP8xFsHRc6E6/SvLd8r5YWprKHzehhtveUXeE2o4ZxfqteiqOtfbOqMBjiQ7E0zr1SE6PyvVAMIXHVWruSyYgGdWBXP+RX5zCewWaDc9c5oFp1iAQ1ET7zaYjjL0TEaE6f7ABJ6MgdRDKg/xGJw1K7o7kDpkMG9hfDMpsMLWoSVkeFGuiCKtnVJohmDYXWKpr7uhz+/3aCEoHPCATrQ9Ys/oO+KxI9E+VVTJJx8ShZMI+0IcQq8ugRP6SUOF+fIZE136K71BHRailegklYaNJGa28dNsqviN4cXO06CfZ9jWPx3xSTD1hbP21o9RcSPsQZIGx7cYJL2f+T/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCdpH72xpBQCrB6d0R4T3/3OwAt0pOsfZzWfixpkT5Q=;
 b=Q6e07ZA84lNVmaqaLFITYsOPSHEtwyOc0D4exjiEzDh8Qhb4z9d2EfxLD/3BYvr753d8rjL8ueQBapDntMkhHArm8HOvq49wsU9XLRayidzQ6du6fNh8mCpuLIEiaUPfVSiSDeB0AfWD75B9LKr2AtGyR/K/mzTVeHvVFl2Ho3Y=
Received: from IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::15)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 23:01:52 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::8) by IA4P221CA0012.outlook.office365.com
 (2603:10b6:208:559::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 23:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 23:01:51 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 18:01:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/5] Add CPPC HighestFreq support
Date: Mon, 4 May 2026 18:01:36 -0500
Message-ID: <20260504230141.484743-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: c8918636-8618-49c4-c426-08deaa3120fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xJZ9CyHSCt4kY5CJ5HFdCIGGxZE0WWRoOcZfcJopzF0aAkjcf9FT+y+zWBpSgbCZ2wlCCWHdpEcgqOIjjOgrPMP2Bp5BRPHjHlLxMrm8avDR71jP07wlVjNokIW0JRUzcLIsSNtdrmg0WC1EQaGOWhJHaaI5stlw4dGKVjt7dcCuyPiVfgLejzMbiGxttqe94o27oORJ621TKpyEjpJbkKcBPEAZ6ycVzjJffMSJ4lnU0nmKchbPN+GOJVrxZ0ML0I9qyU8AEjk0YFfLquFA+gPrES5YuiofbKywCPUcjob0jUFnUgM3T5WprtIZZag8AhXgvVGGm/IjyxMd+JVBgEu6pOw1Z+LmfkY7nhPksxh3Qomrswgz0k0pJcycj3ZnWzA1dtzxPf5NGpXPw2Fy72qDC1dOiX/btP3Z6Wq7g9UcYABB1mEH6msRHWBqDbWYxNEKcT2oNxEJVNCYs2smsuWf1CNBGB3+fAP6L+htmUG35S+8Qlpq5laNIpu7r5gBbji0mMuub4aGqBBjwhcanm7gZ+bGfDHJQbyVYcDvz8B30AxTRZi55+IArC/K9BJdRK6aiC1zJBqlJliL+ROMRix2zR3aTAPe0Y34Rt4aqiQ2tY1gRmzoBOHJsIDBPi5O9m5Lt1b0Xw1t6054uZrHUIQnpScH8tZxUojl8xbgwCfDoMkrzxdCYI2G1MZGtQjPjwpAdiPj8IzDRFvbGdRncQdB1UARumWtQ9fhzxqZ8m4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fXSCblVqaT/MqaBq4jXASPWTPTk42Rv7VycrWnzqL+rSjkfJSpTRDerVc4d20NMCvyOtbR7RoggwuS7HZRsZXwcYgJQNCaqcz2eEpE+gCigFmcuJpyZOCYFH+pfwT4YQ7GZJBHUnSvNst2KhIE8wB8ZLqDB3MzRBi2QLIHExt6Jc1YSdwGQK1i5BRVCygrghVF21uZ/O4qs6+bWFJ1pEgJ1jG+sMsksdi1oHRHYO0xfy7Xj5j63XaXSPlAvshwuZhgb6jAVZb9hRgQxFtytJ4R+DfRdIb89tAHmECscg1QP7Wk/RzYDM9KcBLr8v9evV+BPZNIIXCaO/Dwq3GP3Y3h3uk8wRirBZMU950mLlSiudLvS1OCjIL0zbN2hZnPG/Lo8EoQAgnEHUn8Y+q5QV/F+aYn0kHgxNDJ+KXTWFvJDZHiLj7X1C917Tl0i938U1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:01:51.6170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8918636-8618-49c4-c426-08deaa3120fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

On some systems, the boost ratio cannot be accurately calculated
using linear interpolation of CPPC performance values because the
performance-to-frequency mapping is not linear across all cores.

This series introduces support for the CPPC HighestFreq register.  This
register is under a proposal with ASWG at the moment and trending for
inclusion in ACPI 6.7.

This optionally provides the actual highest frequency eliminating
the need for interpolation. When available, this frequency value is used
for more accurate CPU capacity calculations and boost ratio determination.

This series brings the existing CPPC definitions up to ACPI 6.6 and then
adds support for the ACPI 6.7 proposal.

---
v2:
 * Drop CPPC v4 patches, these are submitted separately by Sumit Gupta [1]

Link: https://lore.kernel.org/linux-pm/20260430142430.755437-1-sumitg@nvidia.com/ [1]

Mario Limonciello (5):
  Revert "ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio()
    to warn"
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
2.43.0

