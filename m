From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 4/5] drivers: bus: Add Renesas Bus State Controller (BSC)
 DT Bindings
Date: Thu,  5 Feb 2015 11:11:27 +0100
Message-ID: <1423131088-7835-5-git-send-email-geert+renesas@glider.be>
References: <1423131088-7835-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1423131088-7835-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Felipe Balbi <balbi@ti.com>
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The bindings for the BSC extend the bindings for "simple-pm-bus".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Kevin Hilman <khilman@linaro.org>
---
v5:
  - Add Reviewed-by,

v4:
  - New, extracted from simple-pm-bus.txt in v3.
---
 .../devicetree/bindings/bus/renesas,bsc.txt        | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/renesas,bsc.txt

diff --git a/Documentation/devicetree/bindings/bus/renesas,bsc.txt b/Documentation/devicetree/bindings/bus/renesas,bsc.txt
new file mode 100644
index 0000000000000000..90e94726943772c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/renesas,bsc.txt
@@ -0,0 +1,46 @@
+Renesas Bus State Controller (BSC)
+==================================
+
+The Renesas Bus State Controller (BSC, sometimes called "LBSC within Bus
+Bridge", or "External Bus Interface") can be found in several Renesas ARM SoCs.
+It provides an external bus for connecting multiple external devices to the
+SoC, driving several chip select lines, for e.g. NOR FLASH, Ethernet and USB.
+
+While the BSC is a fairly simple memory-mapped bus, it may be part of a PM
+domain, and may have a gateable functional clock.
+Before a device connected to the BSC can be accessed, the PM domain
+containing the BSC must be powered on, and the functional clock
+driving the BSC must be enabled.
+
+The bindings for the BSC extend the bindings for "simple-pm-bus".
+
+
+Required properties
+  - compatible: Must contain an SoC-specific value, and "renesas,bsc" and
+		"simple-pm-bus" as fallbacks.
+                SoC-specific values can be:
+		"renesas,bsc-r8a73a4" for R-Mobile APE6 (r8a73a4)
+		"renesas,bsc-sh73a0" for SH-Mobile AG5 (sh73a0)
+  - #address-cells, #size-cells, ranges: Must describe the mapping between
+		parent address and child address spaces.
+  - reg: Must contain the base address and length to access the bus controller.
+
+Optional properties:
+  - interrupts: Must contain a reference to the BSC interrupt, if available.
+  - clocks: Must contain a reference to the functional clock, if available.
+  - power-domains: Must contain a reference to the PM domain, if available.
+
+
+Example:
+
+	bsc: bus@fec10000 {
+		compatible = "renesas,bsc-sh73a0", "renesas,bsc",
+			     "simple-pm-bus";
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
