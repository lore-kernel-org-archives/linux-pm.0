Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2F30EF63;
	Fri, 27 Mar 2026 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602665; cv=fail; b=LpeOwW6t5HOyPlEDlwrZLurjFzEaxDMDBoYLjNptUrtXLcE6FxM3xx7tASTPLFJ65usWCGVSDVfBpnpgpiPCwgsQvQqzNOt7UNOWWN0txO33pPbWMdM/amQgcrGBh3APEyC0IR028YBjrkQVxnJkCsCSwnFc+ar4uL6FfuE1pU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602665; c=relaxed/simple;
	bh=8uIbZ3B9vQBbZFC9usGufx0+wUQgfb8XnZIomra3VWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KxbHZ//TGXDz3zFnpHHFmQrOx3+3xMh9LGzJyDslS55WrqnU5V1yRcnq5aXtXIktjegoQp/3IjLIruDcXv86aKCuFXfwTKo2TOq8bC0ENfMSmB/gDMv3xWd4mB0QPxUH5jGb3ZsiFeqqd6KRakiLXyfK0v0v7H15tevM1PaLpBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AXC7pzWg; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AXC7pzWg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxQp5QKCuX7kiv12dAP1nKoqPvuWwaQ1k6ncC1z3srY28sodBeuO0sMgLKX9HqIVxpgd0q0MO1isp4+jJfrGU/D4ai8j/Ud0OfUdAwrYHzHu75PoioAOxawfUHjk+In4CDKco3tBAY4Fw+XoCr+FRT/pmZ8bu/j09mYPp3FlhMu9C9Pt4eIstrLEKZRxPR0/7RhG+ikqPaw+6AVdce7FXmaGoM6hvcgotPBi38hJdhI2HwUkAYriopCMy3SxJxs1Rz5M3WHYbmuChnmWO9QnE6c5HdtkEn0JYScl10h9owtramI8nXaU8ljfXErl1lmH80ac2IqH15V1yyyuc2aUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WJQ4AIQyGOJBiv73HiegvCNCyL7HWRaBOKjg1iI3sc=;
 b=Fhi3XVTfFUEM9HNuZp6hFBlFkl0t6HHr7L/dN1s0BJca/ikYnS4w3DKLceVRe8qTtqXILIgfHQaHnsqHocIjqeaX2o1IDTFS5qk0K3Gbs7XIzFmN3oYWZiSSmybb7Qg548dLGGoQNyROYNLrhRGWVRi2G7FnOvL7L0WP6wbqzPrNVgNsO+jaImRmCqY+nDzOaPRxfANV8z/1uipEa5gDhGNrAZ/nDkXOFNofCuJsl4CeW/MnqJIyQjjkT4snDfeSocVStJ6nT6YTFKyMT7zQFsB6jVJmuQCFjEZFXetLmpzBCrKxwKJHr1vo6hgDYl429403e/zsFGgV6RAgKltk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WJQ4AIQyGOJBiv73HiegvCNCyL7HWRaBOKjg1iI3sc=;
 b=AXC7pzWgK9QAYEBQXSmILGJB80DGYbCIjUZQNWBTszuivb77gRQ/3D+OdibLwPR8dDPvsd7pflY8IU1JXkttxAmyPv/OQ4bfidw5n01QErqofuSWo4zmNpnoE7r+5DXAaJGPw95udaO0NIIIIoI0dOL9RWKE29Bd7jOOmpEt4Wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 DS7PR12MB5838.namprd12.prod.outlook.com (2603:10b6:8:79::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.10; Fri, 27 Mar 2026 09:10:56 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 09:10:56 +0000
Date: Fri, 27 Mar 2026 14:40:47 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/19] cpufreq: Use trace_call__##name() at guarded
 tracepoint call sites
Message-ID: <acZJl8QUYEq8voqQ@BLRRASHENOY1.amd.com>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
 <20260323160052.17528-7-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323160052.17528-7-vineeth@bitbyteword.org>
X-ClientProxiedBy: PN4PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::13) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|DS7PR12MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: bfdb1497-07ad-404f-a5b1-08de8be0c0fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NSqLMsY6wXn+Dw1WzCKhF7IAxLiEWWebmMUk8r1JgnaTiqO5tzpCaCRCIvXvr/BjeSprGyIZ/zcVz6HiRd7QJn42bncTLCxyxbyBIRhWVUgqb29f5llqN5kf39ltHfZc5t0Fg4iRZ4Sixo1JebHD5Phsr/wmfDvSXG0N3V4vFDxafVGm4vl7sZc6lyKg4D/1kq//J0yEUvD38G2uyOVFkhHbus7/7TY0v8FR/V8a3NUfKCxesj6DsAs9lO6eMqLWR3gGorxDblT9OU+YMNMj3GaHHuYjYjGsnFwYYihNmCkixLuD2OpMvzqBpcWW7PbdRC1dckwkD+b+iLzwLIgqXpHdGXN0X6g2SitJv/ovcgpjB9Tx8qWjHHUUcbyu8EyFkDC2lrJ8eCBd3Y6lNqd0lVPsPyZ+z7fV1OxHNtYO0ykeOO3LSjfPxSk2rIApC/8zfKIGbUh5OxzBuIwiUqb7BaUU1NT+gObxBlhRH4enmTEgrWBzZgtYlSpwP71jPGJBahaLEEavvI+RLc2UnRagCSzSY+xLFvTcnqCejxNfJYY9LF35f1sRCKwolmIJpbHwsfVzvwLFpB6ppvmFPFh74QQSkWkIxJrEIR9md+wBkzdh3MiTPnBWs60eBDY9tAEpJeXsTBf7YMoWLu/O6ATyMvB2azFl+GWOSMqbNVEfv0I69ZN9q7OGKfBGjLZca94Jtt3486uVousGevNyVFotdJRDGF7VwaXvRQxadVYtFdw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?30d3WBaTISKum6s+3CaphzaeU03Ws4hETl1C/XXUEJc00/BaCSsJI5dq0tF3?=
 =?us-ascii?Q?WWjmPTJFP/mnSWikVjzWk6p5S3P3os0RuPCI+caROtb6kvBDGDr2zmgnwrS/?=
 =?us-ascii?Q?oH8rSpAR5ymsPPi9KMrikpICGSlMNv+D/GwlNDxErWBYyS0WcezKs9W0ctJS?=
 =?us-ascii?Q?9FUufWAQPDfmWkJxGVzhxjrXgoSzORY4SCmtTGcWQWrttP4J071iV1d//Lc2?=
 =?us-ascii?Q?b1V6z4crRhKX40WylQ4uW9sMTC3qIqswepRB1a5Qa8VLwTB7EIrL9mGq0XHt?=
 =?us-ascii?Q?o5/4QeqqfEowpz3/rbi3cONVf7QZzPSvqp+DHBfe0u5005FxNrtntHjR3Ar/?=
 =?us-ascii?Q?FtnCz4vvHD0eGANh/bt3LyI1vjgj/Nb5a8yGYDHMV/aWEWYEpovSXKZyyDfQ?=
 =?us-ascii?Q?Hf5wVOb767PCnca+yJ0bf6z8v6R60jfnohMsfBKMJZLl4R1XETJ0yZwibs8g?=
 =?us-ascii?Q?38rqrDTV85piqW7s3Pk5HwTCXu2mqyDPPHayaWuQHxSEjba5nkEdoQpnhRpj?=
 =?us-ascii?Q?KGR6LrCLzSI43aHxGohsm2Zx+aK5vShx9ZCBhc+cCY11icRBApGnbNQ2XHGn?=
 =?us-ascii?Q?KZKrKlC/nrxjzQR6BR8WUr22OLp2XyViyftm72VCSuBnkeZdkzZ4gej0ajUh?=
 =?us-ascii?Q?tn2OJ6IQ0jTZ/CqQVHNmG+pBuLtBvh8Zeli4TJnyS3kGhFQAUWiOenLOrcHU?=
 =?us-ascii?Q?SLADr8tjg4K/Hj9ycCll1qupqCHhLcSGTqAcaehmnOlDXJeGDGX+drXm1plh?=
 =?us-ascii?Q?0njEW/ipVtPeIaXXyEcOE9d84NPaZvwu/jFqQCiRxadgf+m59MBaDT6QEudy?=
 =?us-ascii?Q?11X0QXYG4zdmqywTbNpqPC86OcCk9BnR3wDEgCAWizOBJsw7fvmWTP+JUue0?=
 =?us-ascii?Q?IJzEscIh8oTPSVmrE+5yU932/ESJ4VnP0rbod5pUM9dtIDNesmcmsPyIIM6x?=
 =?us-ascii?Q?l8vqm4mvLkmMX0DLSn/bGbPuSw5L6KCf8jtj4gKEB1Hgfq+0IsnzAJT1QJhd?=
 =?us-ascii?Q?rsiEuZrhqGy+4QTzWuslhPPEJxuuzzKOoFVFHSW64pSBKL7FbQ8cDtC0hYUO?=
 =?us-ascii?Q?EiDRzIFtWwl+Z8tmW78LGs/SmmMJ7bA+SG1yI9ermD/60M4YJuAb/PPfuZlh?=
 =?us-ascii?Q?/MxrvkkGewH+vAaBX2Y1ttH8UBGY+q74LzoJLu36wIa7Aq+zf+4iwiwbSyfz?=
 =?us-ascii?Q?WuBys8Ftch4eoJ6fEMWN558fKl/oisVjEUZYnhpmYap9q0uoUad3dZh3AJHU?=
 =?us-ascii?Q?B4G4HJoH8J0jLMTTmBj3NG3gA7++80RzSLSe88/Q4h3wf3b+1tAYOQkkm90N?=
 =?us-ascii?Q?wz6fUdLge3LnDo9rKz7VWWoV9ByD9KRTslcsGMVEqB7P+tkCocvx7ycafEbe?=
 =?us-ascii?Q?XGQxcY4qi95KCQK9BO+uetQF54nXhHu+X4vOmnlXbpM6itsQ6htGtwQQ+G0f?=
 =?us-ascii?Q?8F22SRYTsnM6diNUSzPIoXmkTjz3IPXGS4deqfwurkrDDp+Q62N18oO1a8Hy?=
 =?us-ascii?Q?a14xybOsMkS9whnXOYJ/ZoOMUHhO6owUclk9pwSnW/WaBP5kpWUjgmg7U6RV?=
 =?us-ascii?Q?tuQPsYCvwCMY7GvodtkFNZ2+f6kUqZOAYrgNXKvlZIKQEWS/hyZxYusUx06p?=
 =?us-ascii?Q?+5uTmEgR959DfZykg1UA0jrJcb4lnNgy5H5Enzoa1+eL2GpGmeQ7wgC8cEdc?=
 =?us-ascii?Q?Kqj0yzejDPSjqVlU9YsBuU5XOqa8nqaZchBDuKyP/lDZ7F1cKaHRJVPC/2Yo?=
 =?us-ascii?Q?BDndeD3Z8g=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfdb1497-07ad-404f-a5b1-08de8be0c0fe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 09:10:56.1705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugTjeQfNuMXxhrHKugmab9Nq+MgRcn9jUJ+fU04NJS4i0geRYGYMHnL5tU7lr+jZcxRU4+htk03eYGDqTDrqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5838

Hello Vineeth,

On Mon, Mar 23, 2026 at 12:00:25PM -0400, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6


For drivers/cpufreq/amd-pstate.c and drivers/cpufreq/cpufreq.c

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

-- 
Thanks and Regards
gautham.

> ---
>  drivers/cpufreq/amd-pstate.c   | 10 +++++-----
>  drivers/cpufreq/cpufreq.c      |  2 +-
>  drivers/cpufreq/intel_pstate.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf51..4c47324aa2f73 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -247,7 +247,7 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		union perf_cached perf = READ_ONCE(cpudata->perf);
>  
> -		trace_amd_pstate_epp_perf(cpudata->cpu,
> +		trace_call__amd_pstate_epp_perf(cpudata->cpu,
>  					  perf.highest_perf,
>  					  epp,
>  					  min_perf,
> @@ -298,7 +298,7 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		union perf_cached perf = cpudata->perf;
>  
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +		trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  epp,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
>  						    cpudata->cppc_req_cached),
> @@ -343,7 +343,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		union perf_cached perf = cpudata->perf;
>  
> -		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
> +		trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
>  					  epp,
>  					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
>  						    cpudata->cppc_req_cached),
> @@ -507,7 +507,7 @@ static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>  	if (trace_amd_pstate_epp_perf_enabled()) {
>  		union perf_cached perf = READ_ONCE(cpudata->perf);
>  
> -		trace_amd_pstate_epp_perf(cpudata->cpu,
> +		trace_call__amd_pstate_epp_perf(cpudata->cpu,
>  					  perf.highest_perf,
>  					  epp,
>  					  min_perf,
> @@ -588,7 +588,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
>  	}
>  
>  	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
> -		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
> +		trace_call__amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
>  			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
>  				cpudata->cpu, fast_switch);
>  	}
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 277884d91913c..58901047eae5a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2222,7 +2222,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
>  
>  	if (trace_cpu_frequency_enabled()) {
>  		for_each_cpu(cpu, policy->cpus)
> -			trace_cpu_frequency(freq, cpu);
> +			trace_call__cpu_frequency(freq, cpu);
>  	}
>  
>  	return freq;
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 11c58af419006..70be952209144 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3132,7 +3132,7 @@ static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, in
>  		return;
>  
>  	sample = &cpu->sample;
> -	trace_pstate_sample(trace_type,
> +	trace_call__pstate_sample(trace_type,
>  		0,
>  		old_pstate,
>  		cpu->pstate.current_pstate,
> -- 
> 2.53.0
> 
