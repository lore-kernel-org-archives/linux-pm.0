From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v2 5/5] arm64: dts: rockchip: Enable dmc and dfi nodes on gru.
Date: Tue, 19 Mar 2019 14:13:23 -0400
Message-ID: <20190319181323.22804-6-gael.portay@collabora.com>
References: <20190319181323.22804-1-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319181323.22804-1-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@collabora.com, =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
List-Id: linux-pm@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

Enable the DMC (Dynamic Memory Controller) and the DFI (DDR PHY Interface)
nodes on gru/kevin boards so we can support DDR DVFS.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---

Changes in v2:
- [PATCH 8/8] Move center-supply attribute of dmc node in file
              rk3399-gru-chromebook.dtsi (where ppvar_centerlogic is
	      defined).

Changes in v1: None

 .../dts/rockchip/rk3399-gru-chromebook.dtsi   |  4 ++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 20 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      |  2 +-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
index 931640e9aed4..cfb81356c61e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
@@ -400,3 +400,7 @@ ap_i2c_tp: &i2c5 {
 		rockchip,pins = <0 8 RK_FUNC_GPIO &pcfg_pull_none>;
 	};
 };
+
+&dmc {
+	center-supply = <&ppvar_centerlogic>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index da03fa9c5662..d14dce679e7a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -289,6 +289,12 @@
 	status = "okay";
 };
 
+&dmc_opp_table {
+	opp04 {
+		opp-suspend;
+	};
+};
+
 /*
  * Set some suspend operating points to avoid OVP in suspend
  *
@@ -368,6 +374,10 @@
 		<200000000>;
 };
 
+&display_subsystem {
+	devfreq = <&dmc>;
+};
+
 &emmc_phy {
 	status = "okay";
 };
@@ -489,6 +499,16 @@ ap_i2c_audio: &i2c8 {
 	status = "okay";
 };
 
+&dfi {
+	status = "okay";
+};
+
+&dmc {
+	status = "okay";
+	upthreshold = <25>;
+	downdifferential = <15>;
+};
+
 &sdhci {
 	/*
 	 * Signal integrity isn't great at 200 MHz and 150 MHz (DDR) gives the
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8fe86a3e7658..010b3e5267a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -156,7 +156,7 @@
 		};
 	};
 
-	display-subsystem {
+	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
 	};
-- 
2.21.0
