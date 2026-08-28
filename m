Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727A242D6B
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881198; cv=none; b=hjRAkcxicwevYYyfSvXfldP36OH8MUBosxopha3NncMbSuZuJo+eZAqizb4y95Vw3cwrZgFU41ZPgpqcqT9/pLZHTfNuPLpx7FaSU4qWhHYjzjqeQlJsahkIMcbsmlwM9G/wRde2p/gG1K+8kz0pU/u359owodsF+ZKEQb62Ckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881198; c=relaxed/simple;
	bh=DO4SRlqDBHtd3mUlwplDvqW7KlbWhnct/JmPuJzZEAI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GK2vRooRL7vnCGU/Ma0HRnF6ZvtptKt0uTiNsSEI8N3YXJfv9vKI7GDmxrJ8UjS6m0kY2ewmBkCJnWMvZaZTaHSqFV0aR2XCHVOLLn7MnIbAnCqnFmEnqAZA4nZAL5ZQ0dfqgJmb+ugPnW4TGyLmyPls2xGcV0B58roF2f63gD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBWgdn6V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBWgdn6V"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1E3CC19425
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 01:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787881197;
	bh=DO4SRlqDBHtd3mUlwplDvqW7KlbWhnct/JmPuJzZEAI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IBWgdn6VO7lDY+OZv+yWwb2/ZcodKj2NtPYOqOW2pWlKjS0UYHR0FJwJtPvnOYz9I
	 1nRw7bt4JzzCO3QscK+WLLU05QYxzMSL89tRNMvsPFz3+o5JwTS0SobfTwEhFzHN5E
	 IfxOY200J+808ak1cIzkLD034kFDQBvmn902rNdxe7RNMdVIej2SUHocDsFV06/gh3
	 L7m3XXga7/ktis3y3i/9Z2bKtJWrHk+tN+U5pXC8a1niVRtdf9QV3TAhQPooRrecYE
	 fCnrISmT2imF0ZwhvgxdN13KDeBTb8zjkEMQ18pJpjUAiqEVjO9JO4e5PPmrlF4fHw
	 yT8UgcKdmBweA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id A6BDFC41614; Fri, 28 Aug 2026 01:39:57 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221909] amd-pstate: Cezanne (Ryzen 7 5800U) data fabric sync
 flood on DC gated by CPPC max_perf
Date: Fri, 28 Aug 2026 01:39:57 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: smithd98@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221909-137361-OhXiiiydyb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221909-137361@https.bugzilla.kernel.org/>
References: <bug-221909-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221909

--- Comment #5 from David Smith (smithd98@gmail.com) ---
UPDATE 2026-08-27. ONE CLEAN NEW RESULT, AND TWO MECHANISMS EXCLUDED -
INCLUDING THE ONE I WAS ABOUT TO PROPOSE.

This follows comment #4 and does not repeat it. Comment #4's withdrawals all
still stand. What is new here is a single-variable A/B pair that isolates t=
he
frequency cap, and which also falsifies the voltage mechanism I had been
building toward. I am reporting the exclusions because a falsified mechanism
seems more useful than the confounded correlation I would otherwise have
published.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
1. THE ONE CLEAN RESULT: A SINGLE-VARIABLE PAIR
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Everything in comment #0, and most of comment #4, is confounded in some way.
This is not. It is the only experiment in this investigation in which exact=
ly
one variable moves.

Both arms: same boot, same machine, same battery, same workload (llama.cpp
128-token prefill, ~6.7 GB model, verified resident, CPU only), 27 minutes
apart. Both with amdgpu power_dpm_force_performance_level=3Dhigh, which pins
FCLK at its top DPM state. CPU VDD plane sampled at 492 Hz.

                              LETHAL              SURVIVOR
  scaling_max_freq            4508086             3800000
  FCLK                        1333 MHz, 100%      1333 MHz, 100%
  FCLK transitions            0 in 23864 samples  0 in 66913 samples
  VDDNB (SoC rail)            818 mV 84.5%        818 mV 94.0%
  CPU VDD plane, peak         1250 mV             1281 mV
  CPU VDD plane, % >=3D1300 mV  0.00%               0.00%
  CPU VDD plane, % 1100-1300  25.6%               33.0%
  exposure                    died at 20.9 s      survived 318 s, 9/9 steps
  outcome                     0x08000800          clean

scaling_max_freq is the only thing that differs. Prior cap-efficacy evidence
in this bug was confounded: the compared runs differed in the cap AND in the
power source. This pair is not.

Note how harsh the survivor's configuration is. FCLK pinned at 1333 MHz is =
the
modifier that kills this machine FASTEST at stock max_perf - 11.6 s in one
arm, 21 s in another. Under the cap it ran 318 s clean.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
2. EXCLUDED: CPU-PLANE VOLTAGE IS NOT THE MECHANISM
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
I had built a voltage story and was about to publish it: on DC at low thread
counts the plane sits at 1.37-1.39 V for ~99% of the time, and I believed t=
he
cap protects by removing that operating point.

The pair above kills it, in the awkward direction:

  the run that SURVIVED sat at a HIGHER peak plane voltage (1281 vs 1250 mV)
  and spent MORE time in the 1100-1300 mV band (33.0% vs 25.6%), for 15x
  longer exposure - and lived.

So CPU-plane voltage is not the discriminator: not as a peak, not as
residency, not as dose. Withdrawn before publication rather than after.

PROVENANCE CORRECTION, which anyone reading my hwmon numbers needs: the
"vddgfx" column in comment #0's gating table is NOT a GPU rail. On this part
it is the shared VDDCR_VDD plane and it tracks the CPU V/F point. Verified
directly: 1 thread -> cores 4574 MHz, plane 1393 mV; 16 threads -> cores
2761 MHz, plane 931 mV, i.e. the plane follows the CPU down while the iGPU
clock also falls. Any reading of that column as GPU behaviour, mine include=
d,
was wrong.

SECOND INSTRUMENTATION CAVEAT: I sampled that plane at 4 Hz for most of this
investigation, while it updates about every 2.7 ms - roughly 1 value in 92.
Any voltage conclusion in comment #0 or comment #4 was drawn from aliased
data. The 492 Hz figures above are the first honest measurements I have of
that rail.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
3. EXCLUDED: FABRIC DPM TRANSITIONS ARE NOT NECESSARY
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Since the failure is a fabric sync flood, the obvious question is whether t=
he
fabric's own DPM transitions are involved. They are not:

  FCLK pinned at 1333 MHz, 100% residency, ZERO transitions across 23864
  samples at 492 Hz - and the machine sync-flooded anyway, 21 s in.

I had also observed FCLK thrash (400<->1200, 13 transitions in 888 ms) in an
earlier death captured at 50 Hz, and wondered whether it was causal. In this
death the thrash is not merely downstream - it is entirely absent.

Combined with section 2, and with VDDNB identical at 818 mV on both sides of
the pair, that leaves:

  EXCLUDED:  fabric DPM transitions, SoC-rail level, CPU-plane voltage
  REMAINING: peak core frequency itself, or core current / di-dt at the top
             P-states

i.e. the fault lives in the top ~700 MHz, between 3.8 and 4.5 GHz, and is n=
ot
reachable through the plane voltage, the fabric clock, or the SoC rail.

I cannot narrow it further from here. There is no writable PPT interface on
this part - amdgpu hwmon exposes only power1_input, read-only - so I cannot
hold frequency at stock and lower the power budget independently.

The band 3.83-4.45 GHz is entirely untested. My coverage is <=3D3.80 GHz (0
deaths, 52 steps), 4.48 GHz (1/1 dead), and 4.51 GHz stock (dies reliably).=
 A
cap at ~4.1 GHz bisects it. I will run that bisection if it is useful to
anyone.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
4. INSTRUMENTATION WARNING: journald UNDER-REPORTS THE MOMENT OF DEATH
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Relevant to anyone else triaging these resets from logs. In the death I
captured at 492 Hz:

  journald's last write      09:42:52
  my sampler's last write    09:43:00.907   (fsync'd every 0.25 s)

journald stops being flushed 8.0 seconds before the part actually resets. So
the last line in your journal is NOT the moment of death, and "the machine =
was
idle when it died, because the last log line is idle" is an unsafe inferenc=
e.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
5. CORRECTIONS TO COMMENT #4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
(a) TIMING CLAIM WITHDRAWN. Comment #4 section 7 says the compute load
    collapses to idle "0.3-2.8 s BEFORE" the reset, and treats that as cutt=
ing
    against a simple di/dt story. Withdraw that. Those gaps were computed
    against journald's last write, which section 4 above shows is up to 8.0=
 s
    early, so they are not trustworthy. In the one death measured against a
    reliable clock the collapse precedes the reset by under 0.4 s: last busy
    sample 09:43:00.510 at 3065 MHz mean, first collapsed sample .758 at
    498 MHz, reset at .907 - bounded between 0.15 and 0.40 s by the 250 ms
    sampler. I am no longer claiming a long quiet interval before the flood.

(b) UPDATED TALLIES.
      At stock max_perf on DC:   14 deaths in 15 valid arms
      At smax <=3D 3800000 on DC:  52 ladder steps + a 35-min mixed soak
                                 + a 20-min integrity soak, 0 deaths
    The 52 now includes the 9 steps from section 1, run with FCLK pinned at
    1333 MHz. The ledger since 2026-08-21 now records 23 data-fabric sync
    floods plus one hard hang.

(c) The userspace-fault control in comment #4 section 7 becomes: two faults=
 in
    ~15 valid stock-max_perf arms, zero across 52 capped ladder steps and t=
wo
    capped soaks.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
6. WHERE IT STANDS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Still mitigated but not root-caused, and the mitigation is unchanged in for=
m:
cap scaling_max_freq to 3800000 on DC only.

What is now closed: BIOS (three versions), C6 (both directions), EPP,
governor, min_perf pinning, fabric clock pinning, three kernels, and - new
here - CPU-plane voltage and SoC-rail level as mechanisms.

What remains is peak core frequency itself, or core current / di-dt at the =
top
P-states in the 3.8-4.5 GHz band, plus the DC power path, which I cannot cl=
ose
without a replacement pack I am not able to test. I cannot separate those t=
wo
from userspace: there is no writable PPT interface here, and every voltage =
and
power number available to me from hwmon is an SMU self-report, while the one
independent instrument - the battery EC - refreshes about every 9 s against=
 an
event lasting under a second.

ADDITIONAL QUESTIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
These are in addition to the four in comment #4.

5. Is there any Cezanne rail telemetry that is NOT an SMU self-report? If t=
he
   SMU is the suspect and also the only witness, I cannot distinguish "the =
SMU
   commanded a bad V/F point" from "the rail sagged and the SMU did not see
   it".

6. Is there a debug interface to set a PPT limit on this part? amdgpu expos=
es
   only power1_input read-only here, so I cannot separate frequency from po=
wer
   budget - which is exactly the separation section 3 now needs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
