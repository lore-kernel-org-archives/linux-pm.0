From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/3] arm64: defconfig: add allwinner sid support
Date: Sun, 12 May 2019 04:26:12 -0400
Message-ID: <20190512082614.9045-2-tiny.windzz@gmail.com>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512082614.9045-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com, rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com, paulmck@linux.ibm.com, andy.gross@linaro.org, olof@lixom.net, bjorn.andersson@linaro.org, jagan@amarulasolutions.com, marc.w.gonzalez@free.fr, stefan.wahren@i2se.com, enric.balletbo@collabora.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sid contains speedbin information and temperature sensor
calibration information and more, which are important for SOC.

This patch enables CONFIG_NVMEM_SUNXI_SID by default.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..8c23dd60f906 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -736,6 +736,7 @@ CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_HISI_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_UNIPHIER_EFUSE=y
-- 
2.17.0
