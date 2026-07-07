Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4063630B525;
	Tue,  7 Jul 2026 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453551; cv=fail; b=dIkAi+8Fwt6plEUWSFETD35ojFhXl/ZLXUUx/h6QID0kEdZ6NCtURjOjY2m9pSVzhhcyaz95AEnJEFXzdvOjLqclBsU2+KF+uybP2tU40Bircd2eNpCKp8X09dF1G7KvHXa2pcGJP1IDO7UZhbT7Tl/f+pNN4Scjy75BS9AqEEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453551; c=relaxed/simple;
	bh=6A5ruT3VwnUB5hRLmy2uR9cQbFCaU4E8tMfFsxnUWqc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJabFolLlN+ooSK7CbqxasbC3Q9XR1y6KgajrqTrnkDj7m4El9Twq8at5xUbPrX4nR2UUGAZ3hF6lgV0FctfM9WOvslagXWqjrB/A/rWK4urcndAr9H/PWbbmvm4BDg2IoeQ3MlUp29cEDUEzLmt//L99yrxnXoJlpNtGJNSWH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YzMswTDF; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzMswTDF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZpQQLaKcNLIq4OalmhcQmbQvGYEd9fzo7XTUch6rQ3CB3uVEMZrur8qISp9eL1GXtDmrKaERPgN09VQvgFHk3AWziTQ01b0RCNPSszmXmPQ3nHxXllBaB8NJ6aUyN0MmlHdfa3r3hsBthUwGZGnZBxvsCC6hEdPr2ZigNi6o3QQ2bSSYStPkJhdrVrld2JJ7Ztay2MpY7mZ/lT9kuar9GtbeAcUIpXjYue+/s/KicUSpXtB61omHI5tGCPsXNUiWsvTOdJzwe/u51wcMLGzZLCsxc9qblRuoVd3v4ZaLkIWSPBdzYXHpcInDkUTNdnC9nTczs4Le84rc673Bud4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PprZpRxe/7Qn5OhEMeNFuEG/WQ9KU+WlpZndA7FoKrE=;
 b=tKl1tJpOD2+ABilHuFbf97g9Rgif4CYp9LuARaSJ/fkQ2NSVu2zsDCLGDZ16eqdQHaKvUFI8N0o+w9xRjN7bg8DmY22HVx9ZKfl1pacLMmtEar9uqg4WXGWOJhZZUQ8NYob9f/tbY8vTJy5i4m8V3IfJsK2soI+0oru0a/QIrKgmM0QKUGNNHpLt3edyaQTCAw+Ug09HgvUppsFBTpvWfs/+Xlsoxhyxf6faLlVcMOhhxqFe+UD6Zf2q1wcTAdp0oB24yxmKCXKZluD6aH1S7HFjbJKb7GDtr+LRoeWNBEX/YXXbsRYkZ1Vuibg2FOIqdsAjXJXOuLbtrsuGsujhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PprZpRxe/7Qn5OhEMeNFuEG/WQ9KU+WlpZndA7FoKrE=;
 b=YzMswTDFAyGBCkI+olB6CZCdjIMjvQftwT7Ai/A6DaWDUV/PPQ6E3DY5LBFWwyi7YR8hw4xj54fjbjQSPNkqxxwvolROJcetdySHK/ICp6IUK+v9q2yl/YxDjH1jOaru5zh3+Jbd22wZ10ILuvOWWZ8rMW/Lo6aDXqA0TA5uZfPo2qPAzxjf2UMcyKRFq7y4FieTouDaIfGOZHJfD8PmPBTGN9tIyqRTb2a+pbTTDVy+M6CGTzD4k+2u2Ib+j7k5ZmSnGifuAHFf87Ub8nz3sgE05fPJdv542D8ncrGv07C6H9pcbZrh79fv1P+sJIpJDm87p6Y+0ZvhZ14Wb6LM6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 19:45:46 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 19:45:45 +0000
Message-ID: <08c38829-7896-4eb9-b5b7-fd7041623fdc@nvidia.com>
Date: Wed, 8 Jul 2026 01:15:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Pierre Gondois <pierre.gondois@arm.com>
Cc: viresh.kumar@linaro.org, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260623095403.3407436-1-sumitg@nvidia.com>
 <CAJZ5v0jvkNfx-1XChRCsGHJAcY7W4j41P+Xug6+TpPge7tHF7Q@mail.gmail.com>
 <de03b23f-18a3-4e99-a15a-5044463ac484@nvidia.com>
 <CAJZ5v0h+Fhj8+xLC=TAqx43+tQCPDUj-eP9YMW=BwKzn8CPUDw@mail.gmail.com>
 <15def9ce-abbd-4ef5-bb8f-0c55b42a0181@arm.com>
 <CAJZ5v0jB4kpsZn+JxhwoEviagvM7THFsWb7gQ7HnvYaOwm9-gA@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0jB4kpsZn+JxhwoEviagvM7THFsWb7gQ7HnvYaOwm9-gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::23) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b432187-3ea9-4716-9db4-08dedc60562f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	oanXshvT/0Mnjjj5qlQr+YWTmcpGLBtYvilDtpgUtI6EJ7/Y309V8r36fDKGmqgtdHyCMbgTa21iZoO7bg7DXCVPxPWBBWCAWDbBOSu5zRG8OFuCe7ZGLj0IiCAuRViKga0MJDCOFZt3gIT2FF4w6fNc5PKubBnZCoJzAsez2wg9rZu9m2OlfsadMKQB8TasRv5RaroAx6jtMyXrrhu8kYjgXAwVbK9Jfxpb/pD3M9TtDHH4YKPFAdSr2h4vpM/YELE4IKa7PhOrQlTO20cC56P776usCLtsy5tP3w0Naoea6RSG73VW9CMkM1OlZaetUBOMZp8oydD2fu91m/1UCT/0lnyTQPWWaQWEn/2rd6GpxRK4+/zByaqRToyj4pp/IBWOrevPkfeXKv9YsUC3saovjC4KbClQULtvNwxF3S+J/EExcK8fQXutNGliIYRiJHP5DA6MZS07FPy3IAkbVoDsjeLA/Lk5IizqS3dU/clj+sMuA08jd3SUROhL/1VXnG1X5ZWBbe5wytzQipjO9mO9k3JNN9qVWi1hhoCxhXjp8P/uaiVogaoHSKvsHmfij91hWVUZ9zvIlqdGt5/R2ljaJc0U9oz1W1AsBEV5KeoeNQN4xNzYr3D6RQTByBV+kL2Ca9cosop/eO8mtKyLbKPdLyAosYTaYcawScUwqMU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEtUVE04OW5uaUFMaVMyV3lIZWxNdjdEeG5PRjRNZ1RiZnNEc2s3aWpWQ1hx?=
 =?utf-8?B?QkRrRDZocmgwNzZ1czJEbStwbldhbFlaK1JkWlk0NjJ2eEVpbUFCTmw3eEVI?=
 =?utf-8?B?WWkwME0xNVFObkFrL1F2Q1ptMGpkLy9WVDVMOEhteGdIY2hzVGI4eEhwRWpq?=
 =?utf-8?B?TVMxb2VadWNnR0g5elJRaW1aaFZPRzQ4Yzh0cG1zSnFrNzFxbEJpYWxoWFIr?=
 =?utf-8?B?azBmMmdsRW1mQ2FQSUFuTnYyZExZWkNYT0tVK2V0UnpTT09yWElYaTZ5UTdQ?=
 =?utf-8?B?dDZ4eTJQNHlwOTI0MjNFQXMwYVc2NThNS2YyQSs4WUNOeXhTYVNoNksvNEFn?=
 =?utf-8?B?VW0vTVlUMmtEOWhOTWtJTTZqVmgxTjlQNko5Mkl1TC9DVDF5bjVPRHcwcFBy?=
 =?utf-8?B?SXBWRlZwdXRkVXVINFpkSlY3cXhhdHdKa1orVjk1TU9Tcmx2a0p2VHN6THRl?=
 =?utf-8?B?c0FkQlhvc3F0WWQrNDVxdXkyd000Yk9BSGFkeW96dDJwZDRhR1RVcFFRL0VQ?=
 =?utf-8?B?UlRiZ0FxNTlzYzZHaEFoaVM0cWRka2d1QlJSdURQanYyUmFXUkJxamltQ2Rp?=
 =?utf-8?B?b0JudW95dE15bmExdjh5RkVmWE8rR2dDWnRBTFM5NlFBekpkMmVZZ0dpYzJQ?=
 =?utf-8?B?VlBreE01WHZDTk5WVnBFU2tJck1ja2Z6NDFkZTRGWTVKK1ZQQzl1QU1nSFhI?=
 =?utf-8?B?aFE3bnZuNFJtODJYaWFuT0d2QklIdEpOd0pydDBTSUFmelFXR281M0FWWVFs?=
 =?utf-8?B?aDVQeUlrSk9VZyszTnBTbXFIZjF0MHZYcW9jL0ltK0ZKdE53QWhsbmNyaVR5?=
 =?utf-8?B?Q1Jzb1llVVBrenlCYTJjTnJDWVN4aFc5dVR0Qi9hcVdTRDNObEJ6KzhuZ0lE?=
 =?utf-8?B?N2VwWDlEYVhqdmhiSkQ3TmYrTGJveUVhK210WFQ5ZEh1bFlIampMRkI5b25O?=
 =?utf-8?B?L09rTHlyS2F5K01Fc1d6STVxSFVZdHZNY2I0NXFrSmtCb3NQQXdLM1FKSTUx?=
 =?utf-8?B?a0FQM2ZIMmo4Vi8zbGUxYWZYVVpTKzIrdW9QbW5QVG9VNFJpdlBhdzkwblRU?=
 =?utf-8?B?cE9wbjhjalljTUlWWExldEFVUjVxSGZyanV6VUhIOU1venNNTy9qanJibGYz?=
 =?utf-8?B?K0ttV21teUlWYTR0K2JXQVpSbkVIVjBtdUNSalVXeGdWd2IrT2hCRTRPZlM1?=
 =?utf-8?B?c2hwcGtIbmdRRlphbEJCd01ERWVsRWNvWjJkeWRycFBXWllDbkRrQ0JJQjRD?=
 =?utf-8?B?QWRqdFo5Znhzai9rYWMxMmxvcGNsU0s2dzdmZXlIWmk5ajM5cEdVcE9BZzBx?=
 =?utf-8?B?amN5bTM5SXpXK3IwWGh5c1ptUVVyUTNMZmNJMHB4Z29ZVDFVQXEvUkJnM0JJ?=
 =?utf-8?B?dmdRZk8vcWRxaGxQQVBvQzJmUllxOEwyOUtQd2NYdHRTMDBITUdvZ3NBU3Ez?=
 =?utf-8?B?Q1NvaHgyeWNheThSQUtGRlAycmF1TXg0VWJUcTVJYW5JS1g3WTNKby92STNz?=
 =?utf-8?B?bUxvWnl3Z2Y0RzBKVDFKWHN1ZVFHUVhTaC9vMExqMHJEamc2Z1BmUStmMUND?=
 =?utf-8?B?RjhJMDZOaVNUVXR4N2xuVE5GZ1VTSmsxSFdwa01tYStOaFdZV21yZDBFRUZ6?=
 =?utf-8?B?ZkNyeEI1Slpxc25WNys5ZkkrczRoSHpDODVEYTdNdms1S0o1Wk9mc056UEV6?=
 =?utf-8?B?LzZQOTRUU0Exa3Y2K0hSTkQ2dmJxWTBRQmJ0NUdkSUhoWjAxN1ptaHY0L29I?=
 =?utf-8?B?bElvRHphR1lTZWxKTjl1ZWJHWEx1S1pCdmVmTjJvWFV0bGxuZVFwdnBtY1JD?=
 =?utf-8?B?R0RPaldUOEJoK05OOWJEMXZhaE9Bb2lIck9IQkNjTCtoME9WbWZYczJSU2k4?=
 =?utf-8?B?eDBlT25Bem42aCtsY0l4VkMyWDNFWkdrb2ZjdGRjeVAwOEFsZWtESWpsOGk0?=
 =?utf-8?B?eW81VWtWYkRRWlB3MVlGM3VPWVRweUREcEQreWt1MDErOHdsam9LNFZyTTA3?=
 =?utf-8?B?dG1ZM013a0lXdnlGZEQ0WVZCRDcwelRCK1g2a2l4czNXWmZhR1hWMlEyZk5a?=
 =?utf-8?B?bW9FR1R2Q1pkb2trWVY4Y3Awa2lydFVEbXVpekJlS21HcEFiN2NrZDB3NlVT?=
 =?utf-8?B?V3l2cmJaTTJlTThSczdiTlpEeUhQai9vWmcrUDdMN1M1cVYrRVpWdlo2Y2xX?=
 =?utf-8?B?Z2JHams4dHlMTkJId1RGbFRpVjlSVTN3MFMreHRhdjVKUVllZXRudHVaNklB?=
 =?utf-8?B?QVg5TDBGa2REVldOZ1c2RXN2ZXhKMmxjelhlSWswZ3oxdEgyQkxrMUpsYU5P?=
 =?utf-8?Q?8Io+jsdvGfwBTH9qFe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b432187-3ea9-4716-9db4-08dedc60562f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 19:45:45.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+q1Fbix2Ja5dUqvnhMwOjPwAR+vbOaHAu4lo89yCMhm9O0B8UhxKu7QomElmnsDE1BScDRllaDeOvVMUDT8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161


On 07/07/26 00:04, Rafael J. Wysocki (Intel) wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jul 1, 2026 at 6:25 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
>> Hello Rafael, Sumit,
>>
>> On 6/24/26 15:20, Rafael J. Wysocki wrote:
>>> On Wed, Jun 24, 2026 at 2:56 PM Sumit Gupta<sumitg@nvidia.com> wrote:
>>>> Hi Rafael,
>>>>
>>>>
>>>> On 23/06/26 16:30, Rafael J. Wysocki wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On Tue, Jun 23, 2026 at 11:54 AM Sumit Gupta<sumitg@nvidia.com> wrote:
>>>>>> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
>>>>>> boot parameter) can be lost in two ways:
>>>>>>
>>>>>>      - Across CPU hotplug: the platform may reset a CPU's registers when it
>>>>>>        is offlined.
>>>>>>      - On driver unload: the value the driver wrote is left in the register
>>>>>>        instead of returning to its pre-driver state.
>>>>>>
>>>>>> Add a small table-driven mechanism that handles both:
>>>>>>
>>>>>>      - Capture each register's firmware value when a CPU is first seen and
>>>>>>        restore it on driver unload.
>>>>>>      - Record the last value the driver set and reapply it from ->init()
>>>>>>        when the policy is reactivated after CPU hotplug.
>>>>> I'm not sure if this is a good idea TBH.
>>>>>
>>>>> The overall system state when the CPU goes online may be completely
>>>>> different from the system state when the CPU was online last time, so
>>>>> there is no reason to restore its settings from before offline, at
>>>>> least in principle.
>>>> These are values userspace deliberately set, more like a frequency QoS
>>>> request that persists until userspace changes it than transient state.
>>>> It's platform dependent though, as the platform I test on preserves them
>>>> across hotplug, but where the platform resets the register on offline
>>>> the value is silently lost. Should the kernel re-apply it on online,
>>>> or is that better left to userspace? If so, I will drop the hotplug reapply
>>>> and keep only the restore on driver unload.
>>>>
>>>> intel_pstate and amd-pstate already re-sync these on CPU online, as they
>>>> keep the policy across hotplug via ->online()/->offline(). So for them
>>>> it's re-syncing the hardware, not restoring state from before offline.
>>>>
>>>> cppc_cpufreq has no ->online()/->offline() today, so it fully tears the
>>>> policy down and rebuilds it, which is why this reads as "restoring
>>>> settings from before offline".
>>>> Would adding ->online()/->offline() be acceptable, with policy preserved
>>>> and ->online() just re-syncing the registers the platform reset?
>>> That would be a better approach IMV.
>> Just an example to be sure I understand correctly.
>>
>> 1. on a platform, auto_sel=0 by default
>> 2. cppc_cpufreq driver is loaded + we set auto_sel=1
>> 3. all the CPUs of a policy are unplugged
>> 4. cppc_cpufreq driver is unloaded
>>
>> To be sure we let the platform in the default state,
>> we should set auto_sel=0 in step A.3, i.e. in the
>> .offline() callback.
>> Doing it at A.4 (i.e. in the .exit()) would not be possible:
>> the CPU's registers might not be available anymore once offline.
>>
>> IoW, we should only need:
>> .init()
>> \-cppc_cpufreq_save_firmware_regs()
>> firmware_captured=0, save the firmware regs.
>>
>> .online()
>> \-cppc_cpufreq_save_firmware_regs()
>> firmware_captured=1, restore the user (or previous)
>> values that were saved in the previous .offline() call
>> (as .online() is not called for new policies).
>>
>> .offline()
>> \-cppc_cpufreq_restore_firmware_regs()
>> Save the user/current regs values
>> + Restore the firmware registers.
>>
>> And it should be ok to remove:
>> - cppc_cpufreq_reapply_requested_regs()
>> - the firmware_captured field.
>> If during .init(), we init requested_val to the firmware
>> values aswell, firmware_captured should be useless
> This sounds about right to me.

Thanks, will restructure accordingly and drop firmware_captured. Flow:

->init()
\- cppc_cpufreq_save_firmware_regs():
    Read regs and save to firmware_val.

->offline()
\- cppc_cpufreq_save_req_and_restore_firmware_regs():
    Re-read regs and save to requested_val.
    Then restore firmware_val to regs.

->online()
\- cppc_cpufreq_reapply_requested_regs():
    Reapply requested_val (saved in ->offline()) to regs.

I think it's better to keep the cppc_cpufreq_reapply_requested_regs()
helper and call it from online() rather than reuse save_firmware_regs().

init() and online() work in opposite directions:
  - init() / save_firmware_regs() reads the registers into firmware_val.
  - online() / reapply_requested_regs() writes requested_val back out to
    the registers.

A single shared function can't do both directions without the flag (i.e.
firmware_captured) even when init() seeds requested_val to firmware_val.
Reusing save_firmware_regs() for online() re-reads the register (which
holds the firmware value offline() just restored), resets requested_val
back to firmware, and writes it out, overwriting the user's value
instead of reapplying it.

So better to keep the three single-purpose helpers, which also read more
clearly, unless there is a clean flag-free way to merge them that I am
missing.

Thanks,
Sumit


