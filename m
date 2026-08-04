Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157E47729B;
	Tue,  4 Aug 2026 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860135; cv=fail; b=o/6cSChjqiaawSEIIRBWosx7+4ty3Ra+B8rCVkcpA3RCkKtyG5iNtGmaNDrgLUJjAptCHWHNQqGMVNeOZHGEnXHNygUPqSoF4iMqgsvMqHz6GH/bi1AKO7XI7xtNmzxj33JwM3UBmBh+qb+OyQ8Je4gd/2nf+gWYXM49lhkMwNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860135; c=relaxed/simple;
	bh=Hj2P58ncVuw6aI//7TrWpOnV1k7eCUiPhGWGlLyGPnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qPSsnNG6luKosT/hfC9ZN1yj7W89ec9a20iC/5bMZEuIw5LLtGrLnR1hhBycJ60I8mD2DUPWlUzxPfMUjJgIHJXiigrQFu6e/DNoyDyUkoKAAvuRqe1qEkzkdXjIEwivg5rO5dHkFaTqi8eYAVlQR95xsfBWBCSc8EgAg4htZW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nRs5Rrkz; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nRs5Rrkz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSed/7AOXC4jI+sp20Wg1IF1s98Or4qyQHY3ZWFeFKgtNaVWyjqvj7Oh2zmYvOTa98VhBRNrYXbhm3g0d5lvnW8KcbIj3ZZ6wQP1yCkLBREf5ipIp9gZPT0qdH6kbEEN6bVWeTbzUd8DUXZ/IrGBHUv7yKPIlnzmhsa1+SVMs6H3s7AUDWmO1+t36ORrJ23IfYn1jVUmLexDemBBNY8RxV3WK6QwA8H+jqxQfpI8lCWgGb052g0W7NKCSahIUVjH2jamhxBP2BsEBVEDGdepeERmuMTbGVoqviOeI9wnWjhBNH9XVFuuiz98tcDgdDMTM+1FVHk4VUSOSwNcJE+ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwL+xxAm8PYGRX2VCGs76de1bKD8WPVTYjQs1NF46GI=;
 b=uOPDciB0gGl3D+5BsNA8rp3STh4Lg+SKpgKPlQ5Jql8YJIHdZIva9ERVtZzfbzTKZ1fsSx3xSkITjJ2Z/XRaVzB/86kcefpOjzRg/C1amm8kCk5XhlrEUkV9/cabgV0ZPFOtSzHCnfnFL7jOtepTNpzyKBQTZx+ylP0Glf6d+i6ZMp6Oayrg7vAFKDMNHFraIBuUGNagilco3DOQzySCF3ksnVXx4Rowv3BcezlK210kGSt+I8ZRrLDphCCpa+pvaqwaqJondYmUy7p/5Msnyp5WbWeyjzCGu6zQkwkZu//IihXv/Cm3z1XQNI+BaBYZtpr51NnCmmgFYEx+RpYo4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwL+xxAm8PYGRX2VCGs76de1bKD8WPVTYjQs1NF46GI=;
 b=nRs5RrkzhAUfXvCXKCCQOWNXL73ZQ9B/BS3CVcPb9nxKdIBoWqVuYEEn74SDvj801skvIleWeN0Ah/sRJmQ+EKOL7LNn8LOyOWpqXwqjnfo9lt4CdDQ3JMI642W8666jtnoNZcYN6U3KjTSDed2VmrfDuZ+isl0lvXMzRqAExH9HjBCWsDSDVBzQ+5dl/u1a4FF/w1OaKt4BkXzksG4TaRPn2AxmoJmRUJ6Hh+1dHT8WDrdGw4q+yuY6L+UT/HNLyAKa3ve0S8Ei8SbQUzOjdbCwFpXPz1RXLeK/BOzo6pOK6xR3j4fV3Y6Z4C5HmEHDOh1BNrcKytzIaeqzuH2rVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 16:15:17 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 16:15:16 +0000
Message-ID: <15ab9b1c-2fbe-41cf-949c-d9e6c50b0ef9@nvidia.com>
Date: Tue, 4 Aug 2026 21:45:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, christian.loehle@arm.com,
 ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com,
 lenb@kernel.org, saket.dumbre@intel.co, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260717215330.2215058-1-sumitg@nvidia.com>
 <20260717215330.2215058-2-sumitg@nvidia.com>
 <57a80bff-948c-449d-ad17-cb3fba89ed5f@oss.qualcomm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <57a80bff-948c-449d-ad17-cb3fba89ed5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25b::6) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1e61b1-4c6f-4007-8fc6-08def24391da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	A/xDwtdHOPFw9Nynel+ZO7NFQ5GJWhKkE/OV2V6ZU+9+xVDGnY871d+0PsbW05exLTm+D41WtlIV0ilpm/PFF2STLIKAffsGMrsYQWJkyVFljEC2By/oaiNnHVM+eBnRrNXWjx1c53HO2ickciCIg4Dfacu05FLjlI2F5pddhUGStI+QowiFi7HlwgSDi4Z1fkuxcJK8fho224aayc1neU5mkZORc/8ZJJ7xbXetolKX8b8JRtVRcVo5gQlXOTt16srBM4XvIox4/hNDcrIVUXoZMVBe/adDq4E4qZoawd0eTSydv1ig/yS3Xj0vMGYbg7Q87OSBQYTYqZsoYwPuTkv+aDNVR3E3wXUJDHG2d6jrflsHmqJc9GETJpw9/pBTxkJCvdGvCMgd83GfDVsNThM4EZuSw6F96G2ruglnpqfOScYlp0GpmIX9SnzMG3UzCPAIDYGOl7wFoqrImV31mbokxfw8T2bziYQ52f//EGtrT883t25szykweKerfhsvEk9TjgsstZWvnzb3VF3JYOzvw/1g8yciw5QTc02MdMMGx/Irac+vT5DzQfNmPffSYRiTK7nWqHzpTF9kkcJxTzV8W0cILOam9FGo4VJqr4xLRqINNvYN9tQDyw1lxVQ8bkYr+DCTPzbY7cPoaGuPFIN742aU9m3QXasYLuu4okvSwnualkNGVkOGC//cZSv8tiBv1l0zoVoqGLko2WfmAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(3023799007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVJYUnBmWHRaNlhzVlhZU2VsNHZmL2V0REVkYUxSS0thRXRaQlh0Z2V4R3li?=
 =?utf-8?B?bW1wRGQ4TjdBKzdZdE5CSTBRRnJEbzZmQ1BQNG1vNFJDY0duRjBTeXZ5TnBi?=
 =?utf-8?B?ZjhuN2JTL2pFT2RPUFFUaWZQRVpLbjNieE4zQ3NGZUEwQjlBYjFGOVRJSFhj?=
 =?utf-8?B?Wm0vYVF5SkVUVVBITXpnTVU4Nyt4aEd0WVE2MnZjbEhXU25ScEJMbVdVU1gw?=
 =?utf-8?B?VzUxVG55WG5TS3RteFVDMzBmbFdscDBUVy9mbUhETVZ1d0pGcXlHREh2TDlS?=
 =?utf-8?B?dFh2Y0VzVy8ya0FOTFZwVnFja0ZvY0dpZVg5Y3ZGU1RYTmdJaTNMQS80cTJX?=
 =?utf-8?B?UU9lblNON1J3OGIvRGpPYk9Oa0l5K3dYWUdLT3RuZFU0QVVWVXpxSDA3RkpL?=
 =?utf-8?B?MU93Vlh1NTk5ZVpvQjZ0eVFCMXVUN2VPQVAzb3gyNCsyQ05nbmhDZ0pQYlJL?=
 =?utf-8?B?TGlKaU9PQTdic0dlaDRCall6L0hzMmFSVlI1MW5OdU92NFpIY3ZLc0s4dm81?=
 =?utf-8?B?dnZURkttbkxJU1hwWUd0aXdCOG1sdlVSM0VZNThBUVJMMU1CU0pjaEtac0RT?=
 =?utf-8?B?a3QxckZiZFQ5ZFozMzhPZElhZ3hKS29UaTQwMnREa2JlR0Q4UGk0TWlTZ3I0?=
 =?utf-8?B?aDRUNWNISFJEZVA2SitCaWZQVHM2Z0twZC9lNXFIaGJYOHRuaUdnbGg4T2oz?=
 =?utf-8?B?dlZsYkZGNFRzZ2dlTDBiaUxsWmtXcGgyb0s0c0RiNFFpWVZ6Y3laM3FYczl2?=
 =?utf-8?B?TlAyaWZKeDU3U3FzcmU0ZDRQZGE0M0F1YWhHRjZsOWtTWCtwVGtWc09UaUNP?=
 =?utf-8?B?S0JuRnFCYUFRV1EwY1lZK0JRT3lMUTAxVDdWZ3lkOGRscjBlMS9SUUNBMERh?=
 =?utf-8?B?bkl2MTBIMTJKWGsyeWcwdm9ranAveXdoeUt2MkxjU0dCVWRxY1FZUWZHUlRv?=
 =?utf-8?B?ZS9CckZtMlBmVWs2Vkt6WWx1ZXdCTWRyOWZLVHp2a2FyVVZvQjhmYURSR3U2?=
 =?utf-8?B?SnpYZTY2MTVRblg3Q2cvVHNHb1RBY0NJOG5zRHBiQXJhYTVFVW80NjNnditQ?=
 =?utf-8?B?WnJ3ZnR5RkdrU1lMWG1JWHlUZkFSWDdZakd0TWxJeFA1YzBDT3lNaEJiMDNq?=
 =?utf-8?B?ZkZlci9XZzhNckExTUdkajMyaFRvRlVmZW1ySk83K2pZRHBJNzFIS1k0VWZN?=
 =?utf-8?B?Unk5WjlDcDhPVWwwWlFSWEJ3bXQ2Q3B1WUlKdnh2aWJoczE4a0dkVWhIQVVl?=
 =?utf-8?B?eTEwcjM1QTdYRk90bkVnRnFrYXhoRzFpVTZIMkE1MFZYUGJlRzhjck9UQ3hq?=
 =?utf-8?B?MHd6M1F3QnJuaVE3Zkp0Y3BVTTBVOUwzMm5DY2dxb09CanZNbnN5ZmdqVUVm?=
 =?utf-8?B?clNiNkx3R0p1M3ZMb2lCd3Y2T0xOMVY4UTJrYldHaEpqUERSeWhmV3dJdXdS?=
 =?utf-8?B?UUxqVlBpcGZnTDE3b2R3K1hCWVpyWitCc2s4MStPazk3aXZJSkVsSGI3Y3BJ?=
 =?utf-8?B?U3RuNEpOcnNMSzZGWldMSE1TaEczYTZVcEE2SzNZZ1JPVVlQUzdQcWhHU0NQ?=
 =?utf-8?B?U0lRSFkvQUpkZFZ4YldNbGlBcS9tYTVwOVljbmtFa2lpWHI0TTNQVEx5bXFL?=
 =?utf-8?B?aDh3c05BbGM3QUlFa1J4UDFPZ3R5enlnc2NWZW13OXArY1FkYURRL3lobWNK?=
 =?utf-8?B?NWZ2dldEZzVaVkg2bmFpanZGVUh5TEVOKzFLa3dnNVFzQkVQc1VpN1drcWl1?=
 =?utf-8?B?YXJWRDFZeGQ2NzFacllWTklrQWpPalQ4VWRUL2d4L0NOVHJnUmNlUVZnZXVy?=
 =?utf-8?B?bmhCS2VuMXhnYUdRY2RyeVR6RTIwQnZGOWllTjNQTUxRbUxVU2FyT2daNGxJ?=
 =?utf-8?B?WlF2RXVtQVpEL08xdGJhaG9CMmhrNXB0SU5weitDODBWbDl5MlorODhVV21Q?=
 =?utf-8?B?S01DSHF3K1lPUGd3RTh4Wiszc2dJVWpaR2xOeWg0bzFCOHNGbDZudmt3dGNo?=
 =?utf-8?B?OHRyUDl4eityMnVBNWpNSTBuR0l5MCtnRHZWdCtmcEVTNWZYNlJmdkZjQmRQ?=
 =?utf-8?B?YjRlelNXT2ZPWlhuMjZ0cGVGRmJFZng0Mzg4UXVNUitxREszMXpUWFlHbnM1?=
 =?utf-8?B?R2Z0cEZHY1RNcmdiWUhUZHdKOEhMZ3ZyT0dvOVB6MUhzc0FQNGQrV29jb05U?=
 =?utf-8?B?NEQzVUZFSnhhNXhQSXcyazF5UktLbWVZT1EyY2xrYno5WmRFbmFTRFFtMlFz?=
 =?utf-8?B?SVExK0t2akQvR3lMQ29UblZMOVNORkJlSVA0RjNCWnVxRlF6R3dTMll4N3Rt?=
 =?utf-8?Q?ORT8qH3tDFGYyEKTTC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1e61b1-4c6f-4007-8fc6-08def24391da
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:15:16.0901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiGt2gve+OoZoCsWBhPXNUW9e4gbJcBu0rtdTZyleQavWVYTazpUtqrSDpO1CxhRuWfOhor0q8YQ1zj3GsNEAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230

Hi Zhongqiu,


On 28/07/26 18:54, Zhongqiu Han wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> On 7/18/2026 5:53 AM, Sumit Gupta wrote:
>> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
>> 8.4.6.1.2.6), which conveys the desired nominal performance level
>> at which the platform may run. Unlike the existing read-only
>> Nominal Performance register, it is writable and lets OSPM
>> request a lower nominal level than the platform-reported nominal.
>> The platform classifies performance above this level as boosted
>> and below as throttled for its power/thermal decisions.
>>
>> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
>> match the cpufreq sysfs unit convention:
>>
>>    /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>>
>> The attribute is documented in
>> Documentation/ABI/testing/sysfs-devices-system-cpu.
>>
>> Writes are converted to perf via cppc_khz_to_perf(), validated
>> against [Lowest Performance, Nominal Performance], and applied to
>> the policy->cpu. The register is assumed shared across the
>> policy->cpus.
>>
>> On read, the current register value is returned, or
>> "<unsupported>" if the platform does not implement the register.
>>
>> Also add the register to the OSPM-set register save/restore
>> table, so its value survives CPU hotplug and reverts to the
>> firmware value on driver unload, like the other registers in
>> the table.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++++
>>   drivers/acpi/cppc_acpi.c                      | 32 +++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c                | 47 +++++++++++++++++++
>>   include/acpi/cppc_acpi.h                      | 10 ++++
>>   4 files changed, 115 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu 
>> b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 82d10d556cc8..a8d592c08823 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -346,6 +346,32 @@ Description:     Performance Limited
>>
>>               This file is only present if the cppc-cpufreq driver is 
>> in use.
>>
>> +What: /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>> +Date:                May 2026
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: OSPM Nominal Performance (kHz)
>> +
>> +             OSPM uses this attribute to request a nominal performance
>> +             level lower than the platform-reported nominal. The
>> +             platform treats performance above this level as boost
>> +             and below as throttle for power and thermal decisions.
>> +
>> +             Read returns the current value in kHz, or "<unsupported>"
>> +             if the platform does not implement the register. Write a
>> +             kHz value in the range [lowest_freq, nominal_freq].
>> +
>> +             Note that tasks may be migrated from one CPU to another
>> +             by the scheduler's load-balancing algorithm, and if
>> +             different OSPM Nominal Performance values are set for
>> +             those CPUs (through different cpufreq policies), that may
>> +             lead to undesirable outcomes. To avoid such issues it is
>> +             better to set the same value across all policies, or to
>> +             pin every task potentially sensitive to it to a specific
>> +             CPU.
>> +
>> +             This file is only present if the cppc-cpufreq driver is
>> +             in use.
>> +
>>   What: /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:               August 2008
>>   KernelVersion:      2.6.27
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index a7fec6c93178..681d4fd40c11 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>
>> +/**
>> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance 
>> register.
>> + * @cpu: CPU on which to write register.
>> + * @ospm_nominal_perf: Value to write to the OSPM Nominal 
>> Performance register.
>> + *
>> + * OSPM Nominal Performance conveys the desired nominal performance 
>> level
>> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
>> + * must lie within [Lowest Performance, Nominal Performance] and may be
>> + * set independently of Minimum, Maximum and Desired performance. The
>> + * caller is responsible for validating the range.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, 
>> ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>> +
>> +/**
>> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance 
>> register.
>> + * @cpu: CPU from which to read register.
>> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance 
>> value.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, 
>> ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
>> +
>>   /**
>>    * cppc_get_auto_act_window() - Read autonomous activity window 
>> register.
>>    * @cpu: CPU from which to read register.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 9c88512d635c..eb6746810fa6 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -37,6 +37,7 @@ enum cppc_saved_reg_id {
>>       CPPC_SAVED_AUTO_SEL,
>>       CPPC_SAVED_EPP,
>>       CPPC_SAVED_AUTO_ACT_WINDOW,
>> +     CPPC_SAVED_OSPM_NOMINAL_PERF,
>>       CPPC_NR_SAVED_REGS,
>>   };
>>
>> @@ -55,6 +56,9 @@ static const struct cppc_saved_reg 
>> cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>>       [CPPC_SAVED_AUTO_ACT_WINDOW] = {
>>               cppc_get_auto_act_window, cppc_set_auto_act_window,
>>       },
>> +     [CPPC_SAVED_OSPM_NOMINAL_PERF] = {
>> +             cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
>> +     },
>>   };
>>
>>   /*
>> @@ -1166,11 +1170,53 @@ static int cppc_get_perf_limited_filtered(int 
>> cpu, u64 *perf_limited)
>>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>>                        cppc_set_perf_limited)
>>
>> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, 
>> char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     return sysfs_emit(buf, "%u\n",
>> + cppc_perf_to_khz(&cpu_data->perf_caps, perf));
>
> In patch 2/2, cppc_cpufreq_get_effective_nominal() reads the OSPM
> Nominal into ospm_nominal via the output pointer of
> cppc_get_ospm_nominal_perf(policy->cpu, &ospm_nominal), then checks
> ospm_nominal for zero ("A zero value means OSPM has not selected a
> nominal level") and substitutes the platform Nominal in that case.
>
> However, show_ospm_nominal_freq() passes the value read through the same
> output pointer straight into cppc_perf_to_khz() without the equivalent
> zero check. This looks a bit inconsistent — is it intentional, or
> should show() apply the same "zero means not selected" handling?
>

Thanks for pointing this out.
In v7, I will make ospm_nominal_freq as write-only and remove sysfs
show() and cppc_get_ospm_nominal_perf(), eliminating this inconsistency.
The effective nominal calculation will use the last successfully
written value, falling back to the platform Nominal Performance if none
has been written.

Thanks,
Sumit


>
>> +}
>> +
>> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>> +                                    const char *buf, size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +     if (perf < cpu_data->perf_caps.lowest_perf ||
>> +         perf > cpu_data->perf_caps.nominal_perf)
>> +             return -EINVAL;
>> +
>> +     /* The register is assumed shared across the policy's CPUs. */
>> +     ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>   cpufreq_freq_attr_rw(perf_limited);
>> +cpufreq_freq_attr_rw(ospm_nominal_freq);
>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>       &freqdomain_cpus,
>> @@ -1178,6 +1224,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>>       &auto_act_window,
>>       &energy_performance_preference_val,
>>       &perf_limited,
>> +     &ospm_nominal_freq,
>>       NULL,
>>   };
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index cd07e1e92bf4..4c9e59643cc0 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -180,6 +180,8 @@ extern int cpc_write_ffh(int cpunum, struct 
>> cpc_reg *reg, u64 val);
>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls 
>> *perf_ctrls, bool enable);
>>   extern int cppc_set_epp(int cpu, u64 epp_val);
>> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>> +extern int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf);
>>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>> @@ -268,6 +270,14 @@ static inline int cppc_set_epp(int cpu, u64 
>> epp_val)
>>   {
>>       return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 
>> ospm_nominal_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +static inline int cppc_get_ospm_nominal_perf(int cpu, u64 
>> *ospm_nominal_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_get_auto_act_window(int cpu, u64 
>> *auto_act_window)
>>   {
>>       return -EOPNOTSUPP;
>
>
> -- 
> Thx and BRs,
> Zhongqiu Han
