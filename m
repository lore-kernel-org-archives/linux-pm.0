Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AF54652;
	Tue,  9 Jun 2026 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999193; cv=fail; b=N+uvBy3W21An0F4G5kP0EXztU5ZT9P2Q9Ob4Aqyf6J3woYB99IGvFtmGY+tHM5gTWobDCZzFdIVGXhfPYCbRH4KrirEAf+4YdxVlTCKakvkRu7o8izxRUYNQ3JXDiUcl1/vyNQHv4wwjLmGaIq7FhNISB2c+3SDx2CzU2j+z0Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999193; c=relaxed/simple;
	bh=cvhTw0HAaDPc4yuZttbubLE9xfHCqavnYAhc/m07DzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BZJy5g03I35dBODDO67EIk736Dkh9D/cmeQrZow/sINRvVpTu2Bao8NrmwJz/PWJ523eLIr3blhExWFWkYTBHvk9ohEzOwGpaKKxFPUsWoH1Ko2HupVyTeL+YVgaC8EAL9P23rnHisd4/r1DgTdu7O2X6S9jM7wPooK5l3khHbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bkr2Xtc/; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bkr2Xtc/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtD1qDrQsZbmpUXtCjdMQ6spuHbeXkoVke42ZWQIJ/c0ARxy3/kRBMRo7GvZnlcBsnxxeuHy1g70ZSR6r/fjt9XAGc9ZwnhGkju+VGPYJUoWqJxVYFHrqCV15REFvqngyrh68ANSrDKHDbj49l/r7QFeWIF0w/QFi82BOzHejrcGSQNL//QX4ewFFooJCffNNnVYfMTOaRtnEm7VxkO7BPdoo6E4iBxNbS/AW4W9xMIU+OUEK/5gkirJ/cN6ds3523G3Gz08zKMm9JTPhcUIShQwrvQwzu0acqO4u/h2gaAVUfO+OUd9/6gv3E9JyDKQLZ4by4PmvvFKcjUc1QAfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7qXujrRHmgIok0ILMiKdjRd5oB863p2S/mDfuhIPhU=;
 b=w0FMz7NLSXh5NIDcHmZ425+GfAMvqEq/cvqT+6Y+TXtbIOdssoz/xGaD6Q6hRAEBSXv37/DrAfhjggJW4o0SNdfcK5IT6gxJ3Kc0+j56t3wt9fmyU2csG2mvUB27ItyXPE3BAXtNSYrBC57xnUUm9kwzR8qlATjPst7mzJYZEFE1Axd2NNv3l737XoGAsC7phXlKvNsOq8SKPkOMzv8CK+RRFlC425dDaKzVMrP38q1G3woeWu0tRRV0QZQ7CnoQNSDROcvtypowZ4qC6450leqhgHA6e9FejU1pKl3nl/l/uKGkGzB4eidwmyShclW5zU/6DVP3aiA2/MtR5Egryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7qXujrRHmgIok0ILMiKdjRd5oB863p2S/mDfuhIPhU=;
 b=Bkr2Xtc//LuromwNwPSEc/r2oVrZVP6YuC7G9/7yxxlA7X5RsJvvE09g9Ur4rWmaQsmF/si52nzLrFoiVPQU7o5gzuA1oXbBOpsLTO7kvc5P/ddbcUXim2akxhYpwcRtlfAvqQc/RDUrQogECtaPniSRN4v7XnKdZxUfMO1FRQ1tmuui4lqOa2KuXn6sjy+qAt8c1MaRXZxIAQ4nGwGwQAgDaW1Dxu++1zBvVkUYELrSgMZRZ5zsPHqVGSSi1cRrYal9i8AlSKoXiZwGbA6a6BJOvsD63PreIXOInLty0ry//9rpch7f/CBSK5RCjoYQGIQ7hADADu8rL9GVrBT0rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH0PR12MB7011.namprd12.prod.outlook.com (2603:10b6:510:21c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 09:59:49 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0113.011; Tue, 9 Jun 2026
 09:59:48 +0000
Message-ID: <aa25ab45-7e92-4f89-85d4-464c68149892@nvidia.com>
Date: Tue, 9 Jun 2026 15:29:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, mario.limonciello@amd.com,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260527194626.185286-1-sumitg@nvidia.com>
 <20260527194626.185286-3-sumitg@nvidia.com>
 <CAJZ5v0icPAmaiThjgUTxWRymNGBQFarodurJhODFOkLKpVwtOQ@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0icPAmaiThjgUTxWRymNGBQFarodurJhODFOkLKpVwtOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH0PR12MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f90c5c5-7295-4f81-a6fe-08dec60dd73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|6133799003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003;
X-Microsoft-Antispam-Message-Info:
	rUAyeq0GlDzAKc3AXm1qIqM8Y2W4Yeqjd6b81cdpyTEg91CbpBZShH4VZUwHeHGaU0NTaO0joa5jmJ4oD0JIdmUgj817mPCnKKrFTQ40YLkdZbtyn4VggmZq6O/NIArv/ixIE0cgv/kK7ba6xpwi7saAXqbMKJnI32ZYEb/3vibrY0/OnEzCYzN60RLuNFR4gyth4zg5SzD5ffTLuwD9XtznV6s4DAOKnMcH3X0nOnAqx2BI0qFYBs4EAy+/nm/LWC95QOENQhPjNPmshQ/WLRl5eHHhfmiO8Ilr/I+3S0e7H17LqKxZWAS0wVHjtc+VGiRaLRcP0Bf66xkw96CnU3Pg2u39tn4+Pv58ciZjule87p8xUshYl6Z+rGm3wQW7YAClBVAQZQz+S6wBeVoWMPyLWedyI9cEGgHgqlzUPWQhdAbgo0u2b8aaRUI/+b8sXoRRp8+tD9bsLU+UKb2hUobS8Tk7Ub9n9PpL2++pgzFQUdOyG88Lm4n36a3qx5/ruDPSZ2vt3+cS8OztkhcZkY/o44zekI07kOk9dY0Izr2n28KsZMwtu7JLRCVg3siT+7kXC4C/KacyyoFVhh47/56+tvTjAeNi6a5y4gz5jFwPoGxKd8e1AFFxARybFUqV2CYH0jq/ZXcmEaQ9HtHbE2j207O6HqThaRBYcYPqUSdYIzrsAQqVvlNGMjWL/NMi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlg1Z2F6czF0UzBKRVdHdE4yenJ4SEhaK1dLMmRRSU1DU21uZFN0R2hFeTVa?=
 =?utf-8?B?L1R5MHd6ZEhLeVRWTnhlYnY0MzJ3LzU5Z3F3K1ZNY2labElONU5KS3pqMThn?=
 =?utf-8?B?WG4rNU1Kb2VERkcrV295Z0daZWQ4UDlYcitocGN6TEZ5UFlaVlBXNmpyVk9p?=
 =?utf-8?B?VC9Jd3h0ZDRHbnpSK09OR2k5NE0zT05ZWm03d01aY1cvelM4UWJoQkVuNDlH?=
 =?utf-8?B?N0ZsMXpyMldMNDZGOVNjMTFVRmx6bHphb0VhQ2ZXL2M0UlN1cWhZZno4Zk4y?=
 =?utf-8?B?cTZFUUovRFUwUGZKSVpJWS9SaHNxQkRFcmhiTGNCSTJqQXc5NkFKQ3NuVEVm?=
 =?utf-8?B?Z1IwSmFFNndLeW02bWZFREVVL1hHUlp5K05wdVFHTHdUZG1UQnRsWjJvWlY4?=
 =?utf-8?B?RVVnTTBvbmczbXVXU1hGSEo5NGtLbVg5YWRXdnorV3hUczhWbmM4QXp1WG50?=
 =?utf-8?B?ZTJSZGNlbjh6dFh3WWlGSjZSaTJnaUZ0L0daQkp5dDBLaW42d20xMis2QVNR?=
 =?utf-8?B?S3RuRHdHUVdYLzNEWFFGQXpmamZUcVFsRjFqK0hIdTdUL0FZeWVXdEs0RVRH?=
 =?utf-8?B?a3VHeVhYQjJ5YVNvaTZ5Q0lrR3dZYnpQM05KczM4bm9tQmE3d2tVTGp0dDlo?=
 =?utf-8?B?OGdkQ3EzdzYrMkJkbjREb0pHcHlnUU1TY2RBendMVVJ5Tmw5UUNEem1XMndN?=
 =?utf-8?B?UlFiUC9uN2ZVbVNCbHlKWUVRRWxrMXFXQUkyem9VeVl1cjlNU0VDTHdBdFhj?=
 =?utf-8?B?TXpqUGV0ZjNGYlA5UDlwQnE2aDkvWGx2MUcycmFCV0VacWNHRmg0WU1ObS8z?=
 =?utf-8?B?eGtMd0o4aVF4L055dlBsRnA2OW1HOFU4Y1J4MWFJTy9rS05PT2Fwb1U5RW9H?=
 =?utf-8?B?UTBXZHA0OU05V3Q5am0vaDB3ekxXVEdiR1FWV3pvTDl3OEs0bDl6ZmhMeXh0?=
 =?utf-8?B?YTFFd1JYd0NNait4bDdUbGp1STRkSVBZU1QrS1pGVkkwK0FoR0g0ek56R1VN?=
 =?utf-8?B?M2lybEh6QTBheHRSTmZrZU94YnlWdXJkU0pTVEZzbHovS3d4RDFQR1BobGhF?=
 =?utf-8?B?RUltRVlqbzdaY3dyZFZEZFhVNXlSakI0N3dqR1VnN0VBN285SFd1cFBZeWZT?=
 =?utf-8?B?c0Q4S0tQQnBwQ3QzUjBtdG5aNlN0T0lBNjIrdmlnUkpDOVQrK1JMVEVlalBQ?=
 =?utf-8?B?TWIvTXlrRmtJVWUxNnNqY2xZUWJSQzJwem1hMkxxdEtKazAvd3ZMRmJmbjdG?=
 =?utf-8?B?QzdsWEpXa1RlSnQybTcxdHZVemxOZEs2QjF1TXVYd0I3S2Z4NG9xbUFTZ2Vk?=
 =?utf-8?B?NzVqcmEwSlRKT0dYaTNVQnJWL1g4Q3FJUGlKdUdORFZHcTdtQ2R2dFNydnV4?=
 =?utf-8?B?M05GcTk2U0ZqODlBVG5RT0xGaThWNCtERU80RHpvTHAwODMxcnB1WkcwSmhG?=
 =?utf-8?B?TmFVWXVSTE44WlQvKzI3akxiUUlsUXJrR3l5WmFobmxwZzh0ck9KZkNTbmVR?=
 =?utf-8?B?MFVMaHV1YWxkUEFYaktoRG01cC9uMWNmSnZkMDNVQzlvNXpkbkdNMEVybm5N?=
 =?utf-8?B?Q2NCVHpnODlHREVlaGNlRGdzSzZhMk5jV0hBTVNlWEphcGlQTGtud3NFamJK?=
 =?utf-8?B?RFI3UEdyZVM4bVdjZ2lSMG9oamI0amVzVzBiNmljNzk5aDlBdDV3QlFQVTdp?=
 =?utf-8?B?aWE1S1lET2ZWN0xrYnk2TVBlL21TUUljcUpVeFVnU0UvUzdBYnRBZDc3amZ4?=
 =?utf-8?B?SWFGQ0N2MldldFcvYjMwOEh4TEl2ZXMwdzNQbThlSGRTQWRkK1N5UUxDMUcr?=
 =?utf-8?B?Rzg2cnBvQ0ZIWlFQUDVhWGFOaTc0N1ZCdDJIRHZ6ZnowMVcyRmhxQmFENzJT?=
 =?utf-8?B?Wnl6RTd0YzhxSldKV0FMeHJNY1B0c1ROckRvUmh1SzZoOVpSZzZHSHErR2Fa?=
 =?utf-8?B?S3AwVEozZWRyeS91SFBsYjAwNjZvcmNQTDRONGhVZnJoekNkVGVBOFJnN0Fk?=
 =?utf-8?B?OVQ0bzZuYW5hTjlyKzBiRnNlZ0h1aG9ERTE0UG1xUS9ydE9EYVpQbWh1T0Za?=
 =?utf-8?B?ajlVMWxMc2hqSEgxYWMxTnVseWQ5RHM2eHpZT2lheU1McU11SjZPTUtMa0xo?=
 =?utf-8?B?K3MxU05rQ21XcEpZWXlVOFFJMzBjRDl4Z0R4RUFpbVVsM3prZDAxbjFtRG5n?=
 =?utf-8?B?MkJEcmdBYmEzcmVabzk2aTUwUXZINGFJTGsrejhhZG1hNEZZclFiNkt2a3lH?=
 =?utf-8?B?djRmQ3pVR1M0ZnlkM1lpcDZoMlVDVmI0ZEV0MTFuL1FPc2RYUHRiVHptalMx?=
 =?utf-8?B?TFFiakU4QkdBTk40TkpqTTlJSVEyaDlPWXYvakQ3R2RPUVFVanc5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f90c5c5-7295-4f81-a6fe-08dec60dd73c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:59:48.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTnVMZWMz9IsmUSVPT4mn0pIjSUao2ZmGff7CWSTS82RqrCuSBFJBtuGfLVvyE0axREI4Oi8qfByR4Qq0DD87w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7011


On 01/06/26 23:07, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, May 27, 2026 at 9:47 PM Sumit Gupta <sumitg@nvidia.com> wrote:
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
>>    /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
>>
>> The attribute is documented in
>> Documentation/ABI/testing/sysfs-devices-system-cpu.
>>
>> Writes are converted to perf via cppc_khz_to_perf(), validated
>> against [Lowest Performance, Nominal Performance], and applied to
>> every CPU in policy->cpus.
>>
>> The register is write-only; the kernel caches the last written
>> value in struct cppc_cpudata for sysfs readback (returns 0 until
>> userspace writes a value).
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> There is some sashiko.dev feedback on this one that is valid AFAICS:
>
> https://sashiko.dev/#/patchset/20260527194626.185286-1-sumitg%40nvidia.com


Thanks for sharing. Will address all four in v5.


 > Could this validation reject valid frequencies on systems with CPPC
 > favored cores?

1.
In v5, moved the range check into store_ospm_nominal_freq() in
cppc_cpufreq.c, where it uses the same cpu_data->perf_caps as the
kHz->perf conversion. OSPM Nominal is treated as a single per-policy
value. It's validated once against the policy caps and applied to all
CPUs in policy->cpus. This avoids validating against a sibling's
separately-read caps.


 > When the platform's ACPI _CPC table does not support this register,
 > will this unconditionally return '0' instead of an error like
 > -EOPNOTSUPP?

2.
In v5, added cppc_get_ospm_nominal_perf() and dropped the cached
value. show() now reads the register and returns "<unsupported>"
on -EOPNOTSUPP.


 > Are newly onlined CPUs missing this cached ospm_nominal_perf value?

3.
show() now reads the register directly and not cached value, so it
always reflects true per-CPU state.


 > Does skipping this rollback loop when prev_set is false leave the CPUs
 > in a desynchronized state?

In v5, the cache and ospm_nominal_perf_set bool are removed and
show() reads the register, so a partial write is no longer hidden.
sysfs shows the real per-CPU value, not '0').
store() reads the current value before writing and restores it on
already updated CPUs if a sibling write fails, so there is no
first write skip.

Thank you,
Sumit Gupta
....


