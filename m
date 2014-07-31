From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 0/8] thermal: exynos: various cleanups
Date: Thu, 31 Jul 2014 19:10:58 +0200
Message-ID: <1406826667-2289-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:33127 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaGaRL2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Jul 2014 13:11:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Tomasz Figa <t.figa@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

Hi,

This patch series contains various cleanups for EXYNOS thermal
driver.  Overall it decreases driver's LOC by 9%.  It is based
on next-20140731 kernel.  It should not cause any functionality
changes.

Changes since v2 (https://lkml.org/lkml/2014/6/17/436):
- synced patches against next-20140731
- dropped patch "thermal: exynos: remove dead code for
  TYPE_TWO_POINT_TRIMMING calibration" (newly added Exynos3250
  SoC support uses TYPE_TWO_POINT_TRIMMING calibration)
- updated patch description for patch #2
- dropped Reviewed-by from Amit from patch #8 (due to changed
  scope of the patch)

Changes since v1 (https://lkml.org/lkml/2014/5/5/194):
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


Bartlomiej Zolnierkiewicz (8):
  thermal: exynos: remove unused struct exynos_tmu_registers entries
  thermal: exynos: remove dead code for HW_MODE calibration
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
 drivers/thermal/samsung/exynos_tmu.c            | 126 +++++-------------------
 drivers/thermal/samsung/exynos_tmu.h            |  74 +-------------
 drivers/thermal/samsung/exynos_tmu_data.c       |  56 ++---------
 drivers/thermal/samsung/exynos_tmu_data.h       |  31 +-----
 5 files changed, 35 insertions(+), 253 deletions(-)

-- 
1.8.2.3

