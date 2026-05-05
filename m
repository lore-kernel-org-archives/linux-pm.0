Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779F30DEA9;
	Tue,  5 May 2026 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984185; cv=fail; b=QaScjaf86/YLspHX1bt+64kr4VWhlldsztcwp0qUphplKSpiTyu76umtN70Ul4VS/PSCYA2WgSXD504IVQrPfjLZxhLjCiPIgjGqUNbclP4cCEPQIDT4BbdOzCIlWq+vOFWQCKPDJGLJmvSorzcdTZed0usylXQW5k5op8MoVGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984185; c=relaxed/simple;
	bh=yKxqm4GTj+pTU3VtG5t6/HaC8X3tj4o9swgFW2YjDkE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EfDLHGpL5eTWXYtnGeAA+fSRwpn9AYtUFD0TFFpHYqTST6vm1jC71AEJBxRCt/9cG+BcTDyuOpysnSZBWyiUhdyvhGCfXI9zqhdFaYUbrQm/yi05Dba8IezD5IljuMGpP2eVPy3cvriwd0hKX7sGYhqvXZb3MalsI7/Bsep2IVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LRzXWwg+; arc=fail smtp.client-ip=52.101.57.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LRzXWwg+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ8cI0ZSJjciX0138oy1eZliSxZ+BxWAJKWytA1m5+hrSgtpKQybdUTqVcXcHs3RAgX4XTNtssgiYqEklwUIDNEZ7cA5L3uiVW3/AO31aWLCRxXujPqQWBJ/wBNZJklVGLfYEWrnoSgNAQZlIBJNDo5vy3R8wH10vIuT3OwwLJKhcG9VB1t2yhNRL+CvLwDKZvJfgzFIt3Q1EaqfkzhTj0WjYMGTpOzIe1un5ZwtqIDXfBUiWjphrfBLHHYMvMTz3H9Jr/ZWs9K/ygQU0oBArDfkkNifEX9uM+VM955LTUYoRfYfgVJtRf4M8JnP6ayrd6NNvrFM1JFyKBWPltoSUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0CkJNYpUk1+odI0qYUkS85CeskujO56wfWKrPueqVc=;
 b=E//zN2B17IfJIkoKRNKClikTQkNi/IfOtY5V8I/yTLt3zHSzQbf9zAEDmoVl5Bm3YvkNlC2EXu0Uz4jIC2CQEg3fSTyEnPFEgNyNQaX3DEwrHoBsLPhjW+zqRQZ7QMS61UNU2uOvNryfbdqfsf3pgI/00SNcuIVLj6vlOsCrgM+28noTWvyyd0MVMI6VUKb/+SxDghdZSIDcG2F1VRAG27iDyq/5WSKp3vffoPcwZGV3mNz+pEq1Bz3biDTeMevZz9+ELKKv8pT7q0wpxMI5uTge8F2h2y7jYD0EFO8zpUnqWV0bFMSGSHaqvTHK8C0kJa7hHKg9GZFF7Zx4VAackw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0CkJNYpUk1+odI0qYUkS85CeskujO56wfWKrPueqVc=;
 b=LRzXWwg+MGO+/7oPjgU5tob4dmOXKffuRnd41YdhpEFhUyNFECUMdR0DGVbvtptkXKM1mSr6IsxH91HTHnWpgpJgxUWu7AmEJbIcPjh7DDkZAf3w1F4qggpvd3hrHQI/rXEzdr+tdz9DFJsfrGLisdJNDfEoe+GvP4M5kKHFIYAAmMKySPzSlB7nYiIA34h+89x8sB9GZm+LFBKfjgARr8bdNa0TtD/B+gcoPx8c2prdLAV+x/jHPkCIPnjNqDcauVt/TADTs6UHbO7fjB9Lhm6Emy+4BwolK1Q8SjXAFoog/iUzwiTjGUnB6UQEKwikoHkeL2h0582SdIFqNuHGkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:29:36 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:29:36 +0000
Message-ID: <bc06c3ab-0286-4e1e-a615-e704b267c21a@nvidia.com>
Date: Tue, 5 May 2026 17:59:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Jie Zhan <zhanjie9@hisilicon.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, mario.limonciello@amd.com, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260424201814.230071-1-sumitg@nvidia.com>
 <a4ed690a-50d6-4bfe-8810-86a75d7b51e3@hisilicon.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <a4ed690a-50d6-4bfe-8810-86a75d7b51e3@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0245.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::7) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: f115f1d2-fb3b-4193-71fa-08deaaa1f805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	W+uimddFOFxQTSwArRpfQWTd1vGd/Fp74Y2wbzK9m6ycH0bO1pvYmbWlrmtV31Dje7Nnvc+oB12BWV6ysvxtLbJBD3JAjwLs0k6ve32eCNhwdV8qQH9Haj1jU4EetHCPk2r7Svm+x0DcmMWWFfRGUSXjdNJOIRv6CHrm6l/O7cmnLkJNf03oNZlNhJujIj2SMqo3j8yGa1E0FW7i6ICVLp4j6w7NUxVHXUbq2posqHpfZLTCHuE+nsQ2spr5Y2MpIbp91yltm7RZ+wXgrlymjxs+WfHG/ChHKiIHSvP3sijGmncOXyis6AhZc2vl5YrACd6ehXuSBr8vlCaU64t23nducBoNnt4HLAYI5lBbsW8pCkhNqgzt9ikTjfVo/zPxu4I5+FRlBH2Xz8D4n4D4JJL6X2pNMKD1jIfMZxnyETTO+ASq4kEGs9qiyaax6qJOmzRcEA/cwUgkFTjKn3Kl0v323Hd8wEP71H0y/MOtzbCCxZyW4G69sxCAaGeYXUf3Ofps8GR4s4yn2pGNh0+6KbixpOU36OtA9cLcFPW7TXqp1jGeekXyccGVyyeGj1CzytAo4sIVbr4Wnwnn9yh2D5UpyKX837no5vu8yQVOw/OvXels/XaZIvAY+DiE8sye2Gd8/1/5QpLWwEvmjnQYkkFiQDEmwefO/DOkIYGpkImLWXDp7wn8dzzz8LBPrnFU1q5lD5rI0JuzXznNwGfq+fsU17PlinNXqnqaqEhurJf3e5YQzSbxOt9poW9F7dcK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWYzVkk0dVYxcFhYc094U095anEySVlCZ09GVFcvMFo4emFuRnlocXloVmFB?=
 =?utf-8?B?ZTBsb1ZLTEJIeE1pRFJjMHFDUzJmdEV2TUZqQWw0Y2RsMm9WVXMxU3N1bGZP?=
 =?utf-8?B?Y1A5MXFGdFZCYzVVVkxPR202N2YzNEwrblc0OFJZMlZlcEt0TTZnQzdyeE0z?=
 =?utf-8?B?UnhFR2V0L2dsUXFMUlJiMlMzWk1EM2FvbFZWM0g1ek4zRmVETnBXRXJBejll?=
 =?utf-8?B?RHV5cWJBWlpsMXdNa1lETkc5MkpRcW1zWVFHcGRNQnJOWjQ1OFExZDVxcVNk?=
 =?utf-8?B?NWpQRUptQnJzVnNqOW01clNlRVpSWXBBRnU3ODRQWi93bmJLVWZ3NWo2SDFa?=
 =?utf-8?B?QzVxMHd1SCtzakJqTXNqOFBsQXFkc0Q3UUhYdXQ0dmlhRnJCTjM3S1IzNVVt?=
 =?utf-8?B?aFlpTVJjaWl0R0RRU1gwOU5VWmMxLzhWU1JEVzhWeVN3MG13a29SMk1lY0VI?=
 =?utf-8?B?S2p2MHo2WVNVSkdXZk1NQmFDOXR6MWx3V2hHNmYvUHVRVmU2dFMrVTVYR0c4?=
 =?utf-8?B?VTdFY2J4YkZBQzVEWnZ0S0hCaUtENjVxNElHNmMrMkNTcEpjWXhLT3krWHZi?=
 =?utf-8?B?Q08zaURteXZLTUx4M1ljWFpSOUV3WEZxeTkwNUVOTGZmZGQyTkduQThNMkp0?=
 =?utf-8?B?T1JIZUtKZjNXTUZWcWdUZ0c5THVuT2tIYllGd1BRN20ycU1NY3pPUE5XV09s?=
 =?utf-8?B?R3pyUys4N2Q5K2ZwMGN6aHlST3ozcmczTUlVRkY2RXF2QlVyQ0FEdzgraDJi?=
 =?utf-8?B?Qy9ldUF3ZTZURGd4UStGZEVEQmsrWHJYUVBsSG1VSWt2c0VqSlNmME02a0x0?=
 =?utf-8?B?ejRScjJGYkRTVVg4aDVsRzdrS0hzeStFaDlHd21haEplSzQ5QkRLQXFSVWtM?=
 =?utf-8?B?eW91RFhHVHMwOVNQVWY4WlJVTVl1Mk1yeEhBODA1c0lZNGJIaGhZRGFlV2dT?=
 =?utf-8?B?dW1tYmt1RDFvUERuZzJWaG1mTW5nRGJQcmVWUjdIZVZ4VFArRGZkN1NRU0dv?=
 =?utf-8?B?SEVSeHhmbDZNQTFxRDUzSnFQdll3MGFodHd2dFJVb2RMa25lYVlXdEZMc1RB?=
 =?utf-8?B?UVR2a2VYRDlRa3RYdE5vN0g2MDJIMnExM3lTNTZGaXZpVWU0YnZpb0NtUmxr?=
 =?utf-8?B?N3Zxbjl6Z3BGS2RHbDBMK3dzSThPYkUzU2M5V0V5Qml2SENsU2JsZUhyUVll?=
 =?utf-8?B?bllEc3dPRndPV2tIZHVOUGNqNkVwL05CT1ZGMTBFTmRLd1F4NXRuNnRSeWJs?=
 =?utf-8?B?VTBqUDhyQ0JxV2I1Nmkydng4RnUwSE16Wks2RFJSRkM5ZHViaVlwL3JOK2NP?=
 =?utf-8?B?U1hwVEs5dS92Q3MvMnNsbVQrZ2d3WTlUV0VLU1NCT3lmME9wVnVwdXdQTFJY?=
 =?utf-8?B?aW8rWndSYVhvY2NMUnZZb0dPUG9vNElKUnc3TnI2VHEvRWdiVmR2VUxseFNx?=
 =?utf-8?B?S3B6MnZOa3Y0bTVWZGlYbU1GSzZhT3BqdHBDWGJRRUJNRC8wUGxsZ3llMTZ5?=
 =?utf-8?B?dTRHRENtYTg0ODd3ZkRUdGsrbHJhRG0vaEFxQWt2Wmd5VG40aXpoL1BVeXEx?=
 =?utf-8?B?Ty9DTEtKd2l1azFJUDRYQlVuelRwUlZQTXJ3MmtXalk4RjZtbDlzM2RFUmUw?=
 =?utf-8?B?QVRNdW1KbUZrRGg3eFYxcm9EbVhNZCtlVjhTdmVNa3gxS0s5V2YvV2RDUzhF?=
 =?utf-8?B?YWVJU1NMSDBZZWRhbjNsbG5xVjB5RGp0b01ZeVE1U2VEWFFvUlpmdnBlWGNj?=
 =?utf-8?B?V1VpWVVhdVJYdHFuRk9vc1RJMnZ5cktsMHY4RTZHaFJMa2wxQUxJb1Y0RXph?=
 =?utf-8?B?MFZ2a0ZMSFlSaCtGZkZxT2RSWW5VWHV2NysrMTc2cFhWdDZwOTlJTlRCSW9h?=
 =?utf-8?B?NHBVOGRKVHBkQmMwRnhyMzhjT09iMlFWODdQVVRVaEN6ZW5CYTVMVnNuZURN?=
 =?utf-8?B?MDl5SkVhVGRld0tWRmgya3haNEtNekhNeXBzQ2dmdmt5RUM0RUpGODZXK1RI?=
 =?utf-8?B?cndQN0FyaXV3VVBpUkRYejhWZnRxY1pPWlVPLy9WYjZlSFpSVzA1Zk4zRHFu?=
 =?utf-8?B?L01QUUNTVjV2dzNFOFl0Y3UreVQwT25LZlBTNVhtRVNobGU1ejRMQVlFYlIz?=
 =?utf-8?B?M2s3TUkyekM1NmxJUmZiQ1VjbUZxazlmMjJtSWpSUWdVNTE3NDhYRXhTQnRl?=
 =?utf-8?B?ZW1EcnlkMStSWHdxZGVKcHJMZ2ZpZ0dRREFWb1Q2ZFNCSDVLdGd0ZTJNbTVB?=
 =?utf-8?B?MFdYUGRrNGRRWVZIRW50TUFaRFlZWlZ0U0JBTlBvSEFwZGVEWm5YQmsrZnBa?=
 =?utf-8?Q?VQGLlUJPgmbxwS7kzQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f115f1d2-fb3b-4193-71fa-08deaaa1f805
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:29:36.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlPoLjQVYZn8Jn7mJ2jvadI2SNF1AMjsgokMFQl6Coh2Jc5TeMyL7gX4ZDaLqn75L2NpdzPLUQXGgB2C7Tbk2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375

Hi Jie,


On 27/04/26 13:54, Jie Zhan wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Sumit,
>
> In general, I would expect this parameter only toggles on auto_sel by
> default.  IIUC, other CPPC configurations (min/max/desired perf, EPP,
> enable) are optional and not closely related to this.
>
> Why including those stuff here?
>
>
> Please see other questions inline.
>
> Thanks!
> Jie

These together provide a known, predictable autonomous mode boot.
min/max/desired seeding ensures HW has a known starting bound (BIOS
may leave them unset).
EPP=PERFORMANCE_PREF is needed as BIOS defaults often bias toward
energy saving, and admins on many CPU systems shouldn't have to script
per CPU sysfs writes at every boot to undo that.

>
> On 4/25/2026 4:18 AM, Sumit Gupta wrote:
>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>> CPPC autonomous performance selection on all CPUs at system startup.
>> When autonomous mode is enabled, the hardware automatically adjusts
>> CPU performance based on workload demands using Energy Performance
>> Preference (EPP) hints.
>>
>> When auto_sel_mode=1:
>> - Configure all CPUs for autonomous operation on first init
>> - Set EPP to performance preference (0x0)
>> - Use HW min/max_perf when available; otherwise initialize from caps
>> - Clamp desired_perf to bounds before enabling autonomous mode
>> - Hardware controls frequency instead of the OS governor
>>
>> The boot parameter is applied only during first policy initialization.
>> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
>>
>> This patch depends on patch [2] ("cpufreq: Set policy->min and max
>> as real QoS constraints") so that the policy->min/max set in
>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>> during init.
>>
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>> v[1] -> v2:
>> - Call cppc_set_enable() unconditionally so CPPC is enabled for both
>>    OS-driven and autonomous modes.
> Why adding this in v2?
> This looks like a separate issue since setting CPPC Enable reg doesn't seem
> to be related with autonomous control.

In v2, moved it out of the auto_sel specific check.
Agree that cppc_set_enable() is general CPPC enablement and can be split
into a separate patch in v3 if preferred.

>> - Init min/max from caps instead of cppc_cpufreq_update_perf_limits()
>>    as policy->min/max aren't yet populated.
>>
>> [1] https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
>> [2] https://lore.kernel.org/lkml/20260423084731.1090384-2-pierre.gondois@arm.com/
>> ---
>>   .../admin-guide/kernel-parameters.txt         | 13 +++
>>   drivers/cpufreq/cppc_cpufreq.c                | 89 +++++++++++++++++--
>>   2 files changed, 97 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 0a1abed1b93c..751817b0573a 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1067,6 +1067,19 @@ Kernel parameters
>>                        policy to use. This governor must be registered in the
>>                        kernel before the cpufreq driver probes.
>>
>> +     cppc_cpufreq.auto_sel_mode=
>> +                     [CPU_FREQ] Enable ACPI CPPC autonomous performance
>> +                     selection. When enabled, hardware automatically adjusts
>> +                     CPU frequency on all CPUs based on workload demands.
>> +                     In Autonomous mode, Energy Performance Preference (EPP)
>> +                     hints guide hardware toward performance (0x0) or energy
>> +                     efficiency (0xff).
>> +                     Requires ACPI CPPC autonomous selection register support.
>> +                     Format: <bool>
>> +                     Default: 0 (disabled)
>> +                     0: use cpufreq governors
>> +                     1: enable if supported by hardware
>> +
>>        cpu_init_udelay=N
>>                        [X86,EARLY] Delay for N microsec between assert and de-assert
>>                        of APIC INIT to start processors.  This delay occurs
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 02db03d03755..672fc3058190 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,9 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/* Autonomous Selection boot parameter */
>> +static bool auto_sel_mode;
>> +
>>   #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
>>   static enum {
>>        FIE_UNSET = -1,
>> @@ -656,6 +659,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        caps = &cpu_data->perf_caps;
>>        policy->driver_data = cpu_data;
>>
>> +     /*
>> +      * Enable CPPC for both OS-driven and autonomous modes.
>> +      * The Enable register is optional - some platforms may not support it
>> +      */
>> +     ret = cppc_set_enable(cpu, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
>> +
>>        min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
>>        max = cppc_perf_to_khz(caps, policy->boost_enabled ?
>>                        caps->highest_perf : caps->nominal_perf);
>> @@ -711,11 +722,71 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
>>        cpu_data->perf_ctrls.desired_perf =  caps->highest_perf;
>>
>> -     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> -     if (ret) {
>> -             pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> -                      caps->highest_perf, cpu, ret);
>> -             goto out;
>> +     /*
>> +      * Enable autonomous mode on first init if boot param is set.
>> +      * Check last_governor to detect first init and skip if auto_sel
>> +      * is already enabled.
>> +      */
>> +     if (auto_sel_mode && policy->last_governor[0] == '\0' &&
>> +         !cpu_data->perf_ctrls.auto_sel) {
>> +             /* Init min/max_perf from caps if not already set by HW. */
>> +             if (!cpu_data->perf_ctrls.min_perf)
>> +                     cpu_data->perf_ctrls.min_perf = caps->lowest_nonlinear_perf;
>> +             if (!cpu_data->perf_ctrls.max_perf)
>> +                     cpu_data->perf_ctrls.max_perf = policy->boost_enabled ?
>> +                             caps->highest_perf : caps->nominal_perf;
> Is it automatically adjusted when switching boost on and off?

Yes. Here just setting the the initial value. Subsequent boost toggles
propagate via the existing QoS/CPUFREQ_NEED_UPDATE_LIMITS flow:
a FREQ_QOS_MAX update triggers .target (cppc_cpufreq_set_target)
-> cppc_set_perf, which sets the new max_perf to HW.

>> +
>> +             cpu_data->perf_ctrls.desired_perf =
>> +                     clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>> +                             cpu_data->perf_ctrls.min_perf,
>> +                             cpu_data->perf_ctrls.max_perf);
> Why do we need to clamp desire_perf here?

You are right, the clamp isn't really needed.
With auto_sel, the desired_perf is an optional hint. EPP and the
platform drive actual selection within [min_perf, max_perf].
We can simply initialize desired_perf to max_perf as starting hint.
I will update it to below in v3:
     cpu_data->perf_ctrls.desired_perf = cpu_data->perf_ctrls.max_perf;

>> +
>> +             policy->cur = cppc_perf_to_khz(caps,
>> +                                            cpu_data->perf_ctrls.desired_perf);
>> +
>> +             /* EPP is optional - some platforms may not support it */
>> +             ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
> Why setting this to PERFORMANCE by default?
> A platform can have its own default EPP value.  This would override that.

The boot option targets performance oriented use cases on many CPU
systems, avoiding sysfs scripting across all CPUs on every boot.
The BIOS default EPP (often biased toward energy saving) would otherwise
steer HW away from that goal. Admins can still re-tune EPP at runtime via
the existing energy_performance_preference_val sysfs.


>> +             if (ret && ret != -EOPNOTSUPP)
>> +                     pr_warn("Failed to set EPP for CPU%d (%d)\n", cpu, ret);
>> +             else if (!ret)
>> +                     cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
>> +
>> +             /* Program min/max/desired into CPPC regs before enabling auto_sel. */
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf for autonomous mode CPU:%d ret:%d\n",
>> +                              cpu, ret);
>> +                     goto out;
> Shouldn't this be pr_warn(), or even pr_err(), if it needs to bail out?
>
> However, IIUC setting min/max/desired perf is optional for auto_sel, so
> better to pr_info() and continue setting auto_sel?

Agree that we shouldn't fail the whole init here.
Even if cppc_set_perf fails, HW can still operate in autonomous mode.
Prefer pr_warn to pr_info as a non-zero cppc_set_perf return means a
real error, not a missing register, so it's worth flagging.
Will update in v3.


>> +             }
>> +
>> +             ret = cppc_set_auto_sel(cpu, true);
>> +             if (ret && ret != -EOPNOTSUPP) {
>> +                     pr_warn("Failed autonomous config for CPU%d (%d)\n",
>> +                             cpu, ret);
>> +                     goto out;
> Bailing out here would end up without DVFS support.
> Can we fall back to the normal OS directed mode?

Good point.
The fallback is already wired up: when auto_sel stays false, the next
else branch takes the OS directed path. So I will just drop the goto out
and update the message in v3.

Thank you,
Sumit Gupta


>> +             }
>> +             if (!ret)
>> +                     cpu_data->perf_ctrls.auto_sel = true;
>> +     }
>> +
>> +     if (cpu_data->perf_ctrls.auto_sel) {
>> +             /* Sync policy limits from HW when autonomous mode is active */
>> +             policy->min = cppc_perf_to_khz(caps,
>> +                                            cpu_data->perf_ctrls.min_perf ?:
>> +                                            caps->lowest_nonlinear_perf);
>> +             policy->max = cppc_perf_to_khz(caps,
>> +                                            cpu_data->perf_ctrls.max_perf ?:
>> +                                            (policy->boost_enabled ?
>> +                                             caps->highest_perf :
>> +                                             caps->nominal_perf));
>> +     } else {
>> +             /* Normal mode: governors control frequency */
>> +             ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +             if (ret) {
>> +                     pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
>> +                              caps->highest_perf, cpu, ret);
>> +                     goto out;
>> +             }
>>        }
>>
>>        cppc_cpufreq_cpu_fie_init(policy);
>> @@ -1035,10 +1106,18 @@ static int __init cppc_cpufreq_init(void)
>>
>>   static void __exit cppc_cpufreq_exit(void)
>>   {
>> +     unsigned int cpu;
>> +
>> +     for_each_present_cpu(cpu)
>> +             cppc_set_auto_sel(cpu, false);
>> +
>>        cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>        cppc_freq_invariance_exit();
>>   }
>>
>> +module_param(auto_sel_mode, bool, 0444);
>> +MODULE_PARM_DESC(auto_sel_mode, "Enable CPPC autonomous performance selection at boot");
>> +
>>   module_exit(cppc_cpufreq_exit);
>>   MODULE_AUTHOR("Ashwin Chaugule");
>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
