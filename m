Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0D40D581
	for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781822743; cv=none; b=mttQTM5d5ev/CXq/45NXOGoQkgW2jb9C+xFLjUenO/VesJsGBS+KCDaSbJVzeBhpqmJVHK7MAUzAtReJxCmPXUwuT1C+HQrP4F0DGUpLdQ5Vof2CHB1Lhz8CXGIthDc/5IgcwB9EL+poucVC64ZAgv3yDVVFKVJMBPkypCBAqhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781822743; c=relaxed/simple;
	bh=gCIfq7GGox+dnC7fQvi5Q79WBCBfESvLtIFq6kgK2JE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YHGrVqDONe25NAJDWOyUrX96XHy0v7qeWSr3rg9vwiOQmtBR6Mg7pCjbXjzBHIna+7oqtgIezjFclxtUW3PN9Xm6OT7EcF8NG+SSrkZeYbwy29m60A70UlVXpa7MwfkviATT/TJdURxct7ElE8A/R25dlWrx95UA7m3NR1D+DX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fe4sBLCa; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fe4sBLCa"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c85edbb10dfso1006845a12.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2026 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781822741; x=1782427541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tZWoeisMG/627QrZTTnswpH6EG33Wk0G62w0zQcUqBg=;
        b=fe4sBLCa2lxBYgx1+4Syy/waaqKnBc5Pjym4XkHcJWo4ptEFPTTZ6Z7ZrvNCL0/Ev7
         0rZKEEPkQDtt1uYhIzFU9mBXDANGib6jUHxdLVKEOsAPu8d3WOVOX+fmpP4B6nDl3Rj6
         Kz5D64Dd/9AMXGPNmGX/czL24kzreDV9Ro5hhKp25CPHyoBqklTvqHYWRrDAa1y5+AFG
         3f1Z36mmg2a9nURZ0H5kP96jojpDb5cScdDNfj+4vU+VmvqdJdR5EOvSjvwYG5lGsfVc
         PpsHQK92VJ6nV4UATWlpPco5Ci5ZRAiMomE4hoxFZvBrgdb3dQxxgRhb8TAgv18dZorH
         QdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781822741; x=1782427541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZWoeisMG/627QrZTTnswpH6EG33Wk0G62w0zQcUqBg=;
        b=pItIag6MWqiJxPsaovIujVJnN0iRCqkmqMd6k460Jjz+rkZTEobP1f6oXTuArN6Gwa
         jl+zEwq0U4PD0sxVCUZRIPkx/4WC9keyys5ymdVgXw3FqpvAilDFnPEaLKI1NuVeipzY
         NcmcuDqAbx3gSBqvHdNstePwlrNLm6SNuaJCM2equDmNsSWDMVmAYG0zg2zFqfkrugPv
         c1u/kBKT4PqxCiL+zEobOl38wWQR+EE+jX5GWjLtDhtkDTV1/aih4oUoFr17WGsVqZ0P
         RItNMMe5IUdd7uj98cque/Op84yN1H1vFKRWsoJt8t7ICvCd1CSaToqwaZmRNbf//gEz
         1guA==
X-Forwarded-Encrypted: i=1; AFNElJ/zat66NCHPyeJ1j4pbjX43BRwK9J1B8z9kl+b56IXlQhVtzZTvFpB6uO5643M4jgzqhBt0+ZnVeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxNCERej1Vj71tf2nZtC8WSj3URfBZV+wSrVZqS1QoisptPbM
	zj/Y7nXX6IBD3vOQkQEC3uA0GCli2PFccKs/gyR4YIr4BME3GjLSqwO8PNShNp9RZ2yftzZBAHe
	C9x5+k9XhKTgXxA==
X-Received: from pgac7.prod.google.com ([2002:a05:6a02:2947:b0:c85:8522:ec2d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:568e:b0:3a0:9052:c005 with SMTP id adf61e73a8af0-3bb3364fdfbmr776653637.3.1781822740682;
 Thu, 18 Jun 2026 15:45:40 -0700 (PDT)
Date: Thu, 18 Jun 2026 15:45:23 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260618224527.1506419-1-jmattson@google.com>
Subject: [PATCH v3 0/4] Fix racy and incorrect updates to MSR_K7_HWCR
From: Jim Mattson <jmattson@google.com>
To: bp@alien8.de, tglx@kernel.org, x86@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, yosry@kernel.org, andrew.cooper3@citrix.com, 
	ludloff@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>
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

Andrew Cooper raised a valid concern regarding the core-scoped nature of
MSR_K7_HWCR on some AMD CPUs. When the MSR is shared between SMT siblings,
a cross-CPU race is possible if SMT threads concurrently modify the
MSR. Centralizing all runtime updates through the amd_update_hwcr() helper
ensures that if explicit serialization is desired, it can be implemented
transparently in a single place. Note that on recent AMD CPUs, the MSR is
thread-scoped.

Google's internal Sashiko highlighted a separate, pre-existing
architectural issue in acpi-cpufreq that Borislav and I briefly touched on:
during shared policy teardown (e.g., driver unload),
acpi_cpufreq_cpu_exit() is only executed for the final CPU in the
policy. As a result, cpufreq_boost_down_prep() only restores the
boost-disable MSR bit on that single CPU, leaving all other sibling CPUs
that shared the policy with the disable bit still set. On Intel platforms,
where the turbo-disable MSR bit acts as a logical OR across the package,
this leaves the entire package permanently boost-disabled after the driver
is unloaded. This issue out of scope for this series, as it requires a
broader redesign of cpufreq policy teardown coordination, and should be
addressed separately.

v2 -> v3:
 - Add WARN_ON_ONCE(in_nmi()) to the helper to ensure NMI safety [Yosry].
 - Redesign amd_update_hwcr() to be a simple bit-based wrapper [Yosry].
 - Fix cpufreq_boost_down_prep() to target the correct CPU via IPI, resolving
   the wrong-CPU update and Intel preemption/migration races [Sashiko].
 - Drop the Fixes tag from patch 4, since the race is now fixed in patch 3.

v2: https://lore.kernel.org/all/20260612215729.1532175-1-jmattson@google.com/
v1: https://lore.kernel.org/all/20260609211611.466231-1-jmattson@google.com/

Jim Mattson (4):
  x86/CPU/AMD: Avoid racy updates to MSR_K7_HWCR in set_cpuid_faulting()
  x86/mce/inject: Avoid racy updates to MSR_K7_HWCR during MCE injection
  cpufreq: ACPI: Use IPI to update boost MSR in
    cpufreq_boost_down_prep()
  cpufreq: ACPI: Use amd_update_hwcr() for MSR_K7_HWCR updates

 arch/x86/include/asm/msr-index.h |  2 ++
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/cpu/amd.c        | 38 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/inject.c | 46 ++++++++++----------------------
 arch/x86/kernel/process.c        |  5 +---
 drivers/cpufreq/acpi-cpufreq.c   | 11 ++++----
 6 files changed, 62 insertions(+), 42 deletions(-)


base-commit: 83f1454877cc292b88baf13c829c16ce6937d120
