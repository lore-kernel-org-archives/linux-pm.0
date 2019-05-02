From: michael.kao <michael.kao@mediatek.com>
Subject: [PATCH 2/8] arm64: dts: mt8183: add/update dynamic power coefficients
Date: Thu, 2 May 2019 18:43:09 +0800
Message-ID: <1556793795-25204-3-git-send-email-michael.kao@mediatek.com>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: michael.kao@mediatek.com, fan.chen@mediatek.com, jamesjj.liao@mediatek.com, dawei.chien@mediatek.com, louis.yu@mediatek.com, roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add dynamic power coefficients for all cores and update those of
CPU0 and CPU4.

Signed-off-by: Michael.Kao <michael.kao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index b92116f..5668fb8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -58,6 +58,8 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu1: cpu@1 {
@@ -65,6 +67,8 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x001>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu2: cpu@2 {
@@ -72,6 +76,8 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x002>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu3: cpu@3 {
@@ -79,6 +85,8 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x003>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <84>;
+			#cooling-cells = <2>;
 		};
 
 		cpu4: cpu@100 {
@@ -86,6 +94,8 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x100>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 
 		cpu5: cpu@101 {
@@ -93,6 +103,8 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x101>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 
 		cpu6: cpu@102 {
@@ -100,6 +112,8 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x102>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 
 		cpu7: cpu@103 {
@@ -107,6 +121,8 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x103>;
 			enable-method = "psci";
+			dynamic-power-coefficient = <211>;
+			#cooling-cells = <2>;
 		};
 	};
 
-- 
1.9.1
