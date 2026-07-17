Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011042.outbound.protection.outlook.com [52.101.57.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8D379EFE;
	Fri, 17 Jul 2026 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784262190; cv=fail; b=VUTUUHHPWZ33+/cWpur5vIWqgHKJYazqRH9fVjAL2SzXW2ka658c00xep3l9V+Kon2ZX6c8HPGpoQvI0ZChd3SUxX6GKp8Tjmtmai/1gfixgiiqIm5Ekwuzhfegq3SQ6vtAeg0z/cWj8KSWvdau3SYC0RiOkXSOmQ7b2PTfqmdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784262190; c=relaxed/simple;
	bh=cXhacMlXDRPZYiHWtXpQVc/1xxtc95A30ksO6ju0NiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DoeVf/jLWTSYsHJfm/2ha0clYjXgihNmXrO4BQag0ZSsBdH9CDtoUS0BZnVB+2d8PJmaJJbClo0gPI3cXC3tuD3HnkjK6b8JeYWucTDNelzFfQFEKy5dckAut83xbwlnUQgEQ6fzgR9wTkFdSABqbTh1bi3R0T0f1P8tSWYmFpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=01xUz40l; arc=fail smtp.client-ip=52.101.57.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="01xUz40l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lj7XeAKfUBOTK5XNBUQhlon80DdCxtqUjqSiApcD26OAZC+5jPJAFz3K1CsnDZOZ3kFg8KW6mLUiF9W7qd2u+lUUDB1qKwngTU5JphXDeeHFoCxIGDwd3EQChHhF5k7r6k8n2pAPmklw9lixbT1Q8d9WwcCZptTbk2vxIK6M2pHLaLL+HRJwfTWsn54IqHcKeI5YYY6A4icMX2ljNgfiJwTVIneEJzeMc8PadB8l595a2oxDF10p55yc6/rxEcou1rhgHQ5FhfTLTsEmBn26oJu56m/EKP9cdTU4gWNDt/qsHGBhf0AqqSZUV4mWeEZboYgaQzy6+/Ax1YZ9WZILwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO7ZDDUM5X5zzEzFPjcTMxPLqW6elab9Q9p242tzvg0=;
 b=a4O4DbYMeA47pZ+nAlSLISHt0FaUFW7jbFhW1dYMlrbTiI0jNhWughGeJuCMONqAg7Wt6jX1FCcz1hnXmWPgllNMbmoaNtleNaAYadPkegTFG1QgTBUKELKS5haA2CV2+G3xQsYt3q1xSOEuh6X9gpHrH3jlnp9KlHQWnhpTIP6Jsz9nl9E/NO9B+99s4E9bnWqWjM1YD0HdPpMYZj+UvBTNsq61+AmB9U/b3N08XYqcEeh9xt2EK/u4BVYQrAak6KleEPKgXzcrrnTZlTefM7dKE4mzQGn6RYbhh63DpYbeNKnf7GQhQUO2hlo7rgtfbZYEhJX3kyrOJuTYyYoQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO7ZDDUM5X5zzEzFPjcTMxPLqW6elab9Q9p242tzvg0=;
 b=01xUz40lffp9V1mvSHLX5idDlwbYsegCakOOW4g0+RCDmS52Ueh0NgYYyPw/f2Aj4Xmw7BRRL+BNF2ZNj2N7cPWku+1I0glUHB7Y3nximb2ier0b+QYxlYoddrUP09rt5I6LrcpeaBYKemLQeDLayJ3nxsUWHKdAiiPFQs3zuAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 04:23:01 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 04:23:01 +0000
Message-ID: <d105d9ea-32eb-4bf2-8c32-88ae5e5b315c@amd.com>
Date: Thu, 16 Jul 2026 23:22:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] cpufreq/amd-pstate: Fixes for "Requested CPU Min
 frequency" support
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260715074822.16324-1-kprateek.nayak@amd.com>
 <63b26408-d75b-4de9-b3f2-eed5687a8b09@amd.com>
 <fdb525fc-bb52-430b-aa25-bf56f05db9d5@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fdb525fc-bb52-430b-aa25-bf56f05db9d5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR04CA0057.namprd04.prod.outlook.com
 (2603:10b6:408:d4::31) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 6202872d-48b1-494a-3964-08dee3bb16a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2hGRFa6ljwdpXDPEitIdly31IfXQAHGfb+XmKbpVLcgvW90SnVzd80r1NNeJ1osLYutLwMUUYXf95eP0JOakrdKvOO+4cqadP7hMwOh4OBvLxfFW9M91NfpcEqQxxOMf6yNFM5KHJsfzJ7MrJFnLHcf4S159vdJP3Ek2oz1HIJ8/+pfPhSyZ4J/uQOGGI8k79SDpHEjMOBmQQ4F6D9PxIHGZqMUPwLs+UXZUNKW6DI4W6H58/pivZWe8O5GP48teIIGcCAAvJ7k3+9DxmV0Bn8b2mtiJicuLptOZNp0ec15Xf81RnTQCOucG3yo9XJyEJAyGp9k4B0nHoe9n31Wwkkf4SG4/t+tUSuRKWrgMDPiP5fDrxD4DifF+EeWoSKOyvkumk5AwMLl+3iN7Md9TDzF0NdxaicGByN5OzjPSH0+5TiNkC1jLq6ljihZhq2F+hW4mtgqaXLdIfoh7JzGvbTb3ZBquWi3utpuA7FZPjE+Sw1JDwGg+9wQUVbEOGMu0ozrDKKtzkCI68slLL0kEQ2SNVqvvU1b89dDRT+RHtQEhf7lrE0P+DiUG7A8uviFqD5cEo0R05mMpX20lHBdiH+wUBISZgLwGXEVAP0+QH+530vfuxYWvt+daG50yI6obCSIZwwbVw6MeeEBWtNpHsZS6csc8EnMMBDox4pgcDkU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXVYY0FadGJnMUVCK3p0S09mUlNWMnU2bHNrL1pST0xzZGpWdjJVOTVyMmhx?=
 =?utf-8?B?K1FSNitod1lyNnVMcU50cG9MdG1EWWFkMHhPTFFiVXVaMm0xU1BPdHRHSWFS?=
 =?utf-8?B?NTFrYW1GM29DMlMzSkhSdmNVakJoODhleGt5L1BNeXN6bVE4TlJ2Rk42Z05y?=
 =?utf-8?B?WlUzdVVzMkVob1BUZFNicysvWUI4cFlGYkF2M3g4aytmbnk1WTkybnVhU1Zm?=
 =?utf-8?B?TnZ3c3VjRHhkQTdmc2IxVDJuTDI2WkY1dm1OSmlMS2doSE8ySHplSU5nRVVi?=
 =?utf-8?B?RFlSSHFSakF4dEw3KzJiWlB3SUQrTGlBQ3JaRHVtblNGUzJvKzZ0c2orOVov?=
 =?utf-8?B?RDdOZlM2ajJ1dTlDcWNpZkNJWHJocHNRTjRFQW1reWpib21peEFheFUvWnd4?=
 =?utf-8?B?cEUxa01vVjc1dmN0MTRMTGIyNVp0Y0JyclhySkVLbVEyZEFzSDVJaUszNGc1?=
 =?utf-8?B?Y2RGZmZqc2ozTUlYZ29TRUtieEI0ZTB1cnZUc3BVU05hS0JRcjNoK3BIUCs2?=
 =?utf-8?B?Tko0OVdybTkzTERXc2V5RTBNZHB0WDlPNHRGbVNGcHZLU2pIdHBYZXE1bDk5?=
 =?utf-8?B?eFZZTytwdjVvWUpNYjNPMWZsTHo2Z1lvN1JPNDJxMm9iVjdkWkQ1amI0OGxv?=
 =?utf-8?B?N05GT0lPcFN2VEFLZzlSd2haMU00L3lIZGpHVVIxdWFHYVhYQVpKdW0xb2gy?=
 =?utf-8?B?ZjRPa1hjempzRmRyekhFeWo2cGk2dS90cDRGTDYyN2NyamFmSDRTaE5XN0Na?=
 =?utf-8?B?clBSQkd0US9oNzFkK1pjaGh1U0dPZTVDK2dXaW1ZQnZIQWcyVTZXK1poTzZ4?=
 =?utf-8?B?ME9kTzErbzdyaTJ1cmxDK2FLNU5tRXNiTGw3bnpFbnNXQnpUSlFCam1Fai83?=
 =?utf-8?B?Q3JBTEJaaVlBeG01SUF1TEdiOU1rNWhWbXFBak9ncU9kKzhERmhGakl6Y0dL?=
 =?utf-8?B?aFdFUXhHa1NLMTU5RzFGZ3pWSjIrMSs2YUFXNDI0c0ZYTzcvWUNwVHVwaXNw?=
 =?utf-8?B?N2k3TFhWeU9lc2pDT0x2RVczcVcyd09uUTNQYXBlMTNwMUpvUHZWa2FXYjRZ?=
 =?utf-8?B?RTlpc3htbnFjaks0RnFxSU14WjhBVVVZT0djWUtUZDU5OHREWjdCNWtXWkxP?=
 =?utf-8?B?K25iVVVJRDNXMk5rNzhHQTJmRjQzeisrYlFBQWsrVWl4Y1czbE1oOE51K3hP?=
 =?utf-8?B?bzA5ZHpIL2lkQk1WS1dUYnBoUDkwY1dnZ2lrb1hjSzRsc3NVTGY3WWxSRmRJ?=
 =?utf-8?B?YWF6S3NQcVNhZlhDeGJIcWZmTGxoMEtOWFBDQ1RETml2blFaWkxxSUhZczMz?=
 =?utf-8?B?TDJqalY4U0pYZ3VjMjVGQU5kc3liVi9GZy81bTFQY0xYOHh2S01UWmdGdFRC?=
 =?utf-8?B?T1hMalYzclVGb1hmMWZmQzFyc1pOM0lBYzh4T3BPRnRkc3dwRyswK2tkNjZq?=
 =?utf-8?B?ZUJqMGJwdHNCM1NTeXluNU51TFh5YW5hem5USmtBTkVGem95dkRpMGxGeE16?=
 =?utf-8?B?T0ptOXpNMFRFV3FFcWlzM3kwZGJReEVIMDlvb1FXZURkaGxFbU53cXY4Zi9H?=
 =?utf-8?B?ZjdQYkVaODJWT0orUzEvTDdrV0d5eXJ3YXg3VXJDeUF0emc5OHczRTNGWStS?=
 =?utf-8?B?Nlg2MlNsTFdwRjlTQTd5R3NmV1pRY0oxYjhpZjZrS2wyMzQwVVB4U3dYaUFC?=
 =?utf-8?B?cnN6REtmaWFiWkUyRGFCclptMUovMERheEFWQzVuWExiYXVqSnhad0Q1YlFM?=
 =?utf-8?B?TEw2bGprSnBnUEJOc2drVmsxN2t1VDRNdkJLNkxab1VoY3VtRlFKNmorQVpr?=
 =?utf-8?B?USsvVVorTCthZWhSMlgxaEhyd08rbXVwNitzaUtTSEZPcjJFMnVTdE45Mmd6?=
 =?utf-8?B?OXRRay90UlU2Z1lWUHJVbjIrdTZHNVVKRDBvY1NyL2FpQUlSSFVyb0ZGUnFz?=
 =?utf-8?B?aVhnWmhBZXA1NUIzbXdIS3BjUUhsUzdESERqK2pDUmlCbkZIODQxTkJ6azV0?=
 =?utf-8?B?a0FGYytBVFMxbkpKcjYwVWp3Q0NnMDBRTVdmZWI2QjlTVzRraDZSL1UwRVhW?=
 =?utf-8?B?eENPM3YyR2FaQ1hMQmpPWEZ5M1FzZzdWNDRHTEpmWUF0UmFxR3o3eHRxVzdX?=
 =?utf-8?B?RDViZURVbCtoYTZFeGd0Z2sreUdSREFkNlBaRHhxNWpTRWJrU2czV3VXa1Rw?=
 =?utf-8?B?RXBmbndhRytrMDcyL1EvTFZwaFl1U045K2xCbDVtL1QrQURaQjFuaFF0bE1i?=
 =?utf-8?B?UXBYNVhaVS9aMXhYMWVxbmNmcDZJaXJueFFCUEdhcm8zd0VEM1M4N2JwNG9R?=
 =?utf-8?B?NHg1ZERXcThtSjNuNFRMSmIyTUlmbVl3d29OUjVWRlR2cDh1RDc2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6202872d-48b1-494a-3964-08dee3bb16a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 04:23:01.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXtyEESP4CLpns7FayW2QauKa4ly2TKqub9VHmMBgy9OPgw3l/4PSQmY8t/rS8/Eh4AknzfRklQTsy10qJUJug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962



On 7/16/26 21:54, K Prateek Nayak wrote:
> Hello Mario,
> 
> Thank you for reviewing the series.
> 
> On 7/17/2026 1:20 AM, Mario Limonciello wrote:
>>
>>
>> On 7/15/26 02:48, K Prateek Nayak wrote:
>>> It was noted during internal testing that amd-pstate active mode with
>>> performance governor always sets the min_perf to nominal_perf despite
>>> BIOS having supplied bios_min_perf as the preferred idling perf.
>>>
>>> Users who set the "Requested CPU Min frequency" from BIOS are known to
>>> have profiled their workload at different operating frequency to know
>>> the best configuration and amd-pstate should use the same as the lower
>>> limit when configured.
>>>
>>> While testing the fix for above, it was noted that kexec fails to
>>> persist bios_min_freq even when both, the old and new kernel are aware
>>> of bios_min_perf.
>>>
>>> The suspend, offlining paths switched to persisting the CPPC_REQ MSR
>>> state at the time of suspend / offlining with only min_perf being reset
>>> to bios_min_perf.
>>>
>>> msr_init() path only accepts the configured min_perf as bios_min_perf
>>> when it finds rest of the bits in CPPC_REQ MSR to be 0. This is
>>> intentional to prevent stale value of last CPPC_REQ from kernels that
>>> are not aware of bios_min_perf to be mistakenly interpreted as the
>>> bios_min_perf during kexec boot.
>>
>> Is it a real valid case we need to worry about for someone kexec'ing between kernels that are aware of this vs not aware of it?
> 
> Since there are defensive measure in place I thought it might have
> been a concern but as you said, I doubt anyone is running one of
> those flavors and kexecing back and forth that often.
> 
> 
>> During kernel development; sure this might happen.  But I would think once this is available in mainline any of the distro kernels will have picked this up and people will start with a distro kernel with support, or they'll start with a distro kernel without and upgrade to one with.
>>
>> I can't imagine a case people will go the other way.
> 
> Ack! So I'm thinking of changing Patch 2 to:
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 27cfacd283be..707e1485eb1c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -462,7 +462,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   {
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   	u64 cap1, numerator, cppc_req;
> -	u8 min_perf;
>   
>   	int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
>   				     &cap1);
> @@ -478,16 +477,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   		return ret;
>   
>   	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
> -	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
> -
> -	/*
> -	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
> -	 * indication that the min_perf value is the one specified through the BIOS option
> -	 */
> -	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
> -
> -	if (!cppc_req)
> -		perf.bios_min_perf = min_perf;
>   
>   	perf.highest_perf = numerator;
>   	perf.max_limit_perf = numerator;
> @@ -495,6 +484,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
>   	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
>   	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
>   	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
> +	perf.bios_min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
>   	WRITE_ONCE(cpudata->perf, perf);
>   	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
>   	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
> @@ -1046,6 +1036,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>   		return -EINVAL;
>   	}
>   
> +	if (perf.bios_min_perf) {
> +		u32 bios_min_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.bios_min_perf);
> +
> +		pr_debug("Found Requested CPU Min Frequency of %u on CPU%d\n",
> +			 bios_min_freq, cpudata->cpu);
> +	}
> +
>   	return 0;
>   }
>   
> ---
> 
> It gets rid of that defensive check and leaves enough breadcrumbs to
> debug any issues that might arise during a kexec. Thoughts?
> 

That looks better to me, yes.

