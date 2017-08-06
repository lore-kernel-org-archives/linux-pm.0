From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 06/18] staging: typec: fusb302: Get max snk mv/ma/mw from
 device-properties
Date: Sun,  6 Aug 2017 14:35:43 +0200
Message-ID: <20170806123555.5124-7-hdegoede@redhat.com>
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

This is board specific info so it should come from board config, such
as devicetree.

I've chosen to prefix these with "fcs," treating them as fusb302 driver
specific. We may want to revisit to replace these with properties which
are part of a (to be written) generic type-c controller devicetree
binding.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/TODO              |  5 +++++
 drivers/staging/typec/fusb302/fusb302.c | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/typec/TODO b/drivers/staging/typec/TODO
index bc1f97a2d1bf..98b0dbd5752b 100644
--- a/drivers/staging/typec/TODO
+++ b/drivers/staging/typec/TODO
@@ -11,5 +11,10 @@ tcpm:
 tcpci:
 - Test with real hardware
 
+fusb302:
+- We may want to replace the  "fcs,max-snk-mv", "fcs,max-snk-ma",
+  "fcs,max-snk-mw" and "fcs,operating-snk-mw" device(tree) properties with
+  properties which are part of a generic type-c controller devicetree binding.
+
 Please send patches to Guenter Roeck <linux@roeck-us.net> and copy
 Heikki Krogerus <heikki.krogerus@linux.intel.com>.
diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index 6baed06a3c0d..8ceaef8ecf17 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -90,6 +90,7 @@ struct fusb302_chip {
 	struct i2c_client *i2c_client;
 	struct tcpm_port *tcpm_port;
 	struct tcpc_dev tcpc_dev;
+	struct tcpc_config tcpc_config;
 
 	struct regulator *vbus;
 
@@ -1198,7 +1199,6 @@ static const struct tcpc_config fusb302_tcpc_config = {
 
 static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
 {
-	fusb302_tcpc_dev->config = &fusb302_tcpc_config;
 	fusb302_tcpc_dev->init = tcpm_init;
 	fusb302_tcpc_dev->get_vbus = tcpm_get_vbus;
 	fusb302_tcpc_dev->set_cc = tcpm_set_cc;
@@ -1684,7 +1684,9 @@ static int fusb302_probe(struct i2c_client *client,
 {
 	struct fusb302_chip *chip;
 	struct i2c_adapter *adapter;
+	struct device *dev = &client->dev;
 	int ret = 0;
+	u32 val;
 
 	adapter = to_i2c_adapter(client->dev.parent);
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_I2C_BLOCK)) {
@@ -1699,8 +1701,22 @@ static int fusb302_probe(struct i2c_client *client,
 	chip->i2c_client = client;
 	i2c_set_clientdata(client, chip);
 	chip->dev = &client->dev;
+	chip->tcpc_config = fusb302_tcpc_config;
+	chip->tcpc_dev.config = &chip->tcpc_config;
 	mutex_init(&chip->lock);
 
+	if (device_property_read_u32(dev, "fcs,max-snk-mv", &val) == 0)
+		chip->tcpc_config.max_snk_mv = val;
+
+	if (device_property_read_u32(dev, "fcs,max-snk-ma", &val) == 0)
+		chip->tcpc_config.max_snk_ma = val;
+
+	if (device_property_read_u32(dev, "fcs,max-snk-mw", &val) == 0)
+		chip->tcpc_config.max_snk_mw = val;
+
+	if (device_property_read_u32(dev, "fcs,operating-snk-mw", &val) == 0)
+		chip->tcpc_config.operating_snk_mw = val;
+
 	ret = fusb302_debugfs_init(chip);
 	if (ret < 0)
 		return ret;
-- 
2.13.3
