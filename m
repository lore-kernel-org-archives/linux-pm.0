From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V3 14/19] Documentation: DT: bindings: Add power domain info for NVIDIA PMC
Date: Mon, 13 Jul 2015 13:39:52 +0100
Message-ID: <1436791197-32358-15-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436791197-32358-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add power-domain binding documentation for the NVIDIA PMC driver in
order to support generic power-domains.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 02c27004d4a8..93357a450576 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -1,5 +1,7 @@
 NVIDIA Tegra Power Management Controller (PMC)
 
+== Power Management Controller Node ==
+
 The PMC block interacts with an external Power Management Unit. The PMC
 mostly controls the entry and exit of the system from different sleep
 modes. It provides power-gating controllers for SoC and CPU power-islands.
@@ -68,6 +70,10 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
                      Defaults to 0. Valid values are described in section 12.5.2
                      "Pinmux Support" of the Tegra4 Technical Reference Manual.
 
+Optional nodes:
+- pm-domains : This node contains a hierarchy of PM domain nodes, which should
+	       match the power-domains on the Tegra SoC.
+
 Example:
 
 / SoC dts including file
@@ -113,3 +119,96 @@ pmc@7000f400 {
 	};
 	...
 };
+
+
+== PM Domain Nodes ==
+
+Each of the PM domain nodes represents a power-domain on the Tegra SoC
+that can be power-gated by the PMC and should be named appropriately.
+
+Required properties:
+  - clocks:		   Must contain an entry for each clock required by
+			   the PMC for controlling a power-gate. See
+			   ../clocks/clock-bindings.txt for details.
+  - resets:		   Must contain an entry for each reset required by
+			   the PMC for controlling a power-gate. See
+			   ../reset/reset.txt for details.
+  - nvidia,powergate:	   Integer cell that contains an identifier for the
+			   PMC power-gate that is associated with the
+			   power-domain. Please refer to the Tegra TRM for
+			   more details.
+  - #power-domain-cells:   Must be 0.
+
+Optional properties:
+  - nvidia,swgroups:	   Provides details of the software groups that are
+			   associated with a specific power-domain. The
+			   software group specifier consists of a phandle
+			   pointing to the memory controller and a list of
+			   one or more integer cells for each software group
+			   associated with the power domain. The length of
+			   the list of integer cells is specified by
+			   #nvidia,swgroup-cells.
+  - #nvidia,swgroup-cells: Must be 1 or more. See nvidia,swgroups for
+			   more details.
+
+Example:
+
+	pmc@0,7000e400 {
+		compatible = "nvidia,tegra124-pmc";
+		reg = <0x0 0x7000e400 0x0 0x400>;
+		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
+
+		pm-domains {
+
+			...
+
+			pd_sor: sor-power-domain {
+				clocks = <&tegra_car TEGRA124_CLK_SOR0>,
+					 <&tegra_car TEGRA124_CLK_DSIA>,
+					 <&tegra_car TEGRA124_CLK_DSIB>,
+					 <&tegra_car TEGRA124_CLK_HDMI>,
+					 <&tegra_car TEGRA124_CLK_MIPI_CAL>,
+					 <&tegra_car TEGRA124_CLK_DPAUX>;
+				resets = <&tegra_car 182>,
+					 <&tegra_car 48>,
+					 <&tegra_car 82>,
+					 <&tegra_car 51>,
+					 <&tegra_car 56>;
+				nvidia,powergate = <TEGRA_POWERGATE_SOR>;
+				#power-domain-cells = <0>;
+
+				pd_dc: dc-power-domain {
+					clocks = <&tegra_car TEGRA124_CLK_DISP1>;
+					resets = <&tegra_car 27>;
+					nvidia,powergate = <TEGRA_POWERGATE_DIS>;
+					nvidia,swgroups = <&mc TEGRA_SWGROUP_DC>;
+					#nvidia,swgroup-cells = <1>;
+					#power-domain-cells = <0>;
+
+					pd_dcb: dcb-power-domain {
+						clocks = <&tegra_car TEGRA124_CLK_DISP2>;
+						resets = <&tegra_car 26>;
+						nvidia,powergate = <TEGRA_POWERGATE_DISB>;
+						nvidia,swgroups = <&mc TEGRA_SWGROUP_DCB>;
+						#nvidia,swgroup-cells = <1>;
+						#power-domain-cells = <0>;
+					};
+				};
+			};
+		};
+	};
+
+
+== PM Domain Consumers ==
+
+Hardware blocks belonging to a PM domain should contain a "power-domains"
+property that is a phandle pointing to the corresponding PM domain node.
+
+Example:
+
+	sor@0,54540000 {
+		...
+		power-domains = <&pd_sor>;
+		...
+	};
-- 
2.1.4
