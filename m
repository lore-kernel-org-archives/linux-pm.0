Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B653DD518;
	Tue,  9 Jun 2026 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990662; cv=fail; b=NrZ51WzAuHvG7BqiOozm/uvmqPJaS3ACnVBkB2DEovUYntrMXhLzPLB1fOVEVlliz8MfaVAo7Li33I1Gnj0mthqh6nJ0Dl/R5WuTHiIRfx4/oJ8r/0mysUK2jf1y12HLBm1oc1kHCBEVChCguChOLFwHsU8/Yy0TTZ26CuKCIfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990662; c=relaxed/simple;
	bh=sEfWo5r3CjZTfMJ/N7YegkrGFFauAe+zmywWgCliElo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SLiUILc7q3sIfQpMExCcI0CnOWoqWCAqiBr84Ret9nlNlcPQvBD59BfwnP6Imi4hvKjACqNVs8Z7ZCaIAedAaXY7elRomzoM0kvOmgGp3VSuaxI5694ZgCyV8NxD2kiy9QLn+7Os8zD3GOCwOWmjuZIv86ijBXdwLovjGDB4FbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=klLl30Jb; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="klLl30Jb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzNUtiWvi776+iyiYWwaFbfuUYYv2RvE7gJyxK+dk1nmM1gingtw7evp45DxhvUGY0VJ75NY0RBvuMNr0ZcfGUMC9QUyr10JFkkIDhqIlBmMggQtSpMYeYUpEEwhqezxviE+1PjXZMeyxP4qYY6LrQ+vMWvjP1dM2noNG5RCxhau8fIiqg92N18g3llApsc0jIxqq1WZPOzAGXW7ZMKeTLwjlY9TVbaozlOWi2jQL3sE7COLDqOZGqqNxKhn2N9XqhNLgmAes9FkKTa+DXV1ru8hi8UBzdaXyGJEoY6k6aHaUmvArs4P9o3Xx5+2tjVCcPLl3+7sH84Az/E1o1Drkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WuToAVhsZdLvaknkdKxTMGpdF3LjOMujoGkZbTMPjqQ=;
 b=Qr2R9rnDQypwvdYM8wLmdv8oUFh/+6NrsiuwQukG4iW5ZI7a4iJXKmExpKC+M89Y+ToSoxnt8tvinV2WWM1kTVymv7We8WVdUCS4FFM8WoXyAkXoKHEzj3065BaNwBMVXPXZ7sj3xyzBpqKOqRos7IiPjOJLSU+8am8Ij9Ce/rYOe6znclBiX3eclxAep+0UrIg82n9SPNYDH/L8s6bzAdNfErmk6iNLfYrEzSf6VfIVxNVZnBJQ4I5r2DTsosJ7gBwcF2Hbd/ngvkH4EYTi8PSFFzta43VaQYrGaQ239ZeFgy/YSU8xNe8Sf0EAb2nvsHFloTzPAppG4UsPRzn3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WuToAVhsZdLvaknkdKxTMGpdF3LjOMujoGkZbTMPjqQ=;
 b=klLl30JbUPVvkI9mtIhhd4XzhQ+U7BZYKjp2TdajQeVnlKuxzYzu2yYH20tTQeoYnFfWUz5dNLv/9P+t/qCVCpt3/axUVbRLZI5JBwX4DbKc+g+o/VVxcQ1qUsU2YESrweB5/dx98vv5DrQuukdgPES66appKOnHuh6AiNl7kAmHQK0Jl7HYsug91FacXbhitUdVFDrTQngklPbh/L1iKvrRx1McKkojsGgx9BQ760FZQ4wIBLcuoayv6r62BZfCM1//YojbqVEas5njRJxPsNTR4e2+b+FODVt2Jtrm5zD8OoRqivjSYYiwOO8wWtDRDVfjW8nldlsmOKFMpFgQkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:37:37 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:37:37 +0000
Message-ID: <6af59ba9-8d90-48a1-823f-f98bbcb5d8f5@nvidia.com>
Date: Tue, 9 Jun 2026 13:07:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, mario.limonciello@amd.com,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260527194626.185286-1-sumitg@nvidia.com>
 <20260527194626.185286-3-sumitg@nvidia.com>
 <19b92583-ab78-4b45-a260-03a13874b0fe@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <19b92583-ab78-4b45-a260-03a13874b0fe@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::35) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a328051-a410-4fef-a168-08dec5f9fa1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|921020|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Xfk3OCSPWjXWITIUcEyI3joJcdBlFACx6jtJ4frR5+bqgNw3EEoHujRz8lP1xdCPfb8Mprl9BPP/wo9wc46MfTUbTVDsGvxjguvl7TbLichnh+ZBr2pRyaCiStUmCrw6cBaEW/3lbEzyf81rzURnSnC/O8t//qu8d/nrZ4pHj0+cVY22dkZYnKFmkrix7zWIr4YT645SvT6rWA02AY4jomyiwPJLC/tObhoXeKu93uwmdGKhTMhgz0qD+K6aYDKcqlw69MDnS0MNCg+2KN3sNhDUPww7N0rj421PGJNh1HvT4yszvMn84niQBOm7x1BKnCDH3/ayDWY4atQXFcPbc0Vz3P7c7khukyehk3Zf9T9cJ6a1kwh7crvX5Km4GZWJgAUTyiESUl+6/CHWVQ/h+Am9GT1TlFbmK7NvwrVhHis2hOvF5uRPohbG5O/oiqjOaCpRcX7EhS2YPsiQIpwA49NBg0Kx36lOk+YyM8nY/ASMJUNkqySWBdPJ52SYGpYvO9/nyuLpFflxGszzG3/OfxNM6076n4iq4eBQs9nkS8aMz03C4UJ5sPG5n2szRVVbrepdQymRsJQpgi0XWm50Z1cqKSyfiu4G+C0WYbOAO4frxo7HKZfEwbwld4xR5OyuJhLSobkCaNB+UBSVdsf815zK5KvAdnpaO6pNoBP2nNgtHwIpQ+ur8jPZQH/LxiI/tNieKiEyIDaY6kU9UGuFNbYUp6kmigJdpp/7O+JlvMObS7VZRafHLmjYAmwZo+Zk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(921020)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW1hMDVsV0RyZmhreWV6dFdmOGdnZW5qUlJESnZTSzZtN3RXL0w3ZzZTS1d5?=
 =?utf-8?B?VVVZY09JdGxjK3drNnJpN1hpUkpmRmFqZHM5WS8xSmRTSmpmZ3Q0SFR2eUpm?=
 =?utf-8?B?SGhWZ2tlbEFrSDJzc3hoTEwreTdIcENOSXdjcERUa0VTV3h4WUxDRWVjWkpW?=
 =?utf-8?B?QXhOWXdrRS8wTWZwT0tlMjROdEtUNU9Wakt1ZTdFdG5TRUVBcFBOM1N3TEJm?=
 =?utf-8?B?NytYL2ZHLysvZlZ1VHZpN1JxbkxqanZaVG9rd05ReXJ5aVEvdTc0SVVRd3Bm?=
 =?utf-8?B?ajB6K2J2eDY4a2tiNXRaTk5kb1BUMlhLbkRJbGgyZE10UldhdE5hbXBxcmJD?=
 =?utf-8?B?MWxlalZETzdackw4ak9XSDQ3YnloK05TNStyWGJsUXl2MThsbHkxbmNmVnZr?=
 =?utf-8?B?QnJsQUl0R3JwNnNub0V0bTgzSXBTaE5weitWMlhGTU1LWU1qZUx5WmVFcmhv?=
 =?utf-8?B?STZKNGNJSmZsWnNuRm5WVW5wZmE0T3JOMkMwSllmeWNCMThjd0x0MkQwK2U0?=
 =?utf-8?B?aXM4dFdWelV5ckNNV2RUemxyZDN6NG5xVUQ2SktpMkNRTjk2L2RpRjk1amwv?=
 =?utf-8?B?SHQxQmQvcEtjb2lWQjByMHhqeTFLSk15bmhFUW16ejlNdVpGbTJBejZtQ1Vp?=
 =?utf-8?B?cDNucmRCc2xDaFpvTGRBUWRUdGZ5aGd0Mk9tUmlka1d1SGplMkJiS2NBeUVL?=
 =?utf-8?B?ZmpkOTZBV25wZWlVNGVDMjdDa01MWENWL3BHWkM3bFNuNXlHZmJySzdsQ25B?=
 =?utf-8?B?TlNIaGxlQVNiMk0xd0p1V0lZQkkwdFJ5OUpadkw3eTZlNm1ldHZHV0luTEsz?=
 =?utf-8?B?b3EvdWFKRUdXbHZ0T3hTU25CL0JsYUphanFLRmJLb1dYbmp1UWVBRDl2Nnl3?=
 =?utf-8?B?WlFSSnNMYTQzVm1pVXFKN3o5SlUxSzY1aGZQaGhyOUh1QmJpQms0OWMwUzNN?=
 =?utf-8?B?cUVRbXdDVEZBbjFZUTJWNlg0d0RkV2NDTHZBOGlhOWRQM2JDR3hGT2ZXeUhy?=
 =?utf-8?B?UzVnS1FZZC9wa0pTTzVYMEtRbHJ4emNJSUZ2ZE5vVm0wTmxCaTczamVqSkc5?=
 =?utf-8?B?aG1yT1E4WjhsbFMrRVBuN2RmZXR2dFY5U0pCZkhvUXJkbVdUR1ltaGRZbjlS?=
 =?utf-8?B?K1g5d1dERjhiNlgyRDZycXRzTStnalF5aCt4Y1hDUEd1b0lGSU1iQmhlWXUv?=
 =?utf-8?B?eU1FcHVHODZKa2xzQ2h4WXFSMnVzbTJXRUR5Z3ZkcXhwYzUyclN3RzNLb2pM?=
 =?utf-8?B?dGxrTmlpVkVwa1VXMEhMSlltNlNBbjM2WlNHdllhakg4ZFVNT3p4ZlFBSGhs?=
 =?utf-8?B?MENabDFnQm5nUTFYN3FGWWFHdThSWnA0eC9UclE5Ymdmc2NoMTM0Kzc2UzZP?=
 =?utf-8?B?L3JseVhlZXlQbVRZZjdnelJqSXZTcFRUQXRTbnBMREVpMDJESzdzbnFaWHc5?=
 =?utf-8?B?NWVRRnRDeE13Yzd1MGVzU2VURXRMUWliVis1ZU1jVlNScFJXSjBQdXppbFoy?=
 =?utf-8?B?eFh0aHg4Y2YxdTdsNE1SamhoZTVUNUJZSkl6eEJpa3ZKTUdjZkhCNHdEbW52?=
 =?utf-8?B?OUhiR1duZDhPcG8wbllDZ2s3RmR4djZhN3VPY3R4RFFsUW50a2QrbmJ4UUtZ?=
 =?utf-8?B?UnBSVzAxd1dyUDUwZmJoV2VEK1RkQ0ZrVkR6em5EL0RHemw5dTB6UHlpbTMy?=
 =?utf-8?B?clJlWlNWbFA3T05VaFlneFdXQy8waENkekxzWW9GSCtNNzExeTVKMUQyRXZr?=
 =?utf-8?B?YVA5ZzlqcXZpbUFpUUM3bnFWYUVpYlhDenFQOTk5T0NzUVlVR254bnlkL3Ju?=
 =?utf-8?B?Z081YWVvSW1lakpUTURiQmlzVDI5VEhkbkdWeHZZSVVDZUN6NUVRNVRxVmtX?=
 =?utf-8?B?VmgzMjg1cWlIai9LVUVxQVE5cG9PSXRMVmV6blBUQXpiWE9VaitGOW0rNVZs?=
 =?utf-8?B?Qll4eE5IN0N6bkY4S01GMklpWDRwNnZyOFZlMHQ5Sk5BUWpoNFpIdVNCZm0w?=
 =?utf-8?B?WGxSNkRlT21PUkkrL3cxc2ZYc0FzQ3RDcHRkZ1FWQktIK3VRaWk5NmlZQzhO?=
 =?utf-8?B?SURXeUtSd0hwMjBEK01HYzRKMWNMV2dVM0puTHRscTRpYVZXMExwLzRudFN2?=
 =?utf-8?B?S3JvMlJSVFQ5UGtUdmc1blAraGVEVFpYVVhTMjR6V1U4V0NKVUF1ZnFSYmJ3?=
 =?utf-8?B?L1NFZlpFNnpPNHFDdURyUzRwcFVVbXpHTTM4d1h3cDMzQ1ZGU0VFUlovNEkx?=
 =?utf-8?B?ODlMZTVzQTJIVjRMWWdKS0xlOWYwL0laVW1YS1kxcHord1dvVjdVeU1SZ1F5?=
 =?utf-8?Q?LoolEufyKRQnBOiSpn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a328051-a410-4fef-a168-08dec5f9fa1e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:37:36.8371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JeY97Iz8HUcz687Qb2oG47jN7mxmuigzyTBDjft0v8tJaoG1djK9Zh+E+lJsRyiZAq5WHvRFHbCMJ4jZQxWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870


On 29/05/26 18:42, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/27/26 20:46, Sumit Gupta wrote:
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
>>    /sys/devices/system/cpu/cpufreq/policyN/ospm_nominal_freq
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
>>   .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++
>>   drivers/acpi/cppc_acpi.c                      | 35 +++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c                | 60 +++++++++++++++++++
>>   include/acpi/cppc_acpi.h                      | 12 ++++
>>   4 files changed, 124 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 82d10d556cc8..ac1bf1b89ac4 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -346,6 +346,23 @@ Description:     Performance Limited
>>
>>                This file is only present if the cppc-cpufreq driver is in use.
>>
>> +What:                /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>> +Date:                May 2026
>> +Contact:     linux-pm@vger.kernel.org
>> +Description: OSPM Nominal Performance (kHz)
>> +
>> +             OSPM uses this attribute to request a nominal performance
>> +             level lower than the platform-reported nominal. The
>> +             platform treats performance above this level as boost
>> +             and below as throttle for power and thermal decisions.
>> +
>> +             Read returns the last written value in kHz, or 0 if no
>> +             value has been written. Write a kHz value in the range
>> +             [lowest_freq, nominal_freq].
>> +
>> +             This file is only present if the cppc-cpufreq driver is
>> +             in use.
>> +
> Given that this value, based also on firmware behavior, can create vast asymmetries
> between CPUs, which the scheduler would be unaware of I wonder if this warrants
> a similar disclaimer like intel_pstate carries for their per-CPU EPP:
> https://www.kernel.org/doc/html/v7.0/admin-guide/pm/intel_pstate.html#energy-vs-performance-hints
>
> "[Note that tasks may by migrated from one CPU to another by the scheduler’s load-balancing algorithm and if different energy vs performance hints are set for those CPUs, that may lead to undesirable outcomes. To avoid such issues it is better to set the same energy vs performance hint for all CPUs or to pin every task potentially sensitive to them to a specific CPU.]"

Good point.
In v5 added below to the sysfs ABI doc, modeled on similar note:

   Note that tasks may be migrated from one CPU to another
   by the scheduler's load-balancing algorithm, and if
   different OSPM Nominal Performance values are set for
   those CPUs, that may lead to undesirable outcomes. To
   avoid such issues it is better to set the same value
   across all policies, or to pin every potentially
   sensitive task to a specific CPU.

Thank you,
Sumit Gupta


