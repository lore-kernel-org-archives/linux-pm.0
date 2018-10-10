From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 8/8] arm64: dtsi: sdm845: Add cpu power domain support
Date: Thu, 11 Oct 2018 02:50:55 +0530
Message-ID: <1539206455-29342-9-git-send-email-rplsssn@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add cpu power domain support

Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index d3662a8..aadaa20 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -96,6 +96,7 @@
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
+			power-domains = <&cpu_pd>;
 			L2_0: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -111,6 +112,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
+			power-domains = <&cpu_pd>;
 			L2_100: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -123,6 +125,7 @@
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
+			power-domains = <&cpu_pd>;
 			L2_200: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -135,6 +138,7 @@
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
+			power-domains = <&cpu_pd>;
 			L2_300: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -147,6 +151,7 @@
 			reg = <0x0 0x400>;
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
+			power-domains = <&cpu_pd>;
 			L2_400: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -159,6 +164,7 @@
 			reg = <0x0 0x500>;
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
+			power-domains = <&cpu_pd>;
 			L2_500: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -171,6 +177,7 @@
 			reg = <0x0 0x600>;
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
+			power-domains = <&cpu_pd>;
 			L2_600: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -183,6 +190,7 @@
 			reg = <0x0 0x700>;
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
+			power-domains = <&cpu_pd>;
 			L2_700: l2-cache {
 				compatible = "cache";
 				next-level-cache = <&L3_0>;
@@ -1170,6 +1178,11 @@
 					  <WAKE_TCS    3>,
 					  <CONTROL_TCS 1>;
 
+			cpu_pd: power-domain-controller {
+				compatible = "qcom,cpu-pm-domain";
+				#power-domain-cells = <0>;
+			};
+
 			rpmhcc: clock-controller {
 				compatible = "qcom,sdm845-rpmh-clk";
 				#clock-cells = <1>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
