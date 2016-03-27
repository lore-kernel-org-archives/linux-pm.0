From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v6 09/21] PM / devfreq: exynos: Add the detailed correlation
 between sub-blocks and power line
Date: Mon, 28 Mar 2016 08:37:58 +0900
Message-ID: <1459121890-4601-10-git-send-email-cw00.choi@samsung.com>
References: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1459121890-4601-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the detailed corrleation between sub-blocks and power line
for Exynos3250, Exynos4210 and Exynos4x12.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index 03f13d38f1a1..b098fa2ba5d4 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -53,6 +53,57 @@ Optional properties only for parent bus device:
 - exynos,voltage-tolerance: the percentage value for bus voltage tolerance
 			which is used to calculate the max voltage.
 
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
