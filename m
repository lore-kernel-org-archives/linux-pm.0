From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 13/17] dts: Documentation: Update exynos-thermal.txt example
 for Exynos5440
Date: Fri, 16 Jan 2015 12:30:57 +0100
Message-ID: <1421407861-25099-14-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421407861-25099-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421407861-25099-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Updating exynos-thermal.txt documentation entry for Exynos5440

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v4:
- New patch
---
 Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 8497794..0f44932 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -74,6 +74,7 @@ Example 2):
 		interrupts = <0 58 0>;
 		clocks = <&clock 21>;
 		clock-names = "tmu_apbif";
+		#include "exynos5440-tmu-sensor-conf.dtsi"
 	};
 
 Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
-- 
2.0.0.rc2
