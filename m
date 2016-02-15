From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 01/11] PM / Domains: Add DT bindings for the R-Car System Controller
Date: Mon, 15 Feb 2016 22:16:50 +0100
Message-ID: <1455571020-18968-2-git-send-email-geert+renesas@glider.be>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The Renesas R-Car System Controller provides power management for the
CPU cores and various coprocessors, following the generic PM domain
bindings in Documentation/devicetree/bindings/power/power_domain.txt.

This supports R-Car Gen1, Gen2, and Gen3.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Alternatives I considered:

  - Using a single node per power register block, even if it contains
    multiple domains, e.g.:

	    pd_ca15_scu: ca15_scu@180 {
		    reg = <0x180 0x20>;
		    #address-cells = <1>;
		    #size-cells = <0>;
		    #power-domain-cells = <0>;
		    renesas,interrupt-bits = <12>;

		    pd_ca15_cpu: ca15_cpu@40 {
			    reg = <0x40 0x20>;
			    #power-domain-cells = <1>;
			    renesas,pm-domain-indices = <0 1>;
			    renesas,pm-domain-names =
				    "ca15_cpu0", "ca15_cpu1";
			    renesas,interrupt-bits = <0 1>;
		    };
	    };

    Notes:
      - You cannot just have a property with the number of domains, as
	index 0 is not used on R-Car H1. Hence the need for
	"renesas,pm-domain-indices" and "renesas,interrupt-bits",
      - "#power-domain-cells = <1>" for nodes with multiple domains,
	which allows typos in "power-domains = <&pd_ca15_cpu n>", using
	an invalid value of "n".

  - Using a linear description in DT:
      - Needs parent links for subdomains,
      - More complicated to parse (lesson learned from R-Mobile PM
	Domain support).

  - Keeping the power register block offset and the bit number as separate
    "reg" cells, increasing "#address-cells" from 2 to 3,

  - Merging the interrupt bit (which needs only 5 bits) in the other "reg"
    cell, decreasing "#address-cells" from 2 to 1.

v2:
  - Add R-Car H3 (r8a7795) support,
  - Use "renesas,<type>-sysc" instead of "renesas,sysc-<type>",
  - Add fallback compatibility strings for R-Car Gen2 and Gen3.
---
 .../bindings/power/renesas,sysc-rcar.txt           | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
new file mode 100644
index 0000000000000000..92ddc0da7b755215
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
@@ -0,0 +1,87 @@
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
+      - "renesas,rcar-gen2-sysc" (Generic R-Car Gen2)
+      - "renesas,rcar-gen3-sysc" (Generic R-Car Gen3)
+    When compatible with the generic version, nodes must list the SoC-specific
+    version corresponding to the platform first, followed by the generic
+    version.
+  - reg: Address start and address range for the device.
+  - pm-domains: This node contains a hierarchy of PM Domain Nodes.
+    Dependencies (e.g. parent SCUs should not be powered off while child CPUs
+    are on) should be reflected using subnodes.
+
+
+== PM Domain Nodes ==
+
+Each of the PM domain nodes represents a PM domain, as documented by the
+generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
+
+Required properties:
+  - #power-domain-cells: Must be 0.
+  - reg: This property must contain 2 values:
+	   - The first value is the number of the interrupt bit representing
+	     the power area in the various Interrupt Registers (e.g. SYSCISR,
+	     Interrupt Status Register),
+	   - The second value encodes the power register block offset (which is
+	     a multiple of 64), and the number of the bit representing the
+	     power area in the various Power Control Registers (e.g. PWROFFSR,
+	     Power Shutoff Status Register). This value is created by ORing
+	     these two numbers.
+	 The parent's node must contain the following two properties:
+	   - #address-cells: Must be 2,
+	   - #size-cells: Must be 0.
+
+
+Example:
+
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7791-sysc", "renesas,rcar-gen2-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+
+		pm-domains {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			pd_ca15_scu: scu@12 {
+				reg = <12 0x180>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+				#power-domain-cells = <0>;
+
+				pd_ca15_cpu0: cpu@0 {
+					reg = <0 0x40>;
+					#power-domain-cells = <0>;
+				};
+
+				pd_ca15_cpu1: cpu@1 {
+					reg = <1 0x41>;
+					#power-domain-cells = <0>;
+				};
+			};
+
+			pd_sh: sh@16 {
+				reg = <16 0x80>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sgx: sgx@20 {
+				reg = <20 0xc0>;
+				#power-domain-cells = <0>;
+			};
+		};
+	};
-- 
1.9.1
