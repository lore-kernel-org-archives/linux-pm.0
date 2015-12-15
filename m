From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 6/7] ARM: dts: Exynos5800: fix CPU OPP
Date: Tue, 15 Dec 2015 18:33:20 +0100
Message-ID: <1450200801-24539-7-git-send-email-b.zolnierkie@samsung.com>
References: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:40244 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964985AbbLORg5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 12:36:57 -0500
In-reply-to: <1450200801-24539-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>

Fix CPU operating points for Exynos5800 (it use different
voltages than Exynos5420 and supports additional frequencies).
However don't use 2000MHz & 1900MHz OPPs (for A15 cores) and
1400MHz OPP (for A7 cores) for now as they are not available
on all boards.

Based on Hardkernel's kernel for ODROID-XU3 board.

Changes by Ben Gamari:
- Port to operating-points-v2

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Andreas Faerber <afaerber@suse.de>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos5800.dtsi | 108 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5800.dtsi b/arch/arm/boot/dts/exynos5800.dtsi
index c0bb356..8213016 100644
--- a/arch/arm/boot/dts/exynos5800.dtsi
+++ b/arch/arm/boot/dts/exynos5800.dtsi
@@ -23,6 +23,114 @@
 	compatible = "samsung,exynos5800-clock";
 };
 
+&cluster_a15_opp_table {
+	opp@1700000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp@1600000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp@1500000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp@1400000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp@1300000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp@1200000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp@1100000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp@1000000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp@900000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp@800000000 {
+		opp-microvolt = <900000>;
+	};
+	opp@700000000 {
+		opp-microvolt = <900000>;
+	};
+	opp@600000000 {
+		opp-hz = /bits/ 64 <600000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@200000000 {
+		opp-hz = /bits/ 64 <200000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+};
+
+&cluster_a7_opp_table {
+	opp@1300000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp@1200000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp@1100000000 {
+		opp-microvolt = <1250000>;
+	};
+	opp@1000000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp@900000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp@800000000 {
+		opp-microvolt = <1100000>;
+	};
+	opp@700000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp@600000000 {
+		opp-microvolt = <1000000>;
+	};
+	opp@500000000 {
+		opp-hz = /bits/ 64 <500000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@400000000 {
+		opp-hz = /bits/ 64 <400000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@300000000 {
+		opp-hz = /bits/ 64 <300000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+	opp@200000000 {
+		opp-hz = /bits/ 64 <200000000>;
+		opp-microvolt = <900000>;
+		clock-latency-ns = <140000>;
+	};
+};
+
 &mfc {
 	compatible = "samsung,mfc-v8";
 };
-- 
1.9.1

