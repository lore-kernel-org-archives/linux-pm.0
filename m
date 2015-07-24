From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 2/2] PM / devfreq: exynos-ppmu: Update documentation to
 support PPMUv2
Date: Fri, 24 Jul 2015 13:17:25 +0900
Message-ID: <1437711445-7386-3-git-send-email-cw00.choi@samsung.com>
References: <1437711445-7386-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1437711445-7386-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: kgene@kernel.org, k.kozlowski@samsung.com, cw00.choi@samsung.com, dan.carpenter@oracle.com, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch updates the documentation to include the information of PPMUv2.
The PPMUv2 is used for Exynos5433 and Exynos7420 to monitor the performance
of each IP in Exynos SoC.

Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../bindings/devfreq/event/exynos-ppmu.txt         | 42 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index b54bf3a2ff57..e8fa6b6a1827 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -11,7 +11,7 @@ to various devfreq devices. The devfreq devices would use the event data when
 derterming the current state of each IP.
 
 Required properties:
-- compatible: Should be "samsung,exynos-ppmu".
+- compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
 - reg: physical base address of each PPMU and length of memory mapped region.
 
 Optional properties:
@@ -19,7 +19,7 @@ Optional properties:
 - clocks : phandles for clock specified in "clock-names" property
 - #clock-cells: should be 1.
 
-Example1 : PPMU nodes in exynos3250.dtsi are listed below.
+Example1 : PPMUv1 nodes in exynos3250.dtsi are listed below.
 
 		ppmu_dmc0: ppmu_dmc0@106a0000 {
 			compatible = "samsung,exynos-ppmu";
@@ -108,3 +108,41 @@ Example2 : Events of each PPMU node in exynos3250-rinato.dts are listed below.
 			};
 		};
 	};
+
+Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
+
+		ppmu_d0_cpu: ppmu_d0_cpu@10480000 {
+			compatible = "samsung,exynos-ppmu-v2";
+			reg = <0x10480000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_d0_general: ppmu_d0_general@10490000 {
+			compatible = "samsung,exynos-ppmu-v2";
+			reg = <0x10490000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_d0_rt: ppmu_d0_rt@104a0000 {
+			compatible = "samsung,exynos-ppmu-v2";
+			reg = <0x104a0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_d1_cpu: ppmu_d1_cpu@104b0000 {
+			compatible = "samsung,exynos-ppmu-v2";
+			reg = <0x104b0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_d1_general: ppmu_d1_general@104c0000 {
+			compatible = "samsung,exynos-ppmu-v2";
+			reg = <0x104c0000 0x2000>;
+			status = "disabled";
+		};
+
+		ppmu_d1_rt: ppmu_d1_rt@104d0000 {
+			compatible = "samsung,exynos-ppmu-v2";
+			reg = <0x104d0000 0x2000>;
+			status = "disabled";
+		};
-- 
1.8.5.5
