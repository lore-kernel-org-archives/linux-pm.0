From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 15/27] dt-bindings: ap806: prepare the syscon file to list
 other syscons nodes
Date: Sat, 21 Apr 2018 17:12:43 +0200
Message-ID: <20180421151255.29929-16-miquel.raynal@bootlin.com>
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

There are multiple system controllers in AP806. Because all syscon nodes
use the same compatible, it is pertinent to use this same file to list
IPs inside it. Thus, change the header to be more generic.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../bindings/arm/marvell/ap806-system-controller.txt           | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 0b887440e08a..a856eb9a4e05 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -2,14 +2,14 @@ Marvell Armada AP806 System Controller
 ======================================
 
 The AP806 is one of the two core HW blocks of the Marvell Armada 7K/8K
-SoCs. It contains a system controller, which provides a number
-registers giving access to numerous features: clocks, pin-muxing and
-many other SoC configuration items. This DT binding allows to describe
-this system controller.
+SoCs. It contains system controllers, which provide several registers
+giving access to numerous features: clocks, pin-muxing and many other
+SoC configuration items. This DT binding allows to describe these
+system controllers.
 
 For the top level node:
  - compatible: must be: "syscon", "simple-mfd";
-  - reg: register area of the AP806 system controller
+ - reg: register area of the AP806 system controller
 
 Clocks:
 -------
-- 
2.14.1
