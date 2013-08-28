From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH 0/3] thermal: samsung: Add TMU for Exynos5420
Date: Wed, 28 Aug 2013 11:15:16 +0530
Message-ID: <1377668719-8602-1-git-send-email-ch.naveen@samsung.com>
References: <1375336979-14747-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1375336979-14747-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, naveenkrishna.ch@gmail.com, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The below patchset adds the TMU support for Exynos5420
1. correct the fall interrupt en, status bit fields
  Fixes an existing bug in the register field access
2. Add TMU support for Exynos5420 SoCs
  Adds support for Exynos5420. (These changes were tested on a different
  kernel version)
3. Handle the misplaced TRIMINFO register
  Discussion was going on at https://lkml.org/lkml/2013/8/7/59
  Handles the misplaced register on Exynos5420 Only

Naveen Krishna Chatradhi (3):
  thermal: samsung: correct the fall interrupt en, status bit fields
  thermal: samsung: Add TMU support for Exynos5420 SoCs
  thermal: exynos: Handle the misplaced TRIMINFO register

 .../devicetree/bindings/thermal/exynos-thermal.txt |   21 +++++
 drivers/thermal/samsung/exynos_tmu.c               |   38 ++++++--
 drivers/thermal/samsung/exynos_tmu.h               |    3 +
 drivers/thermal/samsung/exynos_tmu_data.c          |   92 ++++++++++++++++++++
 drivers/thermal/samsung/exynos_tmu_data.h          |   10 ++-
 5 files changed, 158 insertions(+), 6 deletions(-)

-- 
1.7.9.5
