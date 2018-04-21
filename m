From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 20/27] dt-bindings: thermal: armada: add reference to new
 bindings
Date: Sat, 21 Apr 2018 17:12:48 +0200
Message-ID: <20180421151255.29929-21-miquel.raynal@bootlin.com>
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

New bindings (with the syscon and the overheat interrupt) are available
for AP806 and CP110 compatibles. Add a reference to these files from the
original documentation.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 Documentation/devicetree/bindings/thermal/armada-thermal.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
index e0d013a2e66d..f3b441100890 100644
--- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
@@ -10,6 +10,11 @@ Required properties:
     * marvell,armada-ap806-thermal
     * marvell,armada-cp110-thermal
 
+Note: these bindings are deprecated for AP806/CP110 and should instead
+follow the rules described in:
+Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
+
 - reg: Device's register space.
   Two entries are expected, see the examples below. The first one points
   to the status register (4B). The second one points to the control
-- 
2.14.1
