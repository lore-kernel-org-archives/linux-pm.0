From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal management updates for v4.5-rc8
Date: Wed, 9 Mar 2016 16:08:12 -0800
Message-ID: <20160310000811.GA19267@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

These are fixes applicable to rc8. But feel free to collect them for rc1 if
you don't have anything for rc8. Lets just not forget them :-). I still have more
material for rc1 (new drivers and API). 

So, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management updates for v4.5-rc8 with top-most

ccb361d2fdda8975c8bbc8a1749c31dbd62dd276:

  thermal: exynos: Defer probe if vtmu is present but not registered (2016-03-08 14:22:25 -0800)

on top of commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

Specifics in this pull request:
- Several fsmall fixes on Rockchip, TI-SoC, Tegra, RCar, and Exynos thermal drivers
- Changes in Kconfigs to allow compile test on UM arch.
- These change have been CI tested using KernelCI bot [1,2]. \o/

I am taking over on Rui's behalf while he is out. Happy New Chinese Year!

[1] - https://kernelci.org/boot/all/job/evalenti/kernel/v4.5-rc6-24-gea1bd053b687/
[2] - https://kernelci.org/build/evalenti/kernel/v4.5-rc6-24-gea1bd053b687/

BR,

Eduardo Valentin

----------------------------------------------------------------
Caesar Wang (3):
      thermal: rockchip: fix a impossible condition caused by the warning
      thermal: rockchip: the rename compatibles for rockchip SoCs
      thermal: rockchip: fix the tsadc sequence output on rk3228/rk3399

Dan Carpenter (1):
      thermal: ti-soc-thermal: clean up the error handling a bit

Elaine Zhang (1):
      thermal: rockchip: fix calculation error for code_to_temp

Javier Martinez Canillas (3):
      thermal: exynos: List vtmu-supply as optional property in DT binding
      thermal: exynos: Use devm_regulator_get_optional() for vtmu
      thermal: exynos: Defer probe if vtmu is present but not registered

Krzysztof Kozlowski (4):
      thermal: Fix build error of missing devm_ioremap_resource on UM
      thermal: exynos: Document compatible for Exynos5433 TMU
      thermal: exynos: Document number of supported trip-points
      thermal: exynos: Print a message about exceeded number of supported trip-points

Luis de Bethencourt (1):
      thermal: db8500_cpufreq_cooling: Compile with COMPILE_TEST

Simon Horman (1):
      thermal: rcar: Use ARCH_RENESAS

Wei Ni (1):
      thermal: tegra_soctherm: fix sign bit of temperature

Wolfram Sang (1):
      thermal: rcar_thermal: don't open code of_device_get_match_data()

 .../devicetree/bindings/thermal/exynos-thermal.txt |  18 +-
 drivers/thermal/Kconfig                            |  12 +-
 drivers/thermal/rcar_thermal.c                     |   3 +-
 drivers/thermal/rockchip_thermal.c                 | 239 ++++++++++++---------
 drivers/thermal/samsung/Kconfig                    |   1 +
 drivers/thermal/samsung/exynos_tmu.c               |  19 +-
 drivers/thermal/tegra_soctherm.c                   |   2 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  10 +-
 8 files changed, 186 insertions(+), 118 deletions(-)
