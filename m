From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 09/12] ARM: dts: Exynos5420/5800: add cluster regulator supply
 properties
Date: Wed,  2 Dec 2015 22:19:24 +0100
Message-ID: <1449091167-20758-10-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
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
Cc: Doug Anderson <dianders@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, Ben Gamari <ben@smart-cactus.org>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, b.zolnierkie@samsung.com, linux-samsung-soc@vger.kernel.org, Andreas Faerber <afaerber@suse.de>, Javier Martinez Canillas <javier@dowhile0.org>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Add cluster regulator supply properties as a preparation to adding
generic arm_big_little_dt cpufreq driver support for Exynos5420 and
Exynos5800 based boards.

Changes by Ben Gamari:
- Add regulators to odroidxu4

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |  9 +++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |  8 ++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |  8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts    |  8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts    | 10 ++++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |  8 ++++++++
 6 files changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 4ecef69..a044da7 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -52,6 +52,15 @@
 	};
 };
 
+&cpu0 {
+  cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+  cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 72ba6f0..eea0aa6 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -676,6 +676,14 @@
 	};
 };
 
+&cpu0 {
+  cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+  cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index ac35aef..d44a280 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -423,3 +423,11 @@
 &usbdrd_phy1 {
 	vbus-supply = <&usb301_vbus_reg>;
 };
+
+&cpu0 {
+  cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+  cpu-cluster.1-supply = <&buck6_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 0c0bbdb..d6650a1 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -53,6 +53,14 @@
 	};
 };
 
+&cpu0 {
+  cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+  cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 2faf886..9f88c34 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -32,6 +32,16 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 49a4f43..a06587b 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -638,6 +638,14 @@
 	};
 };
 
+&cpu0 {
+  cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+  cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
-- 
2.6.2
