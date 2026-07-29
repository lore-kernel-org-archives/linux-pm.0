Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F072623;
	Wed, 29 Jul 2026 03:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294777; cv=fail; b=kcVtqVfMI4Wk0eFTszN0WGrJMRa1hSvvd4COq27Hh8m5lauOJDqf5w46LzlS8Rzf/bJ64haBeczIFtgWJ+JWCuXOliji+UlDRDf08vr91wAh8YnBNS4bVBXhAgevOPzP7VIjt3vf6YQPZvYKFRckfk1m3H3FCDvxkc/NZFpj/H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294777; c=relaxed/simple;
	bh=jW4t7MwJo0cc1ygoywg2K9VEYm3DC5iZjbzbABfFuL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QDk88QEk6HD6TWXvBZzz707lIYiGdkcAMs3L0Iet5eHctfVnuk/AjHS0rVI7reOcI27QDixygl1tamBq5B/1cYNtzUmrH/NRLUsr3MH+NAmNx0lcUF61J1qxG2mRG5xzLd00ZxmqOELN3OXe693p1V5m0G+p7rMXn0nOWW64rh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0INXh9QQ; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0INXh9QQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROS1C4E9GpvQnXVXdtc3VYPRY56ogg4VF++/o2a2/zKT/sNiB0zWUYwn5wowCcaF7WC5rcEi52dOgxR1R5cZmnT0qVbItPmca3eAgw654ngsKnx2UZLS4reM9AGF1T6o9PQK3jF5+N53lQwU2bwI92yOZ7nq8L3Bj/LP5UbopA3ZczFqO5xCi7f7Ur/uaowKcxz8GUp/60K4y+kAJvwc2u1/epeSIY32tJjgk3zLrRL7bRdT3TMHYsE80EfYmFUce1jsLxpVyR9/21YeJnbrNgEhXcC6UJ+veZxRBYSf8mjcmPQAMjfkrLqACTe+BAHHtv+/5+gt0CpB+Xz5mUe0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAx1WcK4zQfj9RVxIchbqv1IZ16STiiNm9jWO6iU7bo=;
 b=MP0dX/6JQKVo3QTRZDEDMvgZDqKXgxY+4R2qcYjr4B9hLYVIpwxhvGrNR7dSwi2zY11G793CE2pVoJbUNE/q9JveuL+yBvyWVrhhh+QnVf+hkTc9/owZc5Ah32fFXUvHy2U57g/710yV35b/sTBErdsa0sLt3lr40u5DwYCHTwYoxy5WaB787z84n0dhQoW8pemCjVk8vH33lDC4ZaVu9/7+pmwHt0GGWOBdhKkg40hIdK6TJ+oUcN/z3inQ9xWKWaHHiRBhPfq34v0a6Kav7WJ/Jdm5yko7h72xfH0Iu4aG4RqXGJrzgmSAvsEylhpDDQAmvCnlKhM9+kcv35OyRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=manifault.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAx1WcK4zQfj9RVxIchbqv1IZ16STiiNm9jWO6iU7bo=;
 b=0INXh9QQmQmiLJRTkZBSyaK4T+N2OrCXHebX5PBJfShUMy1/gj6gnkh95grrzvVlyKLEb+vP9lN6V26+vQZ0V+6JhkCa8L9SlAz6ihuBIPC49P+ru0O3rz83e7w+Krl7hc1BQOSTOcLCG3iNNEt8DzifqGHzihl0QEe+SP7ZQVc=
Received: from DS7PR03CA0105.namprd03.prod.outlook.com (2603:10b6:5:3b7::20)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 03:12:50 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:3b7:cafe::31) by DS7PR03CA0105.outlook.office365.com
 (2603:10b6:5:3b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 03:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 03:12:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 22:12:49 -0500
Received: from [10.136.36.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 28 Jul 2026 22:12:46 -0500
Message-ID: <528d4cef-3c79-4b84-a99a-5566f246a4dc@amd.com>
Date: Wed, 29 Jul 2026 08:42:45 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
To: Mario Limonciello <mario.limonciello@amd.com>, David Vernet
	<void@manifault.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, Changwoo Min
	<changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>
References: <20260728073150.54964-1-void@manifault.com>
 <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
 <40ab4c65-faf5-4a85-8761-bc6ebd1aec90@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <40ab4c65-faf5-4a85-8761-bc6ebd1aec90@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: a347dbc3-e9d1-454a-c488-08deed1f45b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|13003099007|6133799003|56012099006|10067099003|11063799006|5023799004|4143699003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gqwt8yCPY0TVSMj1JROsVsadqXKxRJTlgVy8QVx5RHBm3YsgRjylAXtYnLpoM7z2xonsZ07/Q8iKg6dw7mMIOPsSNoMd9Kivvt+sv8fc68EX9fmEYnPC6z7TWLbYvKA68vqQ/zCmr6FH/uQeiQcbsl4J1rDooXoQ7NLr086v38LDSp3dF79tzly/JDiVMDfK2IDvXjYt/KgKjMAomLKWnkG1vXtQjgnrPNExVc3ols8QhTaOKcvXLftCSahhcWDVR+DCAsddiBK0i/6C/HSkHamx16SKog3m21eri3zsrk/q1g3yAsNeX7EfKeBxUNmMxqw2OIfkEg9LzY4+j3HGS1OHgKyTQvkZZ8fwLZfWcLqwraaVxoXATjgbQWSypCD9MWBHf1p7m/HSBlPjLeq4yDspDX4J9J7c3xDiJAakWXlLS45Lys8Yj1Ji4CDLdZDeAiyeuXC2cYJwIfJoWSq19bZJqzURDJyh9oCTGR0RUEtmTh/uMXo+6sjsPd7AlaIJK+Mx8DfuCio24D6WktMW0KXrqx5ULNpSQY0Qdonx0YHyaGOMKm0N3IH+3jMg8nTEpzLoZK3n+/yKq4kWpdzsRiHbsKilxP62xGbcoDk9EBvjGI+xYuWvN7wwq1dmYUQE1OIU3EP9+LhWIikqAsu6coLQITdrOrjMvYSLnUjp7/kjVeS427WutSbToa39/D+IDEBendlB9xOU8QfgY+GVuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(4143699003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EJE//rUNSK8hXqkJHb+M2s/mw2TXCFLFajMs5cxvcfIYQEfDWpjcGUSL16OcazgDMcK5QQLB6lJiORBopWf3EylZKpDSq+QzC48+nAIhPo7VlE74d40aLu8OpFdzFvUyfXEhy8/e+QTa9RDsdkCpwp5z7fh5OWxktF5elyFtxwz76jnMKSyuX0nkuPrOUjX0ryQN3ilyIa5Fvu+889Je1m03fW6irN+hCUXcQK0PhHBLT7QBGGSsCExonrC5ZOjA3XGTq4nQnEZroxnP5UUNvD+h0yuG1LceFikfvrJJ9ntNCSxbUcNwEl9UP1rn9Qr9RUXeabfSyQvzinFxkjBlOEOddVr8aPyOe4OuImyWFXrZ9pUjNi8VNjNtnCEJB4ssoDchI9INtKjnJfWgVOfa8aoS3Q8s1UDhYut8GrxagBDe9ZODls8v12al3OMGGXfl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 03:12:50.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a347dbc3-e9d1-454a-c488-08deed1f45b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

Hello David, Mario,

On 7/29/2026 1:13 AM, Mario Limonciello wrote:
> +Prateek
> 
> On 7/28/26 09:17, Christian Loehle wrote:
>> On 7/28/26 08:31, David Vernet wrote:
>>> In active (EPP) mode the platform autonomously picks the operating point
>>> between min_perf and max_perf, biased by the EPP hint, and the kernel
>>> only rewrites the CPPC request on policy or limit changes. A workload
>>> dominated by one mostly-busy thread that takes frequent short sleeps
>>> (common in gaming workloads, for example) can fare poorly under this
>>> strategy. Each sleep decays the hardware's performance signal, causing
>>> post-wakeup bursts to start at a low operating point and inflating tail
>>> latency even though the CPU is essentially fully busy while work is
>>> available.
>>>
>>> As mentioned above, the motivating case here is gaming. A game's main or
>>> render thread typically blocks briefly on a futex or a GPU fence every
>>> frame, and the resulting frequency droop shows up directly as stale
>>> frames and inflated frame-time percentiles.
>>>
>>> Solving this at the cpufreq layer requires walking a fairly narrow
>>> path. Globally forcing EPP=performance fixes the tail but burns power
>>> on every core for every workload, which matters on handhelds where the
>>> CPU and GPU share a power budget. Raising min_perf on the busy core
>>> seems like the obvious surgical fix, but it pins the core at or above
>>> nominal even during micro-idle and vsync waits. On Van Gogh (Steam
>>> Deck) experiments that I ran, that perturbs the SMU's shared CPU/GPU
>>> boost management enough to regress the frame-time tail relative to doing
>>> nothing (numbers below).
>>>
>>> This series instead adds an opt-in, per-core EPP boost. When the
>>> epp_boost module parameter is enabled, an update-util hook samples each
>>> core's C0 residency (delta MPERF over delta TSC) at most once every
>>> 10 ms. If a sample shows the core at least 50% busy, the EPP field of
>>> its MSR_AMD_CPPC_REQ is set to performance (0) and held there until
>>> 300 ms pass without another busy sample, at which point the hook
>>> restores the request that policy management last stored in
>>> cppc_req_cached. Both writes happen only on the busy and idle edges, so
>>> the CPPC_REQ write rate matches that of a global EPP=performance
>>> setting. min, max and desired perf are never touched. The mechanism is
>>> only available in active mode on MSR (X86_FEATURE_CPPC) systems, since
>>> the hook does local MSR accesses from scheduler context which the
>>> shared memory interface cannot do. It composes with dynamic_epp, which
>>> selects the policy EPP from the platform profile and power source.
>>> epp_boost temporarily overrides whatever policy EPP is installed and
>>> restores it when the core goes idle.

I would also like to know Rafael's thoughts on kernel modifying the
EPP to something other than what user has programmed.

There are a ton of userspace tools that have currently profiled a bunch
of systems and use the EPP interface to program a good default and their
expectations may diverge if kernel starts modifying EPP underneath them.

This almost feels like putting the ondemand governor into the driver.
Perhaps, the active mode drivers can be made to support the dynamic
governors as opposed to just the static ones? that fits the overall
cpufreq subsystem better but I'll wait on Rafael's thoughts on that.

> 
> Have you seen the series from Prateek that reworks how dynamic EPP
> works [1]?  It becomes an energy_performance_preference that userspace
> can opt into.

I feel like that will come short of the expectations here because we
would like to do this per-CPU based on utilization metrics as opposed
to system profile / power status both of which are global and can lead
to faster battery drain.

> 
> I did have aspirations to hook into more changes than just platform
> profile and power source eventually, so it sounds like we're at least
> thinking in the same area.

Ack! We'll at least need more input to the dynamic mode to cater to
this specific case but it is going into the governor territory at that
point if we want to use CPU specific signals.

> 
> [1] https://lore.kernel.org/linux-pm/20260727072056.1248-1-kprateek.nayak@amd.com/
> 
> Can you rework your series on top of that and see how the mechanics work out?
> 
>>>
>>> Precedents
>>> ==========
>>>
>>> The closest precedent is intel_pstate's hwp_boost. It has the same
>>> overall shape as this feature. It is an opt-in update-util hook that
>>> temporarily rewrites the HWP request from scheduler context on a boost
>>> edge and restores the unboosted request after a hardcoded hold time
>>> (hwp_boost_hold_time_ns). It differs in two ways, both deliberate:
>>>
>>> 1. Trigger. hwp_boost activates on SCHED_CPUFREQ_IOWAIT. The waits
>>>     that matter here are futex waits and amdgpu fence waits, which do
>>>     not set the iowait flag, so a C0 residency trigger is used instead.
>>>     Residency also naturally covers the "mostly busy with short gaps"
>>>     pattern rather than only the wakeup instant.
>>>
>>> 2. Knob being boosted. hwp_boost raises the HWP min.

I think that is why it is acceptable to be used with FW based scaling
as it leaves the user programmed EPP alone.

>>>                                                       As described
>>>     above, a min_perf floor measurably regressed the tail on Van Gogh,
>>>     so this feature biases only the EPP hint and leaves the platform
>>>     free to drop the operating point during the idle portions of the
>>>     frame.
>>>
>>> On the thresholds themselves, the sample period, busy threshold and
>>> decay window are hardcoded rather than exposed as tunables. I'm not sure
>>> if this is appropriate or not, but it seemed like it followed existing
>>> contours.
>>>
>>> hwp_boost_hold_time_ns for example is a hardcoded 3 ms, and schedutil's
>>> iowait boost decay is tied to TICK_NSEC, with no knobs for either. The
>>> 300 ms decay is sized so that a render thread which is only 50-80% busy
>>> from periodic vsync and GPU-fence waits holds the boost across its whole
>>> busy period at a couple of CPPC_REQ writes total, while an idle core
>>> sheds the boost well before it can matter. The energy exposure of a wide
>>> window is small because EPP only influences behavior in C0 and an idle
>>> core sits in CC6 regardless. If folks want me to make these tunable I am
>>> happy to expose them.
> 
> In a lot of ways I feel like you're fighting with the hardware (and
> active mode) by doing it this way.  Did you look into using passive
> or guided mode instead?  They might be better suited for what you're
> trying to do.

Ack! Seems like UCLAMP_MIN + natural accumulation of PELT signals when
running with passive mode + schedutil can achieve the desired results
here but ...

> 
>>>
>>> Testing methodology
>>> ===================
>>>
>>> All numbers are from a Steam Deck LCD (Van Gogh APU) running in active
>>> mode at EPP=balance_performance, using the Civilization VI graphics
>>> benchmark as a single-thread CPU-bound workload with a repeatable
>>> built-in benchmark pass.
>>>
>>> Comparisons were run as interleaved A/B tests with 6 iterations per
>>> configuration. For each run I collected per-frame frame times and the
>>> busy core's frequency, and derived average fps, 1%-low fps and the p99
>>> and p999 frame-time percentiles. Deltas were evaluated with Welch's
>>> t-test, and I report the p-values alongside the deltas below.
>>>
>>> Results:
>>>
>>> Default settings
>>> ----------------
>>> The busy core's median frequency sat at 2.43 GHz despite 98%
>>> utilization, which is the frequency droop described above.
>>
>> Two things to confirm for my understanding:
>> -Median frequency is the 50th percentile when weighing the OPPs by
>> residency, right?
>> - You're also using busy_pct = delta_MPERF * 100 / delta_TSC as
>> utilization, right? (Not util_avg or anything like that)
>>
>> Your observation looks like a firmware or SMU issue.
>> Can we confirm the (short) sleeps reset the demand-estimation, i.e.
>> by tracing cpu_idle/sched_switch and sample APERF/MPERF alongside it?
>> Also rt-app might be helpful to get a feel of how this behaves (and
>> create a similar pathological case like the single-threaded game).
>>
>>>
>>> Global EPP=performance
>>> ----------------------
>>> Globally forcing EPP=performance lifts the median to 3.5 GHz, cuts
>>> frame-time p999 by ~40% and raises 1%-low fps by ~16%, but does so on
>>> every core and for every workload.
>>>
>>> Raising min_perf to nominal on the busy core
>>> --------------------------------------------
>>> A variant of this patch that instead raised min_perf to nominal on the
>>> busy core reached the same 3.5 GHz median yet regressed p999 by 13-21%
>>> by perturbing the SMU boost management as described above.

... this is interesting. Isn't Steam Deck a Zen2 machine? Does that
have the MSR interface for CPPC?

Also when you say you set min_perf on a busy_core, do you restore it
back on the idle path?

I'm assuming what happens with min_perf method is that SMU is more
aggressive at delivering nominal_perf and beyond, compared to the EPP
performance route which perhaps starts off lower but has a steeper
rampup curve compared to EPP balanced.

Could you get some turbostat traces for both case with Civ VI to see
how the frequency scaling behaves with the EPP route vs min_perf
method?

I'll try to compare your method vs min_perf = nominal_perf method on
my Zen3 laptop over the coming weekend to see if I'm able to repro
this SMU behavior.

>>>
>>> epp_boost enabled
>>> -----------------
>>> With epp_boost enabled, the busy core running the Civ VI main thread
>>> runs at a 3.5 GHz median and the benchmark gains 31.8% in 1%-low fps
>>> (p=0.014) and 4.1% in frame-time p99 (p=0.015), with p999 and average
>>> fps unchanged.
>>>
>>> David Vernet (4):
>>>    cpufreq/amd-pstate: Document missing kernel-doc members
>>>    cpufreq/amd-pstate: Update cppc_req_cached before writing the MSR
>>>    cpufreq/amd-pstate: Add per-core EPP boost for recently-busy CPUs
>>>    Documentation: amd-pstate: Document the epp_boost parameter
>>>
>>>   Documentation/admin-guide/pm/amd-pstate.rst |  16 ++
>>>   drivers/cpufreq/amd-pstate.c                | 230 ++++++++++++++++++++++++++--
>>>   drivers/cpufreq/amd-pstate.h                |  20 +++
>>>   3 files changed, 255 insertions(+), 11 deletions(-)
>>>
>>>
>>> base-commit: 92bf086d086f7cfe0d6f807dfd6b8d11bc61b626
>>
> 

-- 
Thanks and Regards,
Prateek

