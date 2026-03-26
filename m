Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD31D45E8;
	Thu, 26 Mar 2026 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526595; cv=fail; b=s78wM9KeoOs+jG0KtxwQWvUqFGzGXZkuOKkv/kWSol8qM8qOshjo1KBYxQQt1J26fxP4Ut95RBDk3lfysKJGX7nqtbt9MRNnNasSwlZr3U8Zf5G1rRPv6j+xpwXfDAd1u/nJikp0p92TN5LJA/Y9ycIGVCNKWAuy5uSnOQ8B0es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526595; c=relaxed/simple;
	bh=devu44nN1swgIBKzDdLu38Lys3PvIpXbFtpeBJUBjfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a+vjxImx7RyNuaLBwprnUu6TpVjOUXSaCjeBbjXBpkvOGN2q5s0OJ65SJI4GrKmSGxFgI3SDr7V1scxHlSgFUnBNshSdleY3oUJ8YDa/DmxiCXb25j0z0XFTq/E3uz47lAM6Z43br3FIovYsHSxjifjaxgWyMhg9p0zWamfdf0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEf8WqyJ; arc=fail smtp.client-ip=52.101.48.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEf8WqyJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjSA0mZr0IIFM7zHlNIeIkgJklNZeeobzoG9FvP3nLB4ZUV/ejVxf9ualgm/Uzp2msRYQ8MEoJFXMnQbW1lL+16Jn8Yqx9bVN1jsob8hCp8XkOrcMHWFKLkByZy0Lv+DN0g/XFRa2dEdoO2j9aRDLwK8GbevKNqpZyjk11RO7jxpEZoenztOEe4hwPwar5kBdR8G96NTaht9/G2rp56sOZQEzD5sMvBr0FIUMt5A5AyKvmP4ifU3fKwOViyznMRYpDuUH/9vz/B22Jb65yNgEd9bPkqeAhHWdQfi50Y276sO7qXRCQpy8u45J2zIvuBRKc0b/sazwoS2DprHuEInpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd/9WHLEmbo6MDCSFhrg3Y3k/Y0OW7s1eIv3UO7DKb8=;
 b=Q6jp8E2Hh9c0xD+8vKx/VWRJcFW37VMkF+rcf2jhNcqs8VajpDZOzV9QsiuA84NDpeFjpJ1KDT9GFhVlFhpf7WI6pumf3JOBfsAVVr9conDa3VjEP8YuEKUNEJB8pbcGRSYGJlRWlIIa5AxtCs9PbcqnaBNQOwKhvaoI3HGmTRu0/hu+AmTINhGmCG6acTj1pzoSl6ctGVFpvc8+YEM4B8xJy8KN+k6S9hbA683vLXNvt+C4hWQwHNeGbNmEU1sQRJ7bZQrm+EvHW/9be94o+10eM/xEhru1uFaNZfoeewM0KZ0OSidX2oop9gD7MIGxgBj8XKnoS1mJzJkP6vw3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd/9WHLEmbo6MDCSFhrg3Y3k/Y0OW7s1eIv3UO7DKb8=;
 b=PEf8WqyJm896f5T0ewVCfO5/7MNPpSlO42WAC3M3kuWxTCW7hc18vWpnVpPsK5mOtr1AGgtKCremiIDeD9AWcq//BLlfxPXeN0WB6BPXMKlyEaNNN4ivRkzYZrsN7TbWsk5FRRkDBpEBuI0gXu3HLvnnr2jLJ9R6J52hWGBZZVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 IA0PPF7D094C5BF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Thu, 26 Mar
 2026 12:03:10 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::e5e2:6cab:5755:bc1a%3]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 12:03:10 +0000
Date: Thu, 26 Mar 2026 17:33:00 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v4 1/2] cpufreq/amd-pstate: Pass the policy to
 amd_pstate_update()
Message-ID: <acUgdId8HnEfReor@BLRRASHENOY1.amd.com>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-2-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316081849.19368-2-kprateek.nayak@amd.com>
X-ClientProxiedBy: PN4PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::7) To IA1PR12MB8240.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 979d4300-ec3c-4e04-d32e-08de8b2fa5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Vs9g8IzlEBXIEMQYGrzgwzvmqM8FVTlQr7tWIzAAqW9NyPsclfup1vFOXphSW1wBphc+7SAfOz0b5Y83YjyhwRPWxdGMUHhYfPZVSYcwuJ8hrs64yx6VUrtwkXFl84lObuTFj7z1rKJAQMURGCXUdmaEDh06bbiHwQptsbGCf8XV8T/ZTUvMEXqJYLSKwtUtFgM0JyVgc/yO/wd8DI/HXVie9sqsvkS8pSVG9k7F7R7/7s2+EFx2ItNBShSmQCfSwFwMJDFhE/x+vcTJUrCuGxgD+rjt/jHh+l4t/CDDiMcrOvvPtAe49FlHPS4YTLn52OPKga4Jvfwd8A+B6sZOVNnd/xsuxmqd8yuTIJO1LNo2ZLyHuvhcYJZHb9NX07UCNaKC9ea5QT3q2ivHlDTk66O43IdicaVsnp/hDmaDvD6ho3BBRniDekh1V+4EnIFrPOz3ZAgDq6i/h/V/kKyOvj9jAs45IEYQl0NFVXST1mhlL+0bmgL/ZNC+MmwXqO7W/JYgZ4pPhb/f1M/SxqH1eswNsfQee5iuZhlhFWAfJL2gl1NTlhrmJPL4nlsQc/m35XbYQubJtWGUdE409QniSnqiuHgN9xE+loSVp378pMo+wuSNirVjU5AH5fLchicoW/JYNuv2QR0VRvt3MKhEYB7+0u+cvHG25K7uwnxT80tIyJUendu2i4CC/WjNUfuFfFbAC1KDHITVqST1inOsNE37mz4LWCbdX7JeShOcsrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juU9Dfwbp3K/ne+27MqZeT+J9BiqDWgj96GInMg5t/GUjcYHVClIxpDWokSI?=
 =?us-ascii?Q?FnFrIZ0wqRToeNuZdkpKngKiiKVAloYdqy/vnHMwbC3fc3Tfec5UJeXqxYy9?=
 =?us-ascii?Q?vSRw2YQtH5IZR8VuYAExq+bWdt6YSoZABoSje4bpPm5aZ6zqdnSZ0PSE24tx?=
 =?us-ascii?Q?ODq7zzuWRmMisHV9S1Tg9UAUEyKix5IqSNbZVa/vKUKRz/Jx8yB9U6lsEJZP?=
 =?us-ascii?Q?guGZ2m19URq06jOdY8r6Y5KJ/YnT9AZ9P0dMgRXAksSgKSrkx4EMEoJ83737?=
 =?us-ascii?Q?8M87HurWZPnIdJ1J/VH47glzkEiepGScsSCyyne/ZSFSnIJZtZ9oMXg7KxDl?=
 =?us-ascii?Q?gCRfidrVIAxD2xIY5GehEFPWM+fkIhlZEG5hC4EXvCja2jpChRX2MZ5eVJJ8?=
 =?us-ascii?Q?TRvN+sgxq/P6YiJf5aHGhVyVt5NlX/2tVmbsK6KX0LL5H4y7QYPyIRimweTq?=
 =?us-ascii?Q?+ObsUqmxrnSlOEDTbt4hcRlJNmzt2aevwVVX6nZIGn9BOdvZ6QeSREgarLs1?=
 =?us-ascii?Q?GahaLEg5fbGqZIOXbLr4jSjDB5ZWe6yPHmoQKXAaJKRigR6LFpxBFTsXmfda?=
 =?us-ascii?Q?YxCgoRi5RRjWibHUrR8bMrPuDKUYKTdR74GRRT00Bsd9owUceWrF5kIO2ibE?=
 =?us-ascii?Q?bkjQxXhYK6UgjjTsCRDCEiRes82k/VJA/JyG0x2CuisZjkH6Itz5qn9n5bsO?=
 =?us-ascii?Q?lNbotTxb6I4bwUbbVWMpD0i8aYsw/DzZuzhqkJ0tXi8nDm14/mQmg3OaeJQ5?=
 =?us-ascii?Q?BTD81IyQZcPo16w33cHbbLhKRK1lE96QHwtlvT5exAxVFK6ddKYsXNNezfk+?=
 =?us-ascii?Q?rEgPjtlGoccjEG8UdUHUew2MSwShBDOorGcV98pgFbiHQgHA2ZIxGg0AvDno?=
 =?us-ascii?Q?WG6cq3i5EHEeNSKVZkOOGWSSKBuuUScoAD7WpJ7t7qszQicHg1YIfKV5h8bc?=
 =?us-ascii?Q?ZZoqc4ab07+Opm7AOIgqpA2E2DiUhHcgObxbPizSSj06XHM7Fs2wX8lxGe0/?=
 =?us-ascii?Q?EcieiWIMAKdI3OtZMWzv+ocj++t1UnjzfOfMTn8YBY4BwdttHcEiioi1N4bu?=
 =?us-ascii?Q?Zww3qCA+VsCM8WxwSD7WE+a5cogOVBzPMn2Jly+TpZcBIhTXCKfy9gnBSQ6u?=
 =?us-ascii?Q?/Ro/3ZCWiiQudv+evx2waWdEqnQYzLFiaq7SeSLqSLHMUj0g7FPQiahJGJuq?=
 =?us-ascii?Q?Qugi5wD8cjKD3F0yAqj4ewOxPM3V/xCojRu/nCHKV1bVNNNfcyj+tg4pgCxm?=
 =?us-ascii?Q?ySjvlgEx6iZ4CQ2YGj5uQE4y2+GNSyxKtgbwyGXR9IczBx/AJLlBJBpFJgLM?=
 =?us-ascii?Q?HS3o++3LkXj2TpvcsZmOmaLZrICHrcLbxSJIGIT2itIA3CMt8AgaM1S7cUSH?=
 =?us-ascii?Q?LzuRIeTGEskV3ghxAOYtFNP1s1cFwdfxHWAaV7+OkI+OL+WEXzg7fpPNcV1J?=
 =?us-ascii?Q?NF8hiuCKhnzksGst14W6AJOQHsz0Avz/A0BczVZJxJoUDiGAC/C4LsShvOGJ?=
 =?us-ascii?Q?UNgUidTQrK2ui8xqAoJPgMkfmfObelChQp9uaxMMr2Y6ATXZ236I7V/c6wI8?=
 =?us-ascii?Q?nadXK7LD28RLtIryHgHBOAiTdlZGZ3ve2HG5/sg1aRNKFf2t/T4zpXoEXjF1?=
 =?us-ascii?Q?RJSJ24b/8ju7O5Ko0w45/D6/1zEKsoSuGJjaRj4kGaZzy+qdour5GPBT1Za+?=
 =?us-ascii?Q?PK6LNjDa31ulYdoecZI39I6oJPjVIxwtu9FvvFx2HYjA3A4Du6QEwDLYNsHy?=
 =?us-ascii?Q?8lMCByfcYw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979d4300-ec3c-4e04-d32e-08de8b2fa5cb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8240.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 12:03:10.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q35FAMN2kmic6Pcrg/R66f3k+OO85WgRGpIm97I8cAJxKDIaWRyL07X7qnrsFO8pmO0YAc8bmzyIH3f5K4jK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF

On Mon, Mar 16, 2026 at 08:18:48AM +0000, K Prateek Nayak wrote:
> All callers of amd_pstate_update() already have a reference to the
> cpufreq_policy object.
> 
> Pass the entire policy object and grab the cpudata using
> "policy->driver_data" instead of passing the cpudata and unnecessarily
> grabbing another read-side reference to the cpufreq policy object when
> it is already available in the caller.
> 
> No functional changes intended.
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
> changelog v3..v4:
> 
> o No changes.
> ---
>  drivers/cpufreq/amd-pstate.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5aa9fcd80cf5..5faccb3d6b14 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -565,15 +565,12 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
>  	return true;
>  }
>  
> -static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
> +static void amd_pstate_update(struct cpufreq_policy *policy, u8 min_perf,
>  			      u8 des_perf, u8 max_perf, bool fast_switch, int gov_flags)
>  {
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
> +	struct amd_cpudata *cpudata = policy->driver_data;
>  	union perf_cached perf = READ_ONCE(cpudata->perf);
>  
> -	if (!policy)
> -		return;
> -
>  	/* limit the max perf when core performance boost feature is disabled */
>  	if (!cpudata->boost_supported)
>  		max_perf = min_t(u8, perf.nominal_perf, max_perf);
> @@ -688,7 +685,7 @@ static int amd_pstate_update_freq(struct cpufreq_policy *policy,
>  	if (!fast_switch)
>  		cpufreq_freq_transition_begin(policy, &freqs);
>  
> -	amd_pstate_update(cpudata, perf.min_limit_perf, des_perf,
> +	amd_pstate_update(policy, perf.min_limit_perf, des_perf,
>  			  perf.max_limit_perf, fast_switch,
>  			  policy->governor->flags);
>  
> @@ -750,7 +747,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
>  	if (max_perf < min_perf)
>  		max_perf = min_perf;
>  
> -	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
> +	amd_pstate_update(policy, min_perf, des_perf, max_perf, true,
>  			policy->governor->flags);
>  }
>  
> -- 
> 2.34.1
> 

-- 
Thanks and Regards
gautham.
