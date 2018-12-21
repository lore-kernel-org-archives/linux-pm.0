From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 3/5] dt-bindings: Add PDC timer bindings for Qualcomm SoCs
Date: Fri, 21 Dec 2018 17:29:44 +0530
Message-ID: <20181221115946.10095-4-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add device binding documentation for Qualcomm Technology Inc's PDC timer.
The driver is used for programming next wake-up timer value when processor
enters SoC level deepest low power state.

Cc: devicetree@vger.kernel.org
Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
index 9b86d1eff219..f24afb45d0d9 100644
--- a/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/rpmh-rsc.txt
@@ -30,6 +30,12 @@ will be an aggregate of the sleep votes from each of those subsystems. Clients
 may request a sleep value for their shared resources in addition to the active
 mode requests.
 
+When the processor enters deepest low power mode, the next wake-up timer value
+needs to be programmed to PDC (Power Domain Controller) through RSC registers
+dedicated for this purpose. PDC timer is specified as child node of RSC with
+register offets to program timer match value.
+
+
 Properties:
 
 - compatible:
@@ -86,6 +92,20 @@ Properties:
 Drivers that want to use the RSC to communicate with RPMH must specify their
 bindings as child nodes of the RSC controllers they wish to communicate with.
 
+If an RSC needs to program next wake-up in the PDC timer, it must specify the
+binding as child node with the following properties:
+
+Properties:
+- compatible:
+    Usage: required
+	Value type: <string>
+	Definition: must be "qcom,pdc-timer".
+
+- reg:
+    Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Specifies the offset of the control register.
+
 Example 1:
 
 For a TCS whose RSC base address is is 0x179C0000 and is at a DRV id of 2, the
@@ -103,6 +123,9 @@ TCS-OFFSET: 0xD00
 		      <0x179d0000 0x10000>,
 		      <0x179e0000 0x10000>;
 		reg-names = "drv-0", "drv-1", "drv-2";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
 		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -112,6 +135,12 @@ TCS-OFFSET: 0xD00
 				  <SLEEP_TCS   3>,
 				  <WAKE_TCS    3>,
 				  <CONTROL_TCS 1>;
+
+		pdc_timer@38 {
+			compatible = "qcom,pdc-timer";
+			reg = <0x38 0x1>,
+			      <0x40 0x1>;
+		}
 	};
 
 Example 2:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
