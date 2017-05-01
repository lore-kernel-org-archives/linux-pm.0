From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] Power management updates for v4.12-rc1, part 1
Date: Mon, 1 May 2017 22:49:09 +0200
Message-ID: <CAJZ5v0iTBfHJjzrsYkjSwkdPc3R=Nohj9vsLeX8Kz+JP7=B56g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:34685 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdEAUtL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 16:49:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-4.12-rc1

with top-most commit a1d2fcfd80bef6cdc5675dcabe25587010720bdb

 Merge branch 'pm-tools'

on top of commit 5a7ad1146caa895ad718a534399e38bd2ba721b7

 Linux 4.11-rc8

to receive the first batch of power management updates for v4.12-rc1.

This time the majority of changes go to the cpufreq subsystem (and
to the intel_pstate driver in particular) and there are some updates
in the generic power domains framework, cpuidle, tools and a couple
of other places.

One thing worth mentioning is that the intel_pstate's sysfs interface
has been reworked to be more consistent with the general expectations
of the cpufreq core and less confusing, hopefully for the better.
Also, we have a new cpufreq driver for Tegra186 and new hardware
support in intel_pstata and the Mediatek cpufreq driver.

Apart from that, the AnalyzeSuspend utility for system suspend
profiling gets a companion called AnalyzeBoot for the analogous
profiling of system boot and they both go into one place under
tools/power/pm-graph/.

The rest is mostly fixes, cleanups and code reorganization.

Specifics:

 - Rework the intel_pstate driver's sysfs interface to make it
   more straightforward and more intuitive (Rafael Wysocki).

 - Make intel_pstate support all processors which advertise HWP
   (hardware-managed P-states) to the kernel in all operation modes
   and make it use the load-based P-state selection algorithm on a
   wider range of systems in the active mode (Rafael Wysocki).

 - Add cpufreq driver for Tegra186 (Mikko Perttunen).

 - Add support for Gemini Lake SoCs to intel_pstate (David Box).

 - Add support for MT8176 and MT817x to the Mediatek cpufreq driver
   and clean up that driver a bit (Daniel Kurtz).

 - Clean up intel_pstate and optimize it slightly (Rafael Wysocki).

 - Update the schedutil cpufreq governor, mostly to fix a couple of
   issues with it related to specific workloads, and rework its sysfs
   tunable and initialization a bit (Rafael Wysocki, Viresh Kumar).

 - Fix minor issues in the imx6q, dbx500 and qoriq cpufreq drivers
   (Christophe Jaillet, Irina Tirdea, Leonard Crestez, Viresh Kumar,
   YuanTian Tang).

 - Add file patterns for cpufreq DT bindings to MAINTAINERS (Geert
   Uytterhoeven).

 - Add support for "always on" power domains to the genpd (generic
   power domains) framework and clean up that code somewhat (Ulf
   Hansson, Lina Iyer, Viresh Kumar).

 - Fix minor issues in the powernv cpuidle driver and clean it up
   (Anton Blanchard, Gautham Shenoy).

 - Move the AnalyzeSuspend utility under tools/power/pm-graph/ and
   add an analogous boot-profiling utility called AnalyzeBoot to it
   (Todd Brandt).

 - Add rk3328 support to the rockchip-io AVS (Adaptive Voltage
   Scaling) driver (David Wu).

 - Fix minor issues in the cpuidle core, the intel_pstate_tracer
   utility, the devfreq framework and the PM core documentation
   (Chanwoo Choi, Doug Smythies, Johan Hovold, Marcin Nowakowski).

Thanks!

---------------

Anton Blanchard (3):
      cpuidle: powernv: Don't bounce between low and very low thread priority
      cpuidle: powernv: Don't continually set thread priority in snooze_loop()
      cpuidle: powernv: Avoid a branch in the core snooze_loop() loop

Chanwoo Choi (1):
      PM / devfreq: Move struct devfreq_governor to devfreq directory

Christophe Jaillet (1):
      cpufreq: imx6q: Fix error handling code

Daniel Kurtz (2):
      cpufreq: mt8173: Mark mt8173_cpufreq_driver_init as __init
      cpufreq: mediatek: Add support for MT8176 and MT817x

David E. Box (1):
      cpufreq: intel_pstate: Add support for Gemini Lake

David Wu (1):
      PM / AVS: rockchip-io: add io selectors and supplies for rk3328

Doug Smythies (1):
      tools/power/x86/intel_pstate_tracer: Adjust directory ownership

Gautham R. Shenoy (1):
      powernv-cpuidle: Validate DT property array size

Geert Uytterhoeven (1):
      MAINTAINERS: Add file patterns for cpufreq device tree bindings

Irina Tirdea (1):
      cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator

Johan Hovold (2):
      PM / runtime: Fix autosuspend documentation
      PM / runtime: Document autosuspend-helper side effects

Leonard Crestez (1):
      cpufreq: imx6q: Set max suspend_freq to avoid changes during suspend

Lina Iyer (1):
      PM / Domains: Ignore domain-idle-states that are not compatible

Marcin Nowakowski (1):
      cpuidle: cpuidle-cps: remove unused variable

Mikko Perttunen (1):
      cpufreq: Add Tegra186 cpufreq driver

Rafael J. Wysocki (25):
      cpufreq: intel_pstate: Drop redundant wrapper function
      cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely
      cpufreq: schedutil: Trace frequency only if it has changed
      cpufreq: intel_pstate: Support HWP processors in all operation modes
      cpufreq: intel_pstate: Use load-based P-state selection more widely
      cpufreq: intel_pstate: Active mode P-state limits rework
      cpufreq: intel_pstate: Avoid transient updates of cpuinfo.max_freq
      cpufreq: intel_pstate: Eliminate struct perf_limits
      cpufreq: intel_pstate: Drop pointless initialization of PID parameters
      cpufreq: intel_pstate: Initialize pid_params statically
      cpufreq: intel_pstate: Fold intel_pstate_reset_all_pid() into the caller
      cpufreq: intel_pstate: Clean up intel_pstate_busy_pid_reset()
      cpufreq: intel_pstate: Set HWP sampling interval once
      cpufreq: intel_pstate: Skip unnecessary PID resets on init
      cpufreq: intel_pstate: Drop driver_registered variable
      cpufreq: intel_pstate: Modify check in intel_pstate_update_status()
      cpufreq: intel_pstate: Use different utilization update callbacks
      cpufreq: intel_pstate: Add update_util callback to pstate_funcs
      cpufreq: intel_pstate: Move cpu_defaults definitions
      cpufreq: intel_pstate: Drop struct cpu_defaults
      cpufreq: intel_pstate: Introduce pid_in_use()
      cpufreq: intel_pstate: Do not walk policy->cpus
      cpufreq: intel_pstate: Eliminate intel_pstate_get_min_max()
      cpufreq: schedutil: Reduce frequencies slower
      cpufreq: schedutil: Use policy-dependent transition delays

Todd E Brandt (3):
      tools: power: pm-graph: AnalyzeSuspend v4.6
      tools: power: pm-graph: AnalyzeBoot v2.0
      tools: power: pm-graph: Package makefile and man pages

Ulf Hansson (4):
      PM / Domains: Clean up code validating genpd's status
      PM / Domains: Enable users of genpd to specify always on PM domains
      PM / Domains: Respect errors from genpd's ->power_off() callback
      PM / Domains: Don't warn about IRQ safe device for an always on PM domain

Viresh Kumar (4):
      cpufreq: schedutil: Redefine the rate_limit_us tunable
      cpufreq: schedutil: Refactor sugov_next_freq_shared()
      cpufreq: dbx500: Manage cooling device from cpufreq driver
      PM / Domain: remove conditional from error case

YuanTian Tang (1):
      cpufreq: qoriq: enhance bus frequency calculation

---------------

 .../devicetree/bindings/power/power_domain.txt     |   4 +-
 .../bindings/power/rockchip-io-domain.txt          |   1 +
 Documentation/power/runtime_pm.txt                 |  19 +-
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |   5 -
 drivers/base/power/domain.c                        |  68 +-
 drivers/cpufreq/Kconfig.arm                        |   6 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/dbx500-cpufreq.c                   |  20 +
 drivers/cpufreq/imx6q-cpufreq.c                    |  17 +-
 drivers/cpufreq/intel_pstate.c                     | 910 +++++++++-----------
 drivers/cpufreq/mt8173-cpufreq.c                   |  23 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |  24 +-
 drivers/cpufreq/tegra186-cpufreq.c                 | 275 +++++++
 drivers/cpuidle/cpuidle-cps.c                      |   3 +-
 drivers/cpuidle/cpuidle-powernv.c                  |  69 +-
 drivers/devfreq/governor.h                         |  29 +
 drivers/power/avs/rockchip-io-domain.c             |  41 +
 drivers/thermal/Kconfig                            |  12 -
 drivers/thermal/Makefile                           |   1 -
 drivers/thermal/db8500_cpufreq_cooling.c           | 105 ---
 include/linux/cpufreq.h                            |   7 +
 include/linux/devfreq.h                            |  30 +-
 include/linux/pm_domain.h                          |   1 +
 include/linux/tick.h                               |   1 +
 kernel/sched/cpufreq_schedutil.c                   |  82 +-
 kernel/time/tick-sched.c                           |  12 +
 tools/power/pm-graph/Makefile                      |  28 +
 tools/power/pm-graph/analyze_boot.py               | 824 ++++++++++++++++++
 .../power/pm-graph}/analyze_suspend.py             | 916 +++++++++++----------
 tools/power/pm-graph/bootgraph.8                   | 132 +++
 tools/power/pm-graph/sleepgraph.8                  | 243 ++++++
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py |  17 +
 33 files changed, 2774 insertions(+), 1153 deletions(-)
