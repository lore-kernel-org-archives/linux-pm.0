From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/4] CPPC only changes for supporting ITMT 3.0
Date: Thu,  1 Sep 2016 13:37:07 -0700
Message-ID: <1472762231-88923-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, alexey.klimov@arm.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

This patchset is CPPC only changes from original "Support Intel® Turbo
Boost Max Technology 3.0" series.

v2
- Rebased on top of bleeding edge branch of Linux-pm git 
- Instead of #ifdef in cppc_acpi using __weak attribute for
functions implemented in arch/x86/kernel/acpi/
- Removed integer support patch as this was already implemented
in the latest code base
- Instead of error return print warning on cppc probe failure

Srinivas Pandruvada (4):
  acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
  acpi: cppc: Don't return on CPPC probe failure
  acpi: cppc: Add support for functional fixed hardware address
  acpi: cppc: Add prefix cppc to cpudata structure name

 arch/x86/kernel/acpi/Makefile   |  1 +
 arch/x86/kernel/acpi/cppc_msr.c | 58 ++++++++++++++++++++++++++++++
 drivers/acpi/Kconfig            |  1 -
 drivers/acpi/cppc_acpi.c        | 79 +++++++++++++++++++++++++++++++++--------
 drivers/acpi/processor_driver.c |  4 +--
 drivers/cpufreq/cppc_cpufreq.c  | 14 ++++----
 include/acpi/cppc_acpi.h        |  4 +--
 7 files changed, 134 insertions(+), 27 deletions(-)
 create mode 100644 arch/x86/kernel/acpi/cppc_msr.c

-- 
2.7.4
