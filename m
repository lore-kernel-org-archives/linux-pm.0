From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] power: bq27xxx_battery: signedness bug in
 bq27xxx_battery_read_health()
Date: Mon, 28 Sep 2015 12:16:53 +0300
Message-ID: <20150928091653.GA11367@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25621 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757191AbbI1JSg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2015 05:18:36 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

We need flags to be signed for the error handling to work.

Fixes: 74aab849f342 ('power: bq27xxx_battery: Cleanup health checking')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
