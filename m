Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E8383C66;
	Tue,  9 Jun 2026 07:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991292; cv=fail; b=L1qoxGRGsiobQ0Hm7GtXq3XGXmufVtJF/JhxBCY4N6yzK7vTNwQhrUMvRC2UZhTIRUdi52ucHCwtsD6xqkHCDlLThbz4sGYR2reMWhXh7/1fwT+AbPQ9J9C1h5EfshEbehNBZ+3mm2NYCWuK8BwmEwMZaN4PQObMyvUTu/qVQbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991292; c=relaxed/simple;
	bh=uDS8lhK2/JisuRV0oYcvFt0QBiT5SGyDgnmteygxec4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qmSsGIRtNhbe2uLK/CoYo4LC1J/eUYz29rYIy8PXOIDHcodEbCXmg5Vz4rfhRZnVMpMotfYwkNYwHz1xOwAc9avsxNRlWzffjR5xgFnx37mdhVroNPM5Q6+csesxaqRQ9zfyQFpxazpHXXok8iDaxjlOa7fbC1xzN8amGoc2VHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jt+VvrMW; arc=fail smtp.client-ip=52.101.48.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jt+VvrMW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+8w0ocSfqnxb0cWWuWcrJ2KY/lvGUDH2PPmLh1uTXFCKo1hmkqEUvosf8UPrknK5AE+A/1qjeR8Gcd6AyXewORYTQxtvxAJu6tDDsxNLi2jtp4fJr+EiUM9mM9cBNQ3MBXa0SQr2kQLOmbaGR1RCqizq0fZnC8uq6tNmAtkJbNlFMMaaCJ7yBJDvkLYeHg/0mJgAgDhv3oClJAzKkD/O6h+8FpgKizvrsgYnNNXIcymoTb243jVSQgYwMyfLUc2bTr+Ih/1zSf+i5CUlED/XIjR71sXxM2aQ36xLkGgqXRwb1ZUJIKVUjYdmzBS0npSTgk28mHGulszv5IT843tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=575rxeugww7McWoxZ9N7ooMl5BKt4xS34qFVlDN5WNU=;
 b=eb+wFyi7LoqdhWqjpX8nxQVtf61PpieeMX2MxpjSLMFJZEDaFGeHF5pzXFF2vJ2dISNvckdJ7iQoDJgAu4KsbQJHnnB2mBKUdZoqZpQI6gx1DBwo0cXQYn2sGf7AQ72BBXx2jneCZXuv63LeZNiIKDb1HSZNknIB2seP4gT/hSlF+rtlqG2IMQ1EhvHBtm5SKls8dqZ7LgyQGhTCSK8fdTG4JmW6LIZT/7olsgdwHDk9EUOdzIt7RPiH8MbItLGvgQNREDDxxzXXA60VW+vUgrCmrfoilNM3lzQN3T/h3SIK6pG1Hn0IlJQTEF9k5mDKiUlVl+nwYfRBbxLd0uztTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=575rxeugww7McWoxZ9N7ooMl5BKt4xS34qFVlDN5WNU=;
 b=Jt+VvrMWNjFpMde7fyS562t5+lDtgdqjnKUw6gEVkDo26sBSDn5Gof4fRV8kYUNE2WC9Lw4kexN8WAm6tMgvqVijmzqRqq0EJd5CA8dkGhpUuEOoQt9lvBPsptiHWMqRl6vD5X7Og3aQ3EQMR+b8BEbtXwEfSZOQppaAMu8174CSUevMTYp3LtvHeIiv/L7yy7gYu5iGVihol2tHfuiXYt0+7e8w845WZFUYwycplh99yc85PfsO0vbQeMxyiQIRnlwF3JBcQnI6/W0tgqAhzenhZzlGo7zloHTzijubyDSTuhLixZb40/xZ/aFLcCBg7QIQe9zxnd0FBHMOHDxWfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:48:06 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:48:06 +0000
Message-ID: <51c26c6c-9016-482b-a020-2e535ba4090e@nvidia.com>
Date: Tue, 9 Jun 2026 13:17:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260527194626.185286-1-sumitg@nvidia.com>
 <20260527194626.185286-3-sumitg@nvidia.com>
 <e3528e78-1397-439a-b8c2-22648d66efb5@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <e3528e78-1397-439a-b8c2-22648d66efb5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0041.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: d0077335-f734-46cf-618b-08dec5fb7116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|11063799006|4143699003|56012099006|6133799003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	i0R8C8VYavqdtT57O764b+9ntuiuxMm0XToWD/iM/YjlyHHqKzhR5Y25p3Ed81xBlxUIoqs9y0AuRjClv5RrnjcH7j6YayMOMLPBN59deRwuH/ExmFRP1PUxNRsPuHhYP9RkVgfrkANwRreB7ZzJAL+f6L06fzy8iHTlnWHzNB+OyyrVf+kd6qQeyo+fnKYIrP6a8XlC/nJ+sz7kjm930LjZq6imb6FPEDSMacBHRr567rE6XCPxYHpM7IPWXSN33U/N8DgeDYSSY74q5tAn6PnuhlLq0gr7ztW9p53A4VvrVUbNg5uH93G6LyuASiQj0BlbvxFLQU8zkaNFoyWcAd4cpRH9FNmZhPECRWh8DzE3myYYfSwf/oDRFN1no7IIq7DUKNp/RSgPcOzz+MR0Zeq1Dzav0WbqSqboUiIlrKuWmZ5zALUtoC6IQWfVxen/GCsf7S7ypxlWOPTbqKnvgOBdGjxk7FFWORNcCsxTa+hwXIouog4APn9wz2gY1X+rYjL2y404Hq0ztun6NyM2QiRkoa0QwbdH9LY873jE0WzAt9g/dgJqlW0qMmDWhT7Ql4i4dfkJRe9+m9AhTFoHJ6GIjQXqU4IEN1fai/ylrVhy4cloZb/g2V8lB/x5yMDdOQozTHUjM26PsBJuVWnxvOahkZK7rqIL/1i132faWoPMhdAkq+jUUxKWdCwRessVKEMiROYCYdSdWS2O7k/A6yLIpcNojgpW0/VPR7EiQen4nkylzM7MhmzMHNn4Jl+i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0RnQjlob2trZXJLUTkyQ1F0bm1pVHNvcXBvZGtjcnovdHdqaW1iYWlDK3NJ?=
 =?utf-8?B?RXNqN09CVWp3bHVIa2FNT1kxM1pWdTh0SktzV2huVWZEanY0TGs0RUJtcWdH?=
 =?utf-8?B?VjFYcVNRcHVwM1Blb2pReEJQd0E3K1hvRmZ3aXVuYWQwNUdBOGZ2bmpid2l5?=
 =?utf-8?B?WG5NN2pXZTFJRjdDdGFCaEsrdU1Hc2ZIc1FCdWtiaGdpVXQ3aGVQRnV4OUV6?=
 =?utf-8?B?VEdLbld2WDhvczdzZE9IelZDb3AyVkhxVm9IWFY4RkxZa0FpUzMwYjMwTThi?=
 =?utf-8?B?U3ZWSUIwK1hYbGpRVjNBZTNjL0VRMXpsVnBsUm5OVGRNRDh2aXJYNXV3ZVhS?=
 =?utf-8?B?UjlvcWpDVGlQMnFUTk9uYktaZWhWU3l4QUxpUm5vc2UzQUFHMXphVXhvVnZm?=
 =?utf-8?B?Tm5xcHZ5V3VkT2g1UlFuQk96WGduaU1yTzlrV3Bha0krMnQ3bVAxVFRjL2NM?=
 =?utf-8?B?RGNZVW1RUGlTTVFoU3hIUUltbzVVR2tiYWtwSmRqc25CZjd1UGQ4VlVnWWp6?=
 =?utf-8?B?MWhVWEUvbGNMcXpWMHpZNkpVbWhEWStmeFN1Q2YwVjAyRllQR3FNTlRCQ2ZV?=
 =?utf-8?B?MDFNWVk1NUNaSHpiZWJnYkRpeUk3UjQwRzErYlZTa0dqVFd2S2ZMd0FvU2py?=
 =?utf-8?B?NmFVWEJHcUpYaitUa1k1eU9uL0thaFIzOXhFQUgxYytibGpDZ0kwQW5hb0dH?=
 =?utf-8?B?TXpFeGlxWXJPWWdIa3h5bitPdkpaYXc3U3hIakcrazh5ajRZSTdydWZGcXFk?=
 =?utf-8?B?WXY1UVVNcDVVU2NPbFZVaEZ4QUlwZnN2TjlRckdOZVlPaThOZVg4RW56WUJZ?=
 =?utf-8?B?cEFtRXpuRFo0S0RkRzN6MTFLajZsb0MzZmNvajRoaU01N1FnMHBBZitnczFU?=
 =?utf-8?B?VndkdTQyUTBKS0M1Ti9QemMzSmg4dklXYWc2V0lDb05jNUVPUEg5QW90aWVC?=
 =?utf-8?B?RDc1Rk9jOU12RzhSTGZPYVdYcUFwQWVjdmpFYi9yVmFlUUQ3aUZ6c1hERW5W?=
 =?utf-8?B?UDhxZ1RTaXFWVllQVXVFdytuOE5QMEhrU3o4WWRtUFNIMGVwZlRHVkdib3NI?=
 =?utf-8?B?QzFINVFhUDluMnBnMUV6VnBjZG54OWx0dENiV1h1V3FjU2NwVzA4NUxyRk0x?=
 =?utf-8?B?MFhtS2l2QTUrMjZkTkdYNDd3N1pKakFXZVA2VFcwaEtKOFNReEg5K3JDaUdH?=
 =?utf-8?B?QzVMU3haRTZaSWVQMVI0TjNJWjlWWmdtSzNDRHZFY1pSckY0SEp2bys4aXBH?=
 =?utf-8?B?eThLUHlsNm5tbmxzMitNTExmTEdtMytuWVl3REFtY0k0NVdJN3l0WjlVVGk1?=
 =?utf-8?B?b0RmMXZIZFN1YUptYmFhZ1Mvb05MSVFCM2thVXd0THBydW1ObDFPVWxHM0x2?=
 =?utf-8?B?WCtzaWxFQkRUZ0hjczhyMGY0TDJrMkxWRWpVYkR4YWdHenJkN0ZJUlNwS2Z5?=
 =?utf-8?B?Mk1WKzZFZVJNVy9NdVE2UXROUlVUbmxrZjA0VnhtUFZEZnk4QmRrRWxTaEFw?=
 =?utf-8?B?eUZYZnZQTTd0MWRhNUlJR0hIKy9hUSttbDN4MDRNaE8xanUvbGd4NFBUc3h2?=
 =?utf-8?B?N1c3aGg1a1V6N1gveUpKMlZWSmdiRkNEMDc3cHFFbThIRHpQMmJzL1k3eS9l?=
 =?utf-8?B?cVBEZEtHVlZWa1c5dlpsSHVRQWNZMVZTSTFtc1lpNER1bWhMWFNCTWpGVTN0?=
 =?utf-8?B?d1JtakJCNjZiK3RkR3g5SmJlZ1JpeGl1aTBZK3h3amFLSHRxNnB6OXp4dVZW?=
 =?utf-8?B?K0xwUVIxWE11QW5VYmdEUXd2VWpkLzgrY3FkbktXbGVRb1JKNUdUeVdMQys4?=
 =?utf-8?B?UjJxZHdDbGpDV3kyQmRWR21Ga0lxTmRUbFZKUUlHUWlabTIzbDA3Uy9vWEdY?=
 =?utf-8?B?MElmVmtNeDNMNjF5blZYSGlKMmdVTUhHV0ZwV2VEaE8zUDRpbWZwRm52YnF1?=
 =?utf-8?B?ektkYzZKUVJzRW5URldXbDI1VkNUdDRQRTNud0NMa1QwSHlTZXZpM21aN0dC?=
 =?utf-8?B?LzVYYW92TG1UKzRSMlYvaTQ1QXZoa1ZYdDRnS21oOU0wMnZ5OEZiMXdLYmkr?=
 =?utf-8?B?bE80c0pJZFQvV3hwU0JBWXpvUDFrbk1qeVVKTVpMeC9jNmdSSUVHaTJQbjNl?=
 =?utf-8?B?aGZ3UDVQY0NmZTR0M0VRZzNZZjk0Z2hrbVg4QmFkYzNqaGpCL095VTZxaXRL?=
 =?utf-8?B?S3JCeHphaThaYS9zRUVKYXFLMWtneTIzdnFBUEtQRXZzTWZ4U2ZqYVhMajhv?=
 =?utf-8?B?YUpDdUVzaFBCMmZkOVVxclpoTWRQMElaWEptZnJJMEZhNm92R3Z5WEljRDdm?=
 =?utf-8?Q?wJUyC0VKO/v6vNU0yl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0077335-f734-46cf-618b-08dec5fb7116
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:48:06.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBZU7IcijAG//q2Ad1OcNavOSK7AFOF+yCe1E9N0qDKqsY68oRAznEcaKEYX/7aMvce8ayUxd/Njw+wtQYSNjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710


On 28/05/26 17:42, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> On 5/27/26 21:46, Sumit Gupta wrote:
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
>> The register is write-only; the kernel caches the last written
>> value in struct cppc_cpudata for sysfs readback (returns 0 until
>> userspace writes a value).
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++
>>   drivers/acpi/cppc_acpi.c                      | 35 +++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c                | 60 +++++++++++++++++++
>>   include/acpi/cppc_acpi.h                      | 12 ++++
>>   4 files changed, 124 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu 
>> b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 82d10d556cc8..ac1bf1b89ac4 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -346,6 +346,23 @@ Description:     Performance Limited
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
>> +             Read returns the last written value in kHz, or 0 if no
>> +             value has been written. Write a kHz value in the range
>> +             [lowest_freq, nominal_freq].
>> +
>> +             This file is only present if the cppc-cpufreq driver is
>> +             in use.
>> +
>>   What: /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:               August 2008
>>   KernelVersion:      2.6.27
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index c76cfafa3589..ad6ece16c30d 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1682,6 +1682,41 @@ int cppc_set_epp(int cpu, u64 epp_val)
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
>> + * set independently of Minimum, Maximum and Desired performance.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +     struct cppc_perf_caps caps;
>> +     int ret;
>> +
>> +     if (!cpc_desc) {
>> +             pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +             return -ENODEV;
>> +     }
>> +
>> +     ret = cppc_get_perf_caps(cpu, &caps);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (ospm_nominal_perf < caps.lowest_perf ||
>> +         ospm_nominal_perf > caps.nominal_perf)
>> +             return -EINVAL;
>> +
>> +     return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, 
>> ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>> +
>>   /**
>>    * cppc_get_auto_act_window() - Read autonomous activity window 
>> register.
>>    * @cpu: CPU from which to read register.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 15a728dea911..5c54af1655b5 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -1139,11 +1139,70 @@ static int cppc_get_perf_limited_filtered(int 
>> cpu, u64 *perf_limited)
>>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>>                        cppc_set_perf_limited)
>>
>> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, 
>> char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +
>> +     if (!cpu_data->ospm_nominal_perf_set)
>> +             return sysfs_emit(buf, "0\n");
>
> The questions on v3 might be more relevant,
> but for instance here, the ospm_nominal_perf value is not 0,
> the hardware register might contain any value.
>
> So reading the register might be more meaningful than
> returning 0.
>
>

Agreed.
In v5, reading the register instead of caching:

- Added cppc_get_ospm_nominal_perf().
- show_ospm_nominal_freq() now returns the current register value,
   or "<unsupported>" on -EOPNOTSUPP.
- Dropped the cpu_data->ospm_nominal_perf cache and the
   ospm_nominal_perf_set bool entirely.

This also follows your earlier point that being write-only doesn't mean
we can't read it (cppc_get_desired_perf() being the precedent).

Thank you,
Sumit Gupta


