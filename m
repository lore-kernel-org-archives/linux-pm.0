Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C839A06B;
	Fri,  5 Jun 2026 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683894; cv=fail; b=YNhKBbqdvH3kiI4oGB4pnjUyUPbBtCfk32msCmZ9D71TF75O5MwpcR8C3txbgUyIopJyLtm6TNx+gN/6jzWeu/liA55/VE7Ogq7Vwp3ZoPpfmrstHGAzVTvYnn5RSIcnUQEezKoVgSGq/xv6nhOD2BVF8sddfBOL9ZdlUBDQ4xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683894; c=relaxed/simple;
	bh=bz7mlO6njnknih9Avbn/Bmvi7W+/4dIdkcNBr/qEsgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ScNBROF91MGwDQhpyR0q54Sd/KbcaOpYCnW/cf1uxp9KxWEM0HDW6dp8FXxA/aseb+ZrgeptF/TlTPPRm0+oD7kiNq1tnt3e40zMV5RbM9RK2lEbQhz+bHztCG7cPF20/DOh0YaQRXZZbALQigJPUMKc3GuRX0WGsD93Kkwotqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1uD8280R; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1uD8280R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5zPA2SEel5e7hKEAgp96AuoVrCdvnwlmyG/q8jXrcMSkyIU7bio19sUlqytnZlliblU0XXk6OcxxJRaHD3wN8yJxvyeYUcQ8jrMJrH+lxBzaAakEk83wcN5qXaT+ECm57kWGnEwi7B/0e43SGRLHjvffLz0UpujfxikCmHQESEC5OVQthDNskAC7R8e4E1A5PtxDA1pALxIu0Den6M1Wi3yqt6M6AieUTycR8LvGumNmIVnjbii3SbWKL6BiJRCufpbJj9nQLksItNmdCpOsUdoPi+87+UgVkf850zMDElRLO40HR//O2rXIKW/olxgyKH3x7mJ+li7qEhVs0wz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdFGKtv5VLvHm82nHoiZlCsdLJ1HTtcaD/PsLL+7WWA=;
 b=hszpO0hsueToX86nF3NHCj0QjDlXuqcfjikLN1txK3wHDH+MO9weooJE3MjJfdBBdQ5zqy90tXqLqkjLuzHIHx3M+TUyyAPEG8BhfDWp/BWgRHEP2Z1HdvEzCOlnV+DpGvz8gJMPsOquj93fETqiAe4BrRPi/fypJ4+D+FF5LpbMZJEae/NcCZD9BayxguEn3SPAZuvDQpqpRAJg8Qj6eVwr9yCYhJqNmD/HVlLTMnCUUjbRIrJFMyRvBZw+V7T/Vrdixz+mjDZv8jRIwgoC+j40atcjDobfT56f3XB//aTTczWDzyuogFyhIMRFyhixrgnm8FDqXeP3ljXgmr3a1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdFGKtv5VLvHm82nHoiZlCsdLJ1HTtcaD/PsLL+7WWA=;
 b=1uD8280RymJEs7gaNxVeI/qO9xlNX/6pPTXdb7Nsf9HOBiNEmV2LE4qvTrv/mI0pm4zWEIjypwv4M0ETAd3UlQ9f4GP+8fy8AJr/yOg9Rf9ozhcmm/sYH3bxIHEnmG3W8GoFnM6WNoNg5z1+WVONVgu5krGrjraaU1ggIEnff5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by PH7PR12MB9101.namprd12.prod.outlook.com (2603:10b6:510:2f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:24:47 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:24:47 +0000
Message-ID: <369d62ed-134e-42de-8263-e1a6caec76c2@amd.com>
Date: Fri, 5 Jun 2026 13:24:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cpufreq/amd-pstate: Fix EPP initialization for
 shared memory systems
To: Marco Scardovi <scardracs@disroot.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 perry.yuan@amd.com, rafael@kernel.org, ray.huang@amd.com,
 stuartmeckle@gmail.com, viresh.kumar@linaro.org, wyes.karny@amd.com
References: <20260605103131.88711-1-scardracs@disroot.org>
 <20260605103131.88711-2-scardracs@disroot.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260605103131.88711-2-scardracs@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0082.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|PH7PR12MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f60f7c-bfb8-4c61-aadc-08dec32fb913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tE1AxVlcs3IqI8UPWQW+7RadItYrT538Sw94NyADy9m517PLTUmLy+VrDOYq4kuvmrv1TdeahAl5nsMWJ+rKnH3OghK2E10PXMqsD621yzGEv2kvaTtAb/7+0pIMWO6i5PEHZieIgRtYFr0FGNer38VJgJZ56PCtV5U8nvUlzK4RIMj5iftSalMRHzWP5TDhlDFe1cuwvbeDi2KRYNuDXJc8ZyjiISul0zmxYAJWRG6h8fpr0BYDCUK6E1p+fG5BqG7Q6tSwZLnCHwadEkQRhjMjsRqx9l6OFeoqRsxZsYl4soxw1uo+NNTHSHhXLB1gyyCkLz81g5oj7nQl2sIlD39+aYLFLgNINYSwBahckX5+1ZtZeJodpZDct5C/vT99iqxCwcnyVp5nE6FZ5uXuJcZcZ9n92OBrUfpiuWUr6yuVkxxdzYiIAQwjLXAsNFjtb2NEGM8roa/Gguvx3iqDs8ZmvGyo7Kct8NdjBLKxxcFX01SNfEvhLytTiaKnSG4ZsDVImD6BJmoxxh2NbDPZs7pEasxnhk/rRh44NTsaNTfJxi+yAmsk+D2m/Wju5WjAWECgEKm+WcQxw0IxI79txc+A28nvY8vP0fheVe+sDYv2Ruqxpho3PejNX/uzUQk0uFHggsziocHIf3cPiE3ca4GfhFMHn1DA70KbQezEwuLdnlY37PuhMuAJ2BU0CLVSSNAP6Y7Jr22g2WH22vLaxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEhZb1JtOWhCNzdZdXh3aktIZ3VmZnVDWWszTGYzUTJMa2x5U3dkdVl4U2E5?=
 =?utf-8?B?Tkk5WVZrMzk2dC93ZXY1Z3JrV3ZGUkxwK2hkK0JjMXdLeGt2cDZhd3F5TGJP?=
 =?utf-8?B?aDRjRVdLeFZ0NW85dXFrb2d2Y0l3MDAybXRFbS9uVDUyWkVSc3FyRGYza3pR?=
 =?utf-8?B?Z0xUNUtFU0ZESWZQLzdpNmdHd0loTWtOTXR1SW9pdi9hYzRsWStTWkxYdjZo?=
 =?utf-8?B?MFp3Qzl3cUdOVXIrc0Q0bWtobit3M3VHR0R1cDBLQjdWNjdiNmR4dUlSQ3Y1?=
 =?utf-8?B?akRuVmYrRUg4UlBvNHBXUzI2U0o0UENMZWpkK2FGZWZ1cjBzZGovSXNMMnhn?=
 =?utf-8?B?elVoc244NHVkSmNiTnVYUTVSdSsrQm94WDhrcDAzQ0V4OXc1VW5KV0tFeGZt?=
 =?utf-8?B?d0plM0JyUjJQdGVnckZtd3JGMjh1S1ZtdS9OYkdzNTNGLzUzUTZMMGZpbStv?=
 =?utf-8?B?T1l6TitaZC9zQjNxNkdGMGNyR3VWb3RZMHM5eVVUN2NhYjJLVFQ1TzZuSWVB?=
 =?utf-8?B?WHpTUk5najk2dzFXdHFpQndIS1hxNGUxZ2JyQXV6V0grR0dJNmhpL3VVVWxK?=
 =?utf-8?B?enIyMjhKNEFHUEkxZ2FmdVpaUmJPRTd2MXgvQVZ2SXgycWY4dDFyR08rbVNJ?=
 =?utf-8?B?UXUrbG9pNlZiRUc3TmF0YUpOQU42U1dKVGxJcFBUMnVsdXRqUEtraDRNbmdn?=
 =?utf-8?B?b0xrdlFxbWM4UWVNemZCdjZ6WmNYOXB6ZjV4TmRaYlMyTVVKNkVuV2tIMEpp?=
 =?utf-8?B?dWxzaWpZVW5rRFl4TEJ0YlBoelJWZTV5QTViK1JFdktLenc1RDZMRHhlKzJz?=
 =?utf-8?B?eHBxMmJqb284NUgrRXk3dnZ0VzB2UTQyUnNQWkJhUFcxU214c3VXNFdDSFR1?=
 =?utf-8?B?QTVaQnd6NUp4aVF0YzBySUh3MnN6eDgrUTFHdkhuU2JKck5jY0JiSlowclBR?=
 =?utf-8?B?aHQ2OTdaeEQyMnByVlY4cnN6MUE5VThDWFVHWDJWSmp3SnJab2w4SlRleEto?=
 =?utf-8?B?SDRUdUdwejE3Y2NHOW9lZS9IclhOQmJwQlNiaDVOQVNNV1dOd3h1N0tlQzYr?=
 =?utf-8?B?bkd2NGc5SW5xNlRETHk0dTNjQ0hJbW42ZmZYbjZZblVta0l2ZlZOVjlSdzA3?=
 =?utf-8?B?N2lpYndGcVNyREJYQjFmVzRqY1BIYTFOaHVTUXNEWGpTLzdwYVBaZDN1Sllp?=
 =?utf-8?B?YkhveVZPVm4wWEVvbExBT0x5R21uTnFZU3E0TkE4YUF3QkUxRjJwcUxOc09S?=
 =?utf-8?B?OFFOb0JYNDVoT0NLOEtnUFJ1N0VtOHUrUDlTZzJOL08xdVQ3VWdTNENQSzJN?=
 =?utf-8?B?dmFUcWwxRmpKbnI5dlFWSThLc1RmSVpUQ1V6Q2tldXVhK1RGU2NyVHB6eGhF?=
 =?utf-8?B?aG9RbndFMDhxS1UySEpPTWhMcTJWUEJOSC90TzErQzJzYk9jaFZON1lvaUto?=
 =?utf-8?B?dTFReVU2N2RYVTRkWUh1UTd3Z3RadlhsUmc5cERKQnQ0N29QSlhzSVN0TkNY?=
 =?utf-8?B?Z3ZPU0g2V0xuNUh4TDVhQ1drbkFjV3Rvb0pnYjhuOGVJdTdTd01VdnVjUkRE?=
 =?utf-8?B?Z1U2VDg2N1h5MWF2QlE2cHBNR1hWc3FCcmgwUk13TG1QMUZqU3F1N0JSYWlm?=
 =?utf-8?B?U2pld2xQeCs1RGQ4Z0JHRklaQjBYbVlYR0Q1MXY0MlBGb3JoMzlVUkttZC92?=
 =?utf-8?B?TjhIZ0VyV3ExSFl4NDlNVXJDTG0rRFBHeFJVVHlsU1B3ZlZSYVFsNzhtNzF4?=
 =?utf-8?B?SG5vc3IvYlh3Y1R4WW9hTlhRYUpRQlBxcFoxaFZ1N2MwaVl4MlNQOXA4U3Uv?=
 =?utf-8?B?aTRnN2E4dndlaHVHKzYzRmIrYlZBQTYrS3ZrRmhsdFdPYThnV2JRQjR2VGp0?=
 =?utf-8?B?VjNRQzN2dDhNQzM1N2NVR3JSZTFnUXFiZVhJelBoSnVEbCt1Vk5MMUdCblZT?=
 =?utf-8?B?TGtGc2R1YUxHWW13bFBKV0ZpQ1pHa3BJVUZ5VHE3ZzZhYVd1WnNRYkxlNkI1?=
 =?utf-8?B?ckRJeitubWJDa2FlNjYwMS9tYXE0Lzd6N1dlWmE1NnFLMmVWQkI0MVJwdDlT?=
 =?utf-8?B?N1B5NWwvSERPNW9tdnU3Z0RDVkdPMUk4VkZ0OGtrMkt5RkxIS1ZOd2dpclZr?=
 =?utf-8?B?bGRpT09ubmNmUnYrQ0k4M3c4WllGakhYOEl6QjZxcDJHYjgrMXpRZ2hkYVdu?=
 =?utf-8?B?dEF5d0FDNEhnU2NNckF3N2hUT1Q4YXVldzd3aUY3dmV6dVBlK2pJY3ptc2Zy?=
 =?utf-8?B?Ynd2RlNZK2NBdTZPc3A2bTRtOGx3bGN6M2daZ1ZkK092dktoT0VPaTNvUjVY?=
 =?utf-8?Q?ImEJqSCEY7lZGXu7PN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f60f7c-bfb8-4c61-aadc-08dec32fb913
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:24:47.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgAXjvQv3VeM7NS3WPiPxWPnZNYPrwIGKoWoah5rxuZoRPR8IhWb4wtuqyzdXRYpQ7Tj8nstWV1vopuQREQU+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9101



On 6/5/26 05:26, Marco Scardovi wrote:
> At CPU initialization, the private cpudata structure is allocated via
> kzalloc, which means cpudata->cppc_req_cached is initialized to 0. This
> makes the default cached EPP value 0 (AMD_CPPC_EPP_PERFORMANCE).
> 
> When initializing a system that defaults to performance EPP, the driver
> attempts to configure the EPP via amd_pstate_set_epp(). Because the
> requested EPP (0) matches the uninitialized cached value (0), the cache
> guard check triggers, and the driver skips writing to the hardware.
> 
> On shared memory systems, the EPP write via cppc_set_epp_perf() is also
> responsible for toggling on the autonomous selection register (auto_sel).
> Skipping the EPP write consequently skips enabling auto_sel, leaving the
> CPU in non-autonomous mode. This prevents the hardware from boosting and
> leaves the CPU frequency stuck at the lowest non-linear frequency (1.7GHz).
> 
> Fix this by:
> 1. Cache the firmware programmed default EPP value in cppc_req_cached
>     during CPU EPP initialization.
> 2. Explicitly toggle the AUTO_SEL_ENABLE register to 1 during EPP CPU
>     initialization for shared memory systems, independent of whether the EPP
>     write is skipped due to a cache match.
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221473
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Marco Scardovi <scardracs@disroot.org>
> ---
>   drivers/cpufreq/amd-pstate.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 8d55e2be825b..8e0099eba512 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1877,6 +1877,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata;
>   	union perf_cached perf;
>   	struct device *dev;
> +	s16 default_epp;

Reviewing this code I realize we have a problem with the return types.

Both possible functions return u8:

static u8 msr_get_epp(struct amd_cpudata *cpudata)
static u8 shmem_get_epp(struct amd_cpudata *cpudata)

The static call returns s16:
static inline s16 amd_pstate_get_epp(struct amd_cpudata *cpudata)

But then both shmem_get_epp and msr_get_epp can return negative integers 
on failure.

So the return type for all of them should be changed to be an integer to 
support this change.

Als othe variable used in amd_pstate_epp_cpu_init needs to be an integer 
too.

>   	int ret;
>   
>   	/*
> @@ -1926,6 +1927,27 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   
>   	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
>   
> +	/* Cache the firmware programmed EPP */
> +	default_epp = amd_pstate_get_epp(cpudata);
> +	if (default_epp < 0) {
> +		ret = default_epp;
> +		goto free_cpudata1;
> +	}
> +	FIELD_MODIFY(AMD_CPPC_EPP_PERF_MASK, &cpudata->cppc_req_cached, default_epp);
> +
> +	/*
> +	 * Shared memory based systems may require the AUTO_SEL_ENABLE register
> +	 * to be toggled on to function correctly. Since the first call to
> +	 * amd_pstate_set_epp() may bail out early if the desired EPP is
> +	 * same as the one configured by the firmware, attempt to toggle the
> +	 * AUTO_SEL_ENABLE here, independent of EPP programming.
> +	 */
> +	if (!cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +		ret = cppc_set_auto_sel(policy->cpu, 1);
> +		if (ret)
> +			pr_warn("failed to enable auto_sel for cpu %d: %d\n", policy->cpu, ret);
> +	}

This doesn't really make sense to me.  I think it's actually pointing to 
a logic error in shmem_init_perf().

I think you can just drop the call to bail in active mode and get the 
same result.

> +
>   	/*
>   	 * Set the policy to provide a valid fallback value in case
>   	 * the default cpufreq governor is neither powersave nor performance.
> @@ -1933,7 +1955,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   	if (amd_pstate_acpi_pm_profile_server() ||
>   	    amd_pstate_acpi_pm_profile_undefined()) {
>   		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
> -		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
> +		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
>   		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
>   	} else {
>   		policy->policy = CPUFREQ_POLICY_POWERSAVE;

