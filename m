From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/6] staging: board: Initialize staging board code earlier
Date: Fri,  3 Apr 2015 14:41:59 +0200
Message-ID: <1428064923-24950-3-git-send-email-geert+renesas@glider.be>
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

Currently the staging board code is initialized from a late_initcall().
However, unused PM domains are also disabled from a late_initcall(),
which happens before due to link order.

Change the initialization of staging board code from using
late_initcall() to device_initcall() to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
