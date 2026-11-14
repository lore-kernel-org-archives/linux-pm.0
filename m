Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675418;
	b=MbXd9/XboXrLKwyeWOFNBa6nNKIkuQN5xJFW5vSCePFcV+sbGWuKpk32cDdzxvphGkYF
	 VeNSBwjxHJsg0T7j9enkz8BdLKAQOorXvqnv6K/QQcdjXMOEwENbvDn1yS9h+9VMAFOJ3
	 AWvp9rQKNcc9+Sq+yiE07jmLvuzYcmqO/phjvLmlg9w/JHZm89MKAe4EG2pfTiqn2lTj+
	 /7fLvx8QnJ80MEfymAf88U3uZnMOB13N69ddGWaPGeN8gB7y1lec3wHvOsv2Fpvsw35kf
	 dg6FZwNeWDRfF1btMczWcnJX/rEFxKSnp5xeTey0To8nM3+i5SpecE9hsqQwzpOgzHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uQximJwLYj6Lfa3XenE63rosMCyJlomCN9RTOM5F9N0=;
	b=FWp80dNIyhe0c4L7DaJSEZMWpei5ojov2QgBLlT7owpLqsipeZGuAsCwH7sFtoMgCoB0
	 tbvvWWCIlujLOAmvqYmUlMbeoD8Xe9lHJhXWjUo3o4F79HN441AeW2Ghh8Pjf4fuPBYY2
	 hmDSWPizmc0nLMbVRG6H40gjwKe0Q0DRwAn8aRADqPC4yEjtUKSHn8EMrEwXR9M3jnsUa
	 zsbGXon4rzsrw3CeT5vsD8+RmZXTGBwktCjc+o1fyS0h6JzF45Jr6Gpv/T10vifPVI3gf
	 mKuZONSB7ln3l0vuEPcQB4+OTcqxP0Ab8tc6KaGDbt9VdpUFQYHe7jFExeNf7LYQWOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v6qLJSeg;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82C606A33F
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C82C606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v6qLJSeg
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so21654741fa.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675416; x=1795280216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uQximJwLYj6Lfa3XenE63rosMCyJlomCN9RTOM5F9N0=;
        b=v6qLJSegZUS7+CLnyvtWid+jXPX+TRuUV59RiVKeTXtxdW3D+FcXkAuOxkqSX6PqXl
         9IHY+uifybmWbN5HjO0RxAk/20UW5E2+tDxFBxUoi9xETZQBpZA6hHCL+dvrH5/F2Zdd
         MLcbJL0gDonDQP8BdHzCHC5thlt3xJfeIJTq+aAPp2yMgJngBq+C34FcjCtW0uqgBbe3
         MaW9GrvGFWnzo9sjTAQkksHa93nm1KKpYup0RaxlqwtB05YQIaO73rRmKe0FVGs2Cz5b
         qka7dUz8g4F95OKhTlg31u9vp35WXZFX4nq94RVy6Jhh4F35XE3S5I1qcmm/ocomT3Fg
         F0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675416; x=1795280216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uQximJwLYj6Lfa3XenE63rosMCyJlomCN9RTOM5F9N0=;
        b=qLyi+/PyBXfkf+ugpJAWn4K31mtAlp33apVMPDXVn/MSrq6f/LEYIY5hvGWH4R39QY
         hzBlaQoLlzm36mA7vid5IgxPeXd81TGtzrwDwuk11PNITqgBqdqdblr+DX6QgsAuugl4
         HDI00OHRF4/qpH7W3JzVSRu49kxoFee0jTvQUSVlsJaRL+ozGyrPIeTrOW0n6EAn5cL6
         4MTiSraTW7u+UjwlmFUWaEubpd1kYu2iBpXwD2PwcBUj+qi1uklznK/EXLcLxroTAejv
         M04nwQExO6w5I8Fcpv5nskbizvNglWMdfLiJEONdf+cOAOHCIeGcF3Rm82OOP+sUl3Hw
         rnPw==
X-Forwarded-Encrypted: i=1; AL+hErG5hjSjLcMIKdn63mZQuMGQlGh9v0mQqTS6OckH6i73rNUb/xyZp8JHD0WnUzJqVAjpqALZOMGWLA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9ge5Q6mo/Lnm1iJkLth3zLHYQPb4DSwaWdNlYUmWlG1bey0Z37
	9h7wJv0A03rFuLdSb1zw7VBE3UX7+wK49jcmQcXS/phh1H+rXZF+F22p
X-Gm-Gg: AYBFou0FY9VTABZ/yGJpPOB6Qwohndm6iQaM2ffJ7MXWZ8WFi095NxE0+FPff59YGKk
	JFkZka2wNMkJoBhB7Cdbu0FCz9bHyoGflBLaUNc8YIpsqOMa0wD4lmQ6vrjC/F0yrRyFT51DxM3
	2Yg9bkHbTMkz5UqJn+SZq8pQnt2hvjaVY69jThf0tmhN6RZItLoZx9nbzhDhhn7xcr+tTtg7EMz
	tOkIJLtJAMRsbHp3fSmSgTzE59+s7L4Kt6AEvbhBRCYKHypqT5DJWia5Oasv6DwOhVvPEdwve/7
	4vZivUOdsw/+tBTjnhgkV01mMPvFiWFOEioo5ctJgJ1fak8URDWZcOsY/0qxvm1bntu6wSrTxh5
	qPRsj+JGsAemO217oBphr7RGDZdBwQySTmm/gHymOdJnjk23maHjvmQY25bT8DEsTfy7qJznZXa
	QahxueFdmBe/FOhQwAj22nb9jAFU6XIFi0BwcFrl8knPgP4WKHJDOOW2A7Qxj1VVA/YS98OBLwJ
	wZIWx+ZWA2GGao4sXlH7rr0P86zgNs7N5VCW2K+jpS027JL7j2x3OMeZhhy/U4DHkjJ1Qb8cv5u
	C4XdRLBkn1Pv3VpwsvqZEhKGQOWiSI70KCJoiZl9ihJ31eo4RKYhvDkMC9oJ3iv1zrrIUGPcr6W
	7q2qPGkiRQg==
X-Received: by 2002:a05:651c:b22:b0:3a6:95a:52a6 with SMTP id 38308e7fff4ca-3ae2b51fa1bmr19487401fa.20.1794675416400;
        Sat, 14 Nov 2026 08:56:56 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad26sm1792051e87.8.2026.11.14.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:56:56 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: [PATCH v3 07/14] x86: fix duplicate extern declarations
Date: Sat, 14 Nov 2026 20:55:47 +0400
Message-ID: <20261114165612.368785-8-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114165612.368785-1-safocl88@gmail.com>
References: <20261114165612.368785-1-safocl88@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling a kernel module with a C++ compiler results in a "duplicate
extern specifier" error.
This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
expands to `extern C` when processed by a C++ compiler.
Since the code already contains sections that respond to a C++ compiler,
I believe it is a perfectly valid approach to gradually move toward a state
where kernel modules can be compiled by a C++ compiler without any issues.
The `extern` specifier must be removed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257
Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 arch/x86/include/asm/efi.h       | 2 +-
 arch/x86/include/asm/gsseg.h     | 2 +-
 arch/x86/include/asm/preempt.h   | 8 ++++----
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/include/asm/suspend.h   | 2 +-
 arch/x86/um/sys_call_table_32.c  | 4 ++--
 arch/x86/um/sys_call_table_64.c  | 4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index be58b7f5c..f5cb179b8 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -94,7 +94,7 @@ static inline void efi_fpu_end(void)
 #else /* !CONFIG_X86_32 */
 #define EFI_X86_KERNEL_ALLOC_LIMIT		EFI_ALLOC_LIMIT
 
-extern asmlinkage u64 __efi_call(void *fp, ...);
+asmlinkage u64 __efi_call(void *fp, ...);
 
 extern bool efi_disable_ibt_for_runtime;
 
diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
index ab6a595ce..81ef16081 100644
--- a/arch/x86/include/asm/gsseg.h
+++ b/arch/x86/include/asm/gsseg.h
@@ -12,7 +12,7 @@
 
 #ifdef CONFIG_X86_64
 
-extern asmlinkage void asm_load_gs_index(u16 selector);
+asmlinkage void asm_load_gs_index(u16 selector);
 
 /* Replace with "lkgs %di" once binutils support LKGS instruction */
 #define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index d16d9c2f7..135695ae3 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -134,11 +134,11 @@ static __always_inline bool should_resched(int preempt_offset)
 
 #ifdef CONFIG_PREEMPTION
 
-extern asmlinkage void preempt_schedule(void);
-extern asmlinkage void preempt_schedule_thunk(void);
+asmlinkage void preempt_schedule(void);
+asmlinkage void preempt_schedule_thunk(void);
 
-extern asmlinkage void preempt_schedule_notrace(void);
-extern asmlinkage void preempt_schedule_notrace_thunk(void);
+asmlinkage void preempt_schedule_notrace(void);
+asmlinkage void preempt_schedule_notrace_thunk(void);
 
 #define __preempt_schedule() \
 	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 77488ff5e..68d7292af 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -455,7 +455,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 #endif
 }
 
-extern asmlinkage void entry_SYSCALL32_ignore(void);
+asmlinkage void entry_SYSCALL32_ignore(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
diff --git a/arch/x86/include/asm/suspend.h b/arch/x86/include/asm/suspend.h
index a892494ca..e29c071b9 100644
--- a/arch/x86/include/asm/suspend.h
+++ b/arch/x86/include/asm/suspend.h
@@ -11,4 +11,4 @@ extern unsigned long temp_pgt __visible;
 extern unsigned long relocated_restore_code __visible;
 extern int relocate_restore_code(void);
 /* Defined in hibernate_asm_32/64.S */
-extern asmlinkage __visible int restore_image(void);
+asmlinkage __visible int restore_image(void);
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 51655133e..f79c0138e 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -9,7 +9,7 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
+asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 				      unsigned long, unsigned long,
 				      unsigned long, unsigned long);
 
@@ -28,7 +28,7 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
 #define __SYSCALL_NORETURN __SYSCALL
 
-#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL(nr, sym) asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_32.h>
 #undef  __SYSCALL
 
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index 943d414f2..555e65e66 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -9,7 +9,7 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
+asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 				      unsigned long, unsigned long,
 				      unsigned long, unsigned long);
 
@@ -24,7 +24,7 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
 
 #define __SYSCALL_NORETURN __SYSCALL
 
-#define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#define __SYSCALL(nr, sym) asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
 #undef  __SYSCALL
 
-- 
2.56.1

