From: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 2/3] watchdog: renesas-wdt: add support for rza
Date: Thu, 16 Feb 2017 12:23:19 -0500
Message-ID: <20170216172320.10897-3-chris.brandt@renesas.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170216172320.10897-1-chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Describe the WDT hardware in the RZ/A series.

Signed-off-by: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
v2:
* added to renesas-wdt.txt instead of creating a new file
* changed commit title
* added "renesas,rza-wdt" as a fallback
* added interrupts property
---
 Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
index da24e31..9e306af 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
@@ -2,10 +2,11 @@ Renesas Watchdog Timer (WDT) Controller
 
 Required properties:
 - compatible : Should be "renesas,<soctype>-wdt", and
-	       "renesas,rcar-gen3-wdt" as fallback.
+	       "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
 	       Examples with soctypes are:
 	         - "renesas,r8a7795-wdt" (R-Car H3)
 	         - "renesas,r8a7796-wdt" (R-Car M3-W)
+	         - "renesas,r7s72100-wdt" (RZ/A1)
 
   When compatible with the generic version, nodes must list the SoC-specific
   version corresponding to the platform first, followed by the generic
@@ -17,6 +18,7 @@ Required properties:
 Optional properties:
 - timeout-sec : Contains the watchdog timeout in seconds
 - power-domains : the power domain the WDT belongs to
+- interrupts: Some WDTs have an interrupt when used in interval timer mode
 
 Examples:
 
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
