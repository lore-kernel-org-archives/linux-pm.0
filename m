From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v4 07/13] ARM: dts: mvebu: Add a new set of registers to the PMSU node
Date: Thu, 13 Feb 2014 18:33:30 +0100
Message-ID: <1392312816-17657-8-git-send-email-gregory.clement@free-electrons.com>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392312816-17657-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The Power Management Unit Service block also controls the Coherency
Fabric subsystem. This new set of registers is needed for the CPU idle
implementation for the Armada XP, it allows to enter in a deep CPU
idle state where the Coherency Fabric and the L2 cache are powerdown.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt | 12 +++++++-----
 arch/arm/boot/dts/armada-xp.dtsi                             |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
index 926b4d6aae7e..8a9db0c32ba5 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
@@ -7,14 +7,16 @@ Required properties:
 - compatible: "marvell,armada-370-xp-pmsu"
 
 - reg: Should contain PMSU registers location and length. First pair
-  for the per-CPU SW Reset Control registers, second pair for the
-  Power Management Service Unit.
+  for the per-CPU SW Reset Control registers, second pair for the CPU
+  Power Management Service Unit registers, third pair for the Fabric Power
+  Management Service Unit registers.
 
 Example:
 
-armada-370-xp-pmsu@d0022000 {
+armada-370-xp-pmsu@22000 {
 	compatible = "marvell,armada-370-xp-pmsu";
-	reg = <0xd0022100 0x430>,
-	      <0xd0020800 0x20>;
+	reg = <0x22100 0x430>,
+	      <0x20800 0x20>,
+	      <0x22000 0x24>;
 };
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index b8b84a22f0f3..f717da4f4d97 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -113,7 +113,7 @@
 
 			armada-370-xp-pmsu@22000 {
 				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x400>, <0x20800 0x20>;
+				reg = <0x22100 0x400>, <0x20800 0x20>, <0x22000 0x24>;
 			};
 
 			eth2: ethernet@30000 {
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
