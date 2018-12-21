From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 5/5] arm64: dts: msm: add PDC timer for apps_rsc for SDM845
Date: Fri, 21 Dec 2018 17:29:46 +0530
Message-ID: <20181221115946.10095-6-rplsssn@codeaurora.org>
References: <20181221115946.10095-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221115946.10095-1-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add PDC timer node for apps_rsc to program next wake-up
timer value.

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b256357e4db1..c73b717ed8ea 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1372,6 +1372,9 @@
 			      <0x179d0000 0x10000>,
 			      <0x179e0000 0x10000>;
 			reg-names = "drv-0", "drv-1", "drv-2";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
@@ -1382,6 +1385,12 @@
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
 
+			pdc_timer@38 {
+				compatible = "qcom,pdc-timer";
+				reg = <0x38 0x1>,
+				      <0x40 0x1>;
+			};
+
 			rpmhcc: clock-controller {
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
