From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 4/6] dt-bindings: devfreq: rk3399_dmc: remove interrupts as is not required.
Date: Thu, 19 Apr 2018 12:40:17 +0200
Message-ID: <20180419104019.24406-5-enric.balletbo@collabora.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419104019.24406-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, dianders@google.com, groek@google.com, kernel@collabora.com, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

In ATF we already wait for DDR dvfs finish, so don't need to do this in
kernel, so remove the interrupts properties as is not longer required.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index d83ef821d282..e5307155e901 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
@@ -5,10 +5,6 @@ Required properties:
 - devfreq-events:	 Node to get DDR loading, Refer to
 			 Documentation/devicetree/bindings/devfreq/event/
 			 rockchip-dfi.txt
-- interrupts:		 The CPU interrupt number. The interrupt specifier
-			 format depends on the interrupt controller.
-			 It should be a DCF interrupt. When DDR DVFS finishes
-			 a DCF interrupt is triggered.
 - clocks:		 Phandles for clock specified in "clock-names" property
 - clock-names :		 The name of clock used by the DFI, must be
 			 "pclk_ddr_mon";
@@ -172,7 +168,6 @@ Example:
 	dmc: dmc {
 		compatible = "rockchip,rk3399-dmc";
 		devfreq-events = <&dfi>;
-		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru SCLK_DDRCLK>;
 		clock-names = "dmc_clk";
 		operating-points-v2 = <&dmc_opp_table>;
-- 
2.17.0
