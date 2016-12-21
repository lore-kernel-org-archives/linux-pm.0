From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 12/12] power: supply: axp288_charger: Fix the module not auto-loading
Date: Wed, 21 Dec 2016 15:36:57 +0100
Message-ID: <20161221143657.322-13-hdegoede@redhat.com>
References: <20161221143657.322-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935545AbcLUOhX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 09:37:23 -0500
In-Reply-To: <20161221143657.322-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Add a MODULE_DEVICE_TABLE to fix the module not auto-loading.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 6e588e6..ca4fa51 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -856,8 +856,15 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id axp288_charger_id_table[] = {
+	{ .name = "axp288_charger" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, axp288_charger_id_table);
+
 static struct platform_driver axp288_charger_driver = {
 	.probe = axp288_charger_probe,
+	.id_table = axp288_charger_id_table,
 	.driver = {
 		.name = "axp288_charger",
 	},
-- 
2.9.3

