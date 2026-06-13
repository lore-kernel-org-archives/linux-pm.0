Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EF38F230;
	Sat, 13 Jun 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388434; cv=none; b=SQVLtyjOOEpMty3paNK4NvHS4Nt/8byEuecXoFKntnBDdwzzJBMgNBg9L6gPciZWe+tDIjV5SduLSuR5+KgEBziSvJCtDodEIYDOnSNRq5W/GrNUz8ik+BFkdCuLH1zijSOt7k/4e+lKLZPb3CHy3FxZqQqm5f6asQMt4CWp+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388434; c=relaxed/simple;
	bh=SySwBSUtMdOzuytw8dGkl1nnKh3vUI9lNN2KAsd4jbg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NqtA6I1oIkIcm56mXGVzKFWlcIQAZPwxo9YSX1gwcoVg0Yvl3qj4/Z5uZ7yIGMTBXdd89c/QHuJnf348pNgBqBdt/lsz0NrIGuxSP7mzg/NZXhe7AYU12Ob89QVvZVdaRQAE2uL/CHJQpwqh8a5FFjUnWFGOhisTDC+/U5VHBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kTSas0I9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTSas0I9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781388432; x=1812924432;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=SySwBSUtMdOzuytw8dGkl1nnKh3vUI9lNN2KAsd4jbg=;
  b=kTSas0I9Q6YcmjSYOMH1DO4NWfK49G1bDh5huoFe6Y1Ox19grXyxkgbF
   sQwf09iZwmUKkVuE5aeS1u6uKgl+K9Dpp7kvTAJfgPuShVGmWuc0EKMUA
   0Crp3acXKMzVGQyzT+uIHTPwutnZK4CMWqOT6y74XiS4rDYBsOaeq04iE
   igBrfwavkUAqKKToCJFRGjgBqw3clBeleYhb9Ycb8OQsE690Nl0cmV77o
   zWCyWgtXX/O1luiVYBDWjTPTbKYJnJS4Tz0ztyMh90smZ79FPk3CZJ7wB
   Kw2RNgNjVRPUPeJrLmTlKdENdCDxbZRhult4u5clYqubo53GUmNhDZKsV
   g==;
X-CSE-ConnectionGUID: 4fqhJKNjTBe9W4B8eV9DRw==
X-CSE-MsgGUID: fZSnCjO7QAiuF0urhhF/NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11816"; a="82029412"
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="82029412"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:11 -0700
X-CSE-ConnectionGUID: Y1aJMPF2SWO1SDeoRcNd0Q==
X-CSE-MsgGUID: wlFzJVe2RFuYZSJpZ/i3Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,203,1774335600"; 
   d="scan'208";a="252221842"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 15:07:10 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3 0/6] thermal: intel: Add support for Directed Package
 Thermal Interrupt
Date: Sat, 13 Jun 2026 15:17:46 -0700
Message-Id: <20260613-rneri-directed-therm-intr-v3-0-3a26d1e47fc8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAArXLWoC/33NwQqDMAwG4FcZPa8SWyx2p73H2EFrOgNaR9sVh
 /juq8LYYWBuf8L/ZWEBPWFgl9PCPCYKNLkc5PnETN+4B3LqcmYChAIJinuXC7wjjyZix2OPfuT
 koufaSlvnaVtpWe4/PVqad/t2z7mnECf/3l+lctt+VX2gppIDF7pSKAFAV3AdyL3mIh9xKMw0s
 s1O4udVoj7yRPZqFFYjmLKR6t9b1/UDDAXcdxgBAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781389088; l=4271;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=SySwBSUtMdOzuytw8dGkl1nnKh3vUI9lNN2KAsd4jbg=;
 b=Em/Xgc2rG4y/HwZO7tsxnYoqZ/dGlX2LY+oL7e7GcxSbsQsYNwgoT2C2b5qBpRUAmQoBweFfT
 NIhr6A5JhYCDRZnK2ELJCaghtqdlmKpu0tsIqr10qTpMRPeBNoPtevP
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Hi,

This is v3 of this series. The main change is the reworking of the
rollback mechanism to fix a bug in which kfree() could be called with local
interrupts disabled in PREEMPT_RT kernels. Please see the changelog for
details.

Package-level thermal interrupts are currently broadcast to all CPUs in a
package. Only one CPU is needed to service package-wide events.
Broadcasting creates unnecessary resource contention. Thermal interrupts
generated for Hardware Feedback Interface[1] updates are an example: all
CPUs in the package receive the interrupt and race for a lock to update a
shared data structure. Idle CPUs are needlessly woken up.

Newer Intel processors allow directing package-level thermal interrupts
only to CPUs that explicitly request them. A CPU opts in by setting a
designated bit in IA32_THERM_INTERRUPT. Hardware acknowledges the request
by setting a designated bit in IA32_PACKAGE_THERM_STATUS.

This series enables directed package-level thermal interrupts and
designates one handler CPU per package using the CPU hotplug
infrastructure. A new CPU is selected if the handler CPU goes offline.

Because CPU0's hotplug callbacks are not invoked during suspend and resume,
syscore callbacks are added to restore the handler for the boot package.
The series also disables directed delivery during kexec reboot, avoiding
stale interrupt routing when rebooting into a kernel that does not support
the feature.

This patchset introduces a change in behavior in the /sys/devices/system/
cpu/cpuN/thermal_throttle/package* sysfs files. These files reflect per-CPU
variables updated when a CPU handles a package-level thermal interrupt. In
broadcast mode, all CPUs update their variables. When directed package-
level thermal interrupts are enabled, only the handler CPU's variables are
updated.

Lastly, nothing changes for processors that do not support this feature:
they fall back to broadcast delivery.

[1] Intel Software Developer's Manual Vol. 3, Section 17.6, March 2026 https://www.intel.com/SDM

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v3:
- Fixed a potential deadlock when calling kfree() with interrupts
  disabled in PREEMPT_RT kernels. (Sashiko)
- Introduced cleanup_directed_pkg_thermal_intr() to tear down DPTI
  resources on error.
- Split patch 4 into two since it had become too big.
- Miscellaneous changes to inline comments.
- Link to v2: https://lore.kernel.org/r/20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com

Changes in v2:
- Fixed an existing bug in the error-handling of thermal_throttle_online()
  CPU hotplug callback.
- Redesigned the rollback mechanism to handle all packages, not only
  the boot package.
- Fixed the handling of the return value of cpumask_any_but(), which on
  failure returns small_cpumask_bits, not nr_cpu_ids.
- Renamed the Directed Package Thermal Interrupt CPUID and MSR bits for
  consistency and brevity. (Boris)
- Added measurements of the latency of setup acknowledgment from hardware.
- Removed an unused argument from directed_thermal_pkg_intr_supported().
- Reused the global rollback mechanism in the syscore shutdown callback.
- Link to v1: https://lore.kernel.org/r/20260309-rneri-directed-therm-intr-v1-0-2956e3000950@linux.intel.com

---
Ricardo Neri (6):
      thermal: intel: Fix dangling resources on thermal_throttle_online() failure
      x86/thermal: Add bit definitions for Intel Directed Package Thermal Interrupt
      thermal: intel: Add resources to handle directed package-level thermal interrupts
      thermal: intel: Enable the Directed Package-level Thermal Interrupt
      thermal: intel: Add syscore callbacks for suspend and resume
      thermal: intel: Add a syscore shutdown callback for kexec reboot

 arch/x86/include/asm/cpufeatures.h  |   2 +
 arch/x86/include/asm/msr-index.h    |   2 +
 drivers/thermal/intel/therm_throt.c | 284 +++++++++++++++++++++++++++++++++++-
 3 files changed, 284 insertions(+), 4 deletions(-)
---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260306-rneri-directed-therm-intr-9f3f8888bb3f

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

