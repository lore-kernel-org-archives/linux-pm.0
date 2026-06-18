Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CB5266B72
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 22:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781822744; cv=none; b=EzCq9kPcwE+xkfND1A5X4zrmyVunBX7SX0DvpYdk4oQyvKkgGG1yQz5xr7E5t1HJpLIynWaK8+w7ltxmkF5brvlwcvuWTOPKJ7FnFHR+Q2ARRoV4jCw7cslc9zI4ZDdKfA6bR5AMMDBzHOgB/ViR9u8kR9sDvky+AM2oPfZai2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781822744; c=relaxed/simple;
	bh=HJ6jYaBiUSKlmb612+8ChGK1bTb+QE/WZi4XVojwBc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhD//BW47aUy8GL6NWnkBYyBtqR3X77s+m1DoyrJrJH8yR/GtlceBBFae5S/VC+1p1ePEvZd3QZ7XMlEXnINAlVeyP66ifHjmKt1Zxgy7hqzZthGmZrN10mqiVdpOuw1hqguUGXjyVRFXNtiLYV6ApZpLQaG/l/NnIUtKDSWbkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cJqdLwWa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cJqdLwWa"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c890bac374eso1832512a12.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781822742; x=1782427542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f7dHA+nx3O9qXKX/SBLZ26Q42jziy/Oaldb2t+XOIEA=;
        b=cJqdLwWaf5kfj4kR2Tm0xGLMidToUIAVl4vsweruUrEdyz8jaHCpw8FzVRHUEzOZlW
         TY6ZAXa603hSRd1x50vJ4SDDq1SmdDhGQdyQuJyAng2tnRkkl9PEo98sTPTOTwI6Hzsj
         ZyxE81U9/xP0/ZQXahV+fXxgE0pJZVs4p4NAwJRgWgSflWyscBiNYwXHbgzKXuM7l3kM
         FkUAu2EpeO2kXUNEJGXsn6MSUAKt6bpLN50SJ5ZQnMgj5Ir95oWWxO/6Xj/huVQr75rv
         YRS/TT6aJMeZ4dtvvFRZZu0DcJ8ElcfhGZzQj6km2zUapnooZVMpzsA176WfTET2cgnG
         dbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781822742; x=1782427542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7dHA+nx3O9qXKX/SBLZ26Q42jziy/Oaldb2t+XOIEA=;
        b=j1kEEt1KP3gz/PxdPJPISvo/w+nYlFMrIWHRRMZY7DUPlaOKsfcjpZmKMlcTqgpznt
         VSl9qAlx4E4p3stiQiZ0X9SSozbEikpd4SiV5rggW9QmIEZXc5efeIpdb/C+6c4IACXi
         RGilBKByxOk89rabtCg1oosQsuyue4lGXmo1mekkBLRMSn8L/Ix5P8OhKenXkgGGn/E8
         yIQ0qgLEJZ42xVaiE+I7HET1L1e0aR2POsFdV3DO8SZdTCOKAPjWkAAHLCiu7nSzrVd/
         XJrRkukwki560lHayxA2BOg/uLOFuy788E4GDzMbe6HibmqpZR1nWnz7XDBzFuo+0jJ/
         XtyA==
X-Forwarded-Encrypted: i=1; AFNElJ8zXfgnT7+0IyFYxs3MsymJOV2UMtLTu84X7AeMH3tGSART/tKFNxY3S5mjHSimky0Qzpan+6Soag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxirFWRvoKcHW34znhvyERiEr18ueCMKXdTFIyeLa8xUpNdU8Cx
	g3vQfrdsiY+jE3w9/nvAe1/K8zjV8SupUfoaKYZ/c75MsR1N0VhANsiqBCeIMq7guY9HHjPkM3u
	ph/Dlwm2LqQbx9A==
X-Received: from pgls22.prod.google.com ([2002:a63:5256:0:b0:c85:9dd2:d11e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7105:b0:3b4:8f4a:3bc6 with SMTP id adf61e73a8af0-3bb34652904mr1039348637.32.1781822741539;
 Thu, 18 Jun 2026 15:45:41 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:45:24 -0700
In-Reply-To: <20260618224527.1506419-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618224527.1506419-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260618224527.1506419-2-jmattson@google.com>
Subject: [PATCH v3 1/4] x86/CPU/AMD: Avoid racy updates to MSR_K7_HWCR in set_cpuid_faulting()
From: Jim Mattson <jmattson@google.com>
To: bp@alien8.de, tglx@kernel.org, x86@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Since msr_set_bit() and msr_clear_bit() perform a non-atomic update to an
MSR, they can race with a write to the same MSR from interrupt context.

On AMD CPUs, set_cpuid_faulting() uses these functions to modify
MSR_K7_HWCR from process context, with preemption disabled but interrupts
enabled. The acpi-cpufreq driver's boost_set_msr() modifies HWCR from
interrupt context. If a crosscall IPI arrives between
set_cpuid_faulting()'s read and write of MSR_K7_HWCR and toggles the Core
Performance Boost disable bit (CPB_DIS), the IPI's update is lost.

This race has been observed empirically on a Turin system running the
acpi-cpufreq driver with a synthetic test. One thread repeatedly toggles
/sys/devices/system/cpu/cpufreq/boost and verifies CPB_DIS on CPU0 after
each write. A second thread pinned to CPU0 calls arch_prctl(ARCH_SET_CPUID,
<val>), with alternating <val>s of 0 and 1. CPB_DIS bit changes are
sometimes lost.

Introduce amd_update_hwcr() to perform an interrupt-safe read-modify-write
of MSR_K7_HWCR, and use it in set_cpuid_faulting() to prevent races with
HWCR updates in interrupt context. Note that when set_cpuid_faulting() is
called from __switch_to_xtra(), interrupts are already disabled, so the
race is only possible on the arch_prctl() paths.

Reported-by: Sashiko (gemini/gemini-3.1-pro-preview)
Closes: https://lore.kernel.org/all/20260609211611.466231-1-jmattson@google.com/
Suggested-by: Borislav Petkov <bp@alien8.de>
Fixes: 65f55a301766 ("x86/CPU/AMD: Add CPUID faulting support")
Assisted-by: Gemini:gemini-3.5-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 38 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c        |  5 +----
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 87b1d4c0727e..153b621777ae 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -722,9 +722,11 @@ static __always_inline void amd_clear_divider(void)
 }
 
 extern void amd_check_microcode(void);
+extern int amd_update_hwcr(u8 bit, bool set);
 #else
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
+static inline int amd_update_hwcr(u8 bit, bool set) { return -ENODEV; }
 #endif
 
 extern unsigned long arch_align_stack(unsigned long sp);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 487ac147e11f..15e7ca3b815d 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1320,6 +1320,44 @@ void amd_check_microcode(void)
 		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 
+/**
+ * amd_update_hwcr - Update MSR_K7_HWCR on the executing CPU
+ * @bit: bit number to change
+ * @set: whether to set or clear the bit
+ *
+ * MSR_K7_HWCR is written from both process context (e.g. CPUID faulting
+ * updates via arch_prctl(ARCH_SET_CPUID)) and interrupt context (e.g.
+ * Core Performance Boost updates IPI'd by the acpi-cpufreq driver), so
+ * a read-modify-write of the MSR must be performed with interrupts
+ * disabled to avoid losing an update made by an intervening interrupt.
+ * All runtime (non-initialization) updates of MSR_K7_HWCR should go
+ * through this helper.
+ *
+ * Context: Any context except NMI. Disabling interrupts does not
+ *          serialize against an NMI, so NMI handlers must not write
+ *          MSR_K7_HWCR. Warns if called from NMI context.
+ *
+ * Return: 0 on success, negative error code if an MSR access faults.
+ */
+int amd_update_hwcr(u8 bit, bool set)
+{
+	unsigned long flags;
+	int ret;
+
+	if (WARN_ON_ONCE(in_nmi()))
+		return -EINVAL;
+
+	local_irq_save(flags);
+	if (set)
+		ret = msr_set_bit(MSR_K7_HWCR, bit);
+	else
+		ret = msr_clear_bit(MSR_K7_HWCR, bit);
+	local_irq_restore(flags);
+
+	return ret < 0 ? ret : 0;
+}
+EXPORT_SYMBOL_GPL(amd_update_hwcr);
+
 static const char * const s5_reset_reason_txt[] = {
 	[0]  = "thermal pin BP_THERMTRIP_L was tripped",
 	[1]  = "power button was pressed for 4 seconds",
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index a554f19c9973..8895cc0fa472 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -354,10 +354,7 @@ static void set_cpuid_faulting(bool on)
 		this_cpu_write(msr_misc_features_shadow, msrval);
 		wrmsrq(MSR_MISC_FEATURES_ENABLES, msrval);
 	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (on)
-			msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER_DIS_BIT);
-		else
-			msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER_DIS_BIT);
+		amd_update_hwcr(MSR_K7_HWCR_CPUID_USER_DIS_BIT, on);
 	}
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

