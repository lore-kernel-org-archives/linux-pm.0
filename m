Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663311;
	b=P6km7OOKIYB7ocVPHorndqdz5Xj7P2u/zDa/GQSGLRq8DVi7IxCkauG76Wxp6D/yd/pz
	 Lt7ewCIqLFoa37OagvxIqRA3oPsBOfk4xrN87KIdg9Mjien68Wacs5jj+3r2DZa34aYiz
	 J/iLKOiNC5/3/ZTFIqdQdYhDPxij7XR/5keQvfO2uPbcaUyngFQIxuNK2D2xzvZ49fao/
	 xMeWpxNUtgpMluldneIzUlm7LNgFx5vKrqlrMRdP157bjnzsP1xynnsBUoZrPDvOXWCmL
	 2PE99Zz1dJCaur0L20XakCJpfGZPbNdnzaojMaFKW+drmb52gWOD2qgC9vLRVU6O5eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663311;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=IGU12cZi2tmQMvp1fhf4MEtvE65rIlZACEHRBr3EMUM=;
	b=L1/EoGYFMkftNombaQPVbcolIPKt4yNgo4FJiLIffKnM7UsGjFd6UMmhhZ+GrCakcGOq
	 iplKfZDtcCnHPM6geSoCoBmbWXYIIjvsafFYXTQToLV1uSokLnDH3glSe8U/XPilo49Nj
	 0h5HnPphIFnEkSUC38GEPXT4VQP4uzFFn1Dg5RbThJMa9ty3tGm/7L2XJ4qg11FTcKXGA
	 oPI9Fy2+PyL+putf2+DW9GICWEpmRFvYhInseUe7ZHItMXg6atzlihURiaFZW8UXMBWkn
	 elOQfecGdqeXD8ElfsIkLP/BOTVQeP11UO47j0867O/3zs4+D6KGBDGyGhJKGwLEEEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wvw.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W2KfG5nC;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749D3606A334
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 23:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 749D3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wvw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W2KfG5nC
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eaf3f829b3so36843725ad.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 15:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793663310; x=1794268110; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IGU12cZi2tmQMvp1fhf4MEtvE65rIlZACEHRBr3EMUM=;
        b=W2KfG5nCkXaahHYfdBYaC1C+Tu82n9C0Cs3aOnonE4V1eEw1Gr0v62d6a1UWZwHBsQ
         xhpXUncfov5Sn51QZhe16GrzZalfaOBrrrVGfHYbm9s1CmBwNC5tfHRG/Id8RadVIhVE
         CzZJvwJ6A0viyIBIkc+sBN7VaOcUIm5XIEw5WW0T/AJXSpM8otfwQz0/INSlcHecYIi6
         rOrZ6dig7EdIH2wAHP7P7CD7hy8+JBdTLApTQHiQXq6mAF3578oW2+PsL9vzbakrBMiu
         9WMbmbn9tKyuTYLWUfY1h+MTHb6J+xmheIfTt3rtGa6j0KfCbfLxsZj3Zbycq/t/5Bna
         WDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663310; x=1794268110;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IGU12cZi2tmQMvp1fhf4MEtvE65rIlZACEHRBr3EMUM=;
        b=qk3NH0J1H0DpZtSUXsEBmNRbHJg+2JV9hygcI1d4+sgmZ0aly1jyrZaoS7lWvLVP9p
         GT8aGugrdUKXkcC3ZSzp7qKpqqUzQZHFxY4+qlKod3sjIPaS601HXlmOREvsjVgQjZ5J
         2r96wI8AxXMtGiq/Eeh83MYy04vRSmjgmPb0AbH1k6lp9AIk+slCioAMVazjfi90OMQD
         nZpOjGvUuIzd2rJjmPjFJgZz/85eeHX53Ir9+djKp1XJhLfoHdEC9Q18DZKMk6IH5Rag
         x+QlP9NTiU7fzQLMl/WvyoQr7sKreZduTj79U9qWdEo5ZRCLpYnBHBqe6sUccwPpMj/7
         8vPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsg8yUOXbBmShx51oL+ujuR0MM1G5GeTyGqTXEvcuwY3g3bjLNapAhr1bCaBIJ2pnQF4Gt3tMMQg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9jt5wgW3FTR9EAW8aWDkHrf1RSxxtQ73yaakyX3c67G1a0FXFv
	pYyWFbhnnx/2NZNlVWS+eZ897AK3s1jnjy4LlAcjfl7pPLZlVwNSdRRsIpQ8nk75E8aH8Q==
X-Received: from plil13.prod.google.com ([2002:a17:903:17cd:b0:2eb:515:b000])
 (user=wvw job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2442:b0:2e2:cebe:d811
 with SMTP id d9443c01a7336-2eb3646de8amr99595635ad.46.1793663309587; Mon, 02
 Nov 2026 15:48:29 -0800 (PST)
Date: Mon,  2 Nov 2026 23:48:13 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102234813.1069156-1-wvw@google.com>
Subject: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
From: Wei Wang <wvw@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"

On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread state:
the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kernel
context-switches it eagerly in tls_thread_switch(). While a task is
running, the live register is the only copy of its value.

The architecture defines TPIDR2_EL0 as UNKNOWN after a warm reset, so
a CPU power-down through PSCI CPU_SUSPEND or SYSTEM_SUSPEND can lose it.
cpu_do_suspend() and cpu_do_resume() already preserve TPIDR_EL0 and
TPIDRRO_EL0, but not TPIDR2_EL0.

For CPU idle this is harmless: current is the idle task, and the next
context switch reloads TPIDR2_EL0 from next->thread.tpidr2_el0. For
suspend-to-RAM and hibernation, however, cpu_suspend() runs in the
context of the userspace task that wrote /sys/power/state, and that
task returns to EL0 with an UNKNOWN TPIDR2_EL0. On hardware where the
reset value is non-zero, the next SME ABI lazy-save check in that
thread faults. For example, bionic's fork() -> clone() ->
__arm_za_disable() -> __arm_tpidr2_save() loads from the garbage
pointer:

  # echo mem > /sys/power/state; true
  signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 0xa3bad11bcaf72e93
      x16 a3bad11bcaf72e89
  #00 pc ... libc.so (__arm_tpidr2_save+24)
  #01 pc ... libc.so (__arm_za_disable+32)
  #02 pc ... libc.so (clone+480)
  #03 pc ... libc.so (fork+60)

Having firmware zero TPIDR2_EL0 on warm reset avoids the crash. It is
not enough on its own, though: a thread that enters the kernel with a
lazy save pending (TPIDR2_EL0 pointing at a valid TPIDR2 block) would
see TPIDR2_EL0 == 0 on return. It would then wrongly conclude that ZA
had been committed and restore stale data from its save buffer. The
kernel owns this state and must preserve it.

Save TPIDR2_EL0 in cpu_do_suspend() and restore it in cpu_do_resume()
when SME is present. Placing this in proc.S covers both cpu_suspend()
and hibernation. The new slot uses ctx_regs[14]; sp moves into what was
previously tail padding, so sizeof(struct cpu_suspend_ctx) stays 128
bytes. sp is only accessed through the CPU_CTX_SP asm-offset.

Fixes: a9d691585950 ("arm64/sme: Implement support for TPIDR2")
Signed-off-by: Wei Wang <wvw@google.com>
---
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/mm/proc.S             | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index eb60c9735553..2cc5fb405769 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-#define NR_CTX_REGS 14
+#define NR_CTX_REGS 15
 #define NR_CALLEE_SAVED_REGS 12
 
 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 7afbece885a3..c7b7fa6491c3 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -103,6 +103,10 @@ SYM_FUNC_START(cpu_do_suspend)
 alternative_if ARM64_HAS_TCR2
 	mrs	x2, REG_TCR2_EL1
 	str	x2, [x0, #104]
+alternative_else_nop_endif
+alternative_if ARM64_SME
+	mrs_s	x2, SYS_TPIDR2_EL0
+	str	x2, [x0, #112]
 alternative_else_nop_endif
 	ret
 SYM_FUNC_END(cpu_do_suspend)
@@ -142,6 +146,10 @@ alternative_if ARM64_HAS_TCR2
 	ldr	x2, [x0, #104]
 	msr	REG_TCR2_EL1, x2
 alternative_else_nop_endif
+alternative_if ARM64_SME
+	ldr	x2, [x0, #112]
+	msr_s	SYS_TPIDR2_EL0, x2
+alternative_else_nop_endif
 
 	msr	sctlr_el1, x12
 	set_this_cpu_offset x13
-- 
2.56.0.385.gac671c819a-goog

