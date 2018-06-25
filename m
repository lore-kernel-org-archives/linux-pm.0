From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 22/23] arm64: dts: marvell: add macro to make distinction
 between node names
Date: Mon, 25 Jun 2018 17:12:38 +0200
Message-ID: <20180625151239.20976-23-miquel.raynal@bootlin.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625151239.20976-1-miquel.raynal@bootlin.com>
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

Because the label is different between CPs, the full path of a node is
unique. However, when referring to the end of the path only (the node
name), this name is not unique anymore.

The *thermal_zone_of_sensor_register() functions of the thermal core
present this limitation and prevent having a thermal-zone per CP.

Add a macro to make the distinction between node names to solve this
situation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-common.dtsi b/arch/arm64/boot/dts/marvell/armada-common.dtsi
index d5e8aedec188..b29c6405d214 100644
--- a/arch/arm64/boot/dts/marvell/armada-common.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-common.dtsi
@@ -7,4 +7,5 @@
 #define PASTER(x, y) x ## y
 #define EVALUATOR(x, y) PASTER(x, y)
 #define CP110_LABEL(name) EVALUATOR(CP110_NAME, EVALUATOR(_, name))
+#define CP110_NODE_NAME(name) EVALUATOR(CP110_NAME, EVALUATOR(-, name))
 #define ADDRESSIFY(addr) EVALUATOR(0x, addr)
-- 
2.14.1
