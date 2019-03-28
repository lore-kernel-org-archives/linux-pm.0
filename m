From: Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 9/9] arm64: dts: qcom: sdm845: Add nodes for icbw driver and opp tables
Date: Thu, 28 Mar 2019 20:58:22 +0530
Message-ID: <20190328152822.532-10-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org
Cc: bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add nodes to enable DDR devfreq driver on SDM845 SoC.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 80 ++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 072563f6b6cb..21a0068855e8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,lpass-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sdm845.h>
+#include <dt-bindings/interconnect/qcom,sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/power/qcom-aoss-qmp.h>
@@ -488,6 +489,85 @@
 		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	cpubw: cpu-icbw {
+		compatible = "devfreq-icbw";
+		interconnects = <&rsc_hlos MASTER_APPSS_PROC &rsc_hlos SLAVE_EBI1>;
+		operating-points-v2 = <&bw_opp_table>;
+	};
+
+	bw_opp_table: bw-opp-table {
+		compatible = "operating-points-v2";
+
+		opp-200  {
+			opp-hz = /bits/ 64 < 200000000 >; /* 200 MHz */
+			required-opps = <&cpu0_opp1>;
+			/* 0 MB/s average and 762 MB/s peak bandwidth */
+			opp-bw-MBs = <0 762>;
+		};
+
+		opp-300 {
+			opp-hz = /bits/ 64 < 300000000 >; /* 300 MHz */
+			/* 0 MB/s average and 1144 MB/s peak bandwidth */
+			opp-bw-MBs = <0 1144>;
+		};
+
+		opp-451 {
+			opp-hz = /bits/ 64 < 451000000 >; /* 451 MHz */
+			/* 0 MB/s average and 1720 MB/s peak bandwidth */
+			opp-bw-MBs = <0 1720>;
+			required-opps = <&cpu0_opp6>;
+		};
+
+		opp-547 {
+			opp-hz = /bits/ 64 < 547000000 >; /* 547 MHz */
+			/* 0 MB/s average and 2086 MB/s peak bandwidth */
+			opp-bw-MBs = <0 2086>;
+			required-opps = <&cpu0_opp11>;
+		};
+
+		opp-681 {
+			opp-hz = /bits/ 64 < 681000000 >; /* 681 MHz */
+			/* 0 MB/s average and 2597 MB/s peak bandwidth */
+			opp-bw-MBs = <0 2597>;
+			required-opps = <&cpu0_opp15>;
+		};
+
+		opp-768 {
+			opp-hz = /bits/ 64 < 768000000 >; /* 768 MHz */
+			/* 0 MB/s average and 2929 MB/s peak bandwidth */
+			opp-bw-MBs = <0 2929>;
+			required-opps = <&cpu4_opp4>;
+		};
+
+		opp-1017 {
+			opp-hz = /bits/ 64 < 1017000000 >; /* 1017 MHz */
+			/* 0 MB/s average and 3879 MB/s peak bandwidth */
+			opp-bw-MBs = <0 3879>;
+			required-opps = <&cpu0_opp16>, <&cpu4_opp5>;
+		};
+
+		opp-1296 {
+			opp-hz = /bits/ 64 < 1296000000 >; /* 1296 MHz */
+			/* 0 MB/s average and 4943 MB/s peak bandwidth */
+			opp-bw-MBs = <0 4943>;
+			required-opps = <&cpu4_opp10>;
+		};
+
+		opp-1555 {
+			opp-hz = /bits/ 64 < 1555000000 >; /* 1555 MHz */
+			/* 0 MB/s average and 5931 MB/s peak bandwidth */
+			opp-bw-MBs = <0 5931>;
+			required-opps = <&cpu4_opp12>;
+		};
+
+		opp-1804 {
+			opp-hz = /bits/ 64 < 1804000000 >; /* 1804 MHz */
+			/* 0 MB/s average and 6881 MB/s peak bandwidth */
+			opp-bw-MBs = <0 6881>;
+			required-opps = <&cpu4_opp15>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 1 IRQ_TYPE_LEVEL_LOW>,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
