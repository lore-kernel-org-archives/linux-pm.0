From: Sricharan R <sricharan@codeaurora.org>
Subject: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
Date: Tue, 19 Dec 2017 21:25:00 +0530
Message-ID: <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: sricharan@codeaurora.org
List-Id: linux-pm@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,pvs.txt       | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt b/Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt
new file mode 100644
index 0000000..260f537
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,pvs.txt
@@ -0,0 +1,91 @@
+Qualcomm Process Voltage Scaling Tables
+
+The node name is required to be "qcom,pvs". There shall only be one
+such node present in the root of the tree.
+
+PROPERTIES
+
+- qcom,pvs-format-a or qcom,pvs-format-b:
+	Usage: required
+	Value type: <empty>
+	Definition: Indicates where and how to read and interpret the efuse registers.
+		    Based on that the opp-microvolt-<name> is extended with the right
+		    speedXX-PVSXX-versionXX string. The cpu opp-table should be populated
+		    with the operating-points-v2 binding and each opp must have the voltage
+		    specified for all combinations of opp-microvolt-<speedXX-pvsXX-versionXX>.
+
+Example:
+
+	cpu@0 {
+		compatible = "qcom,krait";
+		enable-method = "qcom,kpss-acc-v1";
+		device_type = "cpu";
+		reg = <0>;
+		qcom,acc = <&acc0>;
+		qcom,saw = <&saw0>;
+		clocks = <&kraitcc 0>;
+		clock-names = "cpu";
+		cpu-supply = <&smb208_s2a>;
+		operating-points-v2 = <&cpu_opp_table>;
+	};
+
+	qcom,pvs {
+		qcom,pvs-format-a;
+	};
+
+
+	cpu_opp_table: opp_table {
+		compatible = "operating-points-v2";
+
+		/*
+		 * Missing opp-shared property means CPUs switch DVFS states
+		 * independently.
+		 */
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1250000>;
+			opp-microvolt-speed0-pvs1-v0 = <1175000>;
+			opp-microvolt-speed0-pvs2-v0 = <1125000>;
+			opp-microvolt-speed0-pvs3-v0 = <1050000>;
+
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1100000>;
+			opp-microvolt-speed0-pvs1-v0 = <1025000>;
+			opp-microvolt-speed0-pvs2-v0 = <995000>;
+			opp-microvolt-speed0-pvs3-v0 = <900000>;
+
+		};
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1000000>;
+			opp-microvolt-speed0-pvs1-v0 = <925000>;
+			opp-microvolt-speed0-pvs2-v0 = <875000>;
+			opp-microvolt-speed0-pvs3-v0 = <800000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1150000>;
+			opp-microvolt-speed0-pvs1-v0 = <1075000>;
+			opp-microvolt-speed0-pvs2-v0 = <1025000>;
+			opp-microvolt-speed0-pvs3-v0 = <950000>;
+
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1050000>;
+			opp-microvolt-speed0-pvs1-v0 = <975000>;
+			opp-microvolt-speed0-pvs2-v0 = <925000>;
+			opp-microvolt-speed0-pvs3-v0 = <850000>;
+		};
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1200000>;
+			opp-microvolt-speed0-pvs1-v0 = <1125000>;
+			opp-microvolt-speed0-pvs2-v0 = <1075000>;
+			opp-microvolt-speed0-pvs3-v0 = <1000000>;
+		};
+	};
+
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
