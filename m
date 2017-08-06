From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 12/18] power: supply: Add
 power_supply_set_input_current_limit_from_supplier helper
Date: Sun,  6 Aug 2017 14:35:49 +0200
Message-ID: <20170806123555.5124-13-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Liam Breck <liam@networkimprov.net>, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some devices the USB Type-C port power (USB PD 2.0) negotiation is
done by a separate port-controller IC, while the current limit is
controlled through another (charger) IC.

It has been decided to model this by modelling the external Type-C
power brick (adapter/charger) as a power-supply class device which
supplies the charger-IC, with its voltage-now and current-max representing
the negotiated voltage and max current draw.

This commit adds a power_supply_set_input_current_limit_from_supplier
helper function which charger power-supply drivers can call to get
the max-current from their supplier and have this applied
through their set_property call-back to their input-current-limit.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/power_supply_core.c | 41 ++++++++++++++++++++++++++++++++
 include/linux/power_supply.h             |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0741fcef3b44..3f92574222de 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -375,6 +375,47 @@ int power_supply_is_system_supplied(void)
 }
 EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
 
+static int __power_supply_get_supplier_max_current(struct device *dev,
+						   void *data)
+{
+	union power_supply_propval ret = {0,};
+	struct power_supply *epsy = dev_get_drvdata(dev);
+	struct power_supply *psy = data;
+
+	if (__power_supply_is_supplied_by(epsy, psy))
+		if (!epsy->desc->get_property(epsy,
+					      POWER_SUPPLY_PROP_CURRENT_MAX,
+					      &ret))
+			return ret.intval;
+
+	return 0;
+}
+
+int power_supply_set_input_current_limit_from_supplier(struct power_supply *psy)
+{
+	union power_supply_propval val = {0,};
+	int curr;
+
+	if (!psy->desc->set_property)
+		return -EINVAL;
+
+	/*
+	 * This function is not intended for use with a supply with multiple
+	 * suppliers, we simply pick the first supply to report a non 0
+	 * max-current.
+	 */
+	curr = class_for_each_device(power_supply_class, NULL, psy,
+				      __power_supply_get_supplier_max_current);
+	if (curr <= 0)
+		return (curr == 0) ? -ENODEV : curr;
+
+	val.intval = curr;
+
+	return psy->desc->set_property(psy,
+				POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+}
+EXPORT_SYMBOL_GPL(power_supply_set_input_current_limit_from_supplier);
+
 int power_supply_set_battery_charged(struct power_supply *psy)
 {
 	if (atomic_read(&psy->use_cnt) >= 0 &&
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index de89066b72b1..79e90b3d3288 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -332,6 +332,8 @@ extern int power_supply_get_battery_info(struct power_supply *psy,
 					 struct power_supply_battery_info *info);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
+extern int power_supply_set_input_current_limit_from_supplier(
+					 struct power_supply *psy);
 extern int power_supply_set_battery_charged(struct power_supply *psy);
 
 #ifdef CONFIG_POWER_SUPPLY
-- 
2.13.3
