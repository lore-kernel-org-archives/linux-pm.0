Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562A2372B2B;
	Fri, 24 Apr 2026 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038758; cv=fail; b=EjaB7p3b+e88mAHiKIJ4g/R4fPq+lx28sUzHgk4T1iee1tdDSpyvxsUndPEXwkiyGyy0Mtzye0yxt0ErqqI0qYTTiiiNnWUKSG9i2AuMtzaL0c3IQf+ikGX9SCjds2joc0W3pfLP86WxiUn489Wd3Gsk+ttiONZKexU8WLfceG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038758; c=relaxed/simple;
	bh=YoVUNS4pTK60E4tt9EW+8OjJFDVtcdn9vNVJtaQuaN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AZDqmj+FDZWNnSzni/unm93qpHS8wrZ/3IO0bA4Fdck31vFcNFwaNNqxYqcTwJCGeGHhFSquaHLJTtuN47CJ/xCsSXeKDkAovbJmqIUk3jSw3KD3T/gNG3xTpoC0A0YJjh0gNvT1jL0S+xm3gkUhjW+XzdrcS7evWD267OSydZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYD4GLvK; arc=fail smtp.client-ip=52.101.52.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYD4GLvK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUr3XvdWfF/tlhcSAlDskZuTnHU8vcZblEjnFPwUIgLC1bSPyS6jSB92/6Yon20wBrg+/vzTxDnxqKHcxMoEURhk6zhGdn1jW/Z5LFdUxwUInWOtV7NkTo5Vj1VEDjketcQl/Z3d9VRCr88HXeLp4VAtTjKxQU6/kbVvHuQv5cXLCiMFMn3EUfxkTzo+XHIxDIUnovjbTjU56Kg5d4IvpsNFkAE0tOGtVXTbRBlnZKpXb7wCgmaRMgm3ZYvwXOT9QHnw6jMLmCE7nF2m+1HJgwz2hSgacbAYukl6pB3up5ZkRJrAQRiZ5i7hMl2rz61c7lsUWWEs00dkIpRuBiXOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wguoXS4vWAheV2gEfPMcPrNQadbEfe87W/feicO7mTo=;
 b=Ao+gnAaWhdqjUBQotyQLg/OmK/6lAKzYx/3co5WmTArXWyJc8X0ZQjeKPwPlkE8kyXVFRtHtyLnl/OAxrcLd3WfXc2R0DO1ZzQXZAWKXyLGZuUSm5+5IeEWX/tAmKEBgY92oMbRWQ5eDErNM//+S+xB8NQdPeeebdam7Lg9ZoRWPInnNFNPXLo1RVfUh1YYtWq87U9dTbiMH4m+r3Jr0H99i72CctSQql7vJcOWKgzV+YPLmjj2VhqkhcH2iVgUA/o210mvxnV1iMpw3tJosOGonbDmmFvRH4lkRX/aogbZHP+E+Sp5uyBZNvE9jJs2MY4pcDb48s17gldADfTuihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wguoXS4vWAheV2gEfPMcPrNQadbEfe87W/feicO7mTo=;
 b=XYD4GLvKICZQrKkT73z1fMJ2II9kfCahXP6C/9on9A9iWg5C8xvu1GhvT4L0ljriy7n8z2F+9WVR0L2T/AQ1GbS5ul5luBGjRzKIPFukbxFhonjvOKmK4lM8npZAtuA5Rhd0cfJkHCDKATsylYsYQ/kE4b2IUPGTBGh1KEs5TZLgsrljMg9EtQToxqX+ReJb4w1P4dKm80H1yVHnkVG4MXOmFZ2xHUVKZuCR1X0wolI2FPzErfgg/91vLvz4mDXRvcWl96FfuO7IBwL/NuJRFdmFQxU1XzgYh5YH1g/UPtr++I+92jFgKCU3XeH3pN/JjfSulTUSHFkfIfc7sOIwgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 13:52:31 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 13:52:31 +0000
Message-ID: <4e3cba64-2bd5-4789-b118-95a7c980731d@nvidia.com>
Date: Fri, 24 Apr 2026 19:22:20 +0530
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
 <0fdc7e64-31aa-4bfd-ab27-dea2f349693b@nvidia.com>
 <8349bae0-ec72-40bb-a6cf-6232d8c0cfe2@nvidia.com>
 <aeb16dd2-0eb5-4fba-9b45-b5ef483ab7b4@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <aeb16dd2-0eb5-4fba-9b45-b5ef483ab7b4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::32) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca6ca5e-f439-4453-40fb-08dea208ba98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|11006099003;
X-Microsoft-Antispam-Message-Info:
	+J1B9jXQhVX8iHuBjp1nsnLm8X0XDIZ9KR6C035YfxSQz0sPeR5gZNq43jDBHynw7epZX+OasAASX+1F3KJ2Su9/7SkjaNTOh05M+3DXdsuPI+rz3LG4UdYok4prBxFFCJ0cUhicw1Ak4l7+to0iwBQtmwVtGUsC1/AHOe64HONNff3x0GOzY6Tpuu6f3tFyBvVnXJnBg7QWIvQRX+8DIp2xsYFmhrtlul0s68T7a5Jx6pNIsVTlx1sWrcRCl5PtG6iGwoJevLOKW9QzYy9oKkvP8zVnmAESpEwAQ77vi3ca8PtHvDTh9kxFUyQ3gWQyxkuBZ/+ahUaecBW78Jw+mp39AbpqjTvee8CUFJBSqbpVM7cddsK0BenHbZzqX3wUj3Ee41ZLH9+nybjCsrqs796X3AjTMM3ju0MLKdnV2UDGfdvN0bE9LoAXnyvGx5/Gi9+XedtwiOgg80H+wLKwVIqHBAmXlVjK0kxLJ/yDgbwT+zDVBeTUrS0BSNZF9mSWXJTbr21GXBfUUvbVM+N0WnJGCnZxnReI+J/pWbMKjOjRJ0MXXe353qqDMbwy+8AboJhlotMsooM4m9JR4DlMgzRtGB4DQ0MmIbhFlFLmQk816slrRRSwNzCd1HK5NDbiqkF/ytAK8VN782moBNKuD8mRuO2PUmapzuNm9F5kR/UEwNPAUB+N8+6HZbnTwXlVEb0FTWqWFUSwlPv+ZqFOBof3HJVNhgrSx39P7pxEHNkpVOwcVynV5hbYheelAEB9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(11006099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3hFajdqSFFOQndkQ08xYTZRVE52dTMydVdCTGg4R3R3MU1jd2NjT21BTGh1?=
 =?utf-8?B?VDhwbVoxcG5JZmZZd1ZBZGRIR21GMlRjOGVRTmkxOUpRaE42a1E1NktCb0JZ?=
 =?utf-8?B?SHF1TjlKMldzajE2NGtZbmNBMG1SQU5GQVpkZGZjcVA4Ujdvamt3QlliSnpM?=
 =?utf-8?B?VS9WK1RYQksxSDFoblB3enFRYVE2VW1DMWtIT0NsQkNTWis4bitEUXFPRmhw?=
 =?utf-8?B?UndzOW1LWk1UV3VhSVVuV3QweUFVOVdKMXRLN0oxK2lKN1lTRkNiVEZ2ZS82?=
 =?utf-8?B?dnNVbTFkUkxkUU5RSWJVYUJRTGRaK1poZjNPNHhhSWFkMUNzb1o0bmJGUUt1?=
 =?utf-8?B?bzdJVDZPZ0lNN3VoYjRPOTliUnFiNDU4WWpiUUhub2ViWHU1SU13S1hXRmRK?=
 =?utf-8?B?T3BrbE1rQlZkUU9pQ3Y4VWQ5YXpxYnNrc29jM1BHVUo5eDdTZ2JmL0hOeENo?=
 =?utf-8?B?MENseWN1MWllTkkvZ3E2MUU1UmZwbms2aHZZRGEzdGV3bCtTTU5LY3BtaFNw?=
 =?utf-8?B?R1VnSHRobDFVVVc2ZUkvRFA0d1pidkxYajZ5QTNIdm4xajNvNkN6MytpMlZE?=
 =?utf-8?B?VVIycEFONTJnNmx3aW9mekxhcEt0ZVdQVm41eUljZWxhcExheXFNbzZrMy9j?=
 =?utf-8?B?TGRYVHlKeEVZM0pqUjYwaGtnSUlvOGpiRDgyNGFLQk9pdHFuYXRzZDlsMk1M?=
 =?utf-8?B?QUhDR0ErK2pUbGMzaWZmR2dRc1Y5dm9rTW1ITnVBQWxoRXN4Q1J0bFVoVDVG?=
 =?utf-8?B?a0wrVnhEWE1YbXNMTEZGSXE1WmZXejdnMWlLNHZQaHlFWlBUVmRDM0JkY0tu?=
 =?utf-8?B?RW4wWWR6elAvZ2FJbG1rTGszcUZpcFRxU1BZcFl2cGFSMElUMVR2aXN5OFgx?=
 =?utf-8?B?Slp3ZXZZQm9zakN4TjBjS2VCdEZyS0ptc3pDdHJNSUc3WVljUGRaSHdOSmVF?=
 =?utf-8?B?NlRmWUdnbWhnTHBTNzV3V1dxalNoZ0VYRjZiRytRZHJ2S09QcG9yM2wxdk9w?=
 =?utf-8?B?Uk83Zy9TemtNSFVDWHJpT2M5TldwMk9Fb0V6T2Eyc1g5YmRtbzhhY2hNSEF4?=
 =?utf-8?B?SzAvd096MFBndG1RMXpPanJKNmZMZkxJbU9ZYjRtdk9pVVJ1Z2F4V05jL2F5?=
 =?utf-8?B?UVk0SlRTTTd0QW5xVlFtZ0FCMzRtRnFjY2VFQm5oVVI1WHk3VkVndDlVN1Ja?=
 =?utf-8?B?SExGUzRZdVRKbDVCREJrRGUvQ3hHL09OTHpHNk02cDUyNlZXZ3BURUU3VTEv?=
 =?utf-8?B?MXh3RHVtZTA3SVJqMWY4RWZlM1VZUXkyYkt0U05zYXdTZ0VIcThvSHNURWYr?=
 =?utf-8?B?aGJ2ODhaek5wTHFCblNsV1lqc2NyTTlObmtCT2JIYjFmTnFlTGlUK2ZJZ3Rj?=
 =?utf-8?B?WjRYdmRVT3Z5VVgrZTA0Y0ZNWWF6R3V6OTBRSGYxS0xZZGk2MjR2QlluUWE0?=
 =?utf-8?B?VjdOamkrdjhCb0dsbUJRZ1JnbGtvQlJTMnNNOUFEa2pPWEt2MjB3SC9ZU3dL?=
 =?utf-8?B?WGpablMvMmROWWdyWlFwTDRoaDhXQi9BdzNEQklYdHJ1UG5JTm1aM05VVThS?=
 =?utf-8?B?RFlvMTRvL1RMUGtycThrY0NsOXg1MGQ1bGhkYlhIVmcwdUtyTEljQXlnWVhs?=
 =?utf-8?B?L3c3RnYwQll1NXdrd0U1NVhPVVJPeWdRWnFyU1Q1c3FQdGtYYlhLR2g1R21q?=
 =?utf-8?B?bXhtZ1dDMnkzZDc3MmU5MEQ4YzVYSWlHUVU2VWFEWnZ4Z3BGblYxcmd0T1ZJ?=
 =?utf-8?B?Zk0zdmFraTR5VzhqbmsvckRZblNXUDQzOW95eSt3MjU3cnFGQm10LzBFODlx?=
 =?utf-8?B?TlFxWjl4TUd2UEJsZ0NPVGhUSTdZSGswZEZIdTFmaXN2QkVodllaT0hYYXI3?=
 =?utf-8?B?NHIwSXhwRjkwdEtCRXVIa2JoN2VVY0M1SzV1enNBVWdMczJQYUZVbkN2UWZ1?=
 =?utf-8?B?S1lJZlhFSFY4STB2cW5ZRDhJVXk1bTlQZS9BZFVlQ0Z1MnZ1SkhpWFl3MC82?=
 =?utf-8?B?YXRQcVZEZzZDN0hKVzA4MXdTTUk4dVZOUmFTY0t2NW9tNUtPd2pWSDQyTC9N?=
 =?utf-8?B?ZDNnRmFUSVZ5ZlBGRHVoaFVhMndVbXNMVTMzQjF1eEdwWFZWc1FUVmI3U2hZ?=
 =?utf-8?B?dTVhVStockdvY2krSEg2SG55Y0NYSnQ0UmQ0Z1Q0V2sxdi9hb1EyaDVTOTUw?=
 =?utf-8?B?M0FxOCs4ZnJVcVBTUy93aU5hMk04UHlZTmlUUytXQllJdlFzZ0VsVXFtaFlv?=
 =?utf-8?B?b04zMTFxYWdTdjhuQUM2Z0lxd0RjZ2V6OTViT2RBdi9KZjBOenpiTTdFT3Br?=
 =?utf-8?Q?ic5Nl/PFdYHOa9TYu1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca6ca5e-f439-4453-40fb-08dea208ba98
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 13:52:30.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxUKk32fKsC58bq42qcihfsf68Jtzl3t9rOKhuRXNyeTjg0hwK7eW7Q9s+fKtkkQKBLF3X++z+a+SOdJh/aDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434


On 24/04/26 18:25, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 4/24/26 14:10, Sumit Gupta wrote:
>>
>> On 20/04/26 18:37, Sumit Gupta wrote:
>>>
>>>>>> On 3/17/26 16:10, Sumit Gupta wrote:
>>>>>>> Add kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>>>>>> CPPC
>>>>>>> autonomous performance selection on all CPUs at system startup
>>>>>>> without
>>>>>>> requiring runtime sysfs manipulation. When autonomous mode is
>>>>>>> enabled,
>>>>>>> the hardware automatically adjusts CPU performance based on 
>>>>>>> workload
>>>>>>> demands using Energy Performance Preference (EPP) hints.
>>>>>>>
>>>>>>> When auto_sel_mode=1:
>>>>>>> - Configure all CPUs for autonomous operation on first init
>>>>>>> - Set EPP to performance preference (0x0)
>>>>>>> - Use HW min/max when set; otherwise program from policy limits
>>>>>>> (caps)
>>>>>>> - Clamp desired_perf to bounds before enabling autonomous mode
>>>>>>> - Hardware controls frequency instead of the OS governor
>>>>>>>
>>>>>>> The boot parameter is applied only during first policy
>>>>>>> initialization.
>>>>>>> On hotplug, skip applying it so that the user's runtime sysfs
>>>>>>> configuration is preserved.
>>>>>>>
>>>>>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>>> ---
>>>>>>> Part 1 [1] of this series was applied for 7.1 and present in next.
>>>>>>> Sending this patch as reworked version of 'patch 11' from [2] based
>>>>>>> on next.
>>>>>>>
>>>>>>> [1]
>>>>>>> https://lore.kernel.org/lkml/20260206142658.72583-1-sumitg@nvidia.com/ 
>>>>>>>
>>>>>>>
>>>>>>> [2]
>>>>>>> https://lore.kernel.org/lkml/20251223121307.711773-1-sumitg@nvidia.com/ 
>>>>>>>
>>>>>>>
>>>>>>> ---
>>>>>>>    .../admin-guide/kernel-parameters.txt         | 13 +++
>>>>>>>    drivers/cpufreq/cppc_cpufreq.c                | 84
>>>>>>> +++++++++++++++++--
>>>>>>>    2 files changed, 92 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>>>>> index fa6171b5fdd5..de4b4c89edfe 100644
>>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>>> @@ -1060,6 +1060,19 @@ Kernel parameters
>>>>>>>                        policy to use. This governor must be
>>>>>>> registered in the
>>>>>>>                        kernel before the cpufreq driver probes.
>>>>>>>
>>>>>>> +     cppc_cpufreq.auto_sel_mode=
>>>>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous
>>>>>>> performance
>>>>>>> +                     selection. When enabled, hardware
>>>>>>> automatically adjusts
>>>>>>> +                     CPU frequency on all CPUs based on workload
>>>>>>> demands.
>>>>>>> +                     In Autonomous mode, Energy Performance
>>>>>>> Preference (EPP)
>>>>>>> +                     hints guide hardware toward performance (0x0)
>>>>>>> or energy
>>>>>>> +                     efficiency (0xff).
>>>>>>> +                     Requires ACPI CPPC autonomous selection
>>>>>>> register support.
>>>>>>> +                     Format: <bool>
>>>>>>> +                     Default: 0 (disabled)
>>>>>>> +                     0: use cpufreq governors
>>>>>>> +                     1: enable if supported by hardware
>>>>>>> +
>>>>>>>        cpu_init_udelay=N
>>>>>>>                        [X86,EARLY] Delay for N microsec between
>>>>>>> assert and de-assert
>>>>>>>                        of APIC INIT to start processors. This delay
>>>>>>> occurs
>>>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c
>>>>>>> b/drivers/cpufreq/cppc_cpufreq.c
>>>>>>> index 5dfb109cf1f4..49c148b2a0a4 100644
>>>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>>>> @@ -28,6 +28,9 @@
>>>>>>>
>>>>>>>    static struct cpufreq_driver cppc_cpufreq_driver;
>>>>>>>
>>>>>>> +/* Autonomous Selection boot parameter */
>>>>>>> +static bool auto_sel_mode;
>>>>>>> +
>>>>>>>    #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>>>>    static enum {
>>>>>>>        FIE_UNSET = -1,
>>>>>>> @@ -708,11 +711,74 @@ static int cppc_cpufreq_cpu_init(struct
>>>>>>> cpufreq_policy *policy)
>>>>>>>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>>>>        cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>>>>
>>>>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>>>>> -     if (ret) {
>>>>>>> -             pr_debug("Err setting perf value:%d on CPU:%d.
>>>>>>> ret:%d\n",
>>>>>>> -                      caps->highest_perf, cpu, ret);
>>>>>>> -             goto out;
>>>>>>> +     /*
>>>>>>> +      * Enable autonomous mode on first init if boot param is set.
>>>>>>> +      * Check last_governor to detect first init and skip if
>>>>>>> auto_sel
>>>>>>> +      * is already enabled.
>>>>>>> +      */
>>>>>> If the goal is to set autosel only once at the driver init,
>>>>>> shouldn't this be done in cppc_cpufreq_init() ?
>>>>>> I understand that cpu_data doesn't exist yet in
>>>>>> cppc_cpufreq_init(), but this seems more appropriate to do
>>>>>> it there IMO.
>>>>>>
>>>>>> This means the cpudata should be updated accordingly
>>>>>> in this cppc_cpufreq_cpu_init() function.
>>>>> In an earlier version [1], the setup was in cppc_cpufreq_init() but
>>>>> was moved to cppc_cpufreq_cpu_init() to improve per-CPU error
>>>>> handling.
>>>>> Keeping the setup in cppc_cpufreq_init() helps to avoid the
>>>>> last_governor
>>>>> check. We can warn for a CPU failing to enable and continue so other
>>>>> CPUs keep autonomous mode.
>>>>> cppc_cpufreq_cpu_init() would then just check the auto_sel state
>>>>> from register and sync policy limits from min/max_perf registers when
>>>>> autonomous mode is active.
>>>>> Please let me know your thoughts.
>>>> FWIU the auto_sel_mode module parameter allows to
>>>> configure the default auto_sel_mode when the driver is
>>>> first loaded, so there should not need to check that again
>>>> whenever cppc_cpufreq_cpu_init() is called.
>>>> Maybe Ionela saw something we didn't see ?
>>>
>>> AFAIU, the concern in that review [1] was about error handling as the
>>> earlier version disabled auto_sel on all CPUs if any single CPU failed.
>>> Per-CPU error handling in cppc_cpufreq_init() (warn and continue)
>>> addresses that. Can't think of more reason.
>>> Do you have anything in mind?
>>>
>>
>> Actually, one case where cppc_cpufreq_cpu_init() would be needed
>> is when CPUs are offline at boot. So I will keep the setup in
>> cppc_cpufreq_cpu_init() in v2 same as present in current version.
>>
> Wouldn't it be possible to loop over the "cpu_present_mask"
> as you currently do in cppc_cpufreq_exit() ?

On ARM64 it works since registers go through PCC/SystemMemory
which don't require the target CPU online. But cppc_cpufreq.c
is also built for RISCV, where cpc_write_ffh() uses
smp_call_function_single().
So setup in cppc_cpufreq_init() with for_each_present_cpu() would
fail on RISCV+FFH platforms when CPUs are offline at boot.
cppc_cpufreq_cpu_init() handles all cases naturally.


>
> ------
>
> Another issue about relying on "cpu_data->perf_ctrls.auto_sel" in:
>
> """
> if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>     !cpu_data->perf_ctrls.auto_sel) {
> """
>
> is that the cpu_data struct is fresh memory coming from
> cppc_cpufreq_get_cpu_data(), so it might always be 0
> I think.
>

cppc_cpufreq_get_cpu_data() calls cppc_get_perf() (added in [1])
which reads perf_ctrls including auto_sel from the HW register.
So, cpu_data->perf_ctrls.auto_sel reflects the actual HW state,
not the zeroed kzalloc value.

[1] https://lore.kernel.org/lkml/20260206142658.72583-2-sumitg@nvidia.com/

Thank you,
Sumit Gupta



