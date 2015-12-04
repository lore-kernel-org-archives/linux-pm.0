From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 02/10] ARM: dts: Exynos5420/5800: add cluster regulator
 supply properties
Date: Fri, 04 Dec 2015 18:30:27 +0100
Message-ID: <1449250235-9613-3-git-send-email-b.zolnierkie@samsung.com>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Add cluster regulator supply properties as a preparation to
adding generic arm_big_little_dt cpufreq driver support for
Exynos5420 and Exynos5800 based boards.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   | 8 ++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts      | 8 ++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts       | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      | 8 ++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      | 8 ++++++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts       | 8 ++++++++
 7 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 4ecef69..24b8a35 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -52,6 +52,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &usbdrd_dwc3_1 {
 	dr_mode = "host";
 };
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 35cfb07..2b74230 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -676,6 +676,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index ac35aef..9e2dc5f 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -423,3 +423,11 @@
 &usbdrd_phy1 {
 	vbus-supply = <&usb301_vbus_reg>;
 };
+
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
index 2ae1cf4..6f1de7c 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts
@@ -54,6 +54,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
index 432406d..6b64122 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
@@ -53,6 +53,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
 &i2c_0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 2faf886..516a40f 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -32,6 +32,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
 &pwm {
 	/*
 	 * PWM 0 -- fan
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7b018e4..34aaaacd 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -638,6 +638,14 @@
 	};
 };
 
+&cpu0 {
+	cpu-cluster.0-supply = <&buck2_reg>;
+};
+
+&cpu4 {
+	cpu-cluster.1-supply = <&buck6_reg>;
+};
+
 &i2c_2 {
 	status = "okay";
 	samsung,i2c-sda-delay = <100>;
-- 
1.9.1
