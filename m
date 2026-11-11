Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439602;
	b=ugnKPcfaGJYwNTS3OZFeKSboje4yIv9MzCmvX/5DYApcX2GqYcHOD0fTWiu9TcwrutTB
	 yDcGCeN1bdA5VjbaCGVUNEAG+YVh9aZBVLc9dLS/ZQZ04J06n/yegJpR/jw2nmMUC9ULU
	 TsgQH8TUasinGBgvdoiIEsxdWHOpTMyvymaLim1g1LvZvSk755qLZXNSFl8++xDywIVaw
	 gjHI6Ut+IrqI4locxnaidcMl1a2r5r4dHWW+55A3AbTv8/yUPuCgbzAYlQg266Csgei2N
	 LqHBKlMJXmWHW/64D4XAAXaeFEKMXIYfm0DInxoKZz3tSoJ1YoOxbR1lP4vxSo9VanQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439602;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:To:Cc:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id:
	 In-Reply-To:References;
	bh=WahUUMKEHUeaMrdXRtQv7EG1eIBXgpGshBhrE00jyNM=;
	b=eCBz9gbdtjB300w5Oe6ypETuNo4xzS93vQlQGKtKq2+CsdRhM+ry1lLFUfwTF0FRNQ8F
	 BE9l0RxXWa7nJyc2/GBX12wz7J2guJY7VGmX3Bcc9adhubkAuBkSSHaUkYc3svvBJXt39
	 pfBPF3xHiYDtyp9NFK35TfwmBwRVi+KprVW8q3UWmCvRu8uU/aAv25xGnbPnzdhDPZw5c
	 bialGJ3poaVdxUUjScsUhCtXkl19dFDDCEGcoRieuHhqm1Iex2c8a3n4DheWZtxb6e0AX
	 geyltNFg9jXAkpQCDPAeUUOHsO+brJf1iL+PgKrw7WVsJd9oT17nifWS8gWuxioNkQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cressey.dev;
	spf=pass smtp.mailfrom=cressey.dev;
	dkim=pass header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=RigteQrK;
	arc=none smtp.remote-ip=95.215.58.74
Received: from mta1.migadu.com (out-74.mta1.migadu.com [95.215.58.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A12606A33D
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 23:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A12606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cressey.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cressey.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cressey.dev header.i=@cressey.dev header.a=rsa-sha256 header.s=key1 header.b=RigteQrK
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=h5LWrU32M/8PYtvSz81JoK1EB8yX4lPH2icFhRh33Xs=;
 c=simple/simple; d=cressey.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794439599; v=1; x=1795044399;
 b=RigteQrK5VRm8azwDsH8qyHTX2/2fk3BXo9EfMKxRJv1QEwTDwnhCMbq20cGOs3XkiRJHWOg
 4h/MDlGgwCdOXRrzYU4Oyf1WHE6KFhE30qrAVgOAmfrwx1KgyeA/ubmUEFuhu8wb17Da+ofndQV
 G7BZtRkHHD+vFY+2VNrUh4PKGn37HWM7XoqZ/ObCW4FEwKzVk21gq3XuAj/2har+9l2A4Fanh85
 VQmj4YaaoVTASX6n1BYu7pr869enVe31ZfXMKkVkwwpoEc1KkwrgEuTgg5GWIhUNs5WwPMUNjPU
 3jCskbfZFJ0RBdhHY131FUdf1mcK46+gPa/05pVz8V+3w==
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4d58726ca1813656;
	Wed, 11 Nov 2026 23:26:39 +0000
X-Mizu-Trace-ID: 4d58726ca1813656
X-Migadu-Flow: FLOW_OUT
From: Ben Cressey <ben@cressey.dev>
Subject: [PATCH v2 2/2] arm64: hibernate: use a typed entry to drop __nocfi
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, 
 llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
 Jeson Gao <jeson.gao@unisoc.com>
X-Mailer: b4 0.15.2
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Nov 2026 15:26:05 -0800
Message-Id: <20261111-arm64-kexec-nocfi-v2-2-ddf0c4aa326f@cressey.dev>
In-Reply-To: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>
References: <20261111-arm64-kexec-nocfi-v2-0-ddf0c4aa326f@cressey.dev>

swsusp_arch_resume() calls the safe page's copy of
swsusp_arch_suspend_exit() indirectly, without a kCFI check. The MMU is
on at the call and TTBR0 maps only that page. The copy starts at the
page's first byte, so the check's load of the type hash in front of it
would fault. SYM_CODE_START() also gives the routine no hash.
Commit e2f8216ca2d8 ("arm64: Set __nocfi on swsusp_arch_resume()")
disabled the check "for now", since the entry had to be first
in .hibernate_exit.text.

SYM_TYPED_FUNC_START() emits the hash inside that section, and
create_safe_exec_page() already copies the whole section, at most 4 KiB,
to the page's start, so the page holds both hash and entry. Relax the
linker script's ASSERT, so the entry need only be in the section.

Fix by typing the routine, with a C prototype, entering the copy at the
symbol's offset in the section, and dropping __nocfi.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/linux-arm-kernel/arZSe8hNnRPM5FqY@J2N7QTR9R3.cambridge.arm.com/
Signed-off-by: Ben Cressey <ben@cressey.dev>
---
 arch/arm64/include/asm/suspend.h  |  5 +++++
 arch/arm64/kernel/hibernate-asm.S |  7 +++++--
 arch/arm64/kernel/hibernate.c     | 14 +++++++++-----
 arch/arm64/kernel/vmlinux.lds.S   |  5 +++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index e9ce68d50ba4..e75aa3681414 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -45,6 +45,11 @@ void _cpu_resume(void);
 
 int swsusp_arch_suspend(void);
 int swsusp_arch_resume(void);
+void __noreturn swsusp_arch_suspend_exit(phys_addr_t tmp_pg_dir,
+					 phys_addr_t ttbr1_el1,
+					 void *reenter_kernel, void *pblist,
+					 phys_addr_t hyp_stub_vectors,
+					 phys_addr_t zero_page);
 int arch_hibernation_header_save(void *addr, unsigned int max_size);
 int arch_hibernation_header_restore(void *addr);
 
diff --git a/arch/arm64/kernel/hibernate-asm.S b/arch/arm64/kernel/hibernate-asm.S
index 2baefe7a82d3..ef8c0b926dcb 100644
--- a/arch/arm64/kernel/hibernate-asm.S
+++ b/arch/arm64/kernel/hibernate-asm.S
@@ -6,6 +6,7 @@
  * Author:	James Morse <james.morse@arm.com>
  */
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <linux/errno.h>
 
 #include <asm/asm-offsets.h>
@@ -31,6 +32,8 @@
  * switches to a copy of the linear map in ttbr1, performs the restore, then
  * switches ttbr1 to the original kernel's swapper_pg_dir.
  *
+ * Called indirectly by swsusp_arch_resume(), this code needs a kCFI type hash.
+ *
  * All of memory gets written to, including code. We need to clean the kernel
  * text to the Point of Coherence (PoC) before secondary cores can be booted.
  * Because the kernel modules and executable pages mapped to user space are
@@ -45,7 +48,7 @@
  * x5: physical address of a  zero page that remains zero after resume
  */
 .pushsection    ".hibernate_exit.text", "ax"
-SYM_CODE_START(swsusp_arch_suspend_exit)
+SYM_TYPED_FUNC_START(swsusp_arch_suspend_exit)
 	/*
 	 * We execute from ttbr0, change ttbr1 to our copied linear map tables
 	 * with a break-before-make via the zero page
@@ -93,5 +96,5 @@ alternative_insn "dc cvau, x4",  "dc civac, x4",  ARM64_WORKAROUND_CLEAN_CACHE
 	mov	x0, #HVC_SET_VECTORS
 	hvc	#0
 3:	ret
-SYM_CODE_END(swsusp_arch_suspend_exit)
+SYM_FUNC_END(swsusp_arch_suspend_exit)
 .popsection
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 8c39863d2d63..d5a066ece8b2 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -418,15 +418,15 @@ int swsusp_arch_suspend(void)
  * Memory allocated by get_safe_page() will be dealt with by the hibernate code,
  * we don't need to free it here.
  */
-int __nocfi swsusp_arch_resume(void)
+int swsusp_arch_resume(void)
 {
 	int rc;
 	void *zero_page;
 	size_t exit_size;
 	pgd_t *tmp_pg_dir;
 	phys_addr_t el2_vectors;
-	void __noreturn (*hibernate_exit)(phys_addr_t, phys_addr_t, void *,
-					  void *, phys_addr_t, phys_addr_t);
+	phys_addr_t exit_page;
+	typeof(swsusp_arch_suspend_exit) *hibernate_exit;
 	struct trans_pgd_info trans_info = {
 		.trans_alloc_page	= hibernate_page_alloc,
 		.trans_alloc_arg	= (__force void *)GFP_ATOMIC,
@@ -463,14 +463,18 @@ int __nocfi swsusp_arch_resume(void)
 	exit_size = __hibernate_exit_text_end - __hibernate_exit_text_start;
 	/*
 	 * Copy swsusp_arch_suspend_exit() to a safe page. This will generate
-	 * a new set of ttbr0 page tables and load them.
+	 * a new set of ttbr0 page tables and load them. The whole section is
+	 * copied: a kCFI hash may precede the entry point.
 	 */
 	rc = create_safe_exec_page(__hibernate_exit_text_start, exit_size,
-				   (phys_addr_t *)&hibernate_exit);
+				   &exit_page);
 	if (rc) {
 		pr_err("Failed to create safe executable page for hibernate_exit code.\n");
 		return rc;
 	}
+	hibernate_exit = (void *)(exit_page +
+				  ((unsigned long)swsusp_arch_suspend_exit -
+				   (unsigned long)__hibernate_exit_text_start));
 
 	/*
 	 * KASLR will cause the el2 vectors to be in a different location in
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index c95243a8b24e..641074a6e6ca 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -412,8 +412,9 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 #ifdef CONFIG_HIBERNATION
 ASSERT(__hibernate_exit_text_end - __hibernate_exit_text_start <= SZ_4K,
        "Hibernate exit text is bigger than 4 KiB")
-ASSERT(__hibernate_exit_text_start == swsusp_arch_suspend_exit,
-       "Hibernate exit text does not start with swsusp_arch_suspend_exit")
+ASSERT(swsusp_arch_suspend_exit >= __hibernate_exit_text_start &&
+       swsusp_arch_suspend_exit < __hibernate_exit_text_end,
+       "Hibernate exit text does not contain swsusp_arch_suspend_exit")
 #endif
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 ASSERT((__entry_tramp_text_end - __entry_tramp_text_start) <= 3*PAGE_SIZE,

-- 
2.56.0

