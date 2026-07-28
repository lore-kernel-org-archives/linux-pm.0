Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9921A681E;
	Tue, 28 Jul 2026 19:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267834; cv=fail; b=IDookeZ8L42A24FNtl6Uoo2eL5jM+DIlT5AbfHdGuL+wSXpRjoVHV1H4R+Dh7a55U8ISSD26L7Drr+GiJGKQ3JzC3nNklN+k6TCNpy5AJ9ZRdB1I3QPIbttJhjAwpgbPMQE8S3k2mjyn3txr2zhjllRWybH68ve0H53h8EIC7Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267834; c=relaxed/simple;
	bh=1kHQ0qdnSupoxy27OtN+mcdcUL4IVnJHOdX5r6xLGXw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t3Q6yMzsDc9uhxDBHt4OLB0I9og9xqMt98JqQ4jiKpxfG60nsbgGzGZpagHgvMaTGtmVQysSEemPyPDCJ2P0qYroFc+8VOTSpTWPeuErDx+L+c8XAFwUbsSIRtOfQhKiRDWOyI0Cg0HvsfBCa2thq+qAuFYE/k3Zhwfek3SL1QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWTPXTO9; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWTPXTO9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wk3dP+Q1f9WWz8IEdvIj8hQKjQTsOHAH7gHPc6s9VB8ERMi6phyQh47Ayh7V4ab/eNlNxRFRepK0EqU06j5JPTMBrCBcJ9f/MFwUBQc1edoDJgOyh+TzJ5363fz2oI7xb/Nf3lUg5NmBhZNoXUuF49sQYY364bJS9xp0tM4xNbn/hAkunFK729gGoka/HQo9o/60C6KsbTkjIFGW38I3fKhvU7Cc4Sw79K8gjCC/XngyUXVdlB88uNPTmWfnCxz0+hZK6+2i2BZb0+3ZgYxHomEFh11xi34FK43sqxhtYG+3PHhpcS1T1WMWNeSkO0QyvxcEj3myaC5Gn3tUXKQZng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/zKGme/lwRHLKj7VpCrKLs0NCA8Hjf7RUabR/mfIW4=;
 b=E8iVda0MYeA7WneGtadPUSFCiFkC7/Lmkpd7tP6EeSiVSUFn0hFM0TjX68HJC+wbQErmGM1Z8/snQ6sJSmfLcQb2+hOdTDjKI0rUZhoLTWdpS1SjhdFqFY60KhxkCw28lxk2KxtRwFnwAhuKHoeodWXk0L9YQwbrwj1E8oDATMCGrWNB62lkBj79O0/KIIW6MhKxM6+ym46CUEmbaqEneBnlOoldnslMm1cIhLY6hEKaZr6Lw88+4vwskh16RTf4x4pJs5xx9IIGnIPuYJtSbqTks6mMrF5kOQTkm/xncnvHDIq1gmxO0q4KozTaKHxEPLi1ACrIrPaKe/tkf6YFIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/zKGme/lwRHLKj7VpCrKLs0NCA8Hjf7RUabR/mfIW4=;
 b=sWTPXTO9snTNrt0/XqxK1ssJJH0DptWd8CcCj8fM3hDw3lYydRfkPJE4PQ4AKidReImunZKFOqUf+bJmz7kARajEp5VTb0EIKi1uT+fNwZqymx1wg2L/cCz6IHkqELL0drXWLoe9TQnITcGDHC1HjDTg0mHaAGkyk9w27pq5QrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 19:43:49 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 19:43:49 +0000
Message-ID: <40ab4c65-faf5-4a85-8761-bc6ebd1aec90@amd.com>
Date: Tue, 28 Jul 2026 14:43:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
Content-Language: en-US
To: David Vernet <void@manifault.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 K Prateek Nayak <KPrateek.Nayak@amd.com>
References: <20260728073150.54964-1-void@manifault.com>
 <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:610:4f::15) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 14df185f-0f50-4ceb-b422-08deece08bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|10067099003|11063799006|5023799004|6133799003|56012099006|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ep1EbUcIxA5htmrTNnUkbfdWyLasIqR8hg1QopnowN9tU/WhxrRHToE+QQAvtKYOLj4VY0cNEAskjlvEBeot8ivkN/JhLaW08U8NYJWgDmHpCVW23mCjOnfIhREw6P9ZQE2by1G3tWKF3Vruox8RHZKRLarI2WGOygDwPg0bGYO5el4Kr/nT0KB3RDAGjwabChecb4sTkKe69EcSSIWAiA18ZpibT01e7yXtjwonQGvEo6fkYEMFcjrPnYi11V945kVLkYXdSwpKBRLMVNR7X3au8bhhr6tEccz06NaQR5gx1xYxypTc4opn9ZGeVqetOJ70Ta4u/NFNhqKqNPQ66vo7wUFTWqLuM16KinYeIAB5v30KLrJ82Gsy/G017Hvy480j/EJ8f8wLooHUmqIlPBnxnO4zvG+qLNJ87idXkUFE0B8RV+z64+LfiZkHmHD8rqcz7RF6eB727j9M/WzvGrQTaMzaSwscIguh82ckxslVMNs55RwL5TBJ8YePdJB4wUpzn639E5YstuuPgh+dNLQmNgtfqah8IBccaDCakDdZzlJTmPGhT8rnR5DG8H4dsMNMu5+vZhvhcmHANAhqgAAegKUVaj4aXvPqFz69Jps9h92tZAdw2gHZflSOL1QYkX/u8R1jCjYXW5WBTiqhMcD7eykuimKH2i2UY8RwARQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(10067099003)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UThBcU05UHRKUTAxckxvdVN6NGJOYnljanJHQWFXYTRWWHN3N293SlpIaDdw?=
 =?utf-8?B?cCtwb2FpbHpoK2FESlRsQVUyL1NDbEpSVW9xODgwdzdUbk8wd2h5bGx5elY2?=
 =?utf-8?B?NFVkYzF1dmpYM0t1WGNpQ29FYktNaEpEbzN2KzZIS3FOcjJENDd3Z05rMSsx?=
 =?utf-8?B?amNlK2tNb0FNejREbVZLbGJLd2pNaWlmMTR5bnBhVUtYS0JOVC9ML2J5SmU0?=
 =?utf-8?B?RWtUWFoyaWFGL1ZFa3NYOG9GN2xnVzVadVB4aFA5RkN2UXlpTmtiUUliM0h6?=
 =?utf-8?B?UDdvSkxSUnhMbytOcmNPaVdtL0kzeEhpSmdPTGlpQmhIOWgvK2lhQ2VoOFZW?=
 =?utf-8?B?bnlwYXd4SDZaK2ltTXFRMmFvMjdnS0pEbGFNeGwvRHdFaVd6VDJzQ2g2eXJE?=
 =?utf-8?B?M0R6bnRSUGNTVkJ3Z28xdWMzbWNrb3BsdjhId0VYOS9IdnZCTlFxcVkzcXJK?=
 =?utf-8?B?Y09LNnA0S3I2Mzh4YnU2N3ZTNXhHUW5IbHNXQTV2UG9zWFhUbm5IeExwMHBU?=
 =?utf-8?B?Um0ybjkzTXdzMjRyTGdKQmVnaWNzZEZ2a3lkSkdleGorcXRTOWJqWXZxRVBH?=
 =?utf-8?B?QVB5aEpPREZNMElqd00vVFYxUS9oTXVjWXFSQU5wUitwdytrT09mU1pPSlRn?=
 =?utf-8?B?akRyVUZzcEVoTFVFYkxGQ2pRTTBPcXpxUjhNdmNSeFJhTW5wWG1PSTFYT21s?=
 =?utf-8?B?dWl2VEhDQ05mZ2ppb25xNjRndzRxNE1lVi95dWRpV1BjNlI1Y0lRL3JJbzBN?=
 =?utf-8?B?Q1o3RlhjUERyZ2RPdm1uOHNYWlFYU3F2c1dpR2NiWEpkQnBEb09JUjJiQlpY?=
 =?utf-8?B?ZXI4cmdOYUh0bGxKYlV4VmJxUjNmRTJKVThYaU5OZ211akJQOVo3UW5SMmw5?=
 =?utf-8?B?Um8rNVBuYmIwYkYwN0d5TGpnUlJCdlAyb3dTeGs1N0FaM1c2YllqdkVXOW5W?=
 =?utf-8?B?cjF6ZDR2MFJWd1NZZlFncWFMZ1NHdWc2ZHprTjZjT2VsNE9YTUI2OHBxcXFO?=
 =?utf-8?B?VlNjZjVlekxTSTc3TFA4UE1TNjhpdVpWVWtvbHdHcTVxcnBPSmRGSXpKQlZW?=
 =?utf-8?B?Um1PMGx4eHEweFdxMVA0Qk1TcWpoTFZGbVd4WUJ3dkhnbjhYYW5ObEZwTUhi?=
 =?utf-8?B?RS9GK3daU2Q1ZFRpS3pXVTRNUlI1cDFBaGtjK3R0M2tvWnFBK3d5ZGRab004?=
 =?utf-8?B?Qi85Um9VaE9CTmJpZCtpVTNNdHplTXNCNHZQRDJHZXRsZ1FIT3dQUGhRcFFp?=
 =?utf-8?B?YjZmTEhrT01mWncvemllVG4zWUdtK05SVUJRZHFIRE1EM1Bad0pzQ2V6VDk1?=
 =?utf-8?B?a3lIc1I1L3RQbG5VZEtXdVA2K3ZiTS9mVnBCRGUxamJuMDRmSExXMVFqQkpH?=
 =?utf-8?B?eXE0N3QvMldMaGNQTE1EWjlBRkNScUljb0Nwdi8wNFBhays2NmJkS2FvNHhZ?=
 =?utf-8?B?dGJ0ZnNWZStnUEJXVzlqQ3UraVFtRTdqUkRkaWZEMUJwVHdUSVBXVGxJVWo4?=
 =?utf-8?B?bi9FMmROK2hrdDl6ckg4UGU5ak02MVgrU1JHZ2pxN1Rsc3Jtd3d6cVNFeG5y?=
 =?utf-8?B?TUxRRmxKV3pMR3NmWHhGbVhFTDNyZ0ExRnhkME5QM3hUQndOMTJlWEZFM2xI?=
 =?utf-8?B?eTZhdHpoT01MeExtZFdRQ09CcFpFcVpuZ0pDZS9aOXVsSVVxWk5JZDFpSHZk?=
 =?utf-8?B?Q3poQnJYRWxjQ2JwSXh6Tkl2YVZ1UHhZTVZPTTlYWU5jckViTWlpOFpKdW9E?=
 =?utf-8?B?bUpYOW5CWThmUjQra3l3N2xYM3NEMjJtSklQQ3NpT09RamZ3WGxoREk1cHlq?=
 =?utf-8?B?WUJuY0tHMXdOQU15bW5kSndGVy9IRGZ0cDB6RVpJQmhDM3JnUlNRanRScHlt?=
 =?utf-8?B?bGNYY2pLeno0QUhBU054SFJMK3hsb3RVeWlFN2hucVJiQlYrdW1KdTlPbDAw?=
 =?utf-8?B?anlUeEhtajg4Uis1L1pEb1llVWJ3UHBjRVdvY2RlT2JwbEt4UWRlV3pDSHBx?=
 =?utf-8?B?d1lqUWw2ejRKN1EwU1E1M2FJcUozOC9semNRMnMvT0Y4M0p6dHh5aFk4Q2wr?=
 =?utf-8?B?NXVJeTVxVlo2TDM4NGdUZlIzQlUxdW1vWThCenhCUFVUTFBrU1FMTGNIOHpP?=
 =?utf-8?B?enM3MUlVZ09tREx0dHZtTVIrMGRHQXhXb3huaGM3V1VEQk84M0VMUUhUNlZo?=
 =?utf-8?B?QXJRWlhTTk5FSVNDaGtKUWo3TlNrRTBlZkh1bElLN3NUbE1LeFBhUG1KbWV6?=
 =?utf-8?B?QzdIVUV1Y1UvSjEyODd1d2s2N2lJQVVHelp6Rk9pUVN5WEtmYWtTeTFnS3pk?=
 =?utf-8?B?REtWSk8wNWU0OFVnbjUxejdCTWR6aDFnYnVqWlg2WnVuSk9YbG0yQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14df185f-0f50-4ceb-b422-08deece08bb2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 19:43:49.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+QKZ58A0JAbjhicyxuPuureWJErCCa7uhx2r2zkcw+Z7Hbi+GYcFuKhixUsaoMi5P41G2KO4o6xOAuPZI+B/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

+Prateek

On 7/28/26 09:17, Christian Loehle wrote:
> On 7/28/26 08:31, David Vernet wrote:
>> In active (EPP) mode the platform autonomously picks the operating point
>> between min_perf and max_perf, biased by the EPP hint, and the kernel
>> only rewrites the CPPC request on policy or limit changes. A workload
>> dominated by one mostly-busy thread that takes frequent short sleeps
>> (common in gaming workloads, for example) can fare poorly under this
>> strategy. Each sleep decays the hardware's performance signal, causing
>> post-wakeup bursts to start at a low operating point and inflating tail
>> latency even though the CPU is essentially fully busy while work is
>> available.
>>
>> As mentioned above, the motivating case here is gaming. A game's main or
>> render thread typically blocks briefly on a futex or a GPU fence every
>> frame, and the resulting frequency droop shows up directly as stale
>> frames and inflated frame-time percentiles.
>>
>> Solving this at the cpufreq layer requires walking a fairly narrow
>> path. Globally forcing EPP=performance fixes the tail but burns power
>> on every core for every workload, which matters on handhelds where the
>> CPU and GPU share a power budget. Raising min_perf on the busy core
>> seems like the obvious surgical fix, but it pins the core at or above
>> nominal even during micro-idle and vsync waits. On Van Gogh (Steam
>> Deck) experiments that I ran, that perturbs the SMU's shared CPU/GPU
>> boost management enough to regress the frame-time tail relative to doing
>> nothing (numbers below).
>>
>> This series instead adds an opt-in, per-core EPP boost. When the
>> epp_boost module parameter is enabled, an update-util hook samples each
>> core's C0 residency (delta MPERF over delta TSC) at most once every
>> 10 ms. If a sample shows the core at least 50% busy, the EPP field of
>> its MSR_AMD_CPPC_REQ is set to performance (0) and held there until
>> 300 ms pass without another busy sample, at which point the hook
>> restores the request that policy management last stored in
>> cppc_req_cached. Both writes happen only on the busy and idle edges, so
>> the CPPC_REQ write rate matches that of a global EPP=performance
>> setting. min, max and desired perf are never touched. The mechanism is
>> only available in active mode on MSR (X86_FEATURE_CPPC) systems, since
>> the hook does local MSR accesses from scheduler context which the
>> shared memory interface cannot do. It composes with dynamic_epp, which
>> selects the policy EPP from the platform profile and power source.
>> epp_boost temporarily overrides whatever policy EPP is installed and
>> restores it when the core goes idle.

Have you seen the series from Prateek that reworks how dynamic EPP works 
[1]?  It becomes an energy_performance_preference that userspace can opt 
into.

I did have aspirations to hook into more changes than just platform 
profile and power source eventually, so it sounds like we're at least 
thinking in the same area.

[1] 
https://lore.kernel.org/linux-pm/20260727072056.1248-1-kprateek.nayak@amd.com/

Can you rework your series on top of that and see how the mechanics work 
out?

>>
>> Precedents
>> ==========
>>
>> The closest precedent is intel_pstate's hwp_boost. It has the same
>> overall shape as this feature. It is an opt-in update-util hook that
>> temporarily rewrites the HWP request from scheduler context on a boost
>> edge and restores the unboosted request after a hardcoded hold time
>> (hwp_boost_hold_time_ns). It differs in two ways, both deliberate:
>>
>> 1. Trigger. hwp_boost activates on SCHED_CPUFREQ_IOWAIT. The waits
>>     that matter here are futex waits and amdgpu fence waits, which do
>>     not set the iowait flag, so a C0 residency trigger is used instead.
>>     Residency also naturally covers the "mostly busy with short gaps"
>>     pattern rather than only the wakeup instant.
>>
>> 2. Knob being boosted. hwp_boost raises the HWP min. As described
>>     above, a min_perf floor measurably regressed the tail on Van Gogh,
>>     so this feature biases only the EPP hint and leaves the platform
>>     free to drop the operating point during the idle portions of the
>>     frame.
>>
>> On the thresholds themselves, the sample period, busy threshold and
>> decay window are hardcoded rather than exposed as tunables. I'm not sure
>> if this is appropriate or not, but it seemed like it followed existing
>> contours.
>>
>> hwp_boost_hold_time_ns for example is a hardcoded 3 ms, and schedutil's
>> iowait boost decay is tied to TICK_NSEC, with no knobs for either. The
>> 300 ms decay is sized so that a render thread which is only 50-80% busy
>> from periodic vsync and GPU-fence waits holds the boost across its whole
>> busy period at a couple of CPPC_REQ writes total, while an idle core
>> sheds the boost well before it can matter. The energy exposure of a wide
>> window is small because EPP only influences behavior in C0 and an idle
>> core sits in CC6 regardless. If folks want me to make these tunable I am
>> happy to expose them.

In a lot of ways I feel like you're fighting with the hardware (and 
active mode) by doing it this way.  Did you look into using passive or 
guided mode instead?  They might be better suited for what you're trying 
to do.

>>
>> Testing methodology
>> ===================
>>
>> All numbers are from a Steam Deck LCD (Van Gogh APU) running in active
>> mode at EPP=balance_performance, using the Civilization VI graphics
>> benchmark as a single-thread CPU-bound workload with a repeatable
>> built-in benchmark pass.
>>
>> Comparisons were run as interleaved A/B tests with 6 iterations per
>> configuration. For each run I collected per-frame frame times and the
>> busy core's frequency, and derived average fps, 1%-low fps and the p99
>> and p999 frame-time percentiles. Deltas were evaluated with Welch's
>> t-test, and I report the p-values alongside the deltas below.
>>
>> Results:
>>
>> Default settings
>> ----------------
>> The busy core's median frequency sat at 2.43 GHz despite 98%
>> utilization, which is the frequency droop described above.
> 
> Two things to confirm for my understanding:
> -Median frequency is the 50th percentile when weighing the OPPs by
> residency, right?
> - You're also using busy_pct = delta_MPERF * 100 / delta_TSC as
> utilization, right? (Not util_avg or anything like that)
> 
> Your observation looks like a firmware or SMU issue.
> Can we confirm the (short) sleeps reset the demand-estimation, i.e.
> by tracing cpu_idle/sched_switch and sample APERF/MPERF alongside it?
> Also rt-app might be helpful to get a feel of how this behaves (and
> create a similar pathological case like the single-threaded game).
> 
>>
>> Global EPP=performance
>> ----------------------
>> Globally forcing EPP=performance lifts the median to 3.5 GHz, cuts
>> frame-time p999 by ~40% and raises 1%-low fps by ~16%, but does so on
>> every core and for every workload.
>>
>> Raising min_perf to nominal on the busy core
>> --------------------------------------------
>> A variant of this patch that instead raised min_perf to nominal on the
>> busy core reached the same 3.5 GHz median yet regressed p999 by 13-21%
>> by perturbing the SMU boost management as described above.
>>
>> epp_boost enabled
>> -----------------
>> With epp_boost enabled, the busy core running the Civ VI main thread
>> runs at a 3.5 GHz median and the benchmark gains 31.8% in 1%-low fps
>> (p=0.014) and 4.1% in frame-time p99 (p=0.015), with p999 and average
>> fps unchanged.
>>
>> David Vernet (4):
>>    cpufreq/amd-pstate: Document missing kernel-doc members
>>    cpufreq/amd-pstate: Update cppc_req_cached before writing the MSR
>>    cpufreq/amd-pstate: Add per-core EPP boost for recently-busy CPUs
>>    Documentation: amd-pstate: Document the epp_boost parameter
>>
>>   Documentation/admin-guide/pm/amd-pstate.rst |  16 ++
>>   drivers/cpufreq/amd-pstate.c                | 230 ++++++++++++++++++++++++++--
>>   drivers/cpufreq/amd-pstate.h                |  20 +++
>>   3 files changed, 255 insertions(+), 11 deletions(-)
>>
>>
>> base-commit: 92bf086d086f7cfe0d6f807dfd6b8d11bc61b626
> 

