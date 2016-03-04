From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V7 2/4] Documentation: DT: bindings: Add power domain info for NVIDIA PMC
Date: Fri, 4 Mar 2016 12:23:04 +0000
Message-ID: <1457094186-15786-3-git-send-email-jonathanh@nvidia.com>
References: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15052 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbcCDMXU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2016 07:23:20 -0500
In-Reply-To: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

Add power-domain binding documentation for the NVIDIA PMC driver in
order to support generic power-domains.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 53aa5496c5cf..7d52bbe99709 100644
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
@@ -115,3 +122,76 @@ pmc@7000f400 {
 	};
 	...
 };
+
+
+== Powergate Nodes ==
+
+Each of the powergate nodes represent a power-domain on the Tegra SoC
+that can be power-gated by the Tegra PMC. The name of the powergate node
+should be one of the below. Note that not every powergate is applicable
+to all Tegra devices and the following list shows which powergates are
+applicable to which devices. Please refer to the Tegra TRM for more
+details on the various powergates.
+
+ Name		Description			Devices Applicable
+ 3d		3D Graphics			Tegra20/114/124/210
+ 3d0		3D Graphics 0			Tegra30
+ 3d1		3D Graphics 1			Tegra30
+ aud		Audio				Tegra210
+ dfd		Debug				Tegra210
+ dis		Display A			Tegra114/124/210
+ disb		Display B			Tegra114/124/210
+ heg		2D Graphics			Tegra30/114/124/210
+ iram		Internal RAM			Tegra124/210
+ mpe		MPEG Encode			All
+ nvdec		NVIDIA Video Decode Engine	Tegra210
+ nvjpg		NVIDIA JPEG Engine		Tegra210
+ pcie		PCIE				Tegra20/30/124/210
+ sata		SATA				Tegra30/124/210
+ sor		Display interfaces		Tegra124/210
+ ve2		Video Encode Engine 2		Tegra210
+ venc		Video Encode Engine		All
+ vdec		Video Decode Engine		Tegra20/30/114/124
+ vic		Video Imaging Compositor	Tegra124/210
+ xusba		USB Partition A			Tegra114/124/210
+ xusbb		USB Partition B 		Tegra114/124/210
+ xusbc		USB Partition C			Tegra114/124/210
+
+Required properties:
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
+			pd_audio: aud {
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

