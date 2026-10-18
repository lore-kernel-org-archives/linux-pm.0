Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D2E346AED
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792358714; cv=none; b=OeKZX26Tx6kxwBQk63nnzDTYGqr1nDKY7Ohevxc1dvrG2c2PMXZXMmSIwPJ5EHr4tzfBnIzROI/EfYigvL2hULQiehrFpMQXsXNC7mqvIQaYAsf9pZUh4nKP7ishbtyHdxdhtFhZlznQcj6TPDGpn55AlgK2svpszvEaOXMgMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792358714; c=relaxed/simple;
	bh=EoIQigilf4qWtB6I3ofCQHfnw8IvdafcRor5iIpoidY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yc+rL6VG9qzalHB4TbJabT5/fgNHtanBdXhNtW7a3PNGCe8GIH8APyTiTI3T0K5+vH7NCoQAUMvk6s/42LLhYy/AoGJG8Y8zaWnc2GcH/mSr9vHSl2IJgNDNm3eSsJDaYpZYTQDF+PExMEK0ZlDe+lgZrH3Af7O4TcM7ZnyiKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBWEyrx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBWEyrx2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CAA2C2BCC7
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 21:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792358714;
	bh=EoIQigilf4qWtB6I3ofCQHfnw8IvdafcRor5iIpoidY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EBWEyrx2jGBOha5SEw5SgeBNcyoChM67qdMqARp/f6jvlQN7/DKlxqYNpxpiVcVvr
	 lWRct5pHBjLJ35BAS1mdcSHrvN1XtnF31cNiufA+LFtW1LAZExNRvoKxDOT1XdXWHs
	 SIJEBKGxjPXqh4QEF8IBVxF2+M1m37aCEdnRS/npLnM2rAEvD2mtiRa5MBMeTzFP0G
	 7c7nhnEp+P/TXVXuUm4rYh9ta9c450OQfxC1I/Gcmzc/WaXQ1QzsJ/JdXRT43TwtwP
	 kr769+rPSxjepkULt/m27O7B5cLQwDF2h35Yzto8E98A+j7OrXm/Qoo10ZUQuzbZLa
	 1LAmHD0LiYyLg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 4DA33C41612; Sun, 18 Oct 2026 21:25:14 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 222146] 6.18: AMD (Ryzen 5): cannot select existing
 energy_performance_preference
Date: Sun, 18 Oct 2026 21:25:14 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steffen@sdaoden.eu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INSUFFICIENT_DATA
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222146-137361-LZU6ExyLqC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222146-137361@https.bugzilla.kernel.org/>
References: <bug-222146-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222146

--- Comment #3 from Steffen Nurpmeso (steffen@sdaoden.eu) ---
merde, of course you can have full lscpu or whatever you want!!
Thanks, indeed.
(I was only sad because of that AMD "territorial pissing" as via
  lid_exists() {
        if [ -z "$LID" ]; then
                # Documentation/firmware-guide/acpi/acpi-lid.rst
                LID=3D/proc/acpi/button/lid/LID0/state
                [ -f "$LID" ] && return 0
                # amd ryzen 5 220, linux 6.18
                LID=3D/proc/acpi/button/lid/LID/state
                [ -f "$LID" ] && return 0
                LID=3D.
        fi
        [ "$LID" !=3D . ]
  }
Cool that really someone deals with bugzilla!!!)


Architecture:                x86_64
  CPU op-mode(s):            32-bit, 64-bit
  Address sizes:             48 bits physical, 48 bits virtual
  Byte Order:                Little Endian
CPU(s):                      12
  On-line CPU(s) list:       0-10:2
  Off-line CPU(s) list:      1-11:2
Vendor ID:                   AuthenticAMD
  Model name:                AMD Ryzen 5 220 w/ Radeon 740M Graphics
    CPU family:              25
    Model:                   124
    Thread(s) per core:      1
    Core(s) per socket:      6
    Socket(s):               1
    Stepping:                0
    Microcode version:       0xa70c00a
    Frequency boost:         enabled
    CPU(s) scaling MHz:      39%
    CPU max MHz:             3201.0000
    CPU min MHz:             406.4770
    BogoMIPS:                6390.28
    Flags:                   fpu vme de pse tsc msr pae mce cx8 apic sep mt=
rr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_=
opt
pdpe1gb rdtscp lm constant_tsc rep
                             _good amd_lbr_v2 nopl xtopology nonstop_tsc cp=
uid
extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse=
4_2
x2apic movbe popcnt aes xsave avx
                              f16c rdrand lahf_lm cmp_legacy svm extapic
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topo=
ext
perfctr_core perfctr_nb bpext perfctr_l
                             lc mwaitx cpuid_fault cpb cat_l3 cdp_l3 hw_pst=
ate
ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgsbase bmi1 avx2
smep bmi2 erms invpcid cqm rdt_a av
                             x512f avx512dq rdseed adx smap avx512ifma
clflushopt clwb avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec xgetbv1
xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm
                             _mbm_local avx512_bf16 clzero irperf xsaveerptr
rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pf
                             threshold vgif x2avic v_spec_ctrl vnmi avx512v=
bmi
umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg
avx512_vpopcntdq rdpid overflow_recov
                              succor smca fsrm flush_l1d amd_lbr_pmc_freeze
Virtualization features:
  Virtualization:            AMD-V
Caches (sum of all):
  L1d:                       192 KiB (6 instances)
  L1i:                       192 KiB (6 instances)
  L2:                        6 MiB (6 instances)
  L3:                        16 MiB (1 instance)
NUMA:
  NUMA node(s):              1
  NUMA node0 CPU(s):         0-10:2
Vulnerabilities:
  Gather data sampling:      Not affected
  Ghostwrite:                Not affected
  Indirect target selection: Not affected
  Itlb multihit:             Not affected
  L1tf:                      Not affected
  Mds:                       Not affected
  Meltdown:                  Not affected
  Mmio stale data:           Not affected
  Old microcode:             Not affected
  Reg file data sampling:    Not affected
  Retbleed:                  Not affected
  Spec rstack overflow:      Vulnerable
  Spec store bypass:         Mitigation; Speculative Store Bypass disabled =
via
prctl
  Spectre v1:                Mitigation; usercopy/swapgs barriers and __user
pointer sanitization
  Spectre v2:                Mitigation; Enhanced / Automatic IBRS; IBPB
conditional; STIBP always-on; PBRSB-eIBRS Not affected; BHI Not affected
  Srbds:                     Not affected
  Tsa:                       Mitigation; Clear CPU buffers
  Tsx async abort:           Not affected
  Vmscape:                   Mitigation; IBPB before exit to userspace

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
