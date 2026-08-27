Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A817374A08
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787794170; cv=none; b=WKZQ53JfpRdaGdfcADWZhRUuy8sdaE6GuMUjI/uT02MzqV78cSkKhmbjrHwi5ugkNzevzm/Bx2zelY2V77vMOXuRjCmuhfoGC+5/2Y8+dSr+wPl3RwawRnvfxMcW185m/o+AxcyWx8FTGiTebHGXLGCFePxdylD+P87QENznywQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787794170; c=relaxed/simple;
	bh=FI/Y5ICdDPZ1sitvKq+NJS+lIUrvw6pPBsUVAXQ71To=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJFNK+0/9qm8baiU4ROoz2quKuGOtpgdBGuuGx1Ocvigz4ciym1Njc3tAcTHxPQCJJBAq4AmBgZyBpbiuaFfOQ0ne1L+jD+w133+BXR067418kACOC60iAV5ywtX3eEgi/Na9lDf0d4HiDOY8/v/PUH6JT1hUUiNa6Jjbx1H7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6dUd5Mk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6dUd5Mk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDDF2C2BCC7
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 01:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787794169;
	bh=FI/Y5ICdDPZ1sitvKq+NJS+lIUrvw6pPBsUVAXQ71To=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=c6dUd5Mky+6a/T7DKWBJ5UMaRKXs/t0G3CxrfoC/x/EJF0y8rDNq+oCt+me7AmYzx
	 ECg2sWmCdbaZK4QueMpOajoK3nqt/J1JzyHrHrIc3GQQEeQqij5W18mrYqQuEXcmzs
	 yYn20Mmc7FTyq6BUr76uAgAE6wuHkhpU+jBqeMTCQbE2lKxJsRfhSOM9L6S0y4GAAB
	 +tpjhwWwrl9c9KbWEDKh3d2iW0gU550Ma3CmMpuKgU8Hh6uZ7VCDiRkY5QXOOpTfJd
	 Wbf6nmQq5nJ2pGKHLCslsjQf9jxQV7lXKwI0RdubDE++SqEB7CgeBBEOV9r1FZ8uq7
	 RYxvvETaajxdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id BF8A9C3279F; Thu, 27 Aug 2026 01:29:29 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221909] amd-pstate: Cezanne (Ryzen 7 5800U) data fabric sync
 flood on DC gated by CPPC max_perf
Date: Thu, 27 Aug 2026 01:29:29 +0000
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
Message-ID: <bug-221909-137361-Ql7fsVDixg@https.bugzilla.kernel.org/>
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

--- Comment #4 from David Smith (smithd98@gmail.com) ---
UPDATE 2026-08-26. SIGNIFICANT CORRECTIONS TO COMMENT #0, PLUS FOUR NEW
NEGATIVE RESULTS AND ONE NEW POSITIVE FINDING.

Several load-bearing claims in comment #0 are wrong and I am withdrawing th=
em.
Anyone using that comment as a starting point should read this first. In
particular, one of the workarounds I published there has since been re-test=
ed
properly and it does NOT work.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. WITHDRAWN: ROWS 3 AND 5 OF THE GATING TABLE, AND THE HEADLINE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Re-deriving the ledger from raw logs rather than from my own prose, the
"surviving" runs at stock max_perf shared a disqualifying defect: the ~6.7 =
GB
model was not actually resident, so they were I/O-bound on page-ins instead=
 of
running sustained all-core AVX2. They were not doing the same work as the r=
uns
that died.

  Row 5 (performance/performance, 4508086, "8 steps 0 deaths", 4374 MHz):
    entered the window with 10 MiB MemAvailable, holding 5004 MiB of a
    ~6.7 GiB model, at 17.3-24.2 tok/s. A 3.8 GHz-capped run manages
    30.7-31.2 tok/s. A run pinned to max_perf 166 that is 30% SLOWER than a
    capped run was not stressing the part. Its quoted fmax 4374 MHz was a
    transient peak in a starved run; mean fmax was 2953 MHz.

  Row 3 (balance_performance/powersave, 4100000, "8 steps 0 deaths"):
    same defect, worse - RSS 38 MiB.

**Therefore the headline claim of comment #0 - "the lethal configuration is=
 the
MILDEST one measured", survives 4374 MHz/1462 mV/85.8 C and dies at
3617 MHz/1175 mV/63.8 C - is WITHDRAWN.** It rested entirely on row 5. So is
"Rows 1 and 5 are the controlling pair" and the conclusion "pinning perf HI=
GH
is safe".

Row 5's configuration has since been re-run correctly (RSS 6692 MiB,
MemAvailable 12.6 GiB, 27.9 tok/s warm). **It died.**

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
2. WITHDRAWN AND ACTIVELY WRONG: THE epp=3Dperformance ADVICE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Comment #0's WORKAROUND section says:

  "epp=3Dperformance on DC also survived (8 steps) and preserves full boost"

**Do not use this. It has been re-tested validly and the machine dies.** Th=
at
"survival" was row 5. Deaths have now been observed at balance_power,
balance_performance and performance alike, and also with min_perf pinned eq=
ual
to max_perf. **EPP is not the gate.** The only workaround I still stand beh=
ind
is the DC frequency cap.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
3. WITHDRAWN: THE "RANGE, NOT CEILING" INTERPRETATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Comment #0 claimed the cap works by narrowing the CPPC range rather than
lowering the ceiling, "even though the workload never exceeds ~2.9 GHz
uncapped". **That was an instrument artifact.** The `fmax` field I derived =
it
from is unreliable on this platform.

Re-measured with per-core CPPC feedback counters (delivered/reference
counters, 43k+ core-samples per arm):

                            STOCK (4508086)   CAPPED (3800000)
  p99                       3981 MHz          3752 MHz
  p99.9                     4171 MHz          3963 MHz
  max                       4473 MHz          4493 MHz
  core-samples > 3.8 GHz    1271 (2.94%)      93 (0.21%)

**The workload does reach 4.2-4.5 GHz, and the cap cuts the above-3.8 GHz
population by 13.8x while leaving the median untouched (2336 -> 2331 MHz). =
The
cap acts entirely on the tail.** The excursions concentrate in LOW-THREAD
phases (cold load, page faults, memcpy, NVMe completion), not in the all-co=
re
vector phase, and they track the CPPC preferred-core ranking exactly:

  cpu            0   1   2   3   4   5   6   7   8   9  10  11  12  13  14 =
 15
  highest_perf 181 181 196 196 186 186 196 196 176 176 166 166 191 191 171 =
171
  count >3.8G   46  50 162 119  81  61 146 122  63  66  46  48  88  90  46 =
 37

Note also that the cap is **statistical, not absolute**: 0.21% of core-samp=
les
still exceed it, peaking at 4493 MHz.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
4. WITHDRAWN: "RULED OUT - THE BATTERY PACK"
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Comment #0 lists the pack under RULED OUT, on the strength of "the same pack
survives 4374 MHz ... and dies at 3617 MHz". That is row 5 again. **With ro=
w 5
withdrawn, the exclusion has no valid arm behind it and is withdrawn.**

The pack is measurably bad. Measured today under load, at 82% charge:

  voltage_min_design  11.400 V
  voltage_now         10.981 V   <- 419 mV BELOW its own design floor
  current_now          2.234 A      at only 2.2 A average
  charge_full/design  76.1%       263 cycles, 5 yr 4 mo

I am not able to test a replacement pack, so I cannot close this. Treat the=
 DC
power path as an open hypothesis, not an excluded one.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
5. CORRECTED: "No MCE"
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Comment #0 says "No MCE". That was wrong - nothing in my harness guaranteed=
 the
log reached disk before the reset. With a per-line-fsync'd capture, one cra=
sh
produced, immediately before the flood:

  CPU:10 MC0_STATUS[Over|UE|MiscV|AddrV|-|-|-|-|Poison|-]: 0xfc000800010101=
35
  Error Addr: 0x0000000125006740   IPID: 0x001000b000000000
  cache level: L1, tx: DATA, mem-tx: DRD
  ... and the identical bank on CPU:4, Error Addr 0x000000015e8c6740

IPID HWID 0xB0 / McaType 0x10 =3D SMCA_LS_V2, XEC 1 =3D "An ECC error or L2=
 poison
was detected on a data cache read by a load". Poison set, OVER set, PCC=3D0=
, two
cores, two addresses, same instant.

The LS unit is the CONSUMER of an already-poisoned line, not the source. OV=
ER
on both banks means a burst. Two scattered addresses on two cores argues
against a single marginal DRAM cell and for transient corruption of in-flig=
ht
data. Only one MCE has been captured in ~21 crashes; two later attempts to
reproduce it failed.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
6. NEW - FOUR NEGATIVE RESULTS THE COHORT IN COMMENTS #2/#3 DOES NOT HAVE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
All run on battery, at stock max_perf, with guards on RSS >=3D 6000 MiB,
MemAvailable >=3D 1500 MiB and warm throughput >=3D 25 tok/s.

(a) **BIOS 01.25.00 (latest HP ships) DIES.** AMD asked me to test it. Flas=
hed
    and verified three ways; died 23 s into the ladder. This rules out AGESA
    CezannePI FP6 1.0.1.1c and PSP 0.11.0.85 -> 0.11.0.88. It does NOT
    exonerate the SMU: **SMU firmware is unchanged at 64.74.0 and microcode=
 is
    unchanged at 0xa500014 across 01.22 -> 01.25**, so the flash did not mo=
ve
    the component actually under suspicion.

(b) **CC6 disabled DIES, and this refutes the cohort's top workaround.**
    With ACPI C3/CC6 disabled and verified at **0 CC6 entries/s** (normal a=
rms
    measure 3420-4403/s), the machine sync-flooded in **10 seconds**. So
    `processor.max_cstate=3D2` - the most-recommended parameter in the gist
    linked in comment #2 - **does not protect this machine.** C6 is also not
    the gate by rate: an AC C6 matrix measured essentially identical entry
    rates across lethal and safe configurations alike.

(c) **Kernel 6.12.75 DIES, which refutes the cohort's last-known-good.**
    Comment #2 and the linked gist name 6.12.x as last-known-good against
    6.18.x/7.1.x failing - exactly this machine's confirmed pair. I install=
ed
    6.12.75-1-lts and ran the lethal ladder. **It died in 20 seconds**, at =
the
    same step as every other death.

    This test was gated in advance so the result could not be explained awa=
y:
    6.12.75 reaches a **harsher** operating point than 7.1.8 (3.67% vs 2.94=
% of
    core-samples above 3.8 GHz), so "6.12 just boosts less" is unavailable.
    The two kernels also derive different limits from the same hardware
    (cpuinfo_min_freq 1113443 -> 400000), but the per-core highest_perf lad=
der
    is identical.

(d) Deaths continue to occur across EPP and governor settings and with
    min_perf pinned. Nothing but the frequency cap has ever moved the rate.

**Caveat I want to state plainly:** my failure fires in 10-50 s on demand a=
nd
is
gated by CPPC max_perf; the cohort in comments #2/#3 reports 1-14 days,
stochastic, with idle sufficient. Those differ by ~4 orders of magnitude in
rate and my gate has no counterpart in their reports. 0x08000800 is an
ENDPOINT, not a mechanism - it is what the DF does whenever it consumes a
poisoned line, whatever poisoned it - and the Framework case was already
root-caused to WD SN770 NVMe firmware. **I no longer assume we have the same
bug.** These negative results are offered as data, not as a merge.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
7. NEW POSITIVE FINDING - IT CORRUPTS DATA BEFORE IT RESETS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
This is the most useful thing I have found and it was not in the original
report.

The last kernel line before one reset was a userspace fault in the compute
workload, which the kernel resolved to a specific instruction:

  traps: llama-server[34143] general protection fault ip:74fd9014dbd7
    error:0 in libggml-cpu-haswell.so[e0bd7,74fd9007f000+d8000]

Disassembled, file offset 0xe0bd7 is inside `ggml_gemm_q4_K_8x8_q8_K`, the
hottest loop of the workload:

  e0bc4:  mov    0x1b8(%rsp),%rax           ; base pointer from stack
  e0bcc:  add    (%rsi),%rax                ; +=3D an 8-byte word from memo=
ry
  e0bd3:  add    $0x8,%rsi
  e0bd7:  vmovdqu 0x10(%rax,%r12,1),%ymm0   ; <-- FAULTS HERE

**The same instruction faulted at an earlier crash** (identical ip low-20 b=
its)
- but as a SIGSEGV (error 4, page-not-present) on a canonical-but-unmapped
address, rather than a #GP on a non-canonical one.

`vmovdqu` is the UNALIGNED load; it does not raise #GP on misalignment. So =
both
faults are bad ADDRESSES, and %rax is built from two memory loads two
instructions earlier. **Same instruction, two different fault types, two
different bad addresses =3D a corrupted pointer operand, not a software bug=
.**
That is exactly what the MCE in section 5 describes: poison consumed on a d=
ata
cache read by a load.

Control: the workload has faulted twice, both times within seconds of a sync
flood, in ~14 valid stock-max_perf arms - and zero times across 43 capped
ladder steps and two capped soaks.

**Implication: this machine computes wrong answers before it resets.** Both
observed cases corrupted a pointer and were therefore loud. Corruption of a
value instead of a pointer would be silent.

Timing caveat, stated because it cuts against a simple di/dt story: in most
recent deaths the compute load collapses to idle **0.3-2.8 s BEFORE** the
reset, and in one case the machine sat at ~9 W for nearly three seconds aft=
er
the workload had already died. It is not universal - one arm died under full
load - but time-of-death is evidently not time-of-injection.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
8. THE MITIGATION, AND WHAT IT IS NOW VALIDATED AGAINST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Unchanged in form - cap scaling_max_freq to 3800000 on DC only, driven from=
 a
systemd unit at boot, a udev rule on SUBSYSTEM=3D=3D"power_supply"
ATTR{type}=3D=3D"Mains", and a system-sleep hook for resume.

  At stock max_perf on DC:   13 deaths in 14 valid arms
  At smax <=3D 3800000 on DC:  43 ladder steps + a 35-min mixed soak
                             + a 20-min integrity soak, 0 deaths

New: I built a self-verifying canary (bit-exact AVX2 checksum over a 32 MiB
buffer, single-bit-flip selftest 60/60) and ran four instances pinned to the
CPPC preferred cores alongside the real workload, on battery under the cap,=
 for
20 minutes: **~557,000 verified passes, ~17 TiB checked bit-exactly, zero
compute errors, zero memory corruption, zero faults, zero MCEs, no reset.**

So the cap now has support on two criteria - survival AND data integrity -
where before it had only survival.

**Limitation I want on the record:** those canaries held their cores at
SUSTAINED 100%, and a continuously busy core does not perform the idle->boo=
st
transition that section 3 identifies as where the excursions live. So this
result licenses "no corruption under sustained load under the cap" and NOT =
"no
corruption during boost excursions under the cap". A burst-mode canary is t=
he
correct instrument and I have not yet run it.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
9. CORRECTED LEDGER AND STANDING
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
Reproduced on BIOS 01.21.00, 01.22.00 and 01.25.00, and on kernels 6.12.75-=
lts,
6.18.44-lts and 7.1.8. The machine-generated boot ledger begins 2026-08-21
(after the 01.22 flash) and records **20 data-fabric sync floods plus one h=
ard
hang**; earlier crashes on 01.21 are described in comment #0 but predate the
ledger, so the true total is somewhat higher than the 21 I have been quotin=
g.

The controlled figures are the arm-based ones above, and those I stand behi=
nd.

Where it stands: the failure is **mitigated but not root-caused**. Every ch=
eap
software and firmware axis is now closed - BIOS (three versions), C6 (both
directions), EPP, governor, min_perf pinning, and three kernels. The remain=
ing
candidates are the SMU's DC boost/voltage policy and the DC power path itse=
lf,
and I cannot separate them without a replacement pack, which I am not able =
to
test.

QUESTIONS, UPDATED
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Given SMU 64.74.0 and microcode 0xa500014 are constant across all three
   BIOS versions tested, is there a known Cezanne (fam 25, model 80) erratum
   covering fabric sync floods arising from autonomous CPPC boost transitio=
ns
   on DC?
2. Which upstream unit sets poison on this part, so the MCE in section 5 can
   be traced back from the consumer to the originator?
3. Is there any way to obtain a fabric-side error record with no APEI tables
   (no BERT/HEST/ERST here, and no EDAC instance binds)?
4. Would a DMI-matched amd_pstate quirk clamping max_perf on DC be acceptab=
le
   upstream, or is this strictly an AGESA/PMFW fix to route through the OEM?
   Happy to write and test it given a preferred shape.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
