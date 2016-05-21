From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 3/5] ARM: dts: rockchip: move rk3288 io-domain nodes to the grf
Date: Sat, 21 May 2016 15:40:52 +0200
Message-ID: <3043390.x2mOUff8Ni@phil>
References: <1459432126-6395-1-git-send-email-heiko@sntech.de> <1459432126-6395-4-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36179 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbcEUNlD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2016 09:41:03 -0400
In-Reply-To: <1459432126-6395-4-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: khilman@kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Am Donnerstag, 31. M=E4rz 2016, 15:48:44 schrieb Heiko Stuebner:
> io-voltage control is actually part of the grf, so move the node unde=
r the
> newly available grf simple-mfd.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 4.8, but adapted slightly to have the core io-domain nodes =
centrally in the rk3288.dtsi:

----- 8< -----
=46rom: Heiko Stuebner <heiko@sntech.de>
Date: Sat, 21 May 2016 01:36:17 +0200
Subject: [PATCH v2.1 3/5] ARM: dts: rockchip: move rk3288 io-domain nod=
es to the grf

io-voltage control is actually part of the grf, so move the node under =
the
newly available grf simple-mfd.

To minimize duplicate code, the core node and compatible property
gets placed in the core rk3288.dtsi while the individual boards
now only need to enable it and add the necessary supply properties.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi   | 31 +++++++++++++++----------=
------
 arch/arm/boot/dts/rk3288-miqi.dts       | 26 +++++++++++++------------=
-
 arch/arm/boot/dts/rk3288-popmetal.dts   | 31 +++++++++++++++----------=
------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi | 31 +++++++++++++++----------=
------
 arch/arm/boot/dts/rk3288-veyron.dtsi    | 25 ++++++++++++-------------
 arch/arm/boot/dts/rk3288.dtsi           |  5 +++++
 6 files changed, 75 insertions(+), 74 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/=
rk3288-firefly.dtsi
index d6cf9ad..114c90fb 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -64,22 +64,6 @@
 		clock-output-names =3D "ext_gmac";
 	};
=20
-	io_domains: io-domains {
-		compatible =3D "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf =3D <&grf>;
-
-		audio-supply =3D <&vcca_33>;
-		bb-supply =3D <&vcc_io>;
-		dvp-supply =3D <&dovdd_1v8>;
-		flash0-supply =3D <&vcc_flash>;
-		flash1-supply =3D <&vcc_lan>;
-		gpio30-supply =3D <&vcc_io>;
-		gpio1830-supply =3D <&vcc_io>;
-		lcdc-supply =3D <&vcc_io>;
-		sdcard-supply =3D <&vccio_sd>;
-		wifi-supply =3D <&vccio_wl>;
-	};
-
 	ir: ir-receiver {
 		compatible =3D "gpio-ir-receiver";
 		pinctrl-names =3D "default";
@@ -397,6 +381,21 @@
 	status =3D "okay";
 };
=20
+&io_domains {
+	status =3D "okay";
+
+	audio-supply =3D <&vcca_33>;
+	bb-supply =3D <&vcc_io>;
+	dvp-supply =3D <&dovdd_1v8>;
+	flash0-supply =3D <&vcc_flash>;
+	flash1-supply =3D <&vcc_lan>;
+	gpio30-supply =3D <&vcc_io>;
+	gpio1830-supply =3D <&vcc_io>;
+	lcdc-supply =3D <&vcc_io>;
+	sdcard-supply =3D <&vccio_sd>;
+	wifi-supply =3D <&vccio_wl>;
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk32=
88-miqi.dts
index 8643103..2448842 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -64,19 +64,6 @@
 		clock-output-names =3D "ext_gmac";
 	};
=20
-	io_domains: io-domains {
-		compatible =3D "rockchip,rk3288-io-voltage-domain";
-
-		audio-supply =3D <&vcca_33>;
-		flash0-supply =3D <&vcc_flash>;
-		flash1-supply =3D <&vcc_lan>;
-		gpio30-supply =3D <&vcc_io>;
-		gpio1830-supply =3D <&vcc_io>;
-		lcdc-supply =3D <&vcc_io>;
-		sdcard-supply =3D <&vccio_sd>;
-		wifi-supply =3D <&vcc_18>;
-	};
-
 	leds {
 		compatible =3D "gpio-leds";
=20
@@ -321,6 +308,19 @@
 	status =3D "okay";
 };
=20
+&io_domains {
+	status =3D "okay";
+
+	audio-supply =3D <&vcca_33>;
+	flash0-supply =3D <&vcc_flash>;
+	flash1-supply =3D <&vcc_lan>;
+	gpio30-supply =3D <&vcc_io>;
+	gpio1830-supply =3D <&vcc_io>;
+	lcdc-supply =3D <&vcc_io>;
+	sdcard-supply =3D <&vccio_sd>;
+	wifi-supply =3D <&vcc_18>;
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/=
rk3288-popmetal.dts
index 720717b..dda8d25 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -77,22 +77,6 @@
 		};
 	};
=20
-	io_domains: io-domains {
-		compatible =3D "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf =3D <&grf>;
-
-		audio-supply =3D <&vcca_33>;
-		bb-supply =3D <&vcc_io>;
-		dvp-supply =3D <&vcc18_dvp>;
-		flash0-supply =3D <&vcc_flash>;
-		flash1-supply =3D <&vcc_lan>;
-		gpio30-supply =3D <&vcc_io>;
-		gpio1830-supply =3D <&vcc_io>;
-		lcdc-supply =3D <&vcc_io>;
-		sdcard-supply =3D <&vccio_sd>;
-		wifi-supply =3D <&vccio_wl>;
-	};
-
 	ir: ir-receiver {
 		compatible =3D "gpio-ir-receiver";
 		gpios =3D <&gpio0 6 GPIO_ACTIVE_LOW>;
@@ -437,6 +421,21 @@
 	status =3D "okay";
 };
=20
+&io_domains {
+	status =3D "okay";
+
+	audio-supply =3D <&vcca_33>;
+	bb-supply =3D <&vcc_io>;
+	dvp-supply =3D <&vcc18_dvp>;
+	flash0-supply =3D <&vcc_flash>;
+	flash1-supply =3D <&vcc_lan>;
+	gpio30-supply =3D <&vcc_io>;
+	gpio1830-supply =3D <&vcc_io>;
+	lcdc-supply =3D <&vcc_io>;
+	sdcard-supply =3D <&vccio_sd>;
+	wifi-supply =3D <&vccio_wl>;
+};
+
 &pinctrl {
 	ak8963 {
 		comp_int: comp-int {
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dt=
s/rk3288-rock2-som.dtsi
index e1ee9f9..bb1f01e 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -61,22 +61,6 @@
 		clock-output-names =3D "ext_gmac";
 	};
=20
-	io_domains: io-domains {
-		compatible =3D "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf =3D <&grf>;
-
-		audio-supply =3D <&vcc_io>;
-		bb-supply =3D <&vcc_io>;
-		dvp-supply =3D <&vcc_18>;
-		flash0-supply =3D <&vcc_flash>;
-		flash1-supply =3D <&vccio_pmu>;
-		gpio30-supply =3D <&vccio_pmu>;
-		gpio1830 =3D <&vcc_io>;
-		lcdc-supply =3D <&vcc_io>;
-		sdcard-supply =3D <&vccio_sd>;
-		wifi-supply =3D <&vcc_18>;
-	};
-
 	vcc_flash: flash-regulator {
 		compatible =3D "regulator-fixed";
 		regulator-name =3D "vcc_sys";
@@ -259,6 +243,21 @@
 	};
 };
=20
+&io_domains {
+	status =3D "okay";
+
+	audio-supply =3D <&vcc_io>;
+	bb-supply =3D <&vcc_io>;
+	dvp-supply =3D <&vcc_18>;
+	flash0-supply =3D <&vcc_flash>;
+	flash1-supply =3D <&vccio_pmu>;
+	gpio30-supply =3D <&vccio_pmu>;
+	gpio1830 =3D <&vcc_io>;
+	lcdc-supply =3D <&vcc_io>;
+	sdcard-supply =3D <&vccio_sd>;
+	wifi-supply =3D <&vcc_18>;
+};
+
 &pinctrl {
 	pcfg_output_high: pcfg-output-high {
 		output-high;
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/r=
k3288-veyron.dtsi
index 5e4c690..3dd2cca 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -83,19 +83,6 @@
 		reset-gpios =3D <&gpio2 9 GPIO_ACTIVE_HIGH>;
 	};
=20
-	io_domains: io-domains {
-		compatible =3D "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf =3D <&grf>;
-
-		bb-supply =3D <&vcc33_io>;
-		dvp-supply =3D <&vcc_18>;
-		flash0-supply =3D <&vcc18_flashio>;
-		gpio1830-supply =3D <&vcc33_io>;
-		gpio30-supply =3D <&vcc33_io>;
-		lcdc-supply =3D <&vcc33_lcd>;
-		wifi-supply =3D <&vcc18_wl>;
-	};
-
 	sdio_pwrseq: sdio-pwrseq {
 		compatible =3D "mmc-pwrseq-simple";
 		clocks =3D <&rk808 RK808_CLKOUT1>;
@@ -355,6 +342,18 @@
 	i2c-scl-rising-time-ns =3D <1000>;
 };
=20
+&io_domains {
+	status =3D "okay";
+
+	bb-supply =3D <&vcc33_io>;
+	dvp-supply =3D <&vcc_18>;
+	flash0-supply =3D <&vcc18_flashio>;
+	gpio1830-supply =3D <&vcc33_io>;
+	gpio30-supply =3D <&vcc33_io>;
+	lcdc-supply =3D <&vcc33_lcd>;
+	wifi-supply =3D <&vcc18_wl>;
+};
+
 &pwm1 {
 	status =3D "okay";
 };
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.d=
tsi
index 3b44ef3..7fa932f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -826,6 +826,11 @@
 			#phy-cells =3D <0>;
 			status =3D "disabled";
 		};
+
+		io_domains: io-domains {
+			compatible =3D "rockchip,rk3288-io-voltage-domain";
+			status =3D "disabled";
+		};
 	};
=20
 	wdt: watchdog@ff800000 {
--=20
2.6.4

----- 8< -----

