From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v3 3/4] ARM: dts: pxa: add pxa27x cpu operating points
Date: Mon, 31 Oct 2016 20:54:55 +0100
Message-ID: <1477943696-23477-4-git-send-email-robert.jarzmik@free.fr>
References: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael J Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add the relevant data taken from the PXA27x Electrical, Mechanical, and
Thermal Specfication. This will be input data for cpufreq-dt driver.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v2: opp definition amended as per Viresh's comment
---
 arch/arm/boot/dts/pxa27x.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 9e73dc6b3ed3..e0fab48ba6fa 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -137,4 +137,44 @@
 		clocks = <&clks CLK_OSTIMER>;
 		status = "okay";
 	};
+
+	pxa270_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@104000000 {
+			opp-hz = /bits/ 64 <104000000>;
+			opp-microvolt = <900000 900000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@156000000 {
+			opp-hz = /bits/ 64 <156000000>;
+			opp-microvolt = <1000000 1000000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@208000000 {
+			opp-hz = /bits/ 64 <208000000>;
+			opp-microvolt = <1180000 1180000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <1250000 1250000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@416000000 {
+			opp-hz = /bits/ 64 <416000000>;
+			opp-microvolt = <1350000 1350000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@520000000 {
+			opp-hz = /bits/ 64 <520000000>;
+			opp-microvolt = <1450000 1450000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <1550000 1550000 1705000>;
+			clock-latency-ns = <20>;
+		};
+	};
 };
-- 
2.1.4
