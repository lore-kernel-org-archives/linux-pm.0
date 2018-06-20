From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date: Wed, 20 Jun 2018 19:22:00 +0200
Message-ID: <20180620172226.15012-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Changes in v8:
 - Added some tags for reviews and acks.
 - Cleanup timer patch (patch6) according to comments from Rafael.
 - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
 - While adopting patch 5 to new genpd changes, I took the opportunity to
   improve the new function description a bit.
 - Corrected malformed SPDX-License-Identifier in patch20.

Changes in v7:
 - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
   the psci firmware driver to a new firmware subdir and change to force PSCI PC
   mode during boot to cope with kexec'ed booted kernels.
 - Added some maintainers in cc for the timer/nohz patches.
 - Minor update to the new genpd governor, taking into account the state's
   poweroff latency while validating the sleep duration time.
 - Addressed a problem pointed out by Geert Uytterhoeven, around calling
   pm_runtime_get|put() for CPUs that has not been attached to a CPU PM domain.
 - Re-based on Linus' latest master.

Some background:

Overall this series have been discussed over years at various Linux conferences
and LKML, although let me give a brief introduction and then the rest can be
read in each changelog.

For ARM, the PSCI firmware interface may be managing the power to the CPUs.
Depending on the SoC, CPUs may also be arranged in hierarchical manner, which
could add another level of complexity from a CPU idle management point of view.

PSCI v1.0+ adds support for the so called OS initiated CPU suspend mode, which
enables a more fine grained method, allowing Linux to get more control, in
regards to being energy efficient. This is typically useful for these kind of
complex battery driven platforms.

Now, in principle what is missing today around CPU idle management for these
SoCs arranging CPUs in a hierarchical manner, that is what this series intends
to address.

 - Patch 1 -> Patch 12: The first part are generic changes to genpd, cpu_pm,
   timers, cpuidle and DT. Of course the solution is based on an opt-in method,
   so no users should be affected of any of these changes.

 - Patch 13 -> Patch 26: The second part are changes to PSCI and ARM64, which
   deploys the support for CPU idle management, based upon the new generic
   changes from the first part.

The series is based on v4.18rc1 and the code has been tested on a QCOM 410c
dragonboard. You may find the code at:

git.linaro.org/people/ulf.hansson/linux-pm.git next

Kind regards
Ulf Hansson


Lina Iyer (6):
  PM / Domains: Add generic data pointer to genpd_power_state struct
  timer: Export next wakeup time of a CPU
  dt: psci: Update DT bindings to support hierarchical PSCI states
  cpuidle: dt: Support hierarchical CPU idle states
  drivers: firmware: psci: Support hierarchical CPU idle states
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

Ulf Hansson (20):
  PM / Domains: Don't treat zero found compatible idle states as an
    error
  PM / Domains: Deal with multiple states but no governor in genpd
  PM / Domains: Add support for CPU devices to genpd
  PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
  PM / Domains: Add genpd governor for CPUs
  PM / Domains: Extend genpd CPU governor to cope with QoS constraints
  kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
  of: base: Add of_get_cpu_state_node() to get idle states for a CPU
    node
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  drivers: firmware: psci: Simplify error path of psci_dt_init()
  drivers: firmware: psci: Announce support for OS initiated suspend
    mode
  drivers: firmware: psci: Prepare to use OS initiated suspend mode
  drivers: firmware: psci: Share a few internal PSCI functions
  drivers: firmware: psci: Add support for PM domains using genpd
  drivers: firmware: psci: Introduce psci_dt_topology_init()
  drivers: firmware: psci: Try to attach CPU devices to their PM domains
  drivers: firmware: psci: Deal with CPU hotplug when using OSI mode
  arm64: kernel: Respect the hierarchical CPU topology in DT for PSCI

 .../devicetree/bindings/arm/psci.txt          | 156 +++++++++++++++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  53 +++++-
 arch/arm64/kernel/setup.c                     |   3 +
 drivers/base/power/domain.c                   | 158 ++++++++++++++-
 drivers/base/power/domain_governor.c          |  67 ++++++-
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/Kconfig                      |  15 +-
 drivers/firmware/Makefile                     |   3 +-
 drivers/firmware/psci/Kconfig                 |  13 ++
 drivers/firmware/psci/Makefile                |   4 +
 drivers/firmware/{ => psci}/psci.c            | 174 +++++++++++++----
 drivers/firmware/psci/psci.h                  |  19 ++
 drivers/firmware/{ => psci}/psci_checker.c    |   0
 drivers/firmware/psci/psci_pm_domain.c        | 180 ++++++++++++++++++
 drivers/of/base.c                             |  35 ++++
 include/linux/of.h                            |   8 +
 include/linux/pm_domain.h                     |  16 ++
 include/linux/psci.h                          |   2 +
 include/linux/tick.h                          |   8 +
 include/uapi/linux/psci.h                     |   5 +
 kernel/cpu_pm.c                               |  11 ++
 kernel/time/tick-sched.c                      |  10 +
 23 files changed, 877 insertions(+), 70 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (83%)
 create mode 100644 drivers/firmware/psci/psci.h
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)
 create mode 100644 drivers/firmware/psci/psci_pm_domain.c

-- 
2.17.1
