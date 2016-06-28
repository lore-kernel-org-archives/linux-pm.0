From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [RFC PATCH 2/5] dt: bindings: add bindings for allwinner a23/33 ths
Date: Tue, 28 Jun 2016 18:13:22 +0800
Message-ID: <20160628101325.2522-2-icenowy@aosc.xyz>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160628101325.2522-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, emilio@elopez.com.ar
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Document the THS on A23/33 SoCs.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 .../devicetree/bindings/thermal/sun8iw3-thermal.txt  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt b/Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt
new file mode 100644
index 0000000..0cdcb9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sun8iw3-thermal.txt
@@ -0,0 +1,20 @@
+* Thermal Sensor (THS) on Allwinner sun8i A23/33 SoCs
+
+Required properties:
+- compatible : should be "allwinner,sun8i-<name>-ths"
+   "allwinner,sun8i-a23-ths": found on A23 SoCs
+   "allwinner,sun8i-a33-ths": found on A33 SoCs
+- reg : physical base address of the controller and length of memory mapped
+	region.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Shall be "pll2", since the THS on A23/33 is using audio PLL (PLL2).
+- #thermal-sensor-cells : Should be 0. See ./thermal.txt for a description.
+
+Example:
+ths: ths@01c25000 {
+	#thermal-sensor-cells = <0>;
+	compatible = "allwinner,sun8i-a23-ths";
+	reg = <0x01c25000 0x44>;
+	clocks = <&pll2 0>;
+	clock-names = "pll2";
+};
-- 
2.9.0
