Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F793AA4ED;
	Thu, 12 Mar 2026 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773298173; cv=fail; b=Hbc0Mw4OrxTDM/y+3D4nPW+zKlOZZpqVbNg4eE5tROfWmc4/7c4tRWnWQB2TltJZyQZLP8GxUEmCeWEcfT72Dy5uKcQRQrz1cft7D96TRDUQ9XI+sDo4NKXUHlDTzuRX1DUMr9MwRbEza6h+t0hmBjkoZ0+A5F3rLtdVkPpzZLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773298173; c=relaxed/simple;
	bh=KGYC/yArb+EJT/ujW/f22/2KE41oMQpy+8KKfDIM7+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gjnc0s+hO4MchCBX22TJG3n1esB+8x6FFu/KMgBOPYOLdPyKIoWhcD/zwAsAV5itn7VMevgFq7UyDb/f84ViCWRAx3xZO7z6NGUJaCfprkL5h4pjjbTnEeg1goJvuUk9t300kd9dg3TMcC5U9J6bmFvqFx5zZ4UJEIsMXmU8M+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tascVSJ7; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tascVSJ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxpxT2/VKR8nZwkHDVZYHq6ScQyRq3j7HAawYosHRP/ufHb8LktbNI22ZwWEb9kYy9aGAN+v3KLGRsjzhGTYP3YuBIuPE75//BR24PpU4Ac4WmgPsMKmqwUmRiMsY+9A1SzBorkonFESHSHaGYL+NFexRihBBavc6fBlu4vzX5jrnMuKKXjVikR9J+0OhxRwXuSbKU7bH96TZQMnKjUGLTg6ZrWTarfdn5DCvNsglvPv7GYdqMuO4d18wduV8SBWhpEO2kG/3a5o2JGrOMzpspi0sgDEa/Oz7784uUYmP57h6261v28zzKAOIg22troxRxk+MSP5A1xOBZtS0kvL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0zP8d//QiUXsLzPWSioAShV5LlwsluopMQ94NEten8=;
 b=Gqu6JLFHsFh9Z+iqwK5bZNMYPgWTpE0Zwam9vCtIKUq+bJ/gegXmaZ6KxAPzDfqmBLaejNKRpZT+A8gMuvBs9bszHoQ5ilUqhDflsjG2j60sh9qBwIRyqn7h5/y9wwis9KqR/DWdurZwLKCOSaPZUitWEZhYezV3BASuEF813ZkKp+MChHiiSi/CVGN5kj6gk/5ELs4Z1v3Geti7q7jgOkClTH6JXrsyVneyg2WC/4fQUaRJ5pW5xo0vDab8CgVscArHSTwqqTLCns8bA+sIjL+ID/7pb0INUssDGXNQO3RJ+0H+IdNx9hAmtAnmFLBK811qDUGwqIGUFv0krKhJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0zP8d//QiUXsLzPWSioAShV5LlwsluopMQ94NEten8=;
 b=tascVSJ7LJ8UyXXIIETSE5eaTITLLDnSBfAGo0/6WXbV/7xVPkSqq1SyxhlRyTFnk97iZG+upml6Vg4LPYBFl/vhdCRUcqy4w6PMsJrbro/Qx7IkUlmBbFgDHepwCni2bmofnVZGioQdvD4yl3RgMDp7UlEsxCwr5d7lqEdUmp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Thu, 12 Mar 2026 06:49:27 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 06:49:27 +0000
Date: Thu, 12 Mar 2026 12:19:21 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2 3/9] amd-pstate: Make certain freq_attrs conditionally
 visible
Message-ID: <abJh8e6agnZLRTzs@BLRRASHENOY1.amd.com>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
 <20260311140116.19604-4-gautham.shenoy@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311140116.19604-4-gautham.shenoy@amd.com>
X-ClientProxiedBy: MA5P287CA0205.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::14) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|MN0PR12MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a3dc56-04b1-47d4-acbb-08de8003813e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UgF/h12lBxuI+IEkbDLMrnItL21/4zvg/a2UNkwC3WN/Ft1lMhzp6LacFQrmcUGNGZaM8G90qTSdJn5QKFzK2wCxQq2KmD3oSVPNr7G4b5vZ+p1mQmv4ep3rWnCdeDI9pxmCXOScMjjhfj/AlvA913kOiFWscEfrtoUrML/qRfZBL/zbF8bMJ2NSOwYI7aMANKZI5T/fydTCHbUuuupSiRl6Kcop6bt5IZ/J6mJkgkLq5qifIW+9C8IDWArV9MALQcv1XKlYSLVxTWVcghfhHlJeYtanfDbrdM4FDl/q6wL7r944z5QRqYOJkdT8jpcotwkv+rbP3v24e3UKYBks70zavxdLnWAMyywb/dDcX9P0GYRPQ/PsuXmstb1Qa3eyrtY8WEHqhCsimm5NBiBytC+HiaUVhc8Y+JXhiYy4UiPOgVbIDmc66dDaY1HDiZy1ak3KDpPGk+elDbmpWb+zFa7dFyl8bKoZ73HXya/Xx9vY56uyn1fdJdCzmfFsmd2eNkSVSoKEtshRQPapsB2ZZFHMbBdKVb/XxGiYlRGPdLPcmYtyaXmvqZ9Ouvp9t0GmpCsJLhqf/Ha5JTpYT+pO/4Ik9m28QUxuOMNxeqr0Qb5tBYklqeqhz/GFQt5D23o1kcAC2/2Ed/YRj2JNNXH0mgitx40/WP1ApbVZv8pMQUBCFC7K6dJAsPxjF1w1FjKKtIg2B5+UYcyPfhwIRqHmxGLQ6hLCnVMWTItABGRGk4Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cR7PmyiNvuBvEbxMSs7YRKWZP8acr+jFNV7hfhAvGZlID5PZ/oZw97/aX8I8?=
 =?us-ascii?Q?mH0QLDHKPt/Nsb6d8Ehv8SNwFMkVgqWWEiYhHhON1QVmDaPAJ0c7l3JsW2xu?=
 =?us-ascii?Q?194vey7XB6AI+yr/4tGyDRFuAOevssx1xvP+vx9U85KFCPBS+HsJJw/j/jWl?=
 =?us-ascii?Q?3wALh2gQsvmXJRqbNm0ANMJP9LFqHPa9uMBcvuiieKjm/POGv9H5IyG8QH03?=
 =?us-ascii?Q?pJTbi9RDNPprhdulPLg/2QcByyF8Q9piSbvzHS91x8KRVpDO0UqgqK3lZcld?=
 =?us-ascii?Q?NY1unSd2gv71xxUxo1LSPmL8/LAVUj+CUzEPtPkIeXrmtBE0V6BC1DjUV/gJ?=
 =?us-ascii?Q?ZigBJ6NsR4BKy6jOvDTo6OpK2JkGHyFrSuPboMNE0pbOj6XxxnXFqhO+icCE?=
 =?us-ascii?Q?4fY06ki/yGe9gAl/z3gyIE4SkrK8a4Q5CQnCXuyGQKtnyt3+Q4W+DDeP+eVB?=
 =?us-ascii?Q?P0lnwk0nb7gbpt4UafFZPgJILypgvm+yg0x/BHWAgyRSWP+FVlrrID5OKt4g?=
 =?us-ascii?Q?Tv8bDMgfaRmf2gG/JDhYV2al9EhYt7rQpZ3uoSpzltEGaaMG1nZAeiCJc2ka?=
 =?us-ascii?Q?+62Nnn4ANPXaMS0VZQCe+z3dhvToKEyMctRyDyQSOStN00O+l0P9ZM0kYc8k?=
 =?us-ascii?Q?cj/0hpkx+axF8S2mGiHX1YIFcEPpiShQzCDqen05yB+dgDAy/28Ky2Vhhp4i?=
 =?us-ascii?Q?Z16jjc2n3Mi3Eu0BVkWAJ3Ka2TXOXAWG+3GmiejkY0Sl/DN6hKdUXnyOcMA7?=
 =?us-ascii?Q?0NXaR3DLhpW9+ux+ZJAOK/p9xAYgXA9ltFT8Eu47I9q+BlinIPELuzgs0pVo?=
 =?us-ascii?Q?0ijmCqTH65kkxxXho/5oG3pD+cISKOnxbtrtlT0LgNJ91Ctb7qjWcocHQxnM?=
 =?us-ascii?Q?0+nZ59IDMRL7vO30CLTyfPZ1l3EKxzS97YzkSieZucqVlX1Oq7y/KPTm1Z5a?=
 =?us-ascii?Q?syojZKw8TEi7poyXVt/X9SnKMoC/bWUus6eeBHAX1dI1+Bn4C+2D7G90qcPl?=
 =?us-ascii?Q?7BWyt6iKDnLFxYMPOD+ZZgh7go+nIjBfmB4PDMaG8+/OhT1B05XI/XotBkYh?=
 =?us-ascii?Q?kUF9c/+6XkDYiSqGWWJ7Ng3uAyqqvcefJAfOoGKmvDCOv4FToI1yXHP0R153?=
 =?us-ascii?Q?LaD/m6ufY9OnzbrJynlXnJ+w+TYhkNLlOxPMQ2Evg7fIYZojh5L1L7lXAKF9?=
 =?us-ascii?Q?BYt3gzJ/y6wCwpbajQG7/Eyx7E1+6YaxHDrjzyI8Ds05p2GJ7MhQE1l/LNDY?=
 =?us-ascii?Q?Pl9cunFKerqE5CUbxhhficQZynuLV047Waz76EwwvlSbGnJLV6qmHn3OeAfi?=
 =?us-ascii?Q?FYdfoktyiV7JKRA+rBe0DcghHjcin97Ste2V8/jT3r6/tzHjai9F+VM7rcUY?=
 =?us-ascii?Q?8jpp4rZKf49R2SMy+fwqmkuuOkcyH6M18bQIouNSJVIgK5GTUcMqfY8G4nVc?=
 =?us-ascii?Q?oecUngohtscUDxK30ZfR1p87jOCEtDcoH3RrVIXsum9F4rAehaoa2/9sVwRw?=
 =?us-ascii?Q?dgV+aB5K4gvqUPMBKYh2E5bv9Dg4gHX9l8oG8er36IK/JX75jE0cAXUmb3ww?=
 =?us-ascii?Q?2TJfJWzQNDzBHl2Lms5wMiGMlhqlasNMHACTmYd5v0jswMO9+Ugwg3LZtZz4?=
 =?us-ascii?Q?AAnLXh18e/w+6cFIm1pmHaeVa3M5e0JV7H1TymU9W2TC9gqIpP61JW2I1HMj?=
 =?us-ascii?Q?umDqopRXAbQKxx3mmaOdKMnq3BycitSpZlN9XK5t8lu9jWQHg6NlKRZRy3UE?=
 =?us-ascii?Q?BehnFK1b5A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a3dc56-04b1-47d4-acbb-08de8003813e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 06:49:27.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhPfbh5gbh87OMGessklNZPcFuqCSpaPuk/U8/NqVeQOhA3EGwm4wtcgAVNFEf8RnQklJI/kPUVbLnLQ/E5ndw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078

Hello,

Claude Opus 4.6 along with Chris Mason's Linux Prompts to which I
added an amd-pstate.md found the following issue with his patch.

> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 24cdeffbcd40..fb5d7bb320c1 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c

[ ... ]

>  static void amd_pstate_driver_cleanup(void)
>  {
>  	if (amd_pstate_prefcore)
>  		sched_clear_itmt_support();
>  
>  	cppc_state = AMD_PSTATE_DISABLE;
> +	kfree(current_pstate_driver->attr);
>  	current_pstate_driver = NULL;
>  }

After the kfree, the .attr field in the static driver struct
(amd_pstate_driver or amd_pstate_epp_driver) still holds the freed
pointer.  Should current_pstate_driver->attr be set to NULL before
current_pstate_driver is set to NULL?

Without that, on a mode switch via
amd_pstate_change_driver_mode()->amd_pstate_unregister_driver()
->amd_pstate_driver_cleanup(), the .attr pointer in the old static
driver struct becomes dangling.  When
amd_pstate_register_driver()->amd_pstate_set_driver() later re-assigns
current_pstate_driver to that same struct, .attr still holds the stale
pointer.  If get_freq_attrs() then fails (kcalloc returns NULL), the
error path calls amd_pstate_driver_cleanup() again, which kfrees the
already-freed .attr -- a double-free.

[ ... ]

> +	attr = get_freq_attrs();
> +	if (IS_ERR(attr)) {
> +		ret = (int) PTR_ERR(attr);
> +		pr_err("Couldn't compute freq_attrs for current mode %s [%d]\n",
> +			amd_pstate_get_mode_string(cppc_state), ret);
> +		amd_pstate_driver_cleanup();
>                 ^^^^

This is where the double-free would be triggered.  At this point
current_pstate_driver->attr was never updated with the new allocation
(it failed), so it still holds whatever the static struct had -- which
is the dangling pointer from a previous amd_pstate_driver_cleanup()
call during a prior mode switch.

I will send a v3 to incorporate this fix.

> +		return ret;
> +	}
> +
> +	current_pstate_driver->attr = attr;

FWIW, the amd-pstate.md for review-prompts/linux is as follows:

x8-------------x8---------------------x8-----------------x8

# AMD Pstate / CPPC Subsystem Delta

Load when patch touches: `drivers/cpufreq/amd-pstate*.c`, `amd_pstate_`, `cppc_` (in cpufreq context).

Generic patterns (memory leaks on error path, NULL checks, uninitialized variables) are covered by
CS-001, patterns/null.md, and false-positive-guide. Apply those; this file adds amd-pstate-specific checks.

## AMD Pstate Patterns [APST]

### APST-001: cppc_req_cached sync on fast_switch path

**Risk**: Stale cached state, wrong EPP/perf on subsequent reads

**Details**: `msr_update_perf()` writes to MSR_AMD_CPPC_REQ but does not update
`cpudata->cppc_req_cached` when the update happens from the fast path (fast_switch).
The cached value is used elsewhere; desync causes incorrect behavior.

- **Check**: Any MSR_AMD_CPPC_REQ write path must update `cppc_req_cached` consistently
- **Fixes context**: Introduced by "Always write EPP value when updating perf"; fast path was missed

### APST-002: Online vs present CPUs for cpc_desc_ptr

**Risk**: NULL deref, crash when accessing offline CPU CPC data

**Details**: `cpc_desc_ptr` (per-CPU) is initialized only for **online** CPUs via
`acpi_soft_cpu_online()` -> `__acpi_processor_start()` -> `acpi_cppc_processor_probe()`.
Code that iterates over **present** CPUs and calls into `cppc_`* (e.g. `cppc_set_auto_sel()` ->
`cppc_set_reg_val()`) can touch uninitialized CPC data for offline CPUs.

- **Check**: Restrict `cppc_set_auto_sel()` and similar CPC ops to online CPUs only
- **Fixes context**: Guided mode control; `amd_pstate_change_mode_without_dvr_change()` iterated present CPUs

### APST-003: EPP 0 after hibernate (S4)

**Risk**: Wrong EPP on resume, performance/power regression

**Details**: During S4 hibernate, CPUs are offlined. When offlined, EPP was reset to 0.
On resume, all CPUs except boot CPU end up with EPP 0 programmed instead of policy value.

- **Check**: When offlining CPUs, do not reset EPP to 0; preserve or reset to policy values so onlining restores correctly
- **Fixes context**: "Requested CPU Min frequency" BIOS option changed offlining behavior

### APST-004: EPP 0 after resume (S3)

**Risk**: Wrong EPP on resume, performance/power regression

**Details**: During suspend, the cached CPPC request was invalidated/destroyed with the
expectation it would be restored on resume. Removing the separate EPP cache and later
explicitly setting EPP to 0 during suspend broke resume.

- **Check**: Preserve or re-apply EPP/CPPC request values during suspend so resume path can restore correctly
- **Fixes context**: "Requested CPU Min frequency" BIOS option; also b7a41156588a (Invalidate cppc_req_cached during suspend)

### APST-005: CPPC.min_perf wrong after governor switch

**Risk**: Performance governor not achieving nominal_perf, throttling incorrectly

**Details**: In active mode with performance governor, CPPC.min_perf must equal nominal_perf.
After "Drop min and max cached frequencies", `amd_pstate_update_min_max_limit()` is
called only when scaling_{min,max}_freq differ from cached values. Governor switch
powersave -> performance does not change scaling limits, so the constraint is never
re-applied and CPPC.min_perf remains at the old powersave value.

- **Check**: Invoke limit update when policy/governor changes, not only when scaling limits change
- **Fixes context**: a9b9b4c2a4cd

### APST-006: ITMT / sched domain init ordering

**Risk**: Wrong asym_prefer_cpu, suboptimal scheduling

**Details**: ITMT support is enabled from `amd_pstate*_cpu_init()`, which runs per CPU.
Sched domains are rebuilt when ITMT is first enabled. Enabling after the first CPU
means other CPUs have not yet initialized their asym priorities; the domain rebuild
captures incomplete data and asym_prefer_cpu is wrong (e.g. always first CPU in group).

- **Check**: Initialize asym priorities for all CPUs first, then enable ITMT (e.g. from `amd_pstate_register_driver()`)
- **Check**: Clear ITMT when driver unregisters; core rankings require update_limits() to be operational
- **Fixes context**: f3a052391822 (Enable amd-pstate preferred core support)

### APST-007: min_limit perf/freq desync for performance governor

**Risk**: Inconsistent min_limit state, wrong scaling behavior

**Details**: With performance governor, min_limit perf and freq are kept in sync. A
special-case path modified only the perf value; the freq value was not updated,
causing perf and freq to diverge.

- **Check**: When updating min_limit perf in performance governor path, update min_limit freq as well
- **Fixes context**: 009d1c29a451 (Move perf values into a union)

### APST-008: freq_to_perf clamping and u8 overflow

**Risk**: Wrong perf values from overflow, wraparound

**Details**: `freq_to_perf()` produces a u8. Values >255 overflow when cast to u8 before
clamping. Also, `clamp_t(u8, ...)` typecasts first then clamps, which does not fix
overflow. Must use a wider type (e.g. u32) for the intermediate value, then clamp,
then cast to u8.

- **Check**: Use intermediate u32 for >255 values; clamp then cast to u8
- **Fixes context**: 620136ced35a / 305621eb6a8b (Modularize perf<->freq conversion)

## Driver Context

### Modes

- **Passive**: Legacy ACPI P-state style
- **Active (EPP)**: Uses MSR_AMD_CPPC_REQ, EPP hint
- **Guided**: Platform-guided; `cppc_set_auto_sel()` involved

### MSR Paths

- **MSR_AMD_CPPC_REQ**: Primary request register; `cppc_req_cached` must stay in sync
- **MSR_AMD_CPPC_REQ2**: Floor perf (newer platforms)
- **MSR_AMD_CPPC_CAP1**: Capabilities, nominal/lowest_perf, etc.
- **Fast path vs slow path**: Both must update `cppc_req_cached` when writing CPPC_REQ

### Per-CPU vs Online

- `cpc_desc_ptr`: Initialized only for **online** CPUs (ACPI CPU hotplug)
- Iterating present CPUs and calling `cppc_`* can access uninitialized data
- Prefer `for_each_online_cpu` or equivalent when touching CPC

### Suspend/Resume

- EPP and CPPC request values must be preserved or explicitly restored
- Offlining during hibernate must not reset EPP to 0; use policy values
- Cached request must be usable for resume restoration

### Governor Interactions

- **Active mode only**: Performance governor CPPC.min_perf = nominal_perf; scaling limits may be ignored. Powersave scaling_min_freq / scaling_max_freq apply.
- **Passive / guided modes**: scaling_min_freq / scaling_max_freq apply regardless of governor.
- Governor switch (in active mode) must re-apply performance constraints; limit updates are not only scaling-limit driven.

## Quick Checks

- Every MSR_AMD_CPPC_REQ write path updates `cppc_req_cached`
- CPC/ACPI ops (e.g. `cppc_set_auto_sel`) restricted to online CPUs
- Suspend/offline paths preserve or reset EPP to policy values, not 0
- Governor switch (especially to performance) triggers limit/constraint refresh
- `freq_to_perf` / `perf_to_freq` use safe clamping (no u8 overflow before clamp)
- Init paths: apply CS-001 error-path validation; amd-pstate has had leaks on init failure
x8-------------x8---------------------x8-----------------x8

-- 
Thanks and Regards
gautham.
