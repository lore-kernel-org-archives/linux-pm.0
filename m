From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] thermal: armada: fix formula documentation comment
Date: Thu, 14 Sep 2017 18:06:57 +0300
Message-ID: <53d5154c1a52b9b973c4386df8b851d10c97f9ad.1505401617.git.baruch@tkos.co.il>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:48996 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751131AbdINPHc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Sep 2017 11:07:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

The formula implementation at armada_get_temp() indicates that the sign
in the formula is inverted.

Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/thermal/armada_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index ae75328945f7..706d74798cbe 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -58,7 +58,7 @@ struct armada_thermal_data {
 	/* Test for a valid sensor value (optional) */
 	bool (*is_valid)(struct armada_thermal_priv *);
 
-	/* Formula coeficients: temp = (b + m * reg) / div */
+	/* Formula coeficients: temp = (b - m * reg) / div */
 	unsigned long coef_b;
 	unsigned long coef_m;
 	unsigned long coef_div;
-- 
2.14.1
