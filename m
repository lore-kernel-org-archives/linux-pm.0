From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 3/6] ARM: tegra: Add thermal trip points for Jetson TK1
Date: Fri, 27 Jun 2014 11:11:36 +0300
Message-ID: <1403856699-2140-4-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, pdeschrijver@nvidia.com, mlongnecker@nvidia.com
Cc: linux-tegra@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This adds critical trip points to the Jetson TK1 device tree.
The device will do a controlled shutdown when either the CPU, GPU
or MEM thermal zone reaches 101 degrees Celsius.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 16082c0..c319443 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -1825,4 +1825,36 @@
 			 <&tegra_car TEGRA124_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	thermal-zones {
+		cpu {
+			trips {
+				cpu-critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		mem {
+			trips {
+				mem-critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu {
+			trips {
+				gpu-critical {
+					temperature = <101000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
1.8.1.5
