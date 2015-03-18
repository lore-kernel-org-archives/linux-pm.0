From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 3/7] irqchip: renesas-irqc: Add functional clock to bindings
Date: Wed, 18 Mar 2015 19:55:57 +0100
Message-ID: <1426704961-27322-4-git-send-email-geert+renesas@glider.be>
References: <1426704961-27322-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426704961-27322-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The external IRQ controller has a functional clock, which is used for
power management. Document it.

Fix a typo in the r8a73a4 SoC name while we're at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 .../devicetree/bindings/interrupt-controller/renesas,irqc.txt         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index 1a88e62228e59631..4f85aeb658e4c833 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -4,7 +4,7 @@ Required properties:
 
 - compatible: has to be "renesas,irqc-<soctype>", "renesas,irqc" as fallback.
   Examples with soctypes are:
-    - "renesas,irqc-r8a73a4" (R-Mobile AP6)
+    - "renesas,irqc-r8a73a4" (R-Mobile APE6)
     - "renesas,irqc-r8a7790" (R-Car H2)
     - "renesas,irqc-r8a7791" (R-Car M2-W)
     - "renesas,irqc-r8a7792" (R-Car V2H)
@@ -12,6 +12,7 @@ Required properties:
     - "renesas,irqc-r8a7794" (R-Car E2)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
   interrupts.txt in this directory
+- clocks: Must contain a reference to the functional clock.
 
 Optional properties:
 
@@ -29,4 +30,5 @@ Example:
 			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 3 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp4_clks R8A7790_CLK_IRQC>;
 	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
