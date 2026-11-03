Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728800;
	b=R+3vehu9FXntSYJjINjiVYPKSS4LviB/ApGkPJ4TVy0p5lEpMXl37JpYzp1d4o8ufVmE
	 6aRc629gCjrvjnDLeePpBfZUY65YlGvTl3IBbYNqcjf7iyrEbg1J2VFmOkfcf3IIkQZLi
	 qRhP2e0j3/cAVwQGQ3qJU48eUB0dAuJRXKm2LpPaAwxXb/Aj3+VGjoHhj/41s8KQthhCn
	 cY/klIcLxNCcUwS4KPHKPMH4kCZ5NtQGAp3ZM2mcQwqNijLw2PaxtVdl1qTGfb7yjyh3A
	 6nLm0yaMQSgq2uhOp2n+/X2mdbpe2aSPRo6rkA60u+e2heozvUlQtj5F8KFcNTZN1Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=FPwct+1U9T6oyA5Ruuz5LB/HvShMdpdhhsQD4HMVAhg=;
	b=R4qPamvUqL5tEHMZ2gsypjStACV2p3w5r/eWWYK2TmNVv56C1OZ0wH3xfNJ2WP9xXj6h
	 EteVwDIgyOggM+5GB4dk3etHw9St1PRGVhuvG0bBhs17RDKrySxspVWDyHVi4cboKDF8k
	 moPGhdruKlxZHe4lVUrwloV2zSLSNLwCdidGYdeT0YaeQgmbKP7WdZfPZmLPgZFARR1d8
	 BMAPR56nj6QsfKUjkaJLL01NKU3RVwUAiCX5KED71V2OougsQngoxmFdBAiS2PkpuW2fv
	 tpMFwqst9rzCTSS7EDmtDoPiFJwEuQEZ8bl7kp18w2T3HxmkhSB5NmwxseDZEFUQGcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wvw.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oKWTE9wx;
	arc=none smtp.remote-ip=209.85.214.200
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2992606D802
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 17:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2992606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wvw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oKWTE9wx
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2e93e2f72bfso70509495ad.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 09:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793728794; x=1794333594; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FPwct+1U9T6oyA5Ruuz5LB/HvShMdpdhhsQD4HMVAhg=;
        b=oKWTE9wxvvkr6zCRmGOi7MD8BifRNWWeKWlQl288hGhFeyWHixUsNw7NTaikjfsx+E
         fl/68xwPzPUk2e/UEBmVVs41KowLq0QtKlvhIc47QqPmeD0M1otau9oULB6BOFOgWXIu
         5aVDEyLHY+EYQ0QJKkPWr1Ja0np0kBEm1xdQKdlv295PWhkpy4fDI/snUTgmU7qN0epA
         4wbVCoPw/xuYj/dhulM1DJVJxN3lD3yr16y0rwkMyt+0EaHFjkF5fr1M91lTR+AHIsda
         xaTQtNbiTAHCX4YmdvieCD8sC52zOSmqojGRDrTuu6Z4YmnDC4wgjuZ9AUqzWcUPF740
         OhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728794; x=1794333594;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FPwct+1U9T6oyA5Ruuz5LB/HvShMdpdhhsQD4HMVAhg=;
        b=sYg/48ySKJYeJZHj0joDYq46HRLV6HTbmycnShJ8Q52wbEOOeXkLO6m7kd5H7CUnxd
         g/wDUe9CYTW826Nn1B9mmXlUWYq8hVtNXDAnOgBRM3ryFIHZoUPSBxFeK3XYm1o8wUZ7
         MvlmeT1xLxD6LGsnTcyGenI9Wxo23oQSh4+iKkTk3xgVkMrXh4tjZyJLEj9E7EjtijiF
         8GDspc2kt9Nf4LLHslDA3NWGn1n81o9rfJ4WiKqasIkfYM4TrOKe5PAk2J3AX++AaKaZ
         lpqTYJzbhKqFsXHm67yCfhtfymeOzF+WQtuV+wgSXoj+xV1olzRN/yzrfl0cqNWyPKOv
         MZ/g==
X-Forwarded-Encrypted: i=1; AKwUvByR0mpMPyvO0NkYd4vaBuTD6xWsHZOUmXQtvzgS7j+oSCsNGPnlNEy0jJW3VDjWnYT6ScmQ+E8EIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+xjAuexlKF52FibiEmZREvgDiV7quzBZh/O9aX77ZS+ul7ID7A
	BOU6qrp/SKYoElubMRof+75NMHGLCvLJSLdyVs7JVwBso5BQG5xCqTijUlVV3T7mQVVqEw==
X-Received: from pggs9.prod.google.com ([2002:a63:dc09:0:b0:ccb:62e:3f01])
 (user=wvw job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b0d:b0:3ac:9e5e:d1a9
 with SMTP id 98e67ed59e1d1-3ae897ec5b1mr11095151a91.20.1793728793847; Tue, 03
 Nov 2026 09:59:53 -0800 (PST)
Date: Tue,  3 Nov 2026 17:59:41 +0000
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
Message-ID: <20261103175941.1349818-1-wvw@google.com>
Subject: [PATCH v2] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
From: Wei Wang <wvw@google.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: broonie@kernel.org, mark.rutland@arm.com, rafael@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wei.vince.wang@gmail.com, 
	stable@vger.kernel.org, Wei Wang <wvw@google.com>
Content-Type: text/plain; charset="UTF-8"

TPIDR2_EL0 is a live EL0 register on systems with SME, but
cpu_do_suspend()/cpu_do_resume() don't preserve it. Its value is
UNKNOWN after a warm reset, so the task that initiates suspend can
return to userspace with a corrupted TPIDR2_EL0.

Save and restore it alongside TPIDR_EL0 and TPIDRRO_EL0. The new slot
fits in existing padding, so sizeof(struct cpu_suspend_ctx) is
unchanged.

Fixes: a9d691585950 ("arm64/sme: Implement support for TPIDR2")
Cc: stable@vger.kernel.org
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Wei Wang <wvw@google.com>
---
v2:
 - Trim commit message (Will)
 - Keep mrs_s/msr_s as TPIDR2_EL0 isn't in tools/sysreg yet (Catalin)
 - Collect Acked-by/Reviewed-by tags
v1: https://lore.kernel.org/r/20261102234813.1069156-1-wvw@google.com

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

