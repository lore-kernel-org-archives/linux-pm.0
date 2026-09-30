Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613F4DDB49;
	Wed, 30 Sep 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799582; cv=fail; b=iq+U3KUIBPFf+YzprTI/F6e78yF0ZRHb0pi6Gd00Rgbep8PYHfeUMnMk5eU3+hxAbNd/+L8S3nxtVvB+UP5s+j8otcCBqMJpKxGXiXoHiIe8SjC72LRt3vVxCVeqMD1IXog2UTKMbFKTTFHItIXABhXWzW1/FGKmXlRsPt7DbN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799582; c=relaxed/simple;
	bh=lXmvd8NIzbyJWvka4G0BRInGTNiT9lgvgorcme7OMFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYcf2XG1JWyQLZS9gj9qHOQ3zzFT+weby2q/lctYlr8+eYujWsQ8Y2vWCff3DUoz/o32t5rNQAn1zJFwNeVg7vgy3GqKRZAZXKGX1jO/6fg1PvNuXvUJNLzrF/vAcmVeXCYKOu7ZIGVf/oSMHv9ZoG5Aeq3lndw/5I+3hzJzg0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PTj20q84; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PTj20q84"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgpijJMNU6OnXbet0JaBHH3KT9YJCa5hEpv0LzpYlc3CyuWYE/tY+jozGFrbnekgtW4Li+TC4WjS7+ci4Z7lM0iotZGM7SwTSNJpnKUpFuwd8b+9NwqXqGwn8haAotL7drbwgPOufs+w1fZJg757+FRIGRyPppCrax+0IAkEI0aEhVhhPrWpK3oHvlApmiR0oFx5U3mtC4g175uvRdm0tXlKULvLb9OtZVobCpQLzURlyMoeIVVkOkg33suq0saReTItd9Tq2pqpPTueB6JVqUyAkDkIRsNAgqLeoFsgCOud9yLybyWMMW8FxiR/dBsLFZAKsbivBbExYA7IqWCisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1hbigmh3VxH/24I9CA6skmURK9OSsSIfLo/yDr8P7U=;
 b=ZC5CUlD/fx0WrOyFH9vhKIqcQN53eQQmOqA9ixVYq7A/x97P8bwHF+eFG5uzh78aEnryRndn99HZT+W4CLv4eZVvphccaNcGv8dD1SdU1kJx6iaopGdTCku+JPPg3P9gIKQb35Qv/zkA8P+b+uIBs1mma4VLFo5OfIDD9vl413ssJVZY0R2ZBf7c0JMZT6iup/zHTyIsvhsE3nkeI5yI0W0iHLY1ZgUT9KwsrjmNGvWYcXCMpZz7jE/DkpWFbgUAuS3ScgT9UhavaaZkPiNvOdDQF59/qJyjVD9KjJUXPuUTykaGowDU6r8SsERDVDyTJEvRuIqJ2AU4z6rNMHW8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1hbigmh3VxH/24I9CA6skmURK9OSsSIfLo/yDr8P7U=;
 b=PTj20q84fwGe9cHz1yifqscAUYlsB+IT9ElSPLVDDo9plZgHmaSHAaLqpBVHpL+MAMlho694VcHC2wnqi1v2MnMCaXkejhp+jzCd29bJ/9300uYEKtellBl1yhpaYKLugkgl+NSbgGczJYE09uWJYGfPAPNLaAnLalxyY832FK8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 20:19:35 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 20:19:35 +0000
Message-ID: <d6d8912d-cc39-4af7-bb78-4d8095fb094b@amd.com>
Date: Wed, 30 Sep 2026 15:19:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] cpufreq: CPPC: Add ospm_nominal_freq attribute
Content-Language: en-US
To: Christian Loehle <christian.loehle@arm.com>,
 Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org, viresh.kumar@linaro.org,
 pierre.gondois@arm.com, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, lenb@kernel.org, saket.dumbre@intel.co,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
References: <20260807214837.863209-1-sumitg@nvidia.com>
 <20260807214837.863209-3-sumitg@nvidia.com>
 <e539dce2-1b2a-45cc-9ea8-1ab0e0f11972@arm.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <e539dce2-1b2a-45cc-9ea8-1ab0e0f11972@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0129.namprd13.prod.outlook.com
 (2603:10b6:806:27::14) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5fdb0b-83c8-432e-c6e3-08df1f302517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|10067099003|4143699003|56012099006|921020|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3ufpbTQDpJTIcmfTx33lwIXyDplapLS0Q3P/MLysw/cjrLqDz9y29vl8loN+W59G1aRiAhf2J2lmKbe6LpyXxbO7oeY2PXSqRa9UZ7BRKDae/yIZSA4yyONy0SMtHEn1OrPMzroVsi7b3wDH/NqATzoyy6LvVT9MmbkeLSHiDvjEUKJudA9HA7BAQkrKV9o91lh8ehNVIfr3njkryrHGJW5PQAwdidVWEku9Z0ty60DBmQ3C9RfScxvYULsqF26Md1z1OEYTFZoy/vlGj7rQSvlTMbeLFNJtPwlK1UAwh/hVpmMba3rydm+G3cIb1iu/I7YEHhuO2+jekmzBPWzY3Xax35TOsAvN0GpvY4s3LGdgNhpLVWAOiymo83KEbRnL8+q/tp1cJEkxEJPx69lLqBqGRyQceYaZ7bNXyWHgDq7kv1PA+n1BaZ9RjMt1Q6q+ZAvN55efwr9v49PJFkhYmxTR2X8EM3A5RENGawqv3tTp7/tHclH43L7dbYLGc8bC55KV7zO1JlMBhSdcKi/Zuql32Gmx6ke5ubdx1MShGDcywywWtIwPqQZXdt0LQEdObwCnIqCStOhM+5f0zjHWVx7fePx6WRDfLGJJ6hEUNepCN3QH/GGxXFSOnw/J5P0A79l573NMNAKlofff9l0DL2xhO5eSyfTWC+sy5Neo2jzbF1BQzGjV9u5xmsu8Oj97kImnKDgLpPWRDA768bW50A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(10067099003)(4143699003)(56012099006)(921020)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y096aFg3UVZxV2VtbU5BTk43VHBHRWk3bmZhLzFhUHhnS0xlb3g3dVN6TXdv?=
 =?utf-8?B?OVRUQ09YMGw4enQ5djdNVzcxQkYrZEJyTkV1a0ZRQjlEZmZ5eFBibG93Vkwv?=
 =?utf-8?B?TzIrT0tNSk1ta1hES3c1UlZUYi9lM1lCV3VMVEV5aUV5VlNtekhibnZTQllV?=
 =?utf-8?B?by9YQ3h6Ykh1ZitXNEg4eTloQUlVTkxsT0NhMWU2dytFekFvODRrUHpSOEJu?=
 =?utf-8?B?TjJ5UEtOUTVKVTNHYWlIUGNwU1FwaVVSWGRjSExLeXkyd2VGRFE4NVBhaTBY?=
 =?utf-8?B?VVgwcDhxRzhCTG90YVNvZG94MCsrbTE5aUxzay9JeXhUZ3A2YUVtQ1BtTWow?=
 =?utf-8?B?U0hVMDBqVmtyQkI0MGwyWUIzaTdlVkgxNEplcC84Q1c4T202WTJjdk1MTEJH?=
 =?utf-8?B?aTZJeVZOZ3ZVbWFKMnN2QTZNOTJCc3Q2UlRvdGtySlR1NkswUnlZcElVeDk3?=
 =?utf-8?B?SGFyUXJkRG9kdkF3RzhXNUxWWFB4Zy82SUpjTkQ5VWpKK3h2U1FxWFdrTlZn?=
 =?utf-8?B?bDZ2SUJzZFdVSGg1WlU3am5EeWM4aW50clorS2hJWU9WYzNNTCtKZWJnalJL?=
 =?utf-8?B?L2U4cVA2K2p5anJGZ0ZUQTNsMThzMkNWNlRya0tTVXovT1VZemNpQTJsRDU0?=
 =?utf-8?B?V010MTJTMi96YzRKU1U0RUtQMmVzTDZ6MG96ZHNwT0JZMWpXQjNjejZLNE9z?=
 =?utf-8?B?cFFDN2RvS0p4VnpuMUt3ZUhxUm02cjl4Wm94bTJtRzJwMVVrbXdXU0hOeFRD?=
 =?utf-8?B?MWhZNHlwNWpTV0IwZjBtdVB6Skx6SGozOTBwdFo1dnVJU2tFY1VHTTBsb2tv?=
 =?utf-8?B?d01xcE0zakhkS3lmS1ZJZEtqTGxNQjBHS25LUm5Tczg3QUY3Mjg5eUE4Um44?=
 =?utf-8?B?MkRLMStmREh3YzVtckhqUndJTHpybmpxNjNuVXFQTWMwUVlVL0UrUThjd3Zu?=
 =?utf-8?B?T0R3TWxHWHM2V1JkTFVGR01UTkwxeTE2N3g4Tk05QUZZYnZ4ZWRIc0Q5cjhi?=
 =?utf-8?B?UHB4UmhCRFo3STNrYVQwbGdjdE1EVlBMNWJNL1oxdHh0ajZsWTBUek9KRGw4?=
 =?utf-8?B?bzJMb2cwSTVVQ1Q1djFJMDkyWnNyb3VUOHp5OWhtS2N2N1BwbFFkb293WlRX?=
 =?utf-8?B?L1BXZnBpMm9OaElSNGoxVUJ4cHlHSDdnYSswRk91ZGkyVTRlc2RvNWtobHVF?=
 =?utf-8?B?WG5YYkFGNFRNNnpZOGwwRk5OWTBoV2J2NTRxenhyV2E0SHdvMUxaR2lsb1JO?=
 =?utf-8?B?ZmJaaStJSVZCTXArV1pnRHFxRlEybnY5a0dPQU5FRkpWTnBxYU9pQ3Q1UHhx?=
 =?utf-8?B?VWgwRWN2Y3dVSFFWUXJiUnVzVFRUQmpFN0xSM0xMcjN2aWRnc3BOaEg3c3V4?=
 =?utf-8?B?aUNtVEUveDhML09lSUl5WWkvYUdWRTF5OWFKSld0bDBLSUdyTUZpVGszeFIv?=
 =?utf-8?B?cGNoMGY1T29tVEg3TWwrbnVPM0ZMTmZuVkVpcC9mVU5MbUFlQjljMTlMaEw4?=
 =?utf-8?B?L01JanJySG4xMUhIek55cjB6UDA3NXFLbWkvUjViQUQ2dFRwNzk4b05xYk9n?=
 =?utf-8?B?ckEyWnkxMHhRbHhNam9FYStRWkR6OHA3YVpyNktCTExySWxwQnR6N2Fzd2RB?=
 =?utf-8?B?VndQOFN1Z2E0WCtVOEZRU2tOTUJGMGZxSFg5eCsxSGRwUUY5QnhxbGQrK1Vr?=
 =?utf-8?B?R0t4Snd5c1BVakdPNERUT1FrbVdYSlNXc2p5T2VhNTFNekM1bUJQTDljMENu?=
 =?utf-8?B?QlgxMnp0WmNQUlVtSXFtZlNXUk5IVmFXSVZISUQvVWpRcUZPQ1oyZGEvWEVt?=
 =?utf-8?B?K1VTK2ZKektJKy9YMFFWS0JVTUMrd0FmcWRONUczMHI5c2UvbE0yYVVXYkp4?=
 =?utf-8?B?SXA1dktvMFdFZG0zVnlodG1zOWVhSFZJajVDbGErL1hHYVZwaklSSFlIWi9L?=
 =?utf-8?B?SHNKeURhcVNtY3BJcnRhOVB3eG92VEJjQy9iYW9WczJhMWZtNVJTcHVHUWxx?=
 =?utf-8?B?cjJhN3ZpVHkzN1dDOXB0Vm1SOEFPRllsNzJYZGtyUEZPN2NXeDdocHFTaS9I?=
 =?utf-8?B?QUVlY1NDSCs4YjZnQWZkT0REbmowczFkQ3BTR3c5QnNqTkVIK2xHeUJIZFFV?=
 =?utf-8?B?alhrK3psQi96NnFFb2J0Y2xJR0dyMDB5d2lzQkhXQVArN2R3Z0M0Uk0vQk1D?=
 =?utf-8?B?a0pxUGNtdUh0TlNTZk42bUYvdlN0Y1ZNWUIxaGhHWlZxZFJJcWZxWU5yMUND?=
 =?utf-8?B?TDFWZk94SXBmcVJvWk9COWp0OFh0dnRYaVpQWEErZysrdG85YWF1QzBaNDBY?=
 =?utf-8?B?c2c1d09uam0zWERzaTlkQ3RRdzI2RkhNeEJ0R1lralNGZlowQzNCZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5fdb0b-83c8-432e-c6e3-08df1f302517
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 20:19:35.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9Js3fXk8RKnJboGUHvOE0tLc7vx5Y+vDP5Xchypf1WI+PAdYHwntzUEJvKHxTFI/FBXcoxD0zbooUG9rFpytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362



On 9/28/26 10:19, Christian Loehle wrote:
> On 8/7/26 22:48, Sumit Gupta wrote:
>> OSPM Nominal Performance (ACPI 6.6, Section 8.4.6.1.2.6) lets the OS
>> request a nominal performance level below the platform-reported one. The
>> platform treats performance above that level as boosted and below it as
>> throttled for its power and thermal decisions. A lower value moves that
>> boundary down, so sustained work runs at a lower point while the range
>> above it remains available as boost.
>>
>> Expose it as a per-policy cpufreq attribute in kHz, matching the unit
>> convention of the other frequency attributes:
>>
>>    /sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>>
>> The attribute is write-only as the register cannot be read back. Writes
>> are converted with cppc_khz_to_perf() and rejected unless they fall in
>> [Lowest Performance, Nominal Performance].
>>
>> Also track the register in the OSPM-set save/restore table, so a
>> requested value survives CPU hotplug and suspend/resume. The store
>> handler records the request rather than init() capturing a firmware
>> value, and driver unload reverts the register to the platform-reported
>> Nominal Performance.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   .../ABI/testing/sysfs-devices-system-cpu      | 24 +++++++
>>   drivers/cpufreq/cppc_cpufreq.c                | 70 +++++++++++++++++--
>>   2 files changed, 90 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 82d10d556cc8..59aafcb2af97 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -346,6 +346,30 @@ Description:	Performance Limited
>>   
>>   		This file is only present if the cppc-cpufreq driver is in use.
>>   
>> +What:		/sys/devices/system/cpu/cpuX/cpufreq/ospm_nominal_freq
>> +Date:		August 2026
>> +Contact:	linux-pm@vger.kernel.org
>> +Description:	OSPM Nominal Performance (kHz), write-only
> 
> IMO exposing this as write-only feels an awkward interface, when we can just
> return (-EOPNOTSUPP, requested_val, or <unset>)?

I guess since it's tracked in the OSPM set save/restore table your point 
is valid.  It could return an error until it's set and then the value 
that was last set a "check that it got set properly" in case multiple 
software interact with the file.

So to that point I agree with your suggestion.

> 
>> +
>> +		OSPM uses this attribute to request a nominal performance level
>> +		lower than the platform-reported nominal. The platform treats
>> +		performance above this level as boost and below as throttle for
>> +		power and thermal decisions.
>> +
>> +		Write a value in kHz, between the frequencies corresponding to
>> +		Lowest Performance and Nominal Performance. The register cannot
>> +		be read back, so this attribute has no read side.
>> +
>> +		Note that tasks may be migrated from one CPU to another by the
>> +		scheduler's load-balancing algorithm, and if different OSPM
>> +		Nominal Performance values are set for those CPUs (through
>> +		different cpufreq policies), that may lead to undesirable
>> +		outcomes. To avoid such issues it is better to set the same
>> +		value across all policies, or to pin every task potentially
>> +		sensitive to it to a specific CPU.
>> +
>> +		This file is only present if the cppc-cpufreq driver is in use.
>> +
>>   What:		/sys/devices/system/cpu/cpu*/cache/index3/cache_disable_{0,1}
>>   Date:		August 2008
>>   KernelVersion:	2.6.27
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 32f38b0c492b..fe714e71826a 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -33,11 +33,13 @@ static struct cpufreq_driver cppc_cpufreq_driver;
>>    * reapplied from online() across CPU hotplug, and the firmware value is
>>    * restored from offline().
>>    *
>> - * Autonomous Selection (auto_sel) is kept first, as writes to the registers
>> - * listed after it only have meaning while autonomous selection is enabled.
>> + * Autonomous Selection (auto_sel) splits the list: the registers before it are
>> + * independent of it, and those after it have meaning only while autonomous
>> + * selection is enabled. Place a new register on the matching side.
>>    */
>>   enum cppc_saved_reg_id {
>> -	CPPC_SAVED_AUTO_SEL,
>> +	CPPC_SAVED_OSPM_NOMINAL_PERF,
>> +	CPPC_SAVED_AUTO_SEL,	/* Entries below need auto_sel enabled. */
>>   	CPPC_SAVED_EPP,
>>   	CPPC_SAVED_AUTO_ACT_WINDOW,
>>   	CPPC_NR_SAVED_REGS,
>> @@ -50,6 +52,11 @@ struct cppc_saved_reg {
>>   };
>>   
>>   static const struct cppc_saved_reg cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
>> +	/* Write-only: the requested value is tracked in software. */
>> +	[CPPC_SAVED_OSPM_NOMINAL_PERF] = {
>> +		.name = "ospm_nominal_perf",
>> +		.set = cppc_set_ospm_nominal_perf,
>> +	},
>>   	[CPPC_SAVED_AUTO_SEL] = {
>>   		.name = "auto_sel",
>>   		.get = cppc_get_auto_sel,
>> @@ -79,6 +86,9 @@ enum cppc_saved_type {
>>    *                   could not be read
>>    *   requested_val - value in effect when the policy last went offline,
>>    *                   reapplied at online(). U64_MAX if none
>> + *
>> + * A write-only register cannot be read back, so its store handler sets
>> + * firmware_val and requested_val instead of init() and offline().
>>    */
>>   struct cppc_saved_vals {
>>   	u64 firmware_val;
>> @@ -135,7 +145,17 @@ static void cppc_cpufreq_save_regs(struct cpufreq_policy *policy,
>>   		st->suspend_regs_handled = false;
>>   
>>   	for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> -		if (cppc_saved_regs[i].get(cpu, &val))
>> +		const struct cppc_saved_reg *reg = &cppc_saved_regs[i];
>> +
>> +		/*
>> +		 * A write-only register cannot be read back. It has no
>> +		 * firmware value to capture, and its requested value comes
>> +		 * from the store handler, so do not overwrite it here.
>> +		 */
>> +		if (!reg->get && saved_type == CPPC_SAVED_REQUESTED)
>> +			continue;
>> +
>> +		if (!reg->get || reg->get(cpu, &val))
>>   			val = U64_MAX;
>>   
>>   		if (saved_type == CPPC_SAVED_FIRMWARE) {
>> @@ -197,6 +217,12 @@ static void cppc_cpufreq_apply_saved_regs(struct cpufreq_policy *policy,
>>   	u64 auto_sel, val;
>>   	int i;
>>   
>> +	/* Registers before auto_sel do not depend on it. */
>> +	for (i = 0; i < CPPC_SAVED_AUTO_SEL; i++) {
>> +		val = cppc_cpufreq_saved_reg_value(st, i, saved_type);
>> +		cppc_cpufreq_write_saved_reg(cpu, i, val, saved_type);
>> +	}
>> +
>>   	auto_sel = cppc_cpufreq_saved_reg_value(st, CPPC_SAVED_AUTO_SEL,
>>   						saved_type);
>>   
>> @@ -1385,11 +1411,46 @@ static int cppc_get_perf_limited_filtered(int cpu, u64 *perf_limited)
>>   CPPC_CPUFREQ_ATTR_RW_U64(perf_limited, cppc_get_perf_limited_filtered,
>>   			 cppc_set_perf_limited)
>>   
>> +static ssize_t store_ospm_nominal_freq(struct cpufreq_policy *policy,
>> +				       const char *buf, size_t count)
>> +{
>> +	struct cppc_cpudata *cpu_data = policy->driver_data;
>> +	struct cppc_saved_vals *st;
>> +	unsigned int freq_khz;
>> +	u32 perf;
>> +	int ret;
>> +
>> +	ret = kstrtouint(buf, 0, &freq_khz);
>> +	if (ret)
>> +		return ret;
>> +
>> +	perf = cppc_khz_to_perf(&cpu_data->perf_caps, freq_khz);
>> +	if (perf < cpu_data->perf_caps.lowest_perf ||
>> +	    perf > cpu_data->perf_caps.nominal_perf)
>> +		return -EINVAL;
>> +
>> +	ret = cppc_set_ospm_nominal_perf(policy->cpu, perf);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Track the request in software: requested_val is reapplied across
>> +	 * hotplug, and firmware_val makes the register revert to the platform
>> +	 * Nominal on driver unload, since the value cannot be read back.
>> +	 */
>> +	st = &cppc_cpufreq_policy_state(policy)->regs[CPPC_SAVED_OSPM_NOMINAL_PERF];
>> +	st->requested_val = perf;
>> +	st->firmware_val = cpu_data->perf_caps.nominal_perf;
>> +
>> +	return count;
>> +}
>> +
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>   cpufreq_freq_attr_rw(auto_select);
>>   cpufreq_freq_attr_rw(auto_act_window);
>>   cpufreq_freq_attr_rw(energy_performance_preference_val);
>>   cpufreq_freq_attr_rw(perf_limited);
>> +cpufreq_freq_attr_wo(ospm_nominal_freq);
>>   
>>   static struct freq_attr *cppc_cpufreq_attr[] = {
>>   	&freqdomain_cpus,
>> @@ -1397,6 +1458,7 @@ static struct freq_attr *cppc_cpufreq_attr[] = {
>>   	&auto_act_window,
>>   	&energy_performance_preference_val,
>>   	&perf_limited,
>> +	&ospm_nominal_freq,
>>   	NULL,
>>   };
>>   
> 

