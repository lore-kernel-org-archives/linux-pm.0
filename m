Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156940587A;
	Tue, 28 Jul 2026 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272569; cv=fail; b=oicjKwT75x/IuN3ozI3Z0STbUouDQyVFS0Y9YVGpDCZGCzWSw/mQiHaJ9aYdDQLQzIIoaiF3ykAQogHzzuGIeAwtTAEzDMryd8k/PqCAy7LLsNyCFbFI+OYr1hqP/I/xYQwwfOGpe6olrzZbPeU7Es6yYTTm3ykuIEyy7p+Sn64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272569; c=relaxed/simple;
	bh=kyh+yVVd5dQF/mughGebIc+EHIsKrr+E8rBNSlEfqcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YptmD3tkseAf28vl58u6/693dv3UMOnJum454wJCGjDc5ROzXLoKuC++dZ4MKKSiGYogWEWMP9X++LCEQM3nRMZC2Oe4SG6kzLZmT66Od0OzYS/Aj03wosFveeXk4pqlaX3nLJPBff5VX9xhD/bTMBg7/ZxGtWXi+DdJGBfaZgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jggc6Rk8; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jggc6Rk8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5WsK5UqzhniW5j73MWbTvQW3u+10UAKfDmCiCzwQ8IivnbraVkw+U5u1Svoc6QJw1iC+72ImcKN54SKVY8bZYm2ex246BqypKXBuyUiFSB70wImHFAVPJDgnFk+1YqlmP5Y0kgtxUX6oNOl+9YpRC5keApPkE7MNQKsmyTjGcJKiQn5MjW621J+5Uj3i44/DoUJJRgBWVJVSBeAVpMx14vOsd7JBkYLW1AU2vCfTpNigramXE1pUCAPc92WRCMh7WmL+wi7hNtJT8NjFhTZ13oGbv6U8VIA1tcoOS6ryAopZlq66KQM1oIHM7RSMUZrwRLirFq5XCh4r2O179dM1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtJkuucW/tphJc05pGRAMwXWCLdpef0BcHHTROOj3pM=;
 b=by9uUmh14TIUmAbNkKpdmGTL6iEcuV6wjoW1EcZZcwaFVmBUd7W3WNraBV6qXOaSRCxiAHSqHScqYwOaiOzqV+fDIPwu22sRAq7sssjTk3BXY7dMu90XweVZuzEtqOR7TQ/SL11DVyA4x3kIEH3oMWkBuIPsbZGdBgBVRLdmILgJ4m5ojYrmSJ69l26XiqvHA3+nIyg48id38USMHYVuAV+rI2HxRDUTl7YR7CdNQhD62A5WIfwk6QzkkmpDM/dlgBba/3BXST4fwB/g/EO1TBkG5+RjqWAKCVJA00L6Zd+Z9dc9keA/Yf4hPiurCEwbzTmr0cKDtuFZVT5gjoiBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtJkuucW/tphJc05pGRAMwXWCLdpef0BcHHTROOj3pM=;
 b=jggc6Rk8TKmaOieZFcOdKWHH5KrLBrUifIeRuO25YCxk7Iz0YNSSbZRpRd+k23A5xOAcI8aexeTdBkbSX0owk5NtPDz2gGH6GigcNCHGgdErND/xgibEXwk7d0xUY6yLO2JJcYNJihYNlCOTYqgKuliyP+r8BPhG5PUTwznMGnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 21:02:38 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 21:02:37 +0000
Message-ID: <0a8a28c6-8af1-4a6e-82d8-166356455aa9@amd.com>
Date: Tue, 28 Jul 2026 16:02:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] cpufreq/amd-pstate: Add per-core EPP boost for
 recently-busy CPUs
Content-Language: en-US
To: David Vernet <void@manifault.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>
References: <20260728073150.54964-1-void@manifault.com>
 <20260728073150.54964-4-void@manifault.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260728073150.54964-4-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:610:cc::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1f66f4-66d1-4848-451a-08deeceb8dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	doRy203LJAO1Jv31IpyniRQPwzPNtTF3JiHzzJtu9XsgO8pLFjMHTZFBNMEOfxjaJq1PCPP9Gvc8tZxNmbimYslu/z+Q2rAvBdseGABo6uQomEhol9pIFxp+WOnBx3z6+NA+KJm72D10OxX1s0MGkseIhf94jF9U7JLiDRkk4UVLUofOwtIThNeOfIlokIcxzH7Xt9NRQm7CqSf7IQt9imInTRZCqV+UKbItMCMr85EO7TKRiCeJvO3NUgv63jv7Jst50o8tA6tVqGzTElLciLAkkN8r7TXT7MdWz7bFMXY8T/FHVIhjrZu2URdwXbIAWDU+X3XhCDRmh2Cxw48aqyXc0jqgA6I2LePYlelVTs1UnQxsWnR54LaAo5JiCHsAGlm3xDPsAj5fClbhMWDuqKMCKFf6w1oGldaP1JLGmlY2BPHp84+bI2ep4IG1LEUxwuvNhLPhs4jfCHz4cFV1Lz0PVhs3/URD0P5LiiHnd+/GnmKRwwbaJioWH2/z1Oi31maFrk5NtZLAASQnJUmLhcxUdKNQHjNawWCqtHKMj5b3+87VAMf0cXwbdPWf86XbRh90UbqZQ/l1ecCVeS25RubzH5Zi7LRUhIB0tp0R+uupfE39yutMRK+cGZBDDJkW6QLw0LjYrxjsxY2TU/hn3dm+lmT72iuG/m+DERJ+32Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFVoaVg2Wjc3Nmg0VUhvSnVHencrdHlUZkhqbXhoaGk0OGhWeXdXckUyLzJJ?=
 =?utf-8?B?dDVjb3c3Uk03ZjJaVDRNRzVqSkpnZ3k5dm1DWDFaeTExS3RrUUlMKzBmSVho?=
 =?utf-8?B?MU54R3B6ckJjc1ZVNkMvUDBrYlphbUdnN2hRZFFoMUZKTVVIRlYzaFZtMVVC?=
 =?utf-8?B?cVllQk9IckI3aGt1MzdlTTN0OUpLa081TVFLb0ZPNWh0NHFLWlhRYlZHK2Zv?=
 =?utf-8?B?QWxVQnpnc0U0TThpeUQzMjVlSmVLTDJqZEUydjhyZFJ5bDJkWWN2TlhhRUVx?=
 =?utf-8?B?WEZac3pBUlZaYkhnVlFQQzV4VEhVWlBHaUdVWlR3NkQ2S004a3dNeGFiOTF6?=
 =?utf-8?B?dVJVK1BTd01HSDh0SThzS2YvR1cyRGcwWlQxOUxvTm1tTjlBby9GY09aa0Rw?=
 =?utf-8?B?cHN5em1DTStSNFJ1ZUtpMWJBdGZVamhhNXg1R2taYkhhU0xWNkZtZ3l4T0Nq?=
 =?utf-8?B?UWZoczdueldKaVMrU1ZKVTI3ZkY2aHp5S0cvYnNxdkxJNlZYTHJaSEM3eEJj?=
 =?utf-8?B?TWZNcG4xanRDRVFoR1Q3WVppNnlwS25NUEhEemtTS0diQWtkK1dodjFkeUpk?=
 =?utf-8?B?VFJ0bWtKRnFsY3p4V3lPVFJQaHplZUFUWEkrSXRlbDE2VWxpZmJqUTUzS0pa?=
 =?utf-8?B?ZUMrcTVYTzJRdndrVVY4cHIwNDdva0pZamorZjRCaWxHb1ZYTzJHbjNrL3RE?=
 =?utf-8?B?N0hEd0JHaXY1WFFLRElnK202SnVkUFlGUU1GbHpvWlVIS3lRWGpRaCtVeWhS?=
 =?utf-8?B?and3cEo5eCt6WGVoU05zWjZxOEFDM1JjN3RtYmlycWxzb05tMnlJbEtJM1VN?=
 =?utf-8?B?YVpWOWdkOEp2TmplKzdVQ2lvQllPNXk0Q2U4cXdEQUZDWklBaVlGK0F3UVg3?=
 =?utf-8?B?bjNaZUcveVRmOUpUNTJCZGZmdFE0YWs0ZkVBY0MzcUFmRnlxZlNBZGE2aEZP?=
 =?utf-8?B?L0xxZWpRcGp2NmRWd1NmNW5hVVczZndQeVI2cXdjRmZGQlZ5TWwrSHp4L0RF?=
 =?utf-8?B?VGNLU2RUOWJaemlWS0Y4Ykw2Lysvc1RLMitaMG13RmE4ZzFMZHFhbTN1aEFJ?=
 =?utf-8?B?WjgyMFpQY2dWWXMzRkxjb3V4bEVJMkJxR3FzY1gyMWM4SEppZHowYjJhTnFy?=
 =?utf-8?B?V3hDT3ZLWm1PYjhDelNya0RydW5PdTRoRUtQZElOaG12U2xsTUNvbTF1RFAw?=
 =?utf-8?B?UGFiaXhnb3BUWnJuQlRSK2RUTkJjb2s4SXNJZHhkWnk4YjBvN1ZjdGViSUVZ?=
 =?utf-8?B?ZDJyaEw2Z2dZQU9Ra1I2QWpPdkhPakc0ekhPSmhjd1ZjT2dMWEl3RmcwNW42?=
 =?utf-8?B?QmtrQmxhUFpMTm4yL1F0ek5mcEdiLzVjVyttQkpwZlAxbzVlS01qNVdKV04v?=
 =?utf-8?B?Z1Y1MUpHVUFLcjZtWDU5L0tYQ05BeUc0MEMyU3ZNZ0JRTTBWbmxkaklMTHEx?=
 =?utf-8?B?eEhlOTY2NFNTZVpIdGZRSytWNGtQVnJtVFBYd20xa25rcG1ybXpYamNla2FN?=
 =?utf-8?B?MTdBdGZIOWVnRlB0SExRK01DR1FzQUUvUjNSNityNDV4NDdRUWY5aHQrN3p0?=
 =?utf-8?B?NDJhQ3pMOWZ6NHYxK28vcXBIWVFMb2RvQTZ3eGN4aHZpbFY0U2o0MUdVd3R4?=
 =?utf-8?B?QXQzYWxhQVdjK0FhYm50VzNZcDRsTVBLN0x3OENjb2hDeEtIcjhyUE0xRkpx?=
 =?utf-8?B?RkNxK0hKajRxQWFPYllHUWV3N2FEN083TjFkWTFNcSsrUjA2MFBXL1ZaSUdX?=
 =?utf-8?B?TC9IQ1VZVHl0azdoeklGRVRLVGpFbUJLRFhuamt6dGhqVk9YZXVtUW1xVkFt?=
 =?utf-8?B?cWl3YS9tSXpOS3cxeUtkNWdYakNzUG1PcWd5VldSeVMvRlpMNS9MTlUyY01U?=
 =?utf-8?B?dEtlcVEzY2JUeEZUMDRCSzcyenNXRWtCT3BBVFVLWVFudzQrVGlxV0xmQnFJ?=
 =?utf-8?B?bWMwUFVKRkRPMU1jemZMUVpZYzhHUnBIRlEwUjNWTzNsVTZyTlZRNi8vKzRL?=
 =?utf-8?B?S3kvV2MwRXMreDB0Z1RjWldOS0Q5VGF6U21kNFpzSHM5Mm5ydExMVVFoUjJX?=
 =?utf-8?B?U0NYMTJGOWNuWndKOVlObk00eXFrdFBSdWxBMk80S2Vlbk00OEVwQXpmUlVx?=
 =?utf-8?B?Zk1rNDZibzRCcSt1Tzd5c1ZwekFHbUVHc3NYdWpDZDQ3OFhJNmdPK2haZkty?=
 =?utf-8?B?MTFZM2FlelJnZ2xaVW45OWxlaUlKc1ZjN0IrUnNTSDFHcXlzdGlCMy9mQjZS?=
 =?utf-8?B?S1o1N3dWMCsrbmhjN0ZCUDkxd3hFM09aanA0RUtZVnk0NTRxUnRndzRUVkg3?=
 =?utf-8?B?T1ltd0kwYU1sK2VvL1RzejluN1hwd0hTZUJDZ2p0VUIxTjdyNDBNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1f66f4-66d1-4848-451a-08deeceb8dda
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 21:02:37.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: olA5XNaoTQ5sXddMeWX3bV2sT7QVOOtfzQKQ5pd7Wn1AawysqJ8ezX5umGWAVNBmSjNd2sogbtZyVgY/q9K39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753



On 7/28/26 02:31, David Vernet wrote:
> In active (EPP) mode the platform autonomously picks the operating point
> between min_perf and max_perf, biased by the EPP hint, and the kernel
> only rewrites the CPPC request on policy/limit changes. A workload
> dominated by one mostly-busy thread that takes frequent short sleeps
> (e.g. a game render thread blocking on a futex waiting for the GPU or a
> worker thread on every frame) can defeat the platform's utilization
> tracking. Each sleep decays the hardware's performance signal, so
> post-wakeup bursts start at a low operating point and the frame-time
> tail inflates even though the CPU is ~100% busy during the frame itself.
> 
> This is a common problem in gaming workloads, and is not easy to solve
> at the cpufreq layer. We have to toe the line between running at a high
> voltage unnecessarily and draining battery (and potentially contending
> with e.g. the GPU for power draw), and lowering frequency on the core
> that's running the game's main and/or render threads (thus materially
> increasing frame latency and causing a tail increase in stale frames).

I have to question - is this really a good use for active mode?   You're 
basically fighting with the hardware and trying to game the behavior.

I wonder if for gaming it would be better to enact guided mode and then 
let userspace limit the range that it can act within.

> 
> Unity, for example, has a main thread and a render thread which run
> (mostly) serialized on the frame-rendering pipeline, and Unity games'
> fps typically experience much lower stale frame rates when CPU frequency
> is higher on cores while they're running those threads. On the other
> hand, for e.g. a 60 fps game (a ~16.7 ms frame deadline), the CPU may be
> idle for some portion of that window when the frame completes ahead of
> the deadline. We also have to contend with the fact that leaving the
> core boosted unnecessarily can be actively harmful, even aside from
> battery consumption. For example, keeping a high min_perf floor in place
> even during short idle and vsync waits can regress performance by
> perturbing SMU boost management.
> 
> We thus need a cpufreq solution that boosts a high-priority core as soon
> as it becomes utilized, and then restores the requested policy value
> when the core goes idle. This diff implements a new mechanism called
> "per-core EPP boost", which achieves this by adding an opt-in per-core
> mechanism that temporarily applies the EPP=performance policy to a core
> that stays at least 50% busy over some sampled window.
> 
> The mechanism works as follows: When the epp_boost module parameter is
> enabled, an update-util hook samples each core's C0 residency (delta
> MPERF over delta TSC) at most once every 10 ms. If a sample shows the
> core at least 50% busy, the EPP field of its MSR_AMD_CPPC_REQ is set to
> performance (0) and held there until 300 ms pass without another busy
> sample. The hook then writes back the request that policy management
> last stored in cppc_req_cached. Both writes happen only on the busy and
> idle edges, so the CPPC_REQ write rate matches that of a global
> EPP=performance setting. min, max and desired perf are never touched.
> This mirrors intel_pstate's hwp_boost, except that hwp_boost triggers on
> SCHED_CPUFREQ_IOWAIT, which the waits at issue here (futex waits and
> amdgpu fence waits) do not set, so a residency trigger is used instead.

I understand using epp_boost in the context of a module parameter to 
easily activate this behavior, but I don't think that's the right way 
that it should be triggered because it's going to end up effective for 
the entire boot even when you're not running games that you want to use 
this.

I'd think a sysfs knob would be better to activate it if it's going to 
be dynamic.  But also - dynamic_epp isn't the default behavior.  What if 
you only activate this when dynamic_epp is set?  IE when using dynamic 
EPP you use platform power profile, power charger, and this running 
algorithm.

> 
> Note that this mechanism is only available in active mode on MSR
> (X86_FEATURE_CPPC) systems, as the hook does local MSR accesses from
> scheduler context which the shared memory interface cannot do. It
> composes with dynamic_epp, which selects the policy EPP from the
> platform profile and power source. epp_boost temporarily overrides
> whatever policy EPP is installed and restores it when the core goes
> idle.
> 
> I ran a series of benchmarks on a Steam Deck (Van Gogh APU,
> EPP=balance_performance) which illustrate the patch:
> 
> *Civ VI graphics benchmark (single-thread CPU-bound)*
> 
> Default settings
> ================
> The busy core's median frequency sat at 2.43 GHz despite 98% utilization.
> 
> Global EPP=performance
> ======================
> Globally forcing EPP=performance lifts the median to 3.5 GHz, cuts
> frame-time p999 by ~40% and raises 1%-low fps by ~16%, but does so on
> every core and every workload.
> 
> Raising min_perf to nominal on the busy core
> ============================================
> A variant of this patch that instead raised min_perf to nominal on the
> busy core reached the same 3.5 GHz median yet regressed p999 by 13-21%
> for the reasons described above.
> 
> epp_boost enabled
> =================
> With epp_boost enabled (interleaved A/B tests with 6 iterations, using
> Welch's t-test to arrive at the deltas), the busy core running the Civ VI
> main thread runs at a 3.5 GHz median and the benchmark gains 31.8% in
> 1%-low fps (p=0.014) and 4.1% in frame-time p99 (p=0.015), with p999 and
> average fps unchanged.
> 
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 214 ++++++++++++++++++++++++++++++++++-
>   drivers/cpufreq/amd-pstate.h |  14 +++
>   2 files changed, 224 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 5d7debb5a35c..771a74e04f86 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -27,6 +27,7 @@
>   #include <linux/module.h>
>   #include <linux/init.h>
>   #include <linux/smp.h>
> +#include <linux/cpu.h>
>   #include <linux/sched.h>
>   #include <linux/cpufreq.h>
>   #include <linux/compiler.h>
> @@ -262,6 +263,10 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
>   	if (value == prev)
>   		return 0;
>   
> +	/*
> +	 * Must come before MSR write to ensure amd_pstate_epp_boost_release()
> +	 * doesn't write a stale value.
> +	 */
>   	WRITE_ONCE(cpudata->cppc_req_cached, value);
>   
>   	if (fast_switch) {
> @@ -314,6 +319,7 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
>   	if (value == prev)
>   		return 0;
>   
> +	/* Must update cached value prior to wrmsrq -- see msr_update_perf() */
>   	WRITE_ONCE(cpudata->cppc_req_cached, value);
>   
>   	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> @@ -1877,6 +1883,187 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
>   	return false;
>   }
>   
> +/*
> + * Per-core EPP boost.
> + *
> + * While the epp_boost module parameter is enabled, each CPU in active (EPP)
> + * mode on an MSR (X86_FEATURE_CPPC) system has a cpufreq update-util hook
> + * registered which puts the core in EPP=performance mode when the core is
> + * sufficiently utilized.
> + *
> + * Enables more efficient frequency scaling on cores that have strict latency
> + * requirements, such as e.g. gaming workloads where render threads use a CPU
> + * for some period during frame windows, and then go idle until the next frame.
> + */
> +static bool epp_boost __read_mostly;
> +
> +#define AMD_PSTATE_EPP_BOOST_SAMPLE_NS	(10 * NSEC_PER_MSEC)
> +/*
> + * Busy threshold is deliberately low and the decay window wide so that a
> + * render thread which is only ~50-80% busy (periodic vsync and GPU-fence
> + * waits) holds the boost across its whole busy period at a couple of CPPC_REQ
> + * writes total.
> + */
> +#define AMD_PSTATE_EPP_BOOST_DECAY_NS	(300 * NSEC_PER_MSEC)
> +#define AMD_PSTATE_EPP_BOOST_BUSY_PCT	50
> +
> +static void amd_pstate_epp_boost_apply(struct amd_cpudata *cpudata, u64 cached)
> +{
> +	union perf_cached perf = READ_ONCE(cpudata->perf);
> +
> +	/* never boost a request whose limits are not populated */
> +	if (!perf.max_limit_perf)
> +		return;
> +
> +	cached &= ~AMD_CPPC_EPP_PERF_MASK;
> +	cached |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, AMD_CPPC_EPP_PERFORMANCE);
> +
> +	wrmsrq(MSR_AMD_CPPC_REQ, cached);
> +}
> +
> +static void amd_pstate_epp_boost_release(struct amd_cpudata *cpudata)
> +{
> +	wrmsrq(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
> +}
> +
> +static void amd_pstate_epp_boost_update_util(struct update_util_data *data,
> +					     u64 time, unsigned int flags)
> +{
> +	struct amd_cpudata *cpudata = container_of(data, struct amd_cpudata,
> +						   epp_boost_update_util);
> +	union perf_cached perf;
> +	bool first_sample;
> +	u64 busy_pct;
> +	bool active;
> +
> +	if (smp_processor_id() != cpudata->cpu)
> +		return;
> +
> +	first_sample = !cpudata->epp_boost_last_sample;
> +	if (!first_sample &&
> +	    time - cpudata->epp_boost_last_sample < AMD_PSTATE_EPP_BOOST_SAMPLE_NS)
> +		return;
> +	cpudata->epp_boost_last_sample = time;
> +
> +	/*
> +	 * Counters can reset across suspend or hotplug (so their values would
> +	 * be garbage), so just recalculate baselines.
> +	 */

This comment confused me.  I at first thought you weren't doing it, but 
you are.  Basically on resume you treat it as a fresh startup.  I would 
just drop this comment.

> +	if (amd_pstate_sample(cpudata) && !first_sample) {
> +		busy_pct = div64_u64(cpudata->cur.mperf * 100, cpudata->cur.tsc);
> +		if (busy_pct >= AMD_PSTATE_EPP_BOOST_BUSY_PCT)
> +			cpudata->epp_boost_last_busy = time;
> +	}
> +
> +	perf = READ_ONCE(cpudata->perf);
> +	active = perf.max_limit_perf &&
> +		 (time - cpudata->epp_boost_last_busy < AMD_PSTATE_EPP_BOOST_DECAY_NS);
> +
> +	if (active && !cpudata->epp_boost_active)
> +		amd_pstate_epp_boost_apply(cpudata,
> +					   READ_ONCE(cpudata->cppc_req_cached));
> +	else if (!active && cpudata->epp_boost_active)
> +		amd_pstate_epp_boost_release(cpudata);
> +
> +	cpudata->epp_boost_active = active;
> +}
> +
> +static void amd_pstate_epp_boost_enable(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (!READ_ONCE(epp_boost))
> +		return;
> +
> +	if (cppc_state != AMD_PSTATE_ACTIVE ||
> +	    !cpu_feature_enabled(X86_FEATURE_CPPC))
> +		return;
> +
> +	if (cpudata->epp_boost_registered)
> +		return;
> +
> +	cpudata->epp_boost_last_sample = 0;
> +	cpudata->epp_boost_last_busy = 0;
> +	cpufreq_add_update_util_hook(policy->cpu, &cpudata->epp_boost_update_util,
> +				     amd_pstate_epp_boost_update_util);
> +	cpudata->epp_boost_registered = true;
> +}
> +
> +static void amd_pstate_epp_boost_disable(struct cpufreq_policy *policy)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +
> +	if (cpudata->epp_boost_registered) {
> +		cpufreq_remove_update_util_hook(policy->cpu);
> +		synchronize_rcu();
> +		cpudata->epp_boost_registered = false;
> +	}
> +
> +	if (cpudata->epp_boost_active) {
> +		u64 cached = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, cached);
> +
> +		/*
> +		 * Cross-CPU restore is not ordered against a concurrent
> +		 * limit/EPP writer that doesn't hold the policy rwsem, so
> +		 * recheck the cache once to ensure that the MSR reflects the
> +		 * cached value
> +		 */
> +		if (READ_ONCE(cpudata->cppc_req_cached) != cached)
> +			wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
> +				      READ_ONCE(cpudata->cppc_req_cached));
> +
> +		cpudata->epp_boost_active = false;
> +	}
> +}
> +
> +static int epp_boost_param_set(const char *val, const struct kernel_param *kp)
> +{
> +	unsigned int cpu;
> +	bool enabled;
> +	int ret;
> +
> +	ret = kstrtobool(val, &enabled);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&amd_pstate_driver_lock);
> +
> +	if (epp_boost == enabled)
> +		return 0;
> +
> +	WRITE_ONCE(epp_boost, enabled);
> +
> +	if (!current_pstate_driver)
> +		return 0;
> +
> +	guard(cpus_read_lock)();
> +
> +	for_each_online_cpu(cpu) {
> +		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> +							cpufreq_cpu_get(cpu);
> +
> +		if (!policy)
> +			continue;
> +
> +		if (enabled)
> +			amd_pstate_epp_boost_enable(policy);
> +		else
> +			amd_pstate_epp_boost_disable(policy);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops epp_boost_param_ops = {
> +	.set = epp_boost_param_set,
> +	.get = param_get_bool,
> +};
> +module_param_cb(epp_boost, &epp_boost_param_ops, &epp_boost, 0644);
> +MODULE_PARM_DESC(epp_boost,
> +		 "boost EPP toward performance on recently-busy CPUs (active mode, MSR systems only)");
> +
>   static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   {
>   	struct amd_cpudata *cpudata;
> @@ -1970,6 +2157,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
>   
>   	current_pstate_driver->adjust_perf = NULL;
>   
> +	amd_pstate_epp_boost_enable(policy);
> +
>   	return 0;
>   
>   free_cpudata1:
> @@ -1989,6 +2178,8 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
>   		if (cpudata->dynamic_epp)
>   			amd_pstate_clear_dynamic_epp(policy);
>   
> +		amd_pstate_epp_boost_disable(policy);
> +
>   		/* Reset CPPC_REQ MSR to the BIOS value */
>   		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
>   		amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
> @@ -2057,7 +2248,13 @@ static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
>   		return ret;
>   
>   	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
> -	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
> +	ret = amd_pstate_set_floor_perf(policy, cached_floor_perf);
> +	if (ret)
> +		return ret;
> +
> +	amd_pstate_epp_boost_enable(policy);
> +
> +	return 0;
>   }
>   
>   static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
> @@ -2066,6 +2263,8 @@ static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   	int ret;
>   
> +	amd_pstate_epp_boost_disable(policy);
> +
>   	/*
>   	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>   	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
> @@ -2088,6 +2287,8 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   	int ret;
>   
> +	amd_pstate_epp_boost_disable(policy);
> +
>   	/*
>   	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
>   	 * min_perf value across kexec reboots. If this CPU is just resumed back without kexec,
> @@ -2134,10 +2335,9 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>   	struct amd_cpudata *cpudata = policy->driver_data;
>   	union perf_cached perf = READ_ONCE(cpudata->perf);
>   	u8 cached_floor_perf;
> +	int ret;
>   
>   	if (cpudata->suspended) {
> -		int ret;
> -
>   		/* enable amd pstate from suspend state*/
>   		ret = amd_pstate_epp_update_limit(policy, false);
>   		if (ret)
> @@ -2147,7 +2347,13 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
>   	}
>   
>   	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
> -	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
> +	ret = amd_pstate_set_floor_perf(policy, cached_floor_perf);
> +	if (ret)
> +		return ret;
> +
> +	amd_pstate_epp_boost_enable(policy);
> +
> +	return 0;
>   }
>   
>   static struct cpufreq_driver amd_pstate_driver = {
> diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> index 99532595150e..0408fc331633 100644
> --- a/drivers/cpufreq/amd-pstate.h
> +++ b/drivers/cpufreq/amd-pstate.h
> @@ -10,6 +10,7 @@
>   
>   #include <linux/pm_qos.h>
>   #include <linux/platform_profile.h>
> +#include <linux/sched/cpufreq.h>
>   
>   /*********************************************************************
>    *                        AMD P-state INTERFACE                       *
> @@ -96,6 +97,12 @@ struct amd_aperf_mperf {
>    * @current_profile: Currently selected platform profile option
>    * @ppdev: Device registered with the platform profile handler
>    * @profile_name: Name under which @ppdev is registered
> + * @epp_boost_update_util: update-util hook for the per-core EPP boost
> + * @epp_boost_last_sample: last C0-residency sample time (ns; 0 means the
> + *			   next callback only re-baselines the counters)
> + * @epp_boost_last_busy: last time the CPU sampled as busy (ns)
> + * @epp_boost_active: EPP boost currently applied to MSR_AMD_CPPC_REQ
> + * @epp_boost_registered: update-util hook currently registered
>    *
>    * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
>    * represents all the attributes and goals that AMD P-State requests at runtime.
> @@ -139,6 +146,13 @@ struct amd_cpudata {
>   	enum platform_profile_option current_profile;
>   	struct device *ppdev;
>   	char *profile_name;
> +
> +	/* per-core EPP boost (active mode, MSR systems only) */
> +	struct	update_util_data epp_boost_update_util;
> +	u64	epp_boost_last_sample;
> +	u64	epp_boost_last_busy;
> +	bool	epp_boost_active;
> +	bool	epp_boost_registered;
>   };
>   
>   /*

