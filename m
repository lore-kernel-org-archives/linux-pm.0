From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2] MAINTAINERS: Add entry for Maxim PMICs on Samsung boards
Date: Fri, 30 Jan 2015 11:10:35 +0100
Message-ID: <1422612635-5711-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42977 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbbA3KKs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 05:10:48 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Add myself and Chanwoo Choi as supporters to help in reviewing patches
for Maxim 77686 PMIC and Maxim 14577/77693 MUIC drivers:
 - mfd (all of them),
 - extcon (extcon-max14577.c, extcon-max77693.c),
 - regulator (all of them),
 - clock (clk-max77686.c),
 - RTC (rtc-max77686.c).

Lately I am the author of contributors to them. These drivers are used
on Exynos-based boards (Trats 2, Gear 1 and Gear 2).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>

---

Changes since v1:
1. Add also Chanwoo Choi as supporter on his request [1].
2. Move out chargers (power supply) to separate patch (applied already
   by Sebastian Reichel [2]). Patch is rebased on next which includes
   this.
3. Add acks from Mark Brown and Lee Jones.

[1] https://lkml.org/lkml/2015/1/16/571
[2] http://git.infradead.org/battery-2.6.git/commit/f8f847b51a0e1cb0c96e706d5da0ac507d96c605
---
 MAINTAINERS | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d7404add7ed..775a631118ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6191,6 +6191,26 @@ S:	Supported
 F:	drivers/power/max14577_charger.c
 F:	drivers/power/max77693_charger.c
 
+MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
+M:	Chanwoo Choi <cw00.choi@samsung.com>
+M:	Krzysztof Kozlowski <k.kozlowski@samsung.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/*/max14577.c
+F:	drivers/*/max77686.c
+F:	drivers/*/max77693.c
+F:	drivers/extcon/extcon-max14577.c
+F:	drivers/extcon/extcon-max77693.c
+F:	drivers/rtc/rtc-max77686.c
+F:	drivers/clk/clk-max77686.c
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

