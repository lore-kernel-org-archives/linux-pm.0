Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203072EBBB9
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787398534; cv=none; b=DYUUeqBiMWm02mrSbGlv3EXNthG1ogRad95z8q5FyetBr3zDek9Oi89w4r0+u5My5QfJu3NuRo40W97Gw4JTysklguFzZSq6PCRWqZztLeBtU3yqdhCiXyCmg14+GCEXlSF74eQdOpoH7k7IYwE0aqeYjU8Z6N8Vg1zu+lhaekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787398534; c=relaxed/simple;
	bh=3mhnTAPaiZfwT6koXKdcjPbfn8CBt8EsKK++Zf90tkc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BNSudkruENO0cBJU04ikobTfHaye+FPZNyplt5WvrK3w70nmsvh/Qn2QDPCtuhX0uKBwlSRcXSCpv89evvSpiojbujXGFfT1KXcwc9x5RhUDF0g8+uRAnelZfAGe36ioqNMcOj9kvUxBfB/mz5m2w6ct9THi+SmkDj/8rbwpcZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZxZZ7o/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZxZZ7o/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2A82C2BCB3
	for <linux-pm@vger.kernel.org>; Sat, 22 Aug 2026 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787398533;
	bh=3mhnTAPaiZfwT6koXKdcjPbfn8CBt8EsKK++Zf90tkc=;
	h=From:To:Subject:Date:From;
	b=GZxZZ7o/1vzPSvfOepfrpFx+/R1QSW80JsjeoCIHVZyD7NKBX7FFxbRpDFB2xLv3X
	 wVAYvgXl3jNxqBgvWC4yWE8klt3yNEQIxCS9YxmXMkYVHy6IFdRT58G6SC+ymo35sM
	 mwKFIq0FkQoBolW40ovPQjzDh2mltZwgWZB6CsEbdn1eTSuYx86MWwDA3skYQdeMvH
	 FT6DWefyEtliEh6ArEoTE9UR5XPpY2EB0IMnvMILfrb13hC4vzjDrNVmEjHHKoIOQ1
	 KWUzLtoDvQRR2A6oD857wOmvrfk+8dVIVTTCae29b5hxAtaatiAbrYmffA1Ukd+COK
	 CnD3egvRNZ+ng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 86104C3279F; Sat, 22 Aug 2026 11:35:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221909] New: amd-pstate: Cezanne (Ryzen 7 5800U) data fabric
 sync flood on DC gated by CPPC max_perf
Date: Sat, 22 Aug 2026 11:35:33 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
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
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-221909-137361@https.bugzilla.kernel.org/>
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

            Bug ID: 221909
           Summary: amd-pstate: Cezanne (Ryzen 7 5800U) data fabric sync
                    flood on DC gated by CPPC max_perf
           Product: Power Management
           Version: 2.5
    Kernel Version: 7.1.8-arch1-3 (also 6.18.44-1-lts)
          Hardware: x86-64
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: smithd98@gmail.com
        Regression: No

SUMMARY
=3D=3D=3D=3D=3D=3D=3D
Reproducible AMD data fabric sync flood (reset 0x08000800) on an HP ProBook
445 G8 (Ryzen 7 5800U, Cezanne) under sustained all-core AVX2 load while on
battery. 13 confirmed hard resets. The failure is gated by CPPC max_perf in
combination with energy_performance_preference, and NOT by any absolute
frequency, voltage, package power or temperature. Never occurs on AC.

  x86/amd: Previous system reset reason [0x08000800]: an uncorrected error
  caused a data fabric sync flood event

The decisive observation: the lethal configuration is the MILDEST one
measured. On the same battery, minutes apart, the machine survives
4374 MHz / 1462 mV / 85.8 C and dies at 3617 MHz / 1175 mV / 63.8 C.

SYSTEM
=3D=3D=3D=3D=3D=3D
Machine        HP ProBook 445 G8 Notebook PC, SKU 4J223UT#ABA, board HP 8861
BIOS           T78 Ver. 01.22.00 (2025-08-19); also reproduced on 01.21.00
CPU            AMD Ryzen 7 5800U - family 25, model 80, stepping 0
Microcode      0xa500014 (amd-ucode 20260810-1), verified loaded
Memory         2 x 8 GB Samsung M471A1K43DB1-CWE DDR4-3200, one per channel
Kernel         7.1.8-arch1-3; also reproduced on 6.18.44-1-lts
cpufreq        amd-pstate-epp, status "active", prefcore enabled
CPPC cpu0      highest_perf 181, nominal_perf 70,
               lowest_nonlinear_perf 41, lowest_perf 15, nominal_freq 1901
Distro         Omarchy Linux (Arch-based)

STEPS TO REPRODUCE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Run on battery. (Never reproduced on AC.)
2. Ensure epp=3Dbalance_performance, governor=3Dpowersave,
   scaling_max_freq=3D4508086 (stock).
3. Apply sustained all-core AVX2/FMA load. I use llama.cpp prefill of a 9B
   model (~6.7 GB resident, CPU only) via ollama, 128-token prompts, model
   held warm so there is no NVMe or page-cache activity in the window.
4. Machine hard-resets 10-20 s into a step, typically the first or second.
   Hazard is roughly 1/3 per 128-token step.

ACTUAL RESULT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hard reset. Next boot reports reset reason 0x08000800 (data fabric sync
flood). No MCE. No OOM (~30 GB swap free at failure). PCIe AER is OS-owned
(_OSC grants it) and reads cor=3D0 / nonfatal=3D0 / fatal=3D0 on all four d=
evices.
No EDAC instance binds. No APEI: no BERT/HEST/ERST, so the platform never
names a component.

EXPECTED RESULT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
No reset.

THE GATING RESULT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
All rows on battery unless noted. Same pack, same charge range, same
workload, 128-token prefill steps. Peaks from amdgpu hwmon plus RAPL.

  # EPP / governor                   smax_freq  max_perf  fmax  vddgfx  tct=
l=20=20=20
steps deaths
  1 balance_performance / powersave  4508086    166       3617  1175mV  63.=
8C=20=20
12    4
  2 balance_performance / powersave  4500000    165       -     -       -=
=20=20=20=20=20=20
1     1
  3 balance_performance / powersave  4100000    ~151      4017  -       84.=
9C=20=20
8     0
  4 balance_performance / powersave  3800000    140       3748  1275mV  71.=
5C=20=20
33    0
  5 performance / performance        4508086    166       4374  1462mV  85.=
8C=20=20
8     0
  6 balance_power / powersave (AC)   4508086    166       4117  1431mV  84.=
0C=20=20
8     0

Rows 1 and 5 are the controlling pair: identical scaling_max_freq, identical
power source, identical workload, differing ONLY in EPP and governor. Row 5
runs 757 MHz faster, 287 mV higher and 22 C hotter than row 1, and survives
8/8, while row 1 dies ~14 s into a step.

Rows 1, 3, 4 bracket the threshold: safe at max_perf <=3D 151 (41 steps, 0
deaths), lethal at >=3D 165 (13 steps, 5 deaths). Boundary in 152-164,
untested.

INTERPRETATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Pinning perf HIGH is safe. Clamping the range LOW is safe. Lethal is the
wide range with autonomous SMU ramping - balance_performance + powersave
across max_perf 166 on DC, where the SMU continuously renegotiates the
operating point over a broad span.

This suggests the defect is in autonomous SMU/PMFW perf-state transition
handling on DC across a wide CPPC range, rather than in any operating point
the silicon actually reaches. Consistent with that: scaling_max_freq=3D3800=
000
prevents the crash even though the workload never exceeds ~2.9 GHz uncapped.
The cap's real effect is narrowing the range, not lowering the ceiling.

RULED OUT
=3D=3D=3D=3D=3D=3D=3D=3D=3D
- Bad DIMM / IMC: Memtest86+ 7.20, 5 full passes, 16 threads, >4 h, 0 error=
s.
- CPU / board / adapter defect: HP preboot diagnostics all PASS including a
  30-minute processor test.
- Thermal: dies at 63.8 C, survives at 85.8 C.
- BIOS regression: 4 crashes on 01.21.00, 9 on 01.22.00.
- NVMe HMB (the Framework SN770 root cause): AER OS-owned and clean on all
  devices, ASPM disabled by FADT, and an autonomous DMA bug cannot switch on
  and off with scaling_max_freq in an A/B/A.
- OOM / reclaim: no OOM kill, ~30 GB swap free at failure.
- The battery pack. It IS worn (5 yr 4 mo, 74.5% health, ~430 mOhm internal
  resistance, sags to 9.48 V under 3.7 A) and was the leading hypothesis. It
  was tested directly and rejected: the same pack survives 4374 MHz /
  1462 mV / 352 W peak and dies at 3617 MHz / 1175 mV / 37 W. A separate
  35-minute mixed-load run survived from 23% to 8% SoC with 32% of samples
  below the pack's 11.4 V voltage_min_design. No battery model produces that
  ordering.

INSTRUMENTATION NOTE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Power figures are from AMD RAPL (intel-rapl:0 binds on this part), sampled =
in
5 ms sub-windows and aggregated per 250 ms. Because RAPL accumulates energy,
scheduling jitter cannot bias derived power.

The amdgpu power1_input (PPT) sensor on this platform emits spurious high
readings: it reported 69-73 W in windows where RAPL measured 14.6 W mean /
21.7 W peak over the same 250 ms. PPT-derived peaks from this hardware -
here or in other reports - should be treated with caution.

WORKAROUND
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Cap CPU frequency on DC only. Costs nothing measurable here because the
workload never exceeds ~2.9 GHz uncapped:

  for c in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq; do
      echo 3800000 > "$c"
  done

Driven from a systemd unit at boot, a udev rule on
SUBSYSTEM=3D=3D"power_supply", ATTR{type}=3D=3D"Mains", and a
/usr/lib/systemd/system-sleep/ hook for resume. Validated: 33 ladder steps
plus a 35-minute mixed-load soak on battery at load average 29-34, zero
resets, against 5 deaths in 13 uncapped steps.

epp=3Dperformance on DC also survived (8 steps) and preserves full boost, b=
ut
rests on much less evidence and costs battery life.

LIMITATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This is a single machine. I have not confirmed it on another 445 G8 or
another 5800U, so I cannot rule out that it is specific to this unit. There
are scattered reports of HP ProBook 445 machines freezing/restarting on
battery under Linux, but none with this level of detail.

QUESTIONS
=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Is there a known Cezanne (family 25, model 80) erratum covering data
   fabric sync floods triggered by autonomous CPPC perf-state transitions
   on DC?
2. Is the DC-vs-AC asymmetry expected - does the SMU run a materially
   different perf-state transition policy on DC that could expose this?
3. Would a DMI-matched amd_pstate quirk clamping max_perf on DC be
   acceptable upstream, or is this strictly an AGESA/PMFW fix to route
   through the OEM? Happy to write and test it given a preferred shape.
4. Is there any way to obtain a fabric-side error record on a platform with
   no APEI tables, to identify which agent flooded?

ATTACHMENTS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
evidence.tar.gz contains: full boot ledger of all 13 resets with codes;
per-crash triage summaries; 5 ms-resolution RAPL/hwmon sample sets for the
matched safe-vs-lethal pair and for rows 3 and 5; system inventory.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
