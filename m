From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 3/4] ARM: dts: pxa: add pxa27x cpu operating points
Date: Sat, 15 Oct 2016 21:57:29 +0200
Message-ID: <1476561450-28407-4-git-send-email-robert.jarzmik@free.fr>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Add the relevant data taken from the PXA27x Electrical, Mechanical, and
Thermal Specfication. This will be input data for cpufreq-dt driver.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 9e73dc6b3ed3..aef1186856bc 100644
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
+		opp@104 {
+			opp-hz = /bits/ 64 <104000000>;
+			opp-microvolt = <900000 900000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@156 {
+			opp-hz = /bits/ 64 <156000000>;
+			opp-microvolt = <1000000 1000000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@208 {
+			opp-hz = /bits/ 64 <208000000>;
+			opp-microvolt = <1180000 1180000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@312 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <1250000 1250000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@416 {
+			opp-hz = /bits/ 64 <416000000>;
+			opp-microvolt = <1350000 1350000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@520 {
+			opp-hz = /bits/ 64 <520000000>;
+			opp-microvolt = <1450000 1450000 1705000>;
+			clock-latency-ns = <20>;
+		};
+		opp@624 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <1550000 1550000 1705000>;
+			clock-latency-ns = <20>;
+		};
+	};
 };
-- 
2.1.4
