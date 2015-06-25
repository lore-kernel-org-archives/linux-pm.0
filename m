From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.2-rc1
Date: Thu, 25 Jun 2015 15:40:38 +0800
Message-ID: <1435218038.2913.20.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:13093 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbbFYHkl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 25 Jun 2015 03:40:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for 4.2-rc1 with
top-most commit 111b23cf895b5cbcdc1b2c6580be1bb78a577d05:

  Merge branches 'release' and 'thermal-soc' of .git into next 

on top of commit e26081808edadfd257c6c9d81014e3b25e9a6118:

  Linux 4.1-rc4 (2015-05-18 10:13:47 -0700)

Specifics:

- Enhance Thermal Framework with several new capabilities:
  . use power estimates
  . compute weights with relative integers instead of percentages
  . allow governors to have private data in thermal zones
  . export thermal zone parameters through sysfs
  Thanks to the ARM thermal team (Javi, Punit, KP).
- Introduce a new thermal governor: power allocator. First in kernel
closed loop PI(D) controller for thermal control. Thanks to ARM thermal
team.
- Enhance OF thermal to allow thermal zones to have sustainable power HW
specification. Thanks to Punit.
- Introduce thermal driver for Intel Quark SoC x1000platform. Thanks to
Ong, Boon Leong.
- Introduce QPNP PMIC temperature alarm driver. Thanks to Ivan T. I.
- Introduce thermal driver for Hisilicon hi6220. Thanks to kongxinwei.
- Enhance Exynos thermal driver to handle Exynos5433 TMU. Thanks to
Chanwoo C.
- TI thermal driver now has a better implementation for EOCZ bit. From
Pavel M.
- Add id for Skylake processors in int340x processor thermal driver.
- a couple of small fixes and cleanups.

thanks,
rui
----------------------------------------------------------------

Brian Bian (1):
      int340x_thermal/processor_thermal_device: add support to Skylake
processors

Chanwoo Choi (1):
      thermal: exynos: Add the support for Exynos5433 TMU

Dasaratharaman Chandramouli (1):
      intel powerclamp: support Knights Landing

Eduardo Valentin (2):
      thermal: support slope and offset coefficients
      thermal: of-thermal: add support for reading coefficients property

Ivan T. Ivanov (1):
      thermal: Add QPNP PMIC temperature alarm driver

Javi Merino (14):
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
      thermal: power_allocator: round the division when divvying up
power

Kapileshwar Singh (3):
      thermal: of: fix cooling device weights in device tree
      thermal: cpu_cooling: Remove cpu_dev update on policy CPU update
      thermal: cpu_cooling: Fix power calculation when CPUs are offline

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

Wu Fengguang (1):
      Thermal: Intel SoC: fix simple_return.cocci warnings

Zhang Rui (2):
      Merge branch 'linus' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into thermal-soc
      Merge branches 'release' and 'thermal-soc' of .git into next

kongxinwei (2):
      dt-bindings: Document the hi6220 thermal sensor bindings
      thermal: hisilicon: add new hisilicon thermal sensor driver

 .../bindings/thermal/hisilicon-thermal.txt         |  23 +
 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  57 ++
 .../devicetree/bindings/thermal/thermal.txt        |   9 +
 Documentation/thermal/cpu-cooling-api.txt          | 156 +++++-
 Documentation/thermal/power_allocator.txt          | 247 +++++++++
 Documentation/thermal/sysfs-api.txt                |  99 +++-
 drivers/acpi/thermal.c                             |   9 +-
 drivers/platform/x86/acerhdf.c                     |   3 +-
 drivers/thermal/Kconfig                            |  68 ++-
 drivers/thermal/Makefile                           |   5 +
 drivers/thermal/cpu_cooling.c                      | 585
++++++++++++++++++++-
 drivers/thermal/db8500_thermal.c                   |   2 +-
 drivers/thermal/fair_share.c                       |  41 +-
 drivers/thermal/hisi_thermal.c                     | 421
+++++++++++++++
 drivers/thermal/imx_thermal.c                      |   3 +-
 .../int340x_thermal/processor_thermal_device.c     |  59 ++-
 drivers/thermal/intel_powerclamp.c                 |   1 +
 drivers/thermal/intel_quark_dts_thermal.c          | 473
+++++++++++++++++
 drivers/thermal/intel_soc_dts_iosf.c               | 478
+++++++++++++++++
 drivers/thermal/intel_soc_dts_iosf.h               |  62 +++
 drivers/thermal/intel_soc_dts_thermal.c            | 430
+--------------
 drivers/thermal/of-thermal.c                       |  41 +-
 drivers/thermal/power_allocator.c                  | 539
+++++++++++++++++++
 drivers/thermal/qcom-spmi-temp-alarm.c             | 309 +++++++++++
 drivers/thermal/samsung/exynos_tmu.c               | 187 ++++++-
 drivers/thermal/samsung/exynos_tmu.h               |   1 +
 drivers/thermal/thermal_core.c                     | 314 ++++++++++-
 drivers/thermal/thermal_core.h                     |  11 +
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 104 ++--
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   5 +-
 drivers/thermal/x86_pkg_temp_thermal.c             |   2 +-
 include/linux/cpu_cooling.h                        |  39 ++
 include/linux/thermal.h                            |  97 +++-
 include/trace/events/thermal.h                     |  58 ++
 include/trace/events/thermal_power_allocator.h     |  87 +++
 35 files changed, 4477 insertions(+), 548 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
 create mode 100644
Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
 create mode 100644 Documentation/thermal/power_allocator.txt
 create mode 100644 drivers/thermal/hisi_thermal.c
 create mode 100644 drivers/thermal/intel_quark_dts_thermal.c
 create mode 100644 drivers/thermal/intel_soc_dts_iosf.c
 create mode 100644 drivers/thermal/intel_soc_dts_iosf.h
 create mode 100644 drivers/thermal/power_allocator.c
 create mode 100644 drivers/thermal/qcom-spmi-temp-alarm.c
 create mode 100644 include/trace/events/thermal_power_allocator.h


