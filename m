From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v12 11/14] dt-bindings: clock: Document qcom,krait-cc
Date: Tue, 14 Aug 2018 17:42:30 +0530
Message-ID: <1534248753-2440-12-git-send-email-sricharan@codeaurora.org>
References: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534248753-2440-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com, linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, linux-pm@vger.kernel.org, sboyd@codeaurora.org, linux@armlinux.org.uk, thierry.escande@linaro.org, linux-kernel@vger.kernel.org, david.brown@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The Krait clock controller controls the krait CPU and the L2 clocks
consisting a primary mux and secondary mux. Add document for that.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,krait-cc.txt    | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
new file mode 100644
index 0000000..030ba60
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
@@ -0,0 +1,34 @@
+Krait Clock Controller
+
+PROPERTIES
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be one of:
+			"qcom,krait-cc-v1"
+			"qcom,krait-cc-v2"
+
+- #clock-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: must be 1
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the clock parents of hfpll, secondary muxes.
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb".
+
+Example:
+
+	kraitcc: clock-controller {
+		compatible = "qcom,krait-cc-v1";
+		clocks = <&hfpll0>, <&hfpll1>, <&acpu0_aux>, <&acpu1_aux>, <qsb>;
+		clock-names = "hfpll0", "hfpll1", "acpu0_aux", "acpu1_aux", "qsb";
+		#clock-cells = <1>;
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
