From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 00/18] thermal: exynos: further fixes and cleanups
Date: Thu, 26 Apr 2018 13:51:15 +0200
Message-ID: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180426115159epcas2p3b8d995ba552b403b5052f74970fdef0f@epcas2p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patchset contains Exynos thermal driver fixes and cleanups.

Highlights:
* Move code valid for all SoCs from ->tmu_initialize method
  to exynos_tmu_initialize().
* Add ->set_trip_[temp,hyst] methods and convert ->tmu_initialize
  method implementations to use them.
* Remove bogus trip reporting to user-space.

The patchset is based on top of:
- "[PATCH 00/14] thermal: exynos: pending fixes and cleanups"
  (https://lkml.org/lkml/2018/4/16/256))
- "[PATCH] thermal: samsung: Remove support for Exynos5440"
  (https://lkml.org/lkml/2018/4/26/405)

Tested on Exynos4210 based Trats board and Exynos5422 based Odroid-XU3
Lite board.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (18):
  thermal: exynos: fix setting rising_threshold for Exynos5433
  thermal: exynos: always check for trips points existence
  thermal: exynos: always check for critical trip points existence
  thermal: exynos: check STATUS register in exynos_tmu_initialize()
  thermal: exynos: use sanitize_temp_error() in exynos7_tmu_initialize()
  thermal: exynos: fix trips limit checking in get_th_reg()
  thermal: exynos: remove threshold_code checking from
    exynos4210_tmu_initialize()
  thermal: exynos: make ->tmu_initialize method void
  thermal: exynos: clear IRQs later in exynos4412_tmu_initialize()
  thermal: exynos: move IRQs clearing to exynos_tmu_initialize()
  thermal: exynos: add exynos*_tmu_set_[trip,hyst]() helpers
  thermal: exynos: do not use trips structure directly in
    ->tmu_initialize
  thermal: exynos: set trips in ascending order in
    exynos7_tmu_initialize()
  thermal: exynos: move trips setting to exynos_tmu_initialize()
  thermal: exynos: check return values of ->get_trip_[temp,hyst] methods
  thermal: exynos: cleanup code for enabling threshold interrupts
  thermal: exynos: remove unused defines for Exynos5433
  thermal: exynos: remove trip reporting to user-space

 drivers/thermal/samsung/exynos_tmu.c | 548 ++++++++++++++---------------------
 1 file changed, 215 insertions(+), 333 deletions(-)

-- 
1.9.1
