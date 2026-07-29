Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91245FFAA;
	Wed, 29 Jul 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344746; cv=fail; b=DG9f+lF70EmgCrdxCVqYpyXhRdUGfwqz1ESWJ/VcnthDed+/vnqGC3ey10o13AUBc41H4B1Ncf+m7nLopH7vexJPYg+/bFpfDgu9WHmaFqwLGopAkUiKFxNR+mMKcf2HVESWObv74ZRqo0o+LYE6Va9MtBGPaAxhIgQJQ9E35xE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344746; c=relaxed/simple;
	bh=Jn/N8kmOYGopTe91U/bY5rIb+GaApduhF3geXCx0Rd8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SeEyuXQZ5gdVpLXKsniJCBx3f86Vr7q67VYtwXk16hV42cXuI1sfd/+Y7OcVVLyBV4g6Xj88Hb8uoknSUtKGol7C1x1ujXAdZPtPhm5OoK+CRXoJ/1qlOHrCDjAT9JljFUErrROwwh7EU4+qLbZDi4eXxCbFdgI1yQmdSZbQU8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l9rSkAxy; arc=fail smtp.client-ip=40.107.200.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l9rSkAxy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfHSsJ0TXBdIGMOFWOXjJeSizvMZ9u2WAZogA8k5p+Qz8iFIGxDp0gzHkqllGbZbtRQR5TWLcdNJVvMHWzJipsOZ8RVcylNcEjV1e2fpZBhkySEexHB5kG28vZAkO/NAbg0qXvRAzOOJTQ1uvScNk4Mp+0TwJMLzbX3jZ+NW25DXRb1etTGmR2ux/AiXPhj3BPGHipIHC6IwpmOA4B713o4g8QngFo8r71z9KXvMOKLYIz2GifB43K7PXyQf/RcrZ69eG7My3Bnu9PPj8tikc8FTF1OeiMfN43MzQ2+e5dRSPEDOI+0sK/qG9OI1C7D6EY9jV5+Hp0pqL9zH0E5KEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEmHSZvYXrFt4/htW7zsdsROiKa1T0/hgmRSeLysJyo=;
 b=O6q1/0408BRCxEojoZfqkAJ9D7WK2StGlZN5ulvc3jO5LQflfxlXReMoswiSpIYUJfVPxqs5ia3eCImgzQE+SA63tcCLAzovHGr9PA30ZBl+KDUvepEgz7XzIg6fUL6E3k3VehuApl0TuFWrYsJKkeVHoU0fIKvIlXEqdaK/KwuMg1w+wG5W/QaFVaQZj6gfV6mb4OgBwWK+oYTLX6H1DkRUl7DPqlYKia2x/TqSinqCJ3bum7TFkdj5zf0CAx8HmjjzjTZjVU1U8YB8O9mSYKPchSa78RRADGmv5Qj89MMOVDajBauZTGCJVeieHaAU/fBhUWpyivaBxZjtL6k00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEmHSZvYXrFt4/htW7zsdsROiKa1T0/hgmRSeLysJyo=;
 b=l9rSkAxyRB3qLLTtq2mLVQ55PcZ3Q1JlkiTXUXArTc7b2C9YjbL+WR55M5EY5qtKx87vgZyycpKN23/+CiMP36WdHwG81WAELoCVnAJK1ENTReSwXPi/z89etX3NW2D8pjAWfgacNvPpyRevTx9/fbAyMe6mq6rqeEk7l8mkMb98fqfPcc55lQjI/9C2EmP3c8zDE9Gt7O169vcdgMvzjSZ06Y4yUFrbH7K+FztDiMKZ/WJZywI8hOi6zIo6KaKkol2yT2qVnnZVSk0eZk0/W5k4AQ5Kd81xNTLcigFI/VeDfL1wDDCx5rfk1LINs3miszsetYDygZRjGM36oKKC8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 17:05:40 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 17:05:40 +0000
Message-ID: <161afe04-7d27-4e93-9ec5-db00caf99869@nvidia.com>
Date: Wed, 29 Jul 2026 22:35:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] cpufreq: CPPC: Keep the policy across CPU hotplug
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, christian.loehle@arm.com,
 ionela.voinescu@arm.com, zhanjie9@hisilicon.com, lenb@kernel.org,
 saket.dumbre@intel.co, ray.huang@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org
Cc: treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, mochs@nvidia.com,
 bbasu@nvidia.com, sumitg@nvidia.com
References: <20260724215937.3368276-1-sumitg@nvidia.com>
 <20260724215937.3368276-2-sumitg@nvidia.com>
 <a4891cdc-9635-4ad7-96b6-f62c39aa254a@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <a4891cdc-9635-4ad7-96b6-f62c39aa254a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017A.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::45) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e81bdeb-11ad-44f6-d761-08deed939e0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|6133799003|56012099006|11063799006|5023799004|4143699003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	IXMtQrZos57uwFvRYN/Cz2Aj/sstO6dAiuBRGdJnI8jHk0MOYJaZ4cP1rJZOgmjnuXUEHCnjvNcWbn7Z7tTVKqin+vn8m5cy9sj0PWyoJ4qsWgWEzec3jknFxL87USi48HATZD6/Z9liCBA1kbsYb71d2aBRKUP4DrVrZsh3XV+XUSBl6ghtwKq25Ce7prV/FQ2niYoWiLCoLs6ExQOlNt8/vys7RQ6dV1A1zhK98h2Ii3chzlPhdSg0GLo8nnbovaCvPBv648PBDst4NPx0FvNxsCoVzjcBjznmmlBNTnQCWD3TWkhHiDBEY9JOsYisapOVMtSa5fG+rEU/5EWmTf+fLRo0OUhuzCeFh7ejnnlpYbphGvVjCTtN6dsovtzunpKdhIhkaiwG3iuZrDyHySLVVpITxe9T+cLJi5iOa0kOZ6cgTsSzwqqZMDLDSkbfqKt3ARgBIF4nTvOQApoEIYTAvVPX+tKw5vnRU3PWPF6vzatPDY6K3vamn8uXO91t9+TPt1Gf3b1oDerGXjtOSKnQ3wn+HsPRsdxDVbl2kE45pPW75MHFf/V+s8fGx/8hyU0JCmyRJWzmwJpSA8IRPaDP2Gp+9rGk6G2Q7c6U/rkp7rCZKMg8rrcNfNPTRFg+NSzBcsxlF3y0o4DgrP0kdHFx2jB8MfjeY3LMpZySfMBHEAxHzN37/D36EytdhLDBc4AToSSSmAqmjshqUGM9Jg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(6133799003)(56012099006)(11063799006)(5023799004)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0xtNEwvRnJ0d2RDd0pvZmZrck9LU2pvdTBMUDcySEFQZC9UZlVHa2pic3kz?=
 =?utf-8?B?eExYNVJBUFNyWEZQWVg4MTFtekdiOGxSMXcwdktPWS9NN0tJR1p1T1JPWFls?=
 =?utf-8?B?L0dOZTdXTTlrNVhjMWpWYzhCdllpdlE2djc2dmJ4d3J3RFN1dWorYVNhMWdM?=
 =?utf-8?B?L2x5bUJQeFJIWFcrSWgwYi9xbit1ZXE4ZERyQ2xubGI0Y3EydkJPZ25TNTJG?=
 =?utf-8?B?NU80QXZNNzlBeWpVZXBQbGFVZHhqK0RhWU84U3VCRmoxMkxVYkRIV25XVHM4?=
 =?utf-8?B?SCtGQko1TDhyL1pkc1l5cFVjbCtDTXM2aUFQQjlSQVR5VkNQQXVidFZMMFl5?=
 =?utf-8?B?SjRRSWhRbC94ZjgrUkxVS2NpRWg4bDlsY0FsQjJFK0p3TGlvSXRod2dNcElo?=
 =?utf-8?B?OE1IcVpNQUExb2VyeEJ2bFZVaVR2WWh5Ly9OUU1FRHZSc3Zhb1NTc1dFNVN1?=
 =?utf-8?B?cmtHcVNHWVduU1dvaUg5cTQ0aTlobm5XL2FVVGxUVlhQQm1RZ0d2NnJpbmsw?=
 =?utf-8?B?d0M4NEs3TFFBWUhHMG94K1VRWFg3MmJaKy91RnF2d1BoREdRZ2pTOExPa2NE?=
 =?utf-8?B?MUxYV0tDVnJXbnRlenF4V3krbG1scGZ4Y29aMmZ5QzRCeFJnY0J6K0VHYzly?=
 =?utf-8?B?N3E0ZHArcFI0Ym9CZkNrRVBTelVrUUF1UmY0V29IVVMrUHJvOVVHYzhvVi9a?=
 =?utf-8?B?VmNLbHJCenBYTEl5S1YyRUdNU2UvaWZhRCsxc0ZJdGNQR1FSd3lpMmZyMExZ?=
 =?utf-8?B?cm9ZUkloODlBZXcvcmhreGNXYXhUOVd2b0tlM21CTTZXdEhFZ3A0RHZTeklN?=
 =?utf-8?B?aVc1d3I5SjRxQW55Qml0T2xOcjdRaHFGRWNHVlJpaTdxcXM2MEtLK3I4VERU?=
 =?utf-8?B?V3NrcmhaUzhlaVFtNVhmclFvdEVVTGN2UWRTRGRnSDVUUHI0QUNwblN0YmE3?=
 =?utf-8?B?S2pBNEpyTTZ2Ylh5S21CdXhSWjNIMXJkWjVaKzZHaUIvbkcvMkpCdWFDZ2N3?=
 =?utf-8?B?QXQ4SWtlMXdMUUJCNENrb25QRnQySEd1K2grK3luOE9tNWRGTnZkRWRpV0lv?=
 =?utf-8?B?cTdKc0hWaUVWVTl0UnBGalZ0QlpPNTlEc21zY21IMzQvNkNmNlZSRTJxT29K?=
 =?utf-8?B?cFZtand0UHVrUm56ZndqbjJuNWV1b1NWTVdpVlk5NGdKTWFjL0xzV2xEYmoz?=
 =?utf-8?B?RmZidmlSOE03aEp0cFhyV0FMNnVMYnpVWG51SEI0SXhqMVh1c0x6SGo4WTRL?=
 =?utf-8?B?OUpBZmc1WVBRY3EvSGpYSkJ0VUlBaXZCZXdMM1R6MFVDREJ6U0hJQSs3WmtF?=
 =?utf-8?B?d2NubTRpVkwrSkEyRVQ1aEJHZlRXdDdMWEdzV012RWxjdXI1SzNXb0ZxaXdQ?=
 =?utf-8?B?ajVLRWJtMTlrR2JIbkhQWHBWQTJkRlNZb01vdUlKN2VaLzZ4RXNTQm9rRTNv?=
 =?utf-8?B?dGdNQXV2T0hrNjIzMWJmRjdYbk5NSVh3a3FMUUJ0RzZTZXVqWVNmQWZ0Tklq?=
 =?utf-8?B?aGo2UTN5RisveXFSWk9pL2svYXZwam5sNWF0dkhkanJiQjlodmNDVk9Xai9P?=
 =?utf-8?B?WVJxTzBUc3NVMHBPb1ZIOHQ1MFVvc3hRSUZyRmk3b2NlZW5MY012SThWdER2?=
 =?utf-8?B?NE5FQUxUZjVvR0pCdjJUYWZESVZhME9WMUNhUmVONU1vUXNOOXB5UHJudFJX?=
 =?utf-8?B?WVdxdTM0S1FmSmRaS28vckV1SHF2QVYvWUg5cDh6SFdJZkR3S3ErL3BYUmEr?=
 =?utf-8?B?bXNCZnh4dEhCRERzNEhHc2RyeU5ESUZ0YUdmREUzY0tFbmcxa3F2WDFTRHdS?=
 =?utf-8?B?MWs5a2x4WXZwa0RmQ3VPcy9obG5rajA0TldzTjRRdVc0eENnZDd6cVpVMFpR?=
 =?utf-8?B?bURsT1hYenFiUDVuNXJXYmkwYVdFMjF2TTRRSjQ4Y0xtR2o3U3pzMi92OWZS?=
 =?utf-8?B?Ymo4c0JJb2JQMi9URlZjMHhCdGNLSnlwSWp6Z0tVS3FpcFFOVGpxRG5sOE54?=
 =?utf-8?B?MDEzaTRQSi9tYjV1a1JqWElHNzRZMi80TkxOUm9MU1U1UFNQbEpwQW05Q0lF?=
 =?utf-8?B?NDJaK0JOQWxGQitNU3FRNXV6YkM3T3VtcEU5SDQ2d3BuYmJYZk43UjllM2Vy?=
 =?utf-8?B?a2h2L3AwTEkweWx5ZmVyMGRHYjA4b01UcUFNd3JUZjYra2VZdk1mSElHM0hy?=
 =?utf-8?B?L0VIM2FZMU9QQWxGRlJ0UjUwVzhwYlVDb0xDY2JpRmRROCtOUzRPWTNlRHRF?=
 =?utf-8?B?Rml3YjJWVWRWdFJqNUo5VXN2WUd2cnNKbDZjKzN3WSs3RWMxMVF6bXNmczVI?=
 =?utf-8?B?U3cyUnpxRWZjZXAwaGYwdlVIT3RqOEhGT2pCOE9WS2x0OU0zc2t5UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e81bdeb-11ad-44f6-d761-08deed939e0c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 17:05:40.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKftv7p3Hd5FNhoaNxN5FtbcvcnoxRVoRguuYuNO8gECHpjkbIvpIfayS8c0KJO69Q1vJr/lZpYnYxSze557ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418


On 28/07/26 14:11, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 7/25/2026 5:59 AM, Sumit Gupta wrote:
>> Without online()/offline() callbacks, the cpufreq core fully tears
>> down a policy during exit() when its last online CPU is offlined, and
>> rebuilds it during init() when it comes back.
>>
>> Add lightweight online()/offline() callbacks so the core instead keeps
>> the policy live and reuses the driver's cpu_data across CPU hotplug.
>> This avoids re-reading the CPPC capabilities on every offline/online,
>> making CPU hotplug faster.
>>
>>  From online(), re-enable CPPC, as the platform may have disabled it
>> while the CPU was offline. Since the policy is no longer rebuilt via
>> init(), online() also reprograms the CPPC performance controls
>> (desired/min/max).
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index f6cea0c54dd9..6dc59f99d880 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -722,6 +722,48 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>        return ret;
>>   }
>>
>> +/*
>> + * With offline() defined, the cpufreq core keeps the policy alive when
>> + * a CPU is hotplugged out.
>> + */
>> +static int cppc_cpufreq_cpu_offline(struct cpufreq_policy *policy)
>> +{
>> +     return 0;
>> +}
> I am not sure if doing nothing here will cause issues. In my view, to be safe,
> we should perform the actions found in cppc_cpufreq_cpu_exit() here, except
> cppc_cpufreq_put_cpu_data().

Agreed regarding the performance request. Since exit() previously set
desired_perf to lowest_perf during hotplug, I will do the same in
offline().
I will keep FIE registered across the lightweight tear down, as clearing
it on every hotplug would add tear down cost with no benefit. It does
need the feedback counter snapshots refreshed, as init() no longer runs,
so I will do that for the online CPUs from online().

Thanks,
Sumit


>
>> +
>> +/*
>> + * Re-enable CPPC when the policy's CPU comes back online, since the platform
>> + * may have disabled it while the CPU was offline.
>> + */
>> +static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
>> +{
>> +     struct cppc_cpudata *cpu_data = policy->driver_data;
>> +     unsigned int cpu = policy->cpu;
>> +     int ret;
>> +
>> +     ret = cppc_set_enable(cpu, true);
>> +     if (ret && ret != -EOPNOTSUPP)
>> +             pr_warn("Failed to re-enable CPPC for CPU%d (%d)\n", cpu, ret);
>> +
>> +     /*
>> +      * The platform may reset the controls while the CPU is offline, so
>> +      * recompute min/max, clamp desired_perf into range, and reprogram them.
>> +      */
>> +     cppc_cpufreq_update_perf_limits(cpu_data, policy);
>> +
>> +     cpu_data->perf_ctrls.desired_perf =
>> +             clamp_t(u32, cpu_data->perf_ctrls.desired_perf,
>> +                     cpu_data->perf_ctrls.min_perf,
>> +                     cpu_data->perf_ctrls.max_perf);
>> +
>> +     ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>> +     if (ret)
>> +             pr_debug("Failed to reapply perf request on CPU%d (%d)\n",
>> +                      cpu, ret);
>> +
>> +     return 0;
>> +}
>> +
>>   static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
>>   {
>>        struct cppc_cpudata *cpu_data = policy->driver_data;
>> @@ -1034,6 +1076,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
>>        .fast_switch = cppc_cpufreq_fast_switch,
>>        .init = cppc_cpufreq_cpu_init,
>>        .exit = cppc_cpufreq_cpu_exit,
>> +     .online = cppc_cpufreq_cpu_online,
>> +     .offline = cppc_cpufreq_cpu_offline,
>>        .set_boost = cppc_cpufreq_set_boost,
>>        .attr = cppc_cpufreq_attr,
>>        .name = "cppc_cpufreq",
