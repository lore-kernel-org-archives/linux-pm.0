From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 0/3] cpufreq: intel_pstate: Base frequency attribute
Date: Fri, 12 Oct 2018 09:43:57 -0700
Message-ID: <20181012164400.3479-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, robert.moore@intel.com, erik.schmauss@intel.com
Cc: juri.lelli@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, devel@acpica.org, pprakash@codeaurora.org, george.cherian@cavium.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This series presents base frequency to cpufreq sysfs when intel_pstate
is in use in HWP mode.

Changes:
v3:
- Update documentation
v2
- Removed guaranteed attribute addition to acpi_cppc sysfs
- Using the cppc_acpi interface to get base frequency and present

Srinivas Pandruvada (3):
  ACPI / CPPC: Add support for guaranteed performance
  cpufreq: intel_pstate: Add base_frequency attribute
  Documentation: intel_pstate: Add base_frequency information

 Documentation/admin-guide/pm/intel_pstate.rst |  4 ++
 drivers/acpi/cppc_acpi.c                      |  8 +++-
 drivers/cpufreq/intel_pstate.c                | 38 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      |  1 +
 4 files changed, 49 insertions(+), 2 deletions(-)

-- 
2.17.1
