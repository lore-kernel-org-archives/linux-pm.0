Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0F3D1CC1;
	Tue,  7 Jul 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783455265; cv=fail; b=ox/lbQH0WF5nz1gIlgWywFTSXyhitm/oqNzHr9GZfNhKmUM/G/ZmsG9cAYuIjGw6mudy8pjdJ8I60Q1Bq+Nz+2Dw9PvUR83dg9s3bzqHOJ58qkCk0i6A0f+6sMdpY86vz6XglRTbXtPwgpWl38kV31VVAB7dPcKwpbGpDhL0H7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783455265; c=relaxed/simple;
	bh=klFhKL62zJ6doUMe8JE5NYoDc5nUBsUa58QuB+6Zf+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JkXlC9b6tn/egUVzZXadAcPYo5g/MZtIbt2bUinqmPmNPEYdhQvxXBfxitjeY7UzxOsQBbKV1F+Acpnj5XmJGi1OISH1R1XleTXl6TMK+CzcLf9xiuiSlY4gcBoBJKNiIh5e4HJSy/jZck3cN/MW9bpwLnUtiVov7eLPgtoncno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1mQePrz; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1mQePrz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHoYg1d88V58FXDaisue0jb47enb/BjyZqMMG57IXT9rwCXVZyFaFFQEuG0g9pVhyhAQUpxP7hs8Cmho3Q2xB+rgdnvacr144kmuwc7cMma1xp0tj18jQnZ8h/pq8M+IYmAh5oe+8u/ioxTDv4i16WO2dlCyyJV8W+8LCrbj2fvoSxPMA5GqZghkk6OGsSB6SubM5qT0dsvQ8OZLKtQrejKTGsicRdC5W5IreFy0aUlCMk5c63LAnSzzUjfAmUjCJjYZC1sLXN6SKhyQtq+6ryhg+PhDXBTsRJAeUiDV0S1ZVtnMlv0Bm0JKkPrC0d0+iJkNMFAQHE9AvHpAEDELKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4UqBxYlBmb8+SQPiD/YH3p+UShiL+9HaoMBCs6gNts=;
 b=F7O8R0YIWONT3qU/wYE+ozRdzrwglC7MzErMhXiQc2ZgsVZhd78K6wD2BDKX5ircLcDizeyAY0hizCC9kOmEdsGRQR3vWeVCek1IPHeGQox/EAMQd+qz1eHqUtbnjjt5bH72gQJNJbzCSW+3OI5ca/tPRTsWiQ1QHF6PNSzae3HkEOhVJUG3F4jAJZSfZakiaViqKWrRUNEsPAC3mskPfIdi4U0RIQyfC5AtloX2ea7wt7bEo8Ox7to8upKHpgg+CJV9w9GH3nU9zHNDYQ3iqgim9xC18J73nK5QWrB4TIC3jrY8xlaao2d4/2g7eB8Z6UbatjOZ4nuXGmrSkrtTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4UqBxYlBmb8+SQPiD/YH3p+UShiL+9HaoMBCs6gNts=;
 b=f1mQePrzo4rdwsNbjk8/KyvYNxk6DiRtOTuakXB5Ar7Gs+CvmNVDL0t+5FjFeB0H2wkhwTCEAzzqZtS6sA/Oct7QqeLvtWkG8yFEQQWQT6f2wX+CVlBcIMEjqKd4cOXwwts894etFwQS3zyBdIpjEW0/0X5t6kotMLRYAhqNZLISPn+t6rm+q9uRlwl+wm20ecyKGIGKQTBTtK0oByY+tRgdUmNEHucBwWz8sjhGA5apI5xAfYcjRwDBKlA+DSNp7fdrUpuKQazDyOCCvQk5Q+BjdACpa61m6sG6Xj9WIjOPjOB9ImLnA+Q14Byu6LfxOF9hhawloVc4OHV+M1G35Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 20:14:17 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 20:14:17 +0000
Message-ID: <9c8bd525-4104-4091-9e97-32125c0dd227@nvidia.com>
Date: Wed, 8 Jul 2026 01:44:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug
 and unload
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260623095403.3407436-1-sumitg@nvidia.com>
 <83f2d177-3832-47a8-83fa-a3f558f78273@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <83f2d177-3832-47a8-83fa-a3f558f78273@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYPR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 66157da7-4adc-4e71-4a96-08dedc645279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VcSjV5J9Eb4PoUWJxk2ZqxQNBNqsm3g/AEXFcV9/Wfwx76n/r/d3Y4n2vfSVSLXpEKitwCWOL70FKrblwfXV3Crs3WVl9tnHIyIlfsKgG4tmEM6uty0aahN6NPADZ8EdDgkh6U79ZYHtSF29x9K77gnW4PiKxyOOKbfvFYRPLt6hsodhdBR953nib/2hAHoXp04NpbH/RWVXOCLW88+zV7OUGeP6pQGxRjsVs+Mh1nrB3GhOKqZEgSGk3v9boJacUrYB0BwznaMD803R/NKtjZNFxiq2pO/yBX4B3vyMAMupOWo8RbujQ90iZswSHBP1zvZD9PDW+b0EN8QPSI7fPVPMGe6vfpmnTSAYgIcK4R5KA6cmoLjvPwsKQqfzxMayxq6FrYdxjTxVTOxIM24DJ2XUQjUSyhGbzhK7T9vZOpT6xdg5g2YTExoVUVzJRE08SUc2WTcULWkZ1V105KEU9i7ppqoFX0Xl9UOMsnC938mImOGKs1lr0iEMbPH7Kto3x2BmSIbM+xvt0jPfi6s5wGltPBH/AzC9wQh8vG6JhSshlQP7fJyI0PS8iWGKZK3Rabx2zTNKOMg+DCgWt+iauEGliTg9uMXu7J3g95LgibE4uM9Mav4L40jrpsDZiu0RoJ6sUQZ1Nn+fkL7ywuSs37FSM6vhwp8srYx3df2/q24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VlZFlwd3VTNGRETHRoT0JBYTFBaU53Q013cFkrS3NqNWMySy91dTFYS2lq?=
 =?utf-8?B?MzJJNVRKRmpMZHlBQTM1N3pqamsxbmJYSzg5bE00cVZteGFaaXczbHRxZllB?=
 =?utf-8?B?NnpoOUhqMVJIbVd0c3hRRmcyekhHeEdhZnhXYXlGMzNLcWdPK1BOOU9HOFdr?=
 =?utf-8?B?V2pkUjFIR1VQTVdpZnRRZkJOc3dWckFEQXlkWUlnV1VNMkxTbjR5azcxOFM0?=
 =?utf-8?B?TFRndGoreHc3WmpEa1lXN2NybFlUekNVNDR5dm1PdXI5NDhEa08yUi9wamh5?=
 =?utf-8?B?RnNpNU50OTVQenlESktrajB4ZHU3T01yMm05cDB2TWtKbEpHUUpJNDdKWEpL?=
 =?utf-8?B?VVFWOWF5dmtkcE9icForMlhOVWtaWThmT1MxNVVFU0cvczFaVFdKdWFTSVA5?=
 =?utf-8?B?QkEvdnZvZ2kwNlRVYWE5WmRUR0orbUZ6ajNBdE5ibEpPUDRTM0pCSGsza0JL?=
 =?utf-8?B?WTFwdDhHS1B1bFRZSkxsODZnMEh2cWl6NVFvSUVFOHdzTjhrTGhMelB6OXNl?=
 =?utf-8?B?R0F0OWp2V2dLTVpWdUFsaUt2NFk5VTRuRmtFQ3NNOUltL0Fhakw4UkloR2Jp?=
 =?utf-8?B?QUtwcVAwNGtIdGpQdXBuUW9nV0VaaEZvKzlWZlI0SWhCV1kxOVY1RWdGaXZj?=
 =?utf-8?B?Nno2cW1lMUxxNmJmRUxBV3UvejRRM05JeG50OTBpajRhR21QOCtDcS90Y0ZI?=
 =?utf-8?B?TlA2c3g1N2ppK0FPVStJWXMxZGJ4S2gyWDJySjNYNjBRczhJM0JqZXMwVml3?=
 =?utf-8?B?SnJWQkRCemJtY0VhRzZKenFYYmI4bDl5UGlFa0RHMS96RHltdkVLeVlFR1hX?=
 =?utf-8?B?bkVVSU0xQnNoT3RlTkozcitmNUhocmRWYWttTkVZR250dDlYQTloNWJLdldB?=
 =?utf-8?B?ZWlab0hLdHJ6bTdad1ZnM2g5Vk9oSWxxUTE5dlJGUCtweG1aSy9PUVRMU0xp?=
 =?utf-8?B?cnYyOXQ2N1hhZVVxSUN1bUJvcWx3V05lWG4vUk5kY2YvLzRqcG01TUpYV1NB?=
 =?utf-8?B?TGN2ekZuUHhJOU9iaVpuSFlVa2NCNFAraW9ud09iRVpWejZFU25LUXZyckdE?=
 =?utf-8?B?Z0FXc1BlSjdJUjJUa2doOW1DaTJRanlzU2tVZDZDbklQNGtjN3lIQk94elI1?=
 =?utf-8?B?SSt3aFRlVFZ3UmsrMmZZNElzVFF4b3pMRFZlbDlLT1ByK25KMCtpWWhMYjVN?=
 =?utf-8?B?bGltZGtSQVVsU24wd0NLcHQvbXBTTUpvOUJTODZRWmYrYW5WWWhLYmh6RTdV?=
 =?utf-8?B?THdWaHFHMzJKRWN3WTg1clBBa2JwMHdBSm1MOXdSVnhIUXh6T1V0NUJCNXRZ?=
 =?utf-8?B?cnBGWEtIZzBEN0FzUGFhNUUyMWFleElEcWNuTUFTKzZVdnhYT2ZNcVJpNTVx?=
 =?utf-8?B?TUF0ZlZld0VjWDk5MnJxa1BmUStScUNiVVJERlJhQVNwSkluWDdEQ1dCV29S?=
 =?utf-8?B?aUVXZHVuYXFNY3RFeENnN2Nja3BTbU03cHgyLzNxZ1gwV3BtajdjVzlBZHgz?=
 =?utf-8?B?cTR6R0sybmRwM0R5d2tuZWlxSzdpejM3MjB3aVFBcWNkb3ZCNkowTnFSM3o2?=
 =?utf-8?B?WEFQbWZFNTlsMFZiZDRVbGdlNURMQkxRUnYzVytVdEVRRDZsZStlSGxnalor?=
 =?utf-8?B?T0hONXVMQiszNVFESDNRTlA5M054ZFI0VDJRWE9pR3BYckxhbDdua0lrZTl2?=
 =?utf-8?B?L1dzanhFNVJRQVRNNHRCRjBOM1hYc3oraGRjSEIwUHg3ME9acjNmNTZRNWRO?=
 =?utf-8?B?b21wUHkzRDJQWEFQakNzaUdjbXNOL1MzWWNlVlNLOWlhVjVHV2VvblA4MjNT?=
 =?utf-8?B?aWgyUmdVMXBucUdCKzN5Y3NFRnNLeFpxL1VBWGlKM3hyelVzR2xPQ0p0K0w2?=
 =?utf-8?B?TDAzTVMxQnA0Yk4ya0d6dElBOXdTeWdlRis0ZTAvazVmZy9DWEc3TW45MjRk?=
 =?utf-8?B?ei9wYmVrWmlWTFdWS0NXUmZCSitrTms2RFN2akVlSzFhN204MFNrczIrSXlq?=
 =?utf-8?B?cEd0UkR0MFM0bWR0Mzh4SUZneStoZm8wSzV4R1RWMFl5eGE2bE02Vmc4bFMv?=
 =?utf-8?B?NERyT2MxZHpIZnNwUkhqUmc1R3dEUVVEa292V3B1N2RaMm5uV2J5THlUTlIy?=
 =?utf-8?B?MHJ3YTNpMlRhakI0WUdjSUs0dnlOR3lDWGhaNnpTamlNbWJUMXpQZ0FtYUlK?=
 =?utf-8?B?T0JUOGV0WVF3ZENPUXhob0JmM1FoNzYyRk1QQmJlQ1RCOXhDNnkvaE9qdTJh?=
 =?utf-8?B?R1owSG1oVE5TSEZ1czkycG5pU1F2TFBpYkNrelNaY0lOemRXUFJhSzc0aGN6?=
 =?utf-8?Q?QCaDd0B7fWVjnaMu1R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66157da7-4adc-4e71-4a96-08dedc645279
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 20:14:17.5106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyjVUULyQzrJSI+BsGEmn8n7hr23ffX5sZl/XH1Nx3Wj/9q0KLvoAJDkrL0jgnMR7YsEypmZs24BK6tsKqEZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525


On 01/07/26 21:54, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Sumit,
>
> On 6/23/26 11:54, Sumit Gupta wrote:
>> Values written to OSPM-set CPPC registers (via sysfs or the autonomous
>> boot parameter) can be lost in two ways:
>>
>>    - Across CPU hotplug: the platform may reset a CPU's registers 
>> when it
>>      is offlined.
>>    - On driver unload: the value the driver wrote is left in the 
>> register
>>      instead of returning to its pre-driver state.
>>
>> Add a small table-driven mechanism that handles both:
>>
>>    - Capture each register's firmware value when a CPU is first seen and
>>      restore it on driver unload.
>>    - Record the last value the driver set and reapply it from ->init()
>>      when the policy is reactivated after CPU hotplug.
>>
>> The firmware value is captured on a CPU's first activation rather than
>> once at module load, so CPUs offline at boot or hot-added later are
>> covered.
>>
>> Reapply is only needed on a full policy teardown and bring-up, which 
>> goes
>> through ->init(). In a SHARED_TYPE_ANY policy, offlining a single CPU
>> leaves the shared register untouched, so nothing is lost there.
>>
>> Cover the OSPM Nominal Performance, Autonomous Selection
>> (auto_sel) and Energy Performance Preference (EPP) registers. For
>> auto_sel it replaces the previous unconditional
>> cppc_set_auto_sel(cpu, false) on unload with a restore of the firmware
>> value captured at the CPU's first init.
>>
>> Suggested-by: Pierre Gondois<pierre.gondois@arm.com>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>
>> This applies on top of (not yet merged):
>>   [1] ACPI: CPPC: Add ospm_nominal_perf support
>> https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
>>   [2] cpufreq: CPPC: add autonomous mode boot parameter support
>> https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
>>
>>   drivers/cpufreq/cppc_cpufreq.c | 194 +++++++++++++++++++++++++++++++--
>>   1 file changed, 186 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index a3fabfb07fbe..d6ea2cbde187 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,174 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/*
>> + * OSPM-set CPPC registers tracked for save/restore. A value set via 
>> sysfs or
>> + * the autonomous boot parameter is reapplied across CPU hotplug, 
>> and the
>> + * firmware value is restored on driver unload.
>> + */
>> +enum cppc_saved_reg_id {
>> +     CPPC_SAVED_OSPM_NOMINAL_PERF,
>> +     CPPC_SAVED_AUTO_SEL,
>> +     CPPC_SAVED_EPP,
>> +     CPPC_NR_SAVED_REGS,
>> +};
>> +
>> +struct cppc_saved_reg {
>> +     int (*get)(int cpu, u64 *val);
>> +     int (*set)(int cpu, u64 val);
>> +};
>> +
>> +/* u64 wrappers so the bool auto_sel register fits the table 
>> signatures. */
>> +static int cppc_get_auto_sel_u64(int cpu, u64 *val)
>
> Should these functions be moved to cppc_acpi.c ?
> IIUC, the issue is that cppc_set_auto_sel()/cppc_get_auto_sel()
> don't have the right prototype for the above function pointers.
> IMO there should still be moved to cppc_acpi.c
>

Agreed, I will move cppc_get/set_auto_sel_u64() into cppc_acpi.c in
a separate patch before this.


>
>> +{
>> +     bool enable;
>> +     int ret;
>> +
>> +     ret = cppc_get_auto_sel(cpu, &enable);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *val = enable;
>> +     return 0;
>> +}
>> +
>> +static int cppc_set_auto_sel_u64(int cpu, u64 val)
>> +{
>> +     return cppc_set_auto_sel(cpu, !!val);
>> +}
>> +
>> +static const struct cppc_saved_reg 
>> cppc_saved_regs[CPPC_NR_SAVED_REGS] = {
> Ideally it would be nice
>> +     [CPPC_SAVED_OSPM_NOMINAL_PERF] = {
>> +             cppc_get_ospm_nominal_perf, cppc_set_ospm_nominal_perf,
>> +     },
>> +     [CPPC_SAVED_AUTO_SEL] = {
>> +             cppc_get_auto_sel_u64, cppc_set_auto_sel_u64,
>> +     },
>> +     [CPPC_SAVED_EPP] = {
>> +             cppc_get_epp_perf, cppc_set_epp,
>> +     },
>> +};
>> +
>> +/*
>> + * Per-CPU saved state for each register in cppc_saved_regs[]:
>> + *   firmware_val      - register value before the driver touched 
>> it, restored
>> + *                       on unload
>> + *   requested_val     - last value the driver set (sysfs or boot 
>> parameter),
>> + *                       reapplied on policy reactivation
>> + *   firmware_captured - whether firmware_val has been read, so a 
>> not-yet-seen
>> + *                       CPU isn't mistaken for one whose firmware 
>> value is 0
>> + */
>> +struct cppc_saved_state {
>> +     u64 firmware_val;
>> +     u64 requested_val;
>> +     bool firmware_captured;
>> +};
>> +
>> +/*
>> + * Per-CPU and not tied to a policy, so the saved values survive policy
>> + * teardown/bring-up across CPU hotplug. cpu_data->perf_ctrls is 
>> per-policy
>> + * and freed on policy ->exit.
>> + */
>> +static DEFINE_PER_CPU(struct cppc_saved_state[CPPC_NR_SAVED_REGS], 
>> cppc_saved_state);
>> +
>> +static void cppc_cache_perf_ctrls(struct cppc_cpudata *cpu_data,
>> +                               enum cppc_saved_reg_id reg, u64 val)
> Is it necessary to keep the cpu_data->perf_ctrl.[auto_sel|energy_perf]
> values synced ?
>
> AUTO_SEL_ENABLE can be set using: - cppc_set_epp_perf(): AUTO_SEL_ENABLE
> + ENERGY_PERF - cppc_set_auto_sel(): AUTO_SEL_ENABLE ENERGY_PERF: -
> cppc_set_epp_perf(): AUTO_SEL_ENABLE + ENERGY_PERF - cppc_set_epp():
> ENERGY_PERF
>
> cppc_set_epp_perf() is not used in cppc_cpufreq.c, so
> auto_sel/energy_perf should not be overwritten inadvertently right ?
>

Yes. I will drop the perf_ctrls syncing (cppc_cache_perf_ctrls()).

>> +{
>> +     switch (reg) {
>> +     case CPPC_SAVED_AUTO_SEL:
>> +             cpu_data->perf_ctrls.auto_sel = val;
>> +             break;
>> +     case CPPC_SAVED_EPP:
>> +             cpu_data->perf_ctrls.energy_perf = val;
>> +             break;
>> +     default:
>> +             break;
>> +     }
>> +}
>> +
>> +/*
>> + * Save the requested value for the given register and CPU, to be 
>> reapplied when
>> + * the policy is reactivated after CPU hotplug. Also update the 
>> per-policy
>> + * perf_ctrls copy so the saved and current values stay in sync.
>> + */
>> +static void cppc_save_requested(struct cppc_cpudata *cpu_data, 
>> unsigned int cpu,
>> +                             enum cppc_saved_reg_id reg, u64 val)
>> +{
>> +     per_cpu(cppc_saved_state, cpu)[reg].requested_val = val;
>> +     cppc_cache_perf_ctrls(cpu_data, reg, val);
>> +}
>> +
>> +/*
>> + * Reapply each register's last requested value from ->init(), so a 
>> value set
>> + * via sysfs or the boot parameter survives a policy teardown and 
>> bring-up
>> + * across CPU hotplug. Also keep perf_ctrls in sync with it.
>> + */
>> +static void cppc_cpufreq_reapply_requested_regs(struct 
>> cpufreq_policy *policy)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu, i;
>> +     u64 val;
>> +
>> +     for_each_cpu(cpu, policy->cpus) {
>> +             for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +                     val = per_cpu(cppc_saved_state, 
>> cpu)[i].requested_val;
>> +                     if (val == U64_MAX)
>> +                             continue;
>> +
>> +                     cppc_saved_regs[i].set(cpu, val);
>> +
>> +                     /* Keep perf_ctrls in sync via the policy's 
>> CPU. */
>> +                     if (cpu == policy->cpu)
>> +                             cppc_cache_perf_ctrls(cpu_data, i, val);
>> +             }
>> +     }
>> +}
>> +
>> +/*
>> + * On a CPU's first ->init(), capture each register's firmware value 
>> to be
>> + * restored on driver unload. Later calls for the same CPU are a 
>> no-op. Capturing
>> + * from ->init() rather than module load covers CPUs that appear 
>> later. Also seed
>> + * requested_val to U64_MAX so its zeroed default is not taken as a 
>> request for 0.
>> + */
>> +static void cppc_cpufreq_save_firmware_regs(struct cpufreq_policy 
>> *policy)
>> +{
>> +     unsigned int cpu, i;
>> +     u64 val;
>> +
>> +     for_each_cpu(cpu, policy->cpus) {
>> +             for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +                     struct cppc_saved_state *s =
>> +                             &per_cpu(cppc_saved_state, cpu)[i];
>> +
>> +                     /* Capture once per CPU; skip if already 
>> recorded. */
>> +                     if (s->firmware_captured)
>> +                             continue;
>> +
>> +                     if (cppc_saved_regs[i].get(cpu, &val))
>> +                             val = U64_MAX;
>> +                     s->firmware_val = val;
>> +                     s->requested_val = U64_MAX;
>> +                     s->firmware_captured = true;
>> +             }
>> +     }
>> +}
>> +
>> +/* On driver unload, restore each captured CPU's firmware value. */
>> +static void cppc_cpufreq_restore_firmware_regs(void)
>> +{
>> +     unsigned int cpu, i;
>> +
>> +     for_each_present_cpu(cpu) {
>> +             for (i = 0; i < CPPC_NR_SAVED_REGS; i++) {
>> +                     struct cppc_saved_state *s =
>> +                             &per_cpu(cppc_saved_state, cpu)[i];
>> +
>> +                     if (s->firmware_captured && s->firmware_val != 
>> U64_MAX)
>> +                             cppc_saved_regs[i].set(cpu, 
>> s->firmware_val);
>> +             }
>> +     }
>> +}
>> +
>>   /* Autonomous Selection boot parameter modes */
>>   enum {
>>       AUTO_SEL_DISABLED = 0,
>> @@ -766,6 +934,9 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>
>> +     /* Capture a CPU's firmware values on its first init, before 
>> any driver write. */
>> +     cppc_cpufreq_save_firmware_regs(policy);
>> +
>>       /*
>>        * Enable autonomous mode on first init if boot param is set.
>>        * Check last_governor to detect first init and skip if auto_sel
>> @@ -812,7 +983,7 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>                       if (ret && ret != -EOPNOTSUPP)
>>                               pr_warn("Failed to set EPP for CPU%d 
>> (%d)\n", cpu, ret);
>>                       else if (!ret)
>> - cpu_data->perf_ctrls.energy_perf = epp;
>> +                             cppc_save_requested(cpu_data, cpu, 
>> CPPC_SAVED_EPP, epp);
>
> It would be nice to handle this in a more generic way.
>
> ------
>
> Theoretically, we should save all the writable CPPC registers,
> not only ospm_nominal_perf/auto_sel/epp. Maybe saving the
> value could be done in cppc_cpufreq_sysfs_store_u64() ?
>

Agreed on handling it generically.
But we can't use cppc_cpufreq_sysfs_store_u64() for this, as it's only
used by auto_act_window and perf_limited. The others (auto_sel, EPP,
ospm_nominal) have their own store handlers, and some values also come
from the boot parameter. None of those pass through that helper, so
saving there would cover only a subset of the registers.

Instead, as you suggested in the other thread, re-reading each tracked
register in offline() and reapplying it in online() works better here.
It captures the value regardless of how it was set.

And we can limit this to the OSPM set values rather than every writable
register:
  - perf_limited is write-to-clear.
  - min/max/desired are governor-managed. cppc_cpufreq_set_target()
    reprograms them from policy->min/max on every transition.
    So preserving them here would conflict with the governor.


>
>>               }
>>
>>               /* Program min/max/desired into CPPC regs (non-fatal on 
>> failure). */
>> @@ -826,7 +997,7 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>                       pr_warn("auto_sel CPU%d failed (%d); using OS 
>> mode\n",
>>                               cpu, ret);
>>               else if (!ret)
>> -                     cpu_data->perf_ctrls.auto_sel = true;
>> +                     cppc_save_requested(cpu_data, cpu, 
>> CPPC_SAVED_AUTO_SEL, true);
>>       }
>>
>>       if (cpu_data->perf_ctrls.auto_sel) {
>> @@ -850,6 +1021,10 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       }
>>
>>       cppc_cpufreq_cpu_fie_init(policy);
>> +
>> +     /* Reapply any saved values lost across a full policy teardown. */
>> +     cppc_cpufreq_reapply_requested_regs(policy);
>> +
>>       return 0;
>>
>>   out:
>> @@ -1039,6 +1214,8 @@ static ssize_t store_auto_select(struct 
>> cpufreq_policy *policy,
>>               }
>>       }
>>
>> +     cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_AUTO_SEL, 
>> val);
>> +
>>       return count;
>>   }
>>
>> @@ -1111,7 +1288,7 @@ store_energy_performance_preference_val(struct 
>> cpufreq_policy *policy,
>>       if (ret)
>>               return ret;
>>
>> -     cpu_data->perf_ctrls.energy_perf = val;
>> +     cppc_save_requested(cpu_data, policy->cpu, CPPC_SAVED_EPP, val);
>>
>>       return count;
>>   }
>> @@ -1193,6 +1370,9 @@ static ssize_t store_ospm_nominal_freq(struct 
>> cpufreq_policy *policy,
>>               }
>>       }
>>
>> +     for_each_cpu(sib, policy->cpus)
> Cf. comment on the other patch, maybe we should not
> actually set/get the ospm_nominal_perf value for all the CPUs
> of the policy. We might just assume all the CPUs have the same
> register.
>

Yes, I will change that patch to operate on policy->cpu considering
a shared register. Will drop the per-sibling loop/rollback, consistent
with auto_sel/EPP.

Thanks,
Sumit

