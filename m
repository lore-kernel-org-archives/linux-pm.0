From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 2/3] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
Date: Tue, 24 Jul 2018 16:46:35 -0700
Message-ID: <20180724234636.57137-2-mka@chromium.org>
References: <20180724234636.57137-1-mka@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724234636.57137-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, Douglas Anderson <dianders@chromium.org>, Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
List-Id: linux-pm@vger.kernel.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v5:
- added tag 'Reviewed-by: Douglas Anderson <dianders@chromium.org>'

Changes in v4:
- none

Changes in v3:
- changed node name from 'qcom,temp-alarm@2400' to 'temp-alarm@2400'
- removed controller register length value from 'reg'

Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..7eea94701b23 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -11,6 +11,13 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8998_temp: temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		pm8998_gpio: gpios@c000 {
 			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.18.0.233.g985f88cf7e-goog
