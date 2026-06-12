Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67741E515
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301459; cv=none; b=CJm4eS+KJaNlIkjBBord5cfcMefbESqGvJ0rIBMciIXcXSRa/nGkZEychExI/2ZZ+cw48C0kwq366rxkyp2iSu1UDu9crN9ctKdht6cfu+mh3FQscC92/Dk8NMmcwSuj/jjOMVD9AxDg9cz4ENOY+S3THLxVEt4quXQ+XwrlKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301459; c=relaxed/simple;
	bh=gKIb/5Ac68Lq99+w5accyZOTfeuSXNHA7G/NQNudGMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=go35E5tS7wskimYdShoOy2EZqE7Cu9prjO8cX82+0hIJXJOsCvGgavjPsoB/ceP2XXz2Atlz4ph94WL3dP6LnTT3eow0A/H56K+FaN1tZxMU7YYnHWX/TByklPMn1Sf0Fy8BWMZLIj87Gx7W3n043Z7CtVrPDkE3OYTNXJufCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IyYBWHFF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyYBWHFF"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so23684975ad.0
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781301457; x=1781906257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AWPKS6/naz+ZdHkF6/FHzlmJwYo79ertAsjGlLKwgyE=;
        b=IyYBWHFFzEl5c+PGjFlDezQvDwQGrS/LJXCOXqa7aRlfc2XYRFWLHvzivMJ67ORniU
         d/QZtn975BGjR81WDWd2jsu1eolUsC9eOb5lkzSolzyDbrScZbavekRNm7OWAG1GPpDH
         A+uL82SqaQqYa7QlorKIPx7JcqrDEGtOv/HaDr38v3ruqnr5HWr/jvzpYp/gAb0Z6A42
         2v6dxjcNPJXKdZDd5Kyoxs/L+b4iVR1sJ7VWRp3etIuitb4sCPWCbwzoL8EVb8SlqmmF
         PzvQ4ckUcqWkxxZFNpWX1pkjRXZhKvfS9ZXZcZ2zFHkKsCcMisag6slYfYO8XksCyFze
         jP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781301457; x=1781906257;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWPKS6/naz+ZdHkF6/FHzlmJwYo79ertAsjGlLKwgyE=;
        b=XH2xsEEXq/2ZsmSwQ8L1E07xat9NK0eSO4xzepUzolwlIfkuSPqriEHWSkXOIjR3nh
         iY1jDVskPbOCtey89ASOMmOnXM3hfcv6jyCqj2dSzquFq37EhI0wjpr9J90IvHfAtd7V
         XNdKf2DI0NphG3qNxfqghZArxa0iL/Wd7RKLxSuwjYskHpy7KL/c04JQaVIP0dppXFV9
         xOtLGxXKDgRNln5nL9I45lQ7U+rbCdAZHLSxn6/WOeDCBlZqpu2kmiGl2WcWnYfDWIUR
         bCibNTE3fJkAHEjs3hpcFfj0j2cKtdAM2lI+mjTp6cLp4OSM2WEMsIN67rSOtntH429p
         4dtA==
X-Forwarded-Encrypted: i=1; AFNElJ9L1TOsmROk8XUSvXjhOx8YHLAjr8I+t8JzOgKaJwHpmHoHm09Q/DgwCKA+2DxaY2uWDlaLd8mUOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeX54QybEqf74L81TUcSdiB4Fbx2k+jbVNuolJaFFoAWIytlH+
	cvhVi6MaF/ZI5HWq9T3HbpgOJpNMfaOiYdHbiliyeC9leVaQI/Rw0zoVjMGiRCxOkgNLJaaXh05
	fU49y7nUCDWl/oQ==
X-Received: from plbmp4.prod.google.com ([2002:a17:902:fd04:b0:2b6:417:db8d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:c94f:b0:2c0:b319:fb43 with SMTP id d9443c01a7336-2c41235e4camr52119065ad.21.1781301456776;
 Fri, 12 Jun 2026 14:57:36 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:53:16 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612215729.1532175-1-jmattson@google.com>
Subject: [PATCH v2 0/3] Fix three racy updates to MSR_K7_HWCR
From: Jim Mattson <jmattson@google.com>
To: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, yosry@kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

I was backporting commit 65f55a301766 ("x86/CPU/AMD: Add CPUID faulting
support") to a local branch based on Linux v6.12, when our internal Sashiko
asked:

> Can this corrupt MSR_K7_HWCR? disable_cpuid()->set_cpuid_faulting() is
> called with preemption disabled, but interrupts are still enabled. Since
> msr_set_bit() performs a read-modify-write without disabling interrupts,
> if an IPI arrives between the read and write and modifies MSR_K7_HWCR
> (e.g. acpi-cpufreq toggling Core Performance Boost), the IPI's update
> will be lost.

To confirm that this wasn't just AI slop, I set up an empirical test on a
Turin system. First, I replaced the amd-pstate cpufreq driver with
acpi-cpufreq. Then I ran a test program, where one thread repeatedly reads
CPU0's HWCR, toggles /sys/devices/system/cpu/cpufreq/boost, reads CPU0's
HWCR again, and then verifies that the CPB_DIS bit has flipped. A second
thread, pinned to CPU0, repeatedly calls arch_prctl(ARCH_SET_CPUID, <val>),
where <val> alternates between 0 and 1. With the second thread running, the
first thread soon fails the verification step, indicating that the CPB_DIS
bit change is, in fact, lost.

Per Boris's review of v1, this version hoists the HWCR update logic out
into a new helper, amd_update_hwcr(), which performs the read-modify-write
with interrupts disabled, and converts the three runtime
(non-initialization) HWCR read-modify-write sites to use it:

  * set_cpuid_faulting(), fixing the race demonstrated above (patch 1);
  * toggle_hw_mce_inject(), which previously performed the
    read-modify-write as two independent crosscalls (patch 2);
  * boost_set_msr() in acpi-cpufreq, whose process-context invocation on
    the cpufreq policy teardown path can race with an HWCR update made by
    the MCE injector's crosscall (patch 3).

Initialization-time HWCR updates are left alone for now, to avoid excessive
churn.

v1 -> v2:
 - Add some of the cover letter details to the first patch
 - Hoist the HWCR update logic out into amd_update_hwcr() [Boris]
 - Use the helper in toggle_hw_mce_inject(), collapsing the split
   read/write crosscalls into one
 - Use the helper in boost_set_msr() [Boris]

v1: https://lore.kernel.org/all/20260609211611.466231-1-jmattson@google.com/

Jim Mattson (3):
  x86/CPU/AMD: Avoid racy updates to MSR_K7_HWCR in set_cpuid_faulting()
  x86/mce/inject: Avoid racy updates to MSR_K7_HWCR in
    toggle_hw_mce_inject()
  cpufreq: ACPI: Avoid racy updates to MSR_K7_HWCR in boost_set_msr()

 arch/x86/include/asm/msr-index.h |  3 +++
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 42 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/inject.c | 34 +++++++++++++++++++-------
 arch/x86/kernel/process.c        |  4 +--
 drivers/cpufreq/acpi-cpufreq.c   |  7 +++---
 6 files changed, 78 insertions(+), 14 deletions(-)


base-commit: 2b414a95b8f7307d42173ba9e580d6d3e2bcbfce
-- 
2.54.0.1136.gdb2ca164c4-goog

