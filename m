From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 1/8] PM / devfreq: exynos-bus: Add the detailed correlation
 for Exynos5433
Date: Wed, 28 Dec 2016 20:56:45 +0900
Message-ID: <1482926212-19223-2-git-send-email-cw00.choi@samsung.com>
References: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
 <CGME20161228115654epcas1p13fa3cb3615ddf89ebdf747c72b60d809@epcas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58637 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbcL1L45 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 06:56:57 -0500
In-reply-to: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org

This patch adds the detailed corrleation between sub-blocks and VDD_INT power
line for Exynos5433. VDD_INT provided the power source to INT (Internal) block.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
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

