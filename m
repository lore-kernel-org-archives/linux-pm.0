From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] bq2415x_charger: Delete unnecessary checks before the
 function call "of_node_put"
Date: Fri, 6 Nov 2015 16:56:33 +0100
Message-ID: <563CCDB1.1040703@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:57869 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121AbbKFP5L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Nov 2015 10:57:11 -0500
In-Reply-To: <5317A59D.4@users.sourceforge.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 6 Nov 2015 16:48:46 +0100

The of_node_put() function tests whether its argument is NULL and then
returns immediately. Thus the test around the calls is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/power/bq2415x_charger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/power/bq2415x_charger.c b/drivers/power/bq2415x_charger.c
index 4afd768..27e8953 100644
--- a/drivers/power/bq2415x_charger.c
+++ b/drivers/power/bq2415x_charger.c
@@ -1704,7 +1704,7 @@ error_4:
 error_3:
 	bq2415x_power_supply_exit(bq);
 error_2:
-	if (bq && bq->notify_node)
+	if (bq)
 		of_node_put(bq->notify_node);
 	kfree(name);
 error_1:
@@ -1724,9 +1724,7 @@ static int bq2415x_remove(struct i2c_client *client)
 	if (bq->nb.notifier_call)
 		power_supply_unreg_notifier(&bq->nb);
 
-	if (bq->notify_node)
-		of_node_put(bq->notify_node);
-
+	of_node_put(bq->notify_node);
 	bq2415x_sysfs_exit(bq);
 	bq2415x_power_supply_exit(bq);
 
-- 
2.6.2

