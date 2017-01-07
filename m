From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] ARM: dts: exynos: Fix LAN9730 on Odroid U3 after tftpboot
Date: Sat,  7 Jan 2017 10:52:01 +0200
Message-ID: <20170107085203.4431-3-krzk@kernel.org>
References: <20170107085203.4431-1-krzk@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170107085203.4431-1-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Anand Moon <linux.amoon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Markus Reichl <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The ethernet adapter LAN9730, after enabling in bootloader (e.g. for
tftpboot) requires reset during boot.  Otherwise it won't come up.

The schematics of Odroid U3 are detailed enough but after grabbing
knowledge also from other sources (like U-Boot) the overall design looks
like:
1. LAN9730 is connected to HSIC0 and USB3503 to HSIC1 of EHCI controller.
2. USB3503 comes with its own reset pin: gpx3-5.
3. Reset pin of LAN9730 is pulled up to 3.3 V so it cannot be used.
4. The supply of 3.3 V for LAN9730 is delivered from buck8.
5. Buck8 state is a logical OR of registry value (through I2C command)
   and ENB8 pin.  The ENB8, not described in schematics, is in fact
   gpa1-1.
6. Missing or wrongly timed reset of LAN9730 might result in missing of
   two devices: LAN9730 and USB3503. Without reset, LAN9730 will not
   come up, if it was enabled by bootloader.

To fix the issue use the generic power sequence driver and toggle the
ENB8 (buck8) pin.  Reset duration of 500 us was chosen by experiments
(shortest working time was 400 us).  This is an easiest way to fix the
long standing LAN9730 reset issue.

Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 99634c54dca9..aef49007cba0 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -84,10 +84,23 @@
 	regulator-max-microvolt = <2800000>;
 };
 
+&max77686 {
+	pinctrl-0 = <&max77686_irq &max77686_enb8>;
+};
+
 &mshc_0 {
 	vqmmc-supply = <&ldo22_reg>;
 };
 
+&pinctrl_0 {
+	max77686_enb8: max77686-enb8 {
+		samsung,pins = "gpa1-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+};
+
 &pwm {
 	pinctrl-0 = <&pwm0_out>;
 	pinctrl-names = "default";
@@ -103,7 +116,15 @@
 
 &ehci {
 	port@1 {
+		/* HSIC for LAN9730 */
 		status = "okay";
+		/* buck8 enable pin, use it for power sequence */
+		reset-gpios = <&gpa1 1 GPIO_ACTIVE_LOW>;
+		/*
+		 * Reset duration of 500 us was chosen experimentally.
+		 * Minimal working value was 400 us. Add some safe margin.
+		 */
+		reset-duration-us = <500>;
 	};
 	port@2 {
 		status = "okay";
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
