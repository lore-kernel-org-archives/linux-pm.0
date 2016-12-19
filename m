From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 14/14] power: supply: axp288_charger: Fix the module not auto-loading
Date: Mon, 19 Dec 2016 01:07:31 +0100
Message-ID: <20161219000731.10188-15-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

Add a MODULE_DEVICE_TABLE to fix the module not auto-loading.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 9b93453..6165663 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -854,8 +854,15 @@ static int axp288_charger_probe(struct platform_device *pdev)
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
