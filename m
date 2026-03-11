Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012001.outbound.protection.outlook.com [52.101.48.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF41363C6C;
	Wed, 11 Mar 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237705; cv=fail; b=t7YiumM1nRWg1N9oEXT2INC1yJscFG4W1clWG95SbsoTkHJGj2Eai/JFEK3HhELRqX2yx6gW3gO6IaK4/vKKvDP16SAsWlkyWGmg+Z3iWsJ9obosCIKmGGZYoPpHwwFJZhqTl8Rq4nbD6zhAX1Kj9ju3q0kmtwQcK6oYvKaL13E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237705; c=relaxed/simple;
	bh=wd6X9iuN+/aN/dhdwGqvxTEae/gGQhn+GPNbnJrmnSY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DrZWp+xliUNRFoFsRPFUcLK5LPSMo+9tnGVwoEwlCRqDGqMctpvt2cPIG8id202JK6hYUbzcSmnVUsNewDtnudKSKD1D0EH2K9b7KU5h5SKsQRdl/q9WWiCN+WKY3VE9S8pUfgR7SZtMYaOCc3Ex7NB6YjCzeJEUudAIQt59iFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3xK1D6d6; arc=fail smtp.client-ip=52.101.48.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3xK1D6d6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXjtAdezw/WRsiHI7XqzeS6W9JMS2y6EwB87gHtOLRoStg/xMj2oD9BDsI7UrIbRre5TKwRYE1cYqJpLcbj0BcSHXWw6NvmPFH0BTKLY7r9IGLQ5Qp5gB+kps6dHtscRG0l2B3BL/01Cd88lIaoF5JDYuz3xl5kDVfSzBRGnZAPJJqMhj8t7jwJSZ48TUaqnOusZs7iyLnomqs1nOH25PnoLqKSnjP7+Xn0VPRiYSO0NItz8GIGgQBXmGk4YTrbruSv/INzfInbJZ9ulHUH+J/VIAPPcikILHlMW7r6Y4S1lsGSKqBjG2YSawQPXPCmbwXwzK1m0ipdw+p2iYQqNIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSKdvU13hcRHlIXkNl3i3lCQNxf0VcaKSf827EYTbxk=;
 b=HOC2mbPs8l6QUZ9z2bmkqhCY0vJ8DuwS78ROZw2r4JzZ75Yl1keGdJ6+xQEn0xSemVl5iVh9MdcQawLNpBITqA2DzsnlYMMq/nhukETEd1y/lDtqXjw/XhO4+tCqPcZzn9aPlUn2Pc8dyVQAMkbiHMy/iXO8+CR03gwNBP8wvlOnzOx0D55E3dV+wx09a/6Iivjp6E07R1L0c35c/nb1ptDt3rCH1FfQVuH4JDMPCmY1R9kSWAy6CXCSyQOcYAlsEBtI/Yj7U6jQXmbEyo4T+642bk0Twiusq2rLYAx4B/F0++rtNhR3EQVPuz8dSFLbFYXgH7CQcp/wvuodpmYnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSKdvU13hcRHlIXkNl3i3lCQNxf0VcaKSf827EYTbxk=;
 b=3xK1D6d6wzaJ2f6DHizMREGZhgc+PwBZaX8KSUMPE5RHSlWlgxAqPOlVml6Pf25xIsMP4b5YkgwJ1Wm+D+upAVgWKy66163rKDKil0V0p7bduzDv078RHV60x/ytPEU6ltBZ+SkD1N7XEmOFFzRNP47GG1BQAV6jLzuCVLOplpk=
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Wed, 11 Mar
 2026 14:01:41 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::cf) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Wed,
 11 Mar 2026 14:01:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:01:40 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:38 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2 0/9] amd-pstate: Introduce AMD CPPC Performance Priority
Date: Wed, 11 Mar 2026 19:31:07 +0530
Message-ID: <20260311140116.19604-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: f53ab761-6413-44e1-2bd0-08de7f76b872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	YvLPEEUN6Ah/hyW4t/K5EzmD31bBA9AAe6RpIyaGIYnYorfkwzGmlrODRXFcB1lOSKoRDoPCubvVvRvRdPw4qkK6XlnnaFEZFlkc0HjY5AwxAUznmbttVc+hxsvIyh5tFte6n9k6RFK0dau9G0+kYbomBnH1ZVLjMNgToLdmvLYRAKzxsKlNh7Qhw5I7fA/WowExoVCvbEhfoTzNd45qZI6jMH4r1HdCX9NiajF8p2E1hlB45i8G8plP54YGQL0VvlTvZ8JlFEwHVBWGtNB6ZrrVg9Vcj3ui3kiWyZAW6xM4x4JlDTAsDUB5aYtw3MRxGv1xoExfmn8xm4ibojqJtRxN2ZLGCHqtRE2pf0einKAWlQRvJUgfhabdpTUggKRpCDwWyT7H860ZLijSJu1NPkV2xrDw+NT80svkMB+NArer8h/h298mAbTqBJkIflRaCRM/yYRI6ujoLxY55jhwXUkRM4ACeblb560NwIAI99x4P2T9Xl3NXgOK5B7dS6ySk1noQnVOtsPmz5wolstBUIrzU1VR2E8H7vRA/sgqExTJsYz/UnRPn3N4m1rP6cVU8NJcogv1keYmI+hTpfzwfEotxaK0mhTUJtoratTUxXqr+XWHKLCc4ePO8G3bWR5CFBvTEQMcSw84Ul0ClgqLpGujfogBZ2hikLwbfZKkHYNPnR0LzWYjo9/C3xdPxlNKCpUycNZNghi/n72k6fS22D4ydlDNJBWBuUvFkuj9zGo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MCrqIQidf2k9seh2WGFE8dh2JJKgO7YtBEcdf5abvbNmm+enzUaf0Bq58baDp1JDCln9zvMCCsRti+2H3gtqIV5l06Z4c+ZajTLIXZ4h6Q8DzdKpzIsrEpadOQgQXAiQga8KENDbWSPGN2v0e0PrbpXlCAGEQPKUgiVtFzY3OWaopK1HNAc1CA+M6WQAAMkJnhPKqhtKHZHj1EvEqN3M8mXyUoVqidztRVqvQxyKeC1Xl8D+JGNYwaJl0Stbi0JSj1Mf2YkBIE+NjPTzHMVkcEdny/XsHrqfmwNeVtEu/cn7bVi/bZ9l0SytKvDCT0t24HHB+0vkS3x8i2szczmH/7dylgh+UJHuQsqWwug3cI1UZxy/LZOsjEYFnsZoKOKs5UyIsR9rU+FdIwBuI+OIGqPtdup9iOkfKnSBfUWfWxN8/7BfYtCYfC7qSxDFfmoE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:01:40.9193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f53ab761-6413-44e1-2bd0-08de7f76b872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

Hello,

This is the v2 of the patchset to add support to the amd-pstate driver
for a new feature named "CPPC Performance Priority" that will be
available on some of the future AMD processors.

Details of the feature can be found in the AMD Publication titled
"AMD64 Collaborative Processor Performance Control (CPPC) Performance
Priority" (https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB)

v1 --> v2 Changes:
 * Picked up the Reviewed-by: tags from Boris and Mario for a couple of patches.
 
 * Defined AMD_CPPC_FLOOR_PERF_CNT_MASK via GENMASK_ULL() instead of
   GENMASK() to fix the build errors reported by the kernel test robot
   (https://lore.kernel.org/lkml/202603070431.ykswVnpp-lkp@intel.com/)

 * Moved the code from amd_pstate_cache_cppc_req2() into
   amd_pstate_init_floor_perf() since there are no other callers of
   amd_pstate_cache_cppc_req2().

 * Cached the user requested amd_pstate_floor_freq into
   cpudata->floor_freq [Prateek] and return the same when the user
   reads the syfs file.

Description:

This feature allows userspace to specify different floor performance
levels for different CPUs. The platform firmware takes these different
floor performance levels into consideration while throttling the CPUs
under power/thermal constraints.
    
The presence of this feature is advertised through bit 16 of EDX
register for CPUID leaf 0x80000007. The number of distinct floor
performance levels supported on the platform will be advertised
through the bits 32:39 of the MSR_AMD_CPPC_CAP1. Bits 0:7 of a new MSR
MSR_AMD_CPPC_REQ2 (0xc00102b5) will be used to specify the desired
floor performance level for that CPU.
    
Key changes made by this patchset:

   * Fix a memory leak bug and a control-flow bug.
   
   * Plumb in proper visibility controls for the freq_attr attributes
     so that only relevant attributes can be made visible depending on
     the underlying platform and the current amd-pstate driver mode.

   * Add support for the new CPUID bits, the new MSR and parsing bits
     32:39 of MSR_AMD_CPPC_CAP1.

   * Set the default value for MSR_AMD_CPPC_REQ2[0:7] (Floor perf) to
     CPPC.nominal_perf when the value at boot-time is lower than
     CPPC.lowest_perf

   * Add sysfs support for floor_freq and floor_count

   * Introduce a tracepoint trace_amd_pstate_cppc_req2 for tracking
     the updates to MSR_AMD_CPPC_REQ2.

   * Add documentation for amd_pstate_floor_{freq,count}


Gautham R. Shenoy (9):
  amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
  amd-pstate: Update cppc_req_cached in fast_switch case
  amd-pstate: Make certain freq_attrs conditionally visible
  x86/cpufeatures: Add AMD CPPC Performance Priority feature.
  amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
  amd-pstate: Add sysfs support for floor_freq and floor_count
  amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
  Documentation/amd-pstate: List prefcore related sysfs files
  Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}

 Documentation/admin-guide/pm/amd-pstate.rst |  47 +++-
 arch/x86/include/asm/cpufeatures.h          |   2 +-
 arch/x86/include/asm/msr-index.h            |   5 +
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate-trace.h          |  35 +++
 drivers/cpufreq/amd-pstate.c                | 254 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |   7 +
 tools/arch/x86/include/asm/cpufeatures.h    |   2 +-
 8 files changed, 313 insertions(+), 40 deletions(-)

-- 
2.34.1

