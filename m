From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/7] staging: board: Initialize staging board code earlier
Date: Wed, 17 Jun 2015 10:38:51 +0200
Message-ID: <1434530336-15073-3-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: devel@driverdev.osuosl.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Currently the staging board code is initialized from a late_initcall().
However, unused PM domains are also disabled from a late_initcall(),
which happens before due to link order.

Change the initialization of staging board code from using
late_initcall() to device_initcall() to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop RFC status.
---
 drivers/staging/board/board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/board/board.h b/drivers/staging/board/board.h
index 2390ed6c31a42f2f..e9c914985d4acb36 100644
--- a/drivers/staging/board/board.h
+++ b/drivers/staging/board/board.h
@@ -15,6 +15,6 @@ static int __init runtime_board_check(void)	\
 	return 0;				\
 }						\
 						\
-late_initcall(runtime_board_check)
+device_initcall(runtime_board_check)
 
 #endif /* __BOARD_H__ */
-- 
1.9.1
