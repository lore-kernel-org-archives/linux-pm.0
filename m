Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CE3F7884;
	Thu, 26 Mar 2026 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525707; cv=fail; b=bNeBuvUT2ItgIdMyytyMWfA5CvdffIVdx1rXXu4VrrSz0OSs3VD52s3KCG2hNRn8KKeTyMnpqtjPgJNJMtKQypPfUdEjx3u4WRFrLsI9kVZVp9k5czJvnDo3L0LEGiQcc/AbwMwgrDzG+V/DG1DrFrhRgj0+MTQWhWe9+SBF09U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525707; c=relaxed/simple;
	bh=zYfGKBiiSetHFEkH0bPR988O6mXoCaexn7zCf3qMces=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cUU+7lrNChvtUxMhmm+dEzfJqA6E4RBWwyp/eDwy0EwFfmkRKYETL2GZhPrkXHcfJ8t8hpFMa4qK6OIC0EhKEusA5A9WjxRFRP6WiNv+B9SWoSwE3Tqkf53D6Zo1IzodtnEUQfFU6N4faQSXrnGZQAarTkPuh45PiUD/FK0cs08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vtmOKmOi; arc=fail smtp.client-ip=40.93.198.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vtmOKmOi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=py1KgGJE0iR8E8JN5n5IAljxWomyr0P7nMeXPE6aEq0o0SuOczVw6TchK52ljGQeaRU65z+sRtciAA/86L1mRvGp188bnIAMyhIYkquxJA32hdHdUPgp5jY0qqwB8uLCyj7/xBgF2dU3ymaQ8N5gcVCclsLAwmETphEYdSCpyjxEjodIJ/NOfcJTFJZ8hTO21zsvaYXvwievTkAhJ8/eygyz5dpleSRS5WxEpskHAvKiaX30BoT5QN1xSaMO4FoZj51UUQuZQFvSD/Fi7EHihqngj7wI/6J8/ARVHy5FdY3liO2xCSJNQ12ih2isPmdyzIYqaBAbwIjoP919Bf0r+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dq7G5A4gVP5zcjsWsFq57bUuBkVRYBPntKn+UKb4lak=;
 b=SBpyUBFb3+4Q9kEJBGoclTyb1DJDGg7NycwxYRYW/FopFrPf53jawGAmnjcorkvUGG4k/tlyuUzvwYZpnLxCzuUTxHe6uD9xIYkj5kbTPh16RyOcfVZk3bp6KQK8dHphi0lpIp8g/nmZpIPfHfkdOpLRr+mGuROK/IZavc97Q+bJDBYotTkQ43mOS+FEeKSrixEqp9vUOsoMpju3B6R7GNhWRJFqwF5djUHHV7zw3zuoPiFVSz9dFmsofRH2Wvdylom5x8MC8t5W5IO3QqbmTEbts/YlH3uh7aaIEp8eBTy8iKB1XMx/NlkL+Aup7uGGJ6fS4Qx20XWCd79CM7s/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dq7G5A4gVP5zcjsWsFq57bUuBkVRYBPntKn+UKb4lak=;
 b=vtmOKmOigICgVdibhmIiFYUgMEj6WDqfG6JdyX7Dra66E442vuU+W1O+/ITOi0z8R/bzABYlcPDWvz63zDpH8w4ANYROan+x0CA0uUieStMth7RXkVG8xUBxNp9Jt/9r6LbghTQgIhtJRIsS7x5CrRVmalLXR7MwPB0bN0zsHxA=
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 11:48:18 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::7a) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 11:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:17 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:15 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v4 00/12] amd-pstate: Introduce AMD CPPC Performance Priority
Date: Thu, 26 Mar 2026 17:17:44 +0530
Message-ID: <20260326114756.20374-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a262f6-ec66-45b9-d116-08de8b2d9267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	rie6DcRRY7cF/yygAi8HKgaL53Mz8ZJpd6PBBzex/XHKLpDfalm3LKhtZgd2pmjMXgZv0jf2/7vU/rl4Oh0Xk9c/LVYzdaDbFEguRrGQcn/OGYUndKK6LDz7nNCyFHwKjZf/DCKO5SU56+iWgR+Y7BQLjwlh/yp1K4tovy6TkenPf/q0GRsdrCTewOldyhay0PTeJR+AnV6CiKQjYegxtgaZhwlzwB0XmZ/xI1KoFhf3K39ZmEhFPif/qu8lf9hYNdsh/416Zt9ZpwbXKG8T8ldz9kZTt+MkZX19wJW8RDQWfzVieQaizwM6NDyCNaNuOHirUFY4iyvaTKZAVaoiRqoyaGl/rVna/pp86fcBrDR+YmDR7xCF0iDaM4ych07gWou/ut1i5ekct1ufI3K6Mm4WhLB/uXpoph0UGMxGEVHRsQ9AH4kSetgkc9S3zLgsK+B+Kdumkshv4XLDFuI4jYwWYQ2ip8OK7ZqiILiwnhODGH0M0vAz3wiwkAEQOz40rsjQn/hMWSyF/ln8sGtUH5RB1IVzhJfGE36+lLNs6qn1RNUJDyBCrEiuK9pbb4ulzOcNQfvm8Zg/h7tlkGAPaDZ/2nX4NQSdV5+N6jo/ZQi/bONAadDYQh9JW2nNaC3/bYxNDnQ10fhs/qOb8gEdLO8Af606bDBhdfJhaiy9GOgzHdiw8MdZtLU9q+S4EZuaRVO+8l8qIojBBNLYNFJDcIL5O3jh/9kovQLotRJcDfZUNJ0xKgaaI9KXIAnt5hGyTyay2ZED+hPCU7sLNS1tS+kSBM8ornqbScbqpCP0fec=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ssaDR+uBaqFcvadvii4AEAM9WX3Hq89WSOI3M7XSeN9/813S/xzm04vs1cOyDqlHeck/NB9lWDueO/mGmJQQKbKy8QwEZxLYW446v8Cg1e98IhfnT1wybsqxS3lCCPmWkBJ/J2A484xzlMpISeIww+2iGBtI4I3kn5GhzRok/zsxQvQlA62TrYy3Exk3HTZt8UIbxY++IiIy6X4WSjEaaNlizbPD1jAp2i9+t/qe3RlcYo4YzDXkZexK0OjhAMyh5e6LiZgbEiWHoar8iBLwniIJD2+VpPQ3xBzkUMLN7EFUhQFUKw/LaeI9ZtTEQhR37bsAFskv2SjwFPRGjUBJiqjfc3HM+5u8tg10OPc+KOb+o7GuyinAGNRJyqGCJ4PgOsWS3bxFvtPY8GIP4lbIArMsVxpOFMdmwZ23ymxsPtnPZ5yRBSrA69OSQjPGR8p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:17.8420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a262f6-ec66-45b9-d116-08de8b2d9267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548

Hello,

This is the v4 of the patchset to add support to the amd-pstate driver
for a new feature named "CPPC Performance Priority" that will be
available on some of the future AMD processors.

Details of the feature can be found in the AMD Publication titled
"AMD64 Collaborative Processor Performance Control (CPPC) Performance
Priority" (https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB)

v3--> v4 changes:

 * Modified Patch 8 to run a subset of test-cases specified as
   comma-seperated list while loading the module [Mario, Prateek]

v2-->v3 changes:

 * Picked up the Reviewed-by: tags from Mario except for Patches 5 and
   6 which have major changes (see below)
 
 * Patch 3: Fixed the subtle bug in amd_pstate_driver_cleanup() by cleaning
   setting current_pstate_driver->attr to NULL [Claude Opus 4.6 +
   review-prompts]

 * Patch 5: Added bios_floor_perf field to struct amd_cpudata to cache
   boot-time floor_perf value [New]

 * Patch 5: Moved policy->driver_data = cpudata assignment earlier in
   amd_pstate_cpu_init() (before amd_pstate_cppc_enable()) so that
   policy->driver_data is valid when amd_pstate_init_floor_perf() is
   called inside amd_pstate_cppc_enable() [Bug discovered while
   running amd-pstate-ut tests]

 * Patch 5: Added policy->driver_data = NULL in error paths of both
   amd_pstate_cpu_init() and amd_pstate_epp_cpu_init() to clean up on
   failure. [Code-Hardening]

 * Patch 5: Restores bios_floor_perf via amd_pstate_set_floor_perf() in both
   amd_pstate_cpu_exit() and amd_pstate_epp_cpu_exit() [New]

 * Patch 6: Added input validation in store_amd_pstate_floor_freq():
   rejects frequencies outside [cpuinfo_min_freq, scaling_max_freq]
   with -EINVAL. [Code Hardening]

 * Patch 6: Removed stray blank line between
   show_amd_pstate_floor_freq() and
   show_amd_pstate_floor_count(). [Mario]

 * Patch 6: Reset the floor_perf to bios_floor_perf in the suspend,
   offline, and exit paths, and restore the value to the cached
   user-request floor_freq on the resume and online paths mirroring
   how bios_min_perf is handled for MSR_AMD_CPPC_REQ [New]

 * Patch 8: Add the capability to run a single test from amd_pstate_ut [New]

 * Patch 9: New unit test to validate the driver->attrs [Mario]

 * Patch 10 and 11: Split the Documentation fixes for
   amd_pstate_hw_prefcore and amd_pstate_prefcore_ranking into two
   different patches [Mario]

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

   * Add the capability to only run a subset of unit-tests in the
     amd-pstate-ut module.

   * Add a new unit-test in amd-pstate-ut to validate the driver
     freq_attrs.

   * Introduce a tracepoint trace_amd_pstate_cppc_req2 for tracking
     the updates to MSR_AMD_CPPC_REQ2.

   * Add documentation for amd_pstate_floor_{freq,count}

Gautham R. Shenoy (12):
  amd-pstate: Fix memory leak in amd_pstate_epp_cpu_init()
  amd-pstate: Update cppc_req_cached in fast_switch case
  amd-pstate: Make certain freq_attrs conditionally visible
  x86/cpufeatures: Add AMD CPPC Performance Priority feature.
  amd-pstate: Add support for CPPC_REQ2 and FLOOR_PERF
  amd-pstate: Add sysfs support for floor_freq and floor_count
  amd-pstate: Introduce a tracepoint trace_amd_pstate_cppc_req2()
  amd-pstate-ut: Add module parameter to select testcases
  amd-pstate-ut: Add a testcase to validate the visibility of driver attributes
  Documentation/amd-pstate: List amd_pstate_hw_prefcore sysfs file
  Documentation/amd-pstate: List amd_pstate_prefcore_ranking sysfs file
  Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}

 Documentation/admin-guide/pm/amd-pstate.rst |  42 ++-
 arch/x86/include/asm/cpufeatures.h          |   2 +-
 arch/x86/include/asm/msr-index.h            |   5 +
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate-trace.h          |  35 +++
 drivers/cpufreq/amd-pstate-ut.c             | 170 ++++++++++-
 drivers/cpufreq/amd-pstate.c                | 312 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |  12 +
 tools/arch/x86/include/asm/cpufeatures.h    |   2 +-
 9 files changed, 531 insertions(+), 50 deletions(-)

-- 
2.34.1

