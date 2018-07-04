From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2] dt-bindings: marvell: Add documentation for the Armada
 3700 AVS binding
Date: Wed,  4 Jul 2018 15:25:24 +0200
Message-ID: <20180704132524.23640-1-gregory.clement@bootlin.com>
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
To: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Hua Jing <jinghua@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>, Victor Gu <xigu@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Extend the documentation of the Armada 37xx SoC with the Adaptive Voltage
Scaling (AVS) registers.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changelog:
v1 -> v2:
 - Add Acked-by: from Viresh Kumar
 - Add the dt mailing list in copy

 .../bindings/arm/marvell/armada-37xx.txt         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
index 35c3c3460d17..22438f659d1e 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
@@ -33,3 +33,19 @@ nb_pm: syscon@14000 {
 	compatible = "marvell,armada-3700-nb-pm", "syscon";
 	reg = <0x14000 0x60>;
 }
+
+AVS
+---
+
+For AVS an other component is needed:
+
+Required properties:
+- compatible     : should contain "marvell,armada-3700-avs", "syscon";
+- reg            : the register start and length for the AVS
+
+Example:
+avs: avs@11500 {
+	compatible = "marvell,armada-3700-avs", "syscon";
+	reg = <0x11500 0x40>;
+}
+
-- 
2.17.1
