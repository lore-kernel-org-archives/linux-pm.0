From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2] ARM: dts: r8a7791: Move enable-method to CPU nodes
Date: Tue, 14 May 2019 10:58:37 +0200
Message-ID: <20190514085837.18325-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

According to Documentation/devicetree/bindings/arm/cpus.yaml, the
"enable-method" property should be a property of the individual CPU
nodes, and not of the parent "cpus" container node.
However, on R-Car M2-W, the property is tied to the "cpus" node instead.

Secondary CPU bringup and CPU hot (un)plug work regardless, as
arm_dt_init_cpu_maps() falls back to looking in the "cpus" node.

The cpuidle code does not have such a fallback, so it does not detect
the enable-method.  Note that cpuidle does not support the
"renesas,apmu" enable-method yet, so for now this does not make any
difference.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Arm64 and powerpc do not have such a fallback, but SH has, like arm32.

This is marked RFC, as the alternative is to update the DT bindings to
keep the status quo.

v2:
  - Update reference after commit 672951cbd1b70a9e ("dt-bindings: arm:
    Convert cpu binding to json-schema").
---
 arch/arm/boot/dts/r8a7791.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 6f875502453cf40a..a8266e76d7e50739 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -68,7 +68,6 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		enable-method = "renesas,apmu";
 
 		cpu0: cpu@0 {
 			device_type = "cpu";
@@ -77,6 +76,7 @@
 			clock-frequency = <1500000000>;
 			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
 			power-domains = <&sysc R8A7791_PD_CA15_CPU0>;
+			enable-method = "renesas,apmu";
 			next-level-cache = <&L2_CA15>;
 			voltage-tolerance = <1>; /* 1% */
 			clock-latency = <300000>; /* 300 us */
@@ -97,6 +97,7 @@
 			clock-frequency = <1500000000>;
 			clocks = <&cpg CPG_CORE R8A7791_CLK_Z>;
 			power-domains = <&sysc R8A7791_PD_CA15_CPU1>;
+			enable-method = "renesas,apmu";
 			next-level-cache = <&L2_CA15>;
 			voltage-tolerance = <1>; /* 1% */
 			clock-latency = <300000>; /* 300 us */
-- 
2.17.1
