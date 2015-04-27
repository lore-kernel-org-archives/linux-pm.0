From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.1-rc2
Date: Mon, 27 Apr 2015 19:58:30 +0800
Message-ID: <1430135910.3335.14.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:46462 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932515AbbD0L6m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Apr 2015 07:58:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi, Linus,

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the Thermal Management updates for v4.1-rc2
with top-most commit

75229df63655fefc8e970c4017ba4db0174ab000:

  Merge branches 'thermal-fix', 'thermal-intel' and 'thermal-soc'
of .git into next

on top of commit f22e6e847115abc3a0e2ad7bb18d243d42275af1:

  Linux 4.0-rc7

Specifics:
- Enhance Thermal Framework with several new capabilities:
  . use power estimates
  . compute weights with relative integers instead of percentages
  . allow governors to have private data in thermal zones
  . export thermal zone parameters through sysfs
  Thanks to the ARM thermal team (Javi M., Punit A., and KP).
- Introduce a new thermal governor: power allocator. First in kernel
closed loop PI(D) controller for thermal control. Thanks to ARM thermal
team.
- OF thermal now allows thermal zones to have sustainable power HW
specification. Thanks to Punit.
- Introduce thermal driver for Intel Quark SoC x1000platform. Thanks to
Ong, Boon Leong.
- Introduce QPNP PMIC temperature alarm driver. Thanks to Ivan T. I.;
- Enhance Exynos thermal driver to handle Exynos5433 TMU. Thanks to
Chanwoo C.
- TI thermal driver now has a better implementation for EOCZ bit. Thanks
to Pavel M.
- Add id for Broadwell server in intel_powerclamp driver. Thanks to
Jacob Pan.
- A couple of other small fixes and cleanups from Joe Perches, Brian
Norris, and Matthias Krause.

----------------------------------------------------------------

Brian Norris (1):
      thermal: user_space: add trip point number to uevent data

Chanwoo Choi (1):
      thermal: exynos: Add the support for Exynos5433 TMU

Ivan T. Ivanov (1):
      thermal: Add QPNP PMIC temperature alarm driver

Jacob Pan (1):
      thermal/intel_powerclamp: add id for broadwell server

Javi Merino (13):
      thermal: fair_share: use the weight from the thermal instance
      thermal: fair_share: fix typo
      thermal: export weight to sysfs
      thermal: fair_share: generalize the weight concept
      thermal: let governors have private data for each thermal zone
      thermal: extend the cooling device API to include power
information
      thermal: cpu_cooling: implement the power cooling device API
      thermal: introduce the Power Allocator governor
      thermal: add trace events to the power allocator governor
      thermal: x86_pkg_temp: drop const for thermal_zone_parameters
      thermal: remove stale THERMAL_POWER_ACTOR select
      thermal: cpu_cooling: Check memory allocation of power_table
      thermal: export thermal_zone_parameters to sysfs

Joe Perches (1):
      thermal: Use bool function return values of true/false not 1/0

Kapileshwar Singh (3):
      thermal: of: fix cooling device weights in device tree
      thermal: cpu_cooling: Remove cpu_dev update on policy CPU update
      thermal: cpu_cooling: Fix power calculation when CPUs are offline

Mathias Krause (1):
      thermal/intel_powerclamp: add __init / __exit annotations

Ong, Boon Leong (1):
      thermal: intel Quark SoC X1000 DTS thermal driver

Pavel Machek (3):
      cleanup ti-soc-thermal
      ti-soc-thermal: implement eocz bit to make driver useful on omap3
      ti-soc-thermal: request temperature periodically if hw can't do
that itself

Punit Agrawal (3):
      of: thermal: Introduce sustainable power for a thermal zone
      thermal: core: Add Kconfig option to enable writable trips
      thermal: Default OF created trip points to writable

Srinivas Pandruvada (3):
      Thermal: Intel SoC: DTS thermal IOSF core
      Thermal: Intel SoC: DTS thermal use common APIs
      Thermal/int340x/processor_thermal: Enable auxiliary DTS for
Braswell

Zhang Rui (2):
      Merge branch 'linus' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into thermal-soc
      Merge branches 'thermal-fix', 'thermal-intel' and 'thermal-soc'
of .git into next

 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  57 ++
 .../devicetree/bindings/thermal/thermal.txt        |   9 +
 Documentation/thermal/cpu-cooling-api.txt          | 156 +++++-
 Documentation/thermal/power_allocator.txt          | 247 +++++++++
 Documentation/thermal/sysfs-api.txt                |  83 ++-
 drivers/acpi/thermal.c                             |   9 +-
 drivers/platform/x86/acerhdf.c                     |   3 +-
 drivers/thermal/Kconfig                            |  60 ++-
 drivers/thermal/Makefile                           |   4 +
 drivers/thermal/cpu_cooling.c                      | 585
++++++++++++++++++++-
 drivers/thermal/db8500_thermal.c                   |   2 +-
 drivers/thermal/fair_share.c                       |  41 +-
 drivers/thermal/imx_thermal.c                      |   3 +-
 .../int340x_thermal/processor_thermal_device.c     |  55 +-
 drivers/thermal/intel_powerclamp.c                 |   9 +-
 drivers/thermal/intel_quark_dts_thermal.c          | 473
+++++++++++++++++
 drivers/thermal/intel_soc_dts_iosf.c               | 483
+++++++++++++++++
 drivers/thermal/intel_soc_dts_iosf.h               |  62 +++
 drivers/thermal/intel_soc_dts_thermal.c            | 430
+--------------
 drivers/thermal/of-thermal.c                       |  15 +-
 drivers/thermal/power_allocator.c                  | 538
+++++++++++++++++++
 drivers/thermal/qcom-spmi-temp-alarm.c             | 309 +++++++++++
 drivers/thermal/samsung/exynos_tmu.c               | 187 ++++++-
 drivers/thermal/samsung/exynos_tmu.h               |   1 +
 drivers/thermal/thermal_core.c                     | 310 ++++++++++-
 drivers/thermal/thermal_core.h                     |  13 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 104 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   5 +-
 drivers/thermal/user_space.c                       |  13 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |   2 +-
 include/linux/cpu_cooling.h                        |  39 ++
 include/linux/thermal.h                            |  86 ++-
 include/trace/events/thermal.h                     |  58 ++
 include/trace/events/thermal_power_allocator.h     |  87 +++
 34 files changed, 3986 insertions(+), 552 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
 create mode 100644 Documentation/thermal/power_allocator.txt
 create mode 100644 drivers/thermal/intel_quark_dts_thermal.c
 create mode 100644 drivers/thermal/intel_soc_dts_iosf.c
 create mode 100644 drivers/thermal/intel_soc_dts_iosf.h
 create mode 100644 drivers/thermal/power_allocator.c
 create mode 100644 drivers/thermal/qcom-spmi-temp-alarm.c
 create mode 100644 include/trace/events/thermal_power_allocator.h


