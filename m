From: Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v2 1/2] dt-bindings: thermal: rcar: Add device tree support for r8a7743
Date: Tue, 19 Dec 2017 13:17:28 +0000
Message-ID: <1513689449-2700-2-git-send-email-biju.das@bp.renesas.com>
References: <1513689449-2700-1-git-send-email-biju.das@bp.renesas.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:56717 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752426AbdLSNTl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Dec 2017 08:19:41 -0500
In-Reply-To: <1513689449-2700-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>

Add thermal sensor support for r8a7743 SoC. The Renesas RZ/G1M
(r8a7743) thermal sensor module is identical to the R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,rcar-gen2-thermal".

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v1->v2
  * No Change

 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index a8e52c8..349e635 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -6,6 +6,7 @@ Required properties:
 			   "renesas,rcar-thermal" (without thermal-zone) as fallback.
 			  Examples with soctypes are:
 			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
+			    - "renesas,thermal-r8a7743" (RZ/G1M)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
 			    - "renesas,thermal-r8a7791" (R-Car M2-W)
-- 
1.9.1
