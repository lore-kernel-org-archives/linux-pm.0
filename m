Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3132BE035;
	Mon, 15 Jun 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547829; cv=fail; b=k1JrTUKTXlcJYnXAQYHpruqGYLwP2AVkwShs6+Q3zrhaAhXTH3LAD7iOnG4nk11FDagZotGTY56BviUPbuhLghL0wsmWYHKBxeudxioHiUpeqD7cMKvMTybA8ajXWhKLVmd/5LFU+m+L/Ev6zx7npkBcNZ7zxZ0Zm6KEMlmIVo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547829; c=relaxed/simple;
	bh=hfBgI7hSCuVToCseqJje42BNS/qtsvMzVjfvwvbIojs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iohcjenC9iYAOYtkdTbSZcIH1dW+9vc8Z9uBZTV3a1DU7BlqdttU6er5yi+I3bqIfUjOmTaLAkJn5HHC7qmx3JFpGLSOEmgnILGBriuAAqoLB8CHvsXavnrzQiin1vmGDFqItPAtIKDwAQVqTth3gPq0MSH2l6WhTfC3jtAy35k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OXplGRgj; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OXplGRgj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrUjlIh3dKb8e5hkcJ013b/X+heZsm3CG9MvdccFZDTdjDAwwsNF5CKTedbq01dCSwBx82SxdLqzvYKuvgdP5UkeMjvEmFxWzXEHVk0OsbbhAPrSK/MEZv1pKCSuHtcnN3fr3JhE1RfcWqBcw4mzKWr7JsloR4qKj2TAZ0XZtdLGfET0rAoIowWiHkaKIUmbzdztYntPp2uQNIw+3FMKD0MIkqiDlyfdbzfyKUZaWHfuIYe2JWSkCsMjevcHS6krQAkdKW4wuSxnisqh4CfTSmLvmHGmO7X7GRmXVxMtmscoD9nQOeGpVcnpiqhmkHFyc/2XaAHGLx9adVXtPjeSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfBgI7hSCuVToCseqJje42BNS/qtsvMzVjfvwvbIojs=;
 b=J0BNuO8SR0lJW7Y25H8vvCdQSf2dtE1argsKWJ3zgju6zRdOsNN84bS9dO+I2g4Xg4a8bdCRIk70bqTiVxwrz4LYWwhuVaFAOtpEz9Fc0qgnmXywdM2c5zCG4J7I6vqBWT927/8UQGAMXnCeCZtMEyuiHwzXP+sX6ouYEh82l436Im+kUnspDB2iuKgs53jZRX7RZ+ktz2jNFujEJb7YFo+/zLe621U/taMIvt+fpsc4Mq7IQoqAvZDDC84YsM9ttGL0g/x6C1XbJjhR35icIXrK08rcnxY2lnVduWpcetNp/UHmjSjXFUCfGGjUIBd9P8MVVQ+DcAlA+fjoaKPPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfBgI7hSCuVToCseqJje42BNS/qtsvMzVjfvwvbIojs=;
 b=OXplGRgjE+mN+ApwrnG3yWo9vhebppvBVcELSyHynJfcHcapdNQPm9FJ8bTvtuRKET2YjNtHTBQU9Y127G6bFNV4YLqnlMVZKlWQlQxsGj3jwtVrZMGU55zFYcEioqHzghgMO9OQBeVNzUmhvDUjZHU0n5XGPYlI0chgolpv7/E35VvENhE45PRTKfZg1XzvwiuE1WuZvcfxgrZgkD4OM4wKTuPS14cpt1N+ryF0hNpRBWhwgBe8B3lPDav6ocTcoUBpGHcUUu2Zr83KDqSfgGXg2FPAlzJwEUI5bMIn2nj97cl2rAGO/n0Rqvf2lbi6X59Kr4K8PGA17qXMg3GGUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:23:42 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:23:41 +0000
Message-ID: <257d8e9d-16fa-4030-ae0a-aed7bf17b46f@nvidia.com>
Date: Mon, 15 Jun 2026 23:53:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org, sumitg@nvidia.com
References: <20260514194822.1841748-1-sumitg@nvidia.com>
 <20260514194822.1841748-3-sumitg@nvidia.com>
 <457972d4-eabd-4db9-8d82-b4c6a5f79465@arm.com>
 <5bf877d5-42b8-4e0d-9afd-6cb9c4b45bb1@nvidia.com>
 <86780f97-29ee-4a72-b311-38c89434b707@arm.com>
 <ad12ad81-5d39-4090-b53a-13480e85731d@nvidia.com>
 <37f4fe05-39f5-4e7e-9ca2-c9f5eb79ad87@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <37f4fe05-39f5-4e7e-9ca2-c9f5eb79ad87@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::6) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: a263e4ca-fa77-4f60-729d-08decb0b3a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|18002099003|56012099006|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OsiSsWDsbkc2bjdFVQLTq85DIiW8QTYhCglUmAN+hwFybDHTfc0DgRJTapA4oot6MlztXyGCs7PutExnvfcW8cUJciADMpsa8vNIJu/0AAsWTcst1QcAmmUHz3Lfqh3mzM8xCrzdbrL4WfdlvTFPPF2Tp4wqnsqwcg+Eh2iUl/mqdEzPEjm4d5lToD4C1M9BEYRCJL1mroWSwRk5xXeW/6RamVFh3mUUc4DocuSvkqRpIXtBd2RwFxRMZgnwPKm8pywXATJCUnYjRd0t7SvXxW2A4YSZORCRQuw3c3oipZAOV4Z2dqHkUjHERKxLTkNOLhgOevhBF83J+yJCvOEYcz1jWyRh2UMQg+AjImVvTkE4B5QJD0mzDFEGuZNMy/fxbmX8xclVpgdsvNZYOtFTictt8+68whlSpXIY0jqT5I8dyr7EEbYDRVucmBeT/wb5FylfhDG0yUN6ydBS2C42lSyKA82d4uPmrK+3YJSR5FEWtOPQjnI02/PA0Xjus7nPJQm2ATW3gv1op3hcVI8vc5WXEJLzgz9nTPNmrRUXVw4VlA7pG9rP8SS0Pk8MwY25Cy8xrQdVnPdpg2kzoZTuErMZVngW3OjusjBw9+ZUkpYK9Gp7ktRcejlinvmOpZ53Q7liJRyA7KrvIzHuY/GO3ULzDbjs2hMqVrpJnqjVqkSHyXQgbsOwYfgJGvUS3qGS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWhQSFRkaTQ4aDAvbjRidUtabk9adXVVWFBZWHNqeEdSdFNWRlNkbTdiQ2pU?=
 =?utf-8?B?ODNrRUxIR1k3Zmg1OGcwanFOUHo3RGpLdWc0Qkk3cEZVeXk4ZE1LTjl0Z0NL?=
 =?utf-8?B?MGNqMHRoOFZGMm5uT2xOMmx3REZ6aDBMczVVUzhLeTVxTlNUVjkzN1J6TUll?=
 =?utf-8?B?R0pxU0ZINDhYQjN3a2NUQ3dBSEthOHJ2NTRRUVBhWjdHRldaTU4zdFgwSkR0?=
 =?utf-8?B?NzBma1BtaSsrMHA2L3BrQk9XTU9pcU1vQk55ZGZmZmpVVEN6L2dmTGEzaDZv?=
 =?utf-8?B?Q1pZdlhHQ04xU3J5NDJnTUtyOVJidXJ3RUFpNm1nVVFGMUFnSjNncndTV0wr?=
 =?utf-8?B?a2hiVFpxMmxsbWp1dVh0bmUzRWI2RmxCdHBhNFJITnVVQjN3UnRjQVV5NC92?=
 =?utf-8?B?RkUxbkdqdFFEdjRIaGk2c1dubzZ3UkRmcU1GOUtITy9zNXJvQnRmZVZQYlY2?=
 =?utf-8?B?MjVqZHM4bVJTWlV1ZHFjdk0yNGVDZUdvZjNEUlZ6dWtTZGFkUEh4akgvakRr?=
 =?utf-8?B?VTJrZEF0K1pnZGlOSy9LM3RIdEVRWk5jd1JnUjZTUXY3YVNlZzNEQUNsUU9j?=
 =?utf-8?B?UUl1N01kWDJTY0ZsYVRGV2FqRzdlZVNJV25TZmxzYXI1V2VCUTNqUlAxcmd4?=
 =?utf-8?B?MG14TjRZWTB2UDliSHpxS0xOOGYzL3ZIRVZTaDZjOVhaeS93MHp5dHg1UVRK?=
 =?utf-8?B?YVlVbGRqRHM0Mlo3SDMvWTFDRm5hRTRBMU1uUTZ2d25Xc2Q2YWh3YWdydG5N?=
 =?utf-8?B?dFZmbXNWUTZlaDZXSjlKUUR3UTl3MmJUV2srNWd1aStRMnhxOEdvSkVmZDJC?=
 =?utf-8?B?cVZzUDBhMzlrbmZpVDF2R2cxT1lPM3dzdUhpelA3YmNMM2k2QmlWUWNaQlE0?=
 =?utf-8?B?cG9JS2ZJSmlNTTZveGdBVUhYVnJEejRjcG5aZ2VyQi9JUEtsUjdmbC9ERVRv?=
 =?utf-8?B?b095TEdRK1FNbjFvMks5Nkd3WUhnOG9YRWhYWlJQazFIS0h2ZDBkN2Z4V3oz?=
 =?utf-8?B?S3FDRzdCM2RrNkF5eElmenJQU1ZZSUs4b2cwbXdxVFp5a0liU1QyVHRkaEor?=
 =?utf-8?B?eU1oVFNwa0hrVjNNOWJGQ2tGdWNqdWp0TlNIN1lwMmNITjFBUk5SVmI5RU5F?=
 =?utf-8?B?VHdRdmNEQ3cxTTJyMlJscW1kUzhIUk9GcDZpNGVLUzRtUVNpTzVmUEZ6alpU?=
 =?utf-8?B?d2QxMXErTDRwcTNEOXNFZHRuYjhHc1JKU1VkTUgwSXNsL1FHV2lXVWRLeHkw?=
 =?utf-8?B?THdQN1B5TDhCSnNhU2VaeDVJUmJhU0QyaGxYMFNwVUh6elVvb01OMnYzMnQ1?=
 =?utf-8?B?RHRTNzRMV1RUR1cvOXRlUTcrcFo3UTZ4R1FyV3V2ajQ2ckkwbUFvSkRqK3lj?=
 =?utf-8?B?cUIzUHpSa2hSUUtzZmhqN3ZoeEFxUWVTVGdiSmd3SnZDUnh1WWFOT0wyZXpL?=
 =?utf-8?B?S2s0T3lqUzY0L1l0NUxoaWVWWGtzd1Nmc0dlTzFzakQ2a3JnR1c3MHJHcnh0?=
 =?utf-8?B?MHhOeWl3YjR1MVNNN2pEYWs5dzlKd1VJMzdqUEprVGxXWGFpVi9XQkxLYTRz?=
 =?utf-8?B?bXY4aEcvVG9wUWRQVEVJUDJsSU05ZW4rSm1CUDRGcGluNE5PbjRMUmlNRzJB?=
 =?utf-8?B?SHNLRmFiQlRUajBQKzJyajl5R1d1bytqR0hOTlZEWllSWGMwSEIranF3REJk?=
 =?utf-8?B?WE53Y0k2bzRkanJqZ3NiejlyVW5oQjE4MWtXcFdDWm1pREtDaTllNVdTcFFi?=
 =?utf-8?B?UmNBMmZDOS9QZ2tMdkFOcEwvblk3TDF6RGhmQmdhSWdldVBqUGNwOEtrNko5?=
 =?utf-8?B?T3k2SzdOWXl6RXBXR2YyYXg5R3BJOVdHTldEMEFCTDZqekpiRmRmdVBOanZV?=
 =?utf-8?B?cUZRWHE5eUo3RUZqRUQ4NTZiTTBCRGdrVzA3azQ4V0VtZGxVSk51QkFvR2ox?=
 =?utf-8?B?OGxaaU80NmNJL1Zha0pxdDliRGN5K2s3ZGowMUc1TnJsci9RQXBzQVRYVXMz?=
 =?utf-8?B?WEpGbWNES0p1Tm1IaWZzWStWUWU0MWoySmQ0eVJsZ3pnMEdPYytidHphQ0ZH?=
 =?utf-8?B?VVhuTzdpbk5RWEJOUEtGQWtsZE0vNGdnRlFNSnFmbzhpT1k2S2l3TlRENDlZ?=
 =?utf-8?B?RVM3ZGNBV0F1R2tIUDcyVzVCOUFjenRHSXhWaGI4Q0pvK01tUER0ZzIrZ09x?=
 =?utf-8?B?SUxQZXJTVXFwc3NtV1NuMVpvUVIyRkhsM3dZMHlwM1FhRHEwclRzSmZLdUdE?=
 =?utf-8?B?WHpXb2o3RlQ1cUhiY3RYcmxqVE9yRll5RDNMZUpsMUdMd044K1kyUGc0blNO?=
 =?utf-8?Q?mjS8TjYjt/gvvKHXXR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a263e4ca-fa77-4f60-729d-08decb0b3a35
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:23:41.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vnFGqpg6mLRS+61qczHOi8agAVv0YZU+h36wpQ0e6OvxE6nXkAuEKqNK9vkBZXU/KjKvp72H7WdNE3PRuyBmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

Hi Pierre,


On 11/06/26 20:01, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/9/26 10:53, Sumit Gupta wrote:
>>
>> On 28/05/26 17:37, Pierre Gondois wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hello Sumit,
>>>>
>>>> Hi Pierre,
>>>>
>>>> Thanks for the review and the complementary patch.
>>>> Going point by point:
>>>>
>>>> 1. Rollback for a partially applied multiple CPU write in
>>>>     store_ospm_nominal_freq(): Agreed, will add into v4.
>>>>
>>>> 2. cppc_get_ospm_nominal_perf() and the show/init/exit coherence
>>>>     checks that rely on it: I'd skip these as the register is
>>>> write-only
>>>>     as per spec.
>>>>
>>> NIT:
>>> IIUC having a write-only register doesn't mean we cannot read it.
>>> Cf. cppc_get_desired_perf()
>>
>>
>> Good point.
>> v5 reads the register via a new cppc_get_ospm_nominal_perf().
>> So, show() returns the register value or "<unsupported>",
>> and dropped the cache/bool.
>>
>>
>>>
>>>> 3. Initializing the register at startup and restoring at exit: In
>>>> v3, we
>>>>     dropped the unconditional cpu_init write so user values would
>>>>     survive CPU hotplug. The spec also makes the explicit init
>>>>     unnecessary: "If this register is not provided, then OSPM must
>>>>     assume that the OSPM Nominal Performance value is equal to
>>>>     the Nominal Performance value.". The unwritten default already
>>>>     looks well defined.
>>>
>>> The concern I had was for the scenario where:
>>>
>>> - the driver is loaded
>>>
>>> - the user sets an ospm_nominal_freq value
>>>
>>> - the driver is unloaded
>>>
>>> In such case, the ospm_nominal_freq value will still be set to a
>>> non-default value. The modifications suggested previously would
>>> allow to handle that case to come back to the default value.
>>>
>>> FWIU, we have:
>>>
>>> +------+     +---------+     +-----------+     +------+
>>> | User | <-> | CPPC    | <-> | CPPC      | <-> | CPPC |
>>> +------+     | driver  |     | reg       |     | HW   |
>>>              +---------+     | interface |     | reg  |
>>>                              +-----------+     +------+
>>>
>>> So if we want to handle:
>>>
>>> - the case described above
>>>
>>> - the case you mentioned, i.e. hot-plugging CPUs
>>>
>>> maybe the scratch values should be stored along the CPPC register
>>> interface. This would allow to handle complex cases where CPUs
>>> are hotplugged and the driver is loaded/unloaded ?
>>>
>>> Note: the same kind of scenario should apply to the auto_sel register
>>>
>>
>> Right.
>> After unload, the register keeps the user set value instead of the
>> firmware value. In a follow-up, I will restore the firmware value on
>> unload and reapply the user value across hotplug, grouping the
>> OSPM-set registers together (ospm_nominal_perf, auto_sel and EPP).
>> On my test platforms the registers survive hotplug, but that isn't
>> guaranteed in general.
>>
>> I think it's better to keep the saved state in the cppc_cpufreq driver
>> rather than the CPPC register interface. intel_pstate and amd-pstate
>> do the same.
>> For reapply, will use a CPU hotplug callback rather than ->online/
>> ->offline hooks. Those are only called when a policy gains its first
>> online CPU or loses its last one. cppc_cpufreq also has shared
>> (SHARED_TYPE_ANY) policy, offlining and onlining a single CPU
>> keeps the policy active, so neither hook is called for it. A per-CPU
>> hotplug callback is needed to cover that case.
>>
>> Let me know if you have other thoughts.
>>
> Is it necessary to have cpuhp callbacks ?
>
> The cppc_cpufreq driver should only support:
> - SHARED_TYPE_HW/NONE: in such case, the polity should
> only have one CPU
> - SHARED_TYPE_ANY: in such case, configuring any CPU should
> configure all the CPUs of the policy. The only issue is that
> we currently don't know whether the CPUs in the policy
> share the same CPPC registers or have individual registers.
> I think it is currently strongly assumed there is only one
> registers for all the CPUs.
>
> For instance, if:
> - CPU0/1 are in the same perf. domain
> - don't have the same CPPC registers
> - have a SHARED_TYPE_ANY policy (i.e. writing to any
> of CPU0/1's CPPC registers triggers an update of the
> hardware for the 2 CPUs)
> - policy->cpu = 0
> then:
> - enabling auto_sel for the policy means configuring
> CPU0's CPPC register
> - if CPU0 is offlined, policy->cpu is updated to 1 (pointing to CPU1),
> - then reading the policy's auto_sel register means reading
> CPU1's CPPC register, which was not updated
>
> So using the already present online()/offline() callbacks should be
> enough. It would also be good to check that, for a policy, all the
> CPPC registers are identical.
>
> Note: having per-CPU CPPC registers + SHARED_TYPE_ANY
> policy is theoretically valid, but unsupported FWIU.
>
> Let me know if it makes sense or not,
>
> Regards,
>
> Pierre
>


Agreed, the cpuhp callback isn't needed.
For a SHARED_TYPE_ANY policy cppc_cpufreq treats the control registers
as equivalent across the policy's CPUs. A single CPU offline/online
within the policy therefore doesn't lose the value. Only a full teardown
and bring-up can lose value on the platforms that reset the register on
hotplug. That path already goes through ->exit/->init, so reapplying the
saved value from ->init() covers it without adding callbacks.

We can add a check that guards this assumption in cppc_cpufreq_cpu_init,
for the CPUFREQ_SHARED_TYPE_ANY case. Compare the control registers each
CPU in policy->cpus exposes (excluding per-CPU feedback counters) and
warn on a mismatch rather than failing init. Since it concerns existing
behavior, the change can be a separate independent patch. It flags the
per CPU registers case you described. Does that match what you had in mind?

Thank you,
Sumit Gupta


