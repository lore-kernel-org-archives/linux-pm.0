Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE851325707
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478099; cv=fail; b=hRXzC+GaY6wQmDdRrQ9XHrRAtFaNU9xws4hr5myH7ZAopUPdhXhnL/G8F0Ub+JosgRxUUATxR+V+SepyqLZ1jZmVnxF9yCB83VOb2gAjlc/t6cFOQ4cMHAeZSxYS0u/Z6JZtw4qd8SSMeKexRMAweiI+aU/pYfxWGOfxG60Wahg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478099; c=relaxed/simple;
	bh=rcL3lrmf13Hn4bd0j2XUPcn/xaCxnqFPiMxckriRel4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QxrI54o2adlJWbx0muVXUeYMe0hxvyp5Q3c4AviETcgDqzF8IltatOfYA1m/6BmzIDpZVQg9I6Jdo8NsvfZjq+1hRkLui47qNP7B2rOdQPTiO2d/l8MqIzFuKGzwTL9W7epkBXPlq5xF1CFPSN/1v+g8M+juTOLD7KJ7VMM8/xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FParDI/o; arc=fail smtp.client-ip=52.101.62.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FParDI/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyqeQ0rmIzB4c/Y4/jF79E6V8+KWmrdFDNYH7V63/S0NxVURGw/vt/WpRtf9vsTSnC1UDMBtV3YUihJ0nvIz4GU5FHtO2cnRk/nsze+sp8/yARZbUqhUEaMALMEwvoxsy8L0M8OrsQQE5JMW3ELsqLq0eSR/dtkXtGz/+XPdYMTz62bPt7T/0FtIn4TOQnSMpE1qkxnt7wIT6Z8982YXVzbJ8/7bqoqR3m5GYM5aK1U6l0/YWV2+sJZTe6GBZJSQqNyHvgewmzG4NUZDBrnFhEfXfWrfIZtvOjHi3A/Cf4RPkBzExtF4+gzzqAynMqmUrwgxWucJsoyb681juUXVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bFZwpGNa3C7eFx8HBosJWSIwodMU4IgEBzl2HBMOVA=;
 b=EH/UtArtGNQhYuTQZPhDPBTI/NXnGg5myPtdgIx1Ij+RcHAjtykPGSZ3Rw0qwebXfwok64/+C8AltJqeF7Dqm/PC1H5vu9K47pXAwiajRS8DHhR6rvpQfyX22eXcoQZD/etsnCj0EbGozn0HAjOvAYplvYegXl9XtTwuepIp+FS/iEjUQQ9XpMI3cNHTd+6Bfde9I3FYLTRQrpgN77GPcon4+ZHBlgBVqkyuCwrUKMaPTFkGlrC7FOdoqbGLpG+DPF8P98P2U2pUmCPoTBKEsjvzuWOBXejw9FpV+n72k95KgUaoWH8WclTor9sv6+u3hSCjzO1IyDXt4WLO35kzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bFZwpGNa3C7eFx8HBosJWSIwodMU4IgEBzl2HBMOVA=;
 b=FParDI/ovSb2kTGWuuDDvdklEErsw2NlzlJ8kFtK1k21kQqeT5AjsnnYYsMbYr9i8gzHSK4IrKYSQWAJ7KXk724pXYj3xe59/sSIac8Oqupg4ACC3y8IhK1MMgJZ+8LL2aIiQeVOf3qOV0zJZx1p7z8eXcFnUy+svN9lbU5PXlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 15:54:49 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 15:54:47 +0000
Message-ID: <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
Date: Wed, 29 Apr 2026 10:54:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
Content-Language: en-US
To: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>, Huang Rui <ray.huang@amd.com>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0251.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::16) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CY8PR12MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2275ec-0111-45c8-ead7-08dea607a385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|18092099006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	b4bcbK3kwrDeAOzwiPmIqlSmm8SiMUCovwqBbt3dt+C70MlKrKhmC7rN02Jv4vC8w+5urs4FI9l4WFIWgh/zt+w7xwIWFxrbdnU+CSAczLPT9VY7Kwrn7UvA9GMp401j/OnClEaMY3M9AweBbyCegTZMs7tLssfryU/ozEug8V8MvZtM+yyLGM/g/RI+CSTWgTWObjR4lIzA9LqhgCihsDehUEmsEd1oFz7XCzWFZxk/x+USi5TibKH/FPOxDbn0o4pxljC4CJ+x0/BpzITogQtNSUjmuLu83WcMtpZTaCtvUalgCRS4yVXmG3wqmIGt1K7UuiJgeYWMbUrgGAEDkyxSABbCODFXvkFLTQTLJktIizZ84B4qgyuSdCgwdwTMeJZqthrHQYpnH6DXkAQWLLP1DhcoVrOe7P82aG6rEs/VUxYGW/uHosLF8pYGlVSm6LokrPpeSim696ljdiIkX6s/Q61nqs0nPw9zVz7lYcwWHN8CBEMJr3KlUpClNMEZAvJVLK7IfUYcPFt4Wu4MATfawi20EQXOuMHSCGhdYom6CJtWWogWGukwp8fbMoJUmZXK8FtncTYeJ02CKcXY3t1yn0B/2/0T7QWto633wm7TwhX7stXDXvf2xqj18osrtsvb055SlAPw8fAJqIzWn9wVRX12Isib/Xo8FEYJBNZ96Eax2ULqFCN/wcvkbWaBQXjNtWsZQuGRAn9DNtIuTpAq1uZK7SBUhVMUA80xWXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(18092099006)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFAxQkhBV0ExME9BUE9RK2NXcDhJZ0NHZVZPSkdCdm9DRGRxNzM5TFppWUhv?=
 =?utf-8?B?ajJuQUFJN1lxS3p0dEJyc3JsYU1lV3FQYkxvMkZYazhOVnBieUN0VW5uTjk2?=
 =?utf-8?B?T29LT05BWlNGdnhNalozbjNndGQybDgvbEtRRHlkOWNhNDBMT0VETGhSOE9C?=
 =?utf-8?B?YUlrMDF2NFYyOEVwamNkTVY1UGJmUEVQemx3bDhXYm9uSEk2Mm1wRWdkckls?=
 =?utf-8?B?bG84N2RLZDIxZnEzdmRyNXdrQmFGVmFPTHdXRjc3MUFua3lRc3ZUalVEdWpr?=
 =?utf-8?B?dDZjc3FrUHVIRlB3K3ZlYmNqQzJtZlFoZm44cVA4MDNXVFl4bWR5VDlCSFRa?=
 =?utf-8?B?Rmo3b2FiNXNsVDM4YmlWMzVRNWNaTXpaLy9YUUMwcWVMREIybGp2bFlZU3FW?=
 =?utf-8?B?dWp6cW5WMTg1blhhRFlPRFFVa1hHVWt0S2R6cjg2N1lsaG5LQXdsWlJJK1J0?=
 =?utf-8?B?MFpwVCtGaDdvc2NReFN4NTJBVWJaVjdjQ2Z6NmF0NnFuYWZLdWo1LzNkQ2NU?=
 =?utf-8?B?N0FCMFhOQmZpWW9FekFTNGxMaXJLbDdiUWx3c2cvQjFlMmphL25MWHpHUFRP?=
 =?utf-8?B?REREYzBKejY3WkhtenZ5TkFTd25CeEpMOXk1S3ZVSUlVT25VTStRMVkyT0RI?=
 =?utf-8?B?MGJaK3FIR3VNQzhIeS9mdTRTRndFYU1YWTJCRnN1eFEzUm1jR1FKZy9NMm5J?=
 =?utf-8?B?aXRxamNPdkhrNVRTT0J5VTJGM1F3THZldTM1NFpFK2c4MEJnZ2gxQ3d0QjVs?=
 =?utf-8?B?QjR0RFEvbE5pdUFQbytTUU8yTiszb0RmWGhmNkE2NkRSNUZwQnNIMWJQeitL?=
 =?utf-8?B?NHdDN3NGRkNhR3NZSjdGRFpCek4xWjl1d1g0Wk9LMW96ZGRLYnRHZ0lqSitS?=
 =?utf-8?B?d3N4RTR1a1IxZ0pEenl6ZzZTbUEydWpTbU9mV1h0VUsvUmVDWkNZZnBLZ1gz?=
 =?utf-8?B?MjVEc1FVZVlxSXd5K1REQzVuU1d2SzBTODhvSFJ5K0JxbDJ5Qzl0Q2JpaURY?=
 =?utf-8?B?L0hudEE2NTVGeUxzVzdkc0U4UHdBL1hydDJoQUw3dDZxMXYzUzJuUG1SOGxZ?=
 =?utf-8?B?QXhJNlZZVFB0dE1QYnVCblVrUlpPelZaVGdSbTVrOXgyWTJ2cU5kcXdCWWtu?=
 =?utf-8?B?YXlVcXFYMlRaaXBEdExUemZnVEZIU0Z5UmloSTBJRWZmZStSc3Z3UElxUjZy?=
 =?utf-8?B?M1hPQ2tYRW4zcktKVVBTWGZGWCt1YVFRNm0wSG5pcjd5dklYbTBsOGxLdW8r?=
 =?utf-8?B?aHY1Nng2M0U5Qk10MGppc2VENEg0UzFCWXJjUHpJa3MxNmxUUDk0V245SURT?=
 =?utf-8?B?WGNMV3ozVTFOMkVwaWdBSFp6SnZuS1RIQ3FOdW5NQ1Z3TlVoRFJoRmJ4eE1u?=
 =?utf-8?B?QUJudm1panMvVGkraGliTWJBWkloZlRvbXlUd0JZYW82WndpakFRQW15WnlE?=
 =?utf-8?B?RlpNbzJ0V0o3L2cyMlpHRmFaUFc4bU9JekFueVM4Uzg3SVAzcHZ0RFNGejhl?=
 =?utf-8?B?Mi9BZkNPd1cxTllzUHFiRUt5QUtBeS96eDJIcWdPbGR5b2dvbW5NRDdYL3Ru?=
 =?utf-8?B?dThpZFE1NmpiNkdtTWIrZ0p4ZWdWeWhRSG1Cb0NDWWdPajdjMWEzc2RPZGhq?=
 =?utf-8?B?dmxYazNxWFdLU2xQcXpEK1dFamtBVXh5aEgzbktQSWNDeEFabE9JbmlFL0NV?=
 =?utf-8?B?UVBoVXBVR3hIS0NBN3ZLNDNDZTV2VE44UVY0c1RSZENkVWk2bXV2TGt0TWpz?=
 =?utf-8?B?VDBtV0x0Q2RqOTMzL3RRNExHWGJ3LzJwUlJlRFhzOHUxTFpzQVpFeENBVm4y?=
 =?utf-8?B?dndiTWEzUEdnODNjalFkWXpFVmRBck9uQkZDVTRicG1sZDlQRzdodHh3VENE?=
 =?utf-8?B?Yk9vclBGMVk4ZjRHVThueGsyaHg5L0tDMCtJZG9mdXhDbktYNWRyV2pSaVFx?=
 =?utf-8?B?cXZORkFoSm5GR3JjRDlWTC9Cd3p5NHExRGlNY3JWVXZ2ZmhCeFZEYVB2WnVJ?=
 =?utf-8?B?dzJubDlXYzZnSDV0SkdobFhrazBsblN5RER3TU8yVXpadnFLeFdwYjNFR2Jp?=
 =?utf-8?B?VUk1a2hVVTArV2l2WXBxSkcxamF0YUc1SHBJK2RQUHlFQ2RwWUl5anA4ekYz?=
 =?utf-8?B?Rjk1Z1R2VUFVMEpQdnNWR0NaZlp6RC81UEpySUR5Wm1FN1kybFFMS1hpT2ti?=
 =?utf-8?B?VEJGak1HaDRmZWsvUjY5OUJDRE8xL1RpSHZxQm16WUJJSFlPY2dHVkhHUmlE?=
 =?utf-8?B?cjg4ZEhOZ2hzdWdDaVRDM3gxRmFuUkwvNHBvb01WRXlhZVg0MWh0VUFlS3Q0?=
 =?utf-8?B?cE4xN1owYWk0bzVmMGsyL3R6c041Tm5CSXk3c0ZqRXVXc09wQS9oZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2275ec-0111-45c8-ead7-08dea607a385
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 15:54:47.5040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIoxNOwV6B9iaHHO6Z/l4GExvKUcxPoTv9t5ST+fjo4zLqIaUhaUyIScnz2HET5ch/Yb6VjitrOvZu4Z05+enw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290



On 4/29/26 10:38, Viktor Jägersküpper wrote:
> Am 29.04.26 um 16:25 schrieb Mario Limonciello:
>>
>>
>> On 4/29/26 08:54, Viktor Jägersküpper wrote:
>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> Am 29.04.26 um 15:04 schrieb Mario Limonciello:
>>>>
>>>>
>>>> On 4/29/26 07:34, Viktor Jägersküpper wrote:
>>>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> Hi,
>>>>>
>>>>> when I boot my desktop system running with an AMD Ryzen 9 5900X using
>>>>> the kernel 7.1-rc1, all CPU cores seem to run at ~1.7 GHz constantly,
>>>>> i.e. I don't observe any core frequency boosting under load. This never
>>>>> happened with older kernel releases, e.g. with 7.0-rc7. I ran
>>>>> 'git bisect' and found this first bad commit:
>>>>>
>>>>> e30ca6dd5345c5b8ba05f346a8e81105352fe571 cpufreq/amd-pstate: Add dynamic energy performance preference
>>>>
>>>> If you compile with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=n (instead of using kernel command line to turn it off) does the issue go away?
>>>>
>>>
>>> No, and still nothing about amd-pstate in dmesg.
>>
>> Can you turn on dynamic debugging for amd-pstate.c?  Something like this:
>>
>> dyndbg='file drivers/cpufreq/amd-pstate.c +p'
>>
> 
> Both kernel builds (with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y/n) have the following config:
> CONFIG_DYNAMIC_DEBUG=y
> CONFIG_DYNAMIC_DEBUG_CORE=y
> 
> Booting with the above dyndbg parameter gives me only this line about amd-pstate in dmesg:
> [    0.844066] amd_pstate: AMD CPPC shared memory based functionality is supported
> 
> Do I have to do anything else besides booting with the dyndbg parameter? I have tried
> both builds.

You shouldn't have to.  I think there might be something silently 
failing in the init path now.  Maybe platform profile registration is 
failing for your system?  I haven't reproduced this on my side on any of 
my systems unfortunately.

Do you think you can sprinkle printk()'s around the init to figure it 
out?  If you need me to write a patch that does this I can try to whip 
one up.

> 
>>>
>>>>>
>>>>> I configured the amd-pstate driver as follows:
>>>>> CONFIG_X86_AMD_PSTATE=y
>>>>> CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
>>>>> CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y
>>>>> # CONFIG_X86_AMD_PSTATE_UT is not set
>>>>>
>>>>> Booting with "amd_dynamic_epp=disable" doesn't change anything, but as
>>>>> far as I can tell this new feature shouldn't affect my system at all.
>>>>> dmesg shows nothing about the amd-pstate driver (see below).
>>>>>
>>>>> Information about my system:
>>>>> AMD Ryzen 9 5900X (family: 0x19, model: 0x21, stepping: 0x2)
>>>>> AMD AGESA ComboV2 1.2.0.F (included in latest available BIOS)
>>>>> no overclocking/tuning
>>>>>
>>>>> Possibly related BIOS settings:
>>>>> Core Performance Boost - Auto
>>>>> SVM Mode - Enabled
>>>>> AMD Cool&Quiet function - Enabled
>>>>> PPC Adjustment - Pstate 0
>>>>> Global C-state Control - Auto
>>>>> Power Supply Idle Control - Auto
>>>>> CCD Control - Auto
>>>>> Downcore Control - Auto
>>>>> SMT Mode - Auto
>>>>> CPPC - Auto
>>>>> CPPC Preferred Cores - Auto
>>>>>
>>>>> Any ideas?
>>>>>
>>>>> Viktor
>>>>>
>>>>>
>>>>> #regzbot introduced: e30ca6dd5345c5b8ba05f346a8e81105352fe571
>>>>>
>>>>>
>>>>> [    0.000000] Linux version 7.1.0-rc1 (viktor@einstein) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Mon Apr 27 17:38:55 CEST 2026
>>>>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-linux-upstream root=/dev/mapper/nvme0n1p3-encrypted rw rd.luks.name=f57b6e73-6f79-41f3-b733-266aa9695b49=nvme0n1p3-encrypted loglevel=3 mitigations=off zswap.enabled=0 modprobe.blacklist=radeon amd_dynamic_epp=disable
>>>>> [    0.000000] BIOS-provided physical RAM map:
>>>>> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff]  System RAM
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009c3efff]  System RAM
>>>>> [    0.000000] BIOS-e820: [mem 0x0000000009c3f000-0x0000000009ffffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff]  System RAM
>>>>> [    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20dfff]  ACPI NVS
>>>>> [    0.000000] BIOS-e820: [mem 0x000000000a20e000-0x000000000affffff]  System RAM
>>>>> [    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [mem 0x000000000b020000-0x00000000b9d84fff]  System RAM
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000b9d85000-0x00000000bc941fff]  device reserved
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000bc942000-0x00000000bc991fff]  ACPI data
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000bc992000-0x00000000bd082fff]  ACPI NVS
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000bd083000-0x00000000bddfefff]  device reserved
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000bddff000-0x00000000beffffff]  System RAM
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000bf000000-0x00000000bfffffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000c0000000-0x00000000efffffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000f8000000-0x00000000fd1fffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fd200000-0x00000000fd2fffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fd300000-0x00000000fd5fffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fd600000-0x00000000fd7fffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fd800000-0x00000000fe9fffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fea10000-0x00000000feb7ffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fec02000-0x00000000fec0ffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fec11000-0x00000000fec2ffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fec31000-0x00000000fecfffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fed01000-0x00000000fed3ffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fed45000-0x00000000fed7ffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fed90000-0x00000000fedc1fff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fedd0000-0x00000000fedd3fff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff]  device reserved
>>>>> [    0.000000] BIOS-e820: [gap 0x00000000fedd6000-0x00000000feffffff]
>>>>> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]  device reserved
>>>>> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000103f2fffff]  System RAM
>>>>> [    0.000000] BIOS-e820: [mem 0x000000103f300000-0x000000103fffffff]  device reserved
>>>>> [    0.000000] NX (Execute Disable) protection: active
>>>>> [    0.000000] APIC: Static calls initialized
>>>>> [    0.000000] efi: EFI v2.7 by American Megatrends
>>>>> [    0.000000] efi: ACPI=0xbd06c000 ACPI 2.0=0xbd06c014 TPMFinalLog=0xbd036000 SMBIOS=0xbdbf3000 SMBIOS 3.0=0xbdbf2000 MEMATTR=0xb5bcd018 ESRT=0xb8079698 INITRD=0xb566be98 RNG=0xbc974018 TPMEventLog=0xbc972018
>>>>> [    0.000000] random: crng init done
>>>>> [    0.000000] efi: Remove mem309: MMIO range=[0xf0000000-0xf7ffffff] (128MB) from e820 map
>>>>> [    0.000000] e820: remove [mem 0xf0000000-0xf7ffffff] device reserved
>>>>> [    0.000000] efi: Remove mem310: MMIO range=[0xfd200000-0xfd2fffff] (1MB) from e820 map
>>>>> [    0.000000] e820: remove [mem 0xfd200000-0xfd2fffff] device reserved
>>>>> [    0.000000] efi: Remove mem311: MMIO range=[0xfd600000-0xfd7fffff] (2MB) from e820 map
>>>>> [    0.000000] e820: remove [mem 0xfd600000-0xfd7fffff] device reserved
>>>>> [    0.000000] efi: Not removing mem312: MMIO range=[0xfea00000-0xfea0ffff] (64KB) from e820 map
>>>>> [    0.000000] efi: Remove mem313: MMIO range=[0xfeb80000-0xfec01fff] (0MB) from e820 map
>>>>> [    0.000000] e820: remove [mem 0xfeb80000-0xfec01fff] device reserved
>>>>> [    0.000000] efi: Not removing mem314: MMIO range=[0xfec10000-0xfec10fff] (4KB) from e820 map
>>>>> [    0.000000] efi: Not removing mem315: MMIO range=[0xfec30000-0xfec30fff] (4KB) from e820 map
>>>>> [    0.000000] efi: Not removing mem316: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
>>>>> [    0.000000] efi: Not removing mem317: MMIO range=[0xfed40000-0xfed44fff] (20KB) from e820 map
>>>>> [    0.000000] efi: Not removing mem318: MMIO range=[0xfed80000-0xfed8ffff] (64KB) from e820 map
>>>>> [    0.000000] efi: Not removing mem319: MMIO range=[0xfedc2000-0xfedcffff] (56KB) from e820 map
>>>>> [    0.000000] efi: Not removing mem320: MMIO range=[0xfedd4000-0xfedd5fff] (8KB) from e820 map
>>>>> [    0.000000] efi: Remove mem321: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
>>>>> [    0.000000] e820: remove [mem 0xff000000-0xffffffff] device reserved
>>>>> [    0.000000] DMI: SMBIOS 3.3.0 present.
>>>>> [    0.000000] DMI: Gigabyte Technology Co., Ltd. B550 AORUS MASTER/B550 AORUS MASTER, BIOS F18 10/28/2025
>>>>> [    0.000000] DMI: Memory slots populated: 2/4
>>>>> [    0.000000] tsc: Fast TSC calibration using PIT
>>>>> [    0.000000] tsc: Detected 3693.076 MHz processor
>>>>> [    0.000384] e820: update [mem 0x00000000-0x00000fff] System RAM ==> device reserved
>>>>> [    0.000385] e820: remove [mem 0x000a0000-0x000fffff] System RAM
>>>>> [    0.000390] last_pfn = 0x103f300 max_arch_pfn = 0x400000000
>>>>> [    0.000395] total RAM covered: 3071M
>>>>> [    0.000473] Found optimal setting for mtrr clean up
>>>>> [    0.000473]  gran_size: 64K  chunk_size: 64M         num_reg: 3      lose cover RAM: 0G
>>>>> [    0.000475] MTRR map: 7 entries (3 fixed + 4 variable; max 20), built from 9 variable MTRRs
>>>>> [    0.000477] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
>>>>> [    0.000639] e820: update [mem 0xbcb00000-0xbcb0ffff] System RAM ==> device reserved
>>>>> [    0.000643] e820: update [mem 0xc0000000-0xffffffff] System RAM ==> device reserved
>>>>> [    0.000645] last_pfn = 0xbf000 max_arch_pfn = 0x400000000
>>>>> [    0.003181] esrt: Reserving ESRT space from 0x00000000b8079698 to 0x00000000b80796d0.
>>>>> [    0.003189] e820: update [mem 0xb8079000-0xb8079fff] System RAM ==> device reserved
>>>>> [    0.003214] Using GB pages for direct mapping
>>>>> [    0.003377] Secure boot disabled
>>>>> [    0.003377] RAMDISK: [mem 0xaf770000-0xb03c1fff]
>>>>> [    0.003391] ACPI: Early table checksum verification disabled
>>>>> [    0.003393] ACPI: RSDP 0x00000000BD06C014 000024 (v02 ALASKA)
>>>>> [    0.003396] ACPI: XSDT 0x00000000BD06B728 0000E4 (v01 ALASKA A M I    01072009 AMI  01000013)
>>>>> [    0.003399] ACPI: FACP 0x00000000BC978000 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
>>>>> [    0.003402] ACPI: DSDT 0x00000000BC94F000 00684A (v02 ALASKA A M I    01072009 INTL 20190509)
>>>>> [    0.003404] ACPI: FACS 0x00000000BD066000 000040
>>>>> [    0.003405] ACPI: SSDT 0x00000000BC987000 00AD59 (v02 GBT    GSWApp   00000001 INTL 20190509)
>>>>> [    0.003406] ACPI: SSDT 0x00000000BC97E000 008CE9 (v02 AMD    AmdTable 00000002 MSFT 04000000)
>>>>> [    0.003408] ACPI: SSDT 0x00000000BC97A000 003D7C (v02 AMD    AMD AOD  00000001 INTL 20190509)
>>>>> [    0.003409] ACPI: SSDT 0x00000000BC979000 000309 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
>>>>> [    0.003410] ACPI: FIDT 0x00000000BC971000 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
>>>>> [    0.003411] ACPI: MCFG 0x00000000BC970000 00003C (v01 ALASKA A M I    01072009 MSFT 00010013)
>>>>> [    0.003413] ACPI: HPET 0x00000000BC96F000 000038 (v01 ALASKA A M I    01072009 AMI  00000005)
>>>>> [    0.003414] ACPI: IVRS 0x00000000BC96E000 0001A4 (v02 AMD    AmdTable 00000001 AMD  00000001)
>>>>> [    0.003415] ACPI: FPDT 0x00000000BC96D000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
>>>>> [    0.003416] ACPI: BGRT 0x00000000BC96C000 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
>>>>> [    0.003417] ACPI: TPM2 0x00000000BC96B000 00004C (v04 ALASKA A M I    00000001 AMI  00000000)
>>>>> [    0.003419] ACPI: PCCT 0x00000000BC96A000 00006E (v02 AMD    AmdTable 00000001 AMD  00000001)
>>>>> [    0.003420] ACPI: SSDT 0x00000000BC963000 0061A3 (v02 AMD    AmdTable 00000001 AMD  00000001)
>>>>> [    0.003421] ACPI: CRAT 0x00000000BC961000 001190 (v01 AMD    AmdTable 00000001 AMD  00000001)
>>>>> [    0.003423] ACPI: CDIT 0x00000000BC960000 000029 (v01 AMD    AmdTable 00000001 AMD  00000001)
>>>>> [    0.003424] ACPI: SSDT 0x00000000BC95F000 000625 (v02 AMD    ArticDGP 00000001 INTL 20190509)
>>>>> [    0.003425] ACPI: SSDT 0x00000000BC95D000 001512 (v02 AMD    ArticTPX 00000001 INTL 20190509)
>>>>> [    0.003426] ACPI: SSDT 0x00000000BC95C000 000788 (v02 AMD    ArticNOI 00000001 INTL 20190509)
>>>>> [    0.003427] ACPI: SSDT 0x00000000BC958000 003A23 (v02 AMD    ArticN   00000001 INTL 20190509)
>>>>> [    0.003429] ACPI: WSMT 0x00000000BC957000 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
>>>>> [    0.003430] ACPI: APIC 0x00000000BC956000 00015E (v04 ALASKA A M I    01072009 AMI  00010013)
>>>>> [    0.003431] ACPI: SSDT 0x00000000BC976000 00147F (v02 AMD    ArticC   00000001 INTL 20190509)
>>>>> [    0.003432] ACPI: SSDT 0x00000000BC975000 0000BF (v01 AMD    AmdTable 00001000 INTL 20190509)
>>>>> [    0.003433] ACPI: Reserving FACP table memory at [mem 0xbc978000-0xbc978113]
>>>>> [    0.003434] ACPI: Reserving DSDT table memory at [mem 0xbc94f000-0xbc955849]
>>>>> [    0.003435] ACPI: Reserving FACS table memory at [mem 0xbd066000-0xbd06603f]
>>>>> [    0.003435] ACPI: Reserving SSDT table memory at [mem 0xbc987000-0xbc991d58]
>>>>> [    0.003435] ACPI: Reserving SSDT table memory at [mem 0xbc97e000-0xbc986ce8]
>>>>> [    0.003436] ACPI: Reserving SSDT table memory at [mem 0xbc97a000-0xbc97dd7b]
>>>>> [    0.003436] ACPI: Reserving SSDT table memory at [mem 0xbc979000-0xbc979308]
>>>>> [    0.003436] ACPI: Reserving FIDT table memory at [mem 0xbc971000-0xbc97109b]
>>>>> [    0.003437] ACPI: Reserving MCFG table memory at [mem 0xbc970000-0xbc97003b]
>>>>> [    0.003437] ACPI: Reserving HPET table memory at [mem 0xbc96f000-0xbc96f037]
>>>>> [    0.003437] ACPI: Reserving IVRS table memory at [mem 0xbc96e000-0xbc96e1a3]
>>>>> [    0.003438] ACPI: Reserving FPDT table memory at [mem 0xbc96d000-0xbc96d043]
>>>>> [    0.003438] ACPI: Reserving BGRT table memory at [mem 0xbc96c000-0xbc96c037]
>>>>> [    0.003438] ACPI: Reserving TPM2 table memory at [mem 0xbc96b000-0xbc96b04b]
>>>>> [    0.003439] ACPI: Reserving PCCT table memory at [mem 0xbc96a000-0xbc96a06d]
>>>>> [    0.003439] ACPI: Reserving SSDT table memory at [mem 0xbc963000-0xbc9691a2]
>>>>> [    0.003439] ACPI: Reserving CRAT table memory at [mem 0xbc961000-0xbc96218f]
>>>>> [    0.003440] ACPI: Reserving CDIT table memory at [mem 0xbc960000-0xbc960028]
>>>>> [    0.003440] ACPI: Reserving SSDT table memory at [mem 0xbc95f000-0xbc95f624]
>>>>> [    0.003440] ACPI: Reserving SSDT table memory at [mem 0xbc95d000-0xbc95e511]
>>>>> [    0.003441] ACPI: Reserving SSDT table memory at [mem 0xbc95c000-0xbc95c787]
>>>>> [    0.003441] ACPI: Reserving SSDT table memory at [mem 0xbc958000-0xbc95ba22]
>>>>> [    0.003441] ACPI: Reserving WSMT table memory at [mem 0xbc957000-0xbc957027]
>>>>> [    0.003442] ACPI: Reserving APIC table memory at [mem 0xbc956000-0xbc95615d]
>>>>> [    0.003442] ACPI: Reserving SSDT table memory at [mem 0xbc976000-0xbc97747e]
>>>>> [    0.003443] ACPI: Reserving SSDT table memory at [mem 0xbc975000-0xbc9750be]
>>>>> [    0.003490] No NUMA configuration found
>>>>> [    0.003490] Faking a node at [mem 0x0000000000000000-0x000000103f2fffff]
>>>>> [    0.003494] NODE_DATA(0) allocated [mem 0x103f2d4f80-0x103f2fffff]
>>>>> [    0.003972] ACPI: PM-Timer IO Port: 0x808
>>>>> [    0.003977] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
>>>>> [    0.003987] IOAPIC[0]: apic_id 25, version 33, address 0xfec00000, GSI 0-23
>>>>> [    0.003992] IOAPIC[1]: apic_id 26, version 33, address 0xfec01000, GSI 24-55
>>>>> [    0.003993] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>>>>> [    0.003994] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
>>>>> [    0.003996] ACPI: Using ACPI (MADT) for SMP configuration information
>>>>> [    0.003997] ACPI: HPET id: 0x10228201 base: 0xfed00000
>>>>> [    0.004003] e820: update [mem 0xb5b76000-0xb5bccfff] System RAM ==> device reserved
>>>>> [    0.004010] CPU topo: Max. logical packages:   1
>>>>> [    0.004010] CPU topo: Max. logical nodes:      1
>>>>> [    0.004011] CPU topo: Num. nodes per package:  1
>>>>> [    0.004012] CPU topo: Max. logical dies:       1
>>>>> [    0.004012] CPU topo: Max. dies per package:   1
>>>>> [    0.004014] CPU topo: Max. threads per core:   2
>>>>> [    0.004014] CPU topo: Num. cores per package:    12
>>>>> [    0.004015] CPU topo: Num. threads per package:  24
>>>>> [    0.004015] CPU topo: Allowing 24 present CPUs plus 0 hotplug CPUs
>>>>> [    0.004028] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
>>>>> [    0.004029] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
>>>>> [    0.004030] PM: hibernation: Registered nosave memory: [mem 0x09c3f000-0x09ffffff]
>>>>> [    0.004031] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20dfff]
>>>>> [    0.004032] PM: hibernation: Registered nosave memory: [mem 0x0b000000-0x0b01ffff]
>>>>> [    0.004032] PM: hibernation: Registered nosave memory: [mem 0xb5b76000-0xb5bccfff]
>>>>> [    0.004033] PM: hibernation: Registered nosave memory: [mem 0xb8079000-0xb8079fff]
>>>>> [    0.004034] PM: hibernation: Registered nosave memory: [mem 0xb9d85000-0xbddfefff]
>>>>> [    0.004035] PM: hibernation: Registered nosave memory: [mem 0xbf000000-0xffffffff]
>>>>> [    0.004036] [gap 0xc0000000-0xfe9fffff] available for PCI devices
>>>>> [    0.004037] Booting paravirtualized kernel on bare hardware
>>>>> [    0.004038] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
>>>>> [    0.007489] Zone ranges:
>>>>> [    0.007490]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>>>>> [    0.007491]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>>>>> [    0.007491]   Normal   [mem 0x0000000100000000-0x000000103f2fffff]
>>>>> [    0.007492]   Device   empty
>>>>> [    0.007493] Movable zone start for each node
>>>>> [    0.007493] Early memory node ranges
>>>>> [    0.007494]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
>>>>> [    0.007494]   node   0: [mem 0x0000000000100000-0x0000000009c3efff]
>>>>> [    0.007495]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
>>>>> [    0.007495]   node   0: [mem 0x000000000a20e000-0x000000000affffff]
>>>>> [    0.007495]   node   0: [mem 0x000000000b020000-0x00000000b9d84fff]
>>>>> [    0.007496]   node   0: [mem 0x00000000bddff000-0x00000000beffffff]
>>>>> [    0.007496]   node   0: [mem 0x0000000100000000-0x000000103f2fffff]
>>>>> [    0.007499] Initmem setup node 0 [mem 0x0000000000001000-0x000000103f2fffff]
>>>>> [    0.007503] On node 0, zone DMA: 1 pages in unavailable ranges
>>>>> [    0.007513] On node 0, zone DMA: 96 pages in unavailable ranges
>>>>> [    0.007589] On node 0, zone DMA32: 961 pages in unavailable ranges
>>>>> [    0.007598] On node 0, zone DMA32: 14 pages in unavailable ranges
>>>>> [    0.009410] On node 0, zone DMA32: 32 pages in unavailable ranges
>>>>> [    0.009492] On node 0, zone DMA32: 16506 pages in unavailable ranges
>>>>> [    0.065366] On node 0, zone Normal: 4096 pages in unavailable ranges
>>>>> [    0.065380] On node 0, zone Normal: 3328 pages in unavailable ranges
>>>>> [    0.065387] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:24 nr_cpu_ids:24 nr_node_ids:1
>>>>> [    0.065831] percpu: Embedded 63 pages/cpu s221184 r8192 d28672 u262144
>>>>> [    0.065837] pcpu-alloc: s221184 r8192 d28672 u262144 alloc=1*2097152
>>>>> [    0.065839] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15
>>>>> [    0.065842] pcpu-alloc: [0] 16 17 18 19 20 21 22 23
>>>>> [    0.065854] Kernel command line: BOOT_IMAGE=/vmlinuz-linux-upstream root=/dev/mapper/nvme0n1p3-encrypted rw rd.luks.name=f57b6e73-6f79-41f3-b733-266aa9695b49=nvme0n1p3-encrypted loglevel=3 mitigations=off zswap.enabled=0 modprobe.blacklist=radeon amd_dynamic_epp=disable
>>>>> [    0.065922] printk: log_buf_len individual max cpu contribution: 4096 bytes
>>>>> [    0.065922] printk: log_buf_len total cpu_extra contributions: 94208 bytes
>>>>> [    0.065923] printk: log_buf_len min size: 131072 bytes
>>>>> [    0.066031] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes
>>>>> [    0.066032] printk: early log buf free: 115336(87%)
>>>>> [    0.069616] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
>>>>> [    0.071427] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
>>>>> [    0.071545] software IO TLB: area num 32.
>>>>> [    0.078734] Fallback order for Node 0: 0
>>>>> [    0.078738] Built 1 zonelists, mobility grouping on.  Total pages: 16752182
>>>>> [    0.078739] Policy zone: Normal
>>>>> [    0.078875] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
>>>>> [    0.148681] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=24, Nodes=1
>>>>> [    0.157058] ftrace: allocating 56496 entries in 224 pages
>>>>> [    0.157059] ftrace: allocated 224 pages with 3 groups
>>>>> [    0.157145] Dynamic Preempt: full
>>>>> [    0.157213] rcu: Preemptible hierarchical RCU implementation.
>>>>> [    0.157213] rcu:     RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=24.
>>>>> [    0.157214] rcu:     RCU priority boosting: priority 1 delay 500 ms.
>>>>> [    0.157215]  Trampoline variant of Tasks RCU enabled.
>>>>> [    0.157215]  Rude variant of Tasks RCU enabled.
>>>>> [    0.157215]  Tracing variant of Tasks RCU enabled.
>>>>> [    0.157216] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
>>>>> [    0.157216] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=24
>>>>> [    0.157226] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
>>>>> [    0.157228] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=24.
>>>>> [    0.160206] NR_IRQS: 524544, nr_irqs: 1160, preallocated irqs: 16
>>>>> [    0.160387] rcu: srcu_init: Setting srcu_struct sizes based on contention.
>>>>> [    0.160488] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
>>>>> [    0.160526] Console: colour dummy device 80x25
>>>>> [    0.160528] printk: legacy console [tty0] enabled
>>>>> [    0.160563] ACPI: Core revision 20251212
>>>>> [    0.160667] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
>>>>> [    0.160684] APIC: Switch to symmetric I/O mode setup
>>>>> [    0.160978] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:0xa0
>>>>> [    0.160979] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:0xa0
>>>>> [    0.160980] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:0xa0
>>>>> [    0.160981] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:0xa0
>>>>> [    0.160981] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
>>>>> [    0.478446] x2apic: IRQ remapping doesn't support X2APIC mode
>>>>> [    0.479080] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
>>>>> [    0.483681] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x6a7792bdeec, max_idle_ns: 881590891415 ns
>>>>> [    0.483684] Calibrating delay loop (skipped), value calculated using timer frequency.. 7386.15 BogoMIPS (lpj=3693076)
>>>>> [    0.483697] x86/cpu: User Mode Instruction Prevention (UMIP) activated
>>>>> [    0.483726] LVT offset 1 assigned for vector 0xf9
>>>>> [    0.483727] LVT offset 2 assigned for vector 0xf4
>>>>> [    0.483905] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
>>>>> [    0.483906] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
>>>>> [    0.483910] process: using mwait in idle threads
>>>>> [    0.483911] mitigations: Enabled attack vectors: SMT mitigations: off
>>>>> [    0.483913] Speculative Store Bypass: Vulnerable
>>>>> [    0.483913] Spectre V2 : Vulnerable
>>>>> [    0.483914] Spectre V2 : User space: Vulnerable
>>>>> [    0.483915] Speculative Return Stack Overflow: Vulnerable
>>>>> [    0.483915] VMSCAPE: Vulnerable
>>>>> [    0.483916] Spectre V1 : Vulnerable: __user pointer sanitization and usercopy barriers only; no swapgs barriers
>>>>> [    0.483920] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
>>>>> [    0.483921] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
>>>>> [    0.483921] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
>>>>> [    0.483922] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
>>>>> [    0.483922] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
>>>>> [    0.483923] x86/fpu: Supporting XSAVE feature 0x1000: 'Control-flow Kernel registers (KVM only)'
>>>>> [    0.483924] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
>>>>> [    0.483924] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
>>>>> [    0.483925] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
>>>>> [    0.483926] x86/fpu: xstate_offset[12]:  856, xstate_sizes[12]:   24
>>>>> [    0.483926] x86/fpu: Enabled xstate features 0x1a07, context size is 880 bytes, using 'compacted' format.
>>>>> [    0.503034] pid_max: default: 32768 minimum: 301
>>>>> [    0.503129] landlock: Up and running.
>>>>> [    0.503131] Yama: becoming mindful.
>>>>> [    0.503264] LSM support for eBPF active
>>>>> [    0.503343] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
>>>>> [    0.503400] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
>>>>> [    0.503451] VFS: Finished mounting rootfs on nullfs
>>>>> [    0.605788] smpboot: CPU0: AMD Ryzen 9 5900X 12-Core Processor (family: 0x19, model: 0x21, stepping: 0x2)
>>>>> [    0.605899] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
>>>>> [    0.605902] ... version:                   0
>>>>> [    0.605902] ... bit width:                 48
>>>>> [    0.605903] ... generic counters:          6
>>>>> [    0.605903] ... generic bitmap:            000000000000003f
>>>>> [    0.605904] ... fixed-purpose counters:    0
>>>>> [    0.605904] ... fixed-purpose bitmap:      0000000000000000
>>>>> [    0.605904] ... value mask:                0000ffffffffffff
>>>>> [    0.605905] ... max period:                00007fffffffffff
>>>>> [    0.605905] ... global_ctrl mask:          000000000000003f
>>>>> [    0.605967] signal: max sigframe size: 3376
>>>>> [    0.605984] rcu: Hierarchical SRCU implementation.
>>>>> [    0.605985] rcu:     Max phase no-delay instances is 400.
>>>>> [    0.606013] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
>>>>> [    0.606170] MCE: In-kernel MCE decoding enabled.
>>>>> [    0.606193] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
>>>>> [    0.606283] smp: Bringing up secondary CPUs ...
>>>>> [    0.606329] smpboot: x86: Booting SMP configuration:
>>>>> [    0.606330] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
>>>>> [    0.633712] smp: Brought up 1 node, 24 CPUs
>>>>> [    0.633712] smpboot: Total of 24 processors activated (177267.64 BogoMIPS)
>>>>> [    0.635745] Memory: 65597208K/67008728K available (20069K kernel code, 2878K rwdata, 16092K rodata, 4788K init, 4820K bss, 1379168K reserved, 0K cma-reserved)
>>>>> [    0.636165] devtmpfs: initialized
>>>>> [    0.636165] x86/mm: Memory block size: 2048MB
>>>>> [    0.636791] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20dfff] (57344 bytes)
>>>>> [    0.636791] ACPI: PM: Registering ACPI NVS region [mem 0xbc992000-0xbd082fff] (7278592 bytes)
>>>>> [    0.636791] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
>>>>> [    0.636791] posixtimers hash table entries: 16384 (order: 6, 262144 bytes, linear)
>>>>> [    0.636791] futex hash table entries: 8192 (524288 bytes on 1 NUMA nodes, total 512 KiB, linear).
>>>>> [    0.636793] xor: automatically using best checksumming function   avx
>>>>> [    0.636889] PM: RTC time: 10:27:47, date: 2026-04-29
>>>>> [    0.637177] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>>>>> [    0.637386] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
>>>>> [    0.637767] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
>>>>> [    0.637908] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
>>>>> [    0.637911] audit: initializing netlink subsys (disabled)
>>>>> [    0.637915] audit: type=2000 audit(1777458467.161:1): state=initialized audit_enabled=0 res=1
>>>>> [    0.637915] thermal_sys: Registered thermal governor 'fair_share'
>>>>> [    0.637915] thermal_sys: Registered thermal governor 'bang_bang'
>>>>> [    0.637915] thermal_sys: Registered thermal governor 'step_wise'
>>>>> [    0.637915] thermal_sys: Registered thermal governor 'user_space'
>>>>> [    0.637915] thermal_sys: Registered thermal governor 'power_allocator'
>>>>> [    0.637915] cpuidle: using governor ladder
>>>>> [    0.637915] cpuidle: using governor menu
>>>>> [    0.637915] Detected 1 PCC Subspaces
>>>>> [    0.637915] Registering PCC driver as Mailbox controller
>>>>> [    0.637915] Freeing SMP alternatives memory: 56K
>>>>> [    0.639693] efi: Freeing EFI boot services memory: 86876K
>>>>> [    0.639696] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>>>>> [    0.639733] PCI: ECAM [mem 0xf0000000-0xf7ffffff] (base 0xf0000000) for domain 0000 [bus 00-7f]
>>>>> [    0.639739] PCI: Using configuration type 1 for base access
>>>>> [    0.639775] virt/tdx: TDX not supported by the host platform
>>>>> [    0.639816] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
>>>>> [    0.640711] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
>>>>> [    0.640711] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
>>>>> [    0.640711] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
>>>>> [    0.640711] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
>>>>> [    0.641028] raid6: skipped pq benchmark and selected avx2x4
>>>>> [    0.641030] raid6: using avx2x2 recovery algorithm
>>>>> [    0.641692] ACPI: Added _OSI(Module Device)
>>>>> [    0.641693] ACPI: Added _OSI(Processor Device)
>>>>> [    0.641694] ACPI: Added _OSI(Processor Aggregator Device)
>>>>> [    0.655960] ACPI: 12 ACPI AML tables successfully acquired and loaded
>>>>> [    0.657155] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>>>>> [    0.661736] ACPI: \_SB_: platform _OSC: OS support mask [006a7efe]
>>>>> [    0.662247] ACPI: Interpreter enabled
>>>>> [    0.662256] ACPI: PM: (supports S0 S3 S4 S5)
>>>>> [    0.662257] ACPI: Using IOAPIC for interrupt routing
>>>>> [    0.662470] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
>>>>> [    0.662470] PCI: Ignoring E820 reservations for host bridge windows
>>>>> [    0.662470] ACPI: Enabled 8 GPEs in block 00 to 1F
>>>>> [    0.667542] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>>>>> [    0.667546] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
>>>>> [    0.667620] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR DPC]
>>>>> [    0.667627] acpi PNP0A08:00: [Firmware Info]: ECAM [mem 0xf0000000-0xf7ffffff] for domain 0000 [bus 00-7f] only partially covers this bridge
>>>>> [    0.667830] PCI host bridge to bus 0000:00
>>>>> [    0.667832] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
>>>>> [    0.667833] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
>>>>> [    0.667834] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
>>>>> [    0.667834] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>>>>> [    0.667835] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
>>>>> [    0.667836] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfec2ffff window]
>>>>> [    0.667836] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xffffffff window]
>>>>> [    0.667837] pci_bus 0000:00: root bus resource [bus 00-ff]
>>>>> [    0.667846] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.667927] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600 conventional PCI endpoint
>>>>> [    0.667999] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.668057] pci 0000:00:01.1: [1022:1483] type 01 class 0x060400 PCIe Root Port
>>>>> [    0.668071] pci 0000:00:01.1: PCI bridge to [bus 01]
>>>>> [    0.668075] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
>>>>> [    0.668131] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
>>>>> [    0.668241] pci 0000:00:01.2: [1022:1483] type 01 class 0x060400 PCIe Root Port
>>>>> [    0.668255] pci 0000:00:01.2: PCI bridge to [bus 02-05]
>>>>> [    0.668258] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
>>>>> [    0.668260] pci 0000:00:01.2:   bridge window [mem 0xfcb00000-0xfcdfffff]
>>>>> [    0.668271] pci 0000:00:01.2: enabling Extended Tags
>>>>> [    0.668316] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
>>>>> [    0.668414] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.668467] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.668524] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400 PCIe Root Port
>>>>> [    0.668538] pci 0000:00:03.1: PCI bridge to [bus 06]
>>>>> [    0.668541] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
>>>>> [    0.668543] pci 0000:00:03.1:   bridge window [mem 0xfce00000-0xfcefffff]
>>>>> [    0.668548] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
>>>>> [    0.668599] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
>>>>> [    0.668912] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.668968] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669022] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669074] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400 PCIe Root Port
>>>>> [    0.669087] pci 0000:00:07.1: PCI bridge to [bus 07]
>>>>> [    0.669101] pci 0000:00:07.1: enabling Extended Tags
>>>>> [    0.669141] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
>>>>> [    0.669231] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669287] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400 PCIe Root Port
>>>>> [    0.669301] pci 0000:00:08.1: PCI bridge to [bus 08]
>>>>> [    0.669305] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcafffff]
>>>>> [    0.669316] pci 0000:00:08.1: enabling Extended Tags
>>>>> [    0.669360] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
>>>>> [    0.669470] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
>>>>> [    0.669551] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
>>>>> [    0.669640] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669660] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669680] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669702] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669722] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669741] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669761] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669780] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000 conventional PCI endpoint
>>>>> [    0.669858] pci 0000:01:00.0: [144d:a80a] type 00 class 0x010802 PCIe Endpoint
>>>>> [    0.669894] pci 0000:01:00.0: BAR 0 [mem 0xfcf00000-0xfcf03fff 64bit]
>>>>> [    0.670118] pci 0000:00:01.1: PCI bridge to [bus 01]
>>>>> [    0.670177] pci 0000:02:00.0: [1022:43ee] type 00 class 0x0c0330 PCIe Legacy Endpoint
>>>>> [    0.670217] pci 0000:02:00.0: BAR 0 [mem 0xfcda0000-0xfcda7fff 64bit]
>>>>> [    0.670228] pci 0000:02:00.0: enabling Extended Tags
>>>>> [    0.670290] pci 0000:02:00.0: PME# supported from D3hot D3cold
>>>>> [    0.670408] pci 0000:02:00.1: [1022:43eb] type 00 class 0x010601 PCIe Legacy Endpoint
>>>>> [    0.670450] pci 0000:02:00.1: BAR 5 [mem 0xfcd80000-0xfcd9ffff]
>>>>> [    0.670452] pci 0000:02:00.1: ROM [mem 0xfcd00000-0xfcd7ffff pref]
>>>>> [    0.670458] pci 0000:02:00.1: enabling Extended Tags
>>>>> [    0.670507] pci 0000:02:00.1: PME# supported from D3hot D3cold
>>>>> [    0.670588] pci 0000:02:00.2: [1022:43e9] type 01 class 0x060400 PCIe Switch Upstream Port
>>>>> [    0.670614] pci 0000:02:00.2: PCI bridge to [bus 03-05]
>>>>> [    0.670620] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
>>>>> [    0.670623] pci 0000:02:00.2:   bridge window [mem 0xfcb00000-0xfccfffff]
>>>>> [    0.670644] pci 0000:02:00.2: enabling Extended Tags
>>>>> [    0.670695] pci 0000:02:00.2: PME# supported from D3hot D3cold
>>>>> [    0.670773] pci 0000:00:01.2: PCI bridge to [bus 02-05]
>>>>> [    0.670873] pci 0000:03:08.0: [1022:43ea] type 01 class 0x060400 PCIe Switch Downstream Port
>>>>> [    0.670900] pci 0000:03:08.0: PCI bridge to [bus 04]
>>>>> [    0.670906] pci 0000:03:08.0:   bridge window [io  0xf000-0xffff]
>>>>> [    0.670909] pci 0000:03:08.0:   bridge window [mem 0xfcc00000-0xfccfffff]
>>>>> [    0.670932] pci 0000:03:08.0: enabling Extended Tags
>>>>> [    0.670992] pci 0000:03:08.0: PME# supported from D3hot D3cold
>>>>> [    0.671099] pci 0000:03:09.0: [1022:43ea] type 01 class 0x060400 PCIe Switch Downstream Port
>>>>> [    0.671126] pci 0000:03:09.0: PCI bridge to [bus 05]
>>>>> [    0.671134] pci 0000:03:09.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
>>>>> [    0.671157] pci 0000:03:09.0: enabling Extended Tags
>>>>> [    0.671216] pci 0000:03:09.0: PME# supported from D3hot D3cold
>>>>> [    0.671317] pci 0000:02:00.2: PCI bridge to [bus 03-05]
>>>>> [    0.671424] pci 0000:04:00.0: [10ec:8125] type 00 class 0x020000 PCIe Endpoint
>>>>> [    0.671494] pci 0000:04:00.0: BAR 0 [io  0xf000-0xf0ff]
>>>>> [    0.671500] pci 0000:04:00.0: BAR 2 [mem 0xfcc00000-0xfcc0ffff 64bit]
>>>>> [    0.671504] pci 0000:04:00.0: BAR 4 [mem 0xfcc10000-0xfcc13fff 64bit]
>>>>> [    0.671663] pci 0000:04:00.0: supports D1 D2
>>>>> [    0.671663] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>>>>> [    0.671932] pci 0000:03:08.0: PCI bridge to [bus 04]
>>>>> [    0.672031] pci 0000:05:00.0: [8086:2723] type 00 class 0x028000 PCIe Endpoint
>>>>> [    0.672104] pci 0000:05:00.0: BAR 0 [mem 0xfcb00000-0xfcb03fff 64bit]
>>>>> [    0.672242] pci 0000:05:00.0: PME# supported from D0 D3hot D3cold
>>>>> [    0.672422] pci 0000:03:09.0: PCI bridge to [bus 05]
>>>>> [    0.672501] pci 0000:06:00.0: [1002:6819] type 00 class 0x030000 PCIe Legacy Endpoint
>>>>> [    0.672529] pci 0000:06:00.0: BAR 0 [mem 0xe0000000-0xefffffff 64bit pref]
>>>>> [    0.672531] pci 0000:06:00.0: BAR 2 [mem 0xfce00000-0xfce3ffff 64bit]
>>>>> [    0.672533] pci 0000:06:00.0: BAR 4 [io  0xe000-0xe0ff]
>>>>> [    0.672535] pci 0000:06:00.0: ROM [mem 0xfce40000-0xfce5ffff pref]
>>>>> [    0.672556] pci 0000:06:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>>>>> [    0.672596] pci 0000:06:00.0: supports D1 D2
>>>>> [    0.672597] pci 0000:06:00.0: PME# supported from D1 D2 D3hot
>>>>> [    0.672717] pci 0000:06:00.1: [1002:aab0] type 00 class 0x040300 PCIe Legacy Endpoint
>>>>> [    0.672744] pci 0000:06:00.1: BAR 0 [mem 0xfce60000-0xfce63fff 64bit]
>>>>> [    0.672791] pci 0000:06:00.1: supports D1 D2
>>>>> [    0.672866] pci 0000:00:03.1: PCI bridge to [bus 06]
>>>>> [    0.672910] pci 0000:07:00.0: [1022:148a] type 00 class 0x130000 PCIe Endpoint
>>>>> [    0.672936] pci 0000:07:00.0: enabling Extended Tags
>>>>> [    0.673066] pci 0000:00:07.1: PCI bridge to [bus 07]
>>>>> [    0.673116] pci 0000:08:00.0: [1022:1485] type 00 class 0x130000 PCIe Endpoint
>>>>> [    0.673148] pci 0000:08:00.0: enabling Extended Tags
>>>>> [    0.673302] pci 0000:08:00.1: [1022:1486] type 00 class 0x108000 PCIe Endpoint
>>>>> [    0.673328] pci 0000:08:00.1: BAR 2 [mem 0xfc900000-0xfc9fffff]
>>>>> [    0.673331] pci 0000:08:00.1: BAR 5 [mem 0xfca08000-0xfca09fff]
>>>>> [    0.673336] pci 0000:08:00.1: enabling Extended Tags
>>>>> [    0.673466] pci 0000:08:00.3: [1022:149c] type 00 class 0x0c0330 PCIe Endpoint
>>>>> [    0.673493] pci 0000:08:00.3: BAR 0 [mem 0xfc800000-0xfc8fffff 64bit]
>>>>> [    0.673501] pci 0000:08:00.3: enabling Extended Tags
>>>>> [    0.673548] pci 0000:08:00.3: PME# supported from D0 D3hot D3cold
>>>>> [    0.673644] pci 0000:08:00.4: [1022:1487] type 00 class 0x040300 PCIe Endpoint
>>>>> [    0.673669] pci 0000:08:00.4: BAR 0 [mem 0xfca00000-0xfca07fff]
>>>>> [    0.673678] pci 0000:08:00.4: enabling Extended Tags
>>>>> [    0.673729] pci 0000:08:00.4: PME# supported from D0 D3hot D3cold
>>>>> [    0.673828] pci 0000:00:08.1: PCI bridge to [bus 08]
>>>>> [    0.674935] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
>>>>> [    0.674966] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
>>>>> [    0.674990] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
>>>>> [    0.675020] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
>>>>> [    0.675047] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
>>>>> [    0.675069] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
>>>>> [    0.675091] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
>>>>> [    0.675112] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
>>>>> [    0.675690] iommu: Default domain type: Translated
>>>>> [    0.675690] iommu: DMA domain TLB invalidation policy: lazy mode
>>>>> [    0.676765] SCSI subsystem initialized
>>>>> [    0.676770] libata version 3.00 loaded.
>>>>> [    0.676770] ACPI: bus type USB registered
>>>>> [    0.676770] usbcore: registered new interface driver usbfs
>>>>> [    0.676770] usbcore: registered new interface driver hub
>>>>> [    0.676770] usbcore: registered new device driver usb
>>>>> [    0.676770] EDAC MC: Ver: 3.0.0
>>>>> [    0.676786] efivars: Registered efivars operations
>>>>> [    0.676787] NetLabel: Initializing
>>>>> [    0.676788] NetLabel:  domain hash size = 128
>>>>> [    0.676789] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
>>>>> [    0.676798] NetLabel:  unlabeled traffic allowed by default
>>>>> [    0.676801] mctp: management component transport protocol core
>>>>> [    0.676801] NET: Registered PF_MCTP protocol family
>>>>> [    0.676805] PCI: Using ACPI for IRQ routing
>>>>> [    0.680259] PCI: pci_cache_line_size set to 64 bytes
>>>>> [    0.680314] e820: register RAM buffer resource [mem 0x09c3f000-0x0bffffff]
>>>>> [    0.680315] e820: register RAM buffer resource [mem 0x0a200000-0x0bffffff]
>>>>> [    0.680316] e820: register RAM buffer resource [mem 0x0b000000-0x0bffffff]
>>>>> [    0.680316] e820: register RAM buffer resource [mem 0xb5b76000-0xb7ffffff]
>>>>> [    0.680317] e820: register RAM buffer resource [mem 0xb8079000-0xbbffffff]
>>>>> [    0.680317] e820: register RAM buffer resource [mem 0xb9d85000-0xbbffffff]
>>>>> [    0.680318] e820: register RAM buffer resource [mem 0xbf000000-0xbfffffff]
>>>>> [    0.680318] e820: register RAM buffer resource [mem 0x103f300000-0x103fffffff]
>>>>> [    0.680707] pci 0000:06:00.0: vgaarb: setting as boot VGA device
>>>>> [    0.680707] pci 0000:06:00.0: vgaarb: bridge control possible
>>>>> [    0.680707] pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
>>>>> [    0.680707] vgaarb: loaded
>>>>> [    0.680708] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>>>>> [    0.680710] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
>>>>> [    0.682724] clocksource: Switched to clocksource tsc-early
>>>>> [    0.682821] VFS: Disk quotas dquot_6.6.0
>>>>> [    0.682828] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>>>>> [    0.682865] acpi PNP0C01:00: Reserved [mem 0xf0000000-0xf7ffffff]
>>>>> [    0.682869] acpi PNP0C02:00: Reserved [mem 0xfeb80000-0xfebfffff]
>>>>> [    0.682879] acpi PNP0C02:01: Reserved [mem 0xfd200000-0xfd2fffff]
>>>>> [    0.682947] acpi PNP0C02:02: Reserved [io  0x0a00-0x0a2f]
>>>>> [    0.682948] acpi PNP0C02:02: Reserved [io  0x0a30-0x0a3f]
>>>>> [    0.682948] acpi PNP0C02:02: Reserved [io  0x0a40-0x0a4f]
>>>>> [    0.682949] acpi PNP0C02:02: Reserved [mem 0xfe000000-0xfe00ffff]
>>>>> [    0.683025] acpi PNP0C02:03: Skipped [io  0x0010-0x001f]
>>>>> [    0.683026] acpi PNP0C02:03: Skipped [io  0x0022-0x003f]
>>>>> [    0.683026] acpi PNP0C02:03: Skipped [io  0x0063]
>>>>> [    0.683027] acpi PNP0C02:03: Skipped [io  0x0065]
>>>>> [    0.683027] acpi PNP0C02:03: Skipped [io  0x0067-0x006f]
>>>>> [    0.683028] acpi PNP0C02:03: Skipped [io  0x0072-0x007f]
>>>>> [    0.683028] acpi PNP0C02:03: Skipped [io  0x0080]
>>>>> [    0.683028] acpi PNP0C02:03: Skipped [io  0x0084-0x0086]
>>>>> [    0.683029] acpi PNP0C02:03: Skipped [io  0x0088]
>>>>> [    0.683029] acpi PNP0C02:03: Skipped [io  0x008c-0x008e]
>>>>> [    0.683030] acpi PNP0C02:03: Skipped [io  0x0090-0x009f]
>>>>> [    0.683030] acpi PNP0C02:03: Skipped [io  0x00a2-0x00bf]
>>>>> [    0.683031] acpi PNP0C02:03: Skipped [io  0x00b1]
>>>>> [    0.683031] acpi PNP0C02:03: Skipped [io  0x00e0-0x00ef]
>>>>> [    0.683032] acpi PNP0C02:03: Reserved [io  0x04d0-0x04d1]
>>>>> [    0.683032] acpi PNP0C02:03: Reserved [io  0x040b]
>>>>> [    0.683033] acpi PNP0C02:03: Reserved [io  0x04d6]
>>>>> [    0.683033] acpi PNP0C02:03: Reserved [io  0x0c00-0x0c01]
>>>>> [    0.683034] acpi PNP0C02:03: Reserved [io  0x0c14]
>>>>> [    0.683035] acpi PNP0C02:03: Reserved [io  0x0c50-0x0c51]
>>>>> [    0.683035] acpi PNP0C02:03: Reserved [io  0x0c52]
>>>>> [    0.683036] acpi PNP0C02:03: Reserved [io  0x0c6c]
>>>>> [    0.683036] acpi PNP0C02:03: Reserved [io  0x0c6f]
>>>>> [    0.683037] acpi PNP0C02:03: Reserved [io  0x0cd8-0x0cdf]
>>>>> [    0.683037] acpi PNP0C02:03: Reserved [io  0x0800-0x089f]
>>>>> [    0.683038] acpi PNP0C02:03: Reserved [io  0x0b00-0x0b0f]
>>>>> [    0.683038] acpi PNP0C02:03: Reserved [io  0x0b20-0x0b3f]
>>>>> [    0.683039] acpi PNP0C02:03: Reserved [io  0x0900-0x090f]
>>>>> [    0.683040] acpi PNP0C02:03: Reserved [io  0x0910-0x091f]
>>>>> [    0.683041] acpi PNP0C02:03: Could not reserve [mem 0xfec00000-0xfec00fff]
>>>>> [    0.683042] acpi PNP0C02:03: Could not reserve [mem 0xfec01000-0xfec01fff]
>>>>> [    0.683042] acpi PNP0C02:03: Reserved [mem 0xfedc0000-0xfedc0fff]
>>>>> [    0.683044] acpi PNP0C02:03: Reserved [mem 0xfee00000-0xfee00fff]
>>>>> [    0.683045] acpi PNP0C02:03: Could not reserve [mem 0xfed80000-0xfed8ffff]
>>>>> [    0.683047] acpi PNP0C02:03: Reserved [mem 0xfec10000-0xfec10fff]
>>>>> [    0.683048] acpi PNP0C02:03: Reserved [mem 0xff000000-0xffffffff]
>>>>> [    0.683070] pnp: PnP ACPI init
>>>>> [    0.683382] pnp: PnP ACPI: found 0 devices
>>>>> [    0.688630] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
>>>>> [    0.688680] NET: Registered PF_INET protocol family
>>>>> [    0.688805] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
>>>>> [    0.690569] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
>>>>> [    0.690602] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>>>>> [    0.690824] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
>>>>> [    0.691150] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
>>>>> [    0.691223] TCP: Hash tables configured (established 524288 bind 65536)
>>>>> [    0.691369] MPTCP token hash table entries: 65536 (order: 9, 1572864 bytes, linear)
>>>>> [    0.691519] UDP hash table entries: 32768 (order: 9, 2097152 bytes, linear)
>>>>> [    0.691633] NET: Registered PF_UNIX/PF_LOCAL protocol family
>>>>> [    0.691637] NET: Registered PF_XDP protocol family
>>>>> [    0.691643] pci 0000:00:01.1: PCI bridge to [bus 01]
>>>>> [    0.691646] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
>>>>> [    0.691651] pci 0000:03:08.0: PCI bridge to [bus 04]
>>>>> [    0.691653] pci 0000:03:08.0:   bridge window [io  0xf000-0xffff]
>>>>> [    0.691657] pci 0000:03:08.0:   bridge window [mem 0xfcc00000-0xfccfffff]
>>>>> [    0.691664] pci 0000:03:09.0: PCI bridge to [bus 05]
>>>>> [    0.691667] pci 0000:03:09.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
>>>>> [    0.691674] pci 0000:02:00.2: PCI bridge to [bus 03-05]
>>>>> [    0.691676] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
>>>>> [    0.691679] pci 0000:02:00.2:   bridge window [mem 0xfcb00000-0xfccfffff]
>>>>> [    0.691686] pci 0000:00:01.2: PCI bridge to [bus 02-05]
>>>>> [    0.691687] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
>>>>> [    0.691689] pci 0000:00:01.2:   bridge window [mem 0xfcb00000-0xfcdfffff]
>>>>> [    0.691694] pci 0000:00:03.1: PCI bridge to [bus 06]
>>>>> [    0.691695] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
>>>>> [    0.691697] pci 0000:00:03.1:   bridge window [mem 0xfce00000-0xfcefffff]
>>>>> [    0.691699] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
>>>>> [    0.691702] pci 0000:00:07.1: PCI bridge to [bus 07]
>>>>> [    0.691707] pci 0000:00:08.1: PCI bridge to [bus 08]
>>>>> [    0.691709] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcafffff]
>>>>> [    0.691714] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
>>>>> [    0.691715] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
>>>>> [    0.691715] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
>>>>> [    0.691716] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
>>>>> [    0.691716] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
>>>>> [    0.691717] pci_bus 0000:00: resource 9 [mem 0xc0000000-0xfec2ffff window]
>>>>> [    0.691717] pci_bus 0000:00: resource 10 [mem 0xfee00000-0xffffffff window]
>>>>> [    0.691718] pci_bus 0000:01: resource 1 [mem 0xfcf00000-0xfcffffff]
>>>>> [    0.691719] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
>>>>> [    0.691719] pci_bus 0000:02: resource 1 [mem 0xfcb00000-0xfcdfffff]
>>>>> [    0.691720] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
>>>>> [    0.691720] pci_bus 0000:03: resource 1 [mem 0xfcb00000-0xfccfffff]
>>>>> [    0.691721] pci_bus 0000:04: resource 0 [io  0xf000-0xffff]
>>>>> [    0.691721] pci_bus 0000:04: resource 1 [mem 0xfcc00000-0xfccfffff]
>>>>> [    0.691722] pci_bus 0000:05: resource 1 [mem 0xfcb00000-0xfcbfffff]
>>>>> [    0.691723] pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
>>>>> [    0.691723] pci_bus 0000:06: resource 1 [mem 0xfce00000-0xfcefffff]
>>>>> [    0.691724] pci_bus 0000:06: resource 2 [mem 0xe0000000-0xefffffff 64bit pref]
>>>>> [    0.691724] pci_bus 0000:08: resource 1 [mem 0xfc800000-0xfcafffff]
>>>>> [    0.691857] pci 0000:06:00.1: D0 power state depends on 0000:06:00.0
>>>>> [    0.691932] PCI: CLS 64 bytes, default 64
>>>>> [    0.691940] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
>>>>> [    0.691960] Trying to unpack rootfs image as initramfs...
>>>>> [    0.691968] pci 0000:00:01.0: Adding to iommu group 0
>>>>> [    0.691975] pci 0000:00:01.1: Adding to iommu group 1
>>>>> [    0.691980] pci 0000:00:01.2: Adding to iommu group 2
>>>>> [    0.691987] pci 0000:00:02.0: Adding to iommu group 3
>>>>> [    0.691994] pci 0000:00:03.0: Adding to iommu group 4
>>>>> [    0.691999] pci 0000:00:03.1: Adding to iommu group 5
>>>>> [    0.692004] pci 0000:00:04.0: Adding to iommu group 6
>>>>> [    0.692009] pci 0000:00:05.0: Adding to iommu group 7
>>>>> [    0.692017] pci 0000:00:07.0: Adding to iommu group 8
>>>>> [    0.692022] pci 0000:00:07.1: Adding to iommu group 9
>>>>> [    0.692030] pci 0000:00:08.0: Adding to iommu group 10
>>>>> [    0.692035] pci 0000:00:08.1: Adding to iommu group 11
>>>>> [    0.692043] pci 0000:00:14.0: Adding to iommu group 12
>>>>> [    0.692047] pci 0000:00:14.3: Adding to iommu group 12
>>>>> [    0.692064] pci 0000:00:18.0: Adding to iommu group 13
>>>>> [    0.692068] pci 0000:00:18.1: Adding to iommu group 13
>>>>> [    0.692072] pci 0000:00:18.2: Adding to iommu group 13
>>>>> [    0.692076] pci 0000:00:18.3: Adding to iommu group 13
>>>>> [    0.692080] pci 0000:00:18.4: Adding to iommu group 13
>>>>> [    0.692084] pci 0000:00:18.5: Adding to iommu group 13
>>>>> [    0.692088] pci 0000:00:18.6: Adding to iommu group 13
>>>>> [    0.692092] pci 0000:00:18.7: Adding to iommu group 13
>>>>> [    0.692097] pci 0000:01:00.0: Adding to iommu group 14
>>>>> [    0.692106] pci 0000:02:00.0: Adding to iommu group 15
>>>>> [    0.692111] pci 0000:02:00.1: Adding to iommu group 15
>>>>> [    0.692115] pci 0000:02:00.2: Adding to iommu group 15
>>>>> [    0.692117] pci 0000:03:08.0: Adding to iommu group 15
>>>>> [    0.692119] pci 0000:03:09.0: Adding to iommu group 15
>>>>> [    0.692120] pci 0000:04:00.0: Adding to iommu group 15
>>>>> [    0.692124] pci 0000:05:00.0: Adding to iommu group 15
>>>>> [    0.692135] pci 0000:06:00.0: Adding to iommu group 16
>>>>> [    0.692140] pci 0000:06:00.1: Adding to iommu group 16
>>>>> [    0.692145] pci 0000:07:00.0: Adding to iommu group 17
>>>>> [    0.692151] pci 0000:08:00.0: Adding to iommu group 18
>>>>> [    0.692158] pci 0000:08:00.1: Adding to iommu group 19
>>>>> [    0.692164] pci 0000:08:00.3: Adding to iommu group 20
>>>>> [    0.692170] pci 0000:08:00.4: Adding to iommu group 21
>>>>> [    0.693821] AMD-Vi: Extended features (0x58f77ef22294a5a, 0x0): PPR NX GT IA PC GA_vAPIC
>>>>> [    0.693824] AMD-Vi: Interrupt remapping enabled
>>>>> [    0.693881] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>>>>> [    0.693883] software IO TLB: mapped [mem 0x00000000b13ca000-0x00000000b53ca000] (64MB)
>>>>> [    0.693912] LVT offset 0 assigned for vector 0x400
>>>>> [    0.695508] perf: AMD IBS detected (0x000003ff)
>>>>> [    0.695512] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
>>>>> [    0.703090] Initialise system trusted keyrings
>>>>> [    0.703099] Key type blacklist registered
>>>>> [    0.703146] workingset: timestamp_bits=36 (anon: 32) max_order=24 bucket_order=0 (anon: 0)
>>>>> [    0.703312] fuse: init (API version 7.45)
>>>>> [    0.703356] integrity: Platform Keyring initialized
>>>>> [    0.703358] integrity: Machine keyring initialized
>>>>> [    0.708496] Key type asymmetric registered
>>>>> [    0.708496] Asymmetric key parser 'x509' registered
>>>>> [    0.708508] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
>>>>> [    0.708543] io scheduler mq-deadline registered
>>>>> [    0.708544] io scheduler kyber registered
>>>>> [    0.708551] io scheduler bfq registered
>>>>> [    0.709536] ledtrig-cpu: registered to indicate activity on CPUs
>>>>> [    0.709600] pcieport 0000:00:01.1: PME: Signaling with IRQ 27
>>>>> [    0.709701] pcieport 0000:00:01.2: PME: Signaling with IRQ 28
>>>>> [    0.709796] pcieport 0000:00:03.1: PME: Signaling with IRQ 29
>>>>> [    0.709943] pcieport 0000:00:07.1: PME: Signaling with IRQ 31
>>>>> [    0.709977] pcieport 0000:00:07.1: AER: enabled with IRQ 31
>>>>> [    0.710069] pcieport 0000:00:08.1: PME: Signaling with IRQ 32
>>>>> [    0.710106] pcieport 0000:00:08.1: AER: enabled with IRQ 32
>>>>> [    0.710539] input: Power Button as /devices/platform/PNP0C0C:00/input/input0
>>>>> [    0.710549] ACPI: button: Power Button [PWRB]
>>>>> [    0.710560] input: Power Button as /devices/platform/LNXPWRBN:00/input/input1
>>>>> [    0.710574] ACPI: button: Power Button [PWRF]
>>>>> [    0.710591] Monitor-Mwait will be used to enter C-1 state
>>>>> [    0.714917] Estimated ratio of average max frequency by base frequency (times 1024): 1197
>>>>> [    0.714998] ACPI: \_TZ_.UAD0: _PSL evaluation failure
>>>>> [    0.715044] acpi LNXTHERM:00: registered as thermal_zone0
>>>>> [    0.715045] ACPI: thermal: Thermal Zone [UAD0] (17 C)
>>>>> [    0.715128] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>>>>> [    0.716048] Non-volatile memory driver v1.3
>>>>> [    0.723511] Freeing initrd memory: 12616K
>>>>> [    0.775918] tpm_crb_acpi MSFT0101:00: Disabling hwrng
>>>>> [    0.776042] ACPI: bus type drm_connector registered
>>>>> [    0.776053] Unsupported value for CONFIG_DRM_PANIC_SCREEN ('qr_code'), falling back to 'user'...
>>>>> [    0.776809] ahci 0000:02:00.1: enabling device (0000 -> 0002)
>>>>> [    0.776891] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
>>>>> [    0.776944] ahci 0000:02:00.1: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
>>>>> [    0.776945] ahci 0000:02:00.1: 6/6 ports implemented (port mask 0x3f)
>>>>> [    0.776946] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst
>>>>> [    0.777178] scsi host0: ahci
>>>>> [    0.777243] scsi host1: ahci
>>>>> [    0.777289] scsi host2: ahci
>>>>> [    0.777339] scsi host3: ahci
>>>>> [    0.777383] scsi host4: ahci
>>>>> [    0.777430] scsi host5: ahci
>>>>> [    0.777448] ata1: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80100 irq 38 lpm-pol 1 ext
>>>>> [    0.777450] ata2: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80180 irq 38 lpm-pol 1 ext
>>>>> [    0.777451] ata3: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80200 irq 38 lpm-pol 1 ext
>>>>> [    0.777453] ata4: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80280 irq 38 lpm-pol 1 ext
>>>>> [    0.777454] ata5: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80300 irq 38 lpm-pol 1 ext
>>>>> [    0.777455] ata6: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80380 irq 38 lpm-pol 1 ext
>>>>> [    0.777534] xhci_hcd 0000:02:00.0: xHCI Host Controller
>>>>> [    0.777537] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
>>>>> [    0.832942] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000010
>>>>> [    0.833160] xhci_hcd 0000:02:00.0: xHCI Host Controller
>>>>> [    0.833161] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 2
>>>>> [    0.833162] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced SuperSpeed
>>>>> [    0.833258] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.01
>>>>> [    0.833259] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>>>>> [    0.833260] usb usb1: Product: xHCI Host Controller
>>>>> [    0.833260] usb usb1: Manufacturer: Linux 7.1.0-rc1 xhci-hcd
>>>>> [    0.833261] usb usb1: SerialNumber: 0000:02:00.0
>>>>> [    0.833316] hub 1-0:1.0: USB hub found
>>>>> [    0.833329] hub 1-0:1.0: 10 ports detected
>>>>> [    0.833505] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
>>>>> [    0.833513] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.01
>>>>> [    0.833514] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>>>>> [    0.833514] usb usb2: Product: xHCI Host Controller
>>>>> [    0.833515] usb usb2: Manufacturer: Linux 7.1.0-rc1 xhci-hcd
>>>>> [    0.833515] usb usb2: SerialNumber: 0000:02:00.0
>>>>> [    0.833549] hub 2-0:1.0: USB hub found
>>>>> [    0.833555] hub 2-0:1.0: 4 ports detected
>>>>> [    0.833665] xhci_hcd 0000:08:00.3: xHCI Host Controller
>>>>> [    0.833667] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 3
>>>>> [    0.833768] xhci_hcd 0000:08:00.3: hcc params 0x0278ffe5 hci version 0x110 quirks 0x0000000000000010
>>>>> [    0.833955] xhci_hcd 0000:08:00.3: xHCI Host Controller
>>>>> [    0.833957] xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 4
>>>>> [    0.833957] xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
>>>>> [    0.833973] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 7.01
>>>>> [    0.833974] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>>>>> [    0.833975] usb usb3: Product: xHCI Host Controller
>>>>> [    0.833975] usb usb3: Manufacturer: Linux 7.1.0-rc1 xhci-hcd
>>>>> [    0.833976] usb usb3: SerialNumber: 0000:08:00.3
>>>>> [    0.834016] hub 3-0:1.0: USB hub found
>>>>> [    0.834020] hub 3-0:1.0: 4 ports detected
>>>>> [    0.834130] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
>>>>> [    0.834137] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 7.01
>>>>> [    0.834138] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>>>>> [    0.834139] usb usb4: Product: xHCI Host Controller
>>>>> [    0.834139] usb usb4: Manufacturer: Linux 7.1.0-rc1 xhci-hcd
>>>>> [    0.834140] usb usb4: SerialNumber: 0000:08:00.3
>>>>> [    0.834170] hub 4-0:1.0: USB hub found
>>>>> [    0.834175] hub 4-0:1.0: 4 ports detected
>>>>> [    0.834267] usbcore: registered new interface driver usbserial_generic
>>>>> [    0.834269] usbserial: USB Serial support registered for generic
>>>>> [    0.834283] i8042: PNP: No PS/2 controller found.
>>>>> [    0.834350] rtc_cmos PNP0B00:00: RTC can wake from S4
>>>>> [    0.834521] rtc_cmos PNP0B00:00: registered as rtc0
>>>>> [    0.834547] rtc_cmos PNP0B00:00: setting system clock to 2026-04-29T10:27:48 UTC (1777458468)
>>>>> [    0.834563] rtc_cmos PNP0B00:00: alarms up to one month, y3k, 114 bytes nvram
>>>>> [    0.931490] simple-framebuffer simple-framebuffer.0: [drm] Registered 1 planes with drm panic
>>>>> [    0.931519] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
>>>>> [    0.933645] fbcon: Deferring console take-over
>>>>> [    0.933648] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
>>>>> [    0.933683] hid: raw HID events driver (C) Jiri Kosina
>>>>> [    0.933709] usbcore: registered new interface driver usbhid
>>>>> [    0.933710] usbhid: USB HID core driver
>>>>> [    0.933764] drop_monitor: Initializing network drop monitor service
>>>>> [    0.933903] NET: Registered PF_INET6 protocol family
>>>>> [    0.934226] Segment Routing with IPv6
>>>>> [    0.934228] RPL Segment Routing with IPv6
>>>>> [    0.934236] In-situ OAM (IOAM) with IPv6
>>>>> [    0.934259] NET: Registered PF_PACKET protocol family
>>>>> [    0.936086] x86/amd: Previous system reset reason [0x00080800]: software wrote 0x6 to reset control register 0xCF9
>>>>> [    0.936105] microcode: Current revision: 0x0a201213
>>>>> [    0.936604] resctrl: L3 allocation detected
>>>>> [    0.936606] resctrl: MB allocation detected
>>>>> [    0.936607] resctrl: L3 monitoring detected
>>>>> [    0.936635] IPI shorthand broadcast: enabled
>>>>> [    0.939169] sched_clock: Marking stable (622645566, 316266886)->(963658783, -24746331)
>>>>> [    0.939438] registered taskstats version 1
>>>>> [    0.940257] Loading compiled-in X.509 certificates
>>>>> [    0.948578] Loaded X.509 cert 'Build time autogenerated kernel key: ce454674b523df33fb5f791c1b2ac6e1e8d846a0'
>>>>> [    0.950953] Demotion targets for Node 0: null
>>>>> [    0.951151] Key type .fscrypt registered
>>>>> [    0.951153] Key type fscrypt-provisioning registered
>>>>> [    0.951508] Btrfs loaded, zoned=yes, fsverity=yes
>>>>> [    0.951541] Key type big_key registered
>>>>> [    0.952098] PM:   Magic number: 6:154:478
>>>>> [    0.952106] rtc rtc0: hash matches
>>>>> [    0.952303] RAS: Correctable Errors collector initialized.
>>>>> [    0.952587] clk: Disabling unused clocks
>>>>> [    0.952590] PM: genpd: Disabling unused power domains
>>>>> [    1.129704] usb 1-5: new full-speed USB device number 2 using xhci_hcd
>>>>> [    1.244390] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
>>>>> [    1.245797] ata1.00: HPA detected: current 976771055, native 976773168
>>>>> [    1.245802] ata1.00: ATA-8: ST3500320AS, SD81, max UDMA/133
>>>>> [    1.245805] ata1.00: 976771055 sectors, multi 0: LBA48 NCQ (depth 32)
>>>>> [    1.247571] ata1.00: configured for UDMA/133
>>>>> [    1.258492] scsi 0:0:0:0: Direct-Access     ATA      ST3500320AS      SD81 PQ: 0 ANSI: 5
>>>>> [    1.258771] sd 0:0:0:0: [sda] 976771055 512-byte logical blocks: (500 GB/466 GiB)
>>>>> [    1.258782] sd 0:0:0:0: [sda] Write Protect is off
>>>>> [    1.258785] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>>>>> [    1.258796] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>>>>> [    1.258815] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
>>>>> [    1.328211]  sda: sda1 sda2 < sda5 sda6 sda7 > sda3
>>>>> [    1.328420] sd 0:0:0:0: [sda] Attached SCSI disk
>>>>> [    1.505166] usb 1-5: New USB device found, idVendor=8087, idProduct=0029, bcdDevice= 0.01
>>>>> [    1.505173] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
>>>>> [    1.569494] ata2: SATA link down (SStatus 0 SControl 300)
>>>>> [    1.690618] usb 1-6: new high-speed USB device number 3 using xhci_hcd
>>>>> [    1.724657] tsc: Refined TSC clocksource calibration: 3693.059 MHz
>>>>> [    1.724671] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6a77744cfd5, max_idle_ns: 881590969987 ns
>>>>> [    1.724785] clocksource: Switched to clocksource tsc
>>>>> [    1.891107] ata3: SATA link down (SStatus 0 SControl 300)
>>>>> [    1.899397] usb 1-6: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
>>>>> [    1.899406] usb 1-6: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>>>>> [    1.899409] usb 1-6: Product: USB2.0 Hub
>>>>> [    1.907453] hub 1-6:1.0: USB hub found
>>>>> [    1.911384] hub 1-6:1.0: 4 ports detected
>>>>> [    2.106605] usb 1-7: new full-speed USB device number 4 using xhci_hcd
>>>>> [    2.210264] ata4: SATA link down (SStatus 0 SControl 300)
>>>>> [    2.449618] usb 1-6.1: new high-speed USB device number 5 using xhci_hcd
>>>>> [    2.481124] usb 1-7: New USB device found, idVendor=048d, idProduct=5702, bcdDevice= 0.01
>>>>> [    2.481134] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>>>>> [    2.481137] usb 1-7: Product: ITE Device
>>>>> [    2.481139] usb 1-7: Manufacturer: ITE Tech. Inc.
>>>>> [    2.494092] hid-generic 0003:048D:5702.0001: hiddev96,hidraw0: USB HID v1.12 Device [ITE Tech. Inc. ITE Device] on usb-0000:02:00.0-7/input0
>>>>> [    2.534071] ata5: SATA link down (SStatus 0 SControl 300)
>>>>> [    2.739620] usb 1-10: new high-speed USB device number 6 using xhci_hcd
>>>>> [    2.835362] usb 1-6.1: New USB device found, idVendor=046d, idProduct=0825, bcdDevice= 0.10
>>>>> [    2.835372] usb 1-6.1: New USB device strings: Mfr=0, Product=0, SerialNumber=2
>>>>> [    2.835374] usb 1-6.1: SerialNumber: 2EE9AB20
>>>>> [    2.949333] usb 1-10: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=85.36
>>>>> [    2.949343] usb 1-10: New USB device strings: Mfr=0, Product=1, SerialNumber=0
>>>>> [    2.949345] usb 1-10: Product: USB2.0 Hub
>>>>> [    2.960700] hub 1-10:1.0: USB hub found
>>>>> [    2.964337] hub 1-10:1.0: 4 ports detected
>>>>> [    3.004618] usb 1-6.2: new low-speed USB device number 7 using xhci_hcd
>>>>> [    3.246334] usb 1-6.2: New USB device found, idVendor=046d, idProduct=c31c, bcdDevice=64.00
>>>>> [    3.246344] usb 1-6.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>>>>> [    3.246347] usb 1-6.2: Product: USB Keyboard
>>>>> [    3.246349] usb 1-6.2: Manufacturer: Logitech
>>>>> [    3.315965] input: Logitech USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-6/1-6.2/1-6.2:1.0/0003:046D:C31C.0002/input/input2
>>>>> [    3.367023] hid-generic 0003:046D:C31C.0002: input,hidraw1: USB HID v1.10 Keyboard [Logitech USB Keyboard] on usb-0000:02:00.0-6.2/input0
>>>>> [    3.426902] input: Logitech USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-6/1-6.2/1-6.2:1.1/0003:046D:C31C.0003/input/input3
>>>>> [    3.477763] input: Logitech USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-6/1-6.2/1-6.2:1.1/0003:046D:C31C.0003/input/input4
>>>>> [    3.477847] hid-generic 0003:046D:C31C.0003: input,hidraw2: USB HID v1.10 Device [Logitech USB Keyboard] on usb-0000:02:00.0-6.2/input1
>>>>> [    3.557336] usb 1-6.3: new low-speed USB device number 8 using xhci_hcd
>>>>> [    3.580330] ata6: failed to resume link (SControl 0)
>>>>> [    3.580354] ata6: SATA link down (SStatus 0 SControl 0)
>>>>> [    3.593102] Freeing unused decrypted memory: 2028K
>>>>> [    3.593845] Freeing unused kernel image (initmem) memory: 4788K
>>>>> [    3.593863] Write protecting the kernel read-only data: 36864k
>>>>> [    3.594182] Freeing unused kernel image (text/rodata gap) memory: 408K
>>>>> [    3.594283] Freeing unused kernel image (rodata/data gap) memory: 292K
>>>>> [    3.610587] x86/mm: Checked W+X mappings: passed, no W+X pages found.
>>>>> [    3.610595] rodata_test: all tests were successful
>>>>> [    3.610603] Run /init as init process
>>>>> [    3.610605]   with arguments:
>>>>> [    3.610606]     /init
>>>>> [    3.610608]   with environment:
>>>>> [    3.610609]     HOME=/
>>>>> [    3.610610]     TERM=linux
>>>>> [    3.630680] systemd[1]: Successfully made /usr/ read-only.
>>>>> [    3.793325] usb 1-6.3: New USB device found, idVendor=046d, idProduct=c05a, bcdDevice=54.00
>>>>> [    3.793334] usb 1-6.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>>>>> [    3.793337] usb 1-6.3: Product: USB Optical Mouse
>>>>> [    3.793339] usb 1-6.3: Manufacturer: Logitech
>>>>> [    3.832899] input: Logitech USB Optical Mouse as /devices/pci0000:00/0000:00:01.2/0000:02:00.0/usb1/1-6/1-6.3/1-6.3:1.0/0003:046D:C05A.0004/input/input5
>>>>> [    3.833020] hid-generic 0003:046D:C05A.0004: input,hidraw3: USB HID v1.11 Mouse [Logitech USB Optical Mouse] on usb-0000:02:00.0-6.3/input0
>>>>> [    3.912337] usb 1-6.4: new high-speed USB device number 9 using xhci_hcd
>>>>> [    3.964736] systemd[1]: systemd 260.1-2-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +LIBARCHIVE)
>>>>> [    3.964748] systemd[1]: Detected architecture x86-64.
>>>>> [    3.964752] systemd[1]: Running in initrd.
>>>>> [    3.965072] fbcon: Taking over console
>>>>> [    3.967389] Console: switching to colour frame buffer device 240x67
>>>>> [    3.971100] systemd[1]: Initializing machine ID from random generator.
>>>>> [    3.988476] clocksource: Watchdog remote CPU 5 read timed out
>>>>> [    4.015201] systemd[1]: Queued start job for default target Initrd Default Target.
>>>>> [    4.021231] usb 1-6.4: New USB device found, idVendor=03f0, idProduct=5b12, bcdDevice= 1.00
>>>>> [    4.021239] usb 1-6.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>>>>> [    4.021242] usb 1-6.4: Product: Officejet Pro 8100
>>>>> [    4.021244] usb 1-6.4: Manufacturer: HP
>>>>> [    4.021246] usb 1-6.4: SerialNumber: CN38UBVGGP05MX
>>>>> [    4.081955] systemd[1]: Created slice Slice /system/systemd-cryptsetup.
>>>>> [    4.082246] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
>>>>> [    4.082454] systemd[1]: Expecting device /dev/disk/by-uuid/f57b6e73-6f79-41f3-b733-266aa9695b49...
>>>>> [    4.082540] systemd[1]: Expecting device /dev/mapper/nvme0n1p3-encrypted...
>>>>> [    4.082598] systemd[1]: Reached target Path Units.
>>>>> [    4.082642] systemd[1]: Reached target Slice Units.
>>>>> [    4.082685] systemd[1]: Reached target Swaps.
>>>>> [    4.082727] systemd[1]: Reached target Timer Units.
>>>>> [    4.082861] systemd[1]: Listening on Journal Socket (/dev/log).
>>>>> [    4.082984] systemd[1]: Listening on Journal Sockets.
>>>>> [    4.083098] systemd[1]: Listening on udev Control Socket.
>>>>> [    4.083188] systemd[1]: Listening on udev Kernel Socket.
>>>>> [    4.083236] systemd[1]: Reached target Socket Units.
>>>>> [    4.085791] systemd[1]: Starting Create List of Static Device Nodes...
>>>>> [    4.086142] systemd[1]: Early Battery Level Check skipped, unmet condition check ConditionDirectoryNotEmpty=/sys/class/power_supply
>>>>> [    4.089007] systemd[1]: Started Display Boot-Time Emergency Messages In Full Screen.
>>>>> [    4.095041] systemd[1]: Starting Journal Service...
>>>>> [    4.098060] systemd[1]: Starting Load Kernel Modules...
>>>>> [    4.098501] systemd[1]: TPM PCR Barrier (initrd) skipped, unmet condition check ConditionSecurity=measured-uki
>>>>> [    4.101249] systemd[1]: Starting Create Static Device Nodes in /dev...
>>>>> [    4.103925] systemd[1]: Starting Coldplug All udev Devices...
>>>>> [    4.111251] systemd[1]: Finished Create List of Static Device Nodes.
>>>>> [    4.113857] systemd[1]: Finished Load Kernel Modules.
>>>>> [    4.116352] systemd[1]: Finished Create Static Device Nodes in /dev.
>>>>> [    4.116582] systemd-journald[299]: Collecting audit messages is disabled.
>>>>> [    4.116677] systemd[1]: Reached target Preparation for Local File Systems.
>>>>> [    4.116742] systemd[1]: Reached target Local File Systems.
>>>>> [    4.119671] systemd[1]: Starting Rule-based Manager for Device Events and Files...
>>>>> [    4.151218] systemd[1]: Started Rule-based Manager for Device Events and Files.
>>>>> [    4.184059] systemd[1]: Started Journal Service.
>>>>> [    4.402015] Key type psk registered
>>>>> [    4.412526] ccp 0000:08:00.1: enabling device (0000 -> 0002)
>>>>> [    4.412747] ccp 0000:08:00.1: ccp: unable to access the device: you might be running a broken BIOS.
>>>>> [    4.412846] ccp 0000:08:00.1: psp enabled
>>>>> [    4.422884] nvme nvme0: pci function 0000:01:00.0
>>>>> [    4.434734] nvme nvme0: D3 entry latency set to 10 seconds
>>>>> [    4.440295] nvme nvme0: 24/0/0 default/read/poll queues
>>>>> [    4.443388]  nvme0n1: p1 p2 p3
>>>>> [    4.527375] device-mapper: uevent: version 1.0.3
>>>>> [    4.527470] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
>>>>> [   15.088615] NET: Registered PF_ALG protocol family
>>>>> [   15.889799] Key type trusted registered
>>>>> [   15.895058] Key type encrypted registered
>>>>> [   15.973539] BTRFS: device fsid dc764ad3-c581-4485-bbb3-09f2be518905 devid 1 transid 148127 /dev/mapper/nvme0n1p3-encrypted (253:0) scanned by mount (657)
>>>>> [   15.973857] BTRFS info (device dm-0): first mount of filesystem dc764ad3-c581-4485-bbb3-09f2be518905
>>>>> [   15.973864] BTRFS info (device dm-0): using xxhash64 checksum algorithm
>>>>> [   15.977639] BTRFS info (device dm-0): enabling ssd optimizations
>>>>> [   15.977643] BTRFS info (device dm-0): enabling free space tree
>>>>> [   16.361462] systemd-journald[299]: Received SIGTERM from PID 1 (systemd).
>>>>> [   16.727201] systemd[1]: systemd 260.1-2-arch running in system mode (+PAM +AUDIT -SELINUX +APPARMOR -IMA +IPE +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +BTF +XKBCOMMON +UTMP +LIBARCHIVE)
>>>>> [   16.727213] systemd[1]: Detected architecture x86-64.
>>>>> [   16.743736] systemd[1]: Hostname set to <einstein>.
>>>>> [   16.863521] systemd[1]: bpf-restrict-fs: LSM BPF program attached
>>>>> [   17.120173] systemd[1]: initrd-switch-root.service: Deactivated successfully.
>>>>> [   17.120358] systemd[1]: Stopped Switch Root.
>>>>> [   17.121770] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
>>>>> [   17.122353] systemd[1]: Created slice Slice /system/dirmngr.
>>>>> [   17.124100] systemd[1]: Created slice Slice /system/getty.
>>>>> [   17.125043] systemd[1]: Created slice Slice /system/gpg-agent.
>>>>> [   17.125911] systemd[1]: Created slice Slice /system/gpg-agent-browser.
>>>>> [   17.126787] systemd[1]: Created slice Slice /system/gpg-agent-extra.
>>>>> [   17.127661] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
>>>>> [   17.128481] systemd[1]: Created slice Slice /system/keyboxd.
>>>>> [   17.129323] systemd[1]: Created slice Slice /system/modprobe.
>>>>> [   17.129973] systemd[1]: Created slice User and Session Slice.
>>>>> [   17.130402] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
>>>>> [   17.130804] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
>>>>> [   17.131340] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
>>>>> [   17.131723] systemd[1]: Expecting device /dev/disk/by-uuid/F664-DB79...
>>>>> [   17.132069] systemd[1]: Expecting device /dev/disk/by-uuid/cbf8e37b-2095-4f42-a709-5a9f72a34610...
>>>>> [   17.132500] systemd[1]: Reached target Login Prompts.
>>>>> [   17.132853] systemd[1]: Reached target Image Downloads.
>>>>> [   17.133192] systemd[1]: Stopped target Switch Root.
>>>>> [   17.133550] systemd[1]: Stopped target Initrd File Systems.
>>>>> [   17.133885] systemd[1]: Stopped target Initrd Root File System.
>>>>> [   17.134224] systemd[1]: Reached target Local Integrity Protected Volumes.
>>>>> [   17.134585] systemd[1]: Reached target Path Units.
>>>>> [   17.134928] systemd[1]: Reached target Remote File Systems.
>>>>> [   17.135253] systemd[1]: Reached target Slice Units.
>>>>> [   17.135597] systemd[1]: Reached target Swaps.
>>>>> [   17.135934] systemd[1]: Reached target Local Verity Protected Volumes.
>>>>> [   17.136363] systemd[1]: Listening on Device-mapper event daemon FIFOs.
>>>>> [   17.136799] systemd[1]: Listening on LVM2 poll daemon socket.
>>>>> [   17.138308] systemd[1]: Listening on Query the User Interactively for a Password.
>>>>> [   17.142016] systemd[1]: Listening on Process Core Dump Socket.
>>>>> [   17.143199] systemd[1]: Listening on Credential Encryption/Decryption.
>>>>> [   17.144727] systemd[1]: Listening on Factory Reset Management.
>>>>> [   17.146407] systemd[1]: Listening on Console Output Muting Service Socket.
>>>>> [   17.146964] systemd[1]: TPM PCR Measurements skipped, unmet condition check ConditionSecurity=measured-uki
>>>>> [   17.146990] systemd[1]: Make TPM PCR Policy skipped, unmet condition check ConditionSecurity=measured-uki
>>>>> [   17.147861] systemd[1]: Listening on Disk Repartitioning Service Socket.
>>>>> [   17.148331] systemd[1]: Listening on udev Control Socket.
>>>>> [   17.148751] systemd[1]: Listening on udev Varlink Socket.
>>>>> [   17.149171] systemd[1]: Listening on User Database Manager Socket.
>>>>> [   17.150875] systemd[1]: Mounting Huge Pages File System...
>>>>> [   17.151955] systemd[1]: Mounting POSIX Message Queue File System...
>>>>> [   17.153145] systemd[1]: Mounting Kernel Debug File System...
>>>>> [   17.154282] systemd[1]: Mounting Kernel Trace File System...
>>>>> [   17.166466] systemd[1]: Mounting Temporary Directory /tmp...
>>>>> [   17.168202] systemd[1]: Starting Create List of Static Device Nodes...
>>>>> [   17.169646] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
>>>>> [   17.170046] systemd[1]: Load Kernel Module configfs skipped, unmet condition check ConditionKernelModuleLoaded=!configfs
>>>>> [   17.170893] systemd[1]: Mounting Kernel Configuration File System...
>>>>> [   17.171371] systemd[1]: Load Kernel Module drm skipped, unmet condition check ConditionKernelModuleLoaded=!drm
>>>>> [   17.171421] systemd[1]: Load Kernel Module fuse skipped, unmet condition check ConditionKernelModuleLoaded=!fuse
>>>>> [   17.172449] systemd[1]: Mounting FUSE Control File System...
>>>>> [   17.172948] systemd[1]: systemd-cryptsetup@nvme0n1p3\x2dencrypted.service: Deactivated successfully.
>>>>> [   17.173014] systemd[1]: Stopped systemd-cryptsetup@nvme0n1p3\x2dencrypted.service.
>>>>> [   17.173603] systemd[1]: systemd-cryptsetup@nvme0n1p3\x2dencrypted.service: Consumed 15.936s CPU time over 12.681s wall clock time, 1G memory peak.
>>>>> [   17.175343] systemd[1]: systemd-fsck-root.service: Deactivated successfully.
>>>>> [   17.175384] systemd[1]: Stopped File System Check on Root Device.
>>>>> [   17.175837] systemd[1]: Clear Stale Hibernate Storage Info skipped, unmet condition check ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67
>>>>> [   17.178179] systemd[1]: Starting Journal Service...
>>>>> [   17.180251] systemd[1]: Starting Load Kernel Modules...
>>>>> [   17.180664] systemd[1]: TPM PCR Machine ID Measurement skipped, unmet condition check ConditionSecurity=measured-uki
>>>>> [   17.181604] systemd[1]: Starting Remount Root and Kernel File Systems...
>>>>> [   17.182006] systemd[1]: Early TPM SRK Setup skipped, unmet condition check ConditionSecurity=measured-uki
>>>>> [   17.182953] systemd[1]: Starting Load udev Rules from Credentials...
>>>>> [   17.184173] systemd[1]: Starting Coldplug All udev Devices...
>>>>> [   17.187295] systemd[1]: Mounted Huge Pages File System.
>>>>> [   17.188334] systemd[1]: Mounted POSIX Message Queue File System.
>>>>> [   17.188800] systemd[1]: Mounted Kernel Debug File System.
>>>>> [   17.189245] systemd[1]: Mounted Kernel Trace File System.
>>>>> [   17.189689] systemd[1]: Mounted Temporary Directory /tmp.
>>>>> [   17.190326] systemd[1]: Finished Create List of Static Device Nodes.
>>>>> [   17.190823] systemd[1]: Mounted Kernel Configuration File System.
>>>>> [   17.191333] systemd[1]: Mounted FUSE Control File System.
>>>>> [   17.192770] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
>>>>> [   17.199381] i2c_dev: i2c /dev entries driver
>>>>> [   17.200079] systemd[1]: Finished Load Kernel Modules.
>>>>> [   17.232307] systemd[1]: Starting Apply Kernel Variables...
>>>>> [   17.234023] systemd[1]: Finished Load udev Rules from Credentials.
>>>>> [   17.236939] systemd-journald[884]: Collecting audit messages is disabled.
>>>>> [   17.242507] systemd[1]: Started Journal Service.
>>>>> [   17.363524] systemd-journald[884]: Received client request to flush runtime journal.
>>>>> [   18.527504] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1.SMBI) (20251212/utaddress-204)
>>>>> [   18.527519] ACPI: OSL: Resource conflict; ACPI support missing from driver?
>>>>> [   18.546381] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
>>>>> [   18.547150] mc: Linux media interface: v0.10
>>>>> [   18.547568] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
>>>>> [   18.548916] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
>>>>> [   18.548922] RAPL PMU: hw unit of domain package 2^-16 Joules
>>>>> [   18.548923] input: PC Speaker as /devices/platform/pcspkr/input/input6
>>>>> [   18.548925] RAPL PMU: hw unit of domain core 2^-16 Joules
>>>>> [   18.550361] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
>>>>> [   18.590878] Bluetooth: Core ver 2.22
>>>>> [   18.590914] NET: Registered PF_BLUETOOTH protocol family
>>>>> [   18.590916] Bluetooth: HCI device and connection manager initialized
>>>>> [   18.590922] Bluetooth: HCI socket layer initialized
>>>>> [   18.590926] Bluetooth: L2CAP socket layer initialized
>>>>> [   18.590936] Bluetooth: SCO socket layer initialized
>>>>> [   18.634002] mousedev: PS/2 mouse device common for all mice
>>>>> [   18.634985] cfg80211: Loading compiled-in X.509 certificates for regulatory database
>>>>> [   18.635175] gigabyte-wmi DEADBEEF-2001-0000-00A0-C90629100000-2: No temperature sensors usable
>>>>> [   18.640505] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>>>>> [   18.640843] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
>>>>> [   18.655384] videodev: Linux video capture interface: v2.00
>>>>> [   18.663302] r8169 0000:04:00.0 eth0: RTL8125B, 18:c0:4d:d9:84:b5, XID 641, IRQ 85
>>>>> [   18.663308] r8169 0000:04:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
>>>>> [   18.722710] r8169 0000:04:00.0 eno1: renamed from eth0
>>>>> [   18.735395] iwlwifi 0000:05:00.0: enabling device (0000 -> 0002)
>>>>> [   18.739697] iwlwifi 0000:05:00.0: Detected crf-id 0x3617, cnv-id 0x100530 wfpm id 0x80000000
>>>>> [   18.739708] iwlwifi 0000:05:00.0: PCI dev 2723/0084, rev=0x340, rfid=0x10a100
>>>>> [   18.739712] iwlwifi 0000:05:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz
>>>>> [   18.744029] usbcore: registered new interface driver btusb
>>>>> [   18.747448] iwlwifi 0000:05:00.0: loaded firmware version 77.f39cc7f9.0 cc-a0-77.ucode op_mode iwlmvm
>>>>> [   18.752947] kvm_amd: TSC scaling supported
>>>>> [   18.752952] kvm_amd: Nested Virtualization enabled
>>>>> [   18.752956] kvm_amd: Nested Paging enabled
>>>>> [   18.752959] kvm_amd: LBR virtualization supported
>>>>> [   18.752965] kvm_amd: Virtual VMLOAD VMSAVE supported
>>>>> [   18.752967] kvm_amd: Virtual GIF supported
>>>>> [   18.767652] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
>>>>> [   18.767679] Bluetooth: hci0: Boot Address: 0x24800
>>>>> [   18.767683] Bluetooth: hci0: Firmware Version: 255-255.255
>>>>> [   18.772320] usb 1-5: USB disconnect, device number 2
>>>>> [   18.772614] snd_hda_intel 0000:06:00.1: Handle vga_switcheroo audio client
>>>>> [   18.772621] snd_hda_intel 0000:06:00.1: Force to non-snoop mode
>>>>> [   18.772816] snd_hda_intel 0000:08:00.4: enabling device (0000 -> 0002)
>>>>> [   18.772913] Bluetooth: hci0: FW download error recovery failed (-19)
>>>>> [   18.772959] Bluetooth: hci0: sending frame failed (-19)
>>>>> [   18.772972] Bluetooth: hci0: Reading supported features failed (-19)
>>>>> [   18.772976] Bluetooth: hci0: Error reading debug features
>>>>> [   18.772983] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
>>>>> [   18.772993] Bluetooth: hci0: sending frame failed (-19)
>>>>> [   18.773003] Bluetooth: hci0: Failed to read MSFT supported features (-19)
>>>>> [   18.779647] EDAC MC0: Giving out device to module amd64_edac controller F19h_M21h: DEV 0000:00:18.3 (INTERRUPT)
>>>>> [   18.779653] EDAC amd64: F19h_M21h detected (node 0).
>>>>> [   18.779655] EDAC MC: UMC0 chip selects:
>>>>> [   18.779656] EDAC amd64: MC: 0:     0MB 1:     0MB
>>>>> [   18.779658] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>>>>> [   18.779660] EDAC MC: UMC1 chip selects:
>>>>> [   18.779661] EDAC amd64: MC: 0:     0MB 1:     0MB
>>>>> [   18.779662] EDAC amd64: MC: 2: 16384MB 3: 16384MB
>>>>> [   18.792629] intel_rapl_common: Found RAPL domain package
>>>>> [   18.792634] intel_rapl_common: Found RAPL domain core
>>>>> [   18.793092] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card1/input7
>>>>> [   18.793143] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card1/input8
>>>>> [   18.793183] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card1/input9
>>>>> [   18.793224] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card1/input10
>>>>> [   18.793269] input: HDA ATI HDMI HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card1/input11
>>>>> [   18.793326] input: HDA ATI HDMI HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:03.1/0000:06:00.1/sound/card1/input12
>>>>> [   18.869294] amd_atl: AMD Address Translation Library initialized
>>>>> [   18.870518] snd_hda_codec_alc882 hdaudioC2D0: autoconfig for ALC1220: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
>>>>> [   18.870549] snd_hda_codec_alc882 hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>>>>> [   18.870552] snd_hda_codec_alc882 hdaudioC2D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>>>>> [   18.870554] snd_hda_codec_alc882 hdaudioC2D0:    mono: mono_out=0x0
>>>>> [   18.870555] snd_hda_codec_alc882 hdaudioC2D0:    dig-out=0x1e/0x0
>>>>> [   18.870557] snd_hda_codec_alc882 hdaudioC2D0:    inputs:
>>>>> [   18.870559] snd_hda_codec_alc882 hdaudioC2D0:      Rear Mic=0x18
>>>>> [   18.870561] snd_hda_codec_alc882 hdaudioC2D0:      Front Mic=0x19
>>>>> [   18.870562] snd_hda_codec_alc882 hdaudioC2D0:      Line=0x1a
>>>>> [   18.876221] pps_core: LinuxPPS API ver. 1 registered
>>>>> [   18.876225] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
>>>>> [   18.882606] PTP clock support registered
>>>>> [   18.884466] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card2/input13
>>>>> [   18.884549] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card2/input14
>>>>> [   18.884592] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card2/input15
>>>>> [   18.884642] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card2/input16
>>>>> [   18.884684] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card2/input17
>>>>> [   18.884729] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card2/input18
>>>>> [   18.884774] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:08:00.4/sound/card2/input19
>>>>> [   18.942643] usblp 1-6.4:1.0: usblp0: USB Bidirectional printer dev 9 if 0 alt 0 proto 2 vid 0x03F0 pid 0x5B12
>>>>> [   18.942683] usbcore: registered new interface driver usblp
>>>>> [   19.035526] iwlwifi 0000:05:00.0: Detected RF HR B3, rfid=0x10a100
>>>>> [   19.100466] iwlwifi 0000:05:00.0: base HW address: 08:5b:d6:d0:3a:8b
>>>>> [   19.202967] iwlwifi 0000:05:00.0 wlp5s0: renamed from wlan0
>>>>> [   19.217291] usb 1-5: new full-speed USB device number 10 using xhci_hcd
>>>>> [   19.220632] BTRFS: device fsid cbf8e37b-2095-4f42-a709-5a9f72a34610 devid 1 transid 426 /dev/nvme0n1p2 (259:2) scanned by mount (1081)
>>>>> [   19.220937] BTRFS info (device nvme0n1p2): first mount of filesystem cbf8e37b-2095-4f42-a709-5a9f72a34610
>>>>> [   19.220942] BTRFS info (device nvme0n1p2): using xxhash64 checksum algorithm
>>>>> [   19.223998] BTRFS info (device nvme0n1p2): enabling ssd optimizations
>>>>> [   19.224002] BTRFS info (device nvme0n1p2): turning on async discard
>>>>> [   19.224003] BTRFS info (device nvme0n1p2): enabling free space tree
>>>>> [   19.589346] usb 1-5: New USB device found, idVendor=8087, idProduct=0029, bcdDevice= 0.01
>>>>> [   19.589352] usb 1-5: New USB device strings: Mfr=0, Product=0, SerialNumber=0
>>>>> [   19.617090] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
>>>>> [   19.622101] Bluetooth: hci0: Device revision is 1
>>>>> [   19.622104] Bluetooth: hci0: Secure boot is enabled
>>>>> [   19.622105] Bluetooth: hci0: OTP lock is enabled
>>>>> [   19.622106] Bluetooth: hci0: API lock is enabled
>>>>> [   19.622107] Bluetooth: hci0: Debug lock is disabled
>>>>> [   19.622108] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
>>>>> [   19.626188] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
>>>>> [   19.626223] Bluetooth: hci0: Boot Address: 0x24800
>>>>> [   19.626225] Bluetooth: hci0: Firmware Version: 255-255.255
>>>>> [   20.045278] usb 1-6.1: set resolution quirk: cval->res = 384
>>>>> [   20.045439] usbcore: registered new interface driver snd-usb-audio
>>>>> [   20.045522] uvcvideo 1-6.1:1.0: Found UVC 1.00 device <unnamed> (046d:0825)
>>>>> [   20.353027] usbcore: registered new interface driver uvcvideo
>>>>> [   23.994429] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
>>>>> [   24.002708] amdgpu: Virtual CRAT table created for CPU
>>>>> [   24.002730] amdgpu: Topology: Add CPU node
>>>>> [   24.002839] amdgpu 0000:06:00.0: SI support provided by amdgpu.
>>>>>                   Use radeon.si_support=1 amdgpu.si_support=0 to override.
>>>>> [   24.002985] amdgpu 0000:06:00.0: initializing kernel modesetting (PITCAIRN 0x1002:0x6819 0x174B:0xE221 0x00).
>>>>> [   24.003002] amdgpu 0000:06:00.0: register mmio base: 0xFCE00000
>>>>> [   24.003004] amdgpu 0000:06:00.0: register mmio size: 262144
>>>>> [   24.003083] amdgpu 0000:06:00.0: detected ip block number 0 <common_v1_0_0> (si_common)
>>>>> [   24.003087] amdgpu 0000:06:00.0: detected ip block number 1 <gmc_v6_0_0> (gmc_v6_0)
>>>>> [   24.003089] amdgpu 0000:06:00.0: detected ip block number 2 <ih_v1_0_0> (si_ih)
>>>>> [   24.003091] amdgpu 0000:06:00.0: detected ip block number 3 <gfx_v6_0_0> (gfx_v6_0)
>>>>> [   24.003092] amdgpu 0000:06:00.0: detected ip block number 4 <sdma_v1_0_0> (si_dma)
>>>>> [   24.003094] amdgpu 0000:06:00.0: detected ip block number 5 <smu_v6_0_0> (si_dpm)
>>>>> [   24.003096] amdgpu 0000:06:00.0: detected ip block number 6 <dce_v1_0_0> (dm)
>>>>> [   24.003097] amdgpu 0000:06:00.0: detected ip block number 7 <uvd_v3_1_0> (uvd_v3_1)
>>>>> [   24.003099] amdgpu 0000:06:00.0: detected ip block number 8 <vce_v1_0_0> (vce_v1_0)
>>>>> [   24.019306] amdgpu 0000:06:00.0: Fetched VBIOS from ROM BAR
>>>>> [   24.019315] amdgpu 0000:06:00.0: [drm] ATOM BIOS: 113-221PROHE-X02, build: 234026  , ver: 015.022.000.001.000000, 2012/07/18
>>>>> [   24.020745] amdgpu 0000:06:00.0: Found VCE firmware Version: 50.0 Binary ID: 1
>>>>> [   24.020752] kfd kfd: PITCAIRN  not supported in kfd
>>>>> [   24.059391] Console: switching to colour dummy device 80x25
>>>>> [   24.059938] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
>>>>> [   24.059943] amdgpu 0000:06:00.0: Trusted Memory Zone (TMZ) feature not supported
>>>>> [   24.060066] amdgpu 0000:06:00.0: [drm] PCIE gen 3 link speeds already enabled
>>>>> [   24.060073] amdgpu 0000:06:00.0: vm size is 256 GB, 2 levels, block size is 10-bit, fragment size is 9-bit
>>>>> [   24.060670] amdgpu 0000:06:00.0: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
>>>>> [   24.060677] amdgpu 0000:06:00.0: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
>>>>> [   24.060686] amdgpu 0000:06:00.0: [drm] Detected VRAM RAM=2048M, BAR=256M
>>>>> [   24.060688] amdgpu 0000:06:00.0: [drm] RAM width 256bits GDDR5
>>>>> [   24.060828] amdgpu 0000:06:00.0:  2048M of VRAM memory ready
>>>>> [   24.060831] amdgpu 0000:06:00.0:  32097M of GTT memory ready.
>>>>> [   24.060846] amdgpu 0000:06:00.0: [drm] GART: num cpu pages 262144, num gpu pages 262144
>>>>> [   24.063708] amdgpu 0000:06:00.0: [drm] PCIE GART of 1024M enabled (table at 0x000000F400800000).
>>>>> [   24.066436] amdgpu 0000:06:00.0: [drm] Internal thermal controller with fan control
>>>>> [   24.066454] amdgpu 0000:06:00.0: [drm] si dpm initialized
>>>>> [   24.068522] amdgpu 0000:06:00.0: [drm] Found UVD firmware Version: 64.0 Family ID: 13
>>>>> [   24.373744] Bluetooth: hci0: Waiting for firmware download to complete
>>>>> [   24.373862] Bluetooth: hci0: Firmware loaded in 4636395 usecs
>>>>> [   24.373926] Bluetooth: hci0: Waiting for device to boot
>>>>> [   24.378955] amdgpu 0000:06:00.0: [drm] Display Core v3.2.378 initialized on DCE 6.0
>>>>> [   24.384600] snd_hda_intel 0000:06:00.1: bound 0000:06:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
>>>>> [   24.391029] Bluetooth: hci0: Device booted in 16720 usecs
>>>>> [   24.391310] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-20-1-3.ddc
>>>>> [   24.399864] Bluetooth: hci0: Applying Intel DDC parameters completed
>>>>> [   24.404866] Bluetooth: hci0: Firmware revision 0.3 build 83 week 7 2026
>>>>> [   24.414877] Bluetooth: hci0: HCI LE Coded PHY feature bit is set, but its usage is not supported.
>>>>> [   24.542206] 8021q: 802.1Q VLAN Support v1.8
>>>>> [   24.630289] Realtek Internal NBASE-T PHY r8169-0-400:00: attached PHY driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
>>>>> [   24.800459] r8169 0000:04:00.0 eno1: Link is Down
>>>>> [   27.036649] r8169 0000:04:00.0 eno1: Link is Up - 1Gbps/Full - flow control rx/tx
>>>>> [   27.646408] [drm:dm_helpers_read_local_edid [amdgpu]] *ERROR* EDID err: 2, on connector: HDMI-A-1
>>>>> [   27.647210] amdgpu 0000:06:00.0: [drm] *ERROR* No EDID read.
>>>>> [   27.868358] amdgpu 0000:06:00.0: [drm] UVD initialized successfully.
>>>>> [   28.150630] amdgpu 0000:06:00.0: VCE initialized successfully.
>>>>> [   28.150985] amdgpu 0000:06:00.0: SE 2, SH per SE 2, CU per SH 5, active_cu_number 16
>>>>> [   28.759102] amdgpu 0000:06:00.0: Runtime PM not available
>>>>> [   28.759618] amdgpu 0000:06:00.0: [drm] Registered 6 planes with drm panic
>>>>> [   28.768282] [drm] Initialized amdgpu 3.64.0 for 0000:06:00.0 on minor 1
>>>>> [   28.770058] amdgpu 0000:06:00.0: [drm] Failed to setup vendor infoframe on connector DVI-I-1: -22
>>>>> [   28.773524] fbcon: amdgpudrmfb (fb0) is primary device
>>>>> [   28.972306] Console: switching to colour frame buffer device 240x67
>>>>> [   29.022234] amdgpu 0000:06:00.0: [drm] fb0: amdgpudrmfb frame buffer device
>>>>> [   30.133450] amdgpu 0000:06:00.0: VCE busy: VCE_STATUS=0x100, SRBM_STATUS2=0x0
>>>>> [   31.003355] usb 1-6.1: reset high-speed USB device number 5 using xhci_hcd
>>>>> [   31.527346] nvme nvme0: using unchecked data buffer
>>>>> [   32.459312] warning: `kdeconnectd' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
>>>>
>>>
>>
> 

