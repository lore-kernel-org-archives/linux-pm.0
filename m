Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010004.outbound.protection.outlook.com [52.101.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621E481226;
	Mon, 18 May 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112256; cv=fail; b=Ax8WeDPoahj1ppn+V0aszjUPf+/WfJiAR7ww02MEPBF7/ZzehuumJxupYnPgBdDwJHv6/tDeV1UyM6EcvkHhrTOwpStnRPX29+oGP5Oy/O97JgbbX00LdtLVVRst3Q7nLaoyq0M8x0/CIk/O5etLVQaWOTCVrI8bu6qqiuBtGPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112256; c=relaxed/simple;
	bh=MdWciFir2txCBx9p7ISZRWB/9w78nGPLW0+pvw1Ljk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ujKryrctNto25dHU/geuZiJvSDPC10Q6mmzdlC1tVz9jC/tuMy7JC5tE0rQDo5VEyjJQUIO+xze6NnSIWaQs1Duf9npyV+8WWDxy0bV3idTIm8KckJ0g+KqLU1rK9LUXCCyVIv4ScE7cKYnYlFcXRijMRvlnnM+7aQiuHiHvo8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L09W3Adk; arc=fail smtp.client-ip=52.101.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L09W3Adk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLOd2CmLpMpeyV66UD3fNw+YfXIx5haHRtbao3RHqwqfYTEupPp74uOIx8cDMGFNl16Nz+UR2b9ZJJMUO+q2NdX6swphosRB19WfZP2pXP3XsyhBDnuCbfioWk9AgH3HwdUwqDwbMt7cBlNyFw3Mt2xc2CwrYLEB0kUYNrMUnJaePNoS0t0q/p6D+Njni5n38p0IrH4ukGJL4r7p8LeidQkjN9ki/ujHrwCBt2/qHB2tmoUB2zCAHxnp/t+URkiX2GhSPOnwHtli3RQWdz2Lf2Lx8N2fR37fTzfENDiuiu7Mf0JasW98atoN0lq0kASiYQPlWlMNL/UBai7D2iQU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRoDd98ALEVQVW6ZV0f2ZTZuvzLy31aHN6EDD/5NRPU=;
 b=HpAt2HK9jHslD64sRseH+GbBpCMD8934vp/4dkeNHoVnLr+wSfs2W93J9LM7VAlik3xYyn+hl/ynKaiWUMLqD7Fha7dP7Lk7u8jhCToKBctrORvHXCQD6h4ejoW9IDSFVZdEejzQP48JQqCdBzBBzMZFdkCBxWjNQ2dkW8Y0f6sMbCpJaBNejFMTJjx6QtLI8Pj9/J57UOt2Jfs87YTd3fLElKiR7hgAR01qQeY3lHRXL4cu1ws4nhm1c4vSVjv7TFzIIGH/uxnkxxFAAYmVJXdrhfsRSAyXwiYTf2F1knzZpSzl5vgypvvPMkTeTEMGNGF4B1rodRQRi1uRXsdC2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRoDd98ALEVQVW6ZV0f2ZTZuvzLy31aHN6EDD/5NRPU=;
 b=L09W3AdkfQSWGxH7DBhn43vlZrH66dsYUODIxhfFZlv5+/HtOE59xvdTxURT8nUG6Nxsd+gY5hUkFXYpVq2iMh++kwZV0Nna5g3zaYbxfg4i95BMMy+Fjg4Y6wQfo22ViLV4BcDn763pmrTwFhF9M7PHTRMEZbp5edmRJ2GSsC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 13:50:49 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Mon, 18 May 2026
 13:50:49 +0000
Message-ID: <72fd2fcc-6303-4980-beb7-e4b711ad6406@amd.com>
Date: Mon, 18 May 2026 08:50:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
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
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <139d2f0e-72d9-4721-9d5a-d1d4a2a95fa1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:806:6f::14) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 343a8a16-083d-426e-e52f-08deb4e477ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003|3023799003|921020|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	6wEeKgJwqqgk/3tDVq5uNuZ3mOnA07BnD3+KMgKwlX1iYfswMjiwCIMSb0VxKrcJGz6lfQJT3Gba72KUXvQIg/voBUL3CA7MukbprI9RhMQB4lkrelTNTXgsrjtmAB0mM3CP/AlYIzQSlsrWpmuZbB7+WFV/Lr1aBY/x6r2rN/3gnqq32O2Pl/M6ClmbiVuPG+sBp9HZfp3gGw58qb46vpCuMwyCW9ao5CTvwcIwBNU5vRTnWbNHHCeJQnaN6eeAUZ8JP+xLjxobEkCHJBLh0KGofSn2yxEASqo6NNZOs2g7ESBaWs9rBS0+1HuXUHtLSbRKY4eL6tpXdzOrPj8zL/Sb1Dsm0rv1kxmGZlorGIXaty74ENUPijrGdpDygHZSTDC5m6YWe2xec2ey/ZDHdQ0aguNSOmmnQPJtas25NwCtBVp8QkfCx2z+vEHNu3zGRhWjTPjv1l8itUbZvOLqxW0oLqPtRMO6XphHzk+ZmFAF56kDs/zv5yDLSvTdLX82bHkekqXCQXhbQ9cJG8OIBNHCA+RghB18SZAW17wIrv7cZODxQWjTmPlRGua58ABcytTZ4v+Y3XJFJ4seppDWGS+yt7CH7ZgQv84Pi967F2h9qJB4JRkmJwsxcWFbz0XHKV2CZRN2X8XNGTSO+Mu1rSN9R39IGHR47GpkNTmx1JyHaJCRldJzHXVeLDvQVrF0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003)(3023799003)(921020)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXM2Q3FxbWJmZmF2SXNaRzlNN2tabnQ3d2hBNHZKMTBIcHE5aVM4cUVjYzRx?=
 =?utf-8?B?WXhWVGkzWVJ4RTNsVmZHT3BpYTNPQnBwbnVXbDZZVmlKYmNDVVpmcEhZWWVY?=
 =?utf-8?B?dEovNjJZZkdNbVcrSWpwenZvbGRBZHpnTzdUZyt2VHo3aHhJNXdFcyt5aFg5?=
 =?utf-8?B?YkpOMXk0TERPT1QzZWtHNFh4dUtiaXJPK3ZNcjUraW1iRkl4OWxXK2d3MG8r?=
 =?utf-8?B?dEZjaTFWVnlNS0o5S1ZNN0ttNTdYdE4xYTZPSkN2TWZqRjVudm94b01PMDFa?=
 =?utf-8?B?SGlhcFhyaUV5bU5XY3lDTEFXVGpMMyt5WGFqYkNoRlRkL2V5Q1VuVFFZelpy?=
 =?utf-8?B?TjVSUnVMUzJ3TC8vcFpwbDAvQlNSRmYrRndXMENJbGVGS0s5T3ZEOXcwVm9B?=
 =?utf-8?B?WlFEaFZiRXFMWWt5K01JTjMyZnBVQTFTOE81U1ZidDBob2xLcXptelQrMHk4?=
 =?utf-8?B?TlFpWUdsYW96Ui9UUlMxK0MrZEMwSTZsV01yVHRLbHNqTndvaGhMNTNveDd1?=
 =?utf-8?B?U3pEdlVoeTZ4RklvMDI4VWkra0NrcnlxMkVSc0ZqdVFhSy9lRTJOaERVMDY3?=
 =?utf-8?B?K0NCM3Q4bHF1TDl5WHY5bWVQY0dvNFJDcFdMVnBlazhGdCt2SHE5MmJCdURn?=
 =?utf-8?B?SWM3aDg4QUVTQUNCc0RFeFJwWXppOVFVejIvV29kMjBFNUZyTkJVcmFBOUx5?=
 =?utf-8?B?NEgwQS9oL0VYRTRXRFRDbkMzc256KzBhY1NqM0k2RDVQQkd3RHZreXViNUxC?=
 =?utf-8?B?NFJlVlJDVGdndHU3b2k5WXBpRHBSSDh2bEVEbS9sdEE5TWFiNlBJMVBOS0l1?=
 =?utf-8?B?Sk03NWM2WDlTb2hXZGcyQU55UUMwTEhKMmhBd2JCb296Q2lRMDhMZnRqUEIv?=
 =?utf-8?B?UjV3NlQ5bzVHZXNPUm5saG13blltL1NGQnlEUURGUENIRjBJU0k2WG4ydzB2?=
 =?utf-8?B?SmNrQXMrMnNBVkN6WE11YWllaGFETmE0WTJBSkZPdjBISTZybmpHV0N5eWp1?=
 =?utf-8?B?QUVmV281ZmJwa01EWisxTUV1L3d0THpneUJIWXNTWTVobU8ySHAwUmVkdXRW?=
 =?utf-8?B?N1M5VThjeFpKOUhkYXNBYmZ6UFROTVFHdUFmL0Z6L2xOUkFxUER3T3FvVkJu?=
 =?utf-8?B?UGNnbnpmL0tGbUpPOU1vTmRMYlNIelRXcXNlTmU2a0VBMXRDcDQ4N1JXOVAw?=
 =?utf-8?B?OHRJUFpIbWhZM0lFVmMxZnp5L1hRb0h5WlJHbE5zS0hYaVg0NW9lMGNOazZw?=
 =?utf-8?B?RTY2b3NkOEZKVkpNNUFZUXVWMGNxSzloR3ZsWHVyaERuZ05JWWRDZ29xRGJQ?=
 =?utf-8?B?RHpvNkRRYmFtaURubXR5OGl5TG5hbFJ2RXdLR28yTmRkU3M4Qjl1Y21kSG5l?=
 =?utf-8?B?SktQMWUzQm1aZFpUd2lZT0VONk9pQ3ZnNVFxa0dzR2RDYllIU05QWFVyeDd1?=
 =?utf-8?B?dmhvQjY2c1hGeWU3MjVtTHkzZ3ltbjVRRWN2MW5rVHVnZFdOLzRpM2hjU0Ey?=
 =?utf-8?B?VndLMEVyQzZGUkhMdXBEZmlaZ2RPUVh3bUdwdXhZc3V3Yzh4ZFUrdVJ0V3Q2?=
 =?utf-8?B?MXhEb2trck96OEkzdnJhL3VuV1N5aTlPdDZ6Qjduc2orTHkvcVkyRXBsM2ln?=
 =?utf-8?B?NXdrMllxL0hpd1B4MHhqR2dlOFY4MTYxM3FRV3YreUJKT2NpUzQ5WHdOQVIr?=
 =?utf-8?B?V1lPRlRKbUVJdCtnQ01uUEtKM1hud2RsWFlGaTZMSVNWZE9jSEpuRklzUjl2?=
 =?utf-8?B?a3Nha0lEeFNWS3NmYm5WVDJEVHB4aVFXdUR6MXMvajhNRFBXQW9QSkM0ZWtw?=
 =?utf-8?B?dGVJcFNrYzl5QmE4MlZNd1dPV2VIbE1GRkFpNG9sa21uWVM2RUlvbGg3eDJu?=
 =?utf-8?B?eVVsNG8zQlI1YlVtUmFUMTBvMkppckhQUmh4dVdYTGNrRjNaK0VRZXc5WEZl?=
 =?utf-8?B?WFY5VlFhR3YxN1FSZGdBWHhzbitkNnR5Q05NeFQyZHdWQm51SGljN2hEMVN1?=
 =?utf-8?B?QmFDSGlUdVRKakdDNFgyVURlb25YVWdIV3ZnVFFLS21SZ042bkltcEl1YnBa?=
 =?utf-8?B?aXRlN1d1ZVNqdjdSc2FFT0h1OUo0d1JqWi9JeUNrNURJTWY5L3dRQWFILzRl?=
 =?utf-8?B?amo3eWh5RnM0bEJOelBub3JlMjk2REpNOElUOXNrKzNBVnZMb0x4d0lpY1lB?=
 =?utf-8?B?bjZnWFhXRmRybGR3Z09CVEhGaFZJMjFFZ2lKS2VIclNVVnZ1cXlwaEVENmdE?=
 =?utf-8?B?cWh3REpkakoyRVNBUTZqUXhObXIwTVRRbzQwK0o1NlRwWjROWGtINnQzcTY0?=
 =?utf-8?Q?8OAbPGkB9AhFdnoflM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343a8a16-083d-426e-e52f-08deb4e477ac
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 13:50:48.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/O4wMqeNtr5dMtaRs1F5CS5xYPp/+2wKS51OvnxBljkoFWyWcecur0b4QFoNLbacuE/EbD4e8qU+NJ7fSKZhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264



On 5/18/26 08:44, Sumit Gupta wrote:
> Hi Mario,
> 
> 
> On 16/05/26 02:43, Mario Limonciello wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/15/26 07:26, Sumit Gupta wrote:
>>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>> CPPC autonomous performance selection on all CPUs at system startup.
>>> When autonomous mode is enabled, the hardware automatically adjusts
>>> CPU performance based on workload demands using Energy Performance
>>> Preference (EPP) hints.
>>>
>>> When the parameter is set:
>>> - Configure all CPUs for autonomous operation on first init
>>> - Use HW min/max_perf when available; otherwise initialize from caps
>>> - Initialize desired_perf to max_perf as a starting hint
>>> - Hardware controls frequency instead of the OS governor
>>> - EPP behavior depends on parameter value:
>>>    - performance (or 1): override EPP to performance preference (0x0)
>>>    - default_epp (or 2): preserve EPP value programmed by BIOS/firmware
>>>
>>> The boot parameter is applied only during first policy initialization.
>>> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
>>>
>>> This patch depends on patch series [1] ("cpufreq: Set policy->min and
>>> max as real QoS constraints") so that the policy->min/max set in
>>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>>> during init.
>>>
>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>> ---
>>> [1] https://lore.kernel.org/lkml/20260511135538.522653-1- 
>>> pierre.gondois@arm.com/
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         |  16 +++
>>>   drivers/cpufreq/cppc_cpufreq.c                | 122 +++++++++++++++++-
>>>   2 files changed, 133 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/ 
>>> Documentation/admin-guide/kernel-parameters.txt
>>> index 0eb64aab3685..7e4b3a8fd76f 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -1048,6 +1048,22 @@ Kernel parameters
>>>                       policy to use. This governor must be registered 
>>> in the
>>>                       kernel before the cpufreq driver probes.
>>>
>>> +     cppc_cpufreq.auto_sel_mode=
>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous performance
>>> +                     selection. When enabled, hardware automatically 
>>> adjusts
>>> +                     CPU frequency on all CPUs based on workload 
>>> demands.
>>> +                     In Autonomous mode, Energy Performance 
>>> Preference (EPP)
>>> +                     hints guide hardware toward performance (0x0) 
>>> or energy
>>> +                     efficiency (0xff).
>>> +                     Requires ACPI CPPC autonomous selection register
>>> +                     support.
>>> +                     Accepts:
>>> +                       performance, 1: enable auto_sel + set EPP to
>>> +                                       performance (0x0)
>>> +                       default_epp, 2: enable auto_sel, preserve EPP 
>>> value
>>> +                                       programmed by BIOS/firmware
>>> +                     Unset: cpufreq governors are used (auto_sel 
>>> disabled).
>>
>> Rather than unset doing nothing, have you considered having it take a
>> midpoint like 128?  That's what we do in amd-pstate (default to
>> balance_performance).  I think it turns into a reasonable balance. 
> 
> Thanks for the suggestion.
> I can add balance_performance that enables auto_sel with EPP=128 in v4.
> 
> On changing the driver default (no param behavior) to auto enable
> balance_performance, it would be good to keep the current behavior for
> now since cppc_cpufreq is generic across ARM64/RISC-V platforms where
> EPP and Autonomous Selection registers are optional.
> A default change would affect existing users relying on governors.
> 
> Thank you,
> Sumit Gupta

But couldn't you make the "no module parameter set" follow the behavior 
to only set the registers if they're available?

So the systems that support it start using it, the ones that don't it's 
a NOP.

> 
> 
>>
>>> +
>>>       cpu_init_udelay=N
>>>                       [X86,EARLY] Delay for N microsec between assert 
>>> and de-assert
>>>                       of APIC INIT to start processors.  This delay 
>>> occurs
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/ 
>>> cppc_cpufreq.c
>>> index 6b54427b52e1..5f4d735e7c7d 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>> @@ -28,6 +28,43 @@
>>>
>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>
>>> +/* Autonomous Selection boot parameter modes */
>>> +enum {
>>> +     AUTO_SEL_PERFORMANCE = 1,
>>> +     AUTO_SEL_DEFAULT_EPP = 2,
>>> +};
>>> +
>>> +static int auto_sel_mode;
>>> +
>>> +static int auto_sel_mode_set(const char *val, const struct 
>>> kernel_param *kp)
>>> +{
>>> +     if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
>>> +             *(int *)kp->arg = AUTO_SEL_PERFORMANCE;
>>> +     else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "2"))
>>> +             *(int *)kp->arg = AUTO_SEL_DEFAULT_EPP;
>>> +     else
>>> +             return -EINVAL;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int auto_sel_mode_get(char *buffer, const struct kernel_param 
>>> *kp)
>>> +{
>>> +     switch (*(int *)kp->arg) {
>>> +     case AUTO_SEL_PERFORMANCE:
>>> +             return sysfs_emit(buffer, "performance\n");
>>> +     case AUTO_SEL_DEFAULT_EPP:
>>> +             return sysfs_emit(buffer, "default_epp\n");
>>> +     default:
>>> +             return sysfs_emit(buffer, "disabled\n");
>>> +     }
>>> +}
>>> +
>>> +static const struct kernel_param_ops auto_sel_mode_ops = {
>>> +     .set = auto_sel_mode_set,
>>> +     .get = auto_sel_mode_get,
>>> +};
>>> +
>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>   static enum {
>>>       FIE_UNSET = -1,
>>> @@ -715,11 +752,75 @@ static int cppc_cpufreq_cpu_init(struct 
>>> cpufreq_policy *policy)
>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>
>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> -     if (ret) {
>>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>> -                      caps->highest_perf, cpu, ret);
>>> -             goto out;
>>> +     /*
>>> +      * Enable autonomous mode on first init if boot param is set.
>>> +      * Check last_governor to detect first init and skip if auto_sel
>>> +      * is already enabled.
>>> +      */
>>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>>> +         !cpu_data->perf_ctrls.auto_sel) {
>>> +             /* Init min/max_perf from caps if not already set by 
>>> HW. */
>>> +             if (!cpu_data->perf_ctrls.min_perf)
>>> +                     cpu_data->perf_ctrls.min_perf = caps- 
>>> >lowest_nonlinear_perf;
>>> +             if (!cpu_data->perf_ctrls.max_perf)
>>> +                     cpu_data->perf_ctrls.max_perf = policy- 
>>> >boost_enabled ?
>>> +                             caps->highest_perf : caps->nominal_perf;
>>> +
>>> +             /*
>>> +              * In autonomous mode desired_perf is only a hint; EPP and
>>> +              * the platform drive actual selection within [min, max].
>>> +              * Initialize it to max_perf so HW starts at the upper 
>>> bound.
>>> +              */
>>> +             cpu_data->perf_ctrls.desired_perf = cpu_data- 
>>> >perf_ctrls.max_perf;
>>> +
>>> +             policy->cur = cppc_perf_to_khz(caps,
>>> + cpu_data->perf_ctrls.desired_perf);
>>> +
>>> +             /*
>>> +              * Override EPP only in 'performance' mode; 
>>> 'default_epp' mode
>>> +              * preserves the BIOS/firmware programmed EPP value.
>>> +              * EPP is optional - some platforms may not support it.
>>> +              */
>>> +             if (auto_sel_mode == AUTO_SEL_PERFORMANCE) {
>>> +                     ret = cppc_set_epp(cpu, 
>>> CPPC_EPP_PERFORMANCE_PREF);
>>> +                     if (ret && ret != -EOPNOTSUPP)
>>> +                             pr_warn("Failed to set EPP for CPU%d 
>>> (%d)\n", cpu, ret);
>>> +                     else if (!ret)
>>> + cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
>>> +             }
>>> +
>>> +             /* Program min/max/desired into CPPC regs (non-fatal on 
>>> failure). */
>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> +             if (ret)
>>> +                     pr_warn("set_perf failed CPU%d (%d); using HW 
>>> values\n",
>>> +                             cpu, ret);
>>> +
>>> +             ret = cppc_set_auto_sel(cpu, true);
>>> +             if (ret && ret != -EOPNOTSUPP)
>>> +                     pr_warn("auto_sel CPU%d failed (%d); using OS 
>>> mode\n",
>>> +                             cpu, ret);
>>> +             else if (!ret)
>>> +                     cpu_data->perf_ctrls.auto_sel = true;
>>> +     }
>>> +
>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>> +             /* Sync policy limits from HW when autonomous mode is 
>>> active */
>>> +             policy->min = cppc_perf_to_khz(caps,
>>> + cpu_data->perf_ctrls.min_perf ?:
>>> + caps->lowest_nonlinear_perf);
>>> +             policy->max = cppc_perf_to_khz(caps,
>>> + cpu_data->perf_ctrls.max_perf ?:
>>> + (policy->boost_enabled ?
>>> + caps->highest_perf :
>>> + caps->nominal_perf));
>>> +     } else {
>>> +             /* Normal mode: governors control frequency */
>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>> +             if (ret) {
>>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>>> ret:%d\n",
>>> +                              caps->highest_perf, cpu, ret);
>>> +                     goto out;
>>> +             }
>>>       }
>>>
>>>       cppc_cpufreq_cpu_fie_init(policy);
>>> @@ -1079,10 +1180,21 @@ static int __init cppc_cpufreq_init(void)
>>>
>>>   static void __exit cppc_cpufreq_exit(void)
>>>   {
>>> +     unsigned int cpu;
>>> +
>>> +     for_each_present_cpu(cpu)
>>> +             cppc_set_auto_sel(cpu, false);
>>> +
>>>       cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>>       cppc_freq_invariance_exit();
>>>   }
>>>
>>> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 
>>> 0444);
>>> +MODULE_PARM_DESC(auto_sel_mode,
>>> +              "Enable CPPC autonomous performance selection at boot: "
>>> +              "performance or 1 (EPP=performance), "
>>> +              "default_epp or 2 (preserve BIOS/firmware EPP)");
>>> +
>>>   module_exit(cppc_cpufreq_exit);
>>>   MODULE_AUTHOR("Ashwin Chaugule");
>>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ 
>>> spec");
>>

