Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5236212C;
	Thu, 10 Sep 2026 21:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074099; cv=fail; b=GSsc5a++erZkzKuCvu1yMOXlzQGH5UdcGCfflfDPP7dXUXPWYEDVYqHO++FblKQWeYH5VKwLf7ntqeTIM95mYRMCjV59ZgKmcIuycVfrNKpGZjBFSvUxv35pszYIRw+YRLIUH1GOso1mtX5KubmxdAzA5vs5kUWgoMe5uUBPXEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074099; c=relaxed/simple;
	bh=V0+9y3qdcKBhRlzWegxiobJr1Cf+KNKgHDyw0OAqpiY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KUZehr2dlpFA8fWH0Trrmo+apWKdXgCO921QH6WDsYqtNS5+p812zLpwo3juCFpygXafOzGqYbmwRoSqHgj49r4YVpVSr3Ho0PTXFzAPh0IeFm/7C1weYrEkx/QgS/2r64O+/TcacgLhLBThBAsvesFOiq4qAiNp35RoUyEoi0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VTGawMjO; arc=fail smtp.client-ip=52.101.57.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VTGawMjO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hggvDZhEipolomq2Mpt6eB/4XEC6u85guAwrtZPvYlKopQIGT52XelmA0TIATF7okQmSBpCe4jnOL5ZwIwLackXubsQZBgGRpbB+5+sisSArBed13qJzQChAUMpHHBKzhmHF5/T4bzJFliLKu2KPK5D1HdWP0AjE8oToTCwBnZfwidtMSPmlqnHixNayhl1e8wRml7kL6LZM20+zdUX8Hy21JIUcKeqVz2MIuon9d1gBIBqbRlRTR4JRuiTEYcBJte2sHEZWWaPB2nfrn3sVn7nAzuj0hUa7EYNT1VijmyQwIBFl61w7wcUfbAr+J6SNSJ1mMtwbqRRSq8/BUGOZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uI9LksZ3g5OiUW7TPb4I6qKUx6dflK8Xb9LS3trmjSM=;
 b=lwu3oiqVNUU/P1di+IXSnkXhiNqsxG93X0U094pbuhEGGKFsC9UoOwY8drEcPvm/nRB9jaZebjffo9PvtUOIY55Y4SQB8aehYdh2dEvdgagogGO/zJfM3d9a/FVUBilrbR4UMfqN//WPn0DtekjJp35m5KYU2VSX2YHaTxE8UXSc8wiQndyEjjrg0rvAWTjWoyXHs7v6hagUIcmXmXw6t472DMA/b3+iOgFznfcK3Kbu1d0m7f83zhcEaNWvTVmXOqLpeBya7QnZ/nAmL/VHzAXebORANiVb5yjKibc0BCPXeOuDawWNHE8tdC//cz2PrSlwNjiv1dBbw/oEERTMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI9LksZ3g5OiUW7TPb4I6qKUx6dflK8Xb9LS3trmjSM=;
 b=VTGawMjOfWiwD6YlzRNFpNrOFiS17AGbDJPlATFmTSdxHH8jBOSSodH4Tsuaqc2vOOPMPFEF1fJtlxLRdtQUDp3R/LbTQ7ZHhTwyPedZqk78V2ToRSINdPgsaKeITMrifE4HLqp8v3h3wlvniOQkeREpWSozCH7eAiuiaBXxtuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DS4PR12MB444842.namprd12.prod.outlook.com (2603:10b6:8:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 21:01:34 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 21:01:33 +0000
Message-ID: <1764315f-a39f-4f95-b8b6-2ea90116eb07@amd.com>
Date: Thu, 10 Sep 2026 16:01:31 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] cpufreq/amd-pstate-ut: Fix amd_pstate_ut_check_freq
 failure with 'Requested CPU Min frequency' BIOS option
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>
References: <20260909102650.4582-1-kprateek.nayak@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260909102650.4582-1-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:610:5a::35) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DS4PR12MB444842:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fa4768c-75f2-4e66-4626-08df0f7eb1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tokpfAFzHN1PiFkBpbTBsjDG/b1dqqR05xexbKTrCR2mApRkUYSt/WYB175R5J51EkaxTgbg+xDJukedLg+vXvz5ghwn03I15URRlmSyyoPA/HTBEs1YZumAsGUE6eiguf/oBU5plGC8xQ6kINtBEWmHv+bkStwjlT9aV+hwvMcTlwVoIitEsU6Xfgoll0XK70FRNszqMu1Hj5w1eOmeofVc0Z8yZEciIFHstV9zfW7uGO5TQ/7TQb7Me+50XYuXRlF7Fql5VIrBVH565g8csYXHiTBGOG8lVUA4s9Z3VMUHBxqrON8QPRTw6+7CYRa+E+8dVafN/sV1MhpxAPT92IUZH6zOHeRLbnZtiSJcALKRCldLEG4gkeMf3UaLX6f21Mw7rlqDm+w2E7bBmy8DrgS8NYAW+aSZhyL0g2F2gzF7UjYt/nFeHtHzyL7xI/EAnNx+IJHHqG6BJiZO+RfFP+cKj9FvfXeRgscrH7VCkP659q2zJ+esrOcIS/I36/HAwJFtIc21YJA3mZLXdpVvED8Den+aUM7GU0n5RHonW8jEeqmSsTduCGFeEAI7PzA5iFYG2OFxJH/rYUhjHiM/U7xS04Xl3sGD0pZW48sVnM2iODtNpm8nE48w59sJ86aOVTSej1w/gf6BJhM2cU7cmxcRKy33RTRcVvsfufF/sSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WllqU3djUzdkQlRUWGtyL0lZdHAwRFlhNlNaRytDWVFzbDRQcDNTVThDOG5K?=
 =?utf-8?B?TnVYcHZjMFNmd3dKUzVSNW1ZRXdaU0lVa1hTUDJwOG12YkgxcWxZaTdkS3Rn?=
 =?utf-8?B?N0Vhb3praEhSOUVONUxPa2pHZjdOT3owcUJMUU9SNXFxMTliZTR5dHFIek9F?=
 =?utf-8?B?RWZrSzRydTJuSVRvN280OEhvT1VTajVIeVovQ3lZUzVxSlVZSU5vb2kyak9U?=
 =?utf-8?B?N045QUhMSjJscWZ0RFJMSDhzSzlpaHowaTBaUG5lNHlWZFRuajZmMVNwQ2R3?=
 =?utf-8?B?TXBucGxseUlIa1RYd0xZcFVKMHRlaHpEZGdWbzEwMTJBd0hvWURtN0IxSU1L?=
 =?utf-8?B?ZG4wSks3Ri9oTEZBT3JpalQxMkFScmgyVUFxRnh3THA4anZOVkw4UXBPY3Zj?=
 =?utf-8?B?RGJJbGRrczVCWXp3MzhVNmkzcjZnMCsrNmN2Y3BEbHNMUGFCWTh6TnJQNW1k?=
 =?utf-8?B?aUZqbUdQa3Y5Ujl3ajRGU0d5Q3l6UFRSMjVjbHlGa2laS21pMEZCQlBndlVW?=
 =?utf-8?B?MWFsNDBldUFHSDN0MVV3Mkc0TXJGd2hicllIKzExYkErcyt4ZEtRN2FwNVIr?=
 =?utf-8?B?R2ZRbmtFUU5yNjJVenJMa1hDbkMra0lvZmtyeExUTjlCSURhVXlQSFE2bTF1?=
 =?utf-8?B?NlFtWFVvWWhCZVB5QXJGdnF5aWJaVjZyS0VvcjJJcVV1djZvcURzb1lhdnJK?=
 =?utf-8?B?YXZiekVBanJRVXVoblZpMWpGMHVoUzlmSG9TRjJTeXV5QzNoMjdQTEk0bzRE?=
 =?utf-8?B?L0NSalh6R3B0cERpZ29DUm5Mb2ZWWEJ3SmRuNEl1a2VVUDZ2cGtoZ3ZRdDNo?=
 =?utf-8?B?d1p4VFV1TzlTdzRZVmtub0FOOGRnZSt1aTd4cHlWZGhlVzlFQmEvdm1GVlJN?=
 =?utf-8?B?Nk0ybEZVaDhBVUNkVDlwNXFLWWRQeUhPU2hFVHl0K0xpR1MxTEo5bEVPWndG?=
 =?utf-8?B?ZjhCSnNNVVNOYjJxeFk4Tmt2akpVMjQ2TXk4S2NlMHJva1IxUzMwUWhhN1Nr?=
 =?utf-8?B?UEVwaUIxVlFJd1dRVGtmZ2tJQWxYd0IyUUJIeDNJdFQxK2syaDRLaktWS3ox?=
 =?utf-8?B?T0xSR2RiY3Z0T3FPeFNmektBTUVOM29wODRTNk9lalk5T0VzcVE4N2xXVm9l?=
 =?utf-8?B?TW43WFFWaURkREJ1djF4eUd5L01CNmhtdXVuR2x3UXFjbkRhdTJVSGsyYWNX?=
 =?utf-8?B?bGZnVXExYkhjKzBtcUFKRmtGckdqcDBMZ0RZV01PaWxqNUlSbno3QWw2OWls?=
 =?utf-8?B?Q05XR0JGY0t6QytFVmtXclBlTmtYemJzSlIvWXhTd0t4QUo5VWcyZ0dad29E?=
 =?utf-8?B?OWVpLzNuOFpMQkNvMXlpUzF4R0RwM1lwbnE3dFB2VWFqUDIvNTIxT1NzMDBJ?=
 =?utf-8?B?aXMwdHFQNjNESVVjZkorTGxaQ1BMdlFLdlZiTVFRcEVFUXgzMngvOFNwaktW?=
 =?utf-8?B?dElRMndLRUI1SEJuMUdWSzFuU0Z0N2Y5REYrQjZVYWh3b0xuRTBMVDB1THNt?=
 =?utf-8?B?VFp2djlLRm9GYUpYNVNvbXdrWDlVbUNmZU1JeWRkcDVLUWtlZVdpeGV0S1h1?=
 =?utf-8?B?QzFzMERPMzF3UWtpNStMbTljQnBueW41cXluMVlEY0ttMDM4WndXMjNhOXU5?=
 =?utf-8?B?YlQ3b0p2cmxTd3R0KytPMjNwT0lneG1wNDA2NlAxZ0dONVNTOFFkQ001UEww?=
 =?utf-8?B?OWdvZnZ4dXpYV0lSWHJKYzRvYVYvYlAza2ZyZWg1c2dubHI0enBmVGk5Y0Yr?=
 =?utf-8?B?Y25oY1prSjhBZ2hkZ3Z0UVRCYVQ3YWp2L2F1SE9iVWVnRlgzMDREam5IQTJn?=
 =?utf-8?B?dW01Zk5QUGVEWWFCSUtYd3dsUDRWamVRc2daNEp0RXBUZXRyZEdiSjdHbHQ1?=
 =?utf-8?B?S1pFa0oxRVhhZVNDdjd5UmpKekh6ckwxZWl2WW91c2RGZjZ3RlZubnF6REs2?=
 =?utf-8?B?b3IzQ1hqSW53b3hadW9RT2hHS1IzSGlJVUc4Yk9Uc3FXWUVuOFRxeGd2VFlO?=
 =?utf-8?B?Mnd6cjNBRzNUY1g4dzM0RGFBbFdrN1hNNUlvUUZBaDFya3lVOHYvMmRVdmdz?=
 =?utf-8?B?RkNYaWRRdmNFb1NxNDY3WnI5MlNyeVhGU1RYVmxrZCsxMm5CNzNmc2pETElD?=
 =?utf-8?B?K3hMdXVleDc3NXg1M2svNmswRGtsRE5xa3ZqVkxEM243NFhrKzByR3hIN2V3?=
 =?utf-8?B?blRjL2twRmpzdENOWWZqeTNnSWdpdEJyWmZQOFVyTUNNNnY1MXBIaEJXYkRI?=
 =?utf-8?B?SW5QTTRnVG1SQi9ZbVdLSkVxdFU5NFQvRkNvTm0zY0VDdkpjbVo5azJ5Rk1i?=
 =?utf-8?B?cGlUd0t2WTlJMGZxcnBDSHVXclhWaHozU0JTTmJrem8xSjkyTGZXdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa4768c-75f2-4e66-4626-08df0f7eb1e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 21:01:33.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ9pwHCahWsekZejL6QjZTvksO5fRPAKRtcG4RERt66qr7buP2UGo/gZj9Yi6IujWBCj1ZeP3v3ckLKG+MRCeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB444842



On 9/9/26 05:26, K Prateek Nayak wrote:
> Since commit 608a76b65288 ("cpufreq/amd-pstate: Add support for the
> "Requested CPU Min frequency" BIOS option"), amd-pstate driver sets
> policy->min to frequency corresponding to bios_min_perf if a valid BIOS
> programmed min frequency value is detected.
> 
> amd_pstate_ut_check_freq expects policy->min to always match
> lowest_nonlinear_freq which does not hold true on platforms with user
> configured BIOS min freq.
> 
> Update the test case to compare policy->min to bios_min_freq on
> platforms that set it. Final comparison is adjusted to account for
> insane values by clamping the result within the supported frequency
> range.
> 
> While at it, move freq_to_perf() and perf_to_freq() helpers to internal
> header to allow their use from amd-pstate-ut.
> 
> Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied to my bleeding-edge branch.

FYI - as this is for unit tests only I'll plan to include this with 7.4 
material.

> ---
>   drivers/cpufreq/amd-pstate-ut.c | 23 ++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.c    | 13 -------------
>   drivers/cpufreq/amd-pstate.h    | 14 ++++++++++++++
>   3 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index e23773680e05..c2c1a166b3a9 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -226,11 +226,14 @@ static int amd_pstate_ut_check_freq(u32 index)
>   	for_each_online_cpu(cpu) {
>   		struct cpufreq_policy *policy __free(put_cpufreq_policy) = NULL;
>   		struct amd_cpudata *cpudata;
> +		union perf_cached perf;
>   
>   		policy = cpufreq_cpu_get(cpu);
>   		if (!policy)
>   			continue;
> +
>   		cpudata = policy->driver_data;
> +		perf = READ_ONCE(cpudata->perf);
>   
>   		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
>   			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
> @@ -242,7 +245,25 @@ static int amd_pstate_ut_check_freq(u32 index)
>   			return -EINVAL;
>   		}
>   
> -		if (cpudata->lowest_nonlinear_freq != policy->min) {
> +		if (perf.bios_min_perf) {
> +			u32 bios_min_freq = perf_to_freq(perf, cpudata->nominal_freq,
> +							 perf.bios_min_perf);
> +
> +			/*
> +			 * User set bios_min_freq cannot be trusted to
> +			 * be within the driver limits. Clamp it similar
> +			 * to cpufreq_verify_within_cpu_limits().
> +			 */
> +			bios_min_freq = clamp_t(u32, bios_min_freq,
> +						     policy->cpuinfo.min_freq,
> +						     policy->cpuinfo.max_freq);
> +
> +			if (bios_min_freq != policy->min) {
> +				pr_err("%s cpu%d bios_min_freq=%d policy_min=%d, they should be equal!\n",
> +					__func__, cpu, bios_min_freq, policy->min);
> +				return -EINVAL;
> +			}
> +		} else if (cpudata->lowest_nonlinear_freq != policy->min) {
>   			pr_err("%s cpu%d cpudata_lowest_nonlinear_freq=%d policy_min=%d, they should be equal!\n",
>   				__func__, cpu, cpudata->lowest_nonlinear_freq, policy->min);
>   			return -EINVAL;
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ea6cc072121f..a5daabc2edcd 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -145,19 +145,6 @@ static struct quirk_entry quirk_amd_7k62 = {
>   	.lowest_freq = 550,
>   };
>   
> -static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
> -{
> -	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
> -
> -	return (u8)clamp(perf_val, perf.lowest_perf, perf.highest_perf);
> -}
> -
> -static inline u32 perf_to_freq(union perf_cached perf, u32 nominal_freq, u8 perf_val)
> -{
> -	return DIV_ROUND_UP_ULL((u64)nominal_freq * perf_val,
> -				perf.nominal_perf);
> -}
> -
>   static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>   {
>   	/**
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 9f5a81976eae..578465187b7a 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -159,6 +159,20 @@ enum amd_pstate_mode {
>   	AMD_PSTATE_GUIDED,
>   	AMD_PSTATE_MAX,
>   };
> +
> +static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
> +{
> +	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
> +
> +	return (u8)clamp(perf_val, perf.lowest_perf, perf.highest_perf);
> +}
> +
> +static inline u32 perf_to_freq(union perf_cached perf, u32 nominal_freq, u8 perf_val)
> +{
> +	return DIV_ROUND_UP_ULL((u64)nominal_freq * perf_val,
> +				perf.nominal_perf);
> +}
> +
>   const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode);
>   int amd_pstate_get_status(void);
>   int amd_pstate_update_status(const char *buf, size_t size);
> 
> base-commit: d06c75c22d5c95ee27e01fedcaa07231c9bd5c88

