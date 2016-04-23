From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/3] Enforce _PPC limits
Date: Fri, 22 Apr 2016 21:01:05 -0700
Message-ID: <1461384068-23969-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10753 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbcDWEEb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 23 Apr 2016 00:04:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v2
- kernel command line is changed to support_acpi_ppc from acpi_ppc
- Removed shared_cpu_map allocation, this is only needed if we call
acpi_processor_preregister_performance
- Split the change in the setpolicy callback to another patch
- For enterprise servers and performance servers turns _PPC enforcement
on by default
- Minor fixes for label name and CONFIG_ACPI define

Srinivas Pandruvada (3):
  cpufreq: intel_pstate: Enforce _PPC limits
  cpufreq: intel_pstate: Adjust policy->max
  cpufreq: intel_pstate: Enable PPC enforcement for servers

 Documentation/kernel-parameters.txt |   5 ++
 drivers/cpufreq/Kconfig.x86         |   1 +
 drivers/cpufreq/intel_pstate.c      | 164 +++++++++++++++++++++++++++++++++++-
 3 files changed, 168 insertions(+), 2 deletions(-)

-- 
2.5.0

