From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/7] PM / devfreq: exynos-bus: Add the detailed correlation for
 Exynos5433
Date: Thu, 15 Dec 2016 18:30:37 +0900
Message-ID: <1481794243-5046-2-git-send-email-cw00.choi@samsung.com>
References: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch adds the detailed corrleation between sub-blocks and VDD_INT power
line for Exynos5433. VDD_INT provided the power source to INT (Internal) block.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 Documentation/devicetree/bindings/devfreq/exynos-bus.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index d3ec8e676b6b..d085ef90d27c 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -123,6 +123,20 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
 		|--- FSYS
 		|--- FSYS2
 
+- In case of Exynos5433, there is VDD_INT power line as following:
+	VDD_INT |--- G2D (parent device)
+		|--- MSCL
+		|--- GSCL
+		|--- JPEG
+		|--- MFC
+		|--- HEVC
+		|--- BUS0
+		|--- BUS1
+		|--- BUS2
+		|--- PERIS (Fixed clock rate)
+		|--- PERIC (Fixed clock rate)
+		|--- FSYS  (Fixed clock rate)
+
 Example1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-- 
1.9.1
