Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F27481AB8;
	Mon, 18 May 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113747; cv=fail; b=pnb+1MCXtcwkXTCWAZqi/UDftvGWoAjgzg5llZcwI88b4P/lOB9Ent01GEGXnOAcQr/MBd6Bp4erw9owuyQW98OaohPElobRDMUwOnCy+H5XJeXeqNltzgwNDTlt/pdQCxtmwG4vmgkLqFEQMTn985bCBbK7j16Udf34QIZ2PmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113747; c=relaxed/simple;
	bh=MGMfsBNOvM23R8tZupevn+SebAa4kA9mGypE+5agXbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ewwWnb+GlQ1O17Ti5Fgmn8Jk/moTGtjaqql3eBIFEchmaPrxWjsnocAlvVql+D4uRCzyysJSEdJKR+JRJ2weJM0qNmCQHphQ57E3d77UtKlOfskGSP905FMACoYKyJZJbas/I3+J0NS0zZ+k6x2lF9+dOtvHc8dscyTzbxlZa8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d5P61gEw; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d5P61gEw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuBo9NfVgKumhv6Rh1fOwQFkvTOtDcoR//8/ldCtbbEkDM9WPtV9dCD/YQvjoelLxfyZZR94e/NwdyZFN1w/EvZ35iha3fNIySeYozIYwcI2aUufHJSTuAmZ6hUsbHRH8Cc/Vg38gm4t01Zx6UMwtO29tBjaDNVjc4bhaLByMk+sLMie74/Kn7kUjpxYTS2X+yJeHCM+GOMmrKtET6akNqBDiOleg/Nl/39FFUWGcWzmsnQ+q371jUOwlX0BB3MlfvdlnKoEIRiRSipQ0MxILO2YeonSUqJpyaoO26wk2LKz0s2PpS5DsUJ65IHsTqQDyajTb7lucbcsRszaSI0Mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C2SgUB/UhppwC8k47Lf1TQECFUUL5gSuZIdw/r3fHI=;
 b=ivOsCbfXUplQVehbctz+T1KZ2EordVGpoqB1EXAKYw3X1zzxcOfu3Fku54AVZwmaCxECb/hrBmE8R2h5Wy2bvjlad0CKrh9XTtu/qf2jrqIZnjC5dHbJNLat7SGjMucrSg1n/GETSh/QYRLGbHijif09woFnK20sSX46O2hofjmeYUTOZ7XH9nNKu1XNL1FTvNR9GGsTtP2tUkGfWcAoAlWzqZHLJQm1pDgaquWXs0L7NaQSQU39bgs1Xr5xO3w1UusqWiDhkLTO9SXHC0WE+KbFWZxAZNA5C4lCHY44e2E0O18Z5ha3uvET9Mrm8aUc/6Cb+Gb8+O4KWYwN7vuZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C2SgUB/UhppwC8k47Lf1TQECFUUL5gSuZIdw/r3fHI=;
 b=d5P61gEwo0qtMD1I/5Zr2i60xmJ/StlR6s7nsoNiTZXWvaZalTxlEuEeLZtERZ+8xqnKl3Zk/6syyhqLQGKka1rD8ufT7+7nvX7gVoNWFHYfJLStNglZ6Q6/ExnoHdS5rpqejqiJmRXk5PucFnZxdh1Oya5ld8fSF/9uG1Ov5lZV+dN9/0p6aQdvIxgP9L9ynX2rPlYL9NcioOjTfxFIteQiW3dHApn48ADf+61UV4Wc5Ht+VFirG3OZlZYS7E0yPcDAjcLXuZSco5q2wkrPufDWISZeON7ZcTo9xjAB4qnvCXsMWW9VM2J0SIU+1VdTLe3TzmQTWQNvy8fJ7Ko0yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:15:33 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:15:33 +0000
Message-ID: <e1a546f2-6e7e-4236-97bb-f72bea0137f7@nvidia.com>
Date: Mon, 18 May 2026 19:45:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260515122624.1920637-1-sumitg@nvidia.com>
 <20260515122624.1920637-3-sumitg@nvidia.com>
 <bf521e4e-1aa5-49ce-bec5-52845f02214e@amd.com>
 <139d2f0e-72d9-4721-9d5a-d1d4a2a95fa1@nvidia.com>
 <72fd2fcc-6303-4980-beb7-e4b711ad6406@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <72fd2fcc-6303-4980-beb7-e4b711ad6406@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0096.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH0PR12MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 56787747-ce18-419f-e891-08deb4e7ec7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|3023799003|11063799003|4143699003|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	zQgXaQRbkt1razk9PAvTHg0j6GKl/PzxewSlw6SzTwZ+367RPOK3gAtnOz1bYZfvK6+80BmowDHmuqBq9M80cBHWj5kXZIEPe1IDIsK8bXmlgXOUs7nrCUnIg4kkoAKuwXh/JlyQxg0YWDXFhfXwQbqtR8DHwkihmi29BS5pwno8lrt6CMJ/0+XJ/9Ze8oznpfwSPUMWNt8oMxr6QqtnHolA2kxJhoEZqyq5iVjibSlHqZldlXhaaI3HHCBeEon7AWm8lZ3MSGhixUQPPDRoin28IgKLTtVm5jkgTKrP7k5cAIxVMpgpRm5LxuYwNxpTarCan9o77BrOuFr6r9gTQidiqceRlCF6nOBPlibh7kCc3ZGoyKoAiRzFHs1bshVyzkUQpSSR3q1kldutd0QTYwBRFYgTzwceVEqCA/nDVYCXpavo18qjtTvLxSrQTkkC0NBofe3CmmJ33SwUKLo/9T+MsRYA3nllCnEDyYE0SKkYmvxYM3QCtrxoBXvtcr8dp0qaEc8jE2HHeYBH6uFE3saB9VgA+Rfc/RIf3vY7RIjMI+x1ewf4NhrzFC2YgAiE9O1xXXGKmf41kPdmZyfIuO6dkMZOJq2dcQ9yFRG0mMEbe9O6SfiDQLc9vi1oZr/08VzvolGw/HNEhH0F4Zt1BuupAoXI/m5czzbQcv7/iHVmk0BuGulH0XK7IWYwY5TJ9pJlBsVpiQ2FIc8H/90MzDj3w9/zk7TafkVdlQhR2j67oZOq2aeeHQ2B4xZ69w9B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799003)(11063799003)(4143699003)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGJzbm1iSnZsNW1vZXg1UW9YSi9VNHorcVI0OUdYZ2EvbXo4TnhhUVpXYXZJ?=
 =?utf-8?B?UGhHM1FjYUlUQVRxZ3ZQcmdvM0ZhdlBRWmRWQmsvZkpnTzA5M2xCOWRZUkJV?=
 =?utf-8?B?RnZWcUhaVkdSeGg3RHRHc0tYSWVqSVJyeDRiZXJjRGxRb1I4SFVtQjV2UUtC?=
 =?utf-8?B?ZFBteEV5eU8wZ1ZhUU5ROUxINExCdkRnMWE4OGM5Y0JzeFRVUlJseXZNQm9q?=
 =?utf-8?B?RkREUGV2cGE2ZkdrdjEzR2p2dUFadU9jMnZCYjFXRWNHK0p2aG5QQUwwdk52?=
 =?utf-8?B?UmZ3VjZtYzZGeVo2ZjNHdEJLcmRpOVZ4YmdHcG9TUEN6L2hBL1BzV3FEbmFG?=
 =?utf-8?B?R1c4UDAzNEhyeDRrWWtpemhpamVWNEp0WjUxN1E5RkpkZE5ZWjEraWlnanRq?=
 =?utf-8?B?a1hoaGlVMUJPZHVDbmcxWGJHZGpCUVE2U1cxWElKS210djYyUEwyTnVxd1ds?=
 =?utf-8?B?am4wUm4wd2EyMExVeklRMkxNZHBQbkVraHp6aFUwbW9EeFFGcHdiKzdlMGdX?=
 =?utf-8?B?UlQyY3JrRk5CdWRORmpHT0tVUmd5UUhsMFVHZGVSdjRGNHFSNzRDYXA4ZW1Q?=
 =?utf-8?B?eTI0SGh6NERRNTRJbmFTWlZ1d0tpT2JsWHY3c0dtbWlJZ1dIaHFiOVptbUJ0?=
 =?utf-8?B?MitmaU5Bc2VxT0VMUFdPcVJmMDRRRVZkOU8zQ3NDMHhNNjRDdDRtOUwwNGJU?=
 =?utf-8?B?cU1pUmhOWk9RZVNjcHJkVTgxdUdkWnp3Tm56cmdxRHNxdE1NTlF2RFR6citM?=
 =?utf-8?B?d1lmbGd6dko4VGNhWmVQMURxYlBNcVBqSEo0anA1VmlCNW4zdXJYN3Zvc1d1?=
 =?utf-8?B?Y1dLZWk0ZWpYYUFCdk54djh5TytUaENERjdXU3h2ZWlEdnB3VWk1enNDTEV3?=
 =?utf-8?B?ZFpUcUZkbDhHdjRPbGxFQlJKbXRINVRZUW02Tmg5WjhXRXl1S3RXaFF1WEVC?=
 =?utf-8?B?UHpTU2VVQ1hGMThuSTBUdzlUMysrRkxSMUFERVBJY0hwajJTa004WlBEZXFq?=
 =?utf-8?B?ekVIcDhmWm4vYXc0STNHUDhTTzhPSS9pOHlGNXRqM0JIQ2FockhZYlRqOGJV?=
 =?utf-8?B?UkllYXRoQ2FYbUJoQUJiSkFPd3AwalN3NmdGMXoyTi93MUtGQlRvbVNoM2lL?=
 =?utf-8?B?Q2cxZzZGNUVpYUd3VUVXaHRWc0lIS200QkdDbWVFRUZDUmxUOWNuTmVubHZ4?=
 =?utf-8?B?bysxMDhBVHllNGd5LzBGV0p5bkxxQkEzb1F6dGZIMTFJY3BWd2ZaVmlzOWd0?=
 =?utf-8?B?akI0RWR2OWRQMlppc2lqRDFvMTN6WUdwL1NFUmJCcGVZaFRtbVRPZlh3NW5G?=
 =?utf-8?B?Vm45K0czaUw0WUZYMDNFUStaam9DbmFUMGRBdWhJTXArdVpIaG1TYTdENmdT?=
 =?utf-8?B?OFlhNFh3US9NTEVhUWFtb2JhOTE0L0lZR0pBa0Z4bndQVVZWcVZOeE1JbE1B?=
 =?utf-8?B?aHF5MUVBNjhIRWVRVTlEWGk0c05WZTkrc1Z5YkM4Nm9yb0ZUYld1YW5wT2FR?=
 =?utf-8?B?d3loVi9oRFZQR2tKYndjWWtiS1BqN1JQYXlnejVCZHpxK0E0THhjU0xDM3BN?=
 =?utf-8?B?aVJuTkxQbWhxWWljZXJOU1pzUDBzaVZHUXp0dUhGaXg0N1ZPL3g4cW45dlBr?=
 =?utf-8?B?RlgxblZ3T3RuQkJ5Zk1mbkJOUFp2WTd6OE56U0N4OFFhWmFWelFjWGNSbGgr?=
 =?utf-8?B?cnlsSUF4UzVCc05JeDNFejZwRzJOaE4xbVNpMGQ5RmhHTE45N0RTSXE2czVo?=
 =?utf-8?B?ellPZy96dVhwalZ6S2E3U25GQkU4Z1hlcUdJUno3eHQvUEdIK05WVStRVFBn?=
 =?utf-8?B?dFFBV3BMZU5NMXNXVDJvZnBmZWJ0clZONXdjbEJFREM2TVordjBBMHZNV0Na?=
 =?utf-8?B?SkN4am5aenhKRS9mb1hBL3BkbTlNZ1Z3VEpBaEM1NEgya2NyOElhR0JuZ0tU?=
 =?utf-8?B?a3hCOXpiekg0NmswTUNERE9RS0FacDk0dUtEdWxQU3ZteFprbzhldXExWjRT?=
 =?utf-8?B?MG9oMDZ6WXNFbnhna3g3MnlPRy9kcEdUYnN0SnpSZzBjTTVHVWxyUzd0dkpp?=
 =?utf-8?B?emhydUh5MVNIYmJ5ZEh1UjYzYVpGZ3NGMHVxaTl2d3IySHJlSFJnWkM3ODJW?=
 =?utf-8?B?QkVNdW5HZFg2RjlIbk91WUxMMG5wanFYZVpCdEFtN2dSOHRwb0NFblJkbXZa?=
 =?utf-8?B?aVZCOTlXVDdUYTloby9sajFXelRad1RyWVhCNnVCaFprSUxqRUQyQVlvdlQz?=
 =?utf-8?B?cTJHSFBDWDdJaDBVVWlrdnFmU0s4NXlVZ2ZMbkNheUZKN2Z2TGYrOVpBT3Rk?=
 =?utf-8?Q?1t8N1AZDBUi02Yle16?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56787747-ce18-419f-e891-08deb4e7ec7f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:15:33.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xE9Fcdt9J4N4/CPHCabhnGwbUNEIp5vcAUBKIAX9txg9L/Cit53tuRXlGkYD2Yfqrn7uVFFkXVdIs/LPiZqvBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486


On 18/05/26 19:20, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/18/26 08:44, Sumit Gupta wrote:
>> Hi Mario,
>>
>>
>> On 16/05/26 02:43, Mario Limonciello wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 5/15/26 07:26, Sumit Gupta wrote:
>>>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>>> CPPC autonomous performance selection on all CPUs at system startup.
>>>> When autonomous mode is enabled, the hardware automatically adjusts
>>>> CPU performance based on workload demands using Energy Performance
>>>> Preference (EPP) hints.
>>>>
>>>> When the parameter is set:
>>>> - Configure all CPUs for autonomous operation on first init
>>>> - Use HW min/max_perf when available; otherwise initialize from caps
>>>> - Initialize desired_perf to max_perf as a starting hint
>>>> - Hardware controls frequency instead of the OS governor
>>>> - EPP behavior depends on parameter value:
>>>>    - performance (or 1): override EPP to performance preference (0x0)
>>>>    - default_epp (or 2): preserve EPP value programmed by 
>>>> BIOS/firmware
>>>>
>>>> The boot parameter is applied only during first policy initialization.
>>>> Skip applying it on CPU hotplug to preserve runtime sysfs 
>>>> configuration.
>>>>
>>>> This patch depends on patch series [1] ("cpufreq: Set policy->min and
>>>> max as real QoS constraints") so that the policy->min/max set in
>>>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>>>> during init.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>> [1] https://lore.kernel.org/lkml/20260511135538.522653-1-
>>>> pierre.gondois@arm.com/
>>>> ---
>>>>   .../admin-guide/kernel-parameters.txt         |  16 +++
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 122 
>>>> +++++++++++++++++-
>>>>   2 files changed, 133 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/
>>>> Documentation/admin-guide/kernel-parameters.txt
>>>> index 0eb64aab3685..7e4b3a8fd76f 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -1048,6 +1048,22 @@ Kernel parameters
>>>>                       policy to use. This governor must be registered
>>>> in the
>>>>                       kernel before the cpufreq driver probes.
>>>>
>>>> +     cppc_cpufreq.auto_sel_mode=
>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous 
>>>> performance
>>>> +                     selection. When enabled, hardware automatically
>>>> adjusts
>>>> +                     CPU frequency on all CPUs based on workload
>>>> demands.
>>>> +                     In Autonomous mode, Energy Performance
>>>> Preference (EPP)
>>>> +                     hints guide hardware toward performance (0x0)
>>>> or energy
>>>> +                     efficiency (0xff).
>>>> +                     Requires ACPI CPPC autonomous selection register
>>>> +                     support.
>>>> +                     Accepts:
>>>> +                       performance, 1: enable auto_sel + set EPP to
>>>> +                                       performance (0x0)
>>>> +                       default_epp, 2: enable auto_sel, preserve EPP
>>>> value
>>>> +                                       programmed by BIOS/firmware
>>>> +                     Unset: cpufreq governors are used (auto_sel
>>>> disabled).
>>>
>>> Rather than unset doing nothing, have you considered having it take a
>>> midpoint like 128?  That's what we do in amd-pstate (default to
>>> balance_performance).  I think it turns into a reasonable balance.
>>
>> Thanks for the suggestion.
>> I can add balance_performance that enables auto_sel with EPP=128 in v4.
>>
>> On changing the driver default (no param behavior) to auto enable
>> balance_performance, it would be good to keep the current behavior for
>> now since cppc_cpufreq is generic across ARM64/RISC-V platforms where
>> EPP and Autonomous Selection registers are optional.
>> A default change would affect existing users relying on governors.
>>
>> Thank you,
>> Sumit Gupta
>
> But couldn't you make the "no module parameter set" follow the behavior
> to only set the registers if they're available?
>
> So the systems that support it start using it, the ones that don't it's
> a NOP.
>

Would it work to add balance_performance as a new mode in v4,
and discuss changing the default separately as a follow-up?

Runtime detection helps for unsupported platforms. But platforms which
support the registers use OS governors today, and silently switching
them to autonomous mode on a kernel update is a behavior change for
existing users. They would also have no way to boot into sw governor.

Thank you,
Sumit Gupta


>>
>>
>>>
>>>> +
>>>>       cpu_init_udelay=N
>>>>                       [X86,EARLY] Delay for N microsec between assert
>>>> and de-assert
>>>>                       of APIC INIT to start processors. This delay
>>>> occurs
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/
>>>> cppc_cpufreq.c
>>>> index 6b54427b52e1..5f4d735e7c7d 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -28,6 +28,43 @@
>>>>
>>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>>
>>>> +/* Autonomous Selection boot parameter modes */
>>>> +enum {
>>>> +     AUTO_SEL_PERFORMANCE = 1,
>>>> +     AUTO_SEL_DEFAULT_EPP = 2,
>>>> +};
>>>> +
>>>> +static int auto_sel_mode;
>>>> +
>>>> +static int auto_sel_mode_set(const char *val, const struct
>>>> kernel_param *kp)
>>>> +{
>>>> +     if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
>>>> +             *(int *)kp->arg = AUTO_SEL_PERFORMANCE;
>>>> +     else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, 
>>>> "2"))
>>>> +             *(int *)kp->arg = AUTO_SEL_DEFAULT_EPP;
>>>> +     else
>>>> +             return -EINVAL;
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int auto_sel_mode_get(char *buffer, const struct kernel_param
>>>> *kp)
>>>> +{
>>>> +     switch (*(int *)kp->arg) {
>>>> +     case AUTO_SEL_PERFORMANCE:
>>>> +             return sysfs_emit(buffer, "performance\n");
>>>> +     case AUTO_SEL_DEFAULT_EPP:
>>>> +             return sysfs_emit(buffer, "default_epp\n");
>>>> +     default:
>>>> +             return sysfs_emit(buffer, "disabled\n");
>>>> +     }
>>>> +}
>>>> +
>>>> +static const struct kernel_param_ops auto_sel_mode_ops = {
>>>> +     .set = auto_sel_mode_set,
>>>> +     .get = auto_sel_mode_get,
>>>> +};
>>>> +
>>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>   static enum {
>>>>       FIE_UNSET = -1,
>>>> @@ -715,11 +752,75 @@ static int cppc_cpufreq_cpu_init(struct
>>>> cpufreq_policy *policy)
>>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>
>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> -     if (ret) {
>>>> -             pr_debug("Err setting perf value:%d on CPU:%d. 
>>>> ret:%d\n",
>>>> -                      caps->highest_perf, cpu, ret);
>>>> -             goto out;
>>>> +     /*
>>>> +      * Enable autonomous mode on first init if boot param is set.
>>>> +      * Check last_governor to detect first init and skip if auto_sel
>>>> +      * is already enabled.
>>>> +      */
>>>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>>>> +         !cpu_data->perf_ctrls.auto_sel) {
>>>> +             /* Init min/max_perf from caps if not already set by
>>>> HW. */
>>>> +             if (!cpu_data->perf_ctrls.min_perf)
>>>> +                     cpu_data->perf_ctrls.min_perf = caps-
>>>> >lowest_nonlinear_perf;
>>>> +             if (!cpu_data->perf_ctrls.max_perf)
>>>> +                     cpu_data->perf_ctrls.max_perf = policy-
>>>> >boost_enabled ?
>>>> +                             caps->highest_perf : caps->nominal_perf;
>>>> +
>>>> +             /*
>>>> +              * In autonomous mode desired_perf is only a hint; 
>>>> EPP and
>>>> +              * the platform drive actual selection within [min, 
>>>> max].
>>>> +              * Initialize it to max_perf so HW starts at the upper
>>>> bound.
>>>> +              */
>>>> +             cpu_data->perf_ctrls.desired_perf = cpu_data-
>>>> >perf_ctrls.max_perf;
>>>> +
>>>> +             policy->cur = cppc_perf_to_khz(caps,
>>>> + cpu_data->perf_ctrls.desired_perf);
>>>> +
>>>> +             /*
>>>> +              * Override EPP only in 'performance' mode;
>>>> 'default_epp' mode
>>>> +              * preserves the BIOS/firmware programmed EPP value.
>>>> +              * EPP is optional - some platforms may not support it.
>>>> +              */
>>>> +             if (auto_sel_mode == AUTO_SEL_PERFORMANCE) {
>>>> +                     ret = cppc_set_epp(cpu,
>>>> CPPC_EPP_PERFORMANCE_PREF);
>>>> +                     if (ret && ret != -EOPNOTSUPP)
>>>> +                             pr_warn("Failed to set EPP for CPU%d
>>>> (%d)\n", cpu, ret);
>>>> +                     else if (!ret)
>>>> + cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
>>>> +             }
>>>> +
>>>> +             /* Program min/max/desired into CPPC regs (non-fatal on
>>>> failure). */
>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> +             if (ret)
>>>> +                     pr_warn("set_perf failed CPU%d (%d); using HW
>>>> values\n",
>>>> +                             cpu, ret);
>>>> +
>>>> +             ret = cppc_set_auto_sel(cpu, true);
>>>> +             if (ret && ret != -EOPNOTSUPP)
>>>> +                     pr_warn("auto_sel CPU%d failed (%d); using OS
>>>> mode\n",
>>>> +                             cpu, ret);
>>>> +             else if (!ret)
>>>> +                     cpu_data->perf_ctrls.auto_sel = true;
>>>> +     }
>>>> +
>>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>>> +             /* Sync policy limits from HW when autonomous mode is
>>>> active */
>>>> +             policy->min = cppc_perf_to_khz(caps,
>>>> + cpu_data->perf_ctrls.min_perf ?:
>>>> + caps->lowest_nonlinear_perf);
>>>> +             policy->max = cppc_perf_to_khz(caps,
>>>> + cpu_data->perf_ctrls.max_perf ?:
>>>> + (policy->boost_enabled ?
>>>> + caps->highest_perf :
>>>> + caps->nominal_perf));
>>>> +     } else {
>>>> +             /* Normal mode: governors control frequency */
>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> +             if (ret) {
>>>> +                     pr_debug("Err setting perf value:%d on CPU:%d.
>>>> ret:%d\n",
>>>> +                              caps->highest_perf, cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>>       }
>>>>
>>>>       cppc_cpufreq_cpu_fie_init(policy);
>>>> @@ -1079,10 +1180,21 @@ static int __init cppc_cpufreq_init(void)
>>>>
>>>>   static void __exit cppc_cpufreq_exit(void)
>>>>   {
>>>> +     unsigned int cpu;
>>>> +
>>>> +     for_each_present_cpu(cpu)
>>>> +             cppc_set_auto_sel(cpu, false);
>>>> +
>>>>       cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>>>       cppc_freq_invariance_exit();
>>>>   }
>>>>
>>>> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode,
>>>> 0444);
>>>> +MODULE_PARM_DESC(auto_sel_mode,
>>>> +              "Enable CPPC autonomous performance selection at 
>>>> boot: "
>>>> +              "performance or 1 (EPP=performance), "
>>>> +              "default_epp or 2 (preserve BIOS/firmware EPP)");
>>>> +
>>>>   module_exit(cppc_cpufreq_exit);
>>>>   MODULE_AUTHOR("Ashwin Chaugule");
>>>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+
>>>> spec");
>>>
>
