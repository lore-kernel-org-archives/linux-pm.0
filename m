Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C21313552;
	Tue, 28 Apr 2026 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394267; cv=fail; b=KFrLp//99dJLCGVIZeRYlxNhMXYIdxvrKsgwYXfskxEE/9lZYzY9/SxfKcCecfNsafkYaAWe/NrgR6htCEesfVGka4jDLNlJ5u8CUMS8dH81+9/PBYmGOpGdxkO3Sv8F8sf56o0VUpmGwlaH8sUiJ0dBt49zbOqcXIcOVZlr6FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394267; c=relaxed/simple;
	bh=AYeoWDaMIEOkCYyBTGku+XPei1cRyzwc+jgxj4sZvbQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UaEUf/pkBsN9+k/P9GgKdRl72CMwiv1y9MLb4C8aBnOlW7/hG7qOotmA/NoXxxBYZmUITaqeI8dAyYVnkgg6389HWTmga8+qvbEgiPf5V7NrewZIr/eg+TfBdjQS2UJN2vVx34A6F4GHgi5XEYk5U9CrkNAZMTkkmW1cPqv8REk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UHD8KOh7; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UHD8KOh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwxYwjE2djRZKLJTAmacjUntekb269+isOyVJreLxgAqxKf16KazH7HF2bBKHGr08zKJTSUyU9CGiFWslb9GkCyJKmAXAgb+5ufrAoaoNEtzYuLr+frozUYfPr2jlHPqFtiN4ER93j1hjkXFFEhb+B0qUVuWVsz1w2CsyPle7Nza3a4BN6gJ2l301sSwa//hB8I/v8zIAlwTDvPI4YcRvAceONjt4i7hLy0Rl7q4sraUKx7fkGHZgEiA+ibhenYYGfzKGsTPjTenCFEtM7KItrrz1DdQqmpwSviv/uooxX8k/KgkSRn1tNk7O2/olvsyC6oVoaRZ6l5y81/Bggrilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drQHy1t33XpGnjItMfL4Lcuic7q8I4Cf9QUx7MjmFY0=;
 b=G675Ty7Yo75pXhnrvQ2FFPDgYWZsP4T4XtRYgwWEkrtxoo/Dc3Ok/HQxKV0HA7LtNm2xVXd/33uWJOGHBRqfPyfQghRiCCiM9nDpJ97yK/f90j/L12uv3fOwUtrSNyVCjMI3UVeZxdkwhTwK63Qydi5be7zl/YJWmjB/q/8qwux1TVPI2kFQeta0bDIl1GkfLKULpvihcqQk2v9HXcRKa6xXwPCOhCf7tqR1uo9r5Ac/5L9SC5pe+faMSNaxN7NeGvyyKaRAZ0otP3Ac+QmbwHEYFvBGN3PLrzv/V9UarnKTgqrXgZqFZkegUY+IZlnkgaW3iTliDkARBuOiTxNa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drQHy1t33XpGnjItMfL4Lcuic7q8I4Cf9QUx7MjmFY0=;
 b=UHD8KOh7crWR4AlKcm85JWbsHIfEvEKHGtAkJYwXrCTuaYEkdmhkBllBXeh8B1mYBp+lLSAuUzjYOG28iNNbOyQMKsx3eAPLoMB7jYDWqwaU+ES8zW9qPjpn7+cs9AllNZjgD/08vXLaXn9+W3En9L5o5ZkTFTLxq73xcBecLFSg8ME5v4zEAS7FN5Qb0xCU5801lEmlBmJnn1BMHhH2ALF3vEI86HGUDFVCeotuQ5/Rp7yvZDKy7+2rGl9veyUq8gcKXX1PPXBu6gDE7geTY5aZ0eczLnRPbkaeL1JZWXQtuMAXVm+3ISRPlUXGIf52aZ44F3hUke8ZJ/v0jHjufw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 16:37:39 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 16:37:38 +0000
Message-ID: <a7b7c4b6-59ce-40bf-91c0-de630ba7a638@nvidia.com>
Date: Tue, 28 Apr 2026 22:07:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpufreq: Set policy->min and max as real QoS
 constraints
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng
 <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 Huang Rui <ray.huang@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 linux-pm@vger.kernel.org
References: <20260423084731.1090384-1-pierre.gondois@arm.com>
 <20260423084731.1090384-2-pierre.gondois@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260423084731.1090384-2-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e777c0-e668-4dd4-bfd8-08dea54475e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Q2Tyvz+yCaE7d1AzIOg4Ko02VSOftq2bUUd6BZlhW6QLgU1z6PjVHpdh0jlYUR8Zyz7cGmeBFZBr7vE/U1znmj3ID71orzgnrG3u/0ggMJXPdgMsMs1hWgtnDYiE6fO7b+I8jBA5k15jHpx2WyL8v5kB4lZtJW27mgPL6okgNNvF0sRa4YvxyQbzCVdQ5J8cKQG0x8k8nVOqLAn9qHiWsotEDaD9Q8awGNuLx9r510t9j+Hts+dMZXQgbjojQVEwPc6MtJxEKo6lXk7J0z7S+A1DhEtB86wgtSXuNrldikSWD7I7YOkOY441asyO0eGy4zTIWnGZajeqHD2EgWMFqx9oJUwPtcTb7LkcPqMvhq83eEHJX3z+eG8BKFThbpovJk1ghdkMDX8GEbpjWrUWB7kpYjSzMZ9KDJZBLXNoomeUGFfgEGpbsx2JHl2JbymGGmaV+6I4Q7skYKxLNFLYsi6PO+dhjl7hcMFj3wO1r6eFXCC9OcdTDta2yHHdgbwnFi82d/OCfwp/CCjxC37lTiCG7jDc+cGn1cFQfwcZA1wHdLjYvilApRNIp9/AgQ0sbUnfwKiuM55Za2mcOh4o9PqAsN1Ril5Yg49y6ouc6OymxlVnXO01vGQTzJBbXQ1G5mFGQn7akLNpP6gQeDUOV0ipsWigu8PlcS2d9XMnyQaiu1MaOhdxZT8cEuU3F8AZqhzEjU++ETo1tR0Y3MQMi1QXiJwmETQjLovNAlIZbDw9lD7wmYCsoFd38XKUrsbx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVZmNlU0WDhBVVM1cDFscVNQWXd3V29kTW5nV2kyTUdnMlltdXVOS0dTbDZm?=
 =?utf-8?B?NFg0YVNYdzl3VzBsdlJCYlE1dzJlSHl0QlZUTE5zRngxT2J6czVORDJQK1pr?=
 =?utf-8?B?a1NQR25sNDFUbW82V0R5b2NrTVdOVnJMdzl2M2t4M3M4eUZXbWdHd3g2cGNk?=
 =?utf-8?B?TkpveFBFZEsrN1M1U25LQzRXQWxEQ29YYVVWd1UvUitsZGNEYkhzWnFzN2tj?=
 =?utf-8?B?MjZtTjlCeXFBTFNmc3ZpSkNuMlFveDlCRHJpTmdOVjQweENxZVBzbzhYYjJt?=
 =?utf-8?B?MDRTSjFIelo0V0poajJRdFBSQldLeWVhNVZYZUFpM3N4b2ZodjF6MVlXT012?=
 =?utf-8?B?TjNKQm9RWlRRZTN4d2I4RnBOcEREOVdRTXU2d3pOUWN5SkRFdjU1Z0RGbzJ3?=
 =?utf-8?B?VFkvQmNNMjZsb2d5Q0RBdkV0bFpTaE52QnJReVJTRFZXY0tnSFZTZ3N2bXgv?=
 =?utf-8?B?eTdFRXNnODlyWmJEQjJScGRibmljdG0wQmp4VGpHVTgyYVdPWDExajZhV0U2?=
 =?utf-8?B?cGpvYVFFaVREV2tuSkxaMFR3dHlCQWdRcW00T3lrVHBIS1ZYWEVTeWtKUmZE?=
 =?utf-8?B?bXlhYWRNMzBuZHBIMFNRcmpDNkw5WnFGS21IazJYajcwUnZjRmxpcExWeHg1?=
 =?utf-8?B?UGNhb3dKVG5CZFlRZ0Y4ajh1aFZ0TzQ5TDRPSC9BY0o2SWdoUXRMeDhsODNZ?=
 =?utf-8?B?NmNwUW9Qc2VWckdzYnY0eDJudHF4aFFRaitzL0RaM2ZFZU9nQ2ZnRXYvL0lO?=
 =?utf-8?B?cHBZL3Q4WldlcWFvaTgzYzJrZFo3ZVg4SGJkTGUzQWw5SEgzemt3TXpaN1dJ?=
 =?utf-8?B?QnpmcllxTVhydUFvY0FOM3JPMFZoaERZaU1sSFhrNGhXNjMvbzVVb2JpUHk3?=
 =?utf-8?B?ZUx6SlZhTlJKSi84bTFOQldGemtPN2dqUWthNkl1WllkRkJTMG9OY1FsbzVX?=
 =?utf-8?B?UjBjSjdZdVh0d1RNV1RnQjhod1QwNFJ3R3lQZk5UMHNBWHB2RnBEZkRhRm95?=
 =?utf-8?B?emd4OEdGR0xlTE84QVprWDUydUVKOWt5bWlhMzM1MDVSNldIdGgrcmR6T2pT?=
 =?utf-8?B?NzU4VGpBUFd3ZGUvYWlZdndOWmdLb3BmM3hrZ3pPVzhEYVF4VUJvNzEyaG5N?=
 =?utf-8?B?clVTWVhuUnQ4eUdJRkF5L0haQk9Ia1htMlFHdjQ0Z1RML2hkTnZNaG5TVGJj?=
 =?utf-8?B?U3NoYyt0QlY2M1BNYTh3czU2OERjeFVVSFVMQWY3MjVEMFpiakdTRVVtazM0?=
 =?utf-8?B?UkhHUFVZMDJRb3lPMDJXeUdRMU1kZFBMWEhldHYraXFtU3RsREk4VlFvcHV0?=
 =?utf-8?B?U00xbmh4WDNIWHhZQ2t0elVZL3Z5ZUtJZE5qM0xBSm5zOHFxcWRaSC8vMGJr?=
 =?utf-8?B?M1RQaG0wdjdqMWVmMW03T2k3cHg1azlSSmozbFpVUWV2ckdFS0NQcGtXZ0dR?=
 =?utf-8?B?Y1FFTGpuSVJKSk1nRjM4SjI1QU83VGZGbXhZRFNmTEpFK0g4OFFOVTRFQ1dK?=
 =?utf-8?B?WWRaWFhLQ1VTSmc4QTVFN2hNQ05NSTZ2d2dLdXpWMnl4YU5CM0M2ZWovdE50?=
 =?utf-8?B?SUVGbC9vOXR1dmsva3lGcmYyVmozUklxMXh5YVpVeE5iZjNmNnZCVjEwRDVP?=
 =?utf-8?B?cjQ1MlVGSUJrS1NURVFya1dETnBkbCtyU0J6RXFMOWUybzNzRzBRV2ptRm40?=
 =?utf-8?B?RXcvV0FURjA3TWtKcXp5UUI4RnVDdG9mZmxDMXRRY2o0b0swOFd2c3RGNkhI?=
 =?utf-8?B?cTZJWTBYKzJXc2d5Z1U3WlZQRlhOWkd5c1dKdHQxbU4xbWRqN2hLNHRBZHhH?=
 =?utf-8?B?MW1oajc4REcrZUJkamRNR0hIbUZKSFVCWDU3SFBTc08rZlNkMVJMOTNCUjZn?=
 =?utf-8?B?SU1hRWZKdzU2RmtER0xFZjJ0cnR6d3FYblU2UnJwWTZTckd2YmdEeVFCSDVY?=
 =?utf-8?B?RzAwdThWcS9VYm44ZUtBeG8xYURGWkxqS0RYVGhCWU5qOFN5SkNWS2w2UnRX?=
 =?utf-8?B?K2psNTR2L3EzYWJESTBOK1VvbzFjSStCZmtyTmJIcEQ0MWpWcG1UckdvblIw?=
 =?utf-8?B?ZjRjQW9sQTdKNUs3cFZpcXlZZC9RL0lUTWlzMjdiM0phc1lFR2dheUNQRS93?=
 =?utf-8?B?WnVBTDM0aVRrbTJSR3QwSFNySlpvYzU2U3k1YTU3L1BMVkpBWU45aE15OXcw?=
 =?utf-8?B?S2g4QXZQWE9XMFVoM1lFNytES2VWVmZUQjIyZHJQdlF0bVpGRTlZeFRuWCto?=
 =?utf-8?B?dk9Gbmk0N2tITmtTLy9tZTFVZCszNkJEMnNac0FkVWF6WElCeHlITmpKT2Z1?=
 =?utf-8?B?dTA1dlJObVptemhCRDdpTmVnTmoydkpSanZhWU9xZlBpY2E2a2tydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e777c0-e668-4dd4-bfd8-08dea54475e1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 16:37:38.9131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9I/WhjW+oDZz3KQeH502XdiW81oVrUPkeLV8Ks+JEd83q2p8iAbdBYiWuQ/BOqxq71N9ajCa5RM4AV07FG+Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181


On 23/04/26 14:17, Pierre Gondois wrote:
> External email: Use caution opening links or attachments
>
>
> cpufreq_set_policy() will ultimately override the policy min/max
> values written in the .init() callback through:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>    \-cpufreq_set_policy()
>      \-/* Set policy->min/max */
> Thus the policy min/max values provided are only temporary.
>
> There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
> cpufreq_policy_online()
> \-cpufreq_init_policy()
>    \-__cpufreq_driver_target()
>      \-cpufreq_driver->target()
> is called. To avoid any regression, set policy->min/max in cpufreq.c
> if the values were not initialized.
>
> In this patch:
> - Setting policy->min or max value in driver .init() cb is
>    interpreted as setting a QoS constraint.
> - Remove policy->min/max initialization in drivers if the values
>    are similar to policy->cpuinfo.min_freq/max_freq.
>    The only drivers where these values are different are:
>    - gx-suspmod.c
>    - cppc-cpufreq.c
>    - longrun.c
> - For the cppc-cpufreq driver, the lowest non-linear freq. is
>    used as a min QoS constraint as suggested at:
>    https://lore.kernel.org/lkml/20260213100633.15413-1-zhangpengjie2@huawei.com/
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Tested-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Sumit Gupta <sumitg@nvidia.com>


> ---
>   drivers/cpufreq/amd-pstate.c      | 16 ++++++++--------
>   drivers/cpufreq/cppc_cpufreq.c    | 11 +++++++----
>   drivers/cpufreq/cpufreq-nforce2.c |  4 ++--
>   drivers/cpufreq/cpufreq.c         | 19 +++++++++++++++++--
>   drivers/cpufreq/freq_table.c      |  7 +++----
>   drivers/cpufreq/gx-suspmod.c      |  9 +++++----
>   drivers/cpufreq/intel_pstate.c    |  3 ---
>   drivers/cpufreq/pcc-cpufreq.c     |  8 ++++----
>   drivers/cpufreq/pxa3xx-cpufreq.c  |  4 ++--
>   drivers/cpufreq/sh-cpufreq.c      |  4 ++--
>   drivers/cpufreq/virtual-cpufreq.c |  5 +----
>   11 files changed, 51 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 453084c67327f..1ed4bcdcc957f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1090,10 +1090,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>
>          perf = READ_ONCE(cpudata->perf);
>
> -       policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> -                                                             cpudata->nominal_freq,
> -                                                             perf.lowest_perf);
> -       policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
> +       policy->cpuinfo.min_freq = perf_to_freq(perf,
> +                                               cpudata->nominal_freq,
> +                                               perf.lowest_perf);
> +       policy->cpuinfo.max_freq = cpudata->max_freq;
>
>          policy->driver_data = cpudata;
>          ret = amd_pstate_cppc_enable(policy);
> @@ -1907,10 +1907,10 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>
>          perf = READ_ONCE(cpudata->perf);
>
> -       policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
> -                                                             cpudata->nominal_freq,
> -                                                             perf.lowest_perf);
> -       policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
> +       policy->cpuinfo.min_freq = perf_to_freq(perf,
> +                                               cpudata->nominal_freq,
> +                                               perf.lowest_perf);
> +       policy->cpuinfo.max_freq = cpudata->max_freq;
>          policy->driver_data = cpudata;
>
>          ret = amd_pstate_cppc_enable(policy);
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 7e7f9dfb7a24c..c6fcecdbbab0c 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -645,6 +645,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>          unsigned int cpu = policy->cpu;
>          struct cppc_cpudata *cpu_data;
>          struct cppc_perf_caps *caps;
> +       unsigned int min, max;
>          int ret;
>
>          cpu_data = cppc_cpufreq_get_cpu_data(cpu);
> @@ -655,13 +656,15 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>          caps = &cpu_data->perf_caps;
>          policy->driver_data = cpu_data;
>
> +       min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> +       max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> +                              caps->highest_perf : caps->nominal_perf);
> +
>          /*
>           * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>           * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
>           */
> -       policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
> -       policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
> -                                               caps->highest_perf : caps->nominal_perf);
> +       policy->min = min;
>
>          /*
>           * Set cpuinfo.min_freq to Lowest to make the full range of performance
> @@ -669,7 +672,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>           * nonlinear perf
>           */
>          policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
> -       policy->cpuinfo.max_freq = policy->max;
> +       policy->cpuinfo.max_freq = max;
>
>          policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>          policy->shared_type = cpu_data->shared_type;
> diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
> index fbbbe501cf2dc..831102522ad64 100644
> --- a/drivers/cpufreq/cpufreq-nforce2.c
> +++ b/drivers/cpufreq/cpufreq-nforce2.c
> @@ -355,8 +355,8 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
>                  min_fsb = NFORCE2_MIN_FSB;
>
>          /* cpuinfo and default policy values */
> -       policy->min = policy->cpuinfo.min_freq = min_fsb * fid * 100;
> -       policy->max = policy->cpuinfo.max_freq = max_fsb * fid * 100;
> +       policy->cpuinfo.min_freq = min_fsb * fid * 100;
> +       policy->cpuinfo.max_freq = max_fsb * fid * 100;
>
>          return 0;
>   }
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 44eb1b7e7fc1b..b30bfa3e27daa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1453,6 +1453,14 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>          cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
>
>          if (new_policy) {
> +               unsigned int min, max;
> +
> +               /* Use policy->min/max set by the driver as QoS requests. */
> +               min = max(FREQ_QOS_MIN_DEFAULT_VALUE, policy->min);
> +               if (policy->max)
> +                       max = min(FREQ_QOS_MAX_DEFAULT_VALUE, policy->max);
> +               else
> +                       max = FREQ_QOS_MAX_DEFAULT_VALUE;
>                  for_each_cpu(j, policy->related_cpus) {
>                          per_cpu(cpufreq_cpu_data, j) = policy;
>                          add_cpu_dev_symlink(policy, j, get_cpu_device(j));
> @@ -1469,18 +1477,25 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
>
>                  ret = freq_qos_add_request(&policy->constraints,
>                                             &policy->min_freq_req, FREQ_QOS_MIN,
> -                                          FREQ_QOS_MIN_DEFAULT_VALUE);
> +                                          min);
>                  if (ret < 0)
>                          goto out_destroy_policy;
>
>                  ret = freq_qos_add_request(&policy->constraints,
>                                             &policy->max_freq_req, FREQ_QOS_MAX,
> -                                          FREQ_QOS_MAX_DEFAULT_VALUE);
> +                                          max);
>                  if (ret < 0)
>                          goto out_destroy_policy;
>
>                  blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>                                  CPUFREQ_CREATE_POLICY, policy);
> +
> +               /*
> +                * If the driver didn't set QoS constraints, policy->min/max still
> +                * need to be set as they are used to clamp frequency requests.
> +                */
> +               policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
> +               policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
>          }
>
>          if (cpufreq_driver->get && has_target()) {
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 5b364d8da4f92..ea994647abc88 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -49,16 +49,15 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
>                          max_freq = freq;
>          }
>
> -       policy->min = policy->cpuinfo.min_freq = min_freq;
> -       policy->max = max_freq;
> +       policy->cpuinfo.min_freq = min_freq;
>          /*
>           * If the driver has set its own cpuinfo.max_freq above max_freq, leave
>           * it as is.
>           */
>          if (policy->cpuinfo.max_freq < max_freq)
> -               policy->max = policy->cpuinfo.max_freq = max_freq;
> +               policy->cpuinfo.max_freq = max_freq;
>
> -       if (policy->min == ~0)
> +       if (min_freq == ~0)
>                  return -EINVAL;
>          else
>                  return 0;
> diff --git a/drivers/cpufreq/gx-suspmod.c b/drivers/cpufreq/gx-suspmod.c
> index d269a4f26f98e..ebda2bbebf44b 100644
> --- a/drivers/cpufreq/gx-suspmod.c
> +++ b/drivers/cpufreq/gx-suspmod.c
> @@ -397,7 +397,7 @@ static int cpufreq_gx_target(struct cpufreq_policy *policy,
>
>   static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
>   {
> -       unsigned int maxfreq;
> +       unsigned int minfreq, maxfreq;
>
>          if (!policy || policy->cpu != 0)
>                  return -ENODEV;
> @@ -418,10 +418,11 @@ static int cpufreq_gx_cpu_init(struct cpufreq_policy *policy)
>          policy->cpu = 0;
>
>          if (max_duration < POLICY_MIN_DIV)
> -               policy->min = maxfreq / max_duration;
> +               minfreq = maxfreq / max_duration;
>          else
> -               policy->min = maxfreq / POLICY_MIN_DIV;
> -       policy->max = maxfreq;
> +               minfreq = maxfreq / POLICY_MIN_DIV;
> +
> +       policy->min = minfreq;
>          policy->cpuinfo.min_freq = maxfreq / max_duration;
>          policy->cpuinfo.max_freq = maxfreq;
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1292da53e5fcb..68ccc6eb1ef30 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3049,9 +3049,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
>          policy->cpuinfo.max_freq = READ_ONCE(global.no_turbo) ?
>                          cpu->pstate.max_freq : cpu->pstate.turbo_freq;
>
> -       policy->min = policy->cpuinfo.min_freq;
> -       policy->max = policy->cpuinfo.max_freq;
> -
>          intel_pstate_init_acpi_perf_limits(policy);
>
>          policy->fast_switch_possible = true;
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
> index ac2e90a65f0c4..231edfe8cabaa 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -551,13 +551,13 @@ static int pcc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                  goto out;
>          }
>
> -       policy->max = policy->cpuinfo.max_freq =
> +       policy->cpuinfo.max_freq =
>                  ioread32(&pcch_hdr->nominal) * 1000;
> -       policy->min = policy->cpuinfo.min_freq =
> +       policy->cpuinfo.min_freq =
>                  ioread32(&pcch_hdr->minimum_frequency) * 1000;
>
> -       pr_debug("init: policy->max is %d, policy->min is %d\n",
> -               policy->max, policy->min);
> +       pr_debug("init: max_freq is %d, min_freq is %d\n",
> +                policy->cpuinfo.max_freq, policy->cpuinfo.min_freq);
>   out:
>          return result;
>   }
> diff --git a/drivers/cpufreq/pxa3xx-cpufreq.c b/drivers/cpufreq/pxa3xx-cpufreq.c
> index 50ff3b6a69000..181962b0924e6 100644
> --- a/drivers/cpufreq/pxa3xx-cpufreq.c
> +++ b/drivers/cpufreq/pxa3xx-cpufreq.c
> @@ -185,8 +185,8 @@ static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
>          int ret = -EINVAL;
>
>          /* set default policy and cpuinfo */
> -       policy->min = policy->cpuinfo.min_freq = 104000;
> -       policy->max = policy->cpuinfo.max_freq =
> +       policy->cpuinfo.min_freq = 104000;
> +       policy->cpuinfo.max_freq =
>                  (cpu_is_pxa320()) ? 806000 : 624000;
>          policy->cpuinfo.transition_latency = 1000; /* FIXME: 1 ms, assumed */
>
> diff --git a/drivers/cpufreq/sh-cpufreq.c b/drivers/cpufreq/sh-cpufreq.c
> index 642ddb9ea217e..244153a1cead2 100644
> --- a/drivers/cpufreq/sh-cpufreq.c
> +++ b/drivers/cpufreq/sh-cpufreq.c
> @@ -124,9 +124,9 @@ static int sh_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                  dev_notice(dev, "no frequency table found, falling back "
>                             "to rate rounding.\n");
>
> -               policy->min = policy->cpuinfo.min_freq =
> +               policy->cpuinfo.min_freq =
>                          (clk_round_rate(cpuclk, 1) + 500) / 1000;
> -               policy->max = policy->cpuinfo.max_freq =
> +               policy->cpuinfo.max_freq =
>                          (clk_round_rate(cpuclk, ~0UL) + 500) / 1000;
>          }
>
> diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
> index 4159f31349b16..dc78b74409af4 100644
> --- a/drivers/cpufreq/virtual-cpufreq.c
> +++ b/drivers/cpufreq/virtual-cpufreq.c
> @@ -164,10 +164,7 @@ static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
>                  policy->cpuinfo.min_freq = 1;
>                  policy->cpuinfo.max_freq = virt_cpufreq_get_perftbl_entry(policy->cpu, 0);
>
> -               policy->min = policy->cpuinfo.min_freq;
> -               policy->max = policy->cpuinfo.max_freq;
> -
> -               policy->cur = policy->max;
> +               policy->cur = policy->cpuinfo.max_freq;
>                  return 0;
>          }
>
> --
> 2.43.0
>
