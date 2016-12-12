From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.10-rc1
Date: Mon, 12 Dec 2016 23:31:15 +0100
Message-ID: <CAJZ5v0iSzExr9Mf8AF7U53rjJrxDDyBsUYGrqi3FOm6AbdO1KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.10-rc1

with top-most commit bbc17bb8a89b3eb31520abf3a9b362d5ee54f908

 Merge branch 'pm-devfreq'

on top of commit 69973b830859bc6529a7a0468ba0d80ee5117826

 Linux 4.9

to receive power management updates for v4.10-rc1.

Again, cpufreq gets more changes than the other parts this time
(one new driver, one old driver less, a bunch of enhancements of
the existing code, new CPU IDs, fixes, cleanups).

There also are some changes in cpuidle (idle injection rework, a
couple of new CPU IDs, online/offline rework in intel_idle, fixes
and cleanups), in the generic power domains framework (mostly related
to supporting power domains containing CPUs), and in the Operating
Performance Points (OPP) library (mostly related to supporting
devices with multiple voltage regulators).

In addition to that, the system sleep state selection interface is
modified to make it easier for distributions with unchanged user
space to support suspend-to-idle as the default system suspend
method, some issues are fixed in the PM core, the latency tolerance
PM QoS framework is improved a bit, the Intel RAPL power capping
driver is cleaned up and there are some fixes and cleanups in the
devfreq subsystem.

Specifics:

 - New cpufreq driver for Broadcom STB SoCs and a Device Tree binding
   for it (Markus Mayer).

 - Support for ARM Integrator/AP and Integrator/CP in the generic
   DT cpufreq driver and elimination of the old Integrator cpufreq
   driver (Linus Walleij).

 - Support for the zx296718, r8a7743 and r8a7745, Socionext UniPhier,
   and PXA SoCs in the the generic DT cpufreq driver (Baoyou Xie,
   Geert Uytterhoeven, Masahiro Yamada, Robert Jarzmik).

 - cpufreq core fix to eliminate races that may lead to using
   inactive policy objects and related cleanups (Rafael Wysocki).

 - cpufreq schedutil governor update to make it use SCHED_FIFO
   kernel threads (instead of regular workqueues) for doing delayed
   work (to reduce the response latency in some cases) and related
   cleanups (Viresh Kumar).

 - New cpufreq sysfs attribute for resetting statistics (Markus
   Mayer).

 - cpufreq governors fixes and cleanups (Chen Yu, Stratos Karafotis,
   Viresh Kumar).

 - Support for using generic cpufreq governors in the intel_pstate
   driver (Rafael Wysocki).

 - Support for per-logical-CPU P-state limits and the EPP/EPB
   (Energy Performance Preference/Energy Performance Bias) knobs
   in the intel_pstate driver (Srinivas Pandruvada).

 - New CPU ID for Knights Mill in intel_pstate (Piotr Luc).

 - intel_pstate driver modification to use the P-state selection
   algorithm based on CPU load on platforms with the system profile
   in the ACPI tables set to "mobile" (Srinivas Pandruvada).

 - intel_pstate driver cleanups (Arnd Bergmann, Rafael Wysocki,
   Srinivas Pandruvada).

 - cpufreq powernv driver updates including fast switching support
   (for the schedutil governor), fixes and cleanus (Akshay Adiga,
   Andrew Donnellan, Denis Kirjanov).

 - acpi-cpufreq driver rework to switch it over to the new CPU
   offline/online state machine (Sebastian Andrzej Siewior).

 - Assorted cleanups in cpufreq drivers (Wei Yongjun, Prashanth
   Prakash).

 - Idle injection rework (to make it use the regular idle path
   instead of a home-grown custom one) and related powerclamp
   thermal driver updates (Peter Zijlstra, Jacob Pan, Petr Mladek,
   Sebastian Andrzej Siewior).

 - New CPU IDs for Atom Z34xx and Knights Mill in intel_idle (Andy
   Shevchenko, Piotr Luc).

 - intel_idle driver cleanups and switch over to using the new CPU
   offline/online state machine (Anna-Maria Gleixner, Sebastian
   Andrzej Siewior).

 - cpuidle DT driver update to support suspend-to-idle properly
   (Sudeep Holla).

 - cpuidle core cleanups and misc updates (Daniel Lezcano, Pan Bian,
   Rafael Wysocki).

 - Preliminary support for power domains including CPUs in the
   generic power domains (genpd) framework and related DT bindings
   (Lina Iyer).

 - Assorted fixes and cleanups in the generic power domains (genpd)
   framework (Colin Ian King, Dan Carpenter, Geert Uytterhoeven).

 - Preliminary support for devices with multiple voltage regulators
   and related fixes and cleanups in the Operating Performance Points
   (OPP) library (Viresh Kumar, Masahiro Yamada, Stephen Boyd).

 - System sleep state selection interface rework to make it easier
   to support suspend-to-idle as the default system suspend method
   (Rafael Wysocki).

 - PM core fixes and cleanups, mostly related to the interactions
   between the system suspend and runtime PM frameworks (Ulf Hansson,
   Sahitya Tummala, Tony Lindgren).

 - Latency tolerance PM QoS framework imorovements (Andrew
   Lutomirski).

 - New Knights Mill CPU ID for the Intel RAPL power capping driver
   (Piotr Luc).

 - Intel RAPL power capping driver fixes, cleanups and switch over
   to using the new CPU offline/online state machine (Jacob Pan,
   Thomas Gleixner, Sebastian Andrzej Siewior).

 - Fixes and cleanups in the exynos-ppmu, exynos-nocp, rk3399_dmc,
   rockchip-dfi devfreq drivers and the devfreq core (Axel Lin,
   Chanwoo Choi, Javier Martinez Canillas, MyungJoo Ham, Viresh
   Kumar).

 - Fix for false-positive KASAN warnings during resume from ACPI S3
   (suspend-to-RAM) on x86 (Josh Poimboeuf).

 - Memory map verification during resume from hibernation on x86 to
   ensure a consistent address space layout (Chen Yu).

 - Wakeup sources debugging enhancement (Xing Wei).

 - rockchip-io AVS driver cleanup (Shawn Lin).

Thanks!

---------------

Akshay Adiga (3):
      cpufreq: powernv: Adding fast_switch for schedutil
      cpufreq: powernv: Use PMCR to verify global and local pstate
      cpufreq: powernv: Fix uninitialized lpstate_idx in
gpstates_timer_handler()

Andrew Donnellan (1):
      cpuidle/powernv: staticise powernv_idle_driver

Andrew Lutomirski (3):
      PM / QoS: Improve sysfs pm_qos_latency_tolerance validation
      PM / QoS: Fix writing 'auto' to pm_qos_latency_tolerance_us
      PM / QoS: Export dev_pm_qos_update_user_latency_tolerance

Andy Shevchenko (1):
      x86/intel_idle: Add CPU model 0x4a (Atom Z34xx series)

Anna-Maria Gleixner (1):
      intel_idle: Remove superfluous SMP fuction call

Arnd Bergmann (1):
      cpufreq: intel_pstate: fix intel_pstate_exit_perf_limits() prototype

Axel Lin (2):
      PM / devfreq: exynos-ppmu: ppmu_events array should not be NULL terminated
      PM / devfreq: exynos-ppmu: Remove unused mutex from struct exynos_ppmu

Baoyou Xie (1):
      cpufreq: dt: Add support for zx296718

Chanwoo Choi (1):
      PM / devfreq: rk3399_dmc: Use the resource-managed function to
add devfreq dev

Chen Yu (2):
      PM / hibernate: Verify the consistent of e820 memory map by md5 digest
      cpufreq: ondemand: Set MIN_FREQUENCY_UP_THRESHOLD to 1

Colin Ian King (1):
      PM / Domains: check for negative return from of_count_phandle_with_args()

Dan Carpenter (1):
      PM / Domains: Fix a warning message

Daniel Lezcano (1):
      cpuidle: governors: Remove remaining old module code

Denis Kirjanov (1):
      cpufreq: powernv: Disable preemption while checking CPU throttling state

Geert Uytterhoeven (2):
      cpufreq: dt: Add support for r8a7743 and r8a7745
      PM / Domains: Do not print PM domain add error message if EPROBE_DEFER

Jacob Pan (3):
      powercap/intel_rapl: fix and tidy up error handling
      cpuidle: Allow enforcing deepest idle state selection
      thermal/intel_powerclamp: stop sched tick in forced idle

Javier Martinez Canillas (4):
      PM / devfreq: rk3399_dmc: Fix module autoload
      PM / devfreq: exynos-nocp: Fix module autoload
      PM / devfreq: rockchip-dfi: Fix module autoload
      PM / devfreq: exynos-ppmu: Fix module autoload

Josh Poimboeuf (1):
      x86/suspend: fix false positive KASAN warning on suspend/resume

Lina Iyer (9):
      PM / Domains: Make genpd state allocation dynamic
      PM / Domains: Add residency property to genpd states
      PM / Domains: Allow domain power states to be read from DT
      PM / Domains: Save the fwnode in genpd_power_state
      dt/bindings / PM/Domains: Update binding for PM domain idle states
      PM / Domains: Abstract genpd locking
      PM / Domains: Support IRQ safe PM domains
      PM / doc: Update device documentation for devices in IRQ-safe PM domains
      PM / Domains: Fix compatible for domain idle state

Linus Walleij (2):
      cpufreq: enable the DT cpufreq driver on the Integrators
      cpufreq: retire the Integrator cpufreq driver

Markus Mayer (4):
      dt: cpufreq: brcm: New binding document for brcmstb-avs-cpufreq
      cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs
      cpufreq: brcmstb-avs-cpufreq: add debugfs support
      cpufreq: stats: New sysfs attribute for clearing statistics

Masahiro Yamada (3):
      PM / OPP: make _of_get_opp_desc_node() a static function
      PM / OPP: fix debug/error messages in dev_pm_opp_of_get_sharing_cpus()
      cpufreq: dt: add Socionext UniPhier SoCs support

MyungJoo Ham (1):
      PM / devfreq: correct comment typo.

Pan Bian (1):
      cpuidle: fix improper return value on error

Peter Zijlstra (1):
      sched/idle: Add support for tasks that inject idle

Petr Mladek (2):
      thermal/intel_powerclamp: Remove duplicated code that starts the kthread
      thermal/intel_powerclamp: Convert the kthread to kthread worker API

Piotr Luc (3):
      powercap / RAPL: Add Knights Mill CPUID
      x86/intel_idle: Add Knights Mill CPUID
      cpufreq: intel_pstate: Add Knights Mill CPUID

Prakash, Prashanth (1):
      cpufreq / CPPC: Add MODULE_DEVICE_TABLE for cppc_cpufreq driver

Rafael J. Wysocki (12):
      cpufreq: intel_pstate: Drop boost_iowait flag
      cpufreq: intel_pstate: Request P-states control from SMM if needed
      cpufreq: intel_pstate: Generic governors support
      cpufreq: Avoid using inactive policies
      ACPI / processor: Make acpi_processor_ppc_has_changed() void
      cpufreq: Make cpufreq_update_policy() void
      PM / sleep: System sleep state selection interface rework
      PM / sleep / ACPI: Use the ACPI_FADT_LOW_POWER_S0 flag
      MAINTAINERS: Add bug tracking system location entries for cpuidle
      MAINTAINERS: Add Jacob Pan as a new intel_idle maintainer
      MAINTAINERS: Add bug tracking system location entry for cpufreq
      cpuidle: Add a kerneldoc comment to cpuidle_use_deepest_state()

Robert Jarzmik (1):
      cpufreq: pxa: use generic platdev driver for device-tree

Sahitya Tummala (1):
      PM / core: Fix bug in the error handling of async suspend

Sebastian Andrzej Siewior (5):
      powercap/intel rapl: Convert to hotplug state machine
      cpufreq: acpi-cpufreq: Convert to hotplug state machine
      cpufreq: acpi-cpufreq: drop rdmsr_on_cpus() usage
      thermal/intel_powerclamp: Convert to CPU hotplug state
      intel_idle: Convert to hotplug state machine

Shawn Lin (1):
      PM / AVS: rockchip-io: make the log more consistent

Srinivas Pandruvada (14):
      cpufreq: intel_pstate: Remove PID debugfs when not used
      Documentation: intel_pstate: PID tuning is not always available
      cpufreq: intel_pstate: Per CPU P-State limits
      cpufreq: intel_pstate: Reduce impact due to rounding error
      Documentation: intel_pstate: Update per core limits
      Documentation: kernel parameters: per core P-State control
      cpufreq: intel_pstate: protect limits variable
      cpufreq: intel_pstate: Use CPU load based algorithm for PM_MOBILE
      cpufreq: intel_pstate: round up min_perf limits
      cpufreq: intel_pstate: increase precision of performance limits
      cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
      cpufreq: intel_pstate: Add locking around HWP requests
      cpufreq: intel_pstate: Support for energy performance hints with HWP
      Documentation: intel_pstate: Document HWP energy/performance hints

Stephen Boyd (1):
      PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()

Stratos Karafotis (2):
      cpufreq: conservative: Decrease frequency faster for deferred updates
      cpufreq: conservative: Fix comment explaining frequency updates

Sudeep Holla (1):
      cpuidle: dt: assign ->enter_freeze to same as ->enter callback function

Thomas Gleixner (4):
      powercap/intel_rapl: Add missing domain data update on hotplug
      powercap/intel_rapl: Propagate error code when registration fails
      powercap/intel_rapl: Cleanup duplicated init code
      powercap/intel_rapl: Track active CPUs internally

Tony Lindgren (1):
      PM / wakeirq: Fix dedicated wakeirq for drivers not using autosuspend

Ulf Hansson (6):
      PM / Runtime: Remove the exported function pm_children_suspended()
      PM / Runtime: Clarify comment in rpm_resume() when resuming the parent
      PM / Runtime: Convert pm_runtime_set_suspended() to return an int
      net: smsc911x: Synchronize the runtime PM status during system suspend
      PM / Runtime: Don't allow to suspend a device with an active child
      PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()

Viresh Kumar (19):
      cpufreq: governor: Don't use 'timer' keyword
      cpufreq: conservative: Rename get_freq_target() to get_freq_step()
      cpufreq: schedutil: Avoid indented labels
      cpufreq: schedutil: enable fast switch earlier
      cpufreq: schedutil: move slow path from workqueue to SCHED_FIFO task
      cpufreq: schedutil: irq-work and mutex are only used in slow path
      cpufreq: schedutil: Rectify comment in sugov_irq_work() function
      PM / OPP: Fix incorrect cpu-supply property in binding
      PM / OPP: Reword binding supporting multiple regulators per device
      PM / OPP: Don't use OPP structure outside of rcu protected section
      PM / OPP: Manage supply's voltage/current in a separate structure
      PM / OPP: Pass struct dev_pm_opp_supply to _set_opp_voltage()
      PM / OPP: Add infrastructure to manage multiple regulators
      PM / OPP: Separate out _generic_set_opp()
      PM / OPP: Allow platform specific custom set_opp() callbacks
      PM / OPP: Don't WARN on multiple calls to dev_pm_opp_set_regulators()
      devfreq: exynos: Don't use OPP structures outside of RCU locks
      devfreq: rk3399_dmc: Remove dangling rcu_read_unlock()
      devfreq: rk3399_dmc: Don't use OPP structures outside of RCU locks

Wei Yongjun (1):
      cpufreq: brcmstb-avs-cpufreq: make symbol brcm_avs_cpufreq_attr static

xing wei (1):
      PM / sleep: Print active wakeup sources when blocking on
wakeup_count reads

---------------

 Documentation/ABI/testing/sysfs-power              |   45 +-
 Documentation/cpu-freq/cpufreq-stats.txt           |    6 +
 Documentation/cpu-freq/intel-pstate.txt            |   54 +-
 .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     |   78 ++
 Documentation/devicetree/bindings/opp/opp.txt      |   27 +-
 .../bindings/power/domain-idle-state.txt           |   33 +
 .../devicetree/bindings/power/power_domain.txt     |   43 +
 Documentation/kernel-parameters.txt                |   22 +-
 Documentation/power/devices.txt                    |   14 +-
 Documentation/power/states.txt                     |   62 +-
 MAINTAINERS                                        |   12 +
 arch/arm/mach-imx/gpc.c                            |   17 +-
 arch/x86/kernel/acpi/wakeup_64.S                   |    9 +
 arch/x86/power/hibernate_64.c                      |   94 +-
 drivers/acpi/processor_perflib.c                   |   55 +-
 drivers/acpi/sleep.c                               |    8 +
 drivers/base/power/domain.c                        |  363 +++++--
 drivers/base/power/main.c                          |    2 +-
 drivers/base/power/opp/core.c                      |  521 +++++++---
 drivers/base/power/opp/debugfs.c                   |   52 +-
 drivers/base/power/opp/of.c                        |  111 +-
 drivers/base/power/opp/opp.h                       |   23 +-
 drivers/base/power/power.h                         |   19 +-
 drivers/base/power/qos.c                           |    6 +-
 drivers/base/power/runtime.c                       |   62 +-
 drivers/base/power/sysfs.c                         |    6 +-
 drivers/base/power/wakeirq.c                       |   76 +-
 drivers/base/power/wakeup.c                        |    6 +-
 drivers/cpufreq/Kconfig.arm                        |   29 +-
 drivers/cpufreq/Makefile                           |    2 +-
 drivers/cpufreq/acpi-cpufreq.c                     |  117 +--
 drivers/cpufreq/brcmstb-avs-cpufreq.c              | 1057 ++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c                     |    7 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   15 +
 drivers/cpufreq/cpufreq-dt.c                       |   12 +-
 drivers/cpufreq/cpufreq.c                          |   25 +-
 drivers/cpufreq/cpufreq_conservative.c             |   46 +-
 drivers/cpufreq/cpufreq_governor.c                 |   30 +-
 drivers/cpufreq/cpufreq_governor.h                 |    5 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |   17 +-
 drivers/cpufreq/cpufreq_stats.c                    |   22 +
 drivers/cpufreq/integrator-cpufreq.c               |  239 -----
 drivers/cpufreq/intel_pstate.c                     |  826 ++++++++++++---
 drivers/cpufreq/powernv-cpufreq.c                  |   65 +-
 drivers/cpuidle/cpuidle-powernv.c                  |    2 +-
 drivers/cpuidle/cpuidle.c                          |   19 +-
 drivers/cpuidle/dt_idle_states.c                   |    6 +
 drivers/cpuidle/governor.c                         |    4 -
 drivers/cpuidle/governors/ladder.c                 |    2 -
 drivers/cpuidle/governors/menu.c                   |    2 -
 drivers/cpuidle/sysfs.c                            |    4 +-
 drivers/devfreq/devfreq.c                          |    2 +-
 drivers/devfreq/event/exynos-nocp.c                |    1 +
 drivers/devfreq/event/exynos-ppmu.c                |    6 +-
 drivers/devfreq/event/rockchip-dfi.c               |    1 +
 drivers/devfreq/exynos-bus.c                       |   29 +-
 drivers/devfreq/rk3399_dmc.c                       |   15 +-
 drivers/idle/intel_idle.c                          |  154 +--
 drivers/net/ethernet/smsc/smsc911x.c               |    6 +
 drivers/power/avs/rockchip-io-domain.c             |    2 +-
 drivers/powercap/intel_rapl.c                      |  389 +++----
 drivers/thermal/intel_powerclamp.c                 |  359 +++----
 include/acpi/processor.h                           |    3 +-
 include/linux/cpu.h                                |    2 +
 include/linux/cpufreq.h                            |    6 +-
 include/linux/cpuidle.h                            |    9 +-
 include/linux/pm_domain.h                          |   28 +-
 include/linux/pm_opp.h                             |   72 +-
 include/linux/pm_runtime.h                         |   11 +-
 include/linux/sched.h                              |    3 +-
 include/linux/suspend.h                            |    2 +
 kernel/fork.c                                      |    2 +-
 kernel/power/main.c                                |   88 +-
 kernel/power/power.h                               |    6 +-
 kernel/power/suspend.c                             |   69 +-
 kernel/sched/core.c                                |    1 +
 kernel/sched/cpufreq_schedutil.c                   |  119 ++-
 kernel/sched/idle.c                                |  175 ++--
 mm/kasan/kasan.c                                   |    9 +-
 79 files changed, 4399 insertions(+), 1549 deletions(-)
