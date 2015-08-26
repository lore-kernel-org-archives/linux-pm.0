From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/5] Intel P states enhancements
Date: Wed, 26 Aug 2015 13:32:36 -0700
Message-ID: <1440621161-2732-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55788 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbbHZUcz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Aug 2015 16:32:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This series enhances Intel P state drivers with the following features:
- When max_perf_pct is reduced in turbo range, we can change the turbo ratios
when platform allows. This is particularly useful in limiting performance with
HWP where whole range is turbo.
- Use Turbo Activation Ratio, when calculating max non turbo P state. This will
show now correct percentage in turbo range
- To calculate busy percent, the estimate is not correct when the max non turbo
is limited by tar, hence using physical max non turbo as before.
- Use ACPI _PSS and _PPC in intel_ptate driver.
- Avoid calculation for P state control value when cpufreq policy requests
frequency limits when matched in _PSS. Sometime calculations causes reduced
control value in boundary conditions.

Although they are independent patches, sending as series to help applying and
testing.

I appreciate review and testing on multiple platforms.

Srinivas Pandruvada (5):
  cpufreq: intel_p_state: Fix limiting turbo sub states
  cpufreq: intel_pstate: get P1 from TAR when available
  cpufreq: intel-pstate: Use separate max pstate for scaling
  cpufreq: intel_pstate: Use ACPI perf configuration
  cpufreq: intel_pstate: Avoid calculation for max/min

 arch/x86/include/asm/msr-index.h |   7 +
 drivers/cpufreq/Kconfig.x86      |   1 +
 drivers/cpufreq/intel_pstate.c   | 326 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 324 insertions(+), 10 deletions(-)

-- 
1.9.3

