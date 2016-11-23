From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC 4/4] ARM: dts: exynos4x12: add suspend OPP for DMC and leftbus
Date: Wed, 23 Nov 2016 14:51:27 +0100
Message-ID: <1479909087-22659-5-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

TODO: write desc
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 arch/arm/boot/dts/exynos4x12.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index d5cb433..a00a8b0 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -375,6 +375,7 @@
 		opp@400000000 {
 			opp-hz = /bits/ 64 <400000000>;
 			opp-microvolt = <1050000>;
+			opp-suspend;
 		};
 	};
 
@@ -463,6 +464,7 @@
 		opp@200000000 {
 			opp-hz = /bits/ 64 <200000000>;
 			opp-microvolt = <1000000>;
+			opp-suspend;
 		};
 	};
 
-- 
2.7.3
