From: Colin King <colin.king@canonical.com>
Subject: [PATCH][thermal-next] thermal: brcmstb: remove two redundant integer range checks
Date: Sun,  3 Sep 2017 14:16:19 +0100
Message-ID: <20170903131619.6857-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41110 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdICNQY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Sep 2017 09:16:24 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparisons for integer low on low > INT_MAX and also
integer high > INT_MAX are never going to be true since an
int type cannot be greater than INT_MAX.  Remove these redundant
checks.

Detected by: CoverityScan CID#1455245, 1455248 ("Operands don't affect
  result (CONSTANT_EXPRESSION_RESULT)")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 87b8e7a86ee3..bcb3945feea6 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -278,8 +278,6 @@ static int brcmstb_set_trips(void *data, int low, int high)
 	dev_dbg(priv->dev, "set trips %d <--> %d\n", low, high);
 
 	if (low) {
-		if (low > INT_MAX)
-			low = INT_MAX;
 		avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_LOW, low);
 		avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_LOW, 1);
 	} else {
@@ -287,8 +285,6 @@ static int brcmstb_set_trips(void *data, int low, int high)
 	}
 
 	if (high < ULONG_MAX) {
-		if (high > INT_MAX)
-			high = INT_MAX;
 		avs_tmon_set_trip_temp(priv, TMON_TRIP_TYPE_HIGH, high);
 		avs_tmon_trip_enable(priv, TMON_TRIP_TYPE_HIGH, 1);
 	} else {
-- 
2.14.1
