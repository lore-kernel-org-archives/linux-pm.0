Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC01A6811;
	Tue, 28 Jul 2026 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199669; cv=fail; b=uHhsZqT38R8bj9IneC7IPaNrU8ms/MLz3EAfI0aBI0ynqB6efNE0uDdBb8WVnAppsloJp/T03RkgcRbSTo2M0X9CoBfvbwWY+Oja1eY93TWdstfobUFR2USCnSCwbnwDA83Uisy7D3eSsLJhdC2Cshb0Dk9hfUrQWQiYif9kAgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199669; c=relaxed/simple;
	bh=ZpTGObf8rUSlhS4lkliwZelWhSxVQX5rDSKprqU8ExY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j4m/VKs4fOB+SV5gZvt8cqvcbNiFd3ECpaX2BdyUou5yWXj4lMBuqaYwhdbEyhZg6vydMYCiGNlpw+X0ZUx64A+UW2XGP2KKEpcWoQChnyXp+YnNouVl6iwDJQiv8f4/tzobE09x9aieL0O8zq2HcJepl1firvMgNHDYrMiOfSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W8rS1LqW; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W8rS1LqW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7MkDTtiwBKxc8IJ+T3Xp58XmKhQC7uoDmtoRlK2wmfYf1U6qLJ1+InRhy8Dsj2CpBOlkHACU1ZRoYLeM5rOGf99KMrfQXFIfjtT5ICVopFpGmh7r6DmsD5zLeEwrRAoV77SILLaKm7Hu6LTUdaS0nrp00/FGmg00zW91jKV1HlFgYLvsedhUnq1r7kbPQjJerwJDedeY6ZI5OopkQDwoUR0nRhBpPwm9Pci0Xknp00VErteLwg5hTXJSlc+l18ttkv4ENfcPhoEiawxbifS/4aYnZFzvtVfNcX9R6mfZF9txVTd8Gt6xSH2wuJmWek9qT6wP8kKnFyAxEsMclwyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d438Lngub5sZP69PdqDTItybzfIZiXycWYLAmQpcYuE=;
 b=clpahxfFeTJ60qeqwETy9l/hVtk1cNoXbFIHliMOB/M2nDwpUM7I1OMjDo4c+cp0hC1fXseT6PUWGBhFf5gCXMiRIzChUZ1Grnuu2PzIWm/mLebU2eh/tU8TNaMNz8XD5a7fRSiPGY8EvqOqbzDg8J3FYtVoTcIBSiJ1iR2hr+lryn8Gc3DJtbM6GV2NpxaqRMQDEa7VUut/ypvBkWtZT8YtPuIQ9kZH7JS6XHfBSF3xYsaSVY0y+fNT1FVidNnOOz4U1lC0zhqCVbrrwMaTXcu0jUFbRoTkpAuTD8AWWrj/HSoK5/R0GXqJROGiaQ6cn9NM5CH4TN1Z2l7z4H46wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d438Lngub5sZP69PdqDTItybzfIZiXycWYLAmQpcYuE=;
 b=W8rS1LqWyrXtmJxCrmH5KMRE9pi1DPJtUODH38Fu3diDf0ptMc5h4KDXda1iXtHmcAQzPQ7QH2knobmgFmEM6shxVzzOEOBiTxuYMosSAa32xzQHJsynfm2rMrhGnxPv7RzQb4kXcvS4FFg1MliUnX1YgKX1aDc7xmg1vxQUyhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 00:47:43 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 00:47:43 +0000
Message-ID: <4f4595f9-943f-4509-93ec-484746dce126@amd.com>
Date: Mon, 27 Jul 2026 19:47:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cpufreq/amd-pstate: BIOS min perf fixes and
 Dynamic EPP rework
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Kalpana Shetty <kalpana.shetty@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0206.namprd04.prod.outlook.com
 (2603:10b6:806:126::31) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e1bc48-038f-476e-e395-08deec41d557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0qvsnHy2ilkzJB1zo1A+TiBZ8DdtwYpIIYTrHENauIVatTeMYB2P39O377YYqne/BAdu7vVO4jmi25QYuZZ3PJR/EwhAr7JsII1xx6+cUO8hUSA1eTBs8jFEqDMuEI5+sNnGMc/dwclCb45LpFJF4q2d8D54MNsXtFb4un5E6jjl/dWELdYXSV4Qmj7KWfl+nTM3rXjmXuIBt3+RICnwZ8oDt5l5YIo/cWwa9SXVKUkWSNcyxo8olXt0LgThnaPxSlsWYQrYI63dL1cfmzf7qXjuB9bzklNOfLmQPdiGPjwkOv3B/T4ZKgrxG/KoOBYp3TqED/ULru2eBm6XCDQ4+8UAbZMx4EqNVKs0A7676XvwzAO0EO9yKKmnniLWjhYfd74aa4y/BuOzycOqeUP1aqdZ4BMzqJwGtdK/Eu5nHgznuu6ZPf7Z1XR+70EWLl+TOyQGOAJ08ikJhw2qlTaJDOOhKDwuFr8d5xoLwLBVtkNMJ+eaUYrILhyLV5yrP1NeNPjAVRPkvYBBU1ztKnnaKY1XaXGOZdR8oWxgD9t5BtTqoxlKfaSpYrJzddxt9IjSzXoXcDM1rmf+QELlTV50a8qcLr67SkZMgqxutHZA9+n31l0RolMDcVJx8Er5PUwG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkZmenFCZ2NLbUZkNlI4MWlxRlE3TmFzZkhiNmpWWW1oUXN1dkdqcFNBTHMy?=
 =?utf-8?B?aUlLQXlrVjkzRmxaZmxqUzdVVTZXdjQxVEg1SFlzak9ZNkd6Mml5NjlSR3JE?=
 =?utf-8?B?WXd0dm5tWDdJdnVPQVhYbHpuZko2bXFybVVXSU5HZHRUZkxWTmZudmhON25K?=
 =?utf-8?B?RFBCSmQ1YmlWRUxoZGo3UlE4R2tmU1JYeURSamk5WUxTZVhMTlo3YUVuWERr?=
 =?utf-8?B?UFNtNGZFdFFlZXEvNXN5dzJVY1pMTlY4Ri9vUWVGSk5nMTZ1VHl1TmlNRnpN?=
 =?utf-8?B?dWNqTVNPR3hMeU0yY1VwK2RDVy91Ym5jeE9penptMGdpUHEyRVczQWUvRzhW?=
 =?utf-8?B?U1gwRk1vb3dOZFFPTUZTMUY2dmNCS1pTdkVFcTNZSURjcFl5cDNQaWUzbW1i?=
 =?utf-8?B?ZW1OWnBPZmhRUnlIbHNtUm1zZ0RKbHN1SHI0U1M3ZmJNOWxQc2NLcm43MEll?=
 =?utf-8?B?ekx2YmdBSkcwekhVZUE4SmpuQml2ZmROSEUvSHJqZk91YWt6aXBXbWo3ZzUw?=
 =?utf-8?B?ZHNCY2lqWlg5bFo1ekU0V2daWERCa2hmcndCUnpKVGxSenNFRE5XbnUzc01m?=
 =?utf-8?B?SHBVbStyZ2pNUi9DT2tUSzhHYVlreEFaRmtwTWdVYlBGY3lVTEo1TVlKanVV?=
 =?utf-8?B?RDA3MmZuMzhmUmMyMHdKS1U3ZENva0JEOGJYb3FWSXp6em9DSlp2bjdIQVpI?=
 =?utf-8?B?SmVCRWVxWllQWUtCWXJidzNyS2cyTi9yVTMwSjRFcWlsTlpHUU9VbjhLZDI5?=
 =?utf-8?B?VlNiMXRYNWNsTG5zVDVudFBhMmIvVGlJNEdObWJrdC9KOTFBVkNkU28vSGFQ?=
 =?utf-8?B?dXBMT0VmK2xsWFl2OXpYdGtpdHRoeTVNVklCMWZSOWxMdDdEMXE5Q1J1SWpo?=
 =?utf-8?B?clIyUkhnZDdvZkdBVUswMDlPMmFTQ0lReithdDVBM2REOXl5a1A0WVVGVHhx?=
 =?utf-8?B?VkhKNXMvOGNIc3gvVGlnMEN2U3NiM1RtZVdEVEN2T1FQWnNCSnhjS2JBKzFs?=
 =?utf-8?B?NzJ4Q0lDQXdJckpLOVZwK2EvSzkvWXhwYVU3Z0dZc1piNjYvL0FwdVVhUDY0?=
 =?utf-8?B?WlVuRXFWN0krSjdGM2lMeVM5RTVsc1JZZXNSRVFYYW9yYmMrSkdLNW5LTjJP?=
 =?utf-8?B?Z1dPR2Q5aWxuRjVkSHcyVXdSbWlzV1VNVis5YmpVOWc4eFRMRHdxaDdRZHhK?=
 =?utf-8?B?d3dqcW8vTjQva09WWFpNTnpzcVhRWm5vRHBzWllFZjI1WFhlNVhSekU1L0Vo?=
 =?utf-8?B?dk81V2hsVS9NSGlQZ2RETjhab1RhYTNtZWxmb1dTZFlIQ3FGM3kzblFvS2R2?=
 =?utf-8?B?cmhWYng0V1liS3VYQU4ySXRHUDQxNUFnbWFXNjVDcnJjaUpRMWxSenBsUlBa?=
 =?utf-8?B?aW5VSnJQd3NvVVVKcGJwUENYSUk2MVp5aE1xYTFTeGZpYmMxWE52YWkvLzRi?=
 =?utf-8?B?RWk2T25WclpCZmNhaTE2QUJ6R2N1T28rTmtqM0thOSsvYWtYSFp3M3paeGRZ?=
 =?utf-8?B?ejZuYVVvNSswR2RJQ0s1V1lvd3VwWldIMDRMSlhURFZDU2xDcmE4UjNHZVp6?=
 =?utf-8?B?aVY4TTJzbUNwMEswNzM0NVRVVzRabzB6aXFBYk1VS2I4allLWGZ1VFVRQ1dz?=
 =?utf-8?B?em9scng2aHBiY1dGL1ZzWFNibStzQmN0V3dMbWZPaTEvMXF5Z09ZbGZCRGJx?=
 =?utf-8?B?VHMyM1FGWFcwcGZxRXlzU0o3RkNSMWRyKyt3RHd0bVRlZVlCWG9zaVVGZDMz?=
 =?utf-8?B?U1o3TnJsUTcrN3luT0wxTWpCRkZscXVRWUZVV3Rqbkh4ZkxiVXR0QUxFai8y?=
 =?utf-8?B?R1crUVdUenFmMzV4aG1sWityVVlNZ3c2UDhTT2ZvVTZXNmdBdktzYWFsNEhM?=
 =?utf-8?B?blZLSThwM0s4WUhFTjVHS0dPUmxiVmJmbjBQNFhnSHhhQ2sxWC9LaFZNanRH?=
 =?utf-8?B?N21iUFlqdGpodWZDeTRXNThDNUlISEZndng1aXZoL2E5Y0lzQVdvRWxGVnRT?=
 =?utf-8?B?MlhwQnVrWFZ2ankxV1ZSTXd3a3ZxWmkyc3ZDbXJDMjdpRlc2MElWUTFOVTJC?=
 =?utf-8?B?LzQvcE1TZ3VTK1FlWGdhdHFRcEVKcDFnUDhmOEFkdVZ0SjlEWUdkeDgxOUp5?=
 =?utf-8?B?Sjd1b1NwcGx6ckNOekxIaHFMSWEwenZteTU5V2dKSnNSTEU0QUEwT2NGK0Vo?=
 =?utf-8?B?Zk02ZGZVL0NaUUN1QTRQQkZmUUV2UGRhejBwR3htWXdqQTFRSE4vSUdxWlNV?=
 =?utf-8?B?Kzgycy9VV0VyUEZGMXVoMkhvL2duRGE3SkRyNjRsTGg5VW9lS2lobmVpZ0lQ?=
 =?utf-8?B?RVZrbDQ0RHNDTzRqaHkxYXFYNUI5cndmNi9DMzIxczVCK3dMTVZzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e1bc48-038f-476e-e395-08deec41d557
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 00:47:43.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d561X6qRDhwZE5otw/3oiRDMB3YYQlxaSJebIS6djEs8G6Di0D4bhQTHgIXulHo1jl3ssVtLsF8HgjUcePL0WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146



On 7/27/26 02:20, K Prateek Nayak wrote:
> This is a follow up of
> https://lore.kernel.org/lkml/20260723201228.22584-1-kprateek.nayak@amd.com/
> with comments from Mario and Sashiko addressed.
> 
> Patches are based on:
> 
>    git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge
> 
> at commit 39c0cf62fc78 ("cpufreq/amd-pstate: handle missing policy in
> dynamic EPP callbacks")
> 
> Everyone has been Cc'd on the cover letter. Respective maintainers have
> been Cc'd on the relevant patches to reduce noise. Lists get the full
> series.
> ---
> changelog v2..v3:
> 
> o Ensure min_limit_perf is always <= max_limi_perf when adhering to
>    bios_min_perf constraints. (Sashiko)
> 
> o Fix the units in debug message to KHz. (Sashiko)
> 
> o Added a policy check for dynamic mode toggle. (Sashiko)
> 
> o Reworded documentation based on suggestion. (Mario)
> 
> o Collected tags from Mario and fix typos highlighted. (Thanks a ton!)
> 
> Some Sashiko reviews haven't been addressed in this series:
> 
> Mixing of __free() and goto was considered safe as long as they are in
> the same scope and programmers know what they are doing. (See
> https://lore.kernel.org/all/20260327152052.GJ3738010@noisy.programming.kicks-ass.net/)
> (The flagging was unrelated to changes in this series)
> 
> Kdump scenario for bios_floor_perf is ignored as (afaik) kdump kernels
> are loaded temporarily for debug and dumping out data structures that
> are preserved from last crash, and an inaccurate bios_min_perf during
> this process should be acceptable.
> 
> System profile notifiers do not grab the policy sem to prevent a
> deadlock with disable path. Disable path already grabs the read end and
> a pending notifier must finish for it to be removed. Since the driver
> disallows EPP modifications in dynamic mode, this is handled by the
> driver without needing to grab the policy sem in notifier handler.
> 
> amd-pstate-ut is considered a developer test and is supposed to be run
> in isolation without any parallel modifications to driver settings. As
> such, any of those concerns have not been addressed here.
> ---
> K Prateek Nayak (9):
>    cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
>    cpufreq/amd-pstate: Remove the defensive check for bios_min_perf
>    cpufreq/amd-pstate: Extract platform profile to EPP conversion into a
>      helper
>    cpufreq/amd-pstate: Add dynamic EPP as an
>      "energy_performance_preference" mode
>    cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp"
>      sysfs
>    Documentation/amd-pstate: Update dynamic_epp documentation with new
>      behavior
>    cpufreq/amd-pstate: Reduce the scope of exported symbols
>    cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode
>    cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority
> 
>   Documentation/admin-guide/pm/amd-pstate.rst |  45 ++--
>   drivers/cpufreq/amd-pstate-ut.c             | 131 ++++++++--
>   drivers/cpufreq/amd-pstate.c                | 251 ++++++++++----------
>   drivers/cpufreq/amd-pstate.h                |   9 +
>   4 files changed, 262 insertions(+), 174 deletions(-)
> 
> 
> base-commit: 39c0cf62fc7851a17782e7efe8dfb2948739c681

Thanks, I'll pick these up and continue to test.  If all looks good I'll 
include in my last PR for 7.3.

Thanks!
