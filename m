From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 10/20] PM / devfreq: exynos: Add the detailed correlation
 between sub-blocks and power line
Date: Mon, 14 Dec 2015 15:38:14 +0900
Message-ID: <1450075104-13705-11-git-send-email-cw00.choi@samsung.com>
References: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1450075104-13705-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the detailed corrleation between sub-blocks and power line
for Exynos3250, Exynos4210 and Exynos4x12.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index a251f9120561..f3a32b310dc7 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -51,6 +51,57 @@ Optional properties only for parent bus device:
 - exynos,saturation-ratio: the percentage value which is used to calibrate
                    the performance count against total cycle count.
 
+Detailed correlation between sub-blocks and power line according to Exynos SoC:
+- In case of Exynos3250, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC
+		|--- G3D
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- FSYS
+		|--- LCD0
+		|--- PERIR
+		|--- ISP
+		|--- CAM
+
+- In case of Exynos4210, there is one power line as following:
+	VDD_INT |--- DMC (parent device)
+		|--- LEFTBUS
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- LCD0
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- LCD1
+
+- In case of Exynos4x12, there are two power line as following:
+	VDD_MIF |--- DMC
+
+	VDD_INT |--- LEFTBUS (parent device)
+		|--- PERIL
+		|--- MFC(L)
+		|--- G3D
+		|--- TV
+		|--- IMAGE
+		|--- RIGHTBUS
+		|--- PERIR
+		|--- MFC(R)
+		|--- CAM
+		|--- FSYS
+		|--- GPS
+		|--- LCD0
+		|--- ISP
+
 Example1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-- 
1.9.1
