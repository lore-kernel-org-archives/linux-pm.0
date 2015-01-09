From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 3/4] drivers: bus: Add Simple Power-Managed Bus DT Bindings
Date: Fri,  9 Jan 2015 14:12:34 +0100
Message-ID: <1420809155-4015-4-git-send-email-geert+renesas@glider.be>
References: <1420809155-4015-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1420809155-4015-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
v3:
  - Add Tested-by,
  - Document required properties inherited from "simple-bus",
  - Document required "reg" property for "renesas,bsc",
  - Move "ranges" before "reg" in the example,

v2:
  - New.
---
 .../devicetree/bindings/bus/simple-pm-bus.txt      | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/simple-pm-bus.txt

diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.txt b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
new file mode 100644
index 0000000000000000..d03abf7fd8e3997a
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.txt
@@ -0,0 +1,52 @@
+Simple Power-Managed Bus
+========================
+
+A Simple Power-Managed Bus is a transparent bus that doesn't need a real
+driver, as it's typically initialized by the boot loader.
+
+However, its bus controller is part of a PM domain, or under the control of a
+functional clock.  Hence, the bus controller's PM domain and/or clock must be
+enabled for child devices connected to the bus (either on-SoC or externally)
+to function.
+
+
+Generic compatible values and properties
+----------------------------------------
+
+Required properties:
+  - compatible: Must be at least one of the vendor-specific compatible values
+		from a vendor-specific section below, and "simple-bus" as a
+		fallback.
+  - #address-cells, #size-cells, ranges: Must describe the mapping between
+		parent address and child address spaces.
+
+Optional platform-specific properties for clock or PM domain control (at least
+one of them is required):
+  - clocks: Must contain a reference to the functional clock(s),
+  - power-domains: Must contain a reference to the PM domain.
+
+
+Vendor-specific compatible values and properties
+------------------------------------------------
+
+Renesas Bus State Controller (BSC):
+  - compatible: Must be an SoC-specific value, and "renesas,bsc" as a fallback.
+                SoC-specific values can be:
+		"renesas,bsc-r8a73a4" for R-Mobile APE6 (r8a73a4)
+		"renesas,bsc-sh73a0" for SH-Mobile AG5 (sh73a0)
+  - reg: Must contain the base address and length to access the bus controller.
+  - interrupts: Must contain a reference to the BSC interrupt, if available.
+
+
+Example:
+
+	bsc: bus@fec10000 {
+		compatible = "renesas,bsc-sh73a0", "renesas,bsc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x20000000>;
+		reg = <0xfec10000 0x400>;
+		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&zb_clk>;
+		power-domains = <&pd_a4s>;
+	};
-- 
1.9.1
