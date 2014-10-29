From: Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v2 3/4] mfd: tps65910: Convert poweroff-source DT property to system-power-controller
Date: Wed, 29 Oct 2014 07:35:34 +0000
Message-ID: <1414568135-8311-4-git-send-email-romain.perier@gmail.com>
References: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:49263 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbaJ2Hc1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Oct 2014 03:32:27 -0400
In-Reply-To: <1414568135-8311-1-git-send-email-romain.perier@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: grant.likely@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, johan@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 drivers/mfd/tps65910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index b8dca8a..77a7f78 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -423,7 +423,7 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 
 	board_info->irq = client->irq;
 	board_info->irq_base = -1;
-	board_info->pm_off = of_system_has_poweroff_source(np);
+	board_info->pm_off = of_is_system_power_controller(np);
 
 	return board_info;
 }
-- 
1.9.1

