From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] power: supply: ab8500_charger: Bail out in case of error in 'ab8500_charger_init_hw_registers()'
Date: Wed, 22 Nov 2017 21:31:20 +0100
Message-ID: <20171122203120.13467-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:58636 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbdKVUbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Nov 2017 15:31:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If an error occurs when we enable the backup battery charging, we should
go through the error handling path directly.

Before commit db43e6c473b5 ("ab8500-bm: Add usb power path support") this
was the case, but this commit has added some code between the last test and
the 'out' label.
So, in case of error, this added code is executed and the error may be
silently ignored.

Fix it by adding the missing 'goto out', as done in all other error
handling paths.

Fixes: db43e6c473b5 ("ab8500-bm: Add usb power path support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/power/supply/ab8500_charger.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 1cdbe7a0738d..5a76c6d343de 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3221,8 +3221,10 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 	ret = abx500_mask_and_set_register_interruptible(di->dev,
 		AB8500_RTC, AB8500_RTC_CTRL_REG,
 		RTC_BUP_CH_ENA, RTC_BUP_CH_ENA);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(di->dev, "%s mask and set failed\n", __func__);
+		goto out;
+	}
 
 	if (is_ab8540(di->parent)) {
 		ret = abx500_mask_and_set_register_interruptible(di->dev,
-- 
2.14.1
