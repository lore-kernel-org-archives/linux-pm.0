From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>
Subject: [RFC 4/4] arm64: dts: rockchip: Set the display-subsystem devfreq
Date: Tue, 30 Apr 2019 14:05:24 -0400
Message-ID: <20190430180524.22710-5-gael.portay@collabora.com>
References: <20190430180524.22710-1-gael.portay@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430180524.22710-1-gael.portay@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Sandy Huang <hjc@rock-chips.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@collabora.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Lin Huang <hl@rock-chips.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org

Use the Dynamic Memory Controller as the display-subsystem's devfreq
device.

Signed-off-by: Gaël PORTAY <gael.portay@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 40e78186560b..a5cbbc08f7e1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -375,6 +375,10 @@
 		<200000000>;
 };
 
+&display_subsystem {
+	devfreq = <&dmc>;
+};
+
 &emmc_phy {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 87ee084fac89..253b476163fd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -155,7 +155,7 @@
 		};
 	};
 
-	display-subsystem {
+	display_subsystem: display-subsystem {
 		compatible = "rockchip,display-subsystem";
 		ports = <&vopl_out>, <&vopb_out>;
 	};
-- 
2.21.0
