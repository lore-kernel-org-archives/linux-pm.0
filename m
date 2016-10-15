From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 2/4] ARM: dts: pxa: add pxa25x cpu operating points
Date: Sat, 15 Oct 2016 21:57:28 +0200
Message-ID: <1476561450-28407-3-git-send-email-robert.jarzmik@free.fr>
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

Add the relevant data taken from the PXA 25x Electrical, Mechanical, and
Thermal Specfication. This will be input data for cpufreq-dt driver.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa25x.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index 0d1e012178c4..16b4e8bad4a5 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -89,4 +89,29 @@
 		clocks = <&clktimer>;
 		status = "okay";
 	};
+
+	pxa250_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp@99500 {
+			opp-hz = /bits/ 64 <99532800>;
+			opp-microvolt = <950000 1000000 1650000>;
+			clock-latency-ns = <20>;
+		};
+		opp@199100 {
+			opp-hz = /bits/ 64 <199065600>;
+			opp-microvolt = <1000000 950000 1650000>;
+			clock-latency-ns = <20>;
+		};
+		opp@298600 {
+			opp-hz = /bits/ 64 <298598400>;
+			opp-microvolt = <1100000 1045000 1650000>;
+			clock-latency-ns = <20>;
+		};
+		opp@398100 {
+			opp-hz = /bits/ 64 <398131200>;
+			opp-microvolt = <1300000 1235000 1650000>;
+			clock-latency-ns = <20>;
+		};
+	};
 };
-- 
2.1.4
