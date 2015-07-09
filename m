From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 5/7] ARM: dts: Exynos4x12: add CPU OPP and regulator supply
 property
Date: Thu, 09 Jul 2015 17:43:39 +0200
Message-ID: <1436456621-29839-6-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Andreas Faerber <afaerber@suse.de>, Javier Martinez Canillas <javier@dowhile0.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

For Exynos4x12 platforms, add CPU operating points (using
opp-v2 bindings) and CPU regulator supply properties for
migrating from Exynos specific cpufreq driver to using
generic cpufreq driver.

Based on the earlier work by Thomas Abraham.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi               | 81 ++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  4 ++
 arch/arm/boot/dts/exynos4412-origen.dts         |  5 ++
 arch/arm/boot/dts/exynos4412-trats2.dts         |  5 ++
 arch/arm/boot/dts/exynos4412.dtsi               | 83 +++++++++++++++++++++++++
 5 files changed, 178 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index d9c8efee..9dc40d5 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -30,6 +30,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 			cooling-min-level = <13>;
 			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -39,6 +42,84 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA01>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <200000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <200000>;
+		};
+		opp01 {
+			opp-hz = <300000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <200000>;
+		};
+		opp02 {
+			opp-hz = <400000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <200000>;
+		};
+		opp03 {
+			opp-hz = <500000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+		opp04 {
+			opp-hz = <600000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <200000>;
+		};
+		opp05 {
+			opp-hz = <700000000>;
+			opp-microvolt = <987500>;
+			clock-latency-ns = <200000>;
+		};
+		opp06 {
+			opp-hz = <800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp07 {
+			opp-hz = <900000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <200000>;
+		};
+		opp08 {
+			opp-hz = <1000000000>;
+			opp-microvolt = <1087500>;
+			clock-latency-ns = <200000>;
+		};
+		opp09 {
+			opp-hz = <1100000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <200000>;
+		};
+		opp10 {
+			opp-hz = <1200000000>;
+			opp-microvolt = <1187500>;
+			clock-latency-ns = <200000>;
+		};
+		opp11 {
+			opp-hz = <1300000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <200000>;
+		};
+		opp12 {
+			opp-hz = <1400000000>;
+			opp-microvolt = <1287500>;
+			clock-latency-ns = <200000>;
+		};
+		opp13 {
+			opp-hz = <1500000000>;
+			opp-microvolt = <1350000>;
+			clock-latency-ns = <200000>;
+			turbo-mode;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index ca7d168..1c7811a 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -507,3 +507,7 @@
 &watchdog {
 	status = "okay";
 };
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 84c7631..21150b4 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -532,3 +532,8 @@
 &watchdog {
 	status = "okay";
 };
+
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index afc199d..1ee43456 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1313,3 +1313,8 @@
 	vtmu-supply = <&ldo10_reg>;
 	status = "okay";
 };
+
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index b78ada7..cead3a7 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -30,6 +30,9 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 			cooling-min-level = <13>;
 			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
@@ -39,18 +42,98 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA01>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu@A02 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA02>;
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu@A03 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA03>;
+			operating-points-v2 = <&cpu0_opp_table>;
+		};
+	};
+
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = <200000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <200000>;
+		};
+		opp01 {
+			opp-hz = <300000000>;
+			opp-microvolt = <900000>;
+			clock-latency-ns = <200000>;
+		};
+		opp02 {
+			opp-hz = <400000000>;
+			opp-microvolt = <925000>;
+			clock-latency-ns = <200000>;
+		};
+		opp03 {
+			opp-hz = <500000000>;
+			opp-microvolt = <950000>;
+			clock-latency-ns = <200000>;
+		};
+		opp04 {
+			opp-hz = <600000000>;
+			opp-microvolt = <975000>;
+			clock-latency-ns = <200000>;
+		};
+		opp05 {
+			opp-hz = <700000000>;
+			opp-microvolt = <987500>;
+			clock-latency-ns = <200000>;
+		};
+		opp06 {
+			opp-hz = <800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <200000>;
+		};
+		opp07 {
+			opp-hz = <900000000>;
+			opp-microvolt = <1037500>;
+			clock-latency-ns = <200000>;
+		};
+		opp08 {
+			opp-hz = <1000000000>;
+			opp-microvolt = <1087500>;
+			clock-latency-ns = <200000>;
+		};
+		opp09 {
+			opp-hz = <1100000000>;
+			opp-microvolt = <1137500>;
+			clock-latency-ns = <200000>;
+		};
+		opp10 {
+			opp-hz = <1200000000>;
+			opp-microvolt = <1187500>;
+			clock-latency-ns = <200000>;
+		};
+		opp11 {
+			opp-hz = <1300000000>;
+			opp-microvolt = <1250000>;
+			clock-latency-ns = <200000>;
+		};
+		opp12 {
+			opp-hz = <1400000000>;
+			opp-microvolt = <1287500>;
+			clock-latency-ns = <200000>;
+		};
+		opp13 {
+			opp-hz = <1500000000>;
+			opp-microvolt = <1350000>;
+			clock-latency-ns = <200000>;
+			turbo-mode;
 		};
 	};
 
-- 
1.9.1
