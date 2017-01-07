From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v1.1] ARM: multi_v7_defconfig: Enable power sequence for Odroid U3
Date: Sat,  7 Jan 2017 11:16:51 +0200
Message-ID: <20170107091651.10560-1-krzk@kernel.org>
References: <20170107085203.4431-5-krzk@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932214AbdAGJRS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Jan 2017 04:17:18 -0500
In-Reply-To: <20170107085203.4431-5-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, hverkuil@xs4all.nl, Markus Reichl <m.reichl@fivetechno.de>

Odroid U3 needs a power sequence for lan9730, if it was enabled by
bootloader.  Also enable the USB3503 HSCI to USB2.0 driver (device
is present on Odroid U3).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1 (v1 -> v1.1):
1. Enable also usb3503 driver.
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index b01a43851294..8cc73e084b25 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -443,6 +443,7 @@ CONFIG_POWER_RESET_RMOBILE=y
 CONFIG_POWER_RESET_ST=y
 CONFIG_POWER_AVS=y
 CONFIG_ROCKCHIP_IODOMAIN=y
+CONFIG_PWRSEQ_GENERIC=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_LM95245=y
@@ -686,6 +687,7 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_HSIC_USB3503=m
 CONFIG_AB8500_USB=y
 CONFIG_KEYSTONE_USB_PHY=y
 CONFIG_OMAP_USB3=y
-- 
2.9.3

