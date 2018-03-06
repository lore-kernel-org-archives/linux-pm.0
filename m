From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v9 12/15] dt-bindings: clock: Document qcom,krait-cc
Date: Tue,  6 Mar 2018 20:09:05 +0530
Message-ID: <1520347148-27852-13-git-send-email-sricharan@codeaurora.org>
References: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520347148-27852-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

The Krait clock controller controls the krait CPU and the L2 clocks
consisting a primary mux and secondary mux. Add document for that.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,krait-cc.txt    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt

diff --git a/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
new file mode 100644
index 0000000..874138f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
@@ -0,0 +1,22 @@
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
+Example:
+
+	kraitcc: clock-controller {
+		compatible = "qcom,krait-cc-v1";
+		#clock-cells = <1>;
+	};
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
