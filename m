From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/5] ARM: dts: rockchip: move rk3288 io-domain nodes to the grf
Date: Fri,  5 Feb 2016 22:20:16 +0100
Message-ID: <1454707218-23676-4-git-send-email-heiko@sntech.de>
References: <1454707218-23676-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:60372 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089AbcBEVUb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Feb 2016 16:20:31 -0500
In-Reply-To: <1454707218-23676-1-git-send-email-heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org
Cc: linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, sjoerd.simons@collabora.co.uk, dianders@chromium.org, david.wu@rock-chips.com, Heiko Stuebner <heiko@sntech.de>

io-voltage control is actually part of the grf, so move the node under the
newly available grf simple-mfd.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi   | 33 ++++++++++++++++----------------
 arch/arm/boot/dts/rk3288-popmetal.dts   | 34 +++++++++++++++++----------------
 arch/arm/boot/dts/rk3288-rock2-som.dtsi | 34 +++++++++++++++++----------------
 arch/arm/boot/dts/rk3288-veyron.dtsi    | 28 ++++++++++++++-------------
 4 files changed, 68 insertions(+), 61 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 49ec20d..f219389 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -63,22 +63,6 @@
 		clock-output-names = "ext_gmac";
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcca_33>;
-		bb-supply = <&vcc_io>;
-		dvp-supply = <&dovdd_1v8>;
-		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vcc_lan>;
-		gpio30-supply = <&vcc_io>;
-		gpio1830-supply = <&vcc_io>;
-		lcdc-supply = <&vcc_io>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vccio_wl>;
-	};
-
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		pinctrl-names = "default";
@@ -237,6 +221,23 @@
 	status = "ok";
 };
 
+&grf {
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+
+		audio-supply = <&vcca_33>;
+		bb-supply = <&vcc_io>;
+		dvp-supply = <&dovdd_1v8>;
+		flash0-supply = <&vcc_flash>;
+		flash1-supply = <&vcc_lan>;
+		gpio30-supply = <&vcc_io>;
+		gpio1830-supply = <&vcc_io>;
+		lcdc-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vccio_wl>;
+	};
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 65c4756..4d434f7 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -79,22 +79,6 @@
 		};
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcca_33>;
-		bb-supply = <&vcc_io>;
-		dvp-supply = <&vcc18_dvp>;
-		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vcc_lan>;
-		gpio30-supply = <&vcc_io>;
-		gpio1830-supply = <&vcc_io>;
-		lcdc-supply = <&vcc_io>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vccio_wl>;
-	};
-
 	ir: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
@@ -205,6 +189,24 @@
 	status = "ok";
 };
 
+&grf {
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		audio-supply = <&vcca_33>;
+		bb-supply = <&vcc_io>;
+		dvp-supply = <&vcc18_dvp>;
+		flash0-supply = <&vcc_flash>;
+		flash1-supply = <&vcc_lan>;
+		gpio30-supply = <&vcc_io>;
+		gpio1830-supply = <&vcc_io>;
+		lcdc-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vccio_wl>;
+	};
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3288-rock2-som.dtsi b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
index e1ee9f9..8660b8a 100644
--- a/arch/arm/boot/dts/rk3288-rock2-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-rock2-som.dtsi
@@ -61,22 +61,6 @@
 		clock-output-names = "ext_gmac";
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		audio-supply = <&vcc_io>;
-		bb-supply = <&vcc_io>;
-		dvp-supply = <&vcc_18>;
-		flash0-supply = <&vcc_flash>;
-		flash1-supply = <&vccio_pmu>;
-		gpio30-supply = <&vccio_pmu>;
-		gpio1830 = <&vcc_io>;
-		lcdc-supply = <&vcc_io>;
-		sdcard-supply = <&vccio_sd>;
-		wifi-supply = <&vcc_18>;
-	};
-
 	vcc_flash: flash-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_sys";
@@ -129,6 +113,24 @@
 	tx_delay = <0x30>;
 };
 
+&grf {
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		audio-supply = <&vcc_io>;
+		bb-supply = <&vcc_io>;
+		dvp-supply = <&vcc_18>;
+		flash0-supply = <&vcc_flash>;
+		flash1-supply = <&vccio_pmu>;
+		gpio30-supply = <&vccio_pmu>;
+		gpio1830 = <&vcc_io>;
+		lcdc-supply = <&vcc_io>;
+		sdcard-supply = <&vccio_sd>;
+		wifi-supply = <&vcc_18>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index 0a43e21..fd55697 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -83,19 +83,6 @@
 		reset-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
 	};
 
-	io_domains: io-domains {
-		compatible = "rockchip,rk3288-io-voltage-domain";
-		rockchip,grf = <&grf>;
-
-		bb-supply = <&vcc33_io>;
-		dvp-supply = <&vcc_18>;
-		flash0-supply = <&vcc18_flashio>;
-		gpio1830-supply = <&vcc33_io>;
-		gpio30-supply = <&vcc33_io>;
-		lcdc-supply = <&vcc33_lcd>;
-		wifi-supply = <&vcc18_wl>;
-	};
-
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&rk808 RK808_CLKOUT1>;
@@ -159,6 +146,21 @@
 	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
 };
 
+&grf {
+	io_domains: io-domains {
+		compatible = "rockchip,rk3288-io-voltage-domain";
+		rockchip,grf = <&grf>;
+
+		bb-supply = <&vcc33_io>;
+		dvp-supply = <&vcc_18>;
+		flash0-supply = <&vcc18_flashio>;
+		gpio1830-supply = <&vcc33_io>;
+		gpio30-supply = <&vcc33_io>;
+		lcdc-supply = <&vcc33_lcd>;
+		wifi-supply = <&vcc18_wl>;
+	};
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
-- 
2.6.4

