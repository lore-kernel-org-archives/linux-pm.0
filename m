From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v7 0/8] Support Intel Turbo Boost Max Technology 3.0
Date: Thu, 10 Nov 2016 14:36:32 -0800
Message-ID: <cover.1478805832.git.tim.c.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de
Cc: Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

With Intel Turbo Boost Max Technology 3.0 (ITMT), single-threaded
performance is optimized by identifying processor's fastest
core and running critical workloads on it.

Refer to:
http://www.intel.com/content/www/us/en/architecture-and-technology/turbo-boost/turbo-boost-max-technology.html

This patchset consist of all changes required to support ITMT feature:
- Use CPPC information in Intel P-State driver to get performance information
- Scheduler enhancements
- cppc lib patches (split in to a seprate series)

This featured can be enabled by writing at runtime
# echo 1 > /proc/sys/kernel/sched_itmt_enabled
This featured can be disabled by writing at runtime
# echo 0 > /proc/sys/kernel/sched_itmt_enabled

Change Log:
v7:
1. ITMT3.0 is enabled by default also for multi-socket systems supporting
the feature.  Remove single socket restriction.  
2. Add proper ASYM_PACKING check for high priority idle cpu in
nohz_kick_needed.
3. Nulling of itmt_sysctl_header after sysctl table
unregistration.
4. Minor code format cleanups.
5. Fix build issue on i386

v6:
- Split ITMT support control by OS into sched_set_itmt_support and
sched_clear_itmt_support functions.
- Return error when we set sysctl_sched_itmt_enabled, if system
does not support ITMT, or when we cannot create sysctl table entry.
- Minor code clean up and moving definition of sched_core_priority
to top of file.
- Rebase on v4.9-rc1

v5:
- Simplify intel_pstate for enabling ITMT feature
- Put x86_sched_itmt_flags related functions under proper
CONFIG_SCHED_MC/SMT flags
- Comment to note that rebuild_sched_domain is not needed after updating
CPU priorities.
- Define sysctl_sched_itmt_enabled to 0 when ITMT is not used in
arch/x86/include/asm/topology.h
- Dropped patch "Fix numa in package topology bug", as this is
already applied

v4:
- Split x86 multi-node numa topology bug fix and setting
of SD_ASYM flag for ITMT topology into 2 patches
- Split the sysctl changes for ITMT enablement and setting of ITMT
capability/core priorities into 2 patches.
- Avoid unnecessary rebuild of sched domains when ITMT sysctl or
capabilities are updated.
- Fix missing stub function for topology_max_packages for !SMP case.
- Rename set_sched_itmt() to sched_set_itmt_support().
- Various updates to itmt.c to eliminate goto and make logic tighter.
- Various change logs and comments update.
- intel_pstate: Split function to process cppc and enable ITMT
- intel_pstate: Just keep the cppc_perf information till we use CPPC for HWP

v3:
- Fix race clash when more than one program are enabling/disabling ITMT
- Remove group_priority_cpu macro to simplify code.
- Error reported by 0-day for compile issue on ARM

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


Rafael J. Wysocki (1):
  cpufreq: intel_pstate: Use CPPC to get max performance

Srinivas Pandruvada (2):
  acpi: bus: Enable HWP CPPC objects
  acpi: bus: Set _OSC for diverse core support

Tim Chen (5):
  sched: Extend scheduler's asym packing
  x86/topology: Define x86's arch_update_cpu_topology
  x86: Enable Intel Turbo Boost Max Technology 3.0
  x86/sysctl: Add sysctl for ITMT scheduling feature
  x86/sched: Add SD_ASYM_PACKING flags to x86 ITMT CPU

 arch/x86/Kconfig                |   9 ++
 arch/x86/include/asm/topology.h |  32 ++++++
 arch/x86/kernel/Makefile        |   1 +
 arch/x86/kernel/itmt.c          | 231 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/smpboot.c       |  39 ++++++-
 drivers/acpi/bus.c              |  10 ++
 drivers/cpufreq/Kconfig.x86     |   1 +
 drivers/cpufreq/intel_pstate.c  |  56 +++++++++-
 include/linux/acpi.h            |   1 +
 include/linux/sched.h           |   4 +
 kernel/sched/core.c             |  15 +++
 kernel/sched/fair.c             |  59 +++++++---
 kernel/sched/sched.h            |   6 ++
 13 files changed, 444 insertions(+), 20 deletions(-)
 create mode 100644 arch/x86/kernel/itmt.c

-- 
2.5.5

