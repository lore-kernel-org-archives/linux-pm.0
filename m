From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 09/11] power: supply: bq24190_charger: Get input_current_limit from our supplier
Date: Wed, 30 Aug 2017 11:48:12 +0200
Message-ID: <20170830094814.17758-10-hdegoede@redhat.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170830094814.17758-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

On some devices the USB Type-C port power (USB PD 2.0) negotiation is
done by a separate port-controller IC, while the current limit is
controlled through another (charger) IC.

It has been decided to model this by modelling the external Type-C
power brick (adapter/charger) as a power-supply class device which
supplies the charger-IC, with its voltage-now and current-max representing
the negotiated voltage and max current draw.

This commit adds support for this to the bq24190_charger driver by adding
an external_power_changed callback and calling
power_supply_set_input_current_limit_from_supplier from this callback.
This callback will only get called if the bq24190 has a parent-supply.

Note this replaces the functionality to get the current-limit from an
extcon device, which will be removed in a follow-up commit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Wait a bit before applying current-max from our supplier as input-current-limit
 the bq24190 may still be in its power-good wait-state while our supplier is
 done negotating current-max and if we apply the limit to early then the
 input-current-limit will be reset to 0.5A by the bq24190 after its
 power-good wait is done.

Changes in v3:
-Drop the input-current-limit-from-supplier device-property, simply always
 sync the input-current-limit with the parent-supply if a parent-supply is
 present
---
 drivers/power/supply/bq24190_charger.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index e606a078b0dd..35ff406aca48 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -165,6 +165,7 @@ struct bq24190_dev_info {
 	struct extcon_dev		*extcon;
 	struct notifier_block		extcon_nb;
 	struct delayed_work		extcon_work;
+	struct delayed_work		input_current_limit_work;
 	char				model_name[I2C_NAME_SIZE];
 	bool				initialized;
 	bool				irq_event;
@@ -1210,6 +1211,32 @@ static int bq24190_charger_property_is_writeable(struct power_supply *psy,
 	return ret;
 }
 
+static void bq24190_input_current_limit_work(struct work_struct *work)
+{
+	struct bq24190_dev_info *bdi =
+		container_of(work, struct bq24190_dev_info,
+			     input_current_limit_work.work);
+
+	power_supply_set_input_current_limit_from_supplier(bdi->charger);
+}
+
+/* Sync the input-current-limit with our parent supply (if we have one) */
+static void bq24190_charger_external_power_changed(struct power_supply *psy)
+{
+	struct bq24190_dev_info *bdi = power_supply_get_drvdata(psy);
+
+	/*
+	 * The Power-Good detection may take up to 220ms, sometimes
+	 * the external charger detection is quicker, and the bq24190 will
+	 * reset to iinlim based on its own charger detection (which is not
+	 * hooked up when using external charger detection) resulting in a
+	 * too low default 500mA iinlim. Delay setting the input-current-limit
+	 * for 300ms to avoid this.
+	 */
+	queue_delayed_work(system_wq, &bdi->input_current_limit_work,
+			   msecs_to_jiffies(300));
+}
+
 static enum power_supply_property bq24190_charger_properties[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -1240,6 +1267,7 @@ static const struct power_supply_desc bq24190_charger_desc = {
 	.get_property		= bq24190_charger_get_property,
 	.set_property		= bq24190_charger_set_property,
 	.property_is_writeable	= bq24190_charger_property_is_writeable,
+	.external_power_changed	= bq24190_charger_external_power_changed,
 };
 
 /* Battery power supply property routines */
@@ -1758,6 +1786,8 @@ static int bq24190_probe(struct i2c_client *client,
 	mutex_init(&bdi->f_reg_lock);
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
+	INIT_DELAYED_WORK(&bdi->input_current_limit_work,
+			  bq24190_input_current_limit_work);
 
 	i2c_set_clientdata(client, bdi);
 
-- 
2.13.4
