From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v5 12/15] devicetree: bindings: Document qcom,krait-cc
Date: Tue, 19 Dec 2017 21:24:57 +0530
Message-ID: <1513698900-10638-13-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42352 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbdLSP5U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 10:57:20 -0500
In-Reply-To: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: sricharan@codeaurora.org

From: Stephen Boyd <sboyd@codeaurora.org>

The Krait clock controller controls the krait CPU and the L2 clocks
consisting a primary mux and secondary mux. Add document for that.

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
