From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 4/6] dt-bindings: devfreq: rk3399_dmc: move interrupts to be optional.
Date: Wed,  9 May 2018 14:57:46 +0200
Message-ID: <20180509125749.31318-5-enric.balletbo@collabora.com>
References: <20180509125749.31318-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180509125749.31318-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org, kernel@collabora.com, hl@rock-chips.com, Chanwoo Choi <cw00.choi@samsung.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

In ATF we already wait for DDR DVFS finish, so move the interrupts properties
to be optional.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4:
- [4/6] Add Reviewed-by Rob Herring.

Changes in v3:
- [4/6] Move interrupts to be optional instead of remove.

Changes in v2:
- [4/6] Add Reviewed-by Chanwoo Choi.

 .../devicetree/bindings/devfreq/rk3399_dmc.txt         | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
index e0030a139383..0ec68141f85a 100644
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
@@ -17,6 +13,12 @@ Required properties:
 - center-supply:	 DMC supply node.
 - status:		 Marks the node enabled/disabled.
 
+Optional properties:
+- interrupts:		 The CPU interrupt number. The interrupt specifier
+			 format depends on the interrupt controller.
+			 It should be a DCF interrupt. When DDR DVFS finishes
+			 a DCF interrupt is triggered.
+
 Following properties relate to DDR timing:
 
 - rockchip,dram_speed_bin :	  Value reference include/dt-bindings/clock/rk3399-ddr.h,
-- 
2.17.0
