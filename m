From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/7] Revert "staging: board: disable as it breaks the build"
Date: Wed, 17 Jun 2015 10:38:50 +0200
Message-ID: <1434530336-15073-2-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, devel@driverdev.osuosl.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.

Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
fixed the build of drivers/staging/board/board.c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
  - Add Reviewed-by.
---
 drivers/staging/board/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/board/Kconfig b/drivers/staging/board/Kconfig
index 0a89ad16371f7ded..b8ee81840666ad35 100644
--- a/drivers/staging/board/Kconfig
+++ b/drivers/staging/board/Kconfig
@@ -1,7 +1,6 @@
 config STAGING_BOARD
 	bool "Staging Board Support"
 	depends on OF_ADDRESS
-	depends on BROKEN
 	help
 	  Select to enable per-board staging support code.
 
-- 
1.9.1
