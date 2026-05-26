Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7E41B340;
	Tue, 26 May 2026 18:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819864; cv=fail; b=h9mpoqveLhDqKC0CAfd/naQjXBCAXLhXkldZuNWIj4twRJ3nbQPEiY/Ptd/jxaOTavB6lC8lkGyRJERyZnOZtSjxUiK3QDntl6weB/8py6kP6f+tu84wlHs5MvlpX6vpHt7cT7CObWv7y9MxvsuZMveQbKx7oicky30ZUGpFVFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819864; c=relaxed/simple;
	bh=Z62M3mQBHtfsfN+qGR01OaVoxSduFIlvVgDwKECcieM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ttYbYiRWeYeXTYktsQTS3CnjUWWFydFfUtXRBMdvpuyt7rWGZ/C/PWoI5tWaCPg0BhQTVpAWDdZYSMhbTucBNnYSY+0WWBFCAWLq3Mzjzwj1S56WNtNd6iAg+dt66QZBSD1ReZVOrBdeUa6nYMBFtKVr31sefbYh+N1xIpI29JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U3ShEFeX; arc=fail smtp.client-ip=40.93.195.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U3ShEFeX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3EJuq2nvhlW0QJiyp+4Obn5mM8LV4DVWL683lv64/Dnm3fGOhN4DbA4ZpN0DH+bUiZiZo452//ZiM1Rm2CXMkvKBU6xtuLtIqiP8ZWTSsyGznYj1zoq6Nhy8B3J7K6qMQicKN7mPIeWbfMFGv20c0INFqMqkFy+r2wZQe1DiabKgppTFK8k5tO1ADIRcBmJli5SXbkJZx2aj2/CmTPgvGYhxh3TpDLywGHEqKfxAdy4JWJ7hSBQVwmtE1RzQTtMlAb7BtbpMFmO0Lo20HZSwNkAT15rk9aehN8m1FA81wcvXCBZoUTWdHucOUoJdqOSGlfOasUtgDy38w5xPFlVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqdymI6yPYgfFgBeQCl2Qs7KFonqppgHPAfUK1BthOk=;
 b=eNpDWAa5LSAolxZrrjluX9Lnc98W6obIgkZ17m6HrqD2BkboYgnhGeHEI5oGTcCHi2Xx+geA/yB/hiPFe5iGRwLIEj1A7VLdDxfxbayv4vhdD3aa/7om6rFIkAJ4g/GucB6Ok9+UlyzurMvPtZt2YvwekqNvojK0RECG87wrlBKGsuftJ982yeL4Z2FjFScl+qG1X6csF88/vMJ1DIm/qE6lE+F5XNzqKPtB3OE5rBewCKAeyFphiRO9q4c1gKrnvHnCgAzn0w/lUem5GxfBzZ/8Z3rRSsvuVwn3suKWgTU7qqjn94a3lt4dGdLxLnVuPkXNdpdLNmKIfN3ctj4dNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqdymI6yPYgfFgBeQCl2Qs7KFonqppgHPAfUK1BthOk=;
 b=U3ShEFeX0SE/A6wss9emIdfG/GJUNGb/9CKBIVZlvTePwH4SCZRbHgksO6ICjZwYQWvCTRNDayRqwtEMYqKD9gYy343P7ZSBGAoLSE41hxzsdkOzV8EoptDj0iVdj8SphDH8TGURnVLk7cqrwn0mcRdKGmaMnR+g8OQqGy5EMvcmBrTsIH8HbZ8HE2GS7mkLFyD/uEMIHRhsdK+mOGmzWmVZlUP7a56+/9J4l3szFwbb9cI1eZaCQXk4I51MV4c+rSo4rnqQQdx2era5d3+7lydaGGRHdV4fcf/ft3TX2ojLrpq4vAHT5Ctm5mA3L436zFC7/XsvwpHL32RVesQTsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 18:24:14 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 18:24:14 +0000
Message-ID: <5bf877d5-42b8-4e0d-9afd-6cb9c4b45bb1@nvidia.com>
Date: Tue, 26 May 2026 23:54:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, mario.limonciello@amd.com, saket.dumbre@intel.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, bbasu@nvidia.com,
 sumitg@nvidia.com
References: <20260514194822.1841748-1-sumitg@nvidia.com>
 <20260514194822.1841748-3-sumitg@nvidia.com>
 <457972d4-eabd-4db9-8d82-b4c6a5f79465@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <457972d4-eabd-4db9-8d82-b4c6a5f79465@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::8) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV2PR12MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acdf460-0f23-4ccc-dd40-08debb53fd59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|11063799006|4143699003|6133799003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	e/4AxlMreKbRhXOtAIcwKgUDy9VEr8sLak5KYmhCslXZSU0VQgZ3ssSCNQxul7gnfBwFls7IBAn7qlpNstILOCI34mQLBP4qbP3Dt2xjPkSvySujEYaVtbQcZegIUnJe3i/wOAt2ladBTDb7G0szrdReg4NCiwZm+KJznoVKXvadInOjU8eF8TlL0kk1tmNsylVRmmuoLyf4uSRBegXIUnraKs9+HvYBqBFd/fg0hJ31x2OOXIeo79VGg9QuWfQw1qaDIMZa5zO5FS8GMwIW09kGIzKJ7pzpJ7l3loRtvr0taDxSyN218iZXVGO8zVsbj7EF8eoGESkkKX60FHRWmhiJER6B7AvMZkEXZSPeRYFcsw6hx3VJ1aHZvMa3t9OMt9FRL7LZ1dK4kMa8avoa9RRItBJaEfJdxde6/whw6NwSGEX6o+EtT4SFQ5G6WrbL/u4H9nLowbQNOuOuKdzqb3HSgBWZ7FVQDHEhB6FS9tZt9e/EkEvNNyp3B6WtZUOUh3VBW53y7HcBncPo/VcMwwjjYuwb9TACazfxJ0GWV26cxc/ZJfnQ3fSn5ZWjRuFBygm0nCCEI375HgfwV/+Kdf7EIECLP18XuTl/caBRSdJLuUpZTa0mVciAC1S396glubdbSA6NoNUnAB3TLGim/DQBQtQMTLxrdNwi8I/Y/6gE7wyJRcR2XnEQY8tXHAXOecb5FJ7nfQsJ3lBAu+FYxvWczpKyOsvU/WiIY6v5ps8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWgrNmVvVEFTSkdRV25JaHdoR20zNjFNemJNQjZVbm5VbVNpalpQT3J4Rkho?=
 =?utf-8?B?SFA3OFN1RDZ5VWdXbGV1TUwveFJ6M0d2N3BPZVpTWmY5MjA1NjBneG00Ullu?=
 =?utf-8?B?R3JMUStkTmVNQ0dtYTZ3SUs3ZTk4ZFBDKzZLUFhvMW56WlE3L01kcUhIWTUx?=
 =?utf-8?B?SGEzOHNLMXRYUmhTRUhqVXJvQ3Jjai9rbDRwZlB6T1QrdytKYWd3cGRmVUta?=
 =?utf-8?B?T29vL1NnUXRzTFhPOWR0TmM0ckVaa0V3Z3BNQmlkYmNwdWd0Q1hyRC94dW1r?=
 =?utf-8?B?RW9WaTYxQy9yUEdhT3J4L2VBam0rNEI2aWQ2b2Qxc2JtSmRDS2hGTndXL25C?=
 =?utf-8?B?bmZyKzJsZ2prelh4N05iS2MzOE1OL0k2RFJlblcySmdEUGVYeklXVStKQ0hH?=
 =?utf-8?B?cmxMbjBHdVBZNHlRVklCZE5YTStUYXlnNUpSMG9DQTBBdXVCRmNmNSthSU8r?=
 =?utf-8?B?aXpIc3o3VDRINFBDa2kwZkVFSTBLUlRjYlVQZmZCR3dsbUY2bHNMNzJVUkdG?=
 =?utf-8?B?Y0JhVXoyMVJzRml0RklQN3AwcTJQdmh6UWJZaHRsTmlVdWNHeWZoWGFLUEgw?=
 =?utf-8?B?SnFEc2dpOHN1b0RHZ1IxWG9BcW1pNGhnUGV5Wk5lS1phYW5rTVRLb2JONC9y?=
 =?utf-8?B?Ull3WjFWQk1nUXVRc1RXTWVPZnJiN012b2grdFNmMlNvN1NtczMyYlF3dUUw?=
 =?utf-8?B?ZUQ5bzVSR3YzSDErMVpuL1Q0MlhKSmU2di9MSm54cm16RGZNSWZEcjNxWXlU?=
 =?utf-8?B?TkJPTDMrR0pxY0lZMkFZV0t4VHorbjdmcHpkWUdZa0tRN2x1NmFKOVhwUnZF?=
 =?utf-8?B?OERGdVRLYjNiRDZKMzlIcHFLRDdtU3dCMnFMT0VyUjhZYzg4RTBUUERjTkp3?=
 =?utf-8?B?bXhKZ0FNVEJTMDRwR0JLa21aSm1CQllLU2RjU2VmdjNiQ2YwREY0VEYxMW5j?=
 =?utf-8?B?bVNiRndOSlFlZXgvc2o2OVYvY1pHSzYwSWtJbDk4NWI2VW9LazJ1dVR1UFJm?=
 =?utf-8?B?Qi9HYjRjWVR1aHJyZjFtbFdGdG0zNzVDbEFqMWhUNkltMjZaYXRMd3grM3VB?=
 =?utf-8?B?K3Q0SVJxckNodmhvaEJIUGVKNVdZd2FrV2JOY0gvc0NjVGRGdW96ZldvbmNP?=
 =?utf-8?B?Z3ArSFp2cndtMVNYa3dVR3UvSGJHVDZIT1ZNNjBzdTZWaGJqaWF1SU1od084?=
 =?utf-8?B?N1IrbW5yVENjN0NhcGVEY0xVWmg1ZDNqTjlkWlBiRGh6TmlNYWJveHBhdjNW?=
 =?utf-8?B?ME1EK3hQcHRUUDd0ay93aGw4QmxreUZNL2FtT2tleGVEVGhua254N0RKWlV1?=
 =?utf-8?B?R2NIQnFTOHhCenBTeFA2T2VheDR2elFYSm1NVWNLODhTSWU3NnBRWThyRW9P?=
 =?utf-8?B?a3phYWVJaXZYOVBIU1lxcUFMd2FqR3kySUtia2VWR2tucUJhZ2g2YjcxNzRm?=
 =?utf-8?B?YThrWE9QY3VNcXF3dS9MY29sRHNqZERESG9KMnViSUUyVlpOMUtGS3k5M2Zr?=
 =?utf-8?B?M3BWREZhUnViOEh1YVdZNnNPaS96eWI3RkNZVlo3MXFzMmRreVVNUVY0bzJE?=
 =?utf-8?B?OXp6WDF5dUljcEgyL0kyWTg3czRLOVk3TytRcWNIY0dMNmswdXpZNm5ra2JC?=
 =?utf-8?B?dWRNUUN3aDNJdTFIVWVSNE8rV3JvTHdaMzVRaTJtWVlZcXRIeHR4a21uOGI4?=
 =?utf-8?B?VENrUFFMNDFiaHdzaSsySERJclJUVmxOL3RCQlZsRW96OUkvd2FZazZ2ZXVL?=
 =?utf-8?B?dGg1SEVzTkFTYmJwU2FTVDdHOTM3eHMxM0N0RVBBNVd5Tmo0ZTRpNGVlRGZo?=
 =?utf-8?B?VVFiSU44RHF1NFlpcE1RNFZ6ZEowYWdYdE1wdDhwdlc2NGFRQWdMc2pRTUV0?=
 =?utf-8?B?aDIrY3pUWjNqWmlsYmRWcnpqQktoVGVsN1VUUlVhemFSTU9hUmIrZXBuNUxX?=
 =?utf-8?B?bzlEdzVtc1pwYUN5dUpWYnNxSzUwcXhwL2NRcWRjVkswa0p1VVlPZTZMdFhI?=
 =?utf-8?B?bDA4aStsOFRtTnllOUlLRkJoTHNCNzZXejJKdTJWTW1JQkhkN3FZNzRXd2dB?=
 =?utf-8?B?Uk5LMWdUVjFhTS9PM1NVMk5IY2FTM2xybDRWMEFZSThDaGVMM251cWNiSWF0?=
 =?utf-8?B?NGRpdEU4Rzk2TCtmdnlKQW1aaE1aTjJwbTdFVk1uaTJoclI5T0RWdTZXd3Nm?=
 =?utf-8?B?bkV2ZmtTZm5qNzA0VTFlNXJZSlgvLzNBMHlkWWcrSzdZS0tKeU1SNHduMXBW?=
 =?utf-8?B?SWYrUVBDcVBjdmhVdXZmN05CbTFnSURnZis1ejJIM2hhUjdjYnR5V3JrWlpw?=
 =?utf-8?B?K2tzQ2t3eUVOWnpBakZlb2tiU29WYnp6QzJ2aWFuUlkweGkyMEFtQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acdf460-0f23-4ccc-dd40-08debb53fd59
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 18:24:14.2202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Wsm6b80vCwoVQII/hbxFG+uZwb2Q3xqtKLdy8gK/L3vJ2OYQT33/QKp0bf8nFjUBqPm4x69fwi6gPqOB1K4IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5968


On 21/05/26 22:28, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> I copy-pasted and attached a complementary patch just to show
> what I meant by caching the ospm_nominal_perf value at driver
> init/exit.
>
> This should also allow to handle the cases where a user tries
> to store a new value for a policy with multiple CPUs,
> one of the CPUs and we need to rollback.
>
> I think another issue that should be solved is that:
>
> - we don't the value of ospm_nominal_perf when loading the driver
>
> - we leave the register in an unknown state if we unload/reload
> the driver.
>
> Note:
> IMO caching values like in the patch would also benefit to the
> auto_sel register.
>
> ------
>
> If you think the patch helps, feel free to take it. Otherwise
> please let me know the issues it would raise.
>
> Regards,
>
> Pierre 


Hi Pierre,

Thanks for the review and the complementary patch.
Going point by point:

1. Rollback for a partially applied multiple CPU write in
     store_ospm_nominal_freq(): Agreed, will add into v4.

2. cppc_get_ospm_nominal_perf() and the show/init/exit coherence
     checks that rely on it: I'd skip these as the register is write-only
     as per spec.

3. Initializing the register at startup and restoring at exit: In v3, we
     dropped the unconditional cpu_init write so user values would
     survive CPU hotplug. The spec also makes the explicit init
     unnecessary: "If this register is not provided, then OSPM must
     assume that the OSPM Nominal Performance value is equal to
     the Nominal Performance value.". The unwritten default already
     looks well defined.

4. pr_warn() in show_ospm_nominal_freq() on HW vs cache
     mismatch: Skipping it since it relies on (2).

So in v4, will pick up the rollback and leave the rest as is.
Happy to discuss further if you think differently.

Thank you,
Sumit Gupta


>
>
> On 5/14/26 21:48, Sumit Gupta wrote:
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
>>   .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++++
>>   drivers/acpi/cppc_acpi.c                      | 35 ++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c                | 40 +++++++++++++++++++
>>   include/acpi/cppc_acpi.h                      |  7 ++++
>>   4 files changed, 99 insertions(+)
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
>> index 7e7f9dfb7a24..6379b7ceee34 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -985,11 +985,50 @@ store_energy_performance_preference_val(struct 
>> cpufreq_policy *policy,
>>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
>>                        cppc_set_perf_limited)
>>
>> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, 
>> char *buf)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int freq_khz;
>> +
>> +     if (!cpu_data->ospm_nominal_perf)
>> +             return sysfs_emit(buf, "0\n");
>> +
>> +     freq_khz = cppc_perf_to_khz(&cpu_data->perf_caps,
>> + cpu_data->ospm_nominal_perf);
>> +     return sysfs_emit(buf, "%u\n", freq_khz);
>> +}
>> +
>> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>> +                                    const char *buf, size_t count)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int sib;
>> +     u64 freq_khz;
>> +     u32 perf;
>> +     int ret;
>> +
>> +     ret = kstrtou64(buf, 0, &freq_khz);
>> +     if (ret)
>> +             return ret;
>> +
>> +     perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +     for_each_cpu(sib, policy->cpus) {
>> +             ret = cppc_set_ospm_nominal_perf(sib, perf);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     cpu_data->ospm_nominal_perf = perf;
>> +     return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>   cpufreq_freq_attr_rw(perf_limited);
>> +cpufreq_freq_attr_rw(ospm_nominal_freq);
>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>       &freqdomain_cpus,
>> @@ -997,6 +1036,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>>       &auto_act_window,
>>       &energy_performance_preference_val,
>>       &perf_limited,
>> +     &ospm_nominal_freq,
>>       NULL,
>>   };
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 8693890a7275..0b1dcdbea10a 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -153,6 +153,8 @@ struct cppc_cpudata {
>>       struct cppc_perf_fb_ctrs perf_fb_ctrs;
>>       unsigned int shared_type;
>>       cpumask_var_t shared_cpu_map;
>> +     /* Cached OSPM Nominal Performance value (write-only register). */
>> +     u32 ospm_nominal_perf;
>>   };
>>
>>   #ifdef CONFIG_ACPI_CPPC_LIB
>> @@ -180,6 +182,7 @@ extern int cpc_write_ffh(int cpunum, struct 
>> cpc_reg *reg, u64 val);
>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls 
>> *perf_ctrls, bool enable);
>>   extern int cppc_set_epp(int cpu, u64 epp_val);
>> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>> @@ -266,6 +269,10 @@ static inline int cppc_set_epp(int cpu, u64 
>> epp_val)
>>   {
>>       return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 
>> ospm_nominal_perf)
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_get_auto_act_window(int cpu, u64 
>> *auto_act_window)
>>   {
>>       return -EOPNOTSUPP;
>
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu
> b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index ac1bf1b89ac4d..f3d357917242a 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -356,9 +356,7 @@Description:        OSPM Nominal Performance (kHz)
>                platform treats performance above this level as boost
>                and below as throttle for power and thermal decisions.
>
> -               Read returns the last written value in kHz, or 0 if no
> -               value has been written. Write a kHz value in the range
> -               [lowest_freq, nominal_freq].
> +Values are in kHz and in the range [lowest_freq, nominal_freq].
>
>                This file is only present if the cppc-cpufreq driver is
>                in use.
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 97218c4ac162b..01542184e69b2 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1717,6 +1717,19 @@int cppc_set_ospm_nominal_perf(int cpu, u64
> ospm_nominal_perf)
> }
> EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>
> +/**
> + * cppc_get_ospm_nominal_perf() - Read OSPM Nominal Performance 
> register.
> + * @cpu: CPU from which to read register.
> + * @ospm_nominal_perf: Pointer to store the OSPM Nominal Performance 
> value.
> + *
> + * Return: 0 on success or negative error code.
> + */
> +int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf)
> +{
> +return cppc_get_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_ospm_nominal_perf);
> +
> /**
>  * cppc_get_auto_act_window() - Read autonomous activity window register.
>  * @cpu: CPU from which to read register.
> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
> b/drivers/cpufreq/cppc_cpufreq.c
> index 6379b7ceee347..1a51017a81630 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -28,6 +28,9 @@
>
> static struct cpufreq_driver cppc_cpufreq_driver;
>
> +/* Values at driver init. */
> +static u64 scratch_ospm_nominal_perf[NR_CPUS];
> +
> #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
> static enum {
>        FIE_UNSET = -1,
> @@ -642,7 +645,7 @@static void cppc_cpufreq_put_cpu_data(struct
> cpufreq_policy *policy)
>
> static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
> {
> -       unsigned int cpu = policy->cpu;
> +unsigned int sib, cpu = policy->cpu;
>        struct cppc_cpudata *cpu_data;
>        struct cppc_perf_caps *caps;
>        int ret;
> @@ -704,6 +707,34 @@static int cppc_cpufreq_cpu_init(struct
> cpufreq_policy *policy)
>        if (caps->highest_perf > caps->nominal_perf)
>                policy->boost_supported = true;
>
> +/*
> + * CPUs are expected to have:
> + *   ospm_nominal_perf = nominal_perf
> + * at policy init.
> + */
> +cpu_data->ospm_nominal_perf = caps->nominal_perf;
> +
> +for_each_cpu(sib, policy->cpus) {
> +u64 ospm_nominal_perf;
> +
> +ret = cppc_get_ospm_nominal_perf(sib, &ospm_nominal_perf);
> +if (ret == -EOPNOTSUPP) {
> +continue;
> +} else if (ret) {
> +pr_err("CPU%d: Could not read ospm_nominal_perf value\n",
> +sib);
> +goto out;
> +}
> +
> +if (ospm_nominal_perf != caps->nominal_perf) {
> +pr_err("Incoherent ospm_nominal_perf values: "
> +"scratch_value=%llu expected_value=%u\n",
> +scratch_ospm_nominal_perf[sib],
> +caps->nominal_perf);
> +goto out;
> +}
> +}
> +
>        /* Set policy->cur to max now. The governors will adjust later. */
>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>        cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
> @@ -727,9 +758,17 @@static void cppc_cpufreq_cpu_exit(struct
> cpufreq_policy *policy)
> {
>        struct cppc_cpudata *cpu_data = policy->driver_data;
>        struct cppc_perf_caps *caps = &cpu_data->perf_caps;
> -       unsigned int cpu = policy->cpu;
> +unsigned int sib, cpu = policy->cpu;
>        int ret;
>
> +/*
> + * CPUs are expected to have:
> + *   ospm_nominal_perf = nominal_perf
> + * at policy init, so come back to that state.
> + */
> +for_each_cpu(sib, policy->cpus)
> +cppc_set_ospm_nominal_perf(sib, caps->nominal_perf);
> +
>        cppc_cpufreq_cpu_fie_exit(policy);
>
>        cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
> @@ -989,9 +1028,20 @@static ssize_t show_ospm_nominal_freq(struct
> cpufreq_policy *policy, char *buf)
> {
>        struct cppc_cpudata *cpu_data = policy->driver_data;
>        unsigned int freq_khz;
> +u64 perf;
> +int ret;
> +
> +ret = cppc_get_ospm_nominal_perf(policy->cpu, &perf);
> +if (ret == -EOPNOTSUPP)
> +return sysfs_emit(buf, "<unsupported>\n");
> +if (ret)
> +return ret;
>
> -       if (!cpu_data->ospm_nominal_perf)
> -               return sysfs_emit(buf, "0\n");
> +if (perf != cpu_data->ospm_nominal_perf) {
> +pr_warn("ospm_nominal_freq value is not coherent: "
> +"register=%llu scratch_value=%u\n",
> +perf, cpu_data->ospm_nominal_perf);
> +}
>
>        freq_khz = cppc_perf_to_khz(&cpu_data->perf_caps,
> cpu_data->ospm_nominal_perf);
> @@ -1002,7 +1052,7 @@static ssize_t store_ospm_nominal_freq(struct
> cpufreq_policy *policy,
>                                       const char *buf, size_t count)
> {
>        struct cppc_cpudata *cpu_data = policy->driver_data;
> -       unsigned int sib;
> +unsigned int sib, failing_cpu;
>        u64 freq_khz;
>        u32 perf;
>        int ret;
> @@ -1015,12 +1065,23 @@static ssize_t store_ospm_nominal_freq(struct
> cpufreq_policy *policy,
>
>        for_each_cpu(sib, policy->cpus) {
>                ret = cppc_set_ospm_nominal_perf(sib, perf);
> -               if (ret)
> -                       return ret;
> +if (ret) {
> +failing_cpu = sib;
> +goto error;
> +}
>        }
>
>        cpu_data->ospm_nominal_perf = perf;
>        return count;
> +
> +error:
> +for_each_cpu(sib, policy->cpus) {
> +if (sib == failing_cpu)
> +break;
> +cppc_set_ospm_nominal_perf(sib, cpu_data->ospm_nominal_perf);
> +}
> +
> +return ret;
> }
>
> cpufreq_freq_attr_ro(freqdomain_cpus);
> @@ -1053,6 +1114,64 @@static struct cpufreq_driver cppc_cpufreq_driver 
> = {
>        .name = "cppc_cpufreq",
> };
>
> +static void __exit cppc_cpufreq_ospm_nominal_perf_exit(void)
> +{
> +int cpu;
> +
> +for_each_present_cpu(cpu) {
> +if (scratch_ospm_nominal_perf[cpu] == U64_MAX)
> +continue;
> +
> +/* Reset ospm_nominal_perf to the value present at init. */
> +cppc_set_ospm_nominal_perf(cpu, scratch_ospm_nominal_perf[cpu]);
> +}
> +}
> +
> +static int __init cppc_cpufreq_ospm_nominal_perf_init(void)
> +{
> +int ret, cpu;
> +
> +ret = 0;
> +
> +for_each_present_cpu(cpu) {
> +u64 nominal_perf;
> +
> +/*
> + * If one CPU failed, scratch_ospm_nominal_perf still needs
> + * to be initialized.
> + */
> +if (ret) {
> +scratch_ospm_nominal_perf[cpu] = U64_MAX;
> +continue;
> +}
> +
> +ret = cppc_get_ospm_nominal_perf(cpu, &scratch_ospm_nominal_perf[cpu]);
> +if (ret) {
> +if (ret == -EOPNOTSUPP) {
> +/* Valid reason to fail. Continue to iterate. */
> +ret = 0;
> +}
> +
> +scratch_ospm_nominal_perf[cpu] = U64_MAX;
> +continue;
> +}
> +
> +/* Set ospm_nominal_perf to nominal_perf before policy init. */
> +ret = cppc_get_nominal_perf(cpu, &nominal_perf);
> +if (ret)
> +continue;
> +
> +ret = cppc_set_ospm_nominal_perf(cpu, nominal_perf);
> +if (ret)
> +continue;
> +}
> +
> +if (ret)
> +cppc_cpufreq_ospm_nominal_perf_exit();
> +
> +return ret;
> +}
> +
> static int __init cppc_cpufreq_init(void)
> {
>        int ret;
> @@ -1063,9 +1182,17 @@static int __init cppc_cpufreq_init(void)
>        cppc_freq_invariance_init();
>        populate_efficiency_class();
>
> +ret = cppc_cpufreq_ospm_nominal_perf_init();
> +if (ret) {
> +cppc_freq_invariance_exit();
> +return ret;
> +}
> +
>        ret = cpufreq_register_driver(&cppc_cpufreq_driver);
> -       if (ret)
> +if (ret) {
> +cppc_cpufreq_ospm_nominal_perf_exit();
>                cppc_freq_invariance_exit();
> +}
>
>        return ret;
> }
> @@ -1074,6 +1201,7 @@static void __exit cppc_cpufreq_exit(void)
> {
>        cpufreq_unregister_driver(&cppc_cpufreq_driver);
>        cppc_freq_invariance_exit();
> +cppc_cpufreq_ospm_nominal_perf_exit();
> }
>
> module_exit(cppc_cpufreq_exit);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 0b1dcdbea10a2..07e6598fa837a 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -183,6 +183,7 @@extern int cppc_get_epp_perf(int cpunum, u64 
> *epp_perf);
> extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls
> *perf_ctrls, bool enable);
> extern int cppc_set_epp(int cpu, u64 epp_val);
> extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
> +extern int cppc_get_ospm_nominal_perf(int cpu, u64 *ospm_nominal_perf);
> extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
> extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
> extern int cppc_get_auto_sel(int cpu, bool *enable);
> @@ -273,6 +274,10 @@static inline int cppc_set_ospm_nominal_perf(int
> cpu, u64 ospm_nominal_perf)
> {
>        return -EOPNOTSUPP;
> }
> +static inline int cppc_get_ospm_nominal_perf(int cpu, u64
> *ospm_nominal_perf)
> +{
> +return -EOPNOTSUPP;
> +}
> static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
> {
>        return -EOPNOTSUPP;
>
