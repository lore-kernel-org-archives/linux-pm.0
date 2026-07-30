Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806443B27FA;
	Thu, 30 Jul 2026 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785404190; cv=none; b=EvRhLh4v2Hs1xw4Lr++jmW15LV5EEdjCiHQb6IlvbACQK1KMhd6Bu1cxueJXuo1R/HBcBBLfOC11u/zYFwt8Xts+kJtJVsckBXwLFW4PR1+fJBucn0FFm0peL9XBNOF6vJSDcokIR7hdg1pqxlKYN9EQatVXMJif8VJKzQ7t9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785404190; c=relaxed/simple;
	bh=66jKNUbIEgTWLeFIZcADhbyiD0Jo1iBCLVPGlkQ6tpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjzWPQiqRQ1VxJtYSBFC0XIPvf4oiH08vI2bhd9LJE6GbUY5PdvO1r2tCQTgnlBgvluTXpTynVyaS11YgdkoCxXkgqYVjRUanDKwUbCD3ANp1zKVWhX+Xk8tHKoFGyLEjomtwffOkQjkR0YdVDfXzCzJgZ0380dgnUJqlGfFaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=k35lgVsG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="k35lgVsG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C85DA1684;
	Thu, 30 Jul 2026 02:36:23 -0700 (PDT)
Received: from [10.1.39.91] (e127648.arm.com [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEE2D3F763;
	Thu, 30 Jul 2026 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785404187; bh=66jKNUbIEgTWLeFIZcADhbyiD0Jo1iBCLVPGlkQ6tpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k35lgVsGP9JUK1MthObTJxxuh8MWfazBSI9arw3dFvWKZkrLlG7ehzh1lDoUr366H
	 xpSGpFLkT9WteUcx+3Uc/QKaNSrGq+r4QAbnEUfI8v7WMkFzFqdYYrr//qfP8Nt+fs
	 3bE4TzyBSRSVcpU0KaX0b7S8dix3cJ068vZP9UNM=
Message-ID: <1f2eaaaa-0c42-48ff-8d74-b28eeb5745e8@arm.com>
Date: Thu, 30 Jul 2026 10:36:23 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] cpufreq/amd-pstate: Per-core EPP boost for
 recently-busy CPUs
To: David Vernet <void@manifault.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Almeida?=
 <andrealmeid@igalia.com>, Changwoo Min <changwoo@igalia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Qais Yousef <qyousef@layalina.io>
References: <20260728073150.54964-1-void@manifault.com>
 <700ebebe-f4ab-4329-ad43-716d74d6621c@arm.com>
 <40ab4c65-faf5-4a85-8761-bc6ebd1aec90@amd.com>
 <528d4cef-3c79-4b84-a99a-5566f246a4dc@amd.com> <amryoRIuKC3olg9b@maniforge>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <amryoRIuKC3olg9b@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/30/26 08:22, David Vernet wrote:
> On Wed, Jul 29, 2026 at 08:42:45AM +0530, K Prateek Nayak wrote:
> 
> Hi Prateek!
> 
> [...]
> 
>>>>> This series instead adds an opt-in, per-core EPP boost. When the
>>>>> epp_boost module parameter is enabled, an update-util hook samples each
>>>>> core's C0 residency (delta MPERF over delta TSC) at most once every
>>>>> 10 ms. If a sample shows the core at least 50% busy, the EPP field of
>>>>> its MSR_AMD_CPPC_REQ is set to performance (0) and held there until
>>>>> 300 ms pass without another busy sample, at which point the hook
>>>>> restores the request that policy management last stored in
>>>>> cppc_req_cached. Both writes happen only on the busy and idle edges, so
>>>>> the CPPC_REQ write rate matches that of a global EPP=performance
>>>>> setting. min, max and desired perf are never touched. The mechanism is
>>>>> only available in active mode on MSR (X86_FEATURE_CPPC) systems, since
>>>>> the hook does local MSR accesses from scheduler context which the
>>>>> shared memory interface cannot do. It composes with dynamic_epp, which
>>>>> selects the policy EPP from the platform profile and power source.
>>>>> epp_boost temporarily overrides whatever policy EPP is installed and
>>>>> restores it when the core goes idle.
>>
>> I would also like to know Rafael's thoughts on kernel modifying the
>> EPP to something other than what user has programmed.
>>
>> There are a ton of userspace tools that have currently profiled a bunch
>> of systems and use the EPP interface to program a good default and their
>> expectations may diverge if kernel starts modifying EPP underneath them.
> 
> Yeah that makes sense. I figured EPP was the right abstraction to tune
> if we're going to use scheduler input to provide hints to firmware but
> yes it is indeed modifying EPP under what was explicitly configured. My
> thinking was that this is an opt-in parameter but I agree that it's
> maybe not desirable to change it underneath what was explicitly set by
> the user.
> 
>> This almost feels like putting the ondemand governor into the driver.
>> Perhaps, the active mode drivers can be made to support the dynamic
>> governors as opposed to just the static ones? that fits the overall
>> cpufreq subsystem better but I'll wait on Rafael's thoughts on that.
> 
> Good question. I'll defer to you folks on whether that direction makes
> sense. If it does and would help facilitate this, I'm happy to help
> explore it.
> 
>>> Have you seen the series from Prateek that reworks how dynamic EPP
>>> works [1]?  It becomes an energy_performance_preference that userspace
>>> can opt into.
>>
>> I feel like that will come short of the expectations here because we
>> would like to do this per-CPU based on utilization metrics as opposed
>> to system profile / power status both of which are global and can lead
>> to faster battery drain.
> 
> Yep, +1, I do think we need per-CPU tuning here. That said, I am happy
> to test dynamic EPP and see how it fares. I can try to find time to do
> that this weekend.
> 
>>> I did have aspirations to hook into more changes than just platform
>>> profile and power source eventually, so it sounds like we're at least
>>> thinking in the same area.
>>
>> Ack! We'll at least need more input to the dynamic mode to cater to
>> this specific case but it is going into the governor territory at that
>> point if we want to use CPU specific signals.
>>
>>>
>>> [1] https://lore.kernel.org/linux-pm/20260727072056.1248-1-kprateek.nayak@amd.com/
>>>
>>> Can you rework your series on top of that and see how the mechanics work out?
>>>
>>>>>
>>>>> Precedents
>>>>> ==========
>>>>>
>>>>> The closest precedent is intel_pstate's hwp_boost. It has the same
>>>>> overall shape as this feature. It is an opt-in update-util hook that
>>>>> temporarily rewrites the HWP request from scheduler context on a boost
>>>>> edge and restores the unboosted request after a hardcoded hold time
>>>>> (hwp_boost_hold_time_ns). It differs in two ways, both deliberate:
>>>>>
>>>>> 1. Trigger. hwp_boost activates on SCHED_CPUFREQ_IOWAIT. The waits
>>>>>     that matter here are futex waits and amdgpu fence waits, which do
>>>>>     not set the iowait flag, so a C0 residency trigger is used instead.
>>>>>     Residency also naturally covers the "mostly busy with short gaps"
>>>>>     pattern rather than only the wakeup instant.
>>>>>
>>>>> 2. Knob being boosted. hwp_boost raises the HWP min.
>>
>> I think that is why it is acceptable to be used with FW based scaling
>> as it leaves the user programmed EPP alone.
>>
>>>>>                                                       As described
>>>>>     above, a min_perf floor measurably regressed the tail on Van Gogh,
>>>>>     so this feature biases only the EPP hint and leaves the platform
>>>>>     free to drop the operating point during the idle portions of the
>>>>>     frame.
>>>>>
>>>>> On the thresholds themselves, the sample period, busy threshold and
>>>>> decay window are hardcoded rather than exposed as tunables. I'm not sure
>>>>> if this is appropriate or not, but it seemed like it followed existing
>>>>> contours.
>>>>>
>>>>> hwp_boost_hold_time_ns for example is a hardcoded 3 ms, and schedutil's
>>>>> iowait boost decay is tied to TICK_NSEC, with no knobs for either. The
>>>>> 300 ms decay is sized so that a render thread which is only 50-80% busy
>>>>> from periodic vsync and GPU-fence waits holds the boost across its whole
>>>>> busy period at a couple of CPPC_REQ writes total, while an idle core
>>>>> sheds the boost well before it can matter. The energy exposure of a wide
>>>>> window is small because EPP only influences behavior in C0 and an idle
>>>>> core sits in CC6 regardless. If folks want me to make these tunable I am
>>>>> happy to expose them.
>>>
>>> In a lot of ways I feel like you're fighting with the hardware (and
>>> active mode) by doing it this way.  Did you look into using passive
>>> or guided mode instead?  They might be better suited for what you're
>>> trying to do.
>>
>> Ack! Seems like UCLAMP_MIN + natural accumulation of PELT signals when
>> running with passive mode + schedutil can achieve the desired results
>> here but ...
> 
> Actually, the first thing I tried in general with this effort was to
> raise min_perf to nominal on busy cores, with an idle-path restore
> (answering your question below). It reached the same 3.5 GHz median as
> the EPP approach but surprisngly regressed frame-time p999 by 13-21%
> which I was of course not expecting. I'm not 100% sure why this happens
> but I _think_ what's going on is that on this APU, the CPU and GPU share
> one SMU-managed power budget, and holding a frequency floor through the
> micro-idle portions of each frame (vsync and fence waits) takes away the
> headroom the SMU needs to keep the GPU fed.
> 
> I'm not sure this is what's happening but in the traces I was looking at
> where this occurs, I didn't see CPU pressure so I'm assuming it was GPU
> hitches. I'll validate this again over the weekend. I also haven't tried
> using UCLAMP_MIN, so I'll put that on my TODO list as well.
> 
> With all of that said, something I did realize while looking into this
> is that Proton doesn't actually implement the functions to tag the
> render thread [0] (Changwoo please correct me if I'm misunderstanding
> something here).
> 
> [0]: https://github.com/ValveSoftware/wine/blob/proton_11.0/dlls/avrt/main.c#L57
> 
> If we were to leverage this and be able to configure these high priority
> tasks with the correct UCLAMP settings, etc, I think it's likely that it
> would give us as good or better results, yes. Though, I guess that's
> still assuming that the SMU will do the right thing w/ the CPU/GPU power
> budgeting.
> 
FWIW Qais (+CC) had been rallying for a while now to get userspace hints
(including UCLAMP_MIN) for the scheduler adopted.
His latest proposal includes a system-manager that takes care of the tagging:
https://github.com/qais-yousef/schedqos/
and means you ideally don't have to modify proton (or whatever userspace task
you care about).
