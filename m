Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2E2F691D;
	Wed, 24 Jun 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305796; cv=fail; b=Vvo9IqYiYTDfm+48t25f4dAviEnj5wr8qzNyiOHrkw1TiRx+r2JvkbhsCAQjRL6kG95dB/4Q/n6RlC5iM+SW5dBvceoJjcVzob9TxAOKPAqmGPN+s2MIYAl37V7QkxWPbaP64zCQjc4mxWLqeoFJng1mWxnW5hLXIJkiuMVGh7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305796; c=relaxed/simple;
	bh=xdkjMA/qSU6Ydvh2ctVQ5MBYWRZuTRghZ7LM/aKozWM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZudHPsGjM5s3yc6FgoDuFdXKkYbo4vB+NMmkIe9cye8sRX/2u9HXr6fleq6fWt+duNSXtQ5GcF0xOuZhZecKKJrMpAt04TOprJ8FG8JLCmDpW3o15Bc4K4k0DBR906EFz56Ruu+lYCPWouX1GlJT+UNJobZamDzeUVcbXm0JfuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ap4UUMY6; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ap4UUMY6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZHgeE1lJ+4y7qJ12ipxVl/vexDbF8DzuFQtqecqBUQBLqkr3RTk7/dCExijLORIuTsHC5vOwwKoJrsuIe8IQ4bANwDHF4eWT49/5tGQZogMrojaLcF9pkP/jGPpKpEul8vMaxKg+PBnQHjpZletqlvS+qCKpIfQpwWWZgARGGXiw8sOqBhr1SD0/wVCxKiellDA211Hkc1duVU+QMLCcrNugLISq/HA2xgjRzucSZ1u4DgQZFLw0IDFpS68pEZNzKBK/aYqJe4V1bVrukCwdLsYHvKu0SUkrfhveHGY2wVFNxGimMSVdiJTf96vgmF8jvCf4dWhfvRk6KQwpqeT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV02EzyhiGYMto+bhr6Ebpw/806sAvOs+C5aBdb9pLM=;
 b=d9u25pDyXqT12dxd1k9mZ9ER1QSjhLTh/DxNnH/KtorU5euBqTkV5QkNPK6Jh3titbcKOLVJ4mxpnG6eITM+lyefrxgF2z+QvAXXZrv+puTgKr2xmbs7f8IxY/BTbmDSMM35cYaBo4dAI17fGrJiPp7vXhW/BrdMagvZdXRflUqvt0lBduYTQcZo2CSN8eVN3hukNdFjRSR6BjN+bt0wRtVn7T0qMr07rf2OaCvg5szKEtpgQBJPp2bNwke0NIYOJbdGpGkVUxdjZj3p1dpGpWyENu8bv2Q8zZzSu5NahZpy7uNhfL7ZbozMohqkqKjovbiDw1yBZf8oyQIRxk9EKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV02EzyhiGYMto+bhr6Ebpw/806sAvOs+C5aBdb9pLM=;
 b=ap4UUMY6tYtN008NcLYztd2WMiOnhStfLQNqCYxh5XOn3yi50vXbSkYwimlELh9NhgPcHmCPKzIRFpiPayGWyCxY8/vjM7aCPYChlJuTwtkNnyZS38wPbB8ijofvrlaonK6IR5rA7vdIhzMlV7xJIObq5mcr+CDRo70D6JF/yW7ozicWVEbZa6esCEaqhvO9LvRGiriv6GOgRcCb4Um58TEoFqrrScf+mcLYF5hz9gI7Ny7wFliDAiQ1zDHBSXqQmhPz5DptpC/M/uBKB8UhHFkrKzMaL3iwi6W6pUFrEjUJShrPSqGvTtKoiKNw0bCvNa53aqR1cHWL59HG+icsDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 12:56:24 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0159.015; Wed, 24 Jun 2026
 12:56:24 +0000
Message-ID: <de03b23f-18a3-4e99-a15a-5044463ac484@nvidia.com>
Date: Wed, 24 Jun 2026 18:26:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260623095403.3407436-1-sumitg@nvidia.com>
 <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:8:55::25) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd0c74d-64e9-438e-6a20-08ded1efff09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	k0htdu43VcfH4OknRnCFnWNew0hocrZa51Kpzhb8bie+vD48NFuXikxGTBtSLOw9GWZxxZdN8G6Zrgncw1ZgP7hUBQbZneRA3W9+JdDHqXPUBLXWdxHG8ieOosQkB9lszGoxH/uNdIKgLrQ2/Be09LXxb00hQPjM5RaW+0+Vn94Roycec+zsfFWg5x4B/UEGRa54P57o/FGfqErA3P7ik7lS5/WMwxQSt9oXikbcbmYbGcsieyYp0LCX+TPlvHRlPOx1cCogfuVSA8nBtr/5hsEGV3fVvsG6hc07bEzvrNfLMVZy/f+ztfwaVg2qKn5VlqqGfotSEFIRvvTmNYQJJQw/cwAK8+ZLpVysk+18XbSIcnbQTmsrI0b3VqoKdBBzfSryRTK1DFw3Khcw9SK2ftqeX1g9QCNr1oOO9vB9ELlMUsYKN2XUyrwURnhNyWPfksNz7874mwfmtVBvBM2KNyS+iA1LUUs6zUWqvRWwkqi0MeddiTsH8F5ZpZlzxUcIIcVHPx4LLD0aoc1hZw3yiAUoXqORm7d+qstqLaY4tH0tqvLctLVbBPXWNuJu4JyKr+M1Y1iAM/cUI3LIlXM+RT8ChEXdnsUZS7Bk1L0oPCo0xLMLBc10/NEnnlJtoEoGJJ+frHOAVPwWtV9ct3zuoRf+PqoaorcNXpfKzoC1i0I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWVOYncvUE52QTAwR0FTODZnTFhGL2oxNkkvNjZ6Z1dTVTRTUFlKR0xJU3d4?=
 =?utf-8?B?REFpVStmTlB0V1Y0VGlReGk3VXdEQVVOdFBaamcwMVVBdi9PbjNVRWtWRlE5?=
 =?utf-8?B?QzV0M2hzYnhoS25RUXR5dWRMSGkxUXZYN1NkdlVoWE4wS09TNXUrTmJubzBX?=
 =?utf-8?B?WDc4bE0wVjN6QXdyd1NIeHNBakh5L3E3bndRNkQ1Q015N3o3SC9iMjk0UUpH?=
 =?utf-8?B?MmhPRkEvcndIa2lnMEJWMWFUdTRIVlorMWFhYm9Qd0ZaN21KTVhGSWQyb3pm?=
 =?utf-8?B?UFllYURzUnNMTzN4bllPeGM3Nlc3M3I5QUNHVlBGR2tSMU81TWh2UmhScVcw?=
 =?utf-8?B?RDNyeVdEZm9tNGdJWTYwdWE4aUdtOGltOHkvbkluMFdXN2lyait2ZUFWbjR5?=
 =?utf-8?B?MVI2dDh1OXBCV05GajhUZXJXdzlEcnhjbUZncE9GaTBpY0NUaTFFemlNOTZT?=
 =?utf-8?B?ZVY4OTRCMXZqWGphSHd1ckhuUFdJQ0JPRWZCU1NxZnVyOGFZVHYxQWgyWHJq?=
 =?utf-8?B?WENhS3d1U0Z6OHFmaEJkdVFqem1GaWNqZVd3Z0Z0QjRVTWNTZXJDNTFaNktJ?=
 =?utf-8?B?OHB0UDJlMCs3Nk1hellTcG8ybk1DcmhkY1BFSzFpZlZzUFpnVmIyK2JBYkFt?=
 =?utf-8?B?MTJJRW4rQmgzalN6RXZzOEpLQ2FVaFpnUDNFeHI3YVltUzdHWENHQnJXVC9q?=
 =?utf-8?B?cjUwcmNFQTUrcGdISnBPcTRlSW16Z2VMSCtLQ2syMGtkRm9UOVFlWW4xRVNU?=
 =?utf-8?B?b29hK2tQbnBXNWhtQXNRWlk3SHZiZW9xa083a3hhQnJHZ29Cck41VU5VOVh3?=
 =?utf-8?B?d3lBaUFxaE5vNTVCd2F2RWp4cjJxK1hzQ3djOUJRcWZDaVYxOHNDYU93V1NB?=
 =?utf-8?B?elI3SkJsWG9PZUR4ak1jZEFqNVFEWjErbEgvQnU4enNTRnpZTDY3d3NBU3hm?=
 =?utf-8?B?QTc2ZUxja2tSMTlBVFl0K3ltczlSOUN0NmJxZVBadGIwYlgyM0dkSEVvWXRl?=
 =?utf-8?B?c0tPVG5IZVdoZjFiZTZZRXVSUVFWem1pUnVlam8yV1pJMXZKYTlVQzZVbERv?=
 =?utf-8?B?NjcxOGJTMUx2SUhRMDhaUDFQUjRsZU96REp5NW5BR0dyaFZEa0pHVVVNMjNR?=
 =?utf-8?B?aGZGYk10ZGRSSldxODR2cFY2bC9xK2t0QWZoN2hBQXdid1N3U2FFbDlSNUJP?=
 =?utf-8?B?TXNqQ09zQjgrQ1NnejZWM2RwM05FcXIzcUJrMVg0eWdQaE5XK0o0VTBtaHA5?=
 =?utf-8?B?TU91NjRyRHBrdlZ3ZjB0K1IxeWJBbk1ZUVRrblMzYnN3aGFML0o1ZjgxZENT?=
 =?utf-8?B?aUhJLzVOd1NtZm1USUpkTVRncHZUdDVxZmhWeXBnTmM5cHpYM0ozS1hwSCtM?=
 =?utf-8?B?WW0vVktIYlg1UUNiTmQxMkNBVFhHNzJEZGw4ditDTTg4MDVOWStpQ0pOMnFO?=
 =?utf-8?B?SlhmVXRNYjFzWXhUcmlXSmZYdDNrMDJOcDcwTmxVK0MyL1RGaFlMSEsxOWNn?=
 =?utf-8?B?YTBvWlczR29YRkRHM1ExM2NtN1ZrSldhSGlPUXlKMW5USFg1YSs4bG8yTHNY?=
 =?utf-8?B?ZTlHbHBOTXhKM1lTOEhTd1FEMXNPODFwdWtwMDRGN0pqZ01QeGc0aW1GbS9y?=
 =?utf-8?B?ZFNxQ0poRWFmeW56TGV2bSt1cHRodUhvUHFWY3pvb2xoR1lxOHJVb2NHa3hk?=
 =?utf-8?B?bkloamJZMnUwWThzeE9GWmxmcnpnS2VVZU1rQ3NFV0FYenQrUVQzbVNuQURL?=
 =?utf-8?B?ekdZemRLM0J0azBmSEFGZTR5MmRNN2cyUVBlVDJDRTR3SVlBcFBmeTQ4MmZQ?=
 =?utf-8?B?U2JiVGIrekMvcTViOXRSNS9vMFp5SmcrdFd3aUw1aVhpRGVhbFc4QmhETVJK?=
 =?utf-8?B?bUVJVW1mZ2pkWEF4N0NEUHJoYXpzeEtlMzNUd0Mrbk1USmdLc2lGSGp1MTNV?=
 =?utf-8?B?VnFpWDNjTFUwQzRuTXYrb2FlaG5BUmRWcHZuRGQ2N3hlQ0J3ZUM4NW5Xalpw?=
 =?utf-8?B?eE9TcVRPSi8zeXdtVVc3aTduQUhKWWlCY2VISzEzdktrUjdoa3NZKzd3R3pI?=
 =?utf-8?B?TlRZUXkvb01Kdm0yb2VCT3p0QlhJbFF4ZTd3Q09ieG03dTRrb0tkdHlLNDkz?=
 =?utf-8?B?TXViZ1pSbVBBUmRLNEJoajgvV1JTSHJ5M2JRQWRxV3JRSnBFMVU3ajhNRFVu?=
 =?utf-8?B?S2c2a1B6NC9odUpaOEh1SlVvUEJEM29mOGxDYTJybVBXUU5XdTcvbEQ0V2h2?=
 =?utf-8?B?MGNvUGR4M0w3MHErMjlZc1dQVEhldUVBQ281eXphbm9iSlk2ZWxXanNkQzFp?=
 =?utf-8?Q?ZWHtgP73h337/Ra0cm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd0c74d-64e9-438e-6a20-08ded1efff09
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 12:56:24.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxPIZlMu1eIYMVxgegi9/ICSOmly2bGVxHh/MIcl+wLIGV0tZxwu1odlQ/L10Nmw1o6EeBQbxa3tHiFF/C48NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098

Hi Rafael,


On 23/06/26 16:30, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Jun 23, 2026 at 11:54 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
>> boot parameter) can be lost in two ways:
>>
>>    - Across CPU hotplug: the platform may reset a CPU's registers when it
>>      is offlined.
>>    - On driver unload: the value the driver wrote is left in the register
>>      instead of returning to its pre-driver state.
>>
>> Add a small table-driven mechanism that handles both:
>>
>>    - Capture each register's firmware value when a CPU is first seen and
>>      restore it on driver unload.
>>    - Record the last value the driver set and reapply it from ->init()
>>      when the policy is reactivated after CPU hotplug.
> I'm not sure if this is a good idea TBH.
>
> The overall system state when the CPU goes online may be completely
> different from the system state when the CPU was online last time, so
> there is no reason to restore its settings from before offline, at
> least in principle.

These are values userspace deliberately set, more like a frequency QoS
request that persists until userspace changes it than transient state.
It's platform dependent though, as the platform I test on preserves them
across hotplug, but where the platform resets the register on offline
the value is silently lost. Should the kernel re-apply it on online,
or is that better left to userspace? If so, I will drop the hotplug reapply
and keep only the restore on driver unload.

intel_pstate and amd-pstate already re-sync these on CPU online, as they
keep the policy across hotplug via ->online()/->offline(). So for them
it's re-syncing the hardware, not restoring state from before offline.

cppc_cpufreq has no ->online()/->offline() today, so it fully tears the
policy down and rebuilds it, which is why this reads as "restoring
settings from before offline".
Would adding ->online()/->offline() be acceptable, with policy preserved
and ->online() just re-syncing the registers the platform reset?

Thanks,
Sumit

>> The firmware value is captured on a CPU's first activation rather than
>> once at module load, so CPUs offline at boot or hot-added later are
>> covered.
>>
>> Reapply is only needed on a full policy teardown and bring-up, which goes
>> through ->init(). In a SHARED_TYPE_ANY policy, offlining a single CPU
>> leaves the shared register untouched, so nothing is lost there.
>>
>> Cover the OSPM Nominal Performance, Autonomous Selection
>> (auto_sel) and Energy Performance Preference (EPP) registers. For
>> auto_sel it replaces the previous unconditional
>> cppc_set_auto_sel(cpu, false) on unload with a restore of the firmware
>> value captured at the CPU's first init.
>>
>> Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>
>> This applies on top of (not yet merged):
>>   [1] ACPI: CPPC: Add ospm_nominal_perf support
>>       https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
>>   [2] cpufreq: CPPC: add autonomous mode boot parameter support
>>       https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
>>
>>   drivers/cpufreq/cppc_cpufreq.c | 194 +++++++++++++++++++++++++++++++--
>>   1 file changed, 186 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index a3fabfb07fbe..d6ea2cbde187 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,174 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/*
>> + * OSPM-set CPPC registers tracked for save/restore. A value set via sysfs or
>> + * the autonomous boot parameter is reapplied across CPU hotplug, and the
>> + * firmware value is restored on driver unload.
>> + */
>> +enum cppc_saved_reg_id {
>> +       CPPC_SAVED_OSPM_NOMINAL_PERF,
>> +       CPPC_SAVED_AUTO_SEL,
>> +       CPPC_SAVED_EPP,
>> +       CPPC_NR_SAVED_REGS,
>> +};
>> +
>> +struct cppc_saved_reg {
>> +       int (*get)(int cpu, u64 *val);
>> +       int (*set)(int cpu, u64 val);
>> +};
>> +
>> +/* u64 wrappers so the bool auto_sel register fits the table signatures. */
>> +static int cppc_get_auto_sel_u64(int cpu, u64 *val)
>> +{
>> +       bool enable;
>> +       int ret;
>> +
>> +       ret = cppc_get_auto_sel(cpu, &enable);
>> +       if (ret)
>> +               return ret;
>> +
>> +       *val = enable;
>> +       return 0;
>> +}
>> +
>> +static int cppc_set_auto_sel_u64(int cpu, u64 val)
>> +{
>> +       return cppc_set_auto_sel(cpu, !!val);
>> +}
>> +
>> +static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>> +       [CPPC_SAVED_OSPM_NOMINAL_PERF] = {
>> +               cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
>> +       },
>> +       [CPPC_SAVED_AUTO_SEL] = {
>> +               cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
>> +       },
>> +       [CPPC_SAVED_EPP] = {
>> +               cppc_get_epp_perf, cppc_set_epp,
>> +       },
>> +};
>> +
>> +/*
>> + * Per-CPU saved state for each register in cppc_saved_regs[]:
>> + *   firmware_val      - register value before the driver touched it, restored
>> + *                       on unload
>> + *   requested_val     - last value the driver set (sysfs or boot parameter),
>> + *                       reapplied on policy reactivation
>> + *   firmware_captured - whether firmware_val has been read, so a not-yet-seen
>> + *                       CPU isn't mistaken for one whose firmware value is 0
>> + */
>> +struct cppc_saved_state {
>> +       u64 firmware_val;
>> +       u64 requested_val;
>> +       bool firmware_captured;
>> +};
>> +
>> +/*
>> + * Per-CPU and not tied to a policy, so the saved values survive policy
>> + * teardown/bring-up across CPU hotplug. cpu_data->perf_ctrls is per-policy
>> + * and freed on policy ->exit.
>> + */
>> +static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], cppc_saved_state);
>> +
>> +static void cppc_cache_perf_ctrls(struct cppc_cpudata *cpu_data,
>> +                                 enum cppc_saved_reg_id reg, u64 val)
>> +{
>> +       switch (reg) {
>> +       case CPPC_SAVED_AUTO_SEL:
>> +               cpu_data->perf_ctrls.auto_sel = val;
>> +               break;
>> +       case CPPC_SAVED_EPP:
>> +               cpu_data->perf_ctrls.energy_perf = val;
>> +               break;
>> +       default:
>> +               break;
>> +       }
>> +}
>> +
>> +/*
>> + * Save the requested value for the given register and CPU, to be reapplied when
>> + * the policy is reactivated after CPU hotplug. Also update the per-policy
>> + * perf_ctrls copy so the saved and current values stay in sync.
>> + */
>> +static void cppc_save_requested(struct cppc_cpudata *cpu_data, unsigned int cpu,
>> +                               enum cppc_saved_reg_id reg, u64 val)
>> +{
>> +       per_cpu(cppc_saved_state, cpu)[reg].requested_val = val;
>> +       cppc_cache_perf_ctrls(cpu_data, reg, val);
>> +}
>> +
>> +/*
>> + * Reapply each register's last requested value from ->init(), so a value set
>> + * via sysfs or the boot parameter survives a policy teardown and bring-up
>> + * across CPU hotplug. Also keep perf_ctrls in sync with it.
>> + */
>> +static void cppc_cpufreq_reapply_requested_regs(struct cpufreq_policy *policy)
>> +{
>> +       struct cppc_cpudata *cpu_data = policy->driver_data;
>> +       unsigned int cpu, i;
>> +       u64 val;
>> +
>> +       for_each_cpu(cpu, policy->cpus) {
>> +               for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +                       val = per_cpu(cppc_saved_state, cpu)[i].requested_val;
>> +                       if (val == U64_MAX)
>> +                               continue;
>> +
>> +                       cppc_saved_regs[i].set(cpu, val);
>> +
>> +                       /* Keep perf_ctrls in sync via the policy's CPU. */
>> +                       if (cpu == policy->cpu)
>> +                               cppc_cache_perf_ctrls(cpu_data, i, val);
>> +               }
>> +       }
>> +}
>> +
>> +/*
>> + * On a CPU's first ->init(), capture each register's firmware value to be
>> + * restored on driver unload. Later calls for the same CPU are a no-op. Capturing
>> + * from ->init() rather than module load covers CPUs that appear later. Also seed
>> + * requested_val to U64_MAX so its zeroed default is not taken as a request for 0.
>> + */
>> +static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy *policy)
>> +{
>> +       unsigned int cpu, i;
>> +       u64 val;
>> +
>> +       for_each_cpu(cpu, policy->cpus) {
>> +               for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +                       struct cppc_saved_state *s =
>> +                               &per_cpu(cppc_saved_state, cpu)[i];
>> +
>> +                       /* Capture once per CPU; skip if already recorded. */
>> +                       if (s->firmware_captured)
>> +                               continue;
>> +
>> +                       if (cppc_saved_regs[i].get(cpu, &val))
>> +                               val = U64_MAX;
>> +                       s->firmware_val = val;
>> +                       s->requested_val = U64_MAX;
>> +                       s->firmware_captured = true;
>> +               }
>> +       }
>> +}
>> +
>> +/* On driver unload, restore each captured CPU's firmware value. */
>> +static void cppc_cpufreq_restore_firmware_regs(void)
>> +{
>> +       unsigned int cpu, i;
>> +
>> +       for_each_present_cpu(cpu) {
>> +               for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +                       struct cppc_saved_state *s =
>> +                               &per_cpu(cppc_saved_state, cpu)[i];
>> +
>> +                       if (s->firmware_captured && s->firmware_val != U64_MAX)
>> +                               cppc_saved_regs[i].set(cpu, s->firmware_val);
>> +               }
>> +       }
>> +}
>> +
>>   /* Autonomous Selection boot parameter modes */
>>   enum {
>>          AUTO_SEL_DISABLED = 0,
>> @@ -766,6 +934,9 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>          policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>          cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>>
>> +       /* Capture a CPU's firmware values on its first init, before any driver write. */
>> +       cppc_cpufreq_save_firmware_regs(policy);
>> +
>>          /*
>>           * Enable autonomous mode on first init if boot param is set.
>>           * Check last_governor to detect first init and skip if auto_sel
>> @@ -812,7 +983,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>                          if (ret && ret != -EOPNOTSUPP)
>>                                  pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
>>                          else if (!ret)
>> -                               cpu_data->perf_ctrls.energy_perf = epp;
>> +                               cppc_save_requested(cpu_data, cpu, CPPC_SAVED_EPP, epp);
>>                  }
>>
>>                  /* Program min/max/desired into CPPC regs (non-fatal on failure). */
>> @@ -826,7 +997,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>                          pr_warn("auto_sel CPU%d failed (%d); using OS mode\n",
>>                                  cpu, ret);
>>                  else if (!ret)
>> -                       cpu_data->perf_ctrls.auto_sel = true;
>> +                       cppc_save_requested(cpu_data, cpu, CPPC_SAVED_AUTO_SEL, true);
>>          }
>>
>>          if (cpu_data->perf_ctrls.auto_sel) {
>> @@ -850,6 +1021,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>          }
>>
>>          cppc_cpufreq_cpu_fie_init(policy);
>> +
>> +       /* Reapply any saved values lost across a full policy teardown. */
>> +       cppc_cpufreq_reapply_requested_regs(policy);
>> +
>>          return 0;
>>
>>   out:
>> @@ -1039,6 +1214,8 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>                  }
>>          }
>>
>> +       cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_AUTO_SEL, val);
>> +
>>          return count;
>>   }
>>
>> @@ -1111,7 +1288,7 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>>          if (ret)
>>                  return ret;
>>
>> -       cpu_data->perf_ctrls.energy_perf = val;
>> +       cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_EPP, val);
>>
>>          return count;
>>   }
>> @@ -1193,6 +1370,9 @@ static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>>                  }
>>          }
>>
>> +       for_each_cpu(sib, policy->cpus)
>> +               cppc_save_requested(cpu_data, sib, CPPC_SAVED_OSPM_NOMINAL_PERF, perf);
>> +
>>          return count;
>>
>>   rollback:
>> @@ -1258,13 +1438,11 @@ static int __init cppc_cpufreq_init(void)
>>
>>   static void __exit cppc_cpufreq_exit(void)
>>   {
>> -       unsigned int cpu;
>> -
>> -       for_each_present_cpu(cpu)
>> -               cppc_set_auto_sel(cpu, false);
>> -
>>          cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>          cppc_freq_invariance_exit();
>> +
>> +       /* Restore auto_sel and the other saved registers to their firmware value. */
>> +       cppc_cpufreq_restore_firmware_regs();
>>   }
>>
>>   module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 0444);
>> --
>> 2.34.1
>>
>>
