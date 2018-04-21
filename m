From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 18/27] dt-bindings: cp110: update documentation since DT
 de-duplication
Date: Sat, 21 Apr 2018 17:12:46 +0200
Message-ID: <20180421151255.29929-19-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, David Sniatkiwicz <davidsn@marvell.com>, Rob Herring <robh+dt@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

CP110 master/slave DT files have been merged in a DT de-duplication work
merged in v4.16. Update the syscon documentation accordingly to match
the current state of the DT nodes.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/arm/marvell/cp110-system-controller.txt           | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
index 56e7fb1153e7..54b0d64ce819 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
@@ -163,26 +163,26 @@ Required properties:
 
 Example:
 
-cpm_syscon0: system-controller@440000 {
+CP110_LABEL(syscon0): system-controller@440000 {
 	compatible = "syscon", "simple-mfd";
 	reg = <0x440000 0x1000>;
 
-	cpm_clk: clock {
+	CP110_LABEL(clk): clock {
 		compatible = "marvell,cp110-clock";
 		#clock-cells = <2>;
 	};
 
-	cpm_pinctrl: pinctrl {
+	CP110_LABEL(pinctrl): pinctrl {
 		compatible = "marvell,armada-8k-cpm-pinctrl";
 	};
 
-	cpm_gpio1: gpio@100 {
+	CP110_LABEL(gpio1): gpio@100 {
 		compatible = "marvell,armada-8k-gpio";
 		offset = <0x100>;
 		ngpios = <32>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-ranges = <&cpm_pinctrl 0 0 32>;
+		gpio-ranges = <&CP110_LABEL(pinctrl) 0 0 32>;
 	};
 
 };
-- 
2.14.1
