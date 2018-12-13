From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH] dt-bindings: thermal: rcar-thermal: add R8A774C0 support
Date: Thu, 13 Dec 2018 20:19:48 +0000
Message-ID: <1544732388-6313-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Document RZ/G2E SoC (a.k.a. r8a774c0) bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---

 Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
index 73e1613..a679fb4 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
@@ -4,11 +4,12 @@ Required properties:
 - compatible		: "renesas,thermal-<soctype>",
 			   "renesas,rcar-gen2-thermal" (with thermal-zone) or
 			   "renesas,rcar-thermal" (without thermal-zone) as
-                           fallback except R-Car V3M/D3.
+                           fallback except R-Car V3M/D3 and RZ/G2E.
 			  Examples with soctypes are:
 			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
 			    - "renesas,thermal-r8a7743" (RZ/G1M)
 			    - "renesas,thermal-r8a7744" (RZ/G1N)
+			    - "renesas,thermal-r8a774c0" (RZ/G2E)
 			    - "renesas,thermal-r8a7779" (R-Car H1)
 			    - "renesas,thermal-r8a7790" (R-Car H2)
 			    - "renesas,thermal-r8a7791" (R-Car M2-W)
@@ -23,7 +24,7 @@ Required properties:
 Option properties:
 
 - interrupts		: If present should contain 3 interrupts for
-                          R-Car V3M/D3 or 1 interrupt otherwise.
+                          R-Car V3M/D3 and RZ/G2E or 1 interrupt otherwise.
 
 Example (non interrupt support):
 
-- 
2.7.4
