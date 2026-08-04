Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011028.outbound.protection.outlook.com [52.101.52.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72682459ACB;
	Tue,  4 Aug 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859946; cv=fail; b=FT0MgcYmxYR5g0KuLe/Kgnabcww7B7LJnrE+8tVVs5kdhNNXr/9M9TrVlFDRblB6C6THS+CWYLfFPC7TeUKdTNiT00TpzcS8DstTKLqFnjifnSIyCJO+9/dFzy1c9sw4zNmIm1sEVMRcKxMRu2S/5FnCQMXBXcwtcJLl3sOcaFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859946; c=relaxed/simple;
	bh=87yP2fRl6uu8bPTotY+KpMp17bGuRT5qT2MYUtF+T/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ad2DSn59c5RrL+VHlr4HPqsa0eV1DWRP+doEPNr4NpNMfjZSz+tmPaOTdD7iAMobxD2pa39P0I+maPbazU+goA91eBqBpIuYCjFaE1/EOIMUVdVn47seb0dRRA8JmW3aq3HhQDuK2BC7SbYVIGipjNS8YcZC0KyYNewP7X/ucNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBVLrwEA; arc=fail smtp.client-ip=52.101.52.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBVLrwEA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5UdYlBiMPXGoTz9MhIgVTC3iyuESs55bZguawWg3rRW1T+zRQgp3ndkeC3yvBDV4OkOrhDYiCwEfvhoyxHr3iaXsaKFLiXWlhbH5II6Z5m9Pso+/stgI+PmdrNgT8I54rmT9b1MfsE0azLfvBeuVxunOmr8rPNlwq/moV6worhfKyCNsgkV/NeOoarP6W1KamGQQRH6PeF+sHulC5NUefLfMe5y7uzK/y6mGAaVyY75JFvZ1Ynwjm3zwE5y1FUZ2Hs8zFMOLPF47nm3BFRh/sCHuuaClRUroLBHsTZUGO2YY2HiTcowzHGMLGtaMnaT1abT9FNXAWgwzMh5dCw/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKliewOW0EYX5KpVNxy7i7mosHHTDWpytWp63y+6Z1A=;
 b=jpdrmS2SJ4JiPh8LjYWa3UC4DfTRdyuIoUB60zYQ5xfms2vXqadPKXbF4Jg+zJdSwtIK1Psh/QDUy/Dm60MptG4CgphoKEFjw8F3K50uuronmINgVfIBYNCwO6WxK8+Quad1T+PDU/dh/iPYbJwnRAXnc0PQTeDvq2pHEbOOwNGb6PmHuPrt4imAkM8txmqc83RXEA4LDsZpD1eLyH2tjue3RrKlz3J8YUhbpwFOUAw0WatOyhCEdKBym/q93PWj30Pq/ImlUFlnO/IlC+yzgoM9jkOyt4NDasfBrd4kONeDY9eu2y7uASgomji34DcnUWtcSsb2r83jaFDi1vCuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKliewOW0EYX5KpVNxy7i7mosHHTDWpytWp63y+6Z1A=;
 b=kBVLrwEAtm2WHOmQpDboiIVQoj7OybefrEPC9p4b0ibifIOMz5eQii8wZY9JbCNuNXteUMKMVmn3+6F3TM1ZH6/RcD4cASVllG/rpn9Y1EhHs//EigutQygCC/sIDwosFYjfb5qU1ow4kdrFbsK0uQ1b36+3FRWbdUm5hJBonUrVM19cWgA9QnnPj/Ta3V7lIU8tZdTVHnahuHWrbaXS2fp4DwWFNzI5qJOzDfshts1QbYrzbld6KhYui8LIHKOi2sPYYFBPLqQJ96P5ljYJaC/CoHiDX1DhPs8U0ITHQPXPib4eeulJt1jJtR4iriK7VZKB75noNK+ifVaEM1DtEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV8PR12MB9230.namprd12.prod.outlook.com (2603:10b6:408:186::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 16:12:18 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 16:12:18 +0000
Message-ID: <d75edc69-776c-4828-b3d9-520183672503@nvidia.com>
Date: Tue, 4 Aug 2026 21:42:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260717215330.2215058-1-sumitg@nvidia.com>
 <20260717215330.2215058-2-sumitg@nvidia.com>
 <436ae296-cc68-4313-bf76-86908a1e5b29@arm.com>
 <498f0051-e549-4be4-b5bf-56aba1670881@arm.com>
 <d75cbdd0-4372-48b6-8445-03f2401a6784@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <d75cbdd0-4372-48b6-8445-03f2401a6784@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::33) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV8PR12MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: b7a3ac65-eca7-418f-fb80-08def24327fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|5023799004|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	kYiROT7D/xurH3y5R93n4kqpCRj47YcDnXZ3gs7zRzRAD74CHwPsOLMiLpfO9tQfymcjg6iRVXBEmRCb5yvcaXFw3F0yPuoTtm2lvzn5ryZBzFPQEswAOURfihVCpJE798dl/utFPE8Axow/HwkK9KUc5GDmFOAIQxRbyNesP/dnqEMNVFu5i7GOqRhrYKvXuY8BF0DcxROAaN7NQ8M8PcPI11nimnUBUYSUJZvIcLY9H9jukshf0QmGO8dGfC6EfW5qIVknlEDjPM1ab8vpaMmQ0NKLAOGXEh7v5y81cguE8vTNtElIN0iV+2wqFx7uVwr+10HEofO28OHxbmR98COqPmeTkgJKqRImmJx92b8L3DOsY3iL16g6hieMBRdvNoOqjts8ctvTkV3pHZfJ9Ai22y0pN3U1UB7HcQMaqyNFJIo97I8GC/uyBDAPGCAdaB7p2UM16JWpg/pGriyPaQ7FOz7wRK5sbKrkHLu/YPPMRXe2h/TRzJUv2fupCFWcgdzyGCWV/XVNpChkQuEZofbiZzwrc7aBgtM3jQGalYkbWEoFZyZBDPsHQkQaLjrMy88osuXuQtcuV5t7fkyMWz7j/EvxGLWfrfLK2i6VOgg/ScQB365Sbv/I2ZQTrkPf6Y0JyYQuHkQBJGPF7Bfo8Rk72Qd7z+pBw7i7k9Xo1/Ype1uWmTOTmSxvCPfEqh+ZCUwgOJVHpTWCgJeY+DyNoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(5023799004)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0JIQ05JWGd1NDFvK1NNRXd3Rnh0a0RLMTgweVg0UFh4MzdwUU1pUUpaeml0?=
 =?utf-8?B?dnFPVEMyYTdWZWsyMWs2ZkE0Mnp5K2pnSWJjQjFYZzdvQUJ4NEl0QU1DTkpL?=
 =?utf-8?B?VXJLRWNlMm0rdVJPc2lwUjVWM0hWMmVDSGFjem9KWUhOUGMyeS95QzZKVkhJ?=
 =?utf-8?B?Q2d6ZHp2RGIzMk0zejF5TVJ3RG9OMmhmK09XTlRudkdKTjE5QVRZN3RSc2Ju?=
 =?utf-8?B?NzNBNDFiNXQydlJPazdHR2U4Q0daRm5tR3JjVmVtT0FpT3FjTGpEQ3lUZVZh?=
 =?utf-8?B?ejdBT3VoSDczZkVRbFVNVHE3QVluRG9TNHRvWmJtQlI5SmowZ3ZwLy93bVJS?=
 =?utf-8?B?QVFpaDU0UXBvZzh4RFkzK3BDejZtc3g4L0prelFHWkhySFdFOU1QbG5iVExr?=
 =?utf-8?B?ckd4NHczWHAvUk90ZUtiakRtQ1BRd3pKVCtGS05sdjVyc2pXNU1RczJXKzZv?=
 =?utf-8?B?eDREQ0loSTVYTGVFNHJGSUN2bkdxOHVEbUFaOTdOYXBVWXR1elkxWkVob0hB?=
 =?utf-8?B?NEtNTk81VzF3TTY4R1lYMXpVMitYdm5iVTR0WWxwRkg0VkdIVUt1U2lsNVJj?=
 =?utf-8?B?WERFZy9nOE8zemhKQXpLMEVsemxoZmZLRFFQSGpKUW5ET2NTaXBqeWN6Qjhq?=
 =?utf-8?B?amVqVXlOcUViOUx2SkYrWGlBdTVwNXprZ0I2czBvbTdjSTZrcTJTOWUwRisy?=
 =?utf-8?B?eDVoc0x2TUI0dmxEdlQ5ODNoQ0tEMEFBUUFKOWdaSjA1WjA1a2daYWJBR3hk?=
 =?utf-8?B?RTByczRZSE52UlZRZVpxelFyVjZwdGpRcHBkOW1kVS9tOGFqK2R3SFFHTFlu?=
 =?utf-8?B?cWdqVDJuTUFQeHNsTmRZOEtNaGNEWEhuN2JXTHRETmNhWHV0eEFoV3N1N2do?=
 =?utf-8?B?QXZRQkkxaXR5QTMzZW5UUHl5c0c5OVhFdXVnRnFJQ0JzNk53d2NHaHAwWStE?=
 =?utf-8?B?ZDF1RzZQTzI3T0daaWNSck43dlNMZkxGeGQ3enhIY2lDdVBSN09sMXp1YWQx?=
 =?utf-8?B?alBWanR6aE02K0Z4eWdINHVWeGZMZ2JEQzJjVko4akRza0FFeWxRKzJXcElS?=
 =?utf-8?B?TDFlci9Oek4yQldtZ1A4eklzL0RMM3JnSlN5NkM0Vldoc3ZHaFVJc09ORFlo?=
 =?utf-8?B?UzhsNmc2UlJLQ3NSUUprYU9JNjY2WWF5ZFVJOHo5YlhPVm4zZmFHZno0T1pE?=
 =?utf-8?B?TUtOdytUc2NITWpQS25Pa1VGeW03ejEvL2JWclo4MzVEV3EvbVB6KytWR0Qr?=
 =?utf-8?B?U1NnTDQ5RjVNMFZlZkt6aTFucktPMGVmMWxySGY1SmZJQnplUEFISnUyTEdY?=
 =?utf-8?B?TjFhY0g4aEIxbHBmVUxZNGVycjJBcWl4NzYvR2hjdzlIeitRYjNoQkNsREJI?=
 =?utf-8?B?RkRoaE5qMmpOOGdyV1VlT21pd3pwZk8xS1RBVFJHTzByNzFpdkRNVnY0SEYz?=
 =?utf-8?B?UUJCeG9NYW42ZWRKNmpaQ1M5WE5pTElhYlFLTWlYSXpaYlYyT1dSVTdIckVG?=
 =?utf-8?B?M0RERzdVV3NKdHZBS2JaQVZFQTJNSUFlWXhWeTRCWXFWMjk5S1Jzc1VkYzAw?=
 =?utf-8?B?RGFrQUNCdmhxbTNrN1NacU5pOTVGMTZqMGxRczRsTlhJc0JQT0hEQ2ZqYTli?=
 =?utf-8?B?ZlpmQUY2Vk4yd3FKMjRUQWJlYWVMZVNHSWdLN1BuZDNyVldOTjNOeTkzOWhi?=
 =?utf-8?B?blFkS0w5T0phMitycGlMS2pVVlo4UjdrRUQxVndwQWI2UWRIZ2sreURGODhw?=
 =?utf-8?B?RnR6ZmFpUUVMSjlTem93QWd5Zjg0RGpYMEJHd3ltZmliMTFIQUpoY2Z5NFY4?=
 =?utf-8?B?Slk5ODlpUnNwdFZpREY5VXJONUpzZC9CdTJRQ2F2cXJiYXgxUk5xUDMxRi90?=
 =?utf-8?B?NTBEdEQ0UjZnQTY3ZVZNSlNRZU9nbEdPbGdIeURDNCt3ZE5MV1VOV2JqaE5O?=
 =?utf-8?B?M3Q5MFlzRUoxVzRYa29wTjR6cHljNVU1MzNXcFdRZ3pxdVZSZzYxRkZNZHNs?=
 =?utf-8?B?VU5WQzdMVDZ2OTVUMDhTSE9EdnZuRnJRampLQWwvdnhYampsWXVrKzNTdlp0?=
 =?utf-8?B?UnJKVTZaSytNQy8zZkd0VDZ4ZnJFMlV5S2Flb1FVVmdwaFQ2d1M5Wk44cTZ3?=
 =?utf-8?B?b3UvZzNLcmVBSzYyS0VibkRJR2F6dEpybzhsV3JqVzBURFVjNkVLNlBGcDd2?=
 =?utf-8?B?R1VXYStlMUJ4eGxrZGZBbmF0Sm1xRERkQkxILzRCNWwxN0x0WmNGVzNwNFNj?=
 =?utf-8?B?SVRaYXBCWUgwNGxCa1dsa0svMmk1RlRVWkNCczAxNXBRUUFqNE92QThUZnRY?=
 =?utf-8?Q?tYCA6p+rbSqWQjfJVz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a3ac65-eca7-418f-fb80-08def24327fd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:12:18.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+pW5dmnfymO8JEvJf/HECm5HeiwTFGCVCQR84IOyN6OQghsFFZJ/ID147LvdZqsbUdlPHeu64bxdLiKTx/Row==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9230


On 28/07/26 02:53, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/27/26 18:49, Christian Loehle wrote:
>> On 7/27/26 15:01, Christian Loehle wrote:
>>> On 7/17/26 22:53, Sumit Gupta wrote:
>>>> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
>>>> 8.4.6.1.2.6), which conveys the desired nominal performance level
>>>> at which the platform may run. Unlike the existing read-only
>>>> Nominal Performance register, it is writable and lets OSPM
>>>> request a lower nominal level than the platform-reported nominal.
>>>> The platform classifies performance above this level as boosted
>>>> and below as throttled for its power/thermal decisions.
>>>>
>>>> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
>>>> match the cpufreq sysfs unit convention:
>>>>
>>>>    /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>>>>
>>>> The attribute is documented in
>>>> Documentation/ABI/testing/sysfs-devices-system-cpu.
>>>>
>>>> Writes are converted to perf via cppc_khz_to_perf(), validated
>>>> against [Lowest Performance, Nominal Performance], and applied to
>>>> the policy->cpu. The register is assumed shared across the
>>>> policy->cpus.
>>>>
>>>> On read, the current register value is returned, or
>>>> "<unsupported>" if the platform does not implement the register.
>>>>
>>>> Also add the register to the OSPM-set register save/restore
>>>> table, so its value survives CPU hotplug and reverts to the
>>>> firmware value on driver unload, like the other registers in
>>>> the table.
>>>>
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>>   .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++++
>>>>   drivers/acpi/cppc_acpi.c                      | 32 +++++++++++++
>>>>   drivers/cpufreq/cppc_cpufreq.c                | 47 +++++++++++++++++++
>>>>   include/acpi/cppc_acpi.h                      | 10 ++++
>>>>   4 files changed, 115 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> index 82d10d556cc8..a8d592c08823 100644
>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>> @@ -346,6 +346,32 @@ Description:   Performance Limited
>>>>
>>>>              This file is only present if the cppc-cpufreq driver is in use.
>>>>
>>>> +What:              /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>>>> +Date:              May 2026
>>>> +Contact:   linux-pm@vger.kernel.org
>>>> +Description:       OSPM Nominal Performance (kHz)
>>>> +
>>>> +           OSPM uses this attribute to request a nominal performance
>>>> +           level lower than the platform-reported nominal. The
>>>> +           platform treats performance above this level as boost
>>>> +           and below as throttle for power and thermal decisions.
>>>> +
>>>> +           Read returns the current value in kHz, or "<unsupported>"
>>>> +           if the platform does not implement the register. Write a
>>>> +           kHz value in the range [lowest_freq, nominal_freq].
>>>> +
>>>> +           Note that tasks may be migrated from one CPU to another
>>>> +           by the scheduler's load-balancing algorithm, and if
>>>> +           different OSPM Nominal Performance values are set for
>>>> +           those CPUs (through different cpufreq policies), that may
>>>> +           lead to undesirable outcomes. To avoid such issues it is
>>>> +           better to set the same value across all policies, or to
>>>> +           pin every task potentially sensitive to it to a specific
>>>> +           CPU.
>>>> +
>>>> +           This file is only present if the cppc-cpufreq driver is
>>>> +           in use.
>>>> +
>>>>   What:              /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>>>   Date:              August 2008
>>>>   KernelVersion:     2.6.27
>>>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>>>> index a7fec6c93178..681d4fd40c11 100644
>>>> --- a/drivers/acpi/cppc_acpi.c
>>>> +++ b/drivers/acpi/cppc_acpi.c
>>>> @@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>>>
>>>> +/**
>>>> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
>>>> + * @cpu: CPU on which to write register.
>>>> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
>>>> + *
>>>> + * OSPM Nominal Performance conveys the desired nominal performance level
>>>> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
>>>> + * must lie within [Lowest Performance, Nominal Performance] and may be
>>>> + * set independently of Minimum, Maximum and Desired performance. The
>>>> + * caller is responsible for validating the range.
>>>> + *
>>>> + * Return: 0 on success or negative error code.
>>>> + */
>>>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>>>> +{
>>>> +   return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>>>> +
>>>> +/**
>>>> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance register.
>>>> + * @cpu: CPU from which to read register.
>>>> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance value.
>>>> + *
>>>> + * Return: 0 on success or negative error code.
>>>> + */
>>>> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
>>>> +{
>>>> +   return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
>>> It's a write-only register, we need to track everything in the driver.
>>>
>> So just reread Pierre's comments, TBH I don't see the point of ever
>> reading it, even for sysfs reads, but I don't think
>> reading it for cppc_cpufreq_get_effective_nominal() would be valid
>> in any case?
> FWIW desired_perf was read/write up until ACPI 6.5 and only 6.6 marked
> it as write-only. I don't think we should be reading it either on
> platforms advertising 6.6.
> I will clarify and send a patch.

Good catch that ACPI 6.6 makes Desired Performance write-only,
and thanks for the patches preventing those reads.

The same reasoning applies to OSPM Nominal Performance, so I will treat
it as write-only: make ospm_nominal_freq write-only, remove show(), and
drop cppc_get_ospm_nominal_perf().
Boost and policy limits will use the last value the driver successfully
wrote, falling back to the platform reported Nominal Performance when
nothing has been set.

On unload, I will reset it to the platform Nominal Performance only if
the driver wrote it during its lifetime. Otherwise the register is left
untouched, since the pre-driver value cannot be read back.

Thanks,
Sumit


