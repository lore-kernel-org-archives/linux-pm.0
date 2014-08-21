From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v5 3/4] ARM: tegra: Add thermal trip points for Jetson TK1
Date: Thu, 21 Aug 2014 13:17:21 +0300
Message-ID: <1408616242-21009-4-git-send-email-mperttunen@nvidia.com>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, swarren@wwwdotorg.org, thierry.reding@gmail.com
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, juha-matti.tilli@iki.fi, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This adds critical trip points to the Jetson TK1 device tree.
The device will do a controlled shutdown when either the CPU, GPU
or MEM thermal zone reaches 101 degrees Celsius.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v5: added cooling-maps nodes

 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 0cdb5cf..bcdab7f 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1876,4 +1876,45 @@
 			 <&tegra_car TEGRA124_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	thermal-zones {
+		cpu {
+			trips {
+				trip@0 {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+
+		mem {
+			trips {
+				trip@0 {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+
+		gpu {
+			trips {
+				trip@0 {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+			};
+		};
+	};
 };
-- 
1.8.1.5
