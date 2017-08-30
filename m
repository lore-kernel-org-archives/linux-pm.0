From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 01/11] i2c: Allow overriding dev_name through board_info
Date: Wed, 30 Aug 2017 11:48:04 +0200
Message-ID: <20170830094814.17758-2-hdegoede@redhat.com>
References: <20170830094814.17758-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20170830094814.17758-1-hdegoede@redhat.com>
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

For devices not instantiated through ACPI the i2c-client's device-name
gets set to <busnr>-<addr> by default, e.g. "0-0022" this means that
the device-name is dependent on the order in which the i2c-busses are
enumerated.

In some cases having a predictable constant device-name is desirable,
for example on non device-tree platforms the link between a regulator
and its consumers is specified by the platform code by setting
regulator_init_data.consumers. This array identifies the regulator's
consumers by dev_name and supply(-name). Which requires a constant
dev_name.

This commit adds a dev_name field to i2c_board_info allowing
platform code to set a contstant dev_name so that the device can
be identified by its dev_name in other platform code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-base.c | 10 ++++++++--
 include/linux/i2c.h         |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 45fafcc88b93..5cdf3b947c23 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -672,10 +672,16 @@ static void i2c_adapter_unlock_bus(struct i2c_adapter *adapter,
 }
 
 static void i2c_dev_set_name(struct i2c_adapter *adap,
-			     struct i2c_client *client)
+			     struct i2c_client *client,
+			     struct i2c_board_info const *info)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 
+	if (info && info->dev_name) {
+		dev_set_name(&client->dev, "i2c-%s", info->dev_name);
+		return;
+	}
+
 	if (adev) {
 		dev_set_name(&client->dev, "i2c-%s", acpi_dev_name(adev));
 		return;
@@ -772,7 +778,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.of_node = info->of_node;
 	client->dev.fwnode = info->fwnode;
 
-	i2c_dev_set_name(adap, client);
+	i2c_dev_set_name(adap, client, info);
 
 	if (info->properties) {
 		status = device_add_properties(&client->dev, info->properties);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 701ad26fa6b4..d3655cfe9a3e 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -310,6 +310,7 @@ static inline bool i2c_detect_slave_mode(struct device *dev) { return false; }
  * @type: chip type, to initialize i2c_client.name
  * @flags: to initialize i2c_client.flags
  * @addr: stored in i2c_client.addr
+ * @dev_name: Overrides the default <busnr>-<addr> dev_name if set
  * @platform_data: stored in i2c_client.dev.platform_data
  * @archdata: copied into i2c_client.dev.archdata
  * @of_node: pointer to OpenFirmware device node
@@ -334,6 +335,7 @@ struct i2c_board_info {
 	char		type[I2C_NAME_SIZE];
 	unsigned short	flags;
 	unsigned short	addr;
+	const char	*dev_name;
 	void		*platform_data;
 	struct dev_archdata	*archdata;
 	struct device_node *of_node;
-- 
2.13.4
