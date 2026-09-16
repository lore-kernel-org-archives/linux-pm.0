Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011037.outbound.protection.outlook.com [40.93.194.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179894E50AE;
	Wed, 16 Sep 2026 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585528; cv=fail; b=ecFk6uyGhfLx+WBvB0euyHyrGrPIu1/WUTzYvJU/V1u0TiQY/6qmLHdVoFUjiD9ulJoBOoGlyZcGohYCFo0yvlz484+Z2fTIVaEqTSebTbuFgnjntAPZ94nXmAXGqEddovR6VJRkmPvltiZzIS/EDFaigdC+gCqxavVKFVmmToI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585528; c=relaxed/simple;
	bh=TcN28pn69hsYALUuY74sDpVRT102AA6AcwlkWWQaDJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sEsPKUYN9Xw+fOX9ouAD0CbJkAPHAhvvtU6R1eoeAktPd7eyaMZOPRAOqKx14PZ/btsAdkt0ZYs+V97ybdmETzT51KtOA5WhP/elxLHup+OYoHRhVAWNZawrs94DYjmjllWkgJsrDFotMpGHn5LesM//TUknWlSkjWbjgFZ5Hro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4vNfFg48; arc=fail smtp.client-ip=40.93.194.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4vNfFg48"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2OoeOvtWZfBpUQTkxi2B/scsm1BO1YzTcqDGToc/dbxQ8bKUAnbtQmzJFZpPxpm3/cNYefwYZD0HS1GiQ1osSdWHMM/oTjm4wuWU9J2jhSGfcENqVMNNFNN5IPWUJiAUtTNY93m3MgAWHoBZmDQdMdSdu4r54d4ObwBbH8No0YoaY5fdTXo2mBO86nWwzNNGyarKINGW0MipSl3txm8mv7QaeciqPCnF037+eBm1d+mH466+vn09QbiHjwygCrUI+9CWkh0rTKrLVVGWLTuUnnMyz0gkew+Wn5iqvSd5982Dssh5r7wYdYY5wRA+t+OLye6ZTRc/Jk2Uh94j0B0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvF5s0vgFlKcRAR7XDyS0ZUMFKgQTC/N6kKGfYbUnQg=;
 b=UJ/oatPKr82st4Wms+PXes+M93rmspl4R6GRHya6EnDinji/DglXuSYtyZ7jRr4o0BsCChVEHV++zygAKa65VC4DRgXeLNM9Bo71+lSah4XtonxwtwB+/ggSHQBJWxIV8vLRPzSSBQnjlid3uNKcJmFnAuvpGiGWR6S5QU/yh+c58Px7MgsbRFnJOrJ58Wh3FqrZzUdve+ypAiUbqVgxSe70CpgYdWQP5842qgPvVVIYeIyL43mWNGkJowbmBhtlx1ohHgIZT8aKjsXzznl6ZEVBFk9qL6gqcmbEAjROYOeVRiqqTjdQNX5X3Jgx5B02HyjEqxiJ3ObxWa8++x/nPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvF5s0vgFlKcRAR7XDyS0ZUMFKgQTC/N6kKGfYbUnQg=;
 b=4vNfFg484nhZxtwnpbkIxzDyDZXFhjmv9tfimWZfB1+0wD20Tudse041fgcjxaSy07NV1bOwmgbj5wVSpC1DDBDfIDx6DGyXNgHfOa90+zj14SLBO1PdtFSAYedze6jd0G1wNrnDJZinUPZcNZWFLS2Smq2J7O9YhSr3GNaGSr0=
Received: from IA4P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::6)
 by PH7PR12MB8040.namprd12.prod.outlook.com (2603:10b6:510:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 19:05:10 +0000
Received: from BN3PEPF00022BDB.namprd03.prod.outlook.com
 (2603:10b6:208:558:cafe::39) by IA4P220CA0008.outlook.office365.com
 (2603:10b6:208:558::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 19:05:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BDB.mail.protection.outlook.com (10.167.248.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 19:05:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 14:05:03 -0500
Received: from [192.168.0.226] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 14:04:56 -0500
Message-ID: <97c3140b-071f-4c4a-b42b-d84b6107017d@amd.com>
Date: Thu, 17 Sep 2026 00:34:55 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: Sumit Gupta <sumitg@nvidia.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>
References: <20260916103820.1760297-1-sumitg@nvidia.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260916103820.1760297-1-sumitg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDB:EE_|PH7PR12MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8199a511-cf6c-465a-f444-08df14256d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|921020|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3QdID5uf52Zj78bUZq+l6zu+J4cmJ3GAo2J3qnd+lzQw92akgn0uNQCAEtptPP85U8q5iaC2x3ZM17JbRw+ZDjuh+HbC3rwt2s8bbRHGBztSAQOLOuU0NkRFzcTe0/htcKShgR2rnOHb+EcakNe33hHBr4d0I3xafKoZmDeOoAFsWoR3JVzvBxif9xqBeDI0ennMtPJKGvp5z8SiArZrcIZmcAzjCdnntWlU7MZQmtn3eSpCifMhS2qpBN/gm0w8IsVkmgOSBC73xWPd9nxFrCd5JPq8JpYYfX5+3S8NcwsxsOwEZddWSkAK3pme60zq7gdEKWaglWm0g7xCxJN9guLD7kzdeN+tiLCAkRbXBIdW6Mc3Sobr5nyRdeJf5781+XZl4wESK4b6CDFlJv3AKEaFclyS6dMqPjyd64QYQSXdEoK8sxSx/AhZDgGf126Oc8zIIJErW/XWxn275sejuCaQFPhQyWWkjipmGKMEDsHIB8ubP2toTYaLm794qZa3Qv3l7ceF7hXab9QxIdGaj2dnOA2vhGy2ZWwa5AK4CCoMaRY2xGFxUmad3P4uvsAITKGJ+UYPNjfLoZKPoBd/keioSGzG0/hTAAyFHBOaRBt0uVmEgc63eFpSYiNJhqk+XD0ABgRTy2d1SD9G9q5AJmUKEuG2P0e7JqmT15UejIOHrEbB/MPvw/TB8wjYcNOTd6fdCbUlqTYZ+sjJcPeRTrulvNpLqUkwfwZY5NktaRaiCmtEBJDx8H0OjTELCVDO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(921020)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hVTzPheaTgCP4eKPxo8J4DGN72LqHayBntLfPPgIeWAoYLPKxapVZMzidquR3QiLzxpXZ5GNMRstc3wqoOXraiSgyCXUmbRbDvWJD2H3jrWgymS7Df11nuNOgZw4CEo4Cmd2qeEwrxd41y14YwyUPWQznhTw4O80Jv2uPFffbHwP4yNC3IkgAKv2H1/c2xpJ4rC7V+Ny1iBuUuT3Yc7F5WYFhvbaSJHGERHVCFsC52V7sR3znJ0QDu8bcxei9TnAYM3fyaVTLuo/FebXMbMMbCdfazZaKJRori2LmAEhHDZK9jWs0HJUFc5L5glswrlk8q6Jl4z/yRb127I9eZDlp5c5lt4LotBFl46msPZjyp3ab9O0wleZFgYMTc1Q7QhZ9IA7unj1LIiuKuBbDcxtuK+6diRQjid/eXGq5v0NtOd3f//sxL4FrvS6FIC3/6NN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 19:05:08.8363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8199a511-cf6c-465a-f444-08df14256d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BDB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8040

Hello Sumit,

On 9/16/2026 4:08 PM, Sumit Gupta wrote:
> This series keeps the CPPC cpufreq policy alive across CPU hotplug and
> preserves the OSPM-set CPPC registers (Energy Performance Preference,
> Autonomous Activity Window, Autonomous Selection - set via sysfs).
> 
> Without online()/offline() callbacks, the core tears a policy down when
> its last CPU goes offline and rebuilds it on the way back, re-reading the
> CPPC capabilities each time. The values written to these registers can
> be lost:
> 
>  - Across CPU hotplug or suspend/resume: the platform may reset them
>    while the CPU is offline.
>  - On driver unload: the driver-written value is left in the register
>    instead of returning to its pre-driver state.
> 
> Handle these with:
> 
>  - Patch 1: adds online()/offline() callbacks so the core keeps policy
>    alive across CPU hotplug instead of tearing it down and rebuilding it.
>  - Patch 2: makes the autonomous selection register helpers take a u64.
>  - Patch 3: adds a table-driven mechanism that captures each register's
>    firmware value at init(), restores it from offline(), and reapplies
>    the OSPM-set value from online().
>  - Patch 4: extends the same save/restore to system suspend/resume.
> 
> v4[4] -> v5:
>  - Patch 1:
>    - offline() stops the frequency invariance updates and online()
>      restarts them, replacing the resync that raced with tick. (Sashiko)
>    - reorder the functions to match cppc_cpufreq_driver. (Jie Zhan)
>  - Patch 3:
>    - reapply the OSPM-set registers even when the performance control
>      write fails. (Sashiko)
>  - Patch 4:
>    - suspend() stops the frequency invariance updates too, completing the
>      patch 1 change for a policy whose CPUs stay online.
> 
> Sumit Gupta (4):
>   cpufreq: CPPC: Keep the policy across CPU hotplug
>   ACPI: CPPC: Make autonomous selection helpers take a u64
>   cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>   cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
> 
>  drivers/acpi/cppc_acpi.c       |  20 +-
>  drivers/cpufreq/amd-pstate.c   |   2 +-
>  drivers/cpufreq/cppc_cpufreq.c | 378 ++++++++++++++++++++++++++++++++-
>  include/acpi/cppc_acpi.h       |   8 +-
>  4 files changed, 381 insertions(+), 27 deletions(-)

I was able to hack the Kconfig to build cppc_cpufreq.c for x86 too
and test this out on a Zen3 machine that uses shared memory based
CPPC control.

FWIW, I could verify that "auto_select" and
"energy_performance_preference_val" persists correctly across an
offline-online cycle on my system so feel free to include:

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

