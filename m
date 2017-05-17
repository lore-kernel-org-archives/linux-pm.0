From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] power: supply: ltc3651-charger: Fix wrong pointer passed to PTR_ERR()
Date: Wed, 17 May 2017 12:11:32 +0000
Message-ID: <20170517121132.7052-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33341 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753661AbdEQMLl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 08:11:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so1550089pfe.0
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2017 05:11:41 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/power/supply/ltc3651-charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/ltc3651-charger.c
index 5f8d5c0..eea63ff 100644
--- a/drivers/power/supply/ltc3651-charger.c
+++ b/drivers/power/supply/ltc3651-charger.c
@@ -110,21 +110,21 @@ static int ltc3651_charger_probe(struct platform_device *pdev)
 	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
 					"lltc,acpr", GPIOD_IN);
 	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
-		ret = PTR_ERR(ltc3651_charger->charger);
+		ret = PTR_ERR(ltc3651_charger->acpr_gpio);
 		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
 		return ret;
 	}
 	ltc3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
 					"lltc,fault", GPIOD_IN);
 	if (IS_ERR(ltc3651_charger->fault_gpio)) {
-		ret = PTR_ERR(ltc3651_charger->charger);
+		ret = PTR_ERR(ltc3651_charger->fault_gpio);
 		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
 		return ret;
 	}
 	ltc3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
 					"lltc,chrg", GPIOD_IN);
 	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
-		ret = PTR_ERR(ltc3651_charger->charger);
+		ret = PTR_ERR(ltc3651_charger->chrg_gpio);
 		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
 		return ret;
 	}
