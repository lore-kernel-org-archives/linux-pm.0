From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 1/7] PM / Domains: Add DT bindings for the R-Car System Controller
Date: Wed, 13 Apr 2016 16:44:17 +0200
Message-ID: <1460558663-10197-2-git-send-email-geert+renesas@glider.be>
References: <1460558663-10197-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460558663-10197-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The Renesas R-Car System Controller provides power management for the
CPU cores and various coprocessors, following the generic PM domain
bindings in Documentation/devicetree/bindings/power/power_domain.txt.

This supports R-Car Gen1 (H1), Gen2, and Gen3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v5:
  - Remove power-domains property from the sysc node again, as the
    System Controller itself is not part of the Clock Domain,

v4:
  - Add Reviewed-by, Acked-by,
  - Compatible value must contain "exactly one" instead of "one or
    more",
  - Add power-domains property to refer to the SoC's Clock Domain,

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
index 0000000000000000..b74e4d4785ab2d60
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
+  - compatible: Must contain exactly one of the following:
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
