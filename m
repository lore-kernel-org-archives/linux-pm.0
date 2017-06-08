From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: Set THERMAL_WRITABLE_TRIPS=y for testing
Date: Thu, 8 Jun 2017 19:26:57 +0300
Message-ID: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2nam02on0067.outbound.protection.outlook.com ([104.47.38.67]:18976
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750919AbdFHQ1R (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jun 2017 12:27:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Bai Ping <ping.bai@nxp.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Setting trip points is supported by the imx thermal driver and it is
useful to be able to test this without adjusting config.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index bb6fa56..f7984a6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -204,6 +204,7 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_THERMAL=y
+CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
-- 
2.7.4
