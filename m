Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08B3C3438;
	Fri, 20 Mar 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017839; cv=fail; b=qrwf38v1/F4W7ISiiWfY+HP4msf1/jvD2ywofaLuEI9psEnFIdd3IRHDuokH1o558F4iSVzcXHYaUPtSzTT0X0IcqbgNPp9brf8IrPbnM819JcRX58I+9IASfJhM2AhfGuyo6rvLLQk3mxjXYxXlDEkSbFxiTVrzG5jx1EOQIBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017839; c=relaxed/simple;
	bh=VKe2uhm/gYcNzl38uOz57vX67RJiGbSbz/atFVYvgAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRq3KDxAo+AGu96pa4g8wDc173t904J0zDJdsVlvLQuT8rItrLdODc0z0kmnloXXjSM16Gct1iaqJevMwu5yGuhFttQTk4NJzJ81RdOw09bEsTfaikozjbif5JaxP3idFYkSQXDM2Ap0EIN0OTPmCrc1T/SugMbOo9VJo2awz0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3YDOywSB; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3YDOywSB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6ltZT/bNrR1eFVRq+LcmBum8kTSOv972zRQPFg5OgGmFVmpcIQZ2zG6riLIeO62mrxqYeQzYSdPkuPVUwJ/iLVT7HyMRoq4HXWyLkKyvmnr6sZN0M0MVOmUshptRve6IRFOq/CsWPERv79kRMEwYi446fJUjkN8jMcPEo4URqW6fyFEvOYIruxHCyB4xCjIJf6+Q/5E8xliqSbvAPqXsXvenysThIOdeHcYDm7E3mQbyC3HDqAs59zMybus2S6h6Ou3AivUIiZ4BTvC7pcGDMFMSFxnWeH50lgUamMlOY32ozEXCzad07h5Y2Ez+rH+BBbn2/CxKPIIh6mvjNfsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RiPqWfcd14MPc4bmDPLUBo9b+2FD9UU+BWpAecdwTE=;
 b=o77guZ+VYMrZw2hX9ZY+2THP3OyijRwPAFUaeWVLm1YVuXizhfDenNQpqAEYYeBnM8/FMklhSWo6WiCtxVgOduDDr14uhQn0Kdar1DW+8IQ4lf41sI4VWKrSby1jzMD9rbXKaOBaoISZPv5Ki2uOD0i0uD7LCeHYsXYtVcti2i78AR7tS2MnBIEU3jrLs0wI6anAtjy1tiCbz7ICUdBJDDjYqNZAoqa8FP2xvmGzolyJ0STNvGt6hd7WPK61HhimmiKj8KLMg0r0m4+IvsJwPqQyxA9FIr1T3Hn1NHUAmCnIWiDhbzjK8TQE4v4YeYol08JUz5uR/uFGMgxhuhEqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RiPqWfcd14MPc4bmDPLUBo9b+2FD9UU+BWpAecdwTE=;
 b=3YDOywSByeCVrjNv/3AirVMdFlz37wLDx5dio2CSYSnvo60hSzCO/xhr5EiFkQX4U6qeL5mz7ohB1zHnhko3gQVT6s/t9206Qk2WdLxYkLN4ldw+7UXYOgmMAFebm9NNAxOUuWV2gQ26MhL+AgUQXw1M+XMIE3YSVaCwIAcekKI=
Received: from MN2PR19CA0031.namprd19.prod.outlook.com (2603:10b6:208:178::44)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:43:54 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::e4) by MN2PR19CA0031.outlook.office365.com
 (2603:10b6:208:178::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:43:54 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:43:52 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v3 00/12] amd-pstate: Introduce AMD CPPC Performance Priority
Date: Fri, 20 Mar 2026 20:13:09 +0530
Message-ID: <20260320144321.18543-1-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e80f911-131c-4913-2fca-08de868f1c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Wd9uYrVvRW3MWXs8RU2bSkxLiMbKAMKFEDHpBtiK/R7xOupKn7Ssu+ouOX+jQbVRl+JX1ovvskyxfYruKxSZK9tqUdpCTqrtsUo3imX1oATaAfs+SkBGnUUOU0sZUwT5lTjrJXxQfesQQ+YUbP/VdczxCFdj5ld0yiNBclgKwFcUOdevTb4b64dxZlspVJc5eaBfdHg4RanY44lqSaZNsD/nvAIwpQJWYuH0qa+k0Mgm0LAg2zEuE0vHTFrNr5KBWD3QgYDfN/KvNnrMjBaPQDwHoRl8mfngTeeOO7vZF4Lwnr4InLHia2MP7oy9XdRnRrJqv+lDJ+cqDHYOTokbtdWgErAUbNszr3Apv2zBFIfZjv0KGn295JPtF932XJW4DoYXAKeGyzbTfvBg4f+5Z+con33RQq2lG1soinUHO1nciqR6iYqNRv/6q+XBSHuKUlc6l7k3Qiv/G8Gbj4UOjd0QfibG+k3TGfgofVeKgD+lhCvCrCVnWN/FIxh4yS1tPRWDdcK/MZ630O02PgZnLn96Xeg4A7GD5ylhTBeHGEwj6t6sa7aqXeu0Mjt9D43PZcqhancw2xZXX+KR0RbhcrDE+Q7Di81cH+Dx8dq+cbYHNLTRM0u1iUU2eNFSQZBlN4Pxry74zJIQnhvJyys8WGD8cuPzDvyM+YA9+IQIXVmlochdWDY4K08kzJcteMA7XCk9YNC+8ZLf7NQHaNNLOSJAfvPqUfj+1j3lwbVq1hPh6WnKWIFPEXA2xs9x2o4NHPG93ALMl8NQqAN0PsrEfxDm04i/aW5S79bBXfrGCtY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	atLFzyi+/xDtgpQgipA1A7htrkC0ESZF8/PLj4gI3P9Qf6CT6UojeR+FFNe2xMGb01ozBinVHZ3LBsO3lhNoNNuV8mR3IEgabW4egsUKYhjZziBUE80EnAOZiXSLffnoNMPkjbY1n74eCrnoa7uPIAXtrDcYyz57WNh9PKlYLH6plnmWM7MfKNv0xPBxv9b+hRxFbgUdf6GuVKojcfd4hZ1BSY17834MClwpXtUKHvKMggTIGAxJLZc3lg5BJoLtMP9e2lQWx48xaM+YfNFmsa+ve3hhH58ic+UREFJoHcCwSsik8X+YCAvhtWSxsPJcbpNYl4MGn66oLW46WV2wzO3sAHCz28bRihSDS9mEDAA6laaJpTcLwJY+pgBdgKW7SlvjPdKEARb4sAXRp8PCiKts9+pi1xLcfwOD5E4RzUppQRaktM7BB+tjTT139/8e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:43:54.7061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e80f911-131c-4913-2fca-08de868f1c5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754

Hello,

This is the v3 of the patchset to add support to the amd-pstate driver
for a new feature named "CPPC Performance Priority" that will be
available on some of the future AMD processors.

Details of the feature can be found in the AMD Publication titled
"AMD64 Collaborative Processor Performance Control (CPPC) Performance
Priority" (https://docs.amd.com/v/u/en-US/69206_1.10_AMD64_CPPC_PUB)

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
  amd-pstate-ut: Add ability to run a single testcase
  amd-pstate-ut: Add a testcase to validate the visibility of driver attributes
  Documentation/amd-pstate: List amd_pstate_hw_prefcore sysfs file
  Documentation/amd-pstate: List amd_pstate_prefcore_ranking sysfs file 
  Documentation/amd-pstate: Add documentation for amd_pstate_floor_{freq,count}

 Documentation/admin-guide/pm/amd-pstate.rst |  42 ++-
 arch/x86/include/asm/cpufeatures.h          |   2 +-
 arch/x86/include/asm/msr-index.h            |   5 +
 arch/x86/kernel/cpu/scattered.c             |   1 +
 drivers/cpufreq/amd-pstate-trace.h          |  35 +++
 drivers/cpufreq/amd-pstate-ut.c             | 150 +++++++++-
 drivers/cpufreq/amd-pstate.c                | 312 +++++++++++++++++---
 drivers/cpufreq/amd-pstate.h                |  12 +
 tools/arch/x86/include/asm/cpufeatures.h    |   2 +-
 9 files changed, 511 insertions(+), 50 deletions(-)

-- 
2.34.1

