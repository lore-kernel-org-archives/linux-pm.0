From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/6] Revert "staging: board: disable as it breaks the build"
Date: Fri,  3 Apr 2015 14:41:58 +0200
Message-ID: <1428064923-24950-2-git-send-email-geert+renesas@glider.be>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.

Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
fixed the build of drivers/staging/board/board.c.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
