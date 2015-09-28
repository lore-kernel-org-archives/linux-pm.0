From: Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH] fix handling bq27xxx_read result
Date: Mon, 28 Sep 2015 10:51:27 +0200
Message-ID: <1443430287-575-1-git-send-email-a.hajda@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:31888 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbbI1IwK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 04:52:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "open list:POWER SUPPLY CLASS/SUBSYSTEM and
	DRIVERS" <linux-pm@vger.kernel.org>

The function can return negative value.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/power/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 473aa2f..994c78d 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -691,7 +691,7 @@ static bool bq27xxx_battery_dead(struct bq27xxx_device_info *di, u16 flags)
  */
 static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 {
-	u16 flags;
+	int flags;
 
 	flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, false);
 	if (flags < 0) {
-- 
1.9.1

