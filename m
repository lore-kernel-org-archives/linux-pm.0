From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/3] Documentation: dt: Add TI SCI clock driver
Date: Fri, 19 Aug 2016 19:33:40 -0500
Message-ID: <20160820003342.13599-2-nm@ti.com>
References: <20160820003342.13599-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160820003342.13599-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Add a clock implementation, TI SCI clock, that will hook to the common
clock framework, and allow each clock to be controlled via TI SCI
protocol.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/clock/ti,sci-clk.txt       | 51 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,sci-clk.txt

diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
new file mode 100644
index 000000000000..231cb80a058e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
@@ -0,0 +1,51 @@
+Texas Instruments TI-SCI Clocks
+===============================
+
+All clocks on Texas Instruments' SoCs that contain a System Controller,
+are only controlled by this entity. Communication between a host processor
+running an OS and the System Controller happens through a protocol known
+as TI-SCI[1]. This clock implementation plugs into the common clock
+framework and makes use of the TI-SCI protocol on clock API requests.
+
+[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+
+Required properties:
+-------------------
+- compatible: Must be "ti,sci-clk"
+- #clock-cells: Shall be 2.
+  In clock consumers, this cell represents the device ID and clock ID
+  exposed by the PM firmware. The assignments can be found in the header
+  files <dt-bindings/genpd/<soc>.h> (which covers the device IDs) and
+  <dt-bindings/clock/<soc>.h> (which covers the clock IDs), where <soc>
+  is the SoC involved, for example 'k2g'.
+- ti,sci: Phandle to the TI SCI device to use for managing the clocks
+
+Optional properties:
+-------------------
+- ti,ssc-clocks: Array of phandle clocks that shall enable spread spectrum
+		 clocking while enabled
+- ti,allow-freq-change-clocks: Array of phandle clocks that shall allow
+			       dynamic clock frequency changes by firmware
+- ti,input-term-clocks: Array of phandle clocks that shall enable input
+			termination
+
+Examples:
+--------
+
+k2g_clks: k2g_clks {
+	compatible = "ti,sci-clk";
+	ti,sci = <&pmmc>;
+	#clock-cells = <2>;
+};
+
+dummy_node@1234 {
+	clocks = <&k2g_clks K2G_DEV_DUMMY K2G_DEV_DUMMY_FCK>;
+};
+
+dummy_node2@2345 {
+	clocks = <&k2g_clks K2G_DEV_DUMMY2 K2G_DEV_DUMMY_X1_CLK>;
+};
+
+&k2g_clks {
+	ti,ssc-clocks = <&k2g_clks K2G_DEV_DUMMY K2G_DEV_DUMMY_FCK>;
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 448f6801bd78..1837b98d96a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11576,6 +11576,7 @@ F:	include/linux/soc/ti/ti_sci_protocol.h
 F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 F:	include/dt-bindings/genpd/k2g.h
 F:	drivers/soc/ti/ti_sci_pm_domains.c
+F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.9.1.200.gb1ec08f
