From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 1/3] exynos: config: Remove CONFIG_EXYNOS_THERMAL_CORE define
 (exynos_defconfig)
Date: Wed, 28 Jan 2015 16:28:38 +0100
Message-ID: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

After Exynos TMU rework to use device tree for configuration this flag
can be removed. It is not used anymore.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 3d0c5d6..3691a68 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -88,7 +88,6 @@ CONFIG_HWMON=y
 CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
-CONFIG_EXYNOS_THERMAL_CORE=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MFD_CROS_EC=y
-- 
2.0.0.rc2
