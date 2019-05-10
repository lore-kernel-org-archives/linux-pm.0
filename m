From: michael.kao <michael.kao@mediatek.com>
Subject: [PATCH v2 3/8] arm64: dts: mt8183: Add #cooling-cells to CPU nodes
Date: Fri, 10 May 2019 21:27:01 +0800
Message-ID: <1557494826-6044-4-git-send-email-michael.kao@mediatek.com>
References: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1557494826-6044-1-git-send-email-michael.kao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "michael.kao" <michael.kao@mediatek.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The #cooling-cells property needs to be specified to allow a CPU
to be used as cooling device.

Signed-off-by: Michael.Kao <michael.kao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 8f9fd9a..bf8b0a8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -11,6 +11,8 @@
 #include <dt-bindings/power/mt8183-power.h>
 #include <dt-bindings/reset-controller/mt8183-resets.h>
 #include "mt8183-pinfunc.h"
+#include <dt-bindings/thermal/thermal.h>
+
 / {
 	compatible = "mediatek,mt8183";
 	interrupt-parent = <&sysirq>;
@@ -59,6 +61,7 @@
 			reg = <0x000>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -67,6 +70,7 @@
 			reg = <0x001>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -75,6 +79,7 @@
 			reg = <0x002>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -83,6 +88,7 @@
 			reg = <0x003>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@100 {
@@ -91,6 +97,7 @@
 			reg = <0x100>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@101 {
@@ -99,6 +106,7 @@
 			reg = <0x101>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@102 {
@@ -107,6 +115,7 @@
 			reg = <0x102>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@103 {
@@ -115,6 +124,7 @@
 			reg = <0x103>;
 			enable-method = "psci";
 			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
2.6.4
