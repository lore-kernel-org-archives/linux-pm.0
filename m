From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] thermal: rcar: Add binding docs for new R-Car Gen2 SoCs
Date: Thu, 28 Aug 2014 10:12:32 +0200
Message-ID: <1409213552-5713-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:37638 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935386AbaH1IMe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 04:12:34 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

  - r8a7792 (R-Car V2H)
  - r8a7793 (R-Car M2-N)
  - r8a7794 (R-Car E2)

r8a7791 is now called "R-Car M2-W".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2: Drop RFC
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index 0ef00be44b01..43404b197933 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -7,7 +7,10 @@ Required properties:
 			    - "renesas,thermal-r8a73a4" (R-Mobile AP6)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
-			    - "renesas,thermal-r8a7791" (R-Car M2)
+			    - "renesas,thermal-r8a7791" (R-Car M2-W)
+			    - "renesas,thermal-r8a7792" (R-Car V2H)
+			    - "renesas,thermal-r8a7793" (R-Car M2-N)
+			    - "renesas,thermal-r8a7794" (R-Car E2)
 - reg			: Address range of the thermal registers.
 			  The 1st reg will be recognized as common register
 			  if it has "interrupts".
-- 
1.9.1

