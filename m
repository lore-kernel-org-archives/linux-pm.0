From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 0/3] Enforce _PPC limits
Date: Wed, 27 Apr 2016 15:48:05 -0700
Message-ID: <1461797288-31573-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52033 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbcD0WsB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Apr 2016 18:48:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: khlebnikov@yandex-team.ru, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v4
intel_pstate_init_acpi_perf_limits and intel_pstate_exit_acpi_perf_limits
are now void functions.
Because of this change, other subsequent patches need to be rebased.

v3
Only commit description is changed for patch 2/3. 
Other patches are same as v2.

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
 drivers/cpufreq/intel_pstate.c      | 157 +++++++++++++++++++++++++++++++++++-
 3 files changed, 161 insertions(+), 2 deletions(-)

-- 
2.5.5

