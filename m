Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CC39A806
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301460; cv=none; b=k4p2TOag0gA/8EnVCOEFtUXJROdnfRzfga/T0PdE12kqUQ2qZ0MAnvU+mOy8L9TysHvshUGWSa5onJ3jSB8DrvA6SH3qcDzC4Rs81FhmJt0q9jxLV4Oi/l06F5F3xnvUCvNnFWQEraWBzeXSz8SxGBQ1vFxsQmxI5glkjx/86wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301460; c=relaxed/simple;
	bh=6TvobGFzvoKk/DbCK/rXPg4RBj7uVyiA/HxxjsegTCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2WUd8O4eeK5KfDRVmXM59EUVoGCcJZlnkYNeTMwuGn+qLlbzQMH+d3huCw8tX3zRBKh8XSK5TicBzNbBAKWMH2jW/+dOjjPQeDQibWuFx7NO064EsCMY4QvzXMGzVHGnzH7W3JaDqPV85M1srlU45S/UDgVKyXZ4BzFTjNYhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaTwgLcs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaTwgLcs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2befec3fd8fso9862195ad.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781301458; x=1781906258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JGAWYPtG8XRVixQPAFTMFLYtCbA2VceoK2ap0Z1c4og=;
        b=PaTwgLcsbD8xQL6nRpLFX0IJcgzok/Y9ajL2RgQtzk3UmtF0UljZ8oPvTn72XZdoke
         JA9e7geZIx3jm3h+KVuSAiY1G9g7kweoUB+OahCqecTKRmP2cbtjFr0U9OQXSKh2bO/P
         yqqj4mibit/N0BsNm6CmygnGGVcJUOpWo69UIp2pmqxrOlzrVTnLRZLO5YJ4rIfzd4fP
         m/Haxgtentee3OZZApZgNCnK9KfvFwfxC1DOz1r5ANQ/SxoGDo2NuaTOeqG7I+XcDIi5
         TpA0v4XPpKSPn5wLKCuSvfDhq/23+oCn573WcP7x2kBGSL32urRPDTEMuweC8f9jjtze
         XZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781301458; x=1781906258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JGAWYPtG8XRVixQPAFTMFLYtCbA2VceoK2ap0Z1c4og=;
        b=UHDiq1rcaiid7Pmv3PPB8OKZ/NcKkmng6dnePEADfc9hOkblbFlkuFfDudK1Ud05tR
         OYIS7IcCUHa+yFi8xIiDxul46z46pzevZpqCbW4P1W7MpjLcmzRY7/bPOgZSlLarbJZO
         HqseWH/aGlIzCMFIALevuhW1XC5HH6T5dtv127UQieKKYYW3/4Y2xQ1lcAXhG3vwaa2h
         u/1vqL5J20CV/cfNHhXCYaz47OxJuxxzfMDW25yguK9waYJiEwCxV9O0hm0NOxSZCF/H
         6XKc5hTkxVS3dA5Uxc78IGIE4NaDS/bEZU1X0ZNnFdMPhpbnOyYLXP021W/M6KbI/p8b
         X37Q==
X-Forwarded-Encrypted: i=1; AFNElJ9lyVX4tX6WwEidbIW/xLIfrHVF+hzjTS/q8EigO+tPT0TPTWDUN7bOjgjPxUGPi4aH4z/uQDq2hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxnuQWcW72rjqBxJCMCJnD9G1GVOV2uc/PjX8qod2qvgqcveX
	CWVA8jrIj18Ltnr9cagsjADBXUxNBxrqPWoeWB3DbdfGFBpcGENzK6MmaPV6jBvGfN2/LoIK7LI
	MpGpMoQWc/FxfQg==
X-Received: from plbbe4.prod.google.com ([2002:a17:902:aa04:b0:2c0:a677:42a6])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id d9443c01a7336-2c4105092a4mr57807825ad.15.1781301457799;
 Fri, 12 Jun 2026 14:57:37 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:53:17 -0700
In-Reply-To: <20260612215729.1532175-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612215729.1532175-1-jmattson@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612215729.1532175-2-jmattson@google.com>
Subject: [PATCH v2 1/3] x86/CPU/AMD: Avoid racy updates to MSR_K7_HWCR in set_cpuid_faulting()
From: Jim Mattson <jmattson@google.com>
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, yosry@kernel.org
Cc: Jim Mattson <jmattson@google.com>
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

Introduce amd_update_hwcr() to perform an interrupt-safe
read-modify-write of MSR_K7_HWCR, and use it in set_cpuid_faulting() to
prevent races with HWCR updates in interrupt context. Note that when
set_cpuid_faulting() is called from __switch_to_xtra(), interrupts are
already disabled, so the race is only possible on the arch_prctl()
paths.

Reported-by: Sashiko (gemini/gemini-3.1-pro-preview)
Closes: https://lore.kernel.org/all/20260609211611.466231-1-jmattson@google.com/
Suggested-by: Borislav Petkov <bp@alien8.de>
Fixes: 65f55a301766 ("x86/CPU/AMD: Add CPUID faulting support")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/msr-index.h |  1 +
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 42 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/process.c        |  4 +--
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 86554de9a3f5..18c4be75e927 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -899,6 +899,7 @@
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
+#define MSR_K7_HWCR_CPUID_USER_DIS	BIT_ULL(MSR_K7_HWCR_CPUID_USER_DIS_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67dd932305db..d2ad7ac24e02 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -716,9 +716,11 @@ static __always_inline void amd_clear_divider(void)
 }
 
 extern void amd_check_microcode(void);
+extern int amd_update_hwcr(u64 clear, u64 set);
 #else
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
+static inline int amd_update_hwcr(u64 clear, u64 set) { return -ENODEV; }
 #endif
 
 extern unsigned long arch_align_stack(unsigned long sp);
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 31f01e9c7114..abb6f755be98 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1319,6 +1319,48 @@ void amd_check_microcode(void)
 		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
 
+/**
+ * amd_update_hwcr - Update MSR_K7_HWCR on the executing CPU
+ * @clear: Bits to clear
+ * @set: Bits to set
+ *
+ * MSR_K7_HWCR is written from both process context (e.g. CPUID faulting
+ * updates via arch_prctl(ARCH_SET_CPUID)) and interrupt context (e.g.
+ * Core Performance Boost updates IPI'd by the acpi-cpufreq driver), so
+ * a read-modify-write of the MSR must be performed with interrupts
+ * disabled to avoid losing an update made by an intervening interrupt.
+ * All runtime (non-initialization) updates of MSR_K7_HWCR should go
+ * through this helper.
+ *
+ * Bits in @set take precedence over bits in @clear.
+ *
+ * Context: Any context except NMI. Disabling interrupts does not
+ *          serialize against an NMI, so NMI handlers must not write
+ *          MSR_K7_HWCR.
+ *
+ * Return: 0 on success, negative error code if an MSR access faults.
+ */
+int amd_update_hwcr(u64 clear, u64 set)
+{
+	unsigned long flags;
+	u64 oldval, newval;
+	int ret;
+
+	local_irq_save(flags);
+	ret = rdmsrq_safe(MSR_K7_HWCR, &oldval);
+	if (ret)
+		goto out;
+
+	newval = (oldval & ~clear) | set;
+
+	if (newval != oldval)
+		ret = wrmsrq_safe(MSR_K7_HWCR, newval);
+out:
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(amd_update_hwcr);
+
 static const char * const s5_reset_reason_txt[] = {
 	[0]  = "thermal pin BP_THERMTRIP_L was tripped",
 	[1]  = "power button was pressed for 4 seconds",
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 4c718f8adc59..08ef205f6b7f 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -355,9 +355,9 @@ static void set_cpuid_faulting(bool on)
 		wrmsrq(MSR_MISC_FEATURES_ENABLES, msrval);
 	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
 		if (on)
-			msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER_DIS_BIT);
+			amd_update_hwcr(0, MSR_K7_HWCR_CPUID_USER_DIS);
 		else
-			msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_CPUID_USER_DIS_BIT);
+			amd_update_hwcr(MSR_K7_HWCR_CPUID_USER_DIS, 0);
 	}
 }
 
-- 
2.54.0.1136.gdb2ca164c4-goog

