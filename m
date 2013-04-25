From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v2 1/4] ARM: dts: thermal: exynos4: TMU device tree support for
 Exynos4412 targets
Date: Thu, 25 Apr 2013 14:30:42 +0200
Message-ID: <1366893045-31586-2-git-send-email-l.majewski@samsung.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
 <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1366893045-31586-1-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Device tree support for TMU at Exynos4x12 targets.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changes for v2:
- None
---
 arch/arm/boot/dts/exynos4x12.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index e3380a7..ee920b3 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -79,4 +79,14 @@
 		interrupts = <0 89 0>;
 		status = "disabled";
 	};
+
+	tmu@100C0000 {
+		compatible = "samsung,exynos4412-tmu";
+		interrupt-parent = <&combiner>;
+		reg = <0x100C0000 0x100>;
+		interrupts = <2 4>;
+		clocks = <&clock 383>;
+		clock-names = "tmu_apbif";
+		status = "disabled";
+	};
 };
-- 
1.7.10.4
