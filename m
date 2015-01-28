From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 2/3] exynos: config: Enable thermal emulation for Exynos TMU
 (exynos_defconfig)
Date: Wed, 28 Jan 2015 16:28:39 +0100
Message-ID: <1422458920-14555-2-git-send-email-l.majewski@samsung.com>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:28397 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbbA2BkE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jan 2015 20:40:04 -0500
In-reply-to: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Enabling thermal emulation on Exynos SoCs. New sysfs attribute - emul_temp
is created.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 3691a68..376dbf4 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -88,6 +88,7 @@ CONFIG_HWMON=y
 CONFIG_SENSORS_LM90=y
 CONFIG_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_THERMAL_EMULATION=y
 CONFIG_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MFD_CROS_EC=y
-- 
2.0.0.rc2

