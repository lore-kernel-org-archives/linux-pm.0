From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [PATCH v4 4/5] arm64: dts: rk3399: Add dfi and dmc nodes.
Date: Mon, 15 Apr 2019 17:29:47 -0400
Message-ID: <20190415212948.7736-5-gael.portay@collabora.com>
References: <20190415212948.7736-1-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415212948.7736-1-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lin Huang <hl@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Derek Basehore <dbasehore@chromium.org>, Randy Li <ayaka@soulik.info>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
List-Id: linux-pm@vger.kernel.org

From: Lin Huang <hl@rock-chips.com>

These are required to support DDR DVFS on rk3399 platform.

Signed-off-by: Lin Huang <hl@rock-chips.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---

Changes in v4:
- [PATCH v3 4/5] Remove board related DDR settings.

Changes in v3: None

Changes in v2:
- [PATCH 7/8] Reword the commit message to reflect the removal of
              rk3390-dram-default-timing.dts in v1.

Changes in v1:
- [RFC 8/10] Move rk3399-dram.h to dt-includes.
- [RFC 8/10] Put sdram default values under the dmc node.
- [RFC 8/10] Removed rk3399-dram-default-timing.dts

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index db9d948c0b03..87ee084fac89 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1885,6 +1885,25 @@
 		status = "disabled";
 	};
 
+	dfi: dfi@ff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
+
+	dmc: dmc {
+		compatible = "rockchip,rk3399-dmc";
+		rockchip,pmu = <&pmugrf>;
+		devfreq-events = <&dfi>;
+		clocks = <&cru SCLK_DDRC>;
+		clock-names = "dmc_clk";
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.21.0
