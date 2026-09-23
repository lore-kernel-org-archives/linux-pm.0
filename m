Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010069.outbound.protection.outlook.com [52.101.61.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A03B14BB;
	Wed, 23 Sep 2026 19:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191228; cv=fail; b=fljAbD/Ufg5AVqVzVEWhk2HhaC1PSU/CGuXhofQg7lkzIGOh1eMRQRXAn2VTHY7/63nTVZ/6Zc4SZyF5CHjm7nQB1GRYhTiUJnQrVaiQoMjhqDVT8cauUSsbuAAfxMIUUB/r47UqpLFtaeO9eITFVn7FlHiGk+QHXucf+XGhAFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191228; c=relaxed/simple;
	bh=v/R/waTJwPKRnJ/n9iJruA45nE44gk2Fh9UKmYOPtU4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tjt8mZQLgvbASbtSXwlvHc3I30Je1oAp8Jxs67om454CE7djHfOUhUZKOw36hXAvr1WxpHoylFHdOiaG7+M4fzAMFewdACJgtBE43RJsgw+mwii+UCbi94OpQy5vLbjhUt9wKQPpjRyTW2NFPKLgdM+PoQH7+E9zGgjTOK4697Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNt7LxkL; arc=fail smtp.client-ip=52.101.61.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNt7LxkL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBKL/dUo4ohLrRPsp9LLs7krJQvkcSbj5QUkWm9iUFuxnsvfhbtcNnnD+OleEr+uTjnnLQKhXEdWKfXQKlni0ZKcK788teOXFK8hGxCyqdcMitOfcaN+c+08VhfSjttz1Nl+Kg+97ycQE+LjmSCov3lQ5cH/L3pfCXsC+wbhd1EFHgKKga+U/hwZyt4nKzrGPXn7c8vTHz318x6uLMz26p039McmRjxrU7e0MNiWLiC6C7Xra7y7CoZvUIiYr7z8kExxvuClZC2Yog8zosQcfQjSPxk7bdQZM1j661oTIj4rUVmoZAH2LNjp/87YMVs2BNw2eYxmL57HQ7wPmCb6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP2ZvFw9OM1E7leTZd8mrxy+EXNuHtnSEC5ACKhpLNs=;
 b=KYTWs/Fyd3ZYt7ceHtKCmLYku2hgv0UsmtCqtmNvPVNU/fiqF4g/4rZsXUfAHgxRkZTKU9dRwNX59wHEt/1w+ZUFFXtvgFOzzdo/Phk3dIU3dwJMie3q7BOYfOUnrcF03nkg9+WjiddTm+Z5N+vuS3JkRaeLG7wFgns+OVg5jed0siseO36Gsdc+nYUFaqnjcl7s0N2xHOz7GqulgMU5yaaJJW1lBqVzmn8IQ7B3BcDeCiJW0O3gutpEOplDAp2xabqYEU12fPSXOtqaUH/NSeow6tBYNri1UC/3I2e+K1XgoAuSGtK0GGB1TccI2DNe1IBI3qiVEc1mjTv4Bb6FvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP2ZvFw9OM1E7leTZd8mrxy+EXNuHtnSEC5ACKhpLNs=;
 b=iNt7LxkLiYfoPIAQNHfAs3PZ/BE8WFej2EO1NRHrnzApKYYVCgq1lKJEL10DzFK0veCPNVV90T54pNaZjg3SGCVn65fzBbeSbQk2E3P4eTlcyw3hWaOe29dL0Wm8mBhcnzyl4R2wPuzOhpr3zYsqHBaYB95KL4sSn4P0EloGXHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:20:04 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:20:02 +0000
Message-ID: <b6015026-fe8c-4823-ad39-c630350c0cc1@amd.com>
Date: Wed, 23 Sep 2026 14:20:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] s2idle: unrecoverable sleep on ThinkPad P16s Gen 4 AMD,
 (Strix Point) when more than 16 logical CPUs are online
Content-Language: en-US
To: Fourhundred Thecat <400thecat@ik.me>, platform-driver-x86@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, rafael@kernel.org
References: <82329b33-ba2d-ee43-d444-5fdc14af1bce@ik.me>
 <8a5bef53-cae4-4aa6-a657-d11a6831d2b2@amd.com>
 <7962670b-168e-020e-b55f-c9ea49483f6b@ik.me>
 <bb82702c-6902-491a-8eae-2b90cd8c5c5a@amd.com>
 <4d377d87-c2d3-5541-53af-68c9d67daa72@ik.me>
 <55854916-292a-40ae-8421-1a784785d899@amd.com>
 <f872d7e0-79f6-911a-b0c0-639c58e780f3@ik.me>
 <66dee9c5-ad66-4bd7-982c-c5694d806cf2@amd.com>
 <0bb77796-790f-44db-b4cc-e4742ed1b2d0@amd.com>
 <eafbba40-a10f-6a7f-54e6-b14d59ad1525@ik.me>
 <99dcb462-5045-4fa7-9f6b-ee0f13ff96ab@amd.com>
 <4a161dd5-4dfe-81f4-e4d8-ba9d3280c25a@ik.me>
 <6d7773c8-0dc5-4e11-8bbb-088289dd508b@amd.com>
 <a5611ca8-b28d-4102-0caa-542fc162758a@ik.me>
 <60a5c26c-8fe2-477f-b576-2a18d8b6394d@amd.com>
 <fc70f3b0-6ac5-7ac9-dca8-595b65785718@ik.me>
 <b29e9341-70cb-4201-99fc-ef307dd10fa5@amd.com>
 <aab50dd0-5141-bded-0b58-0f01ae9621d5@ik.me>
 <c42ab776-6fa9-4e8e-acae-fa921a5ac108@amd.com>
 <0d1686e8-a50e-6f3b-2923-a0eca6ab4271@ik.me>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0d1686e8-a50e-6f3b-2923-a0eca6ab4271@ik.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:610:77::25) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|LV2PR12MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: c81a91d3-cb93-4334-cc65-08df19a7aaec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|6133799003|10067099003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zq7u3iljowHSr7jZg6aZo8EU0EnhGGGFGyH6YbrHDoic/Lm8p9s2GtGFja2+4LdSvMcn/teRzd42XxwwbpNuGHgIn//yr+r4ew7W6kQLv6uO8lfvL4KBMU3u+UNuwNtlPbAAHErvE3V4WU6MAeiggGA/htelW4ZhMjvugZp0q989nWPbYpPsTCWLTiKM5+ItxJT2ytdFN5lk0eioXuDNRG6+/nknLuufFSRwj7Z29ReAKTW/y6U7+KsfAgx/IOYJ48pVIrWZMp1XjSIDlDVWIM/lIxgs3711grusjHmGjfk//J1u0ZSmfWRMG3czR2qyNnaURZbkf417KR7fFMMVYhlEdTzJTA64SY7AuQExc+8iveC8pvyFedRuQgyKtrfQJtqGcYtMp99w1YUhdFsCSQxsryaD8egk2nLjWHA2vVDiwmZCDr8wE2chmwH6hrCI9ivcOenH8YL2ZCmHZACDj8MPk3W/gW7ZenE7wJ0rdiPkL06Yj83pBPTBMmxB5hEgzyLJqZRLAkJPBYzXIDrKrZdOScc0cb5rHIE1ftDXw4ncrU1G3OJflF4rSxGRuSKOFxUud8YLK5r/pl2K28LGR/k41hZGrerq2KYlvSQDsVGkY0AnSj3j49wdEfBifIw9a9gbbjaWQiujMcW+1s5E3S/t6vJfDglct/Y1Wd1fyWw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U21CVVB0cExmakowb1N2MG9tNnROc1c3L3VBMzBOeFdPNTEyR1VIcExSL1JM?=
 =?utf-8?B?TTdGVHFIaTc1TWVnclkrcElzWU5vaVNsc05LTXp1cGhqWklsODhCTWx3RnZ0?=
 =?utf-8?B?b0J1TlZLdjhIZ1RSdDFhYUhYU0NyT2lndnR4NXZyaUs5bHhIZ1FLZTIrT1Q5?=
 =?utf-8?B?dTZZZWtqZE9aWFB4U2lBNjVzZG1NQVIxWVNGOFdWYkhvRUdONC9GdUVUKytX?=
 =?utf-8?B?dlBGSlA5c3VGc2hxSWxUNmgrWUY3a3FZMUg1SEdEYWd0RnpWRkJvRVR1Tktp?=
 =?utf-8?B?UlBhUWVkUG9VTkdZOHlmUWV2eHFrVFhtMkZyU0tteVRWNEFhK0R5djU3NTdT?=
 =?utf-8?B?Q1NzZ3NSajNFNjZERkJFc0JpMldHV3FWODFlTHpxUkdwc25TYkQ3SFkvRUxD?=
 =?utf-8?B?Z1Q5WTdMZ3BSTm0rOXFpaFEzUzNac2U5U2ZsdWxOUXNROS9iS3JmdVBYWnVs?=
 =?utf-8?B?QTRaZFBac2EwVytLbjBBcERiQkFSTG9IRkk4MnNmalRzVUZSY2xuaFFxbTRY?=
 =?utf-8?B?RC9SMENYektUZ1FyV0hhaGdWQis5NHN0Q29ud2V2MVkwYW5MV2pJSUU2dXJR?=
 =?utf-8?B?VkxSWEFyRXltZ0E0cWlQRk91aWRPcXZjbDhwTHBmYUJjODd2Z2xmU1QweDJt?=
 =?utf-8?B?cTI2dUpiUEV0QUozNDRBRkQ3UGlLdzYyNGJ3eDJEcTA4MVpkV0ZWWVBLcTRR?=
 =?utf-8?B?eGNEKzcxTmFUS3Y1a0Y5bEVyZys1N2JSMWdPb0REb2xRZjZzUDV2MUYxa0E0?=
 =?utf-8?B?STR1VnVaT2Q2R1o0aVZKZlNlSVZObkdVL0VDMi9reXl5WDl1Lzh6cmdyak41?=
 =?utf-8?B?VGs3ekFaeUNodG01M2lvNDgyMjZ1UnZheUUrZFprUUpSOWlpNWFFS1JWMFgz?=
 =?utf-8?B?RWw0ZlhBSTJCaENKK2c5SGRZU0xOZDMrMG55eTBLZDZtck43dUF4Z2ZRTXFG?=
 =?utf-8?B?Y1ZlSDRoL1hUbWpURDVRUkxqL1UvQktRemV5NXlZYlRVcFBhWm5HQ2VSNzlw?=
 =?utf-8?B?dUlscDBidElWS0s2NThRRnBibUp4MGtLV09YTWRsZmJkdnJycDVPWmd4WHcr?=
 =?utf-8?B?dlA4V1lzZEx1enhhU21HbE4xZFlvVnA1M3B3QUxNY01rR0ZOV2ZHaDV5L3pq?=
 =?utf-8?B?dWcxZlplbE1lV01oaEp4NUNPVWRWd3IzN0lNWHd3eUFUcWZuSXBVRkNyNFY3?=
 =?utf-8?B?U0JSanluaUI0b0xFZjFnZGI3NXk4czkwUDZPZjh6R1FlOUh0SkhCdUtPWmZ5?=
 =?utf-8?B?UHNSMHV1U1RiWGxNSHBST1lxYkl2d0J0SGFWaXYvQVZiYmZBY0RLTWpFOGhC?=
 =?utf-8?B?ZUpxV2p0UkVDK2NhOElOMjd6dDNFOUNzRWlmRDJTQm5sQmdWb1NJcjNoMVJH?=
 =?utf-8?B?TmtTRDFCd0pyZ210S204ZERzUjZmSzM1RGlXWDk1bG0rMDVXK04yWXpLdmkr?=
 =?utf-8?B?RWViazdxUzZ0U3BkekNYaU15bVJZc0dTL2RiSk02cVNqc0VOcDJYK20yUExh?=
 =?utf-8?B?bzhsM0VKZk9ERmhCdXZkbFdoZ1haLyttSFNEMEFhYTlnckpVMHo4TUFIYzlm?=
 =?utf-8?B?YWt3M0crdkZmQXdzcFE2ZTBZL2laTjlXMzFGUjYybHRqcm0xZHVZU09mb2dx?=
 =?utf-8?B?MVBJUzRSTHB1OXA3MjZ3TlYvYmxhcDNPcTU0Y2dyZDRoczM1eXpiMkJNeFBk?=
 =?utf-8?B?RlJhOGIyVlgyQWFlOEtJdEsrUXhIaGNpODV3NExndmszM2UrcCtvQXZPV3NX?=
 =?utf-8?B?R2QwWmZPczlzeXRMMlEzb3BNdmk4MWVkMGJ2YlIrM2pzUVFTZjh6V1dSL0pa?=
 =?utf-8?B?UHdBZnROckNzTUs5NWlCVzdNVXN6MUtuR3dBeVhuWmlUZm1XdGZ4NEZNbGJt?=
 =?utf-8?B?WXZ4WlY3VzZsc2QwdGNGNUh6N2ZBRGlsOHBuRVM2R1l0MkJSRzc5R0JIdXhr?=
 =?utf-8?B?UTMwaUZzRWdjbENkNnhIZVZpWENWeW4yODk2ZzRUVlhyYU1ySlhtWVh0bWZy?=
 =?utf-8?B?TkNYQVJGUWdURllGZzEyb01Va3NibWlmdEdkZXIvcHpGd0lJWkdZbXFzcmEz?=
 =?utf-8?B?UXRDc0VLR05DT2tteDZiUldQZlJGQ3VuOHpOWGtrUUZhQ1VaamFBTUtVVjFy?=
 =?utf-8?B?ei9UdmlURFdtU09BSVk1Smp4bURadmd3THl1MmVjdUdHc2NyV0pkb0JTTkRQ?=
 =?utf-8?B?b08vRk4vOTN2Ykp6WVQ1RWFKdWtqWm5vWjRMM3JFM1kzSTl2RFVPNVhQTmxR?=
 =?utf-8?B?dXg5Sm5NOVduc3poUWEyWUh5R0xYelFJQ1hSZHZXdkVHazVxd2JPT2lKaUFW?=
 =?utf-8?Q?Ooc0Pv69utknFNPRJx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81a91d3-cb93-4334-cc65-08df19a7aaec
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:20:02.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RT7tDO6o/M3J8Jgpc+Gj7Sep4H1hGCm8HRdywJ06yc/w2229OMczDaQOeOqZXFFaYP9o83r7H/NM0hRvhXQiEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727



On 9/23/26 14:13, Fourhundred Thecat wrote:
> On 2026-09-23 20:57, Mario Limonciello wrote:
>>
>>
>> On 9/23/26 13:39, Fourhundred Thecat wrote:
>>> On 23/09/2026 20.25, Mario Limonciello wrote:
>>>
>>>>
>>>> Can you please share your kernel log from this run as well?  It seems
>>>> that your distro dmesg tool didn't pick it up in the tool run.
>>>>
>>>> And can I please see dmesg from a run with amd_iommu=on too.
>>>>
>>>>>    🚦 DMI data was not setup
>>>>
>>>> What is up with the missing data here?
>>>>
>>>> Does your BIOS offer anything to control D3 behavior for the storage?
>>>>
>>>> And this other point I mentioned: another useful data point will be
>>>> whether this can reproduce on 7.3-rc4 with IOMMU enabled to rule out a
>>>> backport issue.
>>>
>>>> Can you please share your kernel log from this run as well?
>>>
>>> Attached as dmesg-iommu-off.txt (full log, 1082 lines, amd_iommu=off, 24
>>> CPUs, the cycle that succeeded). The suspend/resume portion:
>>>
>>>    PM: suspend entry (s2idle)
>>>    Filesystems sync: 0.010 seconds
>>>    Freezing user space processes
>>>    Freezing user space processes completed (elapsed 0.001 seconds)
>>>    OOM killer disabled.
>>>    Freezing remaining freezable tasks
>>>    Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
>>>    PM: Triggering wakeup from IRQ 9
>>>    ACPI: PM: Rearming ACPI SCI for wakeup
>>>    amd_pmc: SMU idlemask s0i3: 0xffff9afd
>>>    PM: Triggering wakeup from IRQ 9
>>>    ACPI: PM: Rearming ACPI SCI for wakeup
>>>    PM: Triggering wakeup from IRQ 9
>>>    amd_pmc: SMU idlemask s0i3: 0xffff9abd
>>>    ACPI: PM: Rearming ACPI SCI for wakeup
>>>    amd_pmc: SMU idlemask s0i3: 0xffff9abd
>>>    PM: Triggering wakeup from IRQ 9
>>>    PM: Triggering wakeup from IRQ 7
>>>    ACPI: PM: Wakeup after ACPI Notify sync
>>>    OOM killer enabled.
>>>    Restarting tasks: Starting
>>>    Restarting tasks: Done
>>>    PM: suspend exit
>>>
>>> For reference, IRQ 9 is the ACPI SCI and IRQ 7 is pinctrl_amd, so the
>>> SCI fires and re-arms several times and the actual wake arrives through
>>> the AMD GPIO controller.
>>>
>>>> And can I please see dmesg from a run with amd_iommu=on too.
>>>
>>> I cannot produce one. With the IOMMU enabled the machine never resumes,
>>> so the ring buffer is lost to the forced power cycle. Streaming it out
>>> does not work either: dmesg -w and sshd are both frozen by the freezer,
>>> so over ssh the log stops at
>>>
>>>    PM: suspend entry (s2idle)
>>>    Filesystems sync: 0.011 seconds
>>>
>>
>> I don't need the full run, I'm looking for how it sets up differently.
>>
>> I am specifically expecting the message from 
>> 51c33f333bbf7bdb6aa2a327e3a3e4bbb2591511 to come up and want to 
>> confirm that.
>>
>>> and nothing after that ever leaves the machine. There is no serial port
>>> on this laptop, and since it hangs rather than panics, pstore captures
>>> nothing.
>>>
>>> What I can send instead is a full kernel log with the IOMMU enabled
>>> using /sys/power/pm_test=platform, which runs the whole suspend path
>>> including LPS0 _DSM entry and returns without entering the idle loop.
>>> That gives you every device callback and the platform prepare with the
>>> IOMMU active. I will send it in a follow-up unless you would rather have
>>> something else.
>>>
>>>> Uh, the hardware does support a wakealarm.  You might have disabled it
>>> in your kernel.
>>>
>>> I checked, and the relevant options are all enabled:
>>>
>>>    CONFIG_RTC_CLASS=y
>>>    CONFIG_RTC_DRV_CMOS=y
>>>    CONFIG_RTC_INTF_SYSFS=y
>>>    CONFIG_RTC_INTF_DEV=y
>>>    CONFIG_HPET=y
>>>    CONFIG_HPET_TIMER=y
>>>    CONFIG_HPET_EMULATE_RTC=y
>>>
>>> What happens at boot is:
>>>
>>>    hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
>>>    hpet0: 3 comparators, 32-bit 14.318180 MHz counter
>>>    clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff,
>>> max_idle_ns: 133484873504 ns
>>>    rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found
>>>    rtc_cmos PNP0B00:00: RTC can wake from S4
>>>    rtc_cmos PNP0B00:00: registered as rtc0
>>>
>>> and /proc/driver/rtc reports HPET_emulated: no.
>>>
>>> As far as I can follow it, HPET is registered as a clocksource only and
>>> legacy replacement is never enabled, so is_hpet_enabled()
>>> (is_hpet_capable() && hpet_legacy_int_enabled) is false. That makes
>>> use_acpi_alarm_quirks() return at its "if (!is_hpet_enabled()) return;"
>>> check, so use_acpi_alarm stays false, and use_hpet_alarm() is false too.
>>> ACPI does not give PNP0B00 an interrupt resource, so
>>> is_valid_irq(rtc_irq) fails and cmos_do_probe() takes the else branch
>>> that does clear_bit(RTC_FEATURE_ALARM, ...), which is why there is no
>>> wakealarm attribute.
>>
>> I think you're missing commit e9f850ba66cdf6b77fb4f005e46c4b605c4de434.
>>
>>>
>>>>   🚦 DMI data was not setup
>>>> What is up with the missing data here?
>>>
>>> CONFIG_DMIID is not set in my config, so /sys/class/dmi/id does not
>>> exist. DMI itself is scanned normally:
>>>
>>>    DMI: LENOVO 21RXS07D00/21RXS07D00, BIOS R2XET40W (1.20 ) 05/26/2026
>>>
>>> so dmi_check_system() quirks do apply. I will enable CONFIG_DMIID in the
>>> next build so the tool stops reporting it.
>>>
>>>> Does your BIOS offer anything to control D3 behavior for the storage?
>>>
>>> No. I dumped all 96 attributes exposed by think-lmi and there is nothing
>>> for storage power management or D3. The only storage related entries are
>>> HardDiskPasswordControl and BlockSIDAuthentication, both access control
>>> rather than power.
>>
>> I don't know for sure if Think LMI will export all BIOS options in the 
>> BIOS GUI.
>>
>>>
>>>> whether this can reproduce on 7.3-rc4 with IOMMU enabled to rule out a
>>> backport issue
>>>
>>> i will try to test 7.3-rc4  as you suggest
>>
>> OK.
> 
>  > I am specifically expecting the message from 51c33f333bbf to come up 
> and want to confirm that.
> 
> That commit is in my tree, but the message does not appear. Booted with 
> the IOMMU enabled, 24 CPUs, no IOMMU parameters, the only thing matching 
> is the unrelated generic ACPI one:
> 
>    dmesg | grep -iE 'FW_BUG|Firmware Bug|matched UID|MSFT0201|acpihid'
>    AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
>    ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>    platform MSFT0201:00: Adding to iommu group 0
> 
> No "No ACPI device matched UID, but N device(s) matched HID." The UIDs 
> agree on this machine:
> 
>    IVRS:  hid:MSFT0201, uid:1, rdevid:0x60
>    ACPI:  MSFT0201:00, _UID = 1, path \_SB_.MHSP
> 
> so get_acpihid_device_id() matches on the first pass and fw_bug is never 
> set. Same device path as in your commit, but this BIOS appears to have 
> consistent UIDs.
> 
> The full AMD-Vi block for this boot:
> 
>    ACPI: IVRS 0x000000006B1BF000 0001F6 (v02 LENOVO TP-R2X   00001200 
> PTEC 00000002)
>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID00, rdevid:0xa0
>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID01, rdevid:0xa0
>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID02, rdevid:0xa0
>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID03, rdevid:0x98
>    AMD-Vi: ivrs, add hid:MSFT0201, uid:1, rdevid:0x60
>    AMD-Vi: ivrs, add hid:AMDI0020, uid:ID04, rdevid:0x98
>    AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x10
>    pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
>    AMD-Vi: Extended features (0x246577efa2254afa, 0x10): PPR NX GT [5] 
> IA GA PC GA_vAPIC
>    AMD-Vi: Interrupt remapping enabled
>    AMD-Vi: Virtual APIC enabled
> 
> One thing that may be worth your attention anyway: MSFT0201:00 is the 
> only ACPI HID device in any IOMMU group on this system, alone in group 
> 0. It is not the TPM - tpm0 is MSFT0101:00. So the single non-PCI device 
> the IOMMU manages here is Pluton.
> 

Got it.  Then this is likely not a Pluton/TPM related issue as it 
originally seemed as the BIOS has that UID aligned.

> For what it is worth, when I tested with PlutonSecurityProcessor set to 
> Disable earlier in this thread the machine still failed to wake, though 
> I did not check at the time whether MSFT0201 was still present in the 
> IVRS in that configuration. I can re-run that combination and capture 
> the IVRS block if it would help.
> 
>  > I think you're missing commit e9f850ba66cd.
> 
> You are right. My 6.18.51 tree still has the old code:
> 
>    drivers/rtc/rtc-cmos.c:1502:  irq = platform_get_irq(pdev, 0);
> 
> which is exactly the path that produces the "-ENXIO: IRQ index 0 not 
> found" message I quoted. I will cherry-pick it and report back whether 
> the wakealarm shows up. If it does, all further cycles can be timed 
> rather than woken by hand, which will make the failing case much easier 
> to instrument.

Good.

> 
>  > I don't know for sure if Think LMI will export all BIOS options in 
> the BIOS GUI.
> 
> OK. I will go through BIOS setup by hand and look for anything 
> controlling storage link power or D3, rather than relying on the think- 
> lmi attribute list.
> 

OK

> The 7.3-rc4 test is still queued and I will report the same data from it.

OK

