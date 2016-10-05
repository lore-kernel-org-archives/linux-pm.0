From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Wed,  5 Oct 2016 17:51:12 +0200
Message-ID: <20161005155112.13774-2-hdegoede@redhat.com>
References: <20161005155112.13774-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31783 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754261AbcJEPvW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 11:51:22 -0400
In-Reply-To: <20161005155112.13774-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hans de Goede <hdegoede@redhat.com>

The i2c subsys does not load modules by compatible, only by
i2c-id, with e.g. a modalias of: "i2c:axp209".

Populate the axp20x_i2c_id[] table with supported ids, so that
module auto-loading will work.

Reported-by: Dennis Gilmore <dennis@ausil.us>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x-i2c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index b1b8658..d35a5fe 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -69,10 +69,11 @@ static const struct of_device_id axp20x_i2c_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, axp20x_i2c_of_match);
 
-/*
- * This is useless for OF-enabled devices, but it is needed by I2C subsystem
- */
 static const struct i2c_device_id axp20x_i2c_id[] = {
+	{ "axp152", 0 },
+	{ "axp202", 0 },
+	{ "axp209", 0 },
+	{ "axp221", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, axp20x_i2c_id);
-- 
2.9.3

