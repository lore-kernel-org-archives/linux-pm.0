From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: =?UTF-8?q?=5BPATCH=2000/11=5D=20Support=20Intel=C2=AE=20Turbo=20Boost=20Max=20Technology=203=2E0?=
Date: Thu, 18 Aug 2016 15:36:41 -0700
Message-ID: <1471559812-19967-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, peterz@infradead.org
Cc: x86@kernel.org, bp@suse.de, sudeep.holla@arm.com, ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, alexey.klimov@arm.com, viresh.kumar@linaro.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, lenb@kernel.org, tim.c.chen@linux.intel.com, srinivas.pandruvada@linux.intel.com, paul.gortmaker@windriver.com, jpoimboe@redhat.com, mcgrof@kernel.org, jgross@suse.com, robert.moore@intel.com, dvyukov@google.com, jeyu@redhat.com
List-Id: linux-pm@vger.kernel.org

With Intel® Turbo Boost Max Technology 3.0 (ITMT), single-threaded performance is
optimized by identifying processor's fastest core and running critical workloads
on it.
Refere to:
http://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-max-technology.html

This patchset consist of all changes required to support ITMT feature:
- Enhance CPPC ACPI lib to support x86
- Use CPPC information in Intel P-State driver to get performance information
- Scheduler enhancements

By default this feature is OFF, to turn on:

# echo 1 > /proc/sys/kernel/sched_itmt_enabled


Srinivas Pandruvada (7):
  acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
  acpi: cpcc: Add integer read support
  acpi: cppc: Add support for function fixed hardware address
  acpi: cppc: Add prefix cppc to cpudata structure name
  acpi: bus: Enable HWP CPPC objects
  acpi: bus: Set _OSC for diverse core support
  cpufreq: intel_pstate: Use CPPC to get max performance

Tim Chen (4):
  sched, cpuset: Add regenerate_sched_domains function to rebuild all
    sched domains
  sched, x86: Add SD_ASYM_PACKING flags to x86 cpu topology for cpus
    supporting Intel Turbo Boost Max Technology
  sched: Extend scheduler's asym packing
  sched,x86: Enable Turbo Boost Max Technology

 arch/x86/Kconfig                |   9 +++
 arch/x86/include/asm/topology.h |  26 +++++++
 arch/x86/kernel/Makefile        |   1 +
 arch/x86/kernel/itmt.c          | 147 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c       |  77 ++++++++++++++++-----
 drivers/acpi/Kconfig            |   1 -
 drivers/acpi/bus.c              |   9 +++
 drivers/acpi/cppc_acpi.c        |  88 ++++++++++++++++++++----
 drivers/acpi/processor_driver.c |   5 +-
 drivers/cpufreq/Kconfig.x86     |   1 +
 drivers/cpufreq/cppc_cpufreq.c  |  14 ++--
 drivers/cpufreq/intel_pstate.c  |  75 +++++++++++++++++++-
 include/acpi/cppc_acpi.h        |   4 +-
 include/linux/acpi.h            |   1 +
 include/linux/cpuset.h          |   2 +
 include/linux/sched.h           |   3 +
 kernel/cpuset.c                 |  32 +++++++--
 kernel/sched/core.c             |  46 ++++++++++++-
 kernel/sched/fair.c             |  25 ++++---
 kernel/sched/sched.h            |  17 +++++
 20 files changed, 517 insertions(+), 66 deletions(-)
 create mode 100644 arch/x86/kernel/itmt.c

-- 
2.7.4
