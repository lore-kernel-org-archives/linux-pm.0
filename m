From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 04/16] power: supply: axp288_charger: Cleanup some double empty lines
Date: Tue, 26 Dec 2017 13:59:02 +0100
Message-ID: <20171226125914.10235-4-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZM7U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:20 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

While we are doing cleanups, also remove some double blank lines.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 5d8308c8835d..03f502e012c3 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -261,7 +261,6 @@ static inline int axp288_charger_set_vbus_inlmt(struct axp288_chrg_info *info,
 	else
 		dev_err(&info->pdev->dev, "charger BAK control %d\n", ret);
 
-
 set_inlmt_fail:
 	return ret;
 }
@@ -281,7 +280,6 @@ static int axp288_charger_vbus_path_select(struct axp288_chrg_info *info,
 	if (ret < 0)
 		dev_err(&info->pdev->dev, "axp288 vbus path select %d\n", ret);
 
-
 	return ret;
 }
 
-- 
2.14.3
