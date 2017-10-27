From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v9 4/7] arm64: dts: rockchip: Move PCIe WAKE# irq to pcie driver for Gru
Date: Fri, 27 Oct 2017 15:17:36 +0800
Message-ID: <20171027071739.21927-5-jeffy.chen@rock-chips.com>
References: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171027071739.21927-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, bhelgaas@google.com
Cc: linux-pm@vger.kernel.org, tony@atomide.com, shawn.lin@rock-chips.com, briannorris@chromium.org, rjw@rjwysocki.net, dianders@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Matthias Kaehlcke <mka@chromium.org>, Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Caesar Wang <wxt@rock-chips.com>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-pm@vger.kernel.org

Currently we are handling PCIe WAKE# irq in mrvl wifi driver.

Move it to rockchip pcie driver since we are going to handle it in the
pci core.

Also avoid this irq been considered as the PCI interrupt pin in the
of_irq_parse_pci().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v9:
Rewrite the commit message.

Changes in v8:
Rewrite the commit message.

Changes in v7: None
Changes in v6: None
Changes in v5:
Use "wakeup" instead of "wake"

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index 5772c52fbfd3..8e37da69f693 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -708,7 +708,15 @@ ap_i2c_audio: &i2c8 {
 
 	ep-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wifi_perst_l>;
+	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wlan_host_wake_l>, <&wifi_perst_l>;
+
+	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "sys", "legacy", "client", "wakeup";
+	/delete-property/ interrupts;
+
 	vpcie3v3-supply = <&pp3300_wifi_bt>;
 	vpcie1v8-supply = <&wlan_pd_n>; /* HACK: see &wlan_pd_n */
 	vpcie0v9-supply = <&pp900_pcie>;
@@ -723,11 +731,6 @@ ap_i2c_audio: &i2c8 {
 			compatible = "pci1b4b,2b42";
 			reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
 			       0x83010000 0x0 0x00100000 0x0 0x00100000>;
-			interrupt-parent = <&gpio0>;
-			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&wlan_host_wake_l>;
-			wakeup-source;
 		};
 	};
 };
-- 
2.11.0
