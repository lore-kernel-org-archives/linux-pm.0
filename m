Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC54384250;
	Mon, 18 May 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124965; cv=fail; b=LQgttkwHRXq2Ky1uDjVPYJpSRptnMPNiHH97+M9ty8yMUXXc0c1G5FVddWkAmbK31YaQ6WyykzhWR34O5pTEA9vMlMG1FA48+GneeivWfOfI4lyj1/4hm+ffjJuJ3mZnIKYIqfsbTDPFL0FtjA/CCEhEvU3B7tKIXA0v3evhvTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124965; c=relaxed/simple;
	bh=YShGaYtiiYwF3BgwWWlaIGqTGpzPopn5tgxZ1Od/UdM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5iG8x8PMXxojij6B+QDlHUFsCYOYLQpElwz+MVLw9vxQi+zGNmyq4ba/FDiMzJMsECTeX5Lio/MVqWJwrb2u8lOsZTCjZ4tEeiv/JQwAiIgJSJHlFatTovkJu4rSAmKm8HYb6EC+X+dsVMx6EmCCxJ1Pf4oRUKsx8Fdot3lV0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h/Z16HuH; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h/Z16HuH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVkUs9mE/ZeGWu2wrf4yHf0vmlR8e7pPsfwwAqqupX+ZEhHR+69TqSNFGgbra2IMcblsb/oWTH5bGMiUWUAcbGd0CQg25Hj1/xnBvpEI5G7/B7IlM+LSpC3oZU86iLUtC/2YC6MyRHnKEHpIan10gNsSoOUZmfoUk+hIahX4heoxy2Rk7LJdqedvyouHqqOBv+UYZx6hRNM07SEZhzM1OXt3Qxty3bUrsL66v6QV/sAQBvhfXTX+eQf6zb307a6fxVgkv529Tuq8tlGZotJgqxJGZcqCOSZovZc5+v0ZRaFUo+4X4ENiZGgPtXJLvfMFLDmmhFlj461bYENA+qPfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtZtQjUFYnitUt1W+35O0JYa2C4FrO1tHDAPplNRBXw=;
 b=hGlmMTZ40SIoT/4yxHnbp39wbz2uCAhTyxG4VmHkjZv9+amwffuqjasTcbedWzN4kfmxvOK8OUoP7MHTLlvuLfTUr1mNQSZPCCE50swFUwe/lg5F7mp13nGKvcQybFdrqSX8+mEJNfRgwVtcedFvcc63Nm20KmQ8DaR6t11Wk6IZUA6GUw5xHCLdQrbuTB2LbY5nHmZndFopyXMU7xvz5j4P0RG0nU60XFYgu37xQQWZ1nwPItqFQHdZn7p614ZePPF5/eeKawOLtXQCGItwamM4Mb+/4O5r3/kv7b2YuNSiU0+ckQA8Qo++LlfOHEuaFgaznWIHGoGg9RXE2yuYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtZtQjUFYnitUt1W+35O0JYa2C4FrO1tHDAPplNRBXw=;
 b=h/Z16HuHzXbtm6fr+2q9z1KCVYRkXeWJx+2fwyGoUcO20P5cZC2vPF8B4Y0pbZe3A9hDw8IwLsOKr/D3AQolMoil0C9ThVojiUnll2jqo7C1okOoLxm7FqWSRnRQL4R/N1EAvvaxrazHzFg8TEVo2rAxLsLBUf7ttGMLw/dhX9BB+RBZynKWeSYNJMT6CTEOsBBq4qjhUEZAhFhiivrfL8qIXqk9HuQ+gs/SObypdYVcLIraajTJoJwCE60O9RdBpJlOpypFbbh79faj226nPPEio2Nsi2HHiFCXUCapLWjbjVtcvOtEGL2yFp2LPK20HUM2WSN99qLt77+QHSLyVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 18 May
 2026 17:22:34 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 17:22:34 +0000
Message-ID: <985f976f-1144-445b-96c2-df5bd57ecf05@nvidia.com>
Date: Mon, 18 May 2026 22:52:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
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
 <7d7a6ab6-b1ea-484c-a275-19acca50c483@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <7d7a6ab6-b1ea-484c-a275-19acca50c483@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0081.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::13) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 338ae25c-81c5-41a1-263f-08deb5020c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|56012099003|11063799003|4143699003|18002099003|3023799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tcANej4n2z6DoeA4b+q2GQBAmMKQEhUeH+eggK7sL9Kz//yxDnFonWbrUTKug9e1Ad+z30f1AiySMpI6KyXAxTnkhVGRggMhR61M7/1J0ucGR6cmfoC75eTp8coR5cYhpdqAwgEBUVNAyJfWYH5bXCMGDLaFvlHEQsy9fhZq9fqbWP1F5WXwK4WcQOqp+FgzdoETNxjer7xMsBDf6pEiW8OLl1ya88HH16YFZGZeL9/QVpvK+qx1dIEcNYQDA/5GiBWbFeZFgaKGZm055usDSLmI/X/w0NSiDT9t1VgQ/yFsJ+zjp7vjiALpw4uXQkPZ+xac/Sq7kBSfiZBZwW24Jmb8bgT6id4eNoa0i08wbhohjjS0E8ojiB6Ky3WIq92Ihv4VsbFvhoJnY4mI+tENDdPbpHjpiU35THdG6uWMrXG+egkxtmEtLMBRRIm2hU+xxMueiEPbDbsSDhmWHFLj/HO/xgxiBHs60eD597JudFKOHp3XPV7h9oMSbq8WyTaHOvd5Mfd6GqMv4QVH4b/DogS7B7hUshYtyJFJ6IfAlKD2z/tODALbbN86zac7UwIl6aEqWlIivr6gvOt7T21EulE5kKjGfvewnDJN7dKseAL+KUnuH/qlao5lOdj8hVSsg1vWV3FSew1B4b7Jn4RhsutDyVRUy9jdStUzJPnW4Wh2WEwtAvcWmtCVxdgqbRLDRZ/XkSL3EL1YKgapzuwRw2d9Fau4tl5cLYX8d+NSSLxVc8AP/QnrQKFBzEo5r6pQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(56012099003)(11063799003)(4143699003)(18002099003)(3023799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzFTOGFvUjRFS3dMM1I3dFdKN0phdkxtREpSZ1R0OWlrV3BuUXdqd0VGanRz?=
 =?utf-8?B?MmtDYXpKU3F5cTNoN2w2QlI1SWZhdG0wMFVVL3BIampmUDFHTFJoOHpicXBJ?=
 =?utf-8?B?VnlobVVBSjNCNnZGdFB2RGJuRXZBSkllcVNWTEp5cWxWWnh5M002SEswRy9P?=
 =?utf-8?B?QlBvUlA2OC9DY29GYWxNbm5aWXQvQVdkTW01SCtXTWRRZEJERnJPTG56NDBB?=
 =?utf-8?B?MXBHV2FDeUtQUXdKdjhvUFJjUkcyMEIyelNWOUtjSHI2T09FN1VDbzNBM1Jq?=
 =?utf-8?B?eW15c2FPSjU3ZldlT1RiYmNjRjZGM3c3c216UE1oYlliSm5jVTNrTGNITlps?=
 =?utf-8?B?bUlsU2pIUUhwa2J3aXNkNlVBRjJhdFpXMVlqTU5yR2U2VEJhMGtCYVdGWWJU?=
 =?utf-8?B?S3NHYng1SjczRy8xSmlVY3h0aTJJbWhwVHR1RHpRbEtmc3M2M2lCYUdpeGZT?=
 =?utf-8?B?RlpML0Y2d1QzaEpwUElPN1VDc1JacERzTUQvQUtrVVhaZ3dSK0Z2Mkg4S3N2?=
 =?utf-8?B?d2hoOGtQM2xQR2RoWjAvZm5VZ0g2a1g0Vjd4ZEo0elVMOGVBUmtZelpndTJ2?=
 =?utf-8?B?S3J6c3g4ZHdyVlpEcVZZa1AwTzdlVXZuUC8zZkQzUXY4Z05XOHJuWFRWejg0?=
 =?utf-8?B?WE50cFRxd2FzbTY0WUU1MlFMT3c4UDJsTnRQa09Va29FODhieGhRSkx0NllM?=
 =?utf-8?B?WTJmK05WVXp0enpyV0JsZmd3SUZ4cUgvK0E0cUpLeFowNEpCL1BjSGM5Szhi?=
 =?utf-8?B?dDIwdUVHY21hTFJQZEQwa2xrSGwycThsWWk3eDJsVXlxRjFQbHB6S0ZNUTV4?=
 =?utf-8?B?VElPc1MyUmkxZXhEVnF4a3VDVTRDNXJUeFBnNlpyMHZTc1pLK0lKeVRFNnVR?=
 =?utf-8?B?RzRvZ2JaVW5qT1R6Q2hHMU1vZ0hWNnBUQmIyOEhQQmJsSmN6aWxZRGF6d3lx?=
 =?utf-8?B?aUx5NHhLak5BaGF3Rm9ZazZ2a2pZVTEvZ0ZvVkJSSmJjV1kreHFqVE9BcGlq?=
 =?utf-8?B?WGRrNVFDUjhjQThlZ2dEd2p2R2hKSWt4dVR6Q21HTXdQYm1XMjRiUWJDa3dv?=
 =?utf-8?B?QTdBVW9kUTlGZDQ3SEZPMmx5QnplSG9ma2ttV2FrbEF4L2NDa1dvdkVhaHFk?=
 =?utf-8?B?YVdtVjF2YnQzT2hST3hJRWFMT2puN1VwUmlmUU1LOEJuMHZRQVlmeVhkNUts?=
 =?utf-8?B?Q1UwYnBJc3pBNThQcExraDA2ZWYrUkxuSWpnM2R0Y3Z2cmlVK0IvSVI2eEha?=
 =?utf-8?B?ekRUcUZmdklIdVY1dmtTUXdXT3J6VkRKOWxlZnVQT2NLMFRnRDV3c2U5MGZ3?=
 =?utf-8?B?RjE3TGZYL0xreS9UREhzOFIwdnRJU0o2RjZQeGJoRTBDdTY0RTBOQ3VqNmx1?=
 =?utf-8?B?S0hBTldkSjdpOHlUZm93T1FlTmRMUDlwaGVLOHB6UHljUWlqeFNYTjljWVZ4?=
 =?utf-8?B?QiszS29qWjNDMUdjUG5WeGpXbWJOWFM2UTZtQ1VUbFpiaTFZeWdtMlo3MWlu?=
 =?utf-8?B?dndFdVFGVCt3L093LytPTk1wWTBjMlhoejVCWnEwQ1g4QlBVYkVsVlY3bk8w?=
 =?utf-8?B?eWlJVGJpRGJ3ejNsb245TVRmRGRDdFRtd1Ara24vRjQrREl6VTZsZzZEYWI5?=
 =?utf-8?B?bS9zRDA3WEF6bkxXY2RvNkRYdWIyMTgwcXR0dkpuMlB2dkovNzVBUE9xQUFX?=
 =?utf-8?B?TDhRdjg0WnVFUTRpYkExZmtEZHg3UWE4VERkOUZHNmgraGxUTUdqMkl2OUJt?=
 =?utf-8?B?dENJc1ExSlR5VTNFTit6RnRpN3RGbnAzSFo2WW5WczZnTmZoNVIrbVU2Skox?=
 =?utf-8?B?M1RFNVVRSGFnNDJKODZPMXYrZzRUbTFzbS9vL1E5allMa1J4QW5wSW9QTEc1?=
 =?utf-8?B?OEdzeFdDbzk0aTZoamZKaklMWGJUMmthRE5vOERVYVJ3MjNNejZiblNKU0Nz?=
 =?utf-8?B?YVFWNWY2OFZpb0ZtWk5zTEdOWHVSQUp4cVpMZjU2VzFLVGIrN0JVejd6QU55?=
 =?utf-8?B?bjFDOVg1VGtuc09ObzluMVZ0K0xzODRCcDZKMjd2REZTUG5nbjVldWNtMGtK?=
 =?utf-8?B?M0N5eEZhUkZTaUVyOGNRNGRDZXJ6dEJkaVMwKzRCcWs2V21tcmNGNy8vNkZj?=
 =?utf-8?B?U2NGQ1hCSzdEaFVIckk3bVM5bFBlMklCbDl4Y3JIUVlSN0Z1YUREdDhKeWp1?=
 =?utf-8?B?WSsxcFlSMDJYc2VwTlpOak1VQTh1a2xiMzZYU3ZLRDFVcG5iK29vSVNoME1F?=
 =?utf-8?B?YTh1RDFzb1BMSE9Za2xlYjVzaGh0VUs3N2VxWXdBMTJPcDJKSWt5N1RlaFUw?=
 =?utf-8?B?UEtkYTF6L3dTdXNGOFhjdGJXaExvRE0yTDlaNlNyQmtlTUx2ZzNtUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338ae25c-81c5-41a1-263f-08deb5020c7d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 17:22:34.1429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UT216jOQRQkt+2Fdc88p4g57BYrjJfgKnYAXPzjD+ejyrrf5wkNlRNrcgq7KQ0VFvhjYyG/4dfLZTgk4chXukw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794


On 18/05/26 19:51, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/18/26 09:15, Sumit Gupta wrote:
>>
>> On 18/05/26 19:20, Mario Limonciello wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 5/18/26 08:44, Sumit Gupta wrote:
>>>> Hi Mario,
>>>>
>>>>
>>>> On 16/05/26 02:43, Mario Limonciello wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 5/15/26 07:26, Sumit Gupta wrote:
>>>>>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>>>>> CPPC autonomous performance selection on all CPUs at system startup.
>>>>>> When autonomous mode is enabled, the hardware automatically adjusts
>>>>>> CPU performance based on workload demands using Energy Performance
>>>>>> Preference (EPP) hints.
>>>>>>
>>>>>> When the parameter is set:
>>>>>> - Configure all CPUs for autonomous operation on first init
>>>>>> - Use HW min/max_perf when available; otherwise initialize from caps
>>>>>> - Initialize desired_perf to max_perf as a starting hint
>>>>>> - Hardware controls frequency instead of the OS governor
>>>>>> - EPP behavior depends on parameter value:
>>>>>>    - performance (or 1): override EPP to performance preference 
>>>>>> (0x0)
>>>>>>    - default_epp (or 2): preserve EPP value programmed by BIOS/
>>>>>> firmware
>>>>>>
>>>>>> The boot parameter is applied only during first policy 
>>>>>> initialization.
>>>>>> Skip applying it on CPU hotplug to preserve runtime sysfs
>>>>>> configuration.
>>>>>>
>>>>>> This patch depends on patch series [1] ("cpufreq: Set policy->min 
>>>>>> and
>>>>>> max as real QoS constraints") so that the policy->min/max set in
>>>>>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>>>>>> during init.
>>>>>>
>>>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>>>> ---
>>>>>> [1] https://lore.kernel.org/lkml/20260511135538.522653-1-
>>>>>> pierre.gondois@arm.com/
>>>>>> ---
>>>>>>   .../admin-guide/kernel-parameters.txt         |  16 +++
>>>>>>   drivers/cpufreq/cppc_cpufreq.c                | 122 +++++++++++++
>>>>>> ++++-
>>>>>>   2 files changed, 133 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/
>>>>>> Documentation/admin-guide/kernel-parameters.txt
>>>>>> index 0eb64aab3685..7e4b3a8fd76f 100644
>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> @@ -1048,6 +1048,22 @@ Kernel parameters
>>>>>>                       policy to use. This governor must be 
>>>>>> registered
>>>>>> in the
>>>>>>                       kernel before the cpufreq driver probes.
>>>>>>
>>>>>> +     cppc_cpufreq.auto_sel_mode=
>>>>>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous
>>>>>> performance
>>>>>> +                     selection. When enabled, hardware 
>>>>>> automatically
>>>>>> adjusts
>>>>>> +                     CPU frequency on all CPUs based on workload
>>>>>> demands.
>>>>>> +                     In Autonomous mode, Energy Performance
>>>>>> Preference (EPP)
>>>>>> +                     hints guide hardware toward performance (0x0)
>>>>>> or energy
>>>>>> +                     efficiency (0xff).
>>>>>> +                     Requires ACPI CPPC autonomous selection 
>>>>>> register
>>>>>> +                     support.
>>>>>> +                     Accepts:
>>>>>> +                       performance, 1: enable auto_sel + set EPP to
>>>>>> +                                       performance (0x0)
>>>>>> +                       default_epp, 2: enable auto_sel, preserve 
>>>>>> EPP
>>>>>> value
>>>>>> +                                       programmed by BIOS/firmware
>>>>>> +                     Unset: cpufreq governors are used (auto_sel
>>>>>> disabled).
>>>>>
>>>>> Rather than unset doing nothing, have you considered having it take a
>>>>> midpoint like 128?  That's what we do in amd-pstate (default to
>>>>> balance_performance).  I think it turns into a reasonable balance.
>>>>
>>>> Thanks for the suggestion.
>>>> I can add balance_performance that enables auto_sel with EPP=128 in 
>>>> v4.
>>>>
>>>> On changing the driver default (no param behavior) to auto enable
>>>> balance_performance, it would be good to keep the current behavior for
>>>> now since cppc_cpufreq is generic across ARM64/RISC-V platforms where
>>>> EPP and Autonomous Selection registers are optional.
>>>> A default change would affect existing users relying on governors.
>>>>
>>>> Thank you,
>>>> Sumit Gupta
>>>
>>> But couldn't you make the "no module parameter set" follow the behavior
>>> to only set the registers if they're available?
>>>
>>> So the systems that support it start using it, the ones that don't it's
>>> a NOP.
>>>
>>
>> Would it work to add balance_performance as a new mode in v4,
>> and discuss changing the default separately as a follow-up?
>>
>
> Sure.
>
>> Runtime detection helps for unsupported platforms. But platforms which
>> support the registers use OS governors today, and silently switching
>> them to autonomous mode on a kernel update is a behavior change for
>> existing users. They would also have no way to boot into sw governor.
>>
>
> But hopefully it should be better battery life/responsiveness for those
> scenarios too, right?
>

Yes in many cases, but if some workloads rely on specific OS governor
configurations, then that would get impacted.
I will send a separate change later to seek broader consensus on
enabling auto_sel as default without any param.

Thank you,
Sumit Gupta

....


