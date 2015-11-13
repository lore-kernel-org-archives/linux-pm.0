From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v5 0/9] samsung: pmu: split up SoC specific PMU data
Date: Fri, 13 Nov 2015 14:59:34 +0530
Message-ID: <1447406983-27835-1-git-send-email-pankaj.dubey@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, k.kozlowski@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de, Pankaj Dubey <pankaj.dubey@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch series is a part of continuation work from following series
[1], [2], [3] and [4]

1: exynos: Move pmu driver to driver/soc folder and add exynos7 support
   http://www.spinics.net/lists/linux-samsung-soc/msg39797.html from Amit Daniel Kacchap
2: soc: samsung: pmu: split up SoC specific PMU data
   https://lkml.org/lkml/2015/1/7/12 from me
3: https://lkml.org/lkml/2015/10/26/245
4: https://lkml.org/lkml/2015/11/10/180

In this series I am splitting up SoC specific PMU configuration data into
mach-exynos folder itself, before moving all of them under
drivers/soc/samsung/. Also instead of making all changes in single patch it
has been broken into SoC specific patches to avoid large size of patch.
With this approach there will not be unwanted big churns just after
adding exynos-pmu under drivers/soc/samsung.

All these patches are just refactoring to keep minimal changes while moving
exynos-pmu driver under drivers/soc/samsung/. Support for exynos7 PMU can
be added on top of it, in such a manner that for ARM64 build, ARM related
SoC's PMU will not get compiled and thus unnecessary increasing kernel image size.

I have tested on Peach-Pi (Exynos5880) based chromebook for boot
and S2R functionality.

These patches have been prepared on top of Kukjin Kim's for-next and on top of
cherry-picked change from [5].

5: ARM: EXYNOS: Constify local exynos_pmu_data structure
   https://lkml.org/lkml/2015/10/28/917

Changes since v4:
 - In v3 I missed to give -M flag to detect rename, which made patches hard
   to review, so resubmitting patches with rename detector flag.
 - Addressed review comments from Krzysztof.

Changes since v3:
 - Keeping intact copyright dates in existing header files.
 - Addressed review comments from Krzysztof for v3.
 - Removing static inline function from exynos-pmu.h and
   keeping them in PMU driver.
 - Added new patch (2/9) for fixing potential null pointer reference in
   exynos_sys_powerdown_conf.
 - Added new patch (8/9) for rearranging static and non-static function for
   better readability.

Changes since v2:
 - Removed Amit's Samsung id as it's no more valid.
 - Rebased on latest kgene tree.
 - Removed redundant code from regs-pmu.h

Pankaj Dubey (9):
  ARM: EXYNOS: removing redundant code from regs-pmu.h
  ARM: EXYNOS: Fix potential NULL pointer access in
    exynos_sys_powerdown_conf
  ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
  ARM: EXYNOS: split up exynos3250 SoC specific PMU data
  ARM: EXYNOS: split up exynos4 SoC specific PMU data
  ARM: EXYNOS: split up exynos5250 SoC specific PMU data
  ARM: EXYNOS: split up exynos5420 SoC specific PMU data
  ARM: EXYNOS: rearrange static and non-static functions of PMU driver
  drivers: soc: Add support for Exynos PMU driver

 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-exynos/Makefile                      |    2 +-
 arch/arm/mach-exynos/exynos.c                      |    4 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |    2 +-
 arch/arm/mach-exynos/platsmp.c                     |    2 +-
 arch/arm/mach-exynos/pm.c                          |    4 +-
 arch/arm/mach-exynos/pmu.c                         | 1004 --------------------
 arch/arm/mach-exynos/suspend.c                     |    4 +-
 drivers/soc/samsung/Kconfig                        |    4 +
 drivers/soc/samsung/Makefile                       |    4 +
 drivers/soc/samsung/exynos-pmu.c                   |  183 ++++
 drivers/soc/samsung/exynos-pmu.h                   |   44 +
 drivers/soc/samsung/exynos3250-pmu.c               |  175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  |  223 +++++
 drivers/soc/samsung/exynos5250-pmu.c               |  196 ++++
 drivers/soc/samsung/exynos5420-pmu.c               |  280 ++++++
 .../linux/soc/samsung}/exynos-pmu.h                |    6 +-
 .../linux/soc/samsung/exynos-regs-pmu.h            |   15 +-
 18 files changed, 1124 insertions(+), 1029 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (98%)

-- 
2.4.5
