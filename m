From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/3] thermal: exynos: Document number of supported trip-points
Date: Thu, 18 Feb 2016 14:14:19 +0900
Message-ID: <1455772460-20684-2-git-send-email-k.kozlowski@samsung.com>
References: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1455772460-20684-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Document the number of configurable temperature thresholds (for
trip-points in interrupt-driven mode).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 Documentation/devicetree/bindings/thermal/exynos-thermal.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 34315d7fbfde..faa62059b5c5 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -44,6 +44,14 @@
 - vtmu-supply: This entry is optional and provides the regulator node supplying
 		voltage to TMU. If needed this entry can be placed inside
 		board/platform specific dts file.
+
+The Exynos TMU supports generating interrupts when reaching given
+temperature thresholds. Number of supported thermal trip points depends
+on the SoC (only first trip points defined in DT will be configured):
+ - most of SoC: 4
+ - samsung,exynos5433-tmu: 8
+ - samsung,exynos7-tmu: 8
+
 Following properties are mandatory (depending on SoC):
 - samsung,tmu_gain: Gain value for internal TMU operation.
 - samsung,tmu_reference_voltage: Value of TMU IP block's reference voltage
-- 
2.5.0
