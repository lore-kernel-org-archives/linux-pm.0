From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/4] ARM: exynos_defconfig: Enable power sequence for Odroid U3
Date: Sat,  7 Jan 2017 10:52:02 +0200
Message-ID: <20170107085203.4431-4-krzk@kernel.org>
References: <20170107085203.4431-1-krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170107085203.4431-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, hverkuil@xs4all.nl, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Odroid U3 needs a power sequence for lan9730, if it was enabled by
bootloader.  Enable also GPIO_SYSFS which is useful for playing with
GPIO during debug process.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/exynos_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 79c415c33f69..ad1a509c296a 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -99,6 +99,7 @@ CONFIG_SPI=y
 CONFIG_SPI_GPIO=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_DEBUG_GPIO=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_WM8994=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_BATTERY_SBS=y
@@ -108,6 +109,7 @@ CONFIG_CHARGER_MAX14577=y
 CONFIG_CHARGER_MAX77693=y
 CONFIG_CHARGER_MAX8997=y
 CONFIG_CHARGER_TPS65090=y
+CONFIG_PWRSEQ_GENERIC=y
 CONFIG_SENSORS_LM90=y
 CONFIG_SENSORS_NTC_THERMISTOR=y
 CONFIG_SENSORS_PWM_FAN=y
-- 
2.9.3
