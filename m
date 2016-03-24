From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.6-rc1
Date: Thu, 24 Mar 2016 21:36:01 +0800
Message-ID: <1458826561.2847.35.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32879 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105AbcCXNgG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Mar 2016 09:36:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for 4.6-rc1 with
top-most commit 81ad4276b505e987dd8ebbdf63605f92cd172b52:

  Thermal: Ignore invalid trip points (2016-03-18 14:10:57 +0800)

on top of commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)


Specifics:

- Fix a regression that bogus trip points on some Lenovo laptops start
to screw up thermal control after commit 81ad4276b505 ("Thermal:
initialize thermal zone device correctly"). On these Lenovo laptops, a
bogus passive trip point is reported, which is 0 degree Celsius. Without
commit 81ad4276b505, thermal zone fails to set cooling devices to proper
cooling state, which is a bug. But with commit 81ad4276b505 applied, the
processors are always throttled on these Lenovo laptops because the
current temperature is always higher than the passive trip point. A
patch is written to ignore such bogus trip points. From: Zhang Rui.

- Introduce Mediatek thermal driver. From: Sascha Hauer.

- Introduce devm_ versions of OF thermal sensor register API. From:
Laxman Dewangan.

- Changes in Kconfigs to allow compile test on UM arch. From: Krzysztof
Kozlowski.

- Introduce Skylake support in intel_pch_thermal driver. From: Srinivas
Pandruvada.

- Several small fixes on Rockchip, TI-SoC, Tegra, RCar, and Exynos
thermal drivers.

thanks,
rui

----------------------------------------------------------------
Caesar Wang (3):
      thermal: rockchip: fix a impossible condition caused by the
warning
      thermal: rockchip: the rename compatibles for rockchip SoCs
      thermal: rockchip: fix the tsadc sequence output on rk3228/rk3399

Dan Carpenter (1):
      thermal: ti-soc-thermal: clean up the error handling a bit

Eduardo Valentin (2):
      thermal: small style cleanup in mtk_thermal
      thermal: mtk: allow compile testing on UM

Elaine Zhang (1):
      thermal: rockchip: fix calculation error for code_to_temp

Javier Martinez Canillas (3):
      thermal: exynos: List vtmu-supply as optional property in DT
binding
      thermal: exynos: Use devm_regulator_get_optional() for vtmu
      thermal: exynos: Defer probe if vtmu is present but not registered

Krzysztof Kozlowski (4):
      thermal: Fix build error of missing devm_ioremap_resource on UM
      thermal: exynos: Document compatible for Exynos5433 TMU
      thermal: exynos: Document number of supported trip-points
      thermal: exynos: Print a message about exceeded number of
supported trip-points

Laxman Dewangan (3):
      thermal: doc: Add details of
thermal_zone_of_sensor_{register,unregister}
      thermal: of-thermal: Add devm version of
thermal_zone_of_sensor_register
      thermal: doc: Add details of
devm_thermal_zone_of_sensor_{register,unregister}

Luis de Bethencourt (1):
      thermal: db8500_cpufreq_cooling: Compile with COMPILE_TEST

Michele Di Giorgio (1):
      thermal: trace: migrating thermal traces to use
TRACE_DEFINE_ENUM() macros

Sascha Hauer (2):
      dt-bindings: thermal: Add binding document for Mediatek thermal
controller
      thermal: Add Mediatek thermal controller support

Simon Horman (1):
      thermal: rcar: Use ARCH_RENESAS

Srinivas Pandruvada (1):
      thermal: intel_pch_thermal: Enable Skylake PCH thermal

Wei Ni (1):
      thermal: tegra_soctherm: fix sign bit of temperature

Wolfram Sang (1):
      thermal: rcar_thermal: don't open code of_device_get_match_data()

Zhang Rui (3):
      Merge branch 'linus' of
git://git.kernel.org/.../evalenti/linux-soc-thermal into thermal-soc
      Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc'
into next
      Thermal: Ignore invalid trip points

 .../devicetree/bindings/thermal/exynos-thermal.txt |  18 +-
 .../bindings/thermal/mediatek-thermal.txt          |  43 ++
 Documentation/thermal/sysfs-api.txt                |  68 +++
 drivers/thermal/Kconfig                            |  21 +-
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/intel_pch_thermal.c                |   6 +
 drivers/thermal/mtk_thermal.c                      | 625
+++++++++++++++++++++
 drivers/thermal/of-thermal.c                       |  81 +++
 drivers/thermal/rcar_thermal.c                     |   3 +-
 drivers/thermal/rockchip_thermal.c                 | 239 ++++----
 drivers/thermal/samsung/Kconfig                    |   1 +
 drivers/thermal/samsung/exynos_tmu.c               |  19 +-
 drivers/thermal/tegra_soctherm.c                   |   2 +-
 drivers/thermal/thermal_core.c                     |  13 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  10 +-
 include/linux/thermal.h                            |  20 +
 include/trace/events/thermal.h                     |  16 +-
 17 files changed, 1065 insertions(+), 121 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
 create mode 100644 drivers/thermal/mtk_thermal.c


