From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH RESEND v6 2/3] ARM: dts: Add pwm-fan node to the Odroid-U3 board
Date: Tue, 11 Aug 2015 15:14:59 +0200
Message-ID: <1439298899-17645-1-git-send-email-l.majewski@samsung.com>
References: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:43141 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934136AbbHKNPL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 09:15:11 -0400
In-reply-to: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>

From: Kamil Debski <k.debski@samsung.com>

Add pwm-fan node to the Odroid-U3 board file to enable PWM control of the
cooling fan. In addition, add the "pwm" label to the pwm@139D0000 node
in the exynos4412.dtsi.

Signed-off-by: Kamil Debski <k.debski@samsung.com>
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 44684e5..4c04837 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -31,6 +31,18 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 0 10000 0>;
+	};
+};
+
+&pwm {
+	pinctrl-0 = <&pwm0_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <0>;
+	status = "okay";
 };
 
 &usb3503 {
-- 
2.0.0.rc2

