From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] bq2415x_charger: Use common error handling code in
 bq2415x_timer_work()
Date: Mon, 30 Oct 2017 21:50:10 +0100
Message-ID: <48b34d35-8c41-d25b-0cb7-6257b37c5a44@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932153AbdJ3UuR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Oct 2017 16:50:17 -0400
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 30 Oct 2017 21:45:09 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/supply/bq2415x_charger.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index c4770a94cc8e..8385e02e1634 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -914,16 +914,12 @@ static void bq2415x_timer_work(struct work_struct *work)
 	}
 
 	boost = bq2415x_exec_command(bq, BQ2415X_BOOST_MODE_STATUS);
-	if (boost < 0) {
-		bq2415x_timer_error(bq, "Unknown error");
-		return;
-	}
+	if (boost < 0)
+		goto report_timer_error;
 
 	error = bq2415x_exec_command(bq, BQ2415X_FAULT_STATUS);
-	if (error < 0) {
-		bq2415x_timer_error(bq, "Unknown error");
-		return;
-	}
+	if (error < 0)
+		goto report_timer_error;
 
 	if (boost) {
 		switch (error) {
@@ -992,6 +988,10 @@ static void bq2415x_timer_work(struct work_struct *work)
 	}
 
 	schedule_delayed_work(&bq->work, BQ2415X_TIMER_TIMEOUT * HZ);
+	return;
+
+report_timer_error:
+	bq2415x_timer_error(bq, "Unknown error");
 }
 
 /**** power supply interface code ****/
-- 
2.14.3
