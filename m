From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Subject: [PATCH v11 0/4] thermal: samsung: Clean up and add support for
 Exynos5420
Date: Tue, 10 Dec 2013 12:10:40 +0530
Message-ID: <1386657640-21481-1-git-send-email-ch.naveen@samsung.com>
References: <1384238132-24515-1-git-send-email-ch.naveen@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1384238132-24515-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com, t.figa@samsung.com
List-Id: linux-pm@vger.kernel.org

This patchset does a little clean up of the existing code (linux-soc-thermal)
1.  [v11] thermal: samsung: replace inten_ bit fields with intclr_
2.  [v11] thermal: samsung: change base_common to more meaningful base_second

adds support for Exynos5420 in the driver and (linux-soc-thermal)
3.  [v11] thermal: samsung: Add TMU support for Exynos5420 SoCs
also adds the device tree nodes for the same to exynos5420.dtsi (linux-samsung.git)
4.  [v11] ARM: dts: Exynos5420: Add device nodes for TMU blocks

(linux-soc-thermal)
Naveen Krishna Chatradhi (3):
  thermal: samsung: replace inten_ bit fields with intclr_
  thermal: samsung: change base_common to more meaningful base_second
  thermal: samsung: Add TMU support for Exynos5420 SoCs

 .../devicetree/bindings/thermal/exynos-thermal.txt |   42 ++++++-
 drivers/thermal/samsung/exynos_tmu.c               |   72 +++++++++---
 drivers/thermal/samsung/exynos_tmu.h               |   21 ++--
 drivers/thermal/samsung/exynos_tmu_data.c          |  119 ++++++++++++++++++--
 drivers/thermal/samsung/exynos_tmu_data.h          |   12 +-
 5 files changed, 228 insertions(+), 38 deletions(-)

(linux-samsung.git)
Naveen Krishna Chatradhi (1):
  ARM: dts: Exynos5420: Add device nodes for TMU blocks

 arch/arm/boot/dts/exynos5420.dtsi |   40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
-- 
1.7.10.4
