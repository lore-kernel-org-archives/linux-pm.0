From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/2] cpufreq: intel_pstate: Base frequency attribute
Date: Tue,  9 Oct 2018 14:46:31 -0700
Message-ID: <20181009214633.16390-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com, viresh.kumar@linaro.org
Cc: pprakash@codeaurora.org, george.cherian@cavium.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, devel@acpica.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This series presents base frequency to cpufreq sysfs when intel_pstate
is in use in HWP mode.

Changes:
v2
- Removed guaranteed attribute addition to acpi_cppc sysfs
- Using the cppc_acpi interface to get base frequency and present

Srinivas Pandruvada (2):
  ACPI / CPPC: Add support for guaranteed performance
  cpufreq: intel_pstate: Add base_frequency attribute

 drivers/acpi/cppc_acpi.c       |  8 +++++--
 drivers/cpufreq/intel_pstate.c | 38 ++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  1 +
 3 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.17.1
