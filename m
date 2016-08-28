From: Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/2] power: bq24735-charger: Request status GPIO with initial input setup
Date: Sun, 28 Aug 2016 19:34:45 +0200
Message-ID: <20160828173446.32728-1-contact@paulk.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>
List-Id: linux-pm@vger.kernel.org

This requests the status GPIO with initial input setup. it is required
to read the GPIO status at probe time and thus correctly avoid sending
i2c messages when AC is not plugged.

When requesting the GPIO without initial input setup, it always reads 0
which causes probe to fail as it assumes the charger is connected, sends
i2c messages and fails.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/power/bq24735-charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index fa454c1..361a047 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -393,9 +393,9 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, charger);
 
 	if (gpio_is_valid(charger->pdata->status_gpio)) {
-		ret = devm_gpio_request(&client->dev,
-					charger->pdata->status_gpio,
-					name);
+		ret = devm_gpio_request_one(&client->dev,
+						charger->pdata->status_gpio,
+						GPIOF_IN, name);
 		if (ret) {
 			dev_err(&client->dev,
 				"Failed GPIO request for GPIO %d: %d\n",
-- 
2.9.3
