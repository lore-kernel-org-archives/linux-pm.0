From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 12/12] ARM: dts: mvebu: Add a new set of registers to the PMSU node
Date: Fri, 13 Sep 2013 12:06:41 +0200
Message-ID: <1379066801-16276-13-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379066801-16276-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>, Atsushi Yamagata <yamagata-SisyDS/t9hATBYAz+LHnZg@public.gmane.org>, Hironobu Shibata <h-shibata-SisyDS/t9hATBYAz+LHnZg@public.gmane.org>, Tomonori Kimura <kimura-SisyDS/t9hATBYAz+LHnZg@public.gmane.org>
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
index 926b4d6..8a9db0c 100644
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
index def125c..c79cd53 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -48,7 +48,7 @@
 
 			armada-370-xp-pmsu@22000 {
 				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x430>, <0x20800 0x20>;
+				reg = <0x22100 0x430>, <0x20800 0x20>, <0x22000 0x24>;
 			};
 
 			serial@12200 {
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
