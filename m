From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] ARM: shmobile: r8a7740 dtsi: Add missing 0x prefix to SYSC reg lengths
Date: Thu,  4 Dec 2014 13:31:38 +0100
Message-ID: <1417696298-27740-3-git-send-email-geert+renesas@glider.be>
References: <1417696298-27740-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1417696298-27740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The register lengths of the sysc device node were supposed to be 0x8000,
not 8000.
This doesn't cause any problems for now, but at least the second range
is documented to cover the full 32 KiB.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 95723764431a3e5d..52f2cf4b84d3ccb4 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -578,7 +578,7 @@
 
 	sysc: system-controller@e6180000 {
 		compatible = "renesas,sysc-r8a7740", "renesas,sysc-rmobile";
-		reg = <0xe6180000 8000>, <0xe6188000 8000>;
+		reg = <0xe6180000 0x8000>, <0xe6188000 0x8000>;
 
 		pm-domains {
 			pd_c5: c5 {
-- 
1.9.1

