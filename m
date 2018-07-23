From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 2/4] power: supply: max17040: Config alert SOC low level threshold from FDT
Date: Mon, 23 Jul 2018 00:08:14 -0400
Message-ID: <20180723040816.19455-3-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

For configuration of fuel gauge alert for a low level state of charge
interrupt we add a function to config level threshold and a device tree
binding property to set it in flatned device tree node.

Now we can use "maxim,alert-soc-level" property with the values from
1 up to 32 to configure alert interrupt threshold.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 6e54e58814a9..3efa52d32b44 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -47,6 +47,8 @@ struct max17040_chip {
 	int soc;
 	/* State Of Charge */
 	int status;
+	/* Alert threshold */
+	int alert_threshold;
 };
 
 static int max17040_get_property(struct power_supply *psy,
@@ -123,6 +125,28 @@ static void max17040_get_soc(struct i2c_client *client)
 	chip->soc = (soc >> 8);
 }
 
+static int max17040_set_soc_threshold(struct i2c_client *client, u8 level)
+{
+	int ret;
+	u16 data;
+
+	/* check if level is between 1% and 32% */
+	if (level > 0 && level < 33) {
+		/* alert threshold use LSb 5 bits from RCOMP */
+		/* two's-complements form: 00000 = 32% and 11111 = 1% */
+		level = 32 - level;
+		data = max17040_read_reg(client, MAX17040_RCOMP);
+		data &= 0xFFE0;
+		data |= level;
+		max17040_write_reg(client, MAX17040_RCOMP, data);
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void max17040_get_version(struct i2c_client *client)
 {
 	u16 version;
@@ -165,6 +189,16 @@ static void max17040_get_status(struct i2c_client *client)
 		chip->status = POWER_SUPPLY_STATUS_FULL;
 }
 
+static void max17040_get_of_data(struct max17040_chip *chip)
+{
+	struct device *dev = &chip->client->dev;
+	struct device_node *np = dev->of_node;
+
+	if (of_property_read_s32(np, "maxim,alert-soc-level",
+			&chip->alert_threshold))
+		chip->alert_threshold = 4;
+}
+
 static void max17040_work(struct work_struct *work)
 {
 	struct max17040_chip *chip;
@@ -231,6 +265,7 @@ static int max17040_probe(struct i2c_client *client,
 
 	chip->client = client;
 	chip->pdata = client->dev.platform_data;
+	max17040_get_of_data(chip);
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
@@ -262,6 +297,7 @@ static int max17040_probe(struct i2c_client *client,
 
 	max17040_reset(client);
 	max17040_get_version(client);
+	max17040_set_soc_threshold(client, chip->alert_threshold);
 
 	INIT_DEFERRABLE_WORK(&chip->work, max17040_work);
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
-- 
2.13.3
