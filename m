From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4/6] ARM: dts: Exynos4x12: add CPU OPP and regulator supply
 property
Date: Fri, 10 Apr 2015 19:59:00 +0200
Message-ID: <1428688742-15578-5-git-send-email-b.zolnierkie@samsung.com>
References: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1428688742-15578-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, Sachin Kamat <sachin.kamat@linaro.org>, b.zolnierkie@samsung.com, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, Andreas Faerber <afaerber@suse.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

For Exynos4x12 platforms, add CPU operating points and CPU
regulator supply properties for migrating from Exynos specific
cpufreq driver to using generic cpufreq driver.

Based on the earlier work by Thomas Abraham.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andreas Farber <afaerber@suse.de>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos4212.dtsi               |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    4 ++++
 arch/arm/boot/dts/exynos4412-origen.dts         |    5 +++++
 arch/arm/boot/dts/exynos4412-trats2.dts         |    5 +++++
 arch/arm/boot/dts/exynos4412.dtsi               |   22 ++++++++++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 5be0328..f97e4b5 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -30,6 +30,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1400000 1287500
+				1300000 1250000
+				1200000 1187500
+				1100000 1137500
+				1000000 1087500
+				 900000 1037500
+				 800000 1000000
+				 700000  987500
+				 600000  975000
+				 500000  950000
+				 400000  925000
+				 300000  900000
+				 200000  900000
+			>;
+			boost-opps = <
+				1500000 1350000
+			>;
+			clock-latency = <200000>;
 			cooling-min-level = <13>;
 			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 8de12af..86f3830 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -504,3 +504,7 @@
 		samsung,pin-pud = <1>;
 	};
 };
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index bd8b730..a9c957c 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -532,3 +532,8 @@
 		};
 	};
 };
+
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 173ffa4..47f9b47 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -1304,3 +1304,8 @@
 		PIN_SLP(gpv4-0, INPUT, DOWN);
 	};
 };
+
+
+&cpu0 {
+	cpu0-supply = <&buck2_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 68ad43b..903981e8 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -30,6 +30,28 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
 			reg = <0xA00>;
+			clocks = <&clock CLK_ARM_CLK>;
+			clock-names = "cpu";
+
+			operating-points = <
+				1400000 1287500
+				1300000 1250000
+				1200000 1187500
+				1100000 1137500
+				1000000 1087500
+				 900000 1037500
+				 800000 1000000
+				 700000  987500
+				 600000  975000
+				 500000  950000
+				 400000  925000
+				 300000  900000
+				 200000  900000
+			>;
+			boost-opps = <
+				1500000 1350000
+			>;
+			clock-latency = <200000>;
 			cooling-min-level = <13>;
 			cooling-max-level = <7>;
 			#cooling-cells = <2>; /* min followed by max */
-- 
1.7.9.5
