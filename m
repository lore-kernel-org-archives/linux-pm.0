From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH] thermal: rcar: Remove binding docs for r8a7794
Date: Tue, 29 Mar 2016 14:07:45 +0900
Message-ID: <1459228065-18674-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58098 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcC2FIM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 01:08:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>

The latest information that I have is that there is no thermal IP
block present on the r8a7794 SoC so remove the corresponding binding.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index e5ee3f159893..a8e52c8ccfcc 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -11,7 +11,6 @@ Required properties:
 			    - "renesas,thermal-r8a7791" (R-Car M2-W)
 			    - "renesas,thermal-r8a7792" (R-Car V2H)
 			    - "renesas,thermal-r8a7793" (R-Car M2-N)
-			    - "renesas,thermal-r8a7794" (R-Car E2)
 - reg			: Address range of the thermal registers.
 			  The 1st reg will be recognized as common register
 			  if it has "interrupts".
-- 
2.1.4

