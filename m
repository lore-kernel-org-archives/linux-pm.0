From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.7-rc1
Date: Mon, 16 May 2016 23:17:59 +0200
Message-ID: <CAJZ5v0jxxQDqy8Jdo4qhCEoChuK6CP7skeueOxtyoCxxzQP3aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36239 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbcEPVSB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 May 2016 17:18:01 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.7-rc1

to receive the main part of power management material for v4.7-rc1
with top-most commit 27c4a1c5ef61b6d4a9aeae68b24419b4319b97ed

 Merge branches 'pm-avs', 'pm-clk', 'powercap' and 'pm-tools'

on top of commit 44549e8f5eea4e0a41b487b63e616cb089922b99

 Linux 4.6-rc7

The majority of changes go into the cpufreq subsystem this time.

To me, quite obviously, the biggest ticket item is the new "schedutil"
governor.  Interestingly enough, it's the first new cpufreq governor
since the beginning of the git era (except for some out-of-the-tree
ones).

There are two main differences between it and the existing governors.
First, it uses the information provided by the scheduler directly for
making its decisions, so it doesn't have to track anything by itself.
Second, it can invoke drivers (supporting that feature) to adjust CPU
performance right away without having to spawn work items to be
executed in process context or similar.  Currently, the acpi-cpufreq
driver is the only one supporting that mode of operation, but then it
is used on a large number of systems.

The "schedutil" governor as included here is very simple and mostly
regarded as a foundation for future work on the integration of
the scheduler with CPU power management (in fact, there is work
in progress on top of it already).  Nevertheless it works and
the preliminary results obtained with it are encouraging.

There also is some consolidation of CPU frequency management for ARM
platforms that can add their machine IDs the the new stub dt-platdev
driver now and that will take care of creating the requisite platform
device for cpufreq-dt, so it is not necessary to do that in platform
code any more.  Several ARM platforms are switched over to using this
generic mechanism.

In addition to that, the intel_pstate driver is now going to respect
CPU frequency limits set by the platform firmware (or a BMC) and
provided via the ACPI _PPC object.

The devfreq subsystem is getting a new "passive" governor for SoCs
subsystems that will depend on somebody else to manage their voltage
rails and its support for Samsung Exynos SoCs is consolidated.

The rest is support for new hardware (Intel Broxton support in
intel_idle for one example), bug fixes, optimizations and cleanups
in a number of places.

Specifics:

 - New cpufreq "schedutil" governor (making decisions based on CPU
   utilization information provided by the scheduler and capable of
   switching CPU frequencies right away if the underlying driver
   supports that) and support for fast frequency switching in the
   acpi-cpufreq driver (Rafael Wysocki).

 - Consolidation of CPU frequency management on ARM platforms allowing
   them to get rid of some platform-specific boilerplate code if they
   are going to use the cpufreq-dt driver (Viresh Kumar, Finley Xiao,
   Marc Gonzalez).

 - Support for ACPI _PPC and CPU frequency limits in the intel_pstate
   driver (Srinivas Pandruvada).

 - Fixes and cleanups in the cpufreq core and generic governor code
   (Rafael Wysocki, Sai Gurrappadi).

 - intel_pstate driver optimizations and cleanups (Rafael Wysocki,
   Philippe Longepe, Chen Yu, Joe Perches).

 - cpufreq powernv driver fixes and cleanups (Akshay Adiga, Shilpasri
   Bhat).

 - cpufreq qoriq driver fixes and cleanups (Jia Hongtao).

 - ACPI cpufreq driver cleanups (Viresh Kumar).

 - Assorted cpufreq driver updates (Ashwin Chaugule, Geliang Tang,
   Javier Martinez Canillas, Paul Gortmaker, Sudeep Holla).

 - Assorted cpufreq fixes and cleanups (Joe Perches, Arnd Bergmann).

 - Fixes and cleanups in the OPP (Operating Performance Points)
   framework, mostly related to OPP sharing, and reorganization of
   OF-dependent code in it (Viresh Kumar, Arnd Bergmann, Sudeep Holla).

 - New "passive" governor for devfreq (for SoC subsystems that will
   rely on someone else for the management of their power resources)
   and consolidation of devfreq support for Exynos platforms, coding
   style and typo fixes for devfreq (Chanwoo Choi, MyungJoo Ham).

 - PM core fixes and cleanups, mostly to make it work better with the
   generic power domains (genpd) framework, and updates for that
   framework (Ulf Hansson, Thierry Reding, Colin Ian King).

 - Intel Broxton support for the intel_idle driver (Len Brown).

 - cpuidle core optimization and fix (Daniel Lezcano, Dave Gerlach).

 - ARM cpuidle cleanups (Jisheng Zhang).

 - Intel Kabylake support for the RAPL power capping driver (Jacob Pan).

 - AVS (Adaptive Voltage Switching) rockchip-io driver update (Heiko
   Stuebner).

 - Updates for the cpupower tool (Arjun Sreedharan, Colin Ian King,
   Mattia Dongili, Thomas Renninger).

Thanks!

---------------

Akshay Adiga (3):
      cpufreq: powernv: Ramp-down global pstate slower than local-pstate
      cpufreq: powernv: Move smp_call_function_any() out of irq safe block
      cpufreq: powernv: del_timer_sync when global and local pstate are equal

Arjun Sreedharan (1):
      cpupower: fix potential memory leak

Arnd Bergmann (2):
      PM / OPP: pass cpumask by reference
      cpufreq: schedutil: Make default depend on CONFIG_SMP

Ashwin Chaugule (1):
      cpufreq: ACPI / CPPC: Add module support for cppc_cpufreq driver

Chanwoo Choi (13):
      PM / devfreq: exynos: Add generic exynos bus frequency driver
      PM / devfreq: exynos: Add documentation for generic exynos bus
frequency driver
      PM / devfreq: Add devfreq_get_devfreq_by_phandle()
      PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier
      PM / devfreq: Add new passive governor
      PM / devfreq: exynos: Add support of bus frequency of sub-blocks
using passive governor
      PM / devfreq: exynos: Update documentation for bus devices using
passive governor
      PM / devfreq: exynos: Add the detailed correlation between
sub-blocks and power line
      PM / devfreq: exynos: Remove unused exynos4/5 busfreq driver
      MAINTAINERS: Add samsung bus frequency driver entry
      PM / devfreq: event: Add new Exynos NoC probe driver
      PM / devfreq: event: Find the instance of devfreq-event device
by using phandle
      PM / devfreq: exynos: Add the detailed correlation for Exynos5422 bus

Chen Yu (1):
      intel_pstate: Avoid unnecessary synchronize_sched() during initialization

Colin Ian King (3):
      PM / clk: ensure we don't allocate a -ve size of count clks
      cpupower: bench: parse.c: fix several resource leaks
      cpupowerutils: bench: trivial fix of spelling mistake on "average"

Daniel Lezcano (1):
      cpuidle: Replace ktime_get() with local_clock()

Dave Gerlach (1):
      cpuidle: Indicate when a device has been unregistered

Finley Xiao (1):
      cpufreq: rockchip: Use generic platdev driver

Geliang Tang (1):
      cpufreq: mt8173: use list_for_each_entry*()

Heiko Stuebner (1):
      PM / AVS: rockchip-io: make io-domains a child of the GRF

Jacob Pan (1):
      powercap/intel_rapl: Add support for Kabylake

Javier Martinez Canillas (1):
      cpufreq: e_powersaver: Use IS_ENABLED() instead of checking for
built-in or module

Jia Hongtao (3):
      cpufreq: qoriq: Don't show cooling device messages if THERMAL_OF undefined
      cpufreq: qoriq: Remove __exit macro from .exit callback
      cpufreq: qoriq: Fix cooling device registration issue during suspend

Jisheng Zhang (4):
      ARM: cpuidle: add const qualifier to cpuidle_ops member in structures
      ARM: cpuidle: constify return value of arm_cpuidle_get_ops()
      soc: qcom: spm: Use const and __initconst for qcom_cpuidle_ops
      drivers: firmware: psci: use const and __initconst for psci_cpuidle_ops

Joe Perches (3):
      intel_pstate: Use pr_fmt
      cpufreq: Convert printk(KERN_<LEVEL> to pr_<level>
      cpufreq: Use consistent prefixing via pr_fmt

Len Brown (1):
      intel_idle: add BXT support

Marc Gonzalez (1):
      cpufreq: tango: Use generic platdev driver

Mattia Dongili (2):
      Honour user's LDFLAGS
      Fix cpupower manpages "NAME" section

MyungJoo Ham (1):
      PM / devfreq: style/typo fixes

Paul Gortmaker (1):
      cpufreq: ppc_cbe_cpufreq_pmi: make the driver explicitly non-modular

Philippe Longepe (1):
      cpufreq: intel_pstate: Use average P-State instead of current P-State

Rafael J. Wysocki (19):
      cpufreq: sched: Helpers to add and remove update_util hooks
      cpufreq: governor: New data type for management part of dbs_data
      cpufreq: governor: Move abstract gov_attr_set code to seperate file
      cpufreq: Move governor attribute set headers to cpufreq.h
      cpufreq: Move governor symbols to cpufreq.h
      cpufreq: Support for fast frequency switching
      cpufreq: schedutil: New governor based on scheduler utilization data
      cpufreq: Call cpufreq_disable_fast_switch() in sugov_exit()
      intel_pstate: Avoid pointless FRAC_BITS shifts under div_fp()
      cpufreq: Simplify switch () in cpufreq_cpu_callback()
      cpufreq: Rearrange cpufreq_add_dev()
      cpufreq: governor: Fix prev_load initialization in
cpufreq_governor_start()
      cpufreq: governor: Change confusing struct field and variable names
      cpufreq: governor: Fix handling of special cases in dbs_update()
      cpufreq: schedutil: Make it depend on CONFIG_SMP
      intel_pstate: Clean up intel_pstate_get()
      intel_pstate: Clarify average performance computation
      intel_pstate: Use sample.core_avg_perf in get_avg_pstate()
      intel_pstate: Clean up get_target_pstate_use_performance()

Sai Gurrappadi (1):
      cpufreq: Fix GOV_LIMITS handling for the userspace governor

Shilpasri G Bhat (1):
      cpufreq: powernv: Remove flag use-case of policy->driver_data

Srinivas Pandruvada (4):
      cpufreq: intel_pstate: Enforce _PPC limits
      cpufreq: intel_pstate: Adjust policy->max
      cpufreq: intel_pstate: Enable PPC enforcement for servers
      cpufreq: intel_pstate: Ignore _PPC processing under HWP

Sudeep Holla (2):
      PM / OPP: add non-OF versions of dev_pm_opp_{cpumask_, }remove_table
      cpufreq: arm_big_little: use generic OPP functions for {init,
free}_opp_table

Thierry Reding (1):
      PM / sleep: Drop unused `info' variable

Thomas Renninger (1):
      cpupower: Add cpuidle parts into library

Ulf Hansson (7):
      PM / Runtime: Fix error path in pm_runtime_force_resume()
      PM / Runtime: Move ignore_children flag under CONFIG_PM
      PM / Domains: Rename stop_ok to suspend_ok for the genpd governor
      PM / Domains: Rename pm_genpd_runtime_suspend|resume()
      PM / Domains: Remove ->save|restore_state() callbacks
      PM / Domains: Remove redundant pm_runtime_get|put*() in pm_genpd_prepare()
      PM / Domains: Drop unnecessary wakeup code from pm_genpd_prepare()

Viresh Kumar (28):
      cpufreq: tegra124: No need of setting platform-data
      cpufreq: dt: Include types.h from cpufreq-dt.h
      cpufreq: dt: Add generic platform-device creation support
      ARM: exynos: exynos-cpufreq platform device isn't supported anymore
      cpufreq: exynos: Use generic platdev driver
      cpufreq: ACPI: policy->driver_data can't be NULL in ->exit()
      cpufreq: ACPI: Remove freq_table from acpi_cpufreq_data
      PM / OPP: Propagate the error returned by _find_opp_table()
      PM / OPP: Add missing doc style comments
      PM / OPP: dev_pm_opp_set_sharing_cpus() doesn't depend on CONFIG_OF
      PM / OPP: Relocate dev_pm_opp_set_sharing_cpus()
      PM / OPP: Mark shared-opp for non-dt case
      cpufreq: dt: Mark platdev machines array as __initconst
      cpufreq: berlin: Use generic platdev driver
      cpufreq: imx: Use generic platdev driver
      cpufreq: omap: Use generic platdev driver
      cpufreq: shmobile: Use generic platdev driver
      cpufreq: sunxi: Use generic platdev driver
      cpufreq: zynq: Use generic platdev driver
      cpufreq: hisilicon: Use generic platdev driver
      PM / OPP: -ENOSYS is applicable only to syscalls
      PM / OPP: Mark cpumask as const in dev_pm_opp_set_sharing_cpus()
      PM / OPP: Add dev_pm_opp_get_sharing_cpus()
      cpufreq: dt: Identify cpu-sharing for platforms without
operating-points-v2
      mvebu: Use dev_pm_opp_set_sharing_cpus() to mark OPP tables as shared
      cpufreq: dt: Kill platform-data
      cpufreq: mvebu: Move cpufreq code into drivers/cpufreq/
      PM / OPP: Move CONFIG_OF dependent code in a separate file

---------------

 .../bindings/devfreq/event/exynos-nocp.txt         |   26 +
 .../devicetree/bindings/devfreq/exynos-bus.txt     |  409 ++++++++
 .../bindings/power/rockchip-io-domain.txt          |    4 +-
 Documentation/kernel-parameters.txt                |    5 +
 MAINTAINERS                                        |   10 +
 arch/arm/include/asm/cpuidle.h                     |    2 +-
 arch/arm/kernel/cpuidle.c                          |    6 +-
 arch/arm/mach-berlin/berlin.c                      |    6 -
 arch/arm/mach-exynos/exynos.c                      |   29 -
 arch/arm/mach-imx/imx27-dt.c                       |   10 -
 arch/arm/mach-imx/mach-imx51.c                     |    3 -
 arch/arm/mach-imx/mach-imx53.c                     |    2 -
 arch/arm/mach-imx/mach-imx7d.c                     |    6 -
 arch/arm/mach-mvebu/pmsu.c                         |   85 --
 arch/arm/mach-omap2/pm.c                           |    7 +-
 arch/arm/mach-rockchip/rockchip.c                  |    1 -
 arch/arm/mach-shmobile/Makefile                    |    1 -
 arch/arm/mach-shmobile/common.h                    |    7 -
 arch/arm/mach-shmobile/cpufreq.c                   |   19 -
 arch/arm/mach-sunxi/sunxi.c                        |    9 -
 arch/arm/mach-zynq/common.c                        |    2 -
 drivers/base/power/clock_ops.c                     |    2 +-
 drivers/base/power/domain.c                        |  145 ++-
 drivers/base/power/domain_governor.c               |   20 +-
 drivers/base/power/main.c                          |   18 +-
 drivers/base/power/opp/Makefile                    |    1 +
 drivers/base/power/opp/core.c                      |  440 +-------
 drivers/base/power/opp/cpu.c                       |  199 ++--
 drivers/base/power/opp/of.c                        |  591 +++++++++++
 drivers/base/power/opp/opp.h                       |   14 +
 drivers/base/power/runtime.c                       |    9 +-
 drivers/cpufreq/Kconfig                            |   45 +
 drivers/cpufreq/Kconfig.arm                        |    9 -
 drivers/cpufreq/Kconfig.x86                        |    1 +
 drivers/cpufreq/Makefile                           |    4 +-
 drivers/cpufreq/acpi-cpufreq.c                     |  129 ++-
 drivers/cpufreq/arm_big_little.c                   |   54 +-
 drivers/cpufreq/arm_big_little.h                   |    4 +-
 drivers/cpufreq/arm_big_little_dt.c                |   21 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   21 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   94 ++
 drivers/cpufreq/cpufreq-dt.c                       |   22 +-
 drivers/cpufreq/cpufreq-nforce2.c                  |   28 +-
 drivers/cpufreq/cpufreq.c                          |  164 ++-
 drivers/cpufreq/cpufreq_conservative.c             |   25 +-
 drivers/cpufreq/cpufreq_governor.c                 |  271 +++--
 drivers/cpufreq/cpufreq_governor.h                 |   46 +-
 drivers/cpufreq/cpufreq_governor_attr_set.c        |   84 ++
 drivers/cpufreq/cpufreq_ondemand.c                 |   29 +-
 drivers/cpufreq/cpufreq_userspace.c                |   43 +-
 drivers/cpufreq/e_powersaver.c                     |   76 +-
 drivers/cpufreq/elanfreq.c                         |    4 +-
 drivers/cpufreq/hisi-acpu-cpufreq.c                |   42 -
 drivers/cpufreq/ia64-acpi-cpufreq.c                |   10 +-
 drivers/cpufreq/intel_pstate.c                     |  303 ++++--
 drivers/cpufreq/longhaul.c                         |   84 +-
 drivers/cpufreq/loongson2_cpufreq.c                |    7 +-
 drivers/cpufreq/maple-cpufreq.c                    |   11 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |   14 +-
 drivers/cpufreq/mvebu-cpufreq.c                    |  107 ++
 drivers/cpufreq/omap-cpufreq.c                     |    7 +-
 drivers/cpufreq/p4-clockmod.c                      |   19 +-
 drivers/cpufreq/pmac32-cpufreq.c                   |   14 +-
 drivers/cpufreq/pmac64-cpufreq.c                   |   47 +-
 drivers/cpufreq/powernow-k6.c                      |   16 +-
 drivers/cpufreq/powernow-k7.c                      |   70 +-
 drivers/cpufreq/powernv-cpufreq.c                  |  272 ++++-
 drivers/cpufreq/ppc_cbe_cpufreq.h                  |    2 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c              |   15 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                   |   18 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |    9 +-
 drivers/cpufreq/s3c2412-cpufreq.c                  |   15 +-
 drivers/cpufreq/s3c2440-cpufreq.c                  |    6 +-
 drivers/cpufreq/s3c24xx-cpufreq-debugfs.c          |    4 +-
 drivers/cpufreq/s3c24xx-cpufreq.c                  |   59 +-
 drivers/cpufreq/s5pv210-cpufreq.c                  |   10 +-
 drivers/cpufreq/sc520_freq.c                       |   10 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   47 +-
 drivers/cpufreq/speedstep-centrino.c               |    6 +-
 drivers/cpufreq/speedstep-ich.c                    |    8 +-
 drivers/cpufreq/speedstep-lib.c                    |   11 +-
 drivers/cpufreq/speedstep-smi.c                    |    7 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |    7 -
 drivers/cpufreq/vexpress-spc-cpufreq.c             |    4 +-
 drivers/cpuidle/cpuidle.c                          |   14 +-
 drivers/devfreq/Kconfig                            |   36 +-
 drivers/devfreq/Makefile                           |    4 +-
 drivers/devfreq/devfreq-event.c                    |    5 +
 drivers/devfreq/devfreq.c                          |  207 +++-
 drivers/devfreq/event/Kconfig                      |    8 +
 drivers/devfreq/event/Makefile                     |    2 +
 drivers/devfreq/event/exynos-nocp.c                |  304 ++++++
 drivers/devfreq/event/exynos-nocp.h                |   78 ++
 drivers/devfreq/exynos-bus.c                       |  570 +++++++++++
 drivers/devfreq/exynos/Makefile                    |    3 -
 drivers/devfreq/exynos/exynos4_bus.c               | 1055 --------------------
 drivers/devfreq/exynos/exynos4_bus.h               |  110 --
 drivers/devfreq/exynos/exynos5_bus.c               |  431 --------
 drivers/devfreq/exynos/exynos_ppmu.c               |  119 ---
 drivers/devfreq/exynos/exynos_ppmu.h               |   86 --
 drivers/devfreq/governor_passive.c                 |  205 ++++
 drivers/firmware/psci.c                            |    2 +-
 drivers/idle/intel_idle.c                          |  137 +++
 drivers/mmc/host/toshsd.c                          |    1 +
 drivers/power/avs/rockchip-io-domain.c             |   10 +-
 drivers/powercap/intel_rapl.c                      |    2 +
 drivers/soc/qcom/spm.c                             |    2 +-
 include/linux/cpufreq-dt.h                         |   22 -
 include/linux/cpufreq.h                            |   54 +
 include/linux/devfreq.h                            |   99 ++
 include/linux/device.h                             |    5 -
 include/linux/pm.h                                 |    2 +-
 include/linux/pm_domain.h                          |    6 +-
 include/linux/pm_opp.h                             |   62 +-
 include/linux/pm_runtime.h                         |    6 +
 include/linux/sched.h                              |    5 +-
 kernel/sched/Makefile                              |    1 +
 kernel/sched/cpufreq.c                             |   48 +-
 kernel/sched/cpufreq_schedutil.c                   |  530 ++++++++++
 kernel/sched/sched.h                               |    8 +
 kernel/trace/power-traces.c                        |    1 +
 tools/power/cpupower/Makefile                      |   12 +-
 tools/power/cpupower/bench/Makefile                |    2 +-
 tools/power/cpupower/bench/README-BENCH            |    2 +-
 tools/power/cpupower/bench/benchmark.c             |    4 +-
 tools/power/cpupower/bench/parse.c                 |   20 +-
 tools/power/cpupower/bench/system.c                |    3 +-
 tools/power/cpupower/lib/cpufreq.c                 |  550 +++++++++-
 tools/power/cpupower/lib/cpufreq.h                 |   59 +-
 tools/power/cpupower/lib/cpuidle.c                 |  380 +++++++
 tools/power/cpupower/lib/cpuidle.h                 |   23 +
 tools/power/cpupower/lib/cpupower.c                |  192 ++++
 tools/power/cpupower/lib/cpupower.h                |   35 +
 tools/power/cpupower/lib/cpupower_intern.h         |    5 +
 tools/power/cpupower/lib/sysfs.c                   |  672 -------------
 tools/power/cpupower/lib/sysfs.h                   |   31 -
 tools/power/cpupower/man/cpupower-frequency-info.1 |    2 +-
 tools/power/cpupower/man/cpupower-frequency-set.1  |    2 +-
 tools/power/cpupower/man/cpupower-idle-info.1      |    2 +-
 tools/power/cpupower/man/cpupower-idle-set.1       |    2 +-
 tools/power/cpupower/utils/cpufreq-set.c           |    8 +-
 tools/power/cpupower/utils/cpuidle-info.c          |   32 +-
 tools/power/cpupower/utils/cpuidle-set.c           |   26 +-
 tools/power/cpupower/utils/helpers/helpers.h       |   26 +-
 tools/power/cpupower/utils/helpers/topology.c      |  107 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |   12 +-
 146 files changed, 6477 insertions(+), 4495 deletions(-)
