From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 3/3] exynos: config: Enable support for cpufreq on Exynos SoCs
 (exynos_defconfig)
Date: Wed, 28 Jan 2015 16:28:40 +0100
Message-ID: <1422458920-14555-3-git-send-email-l.majewski@samsung.com>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This commit enables the cpufreq subsystem. Moreover, support for using
CPU as a cooling device is provided.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 376dbf4..d6be7e8 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -86,6 +86,8 @@ CONFIG_BATTERY_SBS=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_HWMON=y
 CONFIG_SENSORS_LM90=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_THERMAL=y
 CONFIG_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
-- 
2.0.0.rc2
