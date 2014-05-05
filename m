From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 00/10] thermal: exynos: various cleanups
Date: Mon, 05 May 2014 13:15:29 +0200
Message-ID: <1399288539-1793-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series contains various cleanups for EXYNOS thermal
driver.  Overall it decreases driver's LOC by 13%.  It is based
on next-20140428 kernel.  It should not cause any functionality
changes.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (10):
  thermal: exynos: remove unused struct exynos_tmu_registers entries
  thermal: exynos: remove unused defines
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
 drivers/thermal/samsung/exynos_tmu.h            |  86 +----------
 drivers/thermal/samsung/exynos_tmu_data.c       |  40 +-----
 drivers/thermal/samsung/exynos_tmu_data.h       |  32 +----
 5 files changed, 37 insertions(+), 303 deletions(-)

-- 
1.8.2.3
