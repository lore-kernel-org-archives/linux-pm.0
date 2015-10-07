From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 3/4] power:bq27x00: don't fill system log by missing battery
Date: Wed,  7 Oct 2015 20:42:38 +0200
Message-ID: <73cb8d96728805597ecb50e7e7b51bf6272b6d61.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:50101 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbJGSsn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:48:43 -0400
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, NeilBrown <neilb@suse.de>, "H. Nikolaus Schaller" <hns@goldelico.com>

From: NeilBrown <neilb@suse.de>

Print message that battery is not calibrated only during debug build but
not during normal operation.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/bq27x00_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 8287261f..709d1e4 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -491,7 +491,7 @@ static void bq27x00_update(struct bq27x00_device_info *di)
 	if (cache.flags >= 0) {
 		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
 				&& (cache.flags & BQ27000_FLAG_CI)) {
-			dev_info(di->dev, "battery is not calibrated! ignoring capacity values\n");
+			dev_dbg(di->dev, "battery is not calibrated! ignoring capacity values\n");
 			cache.capacity = -ENODATA;
 			cache.energy = -ENODATA;
 			cache.time_to_empty = -ENODATA;
-- 
2.5.1

