Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF7381B19;
	Mon, 11 May 2026 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534453; cv=fail; b=K5+wJ4reSiQnTd2UquhljZ2NecdzUtA+RRnWOwQpHQZBf6tSFIi3Ksmr/hrgX/iswTaHvH95/XmM/Nq2Dy/QG/StxdqkkoUPBNqfquMzZtcAQPgQGAKlSb/Vs6cryOOYFvGi6j0LHz1OAQZOBhKpg0eSJJiWIApAck1+udzJEsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534453; c=relaxed/simple;
	bh=nXN3W2meuftnA0y5A54F7L9H4Cbz0EPW7Cw2+H+Ysoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9+wvSUg2IOvaIAFO2zx2BJpYUZzKXGqjPn302dhvHl3yLS3qW16jLQhflUiAsJaSR1ZwIXs1U0UkcD99WjmTaRz3nM0GihxIfZxfY8WKAoKfAjXqVw8nYJetu/MeRLrTeEkDewvuqRYwj8L91h1mXos5iNa0juYnVtZolviN38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g4OHo0XP; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g4OHo0XP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNUa5Q1I+KJeKJ8P3zFV+tmszoVYAhrHKZ0binu3ag3OwdDprfDu4Vm6t/fjU5gGmY0gsyQx1SZd/edIwUGoFuHY55apc5ZCnCPIz5uHL4oP4nb2E0WCWpNUrrS4A2wUFY8nXoNBeDzq+L/UDlm0D57NfnDqcSE6al0dlOLWia18HJvaaSMsfzrUzyFLrzlsX0nNtXeIl4HJBqOfEOk3syzf7gz0bINmumQrbJbyX9lsDZjRlNGpQoEqhQVpkwCR7a0fMT/azK1eigW93FQOpyaguVBqAKub60SuCbeIDxffOu6dv0ouLnTw34RD5ey3VvJTRiXIpyB0csHY3Kpz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6py+6TD2tMBRfsNgJAGQSY198l4u8URjgXsbJUogmS4=;
 b=MMiemA+fVYOeMZEmDFW+bVaVGKkXZHA4172pH9+55pIDYJmanxvi8oSYUwISM/327LOL2TE7pXHUV3SrAKZ/FtEH13FW9G1Bq6v41tIzsA5fqmgXwqF9mzXpr1MyplYCvqHnSo7oNDXbs4PrjPE95WhcO9OfFzDobNv+pwasz4LDiBIPgjR7kKipglbTk0ggNR5El2imgCee9T5K9Zaoa7hPv7XYDiaZ+KuIs/lq+H14iu7pcJgCXgEd80dgPeAj4lZv1QLxfFelohCp2oIcDGLkJ5co/roZi8cWMUaYp0ueatJxhHysdVa6nebV9zNrafpy/id8z4ezIdXOQCvk/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6py+6TD2tMBRfsNgJAGQSY198l4u8URjgXsbJUogmS4=;
 b=g4OHo0XPeiKbHhbiwugLoZWn6+nKzYN74z+G8p/Bknbaq/jlXkl0xIeh5ERDoX5PC8DkRrmEKHqpneV2K4VsIvp1ZhIUeLy95z86uJG6XBZQSzOJb5qLX9tZMh6OD7WBLGzWQMmmrun3ddYPJ0fXXI1DQ4rjv1BoGKOL4mPqxTtwd/YCO3LKg1IPw4SV8oB8MVg7hwBm5eceoYyTbp3mlMoO7j1WysVEuKxy+T5H6IpAzIFjs8F5nu+uDFeCJOtgRItqEwsv3X1EsBoDyBCMFGVtt2MzCkVceLlhdIyB4KXrG9z2rBRC8sq1nTqAXn+SCoOHeWws362RZWJT/xVeOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 21:20:44 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 21:20:43 +0000
Message-ID: <3b0b5f30-437e-43c0-8b5a-d3ef84932113@nvidia.com>
Date: Tue, 12 May 2026 02:50:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ACPI: CPPC: Add CPPC v4 support (ACPI 6.6)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, mario.limonciello@amd.com,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260430142430.755437-1-sumitg@nvidia.com>
 <CAJZ5v0gCSPjnxE2Vd+Py14ENJ6U46KBQVHiBetLfEKGybtDh8g@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0gCSPjnxE2Vd+Py14ENJ6U46KBQVHiBetLfEKGybtDh8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::12) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc70a52-63aa-4fe8-1533-08deafa3289c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	GMdT+ig2vnTn80padArk8J9LGpPWkVSIFoE4yYVfEQ/dzMhd7EH87dFQlAOVMtV0YOOZD2Z+aGbICLBF6q0w8xb25KchkSef03MdEvnxccDpP+e36i27gBH4HyB6NM2vq3+57GcIVBOHXHRAj3nIHyErN4MXM4lUidta1Faud7SpprL53e0kknX/qQRsY/0e0ChV5j3cP41fCjz/HsgVaGsdHzIp5w5owKW2v8dZG6PWRdv0PI1kAk+SLsPDGy45Hlt+oawbfQaJ0Ngk+/mur2ze9kdef5DNBbQlKzsaUGn5VPgce91+HqjmlOiKi8ujbztTs3KX0qIzR2nLB44f/pmCjB6coiXCT0NpGb4bL8bHxLYra8zoTKVlNW9FD9n0XPgvZFLZXkf/fjCtVFtdwKBmXKFtsY609JNzstXG/TAsRvJgizlDbo0/eEhHgMwRwXz4vfsEThquBjowodhpKwisBfDsel5Jj4JNec4UDz5dBGZaQyKwcOE11T3uHfCW/TIi2NEQAA9hwRy1JxuJWP1Gd/0Dwl4hHFZsQ/NjAPUesIiUvRwhJZTfGl62I3hg8Bqg5VZ0WQwz9aaRKWPWHOpWpVAVCq1RrrjNU5VJgsyVqzqrNISxRm11iUfQkB4g7g4zn6PK6n60CTx+qM9VOlU78iYA0WMWbL7tqS6Y0QR7rdqfMSRsXv79AJy/+WyR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWxnSlEzNFFSKy9aVDUya21Vcnhrb1dOSU90NnVLV2pncnRrTm9IMkVrb1lX?=
 =?utf-8?B?bGVDMHRUcUxDL2RPcFRURXptQTRtSlhWVWJYRGQ5S0htRDBaRXdmcHdYV2Vn?=
 =?utf-8?B?R0pSYXJkVXozVnRMWHJ0MVFXMU40UFRBem5xMjdpY0ZGbkVUMlIvdGRpUVlN?=
 =?utf-8?B?Z3ZCejRLL0VIS1IxaGtIQjZ1UzlleUJVdnYzMCttZzZtZ3Zya3lxcEZqb2p3?=
 =?utf-8?B?U052ZHZIY2orZjExS3ZXeWc2eThHZWEvMDN4cUs0L3NLNnVXbnBaOEhnaVJo?=
 =?utf-8?B?d2RydG85SVE5dE0vaXNGajk0RkhmQmRMZHJYQ2dVZUpodlVMLzFHNzFTMElC?=
 =?utf-8?B?WnNWS01aUE5OSDRUN3dUZWZ5VWZKSndaRXlYK0VqQm5Va0ZuUHE3MUplQjVm?=
 =?utf-8?B?RERsWVI4Yk02RGp4cDcyZFhNSlJqZ2FEVnpZTkV1TVNLWlhYaGsvU0JVeUt3?=
 =?utf-8?B?OUxDSm9qdXhIdlc0dUFTVVZDazZMMk1kZTFPSm15czk1WDhXcXRPNmVocGZi?=
 =?utf-8?B?aDBzR3dJU3VReGtKQVk3SDJPWjRUUmZkY2hGbXZtaTlLbC9JV2d3ZGozd3pO?=
 =?utf-8?B?MDhoY1cyVkdFWkVvRXdvUkZKUkNFZFZvbG5TRkY1R2ZRcGl5bVZQM2lhRVU1?=
 =?utf-8?B?d0J5RW43aFBMbTFqcCtOb3IwdnE0cUtpamJsU2xLbG5VL0dmUUxNUEpIWXkr?=
 =?utf-8?B?T2VOalVOSlZGNDBORlNTRXFORUVSZXdTbll0NTFxRVNYZGg0VzRMU3ROUFhB?=
 =?utf-8?B?UE5yUFFyVExFaHZQbEVEbGFkeUpUUDVLNjVzeVBrQTUzbWxUQVFIK0NyS1ZU?=
 =?utf-8?B?aHdmVFBtTjJIbWZEanlWUmZhb3R1RmUzVGJoTXlBbnNjb2pQWXZINnFZaHM1?=
 =?utf-8?B?Ym13YzY5RmxJZ0pXTVlOZTBqTU1USGUydjZWZm8vU1h2eThoY2xqemNpZnpV?=
 =?utf-8?B?WWo2eGxNbS8ydnJBUUdZM1hYc2VuZWlXdDhXNmxGSmZDdDFPMHRmeFd1bVVL?=
 =?utf-8?B?YkY2bGxNaUxoNXJ6UGw0L2N1OFExREVlZVhyTmJpN1BFQVNEbWQwcHdjdU9X?=
 =?utf-8?B?R0pKOG9ySHdQUmFCSU1lRmgzK2hFMjBSVDBaT3Voa3lUTHF0Nk1rbXMrKzNV?=
 =?utf-8?B?Y2xNNFB6dER0b2ZzYmlQZ0FRanpMQ3ZFOGVJTG1WbFRQbXZVZzluSFQrUDAz?=
 =?utf-8?B?VlpPUzJDdU54aHZzaDI0SmdmOFBKUmcyckVGVzhlaE5xcmRlUkhFNlVRcmho?=
 =?utf-8?B?K0JzUWxXODlTc3cxaUsyZW5URGNqak5aZFNhYjgwL0srMkdlcXhoakg3bkFu?=
 =?utf-8?B?dWozNDVZb0oybWlLdExPY2RnVWxZZ2M2ZkNnaUhZSWNlRjlUTVhxZ3ZHU0VH?=
 =?utf-8?B?YWxJei9KVG5Ncld5YjlVOWE2YTFPRWFNWlBQZk1IR05uYjdGNXJ6NU9rbU00?=
 =?utf-8?B?RzhjeUZDdUx3Zi9WR0licWZCWS90SldSc0RReWpTaFNVTk0vaUJHYjluY1hp?=
 =?utf-8?B?OW5rcE5Ub29iNjZ2c3hMazZONHJtMFdPMWZHZGZseDd1aTBlMVJ2T1NCTkdH?=
 =?utf-8?B?WXhTTDBUcXhPaHZxUVZueStwcTIybGdUQjhLdmx2d2hsdEJzTjUzQXFWQXhr?=
 =?utf-8?B?bHloSGNzOUl4b1R2Mm93VVZzYzNOMGtZTDhxK3RReTRZYngvMTJQUXpNT21F?=
 =?utf-8?B?YnRkSXZ5MmlOendLOTl5dXY0MXRMbWtKVldHZGwxMCtweE9YOENkc1A4NStt?=
 =?utf-8?B?NGFrY0wyZFRYVFJHa3cxdm1Zd09MNVFhZVczOFhsZ1czVEpwZjdUeTJSVkRP?=
 =?utf-8?B?MktKSm1tNkJKamJqUDlGV2c3djJSTG53Qkh4TU5kTGxRT205YXhpM1dweGoy?=
 =?utf-8?B?THpKV2VjQVQ1VDB5azRHRHNubk1KTGttaUVnZHYrUzNKSHgxUnkvejJCZndZ?=
 =?utf-8?B?dm1UWmhLRGFuY1kweTRmZ2Q5YkJzZi9pNXpZSEJFMmRQcUxTMVBsR3U1NHBr?=
 =?utf-8?B?Q2ppR1piTlhCZ05NTjFTdUNMMFFjN09xUTZlY1lDVkduMjRKRjM1bjVmMVRR?=
 =?utf-8?B?dk5xUmRIWjVSZWttMGU3dFprblFESzJLdDk0bnUyNEFpT0RwanluZUloSWtv?=
 =?utf-8?B?d0NlV054TW5Ba3VIaUh5VUZZb2Ntd1lzQUw1dlVCZU1oWlIxSDdnTUFGUVdC?=
 =?utf-8?B?V1Vuck9WUmxTN1NkM2t2RzZPcFpiUVBXRUFWTDliTXpYOFMyeHh6VTM0cU5M?=
 =?utf-8?B?d3ZxQ2ExY0pZb21ydFh0RE9aSjVhTHgxbTR2SEc0RCtmWTQ1RXl3eUZJVGt2?=
 =?utf-8?Q?8/snkVzF6F0CbNxPSz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc70a52-63aa-4fe8-1533-08deafa3289c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 21:20:43.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EX9zUBOOXGDvbs7yMB7KChTA58H3xbT84eu1ZzWF/4h7xqYYIfzE8wBeB5Fpt78X8+hzK/pZEKOR5o7KLRBKGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

Hi Rafael,


On 09/05/26 00:31, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Apr 30, 2026 at 4:25 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>> Add initial kernel support for CPPC v4 (ACPI 6.6, Section 8.4.6),
>> which extends the _CPC package from 23 to 25 entries with two
>> optional fields:
>>
>>    - OSPM Nominal Performance (8.4.6.1.2.6): register used by OSPM
>>      to tell the platform what it considers nominal. The platform
>>      classifies performance above this as boost and below as
>>      throttle for power/thermal decisions.
>>
>>    - Resource Priority (8.4.6.1.2.7): Package of Resource Priority
>>      Register Descriptor sub-packages. Full parsing is not yet
>>      implemented; such entries are marked as unsupported.
>>
>> Patch 1: Add v4 _CPC parsing - validate the 25-entry layout,
>> handle the Resource Priority package, and mark the two new
>> registers optional.
>>
>> Patch 2: Add acpi_cppc/ospm_nominal_perf as a read-write sysfs
>> attribute, and initialize it to the platform nominal value
>> during cppc_cpufreq policy init.
>>
>> ---
>> v1[1] -> v2:
>> - Patch 1: added Reviewed-by from Mario Limonciello.
>> - Patch 2:
>>    - Make ospm_nominal_perf sysfs read-write; cache last write in
>>      cpc_desc and skip redundant register writes.
>>    - Validate input in cppc_set_ospm_nominal_perf.
>>
>> Sumit Gupta (2):
>>    ACPI: CPPC: Add support for CPPC v4
>>    ACPI: CPPC: Add ospm_nominal_perf support
>>
>>   drivers/acpi/cppc_acpi.c       | 93 +++++++++++++++++++++++++++++++---
>>   drivers/cpufreq/cppc_cpufreq.c | 10 ++++
>>   include/acpi/cppc_acpi.h       | 14 ++++-
>>   3 files changed, 109 insertions(+), 8 deletions(-)
>>
>> [1] https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/
>>
>> --
> Can you please see the sashiko.dev feedback on this set:
>
> https://sashiko.dev/#/patchset/20260430142430.755437-1-sumitg%40nvidia.com
>
> and let me know what you think?  Especially regarding the second patch?


Thank you for sharing this.

Patch 1:
- Comments #1 and #2 are pre-existing issues with rare occurrence.
   I will address them in a separate hardening patch.

- Comment #3: In v3, will limit the ACPI_TYPE_PACKAGE handling to the
   RESOURCE_PRIORITY entry. So a Package at any other slot will be
   treated as invalid and abort probe, as it did before this patch.

----------------

Patch 2:
Discussed the changes for v3 in some detail on this thread already
which address most of the points (Please see my reply to Pierre [1]).

Summary of how each point will be addressed below:


 > The commit message states the valid range is [Lowest Performance,
 > Nominal Performance]. Does this code allow writing arbitrary values
 > outside that range by only checking against U32_MAX, without fetching
 > the CPU's capabilities to validate the input?
Will fetch the bounds via cppc_get_perf_caps() and reject values
outside [lowest_perf, nominal_perf] in v3.


 > If the hardware loses state during a logical CPU hotplug or system
 > suspend, but the software cache is not invalidated, will this check
 > prevent the register from being correctly re-initialized when the CPU
 > comes back online?
The redundant write check will be removed in v3, so the stale cache
failure mode won't be possible.


 > Can concurrent sysfs writes permanently desynchronize the software
 > cache from the hardware register?
 > ...
 > Is a lock needed around the read-modify-write cycle?
This will not occur in v3 since concurrent calls for the same
policy are serialized by policy->rwsem at the cpufreq layer (see [1]).


 > Additionally, can a time-of-check to time-of-use race lead to a NULL
 > pointer dereference if cpc_desc_ptr is initialized concurrently?
 > ...
 > Would this cause the WRITE_ONCE() to dereference the locally fetched NULL
 > cpc_desc pointer? Should this explicitly return -ENODEV early if 
!cpc_desc?
Will add the early -ENODEV return at the top of the function in v3,
eliminating the NULL cpc_desc race.


 > For shared cpufreq policies where policy->cpus contains multiple
 > logical cores (such as CPUFREQ_SHARED_TYPE_ANY), does this skip
 > initializing the secondary CPUs in the domain?
 >
 > If they are uninitialized, will their local cache remain 0, causing
 > sysfs reads for those secondary CPUs to incorrectly return -ENODATA?
Will move the rw sysfs from the per-CPU acpi_cppc interface to a
per-policy cpufreq interface in v3, and write the register on every
CPU in policy->cpus/domain.
The -ENODATA on unwritten read path will go away with the per-CPU node,
and the per-policy show returns 0 until user-space writes a value. See [1].


 > Also, since the sysfs attribute is tied to the physical CPU device
 > lifetime and persists independently of cpufreq policy teardowns, will
 > unconditionally setting the nominal performance here silently clobber
 > any persistent userspace configurations when a CPU is taken offline
 > and online?
Will drop the unconditional cpu_init write in v3, so the user-set
value won't be overwritten on CPU hotplug.

[1] 
https://lore.kernel.org/all/9c32f75a-294f-4cea-810e-c011c4dd91ab@nvidia.com/

Thank you,
Sumit Gupta


