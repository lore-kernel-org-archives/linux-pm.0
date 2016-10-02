From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management material for v4.9-rc1
Date: Mon, 3 Oct 2016 00:54:27 +0200
Message-ID: <CAJZ5v0hcVZSLR+ya-p=WqeYG1mXSz4H=xj9K4hDFRh-c5TOHtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34073 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbcJBWy3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Oct 2016 18:54:29 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

Hi Linus,

This goes early as I will be traveling for a good part of the next week.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.9-rc1

with top-most commit 993eb0aeae0ff895e234cf94d1a86170584194e9

 Merge branches 'pm-devfreq' and 'pm-sleep'

on top of commit 08895a8b6b06ed2323cd97a36ee40a116b3db8ed

 Linux 4.8-rc8

to receive power management updates for v4.9-rc1.

Traditionally, cpufreq is the area with the greatest number of changes, but
there are fewer of them than last time.  There also is some activity in the
generic power domains and the devfreq frameworks, a couple of system suspend
and hibernation fixes and some assorted changes in other places.

One new feature is the cpufreq change to allow the scheduler to pass hints to
the governors' utilization update callbacks and some code rework based on that.
Another one is the support for domain removal in the generic power domains
framework.  Also it is now possible to use hibernation with PAGE_POISONING_ZERO
enabled and devfreq supports the RockChip DFI controller and the rk3399 DMC.

The rest of the changes is mostly fixes and cleanups in a number of places.

Specifics:

 - Add a mechanism for passing hints from the scheduler to cpufreq governors
   via their utilization update callbacks and use it to introduce "IOwait
   boosting" into the schedutil governor and intel_pstate that will make them
   boost performance if the enqueued task was previously waiting on I/O
   (Rafael Wysocki).

 - Fix a schedutil governor problem that causes it to overestimate utilization
   if SMT is in use (Steve Muckle).

 - Update defconfigs trying to use the schedutil governor as a module which is
   not possible any more (Javier Martinez Canillas).

 - Update the intel_pstate's pstate_sample tracepoint to take "IOwait boosting"
   into account (Srinivas Pandruvada).

 - Fix a problem in the cpufreq core causing it to mishandle the initialization
   of CPUs registered after the cpufreq driver (Viresh Kumar, Rafael Wysocki).

 - Make the cpufreq-dt driver support per-policy governor tunables, clean it
   up and update its Kconfig description (Viresh Kumar).

 - Add support for more ARM platforms to the cpufreq-dt driver (Chanwoo Choi,
   Dave Gerlach, Geert Uytterhoeven).

 - Make the cpufreq CPPC driver report frequencies in KHz to avoid user space
   compatiblility issues (Al Stone, Hoan Tran).

 - Clean up a few cpufreq drivers (st, kirkwood, SCPI) a bit (Colin Ian King,
   Markus Elfring).

 - Constify some local structures in the intel_pstate driver (Julia Lawall).

 - Add a Documentation/cpu-freq/ entry to MAINTAINERS (Jean Delvare).

 - Add support for PM domain removal to the generic power domains (genpd)
   framework, add new DT helper functions to it and make it always enable
   debugfs support if available (Jon Hunter, Tomeu Vizoso).

 - Clean up the generic power domains (genpd) framework and make it avoid
   measuring power-on and power-off latencies during system-wide PM transitions
   (Ulf Hansson).

 - Add support for the RockChip DFI controller and the rk3399 DMC to the
   devfreq framework (Lin Huang, Axel Lin, Arnd Bergmann).

 - Add COMPILE_TEST to the devfreq framework (Krzysztof Kozlowski, Stephen
   Rothwell).

 - Fix a minor issue in the exynos-ppmu devfreq driver and fix up devfreq
   Kconfig indentation style (Wei Yongjun, Jisheng Zhang).

 - Fix the system suspend interface to make suspend-to-idle work if platform
   suspend operations have not been registered (Sudeep Holla).

 - Make it possible to use hibernation with PAGE_POISONING_ZERO enabled
   (Anisse Astier).

 - Increas the default timeout of the system suspend/resume watchdog and make it
   depend on EXPERT (Chen Yu).

 - Make the operating performance points (OPP) framework avoid using OPPs that
   aren't supported by the platform and fix a build warning in it (Dave Gerlach,
   Arnd Bergmann).

 - Fix the ARM cpuidle driver's return value (Christophe Jaillet).

 - Make the SmartReflex AVS (Adaptive Voltage Scaling) driver use more common
   logging style (Joe Perches).

There is a small merge conflict between the cpufreq material here and the tip
tree.  Appended is a patch used by Stephen to resolve it in linux-next.

Thanks!

---------------

Al Stone (1):
      cpufreq: CPPC: Force reporting values in KHz to fix user space interface

Anisse Astier (1):
      PM / Hibernate: allow hibernation with PAGE_POISONING_ZERO

Arnd Bergmann (2):
      PM / OPP: avoid maybe-uninitialized warning
      PM / devfreq: rockchip: add PM_DEVFREQ_EVENT dependency

Axel Lin (1):
      PM / devfreq: rk3399_dmc: Remove explictly regulator_put call in .remove

Chanwoo Choi (1):
      cpufreq: dt: Add exynos5433 compatible to use generic cpufreq driver

Chen Yu (1):
      PM / sleep: Increase default DPM watchdog timeout to 120

Christophe Jaillet (1):
      ARM: cpuidle: Fix error return code

Colin Ian King (2):
      cpufreq: kirkwood: add missing \n to end of dev_err messages
      cpufreq: st: add missing \n to end of dev_err message

Dave Gerlach (2):
      cpufreq: ti: Use generic platdev driver
      PM / OPP: Don't support OPP if it provides supported-hw but
platform does not

Geert Uytterhoeven (1):
      cpufreq: dt: Add support for r8a7792

Hoan Tran (1):
      cpufreq: CPPC: Avoid overflow when calculating desired_perf

Javier Martinez Canillas (2):
      ARM: exynos_defconfig: Don't attempt to enable schedutil
governor as module
      ARM: multi_v7_defconfig: Don't attempt to enable schedutil
governor as module

Jean Delvare (1):
      MAINTAINERS: Add Documentation/cpu-freq/

Jisheng Zhang (1):
      PM / devfreq: fix Kconfig indent style

Joe Perches (1):
      PM / AVS: SmartReflex: Neaten logging

Jon Hunter (11):
      PM / Domains: Always enable debugfs support if available
      PM / Domains: Add new helper functions for device-tree
      ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
      staging: board: Remove calls to of_genpd_get_from_provider()
      PM / Domains: Don't expose generic_pm_domain structure to clients
      PM / Domains: Don't expose xlate and provider helper functions
      PM / Domains: Verify the PM domain is present when adding a provider
      PM / Domains: Prepare for adding support to remove PM domains
      PM / Domains: Store the provider in the PM domain structure
      PM / Domains: Add support for removing PM domains
      PM / Domains: Add support for removing nested PM domains by provider

Julia Lawall (1):
      intel_pstate: constify local structures

Krzysztof Kozlowski (1):
      PM / devfreq: Add COMPILE_TEST for build coverage

Lin Huang (5):
      PM / devfreq: event: remove duplicate devfreq_event_get_drvdata()
      Documentation: bindings: add dt documentation for dfi controller
      PM / devfreq: event: support rockchip dfi controller
      Documentation: bindings: add dt documentation for rk3399 dmc
      PM / devfreq: rockchip: add devfreq driver for rk3399 dmc

Markus Elfring (1):
      cpufreq-SCPI: Delete unnecessary assignment for the field "owner"

Rafael J. Wysocki (6):
      cpufreq / sched: Pass flags to cpufreq_update_util()
      cpufreq / sched: Pass runqueue pointer to cpufreq_update_util()
      cpufreq: Drop unnecessary check from cpufreq_policy_alloc()
      cpufreq / sched: SCHED_CPUFREQ_IOWAIT flag to indicate iowait condition
      cpufreq: schedutil: Add iowait boosting
      cpufreq: intel_pstate: Use IOWAIT flag in Atom algorithm

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Add io_boost trace

Stephen Rothwell (1):
      partial revert of "PM / devfreq: Add COMPILE_TEST for build coverage"

Steve Muckle (1):
      cpufreq / sched: ignore SMT when determining max cpu capacity

Sudeep Holla (1):
      PM / sleep: enable suspend-to-idle even without registered suspend_ops

Tomeu Vizoso (1):
      PM / Domains: Allow holes in genpd_data.domains array

Ulf Hansson (4):
      PM / Domains: Simplify detaching a device from its genpd
      PM / Domains: Remove redundant system PM callbacks
      PM / Domains: Don't measure latency of ->power_on|off() during system PM
      PM / Domains: Rename pm_genpd_sync_poweron|poweroff()

Viresh Kumar (4):
      cpufreq: dt: Remove unused code
      cpufreq: dt: Update kconfig description
      cpufreq: dt: Support governor tunables per policy
      cpufreq: create link to policy only for registered CPUs

Wei Yongjun (1):
      PM / devfreq: exynos-ppmu: remove unneeded of_node_put()

---------------

 .../bindings/devfreq/event/rockchip-dfi.txt        |  19 +
 .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 209 +++++++++
 MAINTAINERS                                        |   1 +
 arch/arm/configs/exynos_defconfig                  |   2 +-
 arch/arm/configs/multi_v7_defconfig                |   2 +-
 drivers/base/power/domain.c                        | 430 +++++++++++++++----
 drivers/base/power/opp/core.c                      |  10 +-
 drivers/base/power/opp/of.c                        |  14 +-
 drivers/cpufreq/Kconfig                            |   7 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  53 ++-
 drivers/cpufreq/cpufreq-dt-platdev.c               |  11 +-
 drivers/cpufreq/cpufreq-dt.c                       |   6 +-
 drivers/cpufreq/cpufreq-dt.h                       |  19 +
 drivers/cpufreq/cpufreq.c                          |  93 ++--
 drivers/cpufreq/cpufreq_governor.c                 |   2 +-
 drivers/cpufreq/intel_pstate.c                     |  71 ++--
 drivers/cpufreq/kirkwood-cpufreq.c                 |   8 +-
 drivers/cpufreq/scpi-cpufreq.c                     |   1 -
 drivers/cpufreq/sti-cpufreq.c                      |   2 +-
 drivers/cpuidle/cpuidle-arm.c                      |   1 +
 drivers/devfreq/Kconfig                            |  30 +-
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/event/Kconfig                      |  11 +-
 drivers/devfreq/event/Makefile                     |   1 +
 drivers/devfreq/event/exynos-ppmu.c                |   2 -
 drivers/devfreq/event/rockchip-dfi.c               | 256 +++++++++++
 drivers/devfreq/rk3399_dmc.c                       | 470 +++++++++++++++++++++
 drivers/power/avs/smartreflex.c                    | 115 +++--
 drivers/soc/samsung/pm_domains.c                   |  23 +-
 drivers/staging/board/board.c                      |   9 +-
 include/linux/devfreq-event.h                      |   5 -
 include/linux/pm_domain.h                          |  74 ++--
 include/linux/sched.h                              |  13 +-
 include/linux/suspend.h                            |   2 +
 include/trace/events/power.h                       |  13 +-
 kernel/power/Kconfig                               |   4 +-
 kernel/power/hibernate.c                           |  21 +-
 kernel/power/main.c                                |   1 +
 kernel/power/power.h                               |   2 +
 kernel/power/snapshot.c                            |  22 +
 kernel/power/suspend.c                             |  14 +-
 kernel/sched/cpufreq.c                             |   2 +-
 kernel/sched/cpufreq_schedutil.c                   | 122 ++++--
 kernel/sched/deadline.c                            |   5 +-
 kernel/sched/fair.c                                |  23 +-
 kernel/sched/rt.c                                  |   5 +-
 kernel/sched/sched.h                               |  40 +-
 mm/Kconfig.debug                                   |   2 -
 48 files changed, 1797 insertions(+), 452 deletions(-)

---
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 21 Sep 2016 13:20:32 +1000
Subject: [PATCH] cpufreq: merge fix for type of cpufreq_offline changing

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 611395cb115e..6e6c1fb60fbc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1286,7 +1286,7 @@ out_free_policy:
     return ret;
 }

-static void cpufreq_offline(unsigned int cpu);
+static int cpufreq_offline(unsigned int cpu);

 /**
  * cpufreq_add_dev - the cpufreq interface for a CPU device.
---
