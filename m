Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EBA456DFB;
	Thu, 17 Sep 2026 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629249; cv=fail; b=lPaFu6xLnNRR+P+1mJGRj8ZY0Y92JkkQl7l2Ad6VjmWOth8W9gXqYsDaojqC/XIaoZCqCg2XGgN2ybeNC7qQifacubLUiBFu9ofohgBhDFyJI6TeLbWhn12Kv9GW2tBwBZSCV3uxodD+MmNPqA/nuVvhEZTdeLJHY1k9BmSRAj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629249; c=relaxed/simple;
	bh=q2CEg8a7/NbQZLap222XhC3lUC7CYoG03T9J8L3i/Lo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t/un54KV//Mc/vq8NUKTC2jsNLBw4zvKddJwHxAGrjj6mh9rloMzJ/NORr9REFVbcbb8SjRpk3hXa4tU6aWt4NXlqhQ2yAVY0v93T97+lT8xxzukZCgiipLcoZ9Qp79JT7ZH/Crj0aEmUBq+yWBMu8M1lUBf1vSkN3dotZ4v/HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ulccKT7p; arc=fail smtp.client-ip=52.101.43.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ulccKT7p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvBfEuOnLEg+00wESQDV1gMe9m/dBpAj28i0kn56mIcr+kt3qWuhinxHn1XyhILtKTe1mN78fZGK2t7WvkJmvk5lFVqlLnxMB6Xe5h/b8iGwzgRWC5nzonI9RL32j3L2kz66p3lyvmxMeaCxouh9DqOLqwWLrNW7ymIzOTL0ABJwTyuiFqvHsWglU/Aii4pYXqQo2F4evVBDCAK3hfVzAsG6bX8lxmL5joXBLl9DjGEQab6B+mZghQqdG935UUOsFVcvlM9JtZhaDPZ6tEpLAxY07xZCnwc+2CPSRonlK4vl1Rb3OheHtLdFunHx3GBDBN9jPHtvT3SeWU8UjzgxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POWwJhvI0bscYH8VZ3hlzKcrRyQFiJf4hUl6XKn1iBo=;
 b=oRZyMTYY1yshVV86kcwQvT24ra3AdUbbZSAVwK7pPAhAx+NSzY8RhUWwNQTjNrtjE1w/CtGx/nlikDFSMLUVXcBjyoa0tF2NVcAGf9Ljj865DhAhfpP/uwhopHx9wLOb7D8obh50DrTTPf+nnKeeKDKnJLSpbft84IFxddgtiDIK4TqaHZVKhnjXlKBjK8ORvnPsV9aznYLvgvnkdCB5s/g7O7bdGnZ8dBb/+c39y3+dH4uc8mbvLon37Ma4cFGQ7tSFkyLsGlBSzuNNO5yiHYTE0wO8fprV8dXosfRBUlZMGKZVVk1nKn1e32lJZ0ZT8Qptdchk2S1fonTudZ/3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POWwJhvI0bscYH8VZ3hlzKcrRyQFiJf4hUl6XKn1iBo=;
 b=ulccKT7pOLHOgUixVmu8Pd7h6BLDWROKa76qiWUvBktVSAjg1sie0DKzBZBTdUMTDAzLD2UBB7u94kSHUZ8jfa2cRfzwZUa+FdeOXxfzX3Op576MLYtmKPHwWxGVU8x6Ivge6LPnViNNxvLZv1OQ9q56PR3f073O89mCujsqb+0E6XSVkPUT7cxn1GiRwAZhU0Z5nQSr3tIpbOmzafudn53gPQLb/sAa3c5p4OTAEPDN5EV1vLk4IpwxYlEhiy0QuD+kUnXgvT+8ctRtw/fSqnBnBwoaC9ujST/VlhqQxNPmmpfYeSacHAW2dx6X2Wa+b7FhmIWrhyjT65Pkc5w6Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 07:14:04 +0000
Received: from DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485]) by DM4PR12MB5246.namprd12.prod.outlook.com
 ([fe80::9c9e:30a1:5456:c485%4]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 07:14:04 +0000
Message-ID: <a8cc9844-cae7-4e4f-9264-98fe072b36e4@nvidia.com>
Date: Thu, 17 Sep 2026 12:43:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] cpufreq: CPPC: Preserve OSPM-set registers across
 hotplug and unload
To: K Prateek Nayak <kprateek.nayak@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, christian.loehle@arm.com,
 ionela.voinescu@arm.com, zhenglifeng1@huawei.com, zhanjie9@hisilicon.com,
 lenb@kernel.org, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260916103820.1760297-1-sumitg@nvidia.com>
 <97c3140b-071f-4c4a-b42b-d84b6107017d@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <97c3140b-071f-4c4a-b42b-d84b6107017d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0249.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::9) To DM4PR12MB5246.namprd12.prod.outlook.com
 (2603:10b6:5:399::17)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5246:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a5dec8-dda7-4120-269f-08df148b40ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|22082099003|18002099003|921020|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	YpM9kEottktic1t+Xmkg56zeXOP83yda07bbf2XJLepsBlqaf3vuMbS8dQddlZg7Q7dHwE9l5SRLgFiFPQ3cSV9tEwLojU6vGV8p9WfczDdTa7X4MTUtn9kJ2D5BpOYLRKBzK2SydfLLdBEYVr46gwKnpiYmqULW2YwXnuOraaCnyQ9NZa1jbyol6jWqFkyQp+FTvKxiP+hus98n7+COKUNqyhKGhLgrRNtiUT6BvOhoLTZOOr5i96MOhURokPYaZXwFM/LfIfmpRhvutpIF6als91QFVrTgKfnfimYo69ipkLm8Q2zeIZyFdINEIZI/KMa2EOjIfzMpLT5RO+aVg3hVp2R3lvYpUikSJLh5QaWsNBok/AYGJWVn/uD4OYhU9w+2d22jDlJmFreiACgUfIk0ghl2b9QZj8k991cKonoHTIqeoD/utxmp5itH+/hb8GeLL1+GimF3RN/YfjVu8LQxaAT5DO3T/jCtNbpkGIoKkMcp0qzG9L+c8DFcYrOIH3ZLrkV0OZcRjXnZYJtCZzujnVqWdNBB1NSUjTJBDSuhBfdLK3zKjk2/lZQkV45rq/qOrQ2xtl8Td+QY+q3MdvGMqY59dC+HuFaGXkjCVlFXH/J0GUUzI4ZiNqTzEUVR0R/Bf6LyKPGf8qEaBaMq7AA4Qu5wYOdE7r3R9mVcmqX6ePgCyfT9sVNCMKCWY8vOm1g7EqYPl08OA0bKPhky2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(921020)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si85Mm1YenplVGJ0ajdXKzFNSHU0U3B0WGlkdlhZQmlXK1VHNHRZY2FxbklV?=
 =?utf-8?B?TU5lejlRbnBRVzgwZEZ5R1BPV21QcWgySE8xV0YzVlRiU2QycU9GQXp4RjNP?=
 =?utf-8?B?OUFxMTBOdC83enJyeGdkaFFTS0pWS295YU5TNzIwc3QwSVpDUERtQXlvUlBT?=
 =?utf-8?B?R1poQSs1YjNLRVREWFg5RWRKVkkxRk8vMHJkelZIQzZYNGU1UHRBVHp4Mnpm?=
 =?utf-8?B?VGZiVVRJeDlZT2h3aHdEcXh5TFlJcXkwS0lEYTVEdllSNUVwVVpKb2pyNENy?=
 =?utf-8?B?NndwWVB0Ymxwc0dQSjM5ZjVITnExR05KNU9vU3NaMHZDV2tGQjRoUUhvZjJI?=
 =?utf-8?B?NHV4UUlUMGRSR1cxdHBSV0dPc2NmSVFyTlAzRDI4NXhmMkR1SHMvVXRhNU5U?=
 =?utf-8?B?MThWNWhReER5WHZ2dUJUdnNBU0xnVjJmVEZvZUtxdUxUZzZjQmV4T1ZIcDZF?=
 =?utf-8?B?KzdFOXpqNzZkSk1HQUw1dVpkMFhTbWtEZHBGbno2MWpWekV6V1llK3lpcjlD?=
 =?utf-8?B?VzlKcHF5VXdsY2lkdTc3U3hvSG5VZ3FEd3RtdDBnR0I4bHFwYW1mZ0Y1bGcv?=
 =?utf-8?B?NUJzOWtyd0MyUnRFOVk4OEFDbENsQ2U3WW1LSVovTTVJKzlTR09ydlFqT0hX?=
 =?utf-8?B?VUtGY3Y2TTcyZm9BU29Vb3NqNTNWUS95b2lzSWp4V1ZHMGVndTFDMlBLdU5S?=
 =?utf-8?B?Vis4U0JtTWFaVjRKUlprQnRadGcvUWJGa2R0UTJ1ek44c1VVVVRKYldJL2ln?=
 =?utf-8?B?TkRQYk00Zk1DWEJwRC9ncGhlZG92T0lKQUliNnR6RlBOQU0ra1dZRkxkaS9V?=
 =?utf-8?B?eGJOaVNBWTNkWXo0OGFpS1BJRlQxb0NYckN6eFlrdEZYSGNKT1VQZm5aOUpn?=
 =?utf-8?B?RHlSdlowVFhNSGZ1bkF6RkxweGlhRGkrdlVEOXo1S3RoTkNCUkkwai9VaSt0?=
 =?utf-8?B?SHJLd0g5d2RUdmMyODhzcTJlakN4c1RocUUxTUw4bHArSi9meFdUS01DeGYy?=
 =?utf-8?B?WGZ5c3FnUE0rSENxOHlLU3pRV2xHaGd1U2o3YTJYS2hiUHBkRUVQa3NUNk5R?=
 =?utf-8?B?czdSaGJuN0Fkcll2RkRKOCs1Znc0bm0yKzdTaEhIQmdWc0dQNWd5QXdMcGJ2?=
 =?utf-8?B?YTJQTXBaSndlM3RhRTJpbDJrdlJqOUZ1dUF0ZDFzaHg1enZRWFJWSjBYdUQx?=
 =?utf-8?B?TWtHOVJyeXhMWWtRd3EzeHRNckF6MWw5MFRTRzFmSGZodko5cDVjR3J0Nmh0?=
 =?utf-8?B?VkVhYUZoWmcxT3VXdWFvWmVXK1JFYUppUitWN2lGK2o3c0NZRUxOVHNZZFpp?=
 =?utf-8?B?NllmQlorVU15SkNCOWU0WEFIdllKcm00OGhsYnQxTGoyMDREY09ZM1FyaVNa?=
 =?utf-8?B?dktoK3NZemVDclJVQnJySXR1Sjd1RnpCSEMzajl6VkdnWXBUcExCTFcyaUZ5?=
 =?utf-8?B?Z0lXUTBnaXJ0N0E5dDN0bjVJTVRMN2EwK29tV0NpS0sxOG5FOENyVWdwZ3cz?=
 =?utf-8?B?NEZWZHA1VW1aa2hmU2xzaytZUjF0NHRUb3B4YnpYdXprNGpCK29INzVKODN2?=
 =?utf-8?B?bkhvdlZneUpheWRmL0dUNEFNanlyenZTMVlPQVNIRkxhbTZwbWtteldnK1FZ?=
 =?utf-8?B?Y2J6Q3pNSnpaRkxrd3E5b1lrbVZyZGJUZGJYN0JwUlhlQ0d0N2Q5eXAzME5R?=
 =?utf-8?B?NWlVNW1yQmJmK3h5dnpMcktmTitwU09FbHY4cS94dXV1Rkhid0EvRWdOZndR?=
 =?utf-8?B?Z1QwY2ZuWkZRMHF0dmJ4VE1NbWhsVlc1QXBsczZVdEVldUdiYjMrUWxCMXpE?=
 =?utf-8?B?V2dVRVZUOC9WTVdDb0JUM2Q0TE5BWDZyaUkrVEhsblRha3JkeHBNRDdmS25M?=
 =?utf-8?B?U0NIbkZtTXc4VDhnWHl4Qm1nQjhHaTFHMkhkdERVdjVaMU8rSDZIa2lFTFUy?=
 =?utf-8?B?QXZQQlRKSndHcWh6L2NJSE1kRnJJNTBiSTV6WUZHYUlmR0dYR045ZW5xZDhs?=
 =?utf-8?B?ODRwbXlmVk1IUGs5VW85UTRFOVVydGVOcVR5enlYTU9adWdwUFROcUQ3dGRD?=
 =?utf-8?B?cXJtSk9USlFIOFVJcDE2dENYZUQ5Q1hCN3FCdHcvSXRYTE5ucVN0N0lTRWhj?=
 =?utf-8?B?SEV0QW1iTmJOanlJemlaMTZqcTUrRDB2UHdmR3JhdlVTS0tBc1ZBckVvYlcv?=
 =?utf-8?B?dTVjaFdsUjVjd2J6Z3h3Zkcwb1Nab3hlamdsTkp5VG1XSk80cUY0ejViZXE2?=
 =?utf-8?B?cVRlR293ZDcvUUdvTk16VkpBUndXdG1RaXo5ZCtPODkzcVNua0ZpVFN2aGEx?=
 =?utf-8?Q?Rf+usSK+UqIDinItKg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a5dec8-dda7-4120-269f-08df148b40ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 07:14:03.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5P2+Ftcl0gZxPjFD/zY6rz4fMSkuUpXZ02S3EwiSZC0Tlhel6LFyn37uF+lH6qzdDPLbONpN/GefpVVnMZn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015



On 17/09/26 00:34, K Prateek Nayak wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello Sumit,
> 
> On 9/16/2026 4:08 PM, Sumit Gupta wrote:
>> This series keeps the CPPC cpufreq policy alive across CPU hotplug and
>> preserves the OSPM-set CPPC registers (Energy Performance Preference,
>> Autonomous Activity Window, Autonomous Selection - set via sysfs).
>>
>> Without online()/offline() callbacks, the core tears a policy down when
>> its last CPU goes offline and rebuilds it on the way back, re-reading the
>> CPPC capabilities each time. The values written to these registers can
>> be lost:
>>
>>   - Across CPU hotplug or suspend/resume: the platform may reset them
>>     while the CPU is offline.
>>   - On driver unload: the driver-written value is left in the register
>>     instead of returning to its pre-driver state.
>>
>> Handle these with:
>>
>>   - Patch 1: adds online()/offline() callbacks so the core keeps policy
>>     alive across CPU hotplug instead of tearing it down and rebuilding it.
>>   - Patch 2: makes the autonomous selection register helpers take a u64.
>>   - Patch 3: adds a table-driven mechanism that captures each register's
>>     firmware value at init(), restores it from offline(), and reapplies
>>     the OSPM-set value from online().
>>   - Patch 4: extends the same save/restore to system suspend/resume.
>>
>> v4[4] -> v5:
>>   - Patch 1:
>>     - offline() stops the frequency invariance updates and online()
>>       restarts them, replacing the resync that raced with tick. (Sashiko)
>>     - reorder the functions to match cppc_cpufreq_driver. (Jie Zhan)
>>   - Patch 3:
>>     - reapply the OSPM-set registers even when the performance control
>>       write fails. (Sashiko)
>>   - Patch 4:
>>     - suspend() stops the frequency invariance updates too, completing the
>>       patch 1 change for a policy whose CPUs stay online.
>>
>> Sumit Gupta (4):
>>    cpufreq: CPPC: Keep the policy across CPU hotplug
>>    ACPI: CPPC: Make autonomous selection helpers take a u64
>>    cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
>>    cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
>>
>>   drivers/acpi/cppc_acpi.c       |  20 +-
>>   drivers/cpufreq/amd-pstate.c   |   2 +-
>>   drivers/cpufreq/cppc_cpufreq.c | 378 ++++++++++++++++++++++++++++++++-
>>   include/acpi/cppc_acpi.h       |   8 +-
>>   4 files changed, 381 insertions(+), 27 deletions(-)
> 
> I was able to hack the Kconfig to build cppc_cpufreq.c for x86 too
> and test this out on a Zen3 machine that uses shared memory based
> CPPC control.
> 
> FWIW, I could verify that "auto_select" and
> "energy_performance_preference_val" persists correctly across an
> offline-online cycle on my system so feel free to include:
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> --
> Thanks and Regards,
> Prateek
> 

Hi Prateek,

Thanks for testing on x86.
I will add your Tested-by to the series, and Reviewed-by to patch 2.

Thanks,
Sumit

