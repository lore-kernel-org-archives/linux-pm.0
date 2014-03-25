From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v5 08/14] ARM: dts: mvebu: Introduce a new compatible for the PMSU node
Date: Tue, 25 Mar 2014 23:48:19 +0100
Message-ID: <1395787705-31061-9-git-send-email-gregory.clement@free-electrons.com>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The initial binding for PMSU were wrong. It didn't take into account
all the registers from the PMSU and in the other hand refereed to
registers which are not part of PMSU. This commit introduces a new
compatible for the PMSU node and annotates the previous one as
obsolete. However we still continue to support it during a few
releases.

Cc: devicetree@vger.kernel.org
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../devicetree/bindings/arm/armada-370-xp-pmsu.txt         | 14 ++++++--------
 arch/arm/boot/dts/armada-xp.dtsi                           | 11 ++++++++---
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
index 926b4d6aae7e..976188770079 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
@@ -4,17 +4,15 @@ Available on Marvell SOCs: Armada 370 and Armada XP
 
 Required properties:
 
-- compatible: "marvell,armada-370-xp-pmsu"
+- compatible: should be "marvell,armada-370-pmsu", whereas
+  "marvell,armada-370-xp-pmsu" is deprecated and will be removed
 
-- reg: Should contain PMSU registers location and length. First pair
-  for the per-CPU SW Reset Control registers, second pair for the
-  Power Management Service Unit.
+- reg: Should contain PMSU registers location and length.
 
 Example:
 
-armada-370-xp-pmsu@d0022000 {
-	compatible = "marvell,armada-370-xp-pmsu";
-	reg = <0xd0022100 0x430>,
-	      <0xd0020800 0x20>;
+armada-370-xp-pmsu@22000 {
+	compatible = "marvell,armada-370-pmsu";
+	reg = <0x22000 0x1000>;
 };
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index abb9f9dcc525..0c455f5458df 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -117,9 +117,14 @@
 				clock-names = "nbclk", "fixed";
 			};
 
-			armada-370-xp-pmsu@22000 {
-				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x400>, <0x20800 0x20>;
+			cpurst@20800 {
+				compatible = "marvell,armada-xp-cpu-reset";
+				reg = <0x20800 0x20>;
+			};
+
+			armada-370-pmsu@22000 {
+				compatible = "marvell,armada-370-pmsu";
+				reg = <0x22000 0x400>;
 			};
 
 			eth2: ethernet@30000 {
-- 
1.8.1.2
