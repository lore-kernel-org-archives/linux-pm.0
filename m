Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5D48C8A5;
	Mon, 18 May 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114079; cv=fail; b=l4kU28dzYkPOehcp+tS/c0J4JT4k6miGb6Si5yIOy/i6oJVpSRnS+hWhihzkS0IQvbQgW/63UQu4+IRFWDp0AhDCFGpo9wAZU1mJJIYqVryQeze7Rm4RXfph2e/SLphnedepQb+XZe3kRDLkoDP96RWqpqupToosTs+GuDbOtzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114079; c=relaxed/simple;
	bh=LtnWCo0oWV0NFrRna/Htg0s8PWTxbNMp6esDbBR8SyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KjAHkyU0izkj/G9CEMoW8IICa0NV8J02+p7grGf7n9uxgazJOjrVY3RlWU32mMC9GC33Sbk6rkYmMCHAxEnAGp1HarArOfl1R4zwi23BAr2pY3/UYp78iprtMHvgSGFZN+sdsQVmq7pUTXoV5aSGAWDt9Brz/ErZr3gzULb5/FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p4G9FleQ; arc=fail smtp.client-ip=52.101.46.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p4G9FleQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSNY9sCQbUe8eHf/nXKl6NJZhSpopTivpB62SV0a8aLR8SBS7/4Q5jVVuSjTeNH99p4a2/JR1M9gkFPeEn2X1ADERHvT8SQgM+2aC1NaoBgRQ6qs9pTB97ubq/iY2gJFpAKSbKXtDARMe9WBb8mypJr6DCPDWYJyoam0Aa/a+az5R9vVLxBRAw1uWPQupuG+ZKhjJDW8NCteuC31v0CgkfloMtmbtXRxDzmPKpfSBWz4kTXah810zjjjJxR2ogDRPu1bb1SWvg/ZIHSW32csj3SQuvkUmeRJGGuwjYEXcAi5T6g1dQAJxhB1+Mf6xTZU5qnfzr8XmhsgTsDLkDf2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9Uy/0WPxKBuTsKCiSoAqjeEtppzmhEAyxUO67mUHzA=;
 b=l1XbvqcxdU8OwJmTshhM8J2xh+mDcOozYjMtHH/cXqQh4oT/BZJzr7GDXk1+LDvTYm+8uxYgIGKCVRxm0cUHkAJHucqyeKhwpy+ZJ5cCemxbOeciXlaZWoKy+QwAa/8Hp7YkQ3nT52ge5zdjdOwrLgK+gSCBfaBCj1E/OtI3VUR3FzwcJRNIqLe9OHXnDIJq1SpVbQCfU6h6qZmB2ufYQEexrWHkNXEk5Sm4w7iOGtAF/4ZDPz4tj9jiyynHCEbKVim7GSbjIfbooZ095NZ+Zugi+N2VwPuRBav0kJkhqFmSdcBDaK78aFzAfNFgDZfEk1xM6/NrtF54pLdBt9j7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9Uy/0WPxKBuTsKCiSoAqjeEtppzmhEAyxUO67mUHzA=;
 b=p4G9FleQ1s/eMuH5XhZ7Gx4ewDpLdq/fckUQKFQHqM1/5d9I5k9tW84J7+iTm0xDLhiI9GIgf8zPgBR9Tf+quc/MTl0H0IjpM7YOSDXtB95n80WDFm5NPWGNsA0Qv3TwQ8lYvTzisQbY5ulKsrshmkWqrpmEN6KdXUE0uSXVN3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 14:21:08 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Mon, 18 May 2026
 14:21:08 +0000
Message-ID: <7d7a6ab6-b1ea-484c-a275-19acca50c483@amd.com>
Date: Mon, 18 May 2026 09:21:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260515122624.1920637-1-sumitg@nvidia.com>
 <20260515122624.1920637-3-sumitg@nvidia.com>
 <bf521e4e-1aa5-49ce-bec5-52845f02214e@amd.com>
 <139d2f0e-72d9-4721-9d5a-d1d4a2a95fa1@nvidia.com>
 <72fd2fcc-6303-4980-beb7-e4b711ad6406@amd.com>
 <e1a546f2-6e7e-4236-97bb-f72bea0137f7@nvidia.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e1a546f2-6e7e-4236-97bb-f72bea0137f7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:8:57::21) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfed808-4e51-4544-4bf4-08deb4e8b3ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003|3023799003|921020|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	3CvCQG7+SMTnP+u6qht1nZgWrOGoBBFT4ZW70//1tM4iDGDBQCE5PnYnpFWI1TCd8Cqe2KpG2XalC52EwT/zdUPYNjjNVEGGDKl90r2K04Lf2DhMaLaBElUAtaw3Si+o21eY191e/KH5nbzB+WWwIbusvqAm0q0/yynQmdVf+CUBln45roYxQ2q8p88hl7u9YlqgMzxcUy1hT1iPMOTkMUavn4Tgspn5Os45m3CYNhYIXpSR0aXl4GXE1rqnZXONgHXRnH+4RdwAfg+1ncwOmaI0gAiqDq62gZv6AHTpxixIvkw7mfDClpIUkmOQBe0YE1txFfi/zf7fXrbtrZy3g0Q/qTSWbimx+3egpjZVtoMtoJdxnwXIIUOTEARz8zVkhJOpzt90ZJNbV1PyG+ZduvwscMy3ARlzPTnW926keZOSuaEakhc6RrKjrJ0kNx32WTX4k2Bu4zmalnWBq1Dpc+W/pDxJq9+fQmsRSTjrVOB91kqvTruh7w4p0DD4E/2pU6M853UIGQry9jVzDhsjiLwZRlTP2BzRyQEIw/t0OxfS2AZNYjV6cPFr/8qt0UA978HKsLhRI+IleZW1TjkwkFtvt8KuvPR8AJKTCpVMHGxfqUiyO6E/PH0/6XLI97mix7jmV1TCFa5ycf5dh8fcR3duGu23n4EsyjgKq2JOSCwSGUwMzLp1cYVOWLa5MEhD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003)(3023799003)(921020)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?US9UTFliNWtObTF2RGN2aGs5cHRpR3plN0NPemV3M3hseHZhR2lxV2k1aWZi?=
 =?utf-8?B?b0hnc0pPR1E4U0NDYmVWWFpId3o3eUJMTWY2ZFlFdU50VFgyemVrbFRpU282?=
 =?utf-8?B?UEdyZVBycmFkancyQUI0VHVKZktzVUs4ZXdZdWZPaE9NVFNHN3gxUTdhVVUw?=
 =?utf-8?B?bXExUGJJYm9jTEttYnVMYSt1eFJEZDB3UnhRbnJyMmNQNWRLWEVYWUtzLzNR?=
 =?utf-8?B?S0lmc2M5Z29tZkgwTkRBdFpVQ2JheCtzNWJOcnlJcTA5eE10QnBqWjVBWFRK?=
 =?utf-8?B?R3BmUXRwS2hyMGRPSVpwbDJlVTRJY1NuOWk3S3ZYUG5JbXNZWnpGUTVkcWFQ?=
 =?utf-8?B?NHRLUmk3bmJxcHRjTHNDN3N1UzZSZlVXYTEzUXQrZzZqK01sYVAzelR3VWQz?=
 =?utf-8?B?Q2VWTVJIQkZRdHlXV2JJamF6cXMwNExZNWpXSWV4dWQ0MysyUDRUZVpGTTdJ?=
 =?utf-8?B?emRPbGhVd01UaHJaNUJaSDc0dWN0SytJZzdzKzNkVkdnazE4eklnanN6cHJW?=
 =?utf-8?B?Nk9acXJLbnNrekU1ZFFySGZvcmFFUDFOYVJHaWFJN25mQ2xIVnlYSmdvdFJk?=
 =?utf-8?B?MHFOWGkrczBtUjRCVzhxYzVnQy9GNVlKd0s5YXZTZUhOK2oyU2JvaXlSQlp5?=
 =?utf-8?B?TlVyL053d1l4Q0ZkZjRpbERhcVVsQmtsQWY5eHZyTGE2VUxiQjNMUGUvQU5L?=
 =?utf-8?B?UnduclRHVGtnSXI2U3hiT1c5QWhzNVliemF3K0lSdlRrSHo3ZytEOVdlM3U2?=
 =?utf-8?B?OC9qQVdaVUV3ZmlqSU42UW1yOGFrMW9LUjdMbldQTFVSWUxLMEYydzRScXlr?=
 =?utf-8?B?VVJWZ3NnbFdqQU0wR2d1WXRlYTVUK1BsYTI2VEsxdWJ6VCs0MkYzLzFvOHZ6?=
 =?utf-8?B?ak9jWkJtWHFTQ0ZUVzF5aXZPMWRMbGFQR3pxUll5cDZuSVB5a2xTOThjMzZ4?=
 =?utf-8?B?TmJEQ3hVTHNFRTIwSERkS1BsQXUrV2dNL0hScGNJSjlJQXhRQlJqZU5waEdk?=
 =?utf-8?B?eDlXYkVzcmk4dzRnVE83dHVSa0QwWFhIdmtOMFVEdVRJcDBvOXBPTHBVZ0Zq?=
 =?utf-8?B?VTJMOXhUVDhHOWM5bjFBRllqZTdyYjVhYVppYkxzM1pHQWdtSEhHY0JUbEZR?=
 =?utf-8?B?OHBrVG4xRU9KUGJwVjNrWVhyTGFDWmZETlpBcUVsR1gxc2V6SjRxUzFjU0Zz?=
 =?utf-8?B?TFdQSE1tZUUxZlJPRU84QVcvZktpbE1oOHRWSi9OTzdWZHBXSUk0Undld0xS?=
 =?utf-8?B?ODlHQ05zalF1cTBic25qdEI4QXZvUGVwQVIrS0pZZDR6WUQyVmt4aGh5dWZN?=
 =?utf-8?B?TmMxY3RRMkgwYmF1QW9NQk40alVJYjVRUjFIVUFnaC9WWkVLZXdNdU9Mc2xO?=
 =?utf-8?B?STB0bmwwVS8ycWZEeUxHU0Jtby9wVjhFRXAyd0xlT3U4azZFSVdteHRNVUF0?=
 =?utf-8?B?TU9ORVJCeGpiRzkvNjhQeGRJZ2QwdXpkWVJDYk53OXlsdW1udTc0M2NvWGxZ?=
 =?utf-8?B?UTFqM1oyTEdxQy9pTjJHVHpodWs3TndwZ0hMei9VeU0wdDVXOFV4OGxaWlhm?=
 =?utf-8?B?QjZaWnA0NGQzZEdnR0xkZ2lhNTlKQi94amhzZnZJWk9pdTF5aUlGVCtMaTZO?=
 =?utf-8?B?NWNuL003RGR4OEE2ZWJhTVg2RVMwRDJzTFpPUDJSVjNDQkM3aEt0U3hiVjBF?=
 =?utf-8?B?RTVacWt5YWFMTXAyYlpxMkRwbEZ1VDg0V0RtMXlnZmdnT3hkYWVqSVZleTZx?=
 =?utf-8?B?Z1JxT3RaTDByYk9HQmRJUDdJOXdRNnovOVRKM3oyWkw5Tmc4UVZlZ0IwR2Rs?=
 =?utf-8?B?c0hFMEF0elBrUXBxN2tmRE9zZFVKeUdNclNFSjZPakVkZWtSU1FxTjRmb2JW?=
 =?utf-8?B?dzJraWRxWWpPMFJhRjBrVE5yaHlWM0ZsTmFRaGxET1dWWkZnVWMvWWpJTUpL?=
 =?utf-8?B?blFBdUh3OXhnTnNDSVNHcHVpNHV3M2Q4QXc5dFZ0N2pwcGpkZ283WkRFVWl0?=
 =?utf-8?B?cVVhcVdjblFOdjl2UERFOUk1WGVCdnFyTWFJS2dwUXMxMlFDZzNsM0NoNlJr?=
 =?utf-8?B?RVVKSFNGVm9rTlZnSDd0M3dtK0Jvekg1MnpvU3VXQ2tPTzF1c1NuUTlTOXo1?=
 =?utf-8?B?ckRMdEZBbGRqRG9XUE5ZWm5PaHJlZEdLWFBnMHl0NXp0Vy9LNWIvN3JTSW0x?=
 =?utf-8?B?VGoxaEhEbVBBYUt1Mkc1K3NZZTB1ZGt6UmpNcVlXSE5IcmhXaWdjbzZ4TlRX?=
 =?utf-8?B?Z3FGSnFjdlNuNjRRLzNFMXZveUY4WHpGM3hFbTlXcGx4MHp1ZmdEUTIyT01o?=
 =?utf-8?Q?xusM/fJt+9zf8fmwZq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfed808-4e51-4544-4bf4-08deb4e8b3ee
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:21:07.8754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7A9EPn6Rzaf3Ct2M0mmoL3VSGNOCDwUZk55/LhxA6HlFeqZaLqQFhD1/qNZsONUeDz1C77F7ypxcm8BQY2J5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249



On 5/18/26 09:15, Sumit Gupta wrote:
> 
> On 18/05/26 19:20, Mario Limonciello wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 5/18/26 08:44, Sumit Gupta wrote:
>>> Hi Mario,
>>>
>>>
>>> On 16/05/26 02:43, Mario Limonciello wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 5/15/26 07:26, Sumit Gupta wrote:
>>>>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>>>> CPPC autonomous performance selection on all CPUs at system startup.
>>>>> When autonomous mode is enabled, the hardware automatically adjusts
>>>>> CPU performance based on workload demands using Energy Performance
>>>>> Preference (EPP) hints.
>>>>>
>>>>> When the parameter is set:
>>>>> - Configure all CPUs for autonomous operation on first init
>>>>> - Use HW min/max_perf when available; otherwise initialize from caps
>>>>> - Initialize desired_perf to max_perf as a starting hint
>>>>> - Hardware controls frequency instead of the OS governor
>>>>> - EPP behavior depends on parameter value:
>>>>>    - performance (or 1): override EPP to performance preference (0x0)
>>>>>    - default_epp (or 2): preserve EPP value programmed by BIOS/ 
>>>>> firmware
>>>>>
>>>>> The boot parameter is applied only during first policy initialization.
>>>>> Skip applying it on CPU hotplug to preserve runtime sysfs 
>>>>> configuration.
>>>>>
>>>>> This patch depends on patch series [1] ("cpufreq: Set policy->min and
>>>>> max as real QoS constraints") so that the policy->min/max set in
>>>>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>>>>> during init.
>>>>>
>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>> ---
>>>>> [1] https://lore.kernel.org/lkml/20260511135538.522653-1-
>>>>> pierre.gondois@arm.com/
>>>>> ---
>>>>>   .../admin-guide/kernel-parameters.txt         |  16 +++
>>>>>   drivers/cpufreq/cppc_cpufreq.c                | 122 +++++++++++++ 
>>>>> ++++-
>>>>>   2 files changed, 133 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/
>>>>> Documentation/admin-guide/kernel-parameters.txt
>>>>> index 0eb64aab3685..7e4b3a8fd76f 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -1048,6 +1048,22 @@ Kernel parameters
>>>>>                       policy to use. This governor must be registered
>>>>> in the
>>>>>                       kernel before the cpufreq driver probes.
>>>>>
>>>>> +     cppc_cpufreq.auto_sel_mode=
>>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous 
>>>>> performance
>>>>> +                     selection. When enabled, hardware automatically
>>>>> adjusts
>>>>> +                     CPU frequency on all CPUs based on workload
>>>>> demands.
>>>>> +                     In Autonomous mode, Energy Performance
>>>>> Preference (EPP)
>>>>> +                     hints guide hardware toward performance (0x0)
>>>>> or energy
>>>>> +                     efficiency (0xff).
>>>>> +                     Requires ACPI CPPC autonomous selection register
>>>>> +                     support.
>>>>> +                     Accepts:
>>>>> +                       performance, 1: enable auto_sel + set EPP to
>>>>> +                                       performance (0x0)
>>>>> +                       default_epp, 2: enable auto_sel, preserve EPP
>>>>> value
>>>>> +                                       programmed by BIOS/firmware
>>>>> +                     Unset: cpufreq governors are used (auto_sel
>>>>> disabled).
>>>>
>>>> Rather than unset doing nothing, have you considered having it take a
>>>> midpoint like 128?  That's what we do in amd-pstate (default to
>>>> balance_performance).  I think it turns into a reasonable balance.
>>>
>>> Thanks for the suggestion.
>>> I can add balance_performance that enables auto_sel with EPP=128 in v4.
>>>
>>> On changing the driver default (no param behavior) to auto enable
>>> balance_performance, it would be good to keep the current behavior for
>>> now since cppc_cpufreq is generic across ARM64/RISC-V platforms where
>>> EPP and Autonomous Selection registers are optional.
>>> A default change would affect existing users relying on governors.
>>>
>>> Thank you,
>>> Sumit Gupta
>>
>> But couldn't you make the "no module parameter set" follow the behavior
>> to only set the registers if they're available?
>>
>> So the systems that support it start using it, the ones that don't it's
>> a NOP.
>>
> 
> Would it work to add balance_performance as a new mode in v4,
> and discuss changing the default separately as a follow-up?
> 

Sure.

> Runtime detection helps for unsupported platforms. But platforms which
> support the registers use OS governors today, and silently switching
> them to autonomous mode on a kernel update is a behavior change for
> existing users. They would also have no way to boot into sw governor.
> 

But hopefully it should be better battery life/responsiveness for those 
scenarios too, right?

> 
> 
>>>
>>>
>>>>
>>>>> +
>>>>>       cpu_init_udelay=N
>>>>>                       [X86,EARLY] Delay for N microsec between assert
>>>>> and de-assert
>>>>>                       of APIC INIT to start processors. This delay
>>>>> occurs
>>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/
>>>>> cppc_cpufreq.c
>>>>> index 6b54427b52e1..5f4d735e7c7d 100644
>>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>>> @@ -28,6 +28,43 @@
>>>>>
>>>>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>>>>
>>>>> +/* Autonomous Selection boot parameter modes */
>>>>> +enum {
>>>>> +     AUTO_SEL_PERFORMANCE = 1,
>>>>> +     AUTO_SEL_DEFAULT_EPP = 2,
>>>>> +};
>>>>> +
>>>>> +static int auto_sel_mode;
>>>>> +
>>>>> +static int auto_sel_mode_set(const char *val, const struct
>>>>> kernel_param *kp)
>>>>> +{
>>>>> +     if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
>>>>> +             *(int *)kp->arg = AUTO_SEL_PERFORMANCE;
>>>>> +     else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, 
>>>>> "2"))
>>>>> +             *(int *)kp->arg = AUTO_SEL_DEFAULT_EPP;
>>>>> +     else
>>>>> +             return -EINVAL;
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int auto_sel_mode_get(char *buffer, const struct kernel_param
>>>>> *kp)
>>>>> +{
>>>>> +     switch (*(int *)kp->arg) {
>>>>> +     case AUTO_SEL_PERFORMANCE:
>>>>> +             return sysfs_emit(buffer, "performance\n");
>>>>> +     case AUTO_SEL_DEFAULT_EPP:
>>>>> +             return sysfs_emit(buffer, "default_epp\n");
>>>>> +     default:
>>>>> +             return sysfs_emit(buffer, "disabled\n");
>>>>> +     }
>>>>> +}
>>>>> +
>>>>> +static const struct kernel_param_ops auto_sel_mode_ops = {
>>>>> +     .set = auto_sel_mode_set,
>>>>> +     .get = auto_sel_mode_get,
>>>>> +};
>>>>> +
>>>>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>>>>   static enum {
>>>>>       FIE_UNSET = -1,
>>>>> @@ -715,11 +752,75 @@ static int cppc_cpufreq_cpu_init(struct
>>>>> cpufreq_policy *policy)
>>>>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>>>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>>>>
>>>>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>>> -     if (ret) {
>>>>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret: 
>>>>> %d\n",
>>>>> -                      caps->highest_perf, cpu, ret);
>>>>> -             goto out;
>>>>> +     /*
>>>>> +      * Enable autonomous mode on first init if boot param is set.
>>>>> +      * Check last_governor to detect first init and skip if auto_sel
>>>>> +      * is already enabled.
>>>>> +      */
>>>>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>>>>> +         !cpu_data->perf_ctrls.auto_sel) {
>>>>> +             /* Init min/max_perf from caps if not already set by
>>>>> HW. */
>>>>> +             if (!cpu_data->perf_ctrls.min_perf)
>>>>> +                     cpu_data->perf_ctrls.min_perf = caps-
>>>>> >lowest_nonlinear_perf;
>>>>> +             if (!cpu_data->perf_ctrls.max_perf)
>>>>> +                     cpu_data->perf_ctrls.max_perf = policy-
>>>>> >boost_enabled ?
>>>>> +                             caps->highest_perf : caps->nominal_perf;
>>>>> +
>>>>> +             /*
>>>>> +              * In autonomous mode desired_perf is only a hint; 
>>>>> EPP and
>>>>> +              * the platform drive actual selection within [min, 
>>>>> max].
>>>>> +              * Initialize it to max_perf so HW starts at the upper
>>>>> bound.
>>>>> +              */
>>>>> +             cpu_data->perf_ctrls.desired_perf = cpu_data-
>>>>> >perf_ctrls.max_perf;
>>>>> +
>>>>> +             policy->cur = cppc_perf_to_khz(caps,
>>>>> + cpu_data->perf_ctrls.desired_perf);
>>>>> +
>>>>> +             /*
>>>>> +              * Override EPP only in 'performance' mode;
>>>>> 'default_epp' mode
>>>>> +              * preserves the BIOS/firmware programmed EPP value.
>>>>> +              * EPP is optional - some platforms may not support it.
>>>>> +              */
>>>>> +             if (auto_sel_mode == AUTO_SEL_PERFORMANCE) {
>>>>> +                     ret = cppc_set_epp(cpu,
>>>>> CPPC_EPP_PERFORMANCE_PREF);
>>>>> +                     if (ret && ret != -EOPNOTSUPP)
>>>>> +                             pr_warn("Failed to set EPP for CPU%d
>>>>> (%d)\n", cpu, ret);
>>>>> +                     else if (!ret)
>>>>> + cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
>>>>> +             }
>>>>> +
>>>>> +             /* Program min/max/desired into CPPC regs (non-fatal on
>>>>> failure). */
>>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>>> +             if (ret)
>>>>> +                     pr_warn("set_perf failed CPU%d (%d); using HW
>>>>> values\n",
>>>>> +                             cpu, ret);
>>>>> +
>>>>> +             ret = cppc_set_auto_sel(cpu, true);
>>>>> +             if (ret && ret != -EOPNOTSUPP)
>>>>> +                     pr_warn("auto_sel CPU%d failed (%d); using OS
>>>>> mode\n",
>>>>> +                             cpu, ret);
>>>>> +             else if (!ret)
>>>>> +                     cpu_data->perf_ctrls.auto_sel = true;
>>>>> +     }
>>>>> +
>>>>> +     if (cpu_data->perf_ctrls.auto_sel) {
>>>>> +             /* Sync policy limits from HW when autonomous mode is
>>>>> active */
>>>>> +             policy->min = cppc_perf_to_khz(caps,
>>>>> + cpu_data->perf_ctrls.min_perf ?:
>>>>> + caps->lowest_nonlinear_perf);
>>>>> +             policy->max = cppc_perf_to_khz(caps,
>>>>> + cpu_data->perf_ctrls.max_perf ?:
>>>>> + (policy->boost_enabled ?
>>>>> + caps->highest_perf :
>>>>> + caps->nominal_perf));
>>>>> +     } else {
>>>>> +             /* Normal mode: governors control frequency */
>>>>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>>>>> +             if (ret) {
>>>>> +                     pr_debug("Err setting perf value:%d on CPU:%d.
>>>>> ret:%d\n",
>>>>> +                              caps->highest_perf, cpu, ret);
>>>>> +                     goto out;
>>>>> +             }
>>>>>       }
>>>>>
>>>>>       cppc_cpufreq_cpu_fie_init(policy);
>>>>> @@ -1079,10 +1180,21 @@ static int __init cppc_cpufreq_init(void)
>>>>>
>>>>>   static void __exit cppc_cpufreq_exit(void)
>>>>>   {
>>>>> +     unsigned int cpu;
>>>>> +
>>>>> +     for_each_present_cpu(cpu)
>>>>> +             cppc_set_auto_sel(cpu, false);
>>>>> +
>>>>>       cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>>>>       cppc_freq_invariance_exit();
>>>>>   }
>>>>>
>>>>> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode,
>>>>> 0444);
>>>>> +MODULE_PARM_DESC(auto_sel_mode,
>>>>> +              "Enable CPPC autonomous performance selection at 
>>>>> boot: "
>>>>> +              "performance or 1 (EPP=performance), "
>>>>> +              "default_epp or 2 (preserve BIOS/firmware EPP)");
>>>>> +
>>>>>   module_exit(cppc_cpufreq_exit);
>>>>>   MODULE_AUTHOR("Ashwin Chaugule");
>>>>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+
>>>>> spec");
>>>>
>>

