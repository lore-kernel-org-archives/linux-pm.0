From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v5.1-rc1
Date: Mon, 4 Mar 2019 14:21:50 +0100
Message-ID: <CAJZ5v0jAtF5mdu1-_Wt3SbmL3zhXpJY2byPuryvRmCaJgtcuLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.1-rc1

with top-most commit 1271d6d576b7e7c80519de211f250cfd4eebca1a

 Merge branch 'pm-opp'

on top of commit 5b317cbf2bcb85a1e96ce87717cb991ecab1dd4d

 Merge branch 'pm-cpufreq-fixes'

to receive power management updates for 5.1-rc1.

These are PM-runtime framework changes to use ktime instead of
jiffies for accounting, new PM core flag to mark devices that don't
need any form of power management, cpuidle updates including driver
API documentation and a new governor, cpufreq updates including a new
driver for Armada 8K, thermal cleanups and more, some energy-aware
scheduling (EAS) enabling changes, new chips support in the intel_idle
and RAPL drivers and assorted cleanups in some other places.

Specifics:

 - Update the PM-runtime framework to use ktime instead of
   jiffies for accounting (Thara Gopinath, Vincent Guittot).

 - Optimize the autosuspend code in the PM-runtime framework
   somewhat (Ladislav Michl).

 - Add a PM core flag to mark devices that don't need any form of
   power management (Sudeep Holla).

 - Introduce driver API documentation for cpuidle and add a new
   cpuidle governor for tickless systems (Rafael Wysocki).

 - Add Jacobsville support to the intel_idle driver (Zhang Rui).

 - Clean up a cpuidle core header file and the cpuidle-dt and ACPI
   processor-idle drivers (Yangtao Li, Joseph Lo, Yazen Ghannam).

 - Add new cpufreq driver for Armada 8K (Gregory Clement).

 - Fix and clean up cpufreq core (Rafael Wysocki, Viresh Kumar,
   Amit Kucheria).

 - Add support for light-weight tear-down and bring-up of CPUs to the
   cpufreq core and use it in the cpufreq-dt driver (Viresh Kumar).

 - Fix cpu_cooling Kconfig dependencies, add support for CPU cooling
   auto-registration to the cpufreq core and use it in multiple
   cpufreq drivers (Amit Kucheria).

 - Fix some minor issues and do some cleanups in the davinci,
   e_powersaver, ap806, s5pv210, qcom and kryo cpufreq drivers
   (Bartosz Golaszewski, Gustavo Silva, Julia Lawall, Paweł Chmiel,
   Taniya Das, Viresh Kumar).

 - Add a Hisilicon CPPC quirk to the cppc_cpufreq driver (Xiongfeng
   Wang).

 - Clean up the intel_pstate and acpi-cpufreq drivers (Erwan Velu,
   Rafael Wysocki).

 - Clean up multiple cpufreq drivers (Yangtao Li).

 - Update cpufreq-related MAINTAINERS entries (Baruch Siach, Lukas
   Bulwahn).

 - Add support for exposing the Energy Model via debugfs and make
   multiple cpufreq drivers register an Energy Model to support
   energy-aware scheduling (Quentin Perret, Dietmar Eggemann,
   Matthias Kaehlcke).

 - Add Ice Lake mobile and Jacobsville support to the Intel RAPL
   power-capping driver (Gayatri Kammela, Zhang Rui).

 - Add a power estimation helper to the operating performance points
   (OPP) framework and clean up a core function in it (Quentin Perret,
   Viresh Kumar).

 - Make minor improvements in the generic power domains (genpd), OPP
   and system suspend frameworks and in the PM core (Aditya Pakki,
   Douglas Anderson, Greg Kroah-Hartman, Rafael Wysocki, Yangtao Li).

Thanks!


---------------

Aditya Pakki (1):
      PM: clock_ops: fix missing clk_prepare() return value check

Amit Kucheria (11):
      cpufreq: Replace open-coded << with BIT()
      thermal: cpu_cooling: Require thermal core to be compiled in
      cpufreq: Auto-register the driver as a thermal cooling device if asked
      cpufreq: qcom-hw: Register as a cpufreq cooling device
      cpufreq: imx6q: Use auto-registration of thermal cooling device
      cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
      cpufreq: mediatek: Use auto-registration of thermal cooling device
      cpufreq: qoriq: Use auto-registration of thermal cooling device
      cpufreq: scmi: Use auto-registration of thermal cooling device
      cpufreq: scpi: Use auto-registration of thermal cooling device
      cpufreq: qcom-hw: Move to device_initcall

Bartosz Golaszewski (1):
      cpufreq: davinci: move configuration to include/linux/platform_data

Baruch Siach (1):
      MAINTAINERS: Update the active pm tree for ARM

Dietmar Eggemann (1):
      cpufreq: arm_big_little: Register an Energy Model

Douglas Anderson (2):
      PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
      PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()

Erwan Velu (2):
      cpufreq: intel_pstate: Add reasons for failure and debug messages
      cpufreq: acpi-cpufreq: Report if CPU doesn't support boost technologies

Gayatri Kammela (1):
      powercap/intel_rapl: add Ice Lake mobile

Greg Kroah-Hartman (3):
      PM: QoS: no need to check return value of debugfs_create functions
      PM: domains: no need to check return value of debugfs_create functions
      opp: no need to check return value of debugfs_create functions

Gregory CLEMENT (2):
      MAINTAINERS: add new entries for Armada 8K cpufreq driver
      cpufreq: ap806: add cpufreq driver for Armada 8K

Gustavo A. R. Silva (1):
      cpufreq: e_powersaver: Use struct_size() in kzalloc()

Joseph Lo (1):
      cpuidle: dt: bail out if the idle-state DT node is not compatible

Julia Lawall (1):
      cpufreq: ap806: add missing of_node_put after of_device_is_available

Ladislav Michl (1):
      PM-runtime: Optimize pm_runtime_autosuspend_expiration()

Lukas Bulwahn (1):
      MAINTAINERS: use common indentation

Matthias Kaehlcke (2):
      cpufreq: mediatek: Register an Energy Model
      cpufreq: qcom-hw: Register an Energy Model

Paweł Chmiel (1):
      cpufreq: s5pv210: Defer probe if getting regulators fail

Quentin Perret (5):
      PM / EM: Expose the Energy Model in debugfs
      cpufreq: dt: Register an Energy Model
      cpufreq: scpi: Register an Energy Model
      PM / OPP: Introduce a power estimation helper
      cpufreq: scmi: Register an Energy Model

Rafael J. Wysocki (10):
      cpuidle: New timer events oriented governor for tickless systems
      Documentation: driver-api: PM: Add cpuidle document
      PM / suspend: Print debug messages for device using direct-complete
      cpufreq: intel_pstate: Avoid redundant initialization of local vars
      cpufreq: intel_pstate: Eliminate intel_pstate_get_base_pstate()
      cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
      cpufreq: Add kerneldoc comments for two core functions
      cpufreq: Reorder and simplify cpufreq_update_policy()
      cpufreq: Fix two debug messages in cpufreq_set_policy()
      cpufreq: Pass updated policy to driver ->setpolicy() callback

Sudeep Holla (1):
      PM / core: Add support to skip power management in device/driver model

Taniya Das (1):
      cpufreq: qcom: Read voltage LUT and populate OPP

Thara Gopinath (1):
      PM-runtime: Replace jiffies-based accounting with ktime-based accounting

Vincent Guittot (5):
      PM-runtime: Add new interface to get accounted time
      drm/i915: Move on the new pm runtime interface
      PM-runtime: update accounting_timestamp on enable
      PM-runtime: Switch accounting over to ktime_get_mono_fast_ns()
      PM-runtime: update time accounting only when enabled

Viresh Kumar (9):
      cpufreq: Don't update new_policy on failures
      cpufreq: Use struct kobj_attribute instead of struct global_attr
      cpufreq: stats: Declare freq-attr right after their callbacks
      cpufreq: stats: Fix concurrency issues while resetting stats
      PM / OPP: Remove unused parameter of _generic_set_opp_clk_only()
      cpufreq: Allow light-weight tear down and bring up of CPUs
      cpufreq: dt: Implement online/offline() callbacks
      cpufreq: Replace double NOT (!!) with single NOT (!)
      cpufreq: kryo: Release OPP tables on module removal

Xiongfeng Wang (2):
      ACPI / CPPC: Add a helper to get desired performance
      cpufreq / cppc: Work around for Hisilicon CPPC cpufreq

Yangtao Li (10):
      cpuidle: use BIT() for idle state flags and remove
CPUIDLE_DRIVER_FLAGS_MASK
      PM / wakeup: fix kerneldoc comment for pm_wakeup_dev_event()
      cpufreq: qcom-kryo: make some variables static
      cpufreq: tegra124: add missing of_node_put()
      cpufreq: imx6q: Register an Energy Model
      cpufreq: OMAP: Register an Energy Model
      cpufreq: pcc-cpufreq: remove unneeded semicolon
      cpufreq: longhaul: remove unneeded semicolon
      cpufreq: powernv: fix missing check of return value in
init_powernv_pstates()
      cpufreq: speedstep: convert BUG() to BUG_ON()

Yazen Ghannam (1):
      ACPI / processor: Set P_LVL{2,3} idle state descriptions

Zhang Rui (2):
      powercap: intel_rapl: add support for Jacobsville
      intel_idle: add support for Jacobsville

---------------

 Documentation/admin-guide/pm/cpuidle.rst      | 104 +++++-
 Documentation/cpuidle/driver.txt              |  37 ---
 Documentation/cpuidle/governor.txt            |  28 --
 Documentation/driver-api/pm/cpuidle.rst       | 282 ++++++++++++++++
 Documentation/driver-api/pm/index.rst         |   7 +-
 MAINTAINERS                                   |  14 +-
 arch/arm/mach-davinci/da850.c                 |   2 +-
 arch/arm/mach-davinci/include/mach/cpufreq.h  |  26 --
 drivers/acpi/cppc_acpi.c                      |  42 +++
 drivers/acpi/processor_idle.c                 |   7 +
 drivers/base/cpu.c                            |   1 +
 drivers/base/power/clock_ops.c                |  13 +-
 drivers/base/power/common.c                   |   2 +-
 drivers/base/power/domain.c                   |  13 +-
 drivers/base/power/main.c                     |  11 +-
 drivers/base/power/runtime.c                  |  70 ++--
 drivers/base/power/sysfs.c                    |  17 +-
 drivers/base/power/wakeup.c                   |   2 +-
 drivers/cpufreq/Kconfig                       |   3 -
 drivers/cpufreq/Kconfig.arm                   |  16 +-
 drivers/cpufreq/Makefile                      |   1 +
 drivers/cpufreq/acpi-cpufreq.c                |   4 +-
 drivers/cpufreq/arm_big_little.c              |   2 +
 drivers/cpufreq/armada-8k-cpufreq.c           | 206 ++++++++++++
 drivers/cpufreq/cppc_cpufreq.c                |  65 ++++
 drivers/cpufreq/cpufreq-dt.c                  |  33 +-
 drivers/cpufreq/cpufreq.c                     | 134 +++++---
 drivers/cpufreq/cpufreq_stats.c               |  16 +-
 drivers/cpufreq/davinci-cpufreq.c             |   5 +-
 drivers/cpufreq/e_powersaver.c                |   5 +-
 drivers/cpufreq/imx6q-cpufreq.c               |  25 +-
 drivers/cpufreq/intel_pstate.c                | 105 +++---
 drivers/cpufreq/longhaul.c                    |   2 +-
 drivers/cpufreq/mediatek-cpufreq.c            |  16 +-
 drivers/cpufreq/omap-cpufreq.c                |   4 +-
 drivers/cpufreq/pcc-cpufreq.c                 |   2 +-
 drivers/cpufreq/powernv-cpufreq.c             |  10 +-
 drivers/cpufreq/qcom-cpufreq-hw.c             |  53 ++-
 drivers/cpufreq/qcom-cpufreq-kryo.c           |  22 +-
 drivers/cpufreq/qoriq-cpufreq.c               |  15 +-
 drivers/cpufreq/s5pv210-cpufreq.c             |  67 ++--
 drivers/cpufreq/scmi-cpufreq.c                |  53 ++-
 drivers/cpufreq/scpi-cpufreq.c                |  17 +-
 drivers/cpufreq/speedstep-ich.c               |   3 +-
 drivers/cpufreq/tegra124-cpufreq.c            |   2 +
 drivers/cpuidle/Kconfig                       |  11 +-
 drivers/cpuidle/dt_idle_states.c              |  15 +-
 drivers/cpuidle/governors/Makefile            |   1 +
 drivers/cpuidle/governors/teo.c               | 444 ++++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_pmu.c               |  16 +-
 drivers/gpu/drm/i915/i915_pmu.h               |   4 +-
 drivers/idle/intel_idle.c                     |   1 +
 drivers/opp/core.c                            |  22 +-
 drivers/opp/debugfs.c                         | 110 ++-----
 drivers/opp/of.c                              |  99 ++++++
 drivers/opp/opp.h                             |  15 +-
 drivers/powercap/intel_rapl.c                 |   2 +
 drivers/thermal/Kconfig                       |   1 +
 include/acpi/cppc_acpi.h                      |   1 +
 include/linux/cpufreq.h                       |  48 +--
 include/linux/cpuidle.h                       |   8 +-
 include/linux/device.h                        |  10 +
 include/linux/platform_data/davinci-cpufreq.h |  19 ++
 include/linux/pm.h                            |   7 +-
 include/linux/pm_domain.h                     |   8 +-
 include/linux/pm_opp.h                        |   6 +
 include/linux/pm_runtime.h                    |   2 +
 kernel/power/energy_model.c                   |  57 ++++
 kernel/power/qos.c                            |   8 +-
 69 files changed, 1921 insertions(+), 558 deletions(-)
