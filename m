Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2E3ECBF3;
	Tue, 31 Mar 2026 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948360; cv=fail; b=J8H/ePvay1hyWSB3btUTgffsQBHvbghb48ERue1fbORI5hRwlxJ7ryr3HS8n/5vCJPtUnm29BSxb5cIWIT4xwR2zbWJ4trYvQQGV9lVPjvsGG/1A733G8BFZTZwaENTjBdEuORSBLQtRSNTQwoDcuI6V62/9K9VMTaF39pSJBrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948360; c=relaxed/simple;
	bh=V4DjcqGruefUt59Ymqf+gbS20FA3Iw8Ex2AqwBQj+dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KzHqfMqLkMywz+cJntbcYI5O9O/5UwoPp1RzZEOr8WVnOuV9npuV8skSPK4LuFL4apINiVLngi2CQC56dXNmflOMbA6VOP6VHXLhEBhpGDcqdteNjPqlaiUhjpN3AqXUfkSOR61I6sgnrAUDWG1jqVAELNq1ptJytfbkZVtG/4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O43ahw+L; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O43ahw+L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4dX9bk2ACdkplhimCJokvQfXSp99KeoiRBoqSEn5bRj4tZSSgJm+406La+YtDXHmEHnt5epayjoWmIopMougUOtqnSZqZLA0m6gy2ylGzWe+ExgxAn9570Cus+C63mTvsaTeywZ0m+YufPrPMjLebZvSn5gyUnD1g3n5e8nXHD/tygKXyoPxSBUe4DY8huYNILYYCBTTF/4vQKYl1TevbJ8QRSBJdUdlG5e5Naqfq0mWix8xwLTIEHBZHN3xM+eBQ5nndFWcg44YIKtkeX4mK5E4AO+JpeXqVDiEEJdTlXR/8H8YYaRJCVoC+XF7AhzTb76aNKgD3YqQjSHKOsJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khiXZp+3L+jXLbCkT1/nbQ23GfbsEkoMv3Tn1mYzyyk=;
 b=UtCsYRZNe1PgfQvHP/ywaJ0cNJyAIRgv3cJ4tR8lo4QcW5zuGUd+vxVVzRXvl81A1xAQAuwRwHu2hkamjy85RNHOsoaLRUNnXmG72FaO2I2YDuiHZ1YD7W8j19norEkdTF2QjLFkA+eY9pwGQTQzJH/nbT5BlDKLsDJCb1s9nROgGJh7UJEM5XslFh2qZZ2YZWt7ZS3RCEAYi8OkTtDmP7ZPe1LMxcYq8qfmMoVvwWCBXsc+8LhW162Zp43HEwBQjc3cKpghTPkdLrg7x0mKa420Nd0RK5jR3lREwsaN64ljkP/VUXH1zzSiwLH9Ve3cTw5UuRaTQ0taVQkKvDGqHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khiXZp+3L+jXLbCkT1/nbQ23GfbsEkoMv3Tn1mYzyyk=;
 b=O43ahw+L3OGRIpdsS0QW/aoY1BI6syg0BtT9qSMr37rSVnEr4Wy4v7D67MPlckLBtp7wCRZ81OHyA2BBI8vmXWlZ/0fYumXbFN0Le3nQ5CbiwD8gndOpYByCGM940jsYrjeYlqCp9Lb5O3sVsSZad8nHmShHQ3hrw7/dDFbX918=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:12:35 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:12:34 +0000
Date: Tue, 31 Mar 2026 14:42:28 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: Re: [PATCH v3] cpufreq/amd-pstate: Cache the max frequency in cpudata
Message-ID: <acuP/Dqh6+jBm+23@BLRRASHENOY1.amd.com>
References: <20260326193620.649441-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326193620.649441-1-mario.limonciello@amd.com>
X-ClientProxiedBy: PN4P287CA0081.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::15) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: b42488ce-afbc-4d8e-9f71-08de8f05a543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ul9D7w81OTC5SpCH6a93uGz6p/WNV8JNtTyhHwPhR9QmRokS6TDhvkVGsQjpl66KHfxRdE5yic5djALZ353iXMeGmbn4rbAWia0VDcIlP1KBsoW+hoPKfNgyIKAKSpMbAkwOn7D3KuwqFNXapQ1SY+gYt9+zd7EUf/+meAb8uKva51BYKUU01fg5+fDikpideHs7++5r5UOqxt2pv0FoW6/dBk1hEOTvwPnFxm7134+Hzq38GaCUSH2W59zdzsuS//ejb0ZMqdKfQ5AjZbIr1JBAwzfxWq6FAETeXX230D3BEtZKDFn+IBMjRHB6uIMehf1T9zrzNm4VOslpMu9VPwgKfo2grL79tDbzIucFg4PmFWUvCilczm+0NoqvJ4BqS4jItaHLd3Hn4b/19Fz0llLgM6bpNpr8T6H2yQDOzz5pgJbfT6I4bE49CoFeiX9BqOys7J7ZaD0+fFnZp7b1deGx7kCod+lIDG1NGCww2XC8MBcgbq+nt3yrU8GXwlb7MfHvW1cIu6LM/JT0dgxSb8+Xz8wUGRCbYzcQn5MqLYWFsbUmGBwuEVgxuxbcGXQRer/64osgcb9b+tNOG/i/OsHIJB/i+Le96CQPgapKAnP0SoLGTIoCAKTE1tWIU7T1FmyFTuzBJJtawqHSk1hTQofdP8GF34vBNB+1F18rsCWAGOpUyvnXzZcVS50CXgqUG+3cTqgBKjVeuF+kYl7lbJLXOh79Obsij2YADB10cQg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zkhd0eyp1pwOYSh41Ln9APZ5hSnqzXGHBSD6YrUM6Vr3wB6UppIBYgcDhflH?=
 =?us-ascii?Q?80h05DygEGunHI7qIBO9KAHarXGmOv2JSwbO8tbQo9E2Va0VfIo8qoWycufd?=
 =?us-ascii?Q?Y61uinX5Gx+E5gI5coHOeeZGaAFC2zmEYnzKZS8Ob2Dq6irT+/QQ+hJt8lAM?=
 =?us-ascii?Q?EfOkThTefJ3EQzQjwXUTbGpmCe6S0lbgPuVNZ9OU4sAqBDTtnsl05Sif2xlB?=
 =?us-ascii?Q?LWkxTZBRPl8/rrOfW9UFlBVMs/CynZc7u1RO2dXGb/SoT8LFPz8zTS4mYt4J?=
 =?us-ascii?Q?T00jxYSIRoCwpaaMr5mCjw9g0Az5QqEFo8a05A9d8FSYS6CECWa049HFaabc?=
 =?us-ascii?Q?G6twp7wdz+JNwCaNv6PExdqhw+7AOFILBq5TnkDJ8G6t7deaqWxh+lKTAIWw?=
 =?us-ascii?Q?0zwh6e7CoHGvD8haGjMKzf8an+eOlgHz1glWUqSXr/MSCiHc9sYU6FblNBNn?=
 =?us-ascii?Q?2Wt0fn917wcbmpkZ2n0QKJ9RXo3Dcbrn9A+K5eqd0Va/Rmlxo+OpSf5aynXc?=
 =?us-ascii?Q?4lzk7CM3iPZk9c3JpjfXDjJ8i/itDubTsbeTxGDQnc7bDmgidN/K0nhzcr5u?=
 =?us-ascii?Q?swQvtbpidhCK4y1NzXr1o3jNeuSiqw1HvFaB/Ia078APLo2o4cHmzoLVOoJP?=
 =?us-ascii?Q?vmukyixyqDExk7v1JodE2JDpUNIULamoxhqfAUR80fc6XdrPT/7483hVJK50?=
 =?us-ascii?Q?loKv8vxzOH52qLOdBp88nUPZhqELO40h6pcvJqX7+uVGol3uku64TnRbK1KH?=
 =?us-ascii?Q?MTFi/XCNIdjUAc5H/Ry3sdYWfhfqWMUbPsZ036lpI0k0HPZeGeS7u1xxlaGP?=
 =?us-ascii?Q?mj+bXq7u6tVINUFp8p0fQ7qhlkAzgF58+1CHHpYrtLREozDyb4mVKDTOMWLy?=
 =?us-ascii?Q?6it5v7RJW8/aLFBwOmEMXfS6kJNf0YWHdsO2//K9eGiB/SOh1jqcqi52/GSJ?=
 =?us-ascii?Q?F8XDhaAiYVatt1OgOqS0x34j8j329cP2xQWd6Dlnv8M/B+yIfCZgoBcWJJOI?=
 =?us-ascii?Q?X6FnIWZok8DEDbg0ZI69R9NTzf8gO6waMGuVMztLzhbvL+evF0950vlL113G?=
 =?us-ascii?Q?qKK4fxiy0r87ajxC3krbnagoUfiXhzgpDwyHxIulSEnk1HYwSfdwollhiYOz?=
 =?us-ascii?Q?uta1y4jvP9Wmq+xz26mU0/6CgC1WgMRjB+FAJ7PlAE2WTMSJLnkIc8DDH1sK?=
 =?us-ascii?Q?hNUfOKjaFT4mo7whkEluIgumL0RraejZwisjr/eqVCBqlliq+F1SweI8j59v?=
 =?us-ascii?Q?KOcpp2iqjGw6cuiZzqj6agH+nTuBmOo0f68K4VdThgTUw/Xq8Kg9tbAVTNsE?=
 =?us-ascii?Q?bYcouZ9sFx9+DLB2kCFeTuBa3cXHGHpuu7YZbCH3cAtvRdcpmZRZJv+2eG93?=
 =?us-ascii?Q?oKC4SNQYnLhAfBgQe/UDMel1ZtXhsQTy8f77Ml0wOBZkgcHZ1lzCOX4/grgv?=
 =?us-ascii?Q?oWWhXrtnWi+C4Kg+272ruZUbPZZJlU/uRdib4hXKtA2x3phG/O/F4p/d/saY?=
 =?us-ascii?Q?/7KmPMFWhcZJEn58eSJfndMKBNZknPJBOxpJCoX54psc3ZIf/sH+32lPDp/T?=
 =?us-ascii?Q?kog1UzA0mVqG+SyXH4Verb8MqRdkges694Qso204zja8uhRESCG7mLQtMdgW?=
 =?us-ascii?Q?KVY5EFUHxjk7uz6MV/5lC0JRNQzblhZESu6SgR+WMxwSRTnVfI0T3sH66HwF?=
 =?us-ascii?Q?YcUC8BbyOMEArp3+c1PeAaX9QgtDR5TkO+u5K8f0EPXlK11Ln6jYi2ILpdS6?=
 =?us-ascii?Q?GSbT+IEtNA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42488ce-afbc-4d8e-9f71-08de8f05a543
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:12:34.5382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P96gwWo8vMu9iqSI7/485G56Zjvqa3sDM11+0oNaTDAbc+EDsB4gOJgngTSxNBeC2voIGibABRWA6yC0965muA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623

Hello Mario,

On Thu, Mar 26, 2026 at 02:36:20PM -0500, Mario Limonciello wrote:
> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
> 
> The value of maximum frequency is fixed and never changes. Doing
> calculations every time based off of perf is unnecessary.
> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

This one looks good to me. Thanks for fixing this.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.


> ---
> v3:
>  * rebase on Gautham's CPPC perf priority series
>  * add kdoc
> ---
>  drivers/cpufreq/amd-pstate.c | 27 +++++++++------------------
>  drivers/cpufreq/amd-pstate.h |  2 ++
>  2 files changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ed9fd4155a256..f207252eb5f5f 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -826,15 +826,13 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
>  {
>  	struct amd_cpudata *cpudata = policy->driver_data;
> -	union perf_cached perf = READ_ONCE(cpudata->perf);
> -	u32 nominal_freq, max_freq;
> +	u32 nominal_freq;
>  	int ret = 0;
>  
>  	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> -	max_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf);
>  
>  	if (on)
> -		policy->cpuinfo.max_freq = max_freq;
> +		policy->cpuinfo.max_freq = cpudata->max_freq;
>  	else if (policy->cpuinfo.max_freq > nominal_freq)
>  		policy->cpuinfo.max_freq = nominal_freq;
>  
> @@ -1021,13 +1019,15 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>  
>  	WRITE_ONCE(cpudata->nominal_freq, nominal_freq);
>  
> +	/* max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf */
>  	max_freq = perf_to_freq(perf, nominal_freq, perf.highest_perf);
> +	WRITE_ONCE(cpudata->max_freq, max_freq);
> +
>  	lowest_nonlinear_freq = perf_to_freq(perf, nominal_freq, perf.lowest_nonlinear_perf);
>  	WRITE_ONCE(cpudata->lowest_nonlinear_freq, lowest_nonlinear_freq);
>  
>  	/**
>  	 * Below values need to be initialized correctly, otherwise driver will fail to load
> -	 * max_freq is calculated according to (nominal_freq * highest_perf)/nominal_perf
>  	 * lowest_nonlinear_freq is a value between [min_freq, nominal_freq]
>  	 * Check _CPC in ACPI table objects if any values are incorrect
>  	 */
> @@ -1090,9 +1090,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>  							      cpudata->nominal_freq,
>  							      perf.lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> -							      cpudata->nominal_freq,
> -							      perf.highest_perf);
> +	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>  
>  	policy->driver_data = cpudata;
>  	ret = amd_pstate_cppc_enable(policy);
> @@ -1167,14 +1165,9 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
>  static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
>  					char *buf)
>  {
> -	struct amd_cpudata *cpudata;
> -	union perf_cached perf;
> -
> -	cpudata = policy->driver_data;
> -	perf = READ_ONCE(cpudata->perf);
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  
> -	return sysfs_emit(buf, "%u\n",
> -			  perf_to_freq(perf, cpudata->nominal_freq, perf.highest_perf));
> +	return sysfs_emit(buf, "%u\n", cpudata->max_freq);
>  }
>  
>  static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
> @@ -1702,9 +1695,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.min_freq = policy->min = perf_to_freq(perf,
>  							      cpudata->nominal_freq,
>  							      perf.lowest_perf);
> -	policy->cpuinfo.max_freq = policy->max = perf_to_freq(perf,
> -							      cpudata->nominal_freq,
> -							      perf.highest_perf);
> +	policy->cpuinfo.max_freq = policy->max = cpudata->max_freq;
>  	policy->driver_data = cpudata;
>  
>  	ret = amd_pstate_cppc_enable(policy);
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index faead0b19a8a4..32b8b26ce388f 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -73,6 +73,7 @@ struct amd_aperf_mperf {
>   * @min_limit_freq: Cached value of policy->min (in khz)
>   * @max_limit_freq: Cached value of policy->max (in khz)
>   * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
> + * @max_freq: in ideal conditions the maximum frequency (in khz) possible frequency
>   * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
>   * @floor_freq: Cached value of the user requested floor_freq
>   * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
> @@ -103,6 +104,7 @@ struct amd_cpudata {
>  	u32	min_limit_freq;
>  	u32	max_limit_freq;
>  	u32	nominal_freq;
> +	u32	max_freq;
>  	u32	lowest_nonlinear_freq;
>  	u32	floor_freq;
>  
> -- 
> 2.53.0
> 
