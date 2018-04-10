From: Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v2 2/3] adp5061: Add support for battery charging enable
Date: Tue, 10 Apr 2018 12:51:14 +0300
Message-ID: <1523353874-23640-1-git-send-email-stefan.popa@analog.com>
References: <1522829877-7977-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522829877-7977-1-git-send-email-stefan.popa@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: davem@davemloft.net, mchehab@kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, akpm@linux-foundation.org, rdunlap@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stefan.popa@analog.com
List-Id: linux-pm@vger.kernel.org

This patch adds the option to enable/disable battery charging. This
option is not configurable via the power_supply properties, therefore,
access via sysfs was provided to examine and modify this attribute on the
fly.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
  - Fixed kbuild test error by changing the type of the
    charging_enabled_show() and charging_enabled_store() functions from
    int to ssize_t.

 .../ABI/testing/sysfs-class-power-adp5061          | 10 ++++
 MAINTAINERS                                        |  1 +
 drivers/power/supply/adp5061.c                     | 63 ++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-adp5061

diff --git a/Documentation/ABI/testing/sysfs-class-power-adp5061 b/Documentation/ABI/testing/sysfs-class-power-adp5061
new file mode 100644
index 0000000..0d056aa
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-adp5061
@@ -0,0 +1,10 @@
+What: /sys/class/power_supply/adp5061/charging_enabled
+Description:
+	Enable/disable battery charging.
+
+	The ADP5061 charging function can be enabled by setting
+	this attribute to 1. See device datasheet for details.
+
+	Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/MAINTAINERS b/MAINTAINERS
index a9ca73b..9271246 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -804,6 +804,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	Documentation/devicetree/bindings/power/supply/adp5061.txt
 F:	drivers/power/supply/adp5061.c
+F:	Documentation/ABI/testing/sysfs-class-power-adp5061
 
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index c00a02e..99871e6 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 
+
 /* ADP5061 registers definition */
 #define ADP5061_ID			0x00
 #define ADP5061_REV			0x01
@@ -79,6 +80,10 @@
 #define ADP5061_IEND_IEND_MSK			GENMASK(7, 5)
 #define ADP5061_IEND_IEND_MODE(x)		(((x) & 0x07) << 5)
 
+/* ADP5061_FUNC_SET_1 */
+#define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
+#define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
+
 #define ADP5061_NO_BATTERY	0x01
 #define ADP5061_ICHG_MAX	1300 // mA
 
@@ -692,11 +697,63 @@ static const struct power_supply_desc adp5061_desc = {
 	.num_properties		= ARRAY_SIZE(adp5061_props),
 };
 
+static ssize_t charging_enabled_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_FUNC_SET_1, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval &= ADP5061_FUNC_SET_1_EN_CHG_MSK;
+	return sprintf(buf, "%d\n", regval);
+}
+
+static ssize_t charging_enabled_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 chg_en;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &chg_en);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADP5061_FUNC_SET_1,
+				 ADP5061_FUNC_SET_1_EN_CHG_MSK,
+				 ADP5061_FUNC_SET_1_EN_CHG_MODE(!!chg_en));
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(charging_enabled);
+
+static struct attribute *adp5061_attributes[] = {
+	&dev_attr_charging_enabled.attr,
+	NULL
+};
+
+static const struct attribute_group adp5061_attr_group = {
+	.attrs = adp5061_attributes,
+};
+
 static int adp5061_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct power_supply_config psy_cfg = {};
 	struct adp5061_state *st;
+	int ret;
 
 	st = devm_kzalloc(&client->dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
@@ -722,6 +779,12 @@ static int adp5061_probe(struct i2c_client *client,
 		return PTR_ERR(st->psy);
 	}
 
+	ret = sysfs_create_group(&st->psy->dev.kobj, &adp5061_attr_group);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to create sysfs group\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.7.4
