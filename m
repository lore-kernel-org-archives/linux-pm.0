From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V6 05/10] Documentation: DT: bindings: Add power domain info for NVIDIA PMC
Date: Fri, 26 Feb 2016 15:48:39 +0000
Message-ID: <1456501724-28477-6-git-send-email-jonathanh@nvidia.com>
References: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15624 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbcBZPtP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 10:49:15 -0500
In-Reply-To: <1456501724-28477-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Add power-domain binding documentation for the NVIDIA PMC driver in
order to support generic power-domains.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 53aa5496c5cf..0c383a9e720e 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -1,5 +1,7 @@
 NVIDIA Tegra Power Management Controller (PMC)
 
+== Power Management Controller Node ==
+
 The PMC block interacts with an external Power Management Unit. The PMC
 mostly controls the entry and exit of the system from different sleep
 modes. It provides power-gating controllers for SoC and CPU power-islands.
@@ -70,6 +72,11 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
                      Defaults to 0. Valid values are described in section 12.5.2
                      "Pinmux Support" of the Tegra4 Technical Reference Manual.
 
+Optional nodes:
+- powergates : This node contains a hierarchy of power domain nodes, which
+	       should match the powergates on the Tegra SoC. See "Powergate
+	       Nodes" below.
+
 Example:
 
 / SoC dts including file
@@ -115,3 +122,57 @@ pmc@7000f400 {
 	};
 	...
 };
+
+
+== Powergate Nodes ==
+
+Each of the powergate nodes represents a power-domain on the Tegra SoC
+that can be power-gated by the PMC and should be named appropriately.
+
+Required properties:
+  - reg: Contains an integer value that identifies the PMC power-gate.
+    Please refer to the Tegra TRM for more details. The parent node
+    must contain the following two properties:
+    - #address-cells: Must be 1,
+    - #size-cells: Must be 0.
+  - clocks: Must contain an entry for each clock required by the PMC for
+    controlling a power-gate. See ../clocks/clock-bindings.txt for details.
+  - resets: Must contain an entry for each reset required by the PMC for
+    controlling a power-gate. See ../reset/reset.txt for details.
+  - #power-domain-cells: Must be 0.
+
+Example:
+
+	pmc: pmc@0,7000e400 {
+		compatible = "nvidia,tegra210-pmc";
+		reg = <0x0 0x7000e400 0x0 0x400>;
+		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
+
+		powergates {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pd_audio: aud {
+				reg = <TEGRA_POWERGATE_AUD>;
+				clocks = <&tegra_car TEGRA210_CLK_APE>,
+					 <&tegra_car TEGRA210_CLK_APB2APE>;
+				resets = <&tegra_car 198>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
+
+
+== Powergate Clients ==
+
+Hardware blocks belonging to a power domain should contain a "power-domains"
+property that is a phandle pointing to the corresponding powergate node.
+
+Example:
+
+	adma: adma@702e2000 {
+		...
+		power-domains = <&pd_audio>;
+		...
+	};
-- 
2.1.4

