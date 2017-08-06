From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 10/18] staging: typec: fusb302: Add support for fcs,
 vbus-regulator-name device-property
Date: Sun,  6 Aug 2017 14:35:47 +0200
Message-ID: <20170806123555.5124-11-hdegoede@redhat.com>
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

On devicetree platforms the fusb302 dt-node will have a vbus regulator
property with a phandle to the regulator.

On ACPI platforms, there are no phandles and we need to get the vbus by a
system wide unique name. Add support for a new "fcs,vbus-regulator-name"
device-property which ACPI platform code can set to pass the name.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/fusb302/fusb302.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/typec/fusb302/fusb302.c b/drivers/staging/typec/fusb302/fusb302.c
index e1e08f57af99..c3bcc5484ade 100644
--- a/drivers/staging/typec/fusb302/fusb302.c
+++ b/drivers/staging/typec/fusb302/fusb302.c
@@ -1722,6 +1722,28 @@ static int fusb302_probe(struct i2c_client *client,
 			return -EPROBE_DEFER;
 	}
 
+	/*
+	 * Devicetree platforms should get vbus from their dt-node.
+	 * On ACPI platforms, we need to get the vbus by a system wide unique
+	 * name, which is set in a device prop by the platform code.
+	 */
+	if (device_property_read_string(dev, "fcs,vbus-regulator-name",
+					&name) == 0) {
+		/*
+		 * Use regulator_get_optional so that we can detect if we need
+		 * to defer the probe rather then getting the dummy-regulator.
+		 */
+		chip->vbus = devm_regulator_get_optional(dev, name);
+		if (IS_ERR(chip->vbus)) {
+			ret = PTR_ERR(chip->vbus);
+			return (ret == -ENODEV) ? -EPROBE_DEFER : ret;
+		}
+	} else {
+		chip->vbus = devm_regulator_get(dev, "vbus");
+		if (IS_ERR(chip->vbus))
+			return PTR_ERR(chip->vbus);
+	}
+
 	ret = tcpm_register_psy(chip->dev, &chip->tcpc_dev,
 				"fusb302-typec-source");
 	if (ret < 0)
@@ -1739,12 +1761,6 @@ static int fusb302_probe(struct i2c_client *client,
 	INIT_DELAYED_WORK(&chip->bc_lvl_handler, fusb302_bc_lvl_handler_work);
 	init_tcpc_dev(&chip->tcpc_dev);
 
-	chip->vbus = devm_regulator_get(chip->dev, "vbus");
-	if (IS_ERR(chip->vbus)) {
-		ret = PTR_ERR(chip->vbus);
-		goto destroy_workqueue;
-	}
-
 	if (client->irq) {
 		chip->gpio_int_n_irq = client->irq;
 	} else {
-- 
2.13.3
