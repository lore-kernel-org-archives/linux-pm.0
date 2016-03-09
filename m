From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 1/7] PM / Domains: Add DT bindings for the R-Car System Controller
Date: Wed,  9 Mar 2016 20:18:36 +0100
Message-ID: <1457551122-21838-2-git-send-email-geert+renesas@glider.be>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457551122-21838-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The Renesas R-Car System Controller provides power management for the
CPU cores and various coprocessors, following the generic PM domain
bindings in Documentation/devicetree/bindings/power/power_domain.txt.

This supports R-Car Gen1 (H1), Gen2, and Gen3.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v3:
  - Move power area hierarchy from DT to C (cfr. DT bindings for Renesas
    CPG/MSSR), and switch to "#power-domain-cells = <1>",
  - Drop fallback compatibility strings, as the bindings are
    SoC-specific,
  - Rename from renesas,sysc-rcar.txt to renesas,rcar-sysc.txt,

v2:
  - Add R-Car H3 (r8a7795) support,
  - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
  - Add fallback compatibility strings for R-Car Gen2 and Gen3.
---
 .../bindings/power/renesas,rcar-sysc.txt           | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
new file mode 100644
index 0000000000000000..1765fd37c3658b60
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
@@ -0,0 +1,48 @@
+DT bindings for the Renesas R-Car System Controller
+
+== System Controller Node ==
+
+The R-Car System Controller provides power management for the CPU cores and
+various coprocessors.
+
+Required properties:
+  - compatible: Must contain one or more of the following:
+      - "renesas,r8a7779-sysc" (R-Car H1)
+      - "renesas,r8a7790-sysc" (R-Car H2)
+      - "renesas,r8a7791-sysc" (R-Car M2-W)
+      - "renesas,r8a7792-sysc" (R-Car V2H)
+      - "renesas,r8a7793-sysc" (R-Car M2-N)
+      - "renesas,r8a7794-sysc" (R-Car E2)
+      - "renesas,r8a7795-sysc" (R-Car H3)
+  - reg: Address start and address range for the device.
+  - #power-domain-cells: Must be 1.
+
+
+Example:
+
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7791-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
+
+== PM Domain Consumers ==
+
+Devices residing in a power area must refer to that power area, as documented
+by the generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
+
+Required properties:
+  - power-domains: A phandle and symbolic PM domain specifier, as defined in
+		   <dt-bindings/power/r8a77*-sysc.h>.
+
+
+Example:
+
+	L2_CA15: cache-controller@0 {
+		compatible = "cache";
+		power-domains = <&sysc R8A7791_PD_CA15_SCU>;
+		cache-unified;
+		cache-level = <2>;
+	};
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
