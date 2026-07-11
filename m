Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCDF357CE6
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783755154; cv=none; b=FOFhREEUmGMNcyGuf0CCXxRaeXDJWeLxEKrbSQACB6qmXfkGp02ef8bgvWFaunCtA9gcH9wmS9WNp2jzdCxszezPsMSZRBvxeMGbDHZN3iXKKvorRSepSh/EwqEdhVRR3qj6PPClsw8VQSlVJ5+6SBA17/8wC3mdctfLbrVhBPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783755154; c=relaxed/simple;
	bh=gDFnsT6vHAeD1duHVWazIcctdvHeRJkqlI7n2bV4WAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M5+U1ZS4XYIhXjLhy4quWMYs4rP+MpVb161v5anWMmsFO6qZfuWLxP0Tg3C2QezAOSB8WRXyP/kLBMoN8Pa5dd6C+QP5F/LyNJjwJaafSYLpzOYfn/1HpJm2HENCPYqiBv+JS2jKG60xr9HpexZX5sb6Q9FlAC0/b7GJnPWg1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWcqgS8l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWcqgS8l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D311C2BCB9
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 07:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783755154;
	bh=gDFnsT6vHAeD1duHVWazIcctdvHeRJkqlI7n2bV4WAc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=YWcqgS8lTZgu3Ok/t7e5e4b2ul2bwGEo85MaU36JPhZ4AzTyKGwO46paoe5gBruKT
	 6CZMbEA1dxdzIncWcfFetZ8x8TAF+VoRj1fS7YOhK6Ogo8f1y9T8zUrazkLlbkYCoa
	 KODbRTUdqPL0ctv9gvtIGej1zmyIv/xskc3x9K6CZd+fygr8+FGcdDvSugyWo40PqA
	 /gF9ZlRnLggUppAky5VdVr5uPmUqSVARFQz+oioRrgXHWnTjRYNnaBGCVqpkmtG5Wp
	 1V7vED57J7hFTFpm5ceWgnTNRs16ntwCfvNScohTaGMab7MUiA1CEzplEKROMCJnJK
	 sPUxmeJzs5RPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 46D65C41613; Sat, 11 Jul 2026 07:32:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221744] amd_pstate / ACPI: CPU frequency locked at 520MHz when
 AC disconnected with lid closed during s2idle on HP EliteBook 6 G1ah 14
Date: Sat, 11 Jul 2026 07:32:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pepegnu@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221744-137361-63zrfkVS8k@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221744-137361@https.bugzilla.kernel.org/>
References: <bug-221744-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221744

--- Comment #1 from pepegnu@gmail.com ---
Should probably add CPU-info:

lshw -C processor

  *-cpu
       product: AMD Ryzen 5 220 w/ Radeon 740M Graphics
       vendor: Advanced Micro Devices [AMD]
       physical id: 1
       bus info: cpu@0
       version: 25.124.0
       size: 1117MHz
       capacity: 4979MHz
       width: 64 bits
       capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 ap=
ic
sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmx=
ext
fxsr_opt pdpe1gb rdtscp x86-64 constant_tsc rep_good amd_lbr_v2 nopl xtopol=
ogy
nonstop_tsc cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 f=
ma
cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm
cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw =
ibs
skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx
cpuid_fault cpb cat_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp
ibrs_enhanced vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a
avx512f avx512dq rdseed adx smap avx512ifma clflushopt clwb avx512cd sha_ni
avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc
cqm_mbm_total cqm_mbm_local user_shstk avx512_bf16 clzero irperf xsaveerptr
rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
flushbyasid decodeassists pausefilter pfthreshold vgif x2avic v_spec_ctrl v=
nmi
avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni
avx512_bitalg avx512_vpopcntdq rdpid overflow_recov succor smca fsrm flush_=
l1d
amd_lbr_pmc_freeze cpufreq
       configuration: microcode=3D175161354

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
