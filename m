Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010070.outbound.protection.outlook.com [40.93.198.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032C282F38;
	Fri,  8 May 2026 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778267375; cv=fail; b=uYduznPmpVsITLRaMf7uZ9yOu/hY/YufciFmNlfLS+ojEwBKCB5RnnWAxYF2UwkdFJMjMduKfabsUti2SP0p81LFKyX3J6RGreTrTzNq3sg4QdjW4SjOUofsdPQVPBfzKsXbmmvde0xseFm96I+xjVaLtxgkYm3rsgPwHaX3qU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778267375; c=relaxed/simple;
	bh=sbXU8VdyxFKDjyyzt4jV2w5sjzKYwkKkFrjVhGxwI4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZtehOgcJcPwdR0MAUnb68VZsexSflB4OlaQvO1nwFlzYsLPZIE5Auhy0yvsns/HHN0hA35dQOZI+h9x8VoUEeFBbRPZF5Klvtfv4fpoKX5pR5YvmyTSTUCTThocOEcqy765fk3hrN21EuwQV+rgCV9bz6FOUSUXhT91Sw0+k/Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NxNzUOvA; arc=fail smtp.client-ip=40.93.198.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NxNzUOvA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+XgpKLD+wDpe1Rg65+vczRcexBTse/BcmHJcrZ/4zecIyxDkrWQkN7RnJrNI+IatFx/ShCKQQb7jemaI3LcDFllt6CZDSHeCoF+2UMIkAOPP2g9L6q3XCxnCPYi7BpKZEx2pTOkmzx2UIpnH65+Wxj9rFNEkqcTuF8ZRSfdnLl2xlKMkf6mJP06PpbK9OimU5UFB4Na3XDom4M+Ynak2PCbKeGUA8UEDFVg0FZMZMueHEfmt+5layme8AGp/I6iPo1AG9aO5oJNw+l5tnJSch411TmEhW9Iv30eU4vXG0QpoW6+KrKY5m1TE/jK88oVDM4IAQoWQM+EiXejbKJWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84ZfEaYOQODIv0kMvsjQtxU4zBKdxs/tgJCOKCf4BG8=;
 b=CK+ptM3tTiEn1QWY19PNH5JjRP9H1yupItf+PT/jxzb6HGeRTKvQ2F2vyu06j3903sWAwCgAONOFCFKyuMfeCPTVg37R37RzwdhVT/RMOnDdSGI2lEYdx3JqX3BvJ1D+A/04bgfBfr/M90tHByFQ9sc6vKF0kszR4hlo9ISzuFiiqB/7EDAI31gFUSI78Se63zlZKoecO7kvLGnrs/LFUlQqlFddpn2r+XUtz59inHxdTb61ZpIcJQ5PrV7Q0JJ8CwI0BrjjPJGzr/Jz4hTMVs9OLWR7x119TqLvX6MxxlvevSr+f+a+HWvjqTJvVWt7WmEzsGxefM6Vkz6uX9Wmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84ZfEaYOQODIv0kMvsjQtxU4zBKdxs/tgJCOKCf4BG8=;
 b=NxNzUOvAzECdiRnQGNkMwyhpqtIx6BQG+c2H1YRwuaRcVli6E5rb6vWjTwJ/Fuq1b0n3+CqeottvSHJOB1uIOoMCrDkA6EQNoPkAdgUnBapoj40+FswcZSAaskEp5BBLV6Tg9NjSr8LsVnJaSmttRSO3PZanHaEFOYvwenKboTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 19:09:22 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 19:09:22 +0000
Message-ID: <8e2c9db5-fd24-43a2-af0c-cb2cb54f5102@amd.com>
Date: Fri, 8 May 2026 14:09:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] Revert "ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn"
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, Kim Phillips <kim.phillips@amd.com>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
 <20260504230141.484743-2-mario.limonciello@amd.com>
 <CAJZ5v0gBTxzkQU1EduyBNx2fCYfVU92XcNU8+AbSZziymBdJJw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gBTxzkQU1EduyBNx2fCYfVU92XcNU8+AbSZziymBdJJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:610:4e::32) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7a5318-f2d4-4798-3bc1-08dead355059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yYXuif8d7d8CIt5pJtmPSczqjJ/MHAvZnC9YQcQzAgpSTxVLsKRyEAYhgI+7m9uCz6dOu0/EQHCYOfahlqy+6NnjQWFBwNq9HBh/D2Bbm/At1Ln6YOHGkJPcTWLt52N9fHurg44h0wrxMWsMQkYVJ4tkmk9lF6Bpoj/9brCbhK1KajrvQEaeurXw/9NhzYY499kvuWi3pa8mX5vl1bBEvNw4aXHWFjzT0y2yF3rttkv3AOH6V2G3Dc9wAQdp1S8WZR0+zm9L8vfNjgISnnTmgSJk62+KIWrRNO/AcPmwiPR3Quh+fSBQGBIF/TLmEKfNOS59AJMeDpE/9wZdJ51id7fScAhcUGqXXsJJ5K2yLGHhK6uIFsk+/gn2zFJhT8Kk1sIVJF5RHI7lqT3XQIiCH5P/A2RpvPVqxHpOiwbymFWRoTcSL3WCmD3cOfYqH8jc1pTPNpI3y6MDuA21sdASZrCM060oRWRJ4ppoh+aQg4IQCH/dcIINE7ScJ9pwidd9S52zRM2RtEffHoKgZNfQPJ1nL0gRjuxUWewCP6rmRd4n6ciIe2QKVPG+w/Xjd6xbM75v4UZuHdy6RFl1uZu9uAOPRWvhH3QKu8MJ+8Ynm7yx1orl5bC4Gd/4pz5/CPwLWSfGs2OiAQ7ekgfWRsWDKMbZDd1XYjPxo+0u43GDXvly96keGFMKgPeFlEMOcc0AReRorkZNkVoqXkQFrSYfQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFhQjBOVDZscnlxMlF3TW9tWkJXSW9tQy81RzhjTUxVdTVtR3VLK3VBcTgw?=
 =?utf-8?B?Y1E0cGVqY29ycHRGejArem1XWXI3MDVHYkZjZCthVXJuUXliditBY25Wdnhj?=
 =?utf-8?B?RWhPRjVya0g2ZThLRlBkaVI5SzJYbmpjU3VyTW9Ob3lpWlZmTHdxWDNTN2tP?=
 =?utf-8?B?akRzQk9VSllmVXpHbHFubHBvbjdSTHJaUmNPVlZMVjVUaXJoeEJ4dzVieVN0?=
 =?utf-8?B?UHl4cElwZDZwdEc1TVU1b2dEUnRJemdhVTJSQVNsQVlwRUZQdzhnTWpvRW1E?=
 =?utf-8?B?Y0pJRWNaYUlndjVJUW5La01yVHlaaEozVWdBVDY5U0lMQnZJUTkrSmFxSHVo?=
 =?utf-8?B?MDJqelE0ZlBxaDYyUHBWM21TYmNoQ0hnVDMwYU1uODhaMXR6dGhJSElYa1Nx?=
 =?utf-8?B?bzBrR01Zc2U0b3R4cXNmMFA0VDZPTlBvSFdYSXpPeHlPTzgzbngzd2RITDhT?=
 =?utf-8?B?amFjbEpnREVKclV5ZU0yWjlabXhaVGdZVytHUG1ZYmJZdC81T3FXeThBTG15?=
 =?utf-8?B?TTJlUHluUzloclFDWWtRa1ZMMWlNZ296UlF2TXhkeEVLQ1V1ckJrK1FOSFpP?=
 =?utf-8?B?blAzSEV6YjNOcmdxdS81aTYxWGJncHlFREw2dTRyT3NaSlFFK2RvSzRPTUJn?=
 =?utf-8?B?My9Cdll2RS8vclZ4TWZmTGFtclIxdmhXRjVaWWtPeFRJTURiZUdkSkwzOEEv?=
 =?utf-8?B?RE93MFJOZE9PZjZGak9CQ2ZZRWtEUyt1bHc3amlSZXg3VzBXUFkxMytsWFlJ?=
 =?utf-8?B?TmhQdzNWMlZpOWlwYUFqOTJyRjFFY2dtZ0JHWW1kWElFcFV6SkhuSjc0WWZk?=
 =?utf-8?B?RzMvellYQ3lENVNYcFQwcWpZUm1EdmpTNVVJVmxVOEtPOVczMkMwVTZPcWly?=
 =?utf-8?B?RHlZMGk3cUc5RFlxbUtLQkc0MHp2enk2ck5qY0FsMzg0MnB3bXhtNTFsaUhs?=
 =?utf-8?B?Z1FDdk9mbFU1TUNnOVJkR05tUi83T3ZDcUZrRmZEellZYXROVE1WUHlOMkhz?=
 =?utf-8?B?dTBxeHovZnlaL3ZCL3ViZlpGMDFwTkpmUWpTbDJtYUR1S1pleUh0Nnk5RE5n?=
 =?utf-8?B?RzY3b1dmb0liRHhMVm1tK21qQk1WVWQ3VEVNN1hzeFduSWdiaFE5dWJUQ2VT?=
 =?utf-8?B?VUFaVnhpUUZROGhPaytkVDVVK3lZWEtQQzhHSzNBQ3NVOGRnL1VWckpXRVZV?=
 =?utf-8?B?RXU0V3ZTMzluc0JPRjVJdE1CSzNJam0wQWlnUXg3b1VxVjlYU2ticHJlc2s3?=
 =?utf-8?B?eityNVZ2aDAxbFpFS3V2a0tFaHZUdEJ4UGgwc2t6aTg3R2JtS2tTTjVGb2Ir?=
 =?utf-8?B?K1hLOGhSQ09HS0lqYU1PcldjbEpoMW1rLzltck9ZdE1nMkpSWDZ0K0hvRDlq?=
 =?utf-8?B?RnVrdkFtUEF0ejV0ZTN3TE9zSEdRYVBHbmR2bUxmazVSZDg1SkZHUFZuaU9F?=
 =?utf-8?B?NjBFalQzSmxwRkRnWDJMK3NXeDF2YTU5cUI3ckZsZDhQaGExa0pCdE56SjY4?=
 =?utf-8?B?VlZkL2JwYTlQMGhVNU56Ump5TTZRSHYzbFVZb0dmalJnRzUwS0R2YllrbzJW?=
 =?utf-8?B?THl2UEwxR1lNSFIxMzkrWnl5RDFJbXcxbG9Va0JnS3dVeHB2TU4rclZzdDRl?=
 =?utf-8?B?VWwxcFdZM0IrblM5RVBLMSs0ZGowL3NlUzhyZzVGSGtISGhvZVVjZk8yYU5Q?=
 =?utf-8?B?MWZ1MktQTWc1UkVNT2VCL2VBRG1hem8yVUk0VzE5ekZSNUl2bXNBR2QrTWZo?=
 =?utf-8?B?NDhLb1FUYW5JZHhXTXYxRjEzTko3c2FIeWl1ak4zSFlaQ0xDWnJoYThpRTdD?=
 =?utf-8?B?SWVhSkRYcFFUUDlnOTBxbWxaYmZ2Q2ZITm5hRVc3a25tSThCcEVLWm50NHdj?=
 =?utf-8?B?UHQ4aUJwTFpMbkIzSzFkQ1RyRHNWYm9pZWNPNkVDdnZ2Y0hLZndDSy90TTg2?=
 =?utf-8?B?dklMc2NLVXlKQkwzL3Zrb3NvTmZaN2x4NGc1YWg5M2gwNUlibUlyd1c4eW15?=
 =?utf-8?B?RG55NWVqMStKdlQ5d1U2L0FGM0QzTG1Mem9pVUpNbEYwVkVLZnh2WWNINFVx?=
 =?utf-8?B?aXlrZi9pcDYrSTMxWWNEZUVmbGE0YldqYWtSNzcyWVBPUGdMTVNldFFQdUN3?=
 =?utf-8?B?MkR0QUt3VnM4bW1IZjN4SHo4Z0tMNkJiTVQvVkNHOFBDbGVIZWZSNWtIZEdn?=
 =?utf-8?B?VkpqcW1YNkVIU05Hb3J5Z3RqQ1ZiaTFhUnpLVHpFc0lJMmhOanltUWRQdmN3?=
 =?utf-8?B?ZGRYbnZvRGU0cGlqaFlDU3hyMW1aWkRYVVBjNE9lM0hiSkFQRmxnUm5nL1g1?=
 =?utf-8?B?V09IUTVMVHdNWDJZSkNyUGlZTlg5dkNsdVp2TG1CRngvT3Nsa3VqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7a5318-f2d4-4798-3bc1-08dead355059
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 19:09:22.7450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3j1qoa89qCX7kiJKI3KArLeFhEVyGHAPAlMtXcvjcsqadH5nvBgp7iOGqpMScIFq4kO47mJS0VhMGuYtjqaqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493



On 5/8/26 14:04, Rafael J. Wysocki wrote:
> On Tue, May 5, 2026 at 1:01 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Some older systems don't support CPPC in the firmware and this just makes
>> noise for them when booting.  Drop back to debug.
>>
>> This reverts commit 21fb59ab4b9767085f4fe1edbdbe3177fbb9ec97.
>>
>> Fixes: 21fb59ab4b976 ("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn")
>> Suggested-by: Kim Phillips <kim.phillips@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/acpi/cppc.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
>> index d7c8ef1e354d3..be4c5e9e5ff6f 100644
>> --- a/arch/x86/kernel/acpi/cppc.c
>> +++ b/arch/x86/kernel/acpi/cppc.c
>> @@ -88,19 +88,19 @@ static void amd_set_max_freq_ratio(void)
>>
>>          rc = cppc_get_perf_caps(0, &perf_caps);
>>          if (rc) {
>> -               pr_warn("Could not retrieve perf counters (%d)\n", rc);
>> +               pr_debug("Could not retrieve perf counters (%d)\n", rc);
>>                  return;
>>          }
>>
>>          rc = amd_get_boost_ratio_numerator(0, &numerator);
>>          if (rc) {
>> -               pr_warn("Could not retrieve highest performance (%d)\n", rc);
>> +               pr_debug("Could not retrieve highest performance (%d)\n", rc);
>>                  return;
>>          }
>>          nominal_perf = perf_caps.nominal_perf;
>>
>>          if (!nominal_perf) {
>> -               pr_warn("Could not retrieve nominal performance\n");
>> +               pr_debug("Could not retrieve nominal performance\n");
>>                  return;
>>          }
>>
>> --
> 
> It looks like this could be applied without the rest of the series.
> Do you want me to do that?

Yeah; go ahead and pick this one up.  Thanks.

> 
> Also, do I understand correctly that the rest of the series depends on
> Sumit's patch set at
> 
> https://lore.kernel.org/all/20260430142430.755437-2-sumitg@nvidia.com/#r

That's correct.
