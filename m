From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] PM / Domains: R-Mobile SYSC: Add missing 0x prefixes to example
Date: Thu,  4 Dec 2014 13:31:37 +0100
Message-ID: <1417696298-27740-2-git-send-email-geert+renesas@glider.be>
References: <1417696298-27740-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1417696298-27740-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The register lengths in the example were supposed to be 0x8000, not
8000.
This doesn't cause any problems for now, but at least the second range
is documented to cover the full 32 KiB on R-Mobile A1 (r8a7740).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index 5887cbae313481cc..2460476808e9333e 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -53,7 +53,7 @@ which is a subdomain of A4S.
 
 	sysc: system-controller@e6180000 {
 		compatible = "renesas,sysc-r8a7740", "renesas,sysc-rmobile";
-		reg = <0xe6180000 8000>, <0xe6188000 8000>;
+		reg = <0xe6180000 0x8000>, <0xe6188000 0x8000>;
 
 		pm-domains {
 			pd_c5: c5 {
-- 
1.9.1

