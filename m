Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7451364943
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270216; cv=fail; b=YV8bT1Zk9Cp8fPABEJWVkBeMAy7mn3TfEPoF2AdH/ayr6NTD6SSvG01SJI3/jL3iw9hp5tptxvVsRqAojFC87Aj9vgjRG0IzUb4h8P1ddak3AK70qqT5w2dDywvvN9MYG2MUUr/aoOTi3WOunZtdjz2dquszn4XrJIqv2qh9Dm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270216; c=relaxed/simple;
	bh=xSEKpM1l7zRcx7/hws4UYlKWwRpNyq1oXoB6lz40IVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C2JHWCCrM52rKAJbG6sybu9stY+IKa7n4X6Y16V0uPeBfsHasZAQ5+xL290gwaxlbbDGVg1ShCT75Upngz7AZj15R/U+mL+e8ehEnwHhrtcsfqYPqYIMzfSpwSIHCElTzjmA+f4sZT4CoNi2PLNj4dnZUHKkBAcLpcY0gJLoqbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KQujSo60; arc=fail smtp.client-ip=52.101.53.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KQujSo60"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BupsQDBBgrR+uSv4Mc4vPlb3PgEQtUVLi+EbAX8zHHGhLRm9TjMipvaviApBtcOR31lNSyT8CcROuiiB9ZHop8vS3BOGjbKR20gCX12rZ+wyzKB7f6tVpIq3L2nuUlehzT+1EDqP0Z34vGhk9Yd915tvX7O/b7PLIIIM09W6zqaABAXgjZMvDp3JKp1Fj7xwALeix6TWQJm0DQnTTujMGin8KfB1KhDJgfERzQG2gY9YfnNnz7mB8AfAC+F/4pEvv3SRmXbXU04LNUZN+VmCr//EZpy+qa0xnEnzno5Auxlef3kt5plEZ6Iky11LlleZYEjVhYeGWZXz0YyCuSfvTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg7ofggGLTKv7f8dynPfJpGB1shMPcI7gpRfpi71owc=;
 b=H6Lm+cDH4IhhqufcYUt5WM8qiHj+jsQwTCpEm2cEAzoIY6fsnhWjpQEnSW0Q2jBflvZXatNSvsrUwLOBxcEA9jUbIdVjWMtMvWbfynBf8jZIGx+g1IAGYjRBGHdd2tq15R2jp9xJSbD0Srpw9n+HVGd2DFKLCI6OB+1Jw4Bz5SdD1r9X7vF6Bbz6mpG3KMy4cQC7q3GQ/sZdfaXWsVLFdbdFIc+jc/WO7PoaNYRhtR9INz+Nr+L+DGQM24Jbio40CbexP7f1Z5iffNFlwcWteMpl8uWPygESX3o8LBMAHmonympVyfGeICqA+L893ngpK93A4OJiZn2o7A6QrXZPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg7ofggGLTKv7f8dynPfJpGB1shMPcI7gpRfpi71owc=;
 b=KQujSo60KdIieCToqSZEi7SGPTRvmI6TQnn9TrJb2PMO4BMWAnoUjM0a/AXOOR40uNfwiidyQY7yyJYt13L8toYt/666zNHGNdtf4WiG4OhhswWdsyyzooNpCsGuGVMZlEOb/WYUqF/As6xnXoLO8TbMpZb83UrTv4uXvy3TKPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Fri, 8 May
 2026 19:56:50 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 19:56:50 +0000
Message-ID: <399597ae-5186-4276-a585-acb1fd8155ad@amd.com>
Date: Fri, 8 May 2026 14:56:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
Content-Language: en-US
To: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Huang Rui <ray.huang@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
 <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
 <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
 <f4fd9018-2a05-454b-a887-9b1c9a8a14df@amd.com>
 <33a693a8-a460-49b7-83cb-1ab7b66ce69e@freenet.de>
 <46eaec7d-a359-40c8-9c5c-57ecc3506805@leemhuis.info>
 <8c39f42a-f024-4f05-8d77-a95e7ca1c702@amd.com>
 <b5882c89-aa71-4205-ab25-ca9f038340df@freenet.de>
 <b2b60a42-53f1-4ee7-8361-2a07737e1bad@amd.com>
 <5fa4c763-bf94-4507-8667-f3dcb032b2e0@freenet.de>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5fa4c763-bf94-4507-8667-f3dcb032b2e0@freenet.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c21f467-1082-4592-0eaf-08dead3bf16a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cHwUmXT6algcqfr9ijA+ZcHE/dcVOTx+lhHnQwuic9ZhlUtJVs936OGll4XfxAuz3BO6D0qqEZymY1GkAfDwdo2XZhfls48eCc54Ns6K1BwqSKPDbMUchTGmf2/a85PJ7wryGjZztPly8562YcZtk6eiUXoXvhEaajqOCuEmZPSVzygi6n8emc8IBsAbJwytR5eotWDHuUZTTQ5O9Cqt9v9G+5CpfUBLZZ6SyYSOfu5XDHpzlWgPl0NYJXs86vnhEzkMNVC4F5R1qHOXP6zi5+B7NxV3OPQztjcj/F4fDpS1LqTjecritGj77WpwyMwIfdtq5zyHQXpJcVcY/l1ZNCJ9jtDOe93IPMd+ewOeaLRbNCy+TlsqDM4dG7M9Dmzpry7veuue8EGwXp5sJ+FXPg40i5JHi7uwu5KtyVLCBShafeVO2UkEl7rx1pK7Jb9qCpkJVJELdJYT+oAs/VGLo3EC7MlLhab2BrwymfRlevRDcVDnG4Rsr3+QQ+yG10DL0WhnJGXWJCxFqDPShwFcIif9ODnM4mRLB+8DYhR0qkGt6OdORQJdsZyhEd3L7b83822DA8CGP2VB6zVmLtps3jgMzt9zDRQqngCBezV0y3tILXWeLbiSw6d17TMU0jtN7ib4bNkg2Xywza20IUY8/3mfbv+wdCiyNo1DWjNHWl9YMBxFfTSGy12gT+Ny7KjIw0slzAwZCLyaUKEm07bYrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1BGVUZVMlozam9pQmt3ejk2cjduaXZEVlF0bEVuRVd2NnorTW9FVTN0SDR0?=
 =?utf-8?B?eFRQYlRXaXk2TE1QRldFWERrUm1OVW1pM1BhOUlWMXk2a3FSSUpTZUZJMzRu?=
 =?utf-8?B?L2FwSjFyL09jeDRDbXFENGw4UjdwQUhLQ1Z6OVdwUWNLaEZpRUQ3VU9zNTRL?=
 =?utf-8?B?bE82Q2pWOSthclZzd0ZqWVVteThjS2krT0Z5eUxMaThxSDlYMW9HWjRvU21q?=
 =?utf-8?B?M1gxOGpOK25PYkMrcWF2UWxsWVh4b3R4K1JtemdEMzhoRUVDVXovSFJiOTg4?=
 =?utf-8?B?OHJ1bHZOQkxUcXBFaWxMTnJxNWNKS2tVRGRkdWtPc0NxRWcxWW02UkloeUJx?=
 =?utf-8?B?Vk9qS0trNkp4YXpnaTZacUN0S0hpKzVGeEZ3Z0wwMk5hR2t3T2xEai95TTJI?=
 =?utf-8?B?VmNCdS8wL1lzZEtuVjFNbi9xQ05kTUhtU2dmWlRJci9hMWFLYnBOS1NYZzRK?=
 =?utf-8?B?M3AyU2VRR21xRjN2KzlWNXVyM01BTGlTbzJ0d3JrUEhIRHd2ZzVzdEs2SWd5?=
 =?utf-8?B?bmJZQWltZGI3VVVWKzNGLzdlclhjVXM1MzB1TDdvamRabytIUDBvOHg5UkhC?=
 =?utf-8?B?VGVkRVlhZFZndldWM2RxaFVPVFgxNXpHQk9ub0dsZkxla3pLQWJmelFxM0Y4?=
 =?utf-8?B?eEh3NlBFYmh3WWVqenFmVFhoeUQzaDRnK3cyZ2ZKMkRKbERTckdMRUI1RTVC?=
 =?utf-8?B?eFdJRStDd0hsdmhkQXdSQ3Y0Mm1qbDU3eE5ibXY2SjFyZEJidStaUDFvU2F4?=
 =?utf-8?B?S2Z6Vit3ZXhJdVVPTm0wMGxvMmVMMEk2STdwdVhEdHJjalF1Sk9vN1dyTHNn?=
 =?utf-8?B?cUpkQjNkcXJ5ZDlpaHQ5Uk5TL1dxNnd4dnYxWTN2aUI1OXhhbDhKR2hTSkVp?=
 =?utf-8?B?aHpySjl6SzlreTUxSjErWlREWHJKM2J3d0JuOFJGWGpGaHRZTjdMeEU3RjZR?=
 =?utf-8?B?MzZmOEFQVFFqSWgzYWgvZmNIMENMU3c2cnljWVJyalM2Z04vaGFvaGltYlNj?=
 =?utf-8?B?Q0Z2OXVtRHpFRUxQd0FpcXh0eGdmaGN3SXlUenAreVZSdUVVVUZidXp1Ym9Y?=
 =?utf-8?B?VFB3eVl6SEJEb0VFaVJ4ZUhUQ2MvaUR2Z1NWK0l6WStqTDZuWHpLcEVDdVh6?=
 =?utf-8?B?L3RXMjU1ejNYNjM1MzMvWmY1TWVjYXF4THRCQnpDbEhIVWdDL3ZrcWJQS1hu?=
 =?utf-8?B?V1dXMGtVN1p2YWl1SDR5cFlXM2RCbllYU1d1NFNMNUFEVXVBT0ZOMERUQkc3?=
 =?utf-8?B?V2xwUXNvZVdJN0N3LzFkSmpSZmNBbGZqZkF0VU5ZWHdkU3F6c1I2U2Qxbkc4?=
 =?utf-8?B?dm9HUGFUNTNKdTE2RjNYVXBhOVJzdzlaSTluU2VWYXcwdDhxTFNHWC92UUpq?=
 =?utf-8?B?b1h6bnBGaG5ZbktIU0U5RFdRYVlwc28xMEs5NmIzditIenJDR2RwY0ZqUjd1?=
 =?utf-8?B?NlZQc0FvQVNYM2pSYlZrdHRNajlPR01OWXRkak9MWFJZMHdaaE14bUp4NGFm?=
 =?utf-8?B?NndaOExpTEZqK2Z2Lzg0RnhTRnJFZHFwM2pkRGVWdSs3a2tUZzMwMURQTnho?=
 =?utf-8?B?TU9EVi9pbzk1TC82QXoxblJUdnMvc3BSVjJRbDJUektvQTJ0Q1FHRlo1VFp4?=
 =?utf-8?B?TlB3aHE0dS9TWjJpWkJ1SlRiN00xU2V5c0ZoZHpsZ2ZId25pWlVmSHhVR2Rz?=
 =?utf-8?B?MmtoamJ4KzNZQ2dKdUtxNTNrdVRuNjM2akpaclNWQ2ZLOHdqbCtjYUlnNFRn?=
 =?utf-8?B?alpFUU1TV2xCN3JmK0xhRHFuSUtoaWRwd244S0x1V1VTTmJtT1l5dlE1T1ZX?=
 =?utf-8?B?RGlGZWdWTGJIdkJIQjNHRjdoZUdpWmI3QXF5SXgwSUhueDdMZCtFeTFoTGJB?=
 =?utf-8?B?b0c0SFJwdForSUxHZDAwT2JkLzZFNjRWWDNOTmY0Nk1vUVlvV2g5U2k4ZUY3?=
 =?utf-8?B?SDhvUVBKNW10QXJpZ3ZRNUl0VUprd1NIb2YyS3piTElXYmhJVW14U2tvdGlp?=
 =?utf-8?B?NkhKcm1ZT1pveHQxL25uTGlUSit4c2RxdHlON0tkNVNWcDhCR21lQkFJcXZ4?=
 =?utf-8?B?TUpjWWRaYVlRNCtncUU0MisycGxET0dOYXVqclRUdlMvdzdCWVROeVZWSVlv?=
 =?utf-8?B?YkVJdUJEek9WNzZFNFlGTlNJazhPdDdEVWczNmxmWWJtdDV5NEhrT1NOby9l?=
 =?utf-8?B?QjdBelM2OE5XS29hTVZ0TGEyWnJtTGtUNGFOVXhRTWJEYVc5cGVRRldKdXJn?=
 =?utf-8?B?TzQwd3ZFek5DdUo2S09EeTR5dWNQNCtyOXF0YnVUM1R2aUdRMWpwUkxjcHY0?=
 =?utf-8?B?TmNIR2ZQcWNaTXRYcmFOVkkxUEI1SVRYVnpSZzNmbWpBdG10WVB2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c21f467-1082-4592-0eaf-08dead3bf16a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 19:56:49.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIxEbqjfiwNokM2j5sT0PvuQSVaAs+Rpw1B8ENiGpupu9E0VMphEIDcNW1kPso1I3D2Tm92ujQtjEmfsqDLAKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375



On 5/8/26 14:53, Viktor Jägersküpper wrote:
> Am 08.05.26 um 21:01 schrieb Mario Limonciello:
>> On 5/8/26 13:56, Viktor Jägersküpper wrote:
>>> Am 08.05.26 um 14:57 schrieb Mario Limonciello:
>>>> On 5/8/26 04:31, Thorsten Leemhuis wrote:
>>>>> * there is a whole patch series with fixes for the culprit:
>>>>> https://lore.kernel.org/all/20260508051748.10484-1-kprateek.nayak@amd.com/
>>>>>
>>>>
>>>> I don't think any of these will help; but that would a fine surprise if so.
>>>>
>>>
>>> This patch series fixes the bug when I boot with "amd_dynamic_epp=disable" (I built
>>> the kernel with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y). I didn't bisect to find out
>>> which patch contains the partial fix, but I can do this if it helps.
>>>
>>> If you need further information (acpidump and/or output from amd-pstate tool), just
>>> tell me.
>>
>> When you have dynamic EPP enabled it sets up platform profile.  With that series in place does changing platform profile help?
> 
> Strangely *changing* the power profile (to any value) seems to enable the expected
> boosting behaviour, but since I can only do that when the PC has finished booting,
> the cores still seem to be stuck at ~1.7 GHz until then. Unless I am doing something
> stupid, that's not how it's supposed to work, I guess?

Can you confirm your tree when you found this?
7.1-rc2 + Prateek's series?

I would say that is not expected behavior; but it does hint further at 
the second bug.  Hopefully I can repro it.

> 
>>> Last week I got this output after applying a debugging patch from you:
>>>>> On 4/29/26 20:34, Viktor Jägersküpper wrote:
>>>>>> Am 29.04.26 um 19:14 schrieb Mario Limonciello:
>>>>>>>
>>>>>>> OK thanks.  Here is a debugging patch that should show what's happening in the new paths from e30ca6dd5345c5b8ba05f346a8e81105352fe571 so we can confirm root cause on your system.
>>>>>>
>>>>>> These are the dmesg lines concerning amd-pstate:
>>>>>> [    0.845044] amd_pstate: amd_pstate: CPU 0: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.845047] amd_pstate: amd_pstate: CPU 0: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.845059] amd_pstate: amd_pstate: CPU 0: platform_profile_register succeeded
>>>>>> [    0.845060] amd_pstate: amd_pstate: CPU 0: registering power supply notifier
>>>>>> [    0.849046] amd_pstate: amd_pstate: CPU 1: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.849047] amd_pstate: amd_pstate: CPU 1: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.849058] amd_pstate: amd_pstate: CPU 1: platform_profile_register succeeded
>>>>>> [    0.849059] amd_pstate: amd_pstate: CPU 1: registering power supply notifier
>>>>>> [    0.853043] amd_pstate: amd_pstate: CPU 2: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.853044] amd_pstate: amd_pstate: CPU 2: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: platform_profile_register succeeded
>>>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: registering power supply notifier
>>>>>> [    0.857043] amd_pstate: amd_pstate: CPU 3: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.857044] amd_pstate: amd_pstate: CPU 3: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: platform_profile_register succeeded
>>>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: registering power supply notifier
>>>>>> [    0.861045] amd_pstate: amd_pstate: CPU 4: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.861046] amd_pstate: amd_pstate: CPU 4: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.861056] amd_pstate: amd_pstate: CPU 4: platform_profile_register succeeded
>>>>>> [    0.861057] amd_pstate: amd_pstate: CPU 4: registering power supply notifier
>>>>>> [    0.865044] amd_pstate: amd_pstate: CPU 5: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.865046] amd_pstate: amd_pstate: CPU 5: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.865057] amd_pstate: amd_pstate: CPU 5: platform_profile_register succeeded
>>>>>> [    0.865058] amd_pstate: amd_pstate: CPU 5: registering power supply notifier
>>>>>> [    0.870044] amd_pstate: amd_pstate: CPU 6: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.870046] amd_pstate: amd_pstate: CPU 6: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: platform_profile_register succeeded
>>>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: registering power supply notifier
>>>>>> [    0.874044] amd_pstate: amd_pstate: CPU 7: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.874045] amd_pstate: amd_pstate: CPU 7: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.874056] amd_pstate: amd_pstate: CPU 7: platform_profile_register succeeded
>>>>>> [    0.874057] amd_pstate: amd_pstate: CPU 7: registering power supply notifier
>>>>>> [    0.878045] amd_pstate: amd_pstate: CPU 8: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.878046] amd_pstate: amd_pstate: CPU 8: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.878055] amd_pstate: amd_pstate: CPU 8: platform_profile_register succeeded
>>>>>> [    0.878056] amd_pstate: amd_pstate: CPU 8: registering power supply notifier
>>>>>> [    0.882045] amd_pstate: amd_pstate: CPU 9: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.882046] amd_pstate: amd_pstate: CPU 9: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.882055] amd_pstate: amd_pstate: CPU 9: platform_profile_register succeeded
>>>>>> [    0.882056] amd_pstate: amd_pstate: CPU 9: registering power supply notifier
>>>>>> [    0.886045] amd_pstate: amd_pstate: CPU 10: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.886046] amd_pstate: amd_pstate: CPU 10: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.886055] amd_pstate: amd_pstate: CPU 10: platform_profile_register succeeded
>>>>>> [    0.886056] amd_pstate: amd_pstate: CPU 10: registering power supply notifier
>>>>>> [    0.890045] amd_pstate: amd_pstate: CPU 11: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.890046] amd_pstate: amd_pstate: CPU 11: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: platform_profile_register succeeded
>>>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: registering power supply notifier
>>>>>> [    0.894046] amd_pstate: amd_pstate: CPU 12: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.894047] amd_pstate: amd_pstate: CPU 12: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.894056] amd_pstate: amd_pstate: CPU 12: platform_profile_register succeeded
>>>>>> [    0.894057] amd_pstate: amd_pstate: CPU 12: registering power supply notifier
>>>>>> [    0.898046] amd_pstate: amd_pstate: CPU 13: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.898047] amd_pstate: amd_pstate: CPU 13: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.898055] amd_pstate: amd_pstate: CPU 13: platform_profile_register succeeded
>>>>>> [    0.898056] amd_pstate: amd_pstate: CPU 13: registering power supply notifier
>>>>>> [    0.902046] amd_pstate: amd_pstate: CPU 14: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.902048] amd_pstate: amd_pstate: CPU 14: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: platform_profile_register succeeded
>>>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: registering power supply notifier
>>>>>> [    0.906046] amd_pstate: amd_pstate: CPU 15: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.906048] amd_pstate: amd_pstate: CPU 15: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: platform_profile_register succeeded
>>>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: registering power supply notifier
>>>>>> [    0.910046] amd_pstate: amd_pstate: CPU 16: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.910048] amd_pstate: amd_pstate: CPU 16: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.910058] amd_pstate: amd_pstate: CPU 16: platform_profile_register succeeded
>>>>>> [    0.910059] amd_pstate: amd_pstate: CPU 16: registering power supply notifier
>>>>>> [    0.914047] amd_pstate: amd_pstate: CPU 17: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.914048] amd_pstate: amd_pstate: CPU 17: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.914059] amd_pstate: amd_pstate: CPU 17: platform_profile_register succeeded
>>>>>> [    0.914060] amd_pstate: amd_pstate: CPU 17: registering power supply notifier
>>>>>> [    0.918049] amd_pstate: amd_pstate: CPU 18: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.918051] amd_pstate: amd_pstate: CPU 18: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.918081] amd_pstate: amd_pstate: CPU 18: platform_profile_register succeeded
>>>>>> [    0.918082] amd_pstate: amd_pstate: CPU 18: registering power supply notifier
>>>>>> [    0.922049] amd_pstate: amd_pstate: CPU 19: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.922051] amd_pstate: amd_pstate: CPU 19: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.922070] amd_pstate: amd_pstate: CPU 19: platform_profile_register succeeded
>>>>>> [    0.922071] amd_pstate: amd_pstate: CPU 19: registering power supply notifier
>>>>>> [    0.926049] amd_pstate: amd_pstate: CPU 20: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.926052] amd_pstate: amd_pstate: CPU 20: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.926073] amd_pstate: amd_pstate: CPU 20: platform_profile_register succeeded
>>>>>> [    0.926074] amd_pstate: amd_pstate: CPU 20: registering power supply notifier
>>>>>> [    0.930049] amd_pstate: amd_pstate: CPU 21: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.930052] amd_pstate: amd_pstate: CPU 21: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.930071] amd_pstate: amd_pstate: CPU 21: platform_profile_register succeeded
>>>>>> [    0.930072] amd_pstate: amd_pstate: CPU 21: registering power supply notifier
>>>>>> [    0.934050] amd_pstate: amd_pstate: CPU 22: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.934052] amd_pstate: amd_pstate: CPU 22: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.934072] amd_pstate: amd_pstate: CPU 22: platform_profile_register succeeded
>>>>>> [    0.934073] amd_pstate: amd_pstate: CPU 22: registering power supply notifier
>>>>>> [    0.938050] amd_pstate: amd_pstate: CPU 23: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>> [    0.938052] amd_pstate: amd_pstate: CPU 23: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>> [    0.938073] amd_pstate: amd_pstate: CPU 23: platform_profile_register succeeded
>>>>>> [    0.938074] amd_pstate: amd_pstate: CPU 23: registering power supply notifier
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

