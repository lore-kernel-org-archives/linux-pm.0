From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 00/33] thermal: exynos: convert the driver to use per-SoC
 type operations
Date: Thu, 13 Nov 2014 16:00:55 +0100
Message-ID: <1415890888-8881-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series replaces the hardware registers abstractions in
the Exynos thermal driver by the usage of per-SoC type operations.
Such solution provides simpler, easier to understand code and
allows removal of ~250 LOCs (~11% of the whole source code) from
the driver.  Some other driver improvements are now also possible
thanks to these changes but are scheduled at later time (like
consolidating code for clearing IRQs using INTCLEAR register).

The patchset should not cause any functionality changes.  This
means that unless there are some bugs in the patches itself there
should be no behavior changes for the driver (this also includes
lack of changes in the way hardware is accessed by the driver).

All testing was done on (Exynos4412 SoC based) ODROID U3 board
(some additional patches are needed to make the Exynos thermal
driver work on this hardware).

Depends on:
- 'next' branch of linux-soc-thermal.git kernel tree from Eduardo

Changes since v1 (https://lkml.org/lkml/2014/9/18/305):
- rebased on top of the current linux-soc-thermal kernel

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (33):
  thermal: exynos: remove needless triminfo_data abstraction
  thermal: exynos: remove needless tmu_status abstraction
  thermal: exynos: remove needless threshold_temp abstraction
  thermal: exynos: remove needless triminfo_ctrl abstraction
  thermal: exynos: remove needless test_mux_addr_shift abstraction
  thermal: exynos: remove needless therm_trip_[mode,mask]_shift
    abstractions
  thermal: exynos: remove needless therm_trip_en_shift abstraction
  thermal: exynos: remove needless emul_temp_shift abstraction
  thermal: exynos: remove needless emul_time_shift abstraction
  thermal: exynos: replace tmu_irqstatus check by Exynos5440 one
  thermal: exynos: replace tmu_pmin check by Exynos5440 one
  thermal: exynos: simplify HW_TRIP level setting
  thermal: exynos: replace threshold_falling check by Exynos SoC type
    one
  thermal: exynos: remove TMU_SUPPORT_READY_STATUS flag
  thermal: exynos: remove TMU_SUPPORT_TRIM_RELOAD flag
  thermal: exynos: add sanitize_temp_error() helper
  thermal: exynos: add get_th_reg() helper
  thermal: exynos: add ->tmu_initialize method
  thermal: exynos: add get_con_reg() helper
  thermal: exynos: add ->tmu_control method
  thermal: exynos: add ->tmu_read method
  thermal: exynos: add get_emul_con_reg() helper
  thermal: exynos: add ->tmu_set_emulation method
  thermal: exynos: add ->tmu_clear_irqs method
  thermal: exynos: remove TMU_SUPPORT_FALLING_TRIP flag
  thermal: exynos: remove TMU_SUPPORT_EMUL_TIME flag
  thermal: exynos: remove TMU_SUPPORT_EMULATION flag
  thermal: exynos: remove TMU_SUPPORT_ADDRESS_MULTIPLE flag
  thermal: exynos: remove TMU_SUPPORT_MULTI_INST flag
  thermal: exynos: remove test_mux pdata field
  thermal: exynos: remove SoC type ifdefs
  thermal: exynos: remove __EXYNOS5420_TMU_DATA macro
  thermal: exynos: remove exynos_tmu_data.h include

 drivers/thermal/samsung/exynos_thermal_common.h |   1 -
 drivers/thermal/samsung/exynos_tmu.c            | 692 ++++++++++++++++--------
 drivers/thermal/samsung/exynos_tmu.h            | 123 +----
 drivers/thermal/samsung/exynos_tmu_data.c       | 239 +-------
 drivers/thermal/samsung/exynos_tmu_data.h       | 159 ------
 5 files changed, 485 insertions(+), 729 deletions(-)
 delete mode 100644 drivers/thermal/samsung/exynos_tmu_data.h

-- 
1.8.2.3
