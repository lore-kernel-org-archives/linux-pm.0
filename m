From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 0/9] thermal: exynos: various cleanups
Date: Tue, 17 Jun 2014 19:27:16 +0200
Message-ID: <1403026045-16024-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series contains various cleanups for EXYNOS thermal
driver.  Overall it decreases driver's LOC by 12%.  It is based
on next-20140617 kernel.  It should not cause any functionality
changes.

Changes since v1:
- synced patches against next-20140617
- merged patch "thermal: exynos: remove unused defines" into
  "thermal: exynos: remove unused struct exynos_tmu_registers
  entries" one (per request from Eduardo)
- improved patch descriptions for patches #1-5
- fixed documentation for pdata->gain and pdata->reference_voltage
- added Reviewed-by from Amit to patches #6, #7 and #10
- added missing Acked-by from Kyungmin Park

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (9):
  thermal: exynos: remove unused struct exynos_tmu_registers entries
  thermal: exynos: remove dead code for HW_MODE calibration
  thermal: exynos: remove dead code for TYPE_TWO_POINT_TRIMMING
    calibration
  thermal: exynos: remove redundant pdata checks from
    exynos_tmu_initialize()
  thermal: exynos: remove redundant threshold_code checks from
    exynos_tmu_initialize()
  thermal: exynos: simplify temp_to_code() and code_to_temp()
  thermal: exynos: cache non_hw_trigger_levels in pdata
  thermal: exynos: remove redundant pdata checks from
    exynos_tmu_control()
  thermal: exynos: remove identical values from exynos*_tmu_registers
    structures

 drivers/thermal/samsung/exynos_thermal_common.h |   1 -
 drivers/thermal/samsung/exynos_tmu.c            | 181 ++++--------------------
 drivers/thermal/samsung/exynos_tmu.h            |  90 +-----------
 drivers/thermal/samsung/exynos_tmu_data.c       |  64 +--------
 drivers/thermal/samsung/exynos_tmu_data.h       |  33 +----
 5 files changed, 41 insertions(+), 328 deletions(-)

-- 
1.8.2.3
