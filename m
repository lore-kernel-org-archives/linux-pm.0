From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/6] PM / Domains: R-Mobile SYSC: Document SH-Mobile AG5 (sh73a0) binding
Date: Wed, 14 Jan 2015 13:11:19 +0100
Message-ID: <1421237484-16847-2-git-send-email-geert+renesas@glider.be>
References: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421237484-16847-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

SH-Mobile AG5 (sh73a0) can be handled by the existing bindings.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes
---
 Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
index 2460476808e9333e..cc3b1f0a9b1a2b75 100644
--- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
+++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.txt
@@ -12,6 +12,7 @@ Required properties:
 	      fallback.
 	      Examples with soctypes are:
 		- "renesas,sysc-r8a7740" (R-Mobile A1)
+		- "renesas,sysc-sh73a0" (SH-Mobile AG5)
 - reg: Two address start and address range blocks for the device:
          - The first block refers to the normally accessible registers,
          - the second block refers to the registers protected by the HPB
-- 
1.9.1

