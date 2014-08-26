From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv5 0/4] thermal: exynos: Add support for TRIMINFO feature of
 Exynos3250
Date: Tue, 26 Aug 2014 10:31:01 +0900
Message-ID: <1409016665-3824-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: eduardo.valentin@ti.com, amit.daniel@samsung.com, rui.zhang@intel.com
Cc: kgene.kim@samsung.com, ch.naveen@samsung.com, kyungmin.park@samsung.com, b.zolnierkie@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patchset add the support of TRIMINFO_RELOAD feature for Exynos3250.
But Exynos3250 has two TRIMINFO_CTRL register instead other Exynos has only one
TRIMINFO_CTRL register. So, this patchset support the some Exynos SoC which
has more than one TRIMINF_CTRL.

Also, this patchset fix wrong value of TRIMINFO_RELOAD_SHIFT and remove
duplicate code when reading triminfo register of Exynos5440.

Changes from v4:
- Remove un-necessary triminfo_ctrl_{shift, mask} field
- Includes Bartlomiej's patch[1] that Exynos5260 / Exynos5420 should not use
TRIM_RELOAD flag
[2] https://lkml.org/lkml/2014/8/20/481

Changes from v3:
- Add reviewed message of Amit Daniel Kachhap <amit.daniel@samsung.com>
- Split RELOAD patch as two patch
- Fix 'TRIMINFO_RELOAD_SHIFT' value
- This series includes separate patch[1]
[1] https://lkml.org/lkml/2014/8/20/5
- Drop ACTIME bit setting because TRM includes not enough information of ACTIME bit.

Changes from v2:
- Fix build break because of missing 'or' operation.

Changes from v1:
- Add missing 'TMU_SUPPORT_TRIM_RELOAD' features

Bartlomiej Zolnierkiewicz (1):
  thermal: samsung: Exynos5260 and Exynos5420 should not use TRIM_RELOAD flag

Chanwoo Choi (3):
  thermal: exynos: Add support for many TRIMINFO_CTRL registers
  thermal: exynos: Add support for TRIM_RELOAD feature at Exynos3250
  thermal: exynos: Remove duplicate code when reading triminfo register of Exynos5440

 drivers/thermal/samsung/exynos_thermal_common.h |  1 +
 drivers/thermal/samsung/exynos_tmu.c            | 19 +++++++++++------
 drivers/thermal/samsung/exynos_tmu.h            |  9 ++++----
 drivers/thermal/samsung/exynos_tmu_data.c       | 28 ++++++++++++++-----------
 drivers/thermal/samsung/exynos_tmu_data.h       |  9 +++++---
 5 files changed, 40 insertions(+), 26 deletions(-)

-- 
1.8.0
