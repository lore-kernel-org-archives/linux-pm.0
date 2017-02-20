From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.11-rc1
Date: Tue, 21 Feb 2017 00:39:05 +0100
Message-ID: <CAJZ5v0iFCYqHeGD1MejBCsFAr3fd=8=e1BWrc0BsctHqCkXYCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.11-rc1

with top-most commit eee77a8a0d268b936b1641fd7d55efaa17c351d6

 Merge branch 'pm-tools'

on top of commit 7089db84e356562f8ba737c29e472cc42d530dbc

 Linux 4.10-rc8

to receive power management updates for v4.11-rc1.

The majority of changes go into the Operating Performance Points (OPP)
framework and cpufreq this time, followed by devfreq and some scattered
updates all over.

The OPP changes are mostly related to switching over from RCU-based
synchronization, that turned out to be overly complicated and
problematic, to reference counting using krefs.

In the cpufreq land there are core cleanups, documentation updates,
a new driver for Broadcom BMIPS SoCs, a new cpufreq-dt sub-driver for
TI SoCs that require special handling, ARM64 SoCs support for the
qoriq driver, intel_pstate updates, powernv driver update and assorted
fixes.

The devfreq changes are mostly fixes related to the sysfs interface and
some Exynos drivers updates.

Apart from that, the cpuidle menu governor will support per-CPU PM QoS
constraints for the wakeup latency now, some bugs in the wakeup IRQs
framework are fixed, the generic power domains framework should handle
asynchronous invocations of *noirq suspend/resume callbacks from now on,
the analyze_suspend.py script is updated and there is a new tool for
intel_pstate diagnostics.

Specifics:

 - Operating Performance Points (OPP) framework fixes, cleanups and
   switch over from RCU-based synchronization to reference counting
   using krefs (Viresh Kumar, Wei Yongjun, Dave Gerlach).

 - cpufreq core cleanups and documentation updates (Viresh Kumar,
   Rafael Wysocki).

 - New cpufreq driver for Broadcom BMIPS SoCs (Markus Mayer).

 - New cpufreq-dt sub-driver for TI SoCs requiring special handling,
   like in the AM335x, AM437x, DRA7x, and AM57x families, along with
   new DT bindings for it (Dave Gerlach, Paul Gortmaker).

 - ARM64 SoCs support for the qoriq cpufreq driver (Tang Yuantian).

 - intel_pstate driver updates including a new sysfs knob to control
   the driver's operation mode and fixes related to the no_turbo
   sysfs knob and the hardware-managed P-states feature support
   (Rafael Wysocki, Srinivas Pandruvada).

 - New interface to export ultra-turbo frequencies for the powernv
   cpufreq driver (Shilpasri Bhat).

 - Assorted fixes for cpufreq drivers (Arnd Bergmann, Dan Carpenter,
   Wei Yongjun).

 - devfreq core fixes, mostly related to the sysfs interface exported
   by it (Chanwoo Choi, Chris Diamand).

 - Updates of the exynos-bus and exynos-ppmu devfreq drivers (Chanwoo
   Choi).

 - Device PM QoS extension to support CPUs and support for per-CPU
   wakeup (device resume) latency constraints in the cpuidle menu
   governor (Alex Shi).

 - Wakeup IRQs framework fixes (Grygorii Strashko).

 - Generic power domains framework update including a fix to make
   it handle asynchronous invocations of *noirq suspend/resume
   callbacks correctly (Ulf Hansson, Geert Uytterhoeven).

 - Assorted fixes and cleanups in the core suspend/hibernate code,
   PM QoS framework and x86 ACPI idle support code (Corentin Labbe,
   Geert Uytterhoeven, Geliang Tang, John Keeping, Nick Desaulniers).

 - Update of the analyze_suspend.py script is updated to version 4.5
   offering multiple improvements (Todd Brandt).

 - New tool for intel_pstate diagnostics using the pstate_sample
   tracepoint (Doug Smythies).

Thanks!

---------------

Alex Shi (3):
      cpuidle/menu: stop seeking deeper idle if current state is deep enough
      cpuidle/menu: add per CPU PM QoS resume latency consideration
      CPU / PM: expose pm_qos_resume_latency for CPUs

Arnd Bergmann (1):
      cpufreq: CPPC: add ACPI_PROCESSOR dependency

Chanwoo Choi (11):
      PM / devfreq: exynos-bus: Add the detailed correlation for Exynos5433
      PM / devfreq: exynos-ppmu: Use the regmap interface to handle
the registers
      PM / devfreq: exynos-bus: Print the real clock rate of bus
      PM / devfreq: Fix the checkpatch warnings
      PM / devfreq: Fix the wrong description for userspace governor
      PM / devfreq: exynos-ppmu: Show the registred device for ppmu device
      PM / devfreq: Fix available_governor sysfs
      PM / devfreq: Fix wrong trans_stat of passive devfreq device
      PM / devfreq: Remove unnecessary separate _remove_devfreq()
      PM / devfreq: Simplify the sysfs name of devfreq-event device
      PM / devfreq: Modify the device name as devfreq(X) for sysfs

Chris Diamand (1):
      PM / devfreq: Don't delete sysfs group twice

Corentin LABBE (1):
      PM / QoS: Remove unneeded linux/miscdevice.h include

Dan Carpenter (1):
      cpufreq: s3c2416: double free on driver init error path

Dave Gerlach (4):
      PM / OPP: Expose _of_get_opp_desc_node as dev_pm_opp API
      Documentation: dt: add bindings for ti-cpufreq
      cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime
      cpufreq: dt: Don't use generic platdev driver for ti-cpufreq platforms

Doug Smythies (1):
      tools/power/x86: Debug utility for intel_pstate driver

Geert Uytterhoeven (3):
      PM / Domains: Provide dummy governors if CONFIG_PM_GENERIC_DOMAINS=n
      PM / sleep: Fix test_suspend after sleep state rework
      PM / Documentation: Spelling s/wrtie/write/

Geliang Tang (1):
      PM / Hibernate: Use rb_entry() instead of container_of()

Grygorii Strashko (3):
      PM / wakeirq: Enable dedicated wakeirq for suspend
      PM / wakeirq: Fix spurious wake-up events for dedicated wakeirqs
      PM / wakeirq: report a wakeup_event on dedicated wekup irq

John Keeping (1):
      PM / QoS: Fix memory leak on resume_latency.notifiers

Markus Mayer (5):
      MIPS: BMIPS: Update defconfig
      BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
      cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
      MIPS: BMIPS: enable CPUfreq
      MAINTAINERS: cpufreq: add bmips-cpufreq.c

Nick Desaulniers (1):
      ACPI / idle: small formatting fixes

Paul Gortmaker (1):
      cpufreq: make ti-cpufreq explicitly non-modular

Rafael J. Wysocki (3):
      cpufreq: intel_pstate: Expose global sysfs attributes upfront
      cpufreq: intel_pstate: Operation mode control from sysfs
      cpufreq: Do not clear real_cpus mask on policy init

Shilpasri G Bhat (1):
      cpufreq: powernv: Add boost files to export ultra-turbo frequencies

Srinivas Pandruvada (3):
      cpufreq: intel_pstate: Lower frequency than expected under no_turbo
      cpufreq: intel_pstate: Make HWP limits compatible with legacy
      cpufreq: intel_pstate: Calculate guaranteed performance for HWP

Tang Yuantian (2):
      cpufreq: qoriq: add ARM64 SoCs support
      cpufreq: qoriq: Don't look at clock implementation details

Todd E Brandt (4):
      scripts: analyze_suspend.py: Update to upstream v4.3
      scripts: analyze_suspend.py: Update to upstream v4.4
      scripts: analyze_suspend.py: Update to upstream v4.5
      AnalyzeSuspend: fix drag and zoom bug in javascript

Ulf Hansson (3):
      PM / Domains: Rename functions in genpd for power on/off
      PM / Domains: Correct comment in irq_safe_dev_in_no_sleep_domain()
      PM / Domains: Fix asynchronous execution of *noirq() callbacks

Viresh Kumar (29):
      PM / OPP: Fix memory leak while adding duplicate OPPs
      PM / OPP: Remove useless TODO
      PM / OPP: Rename _allocate_opp() to _opp_allocate()
      PM / OPP: Error out on failing to add static OPPs for v1 bindings
      PM / OPP: Add light weight _opp_free() routine
      PM / OPP: Rename and split _dev_pm_opp_remove_table()
      PM / OPP: Don't allocate OPP table from _opp_allocate()
      PM / OPP: Rename dev_pm_opp_get_suspend_opp() and return OPP rate
      PM / OPP: Don't expose srcu_head to register notifiers
      PM / OPP: Split out part of _add_opp_table() and _remove_opp_table()
      PM / OPP: Add per OPP table mutex
      PM / OPP: Add 'struct kref' to OPP table
      PM / OPP: Return opp_table from dev_pm_opp_set_*() routines
      PM / OPP: Take reference of the OPP table while adding/removing OPPs
      PM / OPP: Use dev_pm_opp_get_opp_table() instead of _add_opp_table()
      PM / OPP: Add 'struct kref' to struct dev_pm_opp
      PM / OPP: Update OPP users to put reference
      PM / OPP: Take kref from _find_opp_table()
      PM / OPP: Move away from RCU locking
      PM / OPP: Simplify _opp_set_availability()
      PM / OPP: Simplify dev_pm_opp_get_max_volt_latency()
      PM / OPP: Update Documentation to remove RCU specific bits
      cpufreq: Remove policy create/remove notifiers
      cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config option
      cpufreq: Documentation: Minor reformatting
      cpufreq: Documentation: Updates based on current code
      ACPI: processor_perflib: Simplify code and stop using CPUFREQ_START
      cpufreq: Remove CPUFREQ_START notifier event
      cpufreq: Fix typos in comments

Wei Yongjun (2):
      PM / OPP: Make _find_opp_table_unlocked() static
      cpufreq: brcmstb-avs-cpufreq: remove unnecessary platform_set_drvdata()

---------------

 .../ABI/testing/sysfs-class-devfreq-event          |   25 +
 Documentation/cpu-freq/core.txt                    |   24 +-
 Documentation/cpu-freq/cpu-drivers.txt             |  177 +-
 Documentation/cpu-freq/cpufreq-stats.txt           |   24 +-
 Documentation/cpu-freq/governors.txt               |  322 ++--
 Documentation/cpu-freq/index.txt                   |   23 +-
 Documentation/cpu-freq/intel-pstate.txt            |   15 +
 Documentation/cpu-freq/user-guide.txt              |   60 +-
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |  128 ++
 .../devicetree/bindings/devfreq/exynos-bus.txt     |   14 +
 Documentation/power/opp.txt                        |   52 +-
 Documentation/power/states.txt                     |    2 +-
 MAINTAINERS                                        |    7 +
 arch/arm/configs/exynos_defconfig                  |    2 +-
 arch/arm/configs/multi_v5_defconfig                |    2 +-
 arch/arm/configs/multi_v7_defconfig                |    2 +-
 arch/arm/configs/mvebu_v5_defconfig                |    2 +-
 arch/arm/configs/pxa_defconfig                     |    2 +-
 arch/arm/configs/shmobile_defconfig                |    2 +-
 arch/arm/mach-omap2/pm.c                           |    5 +-
 arch/mips/Kconfig                                  |    2 +
 arch/mips/configs/bmips_stb_defconfig              |   16 +-
 arch/mips/configs/lemote2f_defconfig               |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig          |    2 +-
 arch/x86/kernel/acpi/cstate.c                      |    9 +-
 drivers/acpi/processor_perflib.c                   |    4 +-
 drivers/base/cpu.c                                 |    2 +
 drivers/base/power/domain.c                        |  124 +-
 drivers/base/power/opp/core.c                      | 1011 ++++------
 drivers/base/power/opp/cpu.c                       |   66 +-
 drivers/base/power/opp/of.c                        |  154 +-
 drivers/base/power/opp/opp.h                       |   40 +-
 drivers/base/power/qos.c                           |    2 +-
 drivers/base/power/wakeirq.c                       |   22 +-
 drivers/clk/tegra/clk-dfll.c                       |   17 +-
 drivers/cpufreq/Kconfig                            |   20 +-
 drivers/cpufreq/Kconfig.arm                        |   13 +-
 drivers/cpufreq/Makefile                           |    2 +
 drivers/cpufreq/bmips-cpufreq.c                    |  188 ++
 drivers/cpufreq/brcmstb-avs-cpufreq.c              |    2 -
 drivers/cpufreq/cpufreq-dt-platdev.c               |    2 -
 drivers/cpufreq/cpufreq-dt.c                       |    7 +-
 drivers/cpufreq/cpufreq.c                          |   21 +-
 drivers/cpufreq/cpufreq_stats.c                    |   14 -
 drivers/cpufreq/exynos5440-cpufreq.c               |    5 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   10 +-
 drivers/cpufreq/intel_pstate.c                     |  385 +++-
 drivers/cpufreq/mt8173-cpufreq.c                   |    8 +-
 drivers/cpufreq/omap-cpufreq.c                     |    4 +-
 drivers/cpufreq/powernv-cpufreq.c                  |   50 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c              |    3 -
 drivers/cpufreq/qoriq-cpufreq.c                    |  148 +-
 drivers/cpufreq/s3c2416-cpufreq.c                  |    1 -
 drivers/cpufreq/sti-cpufreq.c                      |   13 +-
 drivers/cpufreq/ti-cpufreq.c                       |  268 +++
 drivers/cpuidle/governors/menu.c                   |   11 +-
 drivers/devfreq/devfreq-event.c                    |    4 +-
 drivers/devfreq/devfreq.c                          |  114 +-
 drivers/devfreq/event/exynos-ppmu.c                |  329 +++-
 drivers/devfreq/exynos-bus.c                       |   22 +-
 drivers/devfreq/governor.h                         |    2 +
 drivers/devfreq/governor_passive.c                 |   10 +-
 drivers/devfreq/governor_userspace.c               |   11 +-
 drivers/devfreq/rk3399_dmc.c                       |   16 +-
 drivers/devfreq/tegra-devfreq.c                    |    4 +-
 drivers/thermal/cpu_cooling.c                      |   11 +-
 drivers/thermal/devfreq_cooling.c                  |   15 +-
 include/linux/cpufreq.h                            |    7 +-
 include/linux/devfreq.h                            |    3 +
 include/linux/pm_domain.h                          |    3 +
 include/linux/pm_opp.h                             |   72 +-
 include/linux/pm_qos.h                             |    1 -
 kernel/power/suspend_test.c                        |    2 +-
 kernel/power/swap.c                                |    2 +-
 scripts/analyze_suspend.py                         | 1933 ++++++++++++--------
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  569 ++++++
 77 files changed, 4163 insertions(+), 2505 deletions(-)
