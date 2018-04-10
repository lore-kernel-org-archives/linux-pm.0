From: Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v2 3/3] adp5061: Add support for charging voltage limit enable
Date: Tue, 10 Apr 2018 12:51:42 +0300
Message-ID: <1523353902-23748-1-git-send-email-stefan.popa@analog.com>
References: <1522829896-8087-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522829896-8087-1-git-send-email-stefan.popa@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stefan.popa@analog.com
List-Id: linux-pm@vger.kernel.org

This patch adds the option to activate/deactivate the charging voltage
limit. If activated, the charger prevents charging until the battery
voltage drops below the VCHG_VLIM threshold.

This option is not configurable via the power_supply properties,
therefore, access via sysfs was provided to examine and modify this
attribute on the fly.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
  - Fixed the kbuild test error by changing the type of the
    charging_vlim_enabled_show() and charging_vlim_enabled_store()
    functions from int to ssize_t.

 .../ABI/testing/sysfs-class-power-adp5061          | 13 ++++++
 drivers/power/supply/adp5061.c                     | 46 ++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power-adp5061 b/Documentation/ABI/testing/sysfs-class-power-adp5061
index 0d056aa..25064c1 100644
--- a/Documentation/ABI/testing/sysfs-class-power-adp5061
+++ b/Documentation/ABI/testing/sysfs-class-power-adp5061
@@ -8,3 +8,16 @@ Description:
 	Valid values:
 		- 1: enabled
 		- 0: disabled
+
+What: /sys/class/power_supply/adp5061/charging_vlim_enabled
+Description:
+	Enable/disable charging voltage limit
+
+	The ADP5061 charging voltage limit can be enabled by setting
+	this attribute to 1. When enabled, the charger prevents charging
+	until the battery voltage drops bellow the VCHG_VLIM threshold.
+	See device datasheet for details.
+
+	Valid values:
+		- 1: enabled
+		- 0: disabled
diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index 99871e6..9716059 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -84,6 +84,10 @@
 #define ADP5061_FUNC_SET_1_EN_CHG_MSK		BIT(0)
 #define ADP5061_FUNC_SET_1_EN_CHG_MODE(x)	(((x) & 0x01) << 0)
 
+/* ADP5061_FUNC_SET_2 */
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK	BIT(5)
+#define ADP5061_FUNC_SET_2_EN_CHG_VLIM_MODE(x)	(((x) & 0x01) << 5)
+
 #define ADP5061_NO_BATTERY	0x01
 #define ADP5061_ICHG_MAX	1300 // mA
 
@@ -737,10 +741,52 @@ static ssize_t charging_enabled_store(struct device *dev,
 	return count;
 }
 
+static ssize_t charging_vlim_enabled_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADP5061_FUNC_SET_2, &regval);
+	if (ret < 0)
+		return ret;
+
+	regval = (regval & ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK) >> 5;
+	return sprintf(buf, "%d\n", regval);
+}
+
+static ssize_t charging_vlim_enabled_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct adp5061_state *st = power_supply_get_drvdata(psy);
+	u8 chg_vlim_en;
+	int ret;
+
+	ret = kstrtou8(buf, 0, &chg_vlim_en);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADP5061_FUNC_SET_2,
+			ADP5061_FUNC_SET_2_EN_CHG_VLIM_MSK,
+			ADP5061_FUNC_SET_2_EN_CHG_VLIM_MODE(!!chg_vlim_en));
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
 static DEVICE_ATTR_RW(charging_enabled);
+static DEVICE_ATTR_RW(charging_vlim_enabled);
 
 static struct attribute *adp5061_attributes[] = {
 	&dev_attr_charging_enabled.attr,
+	&dev_attr_charging_vlim_enabled.attr,
 	NULL
 };
 
-- 
2.7.4
