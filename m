From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0015/1529] Fix typo
Date: Sat, 21 May 2016 13:37:22 +0200
Message-ID: <20160521113722.32053-1-andrea.gelmini@gelma.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@hellion.org.uk, galak@codeaurora.org, kgene@kernel.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
index 3e36c1d..616428a 100644
--- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
+++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
@@ -8,7 +8,7 @@ use to analyze system performance, to make behaviors visible and to count
 usages of each IP (DMC, CPU, RIGHTBUS, LEFTBUS, CAM interface, LCD, G3D, MFC).
 The Exynos PPMU driver uses the devfreq-event class to provide event data
 to various devfreq devices. The devfreq devices would use the event data when
-derterming the current state of each IP.
+determing the current state of each IP.
 
 Required properties:
 - compatible: Should be "samsung,exynos-ppmu" or "samsung,exynos-ppmu-v2.
-- 
2.8.2.534.g1f66975
