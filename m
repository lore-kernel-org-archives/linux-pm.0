From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM / clock_ops: Fix clock error check in __pm_clk_add()
Date: Fri,  8 May 2015 10:47:43 +0200
Message-ID: <1431074863-19124-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:49086 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbEHIrq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 04:47:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Grygorii Strashko <Grygorii.Strashko@linaro.org>, Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

In the final iteration of commit 245bd6f6af8a62a2 ("PM / clock_ops: Add
pm_clk_add_clk()"), a refcount increment was added by Grygorii Strashko.
However, the accompanying IS_ERR() check operates on the wrong clock
pointer, which is always zero at this point, i.e. not an error.
This may lead to a NULL pointer dereference later, when __clk_get()
tries to dereference an error pointer.

Check the passed clock pointer instead to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 245bd6f6af8a62a2 ("PM / clock_ops: Add pm_clk_add_clk()")
---
Note that there are no users of pm_clk_add_clk() in next-20150508, so
for now no in-tree code is affected.
---
 drivers/base/power/clock_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 7fdd0172605afe1b..c7b0fcebf168cabe 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -93,7 +93,7 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
 			return -ENOMEM;
 		}
 	} else {
-		if (IS_ERR(ce->clk) || !__clk_get(clk)) {
+		if (IS_ERR(clk) || !__clk_get(clk)) {
 			kfree(ce);
 			return -ENOENT;
 		}
-- 
1.9.1

