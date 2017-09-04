From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.14-rc1
Date: Mon, 4 Sep 2017 23:37:22 +0200
Message-ID: <CAJZ5v0g8WNcxr65Ts3Ld9kg7uxaWhREH6x1ER2-v=53fb1q52g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.14-rc1

with top-most commit d97561f461e4cb5b2e170bc33b466cffbddc8719

 Merge branch 'pm-tools'

on top of commit 569dbb88e80deb68974ef6fdd6a13edb9d686261

 Linux 4.13

to receive power management updates for v4.14-rc1.

This time (again) cpufreq gets the majority of changes which mostly
are driver updates (including a major consolidation of intel_pstate),
some schedutil governor modifications and core cleanups.

There also are some changes in the system suspend area, mostly
related to diagnostics and debug messages plus some renames of
things related to suspend-to-idle.  One major change here is
that suspend-to-idle is now going to be preferred over S3 on
systems where the ACPI tables indicate to do so and provide
requsite support (the Low Power Idle S0 _DSM in particular).
The system sleep documentation and the tools related to it are
updated too.

The rest is a few cpuidle changes (nothing major), devfreq updates,
generic power domains (genpd) framework updates and a few assorted
modifications elsewhere.

Specifics:

 - Drop the P-state selection algorithm based on a PID controller
   from intel_pstate and make it use the same P-state selection
   method (based on the CPU load) for all types of systems in the
   active mode (Rafael Wysocki, Srinivas Pandruvada).

 - Rework the cpufreq core and governors to make it possible to
   take cross-CPU utilization updates into account and modify the
   schedutil governor to actually do so (Viresh Kumar).

 - Clean up the handling of transition latency information in the
   cpufreq core and untangle it from the information on which drivers
   cannot do dynamic frequency switching (Viresh Kumar).

 - Add support for new SoCs (MT2701/MT7623 and MT7622) to the
   mediatek cpufreq driver and update its DT bindings (Sean Wang).

 - Modify the cpufreq dt-platdev driver to autimatically create
   cpufreq devices for the new (v2) Operating Performance Points
   (OPP) DT bindings and update its whitelist of supported systems
   (Viresh Kumar, Shubhrajyoti Datta, Marc Gonzalez, Khiem Nguyen,
   Finley Xiao).

 - Add support for Ux500 to the cpufreq-dt driver and drop the
   obsolete dbx500 cpufreq driver (Linus Walleij, Arnd Bergmann).

 - Add new SoC (R8A7795) support to the cpufreq rcar driver (Khiem
   Nguyen).

 - Fix and clean up assorted issues in the cpufreq drivers and core
   (Arvind Yadav, Christophe Jaillet, Colin Ian King, Gustavo Silva,
   Julia Lawall, Leonard Crestez, Rob Herring, Sudeep Holla).

 - Update the IO-wait boost handling in the schedutil governor to
   make it less aggressive (Joel Fernandes).

 - Rework system suspend diagnostics to make it print fewer messages
   to the kernel log by default, add a sysfs knob to allow more
   suspend-related messages to be printed and add Low Power S0 Idle
   constraints checks to the ACPI suspend-to-idle code (Rafael
   Wysocki, Srinivas Pandruvada).

 - Prefer suspend-to-idle over S3 on ACPI-based systems with the
   ACPI_FADT_LOW_POWER_S0 flag set and the Low Power Idle S0 _DSM
   interface present in the ACPI tables (Rafael Wysocki).

 - Update documentation related to system sleep and rename a number
   of items in the code to make it cleare that they are related to
   suspend-to-idle (Rafael Wysocki).

 - Export a variable allowing device drivers to check the target
   system sleep state from the core system suspend code (Florian
   Fainelli).

 - Clean up the cpuidle subsystem to handle the polling state on
   x86 in a more straightforward way and to use %pOF instead of
   full_name (Rafael Wysocki, Rob Herring).

 - Update the devfreq framework to fix and clean up a few minor
   issues (Chanwoo Choi, Rob Herring).

 - Extend diagnostics in the generic power domains (genpd) framework
   and clean it up slightly (Thara Gopinath, Rob Herring).

 - Fix and clean up a couple of issues in the operating performance
   points (OPP) framework (Viresh Kumar, Waldemar Rymarkiewicz).

 - Add support for RV1108 to the rockchip-io Adaptive Voltage Scaling
   (AVS) driver (David Wu).

 - Fix the usage of notifiers in CPU power management on some
   platforms (Alex Shi).

 - Update the pm-graph system suspend/hibernation and boot profiling
   utility (Todd Brandt).

 - Make it possible to run the cpupower utility without CPU0 (Prarit
   Bhargava).

There was a merge conflict of the cpufreq material with the tip tree
in linux-next and the Stephen's resolution of it is appended.

Thanks!


---------------

Alex Shi (1):
      PM / CPU: replace raw_notifier with atomic_notifier

Arnd Bergmann (1):
      ARM: ux500: don't select CPUFREQ_DT

Arvind Yadav (1):
      cpufreq: Loongson2: constify platform_device_id

Chanwoo Choi (3):
      PM / devfreq: Move private devfreq_update_stats() into devfreq
      PM / devfreq: Add dependency on PM_OPP
      PM / devfreq: Fix memory leak when fail to register device

Christophe Jaillet (1):
      cpufreq: ti: Fix 'of_node_put' being called twice in error handling path

Colin Ian King (1):
      cpufreq: speedstep-lib: make several arrays static, makes code smaller

David Wu (1):
      PM / AVS: rockchip-io: add io selectors and supplies for RV1108

Finley Xiao (1):
      cpufreq: dt: Add rk3328 compatible to use generic cpufreq driver

Florian Fainelli (1):
      PM / suspend: Export pm_suspend_target_state

Gustavo A. R. Silva (1):
      cpufreq: speedstep: remove unnecessary static in
speedstep_detect_chipset()

Joel Fernandes (2):
      cpufreq: schedutil: Make iowait boost more energy efficient
      cpufreq: schedutil: Use unsigned int for iowait boost

Julia Lawall (1):
      cpufreq: s5pv210: add missing of_node_put()

Khiem Nguyen (2):
      cpufreq: rcar: Add support for R8A7795 SoC
      cpufreq: dt: Add r8a7796 support to to use generic cpufreq driver

Leonard Crestez (1):
      cpufreq: imx6q: Fix imx6sx low frequency support

Linus Walleij (3):
      cpufreq: enable the DT cpufreq driver on the Ux500
      mfd: db8500-prcmu: Get rid of cpufreq dependency
      cpufreq: dbx500: Delete obsolete driver

Marc Gonzalez (1):
      cpufreq: dt: Don't use generic platdev driver for tango

Prarit Bhargava (1):
      tools/power/cpupower: allow running without cpu0

Rafael J. Wysocki (28):
      PM / sleep: Do not print debug messages by default
      PM / sleep: Mark suspend/hibernation start and finish
      PM / timekeeping: Print debug messages when requested
      PM / s2idle: Rearrange the main suspend-to-idle loop
      PM / core: Split dpm_suspend_noirq() and dpm_resume_noirq()
      PM / core: Add error argument to dpm_show_time()
      PM / sleep: Check pm_wakeup_pending() in __device_suspend_noirq()
      PM / sleep: Put pm_test under CONFIG_PM_SLEEP_DEBUG
      PM / suspend: Use mem_sleep_labels[] strings in messages
      PM / suspend: Define pr_fmt() in suspend.c
      cpufreq: intel_pstate: Do not use PID-based P-state selection
      cpufreq: intel_pstate: Drop ->update_util from pstate_funcs
      cpufreq: intel_pstate: Drop INTEL_PSTATE_HWP_SAMPLING_INTERVAL
      platform/x86: intel-hid: Wake up Dell Latitude 7275 from suspend-to-idle
      ACPI / PM: Prefer suspend-to-idle over S3 on some systems
      cpufreq: Simplify cpufreq_can_do_remote_dvfs()
      PM / wakeup: Set power.can_wakeup if wakeup_sysfs_add() fails
      cpufreq: intel_pstate: Simplify intel_pstate_adjust_pstate()
      cpufreq: intel_pstate: Shorten a couple of long names
      PM / s2idle: Rename PM_SUSPEND_FREEZE to PM_SUSPEND_TO_IDLE
      PM / s2idle: Rename freeze_state enum and related items
      PM / s2idle: Rename ->enter_freeze to ->enter_s2idle
      PM / s2idle: Rename platform operations structure
      PM: docs: Describe high-level PM strategies and sleep states
      PM: docs: Delete the obsolete states.txt document
      cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol
      cpuidle: Move polling state initialization code to separate file
      cpuidle: Make drivers initialize polling state

Rob Herring (4):
      PM / Domains: Convert to using %pOF instead of full_name
      cpufreq: Convert to using %pOF instead of full_name
      cpuidle: Convert to using %pOF instead of full_name
      PM / devfreq: Convert to using %pOF instead of full_name

Sean Wang (5):
      cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC
      dt-bindings: cpufreq: move MediaTek cpufreq dt-bindings document
to proper place
      dt-bindings: cpufreq: enhance MediaTek cpufreq dt-binding document
      cpufreq: mediatek: add cleanups with the more generic naming
      cpufreq: mediatek: add support of cpufreq to MT7622 SoC

Shubhrajyoti Datta (1):
      cpufreq: dt: Add zynqmp to the cpufreq dt platdev

Srinivas Pandruvada (2):
      cpufreq: intel_pstate: Improve IO performance with per-core P-states
      ACPI / PM: Check low power idle constraints for debug only

Sudeep Holla (1):
      cpufreq: remove setting of policy->cpu in policy->cpus during init

Thara Gopinath (2):
      PM / Domains: Add time accounting to various genpd states
      PM / Domains: Extend generic power domain debugfs

Todd E Brandt (3):
      pm-graph: AnalyzeSuspend v4.7
      pm-graph: AnalyzeBoot v2.1
      pm-graph: package makefile and man pages

Viresh Kumar (17):
      PM / OPP: OF: Use pr_debug() instead of pr_err() while adding OPP table
      cpufreq: governor: Drop min_sampling_rate
      cpufreq: Use transition_delay_us for legacy governors as well
      cpufreq: Don't set transition_latency for setpolicy drivers
      cpufreq: arm_big_little: Make ->get_transition_latency() mandatory
      cpufreq: Replace "max_transition_latency" with "dynamic_switching"
      cpufreq: schedutil: Set dynamic_switching to true
      cpufreq: Add CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING cpufreq driver flag
      cpufreq: Allow dynamic switching with CPUFREQ_ETERNAL latency
      sched: cpufreq: Allow remote cpufreq callbacks
      cpufreq: Process remote callbacks from any CPU if the platform permits
      cpufreq: Return 0 from ->fast_switch() on errors
      cpufreq: schedutil: Don't restrict kthread to related_cpus unnecessarily
      cpufreq: schedutil: Always process remote callback with slow switching
      cpufreq: Cap the default transition delay value to 10 ms
      cpufreq: dt-platdev: Automatically create cpufreq device with OPP v2
      cpufreq: dt-platdev: Drop few entries from whitelist

Waldemar Rymarkiewicz (1):
      PM / OPP: Fix get sharing CPUs when hotplug is used

---------------

 Documentation/ABI/testing/sysfs-power              |  12 +
 Documentation/admin-guide/pm/cpufreq.rst           |   8 -
 Documentation/admin-guide/pm/index.rst             |  12 +-
 Documentation/admin-guide/pm/intel_pstate.rst      |  61 +--
 Documentation/admin-guide/pm/sleep-states.rst      | 245 +++++++++
 Documentation/admin-guide/pm/strategies.rst        |  52 ++
 Documentation/admin-guide/pm/system-wide.rst       |   8 +
 Documentation/admin-guide/pm/working-state.rst     |   9 +
 .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  |  83 ---
 .../bindings/cpufreq/cpufreq-mediatek.txt          | 247 +++++++++
 .../bindings/power/rockchip-io-domain.txt          |   2 +
 Documentation/power/states.txt                     | 125 -----
 arch/arm/boot/dts/tango4-smp8758.dtsi              |   1 -
 arch/arm/mach-tegra/cpuidle-tegra114.c             |   4 +-
 drivers/acpi/processor_idle.c                      |  23 +-
 drivers/acpi/sleep.c                               | 202 ++++++-
 drivers/base/power/domain.c                        | 251 ++++++++-
 drivers/base/power/main.c                          | 103 ++--
 drivers/base/power/opp/of.c                        |  37 +-
 drivers/base/power/wakeup.c                        |  10 +-
 drivers/cpufreq/Kconfig.arm                        |  21 +-
 drivers/cpufreq/Makefile                           |   4 +-
 drivers/cpufreq/arm_big_little.c                   |  10 +-
 drivers/cpufreq/cppc_cpufreq.c                     |   1 -
 drivers/cpufreq/cpufreq-dt-platdev.c               |  65 ++-
 drivers/cpufreq/cpufreq-dt.c                       |   1 +
 drivers/cpufreq/cpufreq-nforce2.c                  |   2 +-
 drivers/cpufreq/cpufreq.c                          |  41 +-
 drivers/cpufreq/cpufreq_conservative.c             |   6 -
 drivers/cpufreq/cpufreq_governor.c                 |  20 +-
 drivers/cpufreq/cpufreq_governor.h                 |   3 +-
 drivers/cpufreq/cpufreq_ondemand.c                 |  12 -
 drivers/cpufreq/dbx500-cpufreq.c                   | 103 ----
 drivers/cpufreq/elanfreq.c                         |   4 +-
 drivers/cpufreq/gx-suspmod.c                       |   2 +-
 drivers/cpufreq/imx6q-cpufreq.c                    |   9 +
 drivers/cpufreq/intel_pstate.c                     | 322 +----------
 drivers/cpufreq/longrun.c                          |   1 -
 drivers/cpufreq/loongson2_cpufreq.c                |   2 +-
 .../{mt8173-cpufreq.c => mediatek-cpufreq.c}       |  29 +-
 drivers/cpufreq/pmac32-cpufreq.c                   |   7 +-
 drivers/cpufreq/pmac64-cpufreq.c                   |   2 +-
 drivers/cpufreq/s5pv210-cpufreq.c                  |   3 +
 drivers/cpufreq/sa1100-cpufreq.c                   |   5 +-
 drivers/cpufreq/sa1110-cpufreq.c                   |   5 +-
 drivers/cpufreq/sh-cpufreq.c                       |   3 +-
 drivers/cpufreq/speedstep-ich.c                    |   2 +-
 drivers/cpufreq/speedstep-lib.c                    |   4 +-
 drivers/cpufreq/speedstep-smi.c                    |   2 +-
 drivers/cpufreq/sti-cpufreq.c                      |   8 +-
 drivers/cpufreq/tango-cpufreq.c                    |  38 ++
 drivers/cpufreq/ti-cpufreq.c                       |   4 +-
 drivers/cpufreq/unicore2-cpufreq.c                 |   3 +-
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle.c                          |  18 +-
 drivers/cpuidle/driver.c                           |  32 --
 drivers/cpuidle/dt_idle_states.c                   |  24 +-
 drivers/cpuidle/governors/ladder.c                 |  14 +-
 drivers/cpuidle/governors/menu.c                   |  13 +-
 drivers/cpuidle/poll_state.c                       |  37 ++
 drivers/devfreq/Kconfig                            |   1 +
 drivers/devfreq/devfreq-event.c                    |   4 +-
 drivers/devfreq/devfreq.c                          |   5 +-
 drivers/devfreq/governor.h                         |   4 +
 drivers/idle/intel_idle.c                          | 181 +++----
 drivers/mfd/db8500-prcmu.c                         |  62 +--
 drivers/platform/x86/intel-hid.c                   |  17 +-
 drivers/power/avs/rockchip-io-domain.c             |  38 ++
 drivers/regulator/of_regulator.c                   |   2 +-
 include/linux/cpufreq.h                            |  38 +-
 include/linux/cpuidle.h                            |  21 +-
 include/linux/devfreq.h                            |  13 -
 include/linux/pm.h                                 |   4 +
 include/linux/pm_domain.h                          |   3 +
 include/linux/suspend.h                            |  48 +-
 kernel/cpu_pm.c                                    |  50 +-
 kernel/power/hibernate.c                           |  29 +-
 kernel/power/main.c                                |  64 ++-
 kernel/power/power.h                               |   5 +-
 kernel/power/suspend.c                             | 184 ++++---
 kernel/power/suspend_test.c                        |   4 +-
 kernel/sched/cpufreq_schedutil.c                   |  98 +++-
 kernel/sched/deadline.c                            |   2 +-
 kernel/sched/fair.c                                |   8 +-
 kernel/sched/idle.c                                |   8 +-
 kernel/sched/rt.c                                  |   2 +-
 kernel/sched/sched.h                               |  10 +-
 kernel/time/timekeeping_debug.c                    |   5 +-
 tools/power/cpupower/utils/cpupower.c              |  15 +-
 tools/power/cpupower/utils/helpers/cpuid.c         |   4 +-
 tools/power/cpupower/utils/helpers/helpers.h       |   5 +-
 tools/power/cpupower/utils/helpers/misc.c          |   2 +-
 .../cpupower/utils/idle_monitor/hsw_ext_idle.c     |   4 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |   3 +-
 tools/power/cpupower/utils/idle_monitor/nhm_idle.c |   8 +-
 tools/power/cpupower/utils/idle_monitor/snb_idle.c |   4 +-
 tools/power/pm-graph/Makefile                      |  19 +-
 tools/power/pm-graph/analyze_boot.py               | 586 ++++++++++++++-------
 tools/power/pm-graph/analyze_suspend.py            | 534 +++++++++++++------
 tools/power/pm-graph/bootgraph.8                   |  61 ++-
 tools/power/pm-graph/sleepgraph.8                  |  48 +-
 101 files changed, 2835 insertions(+), 1746 deletions(-)


diff --cc kernel/sched/fair.c
index d378d02fdfcb,8d5868771cb3..000000000000
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@@ -2790,6 -2801,29 +2801,31 @@@ static inline void update_cfs_shares(st
  }
  #endif /* CONFIG_FAIR_GROUP_SCHED */

+ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq)
+ {
 -    if (&this_rq()->cfs == cfs_rq) {
++    struct rq *rq = rq_of(cfs_rq);
++
++    if (&rq->cfs == cfs_rq) {
+         /*
+          * There are a few boundary cases this might miss but it should
+          * get called often enough that that should (hopefully) not be
+          * a real problem -- added to that it only calls on the local
+          * CPU, so if we enqueue remotely we'll miss an update, but
+          * the next tick/schedule should update.
+          *
+          * It will not get called when we go idle, because the idle
+          * thread is a different class (!fair), nor will the utilization
+          * number include things like RT tasks.
+          *
+          * As is, the util number is not freq-invariant (we'd have to
+          * implement arch_scale_freq_capacity() for that).
+          *
+          * See cpu_util().
+          */
 -        cpufreq_update_util(rq_of(cfs_rq), 0);
++        cpufreq_update_util(rq, 0);
+     }
+ }
+
  #ifdef CONFIG_SMP
  /*
   * Approximate:
