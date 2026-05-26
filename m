Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F528A3FA;
	Tue, 26 May 2026 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822188; cv=fail; b=lXrShi2RAL3xHGbJn7Jy0t1v8ONZ9CD4FJUK+7zm/CTT2Ac9sKZJ+mM8+UldjWi6zrPAq8jpFPEzlSFu4Ivy5wz6xhtboSA8URCGgCuTwrdrWHhPUCzeRRVJlbEfFGHjSJ3BqliDxYTR+zCa+m9wB/mv1gZSn956X83ew6oU/9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822188; c=relaxed/simple;
	bh=XFNxX4jdkCGZ2NRRQv79GJlM+TO/gWOwHgzL08JdGTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sG2bEiOSz79TYRK1nrmokGyTMAqtmEmfArmsetPhLa0Pl/tlCl9FYWwgVAi46A3uHInfEkh0kAertnJarL7CONladG/Y+Ywf4gAl41Sx2PeiTEcCIaPy4mMTUE+1cGDWIjDu1lLosxsZaKuwgJi1mz49SWFrOj82p7TqDB7Lltk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6oI77Ia; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6oI77Ia"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wzPoZhwFghUcqqgdlcSZR4fyr3XAggU+6bNtb/aL8poZ1TGPeNJJAubz/fWACewNtaCVB65Iy04Mf6i2aP9pfWDNxCvGtlj6rL2+5ucL5AJIomL/DtAfSXfTPQWlmjijM/yVjG2Wn960ziuqOOmbpxbtsboYFHvbtS9OaV6OCEKFYJcM0OBCvN2ecElGuHWIfZ85WpB/UHwfP34zMYPwT18u/F05NQCIeSV16lHHsWpDu21SsFLdOADK5Ni8oTHCf6hBn4oxr4Tb8ZaN8vPro6fr2bKtbIMQWdahHlsWWCho3m5fUCQuNF3cq/owPenzy6BrQy3KgDVEDJJlNEV1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQk4CJPvupLmZD6DsWC/XdrhYU6oNICaRUxMrCTC5Sk=;
 b=VDwa+/KYqzFFRAN08esj7ZROTlx10uG8PRMs5CItgHsG3GkMol6lZyoCmRnh5fHSklSXXf4VSLqvt3rUx4S/lncn+bnMgCgY2LvFC1qQubU3PmWUlqz6RV01ojHSf0R18ObK26pkzM3rWKNS2/DTIJbL8JYyr0JavCGC7TOQ3Je8vP72VQUMKXByyv+JLTInoNNAykIUEG3Tzwni6ebwtSLhfqKpRuivLm4P8vCwK1IMNyxLmm8qmGgqdkL5K6eeZikbGbDH5tg+iodZM39601NPUVg0AF3ByRNuh/xhAohEziUP6cyX1gHpJ6z/tnjHT+27pKZO701KwG57J90vQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQk4CJPvupLmZD6DsWC/XdrhYU6oNICaRUxMrCTC5Sk=;
 b=L6oI77IaMg7FjnPEyW+VPKohe8FrytPYpN/lHp8P+gmKkZB3ROW1HT1D1uKncAcp1v631WfqG2fM/r2e+9hpPnvJucKtzNVMjd1/zwhPYbsI+u91fqqWWNfN15arqihyMClW1ppP91q6ZBq49jAVC5ywP+mVvtCqeJJ3b+9NOZUbzAjlJeBSL/ZpuigBNRTFKdN6CzV/BG2Yj0rcq8f55vPh6RtqzOWUMW4ldX/1aiZLcjVJCyqjq8PlnEr2Rcbnd/KgpksbVM4bxlEkfikyL88tqrgGbT0cuQVaRBnmM3Jb2OwQhm0gmB/ucBymubKjwHerhLBZlrC0V7AqOr2jBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 19:03:02 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 19:03:01 +0000
Message-ID: <b812fa74-46b4-4797-94a9-d5397fb36a97@nvidia.com>
Date: Wed, 27 May 2026 00:32:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ACPI: CPPC: Add ospm_nominal_perf support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, lenb@kernel.org, pierre.gondois@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, mario.limonciello@amd.com,
 saket.dumbre@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260514194822.1841748-1-sumitg@nvidia.com>
 <20260514194822.1841748-3-sumitg@nvidia.com>
 <CAJZ5v0gfgSTwwTHVyCiJfG7QCPD5fgXc2dJDJ3Q8R+qxe6YGLQ@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0gfgSTwwTHVyCiJfG7QCPD5fgXc2dJDJ3Q8R+qxe6YGLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::16) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: b155f17b-2ad8-4174-deec-08debb5968a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|4143699003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SVmc9y6i0NlG3R0bbhvuc08ltT1KiqhntiDE1yHTFTPxAkKZqwXVDc63CF4BdCRwwz0ttYzUcqLhyTOgSrFFjhuD4QmE1SMGLqqV9FqAqJsRlfcRnVZ1y/knwnJQnxsn2VX0WhYrDjGWtASc04Cu2prC+Md16M+fenxN/AF9tBIKJSecIKkZiMjvK7f5sD0TbXzEMmVfO7IWDi2aLHDwoIr+68+I9d4yq3Vy5EyOXItpbOjFEio1DmD294O1dt+6WC7VwS6G2p63x3RO9PJqFu/7WuGrG+iPN9871YyyCyTCrpCIb4bMvDNv992sAVpjg1PnEjN/EM5TRKIM6fvYx+oMLr1m6cx6aQH0lC5D7YEQXWrRLvi0HKDVhWKqQQIul06uDLaRdFQhg+AZzZbU3Vsy2EZHDv5sUjW6u7pX5xgywS5C6+x4ZByvJgEa1uPyfGdm7o0w8iTp4g1tfwbsQ8Ogpl+k03YvMKy0/2K726AnhCtneMO5odobztcb/G+F+RbmHMrG9J0c0Yvf7FDiQdiVjPXuBf4ozNYwybewXzeBcFr2B1HdcTuSae/NaQUFRengQVtIEOikdqI/TUAjk1iokPdZ+mgWMCTtHTiCUFr3sv/raqIk+9l05WWfDGBSQhafg73XCBa8C+N1N5f1CeLBo27pi5QbymG9UdXeqeYWlDcSa/xJcO02ibm3VZN3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0FMNGpWT3hCcXlaTDBmY1lxb1l1b0ZJTFNOTjhyazBRQXJwdERnai8xNHdZ?=
 =?utf-8?B?UjNpKzh2a1FzT1dwZ21SQVo4aXk5ZEhuMGtkcnhKSXlLZHRPRnNPQkpwK2kx?=
 =?utf-8?B?U25qSEZlYThOTUUxRnNEZHZWV3ZoOGRSRmFBMFAyc00wUTA1bStkMjJNQklR?=
 =?utf-8?B?eS9pN0N0RnFtTG1ZM1kxRDQ1aGROVEdrcUNTWC95WGVtVVN6SFpvWlpTTmND?=
 =?utf-8?B?ZldYcXlReVMzcnBJZTQ4Qmg1YU5MZXJmeFcrTUVXbmdSQVI1eHAzMkVZUDd3?=
 =?utf-8?B?RTNHWXdhZVhkSXVzSVQrSm9oNVpNTG5PV3Z4UmdyQkRvUm1UNDA2V3BzYVg5?=
 =?utf-8?B?eCtlNzhuaHRkZ1o0YzM2d3BQTFJNRWVRZnd4bURqYmNKa3JTa05tcW13U05o?=
 =?utf-8?B?bS95TlVuQ0ZGV0J3aWRXaC9RRUoyd29FSGg0WHRtT0o5bEhjKzljWEVSSkRV?=
 =?utf-8?B?LzkxeWtkWGdRUXd0OUpHWjNHTkx2RkJSL1lmNEN5K0tYd1Z4VDlBOEVPZTZm?=
 =?utf-8?B?bkdhSGF1azV4T3FHaE5NNnd1VHRsNm82TENOQXhqejJKNnc0Ymk0cG1EamVz?=
 =?utf-8?B?R05EQ21UK3VvY0xaenpxb1VieTZuaTBLSFdFT2xETXdVVmJxTkx3REZpWEpF?=
 =?utf-8?B?enFVV3haOEJ6dk5rMGw5bUdnaTh0aUVZQ1pnYjc4aml3RXJscDFSVTVrdVR1?=
 =?utf-8?B?cXRVMExHVmVBZkF1ejRXVDVQQVJzOHd0MVV1TDgwNDA2Tm95M2VZSk5rZEtG?=
 =?utf-8?B?YS9JREF5Sklsa0cyYnVnVkJtY3dNeE8raURWY2k0MURuUkNDM0xQcVQzVXJr?=
 =?utf-8?B?c295RFZhNURQMU1jVG81N0Nnd3dEVXorNUVNUnZ4aGJDZG1paGVWYXE4VVlm?=
 =?utf-8?B?cWcwc0xLNWNhWG1mMkt5cmZsOG51UFFYWTJGcmQzQkdHK2ttSmZTYVJPQ0xw?=
 =?utf-8?B?SWx2MCtGNW4zbytjRlZYczArV09RTkFqQXBNVXBnZ1MwcVFGamFDaERndkRw?=
 =?utf-8?B?KzNVTDQyTmpwR0huVDROU3BGSWplbGtFVEJWOU43M1RjQTlKU2VtM0NnWElh?=
 =?utf-8?B?T01TNC8vNUhqWXBzMHUySllnbUsyL0Vub2dhQVRXZzg2WDJqYlcrRUFYTUtX?=
 =?utf-8?B?VXVONy91cU4xa3Q3ajRpcy9TVXlGbjExZDQ3UFhSN3ZmWEJwbU1nZ0h3clhF?=
 =?utf-8?B?UDN1SnJ0YWUxaXBwU25xcHJFM3ZGY2RZOUc5UmVLdlkzZVdBQ0x0OEFhWmdS?=
 =?utf-8?B?ZGEvb1BBTGR0QXROWTljSytNT0wrZkdrK1VHdlV4cE1xVXJPUG14T2dWQ05m?=
 =?utf-8?B?eEh4R1pNYStZREtVL2FLUG9zUEFTM09WYkVpdXpONGVlVnVlMW12ajdJQk1h?=
 =?utf-8?B?MkE4TXJTMXM4dHFSOEJxaDIxdmpEVW1RbDUvU2lLMW1Vd1p0ME9BUHdYcE1R?=
 =?utf-8?B?TjJ0S05lK1RMZjZvWWlyaVViYXhPTGhqTlFYZ2NudVE2WGRPQ0o0T3pNKzlW?=
 =?utf-8?B?YnNnUE5rRnArMWpWYVhlUXBMUWluTnJyN1dyZUY2cXVoQmFzb2k3d3c2QlhB?=
 =?utf-8?B?Tmp4amNpUkJzWURMVjVIblM1TDd4aTI4U050eHpqVWZZdnV0M3NkdkpEaS9p?=
 =?utf-8?B?UEFnM3A2K1VtZVpWaW1tR1lxaHVQK0dOZTE4WU5TcVZVZjdzRjB5ejJHbTI4?=
 =?utf-8?B?RDNHYzA0L0NTdk5CZWpjdHQ3UW9VZlczeWVVN2UvZ1dkU2w3SHpBdXFmby9y?=
 =?utf-8?B?eXlaWDI0Y2grTDhNci9JVmtVSVJ2M3RUU1Bpd0E1Z1lyK1FaN2FQY1hTeE1P?=
 =?utf-8?B?WnQ5eTRHTnQ2ZGw2OS9sR2RMSWh5UXRMY09hdmJFekZvN0VjdWYwUGsrbFV4?=
 =?utf-8?B?alFYUGk4UUNjVytYUCtSSjI1d0ZsTkI3M0swdXZzKzJJSDRoUVZVQmdEOEhQ?=
 =?utf-8?B?TlViOGJ4TEx6c3NZcmhjbGE1TmtwdnJ5cjZIdzhuSVhlUEh2U2NtQytPSVNE?=
 =?utf-8?B?ck5RdVQ5RnA4ZVJ4T2lLYjRjRUNGWnFyRFo1c0laU29LSWRCdTZ4TXQrYmhr?=
 =?utf-8?B?NFE0ZzNXdGhFNnJsRkxnS1VrSEdJaVN3enZaTkRaaXdYZ1BaWTdHRHZnazZn?=
 =?utf-8?B?UUNaUFpkejBVcWZTL01wa25iK3Rpek1Sb05ZZEVlYkdHRk1HY2lEOVZHZ2Fr?=
 =?utf-8?B?M1RoUEJJalZ3VUNMN1JBS0hYQUVTaVJVLzNnZENrQ1FZb0txdUJGV0t6V1lS?=
 =?utf-8?B?bmsrckpNb3o1VjkvcFd4R1pMR0ZjZnBYaGhyaXU2aUlyTHRzUmFrR25td1dY?=
 =?utf-8?Q?awLip02V3H/HNrPThq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b155f17b-2ad8-4174-deec-08debb5968a9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 19:03:01.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f+NJo7wifado37cVd8wPT2gdJ+ZKXl8uSjxbpSpi69TLjA9Q+aNKYYRX3YcGquiTXEkbZ8k+44LGDkcp8f8nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281


On 22/05/26 22:50, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, May 14, 2026 at 9:49 PM Sumit Gupta <sumitg@nvidia.com> wrote:
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
> Please see sashiko.dev's feedback on this patch:
>
> https://sashiko.dev/#/patchset/20260514194822.1841748-1-sumitg%40nvidia.com
>
> and address it, or let me know why you think that addressing it is not
> necessary.


Hi Rafael,

Sure, going through the Sashiko comments:

Patch 1:
- Comments #1 and #2 were also raised in the earlier Sashiko review.
   They are pre-existing issues with rare occurrence.
   Will address them in a separate hardening patch.

Patch 2:
 > Is it possible for a platform to define lowest_perf as 0?
....
Will fix by adding a bool cpu_data->ospm_nominal_perf_set to
distinguish an unwritten cpu_data->ospm_nominal_perf cache
from a valid 0 perf write.

 > Does passing the 64-bit freq_khz to cppc_khz_to_perf() cause a silent
 > truncation?
....
In v4, will switch freq_khz to 'unsigned int' and use kstrtouint() instead
of kstrtou64().

 > If cppc_set_ospm_nominal_perf() succeeds for the first CPU but fails on
 > a subsequent sibling, does this leave the policy out of sync?
In v4, will add rollback in store_ospm_nominal_freq() to restore the
previous value on siblings already updated before the failure.

Thank you,
Sumit Gupta


>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++++
>>   drivers/acpi/cppc_acpi.c                      | 35 ++++++++++++++++
>>   drivers/cpufreq/cppc_cpufreq.c                | 40 +++++++++++++++++++
>>   include/acpi/cppc_acpi.h                      |  7 ++++
>>   4 files changed, 99 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 82d10d556cc8..ac1bf1b89ac4 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -346,6 +346,23 @@ Description:       Performance Limited
>>
>>                  This file is only present if the cppc-cpufreq driver is in use.
>>
>> +What:          /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>> +Date:          May 2026
>> +Contact:       linux-pm@vger.kernel.org
>> +Description:   OSPM Nominal Performance (kHz)
>> +
>> +               OSPM uses this attribute to request a nominal performance
>> +               level lower than the platform-reported nominal. The
>> +               platform treats performance above this level as boost
>> +               and below as throttle for power and thermal decisions.
>> +
>> +               Read returns the last written value in kHz, or 0 if no
>> +               value has been written. Write a kHz value in the range
>> +               [lowest_freq, nominal_freq].
>> +
>> +               This file is only present if the cppc-cpufreq driver is
>> +               in use.
>> +
>>   What:          /sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:          August 2008
>>   KernelVersion: 2.6.27
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index c76cfafa3589..ad6ece16c30d 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -1682,6 +1682,41 @@ int cppc_set_epp(int cpu, u64 epp_val)
>>   }
>>   EXPORT_SYMBOL_GPL(cppc_set_epp);
>>
>> +/**
>> + * cppc_set_ospm_nominal_perf() - Write OSPM Nominal Performance register.
>> + * @cpu: CPU on which to write register.
>> + * @ospm_nominal_perf: Value to write to the OSPM Nominal Performance register.
>> + *
>> + * OSPM Nominal Performance conveys the desired nominal performance level
>> + * at which the platform may run. Per ACPI 6.6, s8.4.6.1.2.6, the value
>> + * must lie within [Lowest Performance, Nominal Performance] and may be
>> + * set independently of Minimum, Maximum and Desired performance.
>> + *
>> + * Return: 0 on success or negative error code.
>> + */
>> +int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +       struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
>> +       struct cppc_perf_caps caps;
>> +       int ret;
>> +
>> +       if (!cpc_desc) {
>> +               pr_debug("No CPC descriptor for CPU:%d\n", cpu);
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = cppc_get_perf_caps(cpu, &caps);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (ospm_nominal_perf < caps.lowest_perf ||
>> +           ospm_nominal_perf > caps.nominal_perf)
>> +               return -EINVAL;
>> +
>> +       return cppc_set_reg_val(cpu, OSPM_NOMINAL_PERF, ospm_nominal_perf);
>> +}
>> +EXPORT_SYMBOL_GPL(cppc_set_ospm_nominal_perf);
>> +
>>   /**
>>    * cppc_get_auto_act_window() - Read autonomous activity window register.
>>    * @cpu: CPU from which to read register.
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 7e7f9dfb7a24..6379b7ceee34 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -985,11 +985,50 @@ store_energy_performance_preference_val(struct cpufreq_policy *policy,
>>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited,
>>                           cppc_set_perf_limited)
>>
>> +static ssize_t show_ospm_nominal_freq(struct cpufreq_policy *policy, char *buf)
>> +{
>> +       struct cppc_cpudata *cpu_data = policy->driver_data;
>> +       unsigned int freq_khz;
>> +
>> +       if (!cpu_data->ospm_nominal_perf)
>> +               return sysfs_emit(buf, "0\n");
>> +
>> +       freq_khz = cppc_perf_to_khz(&cpu_data->perf_caps,
>> +                                   cpu_data->ospm_nominal_perf);
>> +       return sysfs_emit(buf, "%u\n", freq_khz);
>> +}
>> +
>> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>> +                                      const char *buf, size_t count)
>> +{
>> +       struct cppc_cpudata *cpu_data = policy->driver_data;
>> +       unsigned int sib;
>> +       u64 freq_khz;
>> +       u32 perf;
>> +       int ret;
>> +
>> +       ret = kstrtou64(buf, 0, &freq_khz);
>> +       if (ret)
>> +               return ret;
>> +
>> +       perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +
>> +       for_each_cpu(sib, policy->cpus) {
>> +               ret = cppc_set_ospm_nominal_perf(sib, perf);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       cpu_data->ospm_nominal_perf = perf;
>> +       return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>   cpufreq_freq_attr_rw(perf_limited);
>> +cpufreq_freq_attr_rw(ospm_nominal_freq);
>>
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>          &freqdomain_cpus,
>> @@ -997,6 +1036,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>>          &auto_act_window,
>>          &energy_performance_preference_val,
>>          &perf_limited,
>> +       &ospm_nominal_freq,
>>          NULL,
>>   };
>>
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 8693890a7275..0b1dcdbea10a 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -153,6 +153,8 @@ struct cppc_cpudata {
>>          struct cppc_perf_fb_ctrs perf_fb_ctrs;
>>          unsigned int shared_type;
>>          cpumask_var_t shared_cpu_map;
>> +       /* Cached OSPM Nominal Performance value (write-only register). */
>> +       u32 ospm_nominal_perf;
>>   };
>>
>>   #ifdef CONFIG_ACPI_CPPC_LIB
>> @@ -180,6 +182,7 @@ extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
>>   extern int cppc_get_epp_perf(int cpunum, u64 *epp_perf);
>>   extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls, bool enable);
>>   extern int cppc_set_epp(int cpu, u64 epp_val);
>> +extern int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf);
>>   extern int cppc_get_auto_act_window(int cpu, u64 *auto_act_window);
>>   extern int cppc_set_auto_act_window(int cpu, u64 auto_act_window);
>>   extern int cppc_get_auto_sel(int cpu, bool *enable);
>> @@ -266,6 +269,10 @@ static inline int cppc_set_epp(int cpu, u64 epp_val)
>>   {
>>          return -EOPNOTSUPP;
>>   }
>> +static inline int cppc_set_ospm_nominal_perf(int cpu, u64 ospm_nominal_perf)
>> +{
>> +       return -EOPNOTSUPP;
>> +}
>>   static inline int cppc_get_auto_act_window(int cpu, u64 *auto_act_window)
>>   {
>>          return -EOPNOTSUPP;
>> --
>> 2.34.1
>>
>>
