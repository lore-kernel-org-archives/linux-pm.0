Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D9448B8D;
	Tue, 28 Jul 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248278; cv=none; b=JbtSgdML8uQcPzoZj2BuNI3DgpNwZEPy4Cu9R8A9zYVPrdevDRorDcDDODUIDKfQJwDLGiEyX+BG6hPmrNCgrl8ZLUc0ALlnc1H+PY3GFFl20JZszXw5isySS157991FNHofr0gxukmSbezAE7C4HCLUZllIbxxobPFq8S2FX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248278; c=relaxed/simple;
	bh=dmD0AD0Y5XRwhcJV5vpL8TbMgtxe8Nc/lEIb6lEIsRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLipUDmgTKFxUsynopOXpR+6Uui/06w0pDU7ssQTj/Ih1wzJqC2unY/acxLCNB7/3TPS44wDOXwHKE6iCITLfBiwb+trEDFWVDoxKWO1PXMRGlk739OJNC9CBMfQNfRb526rxc2GEAVLqUzOIZZ5K6p9VjTUcNA+ASCY3ZzBmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QFVY7QhS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QFVY7QhS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 208AE1650;
	Tue, 28 Jul 2026 07:17:51 -0700 (PDT)
Received: from [10.1.39.91] (unknown [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 637BC3F66F;
	Tue, 28 Jul 2026 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785248275; bh=dmD0AD0Y5XRwhcJV5vpL8TbMgtxe8Nc/lEIb6lEIsRQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QFVY7QhSEQucPxoMNxZfrAMwCZKywqI/Y7j5cb0tXcVbwdS+9tH/TgM4j5YpaUXB1
	 NbkcdImucV3PiVvK8KzzWMMoxoXlBs4CuyCn8s2uVb8M5NebpkR/TGgdowi/RkXpO1
	 bhChhqdGhZtlnEeo17k7T6d7ZF4DVVvDZiUNgJ1E=
Message-ID: <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
Date: Tue, 28 Jul 2026 15:17:50 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
To: David Vernet <void@manifault.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>
References: <20260728073150.54964-1-void@manifault.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260728073150.54964-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/26 08:31, David Vernet wrote:
> In active (EPP) mode the platform autonomously picks the operating point
> between min_perf and max_perf, biased by the EPP hint, and the kernel
> only rewrites the CPPC request on policy or limit changes. A workload
> dominated by one mostly-busy thread that takes frequent short sleeps
> (common in gaming workloads, for example) can fare poorly under this
> strategy. Each sleep decays the hardware's performance signal, causing
> post-wakeup bursts to start at a low operating point and inflating tail
> latency even though the CPU is essentially fully busy while work is
> available.
> 
> As mentioned above, the motivating case here is gaming. A game's main or
> render thread typically blocks briefly on a futex or a GPU fence every
> frame, and the resulting frequency droop shows up directly as stale
> frames and inflated frame-time percentiles.
> 
> Solving this at the cpufreq layer requires walking a fairly narrow
> path. Globally forcing EPP=performance fixes the tail but burns power
> on every core for every workload, which matters on handhelds where the
> CPU and GPU share a power budget. Raising min_perf on the busy core
> seems like the obvious surgical fix, but it pins the core at or above
> nominal even during micro-idle and vsync waits. On Van Gogh (Steam
> Deck) experiments that I ran, that perturbs the SMU's shared CPU/GPU
> boost management enough to regress the frame-time tail relative to doing
> nothing (numbers below).
> 
> This series instead adds an opt-in, per-core EPP boost. When the
> epp_boost module parameter is enabled, an update-util hook samples each
> core's C0 residency (delta MPERF over delta TSC) at most once every
> 10 ms. If a sample shows the core at least 50% busy, the EPP field of
> its MSR_AMD_CPPC_REQ is set to performance (0) and held there until
> 300 ms pass without another busy sample, at which point the hook
> restores the request that policy management last stored in
> cppc_req_cached. Both writes happen only on the busy and idle edges, so
> the CPPC_REQ write rate matches that of a global EPP=performance
> setting. min, max and desired perf are never touched. The mechanism is
> only available in active mode on MSR (X86_FEATURE_CPPC) systems, since
> the hook does local MSR accesses from scheduler context which the
> shared memory interface cannot do. It composes with dynamic_epp, which
> selects the policy EPP from the platform profile and power source.
> epp_boost temporarily overrides whatever policy EPP is installed and
> restores it when the core goes idle.
> 
> Precedents
> ==========
> 
> The closest precedent is intel_pstate's hwp_boost. It has the same
> overall shape as this feature. It is an opt-in update-util hook that
> temporarily rewrites the HWP request from scheduler context on a boost
> edge and restores the unboosted request after a hardcoded hold time
> (hwp_boost_hold_time_ns). It differs in two ways, both deliberate:
> 
> 1. Trigger. hwp_boost activates on SCHED_CPUFREQ_IOWAIT. The waits
>    that matter here are futex waits and amdgpu fence waits, which do
>    not set the iowait flag, so a C0 residency trigger is used instead.
>    Residency also naturally covers the "mostly busy with short gaps"
>    pattern rather than only the wakeup instant.
> 
> 2. Knob being boosted. hwp_boost raises the HWP min. As described
>    above, a min_perf floor measurably regressed the tail on Van Gogh,
>    so this feature biases only the EPP hint and leaves the platform
>    free to drop the operating point during the idle portions of the
>    frame.
> 
> On the thresholds themselves, the sample period, busy threshold and
> decay window are hardcoded rather than exposed as tunables. I'm not sure
> if this is appropriate or not, but it seemed like it followed existing
> contours.
> 
> hwp_boost_hold_time_ns for example is a hardcoded 3 ms, and schedutil's
> iowait boost decay is tied to TICK_NSEC, with no knobs for either. The
> 300 ms decay is sized so that a render thread which is only 50-80% busy
> from periodic vsync and GPU-fence waits holds the boost across its whole
> busy period at a couple of CPPC_REQ writes total, while an idle core
> sheds the boost well before it can matter. The energy exposure of a wide
> window is small because EPP only influences behavior in C0 and an idle
> core sits in CC6 regardless. If folks want me to make these tunable I am
> happy to expose them.
> 
> Testing methodology
> ===================
> 
> All numbers are from a Steam Deck LCD (Van Gogh APU) running in active
> mode at EPP=balance_performance, using the Civilization VI graphics
> benchmark as a single-thread CPU-bound workload with a repeatable
> built-in benchmark pass.
> 
> Comparisons were run as interleaved A/B tests with 6 iterations per
> configuration. For each run I collected per-frame frame times and the
> busy core's frequency, and derived average fps, 1%-low fps and the p99
> and p999 frame-time percentiles. Deltas were evaluated with Welch's
> t-test, and I report the p-values alongside the deltas below.
> 
> Results:
> 
> Default settings
> ----------------
> The busy core's median frequency sat at 2.43 GHz despite 98%
> utilization, which is the frequency droop described above.

Two things to confirm for my understanding:
-Median frequency is the 50th percentile when weighing the OPPs by
residency, right?
- You're also using busy_pct = delta_MPERF * 100 / delta_TSC as
utilization, right? (Not util_avg or anything like that)

Your observation looks like a firmware or SMU issue.
Can we confirm the (short) sleeps reset the demand-estimation, i.e.
by tracing cpu_idle/sched_switch and sample APERF/MPERF alongside it?
Also rt-app might be helpful to get a feel of how this behaves (and
create a similar pathological case like the single-threaded game).

> 
> Global EPP=performance
> ----------------------
> Globally forcing EPP=performance lifts the median to 3.5 GHz, cuts
> frame-time p999 by ~40% and raises 1%-low fps by ~16%, but does so on
> every core and for every workload.
> 
> Raising min_perf to nominal on the busy core
> --------------------------------------------
> A variant of this patch that instead raised min_perf to nominal on the
> busy core reached the same 3.5 GHz median yet regressed p999 by 13-21%
> by perturbing the SMU boost management as described above.
> 
> epp_boost enabled
> -----------------
> With epp_boost enabled, the busy core running the Civ VI main thread
> runs at a 3.5 GHz median and the benchmark gains 31.8% in 1%-low fps
> (p=0.014) and 4.1% in frame-time p99 (p=0.015), with p999 and average
> fps unchanged.
> 
> David Vernet (4):
>   cpufreq/amd-pstate: Document missing kernel-doc members
>   cpufreq/amd-pstate: Update cppc_req_cached before writing the MSR
>   cpufreq/amd-pstate: Add per-core EPP boost for recently-busy CPUs
>   Documentation: amd-pstate: Document the epp_boost parameter
> 
>  Documentation/admin-guide/pm/amd-pstate.rst |  16 ++
>  drivers/cpufreq/amd-pstate.c                | 230 ++++++++++++++++++++++++++--
>  drivers/cpufreq/amd-pstate.h                |  20 +++
>  3 files changed, 255 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 92bf086d086f7cfe0d6f807dfd6b8d11bc61b626

