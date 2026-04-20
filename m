Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762A31A7E4;
	Mon, 20 Apr 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690456; cv=fail; b=jtWDAZFu57Pj9TtYyqc4rzlw5nBeAU28HUYavciqxv3mx3kt43BFohWpW4+L3jgnZbjojPjl+yg6Axgld7pYEDrlWRZVdl1cPqw64X10cVNDEcu9IGZgkeM0SyQbqwcNSwtIebXyiuWd9M70lErWCU9kUhw/8D7/wRGsMXTEuzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690456; c=relaxed/simple;
	bh=onh0ncxfRhQO16TW63UB+jVLBOHfg6zle1D6olQWa2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VKWKIKYbjBved8V8rDCeX+A2fwqg8gEdGeig8wU5qMVrYQ8AeNp2IMCq5MmEsKu08MaRGQq8WNoaeynXCEDZp5Az3k3ZgvzzXClvY0Bq8kGEmNE6R5WK/gcU9vCGJKlU+d9dCt/KK3sNMUn/dW9OKpOCc+f2KcDk0PkJnlNbBVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PfVYtWrk; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PfVYtWrk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFIt6cw5JXuSKtwMjqMHcKLUKTLS3rqYtMI5E1onALg2Ue7pXLJm13ZeITYm2LWlo8ZL5QRzkyBw3CbO2GPzIYc/QiEy0RwVrEHI3kChio8bCwXQlh9qsrTyaUNhEeB4NIwKtpiCZ8/PHsxkNrrPt9v/fDY9+lhs5K9dHaJB9D2iEHGJjconrvXkdIejA9diL/eV8+jBMdmAn4Yb2kHSgCKVG06pgmLaFeKV0S6whc1nnc+7iHSoDiaagiTnNpCQVvh9WMzP0VLxkNfMu7Iiqqecmt4Vi3xF93kVZLltNmlOPxM8v3ErpwgTmySQxmkREe9LimgFU7ybJF39cN3Vag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ERXn0k6kyf/Oppr8zKpPxdHjuauLmGQkouRDJdZ5do=;
 b=w8XUINd1xi8RiefajiQi+01GgrJcxTcYnDCyI7stDMS+uwPTCbx3BMx1QvNctlU69nBbTlh6kUZEUaG3CETnI6iVwXlxTVtUumhY1fXeCA+pT6tk4wx4vHr8XVBWcsJkpF+NLfxgtga7OzpV2sd7tOOucMg9Lr0PO+6HbPRR1xZJHLnys0kdYd8JTlMAUh70DnSqKsgFbD1UEgVekfomluPf3Rr8SNUMFn+iQqggu2NSm0d4DQzYY4jsF173+gFqZ9kibWDOxGsdBP3VJGMrrQpCDSMtXshqvaUP0vMpvk84bNSoKUdhK7XEAE/EjDSBY04fMcqeF40aGap3Ro11iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ERXn0k6kyf/Oppr8zKpPxdHjuauLmGQkouRDJdZ5do=;
 b=PfVYtWrklssMOvcTgQMG00bzvesLMM1dQ8+J5q89IPk7HgJ1QX1REu8kCHtlj1YNDkg9xEAYE49Oal98eTgZhnw0NvDLkfzHfATDY/6WiNCCukpjw3PFtuOH4RnWeR4x2LBP/Rt9ebzNXHs/rfmo6EJpzVCnzCy/aEBetAF0sZITesnRqcOtvEZyqxIDtape/a758A0lGCj6eKhdrZcC3XOsdWvRYniurqQ6+KpM4KrKCQiEpoKfFufkV0BSOE66t/zmEXIFqd58unGe8MFfi5IfPKTmqiOJiBfFZY1OH5IiwK6beKreuXfoxM882+A6FF001n1G4bxMKpO3qFk9DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 13:07:26 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 13:07:26 +0000
Message-ID: <0fdc7e64-31aa-4bfd-ab27-dea2f349693b@nvidia.com>
Date: Mon, 20 Apr 2026 18:37:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: add autonomous mode boot parameter support
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "zhenglifeng1@huawei.com" <zhenglifeng1@huawei.com>,
 Thierry Reding <treding@nvidia.com>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 "ionela.voinescu@arm.com" <ionela.voinescu@arm.com>,
 Krishna Sitaraman <ksitaraman@nvidia.com>,
 Sanjay Chandrashekara <sanjayc@nvidia.com>,
 "zhanjie9@hisilicon.com" <zhanjie9@hisilicon.com>,
 "corbet@lwn.net" <corbet@lwn.net>, Matt Ochs <mochs@nvidia.com>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 Bibek Basu <bbasu@nvidia.com>, "rdunlap@infradead.org"
 <rdunlap@infradead.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "rafael@kernel.org" <rafael@kernel.org>, sumitg@nvidia.com
References: <20260317151053.2361475-1-sumitg@nvidia.com>
 <4b1f100b-e699-43c1-a06b-5545056d174c@arm.com>
 <b8debb30-67a5-4d2b-8c08-8fd287f7258e@nvidia.com>
 <208360b1-36a5-419d-80f4-431914407f61@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <208360b1-36a5-419d-80f4-431914407f61@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0166.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::9) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SJ2PR12MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef81afb-6b2a-4755-4f20-08de9eddc4b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|13003099007|56012099003;
X-Microsoft-Antispam-Message-Info:
	a7cI1dyjHi573/ySKxDqVuAsYrK5anXB6xR3NfSA6gX55l16Pu9pJv0MehJXdzJhokQcUGGWqTpHLqgGL3DSFtqf5vAl+oHMvcMMMnAkvd0Jys4W9lUN2JjfV8gn8TrYxqbZxaqE8tSwNrFeHPrfI3mWEsVFC0iiTHMiQl5y45iXM9efIMu1YzbgFRR/dn9m++jnEEDaxLb1flFbtjXip00YG95BMfjlq/vQQrdVcToD7EHnUIPQXLl1y1waDwN5mhi3+wAE5hmGgasNlI1CPXO4Wdry6S6xxYtnZ99t+Y/+96otI66FGHJwk3VuVHUiMggOwqomzFze4w1NDbo9x8Ogi4LoHZazUyHlK3GeRhQo6bjYF/gu8gU5njLLurSdlcPXvakAmpN/EKSakpZRO4sjabJiSqLInEF8yZSpUNBPfmY0+aFLJ5pYliK61UClVh+67veNKlDMTETWdwEriglFWyMIZ8hPer/cbr343OT/uOuyjvby5ZYAWsod4m9yE9A34eMu4KqjXMPWM6YAcNX21MDpisSbwulKyJ9wQyQE9g40vjGCqJN6okrl9EBDtm8O0TPXwtZOP2ZlvNSm33UwrZtXTUDLOHKnrBk3iMMFzKKy6RVSfEU8tHbOeTDECSRE0nueTSvrKNU6FeKF8jtKp5lyiCb5tydrywp7SlJaB8TMn8acCOVz3+QNbf+NaXXTbO+I2/1DQnmhfRxF8tz4IONuwaAhczHyMuCoO7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(13003099007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bktGK2ZoRC9Ucm9rQWtiSVZzNFZLaVczODg2MEkrOWYwak5YRFpDYzlKU2FW?=
 =?utf-8?B?bzFKbDI2Vzkrc2RkU3VTRTl3TytZenhDQU84V2ZxWEZHU1FEN3NHTHIrWXdh?=
 =?utf-8?B?TzREWm1LdWM1T25WM2VsU0xpZ3BOUGVETEppblgyWHZlVm0wVVJkekZRNzFs?=
 =?utf-8?B?Y3RMNzZVaE92QkNxb016aFVKRTFoQWJFTzFiYmZQSnVSNndKeUQwRk5BWkM0?=
 =?utf-8?B?Y09GaldNdlg3VUtFczBuLzQ2cFBaV1VQbDNSYjBpM0VNT2JaaGNXZW1pNEFu?=
 =?utf-8?B?UnJxS3M3MUZMT1U2OS9aZXQraWtxYzR4WVZOT1ZsUGcxRTdGdFJLTHBjVzc2?=
 =?utf-8?B?NG1yTnBNSkxuN3BxR2RyWGwrYm1uMk0vM283UE41UGNjaU15aUx3bWRzSFQ3?=
 =?utf-8?B?eitHMVJmc1BDWHhYUk9kclF4cCtRTUszbmZRajVKK2NqUnloWkZYN3hZdWN3?=
 =?utf-8?B?T0F6bHREeXg4STQ2N0NicUpCV05uY3h1eWtYc0R0ckJ3cFpyUE9YYThBYklR?=
 =?utf-8?B?Z2lyUUxVMTkzSUM3WnpRQlhMSHhlR0xZZm9oYmIyWno1SFZXOHY5ZkxvT3ht?=
 =?utf-8?B?TFZuQjh4ZDcweTI0elFKUXRWVFVsRnR4d2owQ0tqdjdNL2UzL1k2bS9qNnRX?=
 =?utf-8?B?anpVUkRhQUhYNC9FYisxU2l6TDh5aHZGZ1o4SkUvVVcrSER4OWhCMTNJSHZG?=
 =?utf-8?B?Tys3cVAwNDQ1RjdyMFpCcXJsL2RZa1c5UzVzNjJCb2Q4MHVta05RWWwwOGlC?=
 =?utf-8?B?Qk5PNm80MnEremxXMWlhRmk1bUg2Tnd2U3pWRmc5VG9RbVdtVUxlNEc4bUVi?=
 =?utf-8?B?S2lreG10TlB4d1RwazhkaGFxa1hrTVdYV3pHb1ZkNXRuVWZxWDdjMmRQbDNT?=
 =?utf-8?B?ajJDdFlYeThPWGY0dzc2UHVkenBJWUtDQnhUd05BK3lYc1k2WjIyVk8zOXB2?=
 =?utf-8?B?dUNUZmRGMm5DZnRpWHdwTUNWK2g4MU1wajNENjBTUmV0d0VwVjQwaDYyeC9U?=
 =?utf-8?B?bmtKUEc3YWRDU0VMeE1zQk1ucmhvUWxjNW93VEZFQU9mQ3ErT0N2QnNsMEFm?=
 =?utf-8?B?YU9zQXREbGdqR25JYlNuZHVFcHhpL3Q1Z0F6ZFk2TS9OUkEzcjNTV1JpOTA2?=
 =?utf-8?B?V0pQOFZudjUyVExCaGJydkY4dFZ0YzZKWThIR0o0VUkySXRYbDdYcUFsd01n?=
 =?utf-8?B?TkxQZllDT2pORkRaSE1BTnVvbTU2NzNJR1ZPemM0MC9yTTN2TDZvMjcyL29n?=
 =?utf-8?B?V09KK3lnZExxMzM1RGVSUllrdHd3OXliQnYwbVBETTE5MGJZRjAxUzlJMGxn?=
 =?utf-8?B?WkxrRW5oNEtpM01qVFNac0FXVVVJeXc3OHZ6Z1Nnd2NycDRnMjlkZ3hKajV3?=
 =?utf-8?B?N2gxNDBtMWRaQkVEY1N4WmpmdHFuZ0VwSVBXd3Yzbms0bHRMaHhPS0Zsb3dr?=
 =?utf-8?B?UGJ2Z210UC9QK2g2TmhBYWF2NXVJVW41UGZKWmNJOU9JM3o4SEN0eVhnMWxM?=
 =?utf-8?B?TTFoN0wya2NrOVQ4dllqbHBLR2s5dndseVJYWlhPUSs0MThOSlZqT05WaWJF?=
 =?utf-8?B?dTBpNUxnU0Y0YlhTQVhQdTNPQlpiOTVWaHJramF6SmdkQUx6QWxTcnlaU1Nm?=
 =?utf-8?B?UFlSTWFpOURBOWFsYndVcERkaE1YTmJlalJ5Y2dZaEd2OE4rcjhXajZodFky?=
 =?utf-8?B?a2d5TXhCUDlPSU03UGVET2hnMDdFeHM1bXptdHc2L3RqVTBXVEFsUFoyQVZY?=
 =?utf-8?B?aHZIdUg0Nndwc3FJUXRIVk02b2lYS3JOTUcxVUFxV01XelZROFpoSndremdE?=
 =?utf-8?B?bzliR1FPdFh4L3JTdEk3VFdod2Z3RmlHVmt5T1E3UXhjWTVQWXdiRUhvR1lz?=
 =?utf-8?B?WEdTK3FhenltYm9MREtiOSt1SE5aWkUwb1NvVm41Q255dGg0MGp1VUVzRlEr?=
 =?utf-8?B?ODlqZHlHT1NaRHNKNGlsNXFQQTZaaHNZYlQxSDk0U010N2xrUjhicnJja2ZH?=
 =?utf-8?B?QUUvRStuQmkzQzQzenV4VUZvNTRvUWE0c25uN0syOGZGYnJybTZpdXNRTWZt?=
 =?utf-8?B?RjhyNWhPY29hbGZjK002anVDNUgyMFlEcDVNSkE1dm5ZOHByVHZTMnE3YjVE?=
 =?utf-8?B?SDJVb3EzQU5Jb1VBLzJ3cFhJYlpLMERpNWtPeTkrMHNnWDAvOStIdm8vMmNK?=
 =?utf-8?B?OThOb3dZeHpXY2U2U2dnTko4bEdKcmM3ZWUxQlBKUzl3YVRqRzFCQVlOODVD?=
 =?utf-8?B?b3JldUI4dG9UL3NmSDd2NklsUXlzWlpYcmUxU2xteWU1M2NkUE45eXpTS2lZ?=
 =?utf-8?Q?Ms9MNORu/Icjw0nOxk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef81afb-6b2a-4755-4f20-08de9eddc4b8
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 13:07:26.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oplyKcd9BuwrSBWJJwv1VNj+3S9l/d6iLpJg1u4MoKnPUW4yfTprpmgELyps5KWuDRuMCjP4ot2hm2v8llYSBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800


>>> On 3/17/26 16:10, Sumit Gupta wrote:
>>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable CPPC
>>>> autonomous performance selection on all CPUs at system startup without
>>>> requiring runtime sysfs manipulation. When autonomous mode is enabled,
>>>> the hardware automatically adjusts CPU performance based on workload
>>>> demands using Energy Performance Preference (EPP) hints.
>>>>
>>>> When auto_sel_mode=1:
>>>> - Configure all CPUs for autonomous operation on first init
>>>> - Set EPP to performance preference (0x0)
>>>> - Use HW min/max when set; otherwise program from policy limits (caps)
>>>> - Clamp desired_perf to bounds before enabling autonomous mode
>>>> - Hardware controls frequency instead of the OS governor
>>>>
>>>> The boot parameter is applied only during first policy initialization.
>>>> On hotplug, skip applying it so that the user's runtime sysfs
>>>> configuration is preserved.
>>>>
>>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>> Part 1 [1] of this series was applied for 7.1 and present in next.
>>>> Sending this patch as reworked version of 'patch 11' from [2] based
>>>> on next.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/
>>>> [2]
>>>> https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         | 13 +++
>>>>    drivers/cpufreq/cppc_cpufreq.c                | 84
>>>> +++++++++++++++++--
>>>>    2 files changed, 92 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>> index fa6171b5fdd5..de4b4c89edfe 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -1060,6 +1060,19 @@ Kernel parameters
>>>>                        policy to use. This governor must be
>>>> registered in the
>>>>                        kernel before the cpufreq driver probes.
>>>>
>>>> +     cppc_cpufreq.auto_sel_mode=
>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous
>>>> performance
>>>> +                     selection. When enabled, hardware
>>>> automatically adjusts
>>>> +                     CPU frequency on all CPUs based on workload
>>>> demands.
>>>> +                     In Autonomous mode, Energy Performance
>>>> Preference (EPP)
>>>> +                     hints guide hardware toward performance (0x0)
>>>> or energy
>>>> +                     efficiency (0xff).
>>>> +                     Requires ACPI CPPC autonomous selection
>>>> register support.
>>>> +                     Format: <bool>
>>>> +                     Default: 0 (disabled)
>>>> +                     0: use cpufreq governors
>>>> +                     1: enable if supported by hardware
>>>> +
>>>>        cpu_init_udelay=N
>>>>                        [X86,EARLY] Delay for N microsec between
>>>> assert and de-assert
>>>>                        of APIC INIT to start processors.  This delay
>>>> occurs
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 5dfb109cf1f4..49c148b2a0a4 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -28,6 +28,9 @@
>>>>
>>>>    static struct cpufreq_driver cppc_cpufreq_driver;
>>>>
>>>> +/* Autonomous Selection boot parameter */
>>>> +static bool auto_sel_mode;
>>>> +
>>>>    #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>    static enum {
>>>>        FIE_UNSET = -1,
>>>> @@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct
>>>> cpufreq_policy *policy)
>>>>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>        cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>
>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> -     if (ret) {
>>>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>>>> -                      caps->highest_perf, cpu, ret);
>>>> -             goto out;
>>>> +     /*
>>>> +      * Enable autonomous mode on first init if boot param is set.
>>>> +      * Check last_governor to detect first init and skip if auto_sel
>>>> +      * is already enabled.
>>>> +      */
>>> If the goal is to set autosel only once at the driver init,
>>> shouldn't this be done in cppc_cpufreq_init() ?
>>> I understand that cpu_data doesn't exist yet in
>>> cppc_cpufreq_init(), but this seems more appropriate to do
>>> it there IMO.
>>>
>>> This means the cpudata should be updated accordingly
>>> in this cppc_cpufreq_cpu_init() function.
>> In an earlier version [1], the setup was in cppc_cpufreq_init() but
>> was moved to cppc_cpufreq_cpu_init() to improve per-CPU error handling.
>> Keeping the setup in cppc_cpufreq_init() helps to avoid the last_governor
>> check. We can warn for a CPU failing to enable and continue so other
>> CPUs keep autonomous mode.
>> cppc_cpufreq_cpu_init() would then just check the auto_sel state
>> from register and sync policy limits from min/max_perf registers when
>> autonomous mode is active.
>> Please let me know your thoughts.
> FWIU the auto_sel_mode module parameter allows to
> configure the default auto_sel_mode when the driver is
> first loaded, so there should not need to check that again
> whenever cppc_cpufreq_cpu_init() is called.
> Maybe Ionela saw something we didn't see ?

AFAIU, the concern in that review [1] was about error handling as the
earlier version disabled auto_sel on all CPUs if any single CPU failed.
Per-CPU error handling in cppc_cpufreq_init() (warn and continue)
addresses that. Can't think of more reason.
Do you have anything in mind?


>
> Also just to be sure, should it still be possible to change
> the auto_sel_mode through the sysfs if the driver was
> loaded with auto_sel_mode=1 ?
>


Yes, the per-CPU auto_select sysfs attribute works independently of the
boot param. Users can enable or disable auto_sel on any CPU at runtime
via sysfs, regardless of how the driver was loaded. The boot param only
sets the initial state.


>> [1]
>> https://lore.kernel.org/lkml/5593d364-ca37-41c5-b33f-f7e245d6d626@nvidia.com/
>>
>>
>>>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>>>> +         !cpu_data->perf_ctrls.auto_sel) {
>>>> +             /* Enable CPPC - optional register, some platforms
>>>> need it */
>>> The documentation of the CPPC Enable Register is subject to
>>> interpretation, but IIUC the field should be set to use the CPPC
>>> controls, so I assume this should be set in cppc_cpufreq_init()
>>> instead ?
>> Agree that the CPPC Enable is about using the CPPC control path
>> in general and not only for autonomous selection.
>> Will move cppc_set_enable() into cppc_cpufreq_init() or outside the
>> autonomous mode block in cppc_cpufreq_cpu_init() as per conclusion
>> of previous comment.
>>
>>>> +             ret = cppc_set_enable(cpu, true);
>>>> +             if (ret && ret != -EOPNOTSUPP)
>>>> +                     pr_warn("Failed to enable CPPC for CPU%d
>>>> (%d)\n", cpu, ret);
>>>> +
>>>> +             /*
>>>> +              * Prefer HW min/max_perf when set; otherwise program
>>>> from
>>>> +              * policy limits derived earlier from caps.
>>>> +              * Clamp desired_perf to bounds and sync policy->cur.
>>>> +              */
>>>> +             if (!cpu_data->perf_ctrls.min_perf ||
>>>> !cpu_data->perf_ctrls.max_perf)
>>> The function doesn't seem to exist.
>> It is newly added in [2].
>> Don't need to call it if we move the setup to cppc_cpufreq_init().
> Ah ok right thanks.
>
>
>> [2]
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ea3db45ae476889a1ba0ab3617e6afdeeefbda3d
>>
>>
>>
>>>> + cppc_cpufreq_update_perf_limits(cpu_data, policy);
>>>> +
>>>> +             cpu_data->perf_ctrls.desired_perf =
>>>> +                     clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>>>> + cpu_data->perf_ctrls.min_perf,
>>>> + cpu_data->perf_ctrls.max_perf);
>>>> +
>>>> +             policy->cur = cppc_perf_to_khz(caps,
>>>> + cpu_data->perf_ctrls.desired_perf);
>>>> +
>>> Maybe this should also be done in cppc_cpufreq_init()
>>> if the auto_sel_mode parameter is set ?
>> Yes.
>>
>>>> +             /* EPP is optional - some platforms may not support it */
>>>> +             ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
>>>> +             if (ret && ret != -EOPNOTSUPP)
>>>> +                     pr_warn("Failed to set EPP for CPU%d (%d)\n",
>>>> cpu, ret);
>>>> +             else if (!ret)
>>>> +                     cpu_data->perf_ctrls.energy_perf =
>>>> CPPC_EPP_PERFORMANCE_PREF;
>>>> +
>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> +             if (ret) {
>>>> +                     pr_debug("Err setting perf for autonomous mode
>>>> CPU:%d ret:%d\n",
>>>> +                              cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>> +
>>>> +             ret = cppc_set_auto_sel(cpu, true);
>>>> +             if (ret && ret != -EOPNOTSUPP) {
>>>> +                     pr_warn("Failed autonomous config for CPU%d
>>>> (%d)\n",
>>>> +                             cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>> +             if (!ret)
>>>> +                     cpu_data->perf_ctrls.auto_sel = true;
>>>> +     }
>>>> +
>>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>> There is a patchset ongoing which tries to remove
>>> setting policy->min/max from driver initialization.
>>> Indeed, these values are only temporarily valid,
>>> until the governor override them.
>>> It is not sure yet the patch will be accepted though.
>>>
>>> https://lore.kernel.org/lkml/20260317101753.2284763-4-pierre.gondois@arm.com/
>>>
>>
>> You are right that policy->min/max from .init() are temporary today
>> as cpufreq_set_policy() overwrites them before the governor starts.
>>
>> On my test platform (highest == nominal, lowest_nonlinear == lowest),
>> this had no visible effect because the BIOS bounds and cpuinfo range
>> end up identical. But on platforms where they differ, the governor
>> would widen the range to full cpuinfo limits.
>>
>> I think your patch [3] fixes this by giving these the right semantic as
>> initial QoS requests. With it, cpufreq_set_policy() preserves the policy
>> limits set from min/max_perf registers in .init(), which can either be
>> BIOS values on first boot or last user configured values before hotplug.
>>
>> I will update the comment in v2 to reflect QoS seeding intent.
>>
>> I see that the first two patches of your series [3] is applied for 7.1.
>> Do you plan to send the pending patch (3/4) from [3]?
>>
> I need to ping Viresh to check if this is still relevant.
>
>
>> [3]
>> https://lore.kernel.org/lkml/20260317101753.2284763-4-pierre.gondois@arm.com/
>>
>>
>>>
>>>> +             /* Sync policy limits from HW when autonomous mode is
>>>> active */
>>>> +             policy->min = cppc_perf_to_khz(caps,
>>>> + cpu_data->perf_ctrls.min_perf ?:
>>>> + caps->lowest_nonlinear_perf);
>>>> +             policy->max = cppc_perf_to_khz(caps,
>>>> + cpu_data->perf_ctrls.max_perf ?:
>>>> + caps->nominal_perf);
>>>> +     } else {
>>>> +             /* Normal mode: governors control frequency */
>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>> +             if (ret) {
>>>> +                     pr_debug("Err setting perf value:%d on CPU:%d.
>>>> ret:%d\n",
>>>> +                              caps->highest_perf, cpu, ret);
>>>> +                     goto out;
>>>> +             }
>>>>        }
>>>>
>>>>        cppc_cpufreq_cpu_fie_init(policy);
>>>> @@ -1038,10 +1104,18 @@ static int __init cppc_cpufreq_init(void)
>>>>
>>>>    static void __exit cppc_cpufreq_exit(void)
>>>>    {
>>>> +     unsigned int cpu;
>>>> +
>>>> +     for_each_present_cpu(cpu)
>>>> +             cppc_set_auto_sel(cpu, false);
>>> If the firmware has a default EPP value, it means that loading
>>> and the unloading the driver will reset this default EPP value.
>>> Maybe the initial EPP value and/or the auto_sel value should be
>>> cached somewhere and restored on exit ?
>>> I don't know if this is actually an issue, this is just to signal it.
>> The auto_sel_mode boot path programs EPP to performance preference(0),
>> not the firmware’s previous value. On unload we only call
>> cppc_set_auto_sel(false); we do not restore EPP, min/max perf,
>> or other CPPC fields to firmware defaults.
> Yes right, so loading/unloading the driver might change the
> default EPP value.

Acknowledged.
With auto_sel_mode, load/unload can leave EPP and other CPPC fields
different from the firmware defaults at boot.
We can add explicit cache-and-restore on exit in a follow-up
if that is desired.

Thank you,
Sumit Gupta


