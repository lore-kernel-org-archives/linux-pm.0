From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/4] restore bq27000 code of v4.3-rc4
Date: Wed,  7 Oct 2015 20:42:36 +0200
Message-ID: <e94ee6deea6f194215927e188d97d1d28ebd00bb.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:65144 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbbJGSmr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 14:42:47 -0400
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
In-Reply-To: <cover.1444243358.git.hns@goldelico.com>
References: <cover.1444243358.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/bq27x00_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index 709d1e4..8287261f 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -491,7 +491,7 @@ static void bq27x00_update(struct bq27x00_device_info *di)
 	if (cache.flags >= 0) {
 		if (!is_bq27500 && !is_bq27425 && !is_bq27742 && !is_bq27510
 				&& (cache.flags & BQ27000_FLAG_CI)) {
-			dev_dbg(di->dev, "battery is not calibrated! ignoring capacity values\n");
+			dev_info(di->dev, "battery is not calibrated! ignoring capacity values\n");
 			cache.capacity = -ENODATA;
 			cache.energy = -ENODATA;
 			cache.time_to_empty = -ENODATA;
-- 
2.5.1

