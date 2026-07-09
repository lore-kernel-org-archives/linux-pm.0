Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0F4DBD73;
	Thu,  9 Jul 2026 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783618733; cv=fail; b=n8wZX5ezSYMsSthGuDwi1IJ77cOCutGMTLVgaOrV06l0J612ttO4wOahEj/0fmBfXdR5vkJyQu9yvkwS9wNATu36jPrt7F2udYPHvMUYZ3gBBnc+KXJfFeYWJhB9XjoTvPk/vjH/VzPYqL7VGuygs99OHaBvG64ieMzU8um4ccM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783618733; c=relaxed/simple;
	bh=RM63CVNDBN9zt6iUCA4hHSH9rFqKC8rVWQLJyKXSmMQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kquOqkmm53MUWOP1gmpmGbXsDEgFaTTiGfg1hUxzRhkieG6fyQFZWENHaPluy5HCgeXIHfB/5WXX5A1MF3pfRQL+juec0WQNpgAps0Jkn9tfuleSsiUctSfuvsU58OvlEVpUCzVOWWIFYpcoY2FUyi9Odt7TO7uykle1vLadbvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fimb05ZH; arc=fail smtp.client-ip=52.101.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fimb05ZH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVxKsiSWJ9R0cvKPXGxonaP2fC7qHrJ1RVeOTwkeNnU6/UNNgVbJEGCAJsixqvOW/aqQCEW3CrdxqlKFh35d6fkpXQaqUzb2AB3aN3OvFujw93mrItIJl7qX4BZAtKZpnEga0FyRTJFp6d7CmuPA6vO+2jw6PiFMo5/zs8OYFgaQtqFl7XQhJXCoOXP+Gh5CJTtsDEhv4qPo9eK8t4p909ojL11s75KRIMD/JGdmbpDpdzsrexUW3yE+agHvsyDxM8o88r9wrPfmcop4+qQUwWKHHMBadGtpr+roybqBxILBLt8iW+beIceGelVRMOgOIg8qyG82ihw8POWA/y5/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i12Evi8YvGanhZyi8oJAQTxGL36HdaoaPM6aCeBVyu0=;
 b=LmZEKDw3mklVJnaQ2Fs5Ctg5rrsXmvD7zkpH5IyC9i/tr2+uIWZR2nTemC1ik4bJv6bmOyxutC8MByxmi2w1/ydG5AXHHhg1maxl0gxYXzZYEDoJdjz9yGoJSxrTER8S4sQRsrYxkY3xBcy66eCH8zbdSpgOp3PInsWOQzTsfkEnYnxbp3HezSSQTbhQ1buhPDLjQM7Lzw7ChKxc8hx/MCCb8mHvuPNWufH325Md3YizSnPs19cQ1rl2UOSxr8OdppVFJPNggD9UcVCIP6If8Jow9exqLoU4Tck5XAWuLyM1OysDAzDHZjPu2Fy8QxeOLW/MrpRGVxAjosB5srvJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i12Evi8YvGanhZyi8oJAQTxGL36HdaoaPM6aCeBVyu0=;
 b=fimb05ZHYbGzmnC57e1+zK2j4cmTC1uDfSYcSHjbIeV6POaBuL1qyqvqQQ1/69WR2yNEorGNY+ZEQWwcAnHyb+9uz8+xtuzzzF3vZrjqtg+bKuNBHtI4w9OlSzzmUXr3RjaFxQhCnelLv0JLqnM7Mo6Z0XmFjCKR+J8Bh0gmzUpFACU8zOIFPBJmgeaF/oSHj2a9lcictamwQtvvsbEzE2rmSk8kzXbqoAVYzSLeDK9/pUIHH2MrXdKoQjlAefgSNxU2ZFcQ72DtMc5dabs2VSqMQkf3FvWiUd98kJApM0LX7WfWWcomBokdikMaPkQlhjpsMGSZ5TI7ZhXwQ0Rv1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 17:38:37 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 17:38:37 +0000
Message-ID: <f61f592a-bc9c-4a83-bde1-e999c8101c36@nvidia.com>
Date: Thu, 9 Jul 2026 23:08:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Pierre Gondois <pierre.gondois@arm.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, ionela.voinescu@arm.com, zhenglifeng1@huawei.com,
 zhanjie9@hisilicon.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260623080652.3353386-1-sumitg@nvidia.com>
 <20260623080652.3353386-3-sumitg@nvidia.com>
 <07721a34-dae0-4575-897b-e4cb7754cf4d@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <07721a34-dae0-4575-897b-e4cb7754cf4d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0090.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::11) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a0af55-d7f5-447c-ddcd-08dedde0e7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|6133799003|18002099003|18092099006|11063799006|56012099006|3023799007|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	QTc9MJ3BhOP5RT94V0HJENcLK4QB6bzSru8aWWmJXL84rnj87/oY8JvuiEbSpbbN+F6vvG4kpprc0bRIwF7If10U4Z4qH1jIjn+FiNtLyqf9cHSCnnm+8JhxyL1lcloTvHqex8p91HlSmYEuMmgqoMm4HUuydezhiK3Y0GYoKf5wH/XK6UadimejciJo4a8BuZbeUIHuXS3fLV/EBzBrrs9flcdrFPwPC1UjJ8dJ7rU01xfJx99YiUlQ03d9SV3aqRbWf/WdJPdhwnAHKRZyS1lic7SzJSQx5pOvH5XHKnTq4Wf3dL0s+68juCcRlthNUk2BYJ4wqmj3su70bl7UInKb7grVt51nmEu7d5Y0otJQ9brL7Zbbi9lB79zJYFKnGHyp9FtmLFXseZLCuTuTEv6DvGLZtGAERy0pOFvyKFeQYQQkn6sL6ElRdJz0qCHsYZ4zsApE1tnYyPmjXZi6L/COgQemvzokRKvUP9uWj8RCY2/8xu3K0DtYBBPLCeApGswvP6KZ32ZXTfkkAEAkiq7pETq6CbZpP/tSI/jrC+FNzJt4OBQnQ7r8cIyRSHpz4mTpBF659y17DsZwJcjySKOX+scKI0BMGoD2G1Cuzm99XqYEGPE8LoxLJDUJ7op/2ryGOTmT68+f27gfMSHdqIF4zsEYyM1hbtY7pnBgGRW0/cqzDJNjNr+8OIjPlXmkesv9YO4NoxwbHRkviu2Utw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(6133799003)(18002099003)(18092099006)(11063799006)(56012099006)(3023799007)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amRQaWNVbFZXZ0hWTEdqUWtWZnc3aWhKRVh6TnZEaXlOd09PSU9RcjAwSG1j?=
 =?utf-8?B?Qk5zSy9jNEhpZG1KcjRtazZtaHF6MklRS3h2T1BLMFF2Y2ZuMXNjWWdJNEcx?=
 =?utf-8?B?NlFsSmtZOXFndVY5Y1RsckIzRko5L0hEdUZtQytZT2drZTNYSWpaRWZucVN0?=
 =?utf-8?B?R2pDNnFIelI4Nm1SQVhnOWdjQm9hNHdLRkNKZXM4bUFsL0VXNXFqUTFkeURN?=
 =?utf-8?B?SDFVWU5QbEFPQ0FOTXVsdmlER3dRY25pTnVlZzRhamc3elFOK0RSa2FtOVFV?=
 =?utf-8?B?YVhCSTlzYVpsRkE0Ykd5dng1ZTJiWmVzYnFWM2hRanhmOGtGN0tZYmdEajV4?=
 =?utf-8?B?R3FIZGRYeERFYlBFNnpXWWsrTm9GbGlRdUZ3cjFCSVk1MUFrT291eXJqK0FC?=
 =?utf-8?B?S3paSXYvdE5vbVA5Qm83NkV6WU5MbkNyN3N2SWtwVVJHYVFyazA5UkJPOXFK?=
 =?utf-8?B?S0J2NGNtb2dNaVRPTnd0dzFUcE54YUd1bE8yTElOcUt5WGI0TEd0OWZVenl3?=
 =?utf-8?B?NXpiYmRDSzFQTGNHa2dFbXFpbXZMQTlhZHE0ZmtxUG5mR0UrNGlTL2lLM2h6?=
 =?utf-8?B?V0tqdUxHVGNpYklxWWpiUGZ6bzZrc2VjeTFYK2RxR1I3OFo5MktBeDl0K1NG?=
 =?utf-8?B?VWxPMy9sT3lBMlBrSC80WmxILzFtUXVJU2o1anFSLzRqYi9DUlhUVzlGcnRJ?=
 =?utf-8?B?Ykx5WHh4UEJHQStuYS9GYnNDNmNhQ2RXeEpBY1lFOVpPRnBjL3orVDBxanZs?=
 =?utf-8?B?UDZWVVRVZFdyQVV4eWRZclBkU3NyOGI3T0VEK1QwOUlrN2hvdTlJUmxGajhv?=
 =?utf-8?B?MUIrOFg4WjZ2b2M4anZEZ1NUeXhCVktlMmtKVzZld29vUjc1V21EbEJzRWE0?=
 =?utf-8?B?RnNhYm0wU3doVzBpZjl2N2tvalUxbEVnSHB3MVhISzBCNVZYN1NhZGRGa2xs?=
 =?utf-8?B?MWl4blRURDlCbkF6QUtLY1BDV1QyWEFzUms0MUU0ZnJqTVJucDE4aE9STThR?=
 =?utf-8?B?aWt6RDZwNDdDeVM0T052TE5nQ0lUSWlHM0ZnQzkxWUZIRHNMSnk1c1RKZXdn?=
 =?utf-8?B?dWsyUzRUQWFLK2tmR3JNUC81ZlkyWmc3T1U4T2NWc0o3OVRjNUhoTm02NHdC?=
 =?utf-8?B?anFtQnlYUEIzQzFRYTIxL0FHRE56YXFWT1FhZGJLUG95MFlVc0ZQaTZwM29C?=
 =?utf-8?B?anVzVitBanBEdWhyNFBZVkJrM3BBNzA4R3A3TUpiMlFHSXlLbkFMQnl5RkZi?=
 =?utf-8?B?dGlYajNZVVVVaGpMaERYL0Znc3FCMDRQaDlyemlDQjlldUJHaUlzY0hwdkJv?=
 =?utf-8?B?K3ZCSUNFL3gvQ040WTVqdHpoWTI3Y2syUVlLSGJLK2E5MVJjaVRVOHovc0k2?=
 =?utf-8?B?SGRnNHNQODFTaFVNTHpCVFgxVEJYK1RRcVRYTFgzcHhNY1F5Sml4QWpocVN3?=
 =?utf-8?B?cHhmNzdDTWpjTUhuUGNLbUt5TU16VzRYbWk2elFObnJObktVdVRqcXpmb2dO?=
 =?utf-8?B?bnpwVkxzeGNKR1NhRkNJN2V5TUlZai9sSHdISzNmTW9SSktOQ1ZvUUVLb3F0?=
 =?utf-8?B?b3E4bEJFQTFPTnl5QUxHaURtTU5RQWtwbGZaRTZhT3NYYk1EOU55c0ltbWds?=
 =?utf-8?B?VFFyc0N1cW91OTVkeXQ5OE83UVBIeTgwd3loMWIxVExOeTU1MDlIV1lIbDFZ?=
 =?utf-8?B?M2FJWlZIdzBEdFdESlZ2cmhQODF0ZFYyUHZaV1NaOGRySTQrU3c2bFVDK052?=
 =?utf-8?B?OW5ITThEMTk1dXZnZ3hlb05oa09uZU5DVWY5bk5JL1Y1VVdiNG4zQ2pkL2Fx?=
 =?utf-8?B?dHJ1NzUzR2Iva0hBRElJVjZoUk44d1VEZnU3T3ZWTU11MUNBY2VtZVRtYVNN?=
 =?utf-8?B?UmlYZkNMR0lFUzBNUEcyQmVycnQrR3RKYVJjMjE2b1BCRU5jZmpYMkhjd3dw?=
 =?utf-8?B?bThlSTZ5ckx2bG1OaUlMcmJTQmVBckg0ZkNYOWJ2MVNxdmhqUDQvZVZOQmha?=
 =?utf-8?B?V2RZM2kzOGticHRLWlFWanRYdU52cEhqa1QzOEJhNVdWdTdFR0tYYm53T09U?=
 =?utf-8?B?anFTeWxsb25mNDFWUEtOYkFZTkt2MkJEaXVxSUtmUGRMTTBSMHVyQXlsMXBM?=
 =?utf-8?B?bTFnTk5EMHVzUmtyVSswc0R6ZWN4S1JqUHcyRllZZDl4bC81djBnd3NFTm1i?=
 =?utf-8?B?dFY0ZWh1UzVEMkFGaUs0ejRUUlVqYnU0NXdjT3cvRmNiemhZQ25VbHhRa1dP?=
 =?utf-8?B?T0pzRXRyaXoxVWJDUHZhcXNVS3dhTVBqeTNDNWRmQUtJTWxwMlRDcjRvSTVV?=
 =?utf-8?Q?Uhg5okboIWoVW43JQ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a0af55-d7f5-447c-ddcd-08dedde0e7ef
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 17:38:37.0324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNT0FMTGxBiRG/Q0P5FhkKT6tx+P4n4xa7gF8UeA7GdL/8o1hndOKBbUkEMrRZ+j6SkGyEe14s27hlz5gNcfow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213


On 01/07/26 21:54, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> On 6/23/26 10:06, Sumit Gupta wrote:
>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>> CPPC autonomous performance selection on all CPUs at system startup.
>> When autonomous mode is enabled, the hardware automatically adjusts
>> CPU performance based on workload demands using Energy Performance
>> Preference (EPP) hints.
>>
>> When the parameter is set:
>> - Configure all CPUs for autonomous operation on first init
>> - Use HW min/max_perf when available; otherwise initialize from caps
>> - Initialize desired_perf to max_perf as a starting hint
>> - Hardware controls frequency instead of the OS governor
>> - EPP behavior depends on parameter value:
>>    - performance (or 1):         override EPP to performance (0x0)
>>    - balance_performance (or 2): override EPP to balance_performance
>>                                  (0x80)
>>    - default_epp (or 3):         preserve EPP value programmed by
>>                                  BIOS/firmware
>>
>> Unset, "0"/"disabled", or an unrecognized value leaves autonomous
>> selection disabled.
>>
>> The boot parameter is applied only during first policy initialization.
>> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
>>
>> This relies on commit 8c83947c5dbb ("cpufreq: Use policy->min/max 
>> init as
>> QoS request") so that the policy->min/max set in cppc_cpufreq_cpu_init()
>> are used as the policy's QoS requests and not overridden by
>> cpufreq_set_policy() during init.
>>
>> Signed-off-by: Sumit Gupta<sumitg@nvidia.com>
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  22 +++
>>   drivers/cpufreq/cppc_cpufreq.c                | 151 +++++++++++++++++-
>>   include/acpi/cppc_acpi.h                      |   1 +
>>   3 files changed, 169 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index b5493a7f8f22..88820d34d516 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1019,6 +1019,28 @@ Kernel parameters
>>                       policy to use. This governor must be registered 
>> in the
>>                       kernel before the cpufreq driver probes.
>>
>> +     cppc_cpufreq.auto_sel_mode=
>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous performance
>> +                     selection. When enabled, hardware automatically 
>> adjusts
>> +                     CPU frequency on all CPUs based on workload 
>> demands.
>> +                     In Autonomous mode, Energy Performance 
>> Preference (EPP)
>> +                     hints guide hardware toward performance (0x0) 
>> or energy
>> +                     efficiency (0xff).
>> +                     Requires ACPI CPPC autonomous selection register
>> +                     support.
>> +                     Accepts:
>> +                       disabled, 0:
>
> Just a question, but would it be worth only accepting
> strings ? If we want to have a thinner granularity later,
> it will be harder to introduce them if there are integer values
> already present.

Sure, will change to keep strings only for flexibility in future.

>
>> +                               cpufreq governors are used (auto_sel 
>> disabled)
>> +                       performance, 1:
>> +                               enable auto_sel + set EPP to 
>> performance (0x0)
>> +                       balance_performance, 2:
>> +                               enable auto_sel + set EPP to
>> +                               balance_performance (0x80)
>> +                       default_epp, 3:
>> +                               enable auto_sel, preserve EPP value 
>> programmed
>> +                               by BIOS/firmware
>> +                     Unset or an unrecognized value is treated as 
>> disabled.
>> +
>>       cpu_init_udelay=N
>>                       [X86,EARLY] Delay for N microsec between assert 
>> and de-assert
>>                       of APIC INIT to start processors.  This delay 
>> occurs
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index f7a47576717a..efa673e3830c 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,55 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/* Autonomous Selection boot parameter modes */
>> +enum {
>> +     AUTO_SEL_DISABLED = 0,
>> +     AUTO_SEL_PERFORMANCE = 1,
>> +     AUTO_SEL_BALANCE_PERFORMANCE = 2,
>> +     AUTO_SEL_DEFAULT_EPP = 3,
>> +};
>> +
>> +static int auto_sel_mode;
>> +
>> +static int auto_sel_mode_set(const char *val, const struct 
>> kernel_param *kp)
>> +{
>> +     int *mode = kp->arg;
>> +
>> +     *mode = AUTO_SEL_DISABLED;
>> +
>> +     if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
>> +             *mode = AUTO_SEL_PERFORMANCE;
>> +     else if (sysfs_streq(val, "balance_performance") || 
>> sysfs_streq(val, "2"))
>> +             *mode = AUTO_SEL_BALANCE_PERFORMANCE;
>> +     else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "3"))
>> +             *mode = AUTO_SEL_DEFAULT_EPP;
>> +     else if (!sysfs_streq(val, "disabled") && !sysfs_streq(val, "0"))
>> +             pr_warn("Invalid auto_sel_mode \"%s\", disable auto 
>> select\n", val);
>> +
>> +     return 0;
>> +}
>> +
>> +static int auto_sel_mode_get(char *buffer, const struct kernel_param 
>> *kp)
>> +{
>> +     int *mode = kp->arg;
>> +
>> +     switch (*mode) {
>> +     case AUTO_SEL_PERFORMANCE:
>> +             return sysfs_emit(buffer, "performance\n");
>> +     case AUTO_SEL_BALANCE_PERFORMANCE:
>> +             return sysfs_emit(buffer, "balance_performance\n");
>> +     case AUTO_SEL_DEFAULT_EPP:
>> +             return sysfs_emit(buffer, "default_epp\n");
>> +     default:
>> +             return sysfs_emit(buffer, "disabled\n");
>> +     }
>> +}
>> +
>> +static const struct kernel_param_ops auto_sel_mode_ops = {
>> +     .set = auto_sel_mode_set,
>> +     .get = auto_sel_mode_get,
>> +};
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>       FIE_UNSET = -1,
>> @@ -645,7 +694,9 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       unsigned int cpu = policy->cpu;
>>       struct cppc_cpudata *cpu_data;
>>       struct cppc_perf_caps *caps;
>> +     bool set_epp = true;
>>       int ret;
>> +     u32 epp;
>>
>>       cpu_data = cppc_cpufreq_get_cpu_data(cpu);
>>       if (!cpu_data) {
>> @@ -715,11 +766,87 @@ static int cppc_cpufreq_cpu_init(struct 
>> cpufreq_policy *policy)
>>       policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>       cpu_data->perf_ctrls.desired_perf = caps->highest_perf;
>>
>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> -     if (ret) {
>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -                      caps->highest_perf, cpu, ret);
>> -             goto out;
>> +     /*
>> +      * Enable autonomous mode on first init if boot param is set.
>> +      * Check last_governor to detect first init and skip if auto_sel
>> +      * is already enabled.
>> +      */
>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>> +         !cpu_data->perf_ctrls.auto_sel) {
>
> If an .online() callback is introduced, does it mean that we can
> remove the "policy->last_governor[0] == '\0'" check ?
>
> Also maybe it would be worth creating a function for this
> "if" block ?
>
> Also (bis), maybe we should check that auto_sel is supported before
> doing anything else.
>

Agreed. Will change in v6.

>
>> +             /* Init min/max_perf from caps if not already set by 
>> HW. */
>> +             if (!cpu_data->perf_ctrls.min_perf)
>> +                     cpu_data->perf_ctrls.min_perf = 
>> caps->lowest_nonlinear_perf;
>> +             if (!cpu_data->perf_ctrls.max_perf)
>> +                     cpu_data->perf_ctrls.max_perf = 
>> policy->boost_enabled ?
>> +                             caps->highest_perf : caps->nominal_perf;
>
> Is it necessary to do that ?
>
> - for min_perf, we are setting it to the lowest possible value
>
> - for max_perf, we are setting it to the highest available value.
> If boost is disabled and we enabled it later, I don't think max_perf is
> updated accordingly, so we would limit the freq. to caps->nominal_perf
>
> (If I m not missing something)
>

The min/max seed is still needed so the HW has valid min/max limits
when firmware leaves them unset.
Here, will keep max_perf capped to nominal while boost is off and
change the second place below to set policy->max = highest_perf so the
driver does not limit the max below highest, letting the core cap
to nominal when boost is off.
Enabling boost then raises the HW max_perf to highest via ->target(),
fixing this point too.

>> +
>> +             /*
>> +              * In autonomous mode desired_perf is only a hint; EPP and
>> +              * the platform drive actual selection within [min, max].
>> +              * Initialize it to max_perf so HW starts at the upper 
>> bound.
>> +              */
>> +             cpu_data->perf_ctrls.desired_perf = 
>> cpu_data->perf_ctrls.max_perf;
>> +
>> +             policy->cur = cppc_perf_to_khz(caps,
>> + cpu_data->perf_ctrls.desired_perf);
>> +
>> +             /*
>> +              * Set EPP per mode. 'default_epp' preserves the 
>> BIOS/firmware
>> +              * programmed EPP value. EPP is optional - some 
>> platforms may
>> +              * not support it.
>> +              */
>> +             switch (auto_sel_mode) {
>> +             case AUTO_SEL_PERFORMANCE:
>> +                     epp = CPPC_EPP_PERFORMANCE_PREF;
>> +                     break;
>> +             case AUTO_SEL_BALANCE_PERFORMANCE:
>> +                     epp = CPPC_EPP_BALANCE_PERFORMANCE_PREF;
>> +                     break;
>> +             default:
>> +                     set_epp = false;
>> +                     break;
>> +             }
>> +
>> +             if (set_epp) {
>> +                     ret = cppc_set_epp(cpu, epp);
>> +                     if (ret && ret != -EOPNOTSUPP)
>> +                             pr_warn("Failed to set EPP for CPU%d 
>> (%d)\n", cpu, ret);
>> +                     else if (!ret)
>> + cpu_data->perf_ctrls.energy_perf = epp;
>> +             }
>> +
>> +             /* Program min/max/desired into CPPC regs (non-fatal on 
>> failure). */
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret)
>> +                     pr_warn("set_perf failed CPU%d (%d); using HW 
>> values\n",
>> +                             cpu, ret);
>> +
>> +             ret = cppc_set_auto_sel(cpu, true);
>> +             if (ret && ret != -EOPNOTSUPP)
>> +                     pr_warn("auto_sel CPU%d failed (%d); using OS 
>> mode\n",
>> +                             cpu, ret);
>> +             else if (!ret)
>> +                     cpu_data->perf_ctrls.auto_sel = true;
>> +     }
> (until here)
>> +
>> +     if (cpu_data->perf_ctrls.auto_sel) {
>> +             /* Sync policy limits from HW when autonomous mode is 
>> active */
>
> Similar comment as above, doesn't it fall into a similar case as:
> 521223d8b3ec ("cpufreq: Fix initialization of min and max frequency QoS
> request")
>
> ?
>

Answered above.

>
>> +             policy->min = cppc_perf_to_khz(caps,
>> + cpu_data->perf_ctrls.min_perf ?:
>> + caps->lowest_nonlinear_perf);
>> +             policy->max = cppc_perf_to_khz(caps,
>> + cpu_data->perf_ctrls.max_perf ?:
>> + (policy->boost_enabled ?
>> + caps->highest_perf :
>> + caps->nominal_perf));
>> +     } else {
>> +             /* Normal mode: governors control frequency */
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf value:%d on CPU:%d. 
>> ret:%d\n",
>> +                              caps->highest_perf, cpu, ret);
>> +                     goto out;
>> +             }
>>       }
>>
>>       cppc_cpufreq_cpu_fie_init(policy);
>> @@ -1066,10 +1193,24 @@ static int __init cppc_cpufreq_init(void)
>>
>>   static void __exit cppc_cpufreq_exit(void)
>>   {
>> +     unsigned int cpu;
>> +
>> +     for_each_present_cpu(cpu)
>> +             cppc_set_auto_sel(cpu, false);
>
> I saw that this is being changed in:
> [PATCH] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and 
> unload
>
> But I think it would make more sense to have this patch comes before 
> these
> patches:
>
>  [1] ACPI: CPPC: Add ospm_nominal_perf support
> https://lore.kernel.org/lkml/20260615185934.2383514-1-sumitg@nvidia.com/
>  [2] cpufreq: CPPC: add autonomous mode boot parameter support
> https://lore.kernel.org/lkml/20260623080652.3353386-1-sumitg@nvidia.com/
>
> to avoid making changes that are corrected in this last patch of the 
> serie.
>

Sure, will reorder them.

Thanks,
Sumit

....

