From: "Gustavo A. R. Silva" <silvagustavosilva@gmail.com>
Subject: [PATCH] drivers: power: supply: Compress return logic into one line.
Date: Wed, 11 Jan 2017 20:29:35 -0600
Message-ID: <20170112022935.GA22272@embeddedgus>
Reply-To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36447 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdALC3h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 21:29:37 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Simplify return logic to avoid unnecessary variable assignments.
These issues were detected using Coccinelle and the following semantic patch:

@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/power/supply/ab8500_btemp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index 6ffdc18..9b01b52 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -123,10 +123,7 @@ static LIST_HEAD(ab8500_btemp_list);
  */
 struct ab8500_btemp *ab8500_btemp_get(void)
 {
-	struct ab8500_btemp *btemp;
-	btemp = list_first_entry(&ab8500_btemp_list, struct ab8500_btemp, node);
-
-	return btemp;
+	return list_first_entry(&ab8500_btemp_list, struct ab8500_btemp, node);
 }
 EXPORT_SYMBOL(ab8500_btemp_get);
 
@@ -470,7 +467,7 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
 static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
 	const struct abx500_res_to_temp *tbl, int tbl_size, int res)
 {
-	int i, temp;
+	int i;
 	/*
 	 * Calculate the formula for the straight line
 	 * Simple interpolation if we are within
@@ -488,9 +485,8 @@ static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
 			i++;
 	}
 
-	temp = tbl[i].temp + ((tbl[i + 1].temp - tbl[i].temp) *
+	return tbl[i].temp + ((tbl[i + 1].temp - tbl[i].temp) *
 		(res - tbl[i].resist)) / (tbl[i + 1].resist - tbl[i].resist);
-	return temp;
 }
 
 /**
-- 
2.5.0

