From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] MAINTAINERS: Drop drivers/sh/ for Renesas ARM
Date: Tue, 16 Feb 2016 16:31:52 +0100
Message-ID: <1455636712-3040-5-git-send-email-geert+renesas@glider.be>
References: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

None of the code under drivers/sh/ is used anymore on Renesas ARM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc2f753cb357a067..a1d03cb4cab49fae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1558,7 +1558,6 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
-F:	drivers/sh/
 
 ARM/SOCFPGA ARCHITECTURE
 M:	Dinh Nguyen <dinguyen@opensource.altera.com>
-- 
1.9.1

