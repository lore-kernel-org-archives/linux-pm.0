Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CAD39EB47;
	Thu,  9 Jul 2026 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616521; cv=fail; b=kgcyUZ+fX+8cXORHs1+SQn/qAzRcGNK9CpWjmZExFcF6WhIYLHuC7MVWku+OMsHGKwJcUyYzM2OzaIbbVvm4sCJK2QF/RmuFw1PuMEZHtxWy0iIlRChIVECG5Lo07ZF+XgpUJayBgBqreK571jaY/umkiFp+LT+P9z8VcDuZoRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616521; c=relaxed/simple;
	bh=HxULmvHkeWcJUBY6uWFBFKoUVmQPxrB4PlDnbqD9a/g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1tHOql48yR78piiLBCaEgR+hm/QmWKHiCPt+V0unEu+ossVk4V8tFR39UA5SrNP72pQIfNM5ZA056pW8OlCHseJ3+R7noRgQIO3WF5u5OIaJNnFr62TlP4eAl7/vO47JNkvw739qbOBeZ7ZpcB8juyIqB25qFgaKXtafkgz+xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOn27i0O; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOn27i0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHiDzsFZh1EaJwubQ3ZXTe2JArN3WgcW4w0h1azhgnlIacSDoyAQWGZhFzAbPE9nNdIyFgdLI5kfxU0nW7Mt0RFmlOO63KiPolFdJ+Y/zZMy+bS71aotm4voGRMJULlmMpwXt0tpNHcpLKPsoOk1ZR47430jhAeFEkO8XQ/xva9KLV/HH0JFhN1SWP1TdrRiBDZmXLT4atoHjrWuJHvIbCHGVrrGcp45+FDtWI8TWheDtW2yYwlT6efu2iQuTXUJ8K+7W/z9S77yl2F5/vmGexB54BJrZmLhckizW5p6D7kzbbKliMHB6NbwIfsyDwpTpjha2DLVqv1APC9KvCmPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAhZhAU4VETGsc8zRPkGfZM9HW6FPFp+DAr+snQFQqQ=;
 b=QAny+PmVvbm86FK9gy9ILtYquKEibzNEq3CDC7C/dvtQ9iKt1hBm75PsXJqyTCln+P5Zry373Xp7u6l3QMQR98Nt7WKK9JVib66kKPKJUcGuEI1Qf6hbIRHXsmaiQI7VKuwe4STcyDyeHudo8v5XDMxlndZVPdcWus/mK1BOwTTypnPqChkPE6tp0v/N6HxU/nBAr4oDfrntmutjdMylTJNr1PSZa50F3T99KDR1hNd1DjiagWo1Ifi4/HyIQR8Xtq/BTvCoUJLmN3rRoNRYhRbYeAxlzlqzyRbt9nBjekBdTn7nQQdK2OtEcQQfTF3K+IupfvtPR95WzBbDNLRCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAhZhAU4VETGsc8zRPkGfZM9HW6FPFp+DAr+snQFQqQ=;
 b=kOn27i0O2tbuGxaXI8i+fhDIcSlT5WaDnNeFpHWp/sBFlKeebnCQXelVvv+EH0afbIhmLdlqJFmEJsKI1ULRPiYUXuGQ7BODr2rtZs/mDOVOJ5OCKnh2l3wOUNwDh5vGSfMsE9XF+Bjlb+dKIp3ypa4PF44nd+pqeEijsweVAojC+rO5/NAJvgF0Z2jTuDW8QUhbzA9QdM7uIam3RItS4jqlQu3KHF8w5KDr7apeayWBT3GpyROSjq4Ph2TwCoIvSCC+DPNdeshNgdryCyNqO1lvSly85ZkhI5AbpNgh/fXCRT/nPkY+U2clvqFHDIQOyoeW0S5UGG1K1XJLP1AVDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SA3PR12MB9132.namprd12.prod.outlook.com (2603:10b6:806:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 17:01:47 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:01:47 +0000
Message-ID: <d2f0a0ee-44f8-47a1-9a6b-2cb9edc77699@nvidia.com>
Date: Thu, 9 Jul 2026 22:31:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ACPI: CPPC: Add ospm_nominal_perf support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, mario.limonciello@amd.com, linux-kernel@vger.kernel.org,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org, sumitg@nvidia.com
References: <20260615185934.2383514-1-sumitg@nvidia.com>
 <b665ecdd-31c3-4663-8f1b-d734ef0c630b@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <b665ecdd-31c3-4663-8f1b-d734ef0c630b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SA3PR12MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d190338-45eb-437e-7376-08dedddbc27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CHAWdalmjDWoFII3We04wfNa1bsyrKViAjojdbP9Nf8uBIhxkOSMGtu43PLSlXdjIKP1MK/KM/FZNlEOOw848KCZrQsfehCad/ZkiULNG19rGp8JZBvozcGSripn0PL4jGSmF+4WxU4a+TOwKrK5KiKwB6WM5vYaWbBpkoa5Lg7tMwU8cgpVh2VcPxELXKQmk3QcYL8zosWaXO73p2DUy8TbJ18qfBfNRG4J0EkHEP0pfNcaxO4VaS5zcqNyrKsJULOTv9UBu1FMW7r+/G7YSXPB50kSA0qTxm/J+zpC6LhIA30sQt572AqRyWjerFHpeP9N1Rs0AesVbYl9JshPN5/VzLwvd5TqoxLCrPRNfxU5eFZ8XrIC6CJrzkFiF13jKIz8q2J0q011NIzZR/XRNo/8uwSgoqmvsePcNHil0ASnMYRQXqMt+SmyTkNSU/5zs2LaPOCkn1skGRoiskGZBwveBjedmN4Arvr/LQuc5kLmaUhDrUoWUnacsTq632KndVtJATliSwl9zoGWaj0/ctlJ8MKyPebfdi97M93U/xxASMjGbmia0Y8ctcSVsVHuLIJP05iDQG3BoX4lE0Flj/Omqxl1BUu/Y+Aw20GXq6ncXelyELaGa51RPhFGSo6tZwpft6h6sUvElEvDTj+KJWQ+9/cjL97ylX0mHZj/+68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkJpQUlnWVRKajNnTnc1RDJBSC8xNVFId0hUQW1VVVdiMDRCZWFOWDlGdU56?=
 =?utf-8?B?SUx2RGExdHp1RGNxSTVEYiswQnd5aHZyUEJ5WUFyTGZqSC8rLzJVSDZxM0p2?=
 =?utf-8?B?T3dScWYwTE4yTXdVcjhDd3cvbmZPbkNrNmRyWm4rWkhVMjhnVS9TK3pDUk0z?=
 =?utf-8?B?aVJPanRJY2U1RWMzaW9DS1Y5S2ROTWh2a2tKT3N6N2tTLzBaK1dSdThRYmk3?=
 =?utf-8?B?U1lkSE8zTDdnNFJaZ254bitnbnR4VFUwR0FXajBBYVEzTU9ESWhsWURLMGpi?=
 =?utf-8?B?QWhsdjJzcEdPWGcwclg5RmZTYVdONHM3cUNtTE5wR01VeGpIRjZ4QW1NdDVH?=
 =?utf-8?B?U2hvaG9tR0xZT25TK2UwaStpTUhtWjA3QytOVG5jSWl6QURaYWI3bGltVVp3?=
 =?utf-8?B?N3NPemUzY2Z3MWczMFI2SFNPZGl2aGl6TXpqaC9Sb0Nha1BkY3J2akhWZ0pF?=
 =?utf-8?B?VVBXaXpmZ2JUMTFQQmtCOHk3YkRBSFpCYlVtRExXUnovTm56UVFYdFpVZkU2?=
 =?utf-8?B?d3Nvdjh4VkpBQnJvN1NHc2xtMWFlU1lDOVE5OTZFN3RlRi83SHlvSlJxVHBa?=
 =?utf-8?B?dlVhSElKSEJTaVd0STBCM2k3R2hDL1V5cGc5cWdRandSMmd3ZGFaN0RkYnlq?=
 =?utf-8?B?cmFvS0FpVXpOMkdIMUV0NysxanZ4NHlFaktJZ0Uxd2k4T1RFMzlHaVQ4RmQx?=
 =?utf-8?B?Ni9obzFXUzNHTnVyYU9NYWRkdUhVdVh0R2dtY3UzRzA5dlhYRzJCZnRYN2F6?=
 =?utf-8?B?R09YOGlKMmdPeUpvVFJjdFBBWVR3MWczOVMrbXFmaWhjSFhpSjhiWHNRQWxE?=
 =?utf-8?B?ZzlCUGFXTXEwMyt1bDdvOGJPOTl1TzQzbUtZVGRvY2FEWkdqSkd5UDhDR1ZS?=
 =?utf-8?B?Njh2b3RKTHM0R0Q3a2dsWThqdUJWUDJWbmdCQlpEZ1JYcE12N2loK0pXUHpm?=
 =?utf-8?B?UkRKU09kcEkxRWt6RmtaNVU5bHlzWngvYnZITEFleFExSmQvNzc2M2w1SnJM?=
 =?utf-8?B?UUhxV3JFTzl2OEptQWc5WWxYcFNFckExczZ2OWdxYVRBU3pkVitvd3g1QmlN?=
 =?utf-8?B?NnE2VExBVGpyTGRFNTdsc0RCSlNzSXM4U0tVVlBKazMzcVBIUmM0Uk5NVlVQ?=
 =?utf-8?B?dWF4dUFNeXZxNEZIeGRKVG1VMUZVbmNUVHZzV2hhbVExOHRJL2JwcDZoL3hN?=
 =?utf-8?B?RDUxVG9mZTRYMFNRdVh2aXNNSUxhTnUrZ3dqK0RLU2pYZnU3NTBOT1NCUmtw?=
 =?utf-8?B?T0wzek5FelJycXB2N1gwWE5Qc3BTM0dFNzVHcUNJRUl3b1RFVXJ1Y3REVWhO?=
 =?utf-8?B?cVpPR3NMbnRVQ29sWXc1MUN0YkZuUitVVmxMcXIzcDYxbzVtNTMvVWxjOUI4?=
 =?utf-8?B?dHhaSVN6N2k1Vy9HRXFUZUZ4NDZVMEZqdHN1SkVyK1RZU29ERzdCOGNWbWlY?=
 =?utf-8?B?amNCNWhSdVN0R2VwcGRVdTVESzh4Q1lMMnRzdzlCdVcwUFlIYXI2eXpxSUVz?=
 =?utf-8?B?QjBiNE85bTNrOGhnRUQ1NHE3WkxkYlhRRzEyRGhteFN0TFoyUUlZUWxhNVdX?=
 =?utf-8?B?WlQwUmJpTGxwMjVWVURLS2hmK1NvSmtjVlY4K3p0WTdQcXBvS2lwU1NyRnF0?=
 =?utf-8?B?Q2Y5ZWtvbTFXcmtkeks4R2FRZzd4ek13UzdpY25sUS9Ebi9WcnRSRzR3NDBY?=
 =?utf-8?B?TnphQ0VpcjEzeGk3cXB3bDRLTlFtcUw4T1BrcWwvTWUrZTVPcUxyNVlNMjNW?=
 =?utf-8?B?VkZhck5VYTJJTWpkWVhMTXhkYmtSSnVBUE5xYnZQT0xEeFhRT3IwWUlOeU9E?=
 =?utf-8?B?dkc1bEdISUFlR25ERzZMTWYxczFMRjBRUDg2Z2FsZUQ4M1d0OHVMemdaakll?=
 =?utf-8?B?cHV4YkJBUEphTjQ1OWV0S1AvS0M2OHpVS1VvakRPVThrcFBvQnh5Wmh3YWlM?=
 =?utf-8?B?RlRUVUdPMGZBSEtVZmU0M1BEZmtITTA3TTVjbnh5SWdDVWxLQ01pRG9wVTJK?=
 =?utf-8?B?Q3lYYzdFU2RrL0ltcWFQQXVhbFFBTnBnMWRYelhiVWJhZ0E0ay9FS3BYektI?=
 =?utf-8?B?dzQyMXljdUdyQmZBaG5kNHZRRTFVVGE2eVVMaVJPTTQycFlwUkY0TFkxTXo1?=
 =?utf-8?B?Um5HdERTUGFyRTZjc2wwWGx6bWpNWjBJVW1kazhDQWNiWjE0WGxEQmgwUXc5?=
 =?utf-8?B?VDZ0dmlsQUJMU2ZXcHV6K0ltR05VMTVvUlB6RkdwWVpvZnVqNDlqTDB2NEN6?=
 =?utf-8?B?bzFWV0tJbVFCRGdOZWJHcmxkak9KT0VyallwSXlSVjM5MzRTYnlCeHNrM3Uw?=
 =?utf-8?B?M0tUMXQ3ZkE1bG5yb0t3bjcwUVoreWI5dlB5YUVTOWppcU9oemkrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d190338-45eb-437e-7376-08dedddbc27a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:01:47.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOmZYxR4spbpmw/bLR90ZhX400hArzteez26TcU57Ei7UdUdDlbhB4keZTILk02h/q7IRLvxwrmal/kx9TnUzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9132


On 01/07/26 21:53, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> On 6/15/26 20:59, Sumit Gupta wrote:
>> Expose the OSPM Nominal Performance register (ACPI 6.6, Section
>> 8.4.6.1.2.6), which conveys the desired nominal performance level
>> at which the platform may run. Unlike the existing read-only
>> Nominal Performance register, it is writable and lets OSPM
>> request a lower nominal level than the platform-reported nominal.
>> The platform classifies performance above this level as boosted
>> and below as throttled for its power/thermal decisions.
>>
>> It is exposed as a per-policy cpufreq sysfs attribute in kHz, to
>> match the cpufreq sysfs unit convention:
>>
>>    /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
>>
>> The attribute is documented in
>> Documentation/ABI/testing/sysfs-devices-system-cpu.
>>
>> Writes are converted to perf via cppc_khz_to_perf(), validated
>> against [Lowest Performance, Nominal Performance], and applied to
>> every CPU in policy->cpus.
>>
>> On read, the current register value is returned, or
>> "<unsupported>" if the platform does not implement the register.
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>> Patch 1 of the v4 series ("ACPI: CPPC: Add support for CPPC v4") is
>> already applied, so this contains only patch 2.
>>
>> Changes in v5:
>> - Add cppc_get_ospm_nominal_perf() to read the register directly.
>> - Drop the cppc_cpudata cache variables ospm_nominal_perf/_set.
>> - Show_ospm_nominal_freq() returns register value or "<unsupported>".
>> - Register rollback reads the register too.
>> - Move range check into the sysfs store from 
>> cppc_set_ospm_nominal_perf()
>> - ABI doc: update read description and add a task-migration note.
>>
>> v4:https://lore.kernel.org/lkml/20260527194626.185286-1-sumitg@nvidia.com/ 
>>
>> v3:https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/ 
>>
>> v2:https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/ 
>>
>> v1:https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/ 
>>
>>
>>   .../ABI/testing/sysfs-devices-system-cpu      | 26 ++++++++
>>   drivers/acpi/cppc_acpi.c                      | 32 +++++++++
>>   drivers/cpufreq/cppc_cpufreq.c                | 65 +++++++++++++++++++
>>   include/acpi/cppc_acpi.h                      | 10 +++
>>   4 files changed, 133 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu 
>> b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 82d10d556cc8..a8d592c08823 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -346,6 +346,32 @@ Description:     Performance Limited
>>
>>               This file is only present if the cppc-cpufreq driver is 
>> in use.
>>
>> +What: /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>> +Date:                May 2026
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: OSPM Nominal Performance (kHz)
>> +
>> +             OSPM uses this attribute to request a nominal performance
>> +             level lower than the platform-reported nominal. The
>> +             platform treats performance above this level as boost
>> +             and below as throttle for power and thermal decisions.
>> +
>> +             Read returns the current value in kHz, or "<unsupported>"
>> +             if the platform does not implement the register. Write a
>> +             kHz value in the range [lowest_freq, nominal_freq].
>> +
>> +             Note that tasks may be migrated from one CPU to another
>> +             by the scheduler's load-balancing algorithm, and if
>> +             different OSPM Nominal Performance values are set for
>> +             those CPUs (through different cpufreq policies), that may
>> +             lead to undesirable outcomes. To avoid such issues it is
>> +             better to set the same value across all policies, or to
>> +             pin every task potentially sensitive to it to a specific
>> +             CPU.
>> +
>> +             This file is only present if the cppc-cpufreq driver is
>> +             in use.
>> +
>>   What: /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:               August 2008
>>   KernelVersion:      2.6.27
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 9f572f481241..1fcc22a10b4c 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1685,6 +1685,38 @@ int cppc_set_epp(int cpu, u64 epp_val)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>
>> +/**
>> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance 
>> register.
>> + * @cpu: CPU on which to write register.
>> + * @ospm_nominal_perf: Value to write to the OSPM Nominal 
>> Performance register.
>> + *
>> + * OSPM Nominal Performance conveys the desired nominal performance 
>> level
>> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
>> + * must lie within [Lowest Performance, Nominal Performance] and may be
>> + * set independently of Minimum, Maximum and Desired performance. The
>> + * caller is responsible for validating the range.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +     return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, 
>> ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>> +
>> +/**
>> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance 
>> register.
>> + * @cpu: CPU from which to read register.
>> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance 
>> value.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
>> +{
>> +     return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, 
>> ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
>> +
>>   /**
>>    * cppc_get_auto_act_window() - Read autonomous activity window 
>> register.
>>    * @cpu: CPU from which to read register.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index f6cea0c54dd9..d160ceced7d9 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -1011,11 +1011,75 @@ static int cppc_get_perf_limited_filtered(int 
>> cpu, u64 *perf_limited)
>>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>>                        cppc_set_perf_limited)
>>
>> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, 
>> char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     u64 perf;
>> +     int ret;
>> +
>> +     ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
>> +     if (ret == -EOPNOTSUPP)
>> +             return sysfs_emit(buf, "<unsupported>\n");
>> +     if (ret)
>> +             return ret;
>> +
>> +     return sysfs_emit(buf, "%u\n",
>> + cppc_perf_to_khz(&cpu_data->perf_caps, perf));
>> +}
>> +
>> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>> +                                    const char *buf, size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int sib, freq_khz, failing_cpu = 0;
>> +     u64 prev_perf;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     ret = kstrtouint(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +     if (perf < cpu_data->perf_caps.lowest_perf ||
>> +         perf > cpu_data->perf_caps.nominal_perf)
>> +             return -EINVAL;
>> +
>
> Sorry I didn't notice in v3, but this function is the only
> one setting the registers for all CPUs in the policy.
>
> In v2, the interface was per-CPU. The main issue with that
> is that we need a mechanism to aggregate values of CPUs
> in the same policy.
>
> In v3/v4/v5, the interface was per-policy, but the
> ospm_nominal_freq was set for all CPUs CPPC regs individually.
> If we do that, the sequence:
> - unplug a CPU from a policy
> - set ospm_nominal_freq for the policy
> - hotplug back the CPU
> might cause inconsistencies in the CPPC regs.
>
> Maybe it is better to continue with the assumption that all
> CPUs in the same policy have the same interface ? This
> assumption seems to be made for auto_sel and other regs.
>
> If this makes sense, would it be possible to:
> - add such check and warn if it is not the case

Will send the mismatch check for the SHARED_TYPE_ANY case as a
separate patch, as it is a pre-existing issue.


> - set the ospm_nominal_freq value only for policy->cpu
> (and remove the rollback mechanism) 

Yes, will write only policy->cpu and drop the rollback assuming a
shared register.


>
> When updating the ospm_nominal_freq, we should also:
> - update policy->cpuinfo.max_freq if boost=0
> - refresh the freq. limits
> - set policy->boost_supported if it is not already the case
>
> Also, update cppc_cpufreq_set_boost() should rely on
> ospm_nominal_freq instead of caps->nominal_perf as a reference.
>
> Please let me know if this is ok
>
> Regards,
>
> Pierre

Agreed. I will add an "effective nominal" (ospm_nominal_freq when set,
else caps->nominal_perf) and use it everywhere. Also will clear
boost_supported when it is raised back to highest_perf.

Thanks,
Sumit


