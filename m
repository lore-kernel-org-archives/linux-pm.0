From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH 1/5] Documentation: bindings: add dt documentation for dfi controller
Date: Fri,  2 Sep 2016 06:31:21 +0800
Message-ID: <1472769085-20715-2-git-send-email-hl@rock-chips.com>
References: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472769085-20715-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, cw00.choi@samsung.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the documentation for rockchip dfi devfreq-event driver.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v8:
- delete a unuse blank line

Changes in v7:
- None

Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- None 

Changes in v1:
- None

 .../bindings/devfreq/event/rockchip-dfi.txt           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
new file mode 100644
index 0000000..d66aca6
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
@@ -0,0 +1,19 @@
+
+* Rockchip rk3399 DFI device
+
+Required properties:
+- compatible: Must be "rockchip,rk3399-dfi".
+- reg: physical base address of each DFI and length of memory mapped region
+- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
+- clocks: phandles for clock specified in "clock-names" property
+- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
+
+Example:
+	dfi: dfi@0xff630000 {
+		reg = <0x00 0xff630000 0x00 0x4000>;
+		compatible = "rockchip,rk3399-dfi";
+		rockchip,pmu = <&pmugrf>;
+		clocks = <&cru PCLK_DDR_MON>;
+		clock-names = "pclk_ddr_mon";
+		status = "disabled";
+	};
-- 
2.6.6
