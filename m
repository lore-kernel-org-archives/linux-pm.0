From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/7] PM / devfreq: exynos: Add the detailed correlation for
 Exynos5422 bus
Date: Fri, 08 Apr 2016 14:00:41 +0900
Message-ID: <1460091646-28701-3-git-send-email-cw00.choi@samsung.com>
References: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:32914 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757044AbcDHFBA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2016 01:01:00 -0400
In-reply-to: <1460091646-28701-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com, kgene@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux.amoon@gmail.com, m.reichl@fivetechno.de, tjakobi@math.uni-bielefeld.de, inki.dae@samsung.com, cw00.choi@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds the detailed corrleation between sub-blocks and power line
for Exynos5422.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 .../devicetree/bindings/devfreq/exynos-bus.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
index b098fa2ba5d4..5a37f51adacf 100644
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
@@ -104,6 +104,25 @@ Detailed correlation between sub-blocks and power line according to Exynos SoC:
 		|--- LCD0
 		|--- ISP
 
+- In case of Exynos5422, there are two power line as following:
+	VDD_MIF |--- DREX 0 (parent device, DRAM EXpress controller)
+	        |--- DREX 1
+
+	VDD_INT |--- NoC_Core (parent device)
+		|--- G2D
+		|--- G3D
+		|--- DISP1
+		|--- NoC_WCORE
+		|--- GSCL
+		|--- MSCL
+		|--- ISP
+		|--- MFC
+		|--- GEN
+		|--- PERIS
+		|--- PERIC
+		|--- FSYS
+		|--- FSYS2
+
 Example1:
 	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
 	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-- 
1.9.1

