Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E543C065;
	Thu, 28 May 2026 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981309; cv=none; b=EYsN7kIBIEdnRpO+w5B0ScE8bpyanNgbfwniHIURZLjMoSCeEHKUtDVvld5Oia17ig0yMIy5/KkYoY+lE57MrZb9RQAbpG8dDhA0mMfYtA+4I351wf2ZtBntE/H2/7zHFygaDRTRj397vu00d8mcNWKKst2cvICPOJqzjFbQYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981309; c=relaxed/simple;
	bh=+Hk3LqQsJvfMFTkSHUPBjmdJP3ffrEDsxBKid7Dg5BY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pHf5ZyyNU48RsIhjI1y4OfQX6Kt5jQvyMOok1RM+ZngbCaYdf3r/UNXCk8XIP4ac6EOVawmj2crnvM5DBag8wKMXUU7JYWCBo7ISULEbalUMwhIIcGhrpda5N6TTSOHcutsf+dwF4Wwb5z384/oBymS8RbZVAXO+Ra/m23+kS8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzuvxvRO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzuvxvRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779981308; x=1811517308;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=+Hk3LqQsJvfMFTkSHUPBjmdJP3ffrEDsxBKid7Dg5BY=;
  b=dzuvxvRO0YFjMBdC1F7mbxwVIdc2wnjxIq+Eanl0Oysct2Dn/qX2Z7cI
   BadaJRVPrfb763Fbs4aOhmB9JJEsHnG6DvBCcTstrYfx38rDuV/JQR3qD
   zPwfHUng7zM9FmCkrpTDslgDJQ+rTfQ5Cp+23hAOpnFAzZqy3Trxf6483
   eIc4Rhp6amta2vF5Mw9Il5FQrkI8f44iXKr5EwUoKAuqm6+HMr34tk0CB
   IfvfTs4zD/sXYz95jn0+CSYRU2IQM0LVRVNP+Yv8I38O2mO1qdAGhCUSP
   08gqQrIXYMjZiL6crolu7ImMy/umTqS0v6y607Er25dlhtSzCmlm5VpAi
   g==;
X-CSE-ConnectionGUID: iiil1CduRGSfFLGB0KCYVA==
X-CSE-MsgGUID: t/hW6QZVTOaItCQr9+zZJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80887331"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80887331"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:06 -0700
X-CSE-ConnectionGUID: Feq6+yn7TNm32BT6ExtZXA==
X-CSE-MsgGUID: aonHwoM3Qn6PctkFlVIBrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241536805"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:15:06 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v2 0/5] thermal: intel: Add support for Directed Package
 Thermal Interrupt
Date: Thu, 28 May 2026 08:25:41 -0700
Message-Id: <20260528-rneri-directed-therm-intr-v2-0-8e2f9e0c1a36@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVeGGoC/32NQQqDMBBFryJZd2RMUJqueo/iosZJHdBYJqlYx
 Ls3Fbrt7N7//DebiiRMUV2KTQktHHkOGfSpUG64hwcB95mVRt2gwQYk5AH0LOQS9ZAGkgk4JAH
 rjT/n6zrjVd4/hTyvh/vWZh44plnex6ul+qY/q/1jXSpA0LZuyCCirfE6cnitZS5pLN08qXbf9
 w/ju0OlyAAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: x86@kernel.org, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779981967; l=3795;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=+Hk3LqQsJvfMFTkSHUPBjmdJP3ffrEDsxBKid7Dg5BY=;
 b=CnZGJjMvL7LNzNcnL/YT589mVsLwl8A/pxvR3CHkYFt6taF2LkhOtreNfRBhpqi17pFRTrLr/
 dk+4wwG+TQSCoTfTblbqI1+JQJ1WhdCsPI6bA/roiyreceae04ZCSKS
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Hi,

This is v2 of this series. The main changes are a new patch fixing a pre-
existing bug and a redesigned error rollback strategy that disables
directed thermal interrupts across all packages when enabling fails in any
one of them. Please see the changelog for details.

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
Ricardo Neri (5):
      thermal: intel: Fix dangling resources on thermal_throttle_online() failure
      x86/thermal: Add bit definitions for Intel Directed Package Thermal Interrupt
      thermal: intel: Enable the Directed Package-level Thermal Interrupt
      thermal: intel: Add syscore callbacks for suspend and resume
      thermal: intel: Add a syscore shutdown callback for kexec reboot

 arch/x86/include/asm/cpufeatures.h  |   2 +
 arch/x86/include/asm/msr-index.h    |   2 +
 drivers/thermal/intel/therm_throt.c | 272 +++++++++++++++++++++++++++++++++++-
 3 files changed, 272 insertions(+), 4 deletions(-)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260306-rneri-directed-therm-intr-9f3f8888bb3f

Best regards,
-- 
Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

