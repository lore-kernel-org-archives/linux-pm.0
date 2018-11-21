From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 6/6] arm: dts: exynos4: set opp-suspend for DMC and leftbus
Date: Wed, 21 Nov 2018 19:01:41 +0100
Message-ID: <1542823301-23563-7-git-send-email-l.luba@partner.samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Mark the state for devfreq device while entring suspend/resume process.

The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch address them keeping in mind suggestions
from Chanwoo Choi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 2 ++
 arch/arm/boot/dts/exynos4412.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b6091c2..4429b72 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -298,6 +298,7 @@
 			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <1150000>;
+				opp-suspend;
 			};
 		};
 
@@ -367,6 +368,7 @@
 			};
 			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
+				opp-suspend;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 51f72f0..908c0c4 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -432,6 +432,7 @@
 			opp-400000000 {
 				opp-hz = /bits/ 64 <400000000>;
 				opp-microvolt = <1050000>;
+				opp-suspend;
 			};
 		};
 
@@ -520,6 +521,7 @@
 			opp-200000000 {
 				opp-hz = /bits/ 64 <200000000>;
 				opp-microvolt = <1000000>;
+				opp-suspend;
 			};
 		};
 
-- 
2.7.4
