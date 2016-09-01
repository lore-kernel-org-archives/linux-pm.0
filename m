From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=200/8=5D=20Support=20Intel=C2=AE=20Turbo=20Boost=20Max=20Technology=203=2E0?=
Date: Thu,  1 Sep 2016 13:33:36 -0700
Message-ID: <1472762024-88771-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

v2
- The patchset is split into two parts so that CPPC changes can be merged first
 1. Only ACPI CPPC changes (It is posted separately)
 2. ITMT changes (scheduler and Intel P-State)

- Changes in patch: sched,x86: Enable Turbo Boost Max Technology
 1. Use arch_update_cpu_topology to indicate need to completely
    rebuild sched domain when ITMT related sched domain flags change
 2. Enable client (single node) platform capable of ITMT with ITMT
    scheduling by default
 3. Implement arch_asym_cpu_priority to provide the cpu priority
    value to scheduler for asym packing.
 4. Fix a compile bug for i386 architecture.

- Changes in patch: sched: Extend scheduler's asym packing
 1. Use arch_asym_cpu_priority() to provide cpu priority
    value used for asym packing to the scheduler.

- Changes in acpi: bus: Enable HWP CPPC objects and
  acpi: bus: Set _OSC for diverse core support
  Minor code cleanup by removing #ifdef
- Changes in Kconfig for Intel P-State
  Avoid building CPPC lib for i386 for issue reported by 0-day

- Feature is enabled by default for single socket systems

With Intel® Turbo Boost Max Technology 3.0 (ITMT), single-threaded performance is
optimized by identifying processor's fastest core and running critical workloads
on it.
Refere to:
http://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-max-technology.html

This patchset consist of all changes required to support ITMT feature:
- Use CPPC information in Intel P-State driver to get performance information
- Scheduler enhancements
- cppc lib patches (split in to a seprate series)

This featured can be enabled by writing at runtime
# echo 1 > /proc/sys/kernel/sched_itmt_enabled
This featured can be disabled by writing at runtime
# echo 0 > /proc/sys/kernel/sched_itmt_enabled

Srinivas Pandruvada (3):
  acpi: bus: Enable HWP CPPC objects
  acpi: bus: Set _OSC for diverse core support
  cpufreq: intel_pstate: Use CPPC to get max performance

Tim Chen (5):
  sched, x86: Add SD_ASYM_PACKING flags to x86 cpu topology for ITMT
  sched: Extend scheduler's asym packing
  x86, cpu: provide a function topology_num_packages to enumerate
    #packages
  sched, x86: use arch_update_cpu_topology to indicate x86 need sched
    domain rebuild
  sched,x86: Enable Turbo Boost Max Technology

 arch/x86/Kconfig                |   9 +++
 arch/x86/include/asm/topology.h |  25 +++++++
 arch/x86/kernel/Makefile        |   1 +
 arch/x86/kernel/itmt.c          | 161 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c       |  92 ++++++++++++++++++-----
 drivers/acpi/bus.c              |   8 ++
 drivers/cpufreq/Kconfig.x86     |   1 +
 drivers/cpufreq/intel_pstate.c  |  75 ++++++++++++++++++-
 include/linux/acpi.h            |   1 +
 include/linux/sched.h           |   2 +
 kernel/sched/core.c             |  21 ++++++
 kernel/sched/fair.c             |  35 ++++++---
 kernel/sched/sched.h            |  12 +++
 13 files changed, 411 insertions(+), 32 deletions(-)
 create mode 100644 arch/x86/kernel/itmt.c

-- 
2.7.4

