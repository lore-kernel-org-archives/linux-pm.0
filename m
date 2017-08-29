From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH resend v2] power: supply: bq27xxx: enable writing capacity values for bq27421
Date: Tue, 29 Aug 2017 22:10:47 +0200
Message-ID: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:20342 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdH2UMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 16:12:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Liam Breck <liam@networkimprov.net>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>

Tested on Pyra prototype with bq27421.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/bq27xxx_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index b6c3120ca5ad..e3c878ef7c7e 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -688,7 +688,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
 #define bq27545_dm_regs 0
 #endif
 
-#if 0 /* not yet tested */
+#if 1 /* tested on Pyra */
 static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
 	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
 	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
-- 
2.12.2
