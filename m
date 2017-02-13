From: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] dt-bindings: power: reset: add document for renesas-reset driver
Date: Mon, 13 Feb 2017 13:25:31 -0500
Message-ID: <20170213182532.4042-3-chris.brandt@renesas.com>
References: <20170213182532.4042-1-chris.brandt@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170213182532.4042-1-chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add device tree bindings document for renesas-reset driver.
This driver uses the WDT hardware to issue an immediate reset.

Signed-off-by: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 .../devicetree/bindings/power/reset/renesas-reset.txt     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/renesas-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/renesas-reset.txt b/Documentation/devicetree/bindings/power/reset/renesas-reset.txt
new file mode 100644
index 0000000..241722d
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/renesas-reset.txt
@@ -0,0 +1,15 @@
+Device-Tree bindings for Renesas WDT reset functionality
+
+Required properties:
+  - compatible: must be one or more of the following:
+    - "renesas,r7s72100-reset" for the r7s72100 SoC
+    - "renesas,wdt-reset"
+                This is a fallback for the above renesas,*-reset entries
+
+  - reg: base address and length of the WDT register block
+
+Example node:
+	wdt: timer@fcfe0000 {
+		compatible = "renesas,r7s72100-reset", "renesas,wdt-reset";
+		reg = <0xfcfe0000 0x6>;
+	};
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
