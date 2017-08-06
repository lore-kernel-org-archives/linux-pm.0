From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 18/18] i2c-cht-wc: Add device-properties for fusb302
 integration
Date: Sun,  6 Aug 2017 14:35:55 +0200
Message-ID: <20170806123555.5124-19-hdegoede@redhat.com>
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

Add device-properties to make the bq24292i controller connected to
the bus get its input-current-limit from the fusb302 Type-C port
controller which is used on boards with the cht-wc PMIC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/busses/Kconfig      | 5 +++++
 drivers/i2c/busses/i2c-cht-wc.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index f20b1f84013a..6de21a81b00b 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -197,6 +197,11 @@ config I2C_CHT_WC
 	  SMBus controller found in the Intel Cherry Trail Whiskey Cove PMIC
 	  found on some Intel Cherry Trail systems.
 
+	  Note this controller is hooked up to a TI bq24292i charger-IC,
+	  combined with a FUSB302 Type-C port-controller as such it is advised
+	  to also select CONFIG_CHARGER_BQ24190=m and CONFIG_TYPEC_FUSB302=m
+	  (the fusb302 driver currently is in drivers/staging).
+
 config I2C_NFORCE2
 	tristate "Nvidia nForce2, nForce3 and nForce4"
 	depends on PCI
diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index ccf0785bcb75..08229fb12615 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -211,8 +211,11 @@ static const struct irq_chip cht_wc_i2c_irq_chip = {
 	.name			= "cht_wc_ext_chrg_irq_chip",
 };
 
+static const char * const bq24190_suppliers[] = { "fusb302-typec-source" };
+
 static const struct property_entry bq24190_props[] = {
-	PROPERTY_ENTRY_STRING("extcon-name", "cht_wcove_pwrsrc"),
+	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", bq24190_suppliers),
+	PROPERTY_ENTRY_BOOL("input-current-limit-from-supplier"),
 	PROPERTY_ENTRY_BOOL("omit-battery-class"),
 	PROPERTY_ENTRY_BOOL("disable-reset"),
 	{ }
-- 
2.13.3
