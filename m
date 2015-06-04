From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 01/15] PM / Domains: Add DT bindings for the R-Car System
 Controller
Date: Thu,  4 Jun 2015 20:53:27 +0200
Message-ID: <1433444021-22167-2-git-send-email-geert+renesas@glider.be>
References: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1433444021-22167-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The Renesas R-Car System Controller provides power management for the
CPU cores and various coprocessors, following the generic PM domain
bindings in Documentation/devicetree/bindings/power/power_domain.txt.

This supports both R-Car Gen1 and Gen2.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Alternatives I considered:

  - Using a single node per power register block, even if it contains
    multiple domains.
      - You cannot just have a property with the number of domains, as
	index 0 is not used on R-Car H1. Hence the need for
	"renesas,pm-domain-indices" and "renesas,interrupt-bits",
      - "#power-domain-cells = <1>" for nodes with multiple domains,
	which allows typos in "power-domains = <&pd_ca15_cpu n>", using
	an invalid value of "n",
      - Hence my first version had:

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

  - Using a linear description in DT
      - Needs parent links for subdomains,
      - More complicated to parse (lesson learned from R-Mobile PM
	Domain support).
  - Keeping the power register block offset and the bit number as separate
    "reg" cells, increasing "#address-cells" from 2 to 3,
  - Merging the interrupt bit (which needs only 5 bits) in the other "reg"
    cell, decreasing "#address-cells" from 2 to 1.

 .../bindings/power/renesas,sysc-rcar.txt           | 82 ++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
new file mode 100644
index 0000000000000000..72d2fcd6beb98749
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
@@ -0,0 +1,82 @@
+DT bindings for the Renesas R-Car System Controller
+
+== System Controller Node ==
+
+The R-Car System Controller provides power management for the CPU cores and
+various coprocessors.
+
+Required properties:
+  - compatible: Should be "renesas,sysc-<soctype>", "renesas,sysc-rcar" as
+	      fallback.
+	      Examples with soctypes are:
+		- "renesas,sysc-r8a7779" (R-Car H1)
+		- "renesas,sysc-r8a7790" (R-Car H2)
+		- "renesas,sysc-r8a7791" (R-Car M2-W)
+		- "renesas,sysc-r8a7793" (R-Car M2-N)
+		- "renesas,sysc-r8a7794" (R-Car E2)
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
+		compatible = "renesas,sysc-r8a7791", "renesas,sysc-rcar";
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
