Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2D36493E;
	Mon, 18 May 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111877; cv=fail; b=FN2XX3x4/Ufovg+U7zSlKXRB6ForMM9eFeCDMCiQOnSA8A80npjlQOlNJAmu9Z5NdQXqyHo3gkyceg17D6EdrNBRqoBafeDh8Bs0ghzMWR/TM408Z1yL7C1Vp2EWuR0zw3lNWo9DTz2L9foGGXe0O94Qb10LkcJu6094clvKc+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111877; c=relaxed/simple;
	bh=xTv1q9E421bTZBhob+Me3QrKiYyLpXYM3XHY4Vyyt5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hbbfYbZbV1+b7Sl+znTAp4bRJ3LNa2BB/BbCsyaWc7Z5DAPEgz2xXixUJybr2s5A05V3xeAhjhsOvyotiZ2+7+PcF5bvBbaos406VN4tZhXQLZC9r3SYOtax9qm88Pq/gCoXpDgCuLTJz7Dd6a+I/64U99P/NzCgGSA+ckYpmpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J81VGt7c; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J81VGt7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhOJWeQV39Vg5HUxQYf/HEV0t1RgvBSLVCaoQQmam4Dtej6RIrXP00S5ytlaR19z7y8TV1WCO8XgHmjUrM9qLujke6jN1AL/Xm6bVH9xpA+XhMnywxFZb9dk1S0cfj+8SJc82CI/NNNuTceKVg/qBkmvyFEaVnieeVaAVnbGpj1f4W6Wkvqk9eKCDN1e0bh79DwFjSb9466XxoykzbQPHFpnkA9FNYh5HCdFIOBKPPPS7t34QEqn3iFTCwAw+kNT4pWb7vhVOWSeWw8vL14qVa3WBttc40U538Oem1SAIBcgjU5lFW3HCxsJsjpNAJIhxtSpI5xWv7tngLOwfDk15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0+fdHLnB7vSRJTJEC25BhG17+/FgTDWnn2irS/HLAA=;
 b=VJlLvzlealGkHTMk/efbFC/5hWKBeIKGXc+FV3wk3Vy8WPKvdlsy2REV/gVKXRjKgYx5GR7puKGxby+xGMBY8f1P4/QtzPxxaQJcT2y0721idYt0FozjxqOnjssrE6L9woFsJq9/NDp76ALGX4uq1KyBvXoDr857uwP7inAGQ2Rx7Hm2K3t8O4xYPQbUryE0lawzmVRlNe+XoUIJLx4XxaZAbh3M7oYQVzvpc7yUkkRh5dcFMLHcg2aY83oN9ItHfi7LLUuAAG2tNw4JUEAC6cxiUSQAQaKTGlDw7cg5qyx9m1SamGLqXy4e2DxNDjdZdTDGRbPxYxb4W+jDmoa/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0+fdHLnB7vSRJTJEC25BhG17+/FgTDWnn2irS/HLAA=;
 b=J81VGt7cDf+s4FmkaLs3UuLjHBq137avEsjSnzS4DaO8e60gGiy0iPlkZMBcvlZakbmWR42nRyn/PW8L08ljCiL9fhsLrnIECdFPdH8eGtl9yPjcaapmaeG36Lv9FRxfOuy9+GNpGT46oFT5TDyFr4Mjokvxd4ALTILAavE7rMxqC6DhH7PWa1NB5MPJfgXjdoMxGbu0PPM4GGmsQbh4DuspMLtPwTERTdTay9qNDrkAFznGko1stR2WxgCwAgXjOfjoPJ/el4KKMUuQYT8qXjTfQbvdMIiMq8dLvt3fPQMAXpMO4/DGvC6lF7hqpkNPgCUMyBKYv5VDhU0zDwIH7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 13:44:26 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 13:44:26 +0000
Message-ID: <139d2f0e-72d9-4721-9d5a-d1d4a2a95fa1@nvidia.com>
Date: Mon, 18 May 2026 19:14:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpufreq: CPPC: add autonomous mode boot parameter
 support
To: Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com,
 zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com
References: <20260515122624.1920637-1-sumitg@nvidia.com>
 <20260515122624.1920637-3-sumitg@nvidia.com>
 <bf521e4e-1aa5-49ce-bec5-52845f02214e@amd.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <bf521e4e-1aa5-49ce-bec5-52845f02214e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0207.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: d043ed13-b9e6-4ee3-9686-08deb4e39356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|22082099003|56012099003|18002099003|11063799003|3023799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	kWo4fGGJSiJUq8HAFYWSpjQbJd0DxJlqHfWYZgU6cDxiepWc4OxtIds7KiUBxOCp8CNhSD+v39O2TrwIABzSCzPdMxnaxhhPWNiOpgHGnA6+fd79RJR0a4X/2V6M8zowGs1c9Ug9ZN6SRGTrjgt4OToBiWQlnyGb+ccI9R4AxDsbmvWGc45zcNRbzU6C7J7+pBbrzmFu4hTDWrBDxX9yylUq3NoKDyPdfJOJOquDZA0G5mKF31mYtFodlCoADp1UJqJh6FO91cfEKIs+EJONqQWkS0sZrtJUCJdAzOJWd5P9jNIo0vZdoSFG5xRTIbLqd721oqaq4k+HzdA+45h3zOzvhvaf0zoI5x2+6b+ixPWPOasgOsHGDFR6Re3QXQcdD9P7wXvMeRXlDl6PMdgF5OlCBShz29XH067pDcaVt0YfQQ7IcEespuXIHSi0hsf2L9yO3GjG+lqyJ1AISD0LYiaLV7HZMWd0zZFiqWTKHn5Ss2ViMoI1QHth5FGiOsNHcwwoFDoUUkjrxdoFun8bTtJipT7If/FJnRAv1kZg5nJ3lu7bfZ6LG/MDhtISSA+lQti2I3vcYnJeu/nlvfOwAme2p2EjWqt0WWwDfS0CsxwN7mO0k4iRzKefr/5joXTS6r98BiZQBgVGABpDwI3FyazEwfnGnH09CI+MAi8n2ZEwOAk6R5X2t9tLjgzOQde9ehXWna8aoaCNjTHuc/CD2szTsJQ/kq11OAExOHyoZeoGgR8YXOcQd5G80dvtNvf/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(22082099003)(56012099003)(18002099003)(11063799003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk0wWElVQlYveTNMVFpaaWxoVmxYR0Y0Y0hWbW5MaWNBdWdwVk9lSXBPY1JN?=
 =?utf-8?B?bUYyZ2lrQUlxQ3VXdzhNSWVCMXROSE9YVk1IeEtRK1daZDI3ZkJMaVpnSzRN?=
 =?utf-8?B?WExUREI2RVpaVHEwRXVORGZ1UEtkU2dGMmhlS2tuOUQ1QlFwaG9QMWJ6V1Uw?=
 =?utf-8?B?dG40bUJGVlYxeDlYSGVJR1YwOEpaRXhvUXp3U0NMMDRFeU1zQUVBZ1dyMXB2?=
 =?utf-8?B?SWhWNm9oNGtKS1dCckRqVzh1b2dremZEZjdyZnE4dGZ0WFl4alFybVdNdzRM?=
 =?utf-8?B?dzVPbUZITlBoYnZBUlhLRkVEdVdjek96RTlYUVRzYmQxMVhYNGtMZXZ0V1ls?=
 =?utf-8?B?eksyRGczTHdaeEZJSmFBZVZJMmRDOUlOeXpqNEFKdnJVRDN5U1dsM0ZtYVJs?=
 =?utf-8?B?NVhVZUtoQXNKVE1VWFFzeGJaTDBWeml2R3pOcnBxK2lGZ3Y4akxtSGlNODdp?=
 =?utf-8?B?RW1sYXZLM1p6OUczV0hKQksrWDB6aTYrT2FsYW05S0JsU2tmaTBTMVU2Y0ZS?=
 =?utf-8?B?VTRWMnIwL0plSWFzMmFGYno1ZUp0a3QyUHBsTENMbzdwVlQ1VUtaRDJCRXlH?=
 =?utf-8?B?OGNYcDViWGZnc2Jld09XN1pLcENMRmFIb1RaZytCNkw1YUN0M3ptNmxiaFYw?=
 =?utf-8?B?VWFYRUhDKy9ZanZGMXJNOGNaNHdScUNNd3ZLc0syZWEvRUVSY1VSRlM1NmNB?=
 =?utf-8?B?bFQxNW9pL21pOWFUR3pEeEs2cnk4WFZjcjNyenNCREozdUNVa09lRWJ5dkJB?=
 =?utf-8?B?UGlvUWp0ZjFORkxBWlllYUc4UUtETktpSUZUbW5KN2VKY1dxTnEwL0FDZUF2?=
 =?utf-8?B?QzdRU1hwc3luQjVxakJCN1RHdHp1Qkx2R0FYWktxSDI0c0pQa2pjQXZtdFFI?=
 =?utf-8?B?ajNkOFBEOXM0ejhKTlFEalh6ckJQOVNuMUpxck5QZWx4T0kyTTNpbGlMMzUx?=
 =?utf-8?B?R0hyYmFSK3ppWG5KK0kvVjFaLzQ2WUkwaENiam5jU09lSW41MVNTdTF4K3h4?=
 =?utf-8?B?UjBRMTd6SWYwV3kzQjYvRldjYmx1eWhTS2UyUDRGSVJuT3BJZmpxNFRMMGg2?=
 =?utf-8?B?ckwwZ2pORUd3VGRJeURIZE5TV0wwOXVYTDlKY2ZmMHB5dU94dEFxdVA4UFgz?=
 =?utf-8?B?WXJSejNBcWk1RnJ4d0tLNWNoeDJFQnBzcmJEUURIOGZYUSt2aGtxWXpldGhv?=
 =?utf-8?B?dDliVTJQdkVxdHdpMXNJMzdaUU9IcXA1bGFmN3cxV3pUQ1BUSmZvZmtSWjhj?=
 =?utf-8?B?VW1WTGhmSTFNTDNZaTh3Sk1nOGJLK0dVSWJnYW1oeGZ1OEI0VnpFaFBlbENI?=
 =?utf-8?B?M2ZhZlcrR3N1cXlSYml0a0JHdmhJSElsYU1OODJaQ0t1eUFMdHFSRCtlUlBj?=
 =?utf-8?B?dWE5UDlUZ3dSalBmTUV0TDhQOHI1aGszKys1bnRVU3FTaXoraVFSQyswK1hD?=
 =?utf-8?B?K21JWHhyOFJ5TmMzTEJtakVuS01oYm5xalhzSWw0Rmx3OU1lQU0vdFNPR3Qr?=
 =?utf-8?B?VTdoS2pock5Dc1BRaUwzQ0lneTNiM3NtT3owdUl6bVBpYTFzMVh0U3FKdS84?=
 =?utf-8?B?OStEb3hOZzJLa0lNRXFqWkIwcDczM2lCU2NLT1lTSGJ1NmNhNjhIWmR0YTJo?=
 =?utf-8?B?L0YvTERNOUJDWVJQVkI1THRWcDlrWjN2UVFSaEZ3dE9rY25taVdJSzRtZGpV?=
 =?utf-8?B?KzgvOEFqeXI5QTlKSUZkdzJXRVRYVE5QVlg2UWFFQVJKSTBjM2MwcyttbnM0?=
 =?utf-8?B?RW9QNXF0ZFI0UEpoSTNTbEMxZ0dxQVdVY1NLZzNXQ2E4L1Z2YmFLR2xoSzds?=
 =?utf-8?B?REFKQlp2a0dCYmljb3dleUF0bUtBOHFKOTlLS2NVVjRCbUIrWmFneGFGWVNw?=
 =?utf-8?B?d01NdDJER1FsSVhGRUhzcjVOUkZ5Q3RUeDhhNy9MT2tlaWRLeFE0YktPZExM?=
 =?utf-8?B?d2wwajhkRnNPVUhuNFJMTlZMMEN1R1dZbXZ4M2gyM2UySEpsSE9lbXBvL0du?=
 =?utf-8?B?ZFRzcnM2WHNSbUNUS2xFNVh4WFo1TzBjSGp2Mmd0R1puUkFGMXAxVk1SVTBV?=
 =?utf-8?B?UFozRDQvM3FxSFIyaFltUDdhb1NKWCtSemRPemVxSE5zYzBjMm1PbGxLcUVK?=
 =?utf-8?B?U1kxSlprTUphZkNyOVJMWXFaTHl2dFoxZWNsckJoS1dpQXNvWlA1ZUNVVnl4?=
 =?utf-8?B?WW1xOXlGTlZINVhEcE9rSjNFRTNub0c1dzQ5OWtWTDZtME96Y05kYUVCKytE?=
 =?utf-8?B?Ym9PQVRXVUVzc2RndVBtUVZ1TDBZYTg2TTNPcFI5U2NSaDE1WjVNRXVKSzlI?=
 =?utf-8?B?VzAxbEhRMnp5Wk5iR1V5ZmZVWURLTTFOYlZBYzFvd3g1cm05emtkZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d043ed13-b9e6-4ee3-9686-08deb4e39356
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 13:44:26.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4bHQ2DZfLDBy2s8yuWzHlF9eCCstuOaBfSIz5LCH12Oxte8Dq52/dblHLnmYOC/t27R5eH/cnuxIfd3Ra/Rsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686

Hi Mario,


On 16/05/26 02:43, Mario Limonciello wrote:
> External email: Use caution opening links or attachments
>
>
> On 5/15/26 07:26, Sumit Gupta wrote:
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
>>    - performance (or 1): override EPP to performance preference (0x0)
>>    - default_epp (or 2): preserve EPP value programmed by BIOS/firmware
>>
>> The boot parameter is applied only during first policy initialization.
>> Skip applying it on CPU hotplug to preserve runtime sysfs configuration.
>>
>> This patch depends on patch series [1] ("cpufreq: Set policy->min and
>> max as real QoS constraints") so that the policy->min/max set in
>> cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy()
>> during init.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>> [1] 
>> https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/
>> ---
>>   .../admin-guide/kernel-parameters.txt         |  16 +++
>>   drivers/cpufreq/cppc_cpufreq.c                | 122 +++++++++++++++++-
>>   2 files changed, 133 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 0eb64aab3685..7e4b3a8fd76f 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1048,6 +1048,22 @@ Kernel parameters
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
>> +                       performance, 1: enable auto_sel + set EPP to
>> +                                       performance (0x0)
>> +                       default_epp, 2: enable auto_sel, preserve EPP 
>> value
>> +                                       programmed by BIOS/firmware
>> +                     Unset: cpufreq governors are used (auto_sel 
>> disabled).
>
> Rather than unset doing nothing, have you considered having it take a
> midpoint like 128?  That's what we do in amd-pstate (default to
> balance_performance).  I think it turns into a reasonable balance. 

Thanks for the suggestion.
I can add balance_performance that enables auto_sel with EPP=128 in v4.

On changing the driver default (no param behavior) to auto enable
balance_performance, it would be good to keep the current behavior for
now since cppc_cpufreq is generic across ARM64/RISC-V platforms where
EPP and Autonomous Selection registers are optional.
A default change would affect existing users relying on governors.

Thank you,
Sumit Gupta


>
>> +
>>       cpu_init_udelay=N
>>                       [X86,EARLY] Delay for N microsec between assert 
>> and de-assert
>>                       of APIC INIT to start processors.  This delay 
>> occurs
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c 
>> b/drivers/cpufreq/cppc_cpufreq.c
>> index 6b54427b52e1..5f4d735e7c7d 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -28,6 +28,43 @@
>>
>>   static struct cpufreq_driver cppc_cpufreq_driver;
>>
>> +/* Autonomous Selection boot parameter modes */
>> +enum {
>> +     AUTO_SEL_PERFORMANCE = 1,
>> +     AUTO_SEL_DEFAULT_EPP = 2,
>> +};
>> +
>> +static int auto_sel_mode;
>> +
>> +static int auto_sel_mode_set(const char *val, const struct 
>> kernel_param *kp)
>> +{
>> +     if (sysfs_streq(val, "performance") || sysfs_streq(val, "1"))
>> +             *(int *)kp->arg = AUTO_SEL_PERFORMANCE;
>> +     else if (sysfs_streq(val, "default_epp") || sysfs_streq(val, "2"))
>> +             *(int *)kp->arg = AUTO_SEL_DEFAULT_EPP;
>> +     else
>> +             return -EINVAL;
>> +
>> +     return 0;
>> +}
>> +
>> +static int auto_sel_mode_get(char *buffer, const struct kernel_param 
>> *kp)
>> +{
>> +     switch (*(int *)kp->arg) {
>> +     case AUTO_SEL_PERFORMANCE:
>> +             return sysfs_emit(buffer, "performance\n");
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
>> @@ -715,11 +752,75 @@ static int cppc_cpufreq_cpu_init(struct 
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
>> +             /* Init min/max_perf from caps if not already set by 
>> HW. */
>> +             if (!cpu_data->perf_ctrls.min_perf)
>> +                     cpu_data->perf_ctrls.min_perf = 
>> caps->lowest_nonlinear_perf;
>> +             if (!cpu_data->perf_ctrls.max_perf)
>> +                     cpu_data->perf_ctrls.max_perf = 
>> policy->boost_enabled ?
>> +                             caps->highest_perf : caps->nominal_perf;
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
>> +              * Override EPP only in 'performance' mode; 
>> 'default_epp' mode
>> +              * preserves the BIOS/firmware programmed EPP value.
>> +              * EPP is optional - some platforms may not support it.
>> +              */
>> +             if (auto_sel_mode == AUTO_SEL_PERFORMANCE) {
>> +                     ret = cppc_set_epp(cpu, 
>> CPPC_EPP_PERFORMANCE_PREF);
>> +                     if (ret && ret != -EOPNOTSUPP)
>> +                             pr_warn("Failed to set EPP for CPU%d 
>> (%d)\n", cpu, ret);
>> +                     else if (!ret)
>> + cpu_data->perf_ctrls.energy_perf = CPPC_EPP_PERFORMANCE_PREF;
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
>> +
>> +     if (cpu_data->perf_ctrls.auto_sel) {
>> +             /* Sync policy limits from HW when autonomous mode is 
>> active */
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
>> @@ -1079,10 +1180,21 @@ static int __init cppc_cpufreq_init(void)
>>
>>   static void __exit cppc_cpufreq_exit(void)
>>   {
>> +     unsigned int cpu;
>> +
>> +     for_each_present_cpu(cpu)
>> +             cppc_set_auto_sel(cpu, false);
>> +
>>       cpufreq_unregister_driver(&cppc_cpufreq_driver);
>>       cppc_freq_invariance_exit();
>>   }
>>
>> +module_param_cb(auto_sel_mode, &auto_sel_mode_ops, &auto_sel_mode, 
>> 0444);
>> +MODULE_PARM_DESC(auto_sel_mode,
>> +              "Enable CPPC autonomous performance selection at boot: "
>> +              "performance or 1 (EPP=performance), "
>> +              "default_epp or 2 (preserve BIOS/firmware EPP)");
>> +
>>   module_exit(cppc_cpufreq_exit);
>>   MODULE_AUTHOR("Ashwin Chaugule");
>>   MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ 
>> spec");
>
