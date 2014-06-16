From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [RFC PATCH 2/4] ARM: tegra: Add Tegra124 EMC support
Date: Mon, 16 Jun 2014 15:35:11 +0200
Message-ID: <1402925713-25426-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@linaro.org>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: linux-pm@vger.kernel.org

Add a device node for the EMC found on Tegra124.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 6e6bc4e..5aa42ff 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -449,6 +449,15 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
+	memory-controller@7001b000 {
+		compatible = "nvidia,tegra124-emc";
+		reg = <0x00 0x7001b000 0x00 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&tegra_car 57>;
+		clock-names = "emc";
+	};
+
 	sdhci@0,700b0000 {
 		compatible = "nvidia,tegra124-sdhci";
 		reg = <0x0 0x700b0000 0x0 0x200>;
-- 
1.9.3
