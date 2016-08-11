From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/5] x86 CPPC usage
Date: Wed, 10 Aug 2016 17:17:21 -0700
Message-ID: <1470874646-70570-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The x86 HWP (Hardware Controlled Performance States) is an implementation
of the ACPI-defined Collaborative Processor Performance Control (CPPC).
The current implementation of HWP doesn't use CPPC, but CPPC brings in
some advanced features. So we will be submitting changes to use CPPC.

The first series only contains ACPI CPPC changes required for x86.

Srinivas Pandruvada (5):
  acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
  acpi: cpcc: Add integer read support
  acpi: cppc: Add support for function fixed hardware address
  acpi: cppc: Add prefix cppc to cpudata structure name
  acpi: bus: Enable HWP CPPC objects

 drivers/acpi/Kconfig            |  1 -
 drivers/acpi/bus.c              |  7 ++++
 drivers/acpi/cppc_acpi.c        | 88 +++++++++++++++++++++++++++++++++++------
 drivers/acpi/processor_driver.c |  5 ++-
 drivers/cpufreq/cppc_cpufreq.c  | 14 +++----
 include/acpi/cppc_acpi.h        |  4 +-
 6 files changed, 95 insertions(+), 24 deletions(-)

-- 
2.7.4

