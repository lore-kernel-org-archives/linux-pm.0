From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 06/12] ARM: dts: r8a7793: Add SYSC PM Domains
Date: Fri, 22 Apr 2016 11:07:28 +0200
Message-ID: <1461316054-27999-7-git-send-email-geert+renesas@glider.be>
References: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461316054-27999-1-git-send-email-geert+renesas@glider.be>
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
Cc: devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add a device node for the System Controller.
Hook up the first Cortex-A15 CPU core and the Cortex-A15 L2 cache/SCU to
their respective PM Domains.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v6:
  - Add Acked-by,

v5:
  - Remove "power-domains" property again from the sysc node, as the
    System Controller itself is not part of the Clock Domain,

v4:
  - Add "power-domains" property to the sysc node, to refer to the SoC's
    Clock Domain,

v3:
  - Drop power area hiearchy from DT,
  - Switch to "#power-domain-cells = <1>",
  - Drop fallback compatibility strings,

v2:
  - Change one-line summary prefix to match current arm-soc practices,
  - Update compatible values.
---
 arch/arm/boot/dts/r8a7793.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index 6186179fd66db6b2..53e235e3279d08c1 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/r8a7793-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/power/r8a7793-sysc.h>
 
 / {
 	compatible = "renesas,r8a7793";
@@ -43,6 +44,7 @@
 			voltage-tolerance = <1>; /* 1% */
 			clocks = <&cpg_clocks R8A7793_CLK_Z>;
 			clock-latency = <300000>; /* 300 us */
+			power-domains = <&sysc R8A7793_PD_CA15_CPU0>;
 
 			/* kHz - uV - OPPs unknown yet */
 			operating-points = <1500000 1000000>,
@@ -76,6 +78,7 @@
 
 	L2_CA15: cache-controller@0 {
 		compatible = "cache";
+		power-domains = <&sysc R8A7793_PD_CA15_SCU>;
 		cache-unified;
 		cache-level = <2>;
 	};
@@ -1223,6 +1226,12 @@
 		};
 	};
 
+	sysc: system-controller@e6180000 {
+		compatible = "renesas,r8a7793-sysc";
+		reg = <0 0xe6180000 0 0x0200>;
+		#power-domain-cells = <1>;
+	};
+
 	ipmmu_sy0: mmu@e6280000 {
 		compatible = "renesas,ipmmu-r8a7793", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
-- 
1.9.1
