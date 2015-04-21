From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 7/8] ARM: dts: Exynos5800: fix CPU OPP
Date: Tue, 21 Apr 2015 17:49:04 +0200
Message-ID: <1429631345-16409-8-git-send-email-b.zolnierkie@samsung.com>
References: <1429631345-16409-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1429631345-16409-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Fix CPU operating points for Exynos5800 (it uses different
voltages than Exynos5420 and supports additional frequencies).
However don't use 2000MHz & 1900MHz OPPs (for A15 cores) and
1400MHz OPP (for A7 cores) until there is a separate DTS for
ODROID-XU3 Lite board (which doesn't support these higher
OPPs).

Based on Hardkernel's kernel for ODROID-XU3 board.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi |   39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..ba7ecd2 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -19,6 +19,45 @@
 	compatible = "samsung,exynos5800", "samsung,exynos5";
 };
 
+&cpu0 {
+	operating-points = <
+		1800000 1250000
+		1700000 1250000
+		1600000 1250000
+		1500000 1100000
+		1400000 1100000
+		1300000 1100000
+		1200000 1000000
+		1100000 1000000
+		1000000 1000000
+		 900000 1000000
+		 800000  900000
+		 700000  900000
+		 600000  900000
+		 500000  900000
+		 400000  900000
+		 300000  900000
+		 200000  900000
+	>;
+};
+
+&cpu4 {
+	operating-points = <
+		1300000 1250000
+		1200000 1250000
+		1100000 1250000
+		1000000 1100000
+		 900000 1100000
+		 800000 1100000
+		 700000 1000000
+		 600000 1000000
+		 500000 1000000
+		 400000 1000000
+		 300000  900000
+		 200000  900000
+	>;
+};
+
 &clock {
 	compatible = "samsung,exynos5800-clock";
 };
-- 
1.7.9.5
