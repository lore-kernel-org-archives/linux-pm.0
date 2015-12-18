From: Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v7 0/6] samsung: pmu: split up SoC specific PMU data
Date: Fri, 18 Dec 2015 09:02:10 +0530
Message-ID: <1450409536-30463-1-git-send-email-pankaj.dubey@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, k.kozlowski@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de, Pankaj Dubey <pankaj.dubey@samsung.com>
List-Id: linux-pm@vger.kernel.org

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

This series have been prepared on top of Krzysztof Kozlowski's 
next/stuff-late-not-split-per-branch branch, and it's just a rebase compared to
V6 posted and reviewed here [1]. 

[1]: https://lkml.org/lkml/2015/11/17/15

For testing entire patchset on Peach-Pi (Exynos5880) based chromebook for boot
and S2R functionality.

Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>

For testing entire patchset on on Trats2 (Exynos4412, S2R, reboot, poweroff)
and Odroid XU3 (Exynos5422, reboot, poweroff).

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Changes since v6:
 - Rebasing on top of branch provided by Krzysztof, after resolving conflicts 
   caused due to Alim's patches for adoptation of generic syscon for poweroff, reboot.
 - Included Tested-by tags on individual patches as per applicability.
 - Dropped patches v6 [1/9], v6 [2/9] as these are already present in above mentioned branch.
 - Dropped patch v6 [8/9] as after Alim's patch this patch no more required.

Changes since v5:
 - Removed extra blank line from patch 5/9 and 6/9.
 - Modified soc/samsung/Kconfig for config EXNOS_PMU. Added depends on ARM.

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

Pankaj Dubey (6):
  ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
  ARM: EXYNOS: split up exynos3250 SoC specific PMU data
  ARM: EXYNOS: split up exynos4 SoC specific PMU data
  ARM: EXYNOS: split up exynos5250 SoC specific PMU data
  ARM: EXYNOS: split up exynos5420 SoC specific PMU data
  drivers: soc: Add support for Exynos PMU driver

 arch/arm/mach-exynos/Kconfig                       |   1 +
 arch/arm/mach-exynos/Makefile                      |   2 +-
 arch/arm/mach-exynos/exynos.c                      |   4 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 |   2 +-
 arch/arm/mach-exynos/platsmp.c                     |   2 +-
 arch/arm/mach-exynos/pm.c                          |   4 +-
 arch/arm/mach-exynos/pmu.c                         | 967 ---------------------
 arch/arm/mach-exynos/suspend.c                     |   4 +-
 drivers/soc/samsung/Kconfig                        |   4 +
 drivers/soc/samsung/Makefile                       |   2 +
 drivers/soc/samsung/exynos-pmu.c                   | 141 +++
 drivers/soc/samsung/exynos-pmu.h                   |  44 +
 drivers/soc/samsung/exynos3250-pmu.c               | 175 ++++
 drivers/soc/samsung/exynos4-pmu.c                  | 223 +++++
 drivers/soc/samsung/exynos5250-pmu.c               | 196 +++++
 drivers/soc/samsung/exynos5420-pmu.c               | 280 ++++++
 .../linux/soc/samsung}/exynos-pmu.h                |   6 +-
 .../linux/soc/samsung/exynos-regs-pmu.h            |   6 +-
 18 files changed, 1080 insertions(+), 983 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-pmu.h
 create mode 100644 drivers/soc/samsung/exynos3250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos4-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5250-pmu.c
 create mode 100644 drivers/soc/samsung/exynos5420-pmu.c
 rename {arch/arm/mach-exynos => include/linux/soc/samsung}/exynos-pmu.h (81%)
 rename arch/arm/mach-exynos/regs-pmu.h => include/linux/soc/samsung/exynos-regs-pmu.h (99%)

-- 
2.4.5
