Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B72377020;
	Mon, 11 May 2026 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506977; cv=fail; b=bzBw1gmds9CXJ+PP9jjDZ2uHCkCyV3GjmB3apBkSCQIxcO2HpheFr2gmwt2qDd/+8QP1FqJliXK94PkHtM3+GgxvmBQutklx/ji3MVAYChLLTLEtO7Ax3mWYwpe7vhKEPjnbtaqSo9Az3orROksGmwT4PVWEc86H1Caidq7LV+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506977; c=relaxed/simple;
	bh=+yh43JQrTJZ5JZJRzWsWPmfjXSY2ul5IP9xxp7/74fA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lflxtvXsewkgAIG+PV+rsnZj77Qp0D8HBWt4GbeATJRGCGz81GqsAcechJFUb6RPz6iwy2XkLlh3WqpZ50silXUIFSCRJJsk9LN0dTYGRrQlDDpyN+8TPIQoY6w9lpNio1wVOXPqG5FCjzdpD67o2NUNQQo60ZcbgxXd8cJBBlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QeAjmU8W; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QeAjmU8W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvnTjHFQNFg+oVRfvcl7hgsqkIqRK5Hr3nLaneDLVlbrpl05xxbnB83x5S4oM3C2NlIwMt1H0bbzn2Mr/BE86gL+UmYWfxMD8iqxfMYc4WPP29CrWxhd10LQkEtKtZXRiiVfEQwrR3jYDr/N55puRyBfGXsUhA1TywyR0SaN8ViJtl31hcDs7CCf5iHr9ZQ5t9edl/hHyA4dc6FXDlVNxTZ9bJW15Z8R9hZd2YvW1+f+kqmZyD+NvBJnh8ORmT3+1mK+3TsbJQJJDSuWLNsqvKFUpSRcjmGawBoltVlXSA431t2CnjgNRfjOn2GbiX0uk0i2gb+72mkyiFRGl6c0nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQAD9TQk2Zlh41Gc676T1jVhFnzMpjG/OBq0i7AZ+OM=;
 b=fDvV56fm2iF3tgGyHTd4sIv5/p5oaHsNxCMv5DW7vvUCfh1kOjF0sa678BebfwfqQ0yYpEva8Qt+eIaEpUuu5T1VrgA59m1//n3ZDeoqkroSStq5twxVYe+KeHLxFm9jwAIZJayh+8nVyh0wDe5xSsiDpUS/j3x+3kfO2Ft9vMmfJ11fA34uY68CfmW1WM9uz1d7bLO7a0XYRQ7EKi4vcIQVLW+4WoHTgWUTzz2hoUuiZx7jHwpsXazTyP0K2jcU4QXBrQnDX6yWrvnn279HR7kreZEYgBPr3XmGOqVGPGYJcJ5o7Uf5P4nWJu4Z+vDf1TY+72HbKpyXRxUnVm5kRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQAD9TQk2Zlh41Gc676T1jVhFnzMpjG/OBq0i7AZ+OM=;
 b=QeAjmU8WYSb43Gsar9y1vwPRKrJ4dYJf9NNsicmltO6aqRp71OnrHZ3qrq5NkYylFA3PpHebVkQX9prJRFmJ7YVGKgokkrp5/0mvWMhfd2XVkWCmDl6JBtbu5eIdgVDNeNP1yav9p8QIITtqEe3ahDn7jTSval0nk3OLleTAVtSX9CiZtTd7S5iExhXnnGYyB3+UM4QfwTf/lBVDTSlr9zyCKxqy8j4IGyBsxsYFwUa9cEubFuvN3HFTBz8jI4mg5sUPapLx401gND3ITkGSmTHIV7qk5QvSxLH0/0Z4ZQD6kUDvTozX5M3DHtTYo3sCpxoD+Zt1a0Lc9KkFfhTDeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 13:42:51 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:42:51 +0000
Message-ID: <ddb44aeb-c810-43e7-8a37-4e61a16e612d@nvidia.com>
Date: Mon, 11 May 2026 19:12:40 +0530
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
 <bc06c3ab-0286-4e1e-a615-e704b267c21a@nvidia.com>
 <a9324a65-9da9-4e35-8c78-a054fb24bc8d@hisilicon.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <a9324a65-9da9-4e35-8c78-a054fb24bc8d@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:5:335::17) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: fa91d808-8d45-4f03-834c-08deaf6331ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	xGIDo4h/C+eR+vm9Ya/X5gsoLRzxf/8zNE6ggCpGyKn2AmH4pvYEV8Q+J+bzJ2nzxTrf4PNc7TONsYnrt1q1YnfPexW92oWuNTg1aTy25mDgjpG5xLXUfBeigoGrLfoh5JI+VMMqnKmzVqSmSCHnEJnaoWlaZLYdpvAJGw767v/HfpBJryDtW+sg0fItAI+jky7xWH+1ufHcOxcs/9Sm8t00gCV8l/ik0dozQeo8Jx/NhHW2+0SCiu/Zfdkiw9BZMCOA2l3DP7sJYNczQ+lZJcKKlSCeR4W2vhz8PEfhUKhgPh8u1t3er1t7qMmdI0TnuDcti30CsIuzzBo49cUPEOwCxGO1ffzyPXUGIsX6b9Qhm6wWyeFitX3rHtrL9xhKXxjSgPOj4g4Kqr3nQbtBtpLtkhDY9cywoa6sYEPjykfYgcBMBHAfpd9P3Md3L27kfEKdcgio20UmsQWAJyt7THFOoCy7cuUUyfH4fCeERAU/0WP3BfqDsQSZ7rEx0Rs9RbOPYpZ5J2uVN9B1lswOAWUxby5L0FDMgw53AYZ6ZSF8qRAAQF1YEATcu6FD7iStIZE4wndQdk1job1haX78OxQdfAjUvak/5y/ljfn6d57iSjW9D0xNA9oYTtiXf3ay7+B/aOvTbPRBsyLGO/c6dBlyxiqHJ0im/2bYckievxk/Ai8Wx7S2FCiETUQnbQZeiSU0hnaQ6V7m+dpebCOMj8gFfSA9rpMti5rV+u27jdeUqbbWqk/fn7nv11DfzSgf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2NINHZZUlI1L1RneVJiNjU3K1pjdVpsQnNUS1RJM3ZFUVYySStxSmVUanFz?=
 =?utf-8?B?VlRpb3VLbzVad1Q0ZW9YMHoxSWRDWUUzYm93NlIzZXJFUTVEUERaalN6ODJu?=
 =?utf-8?B?K1hOZXJlekNzRHp3Z09IN214alpYeTlDZXJIckZYRDFYVUJaMm5QSFhZZEJm?=
 =?utf-8?B?N1JmVGRuNHFjNDIzVmJyNElBSjZGdlpSMFlxOERiL25laGRIRllVRGtqVE5x?=
 =?utf-8?B?TEJlL0VvcUpLYk53OUhQVjlxcUsxaHVaVmpaUlcvdVRSeHJXem1leXZ0MEhm?=
 =?utf-8?B?M0MyWlNmS0I0YlFVU3A0ZEt2a0h2c09TUjF2ZzRnYXJzNGhEYlNMaDZzdHl4?=
 =?utf-8?B?MWU1dTBPRmUxbW5vUFl6M2Fxems1R0pvOTUrbzJ0Zzc1U1p0dHM0K2dtNitS?=
 =?utf-8?B?b1VqUFQ1MEtFZGxIcnRhQmdZTjh6ZWRlRm00d3ZkSFVwZjViazUxN1ZnWGtW?=
 =?utf-8?B?MlE2YU9QZGY5VDdBcTMzWTBQdDJVOG1BQm1VazRUNWtCMGVEcGpnL2xDeXRi?=
 =?utf-8?B?N0FOV09HU3FQQURYdEV2VFZQd2tqSlRBd29lVjlVVE4zWUo3SU55ZDlWeFFo?=
 =?utf-8?B?dzR5T1hwQzZaWWVDQ1RjK1M5bU9qTXFuSFVWRnlxMEVtU1BxZmJjbWtJbDdu?=
 =?utf-8?B?UVRMby9pWk1mc0NqWFhLVDNaTEMySjkzcG50aExLVkpYakx3NFJEMDlwR0J1?=
 =?utf-8?B?WVNLK2F1SUNiUEdQTCt3MlZpY25QbTdLYVlyNmpZbFNoRzl0YjFBTHZHdC9D?=
 =?utf-8?B?QTdSb0I2c0ZER3FzbzFQMU9LZFozaFdlQXQwbjF6aU4zVWs4aXpEb3BQdXhB?=
 =?utf-8?B?ODhiNG9BbXVxSm42dStSY1V3SVRMaVJwQTdpQnI4NTJKUmhyQTJjdVFWSG41?=
 =?utf-8?B?dVk4UlVMM1JXT21KTDlVTURsT1BUNzZiNUtETjluclU0NkIrUUFFOEdTMUF2?=
 =?utf-8?B?SXJtVHRVT05MNCtKRXJXdUhadm03bm13QnVGcmV0WXM1Z083YUM5TEN0L3Fx?=
 =?utf-8?B?UngwOVlPOXlTcDNMaGp3Qk5VYWdobjRvR1diMjlJWC9MTXFlS0pwazZLUGZE?=
 =?utf-8?B?ZmNTS2pkYXZNUkV2Q0xWTkgyRk05YjErbUU2WTE3UlRCU0EvV0Fxc2FGZEsw?=
 =?utf-8?B?VkV5N1RIWjR1ZEJRWGxaQW5oR0JaQjF2bEZRaGgrejl0QzFiSTB3U0trci9m?=
 =?utf-8?B?SnpYOHpsaElob2k5NGZjQkUrMkdPYmR4dTZERmtRMTdCMzNRR2Q1V3dIYWxh?=
 =?utf-8?B?QkZVT0tDaEFZRHRnYkwzd1gxRjhjSStTM1ZUeXgvY08zWGQ1N3ZUWkVudUo0?=
 =?utf-8?B?VUpKR2RNRHU2NlJJSDYrZzNVY2tQRktJMlNXUVhBTWZXNWE3blgraUxYYzlR?=
 =?utf-8?B?OEJkSnM1R2pURE9MVFA1OGVCSDhXVnBrZWxzOXBSZDZIVFFYUkRSeGdiMS9Z?=
 =?utf-8?B?Sk10TERjZWY4MTdZZDU5dWEvY2V4eTNoeFhkQVU4NDhOS0NkdkpYU3Nxa3VY?=
 =?utf-8?B?YUpXZ3BNV3BtQTZRTTR5VDFFTnJYeG03c214TnVEOGp6cTJaSTkwZFIzRjVZ?=
 =?utf-8?B?VENSUEdBYmk0WEhvaHorMnJrUkN2YndxQzQzL1RUTUNxeUIyaE94RGdibTYw?=
 =?utf-8?B?K3g1R2xaY3VhOFpuVTMzemErdWZ0aUdFa0Q5QkcxOUZDaFZnZmtXOFJCclhs?=
 =?utf-8?B?dkxncGowdWVtdmJWVVA0U3JBZmFEWStHbHRQZGZDRVFLV3ZzMEVieG1IMCtC?=
 =?utf-8?B?ZVJXU3A3UFRSSzNXdkJzZHFmbmFCZWdYQ2luN3A0QzQrYmg5ajNOYWw4TFpi?=
 =?utf-8?B?Y21uMWljNURFZVhKbk5HT3pIVTM4OGpWbkxvS1lqeEYwRHV6UUxoL3ZPMWY5?=
 =?utf-8?B?RG4xK0hyV05RRGtmS1V0VzE2UzJBWkcyUnloZkVBQ1h4V0hVZVdxZjRSMDgr?=
 =?utf-8?B?bUEzM0VYRDNvUmhza0s1T09mWnZpWmY3YXJFQzgwcVZQcEhlcm41biswNWgr?=
 =?utf-8?B?SFZqQ3FVMFEyNjFJM3BHNFduSGpraWZDbVI4ek1ucUNBQ2NibU5QWUM2OG9C?=
 =?utf-8?B?czNuYnI5VmNySFdsUkFzS3RaM1MzT3U2d1FPKy92QWQyengvMlZVZW5QQVpi?=
 =?utf-8?B?OTRQbFFpU2FIcVlXMElCckJSVGRDWUZiMC90MXZmSEthaWF6T0tRampRY09J?=
 =?utf-8?B?RTFVZEtaTVFGQktDV294ckFTTlh4WnBQajN4TDJQdkxjM0xmbC83Qm1sc2di?=
 =?utf-8?B?UHRMWDk0dHJzYVduQWRhMk5ObWhWUmdEcVhqQjhFalFJMmdiVlVnRksxdnF3?=
 =?utf-8?B?MlMvMndHZ01kT0ZGZWMwQkJUV2ZSRjNPYTBCeDRteldTNmF1NTQ5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa91d808-8d45-4f03-834c-08deaf6331ea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:42:50.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6e+B6aOt8Lapu3V3Uc6/xdfEi3pM6WkAtjSFPHpIOIvQwRnycmvc1OzGFcaAS5u6ejkTSkGblPV03k+HURFeiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551


On 08/05/26 08:03, Jie Zhan wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/5/2026 8:29 PM, Sumit Gupta wrote:
>> Hi Jie,
>>
>>
>> On 27/04/26 13:54, Jie Zhan wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Sumit,
>>>
>>> In general, I would expect this parameter only toggles on auto_sel by
>>> default.  IIUC, other CPPC configurations (min/max/desired perf, EPP,
>>> enable) are optional and not closely related to this.
>>>
>>> Why including those stuff here?
>>>
>>>
>>> Please see other questions inline.
>>>
>>> Thanks!
>>> Jie
>> These together provide a known, predictable autonomous mode boot.
>> min/max/desired seeding ensures HW has a known starting bound (BIOS
>> may leave them unset).
>> EPP=PERFORMANCE_PREF is needed as BIOS defaults often bias toward
>> energy saving, and admins on many CPU systems shouldn't have to script
>> per CPU sysfs writes at every boot to undo that.
> Hi Sumit,
>
> The min/max/desired perf might be a slightly different case, but the EPP
> value should probably follow the default if there is?
> Otherwise, users may complain that their BIOS defaults don't work and find
> out it's driver's fault.
>
> Alternatively, we may also make an assumption that we ignore BIOS EPP
> config, but not sure if that's suitable?
>
> (Perhaps let's just discuss in the bottom trunk because the main issue is
> pretty much the same.)
>>> On 4/25/2026 4:18 AM, Sumit Gupta wrote:
>>>> Add a kernel boot parameter 'cppc_cpufreq.auto_sel_mode' to enable
>>>> CPPC autonomous performance selection on all CPUs at system startup.
>>>> When autonomous mode is enabled, the hardware automatically adjusts
>>>> CPU performance based on workload demands using Energy Performance
>>>> Preference (EPP) hints.
>>>>
>>>> When auto_sel_mode=1:
>>>> - Configure all CPUs for autonomous operation on first init
>>>> - Set EPP to performance preference (0x0)
>>>> - Use HW min/max_perf when available; otherwise initialize from caps
>>>> - Clamp desired_perf to bounds before enabling autonomous mode
>>>> - Hardware controls frequency instead of the OS governor
>>>>
>>>> The boot parameter is applied only during first policy initialization.
>>>> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
>>>>
>>>> This patch depends on patch [2] ("cpufreq: Set policy->min and max
>>>> as real QoS constraints") so that the policy->min/max set in
>>>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>>>> during init.
>>>>
>>>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org> (Documentation)
>>>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>>>> ---
>>>> v[1] -> v2:
>>>> - Call cppc_set_enable() unconditionally so CPPC is enabled for both
>>>>     OS-driven and autonomous modes.
>>> Why adding this in v2?
>>> This looks like a separate issue since setting CPPC Enable reg doesn't seem
>>> to be related with autonomous control.
>> In v2, moved it out of the auto_sel specific check.
>> Agree that cppc_set_enable() is general CPPC enablement and can be split
>> into a separate patch in v3 if preferred.
>>
> Yeah it should be a separate patch I think.
>>>> - Init min/max from caps instead of cppc_cpufreq_update_perf_limits()
>>>>     as policy->min/max aren't yet populated.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
>>>> [2] https://lore.kernel.org/lkml/20260423084731.1090384-2-pierre.gondois@arm.com/
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         | 13 +++
>>>>    drivers/cpufreq/cppc_cpufreq.c                | 89 +++++++++++++++++--
>>>>    2 files changed, 97 insertions(+), 5 deletions(-)
>>>>
> ...
>>>> +
>>>> +             policy->cur = cppc_perf_to_khz(caps,
>>>> +                                            cpu_data->perf_ctrls.desired_perf);
>>>> +
>>>> +             /* EPP is optional - some platforms may not support it */
>>>> +             ret = cppc_set_epp(cpu, CPPC_EPP_PERFORMANCE_PREF);
>>> Why setting this to PERFORMANCE by default?
>>> A platform can have its own default EPP value.  This would override that.
>> The boot option targets performance oriented use cases on many CPU
>> systems, avoiding sysfs scripting across all CPUs on every boot.
>> The BIOS default EPP (often biased toward energy saving) would otherwise
>> steer HW away from that goal. Admins can still re-tune EPP at runtime via
>> the existing energy_performance_preference_val sysfs.
>>
> Yeah, avoiding scripting makes sense for sure.
> The thing is how do we do this nicely.
>
> For now we need to consider follow either the BIOS default or the driver
> default.
> They seem to be exclusive since there isn't a clear way to support both at
> the same time.
>
> So, are we going to support the BIOS default case?
> For example, users can config a default EPP in the BIOS setup menu.

To consider the BIOS default case, we can extend the parameter to accept
an EPP mode in v3:
- cppc_cpufreq.auto_sel_mode=performance / =1 (EPP=performance)
- cppc_cpufreq.auto_sel_mode=default / =2 (preserve BIOS EPP)

Thank you,
Sumit Gupta

....

