From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] MAINTAINERS: Add entry for Maxim PMIC-s on Samsung boards
Date: Fri, 16 Jan 2015 12:19:50 +0100
Message-ID: <1421407190-6771-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>
List-Id: linux-pm@vger.kernel.org

Add myself as supporter for Maxim 77686 PMIC and Maxim 14577/77693 MUIC
drivers:
 - mfd (all of them),
 - extcon (extcon-max14577, extcon-max77693)
 - power (max14577_charger.c, 77693 on LKML [1]),
 - regulator (all of them),
 - clock (clk-max77686.c)
 - RTC (rtc-max77686.c).

Lately I am the author of major contributors to them. These
drivers are used on Exynos-based boards (Trats 2, Gear 1 and Gear 2).

[1] https://lkml.org/lkml/2015/1/5/139

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
---
 MAINTAINERS | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f017a30eb280..b033fb499186 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6143,6 +6143,21 @@ F:	Documentation/devicetree/bindings/i2c/max6697.txt
 F:	drivers/hwmon/max6697.c
 F:	include/linux/platform_data/max6697.h
 
+MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
+M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/*/*max14577*.c
+F:	drivers/*/*max77686*.c
+F:	drivers/*/*max77693*.c
+F:	Documentation/devicetree/bindings/mfd/max14577.txt
+F:	Documentation/devicetree/bindings/mfd/max77686.txt
+F:	Documentation/devicetree/bindings/mfd/max77693.txt
+F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
+F:	include/linux/mfd/max14577*.h
+F:	include/linux/mfd/max77686*.h
+F:	include/linux/mfd/max77693*.h
+
 MAXIRADIO FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
1.9.1
