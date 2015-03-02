From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 0/5] Subject: The power allocator thermal governor
Date: Mon,  2 Mar 2015 17:17:18 +0000
Message-ID: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47949 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbbCBRRx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Mar 2015 12:17:53 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, lina.iyer@linaro.org, broonie@kernel.org, tixy@linaro.org, Javi Merino <javi.merino@arm.com>

*** BLURB HERE ***

Hi linux-pm,

Introduce the power allocator governor, a thermal governor that
allocates device power to control temperature.  This series is based
on branch "linus" of Eduardo's linux-soc-thermal tree:

git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git

Changes since v2:
  - Address Eduardo's review
    + Turn variable-size array in divvy_up_power() into a
      devm_kcalloc() as suggested by Eduardo
    + Remove #ifdeffery from thermal_core.c as suggested by Eduardo
  - Bring back cpufreq's CPUFREQ_UPDATE_POLICY_CPU notifier in order
    to update the cpu device in cpu_cooling.c when cpufreq changes
    the policy cpu.

Changes since v1:
  - Removed a memory leak pointed out by Steve Rostedt
  - Relax the constraint of the trip points to be the first and last
    passive trip point as Lina Iyer suggested.
  - Update how the governor treats weights to mimic the behavior of
    fair share in v3 of the weight fixes series.
  - Don't cache the cpufreq_cooling_device and scan for it whenever
    we need it.
  - Consider the rate of changes in the derivative term of the PID
    controller

Changes since RFC v6:
  - Addressed Eduardo's review
    + Pass the interval to the static power function as suggested by
      Eduardo
    + Make the cooling device ops return 0 or -E* and put the
      calculation in a parameter, like the rest of the cooling device
      ops
    + Documentation improvements
  - Use thermal_cdev_update() to change cooling device states
  - Add a patch to export the power allocator governor's tzp
    parameters to sysfs

Changes since RFC v5:
  - Addressed Stephen's review of the trace patches.
  - Removed power actors and extended the cooling device interface
    instead.
  - Let platforms override the power allocator governor parameters in
    their thermal zone parameters

Changes since RFC v4:
  - Add more tracing
  - Document some of the limitations of the power allocator governor
  - Export the power_actor API and move power_actor.h to include/linux

Changes since RFC v3:
  - Use tz->passive to poll faster when the first trip point is hit.
  - Don't make a special directory for power_actors
  - Add a DT property for sustainable-power
  - Simplify the static power interface and pass the current thermal
    zone in every power_actor_ops to remove the controversial
    enum power_actor_types
  - Use locks with the actor_list list
  - Use cpufreq_get() to get the frequency of the cpu instead of
    using the notifiers.
  - Remove the prompt for THERMAL_POWER_ACTOR_CPU when configuring
    the kernel

Changes since RFC v2:
  - Changed the PI controller into a PID controller
  - Added static power to the cpu power model
  - tz parameter max_dissipatable_power renamed to sustainable_power
  - Register the cpufreq cooling device as part of the
    power_cpu_actor registration.

Changes since RFC v1:
  - Fixed finding cpufreq cooling devices in cpufreq_frequency_change()
  - Replaced the cooling device interface with a separate power actor
    API
  - Addressed most of Eduardo's comments
  - Incorporated ftrace support for bitmask to trace cpumasks

Cheers,
Javi & Punit

Javi Merino (4):
  thermal: introduce the Power Allocator governor
  thermal: add trace events to the power allocator governor
  thermal: export thermal_zone_parameters to sysfs
  Revert "cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications"

Kapileshwar Singh (1):
  thermal: cpu_cooling: update the cpu device when cpufreq updates the
    policy cpu

 Documentation/thermal/power_allocator.txt      | 247 ++++++++++++
 Documentation/thermal/sysfs-api.txt            |  52 +++
 drivers/cpufreq/cpufreq.c                      |   3 +
 drivers/thermal/Kconfig                        |  15 +
 drivers/thermal/Makefile                       |   1 +
 drivers/thermal/cpu_cooling.c                  |  34 +-
 drivers/thermal/power_allocator.c              | 538 +++++++++++++++++++++++++
 drivers/thermal/thermal_core.c                 | 110 ++++-
 drivers/thermal/thermal_core.h                 |   8 +
 include/linux/cpufreq.h                        |   5 +-
 include/linux/thermal.h                        |  37 +-
 include/trace/events/thermal.h                 |  58 +++
 include/trace/events/thermal_power_allocator.h |  87 ++++
 13 files changed, 1184 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/thermal/power_allocator.txt
 create mode 100644 drivers/thermal/power_allocator.c
 create mode 100644 include/trace/events/thermal_power_allocator.h

-- 
1.9.1

