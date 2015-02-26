From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v6 2/6] ARM: dts: Add pwm-fan node to the Odroid-U3 board
Date: Thu, 26 Feb 2015 14:59:33 +0100
Message-ID: <1424959177-28739-3-git-send-email-l.majewski@samsung.com>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424959177-28739-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1424959177-28739-1-git-send-email-l.majewski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Kamil Debski <k.debski@samsung.com>

Add pwm-fan node to the Odroid-U3 board file to enable PWM control of the
cooling fan. In addition, add the "pwm" label to the pwm@139D0000 node
in the exynos4412.dtsi.

Signed-off-by: Kamil Debski <k.debski@samsung.com>
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes since v1:
- added pwm label to the pwm@139D0000 node in exynos4.dtsi
- use the pwm label in the exynos4412-odroidu3.dts
- change order or properties in the pwn-fan node, to be sorted
  in alphabetical order
Changes for v5:
- Adding Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
- status = "okay"; dropped from the patch
Changes for v6:
- None

---
 arch/arm/boot/dts/exynos4.dtsi            |  2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 690f56c..a93f5ca5 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -599,7 +599,7 @@
 		status = "disabled";
 	};
 
-	pwm@139D0000 {
+	pwm: pwm@139D0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x139D0000 0x1000>;
 		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
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
