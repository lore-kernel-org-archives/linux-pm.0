From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/6] Intel P states enhancements
Date: Tue, 29 Sep 2015 15:54:02 -0700
Message-ID: <1443567248-27134-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:65153 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864AbbI2Wyl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 18:54:41 -0400
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

v3:
- Added function : convert_to_native_pstate_format to convert from
perf_ctl value to pstate used ratios.
- Fix bug identified by Rafael

v2:
- When CONFIG_ACPI not defined, then acpi/processor.h can't be included.
Also some variables will be unused when CONFIG_ACPI is not defined, so there
were warnings. Fixed all these compile issues.

v1:
- Change the command line option to "no_acpi"
- changed kernel parameter documentation file and added "no_acpi" parameter
- pr_debug prefixed with "intel_pstate" as suggested by Doug
- Changed the logic to determine turbo freq in _PSS using odd/even convention,
although this is the way it is defined in _PSS. But atleast two reviewers has
questioned the source of this. This is defined usually in non public documents
like BIOS writer guides. Now using the control field value to determine the
turbo and non turbo max.
- Fix the Kconfig dependency on ACPI for ACPI_PROCESSOR
- multi line comment styles

v0:
Base version

Srinivas Pandruvada (6):
  cpufreq: intel_p_state: Fix limiting turbo sub states
  cpufreq: intel_pstate: get P1 from TAR when available
  cpufreq: intel-pstate: Use separate max pstate for scaling
  cpufreq: intel_pstate: Use ACPI perf configuration
  Documentation: kernel_parameters for Intel P state driver
  cpufreq: intel_pstate: Avoid calculation for max/min

 Documentation/kernel-parameters.txt |   3 +
 arch/x86/include/asm/msr-index.h    |   7 +
 drivers/cpufreq/Kconfig.x86         |   1 +
 drivers/cpufreq/intel_pstate.c      | 368 ++++++++++++++++++++++++++++++++++--
 4 files changed, 368 insertions(+), 11 deletions(-)

-- 
1.9.3

